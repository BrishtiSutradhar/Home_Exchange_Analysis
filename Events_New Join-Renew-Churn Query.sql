-- Events New Join-Renew-Churn Query

WITH users AS(
SELECT user_id
, continent
, f0_ as event_date
, CASE when churn_date IS NOT NULL THEN 1 ELSE 0 END AS churn
, CASE when first_subscription_date IS NOT NULL THEN 1 ELSE 0 END AS new_sub
, CASE WHEN renew_2019 IS NOT NULL THEN 1 ELSE 0 END AS renew_19
, CASE WHEN renew_2020 IS NOT NULL THEN 1 ELSE 0 END AS renew_20
, CASE WHEN renew_2021 IS NOT NULL THEN 1 ELSE 0 END AS renew_21
, Adjusted_Popularity as user_popularity
FROM `lewagon-final-project-397408.home_exchange.subscription_sebas_table`
),


dates AS (
SELECT event_date
, user_id
, continent
, CASE WHEN churn = 1 THEN 'churn' 
    WHEN renew_19 = 1 THEN 'renew'
    WHEN renew_20 = 1 THEN 'renew'
    WHEN renew_21 = 1 THEN 'renew'
    WHEN new_sub = 1 THEN 'join'
  END AS event
, user_popularity
FROM users
)

SELECT 
user_id
, continent
, event
, CASE 
  WHEN event = 'churn' OR event = 'renew' THEN DATETIME_ADD(event_date, INTERVAL 1 YEAR)
  ELSE event_date END AS event_date
, user_popularity
FROM dates

