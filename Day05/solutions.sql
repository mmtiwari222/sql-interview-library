-- ============================================================
-- SQL Practice - Day 5 : ANSWER KEY
-- Matches questions.sql 1:1. Try questions.sql yourself first!
-- Explanations included wherever the logic is tricky: the NOT IN
-- + NULL trap, safe half-open date ranges, LIKE vs regex limits,
-- LIKE ESCAPE, and index behaviour with leading wildcards.
-- ============================================================


-- ################################################################
-- EASY QUESTIONS
-- ################################################################

-- Q1 [EASY] [HR System]
-- Find all employees where manager_id IS NULL (top-level employees).
SELECT * FROM employees WHERE manager_id IS NULL;


-- Q2 [EASY] [E-commerce]
-- Find all orders where shipped_date IS NULL (not yet shipped).
SELECT * FROM orders WHERE shipped_date IS NULL;


-- Q3 [EASY] [Healthcare]
-- Find all patients where phone_number IS NULL.
SELECT * FROM patients WHERE phone_number IS NULL;


-- Q4 [EASY] [Banking]
-- Find all accounts where nominee_name IS NULL (no nominee registered).
SELECT * FROM accounts WHERE nominee_name IS NULL;


-- Q5 [EASY] [Telecom]
-- Find subscribers where alternate_number IS NOT NULL.
SELECT * FROM subscribers WHERE alternate_number IS NOT NULL;


-- Q6 [EASY] [Retail Chain]
-- Find products where price BETWEEN 100 AND 500.
SELECT * FROM products WHERE price BETWEEN 100 AND 500;


-- Q7 [EASY] [Airline-style]
-- Find flights where origin IN ('DEL', 'BOM', 'BLR').
SELECT * FROM flights WHERE origin IN ('DEL','BOM','BLR');


-- Q8 [EASY] [School System]
-- Find students where grade NOT IN ('F', 'D').
SELECT * FROM students WHERE grade NOT IN ('F','D');


-- Q9 [EASY] [Uber-style]
-- Find trips where fare BETWEEN 100 AND 300.
SELECT * FROM trips WHERE fare BETWEEN 100 AND 300;


-- Q10 [EASY] [Insurance]
-- Find policies where policy_type IN ('Health', 'Life').
SELECT * FROM policies WHERE policy_type IN ('Health','Life');


-- Q11 [EASY] [Zomato-style]
-- Find restaurants where name LIKE 'The%'.
SELECT * FROM restaurants WHERE name LIKE 'The%';


-- Q12 [EASY] [Streaming Service]
-- Find users whose email LIKE '%@gmail.com'.
SELECT * FROM users WHERE email LIKE '%@gmail.com';


-- Q13 [EASY] [Logistics]
-- Find shipments where tracking_id LIKE 'IND_' (find literal pattern, 4-char code starting with IND).
SELECT * FROM shipments WHERE tracking_id LIKE 'IND_';


-- Q14 [EASY] [Global E-commerce]
-- Find sellers whose store_name ILIKE 'mega%' (case-insensitive, PostgreSQL).
-- PostgreSQL:
-- SELECT * FROM sellers WHERE store_name ILIKE 'mega%';

-- SQLite equivalent (LIKE is already case-insensitive for ASCII by default):
SELECT * FROM sellers WHERE store_name LIKE 'mega%';
-- Explanation:
-- PostgreSQL's LIKE is case-SENSITIVE by default, which is why ILIKE
-- exists as a separate case-insensitive operator there. SQLite's LIKE, by
-- contrast, is already case-insensitive for ASCII letters out of the box -
-- so the same result is achieved without a special operator, but the
-- behaviour is genuinely engine-specific and worth knowing explicitly.


-- Q15 [EASY] [Manufacturing]
-- Find machines where status NOT IN ('Retired', 'Scrapped').
SELECT * FROM machines WHERE status NOT IN ('Retired','Scrapped');


-- ################################################################
-- MEDIUM QUESTIONS
-- ################################################################

