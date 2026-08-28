-- ============================================================
-- SQL Practice - Day 6 | Schema + Seed Data
-- CASE WHEN, COALESCE, NULLIF, CAST, string functions,
-- conditional aggregation
-- Compatible with SQLite. For MySQL/Postgres adjust as needed.
-- ============================================================

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY, tenure_years INTEGER, department TEXT, salary REAL
);

INSERT INTO employees (employee_id, tenure_years, department, salary) VALUES
(1, 6, 'Engineering', 95000),
(2, 2, 'Engineering', 60000),
(3, 8, 'Sales', 85000),
(4, 3, 'Sales', 45000),
(5, 5, 'Data', 78000),
(6, 1, 'Data', 52000),
(7, 10, 'Engineering', 120000),
(8, 4, 'HR', 48000),
(9, 7, 'Sales', 82000),
(10, 2, 'HR', 41000),
(11, 6, 'Data', 88000),
(12, 9, 'Engineering', 105000);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY, total_amount REAL, product_category TEXT, status TEXT
);

INSERT INTO orders (order_id, total_amount, product_category, status) VALUES
(1, 6200, 'Electronics', 'Delivered'),
(2, 1200, 'Apparel', 'Delivered'),
(3, 8900, 'Electronics', 'Cancelled'),
(4, 450, 'Groceries', 'Delivered'),
(5, 3200, 'Apparel', 'Cancelled'),
(6, 7600, 'Electronics', 'Delivered'),
(7, 900, 'Groceries', 'Delivered'),
(8, 5100, 'Apparel', 'Delivered'),
(9, 2200, 'Electronics', 'Cancelled'),
(10, 600, 'Groceries', 'Cancelled'),
(11, 9800, 'Electronics', 'Delivered'),
(12, 1500, 'Apparel', 'Delivered');

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY, balance REAL, branch_id INTEGER, account_type TEXT
);

INSERT INTO accounts (account_id, balance, branch_id, account_type) VALUES
(1, 150000, 101, 'Savings'),
(2, 45000, 101, 'Current'),
(3, 220000, 102, 'Savings'),
(4, 80000, 101, 'Savings'),
(5, 30000, 102, 'Current'),
(6, 95000, 102, 'Savings'),
(7, 175000, 103, 'Current'),
(8, 60000, 103, 'Savings'),
(9, 50000, 101, 'Current'),
(10, 300000, 103, 'Savings');

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
    flight_id INTEGER PRIMARY KEY, delay_minutes INTEGER
);

INSERT INTO flights (flight_id, delay_minutes) VALUES
(1, 0),
(2, 15),
(3, 0),
(4, 45),
(5, 0),
(6, 90),
(7, 10),
(8, 0);

DROP TABLE IF EXISTS students;
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY, marks REAL, city TEXT
);

INSERT INTO students (student_id, marks, city) VALUES
(1, 95, 'Delhi'),
(2, 82, ' delhi '),
(3, 68, 'DELHI'),
(4, 55, 'Mumbai'),
(5, 91, ' Mumbai'),
(6, 73, 'Pune'),
(7, 48, 'pune '),
(8, 88, 'Delhi '),
(9, 60, 'Bangalore'),
(10, 77, '  Bangalore  ');

DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY, primary_phone TEXT, alternate_phone TEXT, department TEXT, patient_status TEXT, computed_age INTEGER, manual_age_text TEXT
);

INSERT INTO patients (patient_id, primary_phone, alternate_phone, department, patient_status, computed_age, manual_age_text) VALUES
(1, '9001', '9002', 'Cardiology', 'Critical', 65, NULL),
(2, '9003', NULL, 'Cardiology', 'Stable', NULL, '42'),
(3, NULL, NULL, 'Neurology', 'Discharged', 8, NULL),
(4, '9004', '9005', 'Neurology', 'Critical', NULL, '70'),
(5, '9006', NULL, 'Orthopedics', 'Stable', 35, NULL),
(6, NULL, '9007', 'Orthopedics', 'Discharged', NULL, '15'),
(7, '9008', NULL, 'Cardiology', 'Stable', 55, NULL),
(8, '9009', '9010', 'Neurology', 'Critical', NULL, '62');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY, discount REAL, product_description TEXT
);

