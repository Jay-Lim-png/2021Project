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
--BCOLOR �������� �ߺ��� ���ŵ� ����� ������( ASC ���ĵǾ� �� �ߺ� ���� FCOLOR ������ ���� ���� ��)
SELECT
	DISTINCT ON
	(BCOLOR)BCOLOR,
	FCOLOR
FROM
	T1
ORDER BY
	BCOLOR,
	FCOLOR;
	
---------------------------------------------------------------------------
--BCOLOR ���� �ߺ����� BUT FCOLOR �������� �̹����� �ߺ����� FCOLOR ù���� ���� ����
SELECT
	DISTINCT ON
	(BCOLOR) BCOLOR,
	FCOLOR
FROM
	T1
ORDER BY
	BCOLOR,
	FCOLOR DESC;

---------------------------------------------------------------------------
--������ �ǽ�
SELECT
	LAST_NAME, --3
	FIRST_NAME
FROM
	CUSTOMER --1
WHERE
	FIRST_NAME = 'Jamie' --2
	AND LAST_NAME = 'Rice';
---------------------------------------------------------------------------

SELECT
	CUSTOMER_ID,
	AMOUNT,
	PAYMENT_DATE
FROM
	PAYMENT
WHERE
	AMOUNT <= 1
	OR AMOUNT >= 8;

---------------------------------------------------------------------------
-- LIMIT ����
SELECT
	FILM_ID,
	TITLE,
	RELEASE_YEAR
FROM
	FILM
ORDER BY
	FILM_ID
LIMIT 5;

---------------------------------------------------------------------------
-- 4��° ����� ��� ���
SELECT
	FILM_ID,
	TITLE,
	RELEASE_YEAR
FROM
	FILM
ORDER BY
	FILM_ID
LIMIT 4 OFFSET 3;

---------------------------------------------------------------------------
SELECT
	FILM_ID,
	TITLE,
	RENTAL_RATE
FROM
	FILM
ORDER BY
	RENTAL_RATE DESC
LIMIT 100 OFFSET 5;

---------------------------------------------------------------------------
--FETCH��
SELECT
	FILM_ID,
	TITLE
FROM
	FILM
ORDER BY
	TITLE --TITLE�� ������ ���� �߿� ������ �� �� ���� RETURN
FETCH FIRST ROW ONLY;

---------------------------------------------------------------------------
SELECT
	FILM_ID,
	TITLE
FROM
	FILM
ORDER BY
	TITLE --TITLE�� ������ ���� �߿� 5���� RETURN
FETCH FIRST 5 ROW ONLY;

--------------------------------------------------------------------------
SELECT
	FILM_ID,
	TITLE
FROM
	FILM
ORDER BY
	TITLE
	OFFSET 5 ROWS --0 1 2 3 4 5
FETCH FIRST 5 ROW ONLY;  -- FILM_ID 6��°���� RETURN�ϰ� ��

---------------------------------------------------------------------------
--IN ������ ����
SELECT
	CUSTOMER_ID,
	RENTAL_ID,
	RETURN_DATE
FROM
	RENTAL
WHERE
	CUSTOMER_ID IN (1, 2) --CUSTOMER_ID�� 1 OR 2�� �ش��ϴ� �� ���
ORDER BY
	RETURN_DATE DESC;

---------------------------------------------------------------------------
--IN �����ڴ� OR && = �� ����
SELECT
	CUSTOMER_ID,
	RENTAL_ID,
	RETURN_DATE
FROM
	RENTAL
WHERE
	CUSTOMER_ID = 1
	OR CUSTOMER_ID = 2
ORDER BY
	RETURN_DATE DESC;

---------------------------------------------------------------------------
--NOT IN
SELECT
	CUSTOMER_ID,
	RENTAL_ID,
	RETURN_DATE
FROM
	RENTAL
WHERE
	CUSTOMER_ID NOT IN (1, 2)  --1,2�� ������ ������ ����
ORDER BY
	RETURN_DATE DESC;

---------------------------------------------------------------------------
SELECT
	CUSTOMER_ID,
	RENTAL_ID,
	RETURN_DATE
FROM
	RENTAL
WHERE
	CUSTOMER_ID <> 1
	AND CUSTOMER_ID <>2
ORDER BY
	RETURN_DATE DESC;

---------------------------------------------------------------------------
SELECT
	CUSTOMER_ID
FROM
	RENTAL
WHERE
	CAST (RETURN_DATE AS DATE) = '2005-05-27'; --RETURN_DATE�� DATE �������� �ν��ϰ� �� ���� 2005-05-27�� ���� CUSTOMER_ID ���
	-- CAST�� ������ Ÿ���� �����ϴ� �Լ�
---------------------------------------------------------------------------
--�������� ����
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER
WHERE
	CUSTOMER_ID IN ( --1�� �����ϴ� CUSTOMER_ID�� ���� CUSTOMER�� FIRST_NAME�� LAST_NAME ���
	SELECT
		customer_id
	FROM
		rental
	WHERE
		CAST (RETURN_DATE AS DATE) = '2005-05-27'); --1) RETURN_DATE�� �ش� ��¥�� CUSTOMER_ID
---------------------------------------------------------------------------
--BETWEEN ����
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT
FROM
	PAYMENT
WHERE
	AMOUNT BETWEEN 8 AND 9;

----------------------------------------------------------------------------
-- BETWEEN�� AND�����ڷ� �ٽ� ǥ�� ���� (�ٵ� BETWEEN���� �̰� �� �����ٰ� ������..?  -> ������ ���鿡�� BETWEEN�� ����)
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT
FROM
	PAYMENT
WHERE AMOUNT >= 8
AND AMOUNT <= 9;

