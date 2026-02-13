create database  startersq2;
use startersq2;
-- CREATING TWO TABLES SALES ANF PRODUCT 
create table sales (sale_id int primary key,product_id int,foreign key(product_id) references product(product_id),quantity_sold int not null,sale_date date ,total_price decimal(10,2) not null);
create table product(product_id int primary key,product_name varchar(100),category varchar(100),unit_price decimal(10,2));
-- INSERTING VALUES INTO THE TABLE 
insert into product(product_id,product_name,category,unit_price)values(101,'Laptop','Electronics',500.00),(102,'Smartphone','Electronics',300.00),(103,'Headphones','Electronics',30.00),(104,'Keyboard','Electronics',20.00),(105,'Mouse','Electronics',15.00);
insert into sales(sale_id,product_id,quantity_sold,sale_date,total_price)values(1,101,5,'2024-01-01',2500.00),(2,102,3,'2024-01-02',900.00),(3,103,2,'2024-01-02',60.00),(4,104,4,'2024-01-03',80.00),(5,105,6,'2024-01-03',90.00);
-- Question 1 : Retrieve all columns from sales table 
select * from sales;
-- Question 2 : Retrive the product_name and unit price from product table 
select product_name,unit_price from product;
-- Question 3 : Retrieve the sale_id and sale_date from sale table 
select sale_id,sale_date from sales;
-- Question 4 : Filter the sales table to show the sales with a total price greater than 100 dollars 
select * from sales where total_price >100;
-- Question 5 : Filter out the product to show the products only in electronics category 
select * from product where category='Electronics';
-- Question 6 : Retrieve the sale_id and total_price from sales table for sales made on jan 3 2024 
select sale_id,total_price from sales where sale_date='2024-01-03';
-- Question 7 : Retrieve the product_id and product_name from sales product table for products with unit price greater than 100 dollars 
select product_id,product_name from product where unit_price >100;
-- Question 8 : Calculate the total revenue generated from all sales in the sales table 
select sum(total_price) as tot_rev from sales;
-- Question 9 : Calculate the average unit price of products in the product table 
select avg(unit_price) as average_unit_price from product;
-- Question 10 : Calculate the total quantity sold from the sales table 
select * from sales;
select sum(quantity_sold) as total_quantity_sold from sales;
-- Question 11 : Count sales per day from the sales table 
select sale_date,count(quantity_sold) as cnt from sales group by sale_date;
-- Question 12 : Retrieve product_name and unit_price from the product table with the highest unit price 
select product_name,unit_price from(select product_name,unit_price ,rank() over(order by unit_price desc) as rnk from product)t where t.rnk=1;
-- Question 13 : Retrive the sale_id,product_id and total_price from the sales table for sales with a quantity_sold greater than 4 
select sale_id,product_id,total_price from sales where quantity_sold>4;
-- Question 14 : Retrive the product_name and unit_price from the product table,ordering the results by unit_price on descending order 
select product_name,unit_price from product order by unit_price desc;
-- retrieve the total price of all sales rounding the values to two decimal places 
select round(sum(total_price),2) from sales ;
-- calculate the average total price of all sales in the sales table 
select avg(total_price) as avg_total_price from sales ;
-- retrieve the sales_id and sale_date from the sales table formatting the sale_date ad 'YYYY-MM-DD'
select sale_id,date_format(sale_date,'%Y-%m-%d') as date from sales;
-- Calculate the total revenue generated from sales of products in the electronics catgory 
select * from product;
select * from sales ;
select sum(total_price) from sales s join product p on s.product_id=p.product_id where category='Electronics';
-- Retrieve the product name and unit price from the product table filtering the unit_price to show only the values between 20 and 600 dollars 
select product_name,unit_price from product where unit_price between 20 and 600;
-- Retrieve the product name and category from the product table ordering the results by category in the ascending order 
select product_name,category from product order by category asc;
-- Calculate the total quantity_sold of products in the electronics category
select sum(quantity_sold) from sales e join product p on e.product_id =p.product_id where category='electronics';
-- Retrieve the product_name and total_price from the sales table calculating the total price as quantity_sold multiplied by unit_price
select product_name,s.quantity_sold*p.unit_price as total_price from sales s join product p on s.product_id=p.product_id ;
-- Identify the most frequently sold product from sales table 
select * from sales s join product p on s.product_id=p.product_id;
select product_name, count(*) as cnt from sales s join product p on s.product_id=p.product_id group by product_name having cnt>1;
-- Find the products not sold from product table 
select * from product;
select product_id,product_name from product where product_id not in (select product_id from sales );
-- calculate the total revenue generated fro sales for each product category
select sum(s.total_price) from sales s join product p on s.product_id=p.product_id group by p.category;
-- Find the product category with the highest average unit price 
select category , avg_unit_price from (select category , avg(unit_price) over(partition by category order by unit_price desc) as avg_unit_price from product)t  limit 1 ;
-- Identify products with total sales exceeding 30
select * from sales s join product p on s.product_id=p.product_id ;
select product_name, sum(total_price) as total_sales  from product p join sales s on s.product_id=p.product_id group by p.product_name having total_sales>30;
-- count the number of sales made in each month 
select date_format(sale_date , '%Y-%m') as month , count(*) from sales group by month;
-- retrive sales details for products with smart in their name
select * from sales s join product p on s.product_id=p.product_id where p.product_name like '%Smart%';
-- Determine the average quantity sold for products with unit_price greater than $100
select  avg(quantity_sold)  as avg_quantity from sales s join product p on s.product_id=p.product_id where p.unit_price>100;
-- Retrieve the product name and total sales revenue for each product 
select product_name,sum(total_price) as total_sales from sales s join product p on s.product_id=p.product_id group by product_name ;
-- List all sales along with the corresponding product name
select * from sales s join product p on s.product_id=p.product_id ;
select sale_id,product_name,quantity_sold,sale_date,total_price from sales s join product p on p.product_id=s.product_id;
-- Retrieve the product_name and total sales revenue for each product
select product_name,sum(total_price) as  total_sale_revenue from sales s join product p on s.product_id=p.product_id group by product_name;
-- Rank products based on total sales revenue 
select product_name,total_sale_revenue ,rank() over (order by total_sale_revenue) from(select product_name,sum(total_price) as total_sale_revenue from sales s join product p on s.product_id=p.product_id group by product_name)t;
-- calculate the running total revenue for each product category 
select category, sale_date,sum(total_price) over(partition by category order by sale_date) as running_total_revenue from sales s join product p on s.product_id=p.product_id;
-- categorise sales as high medium or low based on total price 
select sale_id ,case when total_price>200 then 'High'when total_price between 100 and 200 then 'Medium' when total_price<100 then  'Low' end as Case_total from sales ; 
-- Identify sales where the quantity sold is greater than the average quantity sold 
select sale_id from sales where quantity_sold > (select avg(quantity_sold) from sales );
-- Extract the month and sales for each sale date and count the number of sales for each month 
select concat(Year(sale_date),'-',month(sale_date)) as month ,count(sale_id) from sales group by month;
-- Calculate the number of days between the current date and sale_date 
select datediff(curdate(),sale_date) from sales;
-- Identify sales made during weekdays vs weekends 
select sale_id,case when dayofweek(sale_date) in(1,7) then 'Weekend' else'Weekday'end from sales;
-- List the top 3 products by revenue percentage contribution 
select product_name , sum(total_price)/(select sum(s.total_price) from sales s )*100 as total_revenue  from product p join sales s on p.product_id=s.product_id group by product_name order by total_revenue desc limit 3;
-- create view named total_sales that displays the totsl_sales amount for each product along with their names and categories 
 create view total_sales as select  product_name, category, sum(total_price) from product p join sales s on s.product_id=s.product_id group by product_name,category;
 select * from total_sales;
 drop  view total_sales;
 -- retrieve the product details (name,category,unit_price) for products that have a quantity sold greater than the average quantity sold across all products 
 select product_name,category,unit_price from product where product_id in (select product_id from sales group by product_id having sum(quantity_sold)>(select avg(quantity_sold) from sales s ));
 -- Explain the significance of indexing in sql databases and provide an example scenario where indexing could significantly improve query performance in the given schema
 -- Let us create an index on the sale_date column 
 create index idx_sale_date on sales(sale_date);
 -- Query with indexing 
 select * from sales where sale_date='2024-01-03';
 -- By specifying an index on the sale_date column thw database can quickly rotate the rows which matches the sale_date without scanning the entire table.The index allows for efficient look up for rows based on the sale_date value resulting in improved query performance
 -- Add a foreign key constraint to the sales table that references the product id column in the product table 
 alter table sales add constraint fk_user4 foreign key(product_id) references product(product_id);
 -- Create a view named top_products that lists the top 3 products based on the total quantity sold 
 create view top_products as select product_name,sum(quantity_sold) from sales s join product p on s.product_id=p.product_id group by product_name order by sum(quantity_sold) desc limit 3;
 select * from top_products;
 drop view top_products;
 