-- Q16 [MEDIUM] [HR System]
-- Find employees with incomplete profiles: phone_number IS NULL OR emergency_contact IS NULL.
SELECT * FROM employees WHERE phone_number IS NULL OR emergency_contact IS NULL;


-- Q17 [MEDIUM] [E-commerce]
-- Find orders that are stuck: shipped_date IS NULL AND order_date < '2026-07-01' (placed long ago but never shipped).
SELECT * FROM orders WHERE shipped_date IS NULL AND order_date < '2026-07-01';


-- Q18 [MEDIUM] [Banking]
-- Find accounts missing KYC: pan_number IS NULL OR aadhaar_number IS NULL.
SELECT * FROM accounts WHERE pan_number IS NULL OR aadhaar_number IS NULL;


-- Q19 [MEDIUM] [Retail Chain]
-- Find products priced NOT BETWEEN 100 AND 1000 (outside the typical range - outlier check).
SELECT * FROM products WHERE price NOT BETWEEN 100 AND 1000;


-- Q20 [MEDIUM] [Airline-style]
-- Find bookings where seat_class IN ('Business', 'First') AND fare BETWEEN 20000 AND 100000.
SELECT * FROM bookings WHERE seat_class IN ('Business','First') AND fare BETWEEN 20000 AND 100000;


-- Q21 [MEDIUM] [Telecom]
-- Segment subscribers by email provider: find those with email LIKE '%@yahoo.com' vs email LIKE '%@gmail.com' (write both).
-- Yahoo subscribers:
SELECT * FROM subscribers WHERE email LIKE '%@yahoo.com';

-- Gmail subscribers:
SELECT * FROM subscribers WHERE email LIKE '%@gmail.com';


-- Q22 [MEDIUM] [Global E-commerce]
-- Find sellers whose store_name LIKE '%Official%' (verified/official store detection pattern).
SELECT * FROM sellers WHERE store_name LIKE '%Official%';


-- Q23 [MEDIUM] [Healthcare]
-- Find patients whose insurance_provider ILIKE '%star%' (case-insensitive partial match).
-- PostgreSQL:
-- SELECT * FROM patients WHERE insurance_provider ILIKE '%star%';

-- SQLite (case-insensitive by default for ASCII):
SELECT * FROM patients WHERE insurance_provider LIKE '%star%';


-- Q24 [MEDIUM] [Insurance]
-- Find claims where claim_type NOT IN ('Fraudulent', 'Rejected', 'Withdrawn') (legitimate active claims only).
SELECT * FROM claims WHERE claim_type NOT IN ('Fraudulent','Rejected','Withdrawn');


-- Q25 [MEDIUM] [Uber-style]
-- Find trips where pickup_city IN ('Delhi', 'Gurugram', 'Noida') AND fare NOT BETWEEN 0 AND 50 (excludes suspiciously low fares).
SELECT * FROM trips WHERE pickup_city IN ('Delhi','Gurugram','Noida') AND fare NOT BETWEEN 0 AND 50;


