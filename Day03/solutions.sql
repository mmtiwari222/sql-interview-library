-- ============================================================
-- SQL Practice - Day 3 : ANSWER KEY
-- Matches questions.sql 1:1. Try questions.sql yourself first!
-- Explanations included wherever the logic is tricky: DISTINCT +
-- ties, NULL sort order across engines, pagination math, and the
-- SQL logical execution order (WHERE vs HAVING).
-- ============================================================


-- ################################################################
-- EASY QUESTIONS
-- ################################################################

-- Q1 [EASY] [Amazon-style]
-- List all orders sorted by order_date in ascending order.
SELECT * FROM orders ORDER BY order_date ASC;


-- Q2 [EASY] [Netflix-style]
-- List all subscribers sorted by signup_date descending (most recent first).
SELECT * FROM subscribers ORDER BY signup_date DESC;


-- Q3 [EASY] [HR System]
-- List employees sorted by salary descending, then by name ascending for ties.
SELECT * FROM employees ORDER BY salary DESC, first_name ASC;


-- Q4 [EASY] [Zomato-style]
-- Get the distinct list of city values from the restaurants table.
SELECT DISTINCT city FROM restaurants;


-- Q5 [EASY] [E-commerce]
-- Get the top 5 most expensive products using ORDER BY + LIMIT.
SELECT * FROM products ORDER BY price DESC LIMIT 5;


-- Q6 [EASY] [Airline-style]
-- List all distinct origin airports from the flights table.
SELECT DISTINCT origin FROM flights;


-- Q7 [EASY] [Bank-style]
-- List the top 10 customers by account_balance descending.
SELECT * FROM customers ORDER BY account_balance DESC LIMIT 10;


-- Q8 [EASY] [School System]
-- List students sorted alphabetically by student_name.
SELECT * FROM students ORDER BY student_name ASC;


-- Q9 [EASY] [Telecom]
-- Get distinct plan_type values from the subscribers table.
SELECT DISTINCT plan_type FROM subscribers;


-- Q10 [EASY] [Retail Chain]
-- Select first_name AS employee_name, salary AS monthly_salary from employees.
SELECT first_name AS employee_name, salary AS monthly_salary FROM employees;


-- Q11 [EASY] [Healthcare]
-- List the 3 most recently registered patients using ORDER BY registration_date DESC LIMIT 3.
SELECT * FROM patients ORDER BY registration_date DESC LIMIT 3;


-- Q12 [EASY] [Uber-style]
-- List distinct city values where trips have occurred.
SELECT DISTINCT city FROM trips;


-- Q13 [EASY] [Logistics]
-- List shipments sorted by expected_delivery_date ascending.
SELECT * FROM shipments ORDER BY expected_delivery_date ASC;


-- Q14 [EASY] [Insurance]
-- Get the top 5 highest claim_amount records.
SELECT * FROM claims ORDER BY claim_amount DESC LIMIT 5;


-- Q15 [EASY] [Streaming Service]
-- List distinct plan_name values from subscriptions.
SELECT DISTINCT plan_name FROM subscriptions;


-- ################################################################
-- MEDIUM QUESTIONS
-- ################################################################

-- Q16 [MEDIUM] [Amazon-style]
-- List orders sorted by order_date DESC, and for orders on the same date, sort by total_amount DESC.
SELECT * FROM orders ORDER BY order_date DESC, total_amount DESC;


-- Q17 [MEDIUM] [Swiggy-style]
-- Get the 5 highest-rated restaurants in 'Mumbai', sorted by rating DESC.
SELECT * FROM restaurants WHERE city = 'Mumbai' ORDER BY rating DESC LIMIT 5;


-- Q18 [MEDIUM] [HR System]
-- Find the 2nd highest salary in the employees table using DISTINCT, ORDER BY, LIMIT, OFFSET.
SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT 1 OFFSET 1;


-- Q19 [MEDIUM] [Banking]
-- List the top 3 customers by total transaction_amount, aliasing the column as total_spent.
SELECT customer_id, SUM(transaction_amount) AS total_spent FROM transactions GROUP BY customer_id ORDER BY total_spent DESC LIMIT 3;


-- Q20 [MEDIUM] [E-commerce]
-- Get distinct combinations of category and brand from the products table.
SELECT DISTINCT category, brand FROM products;


