CREATE VIEW Gold.dim_customers AS
SELECT 
		ROW_NUMBER() OVER (ORDER BY cust.customer_id) AS primary_key
	  ,cust.[customer_id]
    ,cust.[customer_key]
    ,cust.[customer_name]
    ,cust.[marital_status]
    ,cust.[create_date]
	  ,CASE WHEN cust.gender != 'Unknown' THEN cust.gender
			ELSE COALESCE(cust2.gender,'Unknown')
		END AS gender
	  ,cust2.birth_date
	  ,loc.country
    ,cust.[dwh_create_date]
  FROM [DataWarehouse].[Silver].[CRM_CustomerInfo] cust
  LEFT JOIN Silver.ERP_CustomerInfo cust2
  ON cust.customer_key = cust2.customer_id
  LEFT JOIN Silver.ERP_CustomerLocation loc
  ON cust.customer_key = loc.customer_id