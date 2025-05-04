question 1
CREATE TABLE NormalizedProductDetail AS
SELECT
    OrderID,
    CustomerName,
    TRIM(Product) AS Product -- Trim any leading/trailing spaces from the product name
FROM
    ProductDetail
CROSS APPLY SPLIT_STRING_TO_TABLE(Products, ',');
*/





question 2
CREATE TABLE Orders AS
SELECT DISTINCT -- Use DISTINCT to get unique OrderID and CustomerName combinations
    OrderID,
    CustomerName
FROM
    OrderDetails;

-- Add a primary key constraint to the Orders table
ALTER TABLE Orders
ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID);

-- Create the OrderItems table to store details about each product in an order
CREATE TABLE OrderItems AS
SELECT
    OrderID,
    Product,
    Quantity
FROM
    OrderDetails;

-- Add a composite primary key constraint to the OrderItems table
-- The primary key for OrderItems is a combination of OrderID and Product, ensuring
-- each product in an order is uniquely identified.
ALTER TABLE OrderItems
ADD CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, Product);

-- Add a foreign key constraint to the OrderItems table to link it back to the Orders table
-- This establishes a relationship between the two tables based on OrderID.
ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItem_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);


