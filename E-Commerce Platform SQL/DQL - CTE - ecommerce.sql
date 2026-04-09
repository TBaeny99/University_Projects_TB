WITH CustomerSpending AS (
    SELECT 
        C.CustomerID,
        CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
        SUM(O.TotalAmount) AS TotalSpent
    FROM 
        Customers C
        INNER JOIN Orders O ON C.CustomerID = O.CustomerID
    GROUP BY 
        C.CustomerID, C.FirstName, C.LastName
)

SELECT 
    CS.CustomerID,
    CS.CustomerName,
    CS.TotalSpent,
    COUNT(DISTINCT O.OrderID) AS TotalOrders,
    MAX(P.PaymentMethod) AS MostRecentPaymentMethod,
    COUNT(R.ReviewID) AS TotalReviews,
    COALESCE(ROUND(AVG(R.Rating), 2),0) AS AverageRating
FROM 
    CustomerSpending CS
    LEFT JOIN Orders O ON CS.CustomerID = O.CustomerID
    LEFT JOIN Payments P ON O.OrderID = P.OrderID
    LEFT JOIN Reviews R ON O.CustomerID = R.CustomerID
GROUP BY 
    CS.CustomerID, CS.CustomerName, CS.TotalSpent
ORDER BY 
    CS.TotalSpent DESC;




