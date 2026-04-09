SELECT 
    S.SupplierID,
    S.SupplierName,
    COUNT(DISTINCT SP.ProductID) AS TotalProductsSupplied,
    SUM(P.StockQuantity) AS TotalStockAvailable,
    ROUND(AVG(R.Rating), 2) AS AverageProductRating,
    COUNT(DISTINCT PR.PromotionID) AS PromotionsActive
FROM 
    Suppliers S
    INNER JOIN Supplier_Products SP ON S.SupplierID = SP.SupplierID
    INNER JOIN Products P ON SP.ProductID = P.ProductID
    LEFT JOIN Reviews R ON P.ProductID = R.ProductID
    LEFT JOIN Promotions_Products PP ON P.ProductID = PP.ProductID
    LEFT JOIN Promotions PR ON PP.PromotionID = PR.PromotionID AND PR.IsActive = TRUE
GROUP BY 
    S.SupplierID, S.SupplierName
ORDER BY 
    TotalProductsSupplied DESC, AverageProductRating DESC;




