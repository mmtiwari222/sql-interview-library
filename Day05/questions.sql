-- ============================================================
-- SQL Practice - Day 5 : NULL Handling, BETWEEN/IN/LIKE,
-- Safe Date Ranges, the NOT IN Trap, and NOT EXISTS
-- 45 questions across Easy / Medium / Hard, spanning 15+ domains
-- (Amazon, HR, E-commerce, Banking, Telecom, Airline, Healthcare,
-- Uber, Insurance, Logistics, Manufacturing, and more)
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
-- Find all employees where manager_id IS NULL (top-level employees).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q2 [EASY] [E-commerce]
-- Find all orders where shipped_date IS NULL (not yet shipped).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q3 [EASY] [Healthcare]
-- Find all patients where phone_number IS NULL.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q4 [EASY] [Banking]
-- Find all accounts where nominee_name IS NULL (no nominee registered).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q5 [EASY] [Telecom]
-- Find subscribers where alternate_number IS NOT NULL.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q6 [EASY] [Retail Chain]
-- Find products where price BETWEEN 100 AND 500.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q7 [EASY] [Airline-style]
-- Find flights where origin IN ('DEL', 'BOM', 'BLR').
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q8 [EASY] [School System]
-- Find students where grade NOT IN ('F', 'D').
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q9 [EASY] [Uber-style]
-- Find trips where fare BETWEEN 100 AND 300.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q10 [EASY] [Insurance]
-- Find policies where policy_type IN ('Health', 'Life').
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q11 [EASY] [Zomato-style]
-- Find restaurants where name LIKE 'The%'.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q12 [EASY] [Streaming Service]
-- Find users whose email LIKE '%@gmail.com'.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q13 [EASY] [Logistics]
-- Find shipments where tracking_id LIKE 'IND_' (find literal pattern, 4-char code
-- starting with IND).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q14 [EASY] [Global E-commerce]
-- Find sellers whose store_name ILIKE 'mega%' (case-insensitive, PostgreSQL).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q15 [EASY] [Manufacturing]
-- Find machines where status NOT IN ('Retired', 'Scrapped').
-- ---------------------------------------------------------------




-- ################################################################
-- MEDIUM QUESTIONS
-- ################################################################

-- ---------------------------------------------------------------
-- Q16 [MEDIUM] [HR System]
-- Find employees with incomplete profiles: phone_number IS NULL OR emergency_contact IS
-- NULL.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q17 [MEDIUM] [E-commerce]
-- Find orders that are stuck: shipped_date IS NULL AND order_date < '2026-07-01' (placed
-- long ago but never shipped).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q18 [MEDIUM] [Banking]
-- Find accounts missing KYC: pan_number IS NULL OR aadhaar_number IS NULL.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q19 [MEDIUM] [Retail Chain]
-- Find products priced NOT BETWEEN 100 AND 1000 (outside the typical range - outlier
-- check).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q20 [MEDIUM] [Airline-style]
-- Find bookings where seat_class IN ('Business', 'First') AND fare BETWEEN 20000 AND
-- 100000.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q21 [MEDIUM] [Telecom]
-- Segment subscribers by email provider: find those with email LIKE '%@yahoo.com' vs
-- email LIKE '%@gmail.com' (write both).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q22 [MEDIUM] [Global E-commerce]
-- Find sellers whose store_name LIKE '%Official%' (verified/official store detection
-- pattern).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q23 [MEDIUM] [Healthcare]
-- Find patients whose insurance_provider ILIKE '%star%' (case-insensitive partial
-- match).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q24 [MEDIUM] [Insurance]
-- Find claims where claim_type NOT IN ('Fraudulent', 'Rejected', 'Withdrawn')
-- (legitimate active claims only).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q25 [MEDIUM] [Uber-style]
-- Find trips where pickup_city IN ('Delhi', 'Gurugram', 'Noida') AND fare NOT BETWEEN 0
-- AND 50 (excludes suspiciously low fares).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q26 [MEDIUM] [Logistics]
-- Find shipments dispatched in January 2026 using the SAFE pattern (dispatch_date >=
-- '2026-01-01' AND dispatch_date < '2026-02-01') instead of BETWEEN on a TIMESTAMP
-- column - explain why.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q27 [MEDIUM] [Banking]
-- Find transactions on a TIMESTAMP column for exactly one calendar day (e.g.,
-- 2026-08-07) - write the safe version and explain what would go wrong with plain
-- BETWEEN '2026-08-07' AND '2026-08-07'.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q28 [MEDIUM] [Streaming Service]
-- Find users who signed up in Q1 2026 (Jan-Mar) using safe range filtering on a
-- TIMESTAMP signup_date.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q29 [MEDIUM] [School System]
-- Find students whose roll_number LIKE '10__' (exactly a 4-character code starting with
-- "10").
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q30 [MEDIUM] [Manufacturing]
-- Find machines needing review: last_service_date IS NULL OR status NOT IN
-- ('Operational', 'Under Maintenance').
-- ---------------------------------------------------------------




