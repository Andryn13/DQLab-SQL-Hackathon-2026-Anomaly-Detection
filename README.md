# DQLab-SQL-Hackathon-2026-Anomaly-Detection
SQL-based anomaly detection project developed for the DQLab SQL Hackathon 2026. Detects unusual sales order transactions using hierarchy traversal, statistical analysis, and Z-score under MySQL 5.7 constraints.

## Business Background

PT XYZ, a dry food distribution company, observed that purchase orders remained consistently high while actual sales performance stagnated. One possible explanation was uneven ordering behaviour among sales representatives.

To support further business investigation, the company aimed to identify anomalous ordering transactions by analysing transaction patterns within each Level 2 Sales Manager group.

---

## Objectives

This project aims to:

- Map each sales transaction to its corresponding **Level 2 Sales Manager**.
- Calculate the **average** and **population standard deviation (STDDEV_POP)** for each manager group.
- Detect anomalous transactions using **Z-score analysis**.
- Generate both summary and detailed anomaly reports using SQL.

---

## Dataset

The original dataset was provided as part of the DQLab SQL Hackathon 2026 and is not included in this repository.

For demonstration purposes, this repository focuses on the SQL solution and analytical approach rather than redistributing the original competition dataset.

The database consists of two tables.

| Table | Description |
|--------|-------------|
| **nodes** | Stores the hierarchical organisational structure of the sales team. |
| **orders** | Stores sales order transactions performed by leaf-node sales representatives. |

---

## Solution Workflow

```text
Orders + Nodes
        │
        ▼
Hierarchy Traversal
        │
        ▼
Level 2 Manager Mapping
        │
        ▼
Average & STDDEV_POP
        │
        ▼
Z-score Calculation
        │
        ▼
Outlier Detection
        │
        ▼
Summary + Detailed Report
```

---

## SQL Approaches

### Approach 1 – Nested SQL Query

- Single SQL statement
- Nested subqueries
- No temporary tables
- Fully compatible with MySQL 5.7

### Approach 2 – Refactored SQL

- Modular implementation using temporary tables
- Improved readability
- Easier debugging
- Produces identical analytical results

---

## Key Results

- Analysed **509** sales transactions.
- Grouped transactions into **4 Level 2 Sales Managers**.
- Detected **20 anomalous transactions** using the |Z| > 3 threshold.
- Highest anomaly count:
  - **N0551 (9 anomalies)**
- Most extreme positive anomaly:
  - **Z-score = +4.28**
- Most extreme negative anomaly:
  - **Z-score = −5.78**

---

## Business Insights

- Transaction behaviour varies across managerial groups, making manager-level statistical baselines more appropriate than a single global average.
- Statistical anomaly detection highlights transactions requiring further investigation rather than directly indicating operational issues.
- Combining analytical findings with business validation enables more reliable decision-making.

---

## Repository Structure

```
.
├── sql/
│   ├── approach1_nested_query.sql
│   └── approach2_temp_tables.sql
├── portfolio/
│   └── SQL_Hackathon_Portfolio.pdf
├── images/
└── README.md
```

---

## Technologies

- MySQL 5.7
- SQL
- Statistical Analysis
- Z-score
- Git & GitHub

---

## Author

**Andrini Banjarnahor**

If you found this project interesting, feel free to connect with me on LinkedIn.
