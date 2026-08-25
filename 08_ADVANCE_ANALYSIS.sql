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



