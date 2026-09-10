# SQL ↔ Pandas Integration

This repository contains my learning and practice on connecting **MySQL with Python and Pandas**.

## What I Learned

- MySQL Server vs MySQL Workbench
- Connecting Python with MySQL
- Using `mysql.connector`
- Reading MySQL data into Pandas
- Using `pd.read_sql()`
- Writing Pandas DataFrames to MySQL
- Using SQLAlchemy
- Using `df.to_sql()`
- Running SQL queries before performing analysis in Pandas

## Architecture

```text
MySQL Server
     ↕
MySQL Connector / SQLAlchemy
     ↕
   Python
     ↕
   Pandas
```

MySQL Workbench is used as a graphical interface to work with the MySQL Server. It is not the Python-to-MySQL connector.

## Project Structure

```text
sql-pandas-integration/
│
├── README.md
├── requirements.txt
│
├── sql/
│   └── database_setup.sql
│
├── python/
│   └── sql_pandas.py
│
└── data/
    └── README.md
```

## Installation

Clone the repository:

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

Move into the project:

```bash
cd sql-pandas-integration
```

Install the required packages:

```bash
pip install -r requirements.txt
```

## MySQL Setup

Open MySQL Workbench and run:

```sql
CREATE DATABASE college;

USE college;

CREATE TABLE students (
    id INT,
    name VARCHAR(50),
    cgpa FLOAT,
    iq INT
);

INSERT INTO students VALUES
(1, 'Rahul', 8.5, 120),
(2, 'Aman', 7.2, 110),
(3, 'Sara', 9.1, 130);
```

## MySQL → Pandas

Python can execute a SQL query and load the result into a Pandas DataFrame.

```python
import pandas as pd
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="YOUR_PASSWORD",
    database="college"
)

query = "SELECT * FROM students"

df = pd.read_sql(query, conn)

print(df)

conn.close()
```

## Pandas → MySQL

A Pandas DataFrame can also be written back to MySQL using SQLAlchemy.

```python
from sqlalchemy import create_engine

engine = create_engine(
    "mysql+pymysql://root:YOUR_PASSWORD@localhost/college"
)

df.to_sql(
    "students_copy",
    engine,
    if_exists="replace",
    index=False
)
```

## Important Functions

| Direction | Function |
|---|---|
| MySQL → Pandas | `pd.read_sql()` |
| Pandas → MySQL | `df.to_sql()` |

## Why Use SQL and Pandas Together?

SQL is useful for retrieving and filtering data directly from a database.

For example:

```sql
SELECT name, cgpa
FROM students
WHERE cgpa > 8;
```

Pandas can then be used for:

- Data cleaning
- Exploratory Data Analysis
- Visualization
- Feature engineering
- Machine learning preparation

A typical data workflow is:

```text
MySQL Database
      ↓
    SQL
      ↓
Pandas DataFrame
      ↓
Data Cleaning / EDA
      ↓
Feature Engineering
      ↓
Machine Learning
```

## Security Note

Never upload real database passwords, API keys, or other credentials to GitHub.

The examples in this repository use:

```text
YOUR_PASSWORD
```

instead of a real password.

## Learning Goal

The purpose of this repository is to understand the practical workflow of moving data between **MySQL and Pandas** and using both tools together in a data science / machine learning workflow.
