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

## Project Structure

**1. Database Setup**

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```
## 2. Data Exploration & Cleaning**

- **Record Count: Determine the total number of records in the dataset.** 
- **Customer Count: Find out how many unique customers are in the dataset.**
- **Category Count: Identify all unique product categories in the dataset.**
- **Null Value Check: Check for any null values in the dataset and delete records with missing data.**

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```
## 3. Data Analysis & Findings
### The following SQL queries were developed to answer specific business questions:

### 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

```sql
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
```

### 3. Write a SQL query to calculate the total sales (total_sale) for each category.:

```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
```

### 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

### 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:

```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

### 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

```sql
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1
```

### 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

```sql
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
```

### 8. Write a SQL query to find the top 5 customers based on the highest total sales:

```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

### 9. Write a SQL query to find the number of unique customers who purchased items from each category.:

```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category
```

### 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
```

## Findings
- **Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.**
- **High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.**
- Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
- Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.
