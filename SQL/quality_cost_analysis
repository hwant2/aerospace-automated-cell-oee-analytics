
-- Aerospace Automated Manufacturing Cell
-- Quality and Cost Analysis
-- Dataset: Synthetic MFG-005
-- Table: production_data

-- 1. Overall quality performance
SELECT
    SUM(actual_production_quantity) AS total_units,
    SUM(good_units_produced) AS good_units,
    SUM(defective_units_produced) AS defective_units,
    SUM(scrap_units) AS scrap_units,
    SUM(rework_units) AS rework_units,
    ROUND(
        100.0 * SUM(good_units_produced)
        / NULLIF(SUM(actual_production_quantity), 0),
        2
    ) AS good_unit_rate_pct
FROM production_data;

-- 2. Quality performance by work center
SELECT
    work_center_id,
    SUM(actual_production_quantity) AS actual_units,
    SUM(defective_units_produced) AS defective_units,
    SUM(scrap_units) AS scrap_units,
    SUM(rework_units) AS rework_units,
    ROUND(AVG(first_pass_yield_pct), 2) AS avg_first_pass_yield,
    ROUND(AVG(defect_rate_ppm), 2) AS avg_defect_ppm
FROM production_data
GROUP BY work_center_id
ORDER BY defective_units DESC;

-- 3. Overall financial impact
SELECT
    ROUND(SUM(total_downtime_cost_usd), 2)
        AS total_downtime_cost_usd,
    ROUND(SUM(cost_of_poor_quality_usd), 2)
        AS total_poor_quality_cost_usd,
    ROUND(SUM(scrap_cost_usd), 2)
        AS total_scrap_cost_usd,
    ROUND(SUM(rework_cost_usd), 2)
        AS total_rework_cost_usd
FROM production_data;

-- 4. Work centers with highest combined cost
SELECT
    work_center_id,
    ROUND(SUM(total_downtime_cost_usd), 2)
        AS downtime_cost_usd,
    ROUND(SUM(cost_of_poor_quality_usd), 2)
        AS poor_quality_cost_usd,
    ROUND(
        SUM(total_downtime_cost_usd)
        + SUM(cost_of_poor_quality_usd),
        2
    ) AS combined_cost_usd
FROM production_data
GROUP BY work_center_id
ORDER BY combined_cost_usd DESC
LIMIT 15;

-- 5. Most common primary defect types
SELECT
    primary_defect_type,
    COUNT(*) AS record_count,
    SUM(defective_units_produced) AS defective_units,
    ROUND(SUM(cost_of_poor_quality_usd), 2)
        AS poor_quality_cost_usd
FROM production_data
WHERE primary_defect_type IS NOT NULL
GROUP BY primary_defect_type
ORDER BY defective_units DESC;

-- 6. Quality cost by automation level
SELECT
    automation_level,
    COUNT(*) AS production_records,
    ROUND(AVG(first_pass_yield_pct), 2)
        AS avg_first_pass_yield,
    ROUND(SUM(scrap_cost_usd), 2)
        AS scrap_cost_usd,
    ROUND(SUM(rework_cost_usd), 2)
        AS rework_cost_usd,
    ROUND(SUM(cost_of_poor_quality_usd), 2)
        AS poor_quality_cost_usd
FROM production_data
GROUP BY automation_level
ORDER BY poor_quality_cost_usd DESC;
