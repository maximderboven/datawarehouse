/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM velo_op.[dbo].Rides r left join velo_dwh.dbo.dimCustomers c on r.SubscriptionId = c.SubscriptionId WHERE r.EndTime > c.scd_start and r.EndTime < c.scd_end ORDER BY r.SubscriptionId


  /* Verschil zit em in de 0 waardes */
SELECT *
FROM velo_op.[dbo].Rides r left join velo_dwh.dbo.dimCustomers c on r.SubscriptionId = c.SubscriptionId ORDER BY r.SubscriptionId

/* volgende probleem worden de locks die geen endlock hebben -> lock GEEN SLOT