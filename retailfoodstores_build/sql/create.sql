-- create base dcp_retailfoodstores table
DROP TABLE IF EXISTS dcp_retailfoodstores CASCADE;
CREATE TABLE dcp_retailfoodstores AS (
	SELECT *
	FROM nys_retailfoodstores
	WHERE county = 'Bronx'
	OR county = 'Kings'
	OR county = 'New York'
	OR county = 'Queens'
	OR county = 'Richmond'
);
-- add geometry column
SELECT AddGeometryColumn ('public','dcp_retailfoodstores','geom',4326,'Geometry',2);

-- add normalized street_name column
ALTER TABLE dcp_retailfoodstores ADD COLUMN street_name_normalized text;
