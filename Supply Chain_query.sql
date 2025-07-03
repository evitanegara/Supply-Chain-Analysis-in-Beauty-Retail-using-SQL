-- Supply Chain Performance 
-- How many SKUs of each product type does each supplier provide?
SELECT 
  Supplier_name,
  Product_type,
  COUNT(DISTINCT SKU) AS Total_SKUs
FROM dbo.supplychain
GROUP BY Supplier_name, Product_type;

-- What is the pass, pending, and fail percentage per supplier?
SELECT 
  Supplier_name,
  Inspection_results,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Supplier_name), 2) AS Result_Percentage
FROM dbo.supplychain
GROUP BY Supplier_name, Inspection_results;

-- Total order quantity by supplier
SELECT 
    Supplier_name,
    SUM(Order_quantities) AS Total_Ordered_Quantity
FROM dbo.supplychain
GROUP BY Supplier_name
ORDER BY Total_Ordered_Quantity DESC;

-- What is the average stock level by product type or supplier?
SELECT 
    Product_type,
    ROUND(AVG(Stock_levels), 2) AS Avg_Stock_Level
FROM dbo.supplychain
GROUP BY Product_type;

-- Production Quantity vs Products Sold per Supplier
SELECT 
  Supplier_name,
  SUM(Production_volumes) AS Total_Produced,
  SUM(Number_of_products_sold) AS Total_Sold
FROM dbo.supplychain
GROUP BY Supplier_name;


