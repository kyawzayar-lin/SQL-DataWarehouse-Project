CREATE VIEW Gold.dim_product AS
SELECT
    ROW_NUMBER() OVER (
        ORDER BY
            prd.product_start_date,
            prd.product_key
    ) AS product_primary,
    prd.[product_id],
    prd.[product_category_id],
    prdc.product_category,
    prdc.product_subcategory,
    prdc.maintenance,
    prd.[product_key],
    prd.[product_number],
    prd.[product_cost],
    prd.[product_line],
    prd.[product_start_date],
    prd.[product_end_date],
    prd.[dwh_create_date]
FROM
    [DataWarehouse].[Silver].[CRM_ProductInfo] prd
    LEFT JOIN [DataWarehouse].[Silver].[ERP_ProductCategory] prdc 
    ON prd.product_category_id = prdc.product_id
WHERE
    product_end_date IS NULL