-- =====================================================================
-- File: 01_Export_Data_Setup.sql
-- Author: Vaibhav
-- Objective: Provision GlobalTrade_Analytics DB and insert baseline data
-- =====================================================================

USE master;
GO

IF DB_ID('GlobalTrade_Analytics') IS NOT NULL
BEGIN
    ALTER DATABASE GlobalTrade_Analytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE GlobalTrade_Analytics;
END
CREATE DATABASE GlobalTrade_Analytics;
GO

USE GlobalTrade_Analytics;
GO

-- Create Schema
CREATE SCHEMA Trade;
GO

-- Create Tables
CREATE TABLE Trade.Clients (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

CREATE TABLE Trade.Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CertificationType VARCHAR(50)
);

CREATE TABLE Trade.Shipments (
    ShipmentID BIGINT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT FOREIGN KEY REFERENCES Trade.Clients(ClientID),
    ProductID INT FOREIGN KEY REFERENCES Trade.Products(ProductID),
    ShipmentDate DATE,
    MetricTons DECIMAL(10,2),
    ContractValue DECIMAL(18,2),
    Incoterms VARCHAR(10), -- e.g., FOB, CIF
    ShipmentStatus VARCHAR(20)
);
GO

-- Insert Seed Data
INSERT INTO Trade.Clients (CompanyName, Country) VALUES 
('Berlin Organics GMBH', 'Germany'), ('Munich Trade Co', 'Germany'), 
('UK Natural Foods', 'United Kingdom'), ('Dubai Agro Importers', 'UAE');

INSERT INTO Trade.Products (ProductName, CertificationType) VALUES 
('Organic Jaggery Powder', 'NPOP'), ('Organic Jaggery Cubes', 'NPOP'), 
('Organic Liquid Jaggery', 'NPOP'), ('Jaggery Blocks', 'Standard');

-- Insert 40 Random Export Shipments
DECLARE @i INT = 1;
WHILE @i <= 40
BEGIN
    INSERT INTO Trade.Shipments (ClientID, ProductID, ShipmentDate, MetricTons, ContractValue, Incoterms, ShipmentStatus)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 4) + 1,
        (ABS(CHECKSUM(NEWID())) % 4) + 1,
        DATEADD(DAY, -(ABS(CHECKSUM(NEWID()) % 365)), GETDATE()),
        CAST((RAND() * 20) + 1 AS DECIMAL(10,2)), -- 1 to 21 Metric Tons
        CAST((RAND() * 15000) + 5000 AS DECIMAL(18,2)), 
        CASE WHEN @i % 3 = 0 THEN 'CIF' ELSE 'FOB' END,
        CASE WHEN @i % 8 = 0 THEN 'Shipped' ELSE 'Delivered' END
    );
    SET @i = @i + 1;
END;
GO

