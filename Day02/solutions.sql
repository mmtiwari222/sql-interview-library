-- ============================================================
-- SQL Practice - Day 2 : ANSWER KEY
-- Matches questions.sql 1:1. Try questions.sql yourself first!
-- Explanations are included wherever a question involves tricky
-- logic: operator precedence, NULL handling, or LIKE wildcards.
-- ============================================================


-- ################################################################
-- EASY QUESTIONS
-- ################################################################

-- Q1 [EASY] [Amazon-style]
-- Write a query to select order_id, order_date, and total_amount from an orders table.
SELECT order_id, order_date, total_amount FROM orders;


-- Q2 [EASY] [Netflix-style]
-- Write a query to fetch all columns from a subscribers table where plan_type = 'Premium'.
SELECT * FROM subscribers WHERE plan_type = 'Premium';


-- Q3 [EASY] [HR System]
-- Fetch all employees from the employees table with salary > 50000.
SELECT * FROM employees WHERE salary > 50000;


-- Q4 [EASY] [Zomato-style]
-- Select restaurant_name and rating from restaurants where city = 'Bangalore'.
SELECT restaurant_name, rating FROM restaurants WHERE city = 'Bangalore';


-- Q5 [EASY] [E-commerce]
-- Find all products where price is between 500 and 2000 using BETWEEN.
SELECT * FROM products WHERE price BETWEEN 500 AND 2000;
-- BETWEEN is inclusive on both ends, so 500 and 2000 themselves are included.


-- Q6 [EASY] [Airline-style]
-- Select all flights where origin is either 'DEL' or 'BOM' using IN.
SELECT * FROM flights WHERE origin IN ('DEL','BOM');


-- Q7 [EASY] [Bank-style]
-- Find all customers whose account_type is 'Savings' and balance > 10000 (use AND).
SELECT * FROM customers WHERE account_type = 'Savings' AND balance > 10000;


-- Q8 [EASY] [School System]
-- Select students whose grade is 'A' OR 'B'.
SELECT * FROM students WHERE grade = 'A' OR grade = 'B';


-- Q9 [EASY] [Telecom]
-- Find all subscribers where plan_expiry is NOT 'Expired' using <>.
SELECT * FROM telecom_subscribers WHERE plan_expiry <> 'Expired';
-- <> and != are equivalent in SQLite; both mean 'not equal to'.


-- Q10 [EASY] [Retail Chain]
-- Select employees whose first_name starts with 'S' using LIKE.
SELECT * FROM employees WHERE first_name LIKE 'S%';
-- % matches zero or more characters, so 'S%' matches any name starting with 'S'.


-- Q11 [EASY] [Healthcare]
-- Find all patients where phone_number IS NULL.
SELECT * FROM patients WHERE phone_number IS NULL;
-- NULL means 'unknown/missing'. You can never test it with = NULL; you must use IS NULL / IS NOT NULL.


-- Q12 [EASY] [Uber-style]
-- Select all trips where fare is greater than or equal to 200.
SELECT * FROM trips WHERE fare >= 200;


-- Q13 [EASY] [Logistics]
-- Find shipments where status is NOT 'Delivered' using NOT.
SELECT * FROM shipments WHERE NOT status = 'Delivered';


-- Q14 [EASY] [Insurance]
-- Select policies where premium is less than 5000.
SELECT * FROM policies WHERE premium < 5000;


-- Q15 [EASY] [Streaming Service]
-- Select user_id, plan_name from subscriptions where plan_name != 'Free'.
SELECT user_id, plan_name FROM subscriptions WHERE plan_name != 'Free';


-- ################################################################
-- MEDIUM QUESTIONS
-- ################################################################

-- Q16 [MEDIUM] [Amazon-style]
-- Find all orders placed in 'Delhi' OR 'Mumbai' with total_amount > 1000 (combine IN-style logic with AND - use parentheses correctly).
SELECT * FROM orders WHERE (city = 'Delhi' OR city = 'Mumbai') AND total_amount > 1000;
-- Without the parentheses, AND binds tighter than OR, so it would silently
-- become: city='Delhi' OR (city='Mumbai' AND total_amount>1000)
-- which wrongly returns every Delhi order regardless of amount.


