---------------------------------------------------------------------
-- join ���� ���̺� �����
CREATE TABLE BASKET_A(
ID INT PRIMARY KEY,
FRUIT VARCHAR (100) NOT NULL);

CREATE TABLE BASKET_B(
ID INT PRIMARY KEY,
FRUIT VARCHAR (100) NOT NULL);
--���̺� �� �ֱ�
INSERT
	INTO
	BASKET_A(ID,
	FRUIT)
VALUES 
(1,'APPLE'),
(2,'ORANGE'),
(3,'BANANA'),
(4,'CUCUMBER');

COMMIT;  --INSERT, UPDATE, DELETE (�������� ���� �� ����) ����� �ݵ�� COMMIT�� �ؾ� ��. (�������� �۾��� �� �Ȳ��̰� �Ϸ��� �׷���?)

INSERT
	INTO
	BASKET_B (ID,FRUIT)
VALUES 
(1,'ORANGE'),
(2,'APPLE'),
(3,'WATERMELON'),
(4,'PEAR');

COMMIT;

--BASKET_A ���̺� ��ȸ
SELECT * FROM BASKET_A;
--BASKET_B ���̺� ��ȸ
SELECT * FROM BASKET_B;


---------------------------------------------------------------------------
--INNER JOIN ����
SELECT
	A.ID ID_A,
	A.FRUIT FRUIT_A,
	B.ID ID_B,
	B.FRUIT FRUIT_B
FROM
	BASKET_A A
INNER JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT;
	

---------------------------------------------------------------------------
--DVDRENTAL ������ INNERJOIN ����
SELECT
	A.CUSTOMER_ID,
	A.FIRST_NAME,
	A.LAST_NAME,
	A.EMAIL,
	B.AMOUNT,
	B.PAYMENT_DATE
FROM
	CUSTOMER A
INNER JOIN PAYMENT B ON
	A.CUSTOMER_ID = B.CUSTOMER_ID --��� PAYMENT�� CUSTOMER_ID�� ������ ���� ���̱� ������ ����� ROW���� PAYMENT�� ROW���� ������

---------------------------------------------------------------------------
--CUSTOMER ID�� 2���� ���� ���������� ��ȸ (EX. ���������� ���������� ��ȸ���� �� ������ ������ �߰� �Ϸ���)
SELECT
	A.CUSTOMER_ID,
	A.FIRST_NAME,
	A.LAST_NAME,
	A.EMAIL,
	B.AMOUNT,
	B.PAYMENT_DATE
FROM
	CUSTOMER A
INNER JOIN PAYMENT B ON
	A.CUSTOMER_ID = B.CUSTOMER_ID
WHERE A.CUSTOMER_ID = 2;
	
---------------------------------------------------------------------------
--3���� INNERJOIN (A - B  B- C ������ JOIN)
SELECT
	A.CUSTOMER_ID,
	A.FIRST_NAME,
	A.LAST_NAME,
	A.EMAIL,
	B.AMOUNT,
	B.PAYMENT_DATE,
	C.FIRST_NAME AS S_FIRST_NAME,
	C.LAST_NAME AS S_LAST_NAME
FROM
	CUSTOMER A
INNER JOIN PAYMENT B  
ON
	A.CUSTOMER_ID = B.CUSTOMER_ID  -- CUSTOMER ���̺�� PAYMENT ���̺� ����
INNER JOIN STAFF c ON
	B.STAFF_ID = C.STAFF_ID;  --PAYMENT ���̺�� STAFF ���̺��� ����
	
---------------------------------------------------------------------------
-- LEFT OUTER JOIN ���� (A�� B�� JOIN�� A�� ��Ī�Ǵ� B�� �Ϻθ� ������)
-- LEFT OUTER JOIN�� LEFT JOIN���� �ᵵ ��
SELECT
	A.ID AS ID_A ,
	A.FRUIT AS FRUIT_A,
	B.ID AS ID_B,
	B.FRUIT AS FRUIT_B
