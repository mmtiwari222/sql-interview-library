-- ============================================================
-- SQL Practice - Day 5 | Schema + Seed Data
-- NULL handling, BETWEEN/IN/LIKE, safe date ranges, NOT IN trap,
-- NOT EXISTS, LIKE ESCAPE
-- Compatible with SQLite. For MySQL/Postgres adjust as needed.
-- ============================================================

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY, manager_id INTEGER, phone_number TEXT, emergency_contact TEXT
);

INSERT INTO employees (employee_id, manager_id, phone_number, emergency_contact) VALUES
(1, NULL, '9990001001', '9990002001'),
(2, NULL, '9990001002', '9990002002'),
(3, 1, NULL, '9990002003'),
(4, 1, '9990001004', NULL),
(5, 2, '9990001005', '9990002005'),
(6, 2, '9990001006', '9990002006'),
(7, 3, NULL, '9990002007'),
(8, 3, '9990001008', NULL),
(9, 4, '9990001009', '9990002009'),
(10, 5, '9990001010', '9990002010'),
(11, 6, '9990001011', '9990002011'),
(12, 6, '9990001012', '9990002012');

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY, country TEXT
);

INSERT INTO customers (customer_id, country) VALUES
(1, 'India'),
(2, 'India'),
(3, 'USA'),
(4, 'India'),
(5, 'UK'),
(6, 'India'),
(7, 'USA'),
(8, 'India'),
(9, 'UAE'),
(10, 'India');

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date TEXT, shipped_date TEXT
);

INSERT INTO orders (order_id, customer_id, order_date, shipped_date) VALUES
(1, 1, '2026-06-01', '2026-06-05'),
(2, 1, '2026-06-20', NULL),
(3, 2, '2026-05-10', '2026-05-15'),
(4, 2, '2026-06-25', NULL),
(5, 3, '2026-05-01', NULL),
(6, 3, '2026-07-15', '2026-07-20'),
(7, 4, '2026-04-15', NULL),
(8, 5, '2026-06-10', '2026-06-12'),
(9, 6, '2026-06-18', NULL),
(10, 7, '2026-07-01', '2026-07-05'),
(11, 8, '2026-06-05', '2026-06-08'),
(12, NULL, '2026-06-11', '2026-06-14');

DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY, phone_number TEXT, insurance_provider TEXT
);

INSERT INTO patients (patient_id, phone_number, insurance_provider) VALUES
(1, '9991000001', 'Star Health'),
(2, NULL, 'HDFC Ergo'),
(3, '9991000003', 'ICICI Lombard'),
(4, '9991000004', 'star Union Insurance'),
(5, NULL, 'Bajaj Allianz'),
(6, '9991000006', 'STAR HEALTH ALLIED'),
(7, '9991000007', 'New India Assurance'),
(8, '9991000008', NULL),
(9, '9991000009', 'Care Health'),
(10, '9991000010', 'Star Comprehensive');

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY, nominee_name TEXT, pan_number TEXT, aadhaar_number TEXT
);

INSERT INTO accounts (account_id, nominee_name, pan_number, aadhaar_number) VALUES
(1, 'Ravi Kumar', 'ABCDE1234F', '123456789012'),
(2, NULL, 'BCDEF2345G', '223456789012'),
(3, 'Meena Sharma', NULL, '323456789012'),
(4, 'Anita Rao', 'DEFGH4567I', NULL),
(5, NULL, NULL, '523456789012'),
(6, 'Suresh Iyer', 'EFGHI5678J', '623456789012'),
(7, 'Farah Khan', 'FGHIJ6789K', '723456789012'),
(8, NULL, 'GHIJK7890L', '823456789012'),
(9, 'Karan Mehta', 'HIJKL8901M', '923456789012'),
(10, 'Divya Nair', 'IJKLM9012N', '023456789012');

DROP TABLE IF EXISTS nominees;
CREATE TABLE nominees (
    nominee_id INTEGER PRIMARY KEY, account_id INTEGER
);

