SELECT 
    O.OrderID,
    CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
    C.Email AS CustomerEmail,
    E.Name AS AssignedEmployee,
    S.ShipmentStatus,
    O.OrderStatus,
    S.ShipmentDate,
    O.OrderDate,
    DATEDIFF(CURDATE(), O.OrderDate) AS DaysSinceOrder
FROM 
    Orders O
    LEFT JOIN Shipments S ON O.OrderID = S.OrderID
    INNER JOIN Customers C ON O.CustomerID = C.CustomerID
    LEFT JOIN Employees E ON S.EmployeeID = E.EmployeeID
WHERE 
    O.OrderStatus = 'Pending' 
    OR S.ShipmentStatus IS NULL -- in case shipment record do not exists yet
ORDER BY 
    O.OrderDate ASC, DaysSinceOrder DESC;


