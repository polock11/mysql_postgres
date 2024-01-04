with cte_1 as (
    SELECT 
    CONCAT("Cl1: ", COUNT(OrderID), "orders") AS "Total number of orders" FROM Orders WHERE YEAR(Date) = 2022 AND ClientID = "Cl1" 
), cte_2 as (
    SELECT CONCAT("Cl2: ", COUNT(OrderID), "orders") FROM Orders WHERE YEAR(Date) = 2022 AND ClientID = "Cl2" 
), cte_3 as(
    SELECT CONCAT("Cl3: ", COUNT(OrderID), "orders") FROM Orders WHERE YEAR(Date) = 2022 AND ClientID = "Cl3" 
)   SELECT * from cte_1
    UNION
    SELECT * from cte_2
    UNION
    SELECT * from cte_3;




SELECT Activity.Properties ->>'$.ProductID' 
AS ProductID, Products.ProductName, Products.BuyPrice, Products.SellPrice 
FROM Products INNER JOIN Activity 
ON Products.ProductID = Activity.Properties ->>'$.ProductID' 
WHERE Activity.Properties ->>'$.Order' = "True";
