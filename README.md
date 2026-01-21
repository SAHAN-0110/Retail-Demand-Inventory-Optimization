# Retail Demand & Inventory Optimization Analysis

## Project Overview
Efficient inventory management is critical for retail businesses to balance customer demand and operational costs. This project analyzes retail sales and inventory data to identify demand patterns, inventory risks, and opportunities to optimize stock levels and improve business decision-making.

The analysis focuses on understanding product demand, detecting overstock and stockout risks, and generating actionable insights using SQL and business logic.

---

## Business Objectives
- Analyze product demand across time and categories
- Identify fast-moving and slow-moving products
- Detect potential stockout and overstock situations
- Improve inventory turnover and cash flow efficiency
- Support data-driven inventory planning decisions

---

## Dataset Description
The project uses structured retail data consisting of two primary tables:

### Sales Data
- `date`
- `store_id`
- `product_id`
- `category`
- `units_sold`
- `unit_price`

### Inventory Data
- `store_id`
- `product_id`
- `stock_on_hand`
- `reorder_level`
- `last_restock_date`

The dataset reflects real-world retail scenarios with realistic demand variations and inventory constraints.

---

## Tools & Technologies
- SQL (CTEs, joins, window functions)
- Python (Pandas, Matplotlib – optional)
- Power BI / Tableau (optional)
- Git & GitHub

---

## Key Analyses
- Daily, weekly, and monthly demand trends
- Inventory turnover calculation
- Fast-moving vs slow-moving product identification
- Stockout risk analysis based on demand and available stock
- Category-level performance analysis


---

## Key Insights
- Products with high demand and low reorder frequency pose a significant stockout risk
- Certain categories contribute to low inventory turnover and increased holding costs
- Demand patterns reveal seasonality that should influence reorder planning
- Optimized inventory levels can reduce excess stock without impacting sales
- Inventory risk was estimated using demand velocity due to the absence of direct inventory tables, reflecting real-world data limitations

---

## Outcome
This project demonstrates the ability to:
- Perform business-focused data analysis using SQL
- Translate analytical results into actionable business insights
- Apply inventory optimization concepts to real-world retail data

---

## Future Enhancements
- Demand forecasting using time-series models
- Automated inventory alerts for stockout and overstock risks
- Interactive dashboards for real-time inventory monitoring
