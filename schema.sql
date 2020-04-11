-- Data Engineering --

DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS department_employees CASCADE;
DROP TABLE IF EXISTS department_managers CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS titles CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;

-- Creating the Departments table with its primary key
CREATE TABLE departments (
    dept_no 	VARCHAR(10)		NOT NULL PRIMARY KEY,
    dept_name	VARCHAR(255)	NOT NULL
);

-- Creating the Employees table with its primary key
CREATE TABLE employees (
    emp_no 		INT   			NOT NULL PRIMARY KEY,
    birth_date 	DATE   			NOT NULL,
    first_name 	VARCHAR(50)   	NOT NULL,
    last_name 	VARCHAR(50)   	NOT NULL,
    gender 		VARCHAR(3)   	NOT NULL, -- assuming entries of M, F, X, and potentially N/A
    hire_date 	DATE   			NOT NULL
);

-- Creating the Department Employees table with both foreign keys
CREATE TABLE department_employees (
    emp_no 		INT   			NOT NULL,
	FOREIGN KEY (emp_no) 		REFERENCES employees(emp_no),
    dept_no 	VARCHAR(10)   	NOT NULL,
	FOREIGN KEY (dept_no) 		REFERENCES departments(dept_no),
    from_date 	DATE   			NOT NULL,
    to_date 	DATE  			NOT NULL
);

-- Creating the Department Managers table with both foreign keys
CREATE TABLE department_managers (
    dept_no 	VARCHAR(10)   	NOT NULL,
	FOREIGN KEY (dept_no) 		REFERENCES departments(dept_no),
    emp_no 		INT   			NOT NULL,
	FOREIGN KEY (emp_no) 		REFERENCES employees(emp_no),
    from_date 	DATE   			NOT NULL,
    to_date 	DATE   			NOT NULL
);

-- Creating the Employee Salaries table with a foreign key for employee number only
CREATE TABLE salaries (
    emp_no 		INT   			NOT NULL,
	FOREIGN KEY (emp_no) 		REFERENCES employees(emp_no),
    salary 		INT   			NOT NULL,
    from_date 	DATE  			NOT NULL,
    to_date 	DATE   			NOT NULL
);

-- Creating the Employee Titles table with a foreign key for employee number only
CREATE TABLE titles (
    emp_no 		INT   			NOT NULL,
	FOREIGN KEY (emp_no) 		REFERENCES employees(emp_no),
    title 		VARCHAR(50)   	NOT NULL,
    from_date 	DATE   			NOT NULL,
    to_date 	DATE   			NOT NULL
);

-- Check all of our tables
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM department_employees;
SELECT * FROM department_managers;
SELECT * FROM salaries;
SELECT * FROM titles;
