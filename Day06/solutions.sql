-- ============================================================
-- SQL Practice - Day 6 : ANSWER KEY
-- Matches questions.sql 1:1. Try questions.sql yourself first!
-- Explanations included wherever the logic is tricky: NULLIF vs
-- zero-division semantics, CAST's silent failure modes, ||  vs
-- CONCAT() portability, TRIM's limits, and the CASE WHEN
-- 'first match wins' ordering bug.
-- ============================================================


-- ################################################################
-- EASY QUESTIONS
-- ################################################################

-- Q1 [EASY] [HR System]
-- Write a CASE WHEN to label employees as 'Senior' if tenure_years >= 5, else 'Junior'.
SELECT employee_id, tenure_years,
  CASE WHEN tenure_years >= 5 THEN 'Senior' ELSE 'Junior' END AS seniority
FROM employees;


-- Q2 [EASY] [E-commerce]
-- Label orders as 'Large' if total_amount > 5000, else 'Small', using CASE WHEN.
SELECT order_id, total_amount,
  CASE WHEN total_amount > 5000 THEN 'Large' ELSE 'Small' END AS order_size
FROM orders;


-- Q3 [EASY] [Banking]
-- Label accounts as 'Premium' if balance > 100000, else 'Standard'.
SELECT account_id, balance,
  CASE WHEN balance > 100000 THEN 'Premium' ELSE 'Standard' END AS account_tier
FROM accounts;


-- Q4 [EASY] [Airline-style]
-- Label flights as 'Delayed' if delay_minutes > 0, else 'On Time'.
SELECT flight_id, delay_minutes,
  CASE WHEN delay_minutes > 0 THEN 'Delayed' ELSE 'On Time' END AS flight_status
FROM flights;


-- Q5 [EASY] [School System]
-- Convert numeric marks into letter grades using CASE WHEN (90+='A', 75+='B', 60+='C', else 'D').
SELECT student_id, marks,
  CASE
    WHEN marks >= 90 THEN 'A'
    WHEN marks >= 75 THEN 'B'
    WHEN marks >= 60 THEN 'C'
    ELSE 'D'
  END AS letter_grade
FROM students;


-- Q6 [EASY] [Healthcare]
-- Use COALESCE(alternate_phone, primary_phone, 'No Contact') to get a display contact number.
SELECT patient_id, COALESCE(alternate_phone, primary_phone, 'No Contact') AS display_contact
FROM patients;


-- Q7 [EASY] [Retail Chain]
-- Use COALESCE(discount, 0) so NULL discounts display as 0 in a report.
SELECT product_id, COALESCE(discount, 0) AS discount
FROM products;


-- Q8 [EASY] [Telecom]
-- Cast a signup_date stored as TEXT into a proper DATE using CAST.
SELECT subscriber_id, CAST(signup_date AS DATE) AS signup_date_typed
FROM subscribers;
-- Explanation:
-- SQLite has no dedicated DATE storage class (it uses dynamic typing), so
-- CAST(... AS DATE) here mostly documents intent - the value is still stored
-- as TEXT underneath. In PostgreSQL/MySQL, CAST(... AS DATE) genuinely
-- converts to a native date type with real date arithmetic support.


-- Q9 [EASY] [Insurance]
-- Cast policy_number (INTEGER) to TEXT to concatenate it into a formatted string.
SELECT policy_id, 'POL-' || CAST(policy_number AS TEXT) AS formatted_policy_number
FROM policies;


-- Q10 [EASY] [Streaming Service]
-- Use UPPER(plan_name) to standardize plan name casing in a report.
SELECT user_id, UPPER(plan_name) AS plan_name_upper
FROM subscriptions;


-- Q11 [EASY] [Uber-style]
-- Use TRIM(driver_name) to remove accidental leading/trailing spaces from names.
SELECT driver_id, TRIM(driver_name) AS clean_name
FROM drivers;


-- Q12 [EASY] [Zomato-style]
-- Use CONCAT(first_name, ' ', last_name) to build a full_name column.
-- SQLite (no CONCAT() in older versions) - use the || operator:
SELECT customer_id, first_name || ' ' || last_name AS full_name
FROM customers;
-- PostgreSQL / MySQL: SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM customers;


