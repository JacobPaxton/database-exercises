use employees;
# 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
select
	emp_no as "Employee",
	dept_no as "Department Number",
	from_date as "Start Date",
	to_date as "End Date",
	IF(to_date > curdate(), True, False) as "Is Current Employee"
from dept_emp;

# 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
select 
	concat(first_name, " ", last_name) as employee_name,
	case
		when last_name between 'a%' and 'i%' then 'A-H'
		when substr(last_name, 1, 1) in ('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') then 'I-Q'
		else 'R-Z'
		end as alpha_group
	from employees
order by employee_name;

# 3. How many employees (current or previous) were born in each decade?
select 
	case
		when birth_date like '190%' then "19th_century"
		when birth_date like '191%' then "1910s"
		when birth_date like '192%' then "1920s"
		when birth_date like '193%' then "1930s"
		when birth_date like '194%' then "1940s"
		when birth_date like '195%' then "1950s"
		when birth_date like '196%' then "1960s"
		when birth_date like '197%' then "1970s"
		when birth_date like '198%' then "1980s"
		when birth_date like '199%' then "1990s"
		when birth_date like '20%' then "21st_century"
		end as century,
	COUNT(*) as "Number Born"
from employees
group by century;

# B1. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
select
	case
		when dept_name = 'Customer Service' then "Customer Service"
		when dept_name = 'Finance' then "Finance"
		when dept_name = 'Human Resources' then "Human Resources"
		when dept_name = 'Development' then "Development"
		when dept_name = 'Marketing' then "Marketing"
		when dept_name = 'Production' then "Production"
		when dept_name = 'Quality Management' then "Quality Management"
		when dept_name = 'Research' then "Research"
		when dept_name = 'Sales' then "Sales"
		end as Departments,
	avg(salary) as "Average Salary"
from salaries
join dept_emp using(emp_no)
join departments using(dept_no)
group by Departments
order by Departments;