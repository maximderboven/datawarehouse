/*
SELECT * from velo_op.dbo.Rides r join velo_op.dbo.[Weerhistoriek ] w on FORMAT(r.StartTime,'yyyy-MM-dd HH') = FORMAT(w.currentDate,'yyyy-MM-dd HH')
*/

SELECT * from velo_op.dbo.Rides r join velo_dwh.dbo.dimDate w on FORMAT(r.StartTime,'yyyy-MM-dd') = FORMAT(w.Date,'yyyy-MM-dd')