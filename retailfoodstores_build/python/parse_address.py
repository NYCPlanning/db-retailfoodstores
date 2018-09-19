import pandas as pd
import subprocess
import os
import sqlalchemy as sql
import json
import usaddress
from nyc_geoclient import Geoclient


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


# https://github.com/datamade/usaddress (repo for python usaddress lib)
# Parse the location value to get a more accurate street name
def parse_name(location):
    parsed = usaddress.parse(location)
    parsed_street_name = ''
    StreetNamePreDirectional = ''
    StreetName = ''
    StreetNamePostType = ''
    for i in range(len(parsed)):
        if StreetNamePreDirectional == '' and parsed[i][1] == 'StreetNamePreDirectional':
            StreetNamePreDirectional += parsed[i][0]
        elif StreetName == '' and parsed[i][1] == 'StreetName':
            StreetName += parsed[i][0]
        elif StreetNamePostType == '' and parsed[i][1] == 'StreetNamePostType':
            StreetNamePostType += parsed[i][0]

    parsed_street_name = StreetNamePreDirectional + StreetName + ' ' + StreetNamePostType
    # returns the street name as a string
    return(str(parsed_street_name))


# Read in retail stores table where values of geom is null and street_number is not null
retail_2 = pd.read_sql_query('SELECT street_number, location, borough, license_number FROM dcp_retailfoodstores WHERE street_number IS NOT NULL AND street_name IS NOT NULL AND license_number IS NOT NULL AND geom IS NULL;', engine)
# replace single quotes with doubled single quotes for psql compatibility
retail_2['street_number'] = [i.replace("'", "''") for i in retail_2['street_number']]
retail_2['borough'] = [i.replace("'", "''") for i in retail_2['borough']]

# Update the street_name_normalized column
locs = []
for i in range(len(retail_2)):
    new = parse_name(str(retail_2['location'][i]))
    locs.append(new)


# update retail stores normalized street name
for i in range(len(retail_2)):
    upd = "UPDATE dcp_retailfoodstores a SET street_name_normalized = '" + str(locs[i]) + "';"
    engine.execute(upd)
