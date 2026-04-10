/*
****************************************
Stored Procedure: Load Bronze Layer (Source -> Bronze)
****************************************
Script Purpose:
   This stored procedure loads data into the 'bronze' schema from external CSV files.
   It performs the following actions:
   - Truncates the bronze tables before loading data.
   - Uses the BULK INSERT command to load data from csv Files to bronze tables.
Parameters:
       None.
     This stored procedure does not accept any parameters or return any values.

Usage Example:
   EXEC bronze.load_bronze;
****************************************
*/

Create OR Alter Procedure bronze.load_bronze AS 
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
BEGIN TRY
SET @ batch_start _time=GETDATE();
Print ‘==========================’;
Print ’Loading Bronze Layer’;
Print ‘==========================’;
Print ‘-----------------------------------------’;
Print ‘Loading CRM Tables’;
Print ‘-----------------------------------------’;
SET @start_time=GETDATE();
Print ‘>> Truncating Table: bronze. crm_cust_info ’;
TRUNCATE TABLE bronze. crm_cust_info;
Print ‘>> Inserting Table: bronze. crm_cust_info ’;
BULK INSERT bronze. crm_cust_info
FROM ‘C:\sql\dwh_project\datasets\source_crm\cust_info.csv’
WITH ( FIRSTROW=2, FIELDTERMINATOR=’,’, TABLOCK
);  
SET @end_time=GETDATE();
PRINT ‘>>Load Duration: ’+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ‘ seconds’;
PRINT ‘>>-----------------------------------’;

SET @start_time=GETDATE();
Print ‘>> Truncating Table: bronze. crm_prd_info ’;
TRUNCATE TABLE bronze.crm_prd_info;
Print ‘>> Inserting Table: bronze. crm_prd_info ’;
BULK INSERT bronze.crm_prd_info
FROM ‘C:\sql\dwh_project\datasets\source_crm\prd_info.csv’
WITH ( FIRSTROW=2, FIELDTERMINATOR=’,’, TABLOCK
);
SET @end_time=GETDATE();
PRINT ‘>>Load Duration: ’+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ‘ seconds’;
PRINT ‘>>-----------------------------------’;

SET @start_time=GETDATE();
Print ‘>> Truncating Table: bronze. crm_ sales_details’;
TRUNCATE TABLE bronze.crm_sales_details;
Print ‘>> Inserting Table: bronze. crm_sales_details’;
BULK INSERT bronze.crm_sales_details
FROM ‘C:\sql\dwh_project\datasets\source_crm\ sales_details.csv’
WITH ( FIRSTROW=2, FIELDTERMINATOR=’,’, TABLOCK
);
SET @end_time=GETDATE();
PRINT ‘>>Load Duration: ’+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ‘ seconds’;
PRINT ‘>>-----------------------------------’;
Print ‘-----------------------------------------’;
Print ‘Loading ERP Tables’;
Print ‘-----------------------------------------’;
SET @start_time=GETDATE();
Print ‘>> Truncating Table: bronze.erp_loc_a101’;
TRUNCATE TABLE bronze.erp_loc_a101;
Print ‘>> Inserting Table: bronze.erp_loc_a101’;
BULK INSERT bronze.erp_loc_a101
FROM ‘C:\sql\dwh_project\datasets\source_erp\loc_a101.csv’
WITH ( FIRSTROW=2, FIELDTERMINATOR=’,’, TABLOCK
);
SET @end_time=GETDATE();
PRINT ‘>>Load Duration: ’+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ‘ seconds’;
PRINT ‘>>-----------------------------------’;

SET @start_time=GETDATE();
Print ‘>> Truncating Table: bronze.erp_cust_az12’;
TRUNCATE TABLE bronze.erp_cust_az12;
Print ‘>> Inserting Table: bronze.erp_cust_az12’;
BULK INSERT bronze.erp_cust_az12
FROM ‘C:\sql\dwh_project\datasets\source_erp\cust_az12.csv’
WITH ( FIRSTROW=2, FIELDTERMINATOR=’,’, TABLOCK
);
SET @end_time=GETDATE();
PRINT ‘>>Load Duration: ’+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ‘ seconds’;
PRINT ‘>>-----------------------------------’;

SET @start_time=GETDATE();
Print ‘>> Truncating Table: bronze.erp_px_cat_g1v2’;
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
Print ‘>> Inserting Table: bronze.erp_px_cat_g1v2’;
BULK INSERT bronze.erp_px_cat_g1v2
FROM ‘C:\sql\dwh_project\datasets\source_erp\px_cat_g1v2.csv’
WITH ( FIRSTROW=2, FIELDTERMINATOR=’,’, TABLOCK
);
SET @end_time=GETDATE();
PRINT ‘>>Load Duration: ’+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ‘ seconds’;
PRINT ‘>>-----------------------------------’;
SET @ batch_end_time=GETDATE();
PRINT ‘==========================’;
PRINT ‘Loading Bronze Layer is Completed’;
PRINT ‘   - Total Load Duration: ’+ CAST(DATEDIFF(second, @batch_start_time,@batch_end_time) AS NVARCHAR) + ‘ seconds’;
PRINT ‘==========================’;
END TRY
BEGIN CATCH
Print ‘==========================’;
Print ‘ERROR OCCURRED DURING LOADING BRONZE LAYER’
Print ‘Error Message’ + ERROR_MESSAGE();
Print ‘Error Message’ + CAST(ERROR_NUMBER() AS NVARCHAR);
Print ‘Error Message’ + CAST(ERROR_STATE() AS NVARCHAR);
Print ‘==========================’;
END CATCH
END