-- Q13 [EASY] [Global E-commerce]
-- Use LENGTH(product_description) to flag products with descriptions under 20 characters.
SELECT product_id, product_description, LENGTH(product_description) AS desc_length,
  CASE WHEN LENGTH(product_description) < 20 THEN 1 ELSE 0 END AS is_too_short
FROM products;


-- Q14 [EASY] [Logistics]
-- Use LEFT(tracking_id, 3) to extract the courier code prefix.
-- SQLite has no LEFT() - use SUBSTR(string, start, length):
SELECT shipment_id, tracking_id, SUBSTR(tracking_id, 1, 3) AS courier_code
FROM shipments;
-- PostgreSQL / MySQL: SELECT LEFT(tracking_id, 3) AS courier_code FROM shipments;


-- Q15 [EASY] [Manufacturing]
-- Use REPLACE(machine_code, '-', '') to remove hyphens from a machine code.
SELECT machine_id, machine_code, REPLACE(machine_code, '-', '') AS clean_code
FROM machines;


-- ################################################################
-- MEDIUM QUESTIONS
-- ################################################################

-- Q16 [MEDIUM] [HR System]
-- For each department, compute total_employees and the count of employees earning > 80000 (SUM(CASE WHEN salary > 80000 THEN 1 ELSE 0 END)).
SELECT department,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN salary > 80000 THEN 1 ELSE 0 END) AS high_earners
FROM employees
GROUP BY department;


-- Q17 [MEDIUM] [E-commerce]
-- For each product_category, compute the percentage of orders that were 'Cancelled' using conditional SUM divided by COUNT.
SELECT product_category,
  100.0 * SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*) AS cancelled_pct
FROM orders
GROUP BY product_category;


-- Q18 [MEDIUM] [Banking]
-- For each branch_id, compute the count of 'Savings' vs 'Current' accounts in one query using two separate conditional SUMs.
SELECT branch_id,
  SUM(CASE WHEN account_type = 'Savings' THEN 1 ELSE 0 END) AS savings_count,
  SUM(CASE WHEN account_type = 'Current' THEN 1 ELSE 0 END) AS current_count
FROM accounts
GROUP BY branch_id;


-- Q19 [MEDIUM] [Telecom]
-- For each plan_type, compute the churn rate: SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*).
SELECT plan_type,
  1.0 * SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*) AS churn_rate
FROM subscribers
GROUP BY plan_type;


-- Q20 [MEDIUM] [Healthcare]
-- For each department (hospital dept), compute the count of 'Critical', 'Stable', and 'Discharged' patients in one row per department using three conditional SUMs.
SELECT department,
  SUM(CASE WHEN patient_status = 'Critical' THEN 1 ELSE 0 END) AS critical_count,
  SUM(CASE WHEN patient_status = 'Stable' THEN 1 ELSE 0 END) AS stable_count,
  SUM(CASE WHEN patient_status = 'Discharged' THEN 1 ELSE 0 END) AS discharged_count
FROM patients
GROUP BY department;


-- Q21 [MEDIUM] [Retail Chain]
-- Compute avg_sale_value = total_sales / NULLIF(total_transactions, 0) per store, safely handling stores with zero transactions.
SELECT store_id, total_sales, total_transactions,
  1.0 * total_sales / NULLIF(total_transactions, 0) AS avg_sale_value
FROM stores;


-- Q22 [MEDIUM] [Airline-style]
-- Compute on_time_rate = on_time_flights / NULLIF(total_flights, 0) per route.
SELECT route, on_time_flights, total_flights,
  1.0 * on_time_flights / NULLIF(total_flights, 0) AS on_time_rate
FROM routes;


-- Q23 [MEDIUM] [Insurance]
-- Compute avg_claim_per_policy = SUM(claim_amount) / NULLIF(COUNT(DISTINCT policy_id), 0).
SELECT 1.0 * SUM(claim_amount) / NULLIF(COUNT(DISTINCT policy_id), 0) AS avg_claim_per_policy
FROM claims;


-- Q24 [MEDIUM] [Global E-commerce]
-- Use CASE WHEN inside ORDER BY to sort orders with status = 'Urgent' first, then by order_date (custom sort priority pattern).
SELECT * FROM orders_global
ORDER BY CASE WHEN status = 'Urgent' THEN 0 ELSE 1 END, order_date;


