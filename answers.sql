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

-- Explanation:
-- - `CREATE TABLE NormalizedProductDetail AS SELECT ... FROM ProductDetail`: This creates a new table
--   called 'NormalizedProductDetail' based on the result of the SELECT query.
-- - `OrderID, CustomerName`: These columns are directly selected from the original table.
-- - `TRIM(Product) AS Product`: This takes the individual product name resulting from the split
--   and removes any leading or trailing whitespace.
-- - `CROSS APPLY SPLIT_STRING_TO_TABLE(Products, ',')`: This is the crucial part. It applies a
--   hypothetical function 'SPLIT_STRING_TO_TABLE' to the 'Products' column of each row in
--   'ProductDetail'. The comma (',') is used as the delimiter to split the string of products.
--   For each value returned by the split function, a new row is generated, combined with the
--   'OrderID' and 'CustomerName' from the original row.



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

-- Explanation of the resulting tables in 2NF:
-- - Orders Table:
--   - Primary Key: OrderID
--   - Non-key attribute: CustomerName (fully dependent on the primary key OrderID)
-- - OrderItems Table:
--   - Primary Key: (OrderID, Product) - composite key
--   - Non-key attribute: Quantity (fully dependent on the entire primary key - the quantity
--     depends on both the specific order and the specific product within that order)

-- By splitting the original table this way, we have eliminated the partial dependency, and both
-- resulting tables now satisfy the conditions of 2NF.
