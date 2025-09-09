-- Усложним предыдущую задачу и cоздадим представление v_rec_level_partition_info(parent_schema, parent_table, child_schema, child_table, part_level), которая агрегирует информацию о партициях первого уровня (непосредственные партиции), второго уровня (таблица и партиции партиций) и так далее. Скрипт создания должен быть нечувствителен к уже объявленным представлениям. Можно создавать вспомогательные представления и CTE.
CREATE OR REPLACE VIEW v_rec_level_partition_info(parent_schema, parent_table, child_schema, child_table, part_level) AS
WITH RECURSIVE partition_tree AS (
    SELECT 
        parent_ns.nspname AS parent_schema,
        parent_cl.relname AS parent_table,
        child_ns.nspname AS child_schema,
        child_cl.relname AS child_table,
        1 AS part_level,
        child_cl.oid AS child_oid
    FROM pg_inherits i
    JOIN pg_class parent_cl ON i.inhparent = parent_cl.oid
    JOIN pg_class child_cl ON i.inhrelid = child_cl.oid
    JOIN pg_namespace parent_ns ON parent_cl.relnamespace = parent_ns.oid
    JOIN pg_namespace child_ns ON child_cl.relnamespace = child_ns.oid
    
    UNION ALL
    SELECT 
        pt.parent_schema,
        pt.parent_table,
        child_ns.nspname AS child_schema,
        child_cl.relname AS child_table,
        pt.part_level + 1 AS part_level,
        child_cl.oid AS child_oid
    FROM partition_tree pt
    JOIN pg_inherits i ON pt.child_oid = i.inhparent
    JOIN pg_class child_cl ON i.inhrelid = child_cl.oid
    JOIN pg_namespace child_ns ON child_cl.relnamespace = child_ns.oid
)
SELECT parent_schema, parent_table, child_schema, child_table, part_level
FROM partition_tree
ORDER BY 
    part_level, parent_schema, parent_table, child_schema, child_table;
