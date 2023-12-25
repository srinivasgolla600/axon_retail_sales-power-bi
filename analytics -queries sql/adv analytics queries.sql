

select count(customerNumber) from customers;#no.of customers 122

select * from orderdetails order by quantityordered desc limit 5;   #product that orders in hightest quantity


/* top 5 products with theis  details*/
SELECT
  od.productCode,p.productname,p.MSRP,p.buyPrice,
  SUM(od.quantityordered) AS totalQuantityOrdered,
  COUNT(*) AS orderCount
FROM orderdetails od
join products p on p.productCode=od.productCode
GROUP BY productCode
ORDER BY totalQuantityOrdered DESC
LIMIT 5;


/*  what takes long time ti deliver to usa */
select c.customerName,p.productLine ,DATEDIFF(o.requireddate, o.shippeddate) AS delivery_time from customers c 
join orders o on c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber=od.orderNumber
join products p on od.productCode=p.productCode
where c.country = 'usa' group by c.customerName ,p.productLine,delivery_time order by delivery_time desc;


/* who orders most from usa   ..like wise find other countries also*/
SELECT customerName, COUNT(orderNumber) AS totalOrders,country 
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
WHERE customers.country = 'USA'
GROUP BY customerName
ORDER BY totalOrders DESC;


/* what product usa buys the most */
SELECT c.customerName, p.productLine, COUNT(*) AS totalProductsPurchased
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE c.country = 'USA'
GROUP BY c.customerName, p.productLine
ORDER BY totalProductsPurchased DESC;


/* who is the top sales representative  */

SELECT e.employeeNumber, concat(e.firstName, e.lastName) as EmployeeName, SUM(p.amount) AS total_sales
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber, e.firstName, e.lastName
ORDER BY total_sales DESC;



/*salerep with no.of customers*/
SELECT c.salesRepEmployeeNumber, COUNT(*) as total_customers, SUM(p.amount) as total_sales
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.salesRepEmployeeNumber;



select customerNumber, sum(amount) as total_payment from payments 
group by customerNumber order by total_payment desc limit 5; #customer who spend the most 


SELECT customerNumber, COUNT(*) as payment_count
FROM payments
GROUP BY customerNumber
ORDER BY payment_count DESC;   #customer who buys more frequently



#sales by year
SELECT YEAR(paymentDate) as salesYear, SUM(amount) as totalSales
FROM payments
GROUP BY salesYear
ORDER BY totalSales DESC;


#sales by month
SELECT month(paymentDate) as salesmonth, SUM(amount) as totalSales
FROM payments
GROUP BY salesmonth
ORDER BY totalSales DESC;



#sales by weekday
SELECT weekday(paymentDate) as salesweek,DATE_FORMAT(paymentDate, '%W') AS salesWeekday, SUM(amount) as totalSales
FROM payments
GROUP BY salesweek,salesWeekday
ORDER BY totalSales DESC;


/* average order value */
select avg(amount) FROM payments;


SELECT avg(DATEDIFF(shippeddate, orderdate)) AS processing_time
FROM orders; #average processing time 3.75



SELECT avg(DATEDIFF(requireddate, shippeddate)) AS delivery_time
FROM orders where status = "shipped"; #average delivery time 4.4327 ->with only shipped 4.4191


SELECT avg(DATEDIFF(o.orderdate, p.paymentdate)) AS payment_time
FROM orders o join payments p on o.customerNumber=p.customerNumber 
;#16.3704 avg payment time


select distinct(status) ,count(*), (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS status_percentage from orders group by status; 
 #Value counts of status


select count(distinct(ordernumber))  from orders;#total orders 326


select o.customerNumber,o.orderNumber,o.orderdate,o.requiredDate,o.shippedDate,o.status,p.paymentdate,
datediff(o.requireddate,o.shippeddate) as deliverytime ,datediff(o.orderdate,p.paymentdate) as paymenttime from orders o 
join payments p  on o.customernumber=p.customernumber  
where o.status = "shipped"; #delivery time ,payment time


select (quantityOrdered*priceEach)  as totalsales from orderdetails;
select sum((quantityOrdered*priceEach) ) as totalsales from orderdetails; #total sales->9604190.61



select * from orderdetails;
select * from products;


select o.orderNumber,o.quantityOrdered,o.productcode ,o.priceEach,p.productname,p.buyprice ,(o.priceEach-p.buyPrice) as profit 
 from orderdetails o join products p on o.productCode = p.productCode;  #profit of eact order
 
 select o.orderNumber,o.quantityOrdered,o.productcode ,o.priceEach,p.productname,p.buyprice ,(o.priceEach-p.buyPrice) as profitEach ,
 ((o.priceEach-p.buyPrice) *o.quantityOrdered) as totprfit
 from orderdetails o join products p on o.productCode = p.productCode; 
 
 select sum((o.priceEach-p.buyPrice) *o.quantityOrdered)as TOTALprofit 
 from orderdetails o join products p on o.productCode = p.productCode; #total profit->3825880.25
 
 select * from orders;
 
 
CREATE VIEW SalesPerYear AS
SELECT YEAR(paymentDate) AS salesYear, SUM(amount) AS totalSales
FROM payments
GROUP BY salesYear
ORDER BY totalSales DESC;
select * from salesperyear;


 CREATE VIEW Top5Products AS
SELECT
  od.productCode, p.productName, p.MSRP, p.buyPrice,
  SUM(od.quantityOrdered) AS totalQuantityOrdered,
  COUNT(*) AS orderCount
FROM orderDetails od
JOIN products p ON p.productCode = od.productCode
GROUP BY od.productCode
ORDER BY totalQuantityOrdered DESC
LIMIT 5;


select * from top5products;





CREATE VIEW TopSalesRepresentative AS
SELECT e.employeeNumber, CONCAT(e.firstName, ' ', e.lastName) AS EmployeeName, SUM(p.amount) AS total_sales
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber, e.firstName, e.lastName
ORDER BY total_sales DESC;


select * from topsalesRepresentative;

