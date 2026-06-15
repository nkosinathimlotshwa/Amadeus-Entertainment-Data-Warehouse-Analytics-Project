/* Object:  Table [dwh].[dimChannel] */
USE [DDS];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO


BEGIN TRY

    BEGIN TRANSACTION

    /* Drop FK constraints on all fact tables */

    /* FK on factCampaignResult */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCampaignResult_dimChannel'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCampaignResult]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCampaignResult]
                DROP CONSTRAINT [fk_factCampaignResult_dimChannel];
            PRINT 'FK [fk_factCampaignResult_dimChannel] dropped successfully.'
        END

    /* FK on factCommunicationSubscription */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCommunicationSubscription_dimChannel'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCommunicationSubscription]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                DROP CONSTRAINT [fk_factCommunicationSubscription_dimChannel];
            PRINT 'FK [fk_factCommunicationSubscription_dimChannel] dropped successfully.'
        END

    /* Drop dimChannel if it already exists */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimChannel'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimChannel]
                DROP CONSTRAINT IF EXISTS [pk_dimChannel];
            DROP TABLE [dwh].[dimChannel];
            PRINT 'Table [dwh].[dimChannel] dropped successfully.'
        END

    /* Create dimChannel table on dds_fg6 */
    CREATE TABLE [dwh].[dimChannel]
        (
            /* Surrogate key - assigned by ETL via NDS keying */
            [channelKey]            INT             NOT NULL,
            [name]                  VARCHAR(20)     NULL,
            [description]           VARCHAR(50)     NULL,
            [startDate]             SMALLDATETIME   NULL,
            [endDate]               SMALLDATETIME   NULL,
            [status]                VARCHAR(10)     NULL,

            /* ETL audit columns */
            [sourceSystemCode]      TINYINT         NOT NULL,
            [createTimestamp]       DATETIME        NOT NULL,
            [updateTimestamp]       DATETIME        NOT NULL,

            /* Primary key clustered index on dds_fg6 */
            CONSTRAINT [pk_dimChannel] PRIMARY KEY CLUSTERED
                (
                    [channelKey] ASC
                )
                WITH
                (
                    STATISTICS_NORECOMPUTE      = OFF,
                    IGNORE_DUP_KEY              = OFF,
                    OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
                )
                ON [dds_fg6]

        )
        /* Table data stored on dds_fg6 */
        ON [dds_fg6];

    PRINT 'Table [dwh].[dimChannel] created successfully.'

    /* Recreate FK constraints on both fact tables */

    /* Recreate FK on factCampaignResult */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factCampaignResult'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factCampaignResult]
                ADD CONSTRAINT  [fk_factCampaignResult_dimChannel]
                FOREIGN KEY     ([channelKey])
                REFERENCES      [dwh].[dimChannel] ([channelKey]);
            PRINT 'FK [fk_factCampaignResult_dimChannel] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factCampaignResult] does not exist yet.'
            PRINT 'FK [fk_factCampaignResult_dimChannel] will be added when fact table is created.'
        END

    /* Recreate FK on factCommunicationSubscription */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factCommunicationSubscription'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                ADD CONSTRAINT  [fk_factCommunicationSubscription_dimChannel]
                FOREIGN KEY     ([channelKey])
                REFERENCES      [dwh].[dimChannel] ([channelKey]);
            PRINT 'FK [fk_factCommunicationSubscription_dimChannel] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factCommunicationSubscription] does not exist yet.'
            PRINT 'FK [fk_factCommunicationSubscription_dimChannel] will be added when fact table is created.'
        END

    /* Commit if all steps succeeded */
    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimChannel] created and committed.'


END TRY
BEGIN CATCH

    /* Check @@TRANCOUNT before rollback */
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    PRINT 'Error - all changes rolled back.'
    PRINT ERROR_MESSAGE();

END CATCH
GO

/* Verify dimChannel was created successfully */
SELECT
    [c].[name]              AS [ColumnName],
    [t].[name]              AS [DataType],
    [c].[max_length]        AS [MaxLength],
    [c].[is_nullable]       AS [IsNullable]
FROM        [sys].[columns]         AS [c]
INNER JOIN  [sys].[types]           AS [t]
    ON  [c].[user_type_id]  = [t].[user_type_id]
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimChannel]')
ORDER BY    [c].[column_id];
GO
