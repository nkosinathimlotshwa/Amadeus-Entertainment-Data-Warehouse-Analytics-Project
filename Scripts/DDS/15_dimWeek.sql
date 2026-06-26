/* Object:  View [dwh].[dimWeek] */
USE [DDS];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS
    (
        SELECT  *
        FROM    [sys].[views]
        WHERE   [name]      = N'dimWeek'
        AND     [schema_id] = SCHEMA_ID(N'dwh')
    )
    BEGIN
        DROP VIEW [dwh].[dimWeek];
        PRINT 'View [dwh].[dimWeek] dropped successfully.'
    END
GO

CREATE VIEW [dwh].[dimWeek]
AS
    SELECT
        [dateKey],
        [date],
        [systemDate],
        [sqlDate],
        [julianDate],
        [day],
        [dayOfTheYear],
        [weekNumber],
        [month],
        [monthName],
        [shortMonthName],
        [quarter],
        [year],
        [fiscalWeek],
        [fiscalPeriod],
        [fiscalQuarter],
        [fiscalYear],
        [sourceSystemCode],
        [createTimestamp],
        [updateTimestamp]
    FROM    [dwh].[dimDate]
    WHERE   [dayOfTheWeek] = 1;
GO

PRINT 'View [dwh].[dimWeek] created successfully.'
GO

SELECT TOP 5
    [dateKey],
    [date],
    [weekNumber],
    [fiscalWeek],
    [fiscalPeriod],
    [year]
FROM    [dwh].[dimWeek]
ORDER BY [dateKey];
GO

SELECT
    [TotalWeeks]    = COUNT(*)
FROM    [dwh].[dimWeek];
GO
