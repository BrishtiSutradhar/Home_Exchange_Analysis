

-- Churned Calculation for each user
-- If user subscription last happened more than 365 days before the max date (10-31-2021) then consider churned


WITH MaxDate AS (
    -- This subquery finds the maximum subscription_date across the entire dataset.
    SELECT MAX(subscription_date) AS max_subscription_date FROM `lewagon-final-project-397408.home_exchange.subscriptions`

)

SELECT 
    user_id,
    CASE 
        WHEN DATE_DIFF((SELECT max_subscription_date FROM MaxDate), MAX(subscription_date), DAY) >= 365 THEN TRUE
        ELSE FALSE
    END AS churned,
    MIN(subscription_date) AS min_first_subscription_date,
    MAX(subscription_date) AS max_user_subscription_date,
    date_diff(MAX(subscription_date),MIN(subscription_date),DAY) as sub_time,
    max(renew) as renew,
    max(first_subscription_date) as first_subscription_date,
    min(first_subscription) as first_subscription,
    max(referral) as referral,
    max(promotion) as promotion,
    max(payment3x) as payment3x, 
    max(payment2) as payment2,
    max(payment3) as payment3,
    max(country) as country,
    max(region) as region ,
    max(department) as department, 
    max(city) as city
    -- max(codeCountry), 
    -- countryName, 
    -- Contient
    
FROM 
  `lewagon-final-project-397408.home_exchange.subscriptions`
GROUP BY 
    user_id
ORDER BY 
    user_id;



    --Replace Null Value From Churn_by_user_subscriptions Table

    SELECT
  user_id,
  churned,
  min_first_subscription_date,
  max_user_subscription_date,
  sub_time,
  renew,
  first_subscription_date,
  first_subscription,
  referral,
  promotion,
  payment3x,
  payment2,
  payment3,
  IFNULL (country,'unknown') AS country,
  IFNULL (region, 'unknown') AS region,
  IFNULL (department,'unknown') AS department,
  IFNULL (city,'unknown') AS city
FROM
 home_exchange.120_churn_by_user
