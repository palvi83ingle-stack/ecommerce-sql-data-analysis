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
