-- ============================================================
-- SQL Practice - Day 4 : GROUP BY, Aggregate Functions & HAVING
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
-- Q1 [EASY] [HR System]
-- Find the total number of employees in each department using COUNT(*).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q2 [EASY] [E-commerce]
-- Find the total SUM(total_amount) of all orders per customer_id.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q3 [EASY] [Banking]
-- Find the average account balance per account_type using AVG.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q4 [EASY] [Retail Chain]
-- Find the highest price product in each category using MAX.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q5 [EASY] [Airline-style]
-- Find the lowest fare for each route using MIN.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q6 [EASY] [Telecom]
-- Count the number of subscribers per plan_type.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q7 [EASY] [Healthcare]
-- Find the average age of patients grouped by gender.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q8 [EASY] [Uber-style]
-- Find the total number of trips per driver_id.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q9 [EASY] [Insurance]
-- Find the total claim_amount (SUM) per claim_type.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q10 [EASY] [Streaming Service]
-- Count the number of subscribers per plan_name.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q11 [EASY] [Logistics]
-- Find the average delivery_days (delivery_date - order_date) per warehouse_id
-- (conceptual - assume a precomputed column).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q12 [EASY] [Manufacturing]
-- Find the count of maintenance_logs per machine_id.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q13 [EASY] [School System]
-- Find the average marks per subject.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q14 [EASY] [Zomato-style]
-- Find the number of restaurants per city using COUNT(*).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q15 [EASY] [Global E-commerce]
-- Find the total revenue (SUM(total_amount)) per product_category.
-- ---------------------------------------------------------------




-- ################################################################
-- MEDIUM QUESTIONS
-- ################################################################

-- ---------------------------------------------------------------
-- Q16 [MEDIUM] [Amazon-style]
-- Find customer_ids who have placed more than 5 orders (GROUP BY customer_id HAVING
-- COUNT(*) > 5).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q17 [MEDIUM] [HR System]
-- Find departments with an average salary greater than 60000 (GROUP BY department HAVING
-- AVG(salary) > 60000).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q18 [MEDIUM] [Banking]
-- Find duplicate account_number entries in an accounts table (should never happen, but
-- write the detection query - GROUP BY account_number HAVING COUNT(*) > 1).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q19 [MEDIUM] [Telecom]
-- Find plan_types used by fewer than 100 subscribers (HAVING COUNT(*) < 100).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q20 [MEDIUM] [Retail Chain]
-- Find store_ids where total SUM(sales_amount) exceeds 1,000,000.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q21 [MEDIUM] [E-commerce]
-- Find product_sku values that appear more than once in the products table (data quality
-- check).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q22 [MEDIUM] [Healthcare]
-- Find doctor_ids who have handled more than 50 appointments.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q23 [MEDIUM] [Airline-style]
-- Find routes (origin-destination pairs) with an average delay_minutes greater than 30.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q24 [MEDIUM] [Uber-style]
-- Find driver_ids with fewer than 10 completed trips (potential inactive drivers).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q25 [MEDIUM] [School System]
-- Find roll_numbers that appear more than once (data integrity check).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q26 [MEDIUM] [Insurance]
-- Find claim_types where the total claim amount exceeds 5,000,000.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q27 [MEDIUM] [Streaming Service]
-- Find plan_names with more than 10,000 active subscribers.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q28 [MEDIUM] [Logistics]
-- Find warehouse_ids with more than 20 pending shipments (WHERE status = 'Pending'
-- before GROUP BY, then HAVING COUNT(*) > 20).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q29 [MEDIUM] [Retail Chain]
-- Among only 'Active' employees, find departments with an average salary above 50000
-- (WHERE status = 'Active' then GROUP BY department HAVING AVG(salary) > 50000).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q30 [MEDIUM] [Manufacturing]
-- Find machine_types with an average operating_hours greater than 5000.
-- ---------------------------------------------------------------




-- ################################################################
-- HARD QUESTIONS
-- ################################################################

-- ---------------------------------------------------------------
-- Q31 [HARD] [Amazon-style]
-- Find customer_ids who placed more than 10 orders AND whose total SUM(total_amount)
-- exceeds 100,000 (combine two HAVING conditions with AND).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q32 [HARD] [HR System]
-- Find departments where both the employee count is greater than 15 and the average
-- salary is above 70000, using multiple aggregates in a single HAVING clause.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q33 [HARD] [Banking]
-- Find account_holder_ids in a joint-account bridge table who are linked to more than 3
-- accounts (a real fraud/risk-monitoring pattern).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q34 [HARD] [E-commerce]
-- Find product_ids that have been ordered by more than 100 distinct customers
-- (COUNT(DISTINCT customer_id) inside HAVING).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q35 [HARD] [Telecom]
-- Find subscribers (GROUP BY subscriber_id) with more than 3 complaints AND average
-- resolution time greater than 48 hours.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q36 [HARD] [Healthcare]
-- Find doctor_ids whose appointments have an average patient_rating below 3.0, but only
-- among doctors with at least 20 appointments (avoid flagging doctors with too little
-- data - explain why the HAVING COUNT(*) >= 20 condition matters here).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q37 [HARD] [Retail Chain]
-- Find store_ids where MAX(sales_amount) - MIN(sales_amount) (the sales range) exceeds
-- 50000, revealing highly inconsistent daily performance.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q38 [HARD] [Global E-commerce]
-- Find customers who have placed duplicate orders - same customer_id, same product_id,
-- same order_date appearing more than once (GROUP BY customer_id, product_id, order_date
-- HAVING COUNT(*) > 1).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q39 [HARD] [Airline-style]
-- Find flight_codes with more than 5 delayed flights (delay_minutes > 30) in the last 30
-- days, combining a WHERE date filter with HAVING count threshold.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q40 [HARD] [Insurance]
-- Find agent_ids who have processed claims with a total claim_amount exceeding
-- 10,000,000 but where the average claim amount per claim is below 50,000 (detects
-- high-volume, low-value claim patterns).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q41 [HARD] [Streaming Service]
-- Find plan_names where subscriber count dropped compared to a prior period (conceptual:
-- describe how you'd compare two GROUP BY results - full solution needs a self-join or
-- subquery, covered in a later day).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q42 [HARD] [Uber-style]
-- Find driver_ids with more than 100 trips AND an average trip rating below 4.0 -
-- candidates for performance review.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q43 [HARD] [Manufacturing]
-- Find machine_types where the count of maintenance_logs with status = 'Failed' exceeds
-- 20% of their total logs (conceptual - requires combining a filtered COUNT and a total
-- COUNT; discuss the approach using conditional aggregation, e.g. SUM(CASE WHEN
-- status='Failed' THEN 1 ELSE 0 END)).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q44 [HARD] [Banking]
-- Find branch_ids where the number of accounts opened in the last 6 months exceeds the
-- branch's average monthly account openings over the last 2 years (conceptual - describe
-- the two-step GROUP BY comparison needed; full solution requires subqueries, covered
-- later).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q45 [HARD] [Global E-commerce]
-- Find seller_ids who have more than 50 orders AND a return rate above 15% (SUM(CASE
-- WHEN is_returned THEN 1 ELSE 0 END) / COUNT(*) > 0.15) - a genuinely realistic
-- seller-quality flagging query used in real e-commerce analytics.
-- ---------------------------------------------------------------



