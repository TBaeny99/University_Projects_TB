-- Insert new department
INSERT INTO Departments (DepartmentName, DepartmentDescription) 
VALUES ('Logistics', 'Handles product shipping and delivery.');

-- Insert a new employee into the Logistics department
INSERT INTO Employees (EmployeeID, Name, DepartmentID, Position, Salary, HireDate)
VALUES (1000000031, 'Olivia Martinez', 6, 'Logistics Manager', 58000.00, '2024-03-20');

-- Insert a new customer
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address, Country, City)
VALUES (2000000031, 'Liam', 'Baker', 'liam.baker@example.com', '555-1230', '300 Elm St', 'USA', 'Denver');

-- Insert a new product
INSERT INTO Products (ProductName, ProductDescription, Price, StockQuantity, BrandID, CategoryID, PlatformID)
VALUES ('Google Pixel 7', 'Google flagship smartphone with excellent camera.', 799.99, 120, 2, 1, 1);

-- Insert a new order with payment and shipment
INSERT INTO Orders (EmployeeID, CustomerID, OrderDate, OrderStatus, TotalAmount)
VALUES (1000000031, 2000000031, '2024-03-30', 'Pending', 799.99);

-- Get the new OrderID (assuming auto-increment starts from 16 here)
INSERT INTO Payments (OrderID, PaymentDate, PaymentAmount, PaymentMethod)
VALUES (16, '2024-03-30', 799.99, 'Credit Card');

INSERT INTO Shipments (OrderID, EmployeeID, ShipmentDate, TrackingNumber, ShipmentStatus)
VALUES (16, 1000000031, '2024-03-31', 'TRACK016', 'Pending');

-- Update product stock after the new sale
UPDATE Products
SET StockQuantity = StockQuantity - 1
WHERE ProductName = 'Google Pixel 7';

-- Update the order status to 'Shipped' after shipment
UPDATE Orders
SET OrderStatus = 'Shipped', UpdatedDate = NOW()
WHERE OrderID = 16;

-- Update employee salary and position after promotion
UPDATE Employees
SET Salary = Salary + 5000, Position = 'Senior Logistics Manager', UpdatedDate = NOW()
WHERE EmployeeID = 1000000031;

-- Update customer contact information
UPDATE Customers
SET Phone = '555-9999', Address = '500 New Elm St'
WHERE CustomerID = 2000000031;

-- Activate an expired promotion
UPDATE Promotions
SET IsActive = TRUE, EndDate = DATE_ADD(current_date(), INTERVAL 7 DAY), UpdatedDate = current_date()
WHERE PromotionID = 3;


-- Delete an order (and cascade delete associated records)
DELETE FROM Orders
WHERE OrderID = 2;


-- Remove a customer with invalid contact information
DELETE FROM Customers
WHERE Email = 'invalid@example.com';

-- Delete a promotion that is no longer relevant
DELETE FROM Promotions
WHERE EndDate < '2024-01-01';



-- Prevent product stock from going negative
UPDATE Products
SET StockQuantity = 0
WHERE StockQuantity < 0;

-- Ensure payments match total order amounts
UPDATE Payments P
INNER JOIN Orders O ON P.OrderID = O.OrderID
SET P.PaymentAmount = O.TotalAmount
WHERE P.PaymentAmount != O.TotalAmount;
