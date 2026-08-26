# SQL Practice — Day 5: NULL Handling, BETWEEN/IN/LIKE & the NOT IN Trap

45 hand-crafted SQL practice questions (Easy → Medium → Hard) covering `NULL`
filtering, range/set/pattern matching, safe date-range filtering on
`TIMESTAMP` columns, and — the real centerpiece — the classic `NOT IN` +
`NULL` bug and its safe fix with `NOT EXISTS`. Spread across 15+ business
domains (e-commerce, banking, healthcare, HR, telecom, logistics, insurance,
airlines, manufacturing, and more).

## 📁 Repo structure

```
.
├── README.md          ← you are here
├── schema.sql          ← CREATE TABLE + INSERT statements (run this first)
├── questions.sql       ← all 45 questions as comments, blank space to write your own query
├── solutions.sql       ← answer key, with explanations wherever the logic is tricky
└── data/                ← one CSV "sheet" per table (26 files) — same data as schema.sql
    ├── orders.csv
    ├── nominees.csv
    ├── discontinued_plans.csv
    ├── ... (26 tables total)
```

> Same convention as Day 2-4: CSV has no concept of multiple sheets, so
> each table gets its own file inside `data/`.

## ▶️ How to use this

1. **Set up the database** — load `schema.sql` into any SQL engine:
   - **SQLite** (recommended, zero setup): `sqlite3 practice.db < schema.sql`
   - **DB Browser for SQLite** (GUI): open a new DB → Execute SQL → paste `schema.sql`
   - **MySQL/Postgres**: mostly compatible; a few answers use
     PostgreSQL-only syntax (`ILIKE`, `~` regex) with a SQLite-runnable
     equivalent given right alongside it.
2. **Attempt `questions.sql`** — every question is a comment block with blank
   lines underneath. Write your query right there and run it.
3. **Check yourself against `solutions.sql`** — includes the correct query
   plus an explanation wherever the logic isn't obvious (the `NOT IN` +
   `NULL` trap, safe date ranges, `LIKE` limitations, `LIKE ESCAPE`).
4. The `data/` CSVs mirror `schema.sql` exactly — useful for practicing the
   same problems in Excel, Power Query, or pandas instead of SQL.

**A note on the "bad data" rows:** several tables in this dataset contain a
*deliberate* `NULL` in an unexpected place (a `NULL` `customer_id` in
`orders`, a `NULL` `account_id` in `nominees`, a `NULL` `plan_id` in
`discontinued_plans`, a `NULL` `country` in `blocked_countries`). These
aren't mistakes — they're there on purpose, to let you actually witness the
`NOT IN` + `NULL` bug happen against real data instead of just reading
about it.

## 📚 Topics covered

### 1. `IS NULL` / `IS NOT NULL`
The only correct way to test for `NULL` — `= NULL` and `<> NULL` both
always evaluate to `UNKNOWN`, never `TRUE`, so they silently match nothing
no matter what.

### 2. `BETWEEN` and `NOT BETWEEN`
Inclusive range checks on numeric or text/date columns. `NOT BETWEEN`
excludes the inclusive range rather than including it.

### 3. `IN` and `NOT IN` (on literal lists)
Set-membership shorthand for a list of `OR`-ed / `AND`-ed equality checks.
Safe and simple when the list is a literal set of values you wrote
yourself — the danger only appears once the list comes from a **subquery**
(see topic 8).

### 4. `LIKE` and (where supported) `ILIKE`
`%` matches any sequence of characters, `_` matches exactly one. PostgreSQL
draws a hard line between case-sensitive `LIKE` and case-insensitive
`ILIKE`; SQLite's `LIKE` is already case-insensitive for ASCII by default,
so the same query needs no special operator there — a genuinely
engine-specific difference worth knowing explicitly rather than assuming.

### 5. The safe half-open date-range pattern
On any `TIMESTAMP` (not plain `DATE`) column, `BETWEEN 'start' AND 'end'`
implicitly treats the end literal as midnight (`00:00:00`) — silently
excluding everything on the last day after midnight. The fix used
throughout this set: `col >= range_start AND col < NEXT_period_start`
(a half-open interval with no upper edge case to get wrong).

### 6. `LIKE`'s real limitation vs regex
`LIKE` only has two wildcards (`%`, `_`) and **no character classes** — it
cannot express "must be a letter" vs "must be a digit" at all, only
"any character" or "this exact character." Regex (`~` in PostgreSQL,
`SIMILAR TO` in standard SQL) is the correct tool once format validation
actually matters (Q39).

### 7. `LIKE ... ESCAPE`
Because `_` and `%` are always wildcards inside a `LIKE` pattern, matching
them as **literal** characters requires an explicit `ESCAPE` clause
(`LIKE '%\_%' ESCAPE '\'`) to tell the engine "this next character means
itself, not a wildcard" (Q40).

### 8. The `NOT IN` + `NULL` trap (the core lesson of this set)
`col NOT IN (subquery)` expands internally into a chain of `<>`
comparisons ANDed together. If the subquery returns **even one `NULL`**,
every comparison against that `NULL` is `UNKNOWN`, and one `UNKNOWN` inside
an `AND` chain poisons the *entire* expression to `UNKNOWN` — silently
returning **zero rows for the whole query**, with no error thrown. This
happens even for rows that obviously satisfy the intended condition. It's
one of the most common, and most dangerous (because it fails silently),
mistakes in production SQL.

