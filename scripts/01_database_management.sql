-- Remove the database if it already exists
DROP DATABASE IF EXISTS licensing_management;

-- Create the database
CREATE DATABASE licensing_management
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Select the database
USE licensing_management;

-- Change database collation
ALTER DATABASE licensing_management
COLLATE utf8mb4_unicode_ci;

-- Verify database creation
SHOW DATABASES;