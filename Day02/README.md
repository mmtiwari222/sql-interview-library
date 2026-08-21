# SQL Practice — Day 2: WHERE, Comparison & Logical Operators

45 hand-crafted SQL practice questions (Easy → Medium → Hard) spread across 15+
real-world business domains — e-commerce, banking, healthcare, HR, telecom,
logistics, insurance, airlines, manufacturing, and more — built to prepare for
Data Analyst interviews and daily SQL work.

## 📁 Repo structure

```
.
├── README.md          ← you are here
├── schema.sql          ← CREATE TABLE + INSERT statements (run this first)
├── questions.sql       ← all 45 questions as comments, blank space to write your own query
├── solutions.sql       ← answer key, with explanations wherever the logic is tricky
└── data/                ← one CSV "sheet" per table (21 files) — same data as schema.sql
    ├── orders.csv
    ├── employees.csv
    ├── patients.csv
    ├── ... (21 tables total)
```

> **Why one CSV per table instead of one big file?** CSV is a flat format and
> doesn't support multiple sheets like Excel. Splitting by table mirrors how a
> real multi-sheet workbook would be organized, and each file can be loaded
> independently into pandas, Excel, or a database.

## ▶️ How to use this

1. **Set up the database** — load `schema.sql` into any SQL engine:
   - **SQLite** (recommended, zero setup): `sqlite3 practice.db < schema.sql`
   - **DB Browser for SQLite** (GUI): open a new DB → Execute SQL → paste `schema.sql`
   - **MySQL/Postgres**: mostly compatible; adjust `INTEGER PRIMARY KEY` → `AUTO_INCREMENT` / `SERIAL` if needed
2. **Attempt `questions.sql`** — every question is a comment block with blank
   lines underneath. Write your query right there and run it.
3. **Check yourself against `solutions.sql`** — includes the correct query
   plus a short explanation wherever the logic isn't obvious (operator
   precedence, `NULL` handling, `LIKE` wildcards, etc.).
4. The `data/` CSVs contain the exact same rows as `schema.sql`, useful if you
   want to practice the same questions in **Excel, Power Query, or pandas**
   instead of SQL.

## 📚 Topics covered

### 1. `SELECT` and column projection
Choosing specific columns (`SELECT col1, col2 FROM table`) vs. all columns
(`SELECT *`). Selecting only needed columns is a real-world performance and
readability habit, not just easy-question syntax.

### 2. The `WHERE` clause & comparison operators
`=`, `>`, `<`, `>=`, `<=`, `<>` / `!=` — used to filter rows before they're
returned. `WHERE` is evaluated per row, before `GROUP BY`/`HAVING`/`ORDER BY`.

### 3. Logical operators — `AND`, `OR`, `NOT`
Combine multiple conditions. The most interview-relevant nuance here is
**operator precedence**: `AND` binds tighter than `OR`, so
`a OR b AND c` is actually evaluated as `a OR (b AND c)`. Whenever a question
mixes `AND` and `OR`, explicit parentheses are required to get the intended
grouping — several Medium/Hard questions in this set exist specifically to
drill that habit.

### 4. `BETWEEN`
`col BETWEEN low AND high` is shorthand for `col >= low AND col <= high` —
**inclusive on both ends**. Works on numbers and on zero-padded `YYYY-MM-DD`
date strings (which sort correctly as text).

### 5. `IN` / `NOT IN`
Shorthand for a list of `OR`-ed equality checks:
`col IN (a, b, c)` = `col = a OR col = b OR col = c`.
Caution: `NOT IN` with a list that contains `NULL` returns **no rows at all**
(a classic interview trap) — none of the lists in this dataset contain NULLs,
but it's worth knowing for real data.

### 6. `LIKE` and wildcards
`%` matches zero or more characters, `_` matches exactly one character.
`'S%'` → starts with S. `'_a%'` → second character is 'a'. Pattern matching
is case-insensitive in SQLite by default for ASCII text.

### 7. `NULL` handling — `IS NULL` / `IS NOT NULL`
`NULL` means "unknown," not zero or empty string. It can **never** be tested
with `= NULL` (that always evaluates to `UNKNOWN`, so the row is dropped).
Any arithmetic or comparison involving `NULL` also returns `UNKNOWN`, which
is why filters like `sales_target_achieved < 50` silently exclude rows where
that column is `NULL` — a real data-quality gotcha covered in Q36.

