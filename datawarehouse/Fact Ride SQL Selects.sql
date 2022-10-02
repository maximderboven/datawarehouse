/* SELECT OP DE WAREHOUSE */
SELECT TOP (1000) [RideId]
      ,[StartPoint]
      ,[EndPoint]
      ,(cast([StartPoint] as geometry)).STDistance(cast([EndPoint] as geometry)) 'distance'
      ,[StartTime]
      ,[EndTime]
      ,[Duurtijd]
      ,[ClientName]
      ,[ClientEmail]
      ,[ClientStreet]
      ,[ClientNumber]
      ,[ClientZipcode]
      ,[ClientCity]
      ,[ClientCountryCode]
      ,[ClientSubValidFrom]
      ,[ClientSubDesc]
      ,[StartLockType]
      ,[StartLockStreet]
      ,[StartLockNumber]
      ,[StartLockZipcode]
      ,[StartLockDistrict]
      ,[EndLockType]
      ,[EndLockStreet]
      ,[EndLockNumber]
      ,[EndLockZipCode]
      ,[EndLockDistrict]
      ,[Date]
      ,[DayOfMonth]
      ,[Month]
      ,[Year]
      ,[DayOfWeek]
      ,[DayOfYear]
      ,[Weekday]
      ,[MonthName]
      ,[weer]
  FROM [velo_dwh].[dbo].[factRide]

  DECLARE @location geometry = 'POINT(51.193271157685444 4.433102615599496)';
  SELECT v.VehicleId, Point.STDistance(@location) as afstand
  FROM (SELECT * FROM [velo_op].[dbo].[Vehicles]) v
  ORDER BY afstand DESC;

  /*  Wat zijn de drukke momenten (op dagbasis) in de week t.o.v. het weekend? */
  SELECT COUNT(*) as 'aantal ritten', [Weekday] FROM  velo_dwh.dbo.factRide GROUP BY [Weekday] ORDER BY 1;

  /* Hebben datumparameters invloed op de afgelegde afstand? */

  /* Heeft weer invloed op ritten? */
  SELECT COUNT(*) as 'aantal ritten', [weer] FROM  velo_dwh.dbo.factRide GROUP BY [weer] ORDER BY 1;

  /*  Wat is de invloed van de woonplaats van de gebruikers op het gebruik van de fietsen? */

  /* Verschilt de populairste vertrekplek in het weekend tegenover in de week */

  /* We willen voorspellen welke sloten preventief onderhoud nodig hebben. Bekijk hoe vaak slotnummers relatief gezien gebruikt worden. */

  /*  Als een klant zijn abonnement stopzet willen we kunnen voorspellen op welke stations dit het meeste effect zal hebben. */

  /* Welk station is het vaakst (volledig) bezet */

  /* Gemiddelde rides actief op dezelfde moment */

  /* Wat zijn de populairste routes */
