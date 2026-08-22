# SQL Practice — Day 3: ORDER BY, DISTINCT, LIMIT/OFFSET & Pagination

45 hand-crafted SQL practice questions (Easy → Medium → Hard) covering sorting,
deduplication, result limiting, aliasing, and real-world pagination patterns —
across 15+ business domains (e-commerce, banking, healthcare, HR, telecom,
logistics, insurance, airlines, manufacturing, and more).

## 📁 Repo structure

```
.
├── README.md          ← you are here
├── schema.sql          ← CREATE TABLE + INSERT statements (run this first)
├── questions.sql       ← all 45 questions as comments, blank space to write your own query
├── solutions.sql       ← answer key, with explanations wherever the logic is tricky
└── data/                ← one CSV "sheet" per table (19 files) — same data as schema.sql
    ├── orders.csv
    ├── employees.csv
    ├── patients.csv
    ├── ... (19 tables total)
```

> Same convention as Day 2: CSV is a flat format with no concept of multiple
> sheets, so each table gets its own file inside `data/` — the equivalent of
> a multi-tab workbook, just split across files.

## ▶️ How to use this

1. **Set up the database** — load `schema.sql` into any SQL engine:
   - **SQLite** (recommended, zero setup): `sqlite3 practice.db < schema.sql`
   - **DB Browser for SQLite** (GUI): open a new DB → Execute SQL → paste `schema.sql`
   - **MySQL/Postgres**: mostly compatible; a few Hard-tier answers include
     engine-specific notes (see below) since this topic set is where SQLite,
     PostgreSQL, and MySQL genuinely diverge in behaviour.
2. **Attempt `questions.sql`** — every question is a comment block with blank
   lines underneath. Write your query right there and run it.
3. **Check yourself against `solutions.sql`** — includes the correct query
   plus a short explanation wherever the logic isn't obvious (DISTINCT +
   ties, NULL sort order, pagination math, SQL's logical execution order).
4. The `data/` CSVs mirror `schema.sql` exactly — useful for practicing the
   same problems in Excel, Power Query, or pandas instead of SQL.

## 📚 Topics covered

### 1. `ORDER BY` — single and multi-column sorting
`ORDER BY col ASC|DESC`. Multi-column sorting (`ORDER BY col1 DESC, col2 ASC`)
resolves ties in `col1` using `col2` — order of columns in the clause matters,
each subsequent column only breaks ties left by the ones before it.

### 2. `DISTINCT`
Removes duplicate **rows** (or duplicate combinations, when selecting
multiple columns) from the result set — not duplicate values of just one
column when several are selected. `SELECT DISTINCT col1, col2` dedupes on the
*pair*, which regularly surprises beginners (see Q38).

### 3. `LIMIT` / `OFFSET` and the "Nth highest/lowest" pattern
`ORDER BY col DESC LIMIT 1 OFFSET N-1` returns the Nth-highest row. This
pattern shows up constantly in interviews as an alternative to window
functions (`RANK()`, `DENSE_RANK()`). The critical gotcha: **combine with
DISTINCT** when duplicate values could occupy more than one rank — otherwise
`OFFSET` skips past *rows*, not *distinct values*, and returns the wrong
answer (Q31, Q33 both drill this).

### 4. Aliasing (`AS`)
Renaming output columns for readability or API contracts:
`SELECT first_name AS employee_name`. Also used to name computed/aggregated
columns (`COUNT(*) AS trip_count`, `AVG(x) AS avg_amount`) so they can be
referenced in `ORDER BY`.

### 5. Pagination (`LIMIT`/`OFFSET` at scale)
General formula: `OFFSET = (page - 1) * page_size`. Real pagination needs a
**deterministic sort** — sorting only by a column with ties (like a shared
`order_date`) can cause rows to repeat across pages or vanish entirely,
which is why production APIs always add a unique tiebreaker column
(e.g. `order_id`) as a secondary sort key (Q44).

### 6. `GROUP BY` + `COUNT`/`SUM`/`AVG` (introduced here, not the main topic)
Several Medium/Hard questions need aggregation before the `ORDER BY`/`LIMIT`
pattern can apply — e.g. "top 3 customers by total spend" needs
`SUM(...) AS total_spent` grouped per customer *before* ranking. `DISTINCT`
cannot compute a sum or average; only `GROUP BY` + an aggregate function can.

### 7. `NULL` behaviour in `ORDER BY` (engine-dependent!)
This is the single biggest gotcha in this set. Default `NULL` sort position
**differs by engine**:
- **PostgreSQL**: `NULLS LAST` by default for `ASC`, `NULLS FIRST` by default for `DESC`
- **MySQL**: `NULL` is always treated as the *smallest* possible value (sorts first in `ASC`, last in `DESC`)
- **SQLite**: same default as MySQL (`NULL` sorts as smallest) unless `NULLS FIRST/LAST` is specified explicitly (supported from SQLite 3.30+)

