#!/bin/bash

# make sure we are at the top of the git directory
REPOLOC="$(git rev-parse --show-toplevel)"
cd $REPOLOC

# load config
DBNAME=$(cat $REPOLOC/rfs.config.json | jq -r '.DBNAME')
DBUSER=$(cat $REPOLOC/rfs.config.json | jq -r '.DBUSER')

start=$(date +'%T')
echo "Starting to build retail food stores database"
psql -U $DBUSER -d $DBNAME -f $REPOLOC/retailfoodstores_build/sql/create.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/retailfoodstores_build/sql/borough.sql
echo 'Geocoding geoms...'
source activate py2
python $REPOLOC/retailfoodstores_build/python/geocode_address.py
source deactivate

echo "Done!"
