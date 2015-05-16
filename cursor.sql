--set serveroutput on
declare 
--declarare cursor
cursor departments_curs is 
  select dp.department_id,dp.department_name
  from departments dp;
-- obiect cursor
departments_rec departments_curs%rowtype;

begin
-- open cursor
if departments_curs%isopen=false then open departments_curs;
end if;

loop
fetch departments_curs into departments_rec;
  exit when departments_curs%notfound;
dbms_output.put_line(
      departments_rec.department_id ||' '||departments_rec.department_name
);
end loop;
close departments_curs;
end;


declare 
--declarare cursor
cursor departments_curs(p in number)
is select dp.department_id,dp.first_name
from employees dp
where department_id=p;
-- obiect cursor
departments_rec departments_curs%rowtype;

begin
if departments_curs%isopen=false then open departments_curs(30);
end if;

loop
fetch departments_curs into departments_rec;
  exit when departments_curs%notfound;
dbms_output.put_line(
      departments_rec.department_id ||' '||departments_rec.first_name
);
end loop;
close departments_curs;
end;

-- exceptii

declare
v_name VARCHAR2(5);
begin
  begin
    v_name:='Andreilol';
    dbms_output.put_line(v_name);
    exception
      when value_error then
       dbms_output.put_line('error in inner');
  end;
exception
      when value_error then
        dbms_output.put_line('error in outer');

end;


-- angajat cu id 105 , marire in fucntie de experienta, 
-- if exp > 10 then


select trunc((trunc(sysdate)-trunc(a.HIRE_DATE))/360 )ani from employees a
where a.employee_id=105;


-- exercitiu marire salariu
declare
ani NUMBER;
salariuInitial employees.salary%type;
salariuFinal employees.salary%type;
v_proc number;
begin 
  select floor((trunc(sysdate)-trunc(a.HIRE_DATE))/360 ),salary into ani,salariuInitial from employees a
  where a.employee_id=105;
  
  dbms_output.put_line('intiail '||salariuInitial);
  
  /*if(ani >10) then  dbms_output.put_line('maresc cu 20%');
                    v_proc:=0.2;
                    
  elsif(ani > 5) then dbms_output.put_line('maresc cu 10%');
                    v_proc:=0.1;
  else dbms_output.put_line('maresc cu 5%%');
                    v_proc:=0.05;
  end if;
  */
  
  --decode(var,egal,doThis,....,else,do)
  select decode (ani,10,0.2,5,0.1,0.05) into v_proc from dual;
  
  update employees
  set salary=salary*v_proc+salary
  where employee_id=105;
  
  select salary into salariuFinal from EMPLOYEES
  where EMPLOYEE_ID=105;
  
  dbms_output.put_line('final '||salariuFinal);
end;





















