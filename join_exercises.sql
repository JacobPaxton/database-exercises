/*
use join_example_db;
describe roles;
select * from roles;
describe users;
select * from users;
select * from roles, users;
select * from users join roles on users.id = roles.id;
select * from users left join roles on users.id = roles.id;
select * from users right join roles on users.id = roles.id;
select role_id, COUNT(*) from users left join roles on users.id = roles.id group by role_id;
*/

# Employees Database
use employees;
show tables; # Identify tables that might include department manager information
describe dept_manager;
select * from dept_manager limit 10; # Contains department number and employee IDs that are managers
select * from departments; # Contains department name and department number, no managerial information
select * from employees limit 10; # Contains name and employee ID, no managerial status info
select * from dept_emp limit 10;
select * from titles limit 10;

# 2. Show each department along with the name of the current manager for that department
select
	dept_name as "Department Name",
	concat(employees.first_name, " ", employees.last_name) as "Department Manager"
from departments
join dept_manager on dept_manager.dept_no = departments.dept_no
join employees on employees.emp_no = dept_manager.emp_no
join titles on titles.emp_no = employees.emp_no
where titles.title = 'Manager' and titles.to_date > curdate();

# 3. Show each department currently managed by women.
select
	dept_name as "Department Name",
	concat(employees.first_name, " ", employees.last_name) as "Department Manager"
from departments
join dept_manager on dept_manager.dept_no = departments.dept_no
join employees on employees.emp_no = dept_manager.emp_no
join titles on titles.emp_no = employees.emp_no
where titles.title = 'Manager' and titles.to_date > curdate() and employees.gender = 'F';

# 4. Find the current titles of employees currently working in the Customer Service departments
-- Understanding the table contents
select * from dept_emp limit 10;
select * from titles limit 10;
select * from departments;
-- Answering the question
select title as Title, COUNT(*) as Count from titles 
join dept_emp on titles.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
where dept_emp.to_date > curdate() and departments.dept_name = 'Customer Service'
group by Title
order by Title;

# 5. Find the current salary of all current managers.
select
	dept_name as "Department Name",
	concat(employees.first_name, " ", employees.last_name) as "Department Manager",
	salaries.salary as Salary
from departments
join dept_manager on dept_manager.dept_no = departments.dept_no
join employees on employees.emp_no = dept_manager.emp_no
join titles on titles.emp_no = employees.emp_no
join salaries on salaries.emp_no = employees.emp_no
where titles.title = 'Manager' and titles.to_date > curdate() and salaries.to_date > curdate()
order by dept_name;

# 6. Find the number of current employees in each department.
select
	departments.dept_no,
	departments.dept_name,
	COUNT(*) as num_employees
from departments
join dept_emp on dept_emp.dept_no = departments.dept_no
join employees on employees.emp_no = dept_emp.emp_no
where dept_emp.to_date > curdate()
group by departments.dept_no, departments.dept_name
order by departments.dept_no;

# 7. Which department has the highest average salary? Hint: Use current not historic information.
select
	dept_name,
	avg(salaries.salary) as average_salary
from departments
join dept_emp on dept_emp.dept_no = departments.dept_no
join employees on employees.emp_no = dept_emp.emp_no
join salaries on salaries.emp_no = employees.emp_no
where dept_emp.to_date > curdate() and salaries.to_date > curdate()
group by dept_name
order by average_salary DESC
limit 1;

# 8. Who is the highest paid employee in the Marketing department?
select
	first_name,
	last_name
from employees
join dept_emp on dept_emp.emp_no = employees.emp_no
join departments on departments.dept_no = dept_emp.dept_no
join salaries on salaries.emp_no = employees.emp_no
where departments.dept_name = 'Marketing' and dept_emp.to_date > curdate()
order by salaries.salary DESC
limit 1;

# 9. Which current department manager has the highest salary?
select
	dept_name as "Department Name",
	concat(employees.first_name, " ", employees.last_name) as "Department Manager",
	salaries.salary as Salary
from departments
join dept_manager on dept_manager.dept_no = departments.dept_no
join employees on employees.emp_no = dept_manager.emp_no
join titles on titles.emp_no = employees.emp_no
join salaries on salaries.emp_no = employees.emp_no
where titles.title = 'Manager' and titles.to_date > curdate() and salaries.to_date > curdate()
order by salary DESC
limit 1;

# 10. BONUS Find the names of all current employees, their department name, and their current manager's name.
