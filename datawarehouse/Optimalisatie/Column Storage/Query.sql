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