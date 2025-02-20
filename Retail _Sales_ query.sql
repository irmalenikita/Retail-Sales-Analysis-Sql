
-- SQL Retail-Sales-Analytics.

-- Create table.

create table retail_sales(
transactions_id int primary key,
sale_date date, 
sale_time time, 
customer_id int, 
gender varchar(15), 
age int, 
category varchar(15), 
quantiy int,
 price_per_unit float, 
 cogs float, 
 total_sale float);

 select * from retail_sales;
 
 -- Check null values
 
 SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

alter table retail_sales
 rename column quantiy to quantity;
 
 select * from retail_sales;
   
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

-- How many uniuque category we have ?

SELECT DISTINCT category FROM retail_sales;

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 What is the total net sales and number of orders for each category?
-- Q.5 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.6 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.7 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.8 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.9 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.10 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.11 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Business Insights Queries
 
 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 
 select * from retail_sales
 where sale_date = '2022-11-05';
 
 -- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * from retail_sales
where category = 'Clothing'
and quantity >= 4
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as Each_sale_category
from retail_sales
group by category;

-- Q.4 What is the total net sales and number of orders for each category?

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;

-- Q.5 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2) as customer_Avg_age
from retail_sales
where category =  'Beauty';

--  Q.6 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale >= 1000;

 -- Q.7 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select  gender,category, count(transactions_id)
from retail_sales
group by gender,category;

-- Q.8 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
    year, 
    month, 
    Avg_total_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year, 
        MONTH(sale_date) AS month, 
        round(avg(total_sale),2) AS Avg_total_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY avg(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) ranked_sales
WHERE rnk = 1;

-- Q.9 Write a SQL query to find the top 5 customers based on the highest total sales.
 
select customer_id ,sum(total_sale) as Total_sale from retail_sales
group by customer_id
order by Total_sale desc
limit 5;

-- Q.10 Write a SQL query to find the number of unique customers who purchased items from each category.

select category, count( distinct customer_id) as Unique_customer
from retail_sales
group by category;

-- Q.11 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).

    SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS order_count
FROM retail_sales
GROUP BY shift


-- Project End
