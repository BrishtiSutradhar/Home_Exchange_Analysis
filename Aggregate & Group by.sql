--Aggregate exchange table & group by creator_id

SELECT creator_id
, COUNT(DISTINCT country) as country_count
, COUNT(CASE WHEN exchange_type = "RECIPROCAL" THEN 1 END) as reciprocal
, COUNT(CASE WHEN exchange_type = "NON_RECIPROCAL" THEN 1 END) as non_reciprocal
, COUNT(CASE WHEN home_type = "home" THEN 1 END) as home
, COUNT(CASE WHEN home_type = "apartment" THEN 1 END) as apartment
, COUNT(CASE WHEN home_type = "other" THEN 1 END) as other_home_type
, COUNT(CASE WHEN residence_type = "primary" THEN 1 END) as primary_residence
, COUNT(CASE WHEN residence_type = "secondary" THEN 1 END) as secondary_residence
, AVG(max_capacity) as average_capacity
, count(DISTINCT conversation_id) as conversation_counts
, count(DISTINCT exchange_id) as exchange_counts
, count(DISTINCT guest_user_id) as guest_counts
, count(DISTINCT host_user_id) as host_counts 
, count(DISTINCT finalized_at) as finalization_counts
, SAFE_DIVIDE(count(guest_countguest_count),COUNT(exchange_id)) as guest_per_stay_avg
, SAFE_DIVIDE(count(night_count),COUNT(exchange_id)) as nights_per_stay_avg
, count(DISTINCT user_cancellation_id) as cancel_count 
FROM `lewagon-final-project-397408.home_exchange.exchange` 
WHERE created_at BETWEEN DATE('2019-01-01') AND DATE('2021-10-31') 
  AND start_on BETWEEN DATE('2019-01-01') AND DATE('2024-12-31')
  AND end_on BETWEEN DATE('2019-01-01') AND DATE('2024-12-31')
GROUP BY creator_id