-- Q17 [MEDIUM] [Swiggy-style]
-- Select restaurants where city = 'Pune' AND (rating >= 4 OR is_promoted = TRUE). Explain why parentheses are required here.
SELECT * FROM restaurants WHERE city = 'Pune' AND (rating >= 4 OR is_promoted = 1);
-- AND binds tighter than OR by default. Without parentheses this becomes
-- (city='Pune' AND rating>=4) OR is_promoted=1, which wrongly includes
-- promoted restaurants from ANY city, not just Pune.


-- Q18 [MEDIUM] [HR System]
-- Find employees whose department is 'Sales' AND salary BETWEEN 40000 AND 80000.
SELECT * FROM employees WHERE department = 'Sales' AND salary BETWEEN 40000 AND 80000;


-- Q19 [MEDIUM] [Banking]
-- Find all transactions where amount > 10000 AND transaction_type <> 'Refund'.
SELECT * FROM transactions WHERE amount > 10000 AND transaction_type <> 'Refund';


-- Q20 [MEDIUM] [E-commerce]
-- Find products where category IN ('Electronics','Mobiles') AND stock_quantity > 0.
SELECT * FROM products WHERE category IN ('Electronics','Mobiles') AND stock_quantity > 0;


-- Q21 [MEDIUM] [Airline-style]
-- Select passengers whose name LIKE '_a%' (second character is 'a'). Explain what this pattern matches.
SELECT * FROM passengers WHERE name LIKE '_a%';
-- '_' matches exactly ONE character, and '%' matches zero or more.
-- So '_a%' matches names whose SECOND letter is 'a' (e.g. 'Kavita', 'Farah').


-- Q22 [MEDIUM] [Healthcare]
-- Find patients where age >= 60 OR has_chronic_condition = TRUE, but exclude patients where is_deceased = TRUE (use NOT or <>).
SELECT * FROM patients WHERE (age >= 60 OR has_chronic_condition = 1) AND is_deceased <> 1;
-- The OR condition must be grouped first, then combined with the exclusion,
-- otherwise the NOT/<> would bind only to the chronic-condition part.


-- Q23 [MEDIUM] [Retail Chain]
-- Find employees hired between '2022-01-01' and '2023-12-31' using BETWEEN on a date column.
SELECT * FROM employees WHERE hire_date BETWEEN '2022-01-01' AND '2023-12-31';
-- Dates stored as TEXT in 'YYYY-MM-DD' format sort/compare correctly as strings
-- because the format is zero-padded and most-significant-first.


-- Q24 [MEDIUM] [Telecom]
-- Select subscribers where plan_type = 'Postpaid' AND outstanding_balance > 0 AND status <> 'Suspended'.
SELECT * FROM telecom_subscribers WHERE plan_type = 'Postpaid' AND outstanding_balance > 0 AND status <> 'Suspended';


-- Q25 [MEDIUM] [Logistics]
-- Find shipments where origin_city = 'Chennai' AND (status = 'In Transit' OR status = 'Pending').
SELECT * FROM shipments WHERE origin_city = 'Chennai' AND (status = 'In Transit' OR status = 'Pending');


-- Q26 [MEDIUM] [Insurance]
-- Find claims where claim_amount BETWEEN 5000 AND 50000 AND status != 'Rejected'.
SELECT * FROM claims WHERE claim_amount BETWEEN 5000 AND 50000 AND status != 'Rejected';


-- Q27 [MEDIUM] [Streaming Service]
-- Find users where signup_date >= '2023-01-01' AND plan_name IN ('Standard','Premium').
SELECT * FROM subscriptions WHERE signup_date >= '2023-01-01' AND plan_name IN ('Standard','Premium');


