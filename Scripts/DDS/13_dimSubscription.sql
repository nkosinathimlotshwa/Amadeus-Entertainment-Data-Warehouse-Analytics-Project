/* Object:  Table [dwh].[dimSubscriptionStatus] */
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
            WHERE   [name]              = N'fk_factCommunicationSubscription_dimSubscriptionStatus'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCommunicationSubscription]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                DROP CONSTRAINT [fk_factCommunicationSubscription_dimSubscriptionStatus];
            PRINT 'FK [fk_factCommunicationSubscription_dimSubscriptionStatus] dropped successfully.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimSubscriptionStatus'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimSubscriptionStatus]
                DROP CONSTRAINT IF EXISTS [pk_dimSubscriptionStatus];
            DROP TABLE [dwh].[dimSubscriptionStatus];
            PRINT 'Table [dwh].[dimSubscriptionStatus] dropped successfully.'
        END

    CREATE TABLE [dwh].[dimSubscriptionStatus]
        (
            [subscriptionStatusKey]     INT             NOT NULL,
            [subscriptionStatusCode]    CHAR(2)         NULL,
            [description]               VARCHAR(50)     NULL,
            [sourceSystemCode]          TINYINT         NULL,
            [createTimestamp]           DATETIME        NULL,
            [updateTimestamp]           DATETIME        NULL,
            CONSTRAINT [pk_dimSubscriptionStatus] PRIMARY KEY CLUSTERED
                (
                    [subscriptionStatusKey] ASC
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

    PRINT 'Table [dwh].[dimSubscriptionStatus] created successfully.'

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factCommunicationSubscription'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                ADD CONSTRAINT  [fk_factCommunicationSubscription_dimSubscriptionStatus]
                FOREIGN KEY     ([subscriptionStatusKey])
                REFERENCES      [dwh].[dimSubscriptionStatus] ([subscriptionStatusKey]);
            PRINT 'FK [fk_factCommunicationSubscription_dimSubscriptionStatus] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factCommunicationSubscription] does not exist yet.'
            PRINT 'FK [fk_factCommunicationSubscription_dimSubscriptionStatus] will be added when fact table is created.'
        END

    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimSubscriptionStatus] created and committed.'


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
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimSubscriptionStatus]')
ORDER BY    [c].[column_id];
GO
