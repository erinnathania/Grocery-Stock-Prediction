CREATE DATABASE grocery_inventory;
USE grocery_inventory;

RENAME TABLE grocery_inventory.grocery_inventory_and_sales_dataset TO grocery_inventory.inventory;
SELECT * FROM grocery_inventory.inventory LIMIT 10;

ALTER TABLE grocery_inventory.inventory;
RENAME COLUMN Catagory TO Category;

SET SQL_SAFE_UPDATES = 0;

UPDATE grocery_inventory.inventory
SET Unit_Price = TRIM(REPLACE(Unit_Price, '$', ''));

ALTER TABLE grocery_inventory.inventory
MODIFY COLUMN Unit_Price DECIMAL(10,2);

UPDATE grocery_inventory.inventory
SET Date_Received = STR_TO_DATE(Date_Received, '%m/%d/%Y');

UPDATE grocery_inventory.inventory
SET Last_Order_Date = STR_TO_DATE(Last_Order_Date, '%m/%d/%Y');

UPDATE grocery_inventory.inventory
SET Expiration_Date = STR_TO_DATE(Expiration_Date, '%m/%d/%Y');

ALTER TABLE grocery_inventory.inventory
MODIFY COLUMN Date_Received DATE;

ALTER TABLE grocery_inventory.inventory
MODIFY COLUMN Last_Order_Date DATE;

ALTER TABLE grocery_inventory.inventory
MODIFY COLUMN Expiration_Date DATE;