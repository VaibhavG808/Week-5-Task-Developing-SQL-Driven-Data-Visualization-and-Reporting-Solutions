-- =====================================================================
-- File: 02_BI_Reporting_Queries.sql
-- Author: Vaibhav
-- Objective: Extract optimized KPIs for BI Reporting
-- =====================================================================

USE GlobalTrade_Analytics;
GO

-- KPI 1: Export Volume & Revenue by Product Category
SELECT 
    p.ProductName,
    SUM(s.MetricTons) AS TotalVolume_MT,
    SUM(s.ContractValue) AS GrossRevenue
FROM Trade.Shipments s
INNER JOIN Trade.Products p ON s.ProductID = p.ProductID
WHERE s.ShipmentStatus = 'Delivered'
GROUP BY p.ProductName
ORDER BY GrossRevenue DESC;
GO

-- KPI 2: Monthly Export Revenue Trend
SELECT 
    YEAR(ShipmentDate) AS ExportYear,
    MONTH(ShipmentDate) AS ExportMonth,
    SUM(ContractValue) AS MonthlyRevenue
FROM Trade.Shipments
WHERE ShipmentStatus IN ('Shipped', 'Delivered')
GROUP BY YEAR(ShipmentDate), MONTH(ShipmentDate)
ORDER BY ExportYear ASC, ExportMonth ASC;
GO

-- KPI 3: Top International Markets
SELECT TOP 5
    c.Country,
    COUNT(s.ShipmentID) AS TotalShipments,
    SUM(s.ContractValue) AS TotalMarketValue
FROM Trade.Shipments s
INNER JOIN Trade.Clients c ON s.ClientID = c.ClientID
WHERE s.ShipmentStatus = 'Delivered'
GROUP BY c.Country
ORDER BY TotalMarketValue DESC;
GO

-- KPI 4: Shipping Incoterm Distribution (Logistics Risk)
SELECT 
    Incoterms,
    COUNT(ShipmentID) AS ContractCount,
    SUM(ContractValue) AS TotalLiabilityValue
FROM Trade.Shipments
GROUP BY Incoterms;
GO