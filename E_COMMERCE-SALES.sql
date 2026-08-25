CREATE DATABASE indian_ecommerce_sale;
SHOW TABLES;
CREATE TABLE CUSTOMERS_CLEANED
AS
SELECT ï»¿Customer_ID,Gender,Age,Age_Group,City,State,Registration_Date,Customer_Tier,
Total_Orders,Total_Spent
FROM CUSTOMERS;
SELECT*FROM PRODUCTS;
SELECT*FROM SALES;
DESCRIBE CUSTOMERS_CLEANED;
DESCRIBE PRODUCTS;
DESCRIBE SALES;
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

 #Aggregate functions#
 
#COUNT:Number of customers#
SELECT COUNT(*) AS Total_CUSTOMERS
FROM CUSTOMERS_CLEANED;

#Number of products#
SELECT COUNT(*) AS Total_Products
FROM Products;

#Number of orders#
SELECT COUNT(*) AS Total_Orders
FROM Sales;

#SUM#
#Total sales#
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Sales;

#Total quantity sold#
SELECT SUM(Quantity) AS Total_Quantity_Sold
FROM Sales;

#AVG#
#Average order value#
SELECT AVG(Total_Amount) AS Average_Order_Value
FROM Sales;

#Average product rating#
SELECT AVG(Avg_Rating) AS Average_Product_Rating
FROM Products;

#products MIN and MAX#
SELECT 
    MIN(Selling_Price) AS Minimum_Price,
    MAX(Selling_Price) AS Maximum_Price
FROM Products;

#GROUP BY#
#Sales by payment mode#
SELECT 
    Payment_Mode,
    COUNT(*) AS Number_of_Orders,
    SUM(Total_Amount) AS Total_Sales
FROM Sales
GROUP BY Payment_Mode ;

#Sales by city#
SELECT 
    City,
    COUNT(*) AS Number_of_Orders,
    SUM(Total_Amount) AS Total_Sales
FROM Sales
GROUP BY City
ORDER BY Total_Sales DESC;

#Sales by state#
SELECT 
    State,
    COUNT(*) AS Number_of_Orders,
    SUM(Total_Amount) AS Total_Sales
FROM Sales
GROUP BY State
ORDER BY Total_Sales DESC;

#Sales by order status#
SELECT 
    Order_Status,
    COUNT(*) AS Number_of_Orders,
    SUM(Total_Amount) AS Total_Amount
FROM Sales
GROUP BY Order_Status;

# HAVING WHERE filters individual rows:
#HAVING filters groups#
#For example, cities generating more than ₹100,000#
SELECT 
    City,
    SUM(Total_Amount) AS Total_Sales
FROM Sales
GROUP BY City
HAVING SUM(Total_Amount) > 100000
ORDER BY Total_Sales DESC;

#CASE statement#
#For example, classify orders#
SELECT 
    ï»¿Order_ID ,
    Total_Amount,
    CASE
        WHEN Total_Amount >= 5000 THEN 'High Value'
        WHEN Total_Amount >= 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Order_Category
FROM Sales;

#Customer classification#
SELECT
    ï»¿Customer_ID,
    Age,
    CASE
        WHEN Age < 25 THEN 'Young'
        WHEN Age BETWEEN 25 AND 40 THEN 'Adult'
        ELSE 'Senior'
    END AS Age_Category
FROM CUSTOMERS_CLEANED;
#Date functions#
#Sales by year#
SELECT
    YEAR(Order_Date) AS Order_Year,
    SUM(Total_Amount) AS Total_Sales
FROM Sales
GROUP BY YEAR(Order_Date)
ORDER BY Order_Year;

#Sales by month#
SELECT
    MONTH(Order_Date) AS Order_Month,
    SUM(Total_Amount) AS Total_Sales
FROM Sales
GROUP BY MONTH(Order_Date)
ORDER BY Order_Month;

#Sales by year and month
SELECT
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,
    SUM(Total_Amount) AS Total_Sales
