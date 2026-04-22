/*
 
 =======================================================================
 Data Cleansing & Data Transformation
 =======================================================================
 
 */
-- Data Cleaning & Transformation on Bronze.ERP_Cust_az12 table and Loading to Silver.ERP_CustomerInfo table
INSERT INTO Silver.ERP_CustomerInfo(
	customer_id,
	birth_date,
	gender
)
SELECT 
	CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
	ELSE cid
	END AS customer_id
	,CASE WHEN bdate > GETDATE() THEN NULL
		ELSE bdate
	END AS birth_date
	,CASE 
		WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
		WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
		ELSE 'Unknown'
	END AS gender
  FROM [DataWarehouse].[Bronze].[ERP_Cust_az12]