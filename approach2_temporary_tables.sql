CREATE TEMPORARY TABLE manager_mapping AS
SELECT
    a.no_urut,
    a.node_id,
    CASE
        WHEN b.parent_id = 'ROOT' THEN a.node_id
        WHEN c.parent_id = 'ROOT' THEN b.parent_id
        WHEN d.parent_id = 'ROOT' THEN c.parent_id
        WHEN e.parent_id = 'ROOT' THEN d.parent_id
        WHEN f.parent_id = 'ROOT' THEN e.parent_id
        WHEN g.parent_id = 'ROOT' THEN f.parent_id
    END AS sales_manager_2,
    a.nilai_order
FROM orders a
LEFT JOIN nodes b ON a.node_id = b.id
LEFT JOIN nodes c ON b.parent_id = c.id
LEFT JOIN nodes d ON c.parent_id = d.id
LEFT JOIN nodes e ON d.parent_id = e.id
LEFT JOIN nodes f ON e.parent_id = f.id
LEFT JOIN nodes g ON f.parent_id = g.id;

CREATE TEMPORARY TABLE manager_stats AS
SELECT
    sales_manager_2,
    AVG(nilai_order) avg_order,
    STDDEV_POP(nilai_order) stddev_order
FROM manager_mapping
GROUP BY sales_manager_2;

CREATE TEMPORARY TABLE anomaly_detail AS
SELECT
    m.sales_manager_2 AS level2,
    m.node_id AS id,
    m.nilai_order,
    s.avg_order AS average,
    s.stddev_order AS stdev,
    m.nilai_order - s.avg_order AS jarak_average,
    ROUND(
        (m.nilai_order - s.avg_order)
        / s.stddev_order,
        2
    ) AS z_score
FROM manager_mapping m
JOIN manager_stats s
    ON m.sales_manager_2 = s.sales_manager_2
WHERE ABS(
    (m.nilai_order - s.avg_order)
    / s.stddev_order
) > 3;

CREATE TEMPORARY TABLE anomaly_detail_copy AS
SELECT *
FROM anomaly_detail;

SELECT
    level2,
    COUNT(*) jumlah_anomali,
    NULL id,
    NULL nilai_order,
    NULL average,
    NULL stdev,
    NULL jarak_average,
    NULL z_score
FROM anomaly_detail
GROUP BY level2

UNION ALL

SELECT
    level2,
    NULL,
    id,
    nilai_order,
    average,
    stdev,
    jarak_average,
    z_score
FROM anomaly_detail_copy
ORDER BY level2;
