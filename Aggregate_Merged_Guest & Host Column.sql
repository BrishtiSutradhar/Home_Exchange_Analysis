--Aggregate total_night-guest
SELECT
  guest_user_id,
  SUM(night_count) AS total_nights_guest
FROM
  `lewagon-final-project-397408.home_exchange.exchanges_marc`
WHERE
  canceled_at = FALSE
  AND finalized_at = TRUE
GROUP BY
  guest_user_id;

--Aggregate toyal_nightr-host

SELECT
  host_user_id,
  SUM(night_count) AS total_nights_host
FROM
  `lewagon-final-project-397408.home_exchange.exchanges_marc`
WHERE
  canceled_at = FALSE
  AND finalized_at = TRUE
GROUP BY
  host_user_id;

--Merge guest & host column

SELECT
  *
FROM
  `lewagon-final-project-397408.home_exchange.401_total_nights_guest` AS g
FULL OUTER JOIN
  `lewagon-final-project-397408.home_exchange.402_total_nights_host` AS h
ON
  g.guest_user_id = h.host_user_id;

--Update Nulls

UPDATE
  `lewagon-final-project-397408.home_exchange.403_merged`
SET
  guest_user_id = host_user_id
WHERE
  guest_user_id IS NULL;

--Drop Column Host

ALTER TABLE
  `lewagon-final-project-397408.home_exchange.403_merged` DROP COLUMN host_user_id;

--Update Host Column

UPDATE
  `lewagon-final-project-397408.home_exchange.403_merged`
SET
  total_nights_host = 0
WHERE
  total_nights_host IS NULL;

--Update Guest Column

UPDATE
  `lewagon-final-project-397408.home_exchange.403_merged`
SET
  total_nights_guest = 0
WHERE
  total_nights_guest IS NULL;


--Merged with exchange_subscriptions_table

SELECT
  m.guest_user_id,
  m.total_nights_guest,
  m.total_nights_host,
  e.churn
FROM
  `lewagon-final-project-397408.home_exchange.403_merged` AS m
LEFT JOIN
  `lewagon-final-project-397408.home_exchange.exchanges_subscriptions` AS e
ON
  m.guest_user_id = e.user_id