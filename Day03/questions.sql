-- ============================================================
-- SQL Practice - Day 3 : ORDER BY, DISTINCT, LIMIT/OFFSET, Pagination
-- 45 questions across Easy / Medium / Hard, spanning 15+ domains
-- (Amazon, Netflix, HR, Zomato, Airline, Banking, Healthcare, Uber,
-- Logistics, Insurance, Telecom, Manufacturing, and more)
--
-- HOW TO USE:
--   1. Run schema.sql first to create tables and load sample data.
--   2. For each question below, write your own SQL query right
--      after the comment block, then run it against the DB.
--   3. Compare with solutions.sql once you're done.
-- ============================================================


-- ################################################################
-- EASY QUESTIONS
-- ################################################################

-- ---------------------------------------------------------------
-- Q1 [EASY] [Amazon-style]
-- List all orders sorted by order_date in ascending order.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q2 [EASY] [Netflix-style]
-- List all subscribers sorted by signup_date descending (most recent first).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q3 [EASY] [HR System]
-- List employees sorted by salary descending, then by name ascending for ties.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q4 [EASY] [Zomato-style]
-- Get the distinct list of city values from the restaurants table.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q5 [EASY] [E-commerce]
-- Get the top 5 most expensive products using ORDER BY + LIMIT.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q6 [EASY] [Airline-style]
-- List all distinct origin airports from the flights table.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q7 [EASY] [Bank-style]
-- List the top 10 customers by account_balance descending.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q8 [EASY] [School System]
-- List students sorted alphabetically by student_name.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q9 [EASY] [Telecom]
-- Get distinct plan_type values from the subscribers table.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q10 [EASY] [Retail Chain]
-- Select first_name AS employee_name, salary AS monthly_salary from employees.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q11 [EASY] [Healthcare]
-- List the 3 most recently registered patients using ORDER BY registration_date DESC
-- LIMIT 3.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q12 [EASY] [Uber-style]
-- List distinct city values where trips have occurred.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q13 [EASY] [Logistics]
-- List shipments sorted by expected_delivery_date ascending.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q14 [EASY] [Insurance]
-- Get the top 5 highest claim_amount records.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q15 [EASY] [Streaming Service]
-- List distinct plan_name values from subscriptions.
-- ---------------------------------------------------------------




-- ################################################################
-- MEDIUM QUESTIONS
-- ################################################################

-- ---------------------------------------------------------------
-- Q16 [MEDIUM] [Amazon-style]
-- List orders sorted by order_date DESC, and for orders on the same date, sort by
-- total_amount DESC.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q17 [MEDIUM] [Swiggy-style]
-- Get the 5 highest-rated restaurants in 'Mumbai', sorted by rating DESC.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q18 [MEDIUM] [HR System]
-- Find the 2nd highest salary in the employees table using DISTINCT, ORDER BY, LIMIT,
-- OFFSET.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q19 [MEDIUM] [Banking]
-- List the top 3 customers by total transaction_amount, aliasing the column as
-- total_spent.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q20 [MEDIUM] [E-commerce]
-- Get distinct combinations of category and brand from the products table.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q21 [MEDIUM] [Airline-style]
-- List the 10 most delayed flights (delay_minutes DESC), showing flight_code AS flight,
-- delay_minutes AS delay.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q22 [MEDIUM] [Healthcare]
-- List doctors sorted by department ASC, experience_years DESC.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q23 [MEDIUM] [Retail Chain]
-- Get the number of unique store_id values that recorded at least one sale using
-- COUNT(DISTINCT store_id).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q24 [MEDIUM] [Telecom]
-- List the 5 subscribers with the highest outstanding_balance, using an alias AS
-- balance_due.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q25 [MEDIUM] [Logistics]
-- Paginate shipments - return rows 21-30 (page 3, page size 10) sorted by shipment_id.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q26 [MEDIUM] [Insurance]
-- Get distinct claim_type values, sorted alphabetically.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q27 [MEDIUM] [Streaming Service]
-- Find the 3rd most recently active user using ORDER BY last_login_date DESC LIMIT 1
-- OFFSET 2.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q28 [MEDIUM] [Uber-style]
-- List the top 5 drivers by total_trips DESC, aliasing as driver_name, trips_completed.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q29 [MEDIUM] [Manufacturing]
-- Get distinct machine_type values that have had at least one maintenance_log entry.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q30 [MEDIUM] [Global E-commerce]
-- List the 10 most recent orders (order_date DESC) where order_status = 'Delivered'.
-- ---------------------------------------------------------------




