--Join Exchange subscriptions table
  WITH s AS(
  SELECT
    CASE
      WHEN renew = 1 THEN 0
      WHEN renew = 0 THEN 1
  END
    AS churn,
    *
  FROM
    `lewagon-final-project-397408.home_exchange.120 FINAL`f
  LEFT JOIN `lewagon-final-project-397408.home_exchange.exchanges_mergable` AS em ON f.user_id = em.creator_id
  )

  SELECT *
  FROM s
  LEFT JOIN `lewagon-final-project-397408.home_exchange.countryCode` a ON s.country = a.codeCountry

  