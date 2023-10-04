--Replace Null Value
UPDATE `lewagon-final-project-397408.home_exchange.exchanges_marc`
SET home_type = 'other'
WHERE home_type IS NULL;

--Update column from exchange table

UPDATE `lewagon-final-project-397408.home_exchange.exchanges_marc`
SET home_type = 'home'
WHERE home_type = 'Home'

--Replace Null Value from Residence_type column
UPDATE `lewagon-final-project-397408.home_exchange.exchanges_marc`
SET residence_type = 'other'
WHERE residence_type IS NULL


--Replace Null Value from Country column

UPDATE `lewagon-final-project-397408.home_exchange.exchanges_marc`
SET country = 'unknown'
WHERE country IS NULL;

--Drop Column

ALTER TABLE `lewagon-final-project-397408.home_exchange.exchanges_marc`
DROP COLUMN region, DROP COLUMN department, DROP COLUMN city
