
-- Customer Segmentation
SELECT 
	c.CustomerID, 
    c.FirstName, 
    c.LastName, 
    COUNT(o.OrderID) AS NumberOfOrders, 
	SUM(o.TotalAmount) AS TotalSpent, 
    MAX(o.OrderDate) AS LastOrderDate
FROM 
	ecommerce.Customers c
LEFT JOIN 
	ecommerce.Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
	c.CustomerID
ORDER BY 
	TotalSpent DESC;
    
 -- Sales Forecasting
 
 SELECT 
	YEAR(o.OrderDate) AS Year, 
    MONTH(o.OrderDate) AS Month, 
	SUM(od.Quantity * od.UnitPrice) AS MonthlySales
FROM 
	ecommerce.Orders o
JOIN 
	ecommerce.OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
	YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY 
	Year DESC, Month DESC;

-- Product Recommendations

SELECT 
	od1.ProductID AS BoughtProductID, 
	od2.ProductID AS RecommendedProductID, 
	COUNT(*) AS CoPurchaseCount
FROM 
	ecommerce.OrderDetails od1
JOIN 
	ecommerce.OrderDetails od2 ON od1.OrderID = od2.OrderID AND od1.ProductID <> od2.ProductID
GROUP BY 
	od1.ProductID, od2.ProductID
ORDER BY 
	CoPurchaseCount DESC;


-- Sentiment Analysis on Reviews

SELECT 
	r.ProductID, 
    p.ProductName, 
    r.Rating, r.Comment
FROM 
	ecommerce.Reviews r
JOIN 
	ecommerce.Products p ON r.ProductID = p.ProductID
WHERE 
	r.Comment IS NOT NULL;


-- Inventory Optimization

SELECT 
	p.ProductID, 
    p.ProductName, 
    p.StockQuantity, 
	SUM(od.Quantity) AS TotalSold, 
    MAX(o.OrderDate) AS LastSoldDate
FROM 
	ecommerce.Products p
LEFT JOIN 
	ecommerce.OrderDetails od ON p.ProductID = od.ProductID
LEFT JOIN 
	ecommerce.Orders o ON od.OrderID = o.OrderID
GROUP BY 
	p.ProductID, p.ProductName, p.StockQuantity
ORDER BY 
	TotalSold DESC;


-- Promotion Effectiveness

SELECT 
	pp.PromotionID, 
    p.Name AS PromotionName, 
    SUM(od.Quantity * od.UnitPrice) AS TotalSalesDuringPromotion
FROM 
	ecommerce.Promotions_Products pp
JOIN 
	ecommerce.Promotions p ON pp.PromotionID = p.PromotionID
JOIN 
	ecommerce.OrderDetails od ON pp.ProductID = od.ProductID
JOIN 
	ecommerce.Orders o ON od.OrderID = o.OrderID
WHERE 
	o.OrderDate BETWEEN p.StartDate AND p.EndDate
GROUP BY 
	pp.PromotionID, p.Name
ORDER BY 
	TotalSalesDuringPromotion DESC;


-- Churn Prediction

SELECT c.CustomerID, c.FirstName, c.LastName, 
       MAX(o.OrderDate) AS LastOrderDate, 
       DATEDIFF(CURDATE(), MAX(o.OrderDate)) AS DaysSinceLastOrder, 
       SUM(o.TotalAmount) AS TotalSpent
FROM 
	ecommerce.Customers c
LEFT JOIN 
	ecommerce.Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
	c.CustomerID
ORDER BY 
	DaysSinceLastOrder DESC;

-- 



