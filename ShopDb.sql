--CREATE DATABASE SHOP
--USE SHOP

--CREATE TABLE Customers (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    Name VARCHAR(25),
--    Email VARCHAR(25),
--    Phone VARCHAR(25)
--);

--CREATE TABLE Categories (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    Name VARCHAR(25),
--    Description VARCHAR(200)
--);

--CREATE TABLE Products (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    Name VARCHAR(50),
--    Description VARCHAR(200),
--    Price FLOAT,
--    CategoryId INT,
--    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
--);

--CREATE TABLE Orders (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    OrderDate DATE,
--    Status VARCHAR(20),
--    CustomerId INT,
--    FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
--);

--CREATE TABLE OrderItems (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    Quantity INT,
--    UnitPrice FLOAT,
--    OrderId INT,
--    ProductId INT,
--    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
--    FOREIGN KEY (ProductId) REFERENCES Products(Id)
--);

--CREATE TABLE Suppliers (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    Name VARCHAR(25),
--    ContactInfo VARCHAR(200)
--);

--CREATE TABLE ProductSuppliers (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    ProductId INT,
--    SupplierId INT,
--    FOREIGN KEY (ProductId) REFERENCES Products(Id),
--    FOREIGN KEY (SupplierId) REFERENCES Suppliers(Id)
--);
--INSERT INTO Customers (Name, Email, Phone) VALUES
--('Ulvi Abbasli', 'ulvi3457abbasli@gmail.com', '055-478-59-69'),
--('Aysel Huseynova', 'aysel@mail.com', '051-222-33-44'),
--('Elcan Musali', 'elmus2004@gmail.com', '055-333-44-55');

--INSERT INTO Categories (Name, Description) VALUES
--('Electronics', 'Electronic devices and gadgets'),
--('Clothing', 'Men and Women clothing'),
--('Home Appliances', 'Appliances for home use');

--INSERT INTO Products (Name, Description, Price, CategoryId) VALUES
--('iPhone 14', 'Apple smartphone', 1899.99, 1),
--('Samsung TV 55"', '4K Smart TV', 999.50, 1),
--('Men T-Shirt', '100% cotton', 19.99, 2),
--('Washing Machine', 'Automatic washing machine', 780.00, 3),
--('Air Conditioner', '12000 BTU split type', 1100.00, 3);

--INSERT INTO Orders (OrderDate, Status, CustomerId) VALUES
--('2025-01-10', 'Pending', 1),
--('2025-01-11', 'Shipped', 2),
--('2025-01-12', 'Delivered', 1);

--INSERT INTO OrderItems (Quantity, UnitPrice, OrderId, ProductId) VALUES
--(1, 1899.99, 1, 1),   
--(2, 19.99,  1, 3),    
--(1, 999.50, 2, 2),    
--(1, 780.00, 3, 4),    
--(1, 1100.00, 3, 5);   

--INSERT INTO Suppliers (Name, ContactInfo) VALUES
--('TechnoSupply', 'techno@supply.com'),
--('GlobalCloth', 'cloth@global.com'),
--('HomeEquip Co', 'contact@homeequip.com');

--INSERT INTO ProductSuppliers (ProductId, SupplierId) VALUES
--(1, 1),   
--(2, 1),   
--(3, 2),   
--(4, 3),  
--(5, 3);  

