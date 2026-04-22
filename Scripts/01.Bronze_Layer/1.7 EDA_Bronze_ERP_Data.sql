/*
 =================================================================
 Exploratory Data Analysis for data cleaning.
 =================================================================
 */
/*
 =================================================================
 Checking Bronze.ERP_Cust_az12 Table
 =================================================================
 */
-- Checking NULLS

SELECT * FROM Bronze.ERP_Cust_az12 WHERE cid IS NULL OR bdate IS NULL OR gen IS NULL

-- Checking Invalid Date
SELECT DISTINCT bdate FROM Bronze.ERP_Cust_az12 WHERE bdate < '1924-01-01' OR bdate > GETDATE()


-- Checking data consistency
SELECT DISTINCT gen FROM Bronze.ERP_Cust_az12

/*
 =================================================================
 Checking Bronze.ERP_Loc_a101 Table
 =================================================================
 */

 -- Checking NULLS

 SELECT * FROM Bronze.ERP_Loc_a101 WHERE CID IS NULL OR CNTRY IS NULL

 -- Checking Data Consistency
 SELECT DISTINCT CNTRY FROM Bronze.ERP_Loc_a101

 SELECT CASE WHEN TRIM(CNTRY) IN ('US','USA') THEN 'United States'
			WHEN TRIM(CNTRY) IN ('DE') THEN 'Germany'
			WHEN TRIM(CNTRY) = '' OR CNTRY IS NULL THEN 'Others'
			ELSE TRIM(CNTRY)
			END AS Country
	FROM Bronze.ERP_Loc_a101


/*
 =================================================================
 Checking Bronze.ERP_PX_Cat_g1v2 Table
 =================================================================
 */

 -- Checking NULLS

 SELECT * FROM Bronze.ERP_PX_Cat_g1v2 WHERE id IS NULL OR cat IS NULL OR subcat IS NULL OR maintenance IS NULL

 -- Checking spaces
 SELECT cat FROM Bronze.ERP_PX_Cat_g1v2 WHERE cat != TRIM(cat)
 SELECT subcat FROM Bronze.ERP_PX_Cat_g1v2 WHERE cat != TRIM(subcat)
 SELECT maintenance FROM Bronze.ERP_PX_Cat_g1v2 WHERE cat != TRIM(maintenance)

 -- Checking data consistency
 SELECT DISTINCT cat FROM Bronze.ERP_PX_Cat_g1v2
 SELECT DISTINCT subcat FROM Bronze.ERP_PX_Cat_g1v2
 SELECT DISTINCT maintenance FROM Bronze.ERP_PX_Cat_g1v2