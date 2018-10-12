-- Categorize the gas stations with store names
UPDATE dcp_retailfoodstores
SET dcp_type = 'Gas Station'
WHERE dcp_type IS NULL
AND (upper(dba_name) LIKE '% GAS %'
OR upper(dba_name) LIKE '%GASOLINE%'
OR upper(dba_name) LIKE '%EXXON%'
OR upper(dba_name) LIKE '% GULF %'
OR upper(dba_name) LIKE 'BP%'
OR upper(dba_name) LIKE 'SHELL%'
OR upper(dba_name) LIKE '%SPEEDWAY%'
OR upper(dba_name) LIKE '%CITGO%'
OR upper(dba_name) LIKE '%FUEL%'
OR upper(dba_name) LIKE 'SUNOCO%'
OR upper(dba_name) LIKE '%MOBIL %'
OR upper(dba_name) LIKE '%PETROLEUM%'
OR upper(entity_name) LIKE '%PETROLEUM%'
OR upper(entity_name) LIKE '%HESS%MART%'
OR upper(entity_name) LIKE '%SERVICE%STATION%');


-- Categorize the big box stores
UPDATE dcp_retailfoodstores
SET dcp_type = 'Big Box/Chain'
WHERE upper(dba_name) LIKE '%COSTCO%WHOLESALE%'
OR upper(dba_name) LIKE '%BJS%CLUB%'
OR upper(dba_name) LIKE '%TARGET%'
OR upper(dba_name) LIKE '%CENTURY%21%'
OR upper(dba_name) LIKE '%CVS%'
OR upper(dba_name) LIKE 'WALGREENS%'
OR upper(dba_name) LIKE '%BABIES%R%US%'
OR upper(dba_name) LIKE '%TOYS%R%US%'
OR upper(dba_name) LIKE '%DUANE%READE%'
OR upper(dba_name) LIKE '%RITE%AID%'
OR upper(dba_name) LIKE 'BED%BATH%&%BEYOND%'
OR upper(dba_name) LIKE 'DOLLAR%TREE%'
OR upper(dba_name) LIKE 'FAMILY%DOLLAR%'
OR upper(dba_name) LIKE '%DOLLAR%GENERAL%'
OR upper(entity_name) LIKE 'K%MART%'
OR upper(entity_name) LIKE '%TJX%COMPANIES%'
OR upper(entity_name) LIKE '%FIVE%BELOW%'
OR upper(entity_name) LIKE '%LOT%LESS%';


-- Categorize the grocery stores with keywords and square footage
UPDATE dcp_retailfoodstores
SET dcp_type = 'Grocery'
WHERE square_footage <= 5000
AND square_footage >= 500
AND dcp_type IS NULL
AND (upper(dba_name) LIKE '%DEL%'
OR upper(dba_name) LIKE '%MINI%'
OR upper(dba_name) LIKE '%MART%'
OR upper(dba_name) LIKE '%MRKT%'
OR upper(dba_name) LIKE '%MKT%'
OR upper(dba_name) LIKE '%MARKET%'
OR upper(dba_name) LIKE '%DAIRY%'
OR upper(dba_name) LIKE '%GRCY%'
OR upper(dba_name) LIKE '%GRCRY%'
OR upper(dba_name) LIKE '%GROCER%'
OR upper(dba_name) LIKE '%SUPERETTE%'
OR upper(dba_name) LIKE '%CHEESE%'
OR upper(dba_name) LIKE '%KOSHER%'
OR upper(dba_name) LIKE '%HALAL%'
OR upper(dba_name) LIKE '%PRODUCE%'
OR upper(dba_name) LIKE '%FARM%'
OR upper(dba_name) LIKE '%BUTCHER%'
OR upper(dba_name) LIKE '%POULTRY%'
OR upper(dba_name) LIKE '%MEAT%'
OR upper(dba_name) LIKE '%PORK%'
OR upper(dba_name) LIKE '%FISH%'
OR upper(dba_name) LIKE '%FRUIT%'
OR upper(dba_name) LIKE '%VEG%'
OR upper(dba_name) LIKE '%FRESH%'
OR upper(dba_name) LIKE '%SEAFOOD%'
OR upper(entity_name) LIKE '%PRODUCE%'
OR upper(entity_name) LIKE '%SEAFOOD%'
OR upper(entity_name) LIKE '%FISH%'
OR upper(entity_name) LIKE '%FRUIT%'
OR upper(entity_name) LIKE '%PORK%'
OR upper(entity_name) LIKE '%POULTRY%'
OR upper(entity_name) LIKE '%FARM%');

-- Categorize the supermarkets with keywords and square footage
UPDATE dcp_retailfoodstores
SET dcp_type = 'Supermarket'
WHERE (square_footage > 5000
AND dcp_type IS NULL
AND (upper(dba_name) LIKE '%MART%'
OR upper(dba_name) LIKE '%MARKET%'
OR upper(dba_name) LIKE '%MRKT%'
OR upper(dba_name) LIKE '%MKT%'
OR upper(dba_name) LIKE '%SUPERMARK%'
OR upper(dba_name) LIKE '%GROCERY%'))

