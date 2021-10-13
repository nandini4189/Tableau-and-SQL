SELECT * FROM
(SELECT 1 FROM DUAL),
(SELECT LEVEL L FROM DUAL CONNECT BY LEVEL <4),
(SELECT LEVEL R FROM DUAL CONNECT BY LEVEL <4); 
		 
         
         
select * from emp

create table stu1(stu_name varchar2(20),subject varchar2(20),marks number)

insert into stu1 values('&stu_name','&subject',&marks)

select * from stu1

select stu_name,max(decode(subject,'english',marks))english,
        max(decode(subject,'chemistry',marks))chemistry,
        max(decode(subject,'physics',marks))physics,
        max(decode(subject,'electronics',marks))electronics
from stu1
group by stu_name
order by 1 asc

commit


SELECT LEVEL,LEVEL+(9*LEVEL)  FROM DUAL CONNECT BY LEVEL<=10;	





select * from stu1


select * from stu1
where length(trim(translate(stu_name,'abcdefghijklmnoprstuvwxyz',' ')))>0 

select 'ramakrishna',regexp_count('ramakrishna','a')"name" from dual;


select substr(str,level,1) from (
select 'umadevi' str from dual)
connect by level <= length(str);




select count(dat) from (select trunc(sysdate,'mm')+level-1 dat from dual
connect by level <= last_day(sysdate)-trunc(sysdate,'mm')+1)
where to_char(dat,'dy') in ('sat','sun');




select count(dat) from (select trunc(sysdate,'mm')+level-1 dat from dual
connect by level <= last_day(sysdate)-trunc(sysdate,'mm')+1)
where to_char(dat,'dy') in ('sat','sun');


select trunc(sysdate,'mm')-1 from dual





Select dbms_metadata.get_ddl (stu1,’table_name’) from dual;


Select table_name, num_rows from emp where table_name=’Emp’;


select * from (select rownum rn,e.* from emp  e)
where rn between 4 and 7;


select * from(select rownum rn,e.* from emp e)
where rn between 6 and 8


select * from (select rownum rn,e.* from emp e)
where rn between 7 and 10


select MAX(SAL) from Emp WHERE SAL NOT IN (select MAX(SAL) from Emp)

select * from emp
commit

select * from emp



select 'ramakrishna',regexp_count('ramakrishna','a') from dual


select length('ramakrishna')-length(replace('ramakrishna','a'))as letter_count from dual


select ename,regexp_count(ename,'a|e|i|o|u',1,'i')as total from emp where ename='SMITH'


select substr(str,level,1)from
(select 'ramakrishna' str from dual)
connect by level<=length(str)


select substr(str,level,1) from
(select ename str from emp)
connect by level<=length(str)


select substr(str,level,1)from
(select 'umadevi' str from dual)
connect by level<=length(str)




CREATE TABLE EMPLOYEE_DATA (
	EMPLOYEE_ID NUMBER(6,0), 
	NAME VARCHAR2(20), 
	SALARY NUMBER(8,2) 
);


INSERT INTO EMPLOYEE_DATA(EMPLOYEE_ID,NAME,SALARY) VALUES(100,'Jennifer',4400);
INSERT INTO EMPLOYEE_DATA(EMPLOYEE_ID,NAME,SALARY) VALUES(100,'Jennifer',4400);
INSERT INTO EMPLOYEE_DATA(EMPLOYEE_ID,NAME,SALARY) VALUES(101,'Michael',13000);
INSERT INTO EMPLOYEE_DATA(EMPLOYEE_ID,NAME,SALARY) VALUES(101,'Michael',13000);
INSERT INTO EMPLOYEE_DATA(EMPLOYEE_ID,NAME,SALARY) VALUES(101,'Michael',13000);
INSERT INTO EMPLOYEE_DATA(EMPLOYEE_ID,NAME,SALARY) VALUES(102,'Pat',6000);
INSERT INTO EMPLOYEE_DATA(EMPLOYEE_ID,NAME,SALARY) VALUES(102,'Pat',6000);
INSERT INTO EMPLOYEE_DATA(EMPLOYEE_ID,NAME,SALARY) VALUES(103,'Den',11000);



SELECT * FROM EMPLOYEE_DATA;

select rowid,
    employee_id,
    name,
    salary,
    ROW_NUMBER() over(partition by employee_id,name,salary order by employee_id) as row_number
from employee_data where row_number >=1




SELECT ROWID,name,salary from(select rowid,
       EMPLOYEE_ID,
       NAME,SALARY, 
       ROW_NUMBER() OVER(PARTITION BY EMPLOYEE_ID,NAME,SALARY ORDER BY EMPLOYEE_ID) AS ROW_NUMBER 
FROM EMPLOYEE_DATA) where ROW_NUMBER >1




delete from employee_data where rowid in(select rowid from(select rowid,employee_id,name,salary ,row_number()
over (partition by rowid,employee_id,name,salary order by employee_id) as row_number from employee_data)  where row_number>1)


DELETE FROM EMP WHERE ROWID IN (
    SELECT ROWID FROM(
        SELECT ROWID,
        ROW_NUMBER() OVER(PARTITION BY ROWID,EMPLOYEE_ID,NAME,SALARY ORDER BY EMPLOYEE_ID) AS ROW_NUMBER 
    FROM EMPLOYEE_DATA)
WHERE ROW_NUMBER > 1);

delete from employee_data where rowid>1



DELETE FROM EMPLOYEE_DATA A WHERE ROWID > (SELECT MIN(ROWID) FROM EMPLOYEE_DATA B WHERE B.EMPLOYEE_ID = A.EMPLOYEE_ID );


select * from employee_data



select * from emp

select * from emp where rownum<=5


select * from emp

minus

select * from emp where rownum<=(select count(*)-5 from emp )


delete from emp where empno in(7935,8679)


select max(sal) from emp where sal not in (select max(sal) from emp)

select max(sal) from emp



with temp 
as(select max(sal) from emp where sal not in (select max(sal) from emp)
 )
select a.* from emp a join temp b on a.sal=b.sal

SELECT salary FROM(
SELECT salary FROM Employee_data ORDER BY salary DESC)
where rownum<3



commit




select * from emp


select * from emp

1.select min(sal) 
from emp 
group by sal 
having  min(sal)>1000


2.select ename,hiredate
from emp where 
to_char(hiredate,'yyyy') between 1980 and 1981

3.select ename,hiredate,sal from emp 
where deptno in(10,20)


select ename,hiredate,sal,job 
from emp 
where hiredate >'01-jan-1980'



commit






























