--Update Canceled_at column from exchange

-- Step 1: Add the canceled_at_indicator column
ALTER TABLE home_exchange.exchanges_marc
ADD COLUMN canceled_at_indicator BOOLEAN;

-- Step 2: Set the new column values to True where canceled_at is not null
UPDATE home_exchange.exchanges_marc
SET canceled_at_indicator = True
WHERE canceled_at IS NOT NULL;

-- Step 3: Set the new column values to False where canceled_at is null
UPDATE home_exchange.exchanges_marc
SET canceled_at_indicator = False
WHERE canceled_at IS NULL;

-- Step 4: Drop the original column
ALTER TABLE home_exchange.exchanges_marc
DROP COLUMN canceled_at;

-- Step 5: Rename the new column to the original column name
ALTER TABLE home_exchange.exchanges_marc
RENAME COLUMN canceled_at_indicator TO canceled_at;
