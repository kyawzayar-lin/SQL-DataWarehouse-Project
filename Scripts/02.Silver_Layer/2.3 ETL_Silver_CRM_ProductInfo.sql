/*
 
 =======================================================================
 Data Cleansing & Data Transformation
 =======================================================================
 
 */
-- Data Cleaning & Transformation on Bronze.CRM.ProductInfo table and Loading to Silver.CRM_ProductInfo table
INSERT INTO
    Silver.CRM_ProductInfo(
        product_id,
        product_category_id product_key,
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