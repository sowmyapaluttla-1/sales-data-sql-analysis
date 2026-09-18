create database sales;
use sales;
Create table salesp;
select * from sales;
alter table sales add column date_ date;
set sql_safe_updates = 0;
update sales set date_ = str_to_date(sale_date ,'%m/%d/%Y');
-- Find total sales amount for each product category, but only categories whose total sales exceed 80,000.

select product_category ,sum(sale_amount) as ts from sales group by product_category 
having ts > 80000;
select quantity from sales;
-- Show customer names where quantity is NOT between 3 and 7

select customer_name from sales where quantity not between 3 and 7;
 
 -- Display all sales where the product name starts with ‘M’.
 select product_name from sales where product_name like "M%";
 
 -- Find the average sale amount for each region and show only regions with average > 25000
 select region , avg(sale_amount)  as asm from sales group by region having asm > 2500 ;
