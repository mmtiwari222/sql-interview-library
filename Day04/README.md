# SQL Practice — Day 4: GROUP BY, Aggregate Functions & HAVING

45 hand-crafted SQL practice questions (Easy → Medium → Hard) covering the
core of aggregate reporting — `GROUP BY`, `COUNT`/`SUM`/`AVG`/`MIN`/`MAX`,
`HAVING`, multi-condition business logic, and conditional aggregation —
across 15+ business domains (e-commerce, banking, healthcare, HR, telecom,
logistics, insurance, airlines, manufacturing, and more).

## 📁 Repo structure

```
.
├── README.md          ← you are here
├── schema.sql          ← CREATE TABLE + INSERT statements (run this first)
├── questions.sql       ← all 45 questions as comments, blank space to write your own query
├── solutions.sql       ← answer key, with explanations wherever the logic is tricky
└── data/                ← one CSV "sheet" per table (24 files) — same data as schema.sql
    ├── employees.csv
    ├── orders.csv
    ├── claims.csv
    ├── ... (24 tables total)
```

> Same convention as Day 2 & Day 3: CSV has no concept of multiple sheets,
> so each table gets its own file inside `data/`.

## ▶️ How to use this

1. **Set up the database** — load `schema.sql` into any SQL engine:
   - **SQLite** (recommended, zero setup): `sqlite3 practice.db < schema.sql`
   - **DB Browser for SQLite** (GUI): open a new DB → Execute SQL → paste `schema.sql`
   - **MySQL/Postgres**: mostly compatible; a couple of Hard-tier answers use
     `julianday()`/SQLite-specific date math — see the inline comments for
     the Postgres/MySQL equivalents.
2. **Attempt `questions.sql`** — every question is a comment block with blank
   lines underneath. Write your query right there and run it.
3. **Check yourself against `solutions.sql`** — includes the correct query
   plus an explanation wherever the logic isn't obvious (multi-aggregate
   `HAVING`, conditional aggregation, sample-size guards, period comparisons).
4. The `data/` CSVs mirror `schema.sql` exactly — useful for practicing the
   same problems in Excel, Power Query, or pandas instead of SQL.

**Note on scale:** a handful of Medium/Hard questions reference realistic
business thresholds (e.g. "more than 10,000 active subscribers",
"total claim amount exceeds 5,000,000"). The seed data here is intentionally
small for a lightweight browser/local practice tool — some thresholds are
met by design (to produce a non-trivial result you can inspect), and a couple
of very large-scale ones (like the 10,000-subscriber threshold) will
correctly return zero rows with this sample size. The SQL pattern is exactly
what you'd run against production-scale data either way — that's called out
in `solutions.sql` wherever it applies.

## 📚 Topics covered

### 1. `GROUP BY` — collapsing rows into groups
`GROUP BY col` collapses all rows sharing the same value of `col` into a
single output row, so that aggregate functions in `SELECT` operate per
group instead of over the whole table.

### 2. Aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `COUNT(*)` — number of rows in the group (counts NULLs too)
- `COUNT(col)` — number of *non-NULL* values of `col` in the group
- `COUNT(DISTINCT col)` — number of *unique non-NULL* values of `col`
- `SUM(col)` / `AVG(col)` — total / mean of a numeric column per group
- `MIN(col)` / `MAX(col)` — smallest / largest value per group

### 3. Multi-column `GROUP BY`
`GROUP BY col1, col2` groups by the *combination* of both columns —
common for route-level (`origin, destination`) or duplicate-detection
(`customer_id, product_id, order_date`) queries in this set.

### 4. `HAVING` — filtering groups (not rows)
`HAVING` runs *after* `GROUP BY` has produced aggregated groups, and can
reference aggregate expressions directly (`HAVING COUNT(*) > 5`,
`HAVING AVG(salary) > 60000`) — something `WHERE` cannot do, since `WHERE`
only ever sees individual rows before any grouping happens.

### 5. `WHERE` + `GROUP BY` + `HAVING` together
When a query needs to filter individual rows *and* filter aggregated
groups, both clauses are used together, in this order:
`WHERE` (row-level filter, e.g. `status = 'Pending'`) → `GROUP BY` →
`HAVING` (group-level filter, e.g. `COUNT(*) > 20`). Mixing these up — e.g.
trying to filter a raw column inside `HAVING` when it belongs in `WHERE` —
is a common but avoidable inefficiency.

### 6. Multiple aggregates in one `HAVING` clause
Real business rules are rarely single-condition. `HAVING COUNT(*) > 10 AND
SUM(total_amount) > 100000` combines two different aggregate expressions
with `AND`/`OR`, exactly like combining conditions in `WHERE`.

### 7. The "duplicate detection" pattern
`GROUP BY <the columns that should be unique> HAVING COUNT(*) > 1` is one of
the most common real-world data-quality queries — used throughout this set
for duplicate account numbers, SKUs, roll numbers, and duplicate orders.

### 8. Sample-size guards (avoiding noisy small-group flags)
`HAVING AVG(rating) < 3.0 AND COUNT(*) >= 20` — adding a minimum
`COUNT(*)` alongside a quality threshold prevents a group with only 2-3 rows
from being flagged purely due to small-sample noise. A general principle
whenever "quality" or "rate" metrics are aggregated (Q36).

