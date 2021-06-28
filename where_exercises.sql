use employees; # 1.
describe employees;
select * from employees where first_name in ('irena', 'vidya', 'maya'); # 2. 709 rows
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
