--  Write a query to retrieve all orders shipped to the state of "California" that used "Second Class" shipping mode. Include `Order ID`, `Customer Name`, `Sales`, and `Profit`.
SELECT OrderID, CustomerName, Sales, Profit
from superstores
where  state = "California" and ShipMode = "Second Class";

--  Find all orders placed between "2013-01-01" and "2013-12-31" where the `Category` is "Furniture" and the `Profit` is greater than 100. Display the `Order ID`, `Order Date`, `Product Name`, and `Profit`
select  OrderID, OrderDate, ProductName, Profit from superstores
where orderdate between '2013-01-01' and '2013-12-31'  and
category = 'Furniture' and 
Profit > 100;

--  Write a query to list all unique `Ship Modes` and the number of orders shipped through each mode, sorted in descending order of order count
SELECT distinct(shipmode) ship_mode, COUNT(Quantity) Quantity
FROM superstores
GROUP BY ship_mode, Quantity
ORDER BY Quantity DESC;

--  Calculate the total `Sales` and `Profit` for each `Category` and `Sub-Category`. Display the results in descending order of total `Sales`.
select sum(sales) as total_sales, sum(profit) as total_profit, Category, SubCategory
from superstores
group by Category, SubCategory
order by total_sales;

--  Find the top 3 customers in terms of total `Sales` in each `Region`. Display `Customer Name`, `Region`, and `Total Sales`
select CustomerName, Region, sum(sales) total_sales
from superstores
group by CustomerName, Region
order by total_sales desc
limit 3;

--  Write a query to determine which `City` has the highest average `Profit` per order, and display the top 5 cities with the highest average.
select city, avg(profit)
from superstores
group by city
order by city
limit 5;

--  Write a query to find the `Product Name` and `Category` of the most frequently ordered product (the one with the highest total `Quantity`).
select ProductName, Category, sum(quantity) total_quantity
from superstores
group by ProductName, Category
order by total_quantity desc
limit 1;

--  Use a subquery to find all orders where the `Sales` amount is greater than the average `Sales` for that specific `Category`.
SELECT orderid, productid, sales, category
FROM superstores
WHERE sales > (SELECT AVG(sales) FROM superstores WHERE category = category);

--  Write a query to find customers who have placed orders in both the "Corporate" and "Consumer" segments. Display their `Customer ID` and `Customer Name`.
select CustomerID, CustomerName
from superstores
where Segment = "Corporate" or Segment = "Consumer";

--  Update the Ship Mode of all orders shipped in "Kentucky" with a Discount of 0 to "Standard Class".
UPDATE superstores
SET shipmode = "Standard Class"
where state = "Kentucky" AND discount = 0;

-- write a query to adjust the Discount to 0.3 for all products in the "Office Supplies" category that have a Profit less than zero
UPDATE superstores
SET discount = 0.3
WHERE category = 'Office Supplies' and profit < 0;

--  Write a query to increase the `Quantity` by 1 for all orders that have `Sales` greater than 500 but have a `Quantity` of 2 or less.
update superstores 
set quantity = quantity + 1
where sales > 500 and quantity <= 2;

--  Find orders where the `Profit` is negative, but the `Sales` amount is above the average `Sales` of all orders. Display `Order ID`, `Customer Name`, `Sales`, and `Profit`.
select OrderID, CustomerName, Sales, Profit
from superstores
where profit < 0 and sales > (select avg(sales) from superstores);

--  Write a query to calculate the `Profit` margin (as `Profit/Sales`) for each `Product ID` and find the top 5 products with the highest profit margin.
select productid, (profit/sales) as profit_margin
from superstores
where sales != 0
order by profit_margin desc
limit 5;

--  Write a query to find all Order IDs where the Ship Date is more than 5 days after the Order Date. Display Order ID, Order Date, Ship Date, and the days difference.
SELECT orderid, orderdate, shipdate, DATEDIFF('shipdate', 'orderdate') AS days_difference
FROM superstores
WHERE DATEDIFF(shipdate, orderdate) > 5;

SELECT YEAR(orderdate) AS Year, segment, SUM(sales) AS Total_Sales, SUM(profit) AS Total_Profit 
FROM superstores
GROUP BY YEAR(orderdate), segment
ORDER BY Year, segment;

--  Identify the `Sub-Category` with the most orders where `Discount` was applied. Display the `SubCategory`, the total number of such orders, and the average `Discount` given in those cases.
SELECT subcategory, COUNT(orderid) AS total_orders,  AVG(discount) AS average_discount
FROM superstores
WHERE discount > 0
GROUP BY subcategory
ORDER BY total_orders DESC
LIMIT 1;      