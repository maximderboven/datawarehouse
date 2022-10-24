-- voor elke weekdag een filegroep aanmaken
ALTER DATABASE velo_dwh
ADD FILEGROUP fg_maandag;

ALTER DATABASE velo_dwh
ADD FILEGROUP fg_dinsdag;

ALTER DATABASE velo_dwh
ADD FILEGROUP fg_woensdag;

ALTER DATABASE velo_dwh
ADD FILEGROUP fg_donderdag;

ALTER DATABASE velo_dwh
ADD FILEGROUP fg_vrijdag;

ALTER DATABASE velo_dwh
ADD FILEGROUP fg_zaterdag;

ALTER DATABASE velo_dwh
ADD FILEGROUP fg_zondag;

-- per filegroep een bestand
ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat_maandag,
    FILENAME = '/var/opt/mssql/data/dat_maandag.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg_maandag;

ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat_dinsdag,
    FILENAME = '/var/opt/mssql/data/dat_dinsdag.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg_dinsdag;

ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat_woensdag,
    FILENAME = '/var/opt/mssql/data/dat_woensdag.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg_woensdag;

ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat_donderdag,
    FILENAME = '/var/opt/mssql/data/dat_donderdag.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg_donderdag;

ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat_vrijdag,
    FILENAME = '/var/opt/mssql/data/dat_vrijdag.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg_vrijdag;

ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat_zaterdag,
    FILENAME = '/var/opt/mssql/data/dat_zaterdag.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg_zaterdag;

ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat_zondag,
    FILENAME = '/var/opt/mssql/data/dat_zondag.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg_zondag;


CREATE PARTITION FUNCTION dateRanges (int)
AS RANGE LEFT
FOR VALUES (1,2,3,4,5,6);

CREATE PARTITION SCHEME DateRangePS
AS PARTITION dateRanges
TO (fg_maandag,fg_dinsdag,fg_woensdag,fg_donderdag,fg_vrijdag,fg_zaterdag,fg_zondag);
