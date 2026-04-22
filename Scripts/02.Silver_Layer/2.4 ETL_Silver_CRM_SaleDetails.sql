/*
 
 =======================================================================
 Data Cleansing & Data Transformation
 =======================================================================
 
 */
-- Data Cleaning & Transformation on Bronze.CRM_SaleDetails table and Loading to Silver.CRM_SaleDetails table
INSERT INTO
	Silver.CRM_SaleDetails(
		order_number,
		product_key,
		customer_id,
		order_date,
		ship_date,
		due_date,
		sale_quantity,
		price,
		sales
	)
SELECT
	sls_ord_num AS order_number,
	REPLACE(sls_prd_key,'-','_') AS product_key,
	sls_cust_id AS customer_id,
CASE
		WHEN sls_order_dt = 0
		OR LEN(sls_order_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
	END AS order_date,
	CASE
		WHEN sls_ship_dt = 0
		OR LEN(sls_ship_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
	END AS ship_date,
CASE
		WHEN sls_due_dt = 0
		OR LEN(sls_due_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
	END AS due_date,
	sls_quantity AS sale_quantity,
CASE
		WHEN sls_price IS NULL
		OR sls_sales <= 0 THEN sls_sales / NULLIF(sls_quantity, 0)
		ELSE sls_price
	END AS price,
CASE
		WHEN sls_sales IS NULL
		OR sls_sales <= 0
		OR sls_sales != sls_quantity * ABS(sls_price) THEN sls_quantity * ABS(sls_price)
		ELSE sls_sales
	END AS sales
FROM
	[DataWarehouse].[Bronze].[CRM_SaleDetails]