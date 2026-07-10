# Sales Performance & Profitability Trend Analysis

A SQL-based analysis of a US retail sales dataset (200,000+ transactions), exploring profitability, sales trends, and regional/product performance drivers using SQLite.

## Objective

Analyze product sales data to uncover profitability gaps across products, regions, and time periods, and generate insights to support pricing and regional investment decisions.

## Tools

- SQL (SQLite)
- DB Browser for SQLite

## Dataset

Sourced from Kaggle: [Product Sales Dataset 2023–2024](https://www.kaggle.com/datasets/yashyennewar/product-sales-dataset-2023-2024)

`product_sales_dataset_final` — 200,000+ retail transaction records with the following fields:

| Column | Description |
|---|---|
| Order_ID | Unique order identifier |
| Order_Date | Date of order (MM-DD-YY) |
| Customer_Name | Customer name |
| City / State / Region / Country | Customer location |
| Category / Sub_Category / Product_Name | Product hierarchy |
| Quantity | Units sold |
| Unit_Price | Price per unit |
| Revenue | Total order revenue |
| Profit | Total order profit |

## Analysis Performed

1. **Overall KPIs** — total orders, revenue, profit, profit margin, and average order value
2. **Data quality check** — identified and excluded a header row that was mistakenly imported as a data record
3. **Trend analysis** — monthly revenue and profit trends
4. **Driver analysis** — profit margin by product category, to identify high- and low-margin categories
5. **Regional analysis** — revenue and profit performance by region
6. **Product analysis** — top 10 products by total profit

## Key Findings

*(To be filled in once all queries are run — see `sales_performance_analysis.sql`)*

- Total orders: 200,000+
- Total revenue: ~$142.4M
- Total profit: ~$31.5M
- Overall profit margin: ~22.2%
- Average order value: ~$712

## File

- [`sales_performance_analysis.sql`](./sales_performance_analysis.sql) — all queries used in this analysis
