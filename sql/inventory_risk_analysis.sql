#Average Daily Demand per Product
WITH daily_sales AS (
    SELECT
        product_id,
        CAST(order_date AS DATE) AS sale_date,
        SUM(quantity) AS units_sold
    FROM superstore_sales
    GROUP BY product_id, CAST(order_date AS DATE)
)
SELECT
    product_id,
    ROUND(AVG(units_sold), 2) AS avg_daily_demand
FROM daily_sales
GROUP BY product_id;

#Join Demand with Inventory Levels.
WITH avg_demand AS (
    SELECT
        product_id,
        ROUND(AVG(quantity), 2) AS avg_daily_demand
    FROM superstore_sales
    GROUP BY product_id
)
SELECT
    i.product_id,
    i.inventory_level,
    i.reorder_point,
    d.avg_daily_demand
FROM retail_inventory i
JOIN avg_demand d
    ON i.product_id = d.product_id;

#Stockout Risk Flag
WITH avg_demand AS (
    SELECT
        product_id,
        ROUND(AVG(quantity), 2) AS avg_daily_demand
    FROM superstore_sales
    GROUP BY product_id
)
SELECT
    i.product_id,
    i.inventory_level,
    d.avg_daily_demand,
    CASE
        WHEN i.inventory_level < d.avg_daily_demand * 7
        THEN 'HIGH_STOCKOUT_RISK'
        ELSE 'LOW_RISK'
    END AS stockout_risk
FROM retail_inventory i
JOIN avg_demand d
    ON i.product_id = d.product_id;

#Overstock Risk Detection
WITH avg_demand AS (
    SELECT
        product_id,
        ROUND(AVG(quantity), 2) AS avg_daily_demand
    FROM superstore_sales
    GROUP BY product_id
)
SELECT
    i.product_id,
    i.inventory_level,
    d.avg_daily_demand,
    CASE
        WHEN i.inventory_level > d.avg_daily_demand * 30
        THEN 'OVERSTOCK_RISK'
        ELSE 'NORMAL'
    END AS inventory_status
FROM retail_inventory i
JOIN avg_demand d
    ON i.product_id = d.product_id;

#Priority Ranking
WITH avg_demand AS (
    SELECT
        product_id,
        ROUND(AVG(quantity), 2) AS avg_daily_demand
    FROM superstore_sales
    GROUP BY product_id
)
SELECT
    i.product_id,
    i.inventory_level,
    d.avg_daily_demand,
    (d.avg_daily_demand * 7 - i.inventory_level) AS urgency_score
FROM retail_inventory i
JOIN avg_demand d
    ON i.product_id = d.product_id
ORDER BY urgency_score DESC;
