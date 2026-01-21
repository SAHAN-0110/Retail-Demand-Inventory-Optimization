#Daily Demand per Product
SELECT
    product_id,
    product_name,
    CAST(order_date AS DATE) AS sale_date,
    SUM(quantity) AS units_sold
FROM superstore_sales
GROUP BY product_id, product_name, CAST(order_date AS DATE)
ORDER BY sale_date, units_sold DESC;

#Monthly Demand Trend
SELECT
    product_id,
    product_name,
    DATE_TRUNC('month', order_date) AS month,
    SUM(quantity) AS monthly_units_sold
FROM superstore_sales
GROUP BY product_id, product_name, DATE_TRUNC('month', order_date)
ORDER BY month;

#Fast-Moving vs Slow-Moving Products
SELECT
    product_id,
    product_name,
    SUM(quantity) AS total_units_sold,
    RANK() OVER (ORDER BY SUM(quantity) DESC) AS demand_rank
FROM superstore_sales
GROUP BY product_id, product_name;

#Category-Level Demand Contribution
SELECT
    category,
    SUM(quantity) AS total_units_sold,
    ROUND(
        100.0 * SUM(quantity) /
        SUM(SUM(quantity)) OVER (),
        2
    ) AS demand_percentage
FROM superstore_sales
GROUP BY category
ORDER BY total_units_sold DESC;

#7-Day Moving Average
SELECT
    product_id,
    product_name,
    CAST(order_date AS DATE) AS sale_date,
    SUM(quantity) AS daily_units_sold,
    AVG(SUM(quantity)) OVER (
        PARTITION BY product_id
        ORDER BY CAST(order_date AS DATE)
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7_days
FROM superstore_sales
GROUP BY product_id, product_name, CAST(order_date AS DATE);

