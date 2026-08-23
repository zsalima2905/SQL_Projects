DROP DATABASE IF EXISTS Ecommerce_Order_Management_System; 
CREATE DATABASE Ecommerce_Order_Management_System;
USE Ecommerce_Order_Management_System;
SHOW DATABASES;
SELECT VERSION();
SELECT DATABASE();

-- STEP 1. Create Category Table
CREATE TABLE Category(
Category_Id INT PRIMARY KEY AUTO_INCREMENT,
Category_Name VARCHAR(100) NOT NULL UNIQUE
);
SELECT * FROM Category;

-- STEP 2. Create Customer Table
CREATE TABLE Customers(
Customer_Id INT PRIMARY KEY AUTO_INCREMENT,
Customer_Name VARCHAR(50) NOT NULL,
Email VARCHAR(100) UNIQUE,
Mobile_Number VARCHAR(15) UNIQUE,
Gender VARCHAR(10),
Registration_Date DATE,
City VARCHAR(50),

CONSTRAINT Ck_Customer_Gender
CHECK (Gender IN('Male', 'Female', 'Other'))

);
SELECT * FROM Customers;

-- STEP 3. Create Products Table
CREATE TABLE Products(
Product_Id INT PRIMARY KEY AUTO_INCREMENT,
Product_Name VARCHAR(100) NOT NULL,
Category_Id INT,
Brand_Name VARCHAR(100),
Price DECIMAL(10,2) NOT NULL,
Stock_Quantity INT,

CONSTRAINT fk_product_category 
FOREIGN KEY (Category_Id) REFERENCES Category(Category_Id),
CONSTRAINT chk_product_price CHECK (Price > 0),  
CONSTRAINT chk_product_stock CHECK (Stock_Quantity >=0)
);  

SELECT * FROM Products;

-- STEP 4. Create Orders Table
CREATE TABLE Orders(
Order_Id INT PRIMARY KEY AUTO_INCREMENT,
Customer_Id INT NOT NULL,
Order_Date DATE NOT NULL,
Order_Status VARCHAR(20) NOT NULL,
Total_Amount DECIMAL (12,2) NOT NULL,

CONSTRAINT fk_orders_customer
  FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id),
CONSTRAINT chk_order_amount CHECK (Total_Amount>0),
CONSTRAINT chk_order_status CHECK (Order_Status IN ('Placed', 'Packed', 'Shipped', 'Delivered', 'Cancelled'))
);

SELECT * FROM Orders;

-- STEP 5. Create Order Details Table
CREATE TABLE Order_Details(
Order_Detail_Id INT PRIMARY KEY AUTO_INCREMENT,
Order_Id INT NOT NULL,
Product_Id INT NOT NULL,
Quantity INT NOT NULL,
Unit_Price DECIMAL(12,2) NOT NULL,

CONSTRAINT fk_orderdetails_order FOREIGN KEY (Order_Id) REFERENCES Orders(Order_Id),
CONSTRAINT fk_orderdetails_product FOREIGN KEY (Product_Id) REFERENCES Products(Product_Id),
CONSTRAINT chk_orderdetails_quantity CHECK (Quantity>0),
CONSTRAINT chk_orderdetails_price CHECK (Unit_Price>0)
  );
SELECT * FROM Order_Details;

-- STEP 6. Create Payments Table
CREATE TABLE Payments(
Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
Order_Id INT NOT NULL UNIQUE,
Payment_Date DATE NOT NULL,
Payment_Mode VARCHAR(30) NOT NULL,
Payment_Amount DECIMAL(12,2) NOT NULL,
Payment_Status VARCHAR(20) NOT NULL,

CONSTRAINT fk_payment_order FOREIGN KEY (Order_Id) REFERENCES Orders(Order_Id),
CONSTRAINT chk_payment_mode CHECK (Payment_Mode IN ('UPI', 'Card', 'Net Banking', 'Cash On Delivery')),
CONSTRAINT chk_payment_amount CHECK (Payment_Amount> 0),
CONSTRAINT chk_payment_status CHECK (Payment_Status IN ('Success', 'Pending', 'Failed'))
  );
SELECT * FROM Payments;

-- STEP 7. Create Shipping Table 
CREATE TABLE Shippings(
Shipping_Id INT PRIMARY KEY AUTO_INCREMENT,
Order_Id INT UNIQUE,
Courier_Partner VARCHAR(100),
Shipment_Date DATE,
Delivery_Date DATE,
Shipment_Status VARCHAR(20),

CONSTRAINT fk_shipping_order FOREIGN KEY (Order_Id) REFERENCES Orders(Order_Id),
CONSTRAINT chk_shipment_status CHECK(Shipment_Status IN ('Packed', 'In Transit' ,'Delivered', 'Returned'))

);
SELECT * FROM Shippings;

-- STEP 8. Create Review Table
CREATE TABLE Reviews(
Review_Id INT PRIMARY KEY AUTO_INCREMENT,
Customer_Id INT NOT NULL,
Product_Id INT NOT NULL,
Rating INT ,
Review_Date DATE,

CONSTRAINT fk_review_customer FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id),
CONSTRAINT fk_review_product FOREIGN KEY (Product_Id) REFERENCES Products(Product_Id),  
CONSTRAINT chk_review_rating CHECK(Rating BETWEEN 1 AND 5),
CONSTRAINT uq_customer_product_review UNIQUE (Customer_Id, Product_Id)
);
SELECT * FROM Reviews;

SHOW TABLES;

-- STEP 9. CREATE SEQUENCES

ALTER TABLE Customers AUTO_INCREMENT = 1001;
ALTER TABLE Products AUTO_INCREMENT = 2001;
ALTER TABLE Orders AUTO_INCREMENT = 3001;
ALTER TABLE Order_Details AUTO_INCREMENT = 4001;
ALTER TABLE Payments AUTO_INCREMENT = 5001;
ALTER TABLE Shippings AUTO_INCREMENT = 6001;  
ALTER TABLE Reviews AUTO_INCREMENT = 7001;

-- 10. Insert Records
-- Minimum 10 Categories
-- Minimum 50 Products
-- Minimum 30 Customers
-- Minimum 50 Orders
-- Minimum 100 Order Details
-- Minimum 50 Payments
-- Minimum 50 Shipping Records
-- Minimum 50 Reviews

INSERT INTO Category (Category_Id, Category_Name)
VALUES
(1, 'Electronics'),
(2, 'Fashion'),
(3, 'Mobiles'),
(4, 'Accessories'),
(5, 'Home Appliances'),
(6, 'Computers'),
(7, 'Beauty'),
(8, 'Sports'),
(9, 'Books'),
(10, 'Furniture');

SELECT * from Category;  
SELECT count(*) as Total_Categories from Category; 

