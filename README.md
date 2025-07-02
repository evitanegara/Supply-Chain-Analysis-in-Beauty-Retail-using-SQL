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


## Insights Deep-Dive
## Sales Insight
### Revenue, Volume, and Pricing by Product Type
- Skincare leads in total revenue with over 241,000, driven by a high sales volume of 20,731 units despite a moderate average price of 47.26.
- Haircare ranks second with 174,000 in revenue from 13,611 units sold at an average price of 46.01, reflecting steady demand.
- Cosmetics, though priced highest at an average of 57.36, ranks third in revenue (161,000) due to lower volume (11,757 units).
- This suggests that premium pricing in Cosmetics may limit unit sales, while Skincare benefits from a high-volume, mid-priced strategy.

### Top 10 SKUs by Revenue
- Leading SKUs include SKU51 (Haircare) and SKU38 (Cosmetics), both supplied by Supplier 5, indicating strong supplier performance.
- Supplier 5 contributes two top-performing SKUs with combined revenue exceeding 19,500.
- Haircare and Skincare dominate the top 10 list, accounting for 8 of 10 SKUs, pointing to consistent market demand in these categories.
- SKU31 stands out with high revenue (9,655.14) from just 168 units sold, suggesting high pricing or strong profit margins.

### Revenue by Supplier
- Supplier 1 generates the highest revenue at 157,529, followed by Supplier 2 (125,467) and Supplier 5 (110,343).
- Supplier 4 underperforms at 86,468, despite a wide product range—potentially due to pricing strategy, turnover rates, or sales reach.
- These figures highlight the varying effectiveness of supplier performance and may support renegotiation or reallocation of supply partnerships.

### Best-Selling Product Type by Supplier
- Supplier 1 and Supplier 3 derive most of their revenue from Skincare, indicating specialization in this high-volume category.
- Supplier 2 and Supplier 4 generate the bulk of their sales through Haircare products.
- Supplier 5 performs strongest in Cosmetics, possibly reflecting niche strength or premium market positioning.
- This distribution supports the use of supplier-specific segmentation strategies for optimized marketing, procurement, and logistics.

### Revenue by Customer Demographic (Gender)
- "Unknown" gender customers contribute the most revenue (173,090), suggesting potential gaps in data collection or an increase in anonymous or guest checkouts.
- Female customers generate 161,514 in revenue, slightly ahead of Male customers at 126,634.
- Non-binary customers also show meaningful engagement with 116,365 in revenue, indicating inclusive product appeal.
- The demographic breakdown reveals opportunities to improve data capture while also validating diverse market engagement.

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