INSERT INTO products (product_id, discount, product_description) VALUES
(1, 10, 'Wireless mouse with ergonomic design'),
(2, NULL, 'Cotton shirt'),
(3, 5, 'A durable 5kg bag of premium basmati rice'),
(4, NULL, 'Speaker'),
(5, 15, 'Compact power bank, 10000mAh capacity'),
(6, NULL, 'Laptop stand'),
(7, 20, 'Running shoes'),
(8, NULL, 'A high quality bluetooth headset with noise cancellation');

DROP TABLE IF EXISTS subscribers;
CREATE TABLE subscribers (
    subscriber_id INTEGER PRIMARY KEY, signup_date TEXT, plan_type TEXT, status TEXT
);

INSERT INTO subscribers (subscriber_id, signup_date, plan_type, status) VALUES
(1, '2026-01-10', 'Postpaid', 'Active'),
(2, '2026-02-15', 'Prepaid', 'Cancelled'),
(3, '2026-03-01', 'Postpaid', 'Active'),
(4, '2026-01-20', 'Prepaid', 'Active'),
(5, '2026-04-05', 'Postpaid', 'Cancelled'),
(6, '2026-05-11', 'Prepaid', 'Active'),
(7, '2026-06-01', 'Postpaid', 'Active'),
(8, '2026-02-25', 'Prepaid', 'Cancelled'),
(9, '2026-03-18', 'Postpaid', 'Cancelled'),
(10, '2026-04-22', 'Prepaid', 'Active');

DROP TABLE IF EXISTS policies;
CREATE TABLE policies (
    policy_id INTEGER PRIMARY KEY, policy_number INTEGER
);

INSERT INTO policies (policy_id, policy_number) VALUES
(1, 100234),
(2, 100567),
(3, 100891),
(4, 101023),
(5, 101456);

DROP TABLE IF EXISTS subscriptions;
CREATE TABLE subscriptions (
    user_id INTEGER PRIMARY KEY, plan_name TEXT
);

INSERT INTO subscriptions (user_id, plan_name) VALUES
(1, 'premium'),
(2, 'Standard'),
(3, 'free'),
(4, 'PREMIUM'),
(5, 'standard');

DROP TABLE IF EXISTS drivers;
CREATE TABLE drivers (
    driver_id INTEGER PRIMARY KEY, driver_name TEXT
);

INSERT INTO drivers (driver_id, driver_name) VALUES
(1, '  Rakesh Yadav'),
(2, 'Imran Sheikh  '),
(3, 'Devendra Rao'),
(4, '  Ashok Kumar  '),
(5, 'Gopal Singh');

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT
);

INSERT INTO customers (customer_id, first_name, last_name) VALUES
(1, 'Amit', 'Sharma'),
(2, 'Priya', 'Nair'),
(3, 'Rohit', 'Verma'),
(4, 'Kiran', 'Rao'),
(5, 'Neelam', 'Iyer');

DROP TABLE IF EXISTS shipments;
CREATE TABLE shipments (
    shipment_id INTEGER PRIMARY KEY, tracking_id TEXT, customer_name TEXT
);

INSERT INTO shipments (shipment_id, tracking_id, customer_name) VALUES
(1, 'BLD1029384', 'John   Doe'),
(2, 'DTD2938475', 'Meena  Sharma'),
(3, 'FDX1122334', 'Farah Khan'),
(4, 'BLD5566778', 'Karan   Mehta'),
(5, 'DTD9988776', 'Divya Nair');

DROP TABLE IF EXISTS machines;
CREATE TABLE machines (
    machine_id INTEGER PRIMARY KEY, machine_code TEXT
);

INSERT INTO machines (machine_id, machine_code) VALUES
(1, 'MC-2024-001'),
(2, 'MC-2023-045'),
(3, 'MC-2025-012'),
(4, 'MC-2022-089'),
(5, 'MC-2024-067');

DROP TABLE IF EXISTS stores;
CREATE TABLE stores (
    store_id INTEGER PRIMARY KEY, total_sales REAL, total_transactions INTEGER, revenue REAL, cost REAL
);

INSERT INTO stores (store_id, total_sales, total_transactions, revenue, cost) VALUES
(101, 1200000, 4800, 1200000, 900000),
(102, 850000, 3200, 850000, 700000),
(103, 0, 0, 0, 50000),
(104, 600000, 2400, 600000, 720000),
(105, 950000, 3800, 950000, 600000);

DROP TABLE IF EXISTS routes;
CREATE TABLE routes (
    route TEXT PRIMARY KEY, on_time_flights INTEGER, total_flights INTEGER
);