FROM
	BASKET_A A
LEFT JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT;
	
---------------------------------------------------------------------------
-- A���� �����ϴ� �����͸� �̴� ��
SELECT
	A.ID AS ID_A ,
	A.FRUIT AS FRUIT_A,
	B.ID AS ID_B,
	B.FRUIT AS FRUIT_B
FROM
	BASKET_A A
LEFT JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT
WHERE B.ID IS NULL;

---------------------------------------------------------------------------
-- RIGHT OUTER ���� (A�� B�� ���ν� B�� ��Ī�Ǵ� A�� �Ϻθ� ������)
-- ���������� OUTER�� �����ص� ��
SELECT
	A.ID AS ID_A ,
	A.FRUIT AS FRUIT_A,
	B.ID AS ID_B,
	B.FRUIT AS FRUIT_B
FROM
	BASKET_A A
RIGHT JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT;
	
------------------------------------------------------
--�̹����� B���� �����Ͱ� �����ϴ� ROW�� ã�´�
SELECT
	A.ID AS ID_A ,
	A.FRUIT AS FRUIT_A,
	B.ID AS ID_B,
	B.FRUIT AS FRUIT_B
FROM
	BASKET_A A
RIGHT JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT
WHERE A.ID IS NULL;


-----------------------------------------------------
-- SELF JOIN ���� ���̺� �����
-- employee_id�� ������, manager_id�� �ش� employee�� �����ϴ� �Ŵ���
CREATE TABLE EMPLOYEE(
EMPLOYEE_ID INT PRIMARY KEY,
FIRST_NAME VARCHAR (255) NOT NULL,
LAST_NAME VARCHAR (255) NOT NULL,
MANAGER_ID INT,
FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEE (EMPLOYEE_ID) ON
DELETE
	CASCADE
);

INSERT
	INTO
	EMPLOYEE(
EMPLOYEE_ID,
	FIRST_NAME,
	LAST_NAME,
	MANAGER_ID)
VALUES
(1,
'Windy',
'Hays',
NULL), 
(2,
'Ava',
'Christensen',
1), 
(3,
'Hassan',
'Conner',
1), 
(4,
'Anna',
'Reeves',
2), 
(5,
'Sau',
'Norman',
2), 
(6,
'Kelsie',
'Hays',
3), 
(7,
'Tory',
'Goff',
3), 
(8,
'Salley',
'Lester',
3);

COMMIT;
)

SELECT * FROM employee

-------------------------------------------------------------------------
-- SELF JOIN �ǽ�
SELECT
	E.employee_id,
	E.FIRST_NAME || ' ' || E.LAST_NAME EMPLOYEE,  -- FIRST NAME�� LAST NAME�� ���ļ� �̸��� ����
	M.FIRST_NAME || ' ' || M.LAST_NAME MANAGER
FROM
	EMPLOYEE E
INNER JOIN EMPLOYEE M ON   -- E, M ��� EMPLOYEE ���̺� �ش�
	M.EMPLOYEE_ID = E.MANAGER_ID  -- �� �� �� �����Ͱ� ���� ROW�� ��µ��� ����
ORDER BY
	MANAGER;
	
--------------------------------------------------------------------------
--SELF LEFT OUTER JOIN
--MANAGER_ID�� ���� �����͵� ����Ϸ���?
SELECT
	E.employee_id,
	E.FIRST_NAME || ' ' || E.LAST_NAME EMPLOYEE, 
	M.FIRST_NAME || ' ' || M.LAST_NAME MANAGER
FROM
	EMPLOYEE E
LEFT JOIN EMPLOYEE M ON
	M.EMPLOYEE_ID = E.MANAGER_ID
ORDER BY
	MANAGER;
	
-------------------------------------------------------------------------
--SELF JOIN ����2 (DVDRENTAL ������)
--������ ���� COLUMN�� ���ؼ��� SELF JOIN�� ���� (ROW�� Ư�� ī�װ����� ���� �� ������ ��)
SELECT
	F1.TITLE,
	F2.TITLE,
	F1.LENGTH
