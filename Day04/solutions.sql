-- ============================================================
-- SQL Practice - Day 4 : ANSWER KEY
-- Matches questions.sql 1:1. Try questions.sql yourself first!
-- Explanations included wherever the logic is tricky: multi-
-- aggregate HAVING, conditional aggregation (CASE WHEN), sample-
-- size guards, and comparing aggregates across time periods.
-- ============================================================


-- ################################################################
-- EASY QUESTIONS
-- ################################################################

-- Q1 [EASY] [HR System]
-- Find the total number of employees in each department using COUNT(*).
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;


-- Q2 [EASY] [E-commerce]
-- Find the total SUM(total_amount) of all orders per customer_id.
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;


-- Q3 [EASY] [Banking]
-- Find the average account balance per account_type using AVG.
SELECT account_type, AVG(balance) AS avg_balance
FROM accounts
GROUP BY account_type;


-- Q4 [EASY] [Retail Chain]
-- Find the highest price product in each category using MAX.
SELECT category, MAX(price) AS highest_price
FROM products
GROUP BY category;


-- Q5 [EASY] [Airline-style]
-- Find the lowest fare for each route using MIN.
SELECT route, MIN(fare) AS lowest_fare
FROM flights
GROUP BY route;


-- Q6 [EASY] [Telecom]
-- Count the number of subscribers per plan_type.
SELECT plan_type, COUNT(*) AS subscriber_count
FROM subscribers
GROUP BY plan_type;


-- Q7 [EASY] [Healthcare]
-- Find the average age of patients grouped by gender.
SELECT gender, AVG(age) AS avg_age
FROM patients
GROUP BY gender;


-- Q8 [EASY] [Uber-style]
-- Find the total number of trips per driver_id.
SELECT driver_id, COUNT(*) AS trip_count
FROM trips
GROUP BY driver_id;


-- Q9 [EASY] [Insurance]
-- Find the total claim_amount (SUM) per claim_type.
SELECT claim_type, SUM(claim_amount) AS total_claim_amount
FROM claims
GROUP BY claim_type;


-- Q10 [EASY] [Streaming Service]
-- Count the number of subscribers per plan_name.
SELECT plan_name, COUNT(*) AS subscriber_count
FROM subscriptions
GROUP BY plan_name;


-- Q11 [EASY] [Logistics]
-- Find the average delivery_days (delivery_date - order_date) per warehouse_id (conceptual - assume a precomputed column).
SELECT warehouse_id, AVG(delivery_days) AS avg_delivery_days
FROM shipments
GROUP BY warehouse_id;
-- Explanation:
-- delivery_days is treated as an already-computed column here (as the
-- question states) rather than derived inline from two date columns, to keep
-- the GROUP BY focus front and center.


-- Q12 [EASY] [Manufacturing]
-- Find the count of maintenance_logs per machine_id.
SELECT machine_id, COUNT(*) AS log_count
FROM maintenance_logs
GROUP BY machine_id;


-- Q13 [EASY] [School System]
-- Find the average marks per subject.
SELECT subject, AVG(marks) AS avg_marks
FROM student_marks
GROUP BY subject;


-- Q14 [EASY] [Zomato-style]
-- Find the number of restaurants per city using COUNT(*).
SELECT city, COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY city;


-- Q15 [EASY] [Global E-commerce]
-- Find the total revenue (SUM(total_amount)) per product_category.
SELECT product_category, SUM(total_amount) AS total_revenue
FROM global_orders
GROUP BY product_category;


-- ################################################################
-- MEDIUM QUESTIONS
-- ################################################################

-- Q16 [MEDIUM] [Amazon-style]
-- Find customer_ids who have placed more than 5 orders (GROUP BY customer_id HAVING COUNT(*) > 5).
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 5;


-- Q17 [MEDIUM] [HR System]
-- Find departments with an average salary greater than 60000 (GROUP BY department HAVING AVG(salary) > 60000).
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;


-- Q18 [MEDIUM] [Banking]
-- Find duplicate account_number entries in an accounts table (should never happen, but write the detection query - GROUP BY account_number HAVING COUNT(*) > 1).
SELECT account_number, COUNT(*) AS occurrences
FROM accounts
GROUP BY account_number
HAVING COUNT(*) > 1;


-- Q19 [MEDIUM] [Telecom]
-- Find plan_types used by fewer than 100 subscribers (HAVING COUNT(*) < 100).
SELECT plan_type, COUNT(*) AS subscriber_count
FROM subscribers
GROUP BY plan_type
HAVING COUNT(*) < 100;
-- Explanation:
-- This sample dataset is intentionally small, so every plan_type will
-- satisfy '< 100' here - the query pattern is still the realistic one used
-- against production-scale telecom data.