INSERT INTO routes (route, on_time_flights, total_flights) VALUES
('DEL-BOM', 85, 100),
('DEL-MAA', 40, 90),
('BLR-DEL', 70, 75),
('MAA-DEL', 0, 0),
('CCU-BLR', 55, 80);

DROP TABLE IF EXISTS claims;
CREATE TABLE claims (
    claim_id INTEGER PRIMARY KEY, policy_id INTEGER, claim_amount REAL, agent_id INTEGER, is_fraud_suspected INTEGER, days_since_policy_start INTEGER, claim_type TEXT
);

INSERT INTO claims (claim_id, policy_id, claim_amount, agent_id, is_fraud_suspected, days_since_policy_start, claim_type) VALUES
(1, 1, 120000, 10, 0, 10, 'Theft'),
(2, 1, 45000, 10, 0, 200, 'Accident'),
(3, 2, 150000, 11, 1, 5, 'Fraudulent'),
(4, 2, 8000, 11, 0, 400, 'Accident'),
(5, 3, 60000, 12, 0, 15, 'Fire'),
(6, 3, 95000, 12, 0, 25, 'Theft'),
(7, 4, 30000, 10, 0, 300, 'Accident'),
(8, 4, 110000, 13, 0, 20, 'Fire'),
(9, 100, 36974, 20, 1, 158, 'Accident'),
(10, 101, 32171, 20, 1, 128, 'Accident'),
(11, 102, 29644, 20, 1, 125, 'Accident'),
(12, 103, 32279, 20, 1, 76, 'Theft'),
(13, 104, 54820, 20, 1, 119, 'Accident'),
(14, 105, 39310, 20, 0, 25, 'Fire'),
(15, 106, 28276, 20, 0, 17, 'Fire'),
(16, 107, 29614, 20, 0, 53, 'Fire'),
(17, 108, 49561, 20, 0, 233, 'Theft'),
(18, 109, 36823, 20, 0, 192, 'Theft'),
(19, 110, 51901, 20, 0, 291, 'Accident'),
(20, 111, 48152, 20, 0, 196, 'Fire'),
(21, 112, 40562, 20, 0, 70, 'Fire'),
(22, 113, 58972, 20, 0, 144, 'Accident'),
(23, 114, 49384, 20, 0, 293, 'Accident'),
(24, 115, 28837, 20, 0, 235, 'Accident'),
(25, 116, 49058, 20, 0, 284, 'Theft'),
(26, 117, 39222, 20, 0, 113, 'Theft'),
(27, 118, 54255, 20, 0, 192, 'Fire'),
(28, 119, 44321, 20, 0, 245, 'Fire'),
(29, 120, 59681, 20, 0, 153, 'Fire'),
(30, 121, 28570, 20, 0, 261, 'Accident'),
(31, 200, 35430, 21, 1, 299, 'Accident'),
(32, 201, 35445, 21, 1, 109, 'Accident'),
(33, 202, 44015, 21, 1, 77, 'Accident'),
(34, 203, 24802, 21, 1, 230, 'Accident'),
(35, 204, 50385, 21, 1, 209, 'Accident'),
(36, 205, 20142, 21, 1, 227, 'Accident'),
(37, 206, 22831, 21, 1, 125, 'Accident'),
(38, 207, 29289, 21, 1, 264, 'Accident');

DROP TABLE IF EXISTS orders_global;
CREATE TABLE orders_global (
    order_id INTEGER PRIMARY KEY, status TEXT, order_date TEXT
);

INSERT INTO orders_global (order_id, status, order_date) VALUES
(1, 'Normal', '2026-08-01'),
(2, 'Urgent', '2026-08-05'),
(3, 'Normal', '2026-08-02'),
(4, 'Urgent', '2026-08-03'),
(5, 'Normal', '2026-08-04'),
(6, 'Urgent', '2026-08-06');

DROP TABLE IF EXISTS trips;
CREATE TABLE trips (
    trip_id INTEGER PRIMARY KEY, distance_km REAL, fare REAL
);

INSERT INTO trips (trip_id, distance_km, fare) VALUES
(1, 3.2, 120),
(2, 12.5, 350),
(3, 25.0, 650),
(4, 4.8, 110),
(5, 18.0, 480),
(6, 30.5, 800),
(7, 2.1, 90),
(8, 15.0, 420),
(9, 45.0, 1100),
(10, 6.0, 200);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY, email TEXT
);

