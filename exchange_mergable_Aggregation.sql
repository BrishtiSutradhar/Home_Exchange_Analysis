--Exchange Mergable_Aggregation

WITH season AS(
SELECT *,
  CASE WHEN EXTRACT(MONTH FROM start_on) BETWEEN 3 AND 6 AND EXTRACT(MONTH FROM end_on) BETWEEN 3 AND 6 THEN 1 ELSE 0 END AS spring,
  CASE WHEN EXTRACT(MONTH FROM start_on) BETWEEN 6 AND 9 AND EXTRACT(MONTH FROM end_on) BETWEEN 6 AND 9 THEN 1 ELSE 0 END AS summer,
  CASE WHEN EXTRACT(MONTH FROM start_on) BETWEEN 9 AND 12 AND EXTRACT(MONTH FROM end_on) BETWEEN 9 AND 12 THEN 1 ELSE 0 END AS fall,
  CASE WHEN (EXTRACT(MONTH FROM start_on) >= 12 OR EXTRACT(MONTH FROM start_on) <= 3) AND (EXTRACT(MONTH FROM end_on) >= 12 OR EXTRACT(MONTH FROM end_on) <= 3) THEN 1 ELSE 0 END AS winter,
  CASE WHEN finalized_at IS TRUE AND canceled_at IS FALSE THEN 1 ELSE 0 END AS successful
FROM `lewagon-final-project-397408.home_exchange.exchanges_marc_cleaned`
),

seasons AS(
SELECT 
  *
  , CASE WHEN spring = 0 AND summer = 0 AND fall = 0 AND winter = 0 THEN 1 ELSE 0 END AS not_seasonal
FROM season
)
  
  SELECT
    creator_id,
  
  --These columns are based on stays

    SUM(successful) as successful_count,
    COUNT(DISTINCT country) AS country_count,
    COUNTIF(successful =1 AND exchange_type = "reciprocal") AS reciprocal,
    COUNTIF(successful =1 AND exchange_type = "non_reciprocal") AS non_reciprocal,
    COUNTIF(successful =1 AND home_type = "home") AS home_request,
    COUNTIF(successful =1 AND home_type = "apartment") AS apartment_request,
    COUNTIF(successful =1 AND home_type = "other") AS other_home_type_request,
    COUNTIF(successful =1 AND residence_type = "primary") AS primary_residence_request,
    COUNTIF(successful =1 AND residence_type = "secondary") AS secondary_residence_request,

  # These columns are based on requests, not stays

    ROUND(AVG(max_capacity),2) AS average_capacity,
    COUNT(DISTINCT exchange_id) AS exchange_counts,
    COUNT(DISTINCT conversation_id) AS conversation_counts,
    COUNT(DISTINCT finalized_at) AS finalization_counts,

  # Improved (I think)

    COUNTIF(successful = 1) AS guest_counts,
    COUNTIF(successful = 1 AND creator_id = guest_user_id) AS host_counts,

  # Not really sure how to fix these, Sebastian thinks these shouldn't be analysed but anyone else can go ahead

    CASE WHEN SAFE_DIVIDE(COUNT(guest_countguest_count), SUM(successful)) IS NULL THEN 0 END AS guest_per_stay_avg,
    CASE WHEN SAFE_DIVIDE(COUNT(night_count), SUM(successful)) IS NULL THEN 0 END AS nights_per_stay_avg,

  # These columns are based on stays

    COUNTIF(user_cancellation_id IS NOT NULL OR canceled_at IS NOT NULL) AS cancel_count,
    COUNTIF(spring = 1) AS spring_count,
    COUNTIF(summer = 1) AS summer_count,
    COUNTIF(fall = 1) AS fall_count,
    COUNTIF(winter = 1) AS winter_count,
    COUNTIF(not_seasonal = 1) AS not_seasonal_count
  FROM
    seasons
  WHERE
    created_at BETWEEN DATE('2019-01-01') AND DATE('2021-10-31')
    AND start_on BETWEEN DATE('2019-01-01') AND DATE('2024-12-31')
    AND end_on BETWEEN DATE('2019-01-01') AND DATE('2024-12-31')
  GROUP BY creator_id 
