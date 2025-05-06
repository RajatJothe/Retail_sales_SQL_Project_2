## Retail_sales_SQL_Project_2

#### 📊Question asked.
1. Write a SQL query to retrieve all columns for sales made on '2022-11-05
2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
3. Write a SQL query to calculate the total sales (total_sale) for each category.
4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
8. Write a SQL query to find the top 5 customers based on the highest total sales 
9. Write a SQL query to find the number of unique customers who purchased items from each category.
10. Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

#### 📚SOLUTION.
***1. Write a SQL query to retrieve all columns for sales made on '2022-11-05***

```sql
SELECT * 
FROM retail_sales
WHERE   sale_date = '2022-11-05';
```

***2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022***
```sql
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
	AND TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	AND quantity > 2 
```
***3. Write a SQL query to calculate the total sales (total_sale) for each category.***
```sql
SELECT 
	category,
	SUM(total_sale),
	COUNT(*) AS "Total count of each category "
FROM retail_sales
GROUP BY category;
```
***4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.***
```sql
SELECT round(AVG(age))AS "average age"
FROM retail_sales
WHERE category = 'Beauty';
```
***5. Write a SQL query to find all transactions where the total_sale is greater than 1000.***
```sql
SELECT *
FROM retail_sales
WHERE total_sale > '1000';
```
***6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.***
```sql
SELECT 
	category,
	gender,
	count(*) as "total_sales"
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;

```
***7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year***
```sql
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
```
***8. Write a SQL query to find the top 5 customers based on the highest total sales***
```sql
SELECT 
	customer_id , 
	SUM(total_sale) as total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC 
LIMIT 5;  
```
***9. Write a SQL query to find the number of unique customers who purchased items from each category.***
```sql
SELECT 	
	category,
	COUNT(DISTINCT customer_id) AS "unique customer"
FROM retail_sales
GROUP BY category;
```
***10. Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)***
```sql
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
```
## Findings
***Customer Demographics:*** The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.

***High-Value Transactions:*** Several transactions had a total sale amount greater than 1000, indicating premium purchases.

***Sales Trends:*** Monthly analysis shows variations in sales, helping identify peak seasons.

***Customer Insights:*** The analysis identifies the top-spending customers and the most popular product categories.

## Reports
***Sales Summary:*** A detailed report summarizing total sales, customer demographics, and category performance.

***Trend Analysis:*** Insights into sales trends across different months and shifts.

***Customer Insights:*** Reports on top customers and unique customer counts per category.

## Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.







