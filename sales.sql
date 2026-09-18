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
 
 -- Show all records where payment method is NOT NULL and region is either North or East.
 select * from sales where payment_method is not NULL and 
 (region = 'north' or region = 'east' );
 
 -- Find total quantity sold per product, but only for 'Electronics' category. Sort results by total quantity (descending).
 select product_name , sum(quantity) as tq from sales
 where product_category = 'electronics'  group by product_name order by tq desc ;
 
 select * from sales;
-- Q7. Retrieve top 5 records where sale_amount is highest.
select sale_amount , sum(sale_amount) as sm from sales  
group by sale_amount order by sm desc limit 5;
 
-- Q8. Count total sales made in each payment method, but exclude UPI payments.
select payment_method , count(sale_id) as ts from sales 
where payment_method != "upi" group by payment_method ;

-- Q9. Show customernames and regions where sale_amount> 30000 OR quantity > 7
select customer_name , region from sales 
where (sale_amount > '30000' or quantity > '7');
 
 -- Find the number of sales for each region in 2023 only.
 select region , count(sale_id) as totalsales from sales 
 where year(date_) = '2023' group by region ;
 
 
-- Q11. Create a new column “Sale_Type” using CASE:
 -- High Sale → sale_amount > 30000
-- Medium Sale → between 15000 and 30000
-- Low Sale → others.**
    
select sale_amount , case 
when sale_amount > 20000 then 'highsales'
when sale_amount > 15000 then 'mediumsales'
else 'lowsales'
end as sale_type
from sales ;
    
-- Q12. Show total sales done by customers whose name contains the letter 'a'
 select customer_name , sum(sale_id) as ts from sales
 where customer_name like '%a%' group by customer_name;
 
-- Show all sales where product_category is Electronics AND payment_method is NOT Cash.
select product_category from sales 
 where product_category = 'electronics' and payment_method != 'cash' ;

-- Q14. Show the maximum sale_amount for each product, but only for South region.
select region , max(sale_amount) as msa from sales where region = 'south'  group by region ;

-- Q15. Count number of high-value transactions
	-- (sale_amount > 15,000) grouped by payment_method.
select payment_method , count(*) as csa from sales  where sale_amount > '15000' group by payment_method;

-- Find the total sales amount for each product_category in 2023,
	-- but only include categories where:
	-- average quantity is NOT between 3 and 7
	-- and category name contains the letter ‘o’
	-- Sort by total sales descending.
select product_category , sum(sale_amount) as totalsales , avg(quantity) as avgq
from sales where year(date_) = '2023' and  product_category like '%o%'  
group by product_category HAVING avgq NOT BETWEEN 3 AND 7
ORDER BY totalsales DESC;
 
-- Q17. Show customer_name, product_name, sale_amount, and a CASE column:
	-- “Premium” if sale_amount > 40,000
	-- “Moderate” if (quantity > 5 AND sale_amount BETWEEN 15,000 AND 40,000)
	-- “Budget” for all other rows
	-- Only include rows where payment_method is NOT Cash or NOT NULL.
    
select customer_name , product_name , sale_amount , case 
 when sale_amount > 40000 then 'premium' 
 when quantity > 5 AND sale_amount BETWEEN 15000 AND 40000 then 'moderate' 
 else 'budget' end as 'sale_'
 from sales  where payment_method != 'cash' or payment_method != 'null';
 
-- Q18. Find the top 3 regions with the highest total sales,
	-- but only considering sales where the product name starts with ‘C’ or ends with ‘a’.**
    
    select region ,product_name , sum(sale_amount) as ts
    from sales where product_name like 'c%' or product_name like '%a' 
     group by region, product_name order by ts desc limit 3 ;
    
-- Q19. Count number of sales for each payment method where:
	-- region is South or West
	-- AND sale_amount is between 20,000 and 50,000
	-- BUT exclude Clothing category
	-- Show only payment methods having more than 2 such transactions.
 
 use sales;

select payment_method, region , count(quantity) as cs from sales where (region = "south" or region = "west" ) 
and ( sale_amount between 20000 and 50000) and  product_category != "clothing" group by payment_method, region having cs > '';


-- For each customer, show total quantity and total sales only for 2024.
	-- But include the customer only if:
	-- name contains 'i'
	-- AND total quantity is NOT between 10 and 25.

select customer_name , sum(quantity) as tq , sum(sale_id) as ts from sales 
where (year(date_) = 2024 and  customer_name like '%i%')  
group by customer_name having tq not between 10 and 25 ;


-- Show all records where:
	-- product_category = Electronics
	-- AND (quantity > 7 OR sale_amount > 35,000)
	-- AND sale_date is NOT between Feb and April 2023
	-- Sort by sale_amount descending
    
select * from sales where product_category = 'Electronics' and (quantity > 7 OR sale_amount > 35000)
 and (date_ not between 2023-02-01 and 2023-04-01) order by sale_amount desc ;


-- Q22. Create a CASE-based discount column:
	-- 10% discount if payment_method = 'UPI'
	-- 5% discount if payment_method contains the letter 'd'
	-- 2% discount for all others
	-- BUT show only records where discount > 5%.
 
select * from (select payment_method , case 
when payment_method = 'upi' then "10%"
when payment_method like "%d" then "5%"
else "2%" end as discount from sales )abc where  discount > 3 ;

-- Q23. Find total sales by region for products whose:
	--  name contains 'e'
	-- AND unit_price is NOT between 500 and 2000
	-- AND quantity < 6
	-- Show only regions with total sales > 20,000

