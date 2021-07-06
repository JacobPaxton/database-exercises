use germain_1457;
create temporary table employees_with_departments(first_name VARCHAR(100), last_name VARCHAR(100), dept_name VARCHAR(100));
show tables;
select * from employees_with_departments;
drop table employees_with_departments;

use employees;
create temporary table germain_1457.employees_with_departments as
select concat(first_name, " ", last_name) as "Name",
	departments.dept_name as "Department"
from employees
join dept_emp using(emp_no)
join departments using(dept_no);

use germain_1457;
select * from employees_with_departments;
alter table employees_with_departments add full_name VARCHAR(length(concat(first_name, " ", last_name)));
drop table employees_with_departments;

# 1. Create a temporary table called employees_with_departments that contains first_name, last_name, dept_name for employees currently with that department
use employees;
create temporary table germain_1457.employees_with_departments as
select first_name, last_name, departments.dept_name
from employees
join dept_emp using(emp_no)
join departments using(dept_no);

use germain_1457;
select * from employees_with_departments limit 10;

# 1a. Add a column named full_name to this table. It should be VARCHAR with length first_name + last_name
describe employees_with_departments; -- first_name length 14 last_name length 16, 14 + 16 = 30
alter table employees_with_departments add column full_name VARCHAR(30);
select * from employees_with_departments limit 10;

# 1b. Update the table so that full_name is populated.
update employees_with_departments set full_name = concat(first_name, " ", last_name);
select * from employees_with_departments limit 10;

# 1c. Remove the first_name and last_name columns.
alter table employees_with_departments drop column first_name;
alter table employees_with_departments drop column last_name;
select * from employees_with_departments limit 10;

# 1d. What is another way to end with same results?
# Initialize the table with the full_name column; use germain_1457 instead of use employees when generating the temporary table

# 2. Create a temporary table based on the payment table from the sakila database. Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
use sakila;
show tables;
describe payment;
create temporary table germain_1457.payment_in_cents as
select * from payment;
use germain_1457;
describe payment_in_cents;
select * from payment_in_cents limit 100;
alter table payment_in_cents add amount_in_cents int unsigned not null;
select * from payment_in_cents limit 10;
update payment_in_cents set amount_in_cents = (amount * 100);
select * from payment_in_cents limit 10;

# 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the zscore for salaries. In terms of salary, what is the best department right now to work for? Worst?
use employees;
create temporary table germain_1457.current_dept as -- Create temporary table for each department's current average salary and standard deviation
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
	avg(salary) as avg_sal_cur,
	std(salary) as std_sal_cur
from salaries
join dept_emp using(emp_no)
join departments using(dept_no)
where salaries.to_date > curdate()
group by Departments
order by Departments;

create temporary table germain_1457.alltime_dept as -- Create temporary table for each department's historical average salary and standard deviation
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
	avg(salary) as avg_sal_all,
	std(salary) as std_sal_all
from salaries
join dept_emp using(emp_no)
join departments using(dept_no)
group by Departments
order by Departments;

use germain_1457;
create temporary table cur_v_his_dept as -- Join the current and historical salary tables
select * from current_dept join alltime_dept using(Departments);
select * from cur_v_his_dept;

create temporary table zscore_current_from_alltime as
select Departments, ((avg_sal_cur - avg_sal_all) / std_sal_all) as zscore_cur_from_his from cur_v_his_dept;
select * from zscore_current_from_alltime;