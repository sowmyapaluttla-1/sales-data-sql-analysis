--  Retrieve top 5 records where sale_amount is highest.
select sale_amount , sum(sale_amount) as sm from sales  
group by sale_amount order by sm desc limit 5;
 
--  Count total sales made in each payment method, but exclude UPI payments.
select payment_method , count(sale_id) as ts from sales 
where payment_method != "upi" group by payment_method ;

--  Show customernames and regions where sale_amount> 30000 OR quantity > 7
select customer_name , region from sales 
where (sale_amount > '30000' or quantity > '7');
 
 -- Find the number of sales for each region in 2023 only.
 select region , count(sale_id) as totalsales from sales 
 where year(date_) = '2023' group by region ;
