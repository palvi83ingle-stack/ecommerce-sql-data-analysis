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
