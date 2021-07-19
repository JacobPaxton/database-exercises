-- 1. How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
-- Understand database, formulate query strategy
show databases;
use employees;
show tables;
select * from dept_emp limit 10;
select * from dept_manager;
select * from dept_manager join salaries using(emp_no) where (dept_manager.to_date > curdate()) and (salaries.to_date > curdate());

-- Move to write-enabled space for temp table creation
show databases;
use germain_1457;
-- Create temp table for dept managers and salaries
-- drop table man_sal;
create temporary table man_sal(
select emp_no, dept_no, salary from employees.dept_manager 
join employees.salaries using(emp_no)
where (dept_manager.to_date > curdate()) 
and (salaries.to_date > curdate())
);
-- Test to see if it worked
select * from man_sal;

-- Create temp table for salary averages per department
drop table dept_sal_avg;
create temporary table dept_sal_avg(
select dept_no, avg(salary) from employees.salaries 
join employees.dept_emp using(emp_no) 
where salaries.to_date > curdate()
group by dept_no);
-- Test to see if it worked
select * from dept_sal_avg;

-- Join the two temporary tables
-- drop table sal_compare;
create temporary table sal_compare(select * from man_sal join dept_sal_avg using(dept_no));
-- Check final results
select * from sal_compare;


-- 2. Use the world database for the questions below.
use world;
describe city;
select * from city limit 10;
describe country;
select * from country limit 10;
describe countrylanguage;
select * from countrylanguage limit 10;

-- What languages are spoken in Santa Monica?
select * from city where Name = 'Santa Monica';
select Language, Percentage
from city 
join countrylanguage using(CountryCode) 
join country on country.Code = countrylanguage.CountryCode 
where city.Name = 'Santa Monica'
order by percentage;

-- How many different countries are in each region?
select region, COUNT(Name) as "CountryCount" 
from country 
group by region 
order by CountryCount;

-- What is the population for each region?
select region, SUM(Population) as Population
from country 
group by region
order by Population DESC;

-- What is the population for each continent?
select continent, SUM(population) as Population
from country 
group by continent
order by Population DESC;

-- What is the average life expectancy globally?
select AVG(LifeExpectancy) from country;

-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
select continent, AVG(LifeExpectancy) as life_expectancy 
from country 
group by continent 
order by life_expectancy;
select region, AVG(LifeExpectancy) as life_expectancy 
from country 
group by region 
order by life_expectancy, region;

-- Bonus
-- Find all the countries whose local name is different from the official name
-- How many countries have a life expectancy less than x?
-- What state is city x located in?
-- What region of the world is city x located in?
-- What country (use the human readable name) city x located in?
-- What is the life expectancy in city x?