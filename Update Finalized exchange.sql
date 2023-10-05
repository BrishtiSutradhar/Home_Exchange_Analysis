--Update Finalized column From exchange Table

-- Step 1: Add the finalized_at_indicator column
ALTER TABLE home_exchange.exchanges_marc ADD COLUMN finalized_at_indicator BOOLEAN;

-- Step 2: Set the new column values to True where finalized_at is not null
UPDATE home_exchange.exchanges_marc
SET finalized_at_indicator = True
WHERE finalized_at IS NOT NULL;

-- Step 3: Set the new column values to False where finalized_at is null
UPDATE home_exchange.exchanges_marc
SET finalized_at_indicator = False
WHERE finalized_at IS NULL;

-- Step 4: Drop the original column
ALTER TABLE home_exchange.exchanges_marc 
DROP COLUMN finalized_at;

-- Step 5: Rename the new column to the original column name
ALTER TABLE home_exchange.exchanges_marc 
RENAME COLUMN finalized_at_indicator TO finalized_at;