Relying on the default is risky — explicit `NULLS FIRST`/`NULLS LAST` (or
filtering `IS NOT NULL` up front) makes behaviour portable across engines
(Q36, Q43).

### 8. SQL's logical execution order
`FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY`. This explains two
very common beginner errors:
- You **cannot** reference a `SELECT`-defined alias inside `WHERE`, because
  `WHERE` runs before `SELECT` even exists (Q42).
- You **cannot** filter on an aggregate (`COUNT(*)`, `SUM(...)`) using
  `WHERE` — aggregates aren't computed until `GROUP BY` runs, so filtering
  on them requires `HAVING`, which executes after grouping.

---

## 🎯 Interview Q&A

**Q: How do you find the Nth highest value in a column without window functions?**
`SELECT DISTINCT col FROM table ORDER BY col DESC LIMIT 1 OFFSET N-1;`
The `DISTINCT` is essential — without it, duplicate values at the top of the
sort order occupy multiple positions, so `OFFSET` can land on a repeat of an
already-counted value instead of moving on to the true Nth distinct value.

**Q: What's the difference between `ORDER BY col1, col2` and `ORDER BY col2, col1`?**
The first column is the primary sort key; every column after it only
resolves ties left over by the one before it. `ORDER BY col1, col2` sorts
primarily by `col1`, using `col2` only to break ties within equal `col1`
values — swapping the order changes which column dominates the sort.

**Q: Does `SELECT DISTINCT` on two columns give you distinct values of each column independently?**
No — it gives distinct **combinations** of the two columns together. If
`plan_type` has 2 values and `region` has 3, you could get up to 6 rows back
(one per combination that actually occurs), not 2 or 3. This is a very
common beginner trap when someone expects `DISTINCT col1, col2` to behave
like running `DISTINCT` on each column separately.

**Q: Why would the same `ORDER BY ... LIMIT ... OFFSET ...` pagination query return inconsistent results across page loads?**
If the sort column has ties (e.g. multiple rows share the same
`order_date`), SQL doesn't guarantee any particular order among tied rows
unless you add a tiebreaker. Without a unique secondary sort key (like a
primary key `order_id`), the same row can appear on two different pages, or
get skipped, especially if the underlying data or index changes between
requests. The fix is always to add a unique column as the final sort key.

**Q: How does `NULL` behave in `ORDER BY ... DESC`, and does it differ between databases?**
Yes, significantly. PostgreSQL puts `NULL`s **first** by default when sorting
`DESC` (treating them as larger than any real value), while MySQL and SQLite
put `NULL`s **last** by default in `DESC` (treating them as smaller than any
real value). Because the default isn't standardized, portable code should
either filter `NULL`s explicitly or specify `NULLS FIRST`/`NULLS LAST`.

**Q: Why can't you write `SELECT id, COUNT(*) AS cnt FROM t WHERE cnt > 5`?**
Because of SQL's logical execution order: `WHERE` is evaluated before
`SELECT`, so the alias `cnt` doesn't exist yet at the point `WHERE` runs.
Separately, filtering on an aggregate like `COUNT(*)` always requires
`HAVING`, since aggregates are only computed after `GROUP BY` — the correct
form is `SELECT id, COUNT(*) AS cnt FROM t GROUP BY id HAVING COUNT(*) > 5`.

**Q: `LIMIT 5` on a claim_amount ranking returns exactly 5 rows, but two claims are tied for 5th place. What actually happens, and is that usually acceptable?**
`LIMIT 5` returns exactly 5 rows regardless of ties — which of the tied rows
gets included at the boundary is not guaranteed by SQL unless a tiebreaker
column is specified, so the same query can arbitrarily include one tied
claim and exclude the other. If the business requirement is "include every
claim tied for 5th," `LIMIT` alone is the wrong tool — you'd need a ranking
function (`RANK()`) and filter `WHERE rnk <= 5`, since `RANK()` assigns the
same rank to ties and lets more than N rows through when there's a tie at
the cutoff.

**Q: What's the general formula for OFFSET-based pagination?**
`OFFSET = (page_number - 1) * page_size`. E.g. page 5 with page size 15 →
`OFFSET = (5-1)*15 = 60`, `LIMIT 15`. Note that OFFSET-based pagination gets
progressively slower on very large tables (the database still has to scan
and discard all the skipped rows), which is why high-scale APIs often switch
to keyset/cursor-based pagination instead — worth mentioning if the
interview goes deeper into pagination performance.

---

## 🧩 Domains covered in this set
Amazon-style e-commerce, Netflix-style streaming, HR/People systems,
Zomato/Swiggy-style food delivery, general E-commerce, Airlines, Banking,
School systems, Telecom, Retail chains, Healthcare, Uber-style ride-hailing,
Logistics, Insurance, Manufacturing, and Global E-commerce.

---

*Part of a structured SQL learning track (PostgreSQL/SQLite-focused, mapped
to real interview patterns). Continues from Day 2 (WHERE, comparison &
logical operators, BETWEEN/IN/LIKE, NULL handling).*