-- ################################################################
-- HARD QUESTIONS
-- ################################################################

-- ---------------------------------------------------------------
-- Q31 [HARD] [Amazon-style]
-- Find the 3rd highest total_amount order overall, without using window functions (ORDER
-- BY + LIMIT + OFFSET only), and explain why DISTINCT matters if there are tied amounts.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q32 [HARD] [Banking]
-- Rank customers by account_balance DESC and return only ranks 11-20 (i.e., customers
-- 11th to 20th richest) using LIMIT/OFFSET.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q33 [HARD] [HR System]
-- Find the 2nd lowest salary handled correctly even if duplicate minimum salaries exist
-- - write the query and explain the DISTINCT requirement.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q34 [HARD] [Airline-style]
-- List the top 5 busiest routes (origin, destination combination) by number of flights,
-- using DISTINCT-aware counting logic (conceptual - GROUP BY needed, but describe why
-- DISTINCT alone isn't sufficient here).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q35 [HARD] [Healthcare]
-- Return page 5 (page size 15) of all patients sorted by registration_date DESC, and
-- compute the correct OFFSET value.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q36 [HARD] [E-commerce]
-- Find products with the top 10 highest price, but exclude products where price IS NULL,
-- and explain how NULLs interact with ORDER BY DESC in your target engine (PostgreSQL vs
-- MySQL).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q37 [HARD] [Retail Chain]
-- Get distinct (store_id, product_id) pairs that have never had a stock-out (conceptual:
-- DISTINCT combination filtering), aliasing the pair meaningfully.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q38 [HARD] [Telecom]
-- Explain, using a concrete example, why SELECT DISTINCT plan_type, region FROM
-- subscribers might return more rows than expected compared to what a beginner assumed
-- (multi-column DISTINCT trap).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q39 [HARD] [Logistics]
-- Find the shipment with the 4th longest delivery duration (delivery_date - order_date),
-- using an alias for the computed duration column and ordering by it.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q40 [HARD] [Insurance]
-- Return the top 5 claims by claim_amount, but if there's a tie at the 5th position,
-- explain (in words) what LIMIT 5 alone would do vs what business logic might actually
-- require.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q41 [HARD] [Streaming Service]
-- Find the 2nd most-subscribed plan_name by subscriber count (conceptual - requires
-- GROUP BY awareness, but describe the ORDER BY/LIMIT/OFFSET pattern that would apply
-- after aggregation).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q42 [HARD] [Uber-style]
-- Explain step by step (using the logical execution order) why this query is invalid:
-- SELECT driver_id, COUNT(*) AS trip_count FROM trips WHERE trip_count > 10; and how
-- you'd fix it.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q43 [HARD] [Manufacturing]
-- Get machines sorted by last_maintenance_date ASC, explicitly handling NULLs to appear
-- FIRST regardless of engine (write both PostgreSQL and MySQL-compatible approaches).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q44 [HARD] [Global E-commerce]
-- Design a pagination query for an API endpoint returning page N with page size P for
-- orders sorted by order_date DESC, order_id DESC (compound sort for tie-breaking) -
-- explain why the tie-breaker column is necessary for stable pagination.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q45 [HARD] [Banking]
-- Find the customer with the 5th highest average transaction amount (conceptual, GROUP
-- BY needed for the average, but write the ORDER BY/LIMIT/OFFSET pattern you'd apply on
-- top of that aggregated result, and explain why plain DISTINCT wouldn't help here).
-- ---------------------------------------------------------------



