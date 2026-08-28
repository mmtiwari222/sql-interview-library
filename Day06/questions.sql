-- ============================================================
-- SQL Practice - Day 6 : CASE WHEN, COALESCE, NULLIF, CAST,
-- String Functions & Conditional Aggregation
-- 45 questions across Easy / Medium / Hard, spanning 15+ domains
-- (HR, E-commerce, Banking, Airline, Healthcare, Retail, Telecom,
-- Insurance, Streaming, Uber, Logistics, Manufacturing, and more)
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
-- Write a CASE WHEN to label employees as 'Senior' if tenure_years >= 5, else 'Junior'.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q2 [EASY] [E-commerce]
-- Label orders as 'Large' if total_amount > 5000, else 'Small', using CASE WHEN.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q3 [EASY] [Banking]
-- Label accounts as 'Premium' if balance > 100000, else 'Standard'.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q4 [EASY] [Airline-style]
-- Label flights as 'Delayed' if delay_minutes > 0, else 'On Time'.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q5 [EASY] [School System]
-- Convert numeric marks into letter grades using CASE WHEN (90+='A', 75+='B', 60+='C',
-- else 'D').
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q6 [EASY] [Healthcare]
-- Use COALESCE(alternate_phone, primary_phone, 'No Contact') to get a display contact
-- number.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q7 [EASY] [Retail Chain]
-- Use COALESCE(discount, 0) so NULL discounts display as 0 in a report.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q8 [EASY] [Telecom]
-- Cast a signup_date stored as TEXT into a proper DATE using CAST.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q9 [EASY] [Insurance]
-- Cast policy_number (INTEGER) to TEXT to concatenate it into a formatted string.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q10 [EASY] [Streaming Service]
-- Use UPPER(plan_name) to standardize plan name casing in a report.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q11 [EASY] [Uber-style]
-- Use TRIM(driver_name) to remove accidental leading/trailing spaces from names.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q12 [EASY] [Zomato-style]
-- Use CONCAT(first_name, ' ', last_name) to build a full_name column.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q13 [EASY] [Global E-commerce]
-- Use LENGTH(product_description) to flag products with descriptions under 20
-- characters.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q14 [EASY] [Logistics]
-- Use LEFT(tracking_id, 3) to extract the courier code prefix.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q15 [EASY] [Manufacturing]
-- Use REPLACE(machine_code, '-', '') to remove hyphens from a machine code.
-- ---------------------------------------------------------------




-- ################################################################
-- MEDIUM QUESTIONS
-- ################################################################

-- ---------------------------------------------------------------
-- Q16 [MEDIUM] [HR System]
-- For each department, compute total_employees and the count of employees earning >
-- 80000 (SUM(CASE WHEN salary > 80000 THEN 1 ELSE 0 END)).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q17 [MEDIUM] [E-commerce]
-- For each product_category, compute the percentage of orders that were 'Cancelled'
-- using conditional SUM divided by COUNT.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q18 [MEDIUM] [Banking]
-- For each branch_id, compute the count of 'Savings' vs 'Current' accounts in one query
-- using two separate conditional SUMs.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q19 [MEDIUM] [Telecom]
-- For each plan_type, compute the churn rate: SUM(CASE WHEN status = 'Cancelled' THEN 1
-- ELSE 0 END) / COUNT(*).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q20 [MEDIUM] [Healthcare]
-- For each department (hospital dept), compute the count of 'Critical', 'Stable', and
-- 'Discharged' patients in one row per department using three conditional SUMs.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q21 [MEDIUM] [Retail Chain]
-- Compute avg_sale_value = total_sales / NULLIF(total_transactions, 0) per store, safely
-- handling stores with zero transactions.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q22 [MEDIUM] [Airline-style]
-- Compute on_time_rate = on_time_flights / NULLIF(total_flights, 0) per route.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q23 [MEDIUM] [Insurance]
-- Compute avg_claim_per_policy = SUM(claim_amount) / NULLIF(COUNT(DISTINCT policy_id),
-- 0).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q24 [MEDIUM] [Global E-commerce]
-- Use CASE WHEN inside ORDER BY to sort orders with status = 'Urgent' first, then by
-- order_date (custom sort priority pattern).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q25 [MEDIUM] [Uber-style]
-- Label trips as 'Short' (<5km), 'Medium' (5-20km), 'Long' (>20km) using CASE WHEN, then
-- COUNT trips per label.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q26 [MEDIUM] [School System]
-- Clean inconsistent city entries using TRIM(UPPER(city)) before grouping, and explain
-- what bug this fixes (splitting 'Delhi' and ' delhi ' into separate groups).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q27 [MEDIUM] [Streaming Service]
-- Standardize email addresses using LOWER(TRIM(email)) before checking for duplicates
-- (case/space-insensitive dedup).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q28 [MEDIUM] [Logistics]
-- Clean customer_name fields containing extra internal spaces (e.g., "John   Doe") -
-- describe the limitation of TRIM alone here (it only removes leading/trailing spaces,
-- not internal double-spaces) and what function would be needed instead (REGEXP_REPLACE,
-- previewed for a later day).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q29 [MEDIUM] [Manufacturing]
-- Use SUBSTRING to extract the year portion from a machine_code formatted as
-- MC-2024-001.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q30 [MEDIUM] [Banking]
-- Use CAST to safely convert an amount column stored as TEXT (with possible currency
-- symbols already stripped) into NUMERIC, and describe what happens if a row contains a
-- non-numeric string.
-- ---------------------------------------------------------------




