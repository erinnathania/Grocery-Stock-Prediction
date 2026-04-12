SELECT 
    Product_Name,
    Category,
    Stock_Quantity,
    Reorder_Level,
    Reorder_Quantity,
    Supplier_Name,
    Status
FROM grocery_inventory.inventory
WHERE Stock_Quantity < Reorder_Level
ORDER BY (Reorder_Level - Stock_Quantity) DESC;

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