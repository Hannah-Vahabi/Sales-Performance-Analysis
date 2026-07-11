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
--
-- Note: the original CSV header row was mistakenly imported as a data
-- record (row 1). It's excluded in each query via a WHERE clause
-- (e.g. WHERE field8 != 'Category').
-- =====================================================================

-- 1. Overall KPIs: total orders, revenue, profit, margin, avg order value
SELECT
    COUNT(*) AS total_orders,
    SUM(field13) AS total_revenue,
    SUM(field14) AS total_profit,
    (SUM(field14)/SUM(field13)) * 100 AS profit_margin,
    SUM(field13) / COUNT(*) AS avg_order_value
FROM product_sales_dataset_final;


-- 2. Profitability by category (identifies profit drivers)
SELECT
    field8,
    SUM(field13) AS total_revenue,
    SUM(field14) AS total_profit,
    ROUND((SUM(field14)/SUM(field13)) * 100, 2) AS profit_margin
FROM product_sales_dataset_final
WHERE field8 != 'Category'
GROUP BY field8
ORDER BY total_revenue DESC;


-- 3. Top 20 products by total profit
SELECT
    field8 AS category,
    field10 AS product_name,
    SUM(field11) AS total_quantity,
    SUM(field13) AS total_revenue,
    SUM(field14) AS total_profit,
    ROUND((SUM(field14)/SUM(field13)) * 100, 2) AS profit_margin
FROM product_sales_dataset_final
WHERE field10 != 'Product_Name'
GROUP BY field10
ORDER BY total_profit DESC
LIMIT 20;


-- 4. Regional performance: orders, revenue, profit, margin by region
SELECT
    field6 AS region,
    COUNT(*) AS total_order,
    SUM(field13) AS total_revenue,
    SUM(field14) AS total_profit,
    ROUND((SUM(field14)/SUM(field13)) * 100, 2) AS profit_margin
FROM product_sales_dataset_final
WHERE field6 != 'Region'
GROUP BY field6
ORDER BY total_revenue DESC;


-- 5. Monthly sales & profit trend
SELECT
    SUBSTR(field2, 1, 2) || '_' || SUBSTR(field2, 7, 2) AS month_year,
    COUNT(*) AS total_order,
    SUM(field13) AS total_revenue,
    SUM(field14) AS total_profit,
    ROUND((SUM(field14)/SUM(field13)) * 100, 2) AS profit_margin
FROM product_sales_dataset_final
WHERE field2 != 'Order_Date'
GROUP BY month_year
ORDER BY SUBSTR(field2, 7, 2), SUBSTR(field2, 1, 2);


-- 6. Top 10 customers by total profit
SELECT
    field3 AS customer_name,
    COUNT(*) AS total_order,
    SUM(field13) AS total_revenue,
    SUM(field14) AS total_profit,
    ROUND((SUM(field14)/SUM(field13)) * 100, 2) AS profit_margin
FROM product_sales_dataset_final
WHERE field3 != 'Customer_Name'
GROUP BY field3
ORDER BY total_profit DESC
LIMIT 10;


-- 7. Underperforming products: profit margin below 15%
SELECT
    field10 AS product_name,
    SUM(field13) AS total_revenue,
    SUM(field14) AS total_profit,
    ROUND((SUM(field14)/SUM(field13)) * 100, 2) AS profit_margin
FROM product_sales_dataset_final
GROUP BY field10
HAVING profit_margin < 15
ORDER BY profit_margin ASC;


-- 8. Order size distribution: revenue & avg order value by quantity bucket
SELECT
    CASE
        WHEN CAST(field11 AS INTEGER) = 1 THEN '1 unit'
        WHEN CAST(field11 AS INTEGER) BETWEEN 2 AND 3 THEN '2-3 units'
        WHEN CAST(field11 AS INTEGER) BETWEEN 4 AND 5 THEN '4-5 units'
        ELSE '6+ units'
    END AS quantity_bucket,
    COUNT(*) AS total_orders,
    ROUND(SUM(field13), 2) AS total_revenue,
    ROUND(AVG(field13), 2) AS avg_order_value
FROM product_sales_dataset_final
WHERE field11 != 'Quantity'
GROUP BY quantity_bucket
ORDER BY total_orders DESC;
