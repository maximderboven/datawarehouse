SELECT *
  FROM [velo_op].[dbo].[Subscriptions] WHERE UserID = '41'
SELECT *
  FROM [velo_dwh].[dbo].[dimCustomers] WHERE UserID = '41'
SELECT *
  FROM [velo_op].[dbo].[Users] where UserID = '41'

SELECT COUNT(*) from velo_op.dbo.Subscriptions s join velo_op.dbo.Users u on s.UserId = u.UserId
SELECT COUNT(*) from velo_dwh.dbo.dimCustomers

SELECT COUNT(*) as 'aantal users'
  FROM [velo_op].[dbo].[Users]

  SELECT COUNT(*) as 'aantal subscriptions'
  FROM [velo_op].[dbo].Subscriptions


  SELECT * from velo_op.dbo.Subscriptions s join velo_op.dbo.Users u on s.UserId = u.UserId
where u.userID = '38'
