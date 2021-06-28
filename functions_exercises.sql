use employees;
describe employees;
select concat(first_name, " ", last_name) as full_name from employees where last_name like 'e%e'; # 2. 
select upper(concat(first_name, " ", last_name)) as full_name from employees where last_name like 'e%e'; # 3
select datediff(curdate(), hire_date) as days_employed from employees where hire_date like '199%' and birth_date like '%12-25'; # 4
describe salaries;
select min(salary), max(salary) from salaries; # 5

select # 6.
	concat(lower(substr(first_name, 1, 1)), lower(substr(last_name, 1, 4)), "_", substr(birth_date, 6, 2), substr(birth_date, 3, 2)) as username,
	first_name,
	last_name,
	birth_date
from employees;

/*
use employees;
describe employees;
select distinct title from titles; # 2a.
select distinct last_name from employees order by last_name DESC limit 10; # 2b.
select * from employees where (month(birth_date) = 12 and day(birth_date) = 25) and (year(hire_date) between 1990 and 1999) order by hire_date limit 5; # 3. Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup
select * from employees where (month(birth_date) = 12 and day(birth_date) = 25) and (year(hire_date) between 1990 and 1999) order by hire_date limit 5 offset 50; # 4. Christophe Baca, Moie Birsak, Chikako Ibel, Shounak Jansen, Zhigen Boissier
*/

/*
use employees;
describe employees;
select * from employees where first_name in ('irena', 'vidya', 'maya') order by first_name; # 2. Irena Reutenauer, Vidya Simmen
select * from employees where first_name in ('irena', 'vidya', 'maya') order by first_name, last_name; # 3. Irena Acton, Vidya Zweizig
select * from employees where first_name in ('irena', 'vidya', 'maya') order by last_name, first_name; # 4. Irena Acton, Maya Zyda
select * from employees where last_name like 'e%e' order by emp_no; # 5. 899 rows, Ramzi Erde, Tadahiro Erde
select * from employees where last_name like 'e%e' order by hire_date DESC; #6. 899 rows, Teiji Eldridge, Sergi Erde
select * from employees where (month(birth_date) = 12 and day(birth_date) = 25) and (year(hire_date) between 1990 and 1999) order by birth_date ASC, hire_date DESC; # 7. 362 rows, Khun Bernini, Douadi Pettis
*/

/*
use employees; # 1.
describe employees;
select * from employees where first_name in ('irena', 'vidya', 'maya') order by first_name ASC; # 2. 709 rows
select * from employees where first_name = 'irena' or first_name = 'vidya' or first_name = 'maya'; # 3. 709 results as previous
select * from employees where (first_name = 'irena' or first_name = 'vidya' or first_name = 'maya') and gender = 'M'; # 4. 441 rows
select * from employees where last_name like 'e%'; # 5. 7330 rows
select * from employees where last_name like 'e%' or last_name like '%e'; # 6a. 30723 rows
select * from employees where last_name like '%e'; # 6b. 24292 rows
select * from employees where last_name like 'e%' and last_name like '%e'; # 7a. 899 rows, answered 7b in 6b
select * from employees where year(hire_date) between 1990 and 1999; # 8. 135214 rows
select * from employees where month(birth_date) = 12 and day(birth_date) = 25; # 9. 842 rows
select * from employees where (month(birth_date) = 12 and day(birth_date) = 25) and (year(hire_date) between 1990 and 1999); # 10. 362 rows
select * from employees where last_name like '%q%'; # 11. 1873 rows
select * from employees where last_name like '%q%' and last_name not like '%qu%'; # 12. 547 rows
*/