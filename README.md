# Municipal Licensing System — SQL Portfolio

A relational database project built with MySQL to demonstrate SQL proficiency beyond academic exercises. The project simulates a municipal licensing system in which cities issue activity licenses to individuals. It covers schema design, data manipulation, analytical queries, and data validation test scenarios.

---

## Objective

Design and document a relational database that models the issuance and management of municipal activity licenses — such as food trucks, taxi services, and street vendors — demonstrating practical SQL skills including schema evolution, referential integrity, business rule enforcement, and structured query reporting.

---

## Technologies Used

- **MySQL 8+**
- **SQL** — DDL, DML, DQL
- **Markdown** — documentation
- **DBeaver** — execution

---

## Relational Model

```
cidades
   │
   ├── pessoas (id_cidade_residencia → cidades.id_cidade)
   │      │
   │      └── licenciamentos (id_pessoa → pessoas.id_pessoa)
   │
   └── licenciamentos (id_cidade → cidades.id_cidade)
```

| Relationship | Type |
| --- | --- |
| cidades → pessoas | One to Many |
| pessoas → licenciamentos | One to Many |
| cidades → licenciamentos | One to Many |

---

## Project Structure

```
QA-SQL/
│
├── docs/
│   ├── data-dictionary.md       # Column definitions, types, constraints and business rules
│   └── test-scenarios.md        # Validation test case descriptions (CT-01 to CT-15)
│
├── scripts/
│   ├── 01_database_management.sql   # Create and drop database
│   ├── 02_table_management.sql      # Create, alter and drop tables
│   ├── 03_data_manipulation.sql     # Insert, update and delete records
│   ├── 04_queries_and_reports.sql   # Operational queries and analytical reports
│   └── 05_validation_tests.sql      # Data integrity and business rule validation
│
├── LICENSE
└── README.md
```

---

## How to Execute

Run the scripts in order using MySQL Workbench, DBeaver, or the MySQL CLI:

```bash
mysql -u your_user -p < scripts/01_database_management.sql
mysql -u your_user -p < scripts/02_table_management.sql
mysql -u your_user -p licensing_management < scripts/03_data_manipulation.sql
mysql -u your_user -p licensing_management < scripts/04_queries_and_reports.sql
mysql -u your_user -p licensing_management < scripts/05_validation_tests.sql
```

> Scripts 04 and 05 are read-only. They do not modify any data and can be run multiple times safely.

---

## SQL Concepts Demonstrated

| Category | Concepts |
| --- | --- |
| Database Management | `CREATE DATABASE`, `DROP DATABASE`, `ALTER DATABASE` |
| Table Management | `CREATE TABLE`, `DROP TABLE`, `ALTER TABLE` |
| Data Manipulation | `INSERT INTO`, `UPDATE`, `DELETE` |
| Filtering | `WHERE`, `LIKE`, `BETWEEN`, `IN` |
| Sorting | `ORDER BY` |
| Joins | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` |
| Aggregation | `GROUP BY`, `HAVING`, `COUNT` |
| Conditionals | `CASE WHEN` |
| Date Functions | `CURRENT_DATE`, `DATE_ADD`, `INTERVAL` |
| Integrity Validation | Orphan detection, duplicate checks, constraint verification |

---

## Author

**[Your Name]**  
[LinkedIn](https://www.linkedin.com/in/luis-gomess/)