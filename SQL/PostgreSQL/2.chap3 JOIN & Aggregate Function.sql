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
	
-----------------------------------------------------------------------------
-- CROSS ���� ���� ���̺� �����
CREATE TABLE CROSS_T1 (LABEL CHAR(1) PRIMARY KEY);

CREATE TABLE CROSS_T2 (SCORE INT PRIMARY KEY);

INSERT
	INTO
	CROSS_T1(LABEL)
VALUES 
('A'),
('B');
COMMIT;

INSERT
	INTO
	CROSS_T2 (SCORE)
VALUES 
(1),
(2),
(3);
COMMIT;

-------------------------------------------------------------------------------
-- CROSS JOIN ����1
SELECT
	*
FROM
	CROSS_T1
CROSS JOIN CROSS_T2; --T1�� ��� �����Ϳ� T2�� ù��°, �ι�° ���� ���. ���� T1�� ABAB������ �����Ͱ� ��

--------------------------------------------------------------------------------
SELECT
	*
FROM
	CROSS_T1
CROSS JOIN CROSS_T2
ORDER BY LABEL;  -- T1�� �����ؼ� �� �������� ������ֱ�

--------------------------------------------------------------------------------
-- CROSS JOIN�� �ٸ� ǥ�����
SELECT
	*
FROM
	CROSS_T1,
	CROSS_T2 ; --ȣ�� ���� 1�̶� �Ȱ��� ����� ��µ� (�׷� CROSS JOIN�Ⱦ��� ����� ������ CROSS JOIN ����� �� �� ���� �ʳ�?)

--------------------------------------------------------------------------------
-- CROSS JOIN�� �ڿ� LABEL���� �ٸ� �÷��� �� ��ġ��
SELECT
	CASE
		WHEN LABEL = 'A' THEN SUM(SCORE)
		WHEN LABEL = 'B' THEN SUM(SCORE) * -1
		ELSE 0
	END AS CALC
FROM
	CROSS_T1
CROSS JOIN CROSS_T2
GROUP BY
	LABEL
ORDER BY
	LABEL;
	
--------------------------------------------------------------------------------
-- NATURAL JOIN ���� ���̺� ����� (������ ��ǰ��ȣ, ��ǰ��, �ߺ��Ǵ� ��ǰ�� ī�װ�)
CREATE TABLE CATEGORIES
(
	CATEGORY_ID SERIAL PRIMARY KEY,
	CATEGORY_NAME VARCHAR(255) NOT NULL
);

CREATE TABLE PRODUCTS 
(
	PRODUCT_ID SERIAL PRIMARY KEY,
	PRODUCT_NAME VARCHAR (255) NOT NULL,
	CATEGORY_ID INT NOT NULL,
	FOREIGN KEY (CATEGORY_ID)
	REFERENCES CATEGORIES (CATEGORY_ID)
);

INSERT INTO CATEGORIES
(CATEGORY_NAME)
VALUES 
	('Smart Phone'),
	('Laptop'),
	('Tablet')
;

INSERT INTO PRODUCTS 
(PRODUCT_NAME, CATEGORY_ID)
VALUES 
	('iPhone', 1),
	('Samsung Galaxy', 1),
	('HP Elite', 2),
	('Lenovo Thinkpad', 2),
	('iPad', 3),
	('Kinder Fire', 3)
;

--------------------------------------------------------------------------------
-- NATURAL JOIN ���� (�� �� ���̺��� ���� �̸��� ���� �÷� ���� INNER JOIN ������ ���)
SELECT
	*
FROM
	PRODUCTS A --COLUMN ���� ���� ���� �ʾƵ� �ż� SQL���� ��������
NATURAL JOIN
	CATEGORIES B 
;

-------------------------------------------------------------------------------
-- �� ������ INNER JOIN������ ǥ���ϸ�
SELECT
	A.CATEGORY_ID, A.PRODUCT_ID, A.PRODUCT_NAME, B.CATEGORY_NAME 
