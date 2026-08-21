-- ============================================================
-- SQL Practice - Day 2 | Schema + Seed Data
-- Compatible with SQLite. For MySQL/Postgres, adjust AUTOINCREMENT
-- and boolean/INTEGER types as needed.
-- Run this file first to set up the database before attempting
-- questions.sql
-- ============================================================

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY, order_date TEXT, total_amount REAL, city TEXT, payment_method TEXT, order_status TEXT
);

INSERT INTO orders (order_id, order_date, total_amount, city, payment_method, order_status) VALUES
(1, '2026-01-05', 1200, 'Delhi', 'Credit Card', 'Delivered'),
(2, '2026-02-11', 800, 'Mumbai', 'UPI', 'Delivered'),
(3, '2026-02-20', 6200, 'Delhi', 'Credit Card', 'Delivered'),
(4, '2026-03-02', 450, 'Pune', 'COD', 'Cancelled'),
(5, '2026-03-15', 5300, 'Mumbai', 'UPI', 'Delivered'),
(6, '2026-04-01', 9800, 'Bangalore', 'Debit Card', 'Delivered'),
(7, '2026-04-10', 300, 'Delhi', 'COD', 'Cancelled'),
(8, '2026-05-02', 7600, 'Mumbai', 'Credit Card', 'Cancelled'),
(9, '2026-05-19', 1500, 'Chennai', 'UPI', 'Delivered'),
(10, '2026-06-01', 6000, 'Delhi', 'UPI', 'Delivered');

DROP TABLE IF EXISTS global_orders;
CREATE TABLE global_orders (
    order_id INTEGER PRIMARY KEY, customer_country TEXT, order_status TEXT, shipping_country TEXT, billing_country TEXT, customer_account_age_days INTEGER, total_amount REAL, payment_status TEXT
);

INSERT INTO global_orders (order_id, customer_country, order_status, shipping_country, billing_country, customer_account_age_days, total_amount, payment_status) VALUES
(1, 'India', 'Delivered', 'India', 'India', 400, 2000, 'Paid'),
(2, 'India', 'Delivered', 'India', 'USA', 3, 60000, 'Pending'),
(3, 'USA', 'Cancelled', 'USA', 'USA', 900, 15000, 'Paid'),
(4, 'India', 'Returned', 'India', 'India', 120, 3000, 'Paid'),
(5, 'India', 'Delivered', 'India', 'India', 10, 55000, 'Pending'),
(6, 'UK', 'Delivered', 'UK', 'UK', 250, 8000, 'Paid'),
(7, 'India', 'Delivered', 'China', 'India', 5, 90000, 'Pending'),
(8, 'India', 'Cancelled', 'India', 'India', 700, 4000, 'Paid');

DROP TABLE IF EXISTS subscribers;
CREATE TABLE subscribers (
    subscriber_id INTEGER PRIMARY KEY, plan_type TEXT
);

INSERT INTO subscribers (subscriber_id, plan_type) VALUES
(1, 'Premium'),
(2, 'Basic'),
(3, 'Premium'),
(4, 'Free'),
(5, 'Basic'),
(6, 'Premium');

DROP TABLE IF EXISTS subscriptions;
CREATE TABLE subscriptions (
    user_id INTEGER PRIMARY KEY, plan_name TEXT, signup_date TEXT, last_login_date TEXT, subscription_status TEXT
);

INSERT INTO subscriptions (user_id, plan_name, signup_date, last_login_date, subscription_status) VALUES
(1, 'Premium', '2023-02-10', NULL, 'Active'),
(2, 'Free', '2022-05-01', '2026-07-01', 'Active'),
(3, 'Standard', '2023-06-15', '2026-05-10', 'Active'),
(4, 'Premium', '2022-11-20', '2025-12-01', 'Cancelled'),
(5, 'Standard', '2023-09-01', NULL, 'Active'),
(6, 'Free', '2024-01-01', '2026-08-01', 'Active'),
(7, 'Premium', '2023-03-03', '2026-04-20', 'Active');

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY, first_name TEXT, department TEXT, salary REAL, hire_date TEXT, sales_target_achieved REAL, employment_status TEXT, tenure_years INTEGER, performance_rating REAL, is_on_pip INTEGER
);

INSERT INTO employees (employee_id, first_name, department, salary, hire_date, sales_target_achieved, employment_status, tenure_years, performance_rating, is_on_pip) VALUES
(1, 'Sara', 'Sales', 55000, '2022-05-10', 72, 'Active', 4, 4.5, 0),
(2, 'Sunil', 'Engineering', 95000, '2021-01-15', NULL, 'Active', 5, 4.8, 0),
(3, 'Rahim', 'Sales', 42000, '2023-03-20', 35, 'Active', 2, 3.2, 0),
(4, 'Priya', 'Data', 60000, '2022-08-01', NULL, 'Active', 3, 4.1, 0),
(5, 'Aisha', 'Marketing', 48000, '2023-11-11', NULL, 'Active', 1, 3.9, 0),
(6, 'Sameer', 'Sales', 75000, '2022-02-14', 48, 'Active', 4, 4.6, 1),
(7, 'Neha', 'Engineering', 110000, '2020-06-30', NULL, 'Active', 6, 4.9, 0),
(8, 'Suhana', 'Data', 68000, '2023-01-05', NULL, 'Active', 3, 4.2, 0),
(9, 'Vikram', 'Sales', 80000, '2021-09-09', 65, 'Resigned', 5, 4.0, 0),
(10, 'Sanya', 'HR', 39000, '2023-07-18', NULL, 'Active', 1, 3.5, 0);

