-- voor elke weekdag een filegroep aanmaken
ALTER DATABASE dwh_velo
ADD FILEGROUP dimday_maandag;

ALTER DATABASE dwh_velo
ADD FILEGROUP dimday_dinsdag;

ALTER DATABASE dwh_velo
ADD FILEGROUP dimday_woensdag;

ALTER DATABASE dwh_velo
ADD FILEGROUP dimday_donderdag;

ALTER DATABASE dwh_velo
ADD FILEGROUP dimday_vrijdag;

ALTER DATABASE dwh_velo
ADD FILEGROUP dimday_zaterdag;

ALTER DATABASE dwh_velo
ADD FILEGROUP dimday_zondag;

-- per filegroep een bestand
ALTER DATABASE dwh_velo    
ADD FILE (
    NAME = dimday_maandag,
    FILENAME = 'D:\data\dimday_maandag.ndf',
        SIZE = 5 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024KB
		) 
TO FILEGROUP dimday_maandag;

ALTER DATABASE dwh_velo    
ADD FILE (
    NAME = dimday_dinsdag,
    FILENAME = 'D:\data\dimday_dinsdag.ndf',
        SIZE = 5 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024KB
		) 
TO FILEGROUP dimday_dinsdag;

ALTER DATABASE dwh_velo    
ADD FILE (
    NAME = dimday_woensdag,
    FILENAME = 'D:\data\dimday_woensdag.ndf',
        SIZE = 5 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024KB
		) 
TO FILEGROUP dimday_woensdag;

ALTER DATABASE dwh_velo    
ADD FILE (
    NAME = dimday_donderdag,
    FILENAME = 'D:\data\dimday_donderdag.ndf',
        SIZE = 5 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024KB
		) 
TO FILEGROUP dimday_donderdag;

ALTER DATABASE dwh_velo    
ADD FILE (
    NAME = dimday_vrijdag,
    FILENAME = 'D:\data\dimday_vrijdag.ndf',
        SIZE = 5 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024KB
		) 
TO FILEGROUP dimday_vrijdag;

ALTER DATABASE dwh_velo    
ADD FILE (
    NAME = dimday_zaterdag,
    FILENAME = 'D:\data\dimday_zaterdag.ndf',
        SIZE = 5 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024KB
		) 
TO FILEGROUP dimday_zaterdag;

ALTER DATABASE dwh_velo    
ADD FILE (
    NAME = dimday_zondag,
    FILENAME = 'D:\data\dimday_zondag.ndf',
        SIZE = 5 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024KB
		) 
TO FILEGROUP dimday_zondag;


CREATE PARTITION FUNCTION order_by_day (int)
AS RANGE LEFT 
FOR VALUES (1, 2,3,4,5,6,7);

CREATE PARTITION SCHEME DateRangePS
AS PARTITION DateRangesPS 
TO (dimday_maandag,dimday_dinsdag,dimday_woensdag,dimday_donderdag,dimday_vrijdag,dimday_zaterdag,dimday_zondag);