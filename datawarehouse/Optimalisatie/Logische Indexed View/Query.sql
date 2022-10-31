SELECT c.ZipCode, c.City, c.CountryCode, COUNT_BIG(*) AS 'Aantal Ritten'
FROM dbo.factRide f
JOIN dbo.dimCustomers c on f.DIM_USER_SK = c.userRepSK
GROUP BY c.ZipCode, c.City, c.CountryCode
ORDER BY 4 DESC