DROP TABLE IF EXISTS restaurants;
CREATE TABLE restaurants (
    restaurant_id INTEGER PRIMARY KEY, restaurant_name TEXT, rating REAL, city TEXT, is_promoted INTEGER
);

INSERT INTO restaurants (restaurant_id, restaurant_name, rating, city, is_promoted) VALUES
(1, 'Spice Route', 4.5, 'Bangalore', 1),
(2, 'Curry Point', 3.8, 'Bangalore', 0),
(3, 'Pune Tadka', 4.2, 'Pune', 0),
(4, 'Deccan Diner', 3.5, 'Pune', 1),
(5, 'Andhra Bites', 4.7, 'Bangalore', 0),
(6, 'Wada Pav Co', 3.9, 'Pune', 0);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY, name TEXT, price REAL, category TEXT, stock_quantity INTEGER, is_discontinued INTEGER
);

INSERT INTO products (product_id, name, price, category, stock_quantity, is_discontinued) VALUES
(1, 'Wireless Mouse', 600, 'Electronics', 25, 0),
(2, 'Cotton T-Shirt', 450, 'Apparel', 5, 0),
(3, 'Smartphone Case', 700, 'Mobiles', 0, 0),
(4, 'Rice 5kg', 350, 'Groceries', 8, 0),
(5, 'Bluetooth Speaker', 1800, 'Electronics', 3, 0),
(6, 'Old Model TV', 12000, 'Electronics', 0, 1),
(7, 'Wheat Flour 10kg', 900, 'Groceries', 15, 0),
(8, 'Power Bank', 1500, 'Electronics', 6, 0);

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
    flight_id INTEGER PRIMARY KEY, origin TEXT, destination TEXT, delay_minutes INTEGER, flight_status TEXT
);

INSERT INTO flights (flight_id, origin, destination, delay_minutes, flight_status) VALUES
(1, 'DEL', 'BOM', 15, 'On Time'),
(2, 'BLR', 'DEL', 75, 'Delayed'),
(3, 'DEL', 'MAA', 90, 'Delayed'),
(4, 'BOM', 'CCU', 30, 'On Time'),
(5, 'MAA', 'DEL', 65, 'Cancelled'),
(6, 'DEL', 'HYD', 10, 'On Time'),
(7, 'CCU', 'BLR', 80, 'Delayed');

DROP TABLE IF EXISTS passengers;
CREATE TABLE passengers (
    passenger_id INTEGER PRIMARY KEY, name TEXT
);

INSERT INTO passengers (passenger_id, name) VALUES
(1, 'Kavita'),
(2, 'Raju'),
(3, 'Sam'),
(4, 'Lakshay'),
(5, 'Manoj'),
(6, 'Farah');

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY, account_type TEXT, balance REAL
);

INSERT INTO customers (customer_id, account_type, balance) VALUES
(1, 'Savings', 15000),
(2, 'Current', 8000),
(3, 'Savings', 5000),
(4, 'Savings', 22000),
(5, 'Current', 30000);

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY, amount REAL, transaction_type TEXT, country TEXT, is_flagged INTEGER
);

INSERT INTO transactions (transaction_id, amount, transaction_type, country, is_flagged) VALUES
(1, 12000, 'Transfer', 'India', 0),
(2, 150000, 'International', 'USA', 0),
(3, 5000, 'Refund', 'India', 0),
(4, 200000, 'International', 'India', 1),
(5, 300000, 'International', 'China', 0),
(6, 8000, 'Refund', 'India', 0),
(7, 110000, 'International', 'UK', 0);

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY, balance REAL, account_type TEXT, last_transaction_date TEXT, is_frozen INTEGER
);

INSERT INTO accounts (account_id, balance, account_type, last_transaction_date, is_frozen) VALUES
(1, 50, 'Savings', '2026-06-01', 0),
(2, 0, 'Current', '2026-05-11', 0),
(3, 90, 'Savings', NULL, 0),
(4, 200, 'Savings', '2026-07-01', 0),
(5, 30, 'Current', '2026-01-20', 1),
(6, 10, 'Savings', '2026-03-15', 0);

DROP TABLE IF EXISTS students;
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY, grade TEXT
);

INSERT INTO students (student_id, grade) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'A'),
(5, 'D'),
(6, 'B');

DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY, phone_number TEXT, age INTEGER, has_chronic_condition INTEGER, is_deceased INTEGER, last_checkup_date TEXT, is_active INTEGER
);