-- Q26 [MEDIUM] [Logistics]
-- Find shipments dispatched in January 2026 using the SAFE pattern (dispatch_date >= '2026-01-01' AND dispatch_date < '2026-02-01') instead of BETWEEN on a TIMESTAMP column - explain why.
SELECT * FROM shipments
WHERE dispatch_date >= '2026-01-01' AND dispatch_date < '2026-02-01';
-- Explanation:
-- On a TIMESTAMP column, 'BETWEEN 2026-01-01 AND 2026-01-31' implicitly
-- compares against '2026-01-31 00:00:00' as the upper bound - so any
-- dispatch that happened after midnight on Jan 31 (e.g. '2026-01-31
-- 22:15:00', see shipment #2) would be silently EXCLUDED. The half-open
-- range ('>= start of month' AND '< start of NEXT month') has no such edge
-- case, because it doesn't rely on guessing the last possible instant of the
-- last day.


-- Q27 [MEDIUM] [Banking]
-- Find transactions on a TIMESTAMP column for exactly one calendar day (e.g., 2026-08-07) - write the safe version and explain what would go wrong with plain BETWEEN '2026-08-07' AND '2026-08-07'.
SELECT * FROM transactions
WHERE txn_timestamp >= '2026-08-07' AND txn_timestamp < '2026-08-08';
-- Explanation:
-- 'BETWEEN 2026-08-07 AND 2026-08-07' expands to txn_timestamp >=
-- '2026-08-07 00:00:00' AND txn_timestamp <= '2026-08-07 00:00:00' - which
-- only matches a transaction at EXACTLY midnight. Every other transaction
-- that happened later that day (10:30, 14:30, 23:30, etc.) would be silently
-- excluded, making it look like almost nothing happened that day.


-- Q28 [MEDIUM] [Streaming Service]
-- Find users who signed up in Q1 2026 (Jan-Mar) using safe range filtering on a TIMESTAMP signup_date.
SELECT * FROM users
WHERE signup_date >= '2026-01-01' AND signup_date < '2026-04-01';


-- Q29 [MEDIUM] [School System]
-- Find students whose roll_number LIKE '10__' (exactly a 4-character code starting with "10").
SELECT * FROM students WHERE roll_number LIKE '10__';
-- Explanation:
-- '10' fixes the first two characters literally, and each '_' consumes
-- exactly one more character - so the whole pattern only matches strings that
-- are EXACTLY 4 characters long and start with '10' (e.g. '1001' matches,
-- but '10045' - 5 characters - does not, even though it also starts with '10').


-- Q30 [MEDIUM] [Manufacturing]
-- Find machines needing review: last_service_date IS NULL OR status NOT IN ('Operational', 'Under Maintenance').
SELECT * FROM machines WHERE last_service_date IS NULL OR status NOT IN ('Operational','Under Maintenance');


-- ################################################################
-- HARD QUESTIONS
-- ################################################################

-- Q31 [HARD] [Amazon-style]
-- You run: SELECT * FROM customers WHERE customer_id NOT IN (SELECT customer_id FROM orders); and get zero rows, even though you know some customers have never ordered. Diagnose the likely cause and rewrite the query safely.
-- BUGGY (returns 0 rows if orders.customer_id contains even one NULL):
-- SELECT * FROM customers WHERE customer_id NOT IN (SELECT customer_id FROM orders);

-- SAFE FIX #1 - NOT EXISTS (recommended):
SELECT * FROM customers c
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id);

-- SAFE FIX #2 - filter the NULL out of the subquery explicitly:
-- SELECT * FROM customers
-- WHERE customer_id NOT IN (SELECT customer_id FROM orders WHERE customer_id IS NOT NULL);
-- Explanation:
-- NOT IN internally expands into a chain of <> comparisons ANDed
-- together (customer_id <> val1 AND customer_id <> val2 AND ...). If the
-- subquery returns even ONE NULL (here, the bad-data order row with a missing
-- customer_id), then customer_id <> NULL evaluates to UNKNOWN for every
-- customer - and one UNKNOWN in an AND chain makes the WHOLE expression
-- UNKNOWN, so no row ever passes, for the entire query, silently.


-- Q32 [HARD] [HR System]
-- Find employees not assigned to any active project, where the project-assignment table might contain NULL employee_id values (e.g., unassigned placeholder rows). Write the safe query using NOT EXISTS.
SELECT * FROM employees e
WHERE NOT EXISTS (
  SELECT 1 FROM project_assignments pa
  WHERE pa.employee_id = e.employee_id AND pa.is_active = 1
);
-- Explanation:
-- NOT EXISTS is immune to the NULL trap that breaks NOT IN, because it
-- checks row existence via a correlated equality test per employee rather
-- than building a flat IN-list that a stray NULL can silently poison - a
-- NULL employee_id in project_assignments simply never matches anyone's
-- e.employee_id and is harmlessly ignored.