-- Q21 [MEDIUM] [Airline-style]
-- List the 10 most delayed flights (delay_minutes DESC), showing flight_code AS flight, delay_minutes AS delay.
SELECT flight_code AS flight, delay_minutes AS delay FROM flights ORDER BY delay_minutes DESC LIMIT 10;


-- Q22 [MEDIUM] [Healthcare]
-- List doctors sorted by department ASC, experience_years DESC.
SELECT * FROM doctors ORDER BY department ASC, experience_years DESC;


-- Q23 [MEDIUM] [Retail Chain]
-- Get the number of unique store_id values that recorded at least one sale using COUNT(DISTINCT store_id).
SELECT COUNT(DISTINCT store_id) AS active_stores FROM store_sales;


-- Q24 [MEDIUM] [Telecom]
-- List the 5 subscribers with the highest outstanding_balance, using an alias AS balance_due.
SELECT subscriber_id, outstanding_balance AS balance_due FROM subscribers ORDER BY outstanding_balance DESC LIMIT 5;


-- Q25 [MEDIUM] [Logistics]
-- Paginate shipments - return rows 21-30 (page 3, page size 10) sorted by shipment_id.
SELECT * FROM shipments ORDER BY shipment_id LIMIT 10 OFFSET 20;
-- Explanation:
-- General formula: OFFSET = (page - 1) * page_size. Page 3, size 10 -> (3-1)*10 = 20.


-- Q26 [MEDIUM] [Insurance]
-- Get distinct claim_type values, sorted alphabetically.
SELECT DISTINCT claim_type FROM claims ORDER BY claim_type ASC;


-- Q27 [MEDIUM] [Streaming Service]
-- Find the 3rd most recently active user using ORDER BY last_login_date DESC LIMIT 1 OFFSET 2.
SELECT * FROM subscriptions ORDER BY last_login_date DESC LIMIT 1 OFFSET 2;


-- Q28 [MEDIUM] [Uber-style]
-- List the top 5 drivers by total_trips DESC, aliasing as driver_name, trips_completed.
SELECT driver_name, total_trips AS trips_completed FROM drivers ORDER BY total_trips DESC LIMIT 5;


-- Q29 [MEDIUM] [Manufacturing]
-- Get distinct machine_type values that have had at least one maintenance_log entry.
SELECT DISTINCT m.machine_type
FROM machines m
JOIN maintenance_log l ON l.machine_id = m.machine_id;


-- Q30 [MEDIUM] [Global E-commerce]
-- List the 10 most recent orders (order_date DESC) where order_status = 'Delivered'.
SELECT * FROM orders WHERE order_status = 'Delivered' ORDER BY order_date DESC LIMIT 10;


-- ################################################################
-- HARD QUESTIONS
-- ################################################################

-- Q31 [HARD] [Amazon-style]
-- Find the 3rd highest total_amount order overall, without using window functions (ORDER BY + LIMIT + OFFSET only), and explain why DISTINCT matters if there are tied amounts.
SELECT DISTINCT total_amount FROM orders ORDER BY total_amount DESC LIMIT 1 OFFSET 2;
-- Explanation:
-- Without DISTINCT, two orders sharing the highest amount would occupy both
-- rank 1 and rank 2 in the raw row order, pushing the real 3rd-highest DISTINCT
-- value out to OFFSET 3 - so LIMIT 1 OFFSET 2 would return a duplicate of the
-- top amount instead of the true 3rd distinct value.


-- Q32 [HARD] [Banking]
-- Rank customers by account_balance DESC and return only ranks 11-20 (i.e., customers 11th to 20th richest) using LIMIT/OFFSET.
SELECT * FROM customers ORDER BY account_balance DESC LIMIT 10 OFFSET 10;


-- Q33 [HARD] [HR System]
-- Find the 2nd lowest salary handled correctly even if duplicate minimum salaries exist - write the query and explain the DISTINCT requirement.
SELECT DISTINCT salary FROM employees ORDER BY salary ASC LIMIT 1 OFFSET 1;
-- Explanation:
-- If two employees share the lowest salary, without DISTINCT that same
-- minimum value would occupy both OFFSET 0 and OFFSET 1, so 'LIMIT 1 OFFSET 1'
-- would just return the same minimum again instead of the actual 2nd-lowest
-- distinct salary.


