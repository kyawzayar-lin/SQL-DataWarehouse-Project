/*
============================================================================================================
Stored Procedure : Data Load to Bronze Layer
============================================================================================================
Script Purpose:
    This stored procedure is for loading .csv file from CRM and ERP system to the respective tables in Bronze
    layer schema.
    It will performs the following actions:
    - Truncates the bronze tables before loading to the tables.
    - Uses the 'BULK INSERT' command to load data.

Parameters: None

Usage Example: 
    EXEC Bronze.dataload
*/

USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE Bronze.dataload
AS

BEGIN

    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

    BEGIN TRY
    SET @batch_start_time = GETDATE();
    PRINT '=================================';
    PRINT 'Loading .csv to Bronze Layer';
    PRINT '=================================';

    PRINT '=================================';
    PRINT 'Loading CRM table to Bronze Layer';
    PRINT '=================================';

    SET @start_time = GETDATE();
    PRINT '>> Insert Data Into: Bronze.CRM_CustomerInfo'

    TRUNCATE TABLE Bronze.CRM_CustomerInfo
    BULK INSERT Bronze.CRM_CustomerInfo
    FROM 'C:\Users\X415MA\Projects\SQL Datawarehouse Project\Datasets\CRM source_data\cust_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
    PRINT '==================================================================================================';


    SET @start_time = GETDATE();
    PRINT '>> Insert Data Into: Bronze.CRM_ProdcutInfo'

    TRUNCATE TABLE Bronze.CRM_ProdcutInfo
    BULK INSERT Bronze.CRM_ProdcutInfo
    FROM 'C:\Users\X415MA\Projects\SQL Datawarehouse Project\Datasets\CRM source_data\prd_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
    PRINT '==================================================================================================';

    SET @start_time = GETDATE();
    PRINT '>> Insert Data Into: Bronze.CRM_SaleDetails'
    TRUNCATE TABLE Bronze.CRM_SaleDetails
    BULK INSERT Bronze.CRM_SaleDetails
    FROM 'C:\Users\X415MA\Projects\SQL Datawarehouse Project\Datasets\CRM source_data\sales_details.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
    PRINT '==================================================================================================';


    PRINT '=================================';
    PRINT 'Loading ERP table to Bronze Layer';
    PRINT '=================================';

    SET @start_time = GETDATE();
    PRINT '>> Insert Data Into: Bronze.ERP_Cust_az12'
    TRUNCATE TABLE [Bronze].[ERP_Cust_az12]
    BULK INSERT [Bronze].[ERP_Cust_az12]
    FROM 'C:\Users\X415MA\Projects\SQL Datawarehouse Project\Datasets\ERP source_data\CUST_AZ12.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
    PRINT '==================================================================================================';

    SET @start_time = GETDATE();
    PRINT '>> Insert Data Into: Bronze.ERP_Loc_a101'
    TRUNCATE TABLE [Bronze].[ERP_Loc_a101]
    BULK INSERT [Bronze].[ERP_Loc_a101]
    FROM 'C:\Users\X415MA\Projects\SQL Datawarehouse Project\Datasets\ERP source_data\LOC_A101.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
    PRINT '==================================================================================================';

    SET @start_time = GETDATE();
    PRINT '>> Insert Data Into: Bronze.PX_Cat_g1v2'
    TRUNCATE TABLE [Bronze].[ERP_PX_Cat_g1v2]
    BULK INSERT [Bronze].[ERP_PX_Cat_g1v2]
    FROM 'C:\Users\X415MA\Projects\SQL Datawarehouse Project\Datasets\ERP source_data\PX_CAT_G1V2.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
    PRINT '==================================================================================================';

    SET @batch_end_time = GETDATE();
    PRINT '======================================';
    PRINT 'Loading file to Bronze layer is completed.';
    PRINT 'Overall Duration : ' + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds.';
    PRINT '=======================================';
    END TRY

    BEGIN CATCH 
        PRINT '=====================================================';
        PRINT 'ERROR OCCURDED DURING DATA LOAD';
        PRINT 'Error Message ' + ERROR_MESSAGE();
        PRINT 'Error Message ' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT '=====================================================';
    END CATCH
END

-- EXEC Bronze.dataload