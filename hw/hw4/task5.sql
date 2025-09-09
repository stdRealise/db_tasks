-- Представление, которое агрегирует информацию о потребляемой памяти по каждому пользователю текущей базы данных.
CREATE OR REPLACE VIEW v_used_size_per_user AS
WITH table_sizes AS (
    SELECT 
        pg_tables.tableowner AS table_owner,
        pg_tables.schemaname AS schema_name,
        pg_tables.tablename AS table_name,
        pg_total_relation_size(pg_tables.schemaname || '.' || pg_tables.tablename) AS size_bytes
    FROM pg_tables
),
schema_sizes AS (
    SELECT table_owner, schema_name, SUM(size_bytes) AS schema_size_bytes
    FROM table_sizes
    GROUP BY table_owner, schema_name
),
user_sizes AS (
    SELECT table_owner, SUM(schema_size_bytes) AS user_size_bytes
    FROM schema_sizes
    GROUP BY table_owner
)
SELECT 
    ts.table_owner,
    ts.schema_name,
    ts.table_name,
    pg_size_pretty(ts.size_bytes) AS table_size,
    pg_size_pretty(ss.schema_size_bytes) AS used_per_schema_user_total_size,
    pg_size_pretty(us.user_size_bytes) AS used_user_total_size
FROM table_sizes ts
JOIN schema_sizes ss ON ts.table_owner = ss.table_owner AND ts.schema_name = ss.schema_name
JOIN user_sizes us ON ts.table_owner = us.table_owner;
