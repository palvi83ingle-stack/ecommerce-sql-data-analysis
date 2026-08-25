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
