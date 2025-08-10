CREATE DATABASE Practice

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Aman Sharma', 'Delhi'),
(2, 'Riya Mehta', 'Mumbai'),
(3, 'Sneha Kapoor', 'Delhi'),
(4, 'Karan Patel', 'Pune'),
(5, 'Vikram Desai', 'Chennai');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);

INSERT INTO Orders VALUES
(101, 1, '2024-12-01', 110000.00),
(102, 2, '2024-12-03', 30000.00),
(103, 3, '2024-12-05', 20000.00),
(104, 5, '2024-12-08', 12000.00),
(105, 1, '2024-12-10', 20000.00);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2)
);

INSERT INTO Products VALUES
(1, 'Laptop', 55000.00),
(2, 'Tablet', 30000.00),
(3, 'Smartphone', 20000.00),
(4, 'Smartwatch', 12000.00);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT
);

INSERT INTO OrderDetails VALUES
(1, 101, 1, 2),  -- Aman bought 2 Laptops
(2, 102, 2, 1),  -- Riya bought 1 Tablet
(3, 103, 3, 1),  -- Sneha bought 1 Smartphone
(4, 104, 4, 1),  -- Vikram bought 1 Smartwatch
(5, 105, 3, 1);  -- Aman bought 1 Smartphone in another order

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM OrderDetails;

/* 1. Create a table for Customers with fields: ID, Name, City.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

-- 2. Insert 3 new customers into the Customers table.
INSERT INTO Customers VALUES
(6, 'Anjali Verma', 'Bangalore'),
(7, 'Raj Singh', 'Hyderabad'),
(8, 'Pooja Yadav', 'Kolkata'); */

-- 3. Update Aman Sharma’s city to "Noida".
UPDATE Customers
SET City = 'Noida'
WHERE CustomerName = 'Aman Sharma';

-- 4. DELETE FROM Customers
DELETE FROM Customers
WHERE City = 'Pune';

-- 5. Find all customers who live in ‘Delhi’.
SELECT * FROM Customers
WHERE City = 'Delhi';

-- 6. List orders where thetotal amount is greater than 20,000.
SELECT * FROM Orders
WHERE TotalAmount > 20000;

-- 7. Show orders placed between '2024-12-01' and '2024-12-07'.
SELECT * FROM Orders
WHERE OrderDate BETWEEN '2024-12-01' AND '2024-12-07';

-- 8. Find products that are priced less than or equal to 20,000.
SELECT * FROM Products
WHERE Price <= 20000;

-- 9. Display products whose names contain the word "smart".
SELECT * FROM Products
WHERE LOWER(ProductName) LIKE '%smart%';

-- 10. Show customers whose names are either ‘Riya Mehta’ or ‘Sneha Kapoor’.
SELECT * FROM Customers
-- WHERE CustomerName IN ('Riya Mehta', 'Sneha Kapoor'); or
WHERE CustomerName = 'Riya Mehta' OR CustomerName = 'Sneha Kapoor';

-- 11. Show total revenue from all orders.
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders;

-- 12. Find the average price of all products.
SELECT AVG(Price) AS AveragePrice
FROM Products;

-- 13. Get the count of total orders made by each customer.
SELECT CustomerID, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CustomerID;

/* 14. Find the max and min quantity ordered in the OrderDetails table.
SELECT MAX(Quantity),
		MIN (Quantity) 
FROM OrderDetails 
or */
SELECT MAX(Quantity) AS MaxQty, 
	MIN(Quantity) AS MinQty
FROM OrderDetails;

-- 15. Calculate total quantity sold for each product.
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM OrderDetails
GROUP BY ProductID;

-- 16. Display all customer names in uppercase.
SELECT CustomerName, 
UPPER(CustomerName) AS UpperName
FROM Customers;

--  17. Show length of each product name.
SELECT ProductName, 
LENGTH(ProductName) AS LengthOfProduct
FROM Products;

-- 18. Extract the first 3 characters of each product name.
SELECT ProductName,
LEFT(ProductName, 3) AS First3Chars
FROM Products;

-- 19. Display 'High' if TotalAmount > 50,000 else 'Low' for each order.
SELECT TotalAmount,
	CASE 
		WHEN TotalAmount > 50000 THEN 'High'
		ELSE 'Low'
	END AS OrderLevel
FROM Orders;

-- 20. Get customer names with their ordered products (INNER JOIN).
SELECT c.CustomerName, p.ProductName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

-- 21. Show all customers and their orders, including those with no orders (LEFT JOIN).
SELECT c.CustomerName, o.OrderID, o.TotalAmount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 22. Display all orders and customer names, including unmatched orders (RIGHT JOIN).
SELECT o.OrderID, c.CustomerName
FROM Orders o
RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID;

-- 23. Add a row number to each order based on OrderDate.
SELECT OrderID, OrderDate,
       ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNum
FROM Orders;

-- 24. UNION to list all product names and all customer names in one column.
SELECT CustomerName AS Name FROM Customers
UNION
SELECT ProductName FROM Products;

-- 25. Replace NULL customer names with 'Unknown' using COALESCE.
SELECT COALESCE(CustomerName, 'Unknown') AS SafeCustomerName
FROM Customers;