-- Q34 [HARD] [Airline-style]
-- List the top 5 busiest routes (origin, destination combination) by number of flights, using DISTINCT-aware counting logic (conceptual - GROUP BY needed, but describe why DISTINCT alone isn't sufficient here).
SELECT origin, destination, COUNT(*) AS flight_count
FROM flights
GROUP BY origin, destination
ORDER BY flight_count DESC
LIMIT 5;
-- Explanation:
-- DISTINCT only removes duplicate rows - it can tell you which route
-- combinations exist, but it cannot count HOW MANY TIMES each occurs.
-- Ranking by frequency requires GROUP BY (to bucket rows by route) plus
-- COUNT(*) (to measure bucket size); DISTINCT alone has no counting ability.


-- Q35 [HARD] [Healthcare]
-- Return page 5 (page size 15) of all patients sorted by registration_date DESC, and compute the correct OFFSET value.
SELECT * FROM patients ORDER BY registration_date DESC LIMIT 15 OFFSET 60;
-- Explanation:
-- OFFSET = (page - 1) * page_size = (5 - 1) * 15 = 60.


-- Q36 [HARD] [E-commerce]
-- Find products with the top 10 highest price, but exclude products where price IS NULL, and explain how NULLs interact with ORDER BY DESC in your target engine (PostgreSQL vs MySQL).
SELECT * FROM products WHERE price IS NOT NULL ORDER BY price DESC LIMIT 10;
-- Explanation:
-- PostgreSQL's default is NULLS FIRST for DESC (NULLs sort as if larger than
-- any value), so an unfiltered 'ORDER BY price DESC' would push NULL rows to
-- the very top. MySQL treats NULL as the smallest possible value, so the same
-- query would push NULLs to the bottom in DESC order. Because the default
-- behaviour differs by engine, explicitly filtering 'WHERE price IS NOT NULL'
-- (or using NULLS LAST/NULLS FIRST explicitly) avoids engine-dependent surprises.


-- Q37 [HARD] [Retail Chain]
-- Get distinct (store_id, product_id) pairs that have never had a stock-out (conceptual: DISTINCT combination filtering), aliasing the pair meaningfully.
SELECT DISTINCT store_id AS store, product_id AS product
FROM store_sales
WHERE is_stockout = 0;


-- Q38 [HARD] [Telecom]
-- Explain, using a concrete example, why SELECT DISTINCT plan_type, region FROM subscribers might return more rows than expected compared to what a beginner assumed (multi-column DISTINCT trap).
SELECT DISTINCT plan_type, region FROM subscribers;
-- Explanation:
-- DISTINCT with multiple columns removes duplicate ROW COMBINATIONS, not
-- duplicate values of a single column. A beginner might expect only 2 rows
-- back (one per plan_type: 'Postpaid', 'Prepaid'), but because region varies,
-- the query actually returns one row per unique (plan_type, region) pair -
-- e.g. ('Postpaid','North'), ('Postpaid','South'), ('Postpaid','East') are
-- three separate rows even though plan_type repeats each time.


-- Q39 [HARD] [Logistics]
-- Find the shipment with the 4th longest delivery duration (delivery_date - order_date), using an alias for the computed duration column and ordering by it.
SELECT *, (julianday(delivery_date) - julianday(order_date)) AS duration_days
FROM shipments
ORDER BY duration_days DESC
LIMIT 1 OFFSET 3;
-- Explanation:
-- SQLite has no native DATEDIFF; julianday() converts a date to a numeric
-- day count, so subtracting two julianday() values gives the duration in days.
-- (In PostgreSQL you could simply write delivery_date - order_date.)


-- Q40 [HARD] [Insurance]
-- Return the top 5 claims by claim_amount, but if there's a tie at the 5th position, explain (in words) what LIMIT 5 alone would do vs what business logic might actually require.
SELECT * FROM claims ORDER BY claim_amount DESC LIMIT 5;
-- Explanation:
-- LIMIT 5 always returns exactly 5 rows, picking an essentially arbitrary
-- row among any tie at the cut-off boundary (the exact one returned depends on
-- internal row order, which SQL does not guarantee unless you add a tiebreaker
-- column). If the business requirement is 'include every claim tied for 5th
-- place', LIMIT 5 alone is not correct - you'd need a ranking approach such as
-- RANK() <= 5 (a window function) so that ties are all included together.


