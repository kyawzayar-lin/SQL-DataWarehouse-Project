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

-- Checking Nulls and Duplicates for prd_id column

SELECT 
	prd_id,
	COUNT(*)
FROM Bronze.CRM_ProdcutInfo
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Checking for spaces

SELECT 
	prd_nm
FROM Bronze.CRM_ProdcutInfo
WHERE (
	prd_nm != TRIM(prd_nm)
);

-- Checking NULLS & Negative Numbers

SELECT prd_cost
FROM Bronze.CRM_ProdcutInfo
WHERE prd_cost < 0 AND prd_cost IS NULL

SELECT DISTINCT prd_line FROM Bronze.CRM_ProdcutInfo


-- Checking for Invalid Date Orders

SELECT * FROM Bronze.CRM_ProdcutInfo
WHERE prd_end_dt < prd_start_dt
