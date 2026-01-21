#Understand raw demand velocity or how fast the product moves
SELECT
    product_id,
    product_name,
    CAST(order_date AS DATE) AS sale_date,
    SUM(quantity) AS units_sold
FROM superstore_sales
GROUP BY product_id, product_name, CAST(order_date AS DATE)
ORDER BY sale_date, units_sold DESC;

#Spot seasonality and demand patterns.
SELECT
    product_id,
    product_name,
    DATE_TRUNC('month', order_date) AS month,
    SUM(quantity) AS monthly_units_sold
FROM superstore_sales
GROUP BY product_id, product_name, DATE_TRUNC('month', order_date)
ORDER BY month;

#Inventory priority logic.
SELECT
    product_id,
    product_name,
    SUM(quantity) AS total_units_sold,
    RANK() OVER (ORDER BY SUM(quantity) DESC) AS demand_rank
FROM superstore_sales
GROUP BY product_id, product_name;

#Business-level decisions.
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

#Smooth demand → inventory planning.
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