INSERT INTO nominees (nominee_id, account_id) VALUES
(1, 1),
(2, 3),
(3, 4),
(4, 6),
(5, 7),
(6, NULL),
(7, 9);

DROP TABLE IF EXISTS subscribers;
CREATE TABLE subscribers (
    subscriber_id INTEGER PRIMARY KEY, alternate_number TEXT, email TEXT
);

INSERT INTO subscribers (subscriber_id, alternate_number, email) VALUES
(1, '8880001', 'ravi@gmail.com'),
(2, NULL, 'meena@yahoo.com'),
(3, '8880003', 'farah@gmail.com'),
(4, NULL, 'karan@outlook.com'),
(5, '8880005', 'divya@yahoo.com'),
(6, NULL, 'suresh@gmail.com'),
(7, '8880007', 'anita@yahoo.com'),
(8, NULL, 'vikram@gmail.com'),
(9, '8880009', 'neha@rediffmail.com'),
(10, NULL, 'sara@yahoo.com');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY, price REAL, sku TEXT
);

INSERT INTO products (product_id, price, sku) VALUES
(1, 250, 'AB1234'),
(2, 750, 'CD5678'),
(3, 50, 'EF9012'),
(4, 1200, 'GH3456'),
(5, 400, 'IJ7890'),
(6, 1800, 'ABCDE12'),
(7, 120, 'KL1122'),
(8, 900, 'MN33'),
(9, 600, 'OP4455'),
(10, 1500, 'QR6677'),
(11, 80, 'ST8899'),
(12, 350, 'UV0011');

DROP TABLE IF EXISTS returns;
CREATE TABLE returns (
    return_id INTEGER PRIMARY KEY, product_id INTEGER
);

INSERT INTO returns (return_id, product_id) VALUES
(1, 2),
(2, 4),
(3, NULL),
(4, 9);

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
    flight_id INTEGER PRIMARY KEY, origin TEXT
);

INSERT INTO flights (flight_id, origin) VALUES
(1, 'DEL'),
(2, 'BOM'),
(3, 'BLR'),
(4, 'MAA'),
(5, 'HYD'),
(6, 'DEL'),
(7, 'CCU'),
(8, 'BOM'),
(9, 'BLR'),
(10, 'PNQ');

DROP TABLE IF EXISTS students;
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY, grade TEXT, roll_number TEXT
);

INSERT INTO students (student_id, grade, roll_number) VALUES
(1, 'A', '1001'),
(2, 'B', '1002'),
(3, 'F', '1003'),
(4, 'C', '10045'),
(5, 'D', '2001'),
(6, 'A', '1004'),
(7, 'B', '2002'),
(8, 'F', '1005'),
(9, 'C', '10012'),
(10, 'A', '1006');

DROP TABLE IF EXISTS trips;
CREATE TABLE trips (
    trip_id INTEGER PRIMARY KEY, fare REAL, pickup_city TEXT
);

INSERT INTO trips (trip_id, fare, pickup_city) VALUES
(1, 150, 'Delhi'),
(2, 280, 'Gurugram'),
(3, 45, 'Noida'),
(4, 320, 'Mumbai'),
(5, 200, 'Delhi'),
(6, 90, 'Gurugram'),
(7, 260, 'Noida'),
(8, 110, 'Delhi'),
(9, 500, 'Mumbai'),
(10, 30, 'Gurugram'),
(11, 175, 'Noida'),
(12, 600, 'Delhi');

DROP TABLE IF EXISTS policies;
CREATE TABLE policies (
    policy_id INTEGER PRIMARY KEY, policy_type TEXT
);

INSERT INTO policies (policy_id, policy_type) VALUES
(1, 'Health'),
(2, 'Life'),
(3, 'Vehicle'),
(4, 'Property'),
(5, 'Health'),
(6, 'Life'),
(7, 'Vehicle'),
(8, 'Health');

DROP TABLE IF EXISTS restaurants;
CREATE TABLE restaurants (
    restaurant_id INTEGER PRIMARY KEY, name TEXT
);

