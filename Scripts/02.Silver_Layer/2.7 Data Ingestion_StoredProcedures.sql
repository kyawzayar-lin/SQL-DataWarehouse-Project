USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [Silver].[ETL_Procedure]    Script Date: 03/09/2026 09:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      Kyaw Zayar Lin
-- Create date: 09/03/2026
-- Description: ETL store procedure for silver layer
-- =============================================
ALTER   PROCEDURE [Silver].[ETL_Procedure]
AS 
BEGIN 
    SET NOCOUNT ON;

	PRINT '=================================';

	PRINT 'TRUNCATE Data from the table';

	TRUNCATE TABLE Silver.CRM_CustomerInfo 

	PRINT '=================================';

	PRINT '=================================';

	PRINT 'Inserting Data to the table';

	PRINT '=================================';

	INSERT INTO
		Silver.CRM_CustomerInfo(
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

	PRINT '=================================';

	PRINT 'TRUNCATE Data from the table';

	TRUNCATE TABLE Silver.CRM_ProductInfo 

	PRINT '=================================';

	PRINT '=================================';

	PRINT 'Inserting Data to the table';

	PRINT '=================================';

	INSERT INTO
		Silver.CRM_ProductInfo(
			product_id,
			product_category_id,
			product_key,
			product_number,
			product_cost,
			product_line,
			product_start_date,
			product_end_date
		)
	SELECT
		prd_id AS product_id,
		REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS product_category_id,
		REPLACE(SUBSTRING(prd_key, 7, LEN(prd_key)), '-', '_') AS product_key,
		prd_nm AS product_number,
		ISNULL(prd_cost, 0) AS product_cost,
		CASE
			UPPER(prd_line)
			WHEN 'R' THEN 'Road'
			WHEN 'M' THEN 'Mountain'
			WHEN 'T' THEN 'Touring'
			WHEN 'S' THEN 'Other Sale'
			ELSE 'Unknown'
		END AS product_line,
		CAST([prd_start_dt] AS DATE) AS product_start_date,
		DATEADD(
			DAY,
			-1,
			CAST(
				LEAD(prd_start_dt) OVER (
					PARTITION BY prd_key
					ORDER BY
						prd_start_dt
				) AS DATE
			)
		) AS product_end_date
	FROM
		[DataWarehouse].[Bronze].[CRM_ProdcutInfo];

	PRINT '=================================';

	PRINT 'TRUNCATE Data from the table';

	TRUNCATE TABLE Silver.CRM_SaleDetails 

	PRINT '=================================';

	PRINT '=================================';

	PRINT 'Inserting Data to the table';

	PRINT '=================================';

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
		[DataWarehouse].[Bronze].[CRM_SaleDetails];

	PRINT '=================================';

	PRINT 'TRUNCATE Data from the table';

	TRUNCATE TABLE Silver.ERP_CustomerInfo 

	PRINT '=================================';

	PRINT '=================================';

	PRINT 'Inserting Data to the table';

	PRINT '=================================';

	INSERT INTO
		Silver.ERP_CustomerInfo(customer_id, birth_date, gender)
	SELECT
		CASE
			WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
			ELSE cid
		END AS customer_id,
	CASE
			WHEN bdate > GETDATE() THEN NULL
			ELSE bdate
		END AS birth_date,
	CASE
			WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
			WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
			ELSE 'Unknown'
		END AS gender
	FROM
		[DataWarehouse].[Bronze].[ERP_Cust_az12];

	PRINT '=================================';

	PRINT 'TRUNCATE Data from the table';

	TRUNCATE TABLE Silver.ERP_CustomerLocation 

	PRINT '=================================';

	PRINT '=================================';

	PRINT 'Inserting Data to the table';

	PRINT '=================================';

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
		[DataWarehouse].[Bronze].[ERP_Loc_a101];

	PRINT '=================================';

	PRINT 'TRUNCATE Data from the table';

	TRUNCATE TABLE Silver.ERP_ProductCategory 

	PRINT '=================================';

	PRINT '=================================';

	PRINT 'Inserting Data to the table';

	PRINT '=================================';

	INSERT INTO
		Silver.ERP_ProductCategory(
			product_id,
			product_category,
			product_subcategory,
			maintenance
		)
	SELECT
		id AS product_category_id,
		cat AS product_category,
		TRIM(subcat) AS product_subcategory,
		TRIM(maintenance) AS maintenance
	FROM
		[DataWarehouse].[Bronze].[ERP_PX_Cat_g1v2];

END