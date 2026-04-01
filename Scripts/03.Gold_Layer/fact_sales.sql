CREATE VIEW Gold.fact_sales AS
SELECT
  sls.[order_number],
  prd.product_id,
  crd.customer_id,
  sls.[order_date],
  sls.[ship_date],
  sls.[due_date],
  sls.[sale_quantity],
  sls.[price],
  sls.[sales],
  sls.[dwh_create_date]
FROM
  [DataWarehouse].[Silver].[CRM_SaleDetails] sls
  LEFT JOIN Gold.dim_customers crd ON sls.customer_id = crd.customer_id
  LEFT JOIN Gold.dim_product prd ON sls.product_key = prd.product_key