-- ################################################################
-- HARD QUESTIONS
-- ################################################################

-- ---------------------------------------------------------------
-- Q31 [HARD] [Amazon-style]
-- Build a single-row summary report showing total_orders, delivered_pct, cancelled_pct,
-- and returned_pct, each computed via 100.0 * SUM(CASE WHEN status = 'X' THEN 1 ELSE 0
-- END) / COUNT(*).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q32 [HARD] [HR System]
-- For each department, compute both the count AND the average salary of employees above
-- the company-wide average salary, using conditional aggregation combined with a
-- subquery for the company average (conceptual - full solve needs subqueries, covered
-- later, but describe the CASE WHEN condition you'd use).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q33 [HARD] [Telecom]
-- Build a report showing subscriber counts broken down by BOTH plan_type (rows, via
-- GROUP BY) AND active/inactive status (columns, via conditional SUM) - a manual pivot
-- table using GROUP BY + CASE WHEN.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q34 [HARD] [Insurance]
-- Compute the fraud-flag rate per agent_id: percentage of claims marked
-- is_fraud_suspected = TRUE, but only include agents with at least 20 processed claims
-- (combine conditional SUM with HAVING COUNT(*) >= 20).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q35 [HARD] [Global E-commerce]
-- Compute, per seller_id, the percentage of orders that were 5-star rated vs 1-2 star
-- rated in the same query, using two separate conditional SUMs against the same COUNT
-- denominator.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q36 [HARD] [Retail Chain]
-- A profit_margin_pct = (revenue - cost) / NULLIF(revenue, 0) * 100 calculation is
-- returning unexpected NULLs for a subset of stores - explain the likely cause
-- (zero-revenue stores) and confirm this is the correct, intended behavior rather than a
-- bug.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q37 [HARD] [Streaming Service]
-- Compute retention_rate = renewed_subscriptions / NULLIF(expiring_subscriptions, 0) per
-- month, and explain what a NULL result means for a business stakeholder reading the
-- report (vs. a 0% result).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q38 [HARD] [Healthcare]
-- Write a query combining CASE WHEN, COALESCE, and CAST: label patients by age bracket
-- (CASE), using COALESCE(date_of_birth_computed_age, manually_entered_age) as the age
-- source (COALESCE), where the manually entered age is stored as TEXT and needs CAST(...
-- AS INTEGER).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q39 [HARD] [Uber-style]
-- Build a full trip summary label combining CONCAT and CASE WHEN: 'Trip #' || trip_id ||
-- ' - ' || CASE WHEN fare > 500 THEN 'Premium' ELSE 'Standard' END, and explain a
-- portability concern with using || vs CONCAT() across PostgreSQL/MySQL.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q40 [HARD] [Banking]
-- A report divides total_interest_paid / NULLIF(total_deposits, 0), but a data-entry bug
-- sometimes stores total_deposits as the literal string '0' (TEXT) instead of a NULL or
-- numeric 0. Explain why NULLIF alone won't catch this, and what CAST-related fix is
-- needed first.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q41 [HARD] [Global E-commerce]
-- Extract and standardize phone numbers stored inconsistently as '+91-9876543210',
-- '9876543210', '091 9876543210' into a clean 10-digit format using a combination of
-- REPLACE calls - describe your step-by-step approach (full regex-based solution
-- previewed for later days).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q42 [HARD] [Manufacturing]
-- Compute, per machine_type, the percentage of maintenance logs with status = 'Failed'
-- out of total logs, but exclude machine types with fewer than 10 total logs from the
-- report (avoid statistically noisy small-sample percentages) - combine conditional SUM,
-- COUNT, and HAVING.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q43 [HARD] [Telecom]
-- A report computing avg_revenue_per_user = SUM(revenue) / NULLIF(COUNT(DISTINCT
-- subscriber_id), 0) returns a suspiciously high value for one region. Walk through what
-- data issue (hint: think about NULL subscriber_id values and COUNT DISTINCT's
-- NULL-exclusion behavior) could cause this, referencing Day 4's COUNT(DISTINCT)
-- NULL-handling rule.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q44 [HARD] [Insurance]
-- Design a single query that labels each claim's risk tier using nested/multi-condition
-- CASE WHEN (combining claim_amount, days_since_policy_start, and claim_type), then
-- aggregates counts per tier - essentially building the classic 'risk scoring' report
-- pattern used in real insurance analytics.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q45 [HARD] [Retail Chain]
-- Explain, with a concrete broken example, why writing CASE WHEN salary > 50000 THEN
-- 'High' WHEN salary > 80000 THEN 'Very High' ELSE 'Low' END is a logic bug
-- (order-of-conditions mistake), and rewrite it correctly - tests whether "first match
-- wins" was truly internalized.
-- ---------------------------------------------------------------



