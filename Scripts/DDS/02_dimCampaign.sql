
/* Object:  Table [dwh].[dimCampaign] */
USE [DDS];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO


BEGIN TRY

    BEGIN TRANSACTION

    /* Drop FK on factCampaignResult */
  
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCampaignResult_dimCampaign'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCampaignResult]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCampaignResult]
                DROP CONSTRAINT [fk_factCampaignResult_dimCampaign];
            PRINT 'FK [fk_factCampaignResult_dimCampaign] dropped successfully.'
        END

    /* Drop dimCampaign if it already exists */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimCampaign'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimCampaign]
                DROP CONSTRAINT IF EXISTS [pk_dimCampaign];
            DROP TABLE [dwh].[dimCampaign];
            PRINT 'Table [dwh].[dimCampaign] dropped successfully.'
        END

    /* Create dimCampaign table on dds_fg6 */
    CREATE TABLE [dwh].[dimCampaign]
        (
            /* Surrogate key - assigned by ETL via NDS keying   */
            [campaignKey]           INT             NOT NULL,
            [campaignTitle]         VARCHAR(50)     NOT NULL,
            [description]           VARCHAR(100)    NULL,
            [plannedSendDate]       SMALLDATETIME   NULL,
            [numberOfRecipients]    INT             NULL,
            [communicationName]     VARCHAR(50)     NULL,

            /* ETL audit columns */
            [sourceSystemCode]      TINYINT         NOT NULL,
            [createTimestamp]       DATETIME        NOT NULL,
            [updateTimestamp]       DATETIME        NOT NULL,

            /* Primary key clustered index on dds_fg6          */
            CONSTRAINT [pk_dimCampaign] PRIMARY KEY CLUSTERED
                (
                    [campaignKey] ASC
                )
                WITH
                (
                    STATISTICS_NORECOMPUTE      = OFF,
                    IGNORE_DUP_KEY              = OFF,
                    OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
                )
                ON [dds_fg6]

        )
        /*** Table data stored on dds_fg6 ***/
        ON [dds_fg6];

    PRINT 'Table [dwh].[dimCampaign] created successfully.'
      
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
                ADD CONSTRAINT  [fk_factCampaignResult_dimCampaign]
                FOREIGN KEY     ([campaignKey])
                REFERENCES      [dwh].[dimCampaign] ([campaignKey]);
            PRINT 'FK [fk_factCampaignResult_dimCampaign] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factCampaignResult] does not exist yet.'
            PRINT 'FK [fk_factCampaignResult_dimCampaign] will be added when fact table is created.'
        END

    /* Commit if all steps succeeded */
    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimCampaign] created and committed.'


END TRY
BEGIN CATCH

    /* Check @@TRANCOUNT before rollback */-
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    PRINT 'Error - all changes rolled back.'
    PRINT ERROR_MESSAGE();

END CATCH
GO

/* Verify dimCampaign was created successfully */
SELECT
    [c].[name]              AS [ColumnName],
    [t].[name]              AS [DataType],
    [c].[max_length]        AS [MaxLength],
    [c].[is_nullable]       AS [IsNullable]
FROM        [sys].[columns]         AS [c]
INNER JOIN  [sys].[types]           AS [t]
    ON  [c].[user_type_id]  = [t].[user_type_id]
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimCampaign]')
ORDER BY    [c].[column_id];
GO
