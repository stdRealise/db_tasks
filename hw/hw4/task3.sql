-- Создать представление v_first_level_partition_info(parent_schema, parent_table, child_schema, child_table), которая агрегирует информацию о партициях первого уровня (непосредственные партиции). Скрипт создания должен быть нечувствителен к уже объявленным представлениям. Для решения вам потребуются системные таблицы: pg_inherits, pg_class, pg_namespace.
CREATE OR REPLACE VIEW v_first_level_partition_info(parent_schema, parent_table, child_schema, child_table) AS
SELECT 
    parent_ns.nspname::TEXT AS parent_schema,
    parent_cl.relname::TEXT AS parent_table,
    child_ns.nspname::TEXT AS child_schema,
    child_cl.relname::TEXT AS child_table
FROM pg_inherits i
JOIN pg_class parent_cl ON i.inhparent = parent_cl.oid
JOIN pg_class child_cl ON i.inhrelid = child_cl.oid
JOIN pg_namespace parent_ns ON parent_cl.relnamespace = parent_ns.oid
JOIN pg_namespace child_ns ON child_cl.relnamespace = child_ns.oid
WHERE i.inhseqno = 1;
