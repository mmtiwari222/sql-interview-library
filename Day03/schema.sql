-- ============================================================
-- SQL Practice - Day 3 | Schema + Seed Data
-- Sorting (ORDER BY), DISTINCT, LIMIT/OFFSET, Aliasing, Pagination
-- Compatible with SQLite. For MySQL/Postgres adjust as needed.
-- ============================================================

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY, order_date TEXT, total_amount REAL, order_status TEXT
);

INSERT INTO orders (order_id, order_date, total_amount, order_status) VALUES
(1, '2026-01-05', 1200, 'Delivered'),
(2, '2026-01-05', 3400, 'Delivered'),
(3, '2026-02-11', 800, 'Pending'),
(4, '2026-02-20', 6200, 'Delivered'),
(5, '2026-03-02', 450, 'Cancelled'),
(6, '2026-03-15', 6200, 'Delivered'),
(7, '2026-04-01', 9800, 'Delivered'),
(8, '2026-04-10', 300, 'Cancelled'),
(9, '2026-05-02', 7600, 'Delivered'),
(10, '2026-05-19', 1500, 'Pending'),
(11, '2026-06-01', 6000, 'Delivered'),
(12, '2026-06-01', 9800, 'Delivered');

DROP TABLE IF EXISTS subscribers;
CREATE TABLE subscribers (
    subscriber_id INTEGER PRIMARY KEY, signup_date TEXT, plan_type TEXT, region TEXT, outstanding_balance REAL
);

INSERT INTO subscribers (subscriber_id, signup_date, plan_type, region, outstanding_balance) VALUES
(1, '2026-01-10', 'Postpaid', 'North', 500),
(2, '2026-02-15', 'Prepaid', 'South', 0),
(3, '2026-03-01', 'Postpaid', 'South', 1200),
(4, '2026-01-20', 'Prepaid', 'North', 0),
(5, '2026-04-05', 'Postpaid', 'North', 300),
(6, '2026-05-11', 'Prepaid', 'South', 150),
(7, '2026-06-01', 'Postpaid', 'East', 900);

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY, first_name TEXT, salary REAL, department TEXT
);

INSERT INTO employees (employee_id, first_name, salary, department) VALUES
(1, 'Sara', 55000, 'Sales'),
(2, 'Sunil', 95000, 'Engineering'),
(3, 'Rahim', 42000, 'Sales'),
(4, 'Priya', 95000, 'Data'),
(5, 'Aisha', 48000, 'Marketing'),
(6, 'Sameer', 75000, 'Sales'),
(7, 'Neha', 110000, 'Engineering'),
(8, 'Suhana', 42000, 'Data'),
(9, 'Vikram', 80000, 'Sales'),
(10, 'Sanya', 39000, 'HR');

DROP TABLE IF EXISTS restaurants;
CREATE TABLE restaurants (
    restaurant_id INTEGER PRIMARY KEY, restaurant_name TEXT, city TEXT, rating REAL
);

INSERT INTO restaurants (restaurant_id, restaurant_name, city, rating) VALUES
(1, 'Spice Route', 'Bangalore', 4.5),
(2, 'Curry Point', 'Bangalore', 3.8),
(3, 'Mumbai Tadka', 'Mumbai', 4.2),
(4, 'Sea Breeze', 'Mumbai', 4.7),
(5, 'Vada Pav Junction', 'Mumbai', 3.9),
(6, 'Bombay Bites', 'Mumbai', 4.4),
(7, 'Marine Drive Cafe', 'Mumbai', 4.6),
(8, 'Andhra Bites', 'Bangalore', 4.7),
(9, 'Colaba Kitchen', 'Mumbai', 3.5);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY, name TEXT, price REAL, category TEXT, brand TEXT
);

INSERT INTO products (product_id, name, price, category, brand) VALUES
(1, 'Wireless Mouse', 600, 'Electronics', 'Logitech'),
(2, 'Cotton T-Shirt', 450, 'Apparel', 'H&M'),
(3, 'Smartphone Case', 700, 'Mobiles', 'Spigen'),
(4, 'Rice 5kg', 350, 'Groceries', 'India Gate'),
(5, 'Bluetooth Speaker', 1800, 'Electronics', 'JBL'),
(6, 'Old Model TV', 12000, 'Electronics', 'Sony'),
(7, 'Wheat Flour 10kg', 900, 'Groceries', 'Aashirvaad'),
(8, 'Power Bank', 1500, 'Electronics', 'Mi'),
(9, 'Gaming Mouse', NULL, 'Electronics', 'Logitech'),
(10, 'Formal Shirt', 1200, 'Apparel', 'Van Heusen'),
(11, 'Laptop Stand', 2200, 'Electronics', 'Mi'),
(12, 'Running Shoes', 3500, 'Apparel', 'Nike');

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
    flight_id INTEGER PRIMARY KEY, flight_code TEXT, origin TEXT, destination TEXT, delay_minutes INTEGER
);