-- Q33 [HARD] [Banking]
-- Find accounts with no linked nominee using a nominees table, being careful that nominees.account_id may contain NULLs from bad historical data - write both the buggy NOT IN version and the safe fix.
-- BUGGY:
-- SELECT * FROM accounts WHERE account_id NOT IN (SELECT account_id FROM nominees);

-- SAFE FIX:
SELECT * FROM accounts a
WHERE NOT EXISTS (SELECT 1 FROM nominees n WHERE n.account_id = a.account_id);


-- Q34 [HARD] [Telecom]
-- Explain (in words, with a small example) why WHERE plan_id NOT IN (SELECT plan_id FROM discontinued_plans) could incorrectly return zero rows for the entire table, and what single row in discontinued_plans would cause it.
-- The buggy pattern (illustrative only - do not run against production data):
-- SELECT * FROM telecom_plans WHERE plan_id NOT IN (SELECT plan_id FROM discontinued_plans);

-- Safe version:
SELECT * FROM telecom_plans p
WHERE NOT EXISTS (SELECT 1 FROM discontinued_plans d WHERE d.plan_id = p.plan_id);
-- Explanation:
-- A single row in discontinued_plans where plan_id IS NULL (e.g. an
-- incomplete migration record or a placeholder row inserted by mistake) is
-- enough to break the whole query. NOT IN expands to a chain of <>
-- comparisons against every value the subquery returns, including that NULL;
-- any comparison against NULL is UNKNOWN, and one UNKNOWN inside an AND chain
-- makes the entire condition UNKNOWN for every plan_id - so the query
-- returns zero rows even for plans that are obviously still active.


-- Q35 [HARD] [E-commerce]
-- Find products that have never appeared in a return (returns table), safely handling potential NULL product_id values in returns.
SELECT * FROM products p
WHERE NOT EXISTS (SELECT 1 FROM returns r WHERE r.product_id = p.product_id);


-- Q36 [HARD] [Airline-style]
-- A report using WHERE booking_time BETWEEN '2026-08-01' AND '2026-08-31' on a TIMESTAMP column is under-reporting bookings made late on August 31st. Explain exactly why, and rewrite the query correctly.
-- BUGGY:
-- SELECT * FROM bookings WHERE booking_time BETWEEN '2026-08-01' AND '2026-08-31';