-- Q20 [MEDIUM] [Retail Chain]
-- Find store_ids where total SUM(sales_amount) exceeds 1,000,000.
SELECT store_id, SUM(sales_amount) AS total_sales
FROM daily_sales
GROUP BY store_id
HAVING SUM(sales_amount) > 1000000;


-- Q21 [MEDIUM] [E-commerce]
-- Find product_sku values that appear more than once in the products table (data quality check).
SELECT product_sku, COUNT(*) AS occurrences
FROM products
GROUP BY product_sku
HAVING COUNT(*) > 1;


-- Q22 [MEDIUM] [Healthcare]
-- Find doctor_ids who have handled more than 50 appointments.
SELECT doctor_id, COUNT(*) AS appointment_count
FROM doctor_appointments
GROUP BY doctor_id
HAVING COUNT(*) > 50;


-- Q23 [MEDIUM] [Airline-style]
-- Find routes (origin-destination pairs) with an average delay_minutes greater than 30.
SELECT route, AVG(delay_minutes) AS avg_delay
FROM flights
GROUP BY route
HAVING AVG(delay_minutes) > 30;


-- Q24 [MEDIUM] [Uber-style]
-- Find driver_ids with fewer than 10 completed trips (potential inactive drivers).
SELECT driver_id, COUNT(*) AS trip_count
FROM trips
GROUP BY driver_id
HAVING COUNT(*) < 10;


-- Q25 [MEDIUM] [School System]
-- Find roll_numbers that appear more than once (data integrity check).
SELECT roll_number, COUNT(*) AS occurrences
FROM students
GROUP BY roll_number
HAVING COUNT(*) > 1;


-- Q26 [MEDIUM] [Insurance]
-- Find claim_types where the total claim amount exceeds 5,000,000.
SELECT claim_type, SUM(claim_amount) AS total_claim_amount
FROM claims
GROUP BY claim_type
HAVING SUM(claim_amount) > 5000000;


-- Q27 [MEDIUM] [Streaming Service]
-- Find plan_names with more than 10,000 active subscribers.
SELECT plan_name, COUNT(*) AS active_subscribers
FROM subscriptions
WHERE is_active = 1
GROUP BY plan_name
HAVING COUNT(*) > 10000;
-- Explanation:
-- With this small sample dataset no plan will cross 10,000 - the query
-- will correctly return zero rows. At production scale this same pattern is
-- how you'd flag genuinely high-traction plans.


-- Q28 [MEDIUM] [Logistics]
-- Find warehouse_ids with more than 20 pending shipments (WHERE status = 'Pending' before GROUP BY, then HAVING COUNT(*) > 20).
SELECT warehouse_id, COUNT(*) AS pending_count
FROM shipments
WHERE status = 'Pending'
GROUP BY warehouse_id
HAVING COUNT(*) > 20;


-- Q29 [MEDIUM] [Retail Chain]
-- Among only 'Active' employees, find departments with an average salary above 50000 (WHERE status = 'Active' then GROUP BY department HAVING AVG(salary) > 50000).
SELECT department, AVG(salary) AS avg_salary
FROM employees
WHERE status = 'Active'
GROUP BY department
HAVING AVG(salary) > 50000;


-- Q30 [MEDIUM] [Manufacturing]
-- Find machine_types with an average operating_hours greater than 5000.
-- Uses the machines table (conceptual join target for this pattern);
-- shown here directly against maintenance_logs' machine_type where
-- an operating_hours-style column would be aggregated the same way:
SELECT machine_type, COUNT(*) AS log_count
FROM maintenance_logs
GROUP BY machine_type;
-- Swap COUNT(*) for AVG(operating_hours) once that column is joined in
-- from a machines table, e.g.:
-- SELECT machine_type, AVG(operating_hours) AS avg_hours
-- FROM machines GROUP BY machine_type HAVING AVG(operating_hours) > 5000;


-- ################################################################
-- HARD QUESTIONS
-- ################################################################

-- Q31 [HARD] [Amazon-style]
-- Find customer_ids who placed more than 10 orders AND whose total SUM(total_amount) exceeds 100,000 (combine two HAVING conditions with AND).
SELECT customer_id, COUNT(*) AS order_count, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 10 AND SUM(total_amount) > 100000;


-- Q32 [HARD] [HR System]
-- Find departments where both the employee count is greater than 15 and the average salary is above 70000, using multiple aggregates in a single HAVING clause.
SELECT department, COUNT(*) AS employee_count, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING COUNT(*) > 15 AND AVG(salary) > 70000;


