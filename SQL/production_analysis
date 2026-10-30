
-- Aerospace Automated Manufacturing Cell
-- Production and OEE Analysis
-- Dataset: Synthetic MFG-005
-- Table: production_data

-- 1. Overall production performance
SELECT
    COUNT(*) AS total_records,
    SUM(planned_production_quantity) AS total_planned,
    SUM(actual_production_quantity) AS total_actual,
    SUM(good_units_produced) AS total_good_units,
    SUM(defective_units_produced) AS total_defective_units,
    SUM(scrap_units) AS total_scrap_units,
    SUM(rework_units) AS total_rework_units
FROM production_data;

-- 2. Production target achievement
SELECT
    work_center_id,
    SUM(planned_production_quantity) AS planned_units,
    SUM(actual_production_quantity) AS actual_units,
    ROUND(
        100.0 * SUM(actual_production_quantity)
        / NULLIF(SUM(planned_production_quantity), 0),
        2
    ) AS target_achievement_pct
FROM production_data
GROUP BY work_center_id
ORDER BY target_achievement_pct ASC;

-- 3. OEE performance by work center
SELECT
    work_center_id,
    ROUND(AVG(oee_availability), 2) AS avg_availability,
    ROUND(AVG(oee_performance), 2) AS avg_performance,
    ROUND(AVG(oee_quality), 2) AS avg_quality,
    ROUND(AVG(oee_overall), 2) AS avg_oee
FROM production_data
GROUP BY work_center_id
ORDER BY avg_oee ASC;

-- 4. Production performance by shift
SELECT
    shift_number,
    COUNT(*) AS production_records,
    SUM(actual_production_quantity) AS actual_units,
    SUM(good_units_produced) AS good_units,
    ROUND(AVG(throughput_rate_actual_uph), 2) AS avg_throughput_uph
FROM production_data
GROUP BY shift_number
ORDER BY shift_number;

