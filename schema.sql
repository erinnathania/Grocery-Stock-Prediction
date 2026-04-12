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