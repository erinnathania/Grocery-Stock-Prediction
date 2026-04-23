# Grocery Inventory & Restock Prediction — SQL Analysis

## Project Overview

Overstocking ties up capital and leads to waste. Understocking means lost sales and unhappy customers. This project uses SQL to analyze a grocery inventory dataset and surface actionable insights that help operations teams know **exactly when and what to restock** — before it becomes a problem.

---

## Business Questions Answered

| # | Question | Why It Matters |
|---|----------|----------------|
| 1 | Which products are currently below their reorder level, how many units short, and what's the restock cost? | Identifies items at immediate risk of running out and estimates the cost to fix it |
| 2 | Which products are overstocked relative to their sales volume? | Flags capital tied up in slow-moving inventory |
| 3 | Which items are expiring soon but still have high stock? | Prevents waste and financial loss | **Lets say now february 2024**
| 4 | Which suppliers are linked to the most stockouts or backordered products? | Helps evaluate supplier reliability |
| 5 | What is the average inventory turnover rate per category? | Measures how efficiently each category sells |
| 6 | Which products have never been restocked (Last Order Date is old)? | Uncovers neglected or forgotten inventory |
| 7 | What is the | Quantifies lost revenue in dollar terms |

---

## Dataset

**File:** `Grocery_Inventory_and_Sales_Dataset.csv`

| Column | Description |
|--------|-------------|
| `Product_ID` | Unique identifier for each product |
| `Product_Name` | Name of the grocery item |
| `Category` | Product category (e.g., Dairy, Beverages, Grains & Pulses) |
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

## Key Findings
1. Out of the top 10 most understocked products, most are `Discontinued` or `Backordered` 
   — meaning restocking is either unnecessary or impossible.
   - The real concern is the `Active` items: `Basmati Rice` (76 units short, $342 restock cost) 
     and `Haddock` (76 units short, $684 restock cost) — these need immediate reordering.
   - `Avocado Oil` is `Backordered` with the highest restock cost at $760 
     — the supplier (Quamba) is failing to deliver. The business should find an alternative supplier.

2. `Bananas` have the highest have the highest `Capital_Tied_Up at $2,067.03` and despite the low `Inventory_Turnover_Rate` it has overloaded stock compared to its sales volume. 
  - The grocery business should stop or reduce banana reorders immediately, run a promotion or discount to sell existing stock before it expires

3. The 10 `Product_Name` and `Product_ID` with closest expiry date from `February 2024` is below:
  - Bread Flour (67-710-5120)
  - Chocolate Biscuit (20-0540-3716)
  - Cheddar Cheese (60-456-8169)
  - Robusta Coffee (92-455-2959)
  - Salmon (50-930-4751)
  - Pomegranate (62-822-5278)
  - Evaporated Milk (18-107-7886)
  - Evaporated Milk (96-209-1739)
  - Wild Rice (06-340-6856)
  - Mozzarella Cheese (83-400-9746)

`Greek Yogurt (68-734-1585)` has the highest potential waste_loss with a close expiry date at `2024-07-13`.
  - The grocery store should handle this by offering discounts, promotions or use marketing strategies (such as putting it in high-visibility areas or bundling it with complementary items) to sell it as soon as possible.
  - Future order quantities should also be reduced to adjust with its demand rate.

4. 22 suppliers have a 100% backorder rate — meaning every single product they handle has failed to deliver.
   - The worst offenders with the most affected products: `Skinix` (4 products), `Browsecat` (3), `Youspan` (3), `Eimbee` (3), `Ainyx` (3), and `Centimia` (3).
   - These suppliers are a direct cause of understocking — the business can have a perfect restock plan, but it means nothing if the supplier can't deliver.
   - Action needed: Immediately find alternative suppliers for these products, or renegotiate delivery terms with penalties for failed orders.

5. 

---

## Author
**Erinnathania**
- Project Type: SQL Data Analysis Project
- Domain: Inventory Management / Supply Chain Analytics
