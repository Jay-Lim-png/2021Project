--------------------------------------------------------------------------
-- UNION���� ���� ���̺� �����
CREATE TABLE SALES2007_1
(
	NAME VARCHAR(50),
	AMOUNT NUMERIC(15,2)
);

INSERT INTO SALES2007_1
VALUES
  ('Mike', 150000.25)
 ,('Jon', 132000.75)
 ,('Mary', 100000)
;
COMMIT;

CREATE TABLE SALES2007_2
(
  NAME VARCHAR(50)
 ,AMOUNT NUMERIC(15,2)
);

INSERT INTO SALES2007_2
VALUES
  ('Mike', 120000.25)
 ,('Jon', 142000.75)
 ,('Mary', 100000)
;

COMMIT;

-----------------------------------------------------------------------
-- UNION ���� (���� �ߺ����� ���ŵǰ� 5�� �ุ ��µ�)
SELECT
	*
FROM
	SALES2007_1
UNION
SELECT
	*
FROM
	SALES2007_2 
;


-- Ư�� COLUMN�� SELECT & UNION�ϱ� (�ߺ��� ���� 3�� �ุ ��µ�)
SELECT
	NAME
FROM
	SALES2007_1
UNION
SELECT
	NAME
FROM
	SALES2007_2;
	
-- Ư�� COLUMN�� SELECT & UNION (�ߺ��� ���� 5�� �ุ ��µ�)
SELECT
	AMOUNT
FROM
	SALES2007_1
UNION
SELECT
	AMOUNT
FROM
	SALES2007_2;
	
-- ORDER BY ���� �� UNION�Ǵ� ������ SELECT ���� �����Ѵ�.
SELECT
	*
FROM
	SALES2007_1
UNION
SELECT
	*
FROM
	SALES2007_2
ORDER BY
	AMOUNT DESC;

--------------------------------------------------------
--UNION ALL (�ߺ����� �Բ� ���)
SELECT
	AMOUNT
FROM
	SALES2007_1
UNION ALL
SELECT
	AMOUNT
FROM
	SALES2007_2;

--UNION ALL & ORDER BY
SELECT
	*
FROM
	SALES2007_1
UNION ALL
SELECT
	*
FROM
	SALES2007_2
ORDER BY
	AMOUNT DESC;
	
---------------------------------------------------------------------------------
--INTERSECT ���� ���̺� �����
CREATE TABLE EMPLOYEES
(
  EMPLOYEE_ID SERIAL PRIMARY KEY
  ,
EMPLOYEE_NAME VARCHAR (255) NOT NULL
);

CREATE TABLE KEYS
(
  EMPLOYEE_ID INT PRIMARY KEY,
  EFFRECTIVE_DATE DATE NOT NULL,
  FOREIGN KEY (EMPLOYEE_ID)
  REFERENCES EMPLOYEES (EMPLOYEE_ID)
);

CREATE TABLE HIPOS
(
EMPLOYEE_ID INT PRIMARY KEY,
EFFECTIVE_DATE DATE NOT NULL,
FOREIGN KEY (EMPLOYEE_ID)
REFERENCES EMPLOYEES (EMPLOYEE_ID)
);

INSERT
	INTO
	EMPLOYEES (EMPLOYEE_NAME)
VALUES
('Joyce Edwards'),
('Diane Collins'),
('Alice Stewart'),
('Julie Sanchez'),
('Heather Morris'),
('Teresa Rogers'),
('Doris Reed'),
('Gloria Cook'),
('Evelyn Morgan'),
('Jean Bell')

COMMIT;

INSERT
	INTO
	KEYS
VALUES
(1,'2000-02-01'),
(2,'2001-06-01'),
(5,'2002-01-01'),
(7,'2005-06-01')

COMMIT;

INSERT
	INTO
	HIPOS
VALUES
(9,'2000-01-01'),
(2,'2002-06-01'),
(5,'2006-06-01'),
(10,'2005-06-01');

COMMIT;

-----------------------------------------------------------------
--INTERSECT ���� �ǽ� (������ ���)
SELECT
	EMPLOYEE_ID