FROM
	PRODUCTS A
INNER JOIN
	CATEGORIES B
ON (A.CATEGORY_ID = B.CATEGORY_ID)
;

--------------------------------------------------------------------------------
-- NATURAL JOIN ����2 (DVD RENTAL ������) - ���� �� �� �̻��� COLUMN���� �ߺ��ȴٸ� ��� �ɱ�?

SELECT * FROM CITY;  -- �� ���̺� ��� COUNTRY_ID�� LAST_UPDATE �÷��� ������ ����
SELECT * FROM COUNTRY;

SELECT *   -- COUNTRY_ID�� LAST_UPDATE�� ���ÿ� ��ġ�� �����Ͱ� ��µ� (�׷� �����ʹ� ����...)
FROM CITY A
NATURAL JOIN COUNTRY B;
-- NATURAL JOIN�� ���ϱ� ������ COLUMN���� ���� �����͸� ������ INNER JOIN�ϱ� ������ �ǵ���� ��µǱ� ������� �ǹ����� ���� ������� ����
-- ���� �����Ͱ� ���� ���� �� LAST UPDATE�� ó�� ���� ��¥�� ���̺� �����صδµ� NATURAL JOIN�� �̿��ϸ� �̷� �����ͳ����� ���ľ��ؼ� ���� ���� ��
-- ������ ������ JOIN ������ INNER JOIN�� �̿��ؼ� �ٲٸ� �Ʒ��� ����

SELECT
	*
FROM 
	CITY A
INNER JOIN
	COUNTRY B
ON 
	(A.COUNTRY_ID = B.COUNTRY_ID);

---------------------------------------------------------------------------------
-- GROUP BY ����
SELECT
	CUSTOMER_ID  --GROUP BY ������ COLUMN�� ����ϸ� �ش� COLUMN�� ���� DISTINCT ������ ǥ����
FROM 
	PAYMENT
GROUP BY CUSTOMER_ID;

--�� ���� ��¹��� �Ʒ� ��¹��� ������
SELECT
	DISTINCT CUSTOMER_ID
FROM
	PAYMENT
;
-----------------------------------
--�ŷ������� ���� ���� ���� ������� ����ϱ�
SELECT
	CUSTOMER_ID,
	SUM(AMOUNT) AS AMOUNT_SUM  --���� �̸� ���� �����ָ� 'SUM'���� �÷����� ������
FROM
	PAYMENT
GROUP BY
	CUSTOMER_ID
ORDER BY 
	SUM(AMOUNT) DESC;   --ȣ�� SUM ���� ����� ����ε� ������ ������
-- �̷��Ե� ���İ���
SELECT
	CUSTOMER_ID,
	SUM(AMOUNT) AS AMOUNT_SUM  --���� �̸� ���� �����ָ� 'SUM'���� �÷����� ������
FROM
	PAYMENT
GROUP BY
	CUSTOMER_ID
ORDER BY 
	2 DESC; 
-------------------------------------
--�ŷ��� ���� ���� ó���� ������ ������� ����ϱ�
SELECT
	STAFF_ID,
	COUNT(PAYMENT_ID) AS COUNT
FROM
	payment
GROUP BY
	STAFF_ID
ORDER BY
	2 DESC;
	
--���࿡ GROUP BY�� �ϸ鼭 SELECT�� ���������...
--�ŷ��� ���� ���� ó���� ������ ������� ����ϴµ�, STAFF ���̺��� �ش� �������� �̸��� �Բ� ���������� ��
SELECT
	A.STAFF_ID,
	B.STAFF_ID,
	B.FIRST_NAME,
	B.LAST_NAME,
	COUNT(A.PAYMENT_ID) AS COUNT
FROM
	PAYMENT A,
	STAFF B
WHERE
	A.STAFF_ID = B.STAFF_ID
GROUP BY               -- GROUP BY �����Լ��� �� COLUMN�� �����ϰ� ��� �÷��� ����� ���� ���� (STAFF�� ID, NAME�� ��� �ϳ��̱� ����)
	A.STAFF_ID,
	B.STAFF_ID,
	B.FIRST_NAME,
	B.LAST_NAME;
	
