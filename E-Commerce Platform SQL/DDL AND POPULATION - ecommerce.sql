CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;



CREATE TABLE IF NOT EXISTS Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL,
    DepartmentDescription TEXT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Employees (
    EmployeeID INT(10) PRIMARY KEY NOT NULL,
    Name VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    Position VARCHAR(100),
    Salary DECIMAL(10, 2) CHECK (Salary >= 0),
    HireDate DATE NOT NULL,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE CASCADE,
    UNIQUE (Name, DepartmentID,EmployeeID) 
);
CREATE INDEX idx_employees_departmentid ON Employees (DepartmentID);

CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT(10) PRIMARY KEY NOT NULL UNIQUE ,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE CHECK (Email LIKE '%_@__%.__%'),
    Phone VARCHAR(15),
    Address TEXT,
    Country VARCHAR(50),
    City VARCHAR(50),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE INDEX idx_customers_email ON Customers (Email);
CREATE INDEX idx_customers_phone ON Customers (Phone);

CREATE TABLE IF NOT EXISTS Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL UNIQUE,
    CategoryDescription TEXT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE INDEX idx_categories_categoryname ON Categories (CategoryName);

CREATE TABLE IF NOT EXISTS Platforms (
    PlatformID INT PRIMARY KEY AUTO_INCREMENT,
    PlatformName VARCHAR(100) NOT NULL UNIQUE,
    PlatformDescription TEXT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE INDEX idx_platforms_platformname ON Platforms (PlatformName);

CREATE TABLE IF NOT EXISTS Brands (
    BrandID INT PRIMARY KEY AUTO_INCREMENT,                     -- Ensures BrandID is unique
    BrandName VARCHAR(100) NOT NULL UNIQUE,                     -- Ensures BrandName is unique
    BrandDescription TEXT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,            -- Tracks creation timestamp
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Tracks updates
);
CREATE INDEX idx_brands_brandname ON Brands (BrandName);

CREATE TABLE IF NOT EXISTS Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL UNIQUE,
    ProductDescription TEXT,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0.00),
    StockQuantity INT NOT NULL CHECK (StockQuantity >= 0),
    BrandID INT NOT NULL,
    CategoryID INT NOT NULL,
    PlatformID INT NOT NULL,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (BrandID) REFERENCES Brands(BrandID) ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE,
    FOREIGN KEY (PlatformID) REFERENCES Platforms(PlatformID) ON DELETE CASCADE
);
CREATE INDEX idx_products_brandid ON Products (BrandID);
CREATE INDEX idx_products_categoryid ON Products (CategoryID);
CREATE INDEX idx_products_platformid ON Products (PlatformID);
CREATE INDEX idx_products_productname ON Products (ProductName);

CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT(15) NOT NULL UNIQUE,
    CustomerID INT(15) NOT NULL UNIQUE,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL CHECK (OrderStatus IN ('Pending', 'Completed','Shipped', 'Cancelled')),
    TotalAmount DECIMAL(10, 2) NOT NULL CHECK (TotalAmount >= 0),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);
CREATE INDEX idx_orders_customerid ON Orders (CustomerID);
CREATE INDEX idx_orders_employeeid ON Orders (EmployeeID);
CREATE INDEX idx_orders_orderdate ON Orders (OrderDate);

CREATE TABLE IF NOT EXISTS Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL UNIQUE,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL(10, 2) NOT NULL CHECK (PaymentAmount >= 0),
    PaymentMethod VARCHAR(50) CHECK (PaymentMethod IN ('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer')),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
);
CREATE INDEX idx_payments_orderid ON Payments (OrderID);
CREATE INDEX idx_payments_paymentdate ON Payments (PaymentDate);

CREATE TABLE IF NOT EXISTS Shipments (
    ShipmentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    EmployeeID INT NOT NULL,
    ShipmentDate DATE NOT NULL,
    TrackingNumber VARCHAR(100),
    ShipmentStatus VARCHAR(50) CHECK (ShipmentStatus IN ('Completed','Shipped', 'Pending','Canceled', 'Delivered')),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);
CREATE INDEX idx_shipments_orderid ON Shipments (OrderID);
CREATE INDEX idx_shipments_employeeid ON Shipments (EmployeeID);
CREATE INDEX idx_shipments_shipmentstatus ON Shipments (ShipmentStatus);

CREATE TABLE IF NOT EXISTS Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(100) NOT NULL UNIQUE,
    ContactName VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100) CHECK (Email LIKE '%_@__%.__%'),
    Address TEXT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE INDEX idx_suppliers_suppliername ON Suppliers (SupplierName);

