--set serveroutput on
declare 
--declarare cursor
cursor departments_curs
is select dp.department_id,dp.department_name
from departments dp;
-- obiect cursor
departments_rec departments_curs%rowtype;

begin
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