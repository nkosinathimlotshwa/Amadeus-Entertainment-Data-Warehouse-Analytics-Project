/* Object:  Table [dwh].[dimDeliveryStatus] */
USE [DDS];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO


BEGIN TRY

    BEGIN TRANSACTION

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCampaignResult_dimDeliveryStatus'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCampaignResult]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCampaignResult]
                DROP CONSTRAINT [fk_factCampaignResult_dimDeliveryStatus];
            PRINT 'FK [fk_factCampaignResult_dimDeliveryStatus] dropped successfully.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimDeliveryStatus'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimDeliveryStatus]
                DROP CONSTRAINT IF EXISTS [pk_dimDeliveryStatus];
            DROP TABLE [dwh].[dimDeliveryStatus];
            PRINT 'Table [dwh].[dimDeliveryStatus] dropped successfully.'
        END

    CREATE TABLE [dwh].[dimDeliveryStatus]
        (
            [deliveryStatusKey]     INT             NOT NULL,
            [deliveryStatusCode]    INT             NOT NULL,
            [description]           VARCHAR(50)     NULL,
            [category]              VARCHAR(20)     NULL,
            [sourceSystemCode]      TINYINT         NOT NULL,
            [createTimestamp]       DATETIME        NOT NULL,
            [updateTimestamp]       DATETIME        NOT NULL,
            CONSTRAINT [pk_dimDeliveryStatus] PRIMARY KEY CLUSTERED
                (
                    [deliveryStatusKey] ASC
                )
                WITH
                (
                    STATISTICS_NORECOMPUTE      = OFF,
                    IGNORE_DUP_KEY              = OFF,
                    OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
                )
                ON [dds_fg6]

        )
        ON [dds_fg6];

    PRINT 'Table [dwh].[dimDeliveryStatus] created successfully.'

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factCampaignResult'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factCampaignResult]
                ADD CONSTRAINT  [fk_factCampaignResult_dimDeliveryStatus]
                FOREIGN KEY     ([deliveryStatusKey])
                REFERENCES      [dwh].[dimDeliveryStatus] ([deliveryStatusKey]);
            PRINT 'FK [fk_factCampaignResult_dimDeliveryStatus] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factCampaignResult] does not exist yet.'
            PRINT 'FK [fk_factCampaignResult_dimDeliveryStatus] will be added when fact table is created.'
        END

    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimDeliveryStatus] created and committed.'


END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    PRINT 'Error - all changes rolled back.'
    PRINT ERROR_MESSAGE();

END CATCH
GO

SELECT
    [c].[name]              AS [ColumnName],
    [t].[name]              AS [DataType],
    [c].[max_length]        AS [MaxLength],
    [c].[is_nullable]       AS [IsNullable]
FROM        [sys].[columns]         AS [c]
INNER JOIN  [sys].[types]           AS [t]
    ON  [c].[user_type_id]  = [t].[user_type_id]
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimDeliveryStatus]')
ORDER BY    [c].[column_id];
GO
