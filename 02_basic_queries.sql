#FIND THE PERTICULAR CITY#
SELECT*FROM CUSTOMERS_CLEANED WHERE CITY = 'MUMBAI';
#SORTING HIGHEST PRICED PRODUCTS#
SELECT*FROM PRODUCTS ORDER BY Selling_Price DESC;
#SORTING LOWEST PRICE PRODUCT#
SELECT*FROM PRODUCTS ORDER BY Selling_Price ASC;
#DISTINCT :Find unique cities#
SELECT DISTINCT City
FROM CUSTOMERS_CLEANED;
#Unique product categories#
SELECT DISTINCT Category
FROM PRODUCTS;
#Unique payment modes#
SELECT DISTINCT Payment_Mode
FROM Sales;
# WHERE — filtering data#
SELECT *
FROM CUSTOMERS_CLEANED
WHERE Age > 30;
#Products costing more than 1000#
SELECT *
FROM Products
WHERE Selling_Price > 1000;
#Orders with successful status#
SELECT *
FROM Sales
WHERE Order_Status = 'Delivered';
#Multiple conditions#
SELECT *
FROM CUSTOMERS_CLEANED
WHERE Age > 30
AND Customer_Tier = 'Gold';
#USING OR#
SELECT *
FROM Products
WHERE Category = 'Electronics'
OR Category = 'Beauty';
# ORDER BY:Highest-selling products#
SELECT Product_Name, Selling_Price
FROM Products
ORDER BY Selling_Price DESC;
#Youngest customers first#
SELECT ï»¿Customer_ID, Age
FROM CUSTOMERS_CLEANED
ORDER BY Age ASC;
#Highest-value orders#
SELECT ï»¿Order_ID, Total_Amount
FROM Sales
ORDER BY Total_Amount DESC;
# LIMIT:Top 10 expensive products#
SELECT Product_Name, Selling_Price
FROM Products
ORDER BY Selling_Price DESC
LIMIT 10;
#Top 10 highest-value orders#
SELECT ï»¿Order_ID , Total_Amount
FROM Sales
ORDER BY Total_Amount DESC
LIMIT 10;

#"Identified the top 10 highest-value orders using sorting and limiting."#