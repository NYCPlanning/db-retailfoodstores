-- Exports all the records with a 0 square footage to a new file
COPY (SELECT * FROM dcp_retailfoodstores WHERE square_footage <= 50)
TO '/Users/tommywang/git/db-retailfoodstores/retailfoodstores_build/output/retailfoodstores_square_footage.csv' DELIMITER ',' CSV HEADER;
