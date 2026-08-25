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
