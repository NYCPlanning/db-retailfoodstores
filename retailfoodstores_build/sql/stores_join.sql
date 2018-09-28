-- Join the table from sam to the geocoded table
ALTER TABLE dcp_retailfoodstores
ADD COLUMN dcp_type text,
ADD COLUMN dcp_square_footage int;

-- Update the new square footage from sam's table into the geocoded table that has changed
UPDATE dcp_retailfoodstores r
SET dcp_square_footage = g.sf
FROM dcp_grocerystores g
WHERE g.license = r.license_number
AND g.sf != r.square_footage;

-- Update the grocery category type of the stores into the geocoded table
UPDATE dcp_retailfoodstores r
SET dcp_type = 'Grocery'
FROM  dcp_grocerystores g
WHERE g.grocery = 'Yes'
AND g.sf <= 5000
AND g.license = r.license_number;

-- Update the supermarket category type of the stores into the geocoded table
UPDATE dcp_retailfoodstores r
SET dcp_type = 'Supermarket'
FROM  dcp_grocerystores g
WHERE g.grocery = 'Yes'
AND 5000 < g.sf
AND g.license = r.license_number;
