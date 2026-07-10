-- =====================================================================
-- Sales Performance & Profitability Trend Analysis
-- Dataset: product_sales_dataset_final (SQLite)
-- Author: Hannah Vahabi
-- =====================================================================
-- Schema reference:
-- field1  = Order_ID
-- field2  = Order_Date   (format: MM-DD-YY)
-- field3  = Customer_Name
-- field4  = City
-- field5  = State
-- field6  = Region
-- field7  = Country
-- field8  = Category
-- field9  = Sub_Category
-- field10 = Product_Name
-- field11 = Quantity
-- field12 = Unit_Price
-- field13 = Revenue
-- field14 = Profit
-- =====================================================================

-- 1. Overall summary: total orders, revenue, profit, margin, avg order value
SELECT
  count(*) AS total_order,
  SUM(field13) AS total_revenue,
  SUM(field14) AS total_profit,
  (SUM(field14)/SUM(field13)) * 100 AS profit_margin,
  SUM(field13) / COUNT(*) AS avg_order_value
FROM product_sales_dataset_final;


-- 2. Data quality check: confirms the CSV header row was mistakenly
--    imported as an actual data record (row 1). This row is excluded
--    from all subsequent queries via "WHERE field1 <> 'Order_ID'".
SELECT * FROM product_sales_dataset_final WHERE field1 = 'Order_ID';


-- 3. Monthly revenue & profit trend
SELECT
  substr(field2, 7, 2) AS year,
  substr(field2, 1, 2) AS month,
  SUM(CAST(field13 AS REAL)) AS total_revenue,
  SUM(CAST(field14 AS REAL)) AS total_profit
FROM product_sales_dataset_final
WHERE field1 <> 'Order_ID'
GROUP BY year, month
ORDER BY year, month;


-- 4. Profit margin by product category (identifies profitability drivers)
SELECT
  field8 AS category,
  SUM(CAST(field13 AS REAL)) AS total_revenue,
  SUM(CAST(field14 AS REAL)) AS total_profit,
  ROUND(SUM(CAST(field14 AS REAL)) / SUM(CAST(field13 AS REAL)) * 100, 2) AS profit_margin_pct
FROM product_sales_dataset_final
WHERE field1 <> 'Order_ID'
GROUP BY field8
ORDER BY profit_margin_pct DESC;


-- 5. Revenue & profit by region
SELECT
  field6 AS region,
  SUM(CAST(field13 AS REAL)) AS total_revenue,
  SUM(CAST(field14 AS REAL)) AS total_profit
FROM product_sales_dataset_final
WHERE field1 <> 'Order_ID'
GROUP BY field6
ORDER BY total_revenue DESC;


-- 6. Top 10 products by total profit
SELECT
  field10 AS product_name,
  SUM(CAST(field14 AS REAL)) AS total_profit
FROM product_sales_dataset_final
WHERE field1 <> 'Order_ID'
GROUP BY field10
ORDER BY total_profit DESC
LIMIT 10;
