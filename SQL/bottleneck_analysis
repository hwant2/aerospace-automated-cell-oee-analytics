
-- Aerospace Automated Manufacturing Cell
-- Bottleneck and Production Flow Analysis
-- Dataset: Synthetic MFG-005
-- Table: production_data

-- 1. Work centers with the highest cycle-time losses
SELECT
    work_center_id,
    COUNT(*) AS production_records,
    ROUND(AVG(actual_cycle_time_avg_seconds), 2)
        AS avg_actual_cycle_time_seconds,
    ROUND(AVG(designed_cycle_time_seconds), 2)
        AS avg_designed_cycle_time_seconds,
    ROUND(SUM(cycle_time_loss_seconds), 2)
        AS total_cycle_time_loss_seconds,
    ROUND(AVG(bottleneck_utilisation_pct), 2)
        AS avg_bottleneck_utilisation_pct
FROM production_data
GROUP BY work_center_id
ORDER BY total_cycle_time_loss_seconds DESC
LIMIT 15;

-- 2. Most frequently identified bottleneck stations
SELECT
    work_center_id,
    bottleneck_station_id,
    COUNT(*) AS bottleneck_occurrences,
    ROUND(AVG(bottleneck_cycle_time_seconds), 2)
        AS avg_bottleneck_cycle_time_seconds,
    ROUND(AVG(bottleneck_utilisation_pct), 2)
        AS avg_bottleneck_utilisation_pct
FROM production_data
WHERE bottleneck_station_id IS NOT NULL
GROUP BY work_center_id, bottleneck_station_id
ORDER BY bottleneck_occurrences DESC
LIMIT 20;

-- 3. Work-in-progress accumulation
SELECT
    work_center_id,
    ROUND(AVG(wip_queue_avg_units), 2)
        AS avg_wip_queue_units,
    MAX(wip_queue_max_units)
        AS maximum_wip_queue_units,
    ROUND(AVG(throughput_rate_actual_uph), 2)
        AS avg_actual_throughput_uph,
    ROUND(AVG(throughput_rate_design_uph), 2)
        AS avg_design_throughput_uph
FROM production_data
GROUP BY work_center_id
ORDER BY avg_wip_queue_units DESC;

-- 4. Bottleneck performance by automation level
SELECT
    automation_level,
    COUNT(*) AS production_records,
    ROUND(AVG(bottleneck_utilisation_pct), 2)
        AS avg_bottleneck_utilisation_pct,
    ROUND(AVG(cycle_time_loss_seconds), 2)
        AS avg_cycle_time_loss_seconds,
    ROUND(AVG(throughput_rate_ratio), 3)
        AS avg_throughput_ratio
FROM production_data
GROUP BY automation_level
ORDER BY avg_cycle_time_loss_seconds DESC;

-- 5. Work centers with the lowest production achievement
SELECT
    work_center_id,
    SUM(planned_production_quantity) AS planned_units,
    SUM(actual_production_quantity) AS actual_units,
    ROUND(
        100.0 * SUM(actual_production_quantity)
        / NULLIF(SUM(planned_production_quantity), 0),
        2
    ) AS production_achievement_pct,
    ROUND(AVG(bottleneck_utilisation_pct), 2)
        AS avg_bottleneck_utilisation_pct
FROM production_data
GROUP BY work_center_id
ORDER BY production_achievement_pct ASC
LIMIT 15;