INSERT INTO users (user_id, email) VALUES
(1, 'amit@gmail.com'),
(2, 'AMIT@GMAIL.COM'),
(3, ' amit@gmail.com '),
(4, 'priya@yahoo.com'),
(5, 'rohit@gmail.com'),
(6, 'ROHIT@gmail.com ');

DROP TABLE IF EXISTS raw_amounts;
CREATE TABLE raw_amounts (
    id INTEGER PRIMARY KEY, amount_text TEXT
);

INSERT INTO raw_amounts (id, amount_text) VALUES
(1, '1500'),
(2, '2300.50'),
(3, 'N/A'),
(4, '980'),
(5, 'unknown');

DROP TABLE IF EXISTS orders_amazon;
CREATE TABLE orders_amazon (
    order_id INTEGER PRIMARY KEY, status TEXT
);

INSERT INTO orders_amazon (order_id, status) VALUES
(1, 'Delivered'),
(2, 'Delivered'),
(3, 'Delivered'),
(4, 'Delivered'),
(5, 'Delivered'),
(6, 'Delivered'),
(7, 'Delivered'),
(8, 'Delivered'),
(9, 'Delivered'),
(10, 'Delivered'),
(11, 'Delivered'),
(12, 'Delivered'),
(13, 'Delivered'),
(14, 'Delivered'),
(15, 'Delivered'),
(16, 'Delivered'),
(17, 'Delivered'),
(18, 'Delivered'),
(19, 'Delivered'),
(20, 'Delivered'),
(21, 'Delivered'),
(22, 'Delivered'),
(23, 'Delivered'),
(24, 'Delivered'),
(25, 'Delivered'),
(26, 'Delivered'),
(27, 'Delivered'),
(28, 'Delivered'),
(29, 'Delivered'),
(30, 'Delivered'),
(31, 'Delivered'),
(32, 'Delivered'),
(33, 'Delivered'),
(34, 'Delivered'),
(35, 'Delivered'),
(36, 'Delivered'),
(37, 'Delivered'),
(38, 'Delivered'),
(39, 'Delivered'),
(40, 'Delivered'),
(41, 'Delivered'),
(42, 'Delivered'),
(43, 'Delivered'),
(44, 'Delivered'),
(45, 'Delivered'),
(46, 'Delivered'),
(47, 'Delivered'),
(48, 'Delivered'),
(49, 'Delivered'),
(50, 'Delivered'),
(51, 'Delivered'),
(52, 'Delivered'),
(53, 'Delivered'),
(54, 'Delivered'),
(55, 'Delivered'),
(56, 'Delivered'),
(57, 'Delivered'),
(58, 'Delivered'),
(59, 'Delivered'),
(60, 'Delivered'),
(61, 'Delivered'),
(62, 'Delivered'),
(63, 'Delivered'),
(64, 'Delivered'),
(65, 'Delivered'),
(66, 'Delivered'),
(67, 'Delivered'),
(68, 'Delivered'),
(69, 'Delivered'),
(70, 'Delivered'),
(71, 'Delivered'),
(72, 'Delivered'),
(73, 'Cancelled'),
(74, 'Cancelled'),
(75, 'Cancelled'),
(76, 'Cancelled'),
(77, 'Cancelled'),
(78, 'Cancelled'),
(79, 'Cancelled'),
(80, 'Cancelled'),
(81, 'Cancelled'),
(82, 'Cancelled'),
(83, 'Cancelled'),
(84, 'Cancelled'),
(85, 'Cancelled'),
(86, 'Cancelled'),
(87, 'Cancelled'),
(88, 'Returned'),
(89, 'Returned'),
(90, 'Returned'),
(91, 'Returned'),
(92, 'Returned'),
(93, 'Returned'),
(94, 'Returned'),
(95, 'Returned'),
(96, 'Returned'),
(97, 'Pending'),
(98, 'Pending'),
(99, 'Pending'),
(100, 'Pending');

DROP TABLE IF EXISTS seller_orders;
CREATE TABLE seller_orders (
    order_id INTEGER PRIMARY KEY, seller_id INTEGER, rating INTEGER
);