### 9. The safe fix: `NOT EXISTS`
`NOT EXISTS (SELECT 1 FROM other_table WHERE other_table.key = this_table.key)`
is immune to the `NOT IN` + `NULL` trap, because it checks row existence via
a correlated per-row equality test rather than building a flat list that a
stray `NULL` can poison. **`NOT EXISTS` is the generally recommended,
NULL-safe default** whenever "rows that have no matching row elsewhere" is
the goal — this shows up repeatedly across Q31-Q35 and Q45.

### 10. Why a leading `%` wildcard defeats a normal index
A B-tree index is sorted by prefix, so `LIKE 'prefix%'` can use it, but
`LIKE '%suffix'` (a leading wildcard) gives the index nothing to anchor on,
forcing a full table scan regardless of whether an index exists. The fix is
usually a separate, purpose-built column (e.g. an extracted/generated
`domain` column) with its own index (Q41).

---

## 🎯 Interview Q&A

**Q: Why does `WHERE column = NULL` never return any rows, even for rows where the column genuinely is NULL?**
Because `NULL` represents "unknown," and any comparison against an unknown
value — including `=` — evaluates to `UNKNOWN`, not `TRUE`. SQL's `WHERE`
clause only keeps rows where the condition is `TRUE`; `UNKNOWN` is treated
the same as `FALSE` and the row is dropped. The only correct way to test
for `NULL` is `IS NULL` / `IS NOT NULL`.

**Q: You run `WHERE id NOT IN (SELECT id FROM other_table)` and get zero rows back, even though you're sure some rows should qualify. What's the most likely cause, and how do you fix it?**
The most common cause is that the subquery's result set contains at least
one `NULL`. `NOT IN` expands to a chain of `<>` comparisons ANDed together;
comparing anything against `NULL` yields `UNKNOWN`, and a single `UNKNOWN`
inside an `AND` chain makes the whole condition `UNKNOWN` for every row —
so the query silently returns nothing, for the ENTIRE table, not just rows
related to the `NULL`. The safe fix is to rewrite it as
`WHERE NOT EXISTS (SELECT 1 FROM other_table WHERE other_table.id = this_table.id)`,
which is immune to the trap, or to explicitly filter the `NULL` out of the
subquery with `WHERE id IS NOT NULL`.

**Q: Why is `NOT EXISTS` generally preferred over `NOT IN` for anti-join-style queries?**
`NOT EXISTS` evaluates row-by-row using a correlated equality check, so a
`NULL` in the "other" table's key column simply never matches anyone and is
harmlessly skipped — there's no list-building step for a stray `NULL` to
poison. `NOT IN` has no such protection. Since production data almost
always has *some* dirty/incomplete rows somewhere, `NOT EXISTS` is the
safer default any time you're checking "rows with no match elsewhere,"
even when you're fairly confident the subquery is currently NULL-free.

**Q: What's wrong with `WHERE timestamp_col BETWEEN '2026-08-01' AND '2026-08-31'` on a TIMESTAMP column, if the intent is "all of August"?**
The literal `'2026-08-31'` is implicitly treated as `2026-08-31 00:00:00`
when compared to a `TIMESTAMP`, so anything that happened later that day —
which is most of it — falls outside the range and gets silently excluded.
The safe fix is a half-open range: `timestamp_col >= '2026-08-01' AND
timestamp_col < '2026-09-01'`, using the start of the *next* period as an
exclusive upper bound so there's no need to guess the last representable
instant of the last day.

**Q: Why is `< next_period_start` preferred over `<= last_day 23:59:59` for a date range's upper bound?**
`<= '2026-08-31 23:59:59'` looks safe but silently breaks the moment the
column stores sub-second precision — a timestamp like `2026-08-31
23:59:59.842` is *greater* than that literal and would be excluded, even
though it's clearly still within August 31st. `< '2026-09-01'` has no such
edge case: it works correctly no matter how much fractional-second
precision the column stores, because there's no maximum value being
guessed at all.

**Q: Can `LIKE` fully validate a format like "2 letters followed by 4 digits" (e.g. a SKU)?**
No — `LIKE` only supports two wildcards: `%` (any sequence) and `_` (any
single character), with no concept of character *classes*. `LIKE
'______'` (six underscores) can confirm a string is exactly 6 characters
long, but it cannot distinguish "must be a letter" from "must be a digit"
at any position — `'123456'` would match just as readily as the intended
`'AB1234'`. Real format validation like that requires a regex-capable
operator (PostgreSQL's `~`, or `SIMILAR TO` in standard SQL).

**Q: A `LIKE '%@company.com'` query is slow on a huge table despite an index on the column — why doesn't the index help, and what's the fix?**
A standard B-tree index is sorted by the indexed value's prefix, so it can
efficiently jump to rows starting with a known prefix — but a *leading*
wildcard (`%@company.com`) gives the index nothing to anchor on, since the
matching part is at the *end* of the string. The engine has no choice but
to scan and check every row, index or not. The practical fix is to
precompute and store just the relevant suffix/domain in its own column
(via a generated column or an application-side write) and index *that*
column instead, turning the filter into a fast equality or prefix lookup.

---

## 🧩 Domains covered in this set
Amazon-style e-commerce, HR/People systems, Healthcare, Banking, Telecom,
Retail chains, Airlines, School systems, Uber-style ride-hailing, Insurance,
Zomato-style food delivery, Streaming services, Logistics, Global
E-commerce, and Manufacturing.

---

*Part of a structured SQL learning track (PostgreSQL/SQLite-focused, mapped
to real interview patterns). Continues from Day 2 (WHERE, comparison &
logical operators), Day 3 (ORDER BY, DISTINCT, LIMIT/OFFSET, pagination),
and Day 4 (GROUP BY, aggregate functions, HAVING).*