-- Q25 [MEDIUM] [Uber-style]
-- Label trips as 'Short' (<5km), 'Medium' (5-20km), 'Long' (>20km) using CASE WHEN, then COUNT trips per label.
SELECT
  CASE
    WHEN distance_km < 5 THEN 'Short'
    WHEN distance_km <= 20 THEN 'Medium'
    ELSE 'Long'
  END AS trip_label,
  COUNT(*) AS trip_count
FROM trips
GROUP BY trip_label;


-- Q26 [MEDIUM] [School System]
-- Clean inconsistent city entries using TRIM(UPPER(city)) before grouping, and explain what bug this fixes (splitting 'Delhi' and ' delhi ' into separate groups).
SELECT TRIM(UPPER(city)) AS clean_city, COUNT(*) AS student_count
FROM students
GROUP BY TRIM(UPPER(city));
-- Explanation:
-- Without normalizing first, 'Delhi', ' delhi ', and 'DELHI' would each
-- form their OWN separate GROUP BY bucket, even though they clearly represent
-- the same city - fragmenting what should be one group into several and
-- under-counting each one. TRIM(UPPER(city)) collapses casing and stray
-- whitespace differences into a single canonical form before grouping.


-- Q27 [MEDIUM] [Streaming Service]
-- Standardize email addresses using LOWER(TRIM(email)) before checking for duplicates (case/space-insensitive dedup).
SELECT LOWER(TRIM(email)) AS clean_email, COUNT(*) AS occurrences
FROM users
GROUP BY LOWER(TRIM(email))
HAVING COUNT(*) > 1;


-- Q28 [MEDIUM] [Logistics]
-- Clean customer_name fields containing extra internal spaces (e.g., "John   Doe") - describe the limitation of TRIM alone here (it only removes leading/trailing spaces, not internal double-spaces) and what function would be needed instead (REGEXP_REPLACE, previewed for a later day).
SELECT customer_name, TRIM(customer_name) AS trimmed_name
FROM shipments;
-- Explanation:
-- TRIM() only strips whitespace from the very START and END of a string -
-- it never looks at what's happening in the MIDDLE. 'John   Doe' (with three
-- internal spaces) comes out of TRIM() completely unchanged in the middle,
-- still 'John   Doe' - TRIM has nothing to trim there since neither end has
-- leading/trailing whitespace. Collapsing repeated INTERNAL spaces down to a
-- single space requires a regex-capable function like
-- REGEXP_REPLACE(name, '\s+', ' ', 'g') (PostgreSQL) - a tool introduced
-- properly on a later, regex-focused day.


-- Q29 [MEDIUM] [Manufacturing]
-- Use SUBSTRING to extract the year portion from a machine_code formatted as MC-2024-001.
-- SQLite: SUBSTR(string, start_position, length)
SELECT machine_id, machine_code, SUBSTR(machine_code, 4, 4) AS code_year
FROM machines;
-- PostgreSQL / MySQL: SUBSTRING(machine_code, 4, 4)


-- Q30 [MEDIUM] [Banking]
-- Use CAST to safely convert an amount column stored as TEXT (with possible currency symbols already stripped) into NUMERIC, and describe what happens if a row contains a non-numeric string.
SELECT id, amount_text, CAST(amount_text AS NUMERIC) AS amount_numeric
FROM raw_amounts;
-- Explanation:
-- SQLite's CAST is very permissive: CAST('N/A' AS NUMERIC) silently
-- returns 0 rather than raising an error - it simply finds no leading numeric
-- characters to parse and gives up quietly, producing a plausible-looking but
-- completely wrong '0' instead of flagging the row as bad data. Stricter
-- engines like PostgreSQL raise an explicit error on an unparseable CAST
-- instead, which is actually the SAFER behavior since it surfaces the
-- data-quality problem immediately rather than masking it with a silent zero.


-- ################################################################
-- HARD QUESTIONS
-- ################################################################

-- Q31 [HARD] [Amazon-style]
-- Build a single-row summary report showing total_orders, delivered_pct, cancelled_pct, and returned_pct, each computed via 100.0 * SUM(CASE WHEN status = 'X' THEN 1 ELSE 0 END) / COUNT(*).
SELECT
  COUNT(*) AS total_orders,
  100.0 * SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) / COUNT(*) AS delivered_pct,
  100.0 * SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*) AS cancelled_pct,
  100.0 * SUM(CASE WHEN status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*) AS returned_pct
FROM orders_amazon;


