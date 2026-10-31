
-- Aerospace Automated Manufacturing Cell
-- Equipment Reliability Analysis
-- Dataset: Synthetic MFG-005
-- Table: production_data

-- 1. Overall equipment reliability
SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN LOWER(TRIM(equipment_failure_flag)) = 'yes'
     THEN 1 ELSE 0 END)
        AS failure_records,
    ROUND(AVG(mtbf_minutes), 2) AS avg_mtbf_minutes,
    ROUND(AVG(mttr_minutes), 2) AS avg_mttr_minutes,
    ROUND(AVG(equipment_age_years), 2) AS avg_equipment_age_years,
    ROUND(AVG(equipment_condition_score), 2) AS avg_condition_score
FROM production_data;

-- 2. Reliability by work center
SELECT
    work_center_id,
    COUNT(*) AS production_records,
    SUM(CASE WHEN LOWER(TRIM(equipment_failure_flag)) = 'yes'
     THEN 1 ELSE 0 END)
        AS failure_records,
    ROUND(AVG(mtbf_minutes), 2) AS avg_mtbf_minutes,
    ROUND(AVG(mttr_minutes), 2) AS avg_mttr_minutes,
    ROUND(AVG(equipment_condition_score), 2) AS avg_condition_score
FROM production_data
GROUP BY work_center_id
ORDER BY avg_mtbf_minutes ASC;

-- 3. Maintenance status and equipment condition
SELECT
    planned_maintenance_flag,
    maintenance_type_last,
    COUNT(*) AS record_count,
    ROUND(AVG(equipment_condition_score), 2) AS avg_condition_score,
    ROUND(AVG(downtime_unplanned_minutes), 2) AS avg_unplanned_downtime,
    ROUND(AVG(mtbf_minutes), 2) AS avg_mtbf_minutes
FROM production_data
GROUP BY
    planned_maintenance_flag,
    maintenance_type_last
ORDER BY avg_unplanned_downtime DESC;

-- 4. Failure frequency by equipment age
SELECT
    CASE
        WHEN equipment_age_years < 2 THEN 'Under 2 years'
        WHEN equipment_age_years < 5 THEN '2–4 years'
        WHEN equipment_age_years < 10 THEN '5–9 years'
        ELSE '10+ years'
    END AS equipment_age_group,
    COUNT(*) AS record_count,
    SUM(CASE WHEN LOWER(TRIM(equipment_failure_flag)) = 'yes'
     THEN 1 ELSE 0 END)
        AS failure_records,
    ROUND(AVG(mtbf_minutes), 2) AS avg_mtbf_minutes,
    ROUND(AVG(mttr_minutes), 2) AS avg_mttr_minutes
FROM production_data
GROUP BY
    CASE
        WHEN equipment_age_years < 2 THEN 'Under 2 years'
        WHEN equipment_age_years < 5 THEN '2–4 years'
        WHEN equipment_age_years < 10 THEN '5–9 years'
        ELSE '10+ years'
    END
ORDER BY avg_mtbf_minutes ASC;
