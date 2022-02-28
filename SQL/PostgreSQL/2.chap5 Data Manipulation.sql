---------------------------------------------------------------------
--INSERT�� ����
CREATE TABLE LINK (
	ID SERIAL PRIMARY KEY
	,URL VARCHAR (255) NOT NULL
	,NAME VARCHAR (255) NOT NULL
	,DESCRIPTION VARCHAR (255)
	,REL VARCHAR (50)
	);
	
SELECT * FROM LINK  -- ���� �ƹ� ���� ������� ���� ����

INSERT 
	INTO LINK
	(URL, NAME)
	VALUES
	('http://naver.com', 'Naver')
	,('''http://naver.com''', '''Naver''')  --��������ǥ �Է� �� ''�� �Է��ϸ� ��������ǥ�� �ν�
	;
	
COMMIT;

SELECT * FROM LINK;

---------------------------------------------------------------
--������ ������ ���̺� �����
CREATE TABLE LINK_TMP AS
SELECT * FROM LINK WHERE 0 = 1;

--LINK�� �ִ� �����͸� LINK_TMP�� �ű�
INSERT INTO LINK_TMP
SELECT * FROM LINK;

--LINK_TMP �� LINK�� ���� �����͸� Ȯ��(0��)
SELECT * FROM LINK_TMP
EXCEPT
SELECT * FROM LINK;

----------------------------------------------------------------
--UPDATE�� ���� (LAST UPDATE �÷��� �߰��ϰ� ���� ����)
ALTER TABLE LINK ADD COLUMN LAST_UPDATE DATE;  --LINK ���̺��� �����Ѵ�: DATEŸ���� LAST_UPDATE �÷��� �߰�
ALTER TABLE LINK ALTER COLUMN LAST_UPDATE SET DEFAULT CURRENT_DATE; --LINK ���̺� ����: LAST_UPDATE�� DEFAULT VALUE�� CURRENT_DATE�� ����

SELECT * FROM LINK;

UPDATE LINK
SET LAST_UPDATE = DEFAULT  --LAST_UPDATE ���� ������ DEFULAT ������ UPDATE
WHERE LAST_UPDATE IS NULL; --����: LAST_UPDATE�÷��� NULL�� ���� ����

COMMIT;

SELECT * FROM LINK;

--��ü ���̺� ����
UPDATE LINK
SET REL = 'NO DATA'; --rel �÷��� �ϳ��ϳ� �����鼭 NO DATA STRING�� �������

COMMIT;
SELECT * FROM LINK; 

UPDATE LINK
SET DESCRIPTION = NAME;
COMMIT;
SELECT * FROM LINK;

-----------------------------------------------------------------
--UPDATE JOIN �ǽ� (������ * �ǸŰ��� ����� NET_PRICE �÷��� ���� �c����Ʈ�ϱ�)
CREATE TABLE PRODUCT_SEGMENT
(
	ID SERIAL PRIMARY KEY
	,SEGMENT VARCHAR NOT NULL
	,DISCOUNT NUMERIC (4,2)
);

INSERT INTO PRODUCT_SEGMENT (SEGMENT, DISCOUNT)
VALUES
	('Grand Luxury', 0.05)
	,('Luxury', 0.06)
	,('Mass', 0.1);
COMMIT;

CREATE TABLE PRODUCT(
	ID SERIAL PRIMARY KEY
	,NAME VARCHAR NOT NULL
	,NET_PRICE NUMERIC(10,2)
	,SEGMENT_ID INT NOT NULL
	,FOREIGN KEY(SEGMENT_ID)
	REFERENCES PRODUCT_SEGMENT(ID)
);

INSERT INTO PRODUCT (NAME, PRICE, SEGMENT_ID)
VALUES
	('K5', 804.89, 1)
	,('K7', 228.55, 3)
	,('K9', 366.45, 2)
	,('SONATA', 145.33, 3)
	,('SPARK', 551.77, 2)
	,('AVANTE', 261.58, 3)
	,('LOZTE', 591.62, 2)
	,('SANTAFE', 843.31, 1)
	,('TUSAN', 254.18, 3)
	,('TRAX', 427.78, 2)
	,('ORANDO', 936.29, 1)
	,('RAY', 910.34, 1)
	,('MORNING', 208.33, 3)
	,('VERNA', 985.45, 1)
	,('K8', 841.26, 1)
	,('TICO', 896.38, 1)
	,('MATIZ', 575.74, 2)
	,('SPORTAGE', 530.64, 2)
	,('ACCENT', 892.43, 1)
	,('TOSCA', 161.71, 3);
COMMIT;

--NET PRICE �� ������Ʈ (PRODUCT_SEGMENT ���̺��� �������� PRODUCT���̺��� ������ ����)
UPDATE PRODUCT A
SET NET_PRICE = A.PRICE - (A.PRICE * B.DISCOUNT)
FROM PRODUCT_SEGMENT B
WHERE A.SEGMENT_ID = B.ID;

