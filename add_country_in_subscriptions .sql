--Left join two table
SELECT
  *
FROM
  lewagon-final-project-397408.home_exchange.subscriptions AS sp
LEFT JOIN
 lewagon-final-project-397408.home_exchange.countryCode AS cp
ON
  cp.codeCountry = sp.country
 
