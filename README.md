# Aerospace Automated Manufacturing Cell — OEE, Production & Automation Analytics

**Manufacturing Operations | Equipment Reliability | Production Analytics | SQL | Python**

## Project Overview

This project examines production performance, equipment reliability, downtime, bottlenecks, product quality, and operating costs in a simulated automated manufacturing environment.

Using Python, SQL, and SQLite, I analyzed 3,000 manufacturing records to identify performance gaps, compare equipment failure patterns, evaluate production constraints, and highlight work centers that may benefit from further operational investigation.

The goal is to demonstrate how manufacturing data can support maintenance planning, reliability analysis, production monitoring, and operational decision-making.

**Data disclaimer:** This project uses synthetic manufacturing data. It does not contain actual Airbus, HII, Navy, or other commercial or government production records.

## Business Problem

Automated manufacturing operations depend on equipment availability, production throughput, quality control, and effective maintenance planning.

When production falls below plan or equipment experiences recurring downtime, operations teams need reliable information to determine where to focus improvement efforts.

This analysis addresses five primary questions:

1. How closely does actual production meet planned output?
2. Which work centers experience the greatest downtime and production losses?
3. How does equipment failure status relate to downtime and repair time?
4. Which work centers show potential bottleneck conditions?
5. Where are the largest reported downtime and quality costs concentrated?

## Dataset