FROM
	FILM F1
INNER JOIN FILM F2 ON
	F1.FILM_ID <> F2.FILM_ID  -- ���� �ٸ� ��ȭ�� �߿���
	AND F1.LENGTH = F2.LENGTH;  -- ��ȭ�� �󿵽ð��� ������ ������ ���
	
--------------------------------------------------------------------------
--FULL OUTER JOIN  (INNER JOIN + LEFT OUTER JOIN + RIGHT OUTER JOIN�� ����� �����ش� - �翬�� �ߺ�����)
--FULL OUTER JOIN�� �����հ� ����
SELECT
	A.ID ID_A,
	A.FRUIT FRUIT_A,
	B.ID ID_B,
	B.FRUIT FRUIT_B
FROM
	BASKET_A A
FULL OUTER JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT;

--------------------------------------------------------------------------
-- (A��B) - (A��B) �� ���ϴ� ��
SELECT
	A.ID ID_A,
	A.FRUIT FRUIT_A,
	B.ID ID_B,
	B.FRUIT FRUIT_B
FROM
	BASKET_A A
FULL OUTER JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT
WHERE A.ID IS NULL
OR B.ID IS NULL;

--------------------------------------------------------------------------
-- FULL OUTER JOIN ����2 ������ ����
CREATE TABLE  --�Ϸù�ȣ�� �ش��ϴ� �μ� ��
IF NOT EXISTS DEPARTMENTS  -- �ش� �̸��� ���̺��� ���� �� ����
(DEPARTMENT_ID SERIAL PRIMARY KEY,  --SERIAL �Ӽ��� ROW ������� �Ϸù�ȣ�� �ο�
DEPARTMENT_NAME VARCHAR (255) NOT NULL);

CREATE TABLE -- EMPLOYEE�� ���ϴ� �μ��� �Ϸù�ȣ�� ���� �̸�
IF NOT EXISTS EMPLOYEES 
(EMPLOYEE_ID SERIAL PRIMARY KEY,
EMPLOYEE_NAME VARCHAR(255),
DEPARTMENT_ID INTEGER);

INSERT INTO DEPARTMENTS (DEPARTMENT_NAME)
VALUES 
('Sales'),
('Marketing'),
('HR'),
('IT'),
('Production');

COMMIT;

INSERT
	INTO
	EMPLOYEES (EMPLOYEE_NAME,
	DEPARTMENT_ID)
VALUES ('Bette Nicholson',
1),
('Christian Gable',
1),
('Joe Swank',
2),
('Fred Costner',
3),
('Sandra Kilmer',
4),
('Julia Mcqueen',
NULL);

COMMIT;
---------------------------------------------------------------------------
-- FULL OUTER JOIN ����2
-- �� employee���� �̸��� ���ϴ� �μ��� ��� (�ش� ����� ������ �������� ���� �μ��� ROW�� �ܵ����� ��µ�)
SELECT
	E.EMPLOYEE_NAME,
	D.DEPARTMENT_NAME
FROM
	EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D ON
	D.DEPARTMENT_ID = E.DEPARTMENT_ID;
	
----------------------------------------------------------------------------
-- �������� ���ϴ� �μ��� ����� ���̱� ������ �������� ���� �����ʹ� �����Ѵ�
-- �Ʒ� �ΰ��� ������� ǥ�� ����
SELECT
	E.EMPLOYEE_NAME,
	D.DEPARTMENT_NAME
FROM
	EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D ON
	D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE
	E.EMPLOYEE_NAME IS NOT NULL AND D.DEPARTMENT_ID IS NOT NULL;	
------------
SELECT
	E.EMPLOYEE_NAME,
	D.DEPARTMENT_NAME
FROM
	EMPLOYEES E
RIGHT JOIN DEPARTMENTS D ON
	D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE
	E.EMPLOYEE_NAME IS NOT NULL;