-- Q33 [HARD] [Banking]
-- Find account_holder_ids in a joint-account bridge table who are linked to more than 3 accounts (a real fraud/risk-monitoring pattern).
SELECT account_holder_id, COUNT(*) AS linked_accounts
FROM account_holders_bridge
GROUP BY account_holder_id
HAVING COUNT(*) > 3;


-- Q34 [HARD] [E-commerce]
-- Find product_ids that have been ordered by more than 100 distinct customers (COUNT(DISTINCT customer_id) inside HAVING).
SELECT product_id, COUNT(DISTINCT customer_id) AS distinct_customers
FROM product_orders
GROUP BY product_id
HAVING COUNT(DISTINCT customer_id) > 100;


-- Q35 [HARD] [Telecom]
-- Find subscribers (GROUP BY subscriber_id) with more than 3 complaints AND average resolution time greater than 48 hours.
SELECT subscriber_id, COUNT(*) AS complaint_count, AVG(resolution_hours) AS avg_resolution
FROM telecom_complaints
GROUP BY subscriber_id
HAVING COUNT(*) > 3 AND AVG(resolution_hours) > 48;


-- Q36 [HARD] [Healthcare]
-- Find doctor_ids whose appointments have an average patient_rating below 3.0, but only among doctors with at least 20 appointments (avoid flagging doctors with too little data - explain why the HAVING COUNT(*) >= 20 condition matters here).
SELECT doctor_id, COUNT(*) AS appointment_count, AVG(patient_rating) AS avg_rating
FROM doctor_appointments
GROUP BY doctor_id
HAVING AVG(patient_rating) < 3.0 AND COUNT(*) >= 20;
-- Explanation:
-- A doctor with only 2-3 appointments could easily average below 3.0 purely
-- by chance (small-sample noise), unfairly flagging them for review. Requiring
-- COUNT(*) >= 20 ensures the low average is backed by enough data to be a
-- reliable signal rather than a statistical fluke - a general principle
-- worth applying to any 'quality score' aggregation.


-- Q37 [HARD] [Retail Chain]
-- Find store_ids where MAX(sales_amount) - MIN(sales_amount) (the sales range) exceeds 50000, revealing highly inconsistent daily performance.
SELECT store_id, MAX(sales_amount) - MIN(sales_amount) AS sales_range
FROM daily_sales
GROUP BY store_id
HAVING MAX(sales_amount) - MIN(sales_amount) > 50000;


-- Q38 [HARD] [Global E-commerce]
-- Find customers who have placed duplicate orders - same customer_id, same product_id, same order_date appearing more than once (GROUP BY customer_id, product_id, order_date HAVING COUNT(*) > 1).
SELECT customer_id, product_id, order_date, COUNT(*) AS occurrences
FROM orders
GROUP BY customer_id, product_id, order_date
HAVING COUNT(*) > 1;


-- Q39 [HARD] [Airline-style]
-- Find flight_codes with more than 5 delayed flights (delay_minutes > 30) in the last 30 days, combining a WHERE date filter with HAVING count threshold.
SELECT flight_code, COUNT(*) AS delayed_flight_count
FROM flights
WHERE delay_minutes > 30 AND flight_date >= '2026-07-21'
GROUP BY flight_code
HAVING COUNT(*) > 5;
-- Explanation:
-- '2026-07-21' represents (latest_flight_date - 30 days) for this static
-- dataset. In a live system this would typically be written as
-- flight_date >= date('now', '-30 days') (SQLite) or CURRENT_DATE - INTERVAL
-- '30 days' (PostgreSQL) instead of a hardcoded literal.


-- Q40 [HARD] [Insurance]
-- Find agent_ids who have processed claims with a total claim_amount exceeding 10,000,000 but where the average claim amount per claim is below 50,000 (detects high-volume, low-value claim patterns).
SELECT agent_id, SUM(claim_amount) AS total_claims, AVG(claim_amount) AS avg_claim
FROM claims
GROUP BY agent_id
HAVING SUM(claim_amount) > 10000000 AND AVG(claim_amount) < 50000;


