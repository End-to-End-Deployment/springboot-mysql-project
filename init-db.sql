-- Create the database
CREATE DATABASE IF NOT EXISTS springbootdb;

-- Create a user with all privileges on the new database
CREATE USER 'opstree'@'%' IDENTIFIED BY 'Opstree@123';
GRANT ALL PRIVILEGES ON springbootdb.* TO 'opstree'@'%';

-- Flush privileges to ensure that they are saved and available
FLUSH PRIVILEGES;

