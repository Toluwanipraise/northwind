SELECT od.*, (od.UnitPrice-od.Discount*od.UnitPrice)*od.Quantity
FROM "Order Details" od 
JOIN Orders o 
ON od.OrderID =o.OrderID

--Using subquery I created a query to get the to total sales and the total discounting then subtrated the discount for the total sales to get the actual_sales
SELECT order_date, sales - total_discount as actual_sales, ordered_country
FROM (SELECT o."OrderDate" order_date ,o."ShipCountry" ordered_country , (od."UnitPrice" * od."Quantity") sales, (od."UnitPrice" * od."Quantity") * od."Discount" as total_discount
FROM "Order Details" od 
JOIN Orders o ON od."OrderID" = o."OrderID") 


-- I will now create a temp table as sales report with the imformation recovered from the first qwery
DROP TABLE IF EXIST 'sales_report';
CREATE TEMP TABLE 'sales_report' AS 
SELECT order_date, sales - total_discount as actual_sales, ordered_country
FROM (SELECT o."OrderDate" order_date ,o."ShipCountry" ordered_country , (od."UnitPrice" * od."Quantity") sales, (od."UnitPrice" * od."Quantity") * od."Discount" as total_discount
FROM "Order Details" od 
JOIN Orders o ON od."OrderID" = o."OrderID") 

--Calling the table just created 
SELECT *
FROM sales_report

--the order_date table cant the use easily with the way it is formatted (since we only need sales based on 2016,2017 and 2018) all the tears in the database
-- the order_date column will be formatted yearly using STRFTIME FUNCTION

SELECT  strftime('%Y', order_date) as year, *
FROM sales_report


--Create a temp Table  yearly_sales_report

DROP TABLE IF EXIST 'yearly_sales_report';
CREATE TEMP TABLE 'yearly_sales_report' AS 
SELECT  strftime('%Y', order_date) as year, actual_sales, ordered_country
FROM sales_report

--caliing the just created table
SELECT *
FROM yearly_sales_report
WHERE year IN (2016, 2017, 2018)

--next step ranking low sales region, medium sales region and 


SELECT *
FROM "Orders" o 
JOIN "Order Details" od 
ON o."OrderID" = od."OrderID"

SELECT *
FROM "Suppliers"

