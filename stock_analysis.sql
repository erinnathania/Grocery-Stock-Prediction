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