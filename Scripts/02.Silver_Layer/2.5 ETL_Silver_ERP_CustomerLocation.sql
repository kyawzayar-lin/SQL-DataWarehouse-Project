/*
 
 =======================================================================
 Data Cleansing & Data Transformation
 =======================================================================
 
 */
-- Data Cleaning & Transformation on Bronze.ERP_Loc_a101 table and Loading to Silver.ERP_CustomerLocation table
INSERT INTO
	Silver.ERP_CustomerLocation(customer_id, country)
SELECT
	REPLACE(cid, '-', '') AS customer_id,
	CASE
		WHEN TRIM(CNTRY) IN ('US', 'USA') THEN 'United States'
		WHEN TRIM(CNTRY) IN ('DE') THEN 'Germany'
		WHEN TRIM(CNTRY) = ''
		OR CNTRY IS NULL THEN 'Others'
		ELSE TRIM(CNTRY)
	END AS Country
FROM
	[DataWarehouse].[Bronze].[ERP_Loc_a101]