INSERT INTO flights (flight_id, flight_code, origin, destination, delay_minutes) VALUES
(1, 'AI101', 'DEL', 'BOM', 15),
(2, 'AI102', 'BLR', 'DEL', 75),
(3, '6E201', 'DEL', 'MAA', 90),
(4, '6E202', 'BOM', 'CCU', 30),
(5, 'SG301', 'MAA', 'DEL', 65),
(6, 'AI103', 'DEL', 'HYD', 10),
(7, '6E203', 'CCU', 'BLR', 80),
(8, 'AI104', 'DEL', 'BOM', 45),
(9, 'SG302', 'DEL', 'BOM', 20),
(10, '6E204', 'BLR', 'DEL', 55),
(11, 'AI105', 'MAA', 'DEL', 95),
(12, 'SG303', 'DEL', 'MAA', 35);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY, name TEXT, account_balance REAL
);

INSERT INTO customers (customer_id, name, account_balance) VALUES
(1, 'Amit', 95000),
(2, 'Neelam', 88000),
(3, 'Rohit', 102000),
(4, 'Kiran', 76000),
(5, 'Farah', 64000),
(6, 'Sameer', 58000),
(7, 'Divya', 142000),
(8, 'Arjun', 39000),
(9, 'Pooja', 110000),
(10, 'Manav', 71000),
(11, 'Isha', 125000),
(12, 'Ravi', 49000),
(13, 'Tanvi', 67000),
(14, 'Karan', 84000),
(15, 'Meera', 133000),
(16, 'Yash', 52000),
(17, 'Simran', 99000),
(18, 'Anil', 44000),
(19, 'Nisha', 116000),
(20, 'Deepak', 60000);

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY, customer_id INTEGER, transaction_amount REAL
);

INSERT INTO transactions (transaction_id, customer_id, transaction_amount) VALUES
(1, 1, 15154),
(2, 1, 16114),
(3, 1, 17525),
(4, 2, 20259),
(5, 2, 21281),
(6, 3, 7750),
(7, 3, 9228),
(8, 3, 10642),
(9, 3, 12754),
(10, 4, 59604),
(11, 5, 12192),
(12, 5, 13758),
(13, 5, 15413),
(14, 6, 25058),
(15, 6, 26089),
(16, 7, 9104),
(17, 7, 10432),
(18, 7, 11532),
(19, 7, 13030),
(20, 7, 14595),
(21, 8, 29723),
(22, 8, 31238);

DROP TABLE IF EXISTS students;
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY, student_name TEXT
);

INSERT INTO students (student_id, student_name) VALUES
(1, 'Zoya'),
(2, 'Aman'),
(3, 'Nikhil'),
(4, 'Bhavna'),
(5, 'Ishaan'),
(6, 'Charu'),
(7, 'Om'),
(8, 'Diya');

DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY, patient_name TEXT, registration_date TEXT
);

