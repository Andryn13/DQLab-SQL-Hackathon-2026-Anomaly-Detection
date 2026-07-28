-- summary
SELECT 
    level2,
    COUNT(*) jumlah_anomali,
    NULL id,
    NULL nilai_order,
    NULL average,
    NULL stdev,
    NULL jarak_average,
    NULL z_score
FROM
    (SELECT 
        sales_manager_2 AS level2,
            node_id AS id,
            nilai_order,
            avg_order AS average,
            stddev_order AS stdev,
            nilai_order - avg_order AS jarak_average,
            ROUND(z_score, 2) AS z_score
    FROM
        (SELECT 
        p.no_urut,
            p.node_id,
            p.sales_manager_2,
            p.nilai_order,
            q.avg_order,
            q.stddev_order,
            ROUND((p.nilai_order - q.avg_order) / q.stddev_order, 4) AS z_score
    FROM
        (SELECT 
        no_urut,
            node_id,
            CASE
                WHEN lv1 = 'ROOT' THEN node_id
                WHEN lv2 = 'ROOT' THEN lv1
                WHEN lv3 = 'ROOT' THEN lv2
                WHEN lv4 = 'ROOT' THEN lv3
                WHEN lv5 = 'ROOT' THEN lv4
                WHEN lv6 = 'ROOT' THEN lv5
            END AS sales_manager_2,
            nilai_order
    FROM
        (SELECT 
        a.no_urut,
            a.node_id,
            a.nilai_order,
            b.parent_id AS lv1,
            c.parent_id AS lv2,
            d.parent_id AS lv3,
            e.parent_id AS lv4,
            f.parent_id AS lv5,
            g.parent_id AS lv6
    FROM
        orders a
    LEFT JOIN nodes b ON a.node_id = b.id
    LEFT JOIN nodes c ON b.parent_id = c.id
    LEFT JOIN nodes d ON c.parent_id = d.id
    LEFT JOIN nodes e ON d.parent_id = e.id
    LEFT JOIN nodes f ON e.parent_id = f.id
    LEFT JOIN nodes g ON f.parent_id = g.id) x) p
    JOIN (SELECT 
        sales_manager_2,
            AVG(nilai_order) AS avg_order,
            STDDEV_POP(nilai_order) AS stddev_order
    FROM
        (SELECT 
        no_urut,
            node_id,
            CASE
                WHEN lv1 = 'ROOT' THEN node_id
                WHEN lv2 = 'ROOT' THEN lv1
                WHEN lv3 = 'ROOT' THEN lv2
                WHEN lv4 = 'ROOT' THEN lv3
                WHEN lv5 = 'ROOT' THEN lv4
                WHEN lv6 = 'ROOT' THEN lv5
            END AS sales_manager_2,
            nilai_order
    FROM
        (SELECT 
        a.no_urut,
            a.node_id,
            a.nilai_order,
            b.parent_id AS lv1,
            c.parent_id AS lv2,
            d.parent_id AS lv3,
            e.parent_id AS lv4,
            f.parent_id AS lv5,
            g.parent_id AS lv6
    FROM
        orders a
    LEFT JOIN nodes b ON a.node_id = b.id
    LEFT JOIN nodes c ON b.parent_id = c.id
    LEFT JOIN nodes d ON c.parent_id = d.id
    LEFT JOIN nodes e ON d.parent_id = e.id
    LEFT JOIN nodes f ON e.parent_id = f.id
    LEFT JOIN nodes g ON f.parent_id = g.id) y) z
    GROUP BY sales_manager_2) q ON p.sales_manager_2 = q.sales_manager_2
    ORDER BY ABS((p.nilai_order - q.avg_order) / q.stddev_order) DESC) final
    WHERE
        ABS(z_score) > 3
    ORDER BY sales_manager_2) benaran
GROUP BY level2 
UNION ALL SELECT 
    level2,
    NULL jumlah_anomali,
    id,
    nilai_order,
    average,
    stdev,
    jarak_average,
    z_score
FROM
    (SELECT 
        sales_manager_2 AS level2,
            node_id AS id,
            nilai_order,
            avg_order AS average,
            stddev_order AS stdev,
            nilai_order - avg_order AS jarak_average,
            ROUND(z_score, 2) AS z_score
    FROM
        (SELECT 
        p.no_urut,
            p.node_id,
            p.sales_manager_2,
            p.nilai_order,
            q.avg_order,
            q.stddev_order,
            ROUND((p.nilai_order - q.avg_order) / q.stddev_order, 4) AS z_score
    FROM
        (SELECT 
        no_urut,
            node_id,
            CASE
                WHEN lv1 = 'ROOT' THEN node_id
                WHEN lv2 = 'ROOT' THEN lv1
                WHEN lv3 = 'ROOT' THEN lv2
                WHEN lv4 = 'ROOT' THEN lv3
                WHEN lv5 = 'ROOT' THEN lv4
                WHEN lv6 = 'ROOT' THEN lv5
            END AS sales_manager_2,
            nilai_order
    FROM
        (SELECT 
        a.no_urut,
            a.node_id,
            a.nilai_order,
            b.parent_id AS lv1,
            c.parent_id AS lv2,
            d.parent_id AS lv3,
            e.parent_id AS lv4,
            f.parent_id AS lv5,
            g.parent_id AS lv6
    FROM
        orders a
    LEFT JOIN nodes b ON a.node_id = b.id
    LEFT JOIN nodes c ON b.parent_id = c.id
    LEFT JOIN nodes d ON c.parent_id = d.id
    LEFT JOIN nodes e ON d.parent_id = e.id
    LEFT JOIN nodes f ON e.parent_id = f.id
    LEFT JOIN nodes g ON f.parent_id = g.id) x) p
    JOIN (SELECT 
        sales_manager_2,
            AVG(nilai_order) AS avg_order,
            STDDEV_POP(nilai_order) AS stddev_order
    FROM
        (SELECT 
        no_urut,
            node_id,
            CASE
                WHEN lv1 = 'ROOT' THEN node_id
                WHEN lv2 = 'ROOT' THEN lv1
                WHEN lv3 = 'ROOT' THEN lv2
                WHEN lv4 = 'ROOT' THEN lv3
                WHEN lv5 = 'ROOT' THEN lv4
                WHEN lv6 = 'ROOT' THEN lv5
            END AS sales_manager_2,
            nilai_order
    FROM
        (SELECT 
        a.no_urut,
            a.node_id,
            a.nilai_order,
            b.parent_id AS lv1,
            c.parent_id AS lv2,
            d.parent_id AS lv3,
            e.parent_id AS lv4,
            f.parent_id AS lv5,
            g.parent_id AS lv6
    FROM
        orders a
    LEFT JOIN nodes b ON a.node_id = b.id
    LEFT JOIN nodes c ON b.parent_id = c.id
    LEFT JOIN nodes d ON c.parent_id = d.id
    LEFT JOIN nodes e ON d.parent_id = e.id
    LEFT JOIN nodes f ON e.parent_id = f.id
    LEFT JOIN nodes g ON f.parent_id = g.id) y) z
    GROUP BY sales_manager_2) q ON p.sales_manager_2 = q.sales_manager_2
    ORDER BY ABS((p.nilai_order - q.avg_order) / q.stddev_order) DESC) final
    WHERE
        ABS(z_score) > 3
    ORDER BY sales_manager_2) benaran
ORDER BY level2;