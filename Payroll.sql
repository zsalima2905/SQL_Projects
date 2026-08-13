create database Payroll;
Use Payroll;
create table Departments(
 Dept_Id int primary key,
 Dept_Name varchar(20));
 
show databases;
select * from Departments;

create table Employees (
 Dept_Id int ,
 Emp_Id varchar(2) primary key,
Emp_Name varchar(30),
Gender varchar(1),
Age int,
Salary decimal(8,2),
Commission decimal(8,2), 
Doj date, 
Manager_Name varchar(30)
 
 );
describe Employees;
insert into Departments 
values 
 (101, 'IT'),
 (102, 'HR'),
 (103, 'Finance'),
 (104, 'Sales');

insert into Employees
values
 (101, 'A', 'Anitha', 'F',26, 50000, 2000,'2026-05-05', 'Sangeetha'),
 (101, 'B', 'Babu', 'M', 30, 80000, NULL, '2020-03-02', 'Sangeetha'),
 (102, 'C', 'Chandru', 'M', 25, 15000, NULL, '2025-10-02', 'Ganesh'),
 (102, 'D', 'Divya', 'F', 32,70000, 5000, '2019-09-05','Ganesh'),
 (103, 'E', 'Emmy', 'F', 24, 30000,2000, '2026-05-11','Haritha'),
 (103, 'F', 'Florence', 'F', 27,40000, NULL,'2024-04-28', 'Haritha'),
 (103, 'G', 'Gowri', 'F', 31, 65000, NULL, '2018-06-15', 'Haritha'),
 (103, 'H', 'Hari', 'M', 29, 40000, 30000, '2018-08-08','Haritha' ),
 (104, 'I', 'Irin', 'F', 28,35000, 25000, '2020-09-16', 'Manish');

select * from Departments;
select * from Employees;
select count(*) as Total_Employees from Employees;
 
 select ucase(Emp_Name) as Employee_Name from Employees;
select concat(
    ucase(left(Emp_Name,1)),
    lcase(substring(Emp_Name,2))
) as Employee_Name from Employees;
select Emp_Name, length(Emp_Name) as Name_Length from Employees;

select Emp_Name, substr(Emp_Name, 1,3) as First_Three from Employees;

select Emp_Name from Employees where Emp_Name like '%A%';

select trim(Emp_Name) as Employee_Name from Employees;

select e.Emp_Name, d.Dept_Name from Employees e right join Departments d on e.Dept_Id = d.Dept_Id ;

select * from Employees where Commission is Null ; 

select Emp_Name, Salary, Salary + 5000 as Salary_with_Bonus from Employees;

select Emp_Name, Salary, Salary * 12 as Annual_Salary from Employees;

select Dept_Id, max(Salary) as Highest_Salary from Employees group by Dept_Id;

select Dept_Id, min(Salary) as Lowest_Salary from Employees group by Dept_Id; 

select Dept_Id, round(avg(Salary),2) as Average_Salary from Employees group by Dept_Id;

select d.Dept_Name, d.Dept_Id, count(*) as Total_Employees
from Employees e join Departments d on e.Dept_Id = d.Dept_Id group by d.Dept_Name, d.Dept_Id having count(*)>3 ; 

select Emp_name,Doj from employees where year(Doj)= year(current_date());

select Emp_Name, timestampdiff(Month, Doj,current_date()) as Experience_Months from employees;

select Emp_Name,Manager_Name from employees;

select d.Dept_Name, d.Dept_Id, round (avg(Salary),2)as average_salary 
from employees e join Departments d on e.Dept_Id = d.Dept_Id 
group by d.Dept_Name, d.Dept_Id having avg(Salary)> 60000;

select d.dept_Name, sum(e.Salary) as Total_Salary from employees e 
join departments d on e.Dept_Id = d.Dept_Id group by d.Dept_Name;