FROM Sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Order_Year, Order_Month;


#join:
#Customer_Cleaned → Sales
#CUSTOMERS_CLEANED.ï»¿Customer_ID = Sales.Customer_ID
#And:
#Sales → Products
#using:
#Sales.Product_ID = Products.ï»¿Product_ID
#INNER JOIN — Customer + Sales#
SELECT
    c.ï»¿Customer_ID,
    c.Gender,
    c.Age,
    c.City,
    s.ï»¿Order_ID,
    s.Order_Date,
    s.Quantity,
    s.Total_Amount
FROM CUSTOMERS_CLEANED c
INNER JOIN Sales s
    ON c.ï»¿Customer_ID = s.Customer_ID;

# Customer + Sales + Products
SELECT
    c.ï»¿Customer_ID ,
    c.Gender,
    c.Age_Group,
    c.City,
    s.ï»¿Order_ID,
    s.Order_Date,
    p.Product_Name,
    p.Category,
    p.Brand,
    s.Quantity,
    s.Unit_Price,
    s.Total_Amount
FROM Sales s
INNER JOIN CUSTOMERS_CLEANED c
    ON s.Customer_ID= c.ï»¿Customer_ID
INNER JOIN Products p
    ON s.Product_ID = p.ï»¿Product_ID;

#Customer → Order → Product → Amount
# Find best-selling products
SELECT
    p.ï»¿Product_ID,
    p.Product_Name,
    p.Category,
    SUM(s.Quantity) AS Total_Quantity_Sold,
    SUM(s.Total_Amount) AS Total_Revenue
FROM Sales s
INNER JOIN Products p
    ON s.Product_ID = p.ï»¿Product_ID
GROUP BY
    p.ï»¿Product_ID,
    p.Product_Name,
    p.Category
ORDER BY Total_Revenue DESC;

# Best customers by revenue#
SELECT
    c.ï»¿Customer_ID,
    c.City,
    c.Customer_Tier,
    COUNT(s.ï»¿Order_ID) AS Number_of_Orders,
    SUM(s.Total_Amount) AS Total_Spent
FROM CUSTOMERS_CLEANED c
INNER JOIN Sales s
    ON c.ï»¿Customer_ID = s.Customer_ID
GROUP BY
    c.ï»¿Customer_ID,
    c.City,
    c.Customer_Tier
ORDER BY Total_Spent DESC;

#Customer Revenue Analysis#
#Sales by product category
SELECT
    p.Category,
    COUNT(s.ï»¿Order_ID) AS Number_of_Orders,
    SUM(s.Quantity) AS Units_Sold,
    SUM(s.Total_Amount) AS Revenue
FROM Sales s
INNER JOIN Products p
    ON s.Product_ID = p.ï»¿Product_ID
GROUP BY p.Category
ORDER BY Revenue DESC;

# Sales by customer age group
SELECT
    c.Age_Group,
    COUNT(s.ï»¿Order_ID) AS Number_of_Orders,
    SUM(s.Total_Amount) AS Total_Revenue
FROM Sales s
INNER JOIN CUSTOMERS_CLEANED c
    ON s.Customer_ID = c.ï»¿Customer_ID
GROUP BY c.Age_Group
ORDER BY Total_Revenue DESC;

#Sales by customer tier
SELECT
    c.Customer_Tier,
    COUNT(s.ï»¿Order_ID) AS Number_of_Orders,
    SUM(s.Total_Amount) AS Total_Revenue,
    AVG(s.Total_Amount) AS Average_Order_Value
FROM Sales s
INNER JOIN CUSTOMERS_CLEANED c
    ON s.Customer_ID = c.ï»¿Customer_ID
GROUP BY c.Customer_Tier
ORDER BY Total_Revenue DESC;

#LEFT JOIN#
#Suppose you want to find customers who may not have placed any orders#
SELECT
    c.ï»¿Customer_ID,
    c.City,
    c.Customer_Tier,
    s.ï»¿Order_ID
