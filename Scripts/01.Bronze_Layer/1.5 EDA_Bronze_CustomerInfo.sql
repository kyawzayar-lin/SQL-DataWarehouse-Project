/*
 =================================================================
 Exploratory Data Analysis for data cleaning.
 =================================================================
 */
/*
 =================================================================
 Checking Bronze.CRM_CustomerInfo Table
 =================================================================
 */
-- Checking Nulls and Duplicates for cst_id column
SELECT
	cst_id,
	COUNT(*)
FROM
	Bronze.CRM_CustomerInfo
GROUP BY
	cst_id
HAVING
	COUNT(*) > 1
	OR cst_id IS NULL;

-- Checking for spaces
SELECT
	cst_firstname,
	cst_lastname,
	cst_gndr
FROM
	Bronze.CRM_CustomerInfo
WHERE
	(
		cst_firstname != TRIM(cst_firstname)
		OR cst_lastname != TRIM(cst_lastname)
	);

-- Checking NULLS & Data Consistency
SELECT
	cst_firstname,
	cst_lastname
FROM
	Bronze.CRM_CustomerInfo
WHERE
	cst_firstname IS NULL
	OR cst_lastname IS NULL;

SELECT
	DISTINCT(cst_marital_status)
FROM
	Bronze.CRM_CustomerInfo;

SELECT
	DISTINCT(cst_gndr)
FROM
	Bronze.CRM_CustomerInfo;

SELECT
	cst_key
FROM
	Bronze.CRM_CustomerInfo
WHERE
	cst_key IS NULL;