INSERT INTO Customers
(Customer_Name, Email, Mobile_Number, Gender, Registration_Date, City)
VALUES
('Aarav Sharma','aarav@gmail.com','9000000001','Male','2025-01-05','Chennai'),
('Ananya Rao','ananya@gmail.com','9000000002','Female','2025-01-08','Bangalore'),
('Arjun Kumar','arjun@gmail.com','9000000003','Male','2025-01-12','Mumbai'),
('Aishwarya Singh','aishwarya@gmail.com','9000000004','Female','2025-01-15','Delhi'),
('Aditya Verma','aditya@gmail.com','9000000005','Male','2025-01-20','Hyderabad'),
('Priya Nair','priya@gmail.com','9000000006','Female','2025-02-01','Kochi'),
('Rahul Mehta','rahul@gmail.com','9000000007','Male','2025-02-04','Pune'),
('Sneha Iyer','sneha@gmail.com','9000000008','Female','2025-02-08','Chennai'),
('Vikram Patel','vikram@gmail.com','9000000009','Male','2025-02-12','Ahmedabad'),
('Neha Kapoor','neha@gmail.com','9000000010','Female','2025-02-15','Delhi'),
('Rohan Gupta','rohan@gmail.com','9000000011','Male','2025-02-18','Jaipur'),
('Kavya Menon','kavya@gmail.com','9000000012','Female','2025-02-20','Kochi'),
('Sanjay Rao','sanjay@gmail.com','9000000013','Male','2025-03-01','Bangalore'),
('Meera Shah','meera@gmail.com','9000000014','Female','2025-03-05','Mumbai'),
('Karan Joshi','karan@gmail.com','9000000015','Male','2025-03-08','Pune'),
('Divya Reddy','divya@gmail.com','9000000016','Female','2025-03-10','Hyderabad'),
('Nikhil Das','nikhil@gmail.com','9000000017','Male','2025-03-15','Kolkata'),
('Pooja Agarwal','pooja@gmail.com','9000000018','Female','2025-03-20','Delhi'),
('Manish Jain','manish@gmail.com','9000000019','Male','2025-03-22','Jaipur'),
('Swathi Kumar','swathi@gmail.com','9000000020','Female','2025-03-25','Chennai'),
('Abhishek Roy','abhishek@gmail.com','9000000021','Male','2025-04-01','Kolkata'),
('Ishita Bose','ishita@gmail.com','9000000022','Female','2025-04-05','Kolkata'),
('Varun Malhotra','varun@gmail.com','9000000023','Male','2025-04-08','Delhi'),
('Lakshmi Krishnan','lakshmi@gmail.com','9000000024','Female','2025-04-12','Chennai'),
('Suresh Babu','suresh@gmail.com','9000000025','Male','2025-04-15','Chennai'),
('Riya Sen','riya@gmail.com','9000000026','Female','2025-04-18','Kolkata'),
('Mohit Agarwal','mohit@gmail.com','9000000027','Male','2025-04-20','Mumbai'),
('Nandini Rao','nandini@gmail.com','9000000028','Female','2025-04-25','Bangalore'),
('Deepak Kumar','deepak@gmail.com','9000000029','Male','2025-05-01','Pune'),
('Shreya Das','shreya@gmail.com','9000000030','Female','2025-05-05','Kolkata'),
('Ajay Singh','ajay@gmail.com','9000000031','Male','2025-05-08','Delhi'),
('Maya Joseph','maya@gmail.com','9000000032','Female','2025-05-10','Kochi'),
('Akash Mishra','akash@gmail.com','9000000033','Male','2025-05-15','Lucknow'),
('Tanya Kapoor','tanya@gmail.com','9000000034','Female','2025-05-18','Delhi'),
('Harish Nair','harish@gmail.com','9000000035','Male','2025-05-20','Kochi'),
('Ritu Sharma','ritu@gmail.com','9000000036','Female','2025-05-25','Chennai'),
('Gaurav Singh','gaurav@gmail.com','9000000037','Male','2025-06-01','Delhi'),
('Nisha Patel','nisha@gmail.com','9000000038','Female','2025-06-05','Ahmedabad'),
('Ramesh Kumar','ramesh@gmail.com','9000000039','Male','2025-06-08','Chennai'),
('Pallavi Rao','pallavi@gmail.com','9000000040','Female','2025-06-10','Bangalore'),
('Aman Verma','aman@gmail.com','9000000041','Male','2025-06-15','Delhi'),
('Simran Kaur','simran@gmail.com','9000000042','Female','2025-06-18','Chandigarh'),
('Vivek Shah','vivek@gmail.com','9000000043','Male','2025-06-20','Mumbai'),
('Komal Jain','komal@gmail.com','9000000044','Female','2025-06-25','Jaipur'),
('Rajesh Iyer','rajesh@gmail.com','9000000045','Male','2025-07-01','Chennai'),
('Pavithra Menon','pavithra@gmail.com','9000000046','Female','2025-07-05','Kochi'),
('Tarun Gupta','tarun@gmail.com','9000000047','Male','2025-07-08','Delhi'),
('Sonia Roy','sonia@gmail.com','9000000048','Female','2025-07-10','Kolkata'),
('Yash Patel','yash@gmail.com','9000000049','Male','2025-07-15','Ahmedabad'),
('Anjali Das','anjali@gmail.com','9000000050','Female','2025-07-20','Kolkata');

SELECT * FROM Customers;
SELECT COUNT(*) AS Total_Customers FROM Customers;

INSERT INTO Products
(Product_Name, Category_Id, Brand_Name, Price, Stock_Quantity)
VALUES

('Wireless Headphones',1,'Sony',12000,50),
('Bluetooth Speaker',1,'JBL',8000,45),
('Smart Television',1,'LG',65000,15),
('Smart Watch Pro',1,'Samsung',22000,30),
('Digital Camera',1,'Canon',55000,12),

('Men Shirt',2,'Peter England',2500,80),
('Women Dress',2,'Biba',4500,70),
('Men Jeans',2,'Levis',3500,65),
('Women Jeans',2,'Levis',4000,60),
('Sports Shoes',2,'Nike',7500,40),

('Galaxy Phone Pro',3,'Samsung',65000,25),
('iPhone Pro Max',3,'Apple',120000,15),
('Pixel Phone Pro',3,'Google',75000,20),
('OnePlus Phone Pro',3,'OnePlus',55000,30),
('Vivo Phone Pro',3,'Vivo',40000,35),

('Phone Case',4,'Spigen',1800,100),
('USB Cable',4,'Belkin',1200,150),
('Power Bank',4,'Mi',2500,90),
('Wireless Charger',4,'Anker',3500,75),
('Laptop Bag',4,'American Tourister',3000,50),

('Refrigerator',5,'LG',55000,10),
('Washing Machine',5,'Samsung',48000,12),
('Microwave Oven',5,'IFB',18000,20),
('Air Conditioner',5,'Voltas',42000,15),
('Mixer Grinder',5,'Philips',6000,40),

('Laptop Pro 14',6,'Dell',85000,18),
('Laptop Air Pro',6,'Apple',110000,12),
('Gaming Laptop Pro',6,'Asus',95000,10),
('ThinkPad Pro',6,'Lenovo',90000,20),
('Notebook Pro',6,'HP',70000,25),

('Tablet Pro',6,'Apple',70000,15),
('Monitor Pro',6,'Dell',28000,25),
('Keyboard Pro',6,'Logitech',5000,50),
('Mouse Pro',6,'Logitech',3000,60),
('Desktop Pro',6,'HP',75000,12),

('Face Cream',7,'Lakme',800,100),
('Perfume Pro',7,'Fogg',1500,90),
('Lipstick',7,'Maybelline',700,120),
('Face Wash',7,'Nivea',500,110),
('Hair Serum',7,'Loreal',1200,85),

('Cricket Bat',8,'SS',6500,25),
('Football',8,'Adidas',2500,40),
('Tennis Racket',8,'Wilson',8000,20),
('Running Shoes',8,'Adidas',6000,35),
('Yoga Mat',8,'Boldfit',1500,70),