-- Q28 [MEDIUM] [Uber-style]
-- Find trips where fare > 500 OR (trip_type = 'Airport' AND fare > 300). Explain the precedence without parentheses.
SELECT * FROM trips WHERE fare > 500 OR (trip_type = 'Airport' AND fare > 300);
-- AND already binds tighter than OR by default, so removing these
-- parentheses would NOT change the result here - but keeping them makes
-- the intent explicit and the query easier to read and maintain.


-- Q29 [MEDIUM] [Manufacturing]
-- Find machines where last_maintenance_date IS NULL OR status = 'Faulty'.
SELECT * FROM machines WHERE last_maintenance_date IS NULL OR status = 'Faulty';


-- Q30 [MEDIUM] [Global E-commerce]
-- Find orders where customer_country = 'India' AND order_status NOT IN ('Cancelled','Returned').
SELECT * FROM global_orders WHERE customer_country = 'India' AND order_status NOT IN ('Cancelled','Returned');


-- ################################################################
-- HARD QUESTIONS
-- ################################################################

-- Q31 [HARD] [Amazon-style]
-- Find all orders where total_amount > 5000 AND (payment_method = 'Credit Card' OR payment_method = 'UPI') AND order_status <> 'Cancelled'. Explain how missing parentheses would change the result.
SELECT * FROM orders WHERE total_amount > 5000 AND (payment_method = 'Credit Card' OR payment_method = 'UPI') AND order_status <> 'Cancelled';
-- Without parentheses, the OR would split the WHERE clause into two
-- independent branches: (total_amount>5000 AND payment_method='Credit Card'
-- AND order_status<>'Cancelled') OR payment_method='UPI' - pulling in
-- ALL UPI orders regardless of amount or status.


-- Q32 [HARD] [Banking]
-- Find all high-risk transactions: amount > 100000 AND transaction_type = 'International' AND (country <> 'India' OR is_flagged = TRUE).
SELECT * FROM transactions WHERE amount > 100000 AND transaction_type = 'International' AND (country <> 'India' OR is_flagged = 1);


-- Q33 [HARD] [Healthcare]
-- Find patients eligible for a health check reminder: age >= 40 AND (last_checkup_date IS NULL OR last_checkup_date < '2024-01-01') AND is_active = TRUE.
SELECT * FROM patients WHERE age >= 40 AND (last_checkup_date IS NULL OR last_checkup_date < '2024-01-01') AND is_active = 1;
-- IS NULL must be handled explicitly and combined with OR inside parentheses -
-- a plain 'last_checkup_date < 2024-01-01' would silently skip patients
-- who have never had a checkup, since NULL comparisons return UNKNOWN.


-- Q34 [HARD] [E-commerce]
-- Find products that need restocking: stock_quantity < 10 AND category IN ('Electronics','Groceries') AND is_discontinued = FALSE.
SELECT * FROM products WHERE stock_quantity < 10 AND category IN ('Electronics','Groceries') AND is_discontinued = 0;


-- Q35 [HARD] [Airline-style]
-- Find flights delayed beyond acceptable limits: delay_minutes > 60 AND flight_status <> 'Cancelled' AND (origin = 'DEL' OR destination = 'DEL').
SELECT * FROM flights WHERE delay_minutes > 60 AND flight_status <> 'Cancelled' AND (origin = 'DEL' OR destination = 'DEL');


-- Q36 [HARD] [Retail Chain]
-- Find underperforming employees: sales_target_achieved < 50 AND department = 'Sales' AND employment_status = 'Active'. Then explain why sales_target_achieved being NULL would silently exclude that employee from results.
SELECT * FROM employees WHERE sales_target_achieved < 50 AND department = 'Sales' AND employment_status = 'Active';
-- In SQL, any comparison against NULL (e.g. NULL < 50) evaluates to UNKNOWN,
-- not TRUE, so rows with a NULL sales_target_achieved are silently dropped
-- instead of being flagged - a common source of hidden data-quality bugs.
-- Fix: add 'OR sales_target_achieved IS NULL' if those rows should surface.


