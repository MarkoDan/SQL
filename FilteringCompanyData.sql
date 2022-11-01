--1. Udskriv Employees der hedder Smith til efternavn. 
select *
from Employee
where Lname='Smith';


--2. Udskriv Employees hvis efternavn begynder med A.
select *
from Employee
where LName like 'A%';


--3. Udskriv Employees hvis efternavn har l som andet bogstav.
select *
from Employee
where Lname like '%l%';


--4. Udskriv Employees som er ansat før 01-01-1981.
select * 
from Employee
where Hiredate < '1981-01-01';


--b. Udskriv Employees som er ansat for mere end 5 år siden.
select * from Employee
where DATEDIFF(YY, Hiredate, getdate()) > 5


--c. Udskriv efternavn og alder ved ansættelsen for alle Employees. Sæt passende 
select LName, DATEDIFF(YY, Birthdate, GETDATE()) as 'Age' from Employee

--d. Udskriv BirthDate for Employees, men fjern klokkeslettet i udskriften.
select format(Birthdate, 'dd-MM-yy') as 'Birthday' from Employee 


--5. Udskriv Employees som ikke har nogen Supervisor.
select * 
from Employee
where Superv is null


--6. Udskriv Emplyees, hvis Job er Clerk og som har en Salary på mere end 1000. Sorter efter navn.
select * from Employee
where Job = 'Clerk' and Sallary > 1000


--7. Udskriv hvad Employees i Department 10 tjener gennemsnit.
select avg(sallary) as average_salary from Employee
where DeptNo = 10 


--8. Udskriv Job-betegnelserne, men kun i et eksemplar hver.
select DISTINCT Job from Employee


--9. Udskriv alle rows i Employee og Department uden where udtryk. Hvor mangeudskrives der? 48 udskrives
select * from Employee,Department


--10. Udskriv alle Employees sammen med deres respektive oplysninger om tilhørende Department.
select * from Employee, Department
where Employee.DeptNo = Department.DeptNo


--11. Udskriv antallet på Employees der tjener mere end 1500? 
select COUNT(*) as 'Number of Emps'from Employee
where Sallary > 1500


--12. Udskriv navn på den/de Employees, der har den højeste Salary.
select FName, Sallary
from Employee
where Sallary = (select MAX(Sallary)from Employee)


--13 A. Udskriv alle Employees, der arbejder i Sales.
select * from Employee
where DeptNo = (Select Department.DeptNo from Department where Department.Dname = 'Sales')


--13 B C. Udskriv alle Employees, der arbejder i et Department, som har Location i New York.
select * from Employee, Department, Location
where Employee.DeptNo = Department.DeptNo and Department.DeptNo = Location.DeptNo and Location.Location = 'New York'


--14  Udskriv de Employees, der ikke er Supervisor for nogen.
select a.FName, a.LName from Employee a
where not exists (select * from Employee b where a.Empno = b.Superv)


--15. Udskriv navn på alle Employees sammen med navn på deres Supervisor. Sæt passende overskrifter(Supervisee og Supervisor)
select E.FName as 'Supervisee', M.FName as 'Supervisor' from Employee E, Employee M
where E.Superv = M.Empno


--16. Udskriv hver Departments navn sammen med gennemsnittet for de tilhørende Employees salary. (Der må ikke benyttes kolonnen NumberOfEmployees)
select DeptNo, AVG(Sallary) as 'Avarage sallary' from Employee
group by DeptNo;


--17. Udskriv Departments, som ikke har nogen Employees tilknyttet.
select Dname from Department d
where not exists(select * from Employee e where d.DeptNo = e.DeptNo)


--18. Udskriv manager og departmentnavn i de Departments, der styrer de Projects, som Ford (eller en anden) arbejder på.
select Dname, ManEmpNo, ProName from Department, Projects
where Department.DeptNo = Projects.DeptNo

--19. Udskriv King sammen med hele familien. Alle navne i en kolonne. (UNION)
select Empno, FName, LName, Gender, Birthdate from Employee
where LName = 'KING'
UNION ALL
select * from Dependent

