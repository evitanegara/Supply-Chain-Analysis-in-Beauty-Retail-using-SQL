# Supply Chain Analysis in Beauty Retail using SQL

## Project Overview
This project focuses on analyzing the end-to-end performance of a beauty and personal care product supply chain using SQL. The dataset includes transactional records of sales, suppliers, products, shipping carriers, transportation modes, stock levels, quality inspections, and customer demographics.Using advanced SQL queries, this project uncovers trends across product revenue, shipping efficiency, supplier reliability, and customer behavior. The insights are designed to support data-driven decisions across pricing, production planning, inventory optimization, and supplier segmentation in the personal care industry.

## Dataset Overview

The dataset is organized in a single wide-format table named `supplychain`, encompassing 26 columns related to products, inventory, logistics, sales, and customer attributes.

| Table Name   | Description                                                                 |
|--------------|-----------------------------------------------------------------------------|
| supplychain  | SKU, product_type, price, availability, number_of_products_sold, revenue_generated, supplier_name, order_quantities, stock_levels, production_volumes, shipping_carriers, routes, transportation_modes, shipping_costs, shipping_times, inspection_results, customer_gender, and other supply chain performance indicators |


##   Executive Summary
This SQL based analysis uncovers key insights across sales, shipping logistics, supplier quality, and stock movement in the beauty product industry. Skincare leads in revenue, driven by high unit sales, while cosmetics command the highest unit price. Supplier 1 emerges as the top contributor across revenue, product variety, and order volume, while Supplier 3 is notable for having more products sold than produced—indicating strong demand or tight inventory. Logistically, Route A with Carrier A is the most cost-effective combination, and rail is the dominant transport mode in terms of delivery volume. Quality inspection reveals Supplier 4’s high failure rate and Supplier 3’s delay in quality clearance, signaling risk. The data also highlights a potential gender data quality issue, with “Unknown” customers contributing the most revenue. These insights point toward opportunities in inventory optimization, supplier segmentation, and improved delivery planning, enabling more efficient operations and targeted product strategies.


## Insights Deep-Dive (Sales Performance)
### Revenue, Volume, and Pricing by Product Type
- Skincare leads in total revenue with over 241,000, driven by a high sales volume of 20,731 units despite a moderate average price of 47.26.
- Haircare ranks second with 174,000 in revenue from 13,611 units sold at an average price of 46.01, reflecting steady demand.
- Cosmetics, though priced highest at an average of 57.36, ranks third in revenue (161,000) due to lower volume (11,757 units).
- This suggests that premium pricing in Cosmetics may limit unit sales, while Skincare benefits from a high-volume, mid-priced strategy.
 ```sql
SELECT 
    Product_type,
    SUM(Revenue_generated) AS Total_Revenue,
    SUM(Number_of_products_sold) AS Total_Units_Sold,
    ROUND(AVG(Price), 2) AS Avg_Selling_Price
FROM dbo.supplychain
GROUP BY Product_type
ORDER BY Total_Revenue DESC;
```

### Top 10 SKUs by Revenue
- Leading SKUs include SKU51 (Haircare) and SKU38 (Cosmetics), both supplied by Supplier 5, indicating strong supplier performance.
- Supplier 5 contributes two top-performing SKUs with combined revenue exceeding 19,500.
- Haircare and Skincare dominate the top 10 list, accounting for 8 of 10 SKUs, pointing to consistent market demand in these categories.
- SKU31 stands out with high revenue (9,655.14) from just 168 units sold, suggesting high pricing or strong profit margins.

  ```sql
SELECT TOP 10
    SKU,
    Product_type,
    Supplier_name,
    SUM(Revenue_generated) AS Total_Revenue,
    SUM(Number_of_products_sold) AS Total_Units_Sold
FROM dbo.supplychain
GROUP BY SKU, Product_type, Supplier_name
ORDER BY Total_Revenue DESC;
```