-- Q32 [HARD] [HR System]
-- For each department, compute both the count AND the average salary of employees above the company-wide average salary, using conditional aggregation combined with a subquery for the company average (conceptual - full solve needs subqueries, covered later, but describe the CASE WHEN condition you'd use).
SELECT department,
  SUM(CASE WHEN salary > (SELECT AVG(salary) FROM employees) THEN 1 ELSE 0 END) AS above_avg_count,
  AVG(CASE WHEN salary > (SELECT AVG(salary) FROM employees) THEN salary END) AS above_avg_avg_salary
FROM employees
GROUP BY department;
-- Explanation:
-- The CASE WHEN condition compares each employee's salary against a
-- scalar subquery computing the COMPANY-WIDE average (not the department
-- average) - that subquery re-runs once per row here since it's repeated
-- twice in the SELECT list, which is wasteful; a CTE computing the company
-- average ONCE and reusing it would avoid the duplicate work, a pattern
-- covered in a later, CTE-focused day. Note AVG(CASE WHEN ... THEN salary END)
-- with no ELSE deliberately leaves non-matching rows as NULL, which AVG()
-- correctly ignores - unlike SUM's CASE pattern which needs an explicit
-- ELSE 0 to count correctly.


-- Q33 [HARD] [Telecom]
-- Build a report showing subscriber counts broken down by BOTH plan_type (rows, via GROUP BY) AND active/inactive status (columns, via conditional SUM) - a manual pivot table using GROUP BY + CASE WHEN.
SELECT plan_type,
  SUM(CASE WHEN status = 'Active' THEN 1 ELSE 0 END) AS active_count,
  SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_count
FROM subscribers
GROUP BY plan_type;


-- Q34 [HARD] [Insurance]
-- Compute the fraud-flag rate per agent_id: percentage of claims marked is_fraud_suspected = TRUE, but only include agents with at least 20 processed claims (combine conditional SUM with HAVING COUNT(*) >= 20).
SELECT agent_id,
  COUNT(*) AS total_claims,
  100.0 * SUM(CASE WHEN is_fraud_suspected = 1 THEN 1 ELSE 0 END) / COUNT(*) AS fraud_rate_pct
FROM claims
GROUP BY agent_id
HAVING COUNT(*) >= 20;


-- Q35 [HARD] [Global E-commerce]
-- Compute, per seller_id, the percentage of orders that were 5-star rated vs 1-2 star rated in the same query, using two separate conditional SUMs against the same COUNT denominator.
SELECT seller_id,
  100.0 * SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) / COUNT(*) AS five_star_pct,
  100.0 * SUM(CASE WHEN rating IN (1,2) THEN 1 ELSE 0 END) / COUNT(*) AS low_star_pct
FROM seller_orders
GROUP BY seller_id;


-- Q36 [HARD] [Retail Chain]
-- A profit_margin_pct = (revenue - cost) / NULLIF(revenue, 0) * 100 calculation is returning unexpected NULLs for a subset of stores - explain the likely cause (zero-revenue stores) and confirm this is the correct, intended behavior rather than a bug.
SELECT store_id, revenue, cost,
  (revenue - cost) * 1.0 / NULLIF(revenue, 0) * 100 AS profit_margin_pct
FROM stores;
-- Explanation:
-- A NULL here means the store had ZERO revenue (see store 103) - dividing
-- by zero is mathematically undefined, not zero, so NULLIF converting that
-- zero denominator into a NULL and letting it propagate is the CORRECT,
-- intended behavior, not a bug. Showing 0% or some other placeholder instead
-- would misleadingly suggest 'this store broke even' when the real story is
-- 'this store had no revenue at all to compute a margin against' - a very
-- different business situation that a stakeholder needs to see distinctly.


-- Q37 [HARD] [Streaming Service]
-- Compute retention_rate = renewed_subscriptions / NULLIF(expiring_subscriptions, 0) per month, and explain what a NULL result means for a business stakeholder reading the report (vs. a 0% result).
SELECT month, renewed_subscriptions, expiring_subscriptions,
  1.0 * renewed_subscriptions / NULLIF(expiring_subscriptions, 0) AS retention_rate
FROM monthly_retention;
-- Explanation:
-- A NULL retention_rate (see 2026-07, with zero expiring_subscriptions)
-- means 'there was nothing to retain that month' - a neutral, unremarkable
-- situation. A genuine 0% rate would mean the OPPOSITE: subscriptions WERE
-- expiring that month, but literally none of them renewed - a serious churn
-- alarm. Treating both cases the same (e.g. by defaulting the NULL to 0 in a
-- dashboard) would falsely flag a quiet month as a retention crisis.