CREATE TABLE IF NOT EXISTS Supplier_Products (
    SupplierID INT NOT NULL,
    ProductID INT NOT NULL,
    PRIMARY KEY (SupplierID, ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
CREATE INDEX idx_supplier_products_supplierid ON Supplier_Products (SupplierID);
CREATE INDEX idx_supplier_products_productid ON Supplier_Products (ProductID);

CREATE TABLE IF NOT EXISTS Promotions (
    PromotionID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT,
    DiscountPercentage DECIMAL(5, 2) CHECK (DiscountPercentage BETWEEN 0 AND 100),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    IsActive BOOLEAN NOT NULL CHECK (IsActive IN (0, 1)),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE INDEX idx_promotions_startdate ON Promotions (StartDate);
CREATE INDEX idx_promotions_enddate ON Promotions (EndDate);

-- Create Promotions_Products Table
CREATE TABLE IF NOT EXISTS Promotions_Products (
    PromotionID INT,
    ProductID INT,
    PRIMARY KEY (PromotionID, ProductID),
    FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE INDEX idx_promotions_products_productid ON Promotions_Products (ProductID);
CREATE INDEX idx_promotions_products_promotionid ON Promotions_Products (PromotionID);

CREATE TABLE IF NOT EXISTS Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
CREATE INDEX idx_reviews_customerid ON Reviews (CustomerID);
CREATE INDEX idx_reviews_productid ON Reviews (ProductID);
CREATE INDEX idx_reviews_reviewdate ON Reviews (ReviewDate);

-- Create OrderDetails Table
CREATE TABLE IF NOT EXISTS OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL CHECK (Quantity > 0),  -- Ensure quantity is positive
    UnitPrice DECIMAL(10, 2) NOT NULL CHECK (UnitPrice >= 0),  -- Ensure unit price is non-negative
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE INDEX idx_orderdetails_orderid ON OrderDetails (OrderID);
CREATE INDEX idx_orderdetails_productid ON OrderDetails (ProductID);




/*
Data insertion
*/

-- Insert dummy data into Departments table
INSERT INTO Departments (DepartmentName, DepartmentDescription, CreatedDate, UpdatedDate)
VALUES
('Sales', 'Handles product sales and customer interactions.', NOW(), NOW()),
('Marketing', 'Responsible for market research and campaigns.', NOW(), NOW()),
('IT', 'Manages technical infrastructure and support.', NOW(), NOW()),
('Finance', 'Oversees budgeting and financial planning.', NOW(), NOW()),
('Customer Support', 'Provides post-sales support and assistance.', NOW(), NOW());

-- Insert 30 employees into the Employees table
INSERT INTO Employees (EmployeeID, Name, DepartmentID, Position, Salary, HireDate, CreatedDate, UpdatedDate)
VALUES
(1000000001, 'John Smith', 1, 'Sales Manager', 60000.00, '2020-01-01', NOW(), NOW()),
(1000000002, 'Emily Johnson', 2, 'Marketing Director', 75000.00, '2019-02-15', NOW(), NOW()),
(1000000003, 'Michael Brown', 3, 'IT Support Specialist', 55000.00, '2021-05-23', NOW(), NOW()),
(1000000004, 'Sarah Williams', 4, 'Finance Analyst', 65000.00, '2018-08-10', NOW(), NOW()),
(1000000005, 'David Jones', 5, 'Customer Service Representative', 40000.00, '2020-11-30', NOW(), NOW()),
(1000000006, 'Sophia Garcia', 1, 'Sales Executive', 48000.00, '2021-03-15', NOW(), NOW()),
(1000000007, 'James Lee', 2, 'Marketing Coordinator', 42000.00, '2021-06-01', NOW(), NOW()),
(1000000008, 'Daniel Harris', 3, 'IT Manager', 85000.00, '2017-07-09', NOW(), NOW()),
(1000000009, 'Mia Clark', 4, 'Financial Controller', 70000.00, '2019-09-01', NOW(), NOW()),
(1000000010, 'William Lewis', 5, 'Customer Service Lead', 47000.00, '2020-02-20', NOW(), NOW()),
(1000000011, 'Ava Walker', 1, 'Sales Representative', 45000.00, '2020-05-10', NOW(), NOW()),
(1000000012, 'Lucas Hall', 2, 'Social Media Specialist', 43000.00, '2021-07-14', NOW(), NOW()),
(1000000013, 'Charlotte Allen', 3, 'Network Administrator', 60000.00, '2020-10-25', NOW(), NOW()),
(1000000014, 'Elijah Young', 4, 'Accounts Payable Clerk', 39000.00, '2021-04-17', NOW(), NOW()),
(1000000015, 'Harper King', 5, 'Customer Service Assistant', 35000.00, '2021-01-29', NOW(), NOW()),
(1000000016, 'Benjamin Scott', 1, 'Sales Executive', 47000.00, '2020-08-12', NOW(), NOW()),
(1000000017, 'Amelia Adams', 2, 'Digital Marketing Specialist', 46000.00, '2021-02-05', NOW(), NOW()),
(1000000018, 'Sebastian Carter', 3, 'Software Engineer', 80000.00, '2017-06-23', NOW(), NOW()),
(1000000019, 'Madison Nelson', 4, 'Junior Financial Analyst', 42000.00, '2021-11-11', NOW(), NOW()),
(1000000020, 'Jack Thomas', 5, 'Call Center Representative', 36000.00, '2020-03-17', NOW(), NOW()),
(1000000021, 'Chloe Mitchell', 1, 'Sales Coordinator', 48000.00, '2021-05-01', NOW(), NOW()),
(1000000022, 'Daniel Lee', 2, 'Brand Strategist', 72000.00, '2020-12-15', NOW(), NOW()),
(1000000023, 'Lucas Perez', 3, 'Web Developer', 70000.00, '2019-08-07', NOW(), NOW()),
(1000000024, 'Zoe White', 4, 'Payroll Specialist', 41000.00, '2020-07-22', NOW(), NOW()),
(1000000025, 'Ethan Hill', 5, 'Customer Support Agent', 38000.00, '2021-02-28', NOW(), NOW()),
(1000000026, 'Grace Allen', 1, 'Regional Sales Manager', 75000.00, '2018-01-17', NOW(), NOW()),
(1000000027, 'Jacob Rodriguez', 2, 'Content Marketing Manager', 69000.00, '2021-10-09', NOW(), NOW()),
(1000000028, 'Michael Perez', 3, 'IT Security Specialist', 65000.00, '2019-05-05', NOW(), NOW()),
(1000000029, 'Isabella Garcia', 4, 'Tax Consultant', 55000.00, '2021-03-25', NOW(), NOW()),
(1000000030, 'Daniela Martinez', 5, 'Customer Service Manager', 72000.00, '2018-12-02', NOW(), NOW());


-- Insert 30 customers into the Customers table with distinct CustomerID values
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address, Country, City, CreatedDate, UpdatedDate)
VALUES
(2000000001, 'Jane', 'Smith', 'jane.smith@example.com', '555-1234', '123 Main St', 'USA', 'New York', NOW(), NOW()),
(2000000002, 'Michael', 'Johnson', 'michael.johnson@example.com', '555-5678', '456 Oak St', 'USA', 'Los Angeles', NOW(), NOW()),
(2000000003, 'Sarah', 'Williams', 'sarah.williams@example.com', '555-8765', '789 Pine St', 'USA', 'Chicago', NOW(), NOW()),
(2000000004, 'David', 'Jones', 'david.jones@example.com', '555-2345', '101 Maple St', 'USA', 'Houston', NOW(), NOW()),
(2000000005, 'Emily', 'Brown', 'emily.brown@example.com', '555-3456', '202 Birch St', 'USA', 'Phoenix', NOW(), NOW()),
(2000000006, 'Sophia', 'Davis', 'sophia.davis@example.com', '555-4567', '303 Cedar St', 'USA', 'Philadelphia', NOW(), NOW()),
(2000000007, 'James', 'Miller', 'james.miller@example.com', '555-5679', '404 Elm St', 'USA', 'San Antonio', NOW(), NOW()),
(2000000008, 'Daniel', 'Wilson', 'daniel.wilson@example.com', '555-6780', '505 Oak St', 'USA', 'San Diego', NOW(), NOW()),
(2000000009, 'Mia', 'Taylor', 'mia.taylor@example.com', '555-7891', '606 Pine St', 'USA', 'Dallas', NOW(), NOW()),
(2000000010, 'Lucas', 'Anderson', 'lucas.anderson@example.com', '555-8902', '707 Maple St', 'USA', 'Austin', NOW(), NOW()),
(2000000011, 'Lily', 'Thomas', 'lily.thomas@example.com', '555-9013', '808 Birch St', 'USA', 'Jacksonville', NOW(), NOW()),
(2000000012, 'Benjamin', 'Martinez', 'benjamin.martinez@example.com', '555-1122', '909 Cedar St', 'USA', 'Fort Worth', NOW(), NOW()),
(2000000013, 'Charlotte', 'Hernandez', 'charlotte.hernandez@example.com', '555-2233', '1010 Elm St', 'USA', 'Columbus', NOW(), NOW()),
(2000000014, 'Jack', 'Gonzalez', 'jack.gonzalez@example.com', '555-3344', '1111 Oak St', 'USA', 'Indianapolis', NOW(), NOW()),
(2000000015, 'Amelia', 'Perez', 'amelia.perez@example.com', '555-4455', '1212 Pine St', 'USA', 'Charlotte', NOW(), NOW()),
(2000000016, 'Sebastian', 'Jackson', 'sebastian.jackson@example.com', '555-5566', '1313 Maple St', 'USA', 'San Francisco', NOW(), NOW()),
(2000000017, 'Aiden', 'Lee', 'aiden.lee@example.com', '555-6677', '1414 Birch St', 'USA', 'Seattle', NOW(), NOW()),
(2000000018, 'Harper', 'Allen', 'harper.allen@example.com', '555-7788', '1515 Cedar St', 'USA', 'Denver', NOW(), NOW()),
(2000000019, 'Elijah', 'Young', 'elijah.young@example.com', '555-8899', '1616 Elm St', 'USA', 'Washington', NOW(), NOW()),
(2000000020, 'Isabella', 'King', 'isabella.king@example.com', '555-9900', '1717 Oak St', 'USA', 'Boston', NOW(), NOW()),
(2000000021, 'Oliver', 'Wright', 'oliver.wright@example.com', '555-1011', '1818 Pine St', 'USA', 'Detroit', NOW(), NOW()),
(2000000022, 'Ethan', 'Lopez', 'ethan.lopez@example.com', '555-1123', '1919 Maple St', 'USA', 'Memphis', NOW(), NOW()),
(2000000023, 'Grace', 'Scott', 'grace.scott@example.com', '555-2234', '2020 Birch St', 'USA', 'Nashville', NOW(), NOW()),
(2000000024, 'Henry', 'Baker', 'henry.baker@example.com', '555-3345', '2121 Oak St', 'USA', 'Baltimore', NOW(), NOW()),
(2000000025, 'Ella', 'Rivera', 'ella.rivera@example.com', '555-4456', '2323 Maple St', 'USA', 'Portland', NOW(), NOW()),
(2000000026, 'Mason', 'Torres', 'mason.torres@example.com', '555-5567', '2424 Cedar St', 'USA', 'Atlanta', NOW(), NOW()),
(2000000027, 'Aria', 'Reed', 'aria.reed@example.com', '555-6678', '2525 Elm St', 'USA', 'Miami', NOW(), NOW()),
(2000000028, 'Liam', 'Ward', 'liam.ward@example.com', '555-7789', '2626 Birch St', 'USA', 'Orlando', NOW(), NOW()),
(2000000029, 'Zoe', 'Gomez', 'zoe.gomez@example.com', '555-8890', '2727 Oak St', 'USA', 'Las Vegas', NOW(), NOW()),
(2000000030, 'Noah', 'Morgan', 'noah.morgan@example.com', '555-9901', '2828 Pine St', 'USA', 'Sacramento', NOW(), NOW());

-- Insert 5 categories into the Categories table
INSERT INTO Categories (CategoryName, CategoryDescription, CreatedDate, UpdatedDate)
VALUES
('Smartphones', 'Devices designed for mobile communication and internet browsing.', NOW(), NOW()),
('Laptops', 'Portable computers with a built-in screen and keyboard.', NOW(), NOW()),
('Consoles', 'Gaming devices that allow users to play video games.', NOW(), NOW()),
('Accessories', 'Additional products that enhance or complement other items.', NOW(), NOW()),
('Tablets', 'Mobile touchscreen devices that combine elements of both laptops and smartphones.', NOW(), NOW());

-- Insert 5 platforms into the Platforms table
INSERT INTO Platforms (PlatformName, PlatformDescription, CreatedDate, UpdatedDate)
VALUES
('Windows', 'Operating system developed by Microsoft for personal computers.', NOW(), NOW()),
('Xbox', 'A gaming console developed by Microsoft.', NOW(), NOW()),
('PlayStation', 'A gaming console developed by Sony Interactive Entertainment.', NOW(), NOW()),
('Nintendo Switch', 'A hybrid gaming console developed by Nintendo.', NOW(), NOW()),
('Android', 'An open-source mobile operating system developed by Google.', NOW(), NOW());


-- Insert 5 brands into the Brands table
INSERT INTO Brands (BrandName, BrandDescription, CreatedDate, UpdatedDate)
VALUES
('Apple', 'Technology company known for its premium devices like iPhone, MacBook, and iPad.', NOW(), NOW()),
('Samsung', 'Multinational conglomerate known for its electronics, including smartphones, tablets, and TVs.', NOW(), NOW()),
('Sony', 'Electronics company known for PlayStation gaming consoles and other entertainment products.', NOW(), NOW()),
('Microsoft', 'Technology company known for Windows, Xbox, and other software products.', NOW(), NOW()),
('Nintendo', 'Gaming company known for its consoles, including the Nintendo Switch and iconic games like Mario.', NOW(), NOW());

-- Insert 30 products into the Products table
INSERT INTO Products (ProductName, ProductDescription, Price, StockQuantity, BrandID, CategoryID, PlatformID, CreatedDate, UpdatedDate)
VALUES
('iPhone 13', 'Apple smartphone with advanced features and 5G capability.', 999.99, 100, 1, 1, 1, NOW(), NOW()),
('MacBook Pro', 'High-performance laptop by Apple for professionals.', 2499.99, 50, 1, 2, 1, NOW(), NOW()),
('Galaxy S21', 'Flagship smartphone from Samsung with AMOLED screen and 5G support.', 799.99, 120, 2, 1, 1, NOW(), NOW()),
('PlayStation 5', 'Next-gen gaming console from Sony, with ultra-fast loading times.', 499.99, 80, 3, 3, 3, NOW(), NOW()),
('Nintendo Switch', 'Hybrid gaming console by Nintendo that can be used as a portable or home console.', 299.99, 150, 5, 3, 4, NOW(), NOW()),
('Xbox Series X', 'Next-gen gaming console from Microsoft with powerful specs for high-quality gaming.', 499.99, 75, 4, 3, 2, NOW(), NOW()),
('iPad Pro', 'Tablet from Apple with powerful M1 chip and support for Apple Pencil.', 1099.99, 60, 1, 5, 1, NOW(), NOW()),
('Sony Bravia TV', '4K UHD television from Sony with excellent picture quality.', 1499.99, 40, 3, 4, 3, NOW(), NOW()),
('Surface Laptop 4', 'Laptop from Microsoft with touchscreen and powerful performance for professionals.', 1499.99, 30, 4, 2, 1, NOW(), NOW()),
('Samsung Galaxy Tab S7', 'Tablet from Samsung with AMOLED screen and powerful performance.', 649.99, 90, 2, 5, 2, NOW(), NOW()),
('iPhone 12', 'Apple smartphone with a great camera and A14 Bionic chip.', 799.99, 110, 1, 1, 1, NOW(), NOW()),
('MacBook Air', 'Lightweight and portable laptop from Apple, perfect for everyday use.', 999.99, 80, 1, 2, 1, NOW(), NOW()),
('Galaxy Note 20', 'Premium smartphone from Samsung with S Pen and high-end camera.', 950.00, 70, 2, 1, 1, NOW(), NOW()),
('PlayStation 4', 'Popular gaming console from Sony, known for its exclusive games.', 299.99, 150, 3, 3, 3, NOW(), NOW()),
('Xbox One X', 'Powerful gaming console from Microsoft with 4K gaming support.', 399.99, 90, 4, 3, 2, NOW(), NOW()),
('iPad Air', 'Affordable and versatile tablet from Apple with great performance.', 599.99, 100, 1, 5, 1, NOW(), NOW()),
('Sony WH-1000XM4', 'Noise-cancelling headphones from Sony with superior sound quality.', 349.99, 60, 3, 4, 3, NOW(), NOW()),
('Surface Pro 7', '2-in-1 laptop from Microsoft, lightweight and versatile.', 849.99, 50, 4, 2, 1, NOW(), NOW()),
('Samsung Galaxy S21 Ultra', 'Flagship phone from Samsung with a 108MP camera.', 1199.99, 40, 2, 1, 1, NOW(), NOW()),
('Nintendo Switch OLED', 'Enhanced version of the popular Nintendo Switch with OLED screen.', 349.99, 120, 5, 3, 4, NOW(), NOW()),
('iMac 24-inch', 'All-in-one desktop computer by Apple with M1 chip.', 1299.99, 30, 1, 2, 1, NOW(), NOW()),
('Apple Watch Series 7', 'Smartwatch from Apple with advanced fitness and health features.', 399.99, 80, 1, 5, 1, NOW(), NOW()),
('Oculus Quest 2', 'Standalone VR headset by Oculus for immersive virtual reality experiences.', 299.99, 100, 5, 4, 3, NOW(), NOW()),
('Google Pixel 6', 'Google’s flagship smartphone with a custom Tensor chip.', 699.99, 110, 2, 1, 1, NOW(), NOW()),
('Samsung Galaxy Buds Pro', 'Wireless earbuds with great sound quality and noise cancellation.', 199.99, 150, 2, 4, 3, NOW(), NOW()),
('HP Spectre x360', 'Convertible laptop from HP with excellent performance and build quality.', 1499.99, 60, 4, 2, 1, NOW(), NOW()),
('Lenovo ThinkPad X1 Carbon', 'Business laptop from Lenovo with strong performance and battery life.', 1799.99, 50, 4, 2, 1, NOW(), NOW()),
('Dell XPS 13', 'Premium ultrabook from Dell with high-end specs and design.', 1299.99, 90, 4, 2, 1, NOW(), NOW()),
('Razer Blade 15', 'Gaming laptop from Razer with powerful GPU and sleek design.', 1999.99, 40, 4, 2, 1, NOW(), NOW()),
('Google Nest Hub', 'Smart display from Google with Google Assistant integration.', 89.99, 200, 2, 4, 3, NOW(), NOW());

-- Insert 15 orders into the Orders table
INSERT INTO Orders (EmployeeID, CustomerID, OrderDate, OrderStatus, TotalAmount, CreatedDate, UpdatedDate)
VALUES
(1000000001, 2000000001, '2024-01-05', 'Completed', 1200.00, NOW(), NOW()),
(1000000002, 2000000002, '2024-01-10', 'Pending', 850.00, NOW(), NOW()),
(1000000003, 2000000003, '2024-01-15', 'Completed', 950.00, NOW(), NOW()),
(1000000004, 2000000004, '2024-01-20', 'Shipped', 1000.00, NOW(), NOW()),
(1000000005, 2000000005, '2024-01-25', 'Completed', 1500.00, NOW(), NOW()),
(1000000006, 2000000006, '2024-01-30', 'Completed', 800.00, NOW(), NOW()),
(1000000007, 2000000007, '2024-02-05', 'Pending', 700.00, NOW(), NOW()),
(1000000008, 2000000008, '2024-02-10', 'Shipped', 1250.00, NOW(), NOW()),
(1000000009, 2000000009, '2024-02-15', 'Completed', 1100.00, NOW(), NOW()),
(1000000010, 2000000010, '2024-02-20', 'Pending', 900.00, NOW(), NOW()),
(1000000011, 2000000011, '2024-02-25', 'Shipped', 950.00, NOW(), NOW()),
(1000000012, 2000000012, '2024-03-01', 'Completed', 1150.00, NOW(), NOW()),
(1000000013, 2000000013, '2024-03-05', 'Pending', 600.00, NOW(), NOW()),
(1000000014, 2000000014, '2024-03-10', 'Completed', 1050.00, NOW(), NOW()),
(1000000015, 2000000015, '2024-03-15', 'Shipped', 1400.00, NOW(), NOW());


-- Insert 15 payments into the Payments table
INSERT INTO Payments (OrderID, PaymentDate, PaymentAmount, PaymentMethod, CreatedDate, UpdatedDate)
VALUES
(1, '2024-01-06', 1200.00, 'Credit Card', NOW(), NOW()),
(2, '2024-01-11', 850.00, 'PayPal', NOW(), NOW()),
(3, '2024-01-16', 950.00, 'Debit Card', NOW(), NOW()),
(4, '2024-01-21', 1000.00, 'Bank Transfer', NOW(), NOW()),
(5, '2024-01-26', 1500.00, 'Credit Card', NOW(), NOW()),
(6, '2024-01-31', 800.00, 'PayPal', NOW(), NOW()),
(7, '2024-02-06', 700.00, 'Credit Card', NOW(), NOW()),
(8, '2024-02-11', 1250.00, 'Debit Card', NOW(), NOW()),
(9, '2024-02-16', 1100.00, 'Bank Transfer', NOW(), NOW()),
(10, '2024-02-21', 900.00, 'PayPal', NOW(), NOW()),
(11, '2024-02-26', 950.00, 'Credit Card', NOW(), NOW()),
(12, '2024-03-02', 1150.00, 'Debit Card', NOW(), NOW()),
(13, '2024-03-06', 600.00, 'Bank Transfer', NOW(), NOW()),
(14, '2024-03-11', 1050.00, 'Credit Card', NOW(), NOW()),
(15, '2024-03-16', 1400.00, 'PayPal', NOW(), NOW());

-- Insert 15 shipments into the Shipments table
INSERT INTO Shipments (OrderID, EmployeeID, ShipmentDate, TrackingNumber, ShipmentStatus, CreatedDate, UpdatedDate)
VALUES
(1, 1000000001, '2024-01-07', 'TRACK001', 'Shipped', NOW(), NOW()),
(2, 1000000002, '2024-01-12', 'TRACK002', 'Pending', NOW(), NOW()),
(3, 1000000003, '2024-01-17', 'TRACK003', 'Shipped', NOW(), NOW()),
(4, 1000000004, '2024-01-22', 'TRACK004', 'Shipped', NOW(), NOW()),
(5, 1000000005, '2024-01-27', 'TRACK005', 'Shipped', NOW(), NOW()),
(6, 1000000006, '2024-02-01', 'TRACK006', 'Shipped', NOW(), NOW()),
(7, 1000000007, '2024-02-06', 'TRACK007', 'Pending', NOW(), NOW()),
(8, 1000000008, '2024-02-11', 'TRACK008', 'Shipped', NOW(), NOW()),
(9, 1000000009, '2024-02-16', 'TRACK009', 'Completed', NOW(), NOW()),
(10, 1000000010, '2024-02-21', 'TRACK010', 'Pending', NOW(), NOW()),
(11, 1000000011, '2024-02-26', 'TRACK011', 'Shipped', NOW(), NOW()),
(12, 1000000012, '2024-03-03', 'TRACK012', 'Completed', NOW(), NOW()),
(13, 1000000013, '2024-03-06', 'TRACK013', 'Shipped', NOW(), NOW()),
(14, 1000000014, '2024-03-11', 'TRACK014', 'Shipped', NOW(), NOW()),
(15, 1000000015, '2024-03-16', 'TRACK015', 'Pending', NOW(), NOW());


-- Insert 5 suppliers into the Suppliers table
INSERT INTO Suppliers (SupplierName, ContactName, Phone, Email, Address, CreatedDate, UpdatedDate)
VALUES
('Apple Inc.', 'Tim Cook', '555-1111', 'contact@apple.com', '1 Infinite Loop, Cupertino, CA', NOW(), NOW()),
('Samsung Electronics', 'Lee Jae-Yong', '555-2222', 'contact@samsung.com', '129 Samsung-ro, Seoul, Korea', NOW(), NOW()),
('Sony Corporation', 'Kenichiro Yoshida', '555-3333', 'contact@sony.com', '1-7-1 Konan, Minato-ku, Tokyo', NOW(), NOW()),
('Microsoft', 'Satya Nadella', '555-4444', 'contact@microsoft.com', 'Redmond, WA 98052, USA', NOW(), NOW()),
('Nintendo', 'Shuntaro Furukawa', '555-5555', 'contact@nintendo.com', '11-1 Kamitoba Hokodate-cho, Minami-ku, Kyoto, Japan', NOW(), NOW());

-- Insert 10 supplier-product relationships into the Supplier_Products table
INSERT INTO Supplier_Products (SupplierID, ProductID)
VALUES
(1, 1),  -- Apple supplies iPhone 13
(1, 2),  -- Apple supplies MacBook Pro
(2, 3),  -- Samsung supplies Galaxy S21
(2, 4),  -- Samsung supplies Galaxy Note 20
(3, 5),  -- Sony supplies PlayStation 5
(3, 7),  -- Sony supplies Sony Bravia TV
(4, 9),  -- Microsoft supplies Surface Laptop 4
(4, 11), -- Microsoft supplies Surface Pro 7
(5, 10), -- Nintendo supplies Nintendo Switch
(5, 12); -- Nintendo supplies Nintendo Switch OLED

-- Insert 5 promotions into the Promotions table
INSERT INTO Promotions (Name, Description, DiscountPercentage, StartDate, EndDate, IsActive, CreatedDate, UpdatedDate)
VALUES
('Summer Sale', 'Enjoy up to 20% off on selected items during the summer sale.', 20.00, '2024-06-01', '2024-06-30', TRUE, NOW(), NOW()),
('Black Friday Deal', 'Get 50% off on all electronics during Black Friday.', 50.00, '2024-11-25', '2024-11-28', TRUE, NOW(), NOW()),
('Christmas Special', 'Save 30% on all products this holiday season.', 30.00, '2024-12-01', '2024-12-25', TRUE, NOW(), NOW()),
('Back to School', 'Back-to-school promotion: 15% off on laptops and tablets.', 15.00, '2024-08-01', '2024-08-31', TRUE, NOW(), NOW()),
('New Year Sale', 'Ring in the New Year with 10% off on all orders over $500.', 10.00, '2024-01-01', '2024-01-15', TRUE, NOW(), NOW());

-- Insert 10 promotion-product relationships into the Promotions_Products table
INSERT INTO Promotions_Products (PromotionID, ProductID)
VALUES
(1, 1),  -- Summer Sale: iPhone 13
(1, 2),  -- Summer Sale: MacBook Pro
(2, 3),  -- Black Friday Deal: PlayStation 5
(2, 4),  -- Black Friday Deal: Xbox Series X
(3, 5),  -- Christmas Special: Nintendo Switch
(3, 7),  -- Christmas Special: iPad Pro
(4, 9),  -- Back to School: Surface Laptop 4
(4, 11), -- Back to School: Surface Pro 7
(5, 12), -- New Year Sale: Nintendo Switch OLED
(5, 10); -- New Year Sale: Samsung Galaxy Tab S7


-- Insert 20 reviews into the Reviews table
INSERT INTO Reviews (CustomerID, ProductID, Rating, Comment, ReviewDate)
VALUES
(2000000001, 1, 5, 'Excellent phone! The camera and performance are amazing.', '2024-01-10'),
(2000000002, 2, 4, 'Great laptop for work, but a bit expensive.', '2024-01-12'),
(2000000003, 3, 5, 'Best gaming console I have ever used. Fast and reliable.', '2024-01-15'),
(2000000004, 4, 3, 'Good, but not as powerful as the Xbox Series X.', '2024-01-18'),
(2000000005, 5, 5, 'I love the Nintendo Switch, perfect for both home and portable gaming.', '2024-01-20'),
(2000000006, 6, 4, 'The iPad Pro is perfect for drawing and watching movies.', '2024-01-22'),
(2000000007, 7, 4, 'Great TV! Excellent color and picture quality.', '2024-01-25'),
(2000000008, 8, 4, 'Nice laptop, but could use a better screen resolution.', '2024-01-28'),
(2000000009, 9, 3, 'It’s okay, but there are better tablets out there for the price.', '2024-02-01'),
(2000000010, 10, 5, 'The Surface Pro 7 is perfect for my work and entertainment needs.', '2024-02-05'),
(2000000011, 11, 4, 'The iMac is fast and efficient, but the design could be sleeker.', '2024-02-07'),
(2000000012, 12, 5, 'Apple Watch Series 7 is a game changer, love the new health features.', '2024-02-10'),
(2000000013, 13, 4, 'Great experience with the Oculus Quest 2, but needs more game options.', '2024-02-13'),
(2000000014, 14, 5, 'Google Pixel 6 offers amazing camera quality and fast performance.', '2024-02-15'),
(2000000015, 15, 3, 'The Samsung Galaxy Buds Pro are good, but the sound quality could be better.', '2024-02-18'),
(2000000016, 16, 5, 'HP Spectre x360 is amazing! Lightweight and powerful.', '2024-02-20'),
(2000000017, 17, 4, 'The Lenovo ThinkPad X1 Carbon is a solid laptop but could have a better display.', '2024-02-22'),
(2000000018, 18, 5, 'Dell XPS 13 is a premium laptop with excellent performance and battery life.', '2024-02-25'),
(2000000019, 19, 5, 'Razer Blade 15 is a great gaming laptop with a sleek design and power to match.', '2024-02-28'),
(2000000020, 20, 4, 'The Google Nest Hub is really helpful, but could use more integrations.', '2024-03-01');


-- Insert 15 order details into the OrderDetails table with CreatedDate and UpdatedDate
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice, CreatedDate, UpdatedDate)
VALUES
(1, 1, 1, 999.99, '2024-01-05', '2024-01-05'),  -- Order 1: 1 iPhone 13
(1, 2, 1, 2499.99, '2024-01-05', '2024-01-05'),  -- Order 1: 1 MacBook Pro
(2, 3, 2, 799.99, '2024-01-10', '2024-01-10'),  -- Order 2: 2 Galaxy S21
(3, 4, 1, 499.99, '2024-01-15', '2024-01-15'),  -- Order 3: 1 PlayStation 5
(4, 5, 2, 299.99, '2024-01-20', '2024-01-20'),  -- Order 4: 2 Nintendo Switch
(5, 6, 1, 850.00, '2024-01-25', '2024-01-25'),  -- Order 5: 1 Xbox Series X
(6, 7, 1, 800.00, '2024-01-30', '2024-01-30'),  -- Order 6: 1 iPad Pro
(7, 8, 1, 1250.00, '2024-02-05', '2024-02-05'),  -- Order 7: 1 Sony Bravia TV
(8, 9, 1, 1499.99, '2024-02-10', '2024-02-10'),  -- Order 8: 1 Surface Laptop 4
(9, 10, 2, 649.99, '2024-02-15', '2024-02-15'),  -- Order 9: 2 Samsung Galaxy Tab S7
(10, 11, 1, 1099.99, '2024-02-20', '2024-02-20'), -- Order 10: 1 Surface Pro 7
(11, 12, 3, 649.99, '2024-02-25', '2024-02-25'), -- Order 11: 3 iPhone 12
(12, 13, 2, 950.00, '2024-03-01', '2024-03-01'), -- Order 12: 2 Galaxy Note 20
(13, 14, 1, 950.00, '2024-03-05', '2024-03-05'), -- Order 13: 1 MacBook Air
(14, 15, 1, 1200.00, '2024-03-10', '2024-03-10'); -- Order 14: 1 iMac 24-inch
