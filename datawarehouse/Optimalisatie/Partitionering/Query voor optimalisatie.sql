  /* Welke customer heeft al de meeste tijd op een vehicle gezeten in de eerste week van oktober */
  SELECT TOP 1 c.Name AS 'Name',
  SUM(f.DURATION_MV / 60000) as 'totaal tijd (min).',
  count(*) as 'Totaal ritten',
  SUM(f.DURATION_MV / 60000) /  count(*) as 'Gemiddelde tijd per rit (min)'
  from factRide f
  join dimCustomers c on f.DIM_USER_SK = c.userRepSK
  WHERE f.STARTTIME_MV BETWEEN '2015-09-01' AND '2015-09-30'
  GROUP BY f.DIM_USER_SK, c.Name
  ORDER BY COUNT(f.DURATION_MV) DESC