('SQL Programming Book',9,'Pearson',1200,40),
('Java Programming Book',9,'McGraw Hill',1500,35),
('Python Programming Book',9,'OReilly',1800,30),
('Database Systems Book',9,'Pearson',2000,25),
('Business Analytics Book',9,'Wiley',2200,20);
ALTER TABLE Products ADD COLUMN Product_Description TEXT;
UPDATE Products
SET Product_Description = 
    CONCAT('Premium ' , Product_Name, ' Product with Pro Features.')
WHERE Product_Id BETWEEN 2001 AND 2050;

SELECT * FROM Products;
SELECT COUNT(*) AS Total_Products FROM Products;

INSERT INTO Orders
(Customer_Id, Order_Date, Order_Status, Total_Amount)
VALUES
(1001,'2025-08-01','Delivered',122000),
(1002,'2025-08-02','Delivered',104000),
(1003,'2025-08-03','Shipped',101000),
(1004,'2025-08-04','Delivered',64000),
(1005,'2025-08-05','Placed',61000),
(1006,'2025-08-06','Delivered',12500),
(1007,'2025-08-07','Shipped',10500),
(1008,'2025-08-08','Delivered',5900),
(1009,'2025-08-09','Packed',60000),
(1010,'2025-08-10','Delivered',77500),

(1011,'2025-08-11','Delivered',175000),
(1012,'2025-08-12','Delivered',216000),
(1013,'2025-08-13','Shipped',111000),
(1014,'2025-08-14','Delivered',97000),
(1015,'2025-08-15','Placed',46000),
(1016,'2025-08-16','Delivered',97800),
(1017,'2025-08-17','Delivered',2800),
(1018,'2025-08-18','Shipped',4000),
(1019,'2025-08-19','Delivered',4900),
(1020,'2025-08-20','Delivered',9000),

(1021,'2025-08-21','Delivered',111000),
(1022,'2025-08-22','Shipped',66000),
(1023,'2025-08-23','Delivered',60000),
(1024,'2025-08-24','Delivered',48000),
(1025,'2025-08-25','Packed',61000),
(1026,'2025-08-26','Delivered',195000),
(1027,'2025-08-27','Delivered',250000),
(1028,'2025-08-28','Shipped',165000),
(1029,'2025-08-29','Delivered',175000),
(1030,'2025-08-30','Delivered',71600),

(1031,'2025-09-01','Delivered',98000),
(1032,'2025-09-02','Shipped',38000),
(1033,'2025-09-03','Delivered',8000),
(1034,'2025-09-04','Delivered',78000),
(1035,'2025-09-05','Placed',145000),
(1036,'2025-09-06','Delivered',2300),
(1037,'2025-09-07','Delivered',2200),
(1038,'2025-09-08','Shipped',1200),
(1039,'2025-09-09','Delivered',1700),
(1040,'2025-09-10','Delivered',7700),

(1041,'2025-09-11','Delivered',9000),
(1042,'2025-09-12','Delivered',10500),
(1043,'2025-09-13','Shipped',14000),
(1044,'2025-09-14','Delivered',7500),
(1045,'2025-09-15','Placed',2700),
(1046,'2025-09-16','Delivered',2700),
(1047,'2025-09-17','Delivered',3300),
(1048,'2025-09-18','Shipped',3800),
(1049,'2025-09-19','Delivered',4200),
(1050,'2025-09-20','Delivered',8200);

SELECT * FROM Orders;
SELECT count(*) AS Total_Orders FROM Orders;


INSERT INTO Order_Details
(Order_Id, Product_Id, Quantity, Unit_Price)
VALUES
(3001,2001,1,12000),
(3001,2021,2,55000),
(3002,2002,1,8000),
(3002,2022,2,48000),
(3003,2003,1,65000),
(3003,2023,2,18000),
(3004,2004,1,22000),
(3004,2024,1,42000),
(3005,2005,1,55000),
(3005,2025,1,6000),
(3006,2006,1,2500),
(3006,2033,2,5000),
(3007,2007,1,4500),
(3007,2034,2,3000),
(3008,2008,1,3500),
(3008,2040,2,1200),
(3009,2009,1,4000),
(3009,2032,2,28000),
(3010,2010,1,7500),
(3010,2031,1,70000),

(3011,2011,1,65000),
(3011,2021,2,55000),
(3012,2012,1,120000),
(3012,2022,2,48000),
(3013,2013,1,75000),
(3013,2023,2,18000),
(3014,2014,1,55000),
(3014,2024,1,42000),
(3015,2015,1,40000),
(3015,2025,1,6000),
(3016,2016,1,1800),
(3016,2022,2,48000),
(3017,2017,1,1200),
(3017,2036,2,800),
(3018,2018,1,2500),
(3018,2037,1,1500),
(3019,2019,1,3500),
(3019,2038,2,700),
(3020,2020,1,3000),
(3020,2044,1,6000),

(3021,2021,2,55000),
(3021,2039,2,500),
(3022,2022,1,48000),
(3022,2023,1,18000),
(3023,2023,1,18000),
(3023,2024,1,42000),
(3024,2024,1,42000),
(3024,2025,1,6000),
(3025,2025,1,6000),
(3025,2021,1,55000),
(3026,2026,1,85000),
(3026,2027,1,110000),
(3027,2027,1,110000),
(3027,2030,2,70000),
(3028,2028,1,95000),
(3028,2030,1,70000),
(3029,2029,1,90000),
(3029,2026,1,85000),
(3030,2030,1,70000),
(3030,2036,2,800),

(3031,2031,1,70000),
(3031,2032,1,28000),
(3032,2032,1,28000),
(3032,2033,2,5000),
(3033,2033,1,5000),
(3033,2034,1,3000),
(3034,2034,1,3000),
(3034,2035,1,75000),
(3035,2035,1,75000),
(3035,2031,1,70000),
(3036,2036,1,800),
(3036,2037,1,1500),
(3037,2037,1,1500),
(3037,2038,1,700),
(3038,2038,1,700),
(3038,2039,1,500),
(3039,2039,1,500),
(3039,2040,1,1200),
(3040,2040,1,1200),
(3040,2041,1,6500),

(3041,2041,1,6500),
(3041,2042,1,2500),
(3042,2042,1,2500),
(3042,2043,1,8000),
(3043,2043,1,8000),
(3043,2044,1,6000),
(3044,2044,1,6000),
(3044,2045,1,1500),
(3045,2045,1,1500),
(3045,2046,1,1200),
(3046,2046,1,1200),
(3046,2047,1,1500),
(3047,2047,1,1500),
(3047,2048,1,1800),
(3048,2048,1,1800),
(3048,2049,1,2000),
(3049,2049,1,2000),
(3049,2050,1,2200),
(3050,2050,1,2200),
(3050,2044,1,6000);

SELECT * FROM Order_Details;
SELECT COUNT(*) AS Total_Order_Details FROM Order_Details;

-- To verify order totals matches order details total
SELECT
    o.Order_Id,
    o.Total_Amount AS Order_Total,
    SUM(od.Quantity * od.Unit_Price) AS Detail_Total,
    CASE
        WHEN o.Total_Amount = SUM(od.Quantity * od.Unit_Price)
        THEN 'CORRECT'
        ELSE 'MISMATCH'
    END AS Verification
FROM Orders o
JOIN Order_Details od
    ON o.Order_Id = od.Order_Id
GROUP BY o.Order_Id, o.Total_Amount
HAVING o.Total_Amount <> SUM(od.Quantity * od.Unit_Price);


