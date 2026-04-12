# Grocery Inventory & Restock Prediction — SQL Analysis

## Project Overview

Overstocking ties up capital and leads to waste. Understocking means lost sales and unhappy customers. This project uses SQL to analyze a grocery inventory dataset and surface actionable insights that help operations teams know **exactly when and what to restock** — before it becomes a problem.

---

## Business Questions Answered

| # | Question | Why It Matters |
|---|----------|----------------|
| 1 | Which products are currently below their reorder level? | Identifies items at immediate risk of running out |
| 2 | Which products are overstocked relative to their sales volume? | Flags capital tied up in slow-moving inventory |
| 3 | Which items are expiring soon but still have high stock? | Prevents waste and financial loss |
| 4 | Which product categories have the most backordered items? | Reveals supply chain weak points by category |
| 5 | Which suppliers are linked to the most stockouts or backordered products? | Helps evaluate supplier reliability |
| 6 | What is the average inventory turnover rate per category? | Measures how efficiently each category sells |
| 7 | Which products have never been restocked (Last Order Date is old)? | Uncovers neglected or forgotten inventory |
| 8 | What is the estimated financial impact of understocked items? | Quantifies lost revenue in dollar terms |

---

## Dataset

**File:** `Grocery_Inventory_and_Sales_Dataset.csv`

| Column | Description |
|--------|-------------|
| `Product_ID` | Unique identifier for each product |
| `Product_Name` | Name of the grocery item |
| `Catagory` | Product category (e.g., Dairy, Beverages, Grains & Pulses) |
| `Supplier_ID` | Unique identifier for the supplier |
| `Supplier_Name` | Name of the supplying company |
| `Stock_Quantity` | Current units in stock |
| `Reorder_Level` | Minimum stock threshold — reorder when stock falls below this |
| `Reorder_Quantity` | How many units to order when restocking |
| `Unit_Price` | Price per unit |
| `Date_Received` | Date the last shipment arrived |
| `Last_Order_Date` | Date the last order was placed with the supplier |
| `Expiration_Date` | Product expiry date |
| `Warehouse_Location` | Physical storage address |
| `Sales_Volume` | Total units sold |
| `Inventory_Turnover_Rate` | How frequently stock is sold and replaced |
| `Status` | Current product status: Active, Backordered, or Discontinued |

> Note: The `Catagory` column name is a typo present in the original dataset and is preserved as-is.

---

## Tools Used

| Tool | Purpose |
|------|---------|
| **MySQL Workbench** | Database setup, CSV import, and running all SQL queries |
| **MySQL 8.x** | Relational database engine |
| **Git & GitHub** | Version control and project documentation |

---

## Project Structure

```
Grocery Stock Prediction/
│
├── Grocery_Inventory_and_Sales_Dataset.csv   # Raw dataset
├── schema.sql                                # Table creation script
├── analysis.sql                              # All analysis queries
└── README.md                                 # Project documentation
```

---

## How to Run This Project

### 1. Prerequisites
- MySQL Server installed (version 8.x recommended)
- MySQL Workbench installed

### 2. Set Up the Database
```sql
CREATE DATABASE grocery_inventory;
USE grocery_inventory;
```

### 3. Import the Dataset
Use the **Table Data Import Wizard** in MySQL Workbench:
- Right-click your schema → **Table Data Import Wizard**
- Select `Grocery_Inventory_and_Sales_Dataset.csv`
- Let MySQL auto-detect column types, then confirm

### 4. Run the Queries
Open `analysis.sql` in MySQL Workbench and execute the queries to explore the business insights.

---

## Key Findings

> This section will be updated as analysis is completed.

- TBD: Products currently below reorder level
- TBD: Categories most at risk of stockouts
- TBD: Estimated revenue at risk from understocked items

---

## Author

**Erinnathania**
- Project Type: Beginner SQL Portfolio Project
- Domain: Inventory Management / Supply Chain Analytics
