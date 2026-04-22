/*
 ==========================================================================
 Create Database and Schemas
 ==========================================================================
 
 Script Purpose:
 This script is for creating a new database called 'DataWarhouse' after checking the same name exists.
 If there is it, it will drop first and recreate a new database as it's mention. Moreover the scripts also include
 creating schemas called Bronze, Silver and Gold.
 
 Warning:
 Running this script will drop the entire database if it exists. So be cautious if there is same database name as
 in the scripts and back up before running anything.
 
 */
USE master;

GO
    -- Drop and create the 'DataWarehouse' database
    IF EXISTS (
        SELECT
            1
        FROM
            sys.databases
        WHERE
            name = 'DataWarehouse'
    ) BEGIN ALTER DATABASE DataWarehouse
SET
    SINGLE_USER WITH ROLLBACK IMMEDIATE;

DROP DATABASE DataWarehouse;

END;

GO
    -- Create the 'DataWarehouse' database
    CREATE DATABASE DataWarehouse;

GO
    USE DataWarehouse;

GO
    -- Create Schemas
    CREATE SCHEMA Bronze;

GO
    CREATE SCHEMA Silver;

GO
    CREATE SCHEMA Gold;

GO