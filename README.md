# Sales KPI Dashboard (Portfolio Project)

## Overview
This project demonstrates an end-to-end analytics workflow: cleaning and transforming data, writing SQL to generate business-ready metrics, and building a dashboard to communicate performance trends and drivers.

## Business Problem
A retail business wants a clear view of sales performance and profitability across time and key dimensions. The goal is to answer:
- Are revenue and profit trending up or down over time?
- Which product categories drive revenue and profit?
- Which products contribute the most to revenue?
- Which regions are generating the most revenue?

## Dashboard
View the interactive dashboard here: (https://lookerstudio.google.com/reporting/e1dc8358-f7b6-4b0f-90e6-aa6fdfc50109)
Executive summary: [docs/project1_executive_summary.md](docs/project1_executive_summary.md)


## Key Metrics
- Total Revenue
- Total Profit
- Profit Margin (%)
- Revenue by Month (trend)
- Revenue by Category
- Top 10 Products by Revenue
- Revenue by Region
- Total Revenue
- Total Profit
- Profit Margin (%)
- Revenue by Month (trend)
- Revenue by Category
- Top 10 Products by Revenue
- Revenue by Region

## Data
The dataset is a simulated retail sales dataset provided in CSV format and structured to reflect a real business model:
- Orders (fact table)
- Products (dimension)
- Customers (dimension)
- Returns (optional fact table)

## Tools Used
- **SQL (DuckDB)**: querying CSVs, joining tables, and generating aggregated outputs (monthly, category, product, region)
- **GitHub Codespaces**: cloud development environment to run SQL/Python and store deliverables
- **Google Sheets**: importing curated output tables for reporting
- **Looker Studio**: building and publishing the dashboard

## Method (What I Did)
1. Loaded CSV data into a SQL workflow (DuckDB) and validated fields.
2. Wrote SQL queries to calculate revenue, cost, and profit using:
   - Revenue = quantity * unit_price * (1 - discount_pct)
   - Cost = quantity * unit_cost
   - Profit = Revenue - Cost
   - Profit Margin = Profit / Revenue
3. Exported dashboard-ready summary tables:
   - Monthly revenue
   - Revenue/profit by category
   - Top products by revenue
   - Revenue by region
4. Built a one-page dashboard in Looker Studio and published it for viewing.

## Repository Structure
- `data/` — source CSV files  
- `sql/` — SQL queries (week 1 practice + dashboard table generation)  
- `scripts/` — helper scripts to run SQL and export outputs  
- `outputs/` — query results and dashboard-ready tables  
- `docs/` — executive summary and images (optional)

## Next Improvements
- Add global filters (region/category) using a master fact table or blended data.
- Add return rate and discount impact visuals.
- Add a short executive summary with recommendations based on the results.