INSERT INTO patients (patient_id, phone_number, age, has_chronic_condition, is_deceased, last_checkup_date, is_active) VALUES
(1, '9990001', 65, 1, 0, '2023-11-01', 1),
(2, NULL, 45, 0, 0, '2025-02-10', 1),
(3, '9990003', 70, 0, 1, '2020-01-01', 0),
(4, NULL, 55, 1, 0, NULL, 1),
(5, '9990005', 30, 0, 0, '2026-01-15', 1),
(6, '9990006', 62, 0, 0, '2023-05-01', 1);

DROP TABLE IF EXISTS trips;
CREATE TABLE trips (
    trip_id INTEGER PRIMARY KEY, fare REAL, trip_type TEXT
);

INSERT INTO trips (trip_id, fare, trip_type) VALUES
(1, 650, 'City'),
(2, 320, 'Airport'),
(3, 180, 'City'),
(4, 550, 'Airport'),
(5, 210, 'City'),
(6, 700, 'Airport');

DROP TABLE IF EXISTS drivers;
CREATE TABLE drivers (
    driver_id INTEGER PRIMARY KEY, rating REAL, total_trips INTEGER, complaints_count INTEGER, cancellation_rate REAL
);

INSERT INTO drivers (driver_id, rating, total_trips, complaints_count, cancellation_rate) VALUES
(1, 3.2, 45, 7, 0.4),
(2, 4.5, 60, 1, 0.1),
(3, 3.0, 25, 6, 0.35),
(4, 3.4, 10, 8, 0.5),
(5, 4.8, 90, 0, 0.05);

DROP TABLE IF EXISTS shipments;
CREATE TABLE shipments (
    shipment_id INTEGER PRIMARY KEY, status TEXT, origin_city TEXT, expected_delivery_date TEXT, priority TEXT, customer_tier TEXT
);

INSERT INTO shipments (shipment_id, status, origin_city, expected_delivery_date, priority, customer_tier) VALUES
(1, 'Delivered', 'Chennai', '2026-08-01', 'High', 'Premium'),
(2, 'In Transit', 'Chennai', '2026-08-05', 'Low', 'Regular'),
(3, 'Pending', 'Mumbai', '2026-08-03', 'High', 'Regular'),
(4, 'Pending', 'Chennai', '2026-08-20', 'Low', 'Regular'),
(5, 'In Transit', 'Delhi', '2026-08-08', 'High', 'Premium'),
(6, 'Delivered', 'Chennai', '2026-08-02', 'Low', 'Regular'),
(7, 'Pending', 'Pune', '2026-07-30', 'High', 'Premium');

DROP TABLE IF EXISTS policies;
CREATE TABLE policies (
    policy_id INTEGER PRIMARY KEY, premium REAL
);

INSERT INTO policies (policy_id, premium) VALUES
(1, 3000),
(2, 4800),
(3, 6000),
(4, 2500),
(5, 5100);

DROP TABLE IF EXISTS claims;
CREATE TABLE claims (
    claim_id INTEGER PRIMARY KEY, claim_amount REAL, status TEXT, claim_type TEXT, days_since_policy_start INTEGER
);

INSERT INTO claims (claim_id, claim_amount, status, claim_type, days_since_policy_start) VALUES
(1, 120000, 'Approved', 'Theft', 10),
(2, 8000, 'Rejected', 'Accident', 200),
(3, 150000, 'Pending', 'Fire', 5),
(4, 45000, 'Approved', 'Accident', 400),
(5, 110000, 'Pending', 'Theft', 60),
(6, 30000, 'Rejected', 'Fire', 15);

DROP TABLE IF EXISTS telecom_subscribers;
CREATE TABLE telecom_subscribers (
    subscriber_id INTEGER PRIMARY KEY, plan_expiry TEXT, plan_type TEXT, outstanding_balance REAL, status TEXT, plan_expiry_date TEXT, complaints_count INTEGER, avg_usage_minutes REAL
);

INSERT INTO telecom_subscribers (subscriber_id, plan_expiry, plan_type, outstanding_balance, status, plan_expiry_date, complaints_count, avg_usage_minutes) VALUES
(1, 'Active', 'Postpaid', 500, 'Active', '2026-08-15', 3, 40),
(2, 'Expired', 'Prepaid', 0, 'Suspended', '2026-05-01', 0, 80),
(3, 'Active', 'Postpaid', 0, 'Active', '2026-10-01', 0, 120),
(4, 'Active', 'Postpaid', 1200, 'Active', '2026-08-20', 5, 20),
(5, 'Expired', 'Postpaid', 300, 'Active', '2026-06-01', 1, 45),
(6, 'Active', 'Prepaid', 0, 'Active', '2026-12-01', 0, 200);

DROP TABLE IF EXISTS machines;
CREATE TABLE machines (
    machine_id INTEGER PRIMARY KEY, last_maintenance_date TEXT, status TEXT, operating_hours INTEGER
);

INSERT INTO machines (machine_id, last_maintenance_date, status, operating_hours) VALUES
(1, '2026-06-01', 'Running', 3000),
(2, NULL, 'Running', 1200),
(3, '2025-01-01', 'Faulty', 7000),
(4, '2026-07-01', 'Running', 6200),
(5, '2026-08-10', 'Under Repair', 5500),
(6, NULL, 'Faulty', 900);

