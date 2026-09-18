-- . Create a new column “Sale_Type” using CASE:
 -- High Sale → sale_amount > 30000
-- Medium Sale → between 15000 and 30000
-- Low Sale → others.**
    
select sale_amount , case 
when sale_amount > 20000 then 'highsales'
when sale_amount > 15000 then 'mediumsales'
else 'lowsales'
end as sale_type
from sales ;

--  Show customer_name, product_name, sale_amount, and a CASE column:
	-- “Premium” if sale_amount > 40,000
	-- “Moderate” if (quantity > 5 AND sale_amount BETWEEN 15,000 AND 40,000)
	-- “Budget” for all other rows
	-- Only include rows where payment_method is NOT Cash or NOT NULL.
    
select customer_name , product_name , sale_amount , case 
 when sale_amount > 40000 then 'premium' 
 when quantity > 5 AND sale_amount BETWEEN 15000 AND 40000 then 'moderate' 
 else 'budget' end as 'sale_'
 from sales  where payment_method != 'cash' or payment_method != 'null';

-- . Create a CASE-based discount column:
	-- 10% discount if payment_method = 'UPI'
	-- 5% discount if payment_method contains the letter 'd'
	-- 2% discount for all others
	-- BUT show only records where discount > 5%.
 
select * from (select payment_method , case 
when payment_method = 'upi' then "10%"
when payment_method like "%d" then "5%"