-- Q41 [HARD] [Streaming Service]
-- Find the 2nd most-subscribed plan_name by subscriber count (conceptual - requires GROUP BY awareness, but describe the ORDER BY/LIMIT/OFFSET pattern that would apply after aggregation).
SELECT plan_name, COUNT(*) AS subscriber_count
FROM subscriptions
GROUP BY plan_name
ORDER BY subscriber_count DESC
LIMIT 1 OFFSET 1;
-- Explanation:
-- GROUP BY first collapses rows into one per plan_name and computes
-- COUNT(*) per group; only after that aggregation does ORDER BY/LIMIT/OFFSET
-- apply the same '2nd highest' pattern used elsewhere, but now on the
-- aggregated subscriber_count instead of a raw column.


-- Q42 [HARD] [Uber-style]
-- Explain step by step (using the logical execution order) why this query is invalid: SELECT driver_id, COUNT(*) AS trip_count FROM trips WHERE trip_count > 10; and how you'd fix it.
-- INVALID:
-- SELECT driver_id, COUNT(*) AS trip_count FROM trips WHERE trip_count > 10;

-- FIXED:
SELECT driver_id, COUNT(*) AS trip_count
FROM trips
GROUP BY driver_id
HAVING COUNT(*) > 10;
-- Explanation:
-- SQL's logical execution order is roughly:
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY.
-- WHERE runs BEFORE SELECT, so the alias trip_count (created in SELECT) does
-- not exist yet when WHERE is evaluated - that's why the original query fails.
-- Additionally, filtering on an aggregate like COUNT(*) always requires HAVING
-- (which runs after GROUP BY), not WHERE. The fix groups rows per driver_id
-- and filters the aggregated count with HAVING.


-- Q43 [HARD] [Manufacturing]
-- Get machines sorted by last_maintenance_date ASC, explicitly handling NULLs to appear FIRST regardless of engine (write both PostgreSQL and MySQL-compatible approaches).
-- PostgreSQL / SQLite (3.30+):
SELECT * FROM machines ORDER BY last_maintenance_date ASC NULLS FIRST;

-- MySQL (no NULLS FIRST/LAST syntax) - emulate it:
-- SELECT * FROM machines
-- ORDER BY (last_maintenance_date IS NULL) DESC, last_maintenance_date ASC;
-- Explanation:
-- PostgreSQL and modern SQLite support the NULLS FIRST/NULLS LAST keywords
-- directly. MySQL does not, so the common workaround is to sort first by a
-- boolean expression that is TRUE (1) for NULL rows and FALSE (0) otherwise,
-- DESC so the TRUE/NULL rows sort to the top, then sort remaining rows
-- normally by the real column.


-- Q44 [HARD] [Global E-commerce]
-- Design a pagination query for an API endpoint returning page N with page size P for orders sorted by order_date DESC, order_id DESC (compound sort for tie-breaking) - explain why the tie-breaker column is necessary for stable pagination.
-- Example: page N = 2, page size P = 5
SELECT * FROM orders
ORDER BY order_date DESC, order_id DESC
LIMIT 5 OFFSET 5;
-- general form: LIMIT P OFFSET (N-1)*P
-- Explanation:
-- If multiple orders share the same order_date, sorting by order_date alone
-- leaves their relative order unspecified by SQL - the engine is free to
-- return them in a different sequence each time the query runs (e.g. after an
-- index rebuild or on a different page request). That can cause the same row
-- to appear on two different pages, or a row to be skipped entirely. Adding
-- order_id DESC as a secondary sort key guarantees a fully deterministic order,
-- so pagination stays stable across repeated requests.


-- Q45 [HARD] [Banking]
-- Find the customer with the 5th highest average transaction amount (conceptual, GROUP BY needed for the average, but write the ORDER BY/LIMIT/OFFSET pattern you'd apply on top of that aggregated result, and explain why plain DISTINCT wouldn't help here).
SELECT customer_id, AVG(transaction_amount) AS avg_amount
FROM transactions
GROUP BY customer_id
ORDER BY avg_amount DESC
LIMIT 1 OFFSET 4;
-- Explanation:
-- DISTINCT only removes duplicate whole rows - it has no notion of
-- computing an average. To get 'average transaction amount per customer' you
-- first need GROUP BY customer_id with AVG(transaction_amount) to produce that
-- number per customer; only after that aggregated result exists does the
-- familiar 'Nth highest' ORDER BY/LIMIT/OFFSET pattern apply on top of it.

