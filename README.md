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
2. **Category profitability** — revenue, profit, and margin by product category, to identify profit drivers
3. **Product analysis** — top 20 products by total profit
4. **Regional analysis** — orders, revenue, profit, and margin by region
5. **Trend analysis** — monthly revenue and profit trends
6. **Customer analysis** — top 10 customers by total profit
7. **Underperforming products** — products with profit margin below 15%
8. **Order size analysis** — revenue and average order value by quantity bucket

Note: the original CSV header row was mistakenly imported into the table as a data record. This was identified as a data quality issue and excluded from all queries above.

## Key Findings

**Overall performance**
- Total orders: 200,000+
- Total revenue: $142.4M
- Total profit: $31.5M
- Overall profit margin: 22.2%
- Average order value: $712

**Category profitability**
- Electronics generates the highest revenue ($57.5M) but the lowest profit margin (14.0%)
- Accessories generates the lowest revenue ($10.1M) but the highest profit margin (34.0%)
- Clothing & Apparel (32.5%) and Home & Furniture (23.5%) also outperform Electronics on margin

**Underperforming products**
- All 14 products with a profit margin under 15% belong to the Electronics category (e.g. Dell XPS 13, MacBook Air, Apple Watch, iPhone 14, Samsung Galaxy S23)
- These 14 products alone account for ~$50.7M in revenue — roughly 36% of total company revenue — at consistently thin margins, making Electronics pricing/cost review the top opportunity for margin improvement

**Regional performance**
- East region drives the highest order volume and revenue ($44.98M) but has the lowest margin (20.5%)
- South region has the lowest volume but the highest margin (23.58%), followed by West (22.94%) and Centre (22.43%)

**Seasonality & trend**
- November is the peak sales month in both years (~18,900–19,500 orders vs. ~6,000 in a typical month)
- Q4 (Oct–Dec) alone accounts for ~46% of annual order volume, consistent with a holiday/Black Friday shopping pattern
- February is consistently the slowest month in both years
- Profit margin stays remarkably stable (21.9%–22.4%) across all 24 months regardless of volume swings
- Revenue grew modestly year-over-year: ~$70.8M (2023) to ~$71.7M (2024), +1.3%

**Order size analysis**
- Orders of 2–3 units are the revenue "sweet spot": 40% of orders generate 51% of total revenue
- Single-unit orders make up over half of all orders (50.7%) but only 27% of revenue, with the lowest average order value ($381.65)
- Average order value scales with quantity purchased, from $381.65 (1 unit) up to $2,486.88 (6+ units)

**Top products & customers**
- Tempur-Pedic Mattress is the single highest-profit product ($2.13M)
- Top 10 customers by profit are all repeat buyers (43–102 orders each), indicating a meaningful loyal-customer contribution to profit

## Recommendations

- Review pricing and supplier costs for Electronics, the category driving the most revenue but the weakest margins
- Prioritize inventory and marketing investment ahead of Q4, particularly November, given its outsized share of annual volume
- Investigate why the East region underperforms on margin despite leading on volume, and apply South/West region practices where relevant

## File

- [`sales_performance_analysis.sql`](./sales_performance_analysis.sql) — all queries used in this analysis
