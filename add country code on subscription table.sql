--Left join two table
SELECT
  *
FROM
  brishti-project.home_exchange.subscriptions AS sp
LEFT JOIN
 brishti-project.home_exchange.country_code AS cp
ON
  cp.codeCountry = sp.country

  --
