SELECT
	*
FROM
	customer;

-----------------------------------------------

SELECT
	first_name,
	last_name,
	email
FROM
	customer;

-----------------------------------------------

SELECT
	a.first_name,
	a.last_name,
	a.email
FROM
	customer a;

-----------------------------------------------

SELECT
	first_name,
	last_name
FROM
	customer
ORDER BY
	first_name ASC;
	
-----------------------------------------------

select
	first_name,
	last_name
from
	customer
order by
	first_name desc;

------------------------------------------------

select
	first_name,
	last_name
from
	customer
order by
	first_name asc,
	last_name desc;

------------------------------------------------

select
	first_name,
	last_name
from
	customer
order by
	1 asc,
	2 desc ;
	

------------------------------------------------
--select distinct Ȯ�ο� ���̺� �����

create table T1 (ID SERIAL not null primary key,
BCOLOR VARCHAR,
FCOLOR VARCHAR);

insert
	into
	t1(bcolor,
	fcolor)
values 
('red',
'red'),
('red',
'red'),
('red',
null),
(null,
'red'),
('red',
'green'),
('red',
'blue'),
('green',
'red'),
('green',
'blue'),
('green',
'green'),
('blue',
'red'),
('blue',
'green'),
('blue',
'blue');


-------------------------------------------------------------------------
--���� ���̺� �Ӽ� Ȯ��
select * from t1;

-------------------------------------------------------------------------

SELECT
	DISTINCT BCOLOR
FROM
	T1
ORDER BY
	BCOLOR;
	
-------------------------------------------------------------------------

