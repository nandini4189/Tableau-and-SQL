/*PROCEDURES*/
--------------
Stored Procedure is a named plsql block to perfrom tasks. (DML operations)
May or may not reurun value
Combination of header (specification of proc name) and body (solving actual task)
Accepts parameters IN,OUT,INOUT

PROCEDURE SYNTAX:

CREATE OR REPLACE PROCEDURE name
[(parameter[, parameter, ...])]
AS/IS
[local declarations]
BEGIN
executable statements
[EXCEPTION
exception handlers]
END [name];


--IN Parameter--

--single row
create or replace procedure p_emp_names (p_empno in number)
is
emp_name emp.ename%type;
begin
select ename into emp_name from emp where empno = p_empno;
dbms_output.put_line(emp_name);
exception when no_data_found then dbms_output.put_line(sqlerrm);
end;

exec p_emp_names(actual parameters);

begin
p_emp_names;
end;

call p_emp_names(actual parameters);


--multiple row
create or replace procedure p_enames (p_deptno in number)
is
cursor c_emp is select  * from emp where deptno = p_deptno;
begin
for r_emp in c_emp
loop
dbms_output.put_line(r_emp.ename);
end loop;
end;

exec p_enames(10);

begin
p_enames(20);
end;


--OUT Parameter--

create or replace procedure p_square (p_in in number,p_out out number)
as
begin
p_out := p_in*p_in;
end;

--using plsql block
declare
v number;
begin
p_square(5,v);
dbms_output.put_line(v);
end;

--using bind variable
variable v number;
exec p_square(5,:v);
print v;


--INOUT Parameter--
create or replace procedure p_inout(a in out number)
is
begin
a:=a*a;
dbms_output.put_line(a);
end;


--bind variable
variable v number;
exec :v := 8;
exec p_inout(:v);


--using plsql block
declare
v number:=&number;
begin
p_inout(v);
end;






/*FUNCTIONS*/
-------------
A function that is stored in the database is much like a procedure in that it is a named PL/SQL block that can take parameters and be invoked.
The significant difference is that a function is a PL/SQL block that returns a single value. 
Functions can accept one, many, or no parameters, but a function must have a return clause in the executable section of the function. 
The datatype of the return value must be declared in the header of the function.

FUNCTION SYNTAX:

CREATE [OR REPLACE] FUNCTION function_name
(parameter list)
RETURN datatype
IS
BEGIN
<body>
RETURN (return_value);
END;


create or replace function f_exam(input varchar2)
return varchar2
is
begin 
return input;
end;

select f_exam('Hello World') from dual;

declare
op varchar2(100);
begin
op:=f_exam('as');
dbms_output.put_line(op);
end;


variable op varchar2(100);
begin
:op := f_exam('asdf');
end;
/
print op;


CREATE OR REPLACE FUNCTION show_description
(i_course_no course.course_no%TYPE)
RETURN varchar2
AS
v_description varchar2(50);
BEGIN
SELECT description
INTO v_description
FROM course
WHERE course_no = i_course_no;
RETURN v_description;
EXCEPTION
WHEN NO_DATA_FOUND
THEN
RETURN('The Course is not in the database');
WHEN OTHERS
THEN
RETURN('Error in running show_description');
END;


select show_description(10) from dual;

SELECT course_no, show_description(course_no) FROM course;




/*TRIGGERS*/
------------

A database trigger is a named PL/SQL block stored in a database and executed implicitly when a triggering event occurs.
The act of executing a trigger is called firing the trigger.

Triggering event can be one of the following:

. A DML statement (such as INSERT, UPDATE, or DELETE) executed against a database table. Such a trigger can fire before or after a triggering event. 
. A DDL statement (such as CREATE or ALTER) executed either by a particular user against a schema or by any user. Such triggers are often used for auditing purposes and are specifically
  helpful to Oracle DBAs. They can record various schema changes, when they were made, and by which user.
. A system event such as startup or shutdown of the database.
. A user event such as logon and logoff. 


TRIGGER SYNTAX:

CREATE [OR REPLACE] TRIGGER Ttrigger_name
{BEFORE|AFTER} Triggering_event ON table_name
[FOR EACH ROW]
[FOLLOWS another_trigger]
[ENABLE/DISABLE]
[WHEN condition]
DECLARE
declaration statements
BEGIN
executable statements
EXCEPTION
exception-handling statements
END;




CREATE OR REPLACE TRIGGER trg_emp_dup
BEFORE INSERT ON emp_dup
FOR EACH ROW
BEGIN
:NEW.empno := seq_emp_dup_empno.NEXTVAL;
END;



create or replace trigger trg_audit_on_emp_dup
after insert or update or delete on emp_dup for each row
declare
op_type varchar2(10);
begin
if inserting then op_type := 'I';
elsif updating then op_type := 'U';
elsif deleting then op_type := 'D';
end if;
 insert into aud_emp values( USER,op_type,SYSDATE);
end;



create or replace trigger trg_day_check
before insert on emp
declare
day_num number := to_char(sysdate,'D');
begin
if day_num = 5
then raise_application_error(-20011,'data inserting not allowed on thursday');
end if;
end;


CREATE OR REPLACE TRIGGER Tab_ReadOnly
BEFORE DELETE OR INSERT OR UPDATE
ON Emp
FOR EACH ROW
BEGIN
RAISE_APPLICATION_ERROR(-20201, 'Table Status: READ ONLY.');
END;


/*FUNCTION and TRIGGERS (PostgreSQL)*/
--------------------------------------

--Function creation
create or replace function f_ename (eno integer)
returns text as 
$$
declare 
e_name text ;
begin
	select ename into e_name from emp 
	where empno = eno;
return e_name;
end;
$$ language plpgsql;

--Call function
select f_ename(7839);




--Trigger function creation
create or replace function f_trg_emp ()
returns trigger as 
$$
begin 
	if TG_OP = 'DELETE' then
	insert into emp_audit_new values (old.empno,old.ename,old.job,old.mgr,old.hiredate,old.sal,old.comm,old.deptno);
return old;
end if;
return null;
end;
$$ language plpgsql;


--Creating trigger
create trigger trg_emp_audit
before delete on emp for each row 
execute procedure f_trg_emp()





