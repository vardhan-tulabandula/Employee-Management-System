# Employee-Management-System
SQL-based Employee Management System for HR, salary, qualification, leave, and payroll analysis.

# 📊 Employee Management System | SQL Project

A SQL-based Employee Management System designed to store, manage, and analyze employee, job department, salary, qualification, leave, and payroll data.

The project demonstrates how relational database design and SQL analytics can be used to generate meaningful HR and workforce insights.

📌 Project Overview

The Employee Management System contains a structured relational database with six major areas:

Job Department

Salary & Bonus

Employee

Qualification

Leaves

Payroll

The project uses primary keys and foreign keys to establish relationships between the tables and SQL queries to perform business-oriented analysis.

🎯 Project Objectives

The main objectives of this project are:

Design a structured employee management database

Establish relationships between employee-related entities

Analyze employee distribution across departments

Analyze salary and bonus information

Identify the highest-paid employees and job roles

Analyze employee qualifications

Study employee leave patterns

Analyze payroll information

Generate department-wise HR insights using SQL

🗂️ Database Structure

1. JobDepartment

Stores information about job departments and roles.

Main columns:

Job_ID

jobdept

name

description

salaryrange

2. SalaryBonus

Stores salary, annual salary, and bonus information.

Main columns:

salary_ID

Job_ID

amount

annual

bonus

3. Employee

Stores employee personal and job information.

Main columns:

emp_ID

firstname

lastname

gender

age

contact_add

emp_email

emp_pass

Job_ID

4. Qualification

Stores employee qualification and position-related information.

Main columns:

QualID

Emp_ID

Position

Requirements

Date_In

5. Leaves

Stores employee leave records.

Main columns:

leave_ID

emp_ID

date

reason

6. Payroll

Stores payroll transactions and reports.

Main columns:

payroll_ID

emp_ID

job_ID

salary_ID

leave_ID

date

report

total_amount

🔗 Database Relationships

The project uses foreign-key relationships to connect the tables.

SalaryBonus.Job_ID → JobDepartment.Job_ID

Employee.Job_ID → JobDepartment.Job_ID

Qualification.Emp_ID → Employee.emp_ID

Leaves.emp_ID → Employee.emp_ID

Payroll.emp_ID → Employee.emp_ID

Payroll.job_ID → JobDepartment.Job_ID

Payroll.salary_ID → SalaryBonus.salary_ID

Payroll.leave_ID → Leaves.leave_ID

This creates a relational structure that allows employee, salary, qualification, leave, and payroll information to be analyzed together.

📈 SQL Analysis Performed

The project includes SQL queries to answer business questions such as:

Employee Analysis

How many employees are currently in the system?

Which departments have the highest number of employees?

Who are the top 5 highest-paid employees?

Salary & Compensation Analysis

What is the average salary per department?

What is the total salary expenditure?

Which job role offers the highest salary?

Which department has the highest total salary allocation?

What is the average bonus per department?

Which department receives the highest total bonuses?

Job & Qualification Analysis

How many different job roles exist in each department?

How many employees have at least one qualification?

Which positions require the most qualifications?

Which employees have the highest number of qualifications?

Leave Analysis

Which year had the most employees taking leaves?

What is the average number of leave days per department?

Which employees have taken the most leaves?

What is the total number of leave days taken company-wide?

How do leave days relate to payroll amounts?

Payroll Analysis

What is the total monthly payroll processed?

What is the average payroll amount after considering leave deductions?

🛠️ Technologies & SQL Concepts

Technology

MySQL

SQL

Git

GitHub

VS Code

SQL Concepts Used

CREATE DATABASE

CREATE TABLE

Primary Keys

Foreign Keys

INNER JOIN

LEFT JOIN

GROUP BY

HAVING

ORDER BY

LIMIT

Aggregate Functions

COUNT()

SUM()

AVG()

ROUND()

COUNT(DISTINCT ...)

COALESCE()

Subqueries

Derived Tables

CASE concepts

Date functions such as YEAR()

📁 Project Structure

Employee-Management-System/
│
├── EMPLOYEE_MANAGEMENT_SYSTEM.sql
├── README.md
├── ER_Diagram.png

⚙️ How to Run the Project

Step 1: Install MySQL

Install MySQL Server and MySQL Workbench on your Mac.

You can also use another MySQL-compatible SQL client.

Step 2: Clone the Repository

Open Terminal and run:

git clone YOUR_GITHUB_REPOSITORY_URL

Move into the project directory:

cd Employee-Management-System

Step 3: Open the SQL File

Open:

EMPLOYEE_MANAGEMENT_SYSTEM.sql

using MySQL Workbench or another MySQL client.

Step 4: Execute the SQL Script

Run the complete SQL script.

The script:

Creates the database

Selects the database

Creates the required tables

Defines primary and foreign keys

Runs employee management and analytical queries

Step 5: Verify the Database

Run:

USE Employee_Management_System;

SELECT * FROM JobDepartment;
SELECT * FROM SalaryBonus;
SELECT * FROM Employee;
SELECT * FROM Qualification;
SELECT * FROM Leaves;
SELECT * FROM Payroll;

💡 Key Insights

The SQL analysis provides insights into:

Employee distribution across departments

Department-wise salary levels

Highest-paid employees and job roles

Salary allocation across departments

Qualification distribution

Leave usage patterns

Payroll amounts

Bonus distribution

Relationship between employee leave records and payroll

These analyses demonstrate how SQL can be used to convert structured employee records into useful HR and workforce information.

📊 Sample Business Questions

Some of the business questions addressed in this project include:

Which department has the highest number of employees?

Which employees are among the highest paid?

Which department has the highest average salary?

Which job role offers the highest salary?

Which department receives the highest total bonus?

Which employees have the highest number of qualifications?

Which year recorded the highest number of employees taking leaves?

Which employees have taken the most leaves?

What is the total monthly payroll processed?

Future Improvements

The project can be extended by adding:

Employee promotion and career progression analysis

Employee performance data

Attendance tracking

Recruitment data

Employee attrition analysis

Department-wise dashboards

Power BI or Tableau visualization

Stored procedures

Triggers

SQL views for frequently used HR reports

Automated HR reporting

👨‍💻 Author

Vishnu Vardhan

B.Tech – Artificial Intelligence & Data Science

Interested in Data Analytics, Business Intelligence, Data Science, and AI/ML.

🙏 Acknowledgements

Special thanks to Innomatics Research Labs for providing the learning opportunity and practical exposure that supported this project.

Thanks to my Trainer Taruni Thathari and Mentor Vishnu Vardhan Deshmuk for their guidance, feedback, and support throughout the project.

📄 License

This project is intended for educational and portfolio purposes.