FROM
	KEYS
INTERSECT
SELECT
	EMPLOYEE_ID
FROM
	HIPOS
ORDER BY EMPLOYEE_ID;

--INNER JOIN���� �ٽ� ǥ�� (�ǹ������� INTERSECT���� INNER JOIN�� �� ���� ��)
---���������ε� INNER JOIN�� �� ���� ������ ���� �� ����
SELECT A.EMPLOYEE_ID
FROM KEYS A
INNER JOIN HIPOS B
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
ORDER BY A.EMPLOYEE_ID DESC;

--WHERE �� �̿��
SELECT A.EMPLOYEE_ID
FROM KEYS A, HIPOS B
WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID
ORDER BY A.EMPLOYEE_ID DESC;

-------------------------------------------------------------------------------------
--EXCEPT ���� ���� (dvdrental ���̺� ���)
SELECT * FROM INVENTORY LIMIT 10; --��� ������
SELECT * FROM FILM LIMIT 10; --��� ��ȭ ���̵�� ���� ����

--�̶� �ʸ�:�κ��丮 �� 1:n���迡 �ش�. �ʸ��� ��ȭ�� ��ȭ id�� ������ �Ѱ��� ���������, inventory���� �� ��ȭ�� ���� �������� ��� ���°� �������

SELECT
	DISTINCT INVENTORY.FILM_ID, --inventory�� film���̺� ���ÿ� ����ִ� ������ film_id�� ���
	TITLE
FROM
	INVENTORY
INNER JOIN FILM ON
	FILM.FILM_ID = INVENTORY.FILM_ID  
ORDER BY
	TITLE;

--�׷� ��� �������� �ʴ� ��ȭ�� ��� ����ϴ°�? �� �� intersect�� �� �� ����
--film.film_id - inventory.film_id�� ������ ���

SELECT -- ��ü FILM (�ߺ��� ����)
	FILM_ID,
	TITLE
FROM
	FILM
EXCEPT
SELECT --��� �����ϴ� FILM ����
	DISTINCT INVENTORY.FILM_ID,
	TITLE
FROM
	INVENTORY
INNER JOIN FILM ON
	FILM.FILM_ID = INVENTORY.FILM_ID
ORDER BY
	TITLE;
	
-- A-B�� B�� �ߺ��� �������� �ȵǳ� Ȯ���غ�. (Ȯ�� ��� �Ʒ� �ڵ嵵 ������. ���� DISTINCT�� �� �ᵵ ��.. )
SELECT -- ��ü FILM (�ߺ��� ����)
	FILM_ID,
	TITLE
FROM
	FILM
EXCEPT
SELECT --��� �����ϴ� FILM ����
	INVENTORY.FILM_ID,
	TITLE
FROM
	INVENTORY
INNER JOIN FILM ON
	FILM.FILM_ID = INVENTORY.FILM_ID
ORDER BY
	TITLE;
	
-------------------------------------------------------------------------------------------
--��ø �������� ���� 
--RENTAL_RATE�� ��հ����� ū FILM�� ���ϰ� �ʹ�!
SELECT
	FILM_ID,
	TITLE,
	RENTAL_RATE
FROM
	FILM
WHERE
	RENTAL_RATE > 
(
	SELECT
		AVG(RENTAL_RATE)
	FROM
		FILM
);

--�ζ��� �� ����(FROM ������ ���������� ����)
SELECT
	A.FILM_ID,
	A.TITLE,
	A.RENTAL_RATE
FROM
	FILM A,
	(
	SELECT
		AVG(RENTAL_RATE) AS AVG_RENTAL_RATE
	FROM
		FILM) B
WHERE
	A.RENTAL_RATE > B.AVG_RENTAL_RATE;
	
--��Į�� �������� ����(SELECT�� ����Ʈ���� ���������� ����)
SELECT
	A.FILM_ID,
	A.TITLE,
	A.RENTAL_RATE
