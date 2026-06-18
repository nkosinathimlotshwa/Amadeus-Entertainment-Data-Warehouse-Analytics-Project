/* Object:  Table [dwh].[dimCustomer] */
USE [DDS];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO


BEGIN TRY

    BEGIN TRANSACTION

    /* FK on factCampaignResult */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCampaignResult_dimCustomer'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCampaignResult]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCampaignResult]
                DROP CONSTRAINT [fk_factCampaignResult_dimCustomer];
            PRINT 'FK [fk_factCampaignResult_dimCustomer] dropped successfully.'
        END

    /* FK on factCommunicationSubscription */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCommunicationSubscription_dimCustomer'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCommunicationSubscription]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                DROP CONSTRAINT [fk_factCommunicationSubscription_dimCustomer];
            PRINT 'FK [fk_factCommunicationSubscription_dimCustomer] dropped successfully.'
        END

    /* FK on factSubscriptionSales */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factSubscriptionSales_dimCustomer'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSubscriptionSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                DROP CONSTRAINT [fk_factSubscriptionSales_dimCustomer];
            PRINT 'FK [fk_factSubscriptionSales_dimCustomer] dropped successfully.'
        END

    /* FK on factProductSales */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factProductSales_dimCustomer'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factProductSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factProductSales]
                DROP CONSTRAINT [fk_factProductSales_dimCustomer];
            PRINT 'FK [fk_factProductSales_dimCustomer] dropped successfully.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimCustomer'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimCustomer]
                DROP CONSTRAINT IF EXISTS [pk_dimCustomer];
            DROP TABLE [dwh].[dimCustomer];
            PRINT 'Table [dwh].[dimCustomer] dropped successfully.'
        END

    CREATE TABLE [dwh].[dimCustomer]
        (
            [customerKey]           INT             NOT NULL,
            [customerId]            VARCHAR(10)     NOT NULL,
            [accountNumber]         INT             NULL,
            [customerType]          CHAR(3)         NULL,
            [name]                  VARCHAR(100)    NULL,
            [gender]                CHAR(1)         NULL,
            [emailAddress]          VARCHAR(200)    NULL,
            [dateOfBirth]           DATETIME        NULL,
            [address1]              VARCHAR(50)     NULL,
            [address2]              VARCHAR(50)     NULL,
            [address3]              VARCHAR(50)     NULL,
            [address4]              VARCHAR(50)     NULL,
            [city]                  VARCHAR(50)     NULL,
            [state]                 VARCHAR(50)     NULL,
            [zipcode]               VARCHAR(10)     NULL,
            [country]               VARCHAR(50)     NULL,
            [phoneNumber]           VARCHAR(20)     NULL,
            [occupation]            VARCHAR(50)     NULL,
            [householdIncome]       VARCHAR(30)     NULL,
            [dateRegistered]        DATETIME        NULL,
            [status]                VARCHAR(10)     NULL,
            [subscriberClass]       VARCHAR(30)     NULL,
            [subscriberBand]        VARCHAR(30)     NULL,
            [permission]            VARCHAR(2)      NULL,
            [preferredChannel1]     VARCHAR(20)     NULL,
            [preferredChannel2]     VARCHAR(20)     NULL,
            [interest1]             VARCHAR(30)     NULL,
            [interest2]             VARCHAR(30)     NULL,
            [interest3]             VARCHAR(30)     NULL,
            [effectiveTimestamp]    DATETIME        NULL,
            [expiryTimestamp]       DATETIME        NULL,
            [isCurrent]             TINYINT         NULL,
            [sourceSystemCode]      TINYINT         NOT NULL,
            [createTimestamp]       DATETIME        NOT NULL,
            [updateTimestamp]       DATETIME        NOT NULL,

            /* Primary key clustered index on dds_fg6 */
            CONSTRAINT [pk_dimCustomer] PRIMARY KEY CLUSTERED
                (
                    [customerKey] ASC
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

    PRINT 'Table [dwh].[dimCustomer] created successfully.'

    /* Unique index on customerId */
    /* One natural key per customer */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimCustomer_customerId'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimCustomer]')
        )
        DROP INDEX [IX_dimCustomer_customerId]
            ON [dwh].[dimCustomer];

    CREATE UNIQUE NONCLUSTERED INDEX [IX_dimCustomer_customerId]
        ON  [dwh].[dimCustomer] ([customerId])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimCustomer_customerId] created successfully.'


    /* Nonclustered index on emailAddress */
    /* Used for customer lookup in campaign targeting queries */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimCustomer_emailAddress'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimCustomer]')
        )
        DROP INDEX [IX_dimCustomer_emailAddress]
            ON [dwh].[dimCustomer];

    CREATE NONCLUSTERED INDEX [IX_dimCustomer_emailAddress]
        ON  [dwh].[dimCustomer] ([emailAddress])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimCustomer_emailAddress] created successfully.'


    /* Nonclustered index on city */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimCustomer_city'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimCustomer]')
        )
        DROP INDEX [IX_dimCustomer_city]
            ON [dwh].[dimCustomer];

    CREATE NONCLUSTERED INDEX [IX_dimCustomer_city]
        ON  [dwh].[dimCustomer] ([city])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimCustomer_city] created successfully.'


    /* Nonclustered index on occupation */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimCustomer_occupation'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimCustomer]')
        )
        DROP INDEX [IX_dimCustomer_occupation]
            ON [dwh].[dimCustomer];

    CREATE NONCLUSTERED INDEX [IX_dimCustomer_occupation]
        ON  [dwh].[dimCustomer] ([occupation])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimCustomer_occupation] created successfully.'

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
                ADD CONSTRAINT  [fk_factCampaignResult_dimCustomer]
                FOREIGN KEY     ([customerKey])
                REFERENCES      [dwh].[dimCustomer] ([customerKey]);
            PRINT 'FK [fk_factCampaignResult_dimCustomer] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factCampaignResult] does not exist yet.'
            PRINT 'FK [fk_factCampaignResult_dimCustomer] will be added when fact table is created.'
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
                ADD CONSTRAINT  [fk_factCommunicationSubscription_dimCustomer]
                FOREIGN KEY     ([customerKey])
                REFERENCES      [dwh].[dimCustomer] ([customerKey]);
            PRINT 'FK [fk_factCommunicationSubscription_dimCustomer] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factCommunicationSubscription] does not exist yet.'
            PRINT 'FK [fk_factCommunicationSubscription_dimCustomer] will be added when fact table is created.'
        END

    /* Recreate FK on factSubscriptionSales */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSubscriptionSales'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                ADD CONSTRAINT  [fk_factSubscriptionSales_dimCustomer]
                FOREIGN KEY     ([customerKey])
                REFERENCES      [dwh].[dimCustomer] ([customerKey]);
            PRINT 'FK [fk_factSubscriptionSales_dimCustomer] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factSubscriptionSales] does not exist yet.'
            PRINT 'FK [fk_factSubscriptionSales_dimCustomer] will be added when fact table is created.'
        END

    /* Recreate FK on factProductSales */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factProductSales'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factProductSales]
                ADD CONSTRAINT  [fk_factProductSales_dimCustomer]
                FOREIGN KEY     ([customerKey])
                REFERENCES      [dwh].[dimCustomer] ([customerKey]);
            PRINT 'FK [fk_factProductSales_dimCustomer] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factProductSales] does not exist yet.'
            PRINT 'FK [fk_factProductSales_dimCustomer] will be added when fact table is created.'
        END

    /* Commit if all steps succeeded */
    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimCustomer] created and committed.'


