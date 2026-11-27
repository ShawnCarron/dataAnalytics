# SMB Data Governance & Metadata Management Framework

A practical, scalable data governance toolkit built in **Excel** and **SQL** for small and mid-sized businesses (SMBs) that need metric integrity, data lineage visibility, and privacy compliance without the cost or overhead of enterprise catalog software.

---

## Business Problem

In growing organizations, reporting breaks down when:
- **Metrics drift across departments:** Sales and Finance define core KPIs (such as *Active Customer* or *Net Revenue*) differently.
- **Lineage is invisible:** Upstream CRM or ERP schema changes break downstream dashboards with no clear impact map.
- **Privacy risk goes untracked:** Customer PII sits scattered across spreadsheets, SaaS apps, and databases without clear retention rules or ownership.

---

## Solution Architecture

This framework pairs an **8-tab relational Excel catalog** with an **automated SQL metadata extractor** (`INFORMATION_SCHEMA`) to establish a single source of truth:

| Component | Purpose | Key Features |
| :--- | :--- | :--- |
| **`0_Dashboard`** | Executive governance health scorecard | Live `COUNTIF` / `COUNTIFS` KPIs tracking PII exposure, overdue reviews, and open quality issues by severity |
| **`1_Data_Assets`** | Master inventory of databases, SaaS tools, & reports | Tracks Business Owners, Data Stewards, Sensitivity Tiers, PII flags, and review cycles |
| **`2_Field_Dictionary`** | Column-level schema documentation | Uses `XLOOKUP` to link Asset IDs and documents data types, business definitions, and validation rules |
| **`3_Data_Lineage`** | End-to-end source-to-target flow map | Auto-resolves upstream owners and downstream targets via `XLOOKUP` to assess impact before schema changes |
| **`4_Data_Quality_Log`** | Issue & defect remediation tracker | Categorizes defects across standard dimensions (*Completeness, Accuracy, Uniqueness, Timeliness, Consistency*) |
| **`5_Privacy_PIPEDA_Register`** | Record of Processing Activities (ROPA) | Maps personal data categories, collection purposes, PIPEDA/CASL consent bases, third-party processors, and retention schedules |
| **`6_Business_Glossary`** | Standardized metric & KPI definitions | Locks down official calculation logic, approval status, and authoritative source systems |
| **`7_Access_Matrix`** | Role-based access control (RBAC) matrix | Defines read/write/admin permissions and sign-off requirements per asset |
| **`schema_extract.sql`** | Automated SQL metadata & PII scanner | Queries PostgreSQL or MySQL `INFORMATION_SCHEMA` to output table/column schemas and flag likely PII fields automatically |

---

## Repository Contents

- **`SMB_Data_Governance_Catalog_Template-v3.xlsx`** — Ready-to-use relational Excel governance workbook with pre-configured data validation dropdowns, conditional formatting, and live summary formulas.
- **`schema_extract.sql`** — Production-ready SQL query (PostgreSQL & MySQL versions) formatted to export table metadata directly into `2_Field_Dictionary`.

---

## How to Use

1. **Extract Database Schemas (`schema_extract.sql`):** Run the PostgreSQL or MySQL query in DBeaver against your target schema and export the output directly to CSV/Excel.
2. **Populate the Catalog (`SMB_Data_Governance_Catalog_Template-v3.xlsx`):** Paste extracted columns into `2_Field_Dictionary`, assign owners in `1_Data_Assets`, and map upstream/downstream flows in `3_Data_Lineage`.
3. **Standardize & Monitor:** Document shared KPI formulas in `6_Business_Glossary` and track active data anomalies from `0_Dashboard`.

---

## Author

**Shawn Carron** — Sales Operations & Data Analyst | Data Governance, Standardization & Quality  
- **Website:** [datanorthanalytics.ca](https://datanorthanalytics.ca)  
- **Portfolio:** [github.com/ShawnCarron/dataAnalytics](https://github.com/ShawnCarron/dataAnalytics)