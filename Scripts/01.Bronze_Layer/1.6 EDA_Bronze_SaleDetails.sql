/*
 =================================================================
 Exploratory Data Analysis for data cleaning.
 =================================================================
 */
/*
 =================================================================
 Checking Bronze.CRM_SaleDetails Table
 =================================================================
 */
-- Checking Invalid Dates

SELECT
sls_order_dt
FROM Bronze.CRM_SaleDetails
WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) != 8 OR sls_order_dt > 20500101 OR sls_order_dt < 19000101

SELECT
sls_ship_dt
FROM Bronze.CRM_SaleDetails
WHERE sls_ship_dt <= 0 OR LEN(sls_ship_dt) != 8 OR sls_ship_dt > 20500101 OR sls_ship_dt < 19000101

SELECT
sls_due_dt
FROM Bronze.CRM_SaleDetails
WHERE sls_due_dt <= 0 OR LEN(sls_due_dt) != 8 OR sls_due_dt > 20500101 OR sls_due_dt < 19000101


SELECT * FROM Bronze.CRM_SaleDetails
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt>sls_due_dt


-- Checking sales, quantity and price data consistency
-- Sales = Quantity * Price
-- Values must not be NULL, zero or negative

SELECT sls_sales, sls_quantity, sls_price FROM Bronze.CRM_SaleDetails
WHERE sls_sales != sls_quantity*sls_price
	OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
	OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0