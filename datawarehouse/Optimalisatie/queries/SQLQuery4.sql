  SELECT c.ZipCode AS 'Zipcode Costumer', COUNT(*) AS 'Ritten', COUNT(*) /
  (SELECT COUNT(*) FROM dimCustomers c1
	  WHERE c1.Zipcode = c.Zipcode
  ) AS 'Gemiddelde ritten per persoon'
  FROM factRide f
  JOIN dimCustomers c on f.DIM_USER_SK = c.userRepSK
  GROUP BY c.ZipCode
  ORDER BY 3 DESC;

  CREATE VIEW [dbo].[_dta_mv_0] WITH SCHEMABINDING
 AS 
SELECT  [dbo].[dimCustomers].[Zipcode] as _col_1,  count_big(*) as _col_2 FROM  [dbo].[factRide],  [dbo].[dimCustomers]   WHERE  [dbo].[factRide].[DIM_USER_SK] = [dbo].[dimCustomers].[userRepSK]  GROUP BY  [dbo].[dimCustomers].[Zipcode]  

CREATE UNIQUE CLUSTERED INDEX [_dta_index__dta_mv_0_c_8_1166627199__K1] ON [dbo].[_dta_mv_0]
(
	[_col_1] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]


CREATE VIEW [dbo].[_dta_mv_1] WITH SCHEMABINDING
 AS 
SELECT  [dbo].[dimCustomers].[Zipcode] as _col_1,  [dbo].[dimCustomers].[userRepSK] as _col_2,  count_big(*) as _col_3 FROM  [dbo].[dimCustomers]  GROUP BY  [dbo].[dimCustomers].[Zipcode],  [dbo].[dimCustomers].[userRepSK]  

CREATE UNIQUE CLUSTERED INDEX [_dta_index__dta_mv_1_c_8_1182627256__K1_K2] ON [dbo].[_dta_mv_1]
(
	[_col_1] ASC,
	[_col_2] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
