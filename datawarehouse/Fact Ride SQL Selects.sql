/* SELECT OP DE WAREHOUSE */
SELECT TOP (1000) *
      ,(cast([STARTPOINT_MV] as geometry)).STDistance(cast([ENDPOINT_MV] as geometry)) 'distance'
  FROM [velo_dwh].[dbo].[factRide]

  DECLARE @location geometry = 'POINT(51.193271157685444 4.433102615599496)';
  SELECT v.VehicleId, Point.STDistance(@location) as afstand
  FROM (SELECT * FROM [velo_op].[dbo].[Vehicles]) v
  ORDER BY afstand DESC;

  /*  Wat zijn de drukke momenten (op dagbasis) in de week t.o.v. het weekend? */
  SELECT d.Weekday, COUNT(*) as 'aantal ritten'
  FROM velo_dwh.dbo.factRide f
  JOIN dimDate d on d.Date_SK = f.DIM_DATE_SK
  GROUP BY [Weekday]
  ORDER BY 2;

  /* Hebben datumparameters invloed op de afgelegde afstand? */


  /* Heeft weer invloed op ritten? 
  SELECT COUNT(*) as 'aantal ritten', [weer] FROM  velo_dwh.dbo.factRide GROUP BY [weer] ORDER BY 1;*/

  /* Wat is de invloed van de woonplaats van de gebruikers op het gebruik van de fietsen? */

  /* Verschilt de populairste vertrekplek in het weekend tegenover in de week */
  SELECT d.Weekday as 'weekdag',l.StationId as 'vertrekplek', COUNT(*) as 'aantal vertrekken' from factRide f join dimDate d on f.DIM_DATE_SK = d.Date_SK join dimLocks l on f.START_DIM_LOCK_SK = l.LockSK group by d.Weekday, l.StationId

  /* We willen voorspellen welke sloten preventief onderhoud nodig hebben. Bekijk hoe vaak slotnummers relatief gezien gebruikt worden. */
  SELECT l.LockId,COUNT(*) as 'Hoeveel keer gebruikt' from factRide r 
  join dimLocks l on l.LockSK = r.START_DIM_LOCK_SK 
  join dimLocks on l.LockSK = r.END_DIM_LOCK_SK
  GROUP BY l.LockId
  ORDER BY 2 DESC;

  /* Als een klant zijn abonnement stopzet willen we kunnen voorspellen op welke stations dit het meeste effect zal hebben. */
  SELECT CONCAT(CONCAT(l.Street, ' '), l.District) AS 'Station',
  COUNT(l.StationId) AS 'Visits'
  FROM dimLocks l
  JOIN factRide r ON l.LockSK IN(r.START_DIM_LOCK_SK, r.END_DIM_LOCK_SK)
  JOIN dimCustomers c ON r.DIM_USER_SK = c.userRepSK
  WHERE c.UserId = 200
  GROUP BY l.StationId, l.Street, l.District
  ORDER BY COUNT(l.StationId) DESC;

  /* Welk station is het vaakst (volledig) bezet */

  /* Gemiddelde rides actief op dezelfde moment */
  SELECT SUM(CAST(DATEDIFF(SECOND, STARTTIME_MV, ENDTIME_MV) AS BIGINT)) / DATEDIFF(SECOND, MIN(STARTTIME_MV), MAX(ENDTIME_MV)) from factRide;

  /* Wat zijn de populairste routes (alleen docked rides) */
  SELECT COUNT(fr.RIDE_ID) AS 'Amount of rides',
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
