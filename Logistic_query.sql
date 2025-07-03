--Logistics Insights
SELECT * FROM dbo.supplychain

-- What is the average delivery cost by transport mode?
SELECT 
  Transportation_modes,
  ROUND(AVG(Shipping_costs), 2) AS Avg_Delivery_Cost
FROM dbo.supplychain
GROUP BY Transportation_modes;

-- Which route and carrier combination is most cost-effective (lowest average shipping cost)?
SELECT 
  Routes,
  Shipping_carriers,
  ROUND(AVG(Shipping_costs), 2) AS Avg_Cost,
  SUM(Number_of_products_sold) AS Total_Volume
FROM dbo.supplychain
GROUP BY Routes, Shipping_carriers
ORDER BY Avg_Cost ASC;

-- What is the detailed delivery record (SKU, cost, carrier, time, sales volume)?
SELECT 
  Shipping_carriers,
  SKU,
  Routes,
  Transportation_modes AS Mode,
  Shipping_costs,
  Shipping_times AS Shipping_time,
  Number_of_products_sold AS Sales_Volume
FROM dbo.supplychain
ORDER BY Sales_Volume DESC;

-- What is the average delivery time by transport mode and route?
SELECT 
  Transportation_modes,
  Routes,
  ROUND(AVG(Shipping_times), 2) AS Avg_Shipping_Time
FROM dbo.supplychain
GROUP BY Transportation_modes, Routes;

---  Which carrier is most frequently used overall?
SELECT 
  Shipping_carriers,
  COUNT(*) AS Shipment_Count
FROM dbo.supplychain
GROUP BY Shipping_carriers
ORDER BY Shipment_Count DESC;

--Which transport mode delivers the most volume?
SELECT 
  Transportation_modes,
  SUM(Number_of_products_sold) AS Total_Volume
FROM dbo.supplychain
GROUP BY Transportation_modes
ORDER BY Total_Volume DESC;





