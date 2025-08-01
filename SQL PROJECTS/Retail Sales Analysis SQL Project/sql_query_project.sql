-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project;

-- Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
         (
            transactions_id INT PRIMARY KEY,
			sale_date DATE,	
			sale_time TIME,	
			customer_id	INT,
			gender VARCHAR(15),	
			age	INT,
			category VARCHAR(15),	
			quantiy INT,
			price_per_unit	FLOAT,
			cogs FLOAT,
			total_sale FLOAT

         );

SELECT * FROM retail_sales
LIMIT 10

SELECT COUNT(*) FROM retail_sales

-- DATA CLEANING
SELECT * FROM retail_sales
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR 
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

DELETE FROM retail_sales
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR 
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;
	 
-- DATA EXPLORATION

-- How many sales do we have?
SELECT COUNT(total_sale)FROM retail_sales

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales

-- How many unique categories do we have? and List them
SELECT COUNT(DISTINCT category) FROM retail_sales

SELECT DISTINCT category FROM retail_sales

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE 
category = 'Clothing'
AND
TO_CHAR(Sale_date, 'YYYY-MM') = '2022-11'
AND 
quantiy >= 4

-- TO_CHAR is a PostgreSQL function used to convert a date, time, or number into a string, with a specific format.
-- TO_CHAR(expression, format)

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) as net_sale
FROM retail_sales
GROUP BY 1
-- GROUP BY 1 Group by the first column in the SELECT clause or you could just say GROUP BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT ROUND(AVG(age), 2) AS AVG_AGE
FROM retail_sales
WHERE
     category='Beauty'
	 
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT * FROM retail_sales
WHERE
     total_sale > 1000

-- Q.6 Write a SQL query to find the total number of Transactions (transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(transactions_id) as Total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY 1

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT * FROM
(

SELECT 
      EXTRACT(YEAR FROM sale_date) AS year,
      EXTRACT(MONTH FROM sale_date) AS month,
      avg(total_sale) as avg_sale,
      RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as Rank
FROM retail_sales
GROUP BY 1, 2 
) as t1
WHERE Rank = 1

-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale)
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
Limit 5



--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category
SELECT COUNT(DISTINCT customer_id), category
From retail_sales
GROUP BY category

--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
CASE 
	    WHEN EXTRACTION(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACTION(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
END as shift
FROM retail_sales
)
SELECT
  shift,
  COUNT(*) as total_orders
FROM hourly-sale
GROUP BY shift

-- End of Project