FROM CUSTOMERS_CLEANED c
LEFT JOIN Sales s
    ON c.ï»¿Customer_ID = s.Customer_ID;

#To find customers with no orders#
SELECT c.ï»¿Customer_ID ,
    c.City,
    c.Customer_Tier
FROM CUSTOMERS_CLEANED c
LEFT JOIN Sales s
    ON c.ï»¿Customer_ID = s.Customer_ID
WHERE s.ï»¿Order_ID  IS NULL;

# Product performance analysis
# identify products that have been sold and their ratings#
SELECT
    p.ï»¿Product_ID,
    p.Product_Name,
    p.Category,
    p.Avg_Rating,
    p.Total_Reviews,
    SUM(s.Quantity) AS Units_Sold,
    SUM(s.Total_Amount) AS Revenue
FROM Products p
LEFT JOIN Sales s
    ON p.ï»¿Product_ID = s.Product_ID
GROUP BY
    p.ï»¿Product_ID,
    p.Product_Name,
    p.Category,
    p.Avg_Rating,
    p.Total_Reviews
ORDER BY Revenue DESC;

# Discount analysis#
# Products table has#
#Original Price,Discount Price,Discount Amount,Selling Price#
# analyze discounts#
SELECT
    Product_Name,
    Original_Price,
    Discount_Amount,
    Selling_Price,
    ROUND(
        (Discount_Amount / Original_Price) * 100,
        2
    ) AS Discount_Percentage
FROM Products;

#Finding products with discounts greater than 20%:
SELECT
    Product_Name,
    Original_Price,
    Selling_Price,
    ROUND(
        (Discount_Amount / Original_Price) * 100,
        2
    ) AS Discount_Percentage
FROM Products
WHERE (Discount_Amount / Original_Price) * 100 > 20;

# NULL handling 
#Check missing coupon codes
SELECT *
FROM Sales
WHERE Coupon_Code IS NULL;

#Check missing reviews
SELECT *
FROM Sales
WHERE Review_Text IS NULL;

#Count missing values:
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(Coupon_Code) AS Coupon_Records,
    COUNT(Review_Text) AS Review_Records
FROM Sales;

# COALESCE
# replace NULL values.
SELECT
    ï»¿Order_ID,
    COALESCE(Coupon_Code, 'No Coupon') AS Coupon
FROM Sales;

# Subquery
#Find customers who spent more than the average customer spend.
SELECT
    ï»¿Customer_ID ,
    Total_Spent
FROM CUSTOMERS_CLEANED
WHERE Total_Spent >
(
    SELECT AVG(Total_Spent)
    FROM CUSTOMERS_CLEANED
);

# Window Function — advanced SQL
SELECT 
 ï»¿Customer_ID,
    Total_Spent,
    RANK() OVER (
        ORDER BY Total_Spent DESC
    ) AS Customer_Rank
FROM CUSTOMERS_CLEANED;


WITH ProductSales AS
(
    SELECT
        p.ï»¿Product_ID,
        p.Product_Name,
        SUM(s.Total_Amount) AS Revenue
    FROM Products p
    INNER JOIN Sales s
        ON p.ï»¿Product_ID = s.Product_ID
    GROUP BY
        p.ï»¿Product_ID,
        p.Product_Name
)

SELECT
    ï»¿Product_ID,
    Product_Name,
    Revenue,
    RANK() OVER (
        ORDER BY Revenue DESC
    ) AS Revenue_Rank
FROM ProductSales;

WITH CustomerSales AS
(
    SELECT
        c.ï»¿Customer_ID,
        c.City,
        c.Customer_Tier,
        SUM(s.Total_Amount) AS Total_Sales
    FROM CUSTOMERS_CLEANED c
    INNER JOIN Sales s
        ON c.ï»¿Customer_ID = s.Customer_ID
    GROUP BY
        c.ï»¿Customer_ID,
        c.City,
        c.Customer_Tier
)
SELECT *
FROM CustomerSales
ORDER BY Total_Sales DESC;



