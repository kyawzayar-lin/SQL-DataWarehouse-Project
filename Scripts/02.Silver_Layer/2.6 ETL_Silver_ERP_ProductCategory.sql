/*
 
 =======================================================================
 Data Cleansing & Data Transformation
 =======================================================================
 
 */
-- Data Cleaning & Transformation on Bronze.ERP_PX_Cat_g1v2 table and Loading to Silver.ERP_ProductCategory table

INSERT INTO Silver.ERP_ProductCategory(
	product_id,
    product_category,
    product_subcategory,
    maintenance,	
)
SELECT 
	id AS product_category_id,
	cat AS product_category,
	TRIM(subcat) AS product_subcategory,
	TRIM(maintenance) AS maintenance
  FROM [DataWarehouse].[Bronze].[ERP_PX_Cat_g1v2]