INSERT INTO Payments
(Order_ID, Payment_Date, Payment_Mode, Payment_Amount, Payment_Status)
VALUES
(3001,'2025-08-01','UPI',122000,'Success'),
(3002,'2025-08-02','Card',104000,'Success'),
(3003,'2025-08-03','UPI',101000,'Success'),
(3004,'2025-08-04','Card',64000,'Success'),
(3005,'2025-08-05','Cash On Delivery',61000,'Pending'),
(3006,'2025-08-06','Net Banking',12500,'Success'),
(3007,'2025-08-07','Card',10500,'Success'),
(3008,'2025-08-08','UPI',5900,'Success'),
(3009,'2025-08-09','Net Banking',60000,'Success'),
(3010,'2025-08-10','Card',77500,'Success'),

(3011,'2025-08-11','UPI',175000,'Success'),
(3012,'2025-08-12','UPI',216000,'Success'),
(3013,'2025-08-13','Card',111000,'Success'),
(3014,'2025-08-14','UPI',97000,'Success'),
(3015,'2025-08-15','Cash On Delivery',46000,'Pending'),
(3016,'2025-08-16','UPI',97800,'Success'),
(3017,'2025-08-17','Card',2800,'Success'),
(3018,'2025-08-18','UPI',4000,'Success'),
(3019,'2025-08-19','Net Banking',4900,'Success'),
(3020,'2025-08-20','Card',9000,'Success'),

(3021,'2025-08-21','UPI',111000,'Success'),
(3022,'2025-08-22','UPI',66000,'Success'),
(3023,'2025-08-23','Card',60000,'Success'),
(3024,'2025-08-24','UPI',48000,'Success'),
(3025,'2025-08-25','Cash On Delivery',61000,'Pending'),
(3026,'2025-08-26','Card',195000,'Success'),
(3027,'2025-08-27','UPI',250000,'Success'),
(3028,'2025-08-28','Card',165000,'Success'),
(3029,'2025-08-29','Net Banking',175000,'Success'),
(3030,'2025-08-30','UPI',71600,'Success'),

(3031,'2025-09-01','Card',98000,'Success'),
(3032,'2025-09-02','UPI',38000,'Success'),
(3033,'2025-09-03','UPI',8000,'Success'),
(3034,'2025-09-04','Card',78000,'Success'),
(3035,'2025-09-05','Net Banking',145000,'Success'),
(3036,'2025-09-06','UPI',2300,'Success'),
(3037,'2025-09-07','Card',2200,'Success'),
(3038,'2025-09-08','UPI',1200,'Success'),
(3039,'2025-09-09','UPI',1700,'Success'),
(3040,'2025-09-10','Card',7700,'Success'),

(3041,'2025-09-11','Net Banking',9000,'Success'),
(3042,'2025-09-12','UPI',10500,'Success'),
(3043,'2025-09-13','Card',14000,'Success'),
(3044,'2025-09-14','UPI',7500,'Success'),
(3045,'2025-09-15','Cash On Delivery',2700,'Pending'),
(3046,'2025-09-16','UPI',2700,'Success'),
(3047,'2025-09-17','Card',3300,'Success'),
(3048,'2025-09-18','UPI',3800,'Success'),
(3049,'2025-09-19','Net Banking',4200,'Success'),
(3050,'2025-09-20','Card',8200,'Success');

SELECT * FROM Payments;
SELECT COUNT(*) AS Total_Payments FROM Payments;

INSERT INTO Shippings
(Order_Id, Courier_Partner, Shipment_Date, Delivery_Date, Shipment_Status)
VALUES
(3001,'BlueDart','2025-08-01','2025-08-04','Delivered'),
(3002,'Delhivery','2025-08-02','2025-08-06','Delivered'),
(3003,'DTDC','2025-08-03',NULL,'In Transit'),
(3004,'BlueDart','2025-08-04','2025-08-07','Delivered'),
(3005,'Delhivery','2025-08-05',NULL,'Packed'),
(3006,'DTDC','2025-08-06','2025-08-09','Delivered'),
(3007,'BlueDart','2025-08-07','2025-08-10','Delivered'),
(3008,'Delhivery','2025-08-08','2025-08-12','Delivered'),
(3009,'DTDC','2025-08-09',NULL,'Packed'),
(3010,'BlueDart','2025-08-10','2025-08-13','Delivered'),
(3011,'Delhivery','2025-08-11','2025-08-14','Delivered'),
(3012,'DTDC','2025-08-12','2025-08-15','Delivered'),
(3013,'BlueDart','2025-08-13',NULL,'In Transit'),
(3014,'Delhivery','2025-08-14','2025-08-17','Delivered'),
(3015,'DTDC','2025-08-15',NULL,'Packed'),
(3016,'BlueDart','2025-08-16','2025-08-19','Delivered'),
(3017,'Delhivery','2025-08-17','2025-08-20','Delivered'),
(3018,'DTDC','2025-08-18',NULL,'In Transit'),
(3019,'BlueDart','2025-08-19','2025-08-22','Delivered'),
(3020,'Delhivery','2025-08-20','2025-08-23','Delivered'),
(3021,'DTDC','2025-08-21','2025-08-24','Delivered'),
(3022,'BlueDart','2025-08-22',NULL,'In Transit'),
(3023,'Delhivery','2025-08-23','2025-08-26','Delivered'),
(3024,'DTDC','2025-08-24','2025-08-27','Delivered'),
(3025,'BlueDart','2025-08-25',NULL,'Packed'),
(3026,'Delhivery','2025-08-26','2025-08-29','Delivered'),
(3027,'DTDC','2025-08-27','2025-08-30','Delivered'),
(3028,'BlueDart','2025-08-28',NULL,'In Transit'),
(3029,'Delhivery','2025-08-29','2025-09-01','Delivered'),
(3030,'DTDC','2025-08-30','2025-09-02','Delivered'),
(3031,'BlueDart','2025-09-01','2025-09-04','Delivered'),
(3032,'Delhivery','2025-09-02',NULL,'In Transit'),
(3033,'DTDC','2025-09-03','2025-09-06','Delivered'),
(3034,'BlueDart','2025-09-04','2025-09-07','Delivered'),
(3035,'Delhivery','2025-09-05',NULL,'Packed'),
(3036,'DTDC','2025-09-06','2025-09-09','Delivered'),
(3037,'BlueDart','2025-09-07','2025-09-10','Delivered'),
(3038,'Delhivery','2025-09-08',NULL,'In Transit'),
(3039,'DTDC','2025-09-09','2025-09-12','Delivered'),
(3040,'BlueDart','2025-09-10','2025-09-13','Delivered'),
(3041,'Delhivery','2025-09-11','2025-09-14','Delivered'),
(3042,'DTDC','2025-09-12','2025-09-15','Delivered'),
(3043,'BlueDart','2025-09-13','2025-09-16','Delivered'),
(3044,'Delhivery','2025-09-14','2025-09-17','Delivered'),
(3045,'DTDC','2025-09-15',NULL,'Packed'),
(3046,'BlueDart','2025-09-16','2025-09-19','Delivered'),
(3047,'Delhivery','2025-09-17','2025-09-20','Delivered'),
(3048,'DTDC','2025-09-18',NULL,'In Transit'),
(3049,'BlueDart','2025-09-19','2025-09-22','Delivered'),
(3050,'Delhivery','2025-09-20','2025-09-23','Delivered');

SELECT * FROM Shippings;
SELECT COUNT(*) AS Total_Shipments FROM Shippings;

