/*
***************************************************
Create Datbase and Schemas
***************************************************
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists.

Warning:
    Running this script will drop the entire 'DataWarehouse'database if it exists.
*/

USE master;
GO
----Drop and recreate your database 'DataWarehouse' inside system database and use it
IF EXISTS (SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO
----create the database 'DataWarehouse'    
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

----Creating Schemas
Create SCHEMA bronze;
Go
Create SCHEMA silver;
Go
Create SCHEMA gold;
Go