END TRY
BEGIN CATCH

    /* Check @@TRANCOUNT before rollback */
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    PRINT 'Error - all changes rolled back.'
    PRINT ERROR_MESSAGE();

END CATCH
GO

/* Verify dimCustomer was created successfully */
SELECT
    [c].[name]              AS [ColumnName],
    [t].[name]              AS [DataType],
    [c].[max_length]        AS [MaxLength],
    [c].[is_nullable]       AS [IsNullable]
FROM        [sys].[columns]         AS [c]
INNER JOIN  [sys].[types]           AS [t]
    ON  [c].[user_type_id]  = [t].[user_type_id]
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimCustomer]')
ORDER BY    [c].[column_id];
GO

/* Verify all indexes were created correctly */
SELECT
    [i].[name]              AS [IndexName],
    [i].[type_desc]         AS [IndexType],
    [i].[is_unique]         AS [IsUnique],
    [c].[name]              AS [ColumnName]
FROM        [sys].[indexes]         AS [i]
INNER JOIN  [sys].[index_columns]   AS [ic]
    ON  [i].[object_id]     = [ic].[object_id]
    AND [i].[index_id]      = [ic].[index_id]
INNER JOIN  [sys].[columns]         AS [c]
    ON  [ic].[object_id]    = [c].[object_id]
    AND [ic].[column_id]    = [c].[column_id]
WHERE       [i].[object_id] = OBJECT_ID(N'[dwh].[dimCustomer]')
AND         [i].[type]      > 0
ORDER BY    [i].[name];
GO
