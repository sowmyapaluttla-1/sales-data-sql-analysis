-- Find the total sales amount for each product_category in 2023,
	-- but only include categories where:
	-- average quantity is NOT between 3 and 7
	-- and category name contains the letter ‘o’
	-- Sort by total sales descending.
select product_category , sum(sale_amount) as totalsales , avg(quantity) as avgq
from sales where year(date_) = '2023' and  product_category like '%o%'  
group by product_category HAVING avgq NOT BETWEEN 3 AND 7
ORDER BY totalsales DESC;

-- Count number of sales for each payment method where:
	-- region is South or West
	-- AND sale_amount is between 20,000 and 50,000
	-- BUT exclude Clothing category
	-- Show only payment methods having more than 2 such transactions.
 
 use sales;

select payment_method, region , count(quantity) as cs from sales where (region = "south" or region = "west" ) 
and ( sale_amount between 20000 and 50000) and  product_category != "clothing" group by payment_method, region having cs > '';

-- how customers whose total units purchased are > total number of purchases * 4.

select customer_name , sum(quantity) as tu , count(quantity) as sq from sales 
group by customer_name having tu > sq * 4;


--Create a new column “Tax_Added_Amount” = sale_amount + (sale_amount * 0.05)
	-- But show only those final amounts > 50,000

select customer_name , sum(sale_amount) as sa , sum(sale_amount) + sum(sale_amount * 0.05) as tas from sales 
group by customer_name  having tas > 50000;

