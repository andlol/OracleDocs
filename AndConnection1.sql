select LAST_NAME,HIRE_DATE
from EMPLOYEES where DEPARTMENT_ID =
  (select DEPARTMENT_ID from EMPLOYEES
  where LAST_NAME = 'Zlotkey') and 
  LAST_NAME NOT LIKE &r
  ;

-- EX 2
SELECT LAST_NAME,DEPARTMENT_ID 
FROM EMPLOYEES B
WHERE B.DEPARTMENT_ID IN
(SELECT A.DEPARTMENT_ID 
FROM EMPLOYEES  A
WHERE A.LAST_NAME LIKE '%u%');


-- EX 3
SELECT A.LAST_NAME,A.JOB_ID,A.SALARY
FROM EMPLOYEES A
WHERE A.JOB_ID IN ( SELECT B.JOB_ID
                    FROM JOBS B 
                    WHERE B.JOB_TITLE LIKE 'P%') AND A.SALARY NOT IN(2500,3500,7000) 
ORDER BY A.JOB_ID ASC, A.LAST_NAME DESC ;

-- EX 4

--ANGAJATII CARE CASTIGA MAI MULT DECAT ORICE ANGAJAT DIN DEP 30
SELECT A.LAST_NAME,A.SALARY
FROM EMPLOYEES A
WHERE A.SALARY > ANY (SELECT B.SALARY
                      FROM EMPLOYEES B WHERE B.DEPARTMENT_ID=30);

SELECT * FROM EMPLOYEES A
WHERE A.EMPLOYEE_ID=2206
--1107

INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME,LAST_NAME, HIRE_DATE,EMAIL,JOB_ID,SALARY,COMMISSION_PCT) 
VALUES (5555, 'APOSTOIU','Andrei ', sysdate,'A@MAIL','IT_PROG',10000,0.2);

--
INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME,LAST_NAME, HIRE_DATE,EMAIL,JOB_ID,SALARY,COMMISSION_PCT) 
VALUES (5555, 'APOSTOIU','Andrei ', sysdate,'A@MAIL','IT_PROG',10000,0.2);

COMMIT

UPDATE EMPLOYEES A
SET A.DEPARTMENT_ID=(SELECT B.DEPARTMENT_ID FROM DEPARTMENTS B WHERE DEPARTMENT_NAME LIKE 'IT')
WHERE A.EMPLOYEE_ID=2206
;

-- functie verifica CNP
create or replace function verificaCNP(cnp in varchar2 )
return number is
resultat number;
checknr number;
begin
  checknr:=cnp+1;
  if length(cnp) <> 13 then resultat:=0;
  elsif substr(cnp,1,1) not in(1,2) then resultat:=0;
  elsif substr(cnp,4,2) > 12 then resultat:=0;
  else resultat:=1;
  end if;
  return resultat;
end;

select verificaCNP('1930327aaa3') from dual

-- procedura care foloseste un cursor , in cursor aduc numele departamentului , salariul mediu din fiecare departament , 
-- salariul mediu din companie , folosind cursor parametrizat

create or replace procedure afisare(p_id number)
is
cursor curs(c_id number ) is
      select trunc(avg(a.salary)) medie,b.department_name
      from employees a,departments b
      where a.department_id = b.department_id and a.department_id=c_id
      group by b.department_name;
--obiect
cursObject curs%rowtype;
begin 
if curs%isopen=false then open curs(p_id);
end if;

loop
fetch curs into cursObject;
  exit when curs%notfound;
      dbms_output.put_line(
         cursObject.department_name ||'   '|| cursObject.medie
      );
end loop;

close curs;
end;


-- run
set serveroutput on;
execute afisare(60);




