INSERT INTO patients (patient_id, patient_name, registration_date) VALUES
(1, 'Meena P1', '2025-01-04'),
(2, 'Sunil P2', '2025-01-07'),
(3, 'Anita P3', '2025-01-10'),
(4, 'Farhan P4', '2025-01-13'),
(5, 'Priya P5', '2025-01-16'),
(6, 'Karan P6', '2025-01-19'),
(7, 'Neha P7', '2025-01-22'),
(8, 'Suresh P8', '2025-01-25'),
(9, 'Lata P9', '2025-01-28'),
(10, 'Ravi P10', '2025-01-31'),
(11, 'Meena P11', '2025-02-03'),
(12, 'Sunil P12', '2025-02-06'),
(13, 'Anita P13', '2025-02-09'),
(14, 'Farhan P14', '2025-02-12'),
(15, 'Priya P15', '2025-02-15'),
(16, 'Karan P16', '2025-02-18'),
(17, 'Neha P17', '2025-02-21'),
(18, 'Suresh P18', '2025-02-24'),
(19, 'Lata P19', '2025-02-27'),
(20, 'Ravi P20', '2025-03-02'),
(21, 'Meena P21', '2025-03-05'),
(22, 'Sunil P22', '2025-03-08'),
(23, 'Anita P23', '2025-03-11'),
(24, 'Farhan P24', '2025-03-14'),
(25, 'Priya P25', '2025-03-17'),
(26, 'Karan P26', '2025-03-20'),
(27, 'Neha P27', '2025-03-23'),
(28, 'Suresh P28', '2025-03-26'),
(29, 'Lata P29', '2025-03-29'),
(30, 'Ravi P30', '2025-04-01'),
(31, 'Meena P31', '2025-04-04'),
(32, 'Sunil P32', '2025-04-07'),
(33, 'Anita P33', '2025-04-10'),
(34, 'Farhan P34', '2025-04-13'),
(35, 'Priya P35', '2025-04-16'),
(36, 'Karan P36', '2025-04-19'),
(37, 'Neha P37', '2025-04-22'),
(38, 'Suresh P38', '2025-04-25'),
(39, 'Lata P39', '2025-04-28'),
(40, 'Ravi P40', '2025-05-01'),
(41, 'Meena P41', '2025-05-04'),
(42, 'Sunil P42', '2025-05-07'),
(43, 'Anita P43', '2025-05-10'),
(44, 'Farhan P44', '2025-05-13'),
(45, 'Priya P45', '2025-05-16'),
(46, 'Karan P46', '2025-05-19'),
(47, 'Neha P47', '2025-05-22'),
(48, 'Suresh P48', '2025-05-25'),
(49, 'Lata P49', '2025-05-28'),
(50, 'Ravi P50', '2025-05-31'),
(51, 'Meena P51', '2025-06-03'),
(52, 'Sunil P52', '2025-06-06'),
(53, 'Anita P53', '2025-06-09'),
(54, 'Farhan P54', '2025-06-12'),
(55, 'Priya P55', '2025-06-15'),
(56, 'Karan P56', '2025-06-18'),
(57, 'Neha P57', '2025-06-21'),
(58, 'Suresh P58', '2025-06-24'),
(59, 'Lata P59', '2025-06-27'),
(60, 'Ravi P60', '2025-06-30'),
(61, 'Meena P61', '2025-07-03'),
(62, 'Sunil P62', '2025-07-06'),
(63, 'Anita P63', '2025-07-09'),
(64, 'Farhan P64', '2025-07-12'),
(65, 'Priya P65', '2025-07-15'),
(66, 'Karan P66', '2025-07-18'),
(67, 'Neha P67', '2025-07-21'),
(68, 'Suresh P68', '2025-07-24'),
(69, 'Lata P69', '2025-07-27'),
(70, 'Ravi P70', '2025-07-30'),
(71, 'Meena P71', '2025-08-02'),
(72, 'Sunil P72', '2025-08-05'),
(73, 'Anita P73', '2025-08-08'),
(74, 'Farhan P74', '2025-08-11'),
(75, 'Priya P75', '2025-08-14');

DROP TABLE IF EXISTS trips;
CREATE TABLE trips (
    trip_id INTEGER PRIMARY KEY, city TEXT, driver_id INTEGER
);

INSERT INTO trips (trip_id, city, driver_id) VALUES
(1, 'Delhi', 1),
(2, 'Mumbai', 2),
(3, 'Delhi', 3),
(4, 'Bangalore', 1),
(5, 'Mumbai', 4),
(6, 'Delhi', 5),
(7, 'Bangalore', 2),
(8, 'Pune', 3),
(9, 'Mumbai', 1),
(10, 'Pune', 4);

DROP TABLE IF EXISTS drivers;
CREATE TABLE drivers (
    driver_id INTEGER PRIMARY KEY, driver_name TEXT, total_trips INTEGER
);

INSERT INTO drivers (driver_id, driver_name, total_trips) VALUES
(1, 'Rakesh', 210),
(2, 'Imran', 185),
(3, 'Devendra', 260),
(4, 'Ashok', 95),
(5, 'Gopal', 240),
(6, 'Salman', 150),
(7, 'Vinod', 300);

DROP TABLE IF EXISTS shipments;
CREATE TABLE shipments (
    shipment_id INTEGER PRIMARY KEY, order_date TEXT, delivery_date TEXT, expected_delivery_date TEXT
);