INSERT INTO Reviews
(Customer_Id, Product_Id, Rating, Review_Date)
VALUES
(1001,2001,5,'2025-08-05'),
(1002,2002,4,'2025-08-06'),
(1003,2003,5,'2025-08-07'),
(1004,2004,4,'2025-08-08'),
(1005,2005,3,'2025-08-09'),
(1006,2006,5,'2025-08-10'),
(1007,2007,4,'2025-08-11'),
(1008,2008,5,'2025-08-12'),
(1009,2009,4,'2025-08-13'),
(1010,2010,5,'2025-08-14'),
(1011,2011,4,'2025-08-15'),
(1012,2012,3,'2025-08-16'),
(1013,2013,5,'2025-08-17'),
(1014,2014,4,'2025-08-18'),
(1015,2015,5,'2025-08-19'),
(1016,2016,4,'2025-08-20'),
(1017,2017,3,'2025-08-21'),
(1018,2018,5,'2025-08-22'),
(1019,2019,4,'2025-08-23'),
(1020,2020,5,'2025-08-24'),
(1021,2021,4,'2025-08-25'),
(1022,2022,5,'2025-08-26'),
(1023,2023,3,'2025-08-27'),
(1024,2024,4,'2025-08-28'),
(1025,2025,5,'2025-08-29'),
(1026,2026,4,'2025-08-30'),
(1027,2027,5,'2025-09-01'),
(1028,2028,4,'2025-09-02'),
(1029,2029,3,'2025-09-03'),
(1030,2030,5,'2025-09-04'),
(1031,2031,4,'2025-09-05'),
(1032,2032,5,'2025-09-06'),
(1033,2033,4,'2025-09-07'),
(1034,2034,3,'2025-09-08'),
(1035,2035,5,'2025-09-09'),
(1036,2036,4,'2025-09-10'),
(1037,2037,5,'2025-09-11'),
(1038,2038,4,'2025-09-12'),
(1039,2039,3,'2025-09-13'),
(1040,2040,5,'2025-09-14'),
(1041,2041,4,'2025-09-15'),
(1042,2042,5,'2025-09-16'),
(1043,2043,4,'2025-09-17'),
(1044,2044,3,'2025-09-18'),
(1045,2045,5,'2025-09-19'),
(1046,2046,4,'2025-09-20'),
(1047,2047,5,'2025-09-21'),
(1048,2048,4,'2025-09-22'),
(1049,2049,5,'2025-09-23'),
(1050,2050,4,'2025-09-24');

SELECT * FROM Reviews;
SELECT COUNT(*) as Total_Reviews from Reviews;

-- STEP 11. Single Row Functions Questions:
-- 1. Display product name in uppercase.
SELECT Product_Name, UCASE(Product_Name) FROM Products;

-- 2. Display first 5 characters of customer name.
SELECT Customer_Name, LEFT(Customer_Name,5) AS First_5_characters FROM Customers;

-- 3. Display length of product names.
SELECT Product_Name, LENGTH(Product_Name) AS Product_Name_Length FROM Products; 

-- 4. Display registration month of customers.
SELECT Customer_Name, Registration_Date, MONTHNAME(Registration_Date) AS Month_of_Registration FROM Customers; 

-- 5. Display brand names in lowercase.
SELECT Brand_Name, LCASE(Brand_Name) FROM Products;

-- STEP 12. Aggregate Function Questions:
-- 1. Find highest product price.
SELECT MAX(price) AS Costliest_Product FROM Products;
-- 1. Find highest product price with product name.
SELECT Product_Name, Price AS Costliest_Product FROM Products  WHERE Price = (SELECT MAX(Price) FROM Products);

-- 2. Find lowest product price.
SELECT MIN(price) AS Cheapest_Product FROM Products;
-- 2. Find lowest product price with product name.
SELECT Product_Name, Price AS Cheapest_Product FROM Products WHERE Price = (SELECT MIN(Price) FROM Products);

-- 3. Find average product price.
SELECT AVG(Price) AS Average_Product_Price FROM Products;

-- 4. Find total revenue generated.
SELECT SUM(Payment_Amount) AS Total_Revenue FROM Payments WHERE Payment_Status = 'Success';

-- 5.Count total orders.
SELECT COUNT(*) AS Total_Orders FROM Orders;

-- 13. Group By Questions:
-- 1.Catergory-wise product count.
SELECT c.Category_Name, COUNT(p.Product_Id) AS Product_Count
 FROM Category c LEFT JOIN Products p 
  ON c.Category_Id = p.Category_Id GROUP BY c.Category_Id, c.Category_Name;
 
 -- 2.Customer-wise order count.
 SELECT c.Customer_Id,c.Customer_Name, COUNT(o.Order_Id) AS Order_Count
 FROM Customers c LEFT JOIN Orders o 
  ON c.Customer_Id = o.Customer_Id GROUP BY c.Customer_Id, c.Customer_Name;
 
 -- 3. Category wise sales revenue.
 SELECT c.Category_Name, sum(od.Quantity * od.Unit_Price) as Sales_Revenue 
 FROM Category c JOIN products p 
  ON c.Category_Id = p.Category_Id
   JOIN Order_Details od
     ON p.Product_Id = od.Product_Id GROUP BY c.Category_Id, c.Category_Name;
 
 -- 4. Payment mode wise revenue.
 SELECT Payment_Mode, SUM(Payment_Amount) AS Revenue FROM Payments
 WHERE Payment_Status = 'Success' GROUP BY Payment_Mode;
 
 -- 5. Brand wise product count.
 SELECT Brand_Name, COUNT(*) AS Product_Count FROM Products
 GROUP BY Brand_Name;
 
 -- 14. Having Clause Questions
 -- 1. Display categories having more than 5 products.
 SELECT c. Category_Name, COUNT(p.Product_Id) AS Product_Count FROM Category c 
 JOIN Products p ON c.Category_Id = p.Category_Id 
 GROUP BY c.Category_Id, c.Category_Name
 HAVING COUNT(p.Product_Id) > 5;
 
 -- 2. Display Customers having placed more than 3 orders
 SELECT c.Customer_Id, c.Customer_Name, COUNT(o.Order_Id) AS Order_Count FROM Customers c
 JOIN Orders o ON c.Customer_Id = o.Customer_Id
 GROUP BY c.Customer_Id, c.Customer_Name
 HAVING COUNT(o.Order_Id) > 3;
 
 -- 3. Display categories generating revenue above Rs 1,00,000.
 SELECT c.Category_Name, SUM(od.Quantity * od.Unit_Price) AS Revenue FROM Category c
 JOIN Products p ON c.Category_Id = p.Category_Id 
 JOIN Order_Details od ON p.Product_Id = od.Product_Id
 GROUP BY c.Category_Id, c.Category_Name
 HAVING SUM(od.Quantity * od.Unit_Price) > 100000;
 
 -- STEP 15. Inner Join Questions
 -- Display Customer Name, Product Name, Order Date, Quantity, Total Amount
 SELECT 
 c.Customer_Name,
 p.Product_Name,
 o.Order_Date,
 od.Quantity,
 o.Total_Amount 
 FROM Customers c
 INNER JOIN Orders o ON c.Customer_Id = o.Customer_Id
 INNER JOIN Order_Details od ON o.Order_Id = od.Order_Id
 INNER JOIN Products p ON od.Product_Id = p.Product_Id;
 
 -- 16.Left Join Questions
 -- Display all customers including customers who never placed orders.
 SELECT 
 c.Customer_Id,
 c.Customer_Name,
 c.Email,
 o.Order_Id,
 o.Order_Date,
 o.Total_Amount
 FROM Customers c
 LEFT JOIN Orders o ON c.Customer_Id = o.Customer_Id;
 
 -- STEP 17. Right Join Questions
 -- Display all products including products never ordered.
 SELECT p.Product_Id,
        p.Product_Name,
        p.Price,
        od.Order_Id,
        od.Quantity,
        od.Unit_Price
 FROM Order_Details od
 RIGHT JOIN Products p ON od.Product_Id = p.Product_Id;
 
 -- STEP 18. Full Outer Join(Left Join + Right Join with Union) Questions
 -- 1. Display complete customer and order information.
 SELECT c.Customer_Id,
        c.Customer_Name,
        o.Order_Id,
        o.Order_Date,
        o.Order_Status,
        o.Total_Amount
 FROM Customers c
 LEFT JOIN Orders o ON c.Customer_Id = o.Customer_Id
 
 UNION
 
 SELECT c.Customer_Id,
		c.Customer_Name,
        o.Order_Id,
        o.Order_Date,
        o.Order_Status,
        o.Total_Amount
 FROM Customers c
 RIGHT JOIN Orders o ON c.Customer_Id = o.Customer_Id;
 
 -- STEP 19. Cross Join Questions
 -- Generate all possible combinations of Customers and Product Categories
 SELECT 
 c.Customer_Name,
 cat.Category_Name
 FROM Customers c
 CROSS JOIN Category cat;
 
 -- 20. Mutli Table Join
 -- Display Customer Name ,Product Name, Quantity, Payment Amount and Shipment Status
 SELECT 
 c.Customer_Name,
 p.Product_Name,
 cat.Category_Name,
 od.Quantity,
 pay.Payment_Amount,
 s.Shipment_Status
 FROM Customers c
 JOIN Orders o 
    ON c.Customer_Id = o.Customer_Id
 JOIN Order_Details od
    ON o.Order_Id = od.Order_Id
 JOIN Products p
    ON od.Product_Id = p.Product_Id
 JOIN  Category cat
    ON p.Category_Id = cat.Category_Id
 LEFT JOIN Payments pay
    ON o.Order_Id = pay.Order_Id
 LEFT JOIN Shippings s
    ON o.Order_Id = s.Order_Id;
    