OR (upper(dba_name) LIKE '%TRADER%JOE%'
    OR upper(dba_name) LIKE '%SUNRISE%MART%'
    OR upper(dba_name) LIKE '%BROOKLYN%FARE%'
    OR upper(dba_name) LIKE '%FINE%FARE%'
    OR upper(dba_name) LIKE 'TRADE%FAIR%'
    OR upper(dba_name) LIKE '%WESTSIDE%MARKET%'
    OR upper(dba_name) LIKE '%NET%COST%'
    OR upper(dba_name) LIKE '%MORTON%WILLIAMS%'
    OR upper(dba_name) LIKE 'KEY%FOOD%'
    OR upper(dba_name) LIKE 'ASSOCIATED%'
    OR upper(dba_name) LIKE '%BRAVO%SUPERMARKET%'
    OR upper(dba_name) LIKE 'C%TOWN%'
    OR upper(dba_name) LIKE '%FOODTOWN%'
    OR upper(dba_name) LIKE 'FOOD%EMPORIUM%'
    OR upper(dba_name) LIKE 'MET%FOODS%'
    OR upper(dba_name) LIKE 'PIONEER%SUPERMARKET%'
    OR upper(dba_name) LIKE 'SHOPRITE%'
    OR upper(entity_name) LIKE 'WHOLE%FOODS%'
    OR upper(entity_name) LIKE '%NAMDOR%INC%'
    OR upper(entity_name) LIKE '%FAIRWAY%'
    OR upper(entity_name) LIKE 'STOP%&%SHOP%'
    OR upper(entity_name) LIKE '%ALDI%INC%'
    OR upper(entity_name) LIKE 'WESTERN%BEEF%');


-- Categorize the convenience stores with store names
UPDATE dcp_retailfoodstores
SET dcp_type = 'Convenience'
WHERE dcp_type IS NULL
AND (square_footage <= 5000
    AND square_footage > 100
    AND (upper(dba_name) LIKE '%CONVENIEN%'
    OR upper(dba_name) LIKE '%CONV%'
    OR upper(dba_name) LIKE '%DELI%'
    OR upper(dba_name) LIKE '%BODEGA%'
    OR upper(dba_name) LIKE '%CORNER%STORE%'
    OR upper(dba_name) LIKE '%SERVICE%STATION%'
    OR upper(dba_name) LIKE '%LOTTO%'
    OR upper(dba_name) LIKE '%TOBACCO%'
    OR upper(dba_name) LIKE '%CANDY%'
    OR upper(dba_name) LIKE '%CNDY%'
    OR upper(dba_name) LIKE '%SNACK%'
    OR upper(dba_name) LIKE '%GOURM%'
    OR upper(dba_name) LIKE '%DRUG%'
    OR upper(dba_name) LIKE '%PHARMACY%'
    OR upper(dba_name) LIKE '%SMOKE%'
    OR upper(dba_name) LIKE '%BAGEL%'
    OR upper(dba_name) LIKE '%QUICK%'
    OR upper(dba_name) LIKE '%DOLLAR%'
    OR upper(dba_name) LIKE '%NEWS%'
    OR upper(dba_name) LIKE '%BEER%'
    OR upper(dba_name) LIKE '%CHOCOLAT%'
    OR upper(dba_name) LIKE '%BEVERAGE%'
    OR upper(dba_name) LIKE '%LIQUOR%'
    OR upper(dba_name) LIKE '%SWEET%'
    OR upper(dba_name) LIKE '%BREAD%'))

    OR (upper(dba_name) LIKE '%7%ELEVEN%'
        OR upper(dba_name) LIKE 'GENERAL%NUTRITION%'
        OR upper(dba_name) LIKE 'GNC%'
        OR upper(dba_name) LIKE '%$1%'
        OR upper(dba_name) LIKE '%DISCOUNT%'
        OR upper(dba_name) LIKE '%99%'
        OR upper(dba_name) LIKE '%DOLLAR%'
        OR upper(dba_name) LIKE '%99%C%'
        OR upper(dba_name) LIKE '%DEAL%'
        OR upper(dba_name) LIKE '%CENT%');



-- Categorize the Restaurants and Bakeries with store names and square footage
UPDATE dcp_retailfoodstores
SET dcp_type = 'Restaurant/Bakery'
WHERE dcp_type IS NULL
  AND square_footage > 200
  AND (upper(dba_name) LIKE 'EDIBLE%ARRANGEMENTS%'
  OR upper(dba_name) LIKE '%BAKED%BY%MELISSA%'
  OR upper(dba_name) LIKE '%CAFE%'
  OR upper(dba_name) LIKE '%COFFEE%'
  OR upper(dba_name) LIKE '%BAKERY%'
  OR upper(dba_name) LIKE 'JUICE%PRESS%'
  OR upper(dba_name) LIKE '%PASTRY%'
  OR upper(dba_name) LIKE '%SANDWICH%'
  OR upper(dba_name) LIKE '%SUSHI%'
  OR upper(dba_name) LIKE '%JUICE%'
);
