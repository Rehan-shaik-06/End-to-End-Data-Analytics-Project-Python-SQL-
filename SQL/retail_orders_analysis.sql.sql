SELECT * FROM retail_orders.df_orders;

-- Find top 10 highest revenue generating product

SELECT  product_id,sum(sale_price) as sales from retail_orders.df_orders
group by product_id
order by sales desc
limit 10;


-- Find top 5 highest selling products in each region

 with cts as(
 SELECT region,product_id,sum(sale_price)as sales from retail_orders.df_orders
 group by region,product_id)
select * from (
select *
,row_number() over (partition by region order by sales desc ) as rn from cts) A 
where rn<=5;


-- Find month over month growth comparison for 2022 & 2023 sales 
with cts as (
SELECT year(order_date) as order_year,month(order_date) as order_month ,sum(sale_price)as sales FROM retail_orders.df_orders
group by year(order_date),month(order_date)
-- order by year(order_date),month(order_date)

)
select order_month ,
sum(case when order_year=2022 then sales else 0 end )as sales_2022,
sum(case when order_year=2023 then sales else 0 end) as sales_2023 
from cts
group by order_month
order by order_month;


-- for each catogery which month has the highest sales
with cts as (
select  month(order_date)as order_month, category,sum(sale_price) as sales,year(order_date) as order_year from retail_orders.df_orders
group by order_month,category,order_year
-- order by order_month,order_year,sales desc
)
select * from(
select *,row_number() over (partition by category order by sales desc) as rn from cts)A
where rn=1;



-- Which sub_Category have highest growth by profit in 2023 compared to 2022
with cts as (
SELECT sub_category ,year(order_date) as order_year ,sum(sale_price)as sales FROM retail_orders.df_orders
group by order_year,sub_category


) ,cte2 as(
select sub_category ,
sum(case when order_year=2022 then sales else 0 end )as sales_2022,
sum(case when order_year=2023 then sales else 0 end) as sales_2023 
from cts
group by sub_category)
select *,(sales_2023-sales_2022)*100 /sales_2022
from cte2
order by (sales_2023-sales_2022)*100 /sales_2022 desc
limit 1;