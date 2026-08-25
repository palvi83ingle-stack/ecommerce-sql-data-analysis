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
