# SQL Practice — Day 6: CASE WHEN, COALESCE, NULLIF, CAST & String Functions

45 hand-crafted SQL practice questions (Easy → Medium → Hard) covering
conditional logic, safe NULL/zero handling, type conversion, and the
string-cleaning toolkit every analyst reaches for constantly — plus the
"conditional aggregation" pattern that turns `CASE WHEN` into a full pivot-
table report generator. Spread across 15+ business domains (HR, e-commerce,
banking, airline, healthcare, retail, telecom, insurance, streaming, Uber,
logistics, and manufacturing).

## 📁 Repo structure

```
.
├── README.md          ← you are here
├── schema.sql          ← CREATE TABLE + INSERT statements (run this first)
├── questions.sql       ← all 45 questions as comments, blank space to write your own query
├── solutions.sql       ← answer key, with explanations wherever the logic is tricky
└── data/                ← one CSV "sheet" per table (28 files) — same data as schema.sql
    ├── employees.csv
    ├── claims.csv
    ├── revenue_records.csv
    ├── ... (28 tables total)
```

> Same convention as Day 2-5: CSV has no concept of multiple sheets, so
> each table gets its own file inside `data/`.

## ▶️ How to use this

1. **Set up the database** — load `schema.sql` into any SQL engine:
   - **SQLite** (recommended, zero setup): `sqlite3 practice.db < schema.sql`
   - **DB Browser for SQLite** (GUI): open a new DB → Execute SQL → paste `schema.sql`
   - **MySQL/Postgres**: mostly compatible; a few answers call out real
     engine differences explicitly (`||` vs `CONCAT()`, `LEFT()`/`SUBSTRING()`
     vs SQLite's `SUBSTR()`, CAST failure behavior) with the portable
     alternative given right alongside the SQLite version.
2. **Attempt `questions.sql`** — every question is a comment block with blank
   lines underneath. Write your query right there and run it.
3. **Check yourself against `solutions.sql`** — includes the correct query
   plus an explanation wherever the logic isn't obvious (NULLIF semantics,
   CAST's silent failure modes, the CASE WHEN ordering bug, and more).
4. The `data/` CSVs mirror `schema.sql` exactly — useful for practicing the
   same problems in Excel, Power Query, or pandas instead of SQL.

**A note on the "messy data" rows:** several tables here contain
deliberately inconsistent values on purpose — mixed-case/padded city and
email entries, a store with zero transactions, a month with zero expiring
subscriptions, a non-numeric amount string, a `'0'` stored as TEXT instead
of a real zero, and NULL `subscriber_id`s mixed into revenue records. These
let you actually witness each bug/edge-case happen against real query
results, not just read about it.

## 📚 Topics covered

### 1. `CASE WHEN` — the workhorse of conditional logic
`CASE WHEN condition THEN result ... ELSE default END` evaluates its
conditions **top to bottom and stops at the first match** ("first match
wins"). This single rule is the source of one of the most common real bugs
in reporting SQL — see topic 8 below.

### 2. `COALESCE` — first non-NULL value, in priority order
`COALESCE(a, b, c)` returns the first argument that isn't `NULL`, checked
left to right. Perfect for "use this value, but fall back to that one, and
if both are missing use a default" logic (Q6, Q38).

### 3. `NULLIF` — turning a specific value into NULL on purpose
`NULLIF(a, b)` returns `NULL` if `a` equals `b`, otherwise returns `a`.
Its single most common use: `numerator / NULLIF(denominator, 0)` — turning
a would-be division-by-zero into a clean `NULL` instead of an error or a
misleading `0`.

### 4. `CAST` — explicit type conversion, and its failure modes
`CAST(value AS TYPE)` converts between types. Different engines fail
*very* differently on bad input: SQLite silently returns `0` for an
unparseable numeric cast (Q30), while stricter engines like PostgreSQL
raise an explicit error — a genuinely important behavioral difference to
know when moving code between engines.

### 5. String functions: `UPPER`, `LOWER`, `TRIM`, `LENGTH`, `REPLACE`
The everyday text-cleaning toolkit. `TRIM` only touches leading/trailing
whitespace — it has no effect on repeated *internal* spaces (Q28), a
limitation worth knowing before assuming a name field is "clean."

### 6. String concatenation: `||` vs `CONCAT()`
`||` is the ANSI-SQL standard operator (works in PostgreSQL, SQLite,
Oracle) — but in MySQL, `||` means **logical OR** by default, not
concatenation. `CONCAT(a, b, c)` is the portable function-call alternative
that behaves consistently across MySQL and PostgreSQL (Q12, Q39).

### 7. Substring extraction: `SUBSTR`/`SUBSTRING` and `LEFT`
SQLite only has `SUBSTR(string, start, length)`; PostgreSQL/MySQL also
offer the more readable `LEFT(string, n)` shortcut for "first n
characters." Both extract fixed-position segments — useful for parsing
structured codes like `MC-2024-001` (Q14, Q29).

### 8. Conditional aggregation — the "manual pivot table" pattern
`SUM(CASE WHEN condition THEN 1 ELSE 0 END)` inside a `GROUP BY` computes a
filtered count *within* each group, in a single pass — no second query, no
join. Stack several of these side by side in one `SELECT` and you get a
full breakdown report (delivered % / cancelled % / returned %, active vs
inactive counts, 5-star vs 1-2-star rates) that would otherwise need
several separate queries stitched together (Q16-Q20, Q31-Q35, Q42).

### 9. `CASE WHEN` inside `ORDER BY` — custom sort priority
`ORDER BY CASE WHEN status = 'Urgent' THEN 0 ELSE 1 END, other_col` lets you
impose a business-defined sort priority (e.g. "urgent items always float to
the top") that has nothing to do with the natural alphabetical/numeric
order of any single column (Q24).

### 10. The `CASE WHEN` "first match wins" ordering bug
Writing `CASE WHEN salary > 50000 THEN 'High' WHEN salary > 80000 THEN
'Very High' ELSE 'Low' END` is a genuine logic bug: since anything above
80000 is *also* above 50000, the first (broader) condition always wins,
and `'Very High'` can never fire. The fix is to order conditions from most
restrictive to least restrictive (Q45) — arguably the single most
important habit this entire set is designed to drill in.

---

## 🎯 Interview Q&A

**Q: What does `NULLIF(a, b)` do, and what's its most common real-world use?**
`NULLIF(a, b)` returns `NULL` if `a` equals `b`, otherwise it returns `a`
unchanged. The single most common use is guarding against division by
zero: `numerator / NULLIF(denominator, 0)` — if the denominator is `0`,
`NULLIF` converts it to `NULL` first, so the division produces a clean
`NULL` result instead of a divide-by-zero error (in strict engines) or a
misleading `0`/`Inf` value.

**Q: If a division-by-zero-guarded metric comes back as NULL, is that a bug?**
Not necessarily — it's often the mathematically *correct* answer. Division
by zero is undefined, not zero, so a `NULL` result correctly represents
"this ratio genuinely cannot be computed" (e.g. a store with zero revenue,
or a month with zero subscriptions expiring). Defaulting that `NULL` to `0`
in a dashboard would misleadingly conflate "nothing to measure" with "the
metric IS zero," which can tell a very different — and wrong — story to a
stakeholder.

**Q: What's wrong with `CASE WHEN salary > 50000 THEN 'High' WHEN salary > 80000 THEN 'Very High' ELSE 'Low' END`?**
`CASE WHEN` evaluates conditions top-to-bottom and stops at the *first*
match. Since every salary above 80000 is trivially also above 50000, the
first condition always catches those rows before the second ever gets a
chance — so `'Very High'` can never be produced, no matter how high the
salary actually is. The fix: order conditions from most restrictive to
least restrictive, so narrower conditions are checked before the broader
ones that would otherwise swallow them.

**Q: How would you build a single-row report with a breakdown of percentages by status (e.g. % delivered, % cancelled, % returned) without three separate queries?**
Conditional aggregation: `100.0 * SUM(CASE WHEN status = 'Delivered' THEN 1
ELSE 0 END) / COUNT(*)` computes one percentage, and you can stack as many
of these side by side in the same `SELECT` — each one filtering a
different status — all sharing the same `COUNT(*)` denominator, in a
single pass over the table.

**Q: Does `TRIM()` clean up a value like `"John   Doe"` (with extra internal spaces)?**
No — `TRIM()` only removes whitespace from the very start and end of a
string; it has no effect on repeated spaces in the *middle*. `"John
Doe"` (three internal spaces) comes out of `TRIM()` completely unchanged,
since neither end has leading or trailing whitespace to strip. Collapsing
internal whitespace requires a regex-capable function like
`REGEXP_REPLACE(name, '\s+', ' ', 'g')`.

**Q: Why might `||` behave completely differently across database engines?**
`||` is the ANSI-SQL standard string concatenation operator, and it works
that way in PostgreSQL, SQLite, and Oracle — but MySQL treats `||` as
**logical OR** by default (unless the non-standard `PIPES_AS_CONCAT` SQL
mode is explicitly enabled). The same exact query could silently mean two
completely different things depending on which engine runs it.
`CONCAT(a, b, c)` is the safer, portable choice across MySQL/PostgreSQL.

**Q: A query casts a TEXT column to NUMERIC and a row contains `'N/A'`. What happens, and why does it matter?**
It depends entirely on the engine. SQLite's `CAST` is very permissive —
`CAST('N/A' AS NUMERIC)` silently returns `0` rather than raising any
error, since it simply finds no parseable numeric prefix and gives up
quietly. This is dangerous precisely because it's silent: a genuinely bad
or missing value gets replaced with a plausible-looking `0` that can
corrupt downstream aggregates without anyone noticing. Stricter engines
like PostgreSQL raise an explicit error on the same cast instead — which
is arguably the *safer* behavior, since it forces the bad data to be
addressed immediately rather than quietly miscounted.

**Q: `COUNT(DISTINCT subscriber_id)` in a per-user average is producing a suspiciously high number for one region — what's a likely cause?**
`COUNT(DISTINCT column)` never counts `NULL` values. If a chunk of revenue
records in that region have a missing/`NULL` `subscriber_id` (e.g.
anonymous or unlinked transactions), that revenue still gets included in
the `SUM(revenue)` numerator, but those rows are silently excluded from
the `COUNT(DISTINCT subscriber_id)` denominator — so the same total revenue
gets divided by an artificially small subscriber count, inflating the
average-revenue-per-user figure well above what it should genuinely be.

---

## 🧩 Domains covered in this set
HR/People systems, E-commerce, Banking, Airlines, School systems,
Healthcare, Retail chains, Telecom, Insurance, Streaming services,
Uber-style ride-hailing, Zomato-style food delivery, Global E-commerce,
Logistics, and Manufacturing.

---

*Part of a structured SQL learning track (PostgreSQL/SQLite-focused, mapped
to real interview patterns). Continues from Day 2 (WHERE, comparison &
logical operators), Day 3 (ORDER BY, DISTINCT, LIMIT/OFFSET, pagination),
Day 4 (GROUP BY, aggregate functions, HAVING), and Day 5 (NULL handling,
BETWEEN/IN/LIKE, safe date ranges, the NOT IN trap).*
