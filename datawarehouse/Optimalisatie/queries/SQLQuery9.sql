  SELECT TOP 1 c.Name AS 'Name',
  SUM(f.DURATION_MV / 60000) as 'totaal tijd (min).',
  count(*) as 'Totaal ritten',
  SUM(f.DURATION_MV / 60000) /  count(*) as 'Gemiddelde tijd per rit (min)'
  from factRide f
  join dimCustomers c on f.DIM_USER_SK = c.userRepSK
  GROUP BY f.DIM_USER_SK, c.Name
  ORDER BY COUNT(f.DURATION_MV) DESC


  CREATE PARTITION FUNCTION [_dta_pf__9987](int) AS RANGE LEFT FOR VALUES (450, 7811, 15666, 22292, 28790, 36045, 43679, 50596, 57354, 64377, 71809)


  CREATE PARTITION SCHEME [_dta_ps__4364] AS PARTITION [_dta_pf__9987] TO ([PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY])
