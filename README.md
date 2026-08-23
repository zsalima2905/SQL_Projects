# 🛒 E-Commerce Order Management System

**MySQL Database Project**
**Author: Z SALIMA**

## 📌 Project Overview

The **E-Commerce Order Management System** is a relational database project developed using **MySQL Workbench**.

It manages customers, products, categories, orders, payments, shipping, and product reviews while demonstrating SQL querying and business analytics.

---

## 🛠️ Technologies

* MySQL
* MySQL Workbench
* SQL
* Relational Database Design

---

## 🗄️ Database Structure

**Database:** `Ecommerce_Order_Management_System`

### Main Tables

| Table           | Purpose                       |
| --------------- | ----------------------------- |
| `Category`      | Product categories            |
| `Customers`     | Customer information          |
| `Products`      | Product details and inventory |
| `Orders`        | Customer orders               |
| `Order_Details` | Products within orders        |
| `Payments`      | Payment information           |
| `Shippings`     | Shipping and delivery details |
| `Reviews`       | Customer product reviews      |

---

## 📊 Dataset

| Data             | Records |
| ---------------- | ------: |
| Categories       |      10 |
| Customers        |      50 |
| Products         |      50 |
| Orders           |      50 |
| Order Details    |     100 |
| Payments         |      50 |
| Shipping Records |      50 |
| Reviews          |      50 |

---

## 🧠 SQL Concepts Covered

* Database and table creation
* Primary Keys & Foreign Keys
* Unique & Check Constraints
* `INSERT`, `UPDATE`, `SELECT`
* Aggregate Functions
* `GROUP BY` & `HAVING`
* `INNER`, `LEFT`, `RIGHT` & `CROSS JOIN`
* Subqueries & Correlated Subqueries
* `EXISTS` & `NOT EXISTS`
* `UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT`
* Views
* Indexes
* User Roles & Privileges
* `INFORMATION_SCHEMA`
* Date & Time Functions
* Regular Expressions
* Business Analytics

---

## 📈 Business Analytics

The project includes queries for:

* 🏆 Top 10 best-selling products
* 💰 Top revenue-generating products
* 👑 Top customers by spending
* 📂 Category-wise revenue
* 🌆 City-wise revenue
* 📅 Monthly revenue trends
* 📦 Low-stock products
* 🚫 Products never sold
* 💳 Payment mode analysis
* 🚚 Shipment status analysis

---

## 👁️ Views

Three reporting views are created:

* `Customer_Order_Report`
* `Product_Sales_Report`
* `Payment_Summary_Report`

---

## ⚡ Indexes

Indexes are created on frequently searched columns such as:

* Customer Name
* Customer Email
* Mobile Number
* Product Name
* Order Date

---

## 🔐 Database Security

The project demonstrates:

* User creation
* Password management
* `GRANT`
* `REVOKE`
* Database roles
* Default roles
* User privilege management

> ⚠️ The SQL file contains sample credentials for learning purposes. Do not use them in production.

---

## 🚀 How to Run

1. Install **MySQL Server** and **MySQL Workbench**.
2. Download or clone this repository.
3. Open `Ecommerce_Order_Management_System.sql` in MySQL Workbench.
4. Execute the script from the beginning.
5. Verify the database using:

```sql
USE Ecommerce_Order_Management_System;
SHOW TABLES;
```

---

## 📁 Repository Structure

```text
Ecommerce-Order-Management-System/
│
├── README.md
└── Ecommerce_Order_Management_System.sql
```

---

## 🎯 Learning Objectives

This project demonstrates practical skills in:

* SQL and relational database design
* Data integrity and constraints
* Complex queries and joins
* Database security
* Reporting and analytics
* E-commerce data analysis

---

## 👩‍💻 Author

**Z SALIMA**

*MySQL | SQL | Database Design | Data Analysis*

---
