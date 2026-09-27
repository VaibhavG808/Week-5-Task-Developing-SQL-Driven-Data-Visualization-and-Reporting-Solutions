# Week-5-Task-Developing-SQL-Driven-Data-Visualization-and-Reporting-Solutions
# SQL-Driven Data Visualization & Global Trade Analytics

## 📌 Project Overview
This project demonstrates the bridging of raw SQL data extraction with business intelligence (BI) visualization. Using a custom-built international trade database (`GlobalTrade_Analytics`), this project extracts critical supply chain KPIs—such as commodity export volumes, international market penetration, and logistical liability (Incoterms)—and translates them into strategic, executive-level reports.

## 🛠️ Technology Stack
* **Database:** Microsoft SQL Server 2022
* **Language:** T-SQL
* **Visualization:** [Insert Tool Used, e.g., Microsoft Excel / Power BI]
* **Techniques:** Data Aggregation, Temporal Analysis, Schema Joins, Visual Storytelling

## 🗂️ Repository Structure
| File | Description |
| :--- | :--- |
| `01_Export_Data_Setup.sql` | DDL and DML scripts to provision the database and seed realistic international trade records. |
| `02_BI_Reporting_Queries.sql` | Aggregation queries designed to extract the 4 primary business KPIs. |
| `Export_Analytics_Reporting_Solutions.docx` | Comprehensive documentation linking the SQL logic to the visual output, including design rationale. |

## 🚀 Key Performance Indicators (KPIs) Extracted
1. **Commodity Export Volume:** Aggregated metric tonnage and gross revenue by agricultural product category.
2. **Monthly Revenue Velocity:** Temporal aggregation grouping shipments by Year and Month to establish growth trends.
3. **Top International Markets:** Join logic mapping shipment values to destination countries to identify market share.
4. **Shipping Incoterm Distribution:** Categorical grouping of FOB vs. CIF contracts to assess logistical liability.

---
**Author:** Vaibhav
