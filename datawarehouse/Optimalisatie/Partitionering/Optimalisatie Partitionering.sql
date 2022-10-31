-- een filegroep aanmaken
ALTER DATABASE velo_dwh
ADD FILEGROUP fg1;

ALTER DATABASE velo_dwh
ADD FILEGROUP fg2;

ALTER DATABASE velo_dwh
ADD FILEGROUP fg3;

ALTER DATABASE velo_dwh
ADD FILEGROUP fg4;

-- per filegroep een bestand
ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat1,
    FILENAME = '/var/opt/mssql/data/dat1.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg1;

ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat2,
    FILENAME = '/var/opt/mssql/data/dat2.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg2;

ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat3,
    FILENAME = '/var/opt/mssql/data/dat3.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg3;

ALTER DATABASE velo_dwh
ADD FILE (
    NAME = dat4,
    FILENAME = '/var/opt/mssql/data/dat4.ndf',
        SIZE = 5 MB,
        MAXSIZE = UNLIMITED,
        FILEGROWTH = 1024KB
		)
TO FILEGROUP fg4;

CREATE PARTITION FUNCTION DateRangesMonths (datetime) AS RANGE RIGHT
FOR VALUES (N'2015-08-01T00:00:00.000',N'2015-09-01T00:00:00.000', N'2015-10-01T00:00:00.000');

CREATE PARTITION SCHEME DateRangesMonthsPS
AS PARTITION DateRangesMonths
TO (fg1,fg2,fg3,fg4);
