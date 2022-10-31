  -- WARNING: Als u denkt dat het script vastloopt, dit is waarschijnlijk niet zo, het heeft zijn tijd nodig (bij ons circa 1 min.)

  /* SELECT OP DE WAREHOUSE */
  SELECT TOP (1000) *
      ,(cast([STARTPOINT_MV] as geometry)).STDistance(cast([ENDPOINT_MV] as geometry)) 'distance'
  FROM [velo_dwh].[dbo].[factRide]

  DECLARE @location geography = 'POINT(51.193271157685444 4.433102615599496)';
  SELECT v.VehicleId, @location.STDistance(v.Point.ToString()) as afstand
  FROM [velo_op].[dbo].[Vehicles] v
  ORDER BY afstand DESC;
  
  /* Wat zijn de drukke momenten (op dagbasis) in de week t.o.v. het weekend? */
  SELECT d.Weekday, COUNT(*) AS 'Piekritten per uur', CONCAT(FORMAT(f.STARTTIME_MV, 'HH'), 'h') AS 'HOUR'
  FROM factRide f
  JOIN dimDate d ON d.Date_SK = f.DIM_DATE_SK
  GROUP BY d.Weekday, FORMAT(f.STARTTIME_MV, 'HH'), d.DayOfWeek
  HAVING COUNT(*) = (SELECT MAX(j1.Ritten) FROM
	  (SELECT d.Weekday,
		  COUNT(*) AS 'Ritten',
		  FORMAT(f.STARTTIME_MV, 'HH') AS 'HOUR'
		  FROM factRide f1
		  JOIN dimDate d1 ON d1.Date_SK = f1.DIM_DATE_SK
		  WHERE d1.Weekday = d.Weekday
		  GROUP BY d1.Weekday, FORMAT(f1.STARTTIME_MV, 'HH')
	  ) AS j1
	  GROUP BY j1.Weekday, j1.Hour)
  ORDER BY d.DayOfWeek;

  /* Hebben datumparameters invloed op de afgelegde afstand? */
  SELECT d.Weekday,
  ROUND(SUM(DISTANCE_MV) / 1000, 2) AS 'Totale afstand (km)',
  ROUND(SUM(DISTANCE_MV) / 1000 / COUNT(*), 2) AS 'Gemiddelde afstand (km)',
  COUNT(*) as 'aantal ritten'
  FROM factRide f
  JOIN dimDate d on d.Date_SK = f.DIM_DATE_SK
  GROUP BY d.Weekday, d.DayOfWeek
  ORDER BY d.DayOfWeek;

  /* Heeft weer invloed op ritten? */
  SELECT COUNT(*) as 'aantal ritten', w.weer
  FROM factRide f
  JOIN dimWeather w ON f.DIM_WEERTYPE_SK = w.id
  GROUP BY w.weer
  ORDER BY COUNT(*);

  /* Wat is de invloed van de woonplaats van de gebruikers op het gebruik van de fietsen? */
  SELECT c.ZipCode AS 'Zipcode Costumer', COUNT(*) AS 'Ritten', COUNT(*) /
  (SELECT COUNT(*) FROM dimCustomers c1
	  WHERE c1.Zipcode = c.Zipcode
  ) AS 'Gemiddelde ritten per persoon'
  FROM factRide f
  JOIN dimCustomers c on f.DIM_USER_SK = c.userRepSK
  GROUP BY c.ZipCode
  ORDER BY 3 DESC;

  SELECT c.ZipCode, c.City, c.CountryCode, COUNT_BIG(*) AS 'Aantal Ritten'
  FROM dbo.factRide f
  JOIN dbo.dimCustomers c on f.DIM_USER_SK = c.userRepSK
  GROUP BY c.ZipCode, c.City, c.CountryCode
  ORDER BY 4 DESC;

  /* Verschilt de populairste vertrekplek in het weekend tegenover in de week */
  SELECT
  l.Street as 'Station',
  CASE
  WHEN d.IsWeekend = 'true' THEN 'Weekend'
  ELSE 'Week'
  END as 'IsWeekend',
  COUNT (*) as 'Ritten',
  CASE
  WHEN d.IsWeekend = 'true' THEN COUNT(*) / 2
  ELSE COUNT (*) / 5
  END AS 'Ritten per dag'
  FROM factRide r
  JOIN dimLocks l ON r.START_DIM_LOCK_SK = l.LockSK
  JOIN dimDate d ON r.DIM_DATE_SK = d.Date_SK
  WHERE l.StationId IS NOT NULL
  group by d.IsWeekend, l.StationId, l.Street
  HAVING COUNT (*) = (SELECT max(j1.Ritten) FROM
	  (SELECT
		  l1.StationId as 'StationId',
		  CASE
		  WHEN d1.IsWeekend = 'true' THEN 'Weekend'
		  ELSE 'Week'
		  END AS 'IsWeekend',
		  COUNT (*) AS 'Ritten'
		  FROM factRide r1
		  JOIN dimLocks l1 ON r1.START_DIM_LOCK_SK = l1.LockSK
		  JOIN dimDate d1 ON r1.DIM_DATE_SK = d1.Date_SK
		  WHERE l1.StationId IS NOT NULL
		  AND d1.IsWeekend = d.IsWeekend
		  GROUP BY d1.IsWeekend, l1.StationId) AS j1
	  GROUP BY j1.IsWeekend);

  /* We willen voorspellen welke sloten preventief onderhoud nodig hebben. Bekijk hoe vaak slotnummers relatief gezien gebruikt worden. */
  SELECT TOP(100) CONCAT(CONCAT(l1.Street, ' '), l1.District) AS 'Station', l1.StationLockNr AS 'Locknummer', COUNT(*) AS '# keer gebruikt' FROM factRide f
  JOIN dimLocks l1 ON f.START_DIM_LOCK_SK = l1.LockSK
  JOIN dimLocks l2 ON f.END_DIM_LOCK_SK = l2.LockSK
  WHERE l1.LockSK != l2.LockSK
  GROUP BY l1.LockId, l1.Street, l1.District, l1.StationLockNr
  ORDER BY COUNT(*) DESC;

  /* Als een klant zijn abonnement stopzet willen we kunnen voorspellen op welke stations dit het meeste effect zal hebben. */
  SELECT CONCAT(CONCAT(l.Street, ' '), l.District) AS 'Station',
  COUNT(l.StationId) AS 'Visits'
  FROM dimLocks l
  JOIN factRide r ON l.LockSK IN(r.START_DIM_LOCK_SK, r.END_DIM_LOCK_SK)
  JOIN dimCustomers c ON r.DIM_USER_SK = c.userRepSK
  WHERE c.UserId = 200 -- <============== UserId to be changed here
  GROUP BY l.StationId, l.Street, l.District
  ORDER BY COUNT(l.StationId) DESC;

  /* Na hoeveel rides gaat een vehicle gemiddeld in maintenance. */
  SELECT COUNT(*) /
	  (SELECT 
	  COUNT (*)
	  FROM factRide
	  where DIM_USER_SK = 0) AS 'Gemiddeld aantal rides voor maintenance'
  from factRide;

  /* Gemiddelde rides actief op dezelfde moment */
  SELECT SUM(CAST(DATEDIFF(SECOND, STARTTIME_MV, ENDTIME_MV) AS BIGINT)) /
  DATEDIFF(SECOND, MIN(STARTTIME_MV), MAX(ENDTIME_MV)) AS 'Gemiddelde aantal rides op dezelfde moment'
  from factRide;

  /* Wat zijn de populairste routes (alleen docked rides) */
  SELECT TOP(20) COUNT(fr.RIDE_ID) AS 'Amount of rides',
  CONCAT(CONCAT(dl1.Street, ' '), dl1.District) AS 'From',
  CONCAT(CONCAT(dl2.Street, ' '), dl2.District) AS 'To'
  FROM factRide fr
  JOIN dimLocks dl1 ON fr.START_DIM_LOCK_SK = dl1.LockSK
  JOIN dimLocks dl2 ON fr.END_DIM_LOCK_SK = dl2.LockSK
  WHERE dl1.StationId IS NOT NULL
  AND dl1.Street != 'ONTBREKEND'
  AND dl2.Street != 'ONTBREKEND'
  AND dl1.StationId != dl2.StationId
  GROUP BY fr.START_DIM_LOCK_SK, fr.END_DIM_LOCK_SK, dl1.Street, dl1.District, dl2.Street, dl2.District
  ORDER BY COUNT(RIDE_ID) DESC;
  
  /* Welke customer heeft al de meeste tijd op een vehicle gezeten in oktober */
  SELECT TOP 1 c.Name AS 'Name',
  SUM(f.DURATION_MV / 60000) as 'totaal tijd (min).',
  count(*) as 'Totaal ritten',
  SUM(f.DURATION_MV / 60000) /  count(*) as 'Gemiddelde tijd per rit (min)'
  from factRide f
  join dimCustomers c on f.DIM_USER_SK = c.userRepSK
  WHERE f.STARTTIME_MV BETWEEN '2015-09-01' AND '2015-09-30'
  GROUP BY f.DIM_USER_SK, c.Name
  ORDER BY COUNT(f.DURATION_MV) DESC
  
  /* Hoeveel % van de ritten vertrek vanuit de zipcode van de gebruiker */
  SELECT 
  100*(SELECT COUNT(*)
  FROM factride f
  JOIN dimCustomers c ON f.DIM_USER_SK = c.userRepSK
  JOIN dimLocks l on f.START_DIM_LOCK_SK = l.LockSK
  WHERE l.ZipCode = c.Zipcode)
  /
  (SELECT COUNT(*)
  FROM factride f
  JOIN dimCustomers c ON f.DIM_USER_SK = c.userRepSK
  JOIN dimLocks l on f.START_DIM_LOCK_SK = l.LockSK
  WHERE l.ZipCode != c.Zipcode) AS 'Vertrek vanuit eigen Zipcode (%)';
  
  /* Hoeveel mensen hebben er nog nooit gereden maar hebben wel een subscription gekocht */
  SELECT COUNT(*) AS 'Nog nooit gereden' FROM dimCustomers
  WHERE userRepSK NOT IN (
  SELECT DIM_USER_SK FROM factRide
  )
  AND subscriptionId IS NOT NULL;
