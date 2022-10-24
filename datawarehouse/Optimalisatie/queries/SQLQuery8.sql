  SELECT COUNT(*) /
	  (SELECT 
	  COUNT (*)
	  FROM factRide
	  where DIM_USER_SK = 0) AS 'Gemiddeld aantal rides voor maintenance'
  from factRide;


CREATE VIEW [dbo].[_dta_mv_0] WITH SCHEMABINDING
 AS 
SELECT  [dbo].[factRide].[DIM_USER_SK] as _col_1,  count_big(*) as _col_2 FROM  [dbo].[factRide]   GROUP BY  [dbo].[factRide].[DIM_USER_SK]  


CREATE UNIQUE CLUSTERED INDEX [_dta_index__dta_mv_0_c_8_1406628054__K1] ON [dbo].[_dta_mv_0]
(
	[_col_1] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