------------------------------------------------------------------------------------
--HAVING�� ���� (HAVING�� �̿��� GROUP BY ����� ���͸��ϱ�)
SELECT
	CUSTOMER_ID, 
	SUM(AMOUNT) AS AMOUNT
FROM 
	PAYMENT
GROUP BY CUSTOMER_ID
HAVING SUM(AMOUNT) > 200;  --ORDER BY�� �� �÷��� �����Ѵ�� AMOUNT DESC�� �ᵵ �Ǵµ�.. HAVING���� AMOUNT�� ���� ������..

--CUSTOMER_ID�� EMAIL�� JOIN�ؼ� �Բ� ����غ���
SELECT
	A.CUSTOMER_ID,
	B.EMAIL,
	SUM(A.AMOUNT) AS AMOUNT
FROM
	PAYMENT A,
	CUSTOMER B
WHERE
	A.CUSTOMER_ID = B.CUSTOMER_ID
GROUP BY
	A.CUSTOMER_ID,
	B.EMAIL
	-- �� ID�� �� EMAIL�̴� �� �ٷ� GRUOP BY ���ְ�
HAVING
	SUM(A.AMOUNT) > 200
;

-- STORE �� CUSTOMER�� ���� ����Ѵ�
SELECT
	STORE_ID,
	COUNT(CUSTOMER_ID) AS COUNT
FROM
	CUSTOMER
GROUP BY
	STORE_ID
;

-------------------------------------------------------------------------
--GRUOPING SET �� ���� ������ ����
CREATE TABLE SALES
(
BRAND VARCHAR NOT NULL, 
SEGMENT VARCHAR NOT NULL, 
QUANTITY INT NOT NULL, 
PRIMARY KEY (BRAND, SEGMENT)
);

INSERT INTO SALES (BRAND, SEGMENT, QUANTITY)
VALUES 
('ABC', 'Premium', 100),
('ABC', 'Basic', 200),
('XYZ', 'Premium', 100),
('XYZ', 'Basic', 300);

--GROUP BY SET�� UNION ALL�� ������ ����� SQL�� ���� ����� ����
SELECT            --BRAND, SEGMENT�� �׷����� QUANTITY ��
	BRAND,
	SEGMENT,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY 
	BRAND,
	SEGMENT
UNION ALL 
SELECT BRAND,     --BRAND�� �׷����� QUANTITY ��
	NULL,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY
	BRAND
UNION ALL
SELECT            --SEGMENT�� �׷����� QUANTITY ��
	NULL,
	SEGMENT,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY
	SEGMENT
UNION ALL
SELECT            --��ü QUANTITY�� ��
	NULL,
	NULL,
	SUM(QUANTITY)
FROM
	SALES;
	
SELECT * FROM SALES;

-- GROUPING SET�� �̿��ϸ� �Ʒ��� ���� �ܼ�ȭ�� �� �ִ�.
SELECT
	BRAND,
	SEGMENT,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY
	GROUPING SETS 
	( 
	(BRAND,
	SEGMENT),
	(BRAND),
	(SEGMENT),
	()
	)
ORDER BY BRAND, SEGMENT;

-- GROUPING SET�� ����� ���� ���� ǥ��
SELECT
	CASE WHEN GROUPING(BRAND) = 0 AND GROUPING(SEGMENT) = 0 THEN '�귣�庰+��޺�'
		 WHEN GROUPING(BRAND) = 0 AND GROUPING(SEGMENT) = 1 THEN '�귣�庰'
		 WHEN GROUPING(BRAND) = 1 AND GROUPING(SEGMENT) = 0 THEN '��޺�'
		 WHEN GROUPING(BRAND) = 1 AND GROUPING(SEGMENT) = 1 THEN '��ü�հ�'
		 ELSE ''
		 END AS "�������"    -- ��.. COLUMN �̸� ��Ī�� �� ū ����ǥ ����.. value�� ��Ī�� �� ��������ǥ ��� ��.. �� �׷��� ������.. 
	, BRAND
	, SEGMENT
	, SUM(QUANTITY)
