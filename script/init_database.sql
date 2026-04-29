/*
==============================================================
Create Database and Schemas
==============================================================
Script Purpose:
	This script creates a new database named 'DataWareHouse' after checking if it already exists.
	If this database exists, it is dropped and recreated. Additionally, the script setup 3 schemas
	'Bronze' , 'Silver' , 'Gold'.

Warning:
	Running this script will drop the entire 'DataWareHouse' database is it exists.
	All the data in the database will be permanently deleted. Proceed with caution
	and ensure you have proper backups before running this script.
	
*/

--switch to Master Database
USE MASTER;
GO

--Drop and recreate the database 'DataWareHouse'
IF EXISTS (SELECT 1 FROM sys.databases WHERE name= 'DataWareHouse')
BEGIN
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWareHouse;
END;
GO

--Create a new Database named DataWareHouse
CREATE DATABASE DataWareHouse;
GO

--Switch to newly created database
USE DataWareHouse;
GO

--Create Schemas

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO


