-- Aerospace Automated Manufacturing Cell
-- Downtime Analysis
-- Dataset: Synthetic MFG-005
-- Table: production_data

-- 1. Overall downtime performance
SELECT
    COUNT(*) AS total_records,
    ROUND(SUM(downtime_unplanned_minutes), 2) AS total_unplanned_downtime,
    ROUND(SUM(downtime_planned_minutes), 2) AS total_planned_downtime,
    SUM(downtime_event_count) AS total_downtime_events,
    ROUND(AVG(downtime_unplanned_minutes), 2) AS avg_unplanned_downtime
FROM production_data;

-- 2. Downtime by work center
SELECT
    work_center_id,
    COUNT(*) AS production_records,
    ROUND(SUM(downtime_unplanned_minutes), 2) AS total_unplanned_downtime,
    SUM(downtime_event_count) AS total_downtime_events,
    ROUND(AVG(mttr_minutes), 2) AS avg_mttr,
    ROUND(AVG(mtbf_minutes), 2) AS avg_mtbf
FROM production_data
GROUP BY work_center_id
ORDER BY total_unplanned_downtime DESC;

-- 3. Downtime by equipment failure flag
SELECT
    equipment_failure_flag,
    COUNT(*) AS record_count,
    ROUND(AVG(downtime_unplanned_minutes), 2) AS avg_unplanned_downtime,
    ROUND(AVG(mttr_minutes), 2) AS avg_mttr,
    ROUND(AVG(mtbf_minutes), 2) AS avg_mtbf
FROM production_data
GROUP BY equipment_failure_flag;

-- 4. Downtime category analysis
SELECT
    SUM(downtime_category_mechanical) AS mechanical_downtime,
    SUM(downtime_category_electrical) AS electrical_downtime,
    SUM(downtime_category_tooling) AS tooling_downtime,
    SUM(downtime_category_material) AS material_downtime,
    SUM(downtime_category_operator) AS operator_downtime,
    SUM(downtime_category_quality_hold) AS quality_hold_downtime
FROM production_data;

-- 5. Largest downtime events
SELECT
    work_center_id,
    line_id,
    shift_date,
    largest_downtime_event_minutes,
    downtime_unplanned_minutes,
    mttr_minutes,
    mtbf_minutes
FROM production_data
ORDER BY largest_downtime_event_minutes DESC
LIMIT 20;

-- 6. Downtime category reconciliation
-- Flag records with discrepancies exceeding 10 minutes

WITH downtime_check AS (
    SELECT
        work_center_id,
        downtime_unplanned_minutes,
        (
            COALESCE(downtime_category_mechanical, 0) +
            COALESCE(downtime_category_electrical, 0) +
            COALESCE(downtime_category_tooling, 0) +
            COALESCE(downtime_category_material, 0) +
            COALESCE(downtime_category_operator, 0) +
            COALESCE(downtime_category_quality_hold, 0)
        ) AS category_total
    FROM production_data
)
SELECT
    COUNT(*) AS total_records,
    SUM(
        CASE WHEN ABS(category_total - downtime_unplanned_minutes) > 10
        THEN 1 ELSE 0 END
    ) AS major_discrepancy_records,
    ROUND(SUM(downtime_unplanned_minutes), 2) AS total_unplanned_minutes,
    ROUND(SUM(category_total), 2) AS total_category_minutes,
    ROUND(
        SUM(downtime_unplanned_minutes - category_total), 2
    ) AS net_unallocated_minutes
FROM downtime_check;
