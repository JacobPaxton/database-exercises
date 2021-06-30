use employees;
show tables;

# 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
select concat(first_name, " ", last_name) as Name 
from employees 
where 
	hire_date = (select hire_date from employees where emp_no = 101010) 
	and
	emp_no in (select emp_no from dept_emp where to_date > curdate());


# 2. Find all the titles ever held by all current employees with the first name Aamod.
----------- using JOIN ----------
select distinct title 
from titles 
join employees using(emp_no) 
join dept_emp using(emp_no) 
where 
	first_name = "Aamod" 
	and 
	dept_emp.to_date > curdate();
-------- using subqueries --------
select distinct title 
from titles 
where 
	emp_no in (select emp_no from employees where first_name = "Aamod") 
	and 
	emp_no in (select emp_no from dept_emp where to_date > curdate());


# 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
# 85108 rows
select * 
from employees 
where 
	emp_no in (select emp_no from dept_emp where to_date < curdate());


# 4. Find all the current department managers that are female. List their names in a comment in your code.
# Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil
select concat(first_name, " ", last_name) as Name
from employees
where
	emp_no in (select emp_no from titles where title = 'Manager' and to_date > curdate())
	and
	gender = 'F';


# 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
select distinct
	concat(first_name, " ", last_name) as "Name"
from employees
join salaries using(emp_no)
where 
	emp_no in (select emp_no from titles where to_date > curdate())
	and
	salary > (select avg(salary) from salaries);


# 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

# B1. Find all the department names that currently have female managers.

# B2. Find the first and last name of the employee with the highest salary.

# B3. Find the department name that the employee with the highest salary works in.