-- 21. Single Row Subqueries
-- 1. Products costing more than average prodduct price
SELECT Product_Id, Product_Name, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- 2. Customers whose total purchases exceed Customer X(X-->Customer Id= 1001)
SELECT c.Customer_Id, c.Customer_Name,
  SUM(o.Total_Amount) AS Total_Purchases 
 FROM Customers c
 JOIN Orders o ON c.Customer_Id = o.Customer_Id 
 GROUP BY c.Customer_Id, c.Customer_Name
 HAVING SUM(o.Total_Amount) >
 (
   SELECT SUM(Total_Amount)
   FROM Orders 
   WHERE Customer_Id = 1001
   );
   
-- 3. Products priced higher than the most expensive product in a selected(=Computers) category
SELECT Product_Name,Price
FROM Products p
WHERE Price > (
  SELECT MAX(p.Price)
    FROM Products p
    JOIN Category c
       ON p.Category_Id = c.Category_Id 
    WHERE c.Category_Name ='Computers'
);
 
 -- 22. Mutliple Row Subquery Questions
 -- USING IN:
 
 -- 1. Find customers who purchased products from Electronics and Fashion categories.
SELECT DISTINCT c.Customer_Id, c.Customer_Name
FROM Customers c
JOIN Orders o
  ON c.Customer_Id = o.Customer_Id
JOIN Order_Details od
  ON o.Order_Id = od.Order_Id
WHERE od.Product_Id IN (
  SELECT p.Product_Id 
  FROM Products p
  JOIN Category cat
	ON p.Category_Id = cat.Category_Id
  WHERE cat.Category_Name IN ('Electronics', 'Fashion')
);

-- Using ANY:
-- 2.Find products priced higher than any product in the Mobile category.
SELECT Product_Id, Product_Name,Price 
FROM Products 
WHERE Price > ANY
(
 SELECT p.Price
 FROM Products p
 JOIN Category c
   ON p.Category_Id = c.Category_Id
 WHERE c.Category_Name = 'Mobiles' );

-- Using All:
-- 3. Find products priced higher than all products in the Accessories category.
SELECT Product_Name, Price 
FROM Products
WHERE Price > ALL 
(
 SELECT p.Price
 FROM Products p
 JOIN Category c
   ON p.Category_Id = c.Category_Id
 WHERE c.Category_Name = 'Accessories'
);

-- STEP 23. Nested Subquery Questions

-- 1. Find customers who purchased products from the category generating highest revenue.
SELECT DISTINCT c.Customer_Id,c.Customer_Name
 FROM Customers c
 JOIN Orders o
   ON c.Customer_Id = o.Customer_Id
 JOIN Order_Details od
   ON o.Order_Id = od.Order_Id
 JOIN Products p
   ON od.Product_Id = p.Product_Id
 WHERE p.Category_Id =
  (SELECT Category_Id 
   FROM 
    (SELECT p2.Category_Id,
      SUM(od2.Quantity * od2.Unit_Price) AS Revenue
     FROM Products p2
     JOIN Order_Details od2
         ON p2.Product_Id = od2.Product_Id
     GROUP BY p2.Category_Id
     ORDER BY Revenue DESC
     LIMIT 1
   ) AS Highest_Category
);
  
  -- 2. Find products belonging to the category with maximum sales.
  SELECT p.Category_Id, p.Product_Id, p.Product_Name,p.Price 
   FROM Products P
   WHERE p.Category_Id = (SELECT Category_Id 
    FROM (
      SELECT 
       p2.Category_Id, SUM(od.Quantity * od.Unit_Price) AS Total_Sales
      FROM Products p2
      JOIN Order_Details od
		ON p2.Product_Id = od.Product_Id
      GROUP BY p2.Category_Id
      ORDER BY Total_Sales DESC
      LIMIT 1
      ) AS max_sales_category
      );
      
   -- 24. Correlated Subquery Questions
   -- 1. Find products priced above their category average price.
   SELECT p.Product_Id, p.Product_Name,p.Category_Id,p.Price
   FROM Products p
   WHERE p.Price > 
   (
     SELECT AVG(p2.Price)
     FROM Products p2 
     WHERE p2.Category_Id = p.Category_Id
     );
     
-- 2. Find customers whose purchase amount exceeds average purchase amount of their city.
SELECT c.Customer_Id, c.Customer_Name, c.City, 
       SUM(o.Total_Amount) AS Purchase_Amount
 FROM Customers c
 JOIN Orders o
   ON c.Customer_Id = o.Customer_Id 
 GROUP BY c.Customer_Id, c.Customer_Name, c.City
 Having SUM(o.Total_Amount) >
 ( 
  SELECT AVG(City_Purchase.Total_Purchase)
  FROM(
     SELECT c2.Customer_Id, c2.City, SUM(o2.Total_Amount) AS Total_Purchase
     FROM Customers c2
     JOIN Orders o2
        ON c2.Customer_Id = o2.Customer_Id
	 GROUP BY c2.Customer_Id, c2.City
     ) AS City_Purchase
   WHERE City_Purchase.City = c.City
   );
   
