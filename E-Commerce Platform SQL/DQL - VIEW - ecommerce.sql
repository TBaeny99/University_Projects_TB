CREATE VIEW Sales_Inventory_Promotions_Overview AS
SELECT 
    P.ProductID,
    P.ProductName,
    COALESCE(B.BrandName, 'N/A') AS BrandName,
    COALESCE(C.CategoryName, 'N/A') AS CategoryName,
    COALESCE(PL.PlatformName, 'N/A') AS PlatformName,
    P.Price,
    P.StockQuantity AS CurrentInventory,
    COALESCE(SUM(OD.Quantity), 0) AS TotalUnitsSold,
    COALESCE(SUM(OD.Quantity * OD.UnitPrice), 0.00) AS TotalSales,
    COALESCE(PR.Name, 'No Active Promotion') AS ActivePromotion,
    COALESCE(PR.DiscountPercentage, 0.00) AS DiscountPercentage,
    COALESCE(PR.StartDate, '1900-01-01') AS PromotionStartDate,
    COALESCE(PR.EndDate, '1900-01-01') AS PromotionEndDate
FROM 
    Products P
    LEFT JOIN Brands B ON P.BrandID = B.BrandID
    LEFT JOIN Categories C ON P.CategoryID = C.CategoryID
    LEFT JOIN Platforms PL ON P.PlatformID = PL.PlatformID
    LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
    LEFT JOIN Orders O ON OD.OrderID = O.OrderID
    LEFT JOIN Promotions_Products PP ON P.ProductID = PP.ProductID
    LEFT JOIN Promotions PR ON PP.PromotionID = PR.PromotionID AND PR.IsActive = TRUE
GROUP BY 
    P.ProductID, 
    P.ProductName, 
    B.BrandName, 
    C.CategoryName, 
    PL.PlatformName,
    P.Price,
    P.StockQuantity,
    PR.Name, 
    PR.DiscountPercentage, 
    PR.StartDate, 
    PR.EndDate
ORDER BY 
    TotalSales DESC;



-- Retrieve data from the view
SELECT * FROM Sales_Inventory_Promotions_Overview;