SELECT * FROM PRODUCT;

------------------------------------------------------------------
--DELETE��

DELETE FROM LINK
WHERE ID = 2;  --ID�� 2�� �����͸� ����
COMMIT;

--���̺��� �����ؼ� ������ �ְ� �����ϱ�
DELETE FROM LINK_TMP A
USING LINK B
WHERE A.ID = B.ID;    --LINK_TMP �� ID�� LINK���� ����ִ� ������ ����
COMMIT;
SELECT * FROM LINK_TMP; --Ȯ�� (LINK���� ID = 2�� �����Ͱ� ������ ID=2�� LINK_TMP �����͸� ����)

--���̺� ������ ��ü�� ������
DELETE FROM LINK;
COMMIT;

-------------------------------------------------------------------
--UPSERT��
--���� ���̺� �����
CREATE TABLE CUSTOMERS
(
	CUSTOMER_ID SERIAL PRIMARY KEY
	,NAME VARCHAR UNIQUE   --UNIQUE ������������ ���� NAME�� �ߺ��� �÷��� ����
	,EMAIL VARCHAR NOT NULL
	,ACTIVE BOOL NOT NULL DEFAULT TRUE
);

INSERT INTO CUSTOMERS (NAME, EMAIL)
VALUES
	('IBM', 'contact@ibm.com')
	,('Microsoft', 'contact@microsoft.com')
	,('Intel', 'contact@intel.com');
COMMIT;

--SQL ���� �߻� �� UPDATE�� ���� �ʰ� ����
INSERT INTO CUSTOMERS (NAME, EMAIL)
VALUES
	('Microsoft', 'hotline@microsoft.com')  --NAME �÷� UNIQUE �������� ���
ON CONFLICT (NAME)  --�浹��
DO NOTHING;         --�ƹ��͵� ����
COMMIT;

--UPDATE
INSERT INTO CUSTOMERS (NAME, EMAIL)
VALUES (
	'Microsoft','hotline@microsoft.com'
	) ON CONFLICT (NAME)    --NAME���� �浹��
	DO UPDATE               --UPDATE�� �Ѵ�
		SET EMAIL = EXCLUDED.EMAIL || ';' || CUSTOMERS.EMAIL --EXCLUDED.EMAIL�� ������ INSERT�� �õ��� hotline~ �̸����� ����Ŵ
	;                                                        --str||str||str �� string�� �̾���δٴ� ��
COMMIT;
)

SELECT * FROM customers;

---------------------------------------------------------------
--EXPOTR ����

--�ǽ�1(���� �������� ����ϱ�)
COPY CATEGORY(CATEGORY_ID, NAME, LAST_UPDATE)  --������ ���̺�, �÷� ����
TO 'G:\tmp\DB_category.csv'   --��� ���� (�̹� �ִ� �������� ��)
DELIMITER ','                 --������ ����
CSV HEADER                    --�������� ����(header�� ������ column�� �Բ� ����)
;

--�ǽ�2(�ؽ�Ʈ ���Ϸ� ���)
COPY CATEGORY(CATEGORY_ID, NAME, LAST_UPDATE)   --������ ���̺�� �÷� ����
TO 'G:\tmp\DB_CATEGORY.txt'          
DELIMITER '|' 
CSV HEADER
;

--------------------------------------------------------------
--IMPORT ����

--�ǽ����̺� �����
CREATE TABLE CATEGORY_IMPORT
(
	CATEGORY_ID SERIAL NOT NULL
	,"NAME" VARCHAR(25) NOT NULL
	, LAST_UPDATE TIMESTAMP NOT NULL DEFAULT NOW()
	,CONSTRAINT CATEGORY_IMPORT_PKEY PRIMARY KEY (CATEGORY_ID)
);

SELECT * FROM CATEGORY_IMPORT;

--export �������� ������� ������ import�ؿ�
COPY CATEGORY_IMPORT(CATEGORY_ID, "NAME", LAST_UPDATE)
FROM 'G:\tmp\DB_CATEGORY.csv'
DELIMITER ','
CSV HEADER  --HEADER ���� ������ header�� �� ����, header�� ���� ���Ͽ��� header�� �������� ù��° �����Ͱ� ����� �νĵż� ������
;

--�ؽ�Ʈ���� import
COPY CATEGORY_IMPORT(CATEGORY_ID, "NAME", LAST_UPDATE)
FROM 'G:\tmp\DB_CATEGORY.txt'
DELIMITER '|'
CSV HEADER
;    --csv������ category_import�� �ҷ����� �� ������ �����ϸ� ���� �߻�(category_id�� �ߺ��� ���ͼ�)
DELETE FROM category_import;--�ش� ���̺� �� ���� �� �ٽ� txt�ҷ����⸦ �����ϸ� ���� ����