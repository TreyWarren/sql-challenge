---- Data Analysis --------------------------------------------------------------------------

-- Reminder of our tables
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM department_employees;
SELECT * FROM department_managers;
SELECT * FROM salaries;
SELECT * FROM titles;
--------------------------------------------------------------------------------------------

-- 1. List the following details of each employee: 
--		employee number, last name, first name, gender, and salary.
SELECT 	e.emp_no 	 AS "Employee Number", 
		e.last_name  AS "Last Name",
		e.first_name AS "First Name",
		e.gender 	 AS "Gender",
		s.salary 	 AS "Salary"
FROM employees e
LEFT JOIN salaries s ON e.emp_no = s.emp_no
ORDER BY "Employee Number";

--------------------------------------------------------------------------------------------

-- 2. List employees who were hired in 1986.
SELECT 	emp_no 	 	AS "Employee Number", 
		first_name 	AS "First Name",
		last_name  	AS "Last Name",
		hire_date 	AS "Hire Date"
FROM employees 
WHERE hire_date >= '1986-01-01'
AND hire_date <= '1986-12-31'
ORDER BY "Hire Date", "Employee Number";
/* Note: I learned that we could have used to following as well 
		 >>>  WHERE EXTRACT(YEAR FROM hire_date) = 1986  <<<
		 to select the year rather than give the range */
		 
--------------------------------------------------------------------------------------------

-- 3. List the manager of each department with the following information: 
--		department number, department name, the manager's employee number, 
--		last name, first name, and start and end employment dates.
SELECT 	dm.dept_no 	 AS "Department Number", 
		d.dept_name  AS "Department Name",
		dm.emp_no	 AS "Employee Number",
		e.last_name  AS "Last Name",
		e.first_name AS "First Name",
		e.hire_date	 AS "Employment Start Date",
		dm.from_date AS "Managerial Start Date",
		dm.to_date	 AS "Employment End Date"
FROM department_managers dm
LEFT JOIN departments d ON dm.dept_no = d.dept_no
LEFT JOIN employees e ON dm.emp_no = e.emp_no
ORDER BY "Department Number", "Employment End Date";
/* Note: Because some employees were hired and then promoted to manager at a later date, 
		 I included both the employee's hire date and the manager start date. */

--------------------------------------------------------------------------------------------

-- 4. List the department of each employee with the following information: 
--		employee number, last name, first name, and department name.
SELECT	de.emp_no 	 AS "Employee Number",
		e.last_name  AS "Last Name",
		e.first_name AS "First Name",
		d.dept_name	 AS "Department Name"
FROM department_employees de
JOIN employees e ON de.emp_no = e.emp_no 
JOIN departments d ON de.dept_no = d.dept_no
--ORDER BY "Department Name", "Employee Number"
;
/* Note: When I included the ORDER BY statement in an attempt to organize 
		 the employees by department and then sort by Employee Number, 
		 I got a timeout error. I'm very curious to know if this is a 
		 limitation set by pgAdmin or if my computer is just too slow... */
		 
--------------------------------------------------------------------------------------------

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT 	 first_name	AS "First Name",
		 last_name	AS "Last Name"
FROM 	 employees 
WHERE 	 first_name = 'Hercules'
AND 	 last_name LIKE 'B%'
ORDER BY "Last Name";

--------------------------------------------------------------------------------------------

-- 6. List all employees in the Sales department, 
--		including their employee number, last name, first name, and department name.
SELECT	de.emp_no 	 AS "Employee Number",
		e.last_name  AS "Last Name",
		e.first_name AS "First Name",
		d.dept_name	 AS "Department Name"
FROM department_employees de
JOIN employees e ON de.emp_no = e.emp_no 
JOIN departments d ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales'
ORDER BY "Last Name", "First Name"; -- Now the ORDER BY works unlike in question 4! 

--------------------------------------------------------------------------------------------

-- 7. List all employees in the Sales and Development departments, 
--		including their employee number, last name, first name, and department name.
SELECT	de.emp_no 	 AS "Employee Number",
		e.last_name  AS "Last Name",
		e.first_name AS "First Name",
		d.dept_name	 AS "Department Name"
FROM department_employees de
JOIN employees e ON de.emp_no = e.emp_no 
JOIN departments d ON de.dept_no = d.dept_no
WHERE dept_name IN ('Sales', 'Development')
ORDER BY "Last Name", "First Name";

--------------------------------------------------------------------------------------------

-- 8. In descending order, list the frequency count of employee last names, 
--		i.e., how many employees share each last name.
SELECT	last_name	AS "Employee Last Name", 
COUNT(last_name)	AS "Frequency"
FROM employees
GROUP BY last_name
ORDER BY "Frequency" DESC;

--------------------------------------------------------------------------------------------