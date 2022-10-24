  SELECT d.Weekday,
  ROUND(SUM(DISTANCE_MV) / 1000, 2) AS 'Totale afstand (km)',
  ROUND(SUM(DISTANCE_MV) / 1000 / COUNT(*), 2) AS 'Gemiddelde afstand (km)',
  COUNT(*) as 'aantal ritten'
  FROM factRide f
  JOIN dimDate d on d.Date_SK = f.DIM_DATE_SK
  GROUP BY d.Weekday, d.DayOfWeek
  ORDER BY d.DayOfWeek;