-- Q38 [HARD] [Healthcare]
-- Write a query combining CASE WHEN, COALESCE, and CAST: label patients by age bracket (CASE), using COALESCE(date_of_birth_computed_age, manually_entered_age) as the age source (COALESCE), where the manually entered age is stored as TEXT and needs CAST(... AS INTEGER).
SELECT patient_id,
  COALESCE(computed_age, CAST(manual_age_text AS INTEGER)) AS age,
  CASE
    WHEN COALESCE(computed_age, CAST(manual_age_text AS INTEGER)) < 18 THEN 'Minor'
    WHEN COALESCE(computed_age, CAST(manual_age_text AS INTEGER)) < 60 THEN 'Adult'
    ELSE 'Senior'
  END AS age_bracket
FROM patients;


-- Q39 [HARD] [Uber-style]
-- Build a full trip summary label combining CONCAT and CASE WHEN: 'Trip #' || trip_id || ' - ' || CASE WHEN fare > 500 THEN 'Premium' ELSE 'Standard' END, and explain a portability concern with using || vs CONCAT() across PostgreSQL/MySQL.
SELECT 'Trip #' || trip_id || ' - ' ||
  CASE WHEN fare > 500 THEN 'Premium' ELSE 'Standard' END AS trip_summary
FROM trips;
-- Explanation:
-- || is the ANSI-SQL standard string concatenation operator and works as
-- expected in PostgreSQL, SQLite, and Oracle - but in MySQL, || means LOGICAL
-- OR by default (unless the non-default PIPES_AS_CONCAT sql_mode is enabled),
-- so this exact same query would silently mean something completely
-- different - or simply error - on a default MySQL setup. CONCAT(a, b, c) is
-- the portable, function-call alternative that behaves consistently across
-- MySQL and PostgreSQL (SQLite only gained a CONCAT() function in fairly
-- recent releases, so || remains the more universally-supported choice there).


-- Q40 [HARD] [Banking]
-- A report divides total_interest_paid / NULLIF(total_deposits, 0), but a data-entry bug sometimes stores total_deposits as the literal string '0' (TEXT) instead of a NULL or numeric 0. Explain why NULLIF alone won't catch this, and what CAST-related fix is needed first.
-- BUGGY (compares a TEXT column value against an INTEGER literal):
-- SELECT total_interest_paid / NULLIF(total_deposits_text, 0) FROM deposits;

-- FIXED - cast to numeric FIRST, then apply NULLIF:
SELECT branch_id, total_interest_paid, total_deposits_text,
  1.0 * total_interest_paid / NULLIF(CAST(total_deposits_text AS NUMERIC), 0) AS interest_rate
FROM deposits;
-- Explanation:
-- NULLIF(a, b) only fires when a and b are EQUAL. Comparing the TEXT
-- string '0' against the INTEGER literal 0 does not reliably behave like
-- comparing two numbers - depending on the engine's type-comparison and
-- affinity rules, a TEXT value and a numeric literal can be judged 'not
-- equal' even when a human would obviously consider them the same value, so
-- NULLIF silently fails to trigger and the query proceeds to divide by
-- what's effectively zero. The fix is to CAST the column to a genuine numeric
-- type FIRST (CAST(total_deposits_text AS NUMERIC)), and only THEN wrap the
-- result in NULLIF(..., 0), so the equality check compares two values that
-- are unambiguously numeric.


-- Q41 [HARD] [Global E-commerce]
-- Extract and standardize phone numbers stored inconsistently as '+91-9876543210', '9876543210', '091 9876543210' into a clean 10-digit format using a combination of REPLACE calls - describe your step-by-step approach (full regex-based solution previewed for later days).
SELECT seller_id, phone,
  REPLACE(REPLACE(REPLACE(phone, '+91-', ''), ' ', ''), '091', '') AS cleaned_phone
