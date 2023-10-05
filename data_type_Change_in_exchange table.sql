--Rename Column
ALTER TABLE home_exchange.exchanges_marc
RENAME COLUMN capacity TO max_capacity

-- Step 1: Add new temporary columns with different names
ALTER TABLE home_exchange.exchanges_marc ADD COLUMN new_finalized_at DATE;
ALTER TABLE home_exchange.exchanges_marc ADD COLUMN new_canceled_at DATE;

-- Step 2: Update the new columns with values from the original columns
UPDATE home_exchange.exchanges_marc SET new_finalized_at = DATE(finalized_at) WHERE finalized_at IS NOT NULL;
UPDATE home_exchange.exchanges_marc SET new_canceled_at = DATE(canceled_at) WHERE canceled_at IS NOT NULL;

-- Step 3: Drop the original columns
ALTER TABLE home_exchange.exchanges_marc DROP COLUMN finalized_at;
ALTER TABLE home_exchange.exchanges_marc DROP COLUMN canceled_at;

-- Step 4: Rename the new columns to the original column names
ALTER TABLE home_exchange.exchanges_marc RENAME COLUMN new_finalized_at TO finalized_at;
ALTER TABLE home_exchange.exchanges_marc RENAME COLUMN new_canceled_at TO canceled_at;
