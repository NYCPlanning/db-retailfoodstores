-- adding a borough field with the borough value for each record
ALTER TABLE dcp_retailfoodstores
ADD COLUMN borough;

UPDATE dcp_retailfoodstores
SET borough = 'Manhattan'
WHERE county = 'Manhattan';

UPDATE dcp_retailfoodstores
SET borough = 'Bronx'
WHERE county = 'Bronx';

UPDATE dcp_retailfoodstores
SET borough = 'Brooklyn'
WHERE county = 'Brooklyn';

UPDATE dcp_retailfoodstores
SET borough = 'Queens'
WHERE county = 'Queens';

UPDATE dcp_retailfoodstores
SET borough = 'Staten Island'
WHERE county = 'Staten Island';
