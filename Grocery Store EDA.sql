-- B. Exploratory Data Analysis
-- 1a. Total number of products.
select count(distinct(ProductID)) as Total_products
from products;

-- 1b. Total number of products sold so far.
select sum(quantity) as Total_quantiity
from products 
inner join order_details using(productID);

-- 1c. Total quantity sold so far.
select sum(quantity) as Total_quantity
from order_details;

-- 2. Total Revenue So far.
select round(sum(quantity * price), 2) as Total_revenue
from products
inner join order_details as od using(productID);

-- 3. Total Unique Products sold based on category.
select categoryname, count(distinct(productname))
from products
join categories using(categoryID)
group by categoryname
order by count(distinct(productname)) desc;

-- 4. Total Number of Purchase Transactions from customers.
select count(distinct(orderID)) as Total_orders
from customers
join orders using(customerID)
join order_details using(orderID);

-- OR --
select count(orderID)
from orders;

-- OR --
select count(distinct(orderID)) as Total_orders
from orders
inner join order_details using(orderID);

-- 5. Compare Orders made between 2022 – 2023
select year, count(distinct(orderID))
from orders
join order_details using(orderid)
group by year;

-- 6. What is total number of customers? Compare those that have made transaction and those that haven’t at all.
select count(CustomerID) as Customers_Transactions_made
from customers 
join orders using(customerID)
where orderID is null and orderID is not null;

select count(CustomerID) as Customers_Transactions_NotMade
from customers 
left join orders using(customerID)
where orderID is null;

-- OR --
SELECT
    COUNT(DISTINCT CASE WHEN orderID > 0 THEN customerID END) AS customers_with_transactions,
    COUNT(DISTINCT CASE WHEN orderID is null THEN customerID END) AS customers_without_transactions,
    COUNT(DISTINCT customerID) AS total_customers
FROM customers
left join orders using(customerID);

-- 7. Who are the Top 5 customers with the highest purchase value?
select customername, round(sum(price * quantity), 2) as HighestPurchase
from customers
inner join orders as o using(customerID)
inner join order_details using(orderID)
inner join products using(productID)
group by customerID
order by sum(price * quantity) desc
limit 5; 

-- 8. Top 5 best-selling products.
select productname, round(sum(price * quantity)) as Total_price
from order_details
inner join products using(productID)
group by productID
order by sum(price * quantity) desc
limit 5; 

-- add new column
alter table orders
add column month int;

update orders
set month = month(orderdate);

set sql_safe_updates = 0;

-- 9. What is the Transaction value per month?
select Month_name, round(sum(price * quantity),2) as "Total_price"
from orders  
inner join order_details using(orderid)
inner join products using(productid)
group by Month_name
order by sum(price * quantity);

-- 10. Best Selling Product Category?
select categoryname, round(sum(price * quantity), 2) as Total_price
from categories
inner join products using(categoryID)
inner join order_details using(productID)
group by categoryname
order by sum(price * quantity) desc;

-- 11. Buyers who have Transacted more than two times.
select c.customerName, count(o.orderid) as Order_count
from customers as c
inner join orders as o using(customerid)
group by c.customerid
having count(o.orderid) > 2
order by count(o.orderid)
limit 5;

-- 12. Most Successful Employee.
select concat(e.lastname," ", e.firstname) as "Full Name", 
       round(sum(p.price * od.quantity),2) as "Total Purchase"
from employees as e
inner join orders as o using(employeeid)
inner join order_details as od using(orderid)
inner join products as p using(productid)
group by e.EmployeeID
order by round(sum(p.price * od.quantity),2) desc
limit 5;

-- 13. Most use Shipper.
select s.shipperName, count(o.orderid) as "Number of Orders"
from shippers as s
inner join orders as o using(shipperid)
group by s.ShipperID
order by count(o.orderid) desc;

-- 14. Most use Supplier.

select SupplierName, count(distinct(OrderID)) as "Order_counts"
from suppliers 
inner join products using(supplierid)
inner join order_details using(productid)
group by SupplierID
order by count(OrderID) desc
limit 5;

-- TOTAL CUSTOMERS
select count(distinct(customerID)) as Total_customers
from customers;

select customername,  count(CustomerID) 
from customers 
left join orders using(customerID)
where orderID is null
group by customername;