INSERT INTO shipments (shipment_id, order_date, delivery_date, expected_delivery_date) VALUES
(1, '2026-06-01', '2026-06-02', '2026-06-06'),
(2, '2026-06-02', '2026-06-04', '2026-06-07'),
(3, '2026-06-03', '2026-06-06', '2026-06-08'),
(4, '2026-06-04', '2026-06-08', '2026-06-09'),
(5, '2026-06-05', '2026-06-10', '2026-06-10'),
(6, '2026-06-06', '2026-06-12', '2026-06-11'),
(7, '2026-06-07', '2026-06-14', '2026-06-12'),
(8, '2026-06-08', '2026-06-16', '2026-06-13'),
(9, '2026-06-09', '2026-06-18', '2026-06-14'),
(10, '2026-06-10', '2026-06-11', '2026-06-15'),
(11, '2026-06-11', '2026-06-13', '2026-06-16'),
(12, '2026-06-12', '2026-06-15', '2026-06-17'),
(13, '2026-06-13', '2026-06-17', '2026-06-18'),
(14, '2026-06-14', '2026-06-19', '2026-06-19'),
(15, '2026-06-15', '2026-06-21', '2026-06-20'),
(16, '2026-06-16', '2026-06-23', '2026-06-21'),
(17, '2026-06-17', '2026-06-25', '2026-06-22'),
(18, '2026-06-18', '2026-06-27', '2026-06-23'),
(19, '2026-06-19', '2026-06-20', '2026-06-24'),
(20, '2026-06-20', '2026-06-22', '2026-06-25'),
(21, '2026-06-21', '2026-06-24', '2026-06-26'),
(22, '2026-06-22', '2026-06-26', '2026-06-27'),
(23, '2026-06-23', '2026-06-28', '2026-06-28'),
(24, '2026-06-24', '2026-06-30', '2026-06-29'),
(25, '2026-06-25', '2026-07-02', '2026-06-30'),
(26, '2026-06-26', '2026-07-04', '2026-07-01'),
(27, '2026-06-27', '2026-07-06', '2026-07-02'),
(28, '2026-06-28', '2026-06-29', '2026-07-03'),
(29, '2026-06-29', '2026-07-01', '2026-07-04'),
(30, '2026-06-30', '2026-07-03', '2026-07-05'),
(31, '2026-07-01', '2026-07-05', '2026-07-06'),
(32, '2026-07-02', '2026-07-07', '2026-07-07'),
(33, '2026-07-03', '2026-07-09', '2026-07-08'),
(34, '2026-07-04', '2026-07-11', '2026-07-09'),
(35, '2026-07-05', '2026-07-13', '2026-07-10');

DROP TABLE IF EXISTS claims;
CREATE TABLE claims (
    claim_id INTEGER PRIMARY KEY, claim_type TEXT, claim_amount REAL
);

INSERT INTO claims (claim_id, claim_type, claim_amount) VALUES
(1, 'Theft', 120000),
(2, 'Accident', 8000),
(3, 'Fire', 150000),
(4, 'Accident', 45000),
(5, 'Theft', 95000),
(6, 'Fire', 95000),
(7, 'Accident', 30000),
(8, 'Theft', 60000);

DROP TABLE IF EXISTS subscriptions;
CREATE TABLE subscriptions (
    user_id INTEGER PRIMARY KEY, plan_name TEXT, last_login_date TEXT
);

INSERT INTO subscriptions (user_id, plan_name, last_login_date) VALUES
(1, 'Premium', '2026-08-20'),
(2, 'Free', '2026-07-01'),
(3, 'Standard', '2026-08-18'),
(4, 'Premium', '2026-08-15'),
(5, 'Standard', '2026-08-10'),
(6, 'Free', '2026-08-01'),
(7, 'Premium', '2026-08-19'),
(8, 'Standard', '2026-07-25');

DROP TABLE IF EXISTS doctors;
CREATE TABLE doctors (
    doctor_id INTEGER PRIMARY KEY, department TEXT, experience_years INTEGER
);

INSERT INTO doctors (doctor_id, department, experience_years) VALUES
(1, 'Cardiology', 12),
(2, 'Cardiology', 6),
(3, 'Neurology', 9),
(4, 'Neurology', 15),
(5, 'Orthopedics', 3),
(6, 'Orthopedics', 20),
(7, 'Cardiology', 18);

DROP TABLE IF EXISTS store_sales;
CREATE TABLE store_sales (
    sale_id INTEGER PRIMARY KEY, store_id INTEGER, product_id INTEGER, is_stockout INTEGER
);

INSERT INTO store_sales (sale_id, store_id, product_id, is_stockout) VALUES
(1, 101, 1, 0),
(2, 101, 2, 1),
(3, 102, 1, 0),
(4, 102, 3, 0),
(5, 103, 2, 0),
(6, 103, 3, 1),
(7, 104, 1, 0),
(8, 101, 3, 0),
(9, 104, 2, 0);

DROP TABLE IF EXISTS machines;
CREATE TABLE machines (
    machine_id INTEGER PRIMARY KEY, machine_type TEXT, last_maintenance_date TEXT
);

INSERT INTO machines (machine_id, machine_type, last_maintenance_date) VALUES
(1, 'CNC Lathe', '2026-06-01'),
(2, 'Press Machine', NULL),
(3, 'CNC Lathe', '2025-01-01'),
(4, 'Conveyor', NULL),
(5, 'Press Machine', '2026-07-10'),
(6, 'Welding Robot', '2026-05-15');

DROP TABLE IF EXISTS maintenance_log;
CREATE TABLE maintenance_log (
    log_id INTEGER PRIMARY KEY, machine_id INTEGER
);

INSERT INTO maintenance_log (log_id, machine_id) VALUES
(1, 1),
(2, 3),
(3, 5),
(4, 1),
(5, 6);