**Source:** [MFG-005 Synthetic Line Performance Dataset](https://huggingface.co/datasets/xpertsystems/mfg005-sample)

| Attribute | Description |
|---|---|
| Records analyzed | 3,000 |
| Dataset columns | 118 |
| Data type | Synthetic manufacturing operations |
| Database | SQLite |
| Development environment | Google Colab |

## Technology Stack

| Technology | Application |
|---|---|
| Python | Data analysis and visualization |
| Pandas | Data manipulation and aggregation |
| SQL | Operational queries |
| SQLite | Relational data analysis |
| Matplotlib | Data visualization |
| Google Colab | Development environment |
| GitHub | Version control and documentation |

## Analytical Methodology

The project covers seven analytical areas:

1. **Production performance:** Planned output, actual output, good units, defects, and scrap.
2. **Work-center downtime:** Unplanned downtime and equipment interruption patterns.
3. **Equipment reliability:** Failure flags, MTBF, MTTR, and equipment condition.
4. **Bottleneck analysis:** Cycle-time losses, utilization, throughput, and work-in-progress.
5. **Maintenance analysis:** Maintenance categories and equipment condition indicators.
6. **Production quality:** Defective units, first-pass yield, scrap, and rework.
7. **Manufacturing costs:** Downtime costs and reported cost-of-poor-quality exposure.

## Executive Findings

### 1. Production Performance

| Metric | Result |
|---|---:|
| Planned production | 2,219,673 units |
| Actual production | 1,448,365 units |
| Good units | 1,444,421 |
| Defective units | 3,944 |
| Scrap units | 393 |
| Target achievement | 65.25% |
| Good-unit rate | 99.73% |

Actual production was 771,308 units below plan.

WC-022 had the lowest production achievement among the analyzed work centers, at 57.98%.

### 2. Equipment Reliability

| Metric | Failure flagged | No failure flag |
|---|---:|---:|
| Records | 1,154 | 1,846 |
| Average unplanned downtime | 105.41 min | 37.56 min |
| Average MTTR | 25.38 min | 12.30 min |
| Average MTBF | 139.53 min | 235.57 min |

Failure-flagged records averaged approximately 2.81 times as much unplanned downtime as records without a failure flag.

Across the full dataset, average MTBF was 198.63 minutes and average MTTR was 17.33 minutes.

These relationships are descriptive and do not establish causation.

### 3. Work-Center Downtime

The highest cumulative unplanned downtime totals from the earlier analysis were:

| Work center | Unplanned downtime |
|---|---:|
| WC-039 | 5,690.89 min |
| WC-034 | 5,439.38 min |
| WC-005 | 5,136.43 min |

These work centers warrant further investigation into failure patterns, maintenance activity, and operating conditions.

### 4. Bottleneck and Cycle-Time Analysis

| Work center | Total cycle-time loss |
|---|---:|
| WC-034 | 8,170.65 sec |
| WC-046 | 8,011.05 sec |
| WC-041 | 7,308.53 sec |
| WC-039 | 7,218.04 sec |

WC-034 recorded the highest cumulative cycle-time loss in the validated query results.

High cycle-time loss alone does not establish the underlying cause of a bottleneck. Further analysis should account for production volume, utilization, and work-in-progress.

### 5. Manufacturing Cost Exposure

| Work center | Combined reported cost |
|---|---:|
| WC-039 | $964,395.66 |
| WC-034 | $893,222.44 |
| WC-005 | $876,852.33 |

WC-039 recorded $802,824.16 in downtime costs and $161,571.50 in cost-of-poor-quality values.

These are synthetic modeled costs, not actual company losses. The combined metric adds reported downtime cost and cost of poor quality; underlying cost definitions should be reviewed for possible overlap.

## Manufacturing Analytics Visualizations

### Production Output vs. Plan

![Production Output vs Plan](Visualizations/production_output_vs_plan.png)

### Work-Center Downtime

![Work Center Downtime](Visualizations/work_center_downtime.png)

### Equipment Failure and Downtime

![Equipment Failure Downtime](Visualizations/equipment_failure_downtime.png)

## Repository Structure

```text
aerospace-automated-cell-oee-analytics/
├── Documentation/
│   └── sql_validation_report.md
├── Python/
│   └── aerospace_manufacturing_analytics.ipynb
├── SQL/
│   ├── production_analysis.sql
│   ├── downtime_analysis.sql
│   ├── reliability_analysis.sql
│   ├── bottleneck_analysis.sql
│   └── quality_cost_analysis.sql
├── Results/
│   ├── Original analysis CSV files
│   └── Five verified SQL result CSV files
├── Visualizations/
│   ├── production_output_vs_plan.png
│   ├── work_center_downtime.png
│   └── equipment_failure_downtime.png
└── README.md
```

## SQL Validation

The five SQL scripts were tested against the 3,000-record synthetic dataset using SQLite and pandas.

| Analysis | Queries passed |
|---|---:|
| Production and OEE | 4 |
| Downtime | 5 |
| Equipment reliability | 4 |
| Bottlenecks | 5 |
| Quality and costs | 6 |
| **Total** | **24** |

All 24 SQL statements executed without reported errors.

See `Documentation/sql_validation_report.md` for additional validation details.

## Reproducing the Analysis

1. Download the synthetic MFG-005 dataset from the linked source.
2. Open the Python notebook in Google Colab.
3. Install or import the required Python libraries.
4. Load the CSV into pandas.
5. Create a SQLite database table named `production_data`.
6. Execute the SQL scripts in the `SQL` folder.
7. Compare outputs with the verified CSV results.

## Operational Applications

This project demonstrates analytical approaches applicable to:

- Production performance monitoring
- Equipment reliability and maintenance planning
- Downtime investigation
- Manufacturing bottleneck analysis
- Quality performance monitoring
- Operational cost assessment
- Data-driven reporting and continuous improvement

## Limitations and Future Development

The dataset is synthetic, and the analysis is descriptive.

Although the dataset contains OEE availability, performance, quality, and overall OEE fields, additional validation is needed before using them for a formally verified aggregate OEE calculation.

Future improvements include:

- Validating OEE calculations and aggregation methods
- Developing an interactive executive dashboard
- Adding downtime Pareto analysis
- Comparing normalized work-center performance
- Exploring predictive equipment failure models
- Automating production and reliability reporting

## Professional Skills Demonstrated

**Technical:** Python, SQL, SQLite, Pandas, data validation, aggregation, visualization, and analytical reporting.

**Manufacturing:** Production monitoring, equipment reliability, preventive maintenance, downtime analysis, bottleneck investigation, and quality assessment.

**Business:** KPI reporting, operational decision support, cost analysis, and process improvement.

## Author

**Harold Wanton**

Aerospace Manufacturing | Mechanical Maintenance | Operations & Data Analytics

[GitHub Profile](https://github.com/hwant2)
