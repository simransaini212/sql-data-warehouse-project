/*
=============================================================================================
Stored procedure: Load Bronze Layer (Source -> Bronze)
=============================================================================================
Script purpose:	
	This Stored Procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following:
		- Truncate the Bronze tables before loading the data.
		- Use the `BULK INSERT` command to load data from csv files to bronze tables.
		
Parameters:
	None.
	This stored procedure does not accept any parameter or return any values.

Usage Example:
	EXEC bronze.load_bronze;
=============================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
-- Declaring variables to calculate the time taken by tables to load
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	BEGIN TRY
	SET @batch_start_time= GETDATE();
		PRINT'==========================================================';
		PRINT'LOADING BRONZE LAYER';
		PRINT'==========================================================';

		PRINT'----------------------------------------------------------';
		PRINT'LOADING CRM TABLES';
		PRINT'----------------------------------------------------------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cst_info;
		print'>> Inserting Data into : bronze.crm_cst_info';
		BULK INSERT bronze.crm_cst_info
		FROM 'C:\Users\RushiGawande\OneDrive\Desktop\Simran\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH( 
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		print '---------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		print'>> Inserting Data into : bronze.crm_cst_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\RushiGawande\OneDrive\Desktop\Simran\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH( 
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		print '---------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		print'>> Inserting Data into : bronze.crm_cst_info'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\RushiGawande\OneDrive\Desktop\Simran\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH( 
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		print '---------';

		PRINT'----------------------------------------------------------';
		PRINT'LOADING ERP TABLES';
		PRINT'----------------------------------------------------------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		print'>> Inserting Data into : bronze.crm_cst_info'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\RushiGawande\OneDrive\Desktop\Simran\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
		WITH( 
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		print '---------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		print'>> Inserting Data into : bronze.crm_cst_info'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\RushiGawande\OneDrive\Desktop\Simran\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
		WITH( 
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		print '---------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		print'>> Inserting Data into : bronze.crm_cst_info'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\RushiGawande\OneDrive\Desktop\Simran\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
		WITH( 
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		print '---------';

		SET @batch_end_time = GETDATE();
		PRINT '>> Loading Bronze Layer is Completed ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		print '---------';
	END TRY
	BEGIN CATCH
		PRINT '=============================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE ' +	ERROR_MESSAGE();
		PRINT 'ERROR NUMBER ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT '=============================================';
	
	END CATCH
END