INSERT INTO seller_orders (order_id, seller_id, rating) VALUES
(1, 1, 5),
(2, 1, 5),
(3, 1, 5),
(4, 1, 5),
(5, 1, 5),
(6, 1, 5),
(7, 1, 5),
(8, 1, 5),
(9, 1, 5),
(10, 1, 5),
(11, 1, 5),
(12, 1, 5),
(13, 1, 5),
(14, 1, 5),
(15, 1, 5),
(16, 1, 5),
(17, 1, 5),
(18, 1, 5),
(19, 1, 5),
(20, 1, 5),
(21, 1, 5),
(22, 1, 5),
(23, 1, 5),
(24, 1, 5),
(25, 1, 5),
(26, 1, 5),
(27, 1, 5),
(28, 1, 5),
(29, 1, 5),
(30, 1, 5),
(31, 1, 5),
(32, 1, 5),
(33, 1, 5),
(34, 1, 5),
(35, 1, 5),
(36, 1, 2),
(37, 1, 2),
(38, 1, 1),
(39, 1, 2),
(40, 1, 2),
(41, 1, 4),
(42, 1, 3),
(43, 1, 4),
(44, 1, 3),
(45, 1, 3),
(46, 1, 4),
(47, 1, 3),
(48, 1, 3),
(49, 1, 3),
(50, 1, 4),
(51, 2, 5),
(52, 2, 5),
(53, 2, 5),
(54, 2, 5),
(55, 2, 5),
(56, 2, 5),
(57, 2, 5),
(58, 2, 5),
(59, 2, 5),
(60, 2, 5),
(61, 2, 5),
(62, 2, 5),
(63, 2, 2),
(64, 2, 1),
(65, 2, 2),
(66, 2, 1),
(67, 2, 1),
(68, 2, 1),
(69, 2, 1),
(70, 2, 1),
(71, 2, 1),
(72, 2, 2),
(73, 2, 1),
(74, 2, 2),
(75, 2, 2),
(76, 2, 1),
(77, 2, 1),
(78, 2, 1),
(79, 2, 4),
(80, 2, 3),
(81, 2, 4),
(82, 2, 4),
(83, 2, 4),
(84, 2, 3),
(85, 2, 4),
(86, 2, 4),
(87, 2, 3),
(88, 2, 3),
(89, 2, 4),
(90, 2, 4),
(91, 3, 5),
(92, 3, 5),
(93, 3, 5),
(94, 3, 5),
(95, 3, 5),
(96, 3, 5),
(97, 3, 5),
(98, 3, 5),
(99, 3, 5),
(100, 3, 5),
(101, 3, 5),
(102, 3, 5),
(103, 3, 5),
(104, 3, 5),
(105, 3, 5),
(106, 3, 5),
(107, 3, 5),
(108, 3, 1),
(109, 3, 2),
(110, 3, 2),
(111, 3, 1),
(112, 3, 1),
(113, 3, 2),
(114, 3, 1),
(115, 3, 4),
(116, 3, 3),
(117, 3, 3),
(118, 3, 4),
(119, 3, 4),
(120, 3, 3),
(121, 3, 4),
(122, 3, 4),
(123, 3, 3),
(124, 3, 4),
(125, 3, 3);

DROP TABLE IF EXISTS monthly_retention;
CREATE TABLE monthly_retention (
    month TEXT PRIMARY KEY, renewed_subscriptions INTEGER, expiring_subscriptions INTEGER
);

INSERT INTO monthly_retention (month, renewed_subscriptions, expiring_subscriptions) VALUES
('2026-05', 420, 500),
('2026-06', 380, 450),
('2026-07', 0, 0),
('2026-08', 300, 600);

DROP TABLE IF EXISTS deposits;
CREATE TABLE deposits (
    branch_id INTEGER PRIMARY KEY, total_interest_paid REAL, total_deposits_text TEXT
);

INSERT INTO deposits (branch_id, total_interest_paid, total_deposits_text) VALUES
(101, 45000, '5000000'),
(102, 32000, '3800000'),
(103, 500, '0'),
(104, 28000, '2900000');

DROP TABLE IF EXISTS sellers_contact;
CREATE TABLE sellers_contact (
    seller_id INTEGER PRIMARY KEY, phone TEXT
);

INSERT INTO sellers_contact (seller_id, phone) VALUES
(1, '+91-9876543210'),
(2, '9876543211'),
(3, '091 9876543212'),
(4, '+91-9876543213'),
(5, '9876543214');

DROP TABLE IF EXISTS maintenance_logs;
CREATE TABLE maintenance_logs (
    log_id INTEGER PRIMARY KEY, machine_type TEXT, status TEXT
);

