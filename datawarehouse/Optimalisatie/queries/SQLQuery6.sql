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


CREATE VIEW [dbo].[_dta_mv_0] WITH SCHEMABINDING
 AS 
SELECT  [dbo].[dimDate].[IsWeekend] as _col_1,  [dbo].[dimLocks].[Street] as _col_2,  [dbo].[dimLocks].[StationId] as _col_3,  count_big(*) as _col_4 FROM  [dbo].[dimDate],  [dbo].[factRide],  [dbo].[dimLocks]   WHERE  [dbo].[factRide].[START_DIM_LOCK_SK] = [dbo].[dimLocks].[LockSK]  AND  [dbo].[dimDate].[Date_SK] = [dbo].[factRide].[DIM_DATE_SK]  GROUP BY  [dbo].[dimDate].[IsWeekend],  [dbo].[dimLocks].[Street],  [dbo].[dimLocks].[StationId]  

CREATE UNIQUE CLUSTERED INDEX [_dta_index__dta_mv_0_c_8_1214627370__K1_K2_K3] ON [dbo].[_dta_mv_0]
(
	[_col_1] ASC,
	[_col_2] ASC,
	[_col_3] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
