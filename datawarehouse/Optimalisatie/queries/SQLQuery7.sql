  SELECT CONCAT(CONCAT(l.Street, ' '), l.District) AS 'Station',
  COUNT(l.StationId) AS 'Visits'
  FROM dimLocks l
  JOIN factRide r ON l.LockSK IN(r.START_DIM_LOCK_SK, r.END_DIM_LOCK_SK)
  JOIN dimCustomers c ON r.DIM_USER_SK = c.userRepSK
  WHERE c.UserId = 200 -- <============== UserId to be changed here
  GROUP BY l.StationId, l.Street, l.District
  ORDER BY COUNT(l.StationId) DESC;


 -- range op stationIDs