-- FIXED:
SELECT * FROM bookings
WHERE booking_time >= '2026-08-01' AND booking_time < '2026-09-01';
-- Explanation:
-- The literal '2026-08-31' is implicitly treated as '2026-08-31
-- 00:00:00' when compared against a TIMESTAMP column, so any booking made
-- after midnight on the 31st (see booking #6 at 23:45:00) is greater than the
-- upper bound and gets excluded. The half-open range fixes this by using the
-- start of the NEXT month as an exclusive upper bound, which naturally covers
-- every timestamp on the last day regardless of the time of day.


-- Q37 [HARD] [Healthcare]
-- An appointment reminder system using BETWEEN on a TIMESTAMP appointment_datetime column is missing evening appointments on the range's last day. Diagnose and fix.
-- BUGGY:
-- SELECT * FROM appointments WHERE appointment_datetime BETWEEN '2026-08-01' AND '2026-08-31';

-- FIXED:
SELECT * FROM appointments
WHERE appointment_datetime >= '2026-08-01' AND appointment_datetime < '2026-09-01';
-- Explanation:
-- Same root cause as the airline booking bug: the literal upper-bound
-- date is treated as midnight, so any evening appointment on the last day
-- (see appointment #5 at 20:30:00 on Aug 31) falls after that implicit
-- midnight cutoff and is excluded from the BETWEEN range.


-- Q38 [HARD] [Insurance]
-- A monthly claims report computed via BETWEEN on claim_timestamp under-counts claims filed after business hours on the last day of the month. Rewrite using the safe half-open range pattern, and explain why < next_month_start is preferred over <= last_day 23:59:59.
SELECT * FROM claims
WHERE claim_timestamp >= '2026-08-01' AND claim_timestamp < '2026-09-01';
-- Explanation:
-- '<= 2026-08-31 23:59:59' looks like a safe upper bound, but it silently
-- breaks the moment the column stores sub-second precision - a claim at
-- '2026-08-31 23:59:59.842' (see claim #7 at 23:58:12, which is close to this
-- edge) is actually FINE here, but push the timestamp one second later with
-- fractional precision and it would be GREATER than '23:59:59' and get
-- excluded. Using '< start of next month' sidesteps the problem entirely,
-- since there's no maximum-precision value to guess correctly - it works
-- identically regardless of whether the column stores seconds, milliseconds,
-- or microseconds.


-- Q39 [HARD] [Retail Chain]
-- Find products where the sku matches a specific format: starts with 2 letters, followed by exactly 4 digits (e.g., AB1234) - write the LIKE pattern using _ wildcards, and discuss a limitation of LIKE here compared to regex (~ in PostgreSQL).
-- Best LIKE can do - checks LENGTH only, not character type:
SELECT * FROM products WHERE sku LIKE '______';  -- six underscores = exactly 6 characters

-- PostgreSQL regex - actually enforces the letters-then-digits format:
-- SELECT * FROM products WHERE sku ~ '^[A-Z]{2}[0-9]{4}$';
-- Explanation:
-- Standard SQL LIKE only supports two wildcards: '%' (any sequence of
-- characters) and '_' (exactly one character of ANY type). It has no concept
-- of character CLASSES - there is no way to say 'this position must be a
-- letter' or 'this position must be a digit' using LIKE alone. So
-- 'sku LIKE \'______\'' can only guarantee the SKU is exactly 6 characters
-- long; it would happily match '123456' or 'AAAAAA' just as much as the
-- intended 'AB1234' format. PostgreSQL's ~ operator (POSIX regex) or
-- SIMILAR TO can express real character classes and is the correct tool
-- when format validation actually matters.


-- Q40 [HARD] [Global E-commerce]
-- Find sellers whose store_name contains an underscore character literally (not as a wildcard) - write the LIKE ... ESCAPE query.
SELECT * FROM sellers WHERE store_name LIKE '%\_%' ESCAPE '\';
-- Explanation:
-- Without ESCAPE, '_' inside a LIKE pattern ALWAYS means 'match any one
-- character' - so '%_%' would match every single store name in the table
-- (since every non-empty string has at least one character), not
-- specifically ones containing a literal underscore. The ESCAPE clause
-- designates a chosen character (backslash here) as an escape prefix, so
-- '\\_' in the pattern means 'a literal underscore', overriding its usual
-- wildcard meaning just for that occurrence.


-- Q41 [HARD] [Streaming Service]
-- A query using WHERE email LIKE '%@company.com' is running very slowly on a 50-million-row users table despite an index on email. Explain why the index isn't helping, and describe an alternative approach (e.g., a computed/generated domain column with its own index).
-- Slow (leading wildcard defeats a standard B-tree index on email):
-- SELECT * FROM users WHERE email LIKE '%@company.com';

-- Faster alternative, once a generated/maintained domain column exists:
-- SELECT * FROM users WHERE domain = 'company.com';
-- Explanation:
-- A standard B-tree index is built on sorted PREFIXES of the indexed
-- value, so it can jump straight to rows starting with a given prefix (a
-- trailing wildcard like 'company%' can use the index) - but a LEADING
-- wildcard ('%@company.com') means the database has no prefix to anchor on,
-- so it must scan and check every single row, index or not. The practical
-- fix is to precompute and store just the domain portion of the email in its
-- own column (via a generated column, trigger, or application-side write) and
-- index THAT column - turning the filter into a fast equality/prefix lookup
-- instead of a full scan.


-- Q42 [HARD] [Uber-style]
-- Find trips where fare NOT BETWEEN (SELECT AVG(fare) - 50 FROM trips) AND (SELECT AVG(fare) + 50 FROM trips) - explain conceptually what this identifies (outlier fares far from the average) and any risk of using two separate subqueries here (recomputation cost - foreshadowing CTEs, covered later).
SELECT * FROM trips
WHERE fare NOT BETWEEN (SELECT AVG(fare) - 50 FROM trips) AND (SELECT AVG(fare) + 50 FROM trips);
-- Explanation:
-- This identifies 'outlier' trips - fares that sit more than 50 away from
-- the overall average fare in EITHER direction (unusually cheap or unusually
-- expensive). The risk: the database has no way to know both subqueries
-- compute the same underlying AVG(fare), so it re-scans and re-aggregates the
-- entire trips table TWICE, once per subquery - wasted work that grows with
-- table size. A CTE (WITH avg_fare AS (SELECT AVG(fare) AS a FROM trips) ...)
-- would compute the average once and reuse it for both bounds - a pattern
-- covered in a later, CTE-focused day.


-- Q43 [HARD] [Manufacturing]
-- Find machines where status IN ('Faulty', 'Under Repair') OR (last_service_date IS NULL AND installation_date < '2024-01-01') - combine IN, IS NULL, and a date filter in one realistic maintenance-prioritization query.
SELECT * FROM machines
WHERE status IN ('Faulty','Under Repair')
   OR (last_service_date IS NULL AND installation_date < '2024-01-01');


-- Q44 [HARD] [Banking]
-- Design a safe query to find all transactions in the last complete calendar month (not last 30 days) on a TIMESTAMP column, without hardcoding month boundaries as string literals (conceptual: describe the safe pattern using date functions, which are covered in depth on a later day).
-- SQLite:
SELECT * FROM transactions
WHERE txn_timestamp >= date('now','start of month','-1 month')
  AND txn_timestamp <  date('now','start of month');

-- PostgreSQL equivalent:
-- WHERE txn_timestamp >= date_trunc('month', CURRENT_DATE) - INTERVAL '1 month'
--   AND txn_timestamp <  date_trunc('month', CURRENT_DATE);
-- Explanation:
-- Hardcoding literal boundaries like '2026-07-01' AND '2026-08-01' only
-- stays correct for one specific month - the query would need to be manually
-- edited every single month to keep working, an obvious maintenance trap.
-- Computing the boundaries relative to the CURRENT date using built-in date
-- functions makes 'last complete calendar month' resolve correctly forever,
-- with zero ongoing maintenance - date/time functions are covered in full on
-- a later day.


-- Q45 [HARD] [Global E-commerce]
-- Find customers whose country NOT IN (SELECT DISTINCT country FROM blocked_countries), where blocked_countries.country might have inconsistent NULL entries from a bad data import - write the safe version, and explain why this exact bug (silently returning zero customers) is dangerous in a real business context (e.g., an entire marketing campaign accidentally excluding everyone).
-- BUGGY:
-- SELECT * FROM customers WHERE country NOT IN (SELECT DISTINCT country FROM blocked_countries);

-- SAFE FIX:
SELECT * FROM customers c
WHERE NOT EXISTS (SELECT 1 FROM blocked_countries b WHERE b.country = c.country);

-- Alternative safe fix - strip the NULL out of the subquery explicitly:
-- SELECT * FROM customers
-- WHERE country NOT IN (SELECT country FROM blocked_countries WHERE country IS NOT NULL);
-- Explanation:
-- One NULL row in blocked_countries.country (e.g. from a malformed CSV
-- import row with a missing country field) is enough to make NOT IN return
-- ZERO rows for the entire customers table - every comparison chain now
-- includes an UNKNOWN, so no customer ever passes. What makes this genuinely
-- dangerous in production is that it fails SILENTLY: no error is thrown, the
-- query runs successfully and just returns an empty result. If this query
-- feeds a marketing campaign meant to reach 'all customers except blocked
-- countries', the campaign would accidentally send to nobody at all, and
-- unless someone specifically notices the send count is zero, the bug could
-- go unnoticed for an entire campaign cycle.

