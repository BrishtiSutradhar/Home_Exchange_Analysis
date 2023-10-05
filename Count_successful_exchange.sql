
--Count Successful exchange
  
  SELECT
    creator_id,
    SUM(CASE WHEN finalized_at IS TRUE AND canceled_at IS FALSE THEN 1 ELSE 0 END) AS successful,
    COUNT(DISTINCT country) AS country_count,
    COUNTIF(exchange_type = "reciprocal") AS reciprocal,
    COUNTIF(exchange_type = "non_reciprocal") AS non_reciprocal,
    COUNTIF(home_type = "home") AS home_request,
    COUNTIF(home_type = "apartment") AS apartment_request,
    COUNTIF(home_type = "other") AS other_home_type_request,
    COUNTIF(residence_type = "primary") AS primary_residence_request,
    COUNTIF(residence_type = "secondary") AS secondary_residence_request,
    ROUND(AVG(max_capacity),2) AS average_capacity,
    COUNT(DISTINCT exchange_id) AS exchange_counts,
    COUNT(DISTINCT conversation_id) AS conversation_counts,
    COUNT(DISTINCT finalized_at) AS finalization_counts,
    COUNT(DISTINCT guest_user_id) AS guest_counts,
    COUNT(DISTINCT host_user_id) AS host_counts,
    SAFE_DIVIDE(COUNT(guest_countguest_count), COUNT(exchange_id)) AS guest_per_stay_avg,
    SAFE_DIVIDE(COUNT(night_count), COUNT(exchange_id)) AS nights_per_stay_avg,
    COUNTIF(user_cancellation_id IS NOT NULL) AS cancel_count
  FROM
    `lewagon-final-project-397408.home_exchange.exchanges_marc_cleaned`
  WHERE
    created_at BETWEEN DATE('2019-01-01') AND DATE('2021-10-31')
    AND start_on BETWEEN DATE('2019-01-01') AND DATE('2024-12-31')
    AND end_on BETWEEN DATE('2019-01-01') AND DATE('2024-12-31')
  GROUP BY creator_id 