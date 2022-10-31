SET NUMERIC_ROUNDABORT OFF;
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,
   QUOTED_IDENTIFIER, ANSI_NULLS ON;

DROP VIEW woonplaas_invloed_rides; 

--Create view with SCHEMABINDING.

GO
CREATE VIEW woonplaas_invloed_rides
   WITH SCHEMABINDING
   AS
   SELECT c.ZipCode, c.City, c.CountryCode, COUNT_BIG(*) AS 'Aantal Ritten'
FROM dbo.factRide f
JOIN dbo.dimCustomers c on f.DIM_USER_SK = c.userRepSK
GROUP BY c.ZipCode, c.City, c.CountryCode
GO

CREATE UNIQUE CLUSTERED INDEX INDEX_1
   ON  woonplaas_invloed_rides (ZipCode, City, CountryCode);
GO