FROM 
	SALES 
GROUP BY 
GROUPING SETS 
	( 
	(BRAND,SEGMENT),
	(BRAND),
	(SEGMENT),
	()
	)
ORDER BY BRAND, SEGMENT;

-----------------------------------------------------------------------------------------
-- ROLLUP �Լ� ���� (GROUPING SET SALES ������ ���� �ٽ� Ȱ��)
SELECT
	BRAND,
	SEGMENT,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY
	ROLLUP (BRAND, SEGMENT)
ORDER BY
	BRAND,
	SEGMENT;
	
----------------------------------------------------------------------------------------
--�κ� ROLLUP�� ����� ���� ��ü �հ踦 ������ ����
SELECT
	BRAND,
	SEGMENT,
	SUM(QUANTITY)
FROM
	SALES
GROUP BY SEGMENT,
	ROLLUP (BRAND)
ORDER BY
	BRAND,
	SEGMENT;

-----------------------------------------------------------------------------------------
--CUBE�� ���� (SALES ������ Ȱ��)
-- GROUP BY �� �հ� + BRAND �� + SEGMENT�� + ��ü�հ踦 ���
SELECT 
	BRAND, SEGMENT,
	SUM(QUANTITY)
FROM SALES 
GROUP BY
	CUBE (BRAND, SEGMENT)  -- �ٵ� GROUPING SET�̶� ���� �޶�?
ORDER BY  
	BRAND, SEGMENT;
	
--�κ� CUBE
SELECT BRAND, SEGMENT, SUM(QUANTITY)
FROM SALES
GROUP BY BRAND,
		CUBE (SEGMENT)
ORDER BY 
	BRAND, SEGMENT; 
	
------------------------------------------------------------------------------------------
--�м��Լ� ���� ������ �����
CREATE TABLE PRODUCT_GROUP(
	GROUP_ID SERIAL PRIMARY KEY,
	GROUP_NAME VARCHAR(255) NOT NULL
);

CREATE TABLE PRODUCT(
	PRODUCT_ID SERIAL PRIMARY KEY
	,PRODUCT_NAME VARCHAR (255) NOT NULL
	,PRICE DECIMAL (11,2)
	,GROUP_ID INT NOT NULL
	,FOREIGN KEY (GROUP_ID)
	REFERENCES PRODUCT_GROUP(GROUP_ID)
)

INSERT INTO PRODUCT_GROUP(GROUP_NAME)
VALUES
	('Smartphone'),
	('Laptop'),
	('Tablet');

INSERT INTO PRODUCT (PRODUCT_NAME, GROUP_ID, PRICE)
VALUES
	('Microsoft Lumia', 1, 200),
	('HTC One', 1, 400),
	('Nexus', 1, 500),
	('iPhone', 1, 900),
	('HP Elite', 2, 1200),
	('Lenovo Thinkpad', 2, 700),
	('Sony VAIO', 2, 700),
	('Dell Vostro', 2, 800),
	('iPad', 3, 700),
	('Kindle Fire', 3, 150),
	('Samsung Galaxy Tab', 3, 200);


--------------------------------------------------------------------------------------
--�м��Լ� ����  (COUNT�� �ٸ��� �ش� ������� ����� ��� ������ �Բ� �������)
-- ������ + ���̺��� ����
SELECT
	COUNT(*) OVER(), A.*
FROM 
	PRODUCT A

--------------------------------------------------------------------------------------
--AVG �Լ� (����)
SELECT
	AVG(PRICE)
FROM
	PRODUCT;

-- ��ǰ ī�װ����� ���� ����� ���ϱ�
-- GROUP BY + AVG 
SELECT
	B.GROUP_NAME,
	AVG(PRICE)
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B ON
	(A.GROUP_ID = B.GROUP_ID)