select region , product_name , sum(sale_amount) as ts  from sales  where (product_name like "%e%" )
and (unit_price NOT between 500 and 2000 )and quantity < 6 group by region,product_name having ts > 20000;

-- Q24. Show each product and its total quantity sold,
	-- but exclude records where:
	-- customer_name starts with ‘R’
	-- AND region is East
	-- AND sale_amount < 20,000**
	-- (Exclude only if all three conditions are true.)

select product_name , sum(quantity) as sq  from sales where not(customer_name like "r%" 
 and region = "east" and sale_amount < 20000) group by product_name ;
 
 -- Q25. Find the average unit price for each product-category combination,
	-- but only include combinations where:
	-- total quantity is above 15
	-- AND category does NOT start with ‘F’
	-- Sort by avg unit price descending

 select product_category, sum(quantity) as tq , avg(unit_price) as avu from sales 
 where product_category not like "f%" group by product_category having tq > 15 order by avu desc; 
 -- Q26. Show product_name, region, sale_amount, and a new column “Extra_Charge” where:
	-- If region = South → 8% of sale_amount
	-- If payment_method = Credit Card → 4%
	-- If both conditions match → 10%
	-- Else → 2%.
	-- Only display rows where Extra_Charge > 1500.
 select * from( 
 select product_name, region , sale_amount , case
 when  region = 'South' then sale_amount * 0.08
 when  payment_method = 'Credit Card' then sale_amount * 0.04
 when  region = 'South' and payment_method ='Credit Card' then sale_amount * 0.10
 else '2%' end as extra_charges from sales)ec 
 where extra_charges > 1500 ; 
 
 -- Find total sales per customer where:
-- product_category starts with ‘E’ OR ends with ‘y’
-- AND quantity is NOT between 2 and 9
-- AND sale_date NOT BETWEEN July 2023 and Dec 2023.
 
select customer_name , sum(sale_amount) as ts  from sales 
where ( product_category like 'e%' or product_category like '%y' )
and quantity not between 2 and 9
and sale_date not between '2023-07-01' and '2023-12-31' group by customer_name;

-- Show each payment_method with:
	-- total_sales
	-- avg_quantity
	-- minimum unit_price
	-- But only include methods whose avg_quantity is between 4 and 7

select payment_method, sum(sale_amount) as ts , avg(quantity) as avgq , min(unit_price) as mu from sales
 group by payment_method having avgq between 4 and 7; 
 
 -- Categorize each sale into:
	-- “Bulk High” → quantity > 7 AND sale_amount > 35000
	-- “Bulk Low” → quantity > 7 AND sale_amount <= 35000
	-- “Normal” → all others
	-- Show only “Bulk High” or “Bulk Low” records

select customer_name , case
when quantity > 7 AND sale_amount > 35000 then 'bulk_high'
when quantity > 7 AND sale_amount <= 35000 then 'bulk_low'
else 'normal' end as sale from sales where quantity > 7;
-- Q31. For each customer, calculate:
	-- total quantity -- total sales  -- avg unit price
	-- Only include customers whose:  -- name contains 'r' -- AND total sales NOT BETWEEN 50,000 AND 120,000.
 select customer_name , sum(sale_amount) as ts , sum(quantity) as tq, avg(unit_price) as agu 
 from sales where customer_name like '%r%' group by customer_name having ts not between 50000 and 120000;

-- Show all rows where:
	-- quantity < 5 OR sale_amount > 30,000
	-- AND payment_method is NOT “Cash” -- AND product_name contains ‘o’.
select * from sales where (quantity < 5 OR sale_amount > 30000) and payment_method != 'cash' and product_name like '%o%';

-- For each customer, show:
	-- total_sales, total_quantity, and a CASE that says: -- “Active” → if they made more than 3 purchases
	-- “Inactive” → if purchases ≤ 3 -- Only include customers whose total_sales > 20,000

select customer_name , sum(sale_amount) as ts , sum(quantity) as tq , case
when count(quantity) > 3 then 'active'
else 'inactive' end as ain from sales group by customer_name  having ts > 20000;  
-- Q34. Show top 5 product categories based on:
	-- (total_sales / total_quantity) as "Avg_Revenue_Per_Item"
select product_category , sum(sale_amount) as ts , sum(quantity) as sq , sum(sale_amount) / sum(quantity) as avgg from sales 
group by product_category  order by avgg desc limit 5;

-- Show each product and create a CASE column “Pricing_Level”:
	-- ‘Cheap’ → unit_price < 800
	-- ‘Medium’ → unit_price BETWEEN 800 AND 2500
	-- ‘Premium’ → unit_price > 2500
	-- Show only “Premium” and “Medium”.

select product_category ,case 
when (unit_price) < 800 then 'cheap'
when (unit_price between 800 and 2500) then 'medium'
when (unit_price)> 2500 then 'premium' end as pricing_level 
from sales  where unit_price >= 800 ;

-- Q36. Show customers whose total units purchased are > total number of purchases * 4.

select customer_name , sum(quantity) as tu , count(quantity) as sq from sales 
group by customer_name having tu > sq * 4;


-- Q37. Create a new column “Tax_Added_Amount” = sale_amount + (sale_amount * 0.05)
	-- But show only those final amounts > 50,000

select customer_name , sum(sale_amount) as sa , sum(sale_amount) + sum(sale_amount * 0.05) as tas from sales 
group by customer_name  having tas > 50000;



