### 9. Conditional aggregation — `SUM(CASE WHEN ... THEN 1 ELSE 0 END)`
Lets you count or sum only a *subset* of rows within each group, without a
second query or self-join — the standard way to compute a percentage/rate
per group in a single pass (failure rate, return rate, etc. — Q43, Q45).
When a flag column is already stored as `0`/`1`, `SUM(flag_col)` is an even
shorter equivalent.

### 10. Comparing aggregates across two periods (preview of later joins)
A single `GROUP BY` only ever looks at one snapshot of data. Comparing "this
month vs last month" per group needs either a self-join (joining the same
aggregated table to itself on matching keys but different periods) or a
subquery/window function like `LAG()` — a first taste of join-based
patterns covered in a later day (Q41, Q44).

---

## 🎯 Interview Q&A

**Q: What's the difference between `WHERE` and `HAVING`?**
`WHERE` filters individual rows *before* any grouping or aggregation
happens, and cannot reference aggregate functions. `HAVING` filters
*groups* after `GROUP BY` has aggregated rows, so it can reference
`COUNT()`, `SUM()`, `AVG()`, etc. If a query needs both — filter rows first,
then filter the resulting groups — you use `WHERE` and `HAVING` together in
that order.

**Q: What's the difference between `COUNT(*)` and `COUNT(column_name)`?**
`COUNT(*)` counts every row in the group, regardless of `NULL`s.
`COUNT(column_name)` counts only the rows where that specific column is
*not* `NULL`. If a column has missing values, these two can return
different numbers for the same group — a common source of off-by-N bugs in
reporting queries.

**Q: How would you find duplicate records in a table?**
`SELECT <key_columns>, COUNT(*) FROM table GROUP BY <key_columns> HAVING
COUNT(*) > 1;` — group by whichever column(s) are supposed to be unique
(an account number, SKU, or a natural key combination), and `HAVING COUNT(*)
> 1` surfaces any group with more than one row, meaning duplicates exist.

**Q: Why can't you write `WHERE COUNT(*) > 5` instead of `HAVING COUNT(*) > 5`?**
Because of SQL's logical execution order: `FROM → WHERE → GROUP BY → HAVING
→ SELECT`. `WHERE` runs *before* grouping/aggregation even happens, so
`COUNT(*)` doesn't exist yet as a value `WHERE` could filter on. `HAVING`
exists specifically because filtering needs to happen *after* aggregation.

**Q: How do you compute a percentage or rate (like a failure rate or return rate) per group in a single query?**
Conditional aggregation: `SUM(CASE WHEN condition THEN 1 ELSE 0 END)` gives
you the count of rows matching the condition within each group, and dividing
that by `COUNT(*)` gives the rate — all in one pass, no second query needed.
If the flag is already a `0`/`1` integer column, `SUM(flag_column)` is an
even shorter way to get the same numerator. Remember to force
floating-point division (e.g. multiply by `1.0`) or most engines will
truncate the ratio to `0` via integer division.

**Q: A doctor with only 2 appointments has an average rating of 1.5 — should they be flagged for review alongside a doctor with 200 appointments averaging 2.8?**
Not necessarily with equal confidence. A 2-appointment sample can produce an
extreme average purely by chance — there's no statistical weight behind it.
Adding a minimum sample-size guard to the `HAVING` clause
(`HAVING AVG(rating) < 3.0 AND COUNT(*) >= 20`, for example) ensures a
low-average flag is backed by enough data points to be a meaningful signal
rather than noise. This is a general pattern to apply any time you're
ranking or flagging based on an average.

**Q: Can `GROUP BY` compare two different time periods (e.g. "did subscriber count drop this month vs last month")?**
Not by itself — a single `GROUP BY` only aggregates one snapshot of rows at
a time; it has no built-in concept of "before" and "after." To compare two
aggregated periods, you need either a self-join (join the same aggregated
result to itself, matching on the grouping key but pulling different period
values into two column sets) or a subquery/window function like `LAG()` to
pull in the previous period's value alongside the current one.

**Q: What does `SUM(total_amount)` return for a group where every row's `total_amount` is `NULL`?**
`NULL` — not `0`. Aggregate functions (except `COUNT(*)`) skip `NULL`
values when computing, and if *every* value in the group is `NULL`, there's
nothing to sum, so the result itself is `NULL`. This surprises people who
expect an "empty sum" to default to zero; if a `0` is actually wanted,
wrap the result in `COALESCE(SUM(total_amount), 0)`.

---

## 🧩 Domains covered in this set
Amazon-style e-commerce, HR/People systems, Banking, Retail chains,
Airlines, Telecom, Healthcare, Uber-style ride-hailing, Insurance,
Streaming services, Logistics, Manufacturing, School systems,
Zomato-style food delivery, and Global E-commerce.

---

*Part of a structured SQL learning track (PostgreSQL/SQLite-focused, mapped
to real interview patterns). Continues from Day 2 (WHERE, comparison &
logical operators) and Day 3 (ORDER BY, DISTINCT, LIMIT/OFFSET, pagination).*