-- STEP 25. EXISTS Questions
-- 1. Find customers who have placed orders.
SELECT c.Customer_Id, c.Customer_Name
FROM Customers c
WHERE EXISTS (
   SELECT 1
   FROM Orders o
   WHERE o.Customer_Id = c.Customer_Id
  );
  
-- 2. Find products that received reviews
SELECT p.Product_Id,p.Product_Name
FROM Products p
WHERE EXISTS(
   SELECT 1 
   FROM Reviews r
   WHERE r.Product_Id = p.Product_Id
);   
 
-- 3. Find categories containing products.
SELECT c.Category_Id, c.Category_Name
FROM Category c
WHERE EXISTS(
   SELECT 1
   FROM Products p 
   WHERE p.Category_Id = c.Category_Id
 );
   
-- STEP 26. NOT EXISTS Questions
-- 1. Find customers who never placed orders.
SELECT c.Customer_Id, c.Customer_Name
FROM Customers c
WHERE NOT EXISTS(
   SELECT 1 
   FROM Orders o 
   WHERE o.Customer_Id = c.Customer_Id
);

-- 2. Find products never sold.  
SELECT p.Product_Id, p.Product_Name
FROM Products p
WHERE NOT EXISTS (
   SELECT 1 
   FROM Order_Details od
   WHERE od.Product_Id = p.Product_Id
);

-- 3. Find products without reviews
SELECT p.Product_Id, p.Product_Name
FROM Products p
WHERE NOT EXISTS (
   SELECT 1 
   FROM Reviews r 
   WHERE r.Product_Id = p.Product_Id
);
 
 -- 4. Find categories without products
 SELECT c.Category_Id, c.Category_Name
 FROM Category c 
 WHERE NOT EXISTS(
    SELECT 1 
    FROM Products p 
    WHERE p.Category_Id = c.Category_Id
);
   
-- 27. Set Operator Questions
-- 1. Create Current Customers.
CREATE TABLE Current_Customers(
 Customer_Id INT PRIMARY KEY,
 Customer_Name VARCHAR(100)
 );
 INSERT INTO Current_Customers(Customer_Id,Customer_Name)
 SELECT c.Customer_Id, c.Customer_Name 
 FROM Customers c
 WHERE EXISTS(
    SELECT 1 
	FROM Orders o
    WHERE o.Customer_Id = c.Customer_Id
);
SELECT * FROM Current_Customers;
 
-- 2. Create Premium Customers(Customers whose order amount is Rs 1,00,000 or more)
CREATE TABLE Premium_Customers(
 Customer_Id INT PRIMARY KEY,
 Customer_Name VARCHAR(100)
 );
 INSERT INTO Premium_Customers(Customer_Id,Customer_Name)
 SELECT DISTINCT c.Customer_Id, c.Customer_Name 
 FROM Customers c
 JOIN Orders o
   ON c.Customer_Id = o.Customer_Id
 WHERE o.Total_Amount >= 100000;
 
SELECT * FROM Premium_Customers;


-- 3. UNION
SELECT Customer_Id,Customer_Name
FROM Current_Customers
UNION
SELECT Customer_Id,Customer_Name
FROM PREMIUM_Customers;

-- 4. UNION ALL
SELECT Customer_Id,Customer_Name
FROM Current_Customers
UNION ALL
SELECT Customer_Id,Customer_Name
FROM Premium_Customers;

-- 5. INTERSECT 
SELECT Customer_Id, Customer_Name
FROM Current_Customers 
INTERSECT
SELECT Customer_Id, Customer_Name
FROM Premium_Customers;

-- 6. EXCEPT /MINUS
SELECT Customer_Id, Customer_Name
FROM Current_Customers
EXCEPT
SELECT Customer_Id,Customer_Name
FROM Premium_Customers;

-- STEP 28. VIEWS
-- 1. Customer Order Report
CREATE OR REPLACE VIEW Customer_Order_Report AS
SELECT c.Customer_Name, o.Order_Id, o.Order_Date, o.Total_Amount
FROM Customers c
JOIN Orders o ON c.Customer_Id = o.Customer_Id;

SELECT * FROM Customer_Order_Report;

-- 2. Product Sales Report
CREATE OR REPLACE VIEW Product_Sales_Report AS
SELECT p.Product_Name,
       SUM(od.Quantity) AS Quantity_Sold,
       SUM(od.Quantity * od.Unit_Price) AS Revenue_Generated
FROM Products p
JOIN Order_Details od ON p.Product_Id = od.Product_Id
GROUP BY p.Product_Id, p.Product_Name;

SELECT * FROM Product_Sales_Report;

-- 3. Payment_Summary_Report
CREATE OR REPLACE VIEW Payment_Summary_Report AS
SELECT Payment_Mode,
       COUNT(*) AS Total_Transactions,
       SUM(Payment_Amount) AS Revenue
FROM Payments
WHERE Payment_Status = 'Success'
GROUP BY Payment_Mode;

SELECT * FROM Payment_Summary_Report;

-- STEP 29. INDEXES
-- 1. Index on Customer Name
 CREATE INDEX idx_Customer_Name ON Customers(Customer_Name);
 SHOW INDEX FROM Customers; 

 -- 2. Index on Customer Email
 CREATE INDEX idx_Customer_Email ON Customers(Email);
 
 -- 3. Index on Product Name
 CREATE INDEX idx_Product_Name ON Products(Product_Name);
 SHOW INDEX FROM Products; 
 
 -- 4. Index on Order Date
 CREATE INDEX idx_Order_Date ON Orders(Order_Date);
 SHOW INDEX FROM Orders;
 
 -- 5. Index on Customer Mobile Number
 CREATE INDEX idx_Customer_Mobile ON Customers(Mobile_Number);
 
 -- STEP 30. SYNONYMS- LIKE ACCESS USING VIEWS
 -- 1. Customer Table Alternative Name
 CREATE OR REPLACE VIEW Customer_Synonym AS
 SELECT * FROM Customers;
 SELECT * FROM Customer_Synonym;

-- 2. Product Table Aternative Name
CREATE OR REPLACE VIEW Product_Synonym AS
SELECT * FROM Products;
SELECT * FROM Product_Synonym;

-- 3. Order Table Alternative Name
CREATE OR REPLACE VIEW Order_Synonym AS
SELECT * FROM Orders;
SELECT * FROM Order_Synonym;

-- STEP 31. SECURITY COMMANDS
-- 1. Create User
CREATE USER IF NOT EXISTS 'Ecommerce_User'@'Localhost'
IDENTIFIED BY 'Ecommerce@1234';

-- 2. Alter User
ALTER USER 'Ecommerce_User'@'Localhost'
IDENTIFIED BY 'NewPassword@5678';

-- 3. Drop User
-- DROP USER 'Ecommerce_User'@'Localhost';

-- 4. Grant/ Give Privileges(Give Permission)
GRANT SELECT, INSERT, UPDATE, DELETE ON Ecommerce_Order_Management_System.*
TO 'Ecommerce_User'@'Localhost';

-- 5.Revoke/ Take Privileges away(REmove Permission)
REVOKE DELETE ON Ecommerce_Order_Management_System.*
FROM 'Ecommerce_User'@'Localhost'; 

-- 6. Connect Role/ Create Role
CREATE ROLE IF NOT EXISTS 'Connect_Role';
SHOW GRANTS FOR 'Connect_Role'@'%';

