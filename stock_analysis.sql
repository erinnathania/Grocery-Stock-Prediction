#Checks understocked items
SELECT 
    Product_Name,
    Category,
    Stock_Quantity,
    Reorder_Level,
    (Reorder_Level - Stock_Quantity) AS Units_Short,
    Unit_Price,
    ROUND((Reorder_Level - Stock_Quantity) * Unit_Price, 2) AS Restock_Cost,
    Supplier_Name,
    Status
FROM grocery_inventory.inventory
WHERE Stock_Quantity < Reorder_Level
ORDER BY Units_Short DESC;

SELECT 
    Product_Name, Category, Stock_Quantity, Reorder_Level,
    (Reorder_Level - Stock_Quantity) AS Units_Short,
    Unit_Price,
    ROUND((Reorder_Level - Stock_Quantity) * Unit_Price, 2) AS Restock_Cost,
    Supplier_Name
FROM grocery_inventory.inventory
WHERE Stock_Quantity < Reorder_Level
  AND Status = 'Active'
ORDER BY Units_Short DESC;

#Checks overlying stock
SELECT 
    Product_Name,
    Category,
    Stock_Quantity,
    Sales_Volume,
    Inventory_Turnover_Rate,
    (Stock_Quantity - Sales_Volume) AS Excess_Stock,
    Unit_Price,
    ROUND((Stock_Quantity - Sales_Volume) * Unit_Price, 2) AS Capital_Tied_Up
FROM grocery_inventory.inventory
WHERE Stock_Quantity > Sales_Volume
  AND Inventory_Turnover_Rate < 30
ORDER BY Capital_Tied_Up DESC;

#Consider now 2024 February - This query checks the most urgent expiry date
SELECT 
    Product_Name,
    Product_ID,
    Category,
    Expiration_Date
FROM grocery_inventory.inventory
WHERE Expiration_Date < '2024-08-01' AND Stock_Quantity > 0
ORDER BY Expiration_Date ASC;

#This query checks for biggest potential loss
SELECT 
    Product_Name,
    Product_ID,
    Category,
    Expiration_Date,
    ROUND(Stock_Quantity * Unit_Price, 2) AS Waste_Loss
FROM grocery_inventory.inventory
WHERE Expiration_Date < '2024-08-01' AND Stock_Quantity > 0
ORDER BY Waste_Loss DESC;

#Checks which supplier has highest backorder rate
SELECT 
    Supplier_Name,
    COUNT(*) AS Active_Products,
    SUM(CASE WHEN Status = 'Backordered' THEN 1 ELSE 0 END) AS Backordered_Count,
    SUM(CASE WHEN Status = 'Active' THEN 1 ELSE 0 END) AS Fulfilled_Count,
    ROUND(SUM(CASE WHEN Status = 'Backordered' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS Backorder_Rate
FROM grocery_inventory.inventory
WHERE Status != 'Discontinued'
GROUP BY Supplier_Name
HAVING COUNT(*) >= 2
ORDER BY Backorder_Rate DESC;

#Finds which item going to sold out before reordered
SELECT 
    Product_Name,
    Category,
    Stock_Quantity,
    Sales_Volume,
    ROUND(Stock_Quantity / (Sales_Volume / 365), 0) AS Days_Until_Stockout,
    Supplier_Name
FROM grocery_inventory.inventory
WHERE Status = 'Active'
  AND Sales_Volume > 0
ORDER BY Days_Until_Stockout ASC;

#Find slowest supplier
SELECT 
    Supplier_Name,
    COUNT(*) AS Total_Products,
    ROUND(AVG(DATEDIFF(Date_Received, Last_Order_Date)), 0) AS Avg_Delivery_Days,
    MAX(DATEDIFF(Date_Received, Last_Order_Date)) AS Slowest_Delivery,
    MIN(DATEDIFF(Date_Received, Last_Order_Date)) AS Fastest_Delivery
FROM grocery_inventory.inventory
WHERE Status IN ('Active', 'Backordered')
GROUP BY Supplier_Name
HAVING COUNT(*) >= 2
ORDER BY Avg_Delivery_Days DESC;

#Summary
SELECT 
    Product_Name,
    Category,
    Stock_Quantity,
    Reorder_Level,
    Sales_Volume,
    Supplier_Name,
    Expiration_Date,
    DATEDIFF(Date_Received, Last_Order_Date) AS Delivery_Days,

    CASE 
        WHEN Stock_Quantity < Reorder_Level THEN 'Understocked'
        WHEN Stock_Quantity > Sales_Volume AND Inventory_Turnover_Rate < 30 THEN 'Overstocked'
        ELSE 'Balanced'
    END AS Stock_Label,

    CASE 
        WHEN Expiration_Date < '2024-02-01' THEN 'Already Expired'
        WHEN DATEDIFF(Expiration_Date, '2024-02-01') < 90 THEN 'Expiring Soon'
        WHEN DATEDIFF(Expiration_Date, '2024-02-01') < 180 THEN 'Expiring Later'
        ELSE 'Safe'
    END AS Expiry_Label,

    CASE 
        WHEN DATEDIFF(Date_Received, Last_Order_Date) < 0 THEN 'Pending Delivery'
        WHEN DATEDIFF(Date_Received, Last_Order_Date) <= 60 THEN 'Reliable'
        WHEN DATEDIFF(Date_Received, Last_Order_Date) <= 150 THEN 'Slow'
        ELSE 'Very Slow'
    END AS Supplier_Label,

    CASE 
        WHEN Sales_Volume = 0 THEN 'No Sales Data'
        WHEN ROUND(Stock_Quantity / (Sales_Volume / 365), 0) < 60 THEN 'Critical'
        WHEN ROUND(Stock_Quantity / (Sales_Volume / 365), 0) < 120 THEN 'Low'
        ELSE 'Sufficient'
    END AS Stockout_Label

FROM grocery_inventory.inventory
WHERE Status != 'Discontinued'
ORDER BY Expiration_Date ASC;