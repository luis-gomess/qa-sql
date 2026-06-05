# Data Dictionary

## Overview

This document describes the structure of the database used in the Licensing Management System.

---

# Table: cidades

Stores information about cities where people reside and where licenses are issued.

| Column    | Data Type    | Constraints | Description                   |
| --------- | ------------ | ----------- | ----------------------------- |
| id_cidade | INT          | PRIMARY KEY | Unique identifier of the city |
| nome      | VARCHAR(100) | NOT NULL    | City name                     |
| estado    | CHAR(2)      | NOT NULL    | State abbreviation            |

---

# Table: pessoas

Stores personal information about registered individuals.

| Column               | Data Type    | Constraints      | Description                              |
| -------------------- | ------------ | ---------------- | ---------------------------------------- |
| id_pessoa            | INT          | PRIMARY KEY      | Unique identifier of the person          |
| nome                 | VARCHAR(100) | NOT NULL         | Full name                                |
| cpf                  | CHAR(11)     | NOT NULL, UNIQUE | Brazilian taxpayer identification number |
| data_nascimento      | DATE         | NOT NULL         | Date of birth                            |
| id_cidade_residencia | INT          | FOREIGN KEY      | Reference to the city of residence       |

### Relationships

| Foreign Key          | References         |
| -------------------- | ------------------ |
| id_cidade_residencia | cidades(id_cidade) |

---

# Table: licenciamentos

Stores information about business and activity licenses issued by municipalities.

| Column           | Data Type    | Constraints           | Description                      |
| ---------------- | ------------ | --------------------- | -------------------------------- |
| id_licenciamento | INT          | PRIMARY KEY           | Unique identifier of the license |
| id_pessoa        | INT          | NOT NULL, FOREIGN KEY | Licensed person                  |
| id_cidade        | INT          | NOT NULL, FOREIGN KEY | Issuing city                     |
| atividade        | VARCHAR(100) | NOT NULL              | Licensed activity                |
| data_emissao     | DATE         | NOT NULL              | License issue date               |
| data_validade    | DATE         | NOT NULL              | License expiration date          |
| status           | VARCHAR(20)  | NOT NULL              | Current license status           |

### Relationships

| Foreign Key | References         |
| ----------- | ------------------ |
| id_pessoa   | pessoas(id_pessoa) |
| id_cidade   | cidades(id_cidade) |

### Allowed Status Values

| Status   | Description                |
| -------- | -------------------------- |
| ativo    | License is currently valid |
| vencido  | License has expired        |
| revogado | License has been revoked   |

---

# Entity Relationship Summary

```text
cidades
   │
   ├── pessoas
   │      │
   │      └── licenciamentos
   │
   └── licenciamentos
```

---

# Business Rules

### BR-01
A person must belong to a valid city of residence.

### BR-02
A license must be associated with an existing person.

### BR-03
A license must be associated with an existing city.

### BR-04
CPF values must be unique.

### BR-05
A license must contain an activity description.

### BR-06
License status must be one of: `ativo`, `vencido`, or `revogado`.

---

# Database Statistics

| Entity          | Description                 |
| --------------- | --------------------------- |
| cidades         | Stores city information     |
| pessoas         | Stores personal information |
| licenciamentos  | Stores licensing records    |

### SQL Concepts Demonstrated

- Database Management
- Table Management
- Data Manipulation
- Data Validation
- Relational Modeling
- Business Rules
- SQL Reporting
- Data Analysis