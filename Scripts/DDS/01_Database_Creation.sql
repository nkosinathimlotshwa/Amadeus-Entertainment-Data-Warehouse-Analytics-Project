SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF DB_ID(N'DDS') IS NOT NULL
BEGIN
	PRINT 'Database [DDS] already exists. Dropping...'
	DROP DATABASE [DDS]
	PRINT 'Database [DDS] dropped successfully.'
END
GO

/*** Object: Database [DDS] ***/
CREATE DATABASE [DDS]
	ON PRIMARY
		(
			NAME = N'dds_fg1',
			FILENAME = N'C:\Disk\Data1\dds_fg1.mdf',
			SIZE = 50MB,
			FILEGROWTH = 10MB
		),

	FILEGROUP [dds_fg2]
		(
			NAME = N'dds_fg2',
			FILENAME = N'C:\Disk\Data2\dds_fg2.ndf',
			SIZE = 50MB,
			FILEGROWTH = 10MB
		),
    /*** Filegroup 3 ***/
	FILEGROUP [dds_fg3]
        (
            NAME        = N'dds_fg3',
            FILENAME    = N'C:\Disk\Data3\dds_fg3.ndf',
            SIZE        = 50MB,
            FILEGROWTH  = 10MB
        ),

    /*** Filegroup 4 ***/
    FILEGROUP [dds_fg4]
        (
            NAME        = N'dds_fg4',
            FILENAME    = N'C:\Disk\Data4\dds_fg4.ndf',
            SIZE        = 50MB,
            FILEGROWTH  = 10MB
        ),

    /*** Filegroup 5 ***/
    FILEGROUP [dds_fg5]
        (
            NAME        = N'dds_fg5',
            FILENAME    = N'C:\Disk\Data5\dds_fg5.ndf',
            SIZE        = 50MB,
            FILEGROWTH  = 10MB
        ),

    /*** Filegroup 6 ***/
    FILEGROUP [dds_fg6]
        (
            NAME        = N'dds_fg6',
            FILENAME    = N'C:\Disk\Data6\dds_fg6.ndf',
            SIZE        = 50MB,
            FILEGROWTH  = 10MB
        )
	/*** Log File ***/
    LOG ON
        (
            NAME        = N'dds_log',
            FILENAME    = N'C:\Disk\Log1\dds_log.ldf',
            SIZE        = 100MB,
            FILEGROWTH  = 50MB
        )

	COLLATE SQL_Latin1_General_CP1_CI_AS;
GO

/*** Object: DatabaseOption [DDS] Recovery Model ***/
ALTER DATABASE [DDS]
	SET RECOVERY SIMPLE
WITH NO_WAIT;
GO

/*** Object: DatabaseOption [DDS] AutoShrink ***/
ALTER DATABASE [DDS]
	SET AUTO_SHRINK OFF
WITH NO_WAIT;
GO

/*** Object: DatabseOption [DDS] Statistics ***/
ALTER DATABASE [DDS]
	SET AUTO_CREATE_STATISTICS ON
WITH NO_WAIT;
GO

ALTER DATABASE [DDS]
	SET AUTO_UPDATE_STATISTICS ON
WITH NO_WAIT;
GO

SELECT 
	[name] AS [Database Name],
	[recovery_model_desc] AS [Recovery Model],
	[collation_name] AS [Collation],
	[create_date] AS [Created On]
FROM [sys].[databases]
WHERE [name] = N'DDS';
GO