INSERT INTO maintenance_logs (log_id, machine_type, status) VALUES
(1, 'CNC Lathe', 'Failed'),
(2, 'CNC Lathe', 'Failed'),
(3, 'CNC Lathe', 'Failed'),
(4, 'CNC Lathe', 'Failed'),
(5, 'CNC Lathe', 'Failed'),
(6, 'CNC Lathe', 'Failed'),
(7, 'CNC Lathe', 'Failed'),
(8, 'CNC Lathe', 'Failed'),
(9, 'CNC Lathe', 'Failed'),
(10, 'CNC Lathe', 'Failed'),
(11, 'CNC Lathe', 'Passed'),
(12, 'CNC Lathe', 'Passed'),
(13, 'CNC Lathe', 'Passed'),
(14, 'CNC Lathe', 'Passed'),
(15, 'CNC Lathe', 'Passed'),
(16, 'CNC Lathe', 'Passed'),
(17, 'CNC Lathe', 'Passed'),
(18, 'CNC Lathe', 'Passed'),
(19, 'CNC Lathe', 'Passed'),
(20, 'CNC Lathe', 'Passed'),
(21, 'CNC Lathe', 'Passed'),
(22, 'CNC Lathe', 'Passed'),
(23, 'CNC Lathe', 'Passed'),
(24, 'CNC Lathe', 'Passed'),
(25, 'CNC Lathe', 'Passed'),
(26, 'CNC Lathe', 'Passed'),
(27, 'CNC Lathe', 'Passed'),
(28, 'CNC Lathe', 'Passed'),
(29, 'CNC Lathe', 'Passed'),
(30, 'CNC Lathe', 'Passed'),
(31, 'CNC Lathe', 'Passed'),
(32, 'CNC Lathe', 'Passed'),
(33, 'CNC Lathe', 'Passed'),
(34, 'CNC Lathe', 'Passed'),
(35, 'CNC Lathe', 'Passed'),
(36, 'CNC Lathe', 'Passed'),
(37, 'CNC Lathe', 'Passed'),
(38, 'CNC Lathe', 'Passed'),
(39, 'CNC Lathe', 'Passed'),
(40, 'CNC Lathe', 'Passed'),
(41, 'Press Machine', 'Failed'),
(42, 'Press Machine', 'Failed'),
(43, 'Press Machine', 'Failed'),
(44, 'Press Machine', 'Failed'),
(45, 'Press Machine', 'Passed'),
(46, 'Press Machine', 'Passed'),
(47, 'Press Machine', 'Passed'),
(48, 'Press Machine', 'Passed'),
(49, 'Welding Robot', 'Failed'),
(50, 'Welding Robot', 'Failed'),
(51, 'Welding Robot', 'Passed'),
(52, 'Welding Robot', 'Passed'),
(53, 'Welding Robot', 'Passed'),
(54, 'Welding Robot', 'Passed'),
(55, 'Welding Robot', 'Passed'),
(56, 'Welding Robot', 'Passed'),
(57, 'Welding Robot', 'Passed'),
(58, 'Welding Robot', 'Passed'),
(59, 'Welding Robot', 'Passed'),
(60, 'Welding Robot', 'Passed'),
(61, 'Welding Robot', 'Passed'),
(62, 'Welding Robot', 'Passed'),
(63, 'Welding Robot', 'Passed'),
(64, 'Welding Robot', 'Passed'),
(65, 'Welding Robot', 'Passed'),
(66, 'Welding Robot', 'Passed'),
(67, 'Welding Robot', 'Passed'),
(68, 'Welding Robot', 'Passed'),
(69, 'Welding Robot', 'Passed'),
(70, 'Welding Robot', 'Passed');

DROP TABLE IF EXISTS revenue_records;
CREATE TABLE revenue_records (
    record_id INTEGER PRIMARY KEY, region TEXT, subscriber_id INTEGER, revenue REAL
);

INSERT INTO revenue_records (record_id, region, subscriber_id, revenue) VALUES
(1, 'North', 1, 594),
(2, 'North', 2, 738),
(3, 'North', 3, 508),
(4, 'North', 4, 659),
(5, 'North', 5, 735),
(6, 'North', 6, 339),
(7, 'North', 7, 624),
(8, 'North', 8, 707),
(9, 'South', 1, 771),
(10, 'South', 2, 388),
(11, 'South', 3, 370),
(12, 'South', 4, 346),
(13, 'South', NULL, 1114),
(14, 'South', NULL, 504),
(15, 'South', NULL, 1169),
(16, 'South', NULL, 813),
(17, 'South', NULL, 694),
(18, 'South', NULL, 960),
(19, 'South', NULL, 992),
(20, 'South', NULL, 1067),
(21, 'South', NULL, 899),
(22, 'South', NULL, 840);
