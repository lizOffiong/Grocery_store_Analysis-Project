-- TEST SKILLS-- 
-- 1. Select customer name together with each order the customer made.
select c.CustomerName, o.*
from customers as c
inner join orders as o on c.CustomerID = o.CustomerID
order by OrderID asc;

-- 2. Select order id together with name of employee who handled the order.
select o.OrderID, concat(e.lastname," ",e.firstname) as "Employee Name" 
from orders as o
inner join employees as e on o.EmployeeID = e.EmployeeID;

-- 3. Select customers who did not placed any order yet.
select c.CustomerName, o.*
from orders as o
right join customers as c on o.customerID = c.CustomerID
where o.OrderID is null;

-- 4. Select order id together with the name of products.
select od.OrderID, p.ProductName
from order_details as od
inner join products as p on od.ProductID = p.ProductID
order by od.OrderID asc;

-- 5. Select products that no one bought.
select p.ProductName, od.*
from products as p
left join order_details as od on p.ProductID = od.ProductID
where od.OrderID is null;  -- all products has been bought.

-- 6. Select customer together with the products that he bought.
select c.CustomerName, p.ProductName
from customers as c
inner join orders as o using(CustomerID)
inner join order_details as od using(OrderID)
inner join products as p using(ProductID);

-- 7. Select product names together with the name of corresponding category.
select p.ProductName, c.CategoryName
from products as p
inner join categories as c using(CategoryID);

-- 8. Select orders together with the name of the shipping company.
select s.ShipperName, o.orderID
from shippers as s
inner join orders as o on s.ShipperID = o.ShipperID;

-- 9. Select customers with id greater than 50 together with each order they made.
select c.customerName, o.*
from customers as c
inner join orders as o on c.CustomerID = o.CustomerID
where c.CustomerID > 50;

-- 10. Select employees together with orders with order id greater than 10400.
select concat(e.lastname," ", e.FirstName) as "Employee Name", o.*
from employees as e
inner join orders as o using(EmployeeID)
where o.OrderID > 10400;

-- 11. Select the most expensive product.
select ProductName, Price
from products
order by price desc
limit 1;

-- 12. Select the second most expensive product.
select ProductName, Price
from products
where price > 100
order by price asc
limit 1;

-- 13. Select name and price of each product, sort the result by price in decreasing order.
select ProductName, Price
from products
order by Price desc;

-- 14. Select 5 most expensive products.
select ProductName
from products
order by price desc
limit 5;

-- 15. Select 5 most expensive products without the most expensive (in final 4 products).
select ProductName, Price
from products
order by price desc
limit 5 offset 4;

-- 16. Select name of the cheapest product (only name) without using LIMIT and OFFSET.
select ProductName
from products
where ProductID = 33
order by price; 

-- 17. Select name of the cheapest product (only name) using subquery.
select ProductName 
from products
where Price = (
	select min(price) 
    from products);

-- 18. Select number of employees with LastName that starts with 'D'.
select count(LastName) as TotalEmployees
from employees
where LastName like 'D%';

-- 19. Select customer name together with the number of orders made by the corresponding 
-- customer, sort the result by number of orders in decreasing order.
select CustomerName, count(OrderID)
from customers
join orders using (CustomerID)
group by Customername
order by count(OrderID) desc;

-- 20. Add up the price of all products.
select sum(price)
from products;

-- 21. Select orderID together with the total price of that Order, order the result by total 
-- price of order in increasing order
select O.OrderID, sum(price)
from orders as O
left join order_details as OD using (OrderID)
left join products as P using (ProductID)
group by O.OrderID
order by sum(price) asc;

-- 22. Select customer who spends the most money.
select CustomerID, CustomerName, sum(P.price)
from customers
inner join orders as O using(CustomerID)
inner join order_details as OD using(OrderID)
inner join products as P using(ProductID)
group by CustomerID
order by sum(P.price * OD.Quantity)desc
limit 5;

select customerName, sum(p.price * od.quantity) as "Total Amt Spent"
from customers
inner join orders as O using(CustomerID)
inner join order_details as OD using(OrderID)
inner join products as P using(ProductID)
group by CustomerID
order by sum(P.price * OD.Quantity) desc
limit 5;


-- 23. Select customer who spend the most money and lives in Canada.
select customerName, sum(p.price * od.quantity) as "Total Amt Spent"
from customers
inner join orders as O using(CustomerID)
inner join order_details as OD using(OrderID)
inner join products as P using(ProductID)
group by CustomerID
order by sum(P.price * OD.Quantity) desc
limit 5;


-- 24. Select customer who spend the second most money. 
select customerName, sum(p.price * od.quantity) as "Total Amt Spent"
from customers
inner join orders as O using(CustomerID)
inner join order_details as OD using(OrderID)
inner join products as P using(ProductID)
group by CustomerID
order by sum(P.price * OD.Quantity) desc
limit 1 offset 1;


-- 25. Select shipper together with the total price of proceed orders.
select ShipperName, sum(P.price) as Total_price
from shippers
left join orders as O using(ShipperID)
left join order_details as OD using(OrderID)
left join products as P using(ProductID)
group by ShipperName
order by sum(P.price);





