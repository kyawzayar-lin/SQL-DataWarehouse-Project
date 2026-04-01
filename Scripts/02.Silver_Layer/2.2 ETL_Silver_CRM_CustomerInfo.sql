/*
 
 =======================================================================
 Data Cleansing & Data Transformation
 =======================================================================
 
 */
-- Data Cleaning & Transformation on Bronze.CRM.CustomerInfo table and Loading to Silver.CRM_Customer_Info table
INSERT INTO
	Silver.CRM_Customer_Info(
		customer_id,
		customer_key,
		customer_name,
		marital_status,
		gender,
		create_date
	)
SELECT
	cst_id AS customer_id,
	cst_key AS customer_key,
	CONCAT(TRIM(cst_firstname), ' ', TRIM(cst_lastname)) AS customer_name,
	CASE
		WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		ELSE 'Other'
	END marital_status,
	CASE
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		ELSE 'Unknown'
	END gender,
	cst_create_date AS create_date
FROM
	(
		SELECT
			*,
			ROW_NUMBER() OVER (
				PARTITION BY cst_id
				ORDER BY
					cst_create_date DESC
			) as last_created
		FROM
			Bronze.CRM_CustomerInfo
		WHERE
			cst_id IS NOT NULL
	) t
WHERE
	last_created = 1;