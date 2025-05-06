-- CREATE TABLE.
create table retail_sales(
			transactions_id	int primary key,
			sale_date date, 
			sale_time time,	
			customer_id	int,
			gender varchar(15),	
			age int,
			category varchar(15),	
			quantity	int,
			price_per_unit float,	
			cogs float,	
			total_sale int
		);

select * from retail_sales
limit 10;

-- DATA CLEANING.

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
	category IS NULL
	OR
	quantity	IS NULL
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
	category IS NULL
	OR
	quantity	IS NULL
	OR
	price_per_unit IS NULL	
	OR
	cogs IS NULL	
	OR
	total_sale IS NULL;

-- DATA EXPLORATION --.

-- HOW MANY SALES WE HAVE?.
SELECT 	COUNT(*) as "total_sales" 
FROM retail_sales; 

--HOW MANY UNIQUE CUSTOMERS WE HAVE?.
SELECT COUNT(DISTINCT customer_id) as "total unique id" 
FROM retail_sales;

-- HOW MANY UNIQUE CATEGORY WE HAVE?.
SELECT COUNT(DISTINCT category) as "unique category" 
FROM retail_sales;


--DATA ANALYSIS AND BUSINESS KEY PROBLEM AND ANSWER.
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * 
FROM retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
	AND TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	AND quantity > 2 
	
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	category,
	SUM(total_sale),
	COUNT(*) AS "Total count of each category "
FROM retail_sales
GROUP BY category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT round(AVG(age))AS "average age"
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > '1000';

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
	category,
	gender,
	count(*) as "total_sales"
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
		year,
		month,
		avg_sales
FROM		
(SELECT
	extract(year from sale_date) as "year",
	extract(month from sale_date) as "month",
	ROUND(AVG(total_sale)) as "avg_sales",
	RANK() OVER(PARTITION BY EXTRACT(year FROM sale_date) ORDER BY AVG(total_sale) DESC ) as rank
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC
)AS t1
WHERE rank = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT 
	customer_id , 
	SUM(total_sale) as total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC 
LIMIT 5;   


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 	
	category,
	COUNT(DISTINCT customer_id) AS "unique customer"
FROM retail_sales
GROUP BY category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
	(SELECT * ,	
		CASE 
			WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Moring'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS shift	
	FROM retail_sales)

SELECT 
	shift,
	COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift;