GROUP BY
	B.GROUP_NAME;

-- �м� �Լ��� ����ؼ� ���̺� ������� ���� ����ϱ� (���̺� �÷��� ���� + AVG)
SELECT
	A.PRODUCT_NAME,
	A.PRICE,
	B.GROUP_NAME,
	AVG(A.PRICE) OVER (PARTITION BY B.GROUP_NAME)
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B ON
	(A.GROUP_ID = B.GROUP_ID);

-- �м��Լ� �ȿ� �ִ� ORDER BY�� �ܼ��� ���� X ������ �ڿ� ���� ���ذ��� ���� ����� ������
SELECT
	A.PRODUCT_NAME,
	A.PRICE,
	B.GROUP_NAME,
	AVG(A.PRICE) OVER (PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)  --GROUP_NAME���� �����ϰ� PRICE�� ������ո� ������
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B ON
	(A.GROUP_ID = B.GROUP_ID);

------------------------------------------------------------------------------------------
-- ROW_NUMBER ����
-- ROW_NUMBER�� GROUP_NAME ���� �׷�ȭ + PRICE ���� �������� �����ؼ� ���� ROW_NUM�� ����
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	ROW_NUMBER () OVER 
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)  -- ROW_NUM�� ORDER BY ���ؿ� ���� ���� �־ ������ ���������� (1,2,3,4,5...) ��
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B 
	ON (A.GROUP_ID = B.GROUP_ID);

--------------------------------------------------------------------------------------------
--RANK ����
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	RANK () OVER 
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)  -- RANK�� �������� ���� ������ �Ű��� (���������� �ǳʶ�)
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B 
	ON (A.GROUP_ID = B.GROUP_ID);

----------------------------------------------------------------------------------------------
--DENSE_RANK ����
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	DENSE_RANK () OVER 
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)  -- �������� ���� ������ �Ű�����, ���� ���� �ǳʶ��� ����
FROM
	PRODUCT A
INNER JOIN PRODUCT_GROUP B 
	ON (A.GROUP_ID = B.GROUP_ID);


-----------------------------------------------------------------------------------------------
--FIRST_VALUE ����
--product_group ���� ���� ������ ���� �����͸� �̾ƺ���
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE, 
	FIRST_VALUE (A.PRICE) OVER
	(PARTITION BY B.GROUP_NAME ORDER BY A.price)
	AS LOWEST_PRICE_PER_GROUP
	FROM PRODUCT A
	INNER JOIN PRODUCT_GROUP B
		ON (A.GROUP_ID = B.group_id)
		
------------------------------------------------------------------------------------------------
--LAST_VALUE ����
SELECT
	A.PRODUCT_NAME, B.GROUP_NAME, A.PRICE, LAST_VALUE (A.PRICE) OVER
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE DESC)  --���� ROW ���� ���������� ROW �� ������ ���� ����
	AS LOWEST_PRICE_PER_GROUP
FROM PRODUCT A
INNER JOIN PRODUCT_GROUP B
	ON (A.GROUP_ID = B.GROUP_ID);

--�׷� ���� ��ü ROW �� ���������� �̰� �Ϸ��� LAST_vALUE�� RANGE�� �����ؾ� ��
SELECT
	A.PRODUCT_NAME, B.GROUP_NAME, A.PRICE, LAST_VALUE (A.PRICE) OVER
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE DESC
	RANGE BETWEEN UNBOUNDED PRECEDING 
	AND UNBOUNDED FOLLOWING)  -- DEFAULT�� UNBOUNDED PRECEDING AND CURRENT ROW ��
	AS LOWEST_PRICE_PER_GROUP
FROM PRODUCT A
INNER JOIN PRODUCT_GROUP B
	ON (A.GROUP_ID = B.GROUP_ID);

