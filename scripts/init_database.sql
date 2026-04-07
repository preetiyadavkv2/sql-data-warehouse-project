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
----Drop and Create your database inside system database and use it
IF EXISTS (SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN
  
CREATE DATABASE DataWarehouse;
USE DataWarehouse;
----Start creating schemas it is like folder, so start creating schemas for all layers (bronze, silver, gold)
Create SCHEMA bronze;
Go
Create SCHEMA silver;
Go
Create SCHEMA gold;
Go