GRANT SELECT ON Ecommerce_Order_Management_System.*
TO 'Connect_Role';
SHOW GRANTS FOR 'Connect_Role'@'%';

-- Assign Role(Giving role to the user)
GRANT 'Connect_Role' TO 'Ecommerce_User'@'Localhost';

-- 7.Resource Role
CREATE ROLE IF NOT EXISTS 'Resource_Role';
SHOW GRANTS FOR 'Resource_Role'@'%';

GRANT SELECT, INSERT,UPDATE,DELETE
ON Ecommerce_Order_Management_System.*
TO 'Resource_Role';
SHOW GRANTS FOR 'Resource_Role'@'%';

-- Assign Role(Giving role to user)
GRANT 'Resource_Role' TO 'Ecommerce_User'@'Localhost';

-- 8. DBA Role/ Custom Role
CREATE ROLE IF NOT EXISTS 'DBA_Role';

GRANT ALL PRIVILEGES
ON Ecommerce_Order_Management_System.* TO 'DBA_Role';

GRANT 'DBA_Role' TO 'Ecommerce_User'@'Localhost'; 

-- Set Default Roles
SET DEFAULT ROLE
'Connect_Role', 'Resource_Role' TO 'Ecommerce_User'@'Localhost';

-- Check User Privileges
SHOW GRANTS FOR 'Ecommerce_User'@'Localhost';

-- STEP 32. DATA DICTIONARY
-- Information Schema
-- 1. User Table Equivalent
SELECT Table_Name
FROM Information_Schema.Tables
WHERE Table_Schema = DATABASE();

-- 2.User Objects Equivalent
SELECT TABLE_NAME AS Object_Name,
       TABLE_TYPE AS OBJECT_Type
FROM Information_Schema.Tables
WHERE Table_Schema = DATABASE();

-- 3. User Constraints Equivalent
SELECT Table_Name, Constraint_Name, Constraint_Type
FROM Information_Schema.Table_Constraints
WHERE Table_Schema = DATABASE();

-- 4. All Tables Equivalent
SELECT Table_Schema,Table_Name, Table_Type
FROM Information_Schema.Tables
WHERE Table_Type ='BASE TABLE';

-- STEP 33. Date and Time Functions Questions
-- 1. Display Current Date
SELECT CURRENT_DATE AS Today_Date;

-- 2. Display Current Timestamp
SELECT CURRENT_TIMESTAMP AS Current_Date_Time;

-- 3. Display DB Time Zone
SELECT @@global.Time_Zone AS Database_Time_Zone;

-- 4. Display Session Time Zone
SELECT @@session.Time_Zone AS Session_Time_Zone;

-- 5. Calculate number of days since customer registration
SELECT Customer_Id, Customer_Name, Registration_Date,
       DATEDIFF(CURRENT_DATE, Registration_Date) AS Days_Since_Registration
FROM Customers;

-- 6. Find monthly order growth
SELECT 
  DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
  COUNT(*) AS Total_Orders,
  LAG(COUNT(*)) OVER 
    (ORDER BY DATE_FORMAT(Order_Date, '%Y-%m'))
    AS Previous_Month_Orders,
  COUNT(*) -
  LAG(COUNT(*)) OVER
    (ORDER BY DATE_FORMAT(Order_Date, '%Y-%m'))
    AS Order_Growth
FROM Orders
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Order_Month;    

-- STEP 34. Regular Expressions
-- 1. Find Customer names starting with 'A'
SELECT Customer_Id, Customer_Name
FROM Customers 
WHERE Customer_Name REGEXP '^A';

-- 2. Find Gmail Uses
SELECT Customer_Id, Customer_Name, Email
FROM Customers
WHERE Email REGEXP '@gmail[.]com$';

-- 3. Find product names ending with 'Pro'
SELECT Product_Id, Product_Name
FROM Products
WHERE Product_Name REGEXP 'Pro$';

-- 4. Count occurrences of a word-'Pro' in product description
SELECT Product_Name,
(LENGTH (LOWER (Product_Description))
 -
 LENGTH (REPLACE (LOWER (Product_Description),
  'pro', ''))) /
   LENGTH('pro') AS Pro_Occurrences
FROM Products;   

-- 5. Remove numbrs from product names.
SELECT Product_Name,
       REGEXP_Replace(Product_Name, '[0-9]', '')
         AS Product_Name_Without_Numbers
FROM Products;

-- STEP 35. Inventory & Business Analytics Reports
-- 1. Top 10 Best Selling Products
SELECT p.Product_Id, p.Product_Name, SUM(od.Quantity) AS Quantity_Sold
FROM Products p
JOIN Order_Details od
ON p.Product_Id = od.Product_Id
GROUP BY p.Product_Id, p.Product_Name
ORDER BY Quantity_Sold DESC
LIMIT 10;

-- 2. Top 10 Revenue Generating Products
SELECT p.Product_Id, p.Product_Name,SUM(od.Quantity * od.Unit_Price) AS Revenue_Generated
FROM Products p
JOIN Order_Details od
   ON p.Product_Id = od.Product_Id
GROUP BY p.Product_Id, p.Product_Name
ORDER BY Revenue_Generated DESC
LIMIT 10;

-- 3. Top 10 Customers by spending
SELECT c.Customer_Id, c.Customer_Name,SUM(o.Total_Amount) AS Total_Spending
FROM Customers c
JOIN Orders o
   ON c.Customer_Id = o.Customer_Id
GROUP BY c.Customer_Id, c.Customer_Name
ORDER BY Total_Spending DESC
LIMIT 10;

-- 4. Category wise Revenue
SELECT cat.Category_Name, SUM(od.Quantity * od.Unit_Price) AS Revenue
FROM Category cat
JOIN Products p
   ON cat.Category_Id = p.Category_Id
JOIN Order_Details od
   ON p.Product_Id = od.Product_Id
GROUP BY cat.Category_Id, cat.Category_Name
ORDER BY Revenue DESC;

-- 5. City wise Revenue
SELECT c.City, SUM(o.Total_Amount) AS Revenue
FROM Customers c
JOIN Orders o
   ON c.Customer_Id = o.Customer_Id
GROUP BY c.City
ORDER BY Revenue DESC;

-- 6. Monthly Revenue Trend
SELECT DATE_FORMAT(o.Order_Date, '%Y-%m') AS Month,
       SUM(o.Total_Amount) AS Revenue
FROM Orders o
GROUP BY DATE_FORMAT(o.Order_Date, '%Y-%m')
ORDER BY Month;

-- 7. Products with Low Stock (Low Stock = Less than 15 units)
SELECT Product_Id, Product_Name,Stock_Quantity
FROM Products
WHERE Stock_Quantity < 15
ORDER BY Stock_Quantity ASC;

-- 8. Products Never Sold
SELECT p.Product_Id, p.Product_Name
FROM Products p
WHERE NOT EXISTS(
 SELECT 1 FROM Order_Details od
 WHERE od.Product_Id = p.Product_Id);

-- 9. Payment Mode Analysis
SELECT Payment_Mode,
       COUNT(*) AS Total_Transactions,
       SUM(Payment_Amount) AS Total_Revenue,
       AVG(Payment_Amount) AS Average_Payment
FROM Payments
GROUP BY Payment_Mode
ORDER BY Total_Revenue DESC;

-- 10. Shipment Status Analysis
SELECT Shipment_Status,
       COUNT(*) AS Shipment_Count
FROM Shippings
GROUP BY Shipment_Status
ORDER BY Shipment_Count DESC;