FROM sellers_contact;
-- Explanation:
-- Step by step: (1) strip the '+91-' prefix variant, (2) strip any spaces
-- (handles the '091 9876543210' format once the leading '091' word boundary
-- issue is addressed), (3) strip a leading '091' variant. The real limitation:
-- this chain only handles the SPECIFIC formats you've explicitly anticipated -
-- any new inconsistent variant that shows up later (e.g. '(+91) 98765-43210')
-- silently breaks it, and every new format discovered means adding yet another
-- nested REPLACE call. A regex-based extraction ('grab the last 10 digits,
-- discard everything else') generalizes far better and is covered properly on
-- a later, regex-focused day.


-- Q42 [HARD] [Manufacturing]
-- Compute, per machine_type, the percentage of maintenance logs with status = 'Failed' out of total logs, but exclude machine types with fewer than 10 total logs from the report (avoid statistically noisy small-sample percentages) - combine conditional SUM, COUNT, and HAVING.
SELECT machine_type,
  COUNT(*) AS total_logs,
  100.0 * SUM(CASE WHEN status = 'Failed' THEN 1 ELSE 0 END) / COUNT(*) AS failure_pct
FROM maintenance_logs
GROUP BY machine_type
HAVING COUNT(*) >= 10;


-- Q43 [HARD] [Telecom]
-- A report computing avg_revenue_per_user = SUM(revenue) / NULLIF(COUNT(DISTINCT subscriber_id), 0) returns a suspiciously high value for one region. Walk through what data issue (hint: think about NULL subscriber_id values and COUNT DISTINCT's NULL-exclusion behavior) could cause this, referencing Day 4's COUNT(DISTINCT) NULL-handling rule.
SELECT region,
  SUM(revenue) AS total_revenue,
  COUNT(DISTINCT subscriber_id) AS distinct_subscribers,
  1.0 * SUM(revenue) / NULLIF(COUNT(DISTINCT subscriber_id), 0) AS avg_revenue_per_user
FROM revenue_records
GROUP BY region;
-- Explanation:
-- COUNT(DISTINCT subscriber_id) NEVER counts NULL values (the same rule
-- covered on Day 4) - so if a region has several revenue rows with a missing
-- / unassigned subscriber_id (e.g. anonymous purchases or unlinked billing
-- records, as in this dataset's 'South' region), that revenue still gets
-- included in the SUM(revenue) numerator, but the corresponding rows are
-- silently excluded from the COUNT(DISTINCT subscriber_id) denominator. The
-- result: dividing a full (or inflated) numerator by an undercounted
-- denominator produces an artificially, suspiciously high average-revenue-
-- per-user figure.


-- Q44 [HARD] [Insurance]
-- Design a single query that labels each claim's risk tier using nested/multi-condition CASE WHEN (combining claim_amount, days_since_policy_start, and claim_type), then aggregates counts per tier - essentially building the classic 'risk scoring' report pattern used in real insurance analytics.
SELECT
  CASE
    WHEN claim_type = 'Fraudulent' THEN 'Critical'
    WHEN claim_amount > 100000 AND days_since_policy_start < 30 THEN 'High'
    WHEN claim_amount > 50000 THEN 'Medium'
    ELSE 'Low'
  END AS risk_tier,
  COUNT(*) AS claim_count
FROM claims
GROUP BY risk_tier;


-- Q45 [HARD] [Retail Chain]
-- Explain, with a concrete broken example, why writing CASE WHEN salary > 50000 THEN 'High' WHEN salary > 80000 THEN 'Very High' ELSE 'Low' END is a logic bug (order-of-conditions mistake), and rewrite it correctly - tests whether "first match wins" was truly internalized.
-- BROKEN (order-of-conditions bug):
-- CASE WHEN salary > 50000 THEN 'High' WHEN salary > 80000 THEN 'Very High' ELSE 'Low' END

-- FIXED - most restrictive condition checked FIRST:
SELECT employee_id, salary,
  CASE
    WHEN salary > 80000 THEN 'Very High'
    WHEN salary > 50000 THEN 'High'
    ELSE 'Low'
  END AS salary_band
FROM employees;
-- Explanation:
-- CASE WHEN evaluates its conditions top-to-bottom and stops at the FIRST
-- match - 'first match wins'. In the broken version, ANY salary above 80000
-- is also, trivially, above 50000 - so the first condition (salary > 50000)
-- always catches those rows first and returns 'High', and the second
-- condition (salary > 80000) becomes dead code that can NEVER fire, no matter
-- how high the salary is. The fix is to order conditions from MOST specific/
-- restrictive to LEAST specific, so a narrower condition gets its chance to
-- match before a broader condition that would otherwise swallow it.

