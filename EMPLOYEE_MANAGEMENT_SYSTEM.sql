create database if not exists Employee_Management_System;
use Employee_Management_System;

-- Table 1: Job Department
CREATE TABLE if not exists JobDepartment (
    Job_ID INT PRIMARY KEY,
    jobdept VARCHAR(50),
    `name` VARCHAR(100),
    `description` TEXT,
    salaryrange VARCHAR(50)
);

select * from jobdepartment;

-- Table 2: Salary/Bonus
CREATE TABLE SalaryBonus (
    salary_ID INT PRIMARY KEY,
    Job_ID INT,
    amount DECIMAL(10,2),
    annual DECIMAL(10,2),
    bonus DECIMAL(10,2),
    CONSTRAINT fk_salary_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(Job_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

select * from salarybonus;

-- Table 3: Employee
CREATE TABLE Employee (
    emp_ID INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    contact_add VARCHAR(100),
    emp_email VARCHAR(100) UNIQUE,
    emp_pass VARCHAR(50),
    Job_ID INT,
    CONSTRAINT fk_employee_job FOREIGN KEY (Job_ID)
        REFERENCES JobDepartment(Job_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

select * from employee;

-- Table 4: Qualification
CREATE TABLE Qualification (
    QualID INT PRIMARY KEY,
    Emp_ID INT,
    `Position` VARCHAR(50),
    Requirements VARCHAR(255),
    Date_In DATE,
    CONSTRAINT fk_qualification_emp FOREIGN KEY (Emp_ID)
        REFERENCES Employee(emp_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

select * from qualification;

-- Table 5: Leaves
CREATE TABLE if not exists Leaves (
    leave_ID INT PRIMARY KEY,
    emp_ID INT,
    `date` DATE,
    reason TEXT,
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

select * from leaves;

-- Table 6: Payroll
CREATE TABLE Payroll (
    payroll_ID INT PRIMARY KEY,
    emp_ID INT,
    job_ID INT,
    salary_ID INT,
    leave_ID INT,
    `date` DATE,
    report TEXT,
    total_amount DECIMAL(10,2),
    CONSTRAINT fk_payroll_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(job_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_salary FOREIGN KEY (salary_ID) REFERENCES SalaryBonus(salary_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_leave FOREIGN KEY (leave_ID) REFERENCES Leaves(leave_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);
select * from jobdepartment;
select * from salarybonus;
select * from employee;
select * from qualification;
select * from leaves;
select * from payroll;

-- Analysis
-- How many unique employees are currently in the system?
select count(emp_ID) as employee_count from employee;

-- Which departments have the highest number of employees?
select d.jobdept
from jobdepartment d
inner join employee e
using(job_id)
group by d.jobdept
having count(e.emp_id) =(
	select max(employee_count) from
    (
		select count(e2.emp_id) as employee_count
            from jobdepartment d2
            inner join employee e2
            using(job_id)
            group by d2.jobdept
	) as dept_count
);

-- What is the average salary per department?
select d.jobdept,
	   avg(s.amount) as average_salary
from employee e
inner join jobdepartment d
using(job_id)
inner join salarybonus s
using(job_id)
group by jobdept;

-- Who are the top 5 highest-paid employees?
select e.emp_id, 
	   concat(e.firstname," ",e.lastname) as fullname,
       s.amount
from employee e
inner join salarybonus s
using(job_id)
order by s.amount desc
limit 5;

-- What is the total salary expenditure across the company?
select sum(annual+bonus) as total_expenditure
from salarybonus;

-- How many different job roles exist in each department?
select jobdept,
	   count(distinct `name`) as number_of_job_roles
from jobdepartment
group by jobdept
order by jobdept;

-- What is the average salary range per department?
select d.jobdept,
	   avg(s.amount) as average_salary
from jobdepartment d
inner join salarybonus s
using(job_id)
group by d.jobdept
order by average_salary desc;

-- Which job roles offer the highest salary?
select d.`name`, s.amount
from jobdepartment d
inner join salarybonus s
using(job_id)
order by s.amount desc
limit 1;

-- Which departments have the highest total salary allocation?
select d.jobdept, sum(s.amount + s.bonus) as total_salary
from jobdepartment d
inner join salarybonus s
using(job_id)
group by d.jobdept
order by total_salary desc
limit 1;

-- How many employees have at least one qualification listed?
SELECT COUNT(*) AS employees_with_qualification
FROM qualification
WHERE requirements IS NOT NULL
  AND requirements <> '';

-- Which positions require the most qualifications?
SELECT 
    q.Position,
    COUNT(q.QualID) AS qualification_count
FROM Qualification q
GROUP BY q.Position
ORDER BY qualification_count DESC;

-- Which employees have the highest number of qualifications?
SELECT 
    e.emp_ID,
    CONCAT(e.firstname, ' ', e.lastname) AS fullname,
    COUNT(q.QualID) AS qualification_count
FROM Employee e
INNER JOIN Qualification q
    ON e.emp_ID = q.Emp_ID
GROUP BY e.emp_ID, e.firstname, e.lastname
ORDER BY qualification_count DESC
;

-- Which year had the most employees taking leaves?
SELECT 
    YEAR(l.date) AS leave_year,
    COUNT(DISTINCT l.emp_id) AS employee_count
FROM Leaves l
GROUP BY YEAR(l.date)
ORDER BY employee_count DESC
LIMIT 1;

-- What is the average number of leave days taken by its employees per department?
SELECT 
    d.jobdept,
    ROUND(
        COUNT(l.leave_ID) / COUNT(DISTINCT e.emp_ID),
        2
    ) AS average_leave_days
FROM Employee e
INNER JOIN JobDepartment d
    ON e.job_ID = d.job_ID
INNER JOIN Leaves l
    ON e.emp_ID = l.emp_ID
GROUP BY d.jobdept
ORDER BY average_leave_days DESC;

-- Which employees have taken the most leaves?
SELECT 
    e.emp_ID,
    CONCAT(e.firstname, ' ', e.lastname) AS fullname,
    COUNT(l.leave_ID) AS total_leaves
FROM Employee e
INNER JOIN Leaves l
    ON e.emp_ID = l.emp_ID
GROUP BY e.emp_ID, e.firstname, e.lastname
ORDER BY total_leaves DESC;

-- What is the total number of leave days taken company-wide?
SELECT COUNT(leave_ID) AS total_leave_days
FROM Leaves;

-- How do leave days correlate with payroll amounts?
SELECT 
    e.emp_ID,
    CONCAT(e.firstname, ' ', e.lastname) AS fullname,
    COALESCE(l.total_leave_days, 0) AS total_leave_days,
    COALESCE(p.total_payroll, 0) AS total_payroll
FROM Employee e

LEFT JOIN (
    SELECT 
        emp_ID,
        COUNT(leave_ID) AS total_leave_days
    FROM Leaves
    GROUP BY emp_ID
) l
    ON e.emp_ID = l.emp_ID

LEFT JOIN (
    SELECT 
        emp_ID,
        SUM(total_amount) AS total_payroll
    FROM Payroll
    GROUP BY emp_ID
) p
    ON e.emp_ID = p.emp_ID

ORDER BY total_leave_days DESC;

-- What is the total monthly payroll processed?
SELECT 
    SUM(total_amount) AS total_monthly_payroll
FROM Payroll;

-- What is the average bonus given per department?
SELECT 
    d.jobdept,
    ROUND(AVG(s.bonus), 2) AS average_bonus
FROM JobDepartment d
INNER JOIN SalaryBonus s
    USING (job_id)
GROUP BY d.jobdept
ORDER BY average_bonus DESC;

-- Which department receives the highest total bonuses?
SELECT 
    d.jobdept,
    SUM(s.bonus) AS total_bonus
FROM JobDepartment d
INNER JOIN SalaryBonus s
    USING (job_id)
GROUP BY d.jobdept
ORDER BY total_bonus DESC
LIMIT 1;

-- What is the average value of total_amount after considering leave deductions?
SELECT 
    ROUND(AVG(total_amount), 2) AS average_payroll_after_leave_deductions
FROM Payroll;



