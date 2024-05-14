
-- create tables
CREATE TABLE Order_Invoice
(
    InvNo varchar(3) NOT NULL,
    ProdID varchar(3) NOT NULL,
    qty int,
    PRIMARY KEY (InvNo, ProdID)
);

CREATE TABLE Customer_Staff
(
    InvNo varchar(3) NOT NULL,
    CustID varchar(3) NOT NULL,
    StaffID varchar(3) NOT NULL,
    PRIMARY KEY (InvNo)
);

CREATE TABLE Product
(
    ProdID varchar(3) NOT NULL,
    ProdName varchar(50),
    Price double,
    SupplID varchar(3) NOT NULL,
    PRIMARY KEY (ProdID)
);

CREATE TABLE Customer
(
    CustID varchar(3) NOT NULL,
    CustName varchar(50),
    CustEmail varchar(100),
    CustNo varchar(12),
    CustAdd varchar(250),
    PRIMARY KEY (CustID)
);

CREATE TABLE Staff
(
    StaffID varchar(3) NOT NULL,
    StaffName varchar(50),
    PRIMARY KEY (StaffID)
);

CREATE TABLE Supplier
(
    SupplID varchar(3) NOT NULL,
    SupplName varchar(50),
    SupplNo varchar(12),
    PRIMARY KEY (SupplID)
);

CREATE TABLE Product_Category
(
    ProdID varchar(3) NOT NULL,
    ProdName varchar(50) NOT NULL,
    Category varchar(50),
    PRIMARY KEY (ProdID)
);

-- establish relationships 
ALTER TABLE Customer_Staff
ADD FOREIGN KEY (CustID) REFERENCES Customer(CustID),
ADD FOREIGN KEY (StaffID) REFERENCES Staff(StaffID);

ALTER TABLE Order_Invoice
ADD FOREIGN KEY (InvNo) REFERENCES Customer_Staff(InvNo),
ADD FOREIGN KEY (ProdID) REFERENCES Product(ProdID);

ALTER TABLE Product
ADD FOREIGN KEY (SupplID) REFERENCES Supplier(SupplID);

ALTER TABLE Product_Category
ADD FOREIGN KEY (ProdID) REFERENCES Product(ProdID);

-- Extract data

-- number of products sold
SELECT SUM(qty) AS Sum
FROM Order_Invoice;

-- alter price datatype from double to currency

ALTER TABLE Product
MODIFY COLUMN Price CURRENCY;

-- list customer ID and customer name in ascending order of custID.

SELECT custID, CustName
FROM Customer
ORDER BY custID;

-- List the number of products sold for each ProdID

SELECT ProdID, count(ProdID) AS Total
FROM Order_Invoice
GROUP BY ProdID;

-- Update a customer's phone number in the table

UPDATE Customer SET CustNo = '017-8890341'
WHERE CustID = 'C04';

-- find apple juice supplier, select from multiple tables

SELECT A.ProdID, A.ProdName, A.SupplID, B.SupplName, B.SupplNo
FROM Product AS A, Supplier AS B
WHERE A.SupplID=B.SupplID
AND ProdName='Apple Juice';

-- alternative

SELECT P.ProdID, P.ProdName, P.SupplID, B.SupplName, B.SupplNo
FROM Product AS P
INNER JOIN Supplier AS B ON P.SupplID = B.SupplID
WHERE P.ProdName = 'Apple Juice';

-- get staff records where staff name starts with M.

SELECT StaffID, StaffName
FROM Staff
WHERE StaffName like 'M*';

--  multiply the price of product with the quantity bought by a customer with invoice number = ‘A01’ 

SELECT O.InvNo, O.ProdID, P.Price, O.qty, (Price*qty) AS Total
FROM Order_Invoice AS O, Product AS P
WHERE O.ProdID=P.ProdID
AND O.InvNo='A01';

-- DELETE a customer record

DELETE FROM Customer
WHERE CustID = 'CO3';

-- Union IDs and Names of Product & Supplier

SELECT ProdID as ID, ProdName as Name
FROM Product
Union SELECT SupplID, SupplName
FROM Supplier;


-- Join product and product Category table

SELECT P.ProdID, P.ProdName, P.Price, B.Category
FROM Product AS P
INNER JOIN Product_Category AS B ON P.ProdID = B.ProdID;