-- Q37 [HARD] [Telecom]
-- Find subscribers likely to churn: outstanding_balance > 1000 AND plan_expiry_date < '2026-09-01' AND (complaints_count > 2 OR avg_usage_minutes < 50).
SELECT * FROM telecom_subscribers WHERE outstanding_balance > 1000 AND plan_expiry_date < '2026-09-01' AND (complaints_count > 2 OR avg_usage_minutes < 50);


-- Q38 [HARD] [Logistics]
-- Find shipments at risk of SLA breach: expected_delivery_date < '2026-08-10' AND status NOT IN ('Delivered','Cancelled') AND (priority = 'High' OR customer_tier = 'Premium').
SELECT * FROM shipments WHERE expected_delivery_date < '2026-08-10' AND status NOT IN ('Delivered','Cancelled') AND (priority = 'High' OR customer_tier = 'Premium');


-- Q39 [HARD] [Insurance]
-- Find suspicious claims: claim_amount > 100000 AND (claim_type = 'Theft' OR claim_type = 'Fire') AND days_since_policy_start < 30.
SELECT * FROM claims WHERE claim_amount > 100000 AND (claim_type = 'Theft' OR claim_type = 'Fire') AND days_since_policy_start < 30;


-- Q40 [HARD] [Streaming Service]
-- Find users at risk of cancellation: last_login_date IS NULL OR (last_login_date < '2026-06-01' AND subscription_status = 'Active').
SELECT * FROM subscriptions WHERE last_login_date IS NULL OR (last_login_date < '2026-06-01' AND subscription_status = 'Active');
-- The two branches (never logged in vs. logged in long ago but still Active)
-- must stay separated by parentheses so the AND doesn't apply to the NULL check.


-- Q41 [HARD] [Uber-style]
-- Find drivers to flag for review: rating < 3.5 AND total_trips > 20 AND (complaints_count > 5 OR cancellation_rate > 0.3).
SELECT * FROM drivers WHERE rating < 3.5 AND total_trips > 20 AND (complaints_count > 5 OR cancellation_rate > 0.3);


-- Q42 [HARD] [Manufacturing]
-- Find machines needing urgent inspection: last_maintenance_date IS NULL OR (operating_hours > 5000 AND status <> 'Under Repair').
SELECT * FROM machines WHERE last_maintenance_date IS NULL OR (operating_hours > 5000 AND status <> 'Under Repair');


-- Q43 [HARD] [Global E-commerce]
-- Find fraud-suspect orders: total_amount > 50000 AND payment_status = 'Pending' AND (shipping_country <> billing_country OR customer_account_age_days < 7). Note: this compares two columns, not a column to a literal.
SELECT * FROM global_orders WHERE total_amount > 50000 AND payment_status = 'Pending' AND (shipping_country <> billing_country OR customer_account_age_days < 7);
-- shipping_country <> billing_country compares two COLUMNS row-by-row,
-- unlike the usual column-vs-literal comparisons used elsewhere in this set.


-- Q44 [HARD] [Banking]
-- Write a query combining all learned operators: find accounts where balance BETWEEN 0 AND 100 AND account_type IN ('Savings','Current') AND last_transaction_date IS NOT NULL AND is_frozen = FALSE.
SELECT * FROM accounts WHERE balance BETWEEN 0 AND 100 AND account_type IN ('Savings','Current') AND last_transaction_date IS NOT NULL AND is_frozen = 0;


-- Q45 [HARD] [HR System]
-- Find employees eligible for a retention bonus: tenure_years >= 3 AND performance_rating >= 4 AND (department = 'Engineering' OR department = 'Data') AND is_on_pip = FALSE (PIP = Performance Improvement Plan).
SELECT * FROM employees WHERE tenure_years >= 3 AND performance_rating >= 4 AND (department = 'Engineering' OR department = 'Data') AND is_on_pip = 0;