----------------------------------------------------------------------------
--NOT BETWEEN ����
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT
FROM
	PAYMENT
WHERE
	AMOUNT NOT BETWEEN 8 AND 9;

-----------------------------------------------------------------------------
--NOT BETWEEN�� OR�����ڷ� �ٽ� ǥ�� ����
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT
FROM
	PAYMENT
WHERE AMOUNT < 8 OR AMOUNT > 9;

-----------------------------------------------------------------------------
--���ں� ����
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT,
	PAYMENT_DATE
FROM
	PAYMENT
WHERE
	CAST(PAYMENT_DATE AS DATE) BETWEEN '2007-02-07' AND '2007-02-15';
	
------------------------------------------------------------------------------
--PAYMENT_DATE�� ��¥������ �ٲ��� �ʰ� ������ ������ ���ڿ��� ��ȯ�ؼ� �ش� ���� �� �� �ִ�.(to_char������ ��¥������ �νĵǳ���?)
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT,
	PAYMENT_DATE
FROM
	PAYMENT
WHERE to_char(PAYMENT_DATE, 'yyyy-mm-dd') BETWEEN '2007-02-07' AND '2007-02-15'; 

------------------------------------------------------------------------------
--DATEŸ������ ������ �ٲٸ� ��/��/�ʰ� ��������, to_char�Լ��� �ٲٸ� ���� ������ ������ ���� ���� (yyyy-mm���� ������ �ޱ����� ����)
SELECT
	CUSTOMER_ID,
	PAYMENT_ID,
	AMOUNT,
	PAYMENT_DATE, to_char(PAYMENT_DATE, 'yyyy-mm-dd'), CAST(PAYMENT_DATE AS DATE)
FROM
	PAYMENT
WHERE to_char(PAYMENT_DATE, 'yyyy-mm-dd') BETWEEN '2007-02-07' AND '2007-02-15'; 

-------------------------------------------------------------------------------
--LIKE ����
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER
WHERE
	FIRST_NAME LIKE 'Jen%';  --first_name �� Jen���� ���۵Ǵ� ��� �� ���
	
-------------------------------------------------------------------------------
--LIKE ����
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER
WHERE
	FIRST_NAME LIKE '%er%';  -- first_name �� er�� ���� ��� �� ���

-------------------------------------------------------------------------------
--LIKE ����
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER
WHERE
	FIRST_NAME NOT LIKE 'Jen%'; --first_name �� Jen���� �������� �ʴ� ��� �� ���
	
-------------------------------------------------------------------------------
--ISNULL �ǽ� ���̺� ����
CREATE TABLE CONTACTS
(ID INT GENERATED BY DEFAULT AS IDENTITY,
FIRST_NAME VARCHAR(50) NOT NULL,  --NOTNULL�� ġ�� ������ �ߴµ� , NOT NULL�̶� NOTNULL ���̰� ����?
LAST_NAME VARCHAR(50) NOT NULL, 
EMAIL VARCHAR(255) NOT NULL, 
PHONE VARCHAR(15),
PRIMARY KEY(ID)
);

INSERT
	INTO
	CONTACTS(FIRST_NAME,
	LAST_NAME,
	EMAIL,
	PHONE)
VALUES ('John',
'Doe',
'John.doe@example.com',
NULL), 
('Lily',
'Bush',
'lily.bush@example.com',
'(408-234-2764');

COMMIT;

-----------------------------------------------------------------------------
--IS NULL ����  (=NULL�� �ϸ� NULL�� �� ã��)
SELECT
	ID,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	PHONE
FROM
	CONTACTS
WHERE
	PHONE = NULL;

-----------------------------------------------------------------------------
--IS NULL ����2 (IS NULL�� �ؾ� NULL�� ��µ�)
SELECT
	ID,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	PHONE
FROM
	CONTACTS
WHERE
	PHONE IS NULL;

-----------------------------------------------------------------------------
--IS NOT NULL ����
SELECT
	ID,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	PHONE
FROM
	CONTACTS
WHERE PHONE IS NOT NULL;

-----------------------------------------------------------------------------
------------------------------CHAP2 �ǽ�����(1)--------------------------------
--PAYMENT ���̺��� ���� �ŷ��� AMOUNT �׼��� ���� ���� ������ CUSTOMER_ID�� �����϶�. ��, CUSTOMER_ID���� �����ؾ� ��--
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
SELECT DISTINCT customer_id 
FROM PAYMENT
WHERE amount =  (  -- IN �� =���� �ٲ㵵 �ǳ�
	SELECT amount 
	FROM payment
	ORDER BY amount DESC LIMIT 1);


--���� ��� (�� ������ �ְ�)
SELECT
	DISTINCT p.customer_id
FROM
	payment p
WHERE
	p.amount = (
	SELECT
		k.amount
	FROM
		payment k
	ORDER BY
		amount DESC
	LIMIT 1);

------------------------------------------------------------------------------
-------------------------------CHAP2 �ǽ�����(2)--------------------------------
--���鿡�� ��ü �̸����� �����ϰ��� �Ѵ�. CUSTOMER ���̺��� ���� EMAIL �ּҸ� �����ϰ�, �̸��� ���Ŀ� ���� �ʴ� �̸��� �ּҴ� ���ܽ��Ѷ�--
--��, �̸��� ������ '@'�� �����ؾ� �ϰ�, '@'�� �������� ���ƾ� �ϰ� '@'�� ������ ���ƾ� �Ѵ�--
------------------------------------------------------------------------------
------------------------------------------------------------------------------
SELECT c.email 
FROM customer c
WHERE c.email LIKE '_%@%_' AND c.email NOT LIKE '@%' AND c.email NOT LIKE '%@';

--���� ��Ȱ� ����