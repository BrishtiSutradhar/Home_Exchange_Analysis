--Update exchange type
UPDATE
  `lewagon-final-project-397408.home_exchange.exchanges_marc` AS e
SET
  exchange_type = LOWER(e.exchange_type)
WHERE
  exchange_type IS NOT NULL

--delete rows
DELETE
FROM
  `lewagon-final-project-397408.home_exchange.exchanges_marc`
WHERE
  user_cancellation_id IS NULL
  AND canceled_at = TRUE;

--Delete Rows

DELETE
FROM
  `lewagon-final-project-397408.home_exchange.exchanges_marc`
WHERE
  user_cancellation_id IS NOT NULL
  AND canceled_at = false