INSERT INTO restaurants (restaurant_id, name) VALUES
(1, 'The Spice House'),
(2, 'Curry Point'),
(3, 'The Breakfast Table'),
(4, 'Bombay Bites'),
(5, 'The Garden Cafe'),
(6, 'Wada Pav Junction'),
(7, 'Thela Express'),
(8, 'The Coffee Bean'),
(9, 'Andhra Kitchen'),
(10, 'The Local Diner');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY, email TEXT, signup_date TEXT
);

INSERT INTO users (user_id, email, signup_date) VALUES
(1, 'amit@gmail.com', '2026-01-15'),
(2, 'priya@yahoo.com', '2026-02-10'),
(3, 'rohit@gmail.com', '2026-03-22'),
(4, 'kiran@outlook.com', '2026-04-05'),
(5, 'neelam@gmail.com', '2026-05-18'),
(6, 'sameer@gmail.com', '2026-01-30'),
(7, 'divya@yahoo.com', '2026-06-01'),
(8, 'arjun@gmail.com', '2026-03-01'),
(9, 'pooja@gmail.com', '2026-07-12'),
(10, 'manav@yahoo.com', '2026-02-28');

DROP TABLE IF EXISTS shipments;
CREATE TABLE shipments (
    shipment_id INTEGER PRIMARY KEY, tracking_id TEXT, dispatch_date TEXT
);

INSERT INTO shipments (shipment_id, tracking_id, dispatch_date) VALUES
(1, 'INDA', '2026-01-05 10:00:00'),
(2, 'INDB', '2026-01-31 22:15:00'),
(3, 'INDX', '2026-02-03 09:00:00'),
(4, 'IND', '2026-01-10 11:00:00'),
(5, 'INDIA1', '2026-01-20 14:00:00'),
(6, 'INDC', '2026-03-01 08:00:00'),
(7, 'INDD', '2026-01-15 16:00:00'),
(8, 'INDE', '2026-01-31 08:00:00');

DROP TABLE IF EXISTS sellers;
CREATE TABLE sellers (
    seller_id INTEGER PRIMARY KEY, store_name TEXT
);

INSERT INTO sellers (seller_id, store_name) VALUES
(1, 'MegaMart'),
(2, 'megabazaar Store'),
(3, 'Global Traders'),
(4, 'ABC Official Store'),
(5, 'XYZ_Official'),
(6, 'Mega_Deals'),
(7, 'Best Buy Official'),
(8, 'Local Traders'),
(9, 'MEGA Wholesale'),
(10, 'Quick Shop');

DROP TABLE IF EXISTS machines;
CREATE TABLE machines (
    machine_id INTEGER PRIMARY KEY, status TEXT, last_service_date TEXT, installation_date TEXT
);

INSERT INTO machines (machine_id, status, last_service_date, installation_date) VALUES
(1, 'Operational', '2026-06-01', '2023-05-10'),
(2, 'Faulty', '2026-05-15', '2022-01-01'),
(3, 'Under Repair', NULL, '2023-08-20'),
(4, 'Retired', '2024-01-01', '2019-03-15'),
(5, 'Scrapped', '2020-01-01', '2018-07-01'),
(6, 'Operational', NULL, '2025-01-10'),
(7, 'Under Maintenance', '2026-07-01', '2024-06-01'),
(8, 'Faulty', NULL, '2021-11-11'),
(9, 'Operational', '2026-04-10', '2023-02-02'),
(10, NULL, NULL, '2022-09-09');

DROP TABLE IF EXISTS bookings;
CREATE TABLE bookings (
    booking_id INTEGER PRIMARY KEY, seat_class TEXT, fare REAL, booking_time TEXT
);

INSERT INTO bookings (booking_id, seat_class, fare, booking_time) VALUES
(1, 'Business', 45000, '2026-08-05 10:00:00'),
(2, 'Economy', 6000, '2026-08-10 12:00:00'),
(3, 'First', 85000, '2026-08-15 09:30:00'),
(4, 'Business', 110000, '2026-08-20 14:00:00'),
(5, 'Economy', 7000, '2026-08-22 08:00:00'),
(6, 'First', 95000, '2026-08-31 23:45:00'),
(7, 'Business', 30000, '2026-08-01 07:00:00'),
(8, 'Economy', 5500, '2026-08-28 19:00:00');