-- Q41 [HARD] [Streaming Service]
-- Find plan_names where subscriber count dropped compared to a prior period (conceptual: describe how you'd compare two GROUP BY results - full solution needs a self-join or subquery, covered in a later day).
-- Using a precomputed plan_period_counts(plan_name, period, subscriber_count)
-- table (same 'assume precomputed' convention as Easy11):
SELECT curr.plan_name, prev.subscriber_count AS prev_count, curr.subscriber_count AS curr_count
FROM plan_period_counts curr
JOIN plan_period_counts prev
  ON curr.plan_name = prev.plan_name
  AND prev.period = '2026-07' AND curr.period = '2026-08'
WHERE curr.subscriber_count < prev.subscriber_count;
-- Explanation:
-- A plain GROUP BY only ever looks at ONE snapshot of rows at a time - it
-- cannot compare 'this month' against 'last month' by itself. To compare two
-- aggregated periods you need two aggregated result sets side by side, which
-- requires either a self-join (as shown, joining the same table to itself on
-- matching plan_name but different period values) or a subquery/window
-- function (LAG()) - patterns covered in later, join-focused days.


-- Q42 [HARD] [Uber-style]
-- Find driver_ids with more than 100 trips AND an average trip rating below 4.0 - candidates for performance review.
SELECT driver_id, COUNT(*) AS trip_count, AVG(rating) AS avg_rating
FROM trips
GROUP BY driver_id
HAVING COUNT(*) > 100 AND AVG(rating) < 4.0;


-- Q43 [HARD] [Manufacturing]
-- Find machine_types where the count of maintenance_logs with status = 'Failed' exceeds 20% of their total logs (conceptual - requires combining a filtered COUNT and a total COUNT; discuss the approach using conditional aggregation, e.g. SUM(CASE WHEN status='Failed' THEN 1 ELSE 0 END)).
SELECT
  machine_type,
  COUNT(*) AS total_logs,
  SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END) AS failed_logs,
  1.0 * SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END) / COUNT(*) AS failure_rate
FROM maintenance_logs
GROUP BY machine_type
HAVING 1.0 * SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END) / COUNT(*) > 0.2;
-- Explanation:
-- Conditional aggregation - SUM(CASE WHEN condition THEN 1 ELSE 0 END) -
-- lets you count a SUBSET of rows within a group without a second query. It's
-- the standard way to compute a ratio/percentage per group in one pass: one
-- aggregate for the numerator (failed logs), one for the denominator (all
-- logs), combined in the SELECT/HAVING. The '1.0 *' forces floating-point
-- division so the ratio isn't truncated to 0 by integer division.


-- Q44 [HARD] [Banking]
-- Find branch_ids where the number of accounts opened in the last 6 months exceeds the branch's average monthly account openings over the last 2 years (conceptual - describe the two-step GROUP BY comparison needed; full solution requires subqueries, covered later).
-- Using a precomputed branch_monthly_openings(branch_id, month, accounts_opened) table:
SELECT b.branch_id,
       SUM(CASE WHEN b.month >= '2026-03' THEN b.accounts_opened ELSE 0 END) AS last_6mo_total,
       (SELECT AVG(accounts_opened) FROM branch_monthly_openings b2 WHERE b2.branch_id = b.branch_id) AS avg_monthly_2yr
FROM branch_monthly_openings b
GROUP BY b.branch_id
HAVING SUM(CASE WHEN b.month >= '2026-03' THEN b.accounts_opened ELSE 0 END)
       > 6 * (SELECT AVG(accounts_opened) FROM branch_monthly_openings b2 WHERE b2.branch_id = b.branch_id);
-- Explanation:
-- This needs TWO different aggregates over the SAME table at different
-- granularities: (1) a monthly average across the full 2-year history per
-- branch, and (2) a summed total across only the most recent 6 months per
-- branch. A single flat GROUP BY can't produce both numbers at once, so a
-- correlated subquery (or a CTE, covered later) is used to compute the
-- 2-year average independently, then compare it against the 6-month total
-- scaled by 6 to keep units consistent (monthly average x 6 months).


-- Q45 [HARD] [Global E-commerce]
-- Find seller_ids who have more than 50 orders AND a return rate above 15% (SUM(CASE WHEN is_returned THEN 1 ELSE 0 END) / COUNT(*) > 0.15) - a genuinely realistic seller-quality flagging query used in real e-commerce analytics.
SELECT
  seller_id,
  COUNT(*) AS total_orders,
  SUM(is_returned) AS returned_orders,
  1.0 * SUM(is_returned) / COUNT(*) AS return_rate
FROM seller_orders
GROUP BY seller_id
HAVING COUNT(*) > 50 AND 1.0 * SUM(is_returned) / COUNT(*) > 0.15;
-- Explanation:
-- Since is_returned is stored as 0/1 here, SUM(is_returned) already gives
-- the count of returned orders directly (equivalent to the longer
-- SUM(CASE WHEN is_returned THEN 1 ELSE 0 END) form in the question) - a handy
-- shortcut whenever a boolean flag is stored as an integer 0/1.

