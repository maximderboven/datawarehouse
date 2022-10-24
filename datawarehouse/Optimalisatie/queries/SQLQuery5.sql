  SELECT COUNT(*) as 'aantal ritten', w.weer
  FROM factRide f
  JOIN dimWeather w ON f.DIM_WEERTYPE_SK = w.id
  GROUP BY w.weer
  ORDER BY COUNT(*);

CREATE VIEW [dbo].[_dta_mv_1] WITH SCHEMABINDING
 AS 
SELECT  [dbo].[factRide].[DIM_WEERTYPE_SK] as _col_1,  count_big(*) as _col_2 FROM  [dbo].[factRide]  GROUP BY  [dbo].[factRide].[DIM_WEERTYPE_SK]  

CREATE UNIQUE CLUSTERED INDEX [_dta_index__dta_mv_1_c_8_1150627142__K1] ON [dbo].[_dta_mv_1]
(
	[_col_1] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]