DROP TABLE IF EXISTS claims;
CREATE TABLE claims (
    claim_id INTEGER PRIMARY KEY, claim_type TEXT, claim_timestamp TEXT
);

INSERT INTO claims (claim_id, claim_type, claim_timestamp) VALUES
(1, 'Theft', '2026-08-03 10:00:00'),
(2, 'Fraudulent', '2026-08-05 11:00:00'),
(3, 'Fire', '2026-08-10 09:00:00'),
(4, 'Rejected', '2026-08-12 15:00:00'),
(5, 'Accident', '2026-08-20 08:00:00'),
(6, 'Withdrawn', '2026-08-22 13:00:00'),
(7, 'Theft', '2026-08-31 23:58:12'),
(8, 'Fire', '2026-08-18 10:30:00');

DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (
    appointment_id INTEGER PRIMARY KEY, appointment_datetime TEXT
);

INSERT INTO appointments (appointment_id, appointment_datetime) VALUES
(1, '2026-08-01 09:00:00'),
(2, '2026-08-10 11:00:00'),
(3, '2026-08-15 16:00:00'),
(4, '2026-08-20 10:00:00'),
(5, '2026-08-31 20:30:00'),
(6, '2026-08-25 09:30:00'),
(7, '2026-09-02 09:00:00');

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY, txn_timestamp TEXT
);

INSERT INTO transactions (transaction_id, txn_timestamp) VALUES
(1, '2026-08-07 00:30:00'),
(2, '2026-08-07 03:30:00'),
(3, '2026-08-07 09:30:00'),
(4, '2026-08-07 14:30:00'),
(5, '2026-08-07 19:30:00'),
(6, '2026-08-07 23:30:00'),
(7, '2026-05-03 10:00:00'),
(8, '2026-05-10 10:00:00'),
(9, '2026-05-20 10:00:00'),
(10, '2026-06-02 10:00:00'),
(11, '2026-06-15 10:00:00'),
(12, '2026-06-28 10:00:00'),
(13, '2026-07-05 10:00:00'),
(14, '2026-07-12 10:00:00'),
(15, '2026-07-25 10:00:00'),
(16, '2026-08-01 10:00:00'),
(17, '2026-08-09 10:00:00'),
(18, '2026-08-18 10:00:00');

DROP TABLE IF EXISTS project_assignments;
CREATE TABLE project_assignments (
    assignment_id INTEGER PRIMARY KEY, employee_id INTEGER, is_active INTEGER
);

INSERT INTO project_assignments (assignment_id, employee_id, is_active) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 4, 1),
(4, 5, 0),
(5, 6, 1),
(6, NULL, 1),
(7, 9, 1),
(8, 10, 1);

DROP TABLE IF EXISTS telecom_plans;
CREATE TABLE telecom_plans (
    plan_id INTEGER PRIMARY KEY, plan_name TEXT
);

INSERT INTO telecom_plans (plan_id, plan_name) VALUES
(1, 'Basic 199'),
(2, 'Smart 399'),
(3, 'Family 599'),
(4, 'Unlimited 799'),
(5, 'Data Max 999'),
(6, 'Senior 149');

DROP TABLE IF EXISTS discontinued_plans;
CREATE TABLE discontinued_plans (
    id INTEGER PRIMARY KEY, plan_id INTEGER
);

INSERT INTO discontinued_plans (id, plan_id) VALUES
(1, 2),
(2, NULL),
(3, 5);

DROP TABLE IF EXISTS blocked_countries;
CREATE TABLE blocked_countries (
    id INTEGER PRIMARY KEY, country TEXT
);

INSERT INTO blocked_countries (id, country) VALUES
(1, 'North Korea'),
(2, 'Iran'),
(3, NULL);