FROM
	( --�ζ��� �信 �ش�  
	SELECT
		A.FILM_ID,
		A.TILTE,
		A.RENTAL_RATE,
		( --��Į�� �������� ���
		SELECT
			AVG(L.RENTAL_RATE)
			FROM FILM L 
		)AS AVG_RENTAL_RATE  -- ��Į�� �������� ��
		FROM
			FILM A 
		) A --�ζ��� �� ��
	WHERE
		A.RENTAL_RATE > A.AVG_RENTAL_RATE;

----------------------------------------------------------------------------------
--ANY ������ �ǽ�
--��ȭ ī�װ��� �󿵽ð��� ���� �� ��ȭ���� ��ȭ�̸��� ���ϱ� =>�ٵ� �̷��� ¥�� ī�װ����� ���� ���� �ʾƵ� ������ �� �� ����. ���簡 ������ �߸� ��������.
	--ī�װ��� �󿵽ð��� ���� �� ��ȭ���� �󿵽ð��� ���ų� �󿵽ð��� �� ū ��ȭ�� ���ϴ� ������ �����ϴ� �� ����
SELECT
	TITLE,
	LENGTH
FROM
	FILM
WHERE LENGTH >= ANY (  --ANY�� ������ ���������� ����� CATEGORY���� 16���� �ǰ� �Ǵµ�, LENGTH�� 16���� ���� �ѹ��� ���� �� �ִ� ����� ���� ������ ������ ����
	SELECT
		MAX(LENGTH)
	FROM FILM A, FILM_CATEGORY B
	WHERE A.FILM_ID = B.film_id 
	GROUP BY B.category_id 
);

--��ȭ ī�װ��� ���� �� �󿵽ð��� ��ȭ�ð��� ���� ��� ��ȭ���� ���
SELECT
	TITLE,
	LENGTH
FROM
	FILM
WHERE LENGTH = ANY ( 
	SELECT
		MAX(LENGTH)
	FROM FILM A, FILM_CATEGORY B
	WHERE A.FILM_ID = B.film_id 
	GROUP BY B.category_id 
);

-- '= ANY' �� 'IN' �� ������ (�� ������)
SELECT
	TITLE,
	LENGTH
FROM
	FILM
WHERE LENGTH IN ( 
	SELECT
		MAX(LENGTH)
	FROM FILM A, FILM_CATEGORY B
	WHERE A.FILM_ID = B.film_id 
	GROUP BY B.category_id 
);

----------------------------------------------------------------------------------------
--ALL ������ ���� (���������� ��� ������� �����ؾ� ������ ������)
-- ī�װ��� ���� �� ��ȭ ���̺��� ũ�ų� ���� ��ȭ �̸��� ��� (�ᱹ ���� �󿵽ð��� �� ��ȭ�̸��� ����ϴ� �Ͱ� ����)
SELECT
	TITLE,
	LENGTH
FROM
	FILM
WHERE
	LENGTH >= ALL (
	SELECT
		MAX(LENGTH)
	FROM
		FILM A,
		FILM_CATEGORY B
	WHERE
		A.FILM_ID = B.FILM_ID
	GROUP BY
		B.CATEGORY_ID);
		
--ALL ������ �ǽ�2
--�򰡱���(ī�װ� ��������)�� �󿵽ð� ��ձ���(�Ҽ��� ��°�ڸ����� ���)�� ��� ������ �� �󿵽ð��� �� �����͸� ���
SELECT
	FILM_ID,
	TITLE,
	LENGTH
FROM
	FILM
WHERE
	LENGTH > ALL (
	SELECT
		ROUND(AVG(LENGTH), 2)
	FROM
		FILM GROUP BY RATING)
ORDER BY
	LENGTH;
	
--------------------------------------------------------------------------------------------------
--EXISTS ������ ����
--�� ����Ʈ �� ���ݾ��� 11�޷��� �ʰ��� ���̸��� ���(��ü 599�� ������ �� 8�� ������ ���)
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER C
WHERE
	EXISTS ( SELECT 1  -- 'SELECT 1'�� ��� ROW�� ��� 1�� ä���� COLUMN�� ��ȯ�Ѵ�
			FROM PAYMENT P
			WHERE P.CUSTOMER_ID = C.CUSTOMER_ID
			AND P.AMOUNT > 11)   --���ҳ����� 11�޷��� �ʰ��� ���� �����ϴ��� Ȯ���ϱ�
ORDER BY
	FIRST_NAME,
	LAST_NAME;

--NOT EXISTS�� ����
--���ҳ����� 11�޷��� �ʰ��� �� ���� ���̸��� ��� (591�� ������ ���)
SELECT
	FIRST_NAME,
	LAST_NAME
FROM
	CUSTOMER C
WHERE
	NOT EXISTS ( SELECT 1  --���ҳ����� 11�޷��� �ʰ��� ���� �����ϴ��� Ȯ���ϱ�
			FROM PAYMENT P
			WHERE P.CUSTOMER_ID = C.CUSTOMER_ID
			AND P.AMOUNT > 11)   
ORDER BY
	FIRST_NAME,
	LAST_NAME;
	


----------------------------------------------------------------------------------------------------
-------------------------------------------�ǽ�����1 -------------------------------------------------
--�Ʒ� SQL���� FILM ���̺��� 2���̳� ��ĵ�ϰ� �ִ�. FILM ���̺��� �ѹ��� SCAN�Ͽ� ������ ��� ������ ���ϴ� SQL�� �ۼ��϶�--
----------------------------------------------------------------------------------------------------
--���� SQL
SELECT
	FILM_ID,
	TITLE,
	RENTAL_RATE
FROM
	FILM
WHERE
	RENTAL_RATE > (
	SELECT
		AVG(RENTAL_RATE)
	FROM
		FILM);
	
-- FROM ������ �������� �� �� ������..?
-- AVG�� ���̺��� �о �������� ���� �м��Լ��� �ٷ� ����
SELECT
	*
FROM
	(
	SELECT
		FILM_ID,
		TITLE,
		RENTAL_RATE,
		AVG(A.RENTAL_RATE) OVER() AS AVG_RENTAL_RATE
	FROM
		FILM A) A
WHERE
	RENTAL_RATE > AVG_RENTAL_RATE;

----------------------------------------------------------------------------------------------------
-------------------------------------------�ǽ�����2--------------------------------------------------
-------�Ʒ� SQL���� EXCEPT ������ ����Ͽ� ��� ���� ��ȭ�� ���ϰ� �ִ�. EXCEPT ���� ���� ���� ����� �����϶�---------
----------------------------------------------------------------------------------------------------
--���� SQL
SELECT
	FILM_ID,
	TITLE
FROM
	FILM
EXCEPT
SELECT
	DISTINCT INVENTORY.film_id,
	TITLE
FROM
	INVENTORY
INNER JOIN FILM ON
	FILM.FILM_ID = INVENTORY.FILM_ID
ORDER BY
	TILTE;

	
--NOT EXISTS�� ����ϸ� �� ���� ������ ���� ������? (�� ����ε� Ʋ����)
SELECT A.FILM_ID, A.TITLE
FROM FILM A
WHERE 
	NOT EXISTS (
		SELECT DISTINCT B.film_id  
		FROM INVENTORY B
	)
ORDER BY TITLE;

-- ������ Ʋ�Ȱ� ��¥ ����
SELECT A.FILM_ID, A.TITLE
FROM FILM A
WHERE 
	NOT EXISTS (  --�� �״�� �ִ��� �����ĸ� Ȯ������
		SELECT 1
		FROM INVENTORY B, FILM C
		WHERE B.FILM_ID = C.FILM_ID  -- �� WHERE���� �������ִ� ROW���� 1�� ���� ���� ä�� ��µǰ� ��
		AND A.FILM_ID = C.FILM_ID
		)	
ORDER BY TITLE;

		
--�� ��Ⱥ��� �� ���� ��� (�ʸ� ���̺��� 1���� ��ȸ�ϴ� ���)
SELECT A.FILM_ID, A.TITLE
FROM FILM A
WHERE 
	NOT EXISTS (
		SELECT 1
		FROM INVENTORY B
		WHERE 1=1
		AND A.FILM_ID = B.FILM_ID
		)	
ORDER BY TITLE;
