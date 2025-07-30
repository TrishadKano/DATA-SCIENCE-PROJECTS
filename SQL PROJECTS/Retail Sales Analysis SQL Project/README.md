# Retail Sales Analysis SQL Project

A data analysis project using SQL to explore and derive insights from retail sales data. This project showcases the use of SQL for querying, filtering, aggregating, and reporting on retail data, simulating real-world business analytics tasks.

## 📊 Project Overview

The goal of this project is to perform data exploration and analysis on a retail sales dataset using SQL. This includes identifying trends, customer behavior, product performance, and generating key business insights that could inform decision-making.

## 🧰 Tools & Technologies

- **SQL** (PostgreSQL) – core query language used for data analysis
- **DBMS Tool**: pgAdmin


## 🗂️ Dataset Description

The dataset includes the following columns:

- `customer_id`: Unique identifier for each customer
- `transactions_id`: Unique identifier for each transaction
- `category`: Category of the product 
- `quantity`: Number of items sold
- `total_sale`: Total sale value (quantity × unit price)
- `sale_date`: Date of transaction
- `sale-time`: Time of transaction
- `Gender`: Gender of the customer
- `Age`: Age of the Customer
- `price_per_unit`: Price of a single unit of the product
- `cogs`: Cost of goods sold for the transaction

> Note: You can include a sample schema diagram or ERD if available.

## ✅ Key SQL Tasks Performed

- **Data Cleaning & Formatting**
  - Handling nulls, converting date formats using `TO_CHAR`, etc.
- **Exploratory Data Analysis**
  - Monthly sales trends
  - Top-selling products by category
  - High-value customers
- **Aggregation and Grouping**
  - `SUM()`, `AVG()`, `COUNT()`, `GROUP BY`, etc.
- **Filtering and Conditional Logic**
  - Filtering by date, category, sales volume
- **Window Functions**
  - Ranking products or customers by performance