### Revenue by Supplier
- Supplier 1 generates the highest revenue at 157,529, followed by Supplier 2 (125,467) and Supplier 5 (110,343).
- Supplier 4 underperforms at 86,468, despite a wide product range—potentially due to pricing strategy, turnover rates, or sales reach.
- These figures highlight the varying effectiveness of supplier performance and may support renegotiation or reallocation of supply partnerships.
  ```sql
SELECT
    Supplier_name,
    SUM(Revenue_generated) AS Total_Revenue
FROM dbo.supplychain
GROUP BY Supplier_name
ORDER BY Total_Revenue DESC;
```
### Best-Selling Product Type by Supplier
- Supplier 1 and Supplier 3 derive most of their revenue from Skincare, indicating specialization in this high-volume category.
- Supplier 2 and Supplier 4 generate the bulk of their sales through Haircare products.
- Supplier 5 performs strongest in Cosmetics, possibly reflecting niche strength or premium market positioning.
- This distribution supports the use of supplier-specific segmentation strategies for optimized marketing, procurement, and logistics.

 ```sql
WITH ProductRevenue AS (
	SELECT 
        Supplier_name,
        Product_type,
        SUM(Revenue_generated) AS Total_Revenue,
        RANK() OVER (PARTITION BY Supplier_name ORDER BY SUM(Revenue_generated) DESC) AS rnk
    FROM dbo.supplychain
    GROUP BY Supplier_name, Product_type
)
SELECT 
    Supplier_name,
    Product_type,
    Total_Revenue
FROM ProductRevenue
WHERE rnk = 1
ORDER BY Supplier_name;
```
### Revenue by Customer Demographic (Gender)
- "Unknown" gender customers contribute the most revenue (173,090), suggesting potential gaps in data collection or an increase in anonymous or guest checkouts.
- Female customers generate 161,514 in revenue, slightly ahead of Male customers at 126,634.
- Non-binary customers also show meaningful engagement with 116,365 in revenue, indicating inclusive product appeal.
- The demographic breakdown reveals opportunities to improve data capture while also validating diverse market engagement.
  
 ```sql
  SELECT 
  Customer_demographics AS Gender,
  SUM(Revenue_generated) AS Total_Revenue
FROM dbo.supplychain
GROUP BY Customer_demographics
ORDER BY Total_Revenue DESC;
```
  
## Insights Deep-Dive (Supply Chain)

###  SKU Distribution by Supplier and Product Type
- Supplier 1 offers the widest skincare assortment with 15 SKUs — the highest among all suppliers. It also provides strong coverage in cosmetics (7 SKUs) and haircare (5 SKUs).
- Supplier 2 leads in haircare SKU variety (10 SKUs, tied with Supplier 4) and also contributes 7 cosmetics SKUs and 5 skincare SKUs.
- Supplier 3 takes a focused approach, offering just 1 SKU in cosmetics, 5 in haircare, and 9 in skincare.
- Supplier 4 specializes in haircare (10 SKUs), but is limited in skincare and cosmetics with only 4 SKUs each.
- Supplier 5 maintains a moderate but balanced SKU diversity across all three categories.
  
  ```sql
SELECT 
  Supplier_name,
  Product_type,
  COUNT(DISTINCT SKU) AS Total_SKUs
FROM dbo.supplychain
GROUP BY Supplier_name, Product_type;
```
### Quality Inspection Results (Pass, Pending, Fail %)
- Supplier 4 recorded the highest failure rate at 66.67%, signaling major quality control concerns.
- Supplier 3 had the highest pending rate (66.67%), suggesting delays or bottlenecks in quality assessments.
- Supplier 1 achieved the highest pass rate (48.15%), indicating strong quality assurance practices.
- Supplier 5 reported the lowest pass rate (16.67%), reflecting weaker product compliance compared to peers.

  ```sql
SELECT 
  Supplier_name,
  Inspection_results,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Supplier_name), 2) AS Result_Percentage
FROM dbo.supplychain
GROUP BY Supplier_name, Inspection_results;
```
### Total Order Volume by Supplier
- Supplier 1 leads with the highest total order quantity (1,458 units), showing strong demand or preferred supplier status.
- Supplier 2 and Supplier 5 also perform well in order volume, reflecting consistent buyer engagement.
- Supplier 3, despite a relatively strong pass rate, receives the lowest total orders, suggesting lower demand or product availability.

  ```sql
SELECT 
    Supplier_name,
    SUM(Order_quantities) AS Total_Ordered_Quantity
FROM dbo.supplychain
GROUP BY Supplier_name
ORDER BY Total_Ordered_Quantity DESC;
```