### 8. Operator precedence & parentheses discipline
The single biggest theme running through the Medium/Hard tier: writing
`WHERE a AND b OR c` vs `WHERE a AND (b OR c)` can return completely
different result sets. The habit to build is **always parenthesize mixed
AND/OR conditions explicitly**, even when precedence would technically give
the same answer — it removes ambiguity for the next person reading the query.

### 9. Comparing two columns vs. a column to a literal
Most filters compare a column to a fixed value (`status = 'Delivered'`), but
Q43 (`shipping_country <> billing_country`) compares two columns to each
other, row by row — a pattern common in fraud/anomaly-detection queries.

---

## 🎯 Interview Q&A

**Q: What's the difference between `WHERE` and `HAVING`?**
`WHERE` filters individual rows before any grouping/aggregation happens.
`HAVING` filters *groups* after `GROUP BY` has aggregated rows, so it can
reference aggregate functions like `COUNT()` or `SUM()`, which `WHERE`
cannot.

**Q: Why does `column = NULL` never return any rows?**
Because `NULL` represents an unknown value, not a comparable value. Any
comparison operator (`=`, `<`, `>`, etc.) against `NULL` evaluates to
`UNKNOWN`, and `WHERE` only keeps rows where the condition is `TRUE` —
`UNKNOWN` rows are excluded just like `FALSE` rows. You must use
`IS NULL` / `IS NOT NULL` instead.

**Q: If I write `WHERE dept = 'Sales' AND salary > 40000 OR salary > 80000`, what does it actually filter?**
Because `AND` has higher precedence than `OR`, this is evaluated as
`(dept = 'Sales' AND salary > 40000) OR salary > 80000` — meaning *any*
department with salary above 80000 also qualifies, not just Sales. If the
intent was "Sales employees earning more than either threshold," it needs
explicit parentheses around the whole `OR` clause.

**Q: What's the difference between `BETWEEN` and using `>=`/`<=` manually?**
Functionally identical for most engines — `BETWEEN` is inclusive syntax
sugar for `col >= low AND col <= high`. It's more readable, but be careful
with strings/dates: `BETWEEN` compares them lexicographically, so formats
must be consistent (e.g. always `YYYY-MM-DD`) or the comparison silently
gives wrong results.

**Q: How would `NOT IN` behave if the list contains a `NULL`?**
`col NOT IN (1, 2, NULL)` returns **zero rows**, even for values that
clearly aren't 1 or 2. This is because `NOT IN` internally expands to a
chain of `<>` comparisons ANDed together, and any comparison against `NULL`
is `UNKNOWN` — one `UNKNOWN` in an AND chain makes the whole expression
`UNKNOWN`, so no row ever passes. Safer alternative:
`NOT (col IN (SELECT ... WHERE col IS NOT NULL))` or filter NULLs out first.

**Q: What does `LIKE '_a%'` match, versus `LIKE '%a%'`?**
`_a%` requires the **second character** to be exactly `a` (the leading `_`
consumes exactly one character). `%a%` matches `a` occurring **anywhere** in
the string, including the first character or the last. They're easy to
confuse in an interview whiteboard setting — always clarify what each
wildcard consumes.

**Q: A filter `sales_target_achieved < 50` is supposed to catch
underperformers, but a known underperformer with a missing value doesn't show
up. Why?**
Because their `sales_target_achieved` is `NULL`, and `NULL < 50` evaluates to
`UNKNOWN`, not `TRUE` — so the row is silently excluded rather than flagged.
This is a genuine, common bug in reporting queries. The fix is to explicitly
decide how missing data should be treated, e.g.
`WHERE sales_target_achieved < 50 OR sales_target_achieved IS NULL`.

**Q: Why prefer explicit parentheses even when operator precedence would
give the same result anyway?**
Correctness today doesn't guarantee correctness after the next edit. If
someone later adds another `OR` condition without noticing the implicit
precedence, the query's meaning can silently change. Parentheses make the
grouping unambiguous for both the engine and the next person reading the
code — a small habit that prevents real production bugs.

---

## 🧩 Domains covered in this set
Amazon-style e-commerce, Netflix-style streaming, HR/People systems,
Zomato/Swiggy-style food delivery, general E-commerce, Airlines, Banking,
School systems, Telecom, Retail chains, Healthcare, Uber-style ride-hailing,
Logistics, Insurance, Manufacturing, and Global E-commerce.

---

*Part of a structured SQL learning track (PostgreSQL/SQLite-focused, mapped
to real interview patterns). More days/topics will be added as the series
progresses.*