-------------------------------------------------------------------------------------------------
--LAG �Լ� ����
--PRICE ���� �ٷ� ���� ���� ã�Ƽ� ���� ���� ����
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	LAG(A.PRICE, 1) OVER  -- PRICE ���� 1��° ���� ���� ã�Ƽ� PREV_PRICE�� 
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)
	AS PREV_PRICE,
	A.PRICE - LAG(PRICE,1) OVER (  -- ���� PRICE�� �������� ���� ���ؼ� �� ���� �ֱ�
	PARTITION BY GROUP_NAME ORDER BY A.PRICE )
	AS CUR_PREV_DIFF
FROM PRODUCT A
INNER JOIN PRODUCT_GROUP B
	ON (A.GROUP_ID = B.GROUP_ID);

--PRICE ���� 2��° �� ���� ã�� ���� ���� ���� ���ϱ�
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	LAG(A.PRICE, 2) OVER   
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)
	AS PREV_PRICE,
	A.PRICE - LAG(PRICE,2) OVER (  
	PARTITION BY GROUP_NAME ORDER BY A.PRICE )
	AS CUR_PREV_DIFF
FROM PRODUCT A
INNER JOIN PRODUCT_GROUP B
	ON (A.GROUP_ID = B.GROUP_ID);
	
---------------------------------------------------------------------------------------------------------
--LEAD �Լ� ����
SELECT
	A.PRODUCT_NAME,
	B.GROUP_NAME,
	A.PRICE,
	LEAD(A.PRICE, 1) OVER   
	(PARTITION BY B.GROUP_NAME ORDER BY A.PRICE)
	AS NEXT_PRICE,
	A.PRICE - LEAD(PRICE,1) OVER (  
	PARTITION BY GROUP_NAME ORDER BY A.PRICE )
	AS CUR_NEXT_DIFF
FROM PRODUCT A
INNER JOIN PRODUCT_GROUP B
	ON (A.GROUP_ID = B.GROUP_ID);
	
----------------------------------------------------------------------------------------------------------
--------------------------------------------CHAP.3 �ǽ�����1-------------------------------------------------
----DVDRENTAL �������� RENTAL ���̺��� �̿��Ͽ� ��,��,������,��ü ������ �������� RENTAL_ID ���� ��Ż�� �Ͼ Ƚ���� ����϶�----
--(��ü �����͸� �������� ��� ���� ����ؾ� ��)----------------------------------------------------------------------
-- �м��Լ� �̿��ؾ� �ٱ�.. COUNT(RENTAL_DATE), GROUP BY�� �ϴµ� RENTAL ID�� ������ �����ؾ� ��
SELECT 
	TO_CHAR(RENTAL_DATE, 'YYYY') Y,
	TO_CHAR(RENTAL_DATE, 'MM') M,
	TO_CHAR(RENTAL_DATE, 'DD') D,
	COUNT(RENTAL_ID)
FROM RENTAL
GROUP BY
ROLLUP
(
	TO_CHAR(RENTAL_dATE, 'YYYY'),
	TO_CHAR(RENTAL_DATE, 'MM'),
	TO_CHAR(RENTAL_DATE, 'DD')
);

------------------------------------------------------------------------------------------------------------
----------------------------------------------CHAP.3 �ǽ�����2------------------------------------------------
-------RENTAL�� CUSTOMER ���̺��� �̿��Ͽ� ������� ���� ���� RENTAL�� �� ���� ID, ��Ż����, ������ŻȽ��, �̸��� ����϶�------

SELECT
	A.customer_id ,
	ROW_NUMBER() OVER(ORDER BY COUNT(A.RENTAL_ID) DESC) AS RENTAL_RANK,
	COUNT(A.RENTAL_ID) RENTAL_COUNT,
	MAX(B.FIRST_NAME) AS FIRST_NAME,
	MAX(B.LAST_NAME) AS LAST_NAME
FROM 
	RENTAL A, CUSTOMER B
WHERE
	A.CUSTOMER_ID = B.customer_id 
GROUP BY A.CUSTOMER_ID ORDER BY RENTAL_RANK LIMIT 1;

	