### Average Stock Levels by Product Type
- Cosmetics maintain the highest average stock level (58 units), which could indicate overstocking or slower turnover rates.
- Haircare holds an average stock level of 48 units, balancing availability and demand.
- Skincare maintains the leanest inventory at 40 units on average, potentially due to higher sales velocity or tighter inventory management.

  ```sql
SELECT 
    Product_type,
    ROUND(AVG(Stock_levels), 2) AS Avg_Stock_Level
FROM dbo.supplychain
GROUP BY Product_type;
```
###  Production Quantity vs. Products Sold per Supplier
- Supplier 3 is the only supplier that sold more than it produced (Sales: 8,083 vs Production: 7,997), indicating potential stock clearance or backorders.
- Supplier 2 produced the highest volume (14,105) but sold only slightly more than Supplier 1, possibly pointing to overproduction or unsold inventory.
- Supplier 4 shows the widest gap between production (11,756) and sales (7,206), raising concerns around demand forecasting or excess stock.
- Supplier 5 maintains a healthy production-to-sales balance (Production: 9,381 vs Sales: 8,662), showing efficient supply alignment.
 ```sql
SELECT 
  Supplier_name,
  SUM(Production_volumes) AS Total_Produced,
  SUM(Number_of_products_sold) AS Total_Sold
FROM dbo.supplychain
GROUP BY Supplier_name;
```
## Insights Deep-Dive (Logistics)
### Most Cost-Effective Route & Carrier Combination
- The combination of Route A with Carrier A offers the lowest average shipping cost at 4.63 per unit, with a healthy total volume of 6,870 units.
- Carrier B on Route B is also highly efficient, delivering 8,907 units at a competitive cost of 5.17 per unit.
- In contrast, Carrier A on Route C has the highest average cost at 6.34 per unit with the lowest shipment volume, suggesting inefficiencies or expensive routing for that pair.
 ```sql
SELECT 
  Routes,
  Shipping_carriers,
  ROUND(AVG(Shipping_costs), 2) AS Avg_Cost,
  SUM(Number_of_products_sold) AS Total_Volume
FROM dbo.supplychain
GROUP BY Routes, Shipping_carriers
ORDER BY Avg_Cost ASC;
```
### Average Delivery Cost by Transport Mode
- Sea transport has the lowest average delivery cost at 4.97.
- Air transport is the most expensive at 6.02, likely due to its speed and operational overhead.
- Rail and Road provide a mid-range balance between cost and coverage, both under 5.55.
 ```sql
SELECT 
  Transportation_modes,
  ROUND(AVG(Shipping_costs), 2) AS Avg_Delivery_Cost
FROM dbo.supplychain
GROUP BY Transportation_modes;
```
### Carrier Performance by Shipment Count
- Carrier B is the most frequently used with 43 shipments, followed by Carrier C (29) and Carrier A (28).
- Carrier B’s higher usage implies stronger network capacity or more favorable contracts across multiple routes.
 ```sql
SELECT 
  Shipping_carriers,
  COUNT(*) AS Shipment_Count
FROM dbo.supplychain
GROUP BY Shipping_carriers
ORDER BY Shipment_Count DESC;
```
### Average Delivery Time by Transport Mode and Route
- Route C via Road is the fastest combination, with an average delivery time of just 3 days.
- Sea transport is the slowest option, averaging 7 days across all three routes (A, B, and C), which may introduce delays for time-sensitive deliveries.
- Air and Rail demonstrate consistent performance—Air remains steady at 5 days across all routes, while Rail ranges from 6 to 7 days depending on the route.
- Businesses prioritizing speed should leverage Route C + Road, the most efficient configuration in terms of delivery time.
 ```sql
SELECT  
  Transportation_modes,
  Routes,
  ROUND(AVG(Shipping_times), 2) AS Avg_Shipping_Time
FROM dbo.supplychain
GROUP BY Transportation_modes, Routes;
```
## Recommendations
### Product & Pricing Strategy
- Focus on Skincare Expansion: Skincare drives the highest revenue due to volume, suggesting it should remain a primary focus in marketing and production.
- Reevaluate Cosmetic Pricing: Cosmetics have the highest price but lower sales, indicating a need to review pricing strategies or improve value perception.
- Leverage Premium SKUs: Products like SKU31 show high revenue despite low volume—these can be featured in premium collections or bundles.

### Logistics Optimization
- Prioritize Route A + Carrier A for bulk distribution due to lowest cost per unit.
- Minimize reliance on Carrier A on Route C, which has the highest cost and lowest volume, indicating inefficiency.
- Use Rail and Road for large shipments, especially where cost efficiency and moderate delivery speed are acceptable.
- Route C + Road should be considered for urgent deliveries, as it’s the fastest combination (3-day average).

## Inventory & Stock Management
- Rebalance Cosmetics Inventory: Cosmetics have the highest stock levels despite being the lowest in sales volume, suggesting possible overstock.
- Monitor Skincare Inventory Closely: Skincare has lean stock and high turnover—ensure it doesn't fall below reorder points.

## Supplier Performance
- Prioritize Supplier 1: Strong performance across revenue, SKU variety, order volume, and inspection pass rate makes Supplier 1 a strategic partner.
 Investigate Supplier 3’s Over-Sales: Supplier 3 sold more units than produced, suggesting demand forecasting or reporting discrepancies.
- Address Supplier 4's Fail Rate (66.67%): Immediate attention needed to address QC failures that may affect customer trust and regulatory compliance.
- 
## Contact

For questions or collaboration:  
📧 **evitanegara@gmail.com**
