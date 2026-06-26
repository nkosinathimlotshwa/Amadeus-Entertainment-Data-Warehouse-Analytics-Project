/* Object:  Table [dwh].[dimStore] */
USE [DDS];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO


BEGIN TRY

    BEGIN TRANSACTION

    /* FK on factProductSales */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factProductSales_dimStore'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factProductSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factProductSales]
                DROP CONSTRAINT [fk_factProductSales_dimStore];
            PRINT 'FK [fk_factProductSales_dimStore] dropped successfully.'
        END

    /* FK on factSubscriptionSales */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factSubscriptionSales_dimStore'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSubscriptionSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                DROP CONSTRAINT [fk_factSubscriptionSales_dimStore];
            PRINT 'FK [fk_factSubscriptionSales_dimStore] dropped successfully.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimStore'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimStore]
                DROP CONSTRAINT IF EXISTS [pk_dimStore];
            DROP TABLE [dwh].[dimStore];
            PRINT 'Table [dwh].[dimStore] dropped successfully.'
        END


    CREATE TABLE [dwh].[dimStore]
        (
            [storeKey]              INT             NOT NULL,
            [storeNumber]           SMALLINT        NULL,
            [storeName]             VARCHAR(50)     NULL,
            [storeType]             VARCHAR(30)     NULL,
            [storeAddress1]         VARCHAR(50)     NULL,
            [storeAddress2]         VARCHAR(50)     NULL,
            [storeAddress3]         VARCHAR(50)     NULL,
            [storeAddress4]         VARCHAR(50)     NULL,
            [city]                  VARCHAR(50)     NULL,
            [state]                 VARCHAR(50)     NULL,
            [zipcode]               VARCHAR(10)     NULL,
            [country]               VARCHAR(50)     NULL,
            [phoneNumber]           VARCHAR(20)     NULL,
            [webSite]               VARCHAR(100)    NULL,
            [region]                VARCHAR(50)     NULL,
            [priorRegion]           VARCHAR(50)     NULL,
            [priorRegionDate]       DATETIME        NULL,
            [division]              VARCHAR(50)     NULL,
            [priorDivision]         VARCHAR(50)     NULL,
            [priorDivisionDate]     DATETIME        NULL,
            [sourceSystemCode]      TINYINT         NULL,
            [createTimestamp]       DATETIME        NULL,
            [updateTimestamp]       DATETIME        NULL,
            CONSTRAINT [pk_dimStore] PRIMARY KEY CLUSTERED
                (
                    [storeKey] ASC
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

    PRINT 'Table [dwh].[dimStore] created successfully.'

    INSERT INTO [dwh].[dimStore]
        (
            [storeKey],
            [storeNumber],
            [storeName],
            [storeType],
            [storeAddress1],
            [storeAddress2],
            [storeAddress3],
            [storeAddress4],
            [city],
            [state],
            [zipcode],
            [country],
            [phoneNumber],
            [webSite],
            [region],
            [priorRegion],
            [priorRegionDate],
            [division],
            [priorDivision],
            [priorDivisionDate],
            [sourceSystemCode],
            [createTimestamp],
            [updateTimestamp]
        )
    VALUES
        (
            0,
            0,
            'Unknown',
            'Unknown',
            'Unknown',
            'Unknown',
            'Unknown',
            'Unknown',
            'Unknown',
            'Unknown',
            'Unknown',
            'Unknown',
            '',
            'Unknown',
            'Unknown',
            'Unknown',
            '19000101',
            'Unknown',
            'Unknown',
            '19000101',
            0,
            GETDATE(),
            GETDATE()
        );

    PRINT 'Unknown member row inserted into [dwh].[dimStore] successfully.'


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
                ADD CONSTRAINT  [fk_factProductSales_dimStore]
                FOREIGN KEY     ([storeKey])
                REFERENCES      [dwh].[dimStore] ([storeKey]);
            PRINT 'FK [fk_factProductSales_dimStore] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factProductSales] does not exist yet.'
            PRINT 'FK [fk_factProductSales_dimStore] will be added when fact table is created.'
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
                ADD CONSTRAINT  [fk_factSubscriptionSales_dimStore]
                FOREIGN KEY     ([storeKey])
                REFERENCES      [dwh].[dimStore] ([storeKey]);
            PRINT 'FK [fk_factSubscriptionSales_dimStore] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factSubscriptionSales] does not exist yet.'
            PRINT 'FK [fk_factSubscriptionSales_dimStore] will be added when fact table is created.'
        END

    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimStore] created and committed.'


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
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimStore]')
ORDER BY    [c].[column_id];
GO

SELECT
    [storeKey],
    [storeName],
    [region],
    [division]
FROM    [dwh].[dimStore]
WHERE   [storeKey] = 0;
GO
