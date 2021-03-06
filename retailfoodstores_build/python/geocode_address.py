import pandas as pd
import subprocess
import os
import sqlalchemy as sql
import json
import usaddress
from nyc_geoclient import Geoclient

# If you get this error: requests.exceptions.ConnectionError: ('Connection aborted.', error(54, 'Connection reset by peer')) install below or try the other solutions in the link
# pip install pyopenssl idna (https://github.com/jakubroztocil/httpie/issues/351)

# make sure we are at the top of the repo
wd = subprocess.check_output('git rev-parse --show-toplevel', shell = True)
os.chdir(wd[:-1]) #-1 removes \n

# load config file
with open('rfs.config.json') as conf:
    config = json.load(conf)

DBNAME = config['DBNAME']
DBUSER = config['DBUSER']
# load necessary environment variables
# set variables with following command: export SECRET_KEY="somesecretvalue"
app_id = config['GEOCLIENT_APP_ID']
app_key = config['GEOCLIENT_APP_KEY']

# connect to postgres db
engine = sql.create_engine('postgresql://{}@localhost:5432/{}'.format(DBUSER, DBNAME))

# read in retail stores table
retail = pd.read_sql_query('SELECT license_number, street_number, street_name, borough FROM dcp_retailfoodstores WHERE borough IS NOT NULL AND license_number IS NOT NULL AND street_number IS NOT NULL AND street_name IS NOT NULL AND geom IS NULL;', engine)

# replace single quotes with doubled single quotes for psql compatibility
retail['street_number'] = [i.replace("'", "''") for i in retail['street_number']]
retail['street_name'] = [i.replace("'", "''") for i in retail['street_name']]

# get the geo data
g = Geoclient(app_id, app_key)

def get_loc(num, street, borough):
    geo = g.address(num, street, borough)
    try:
        lat = geo['latitude']
    except KeyError:
        try: lat = geo['latitude']
        except KeyError:
            lat = 'none'
    try:
        lon = geo['longitude']
    except:
        lon = 'none'
    loc = pd.DataFrame({'lat' : [lat],
                        'lon' : [lon]})
    return(loc)

locs = pd.DataFrame()
for i in range(len(retail)):
    new = get_loc(retail['street_number'][i],
                  retail['street_name'][i],
                  retail['borough'][i]
    )
    locs = pd.concat((locs, new))
locs.reset_index(inplace = True)

# update retail stores geom based on bin or lat and long
for i in range(len(retail)):
    if (locs['lat'][i] != 'none') & (locs['lon'][i] != 'none'):
        upd = "UPDATE dcp_retailfoodstores a SET geom = ST_SetSRID(ST_MakePoint(" + str(locs['lon'][i]) + ", " + str(locs['lat'][i]) + "), 4326) WHERE a.license_number = '" + retail['license_number'][i] + "';"
    elif locs['lat'][i] == 'none':
        upd = "UPDATE dcp_retailfoodstores a SET geom = NULL WHERE a.license_number = '" + retail['license_number'][i] + "';"
    engine.execute(upd)


# not deleting because if I ever figure it out this is probably a better way of doing this...
#md = sql.MetaData(engine)
#table = sql.Table('sca', md, autoload=True)
#upd = table.update(values={
