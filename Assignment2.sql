SELECT current_database();

SELECT tablename
FROM pg_tables
WHERE schemaname = 'public';

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM customer_events_wide;

SELECT *
FROM customer_events_wide;

SELECT
    pid,
    usename,
    state,
    wait_event_type,
    wait_event,
    query
FROM pg_stat_activity
WHERE datname = 'student_perf_lab';

SELECT
    query,
    calls,
    total_exec_time,
    mean_exec_time,
    rows
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 20;

SELECT
    blocked.pid AS blocked_pid,
    blocked.query AS blocked_query,
    blocking.pid AS blocking_pid,
    blocking.query AS blocking_query
FROM pg_stat_activity blocked
JOIN pg_stat_activity blocking
ON blocking.pid = ANY(pg_blocking_pids(blocked.pid));

SELECT
    pid,
    usename,
    state,
    xact_start,
    now() - xact_start AS transaction_duration,
    query
FROM pg_stat_activity
WHERE xact_start IS NOT NULL
ORDER BY xact_start;

SELECT *
FROM pg_indexes
WHERE schemaname = 'public';

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE customer_id = 100;

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 100;

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE country = 'USA';

CREATE INDEX idx_customers_country
ON customers(country);

CREATE INDEX idx_customers_status
ON customers(status);

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE country = 'USA';

EXPLAIN ANALYZE
SELECT
    c.customer_id,
    c.full_name,
    o.order_id,
    o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;