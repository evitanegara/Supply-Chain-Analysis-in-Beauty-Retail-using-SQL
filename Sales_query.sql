-- 1. Revenue & Sales Performance

-- Which SKUs generated the highest revenue?
SELECT TOP 10
    SKU,
    Product_type,
    Supplier_name,
    SUM(Revenue_generated) AS Total_Revenue,
    SUM(Number_of_products_sold) AS Total_Units_Sold
FROM dbo.supplychain
GROUP BY SKU, Product_type, Supplier_name
ORDER BY Total_Revenue DESC;

select * from 
dbo.supplychain

-- Which product types contribute most to revenue?

SELECT
    Product_type,
    SUM(Revenue_generated) AS Total_Revenue
FROM dbo.supplychain
GROUP BY Product_type
ORDER BY Total_Revenue DESC;

-- What is the total revenue by supplier?
SELECT
    Supplier_name,
    SUM(Revenue_generated) AS Total_Revenue
FROM dbo.supplychain
GROUP BY Supplier_name
ORDER BY Total_Revenue DESC;

-- Which product type sells best per supplier?
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


SELECT * FROM dbo.supplychain

-- What is the average selling price by product type?
SELECT 
    Product_type,
    ROUND(AVG(Price), 2) AS Avg_Selling_Price
FROM dbo.supplychain
GROUP BY Product_type
ORDER BY Avg_Selling_Price DESC;

-- Which customer gender drive the most revenue?
SELECT 
  Customer_demographics AS Gender,
  SUM(Revenue_generated) AS Total_Revenue
FROM dbo.supplychain
GROUP BY Customer_demographics
ORDER BY Total_Revenue DESC;


