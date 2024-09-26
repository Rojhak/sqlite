-- SQLite
SELECT * FROM employees
-- Write a query to find the names (first_name, last_name) and hire date of the employees who were hired after 'Jones'.
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date > (
SELECT hire_date FROM employees 
WHERE  last_name  =  "Jones")

--Write a query to get the department name and number of employees in the department.
SELECT department.department_name, COUNT(employees.employee_id) FROM department 
JOIN employees 
ON  department.department_id = employees.department_id 
GROUP BY department.department_id
ORDER BY COUNT(employees.employee_id) DESC 

