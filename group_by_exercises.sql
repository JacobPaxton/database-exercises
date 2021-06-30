use employees;
describe titles;
select distinct title from titles; # 2. 7 unique titles
describe employees;
select last_name from employees where last_name like 'e%e' group by last_name; # 3. 5 unique names
select last_name, first_name from employees where last_name like 'e%e' group by last_name, first_name; # 4. 846 unique names
select last_name from employees where last_name like '%q%' and last_name not like '%qu%' group by last_name; # 5. 3 unique names
select last_name, COUNT(last_name) from employees where last_name like '%q%' and last_name not like '%qu%' group by last_name; # 6.
select gender, COUNT(*) from employees where first_name in ('irena', 'vidya', 'maya') group by gender; # 7. 441 M, 268

select # 8. To detemine number of duplicates, subtract unique usernames count from total usernames count. Should be 14,158 duplicates
	concat(lower(substr(first_name, 1, 1)), lower(substr(last_name, 1, 4)), "_", substr(birth_date, 6, 2), substr(birth_date, 3, 2)) as username,
	COUNT(*) as number_of_usernames
from employees
group by username
order by number_of_usernames DESC;