-- ################################################################
-- HARD QUESTIONS
-- ################################################################

-- ---------------------------------------------------------------
-- Q31 [HARD] [Amazon-style]
-- You run: SELECT * FROM customers WHERE customer_id NOT IN (SELECT customer_id FROM
-- orders); and get zero rows, even though you know some customers have never ordered.
-- Diagnose the likely cause and rewrite the query safely.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q32 [HARD] [HR System]
-- Find employees not assigned to any active project, where the project-assignment table
-- might contain NULL employee_id values (e.g., unassigned placeholder rows). Write the
-- safe query using NOT EXISTS.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q33 [HARD] [Banking]
-- Find accounts with no linked nominee using a nominees table, being careful that
-- nominees.account_id may contain NULLs from bad historical data - write both the buggy
-- NOT IN version and the safe fix.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q34 [HARD] [Telecom]
-- Explain (in words, with a small example) why WHERE plan_id NOT IN (SELECT plan_id FROM
-- discontinued_plans) could incorrectly return zero rows for the entire table, and what
-- single row in discontinued_plans would cause it.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q35 [HARD] [E-commerce]
-- Find products that have never appeared in a return (returns table), safely handling
-- potential NULL product_id values in returns.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q36 [HARD] [Airline-style]
-- A report using WHERE booking_time BETWEEN '2026-08-01' AND '2026-08-31' on a TIMESTAMP
-- column is under-reporting bookings made late on August 31st. Explain exactly why, and
-- rewrite the query correctly.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q37 [HARD] [Healthcare]
-- An appointment reminder system using BETWEEN on a TIMESTAMP appointment_datetime
-- column is missing evening appointments on the range's last day. Diagnose and fix.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q38 [HARD] [Insurance]
-- A monthly claims report computed via BETWEEN on claim_timestamp under-counts claims
-- filed after business hours on the last day of the month. Rewrite using the safe
-- half-open range pattern, and explain why < next_month_start is preferred over <=
-- last_day 23:59:59.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q39 [HARD] [Retail Chain]
-- Find products where the sku matches a specific format: starts with 2 letters, followed
-- by exactly 4 digits (e.g., AB1234) - write the LIKE pattern using _ wildcards, and
-- discuss a limitation of LIKE here compared to regex (~ in PostgreSQL).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q40 [HARD] [Global E-commerce]
-- Find sellers whose store_name contains an underscore character literally (not as a
-- wildcard) - write the LIKE ... ESCAPE query.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q41 [HARD] [Streaming Service]
-- A query using WHERE email LIKE '%@company.com' is running very slowly on a
-- 50-million-row users table despite an index on email. Explain why the index isn't
-- helping, and describe an alternative approach (e.g., a computed/generated domain
-- column with its own index).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q42 [HARD] [Uber-style]
-- Find trips where fare NOT BETWEEN (SELECT AVG(fare) - 50 FROM trips) AND (SELECT
-- AVG(fare) + 50 FROM trips) - explain conceptually what this identifies (outlier fares
-- far from the average) and any risk of using two separate subqueries here
-- (recomputation cost - foreshadowing CTEs, covered later).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q43 [HARD] [Manufacturing]
-- Find machines where status IN ('Faulty', 'Under Repair') OR (last_service_date IS NULL
-- AND installation_date < '2024-01-01') - combine IN, IS NULL, and a date filter in one
-- realistic maintenance-prioritization query.
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q44 [HARD] [Banking]
-- Design a safe query to find all transactions in the last complete calendar month (not
-- last 30 days) on a TIMESTAMP column, without hardcoding month boundaries as string
-- literals (conceptual: describe the safe pattern using date functions, which are
-- covered in depth on a later day).
-- ---------------------------------------------------------------




-- ---------------------------------------------------------------
-- Q45 [HARD] [Global E-commerce]
-- Find customers whose country NOT IN (SELECT DISTINCT country FROM blocked_countries),
-- where blocked_countries.country might have inconsistent NULL entries from a bad data
-- import - write the safe version, and explain why this exact bug (silently returning
-- zero customers) is dangerous in a real business context (e.g., an entire marketing
-- campaign accidentally excluding everyone).
-- ---------------------------------------------------------------



