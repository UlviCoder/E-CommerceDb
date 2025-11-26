CREATE DATABASE SHOP
USE SHOP

CREATE TABLE Customers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(25),
    Email VARCHAR(25),
    Phone VARCHAR(25)
);

CREATE TABLE Categories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(25),
    Description VARCHAR(200)
);

CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Description VARCHAR(200),
    Price FLOAT,
    CategoryId INT,
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE,
    Status VARCHAR(20),
    CustomerId INT,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
);

CREATE TABLE OrderItems (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Quantity INT,
    UnitPrice FLOAT,
    OrderId INT,
    ProductId INT,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);

CREATE TABLE Suppliers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(25),
    ContactInfo VARCHAR(200)
);

CREATE TABLE ProductSuppliers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ProductId INT,
    SupplierId INT,
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (SupplierId) REFERENCES Suppliers(Id)
);
