create database Company

drop table [Location]
go
drop table [Dependent]
go
drop table WorksOn
go
drop table Projects
go
alter table Department
drop constraint dept_manager_fk
go
drop table Employee
go 
drop table Department


create table Department
(
 Dname varchar(50) not null,
 DeptNo int constraint dept_deptno_pk primary key

)

create table Employee
(
Empno int constraint emp_empno_pk primary key,
FName varchar(50) not null,
MInit char(1),
LName varchar(50) not null,
Job varchar(50) not null,
Trainee bit,
Superv int constraint emp_supervisor_fk foreign key references Employee(Empno), 
Gender char(1) check(Gender in ('M','F')),
Birthdate DATETIME,
Hiredate DATE,
Sallary float not null,
Commission float,
DeptNo int constraint emp_deptno_fk foreign key references Department(DeptNo)


)

insert into Department values('ACCOUNTING',10)
insert into Department values('RESEARCH',20)
insert into Department values('SALES',30)
insert into Department values('OPERATIONS',40)

insert into Employee values(7839, 'James', 'L', 'KING', 'President', 0,null, 'M', '1942-12-31','1972-11-30',5000, NULL, 10)
insert into Employee values(7566,'Jack','J', 'Jones', 'Manager',1,7839,'M', '1942-07-23','1972-06-04',2795,null,20)
insert into Employee values(7698, 'Horace', 'O', 'Blake', 'Manager', 0 ,7839, 'M' ,'1972-11-30','1993-10-28', 2850 ,NULL, 30)
insert into Employee values(7782, 'Terry', 'A', 'Clerk' ,'Manager', 1, 7839,'M', '1982-10-12','2010-09-26', 2450, NULL, 10)
insert into Employee values(7499,'Dave','J', 'Allen', 'Developer',0,7698,'M', '1949-09-13','1983-08-25',1600,300,30)
insert into Employee values(7521,'Samuel','D', 'Ward', 'Salesman',1,7698,'M', '1934-08-14','1985-07-01',1250,500,30)
insert into Employee values(7654, 'Jeans', 'J', 'Martin', 'Salesman', 1 ,7698, 'F', '1978-07-23','1995-06-04', 1250 ,1400 ,30)
insert into Employee values(7844, 'Tina','E' ,'Turner', 'Salesman', 1 ,7698, 'F', '1978-05-11','1992-04-12' ,1500 ,0, 30)
insert into Employee values(7934, 'Marcus', 'G', 'Miller', 'Clerk', 1, 7782 ,'M', '1981-03-09','2003-02-12',1300, NULL,10)
insert into Employee values(7369,'Harald','H', 'Smith', 'Clerk',1,7934,'M', '1966-02-23','2004-01-27',800,null,20)
insert into Employee values(7788, 'Taylor','R' ,'Scott', 'Analyst', 0, 7566,'M' ,'1956-06-21','1989-05-24', 3000, NULL, 20)
insert into Employee values(7876,'John' ,'R' ,'Ford' ,'Analyst ',0, 7566, 'M' ,'1985-04-01' ,'2002-03-17' ,3000 ,NULL, 20)


alter table Department
add numOfEMps int

alter table Department
add ManEmpNo int constraint dept_manager_fk foreign key references Employee(Empno)

alter table Department
add StartDate datetime

update Department
set ManEmpNo = 7499 where DeptNo = 10;

update Department
set ManEmpNo = 7788 where DeptNo = 20;

update Department
set ManEmpNo = 7566 where DeptNo = 30;

update Department
set ManEmpNo = 7698 where DeptNo = 40;

update Department
set StartDate = GETDATE();

update Department
set NumOfEmps = (select count(*) from Employee where Employee.DeptNo = Department.DeptNo);


create table [Location]
(
  DeptNo int foreign key references Department(DeptNo),
  [Location] varchar(50)
  constraint Location_DeptNo_Loc_PK primary key(DeptNo,Location)

)

insert into Location values (10,'New York')
insert into Location values (10,'Houston')
insert into Location values (20,'Dallas')
insert into Location values (30,'Chicago')
insert into Location values (30,'Tafford')
insert into Location values (30,'New York')
insert into Location values (40,'Boston')

create table Projects
(

 ProName varchar(50) unique not null,
 ProNo int constraint projects_proNo_pk primary key,
 ProLocation varchar(50) not null,
 DeptNo int constraint project_deptNo_fk foreign key references Department(DeptNo)
)

insert into Projects values ('PRODUCTX',1,'New York',10)
insert into Projects values ('PRODUCTY',2,'Houston',20)
insert into Projects values ('PRODUCTZ',3,'Dallas',30)
insert into Projects values ('COMPUTERIZATION',10,'Chicago',30)
insert into Projects values ('REORGANIZATION',20,'Stafford',30)
insert into Projects values ('NEWBENEFITS',30,'New York',30)

create table WorksOn
(
  EmpNo int constraint WorksOn_EmpNo_fk foreign key references Employee(EmpNo),
  ProNo int constraint WorksOn_ProNo_fk foreign key references Projects(ProNo),
  Hours int not null
  constraint WorksOn_EmpNo_ProNo_pk primary key(EmpNo,ProNo)
)

insert into WorksOn values(7499,1,12)
insert into WorksOn values(7934,2,10)
insert into WorksOn values(7844,2,23)
insert into WorksOn values(7782,30,58)
insert into WorksOn values(7934,3,6)


create table [Dependent]
(
 EmpNo int constraint Depend_EmpNo_fk foreign key references Employee(EmpNo),
 [Name] varchar(50),
 Relation varchar(50),
 Gender char(1) check(Gender in ('M','F')),
 Birthdate DATE,
 constraint Depened_EmpNo_Name_pk primary key(EmpNo,[Name])
)

insert into [Dependent] values (7839,'Prince','son','M','1987-11-01')
insert into [Dependent] values (7839,'Princess','daughter','M','1987-11-01')
insert into [Dependent] values (7839,'Queen','wife','F','1965-12-24')
insert into [Dependent] values (7839,'Sammy','father','M','1932-05-21')

