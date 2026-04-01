/*
 ===============================================================
 DDL Scripts: Creating Bronze Tables
 ===============================================================
 
 Scripts Purpose:
 This DDL Scripts is for tables creation in the Bronze layer
 for raw data from CSV . Columns are created as it's in the
 .csv files for both soure systems.
 
 ================================================================
 */
IF OBJECT_ID('Bronze.CRM_CustomerInfo', 'U') IS NOT NULL DROP TABLE Bronze.CRM_CustomerInfo;

GO
    CREATE TABLE Bronze.CRM_CustomerInfo (
        cst_id INT,
        cst_key NVARCHAR(50),
        cst_firstname NVARCHAR(50),
        cst_lastname NVARCHAR(50),
        cst_marital_status NVARCHAR(50),
        cst_gndr NVARCHAR(50),
        cst_create_date DATE
    );

GO
    IF OBJECT_ID('Bronze.CRM_ProductInfo', 'U') IS NOT NULL DROP TABLE Bronze.CRM_ProdcutInfo;

GO
    CREATE TABLE Bronze.CRM_ProdcutInfo (
        prd_id INT,
        prd_key NVARCHAR(50),
        prd_nm NVARCHAR(50),
        prd_cost INT,
        prd_line NVARCHAR(50),
        prd_start_dt DATETIME,
        prd_end_dt DATETIME
    );

GO
    IF OBJECT_ID('Bronze.CRM_SaleDetails', 'U') IS NOT NULL DROP TABLE Bronze.CRM_SaleDetails;

GO
    CREATE TABLE Bronze.CRM_SaleDetails (
        sls_ord_num NVARCHAR(50),
        sls_prd_key NVARCHAR(50),
        sls_cust_id INT,
        sls_order_dt INT,
        sls_ship_dt INT,
        sls_due_dt INT,
        sls_sales INT,
        sls_quantity INT,
        sls_price INT
    );

GO
    IF OBJECT_ID('Bronze.ERP_Loc_a101', 'U') IS NOT NULL DROP TABLE Bronze.ERP_Loc_a101;

GO
    CREATE TABLE Bronze.ERP_Loc_a101 (
        cid NVARCHAR(50),
        cntry NVARCHAR(50)
    );

GO
    IF OBJECT_ID('Bronze.ERP_Cust_az12', 'U') IS NOT NULL DROP TABLE Bronze.ERP_Cust_az12;

GO
    CREATE TABLE Bronze.ERP_Cust_az12 (
        cid NVARCHAR(50),
        bdate DATE,
        gen NVARCHAR(50)
    );

GO
    IF OBJECT_ID('Bronze.ERP_PX_Cat_g1v2', 'U') IS NOT NULL DROP TABLE Bronze.ERP_PX_Cat_g1v2;

GO
    CREATE TABLE Bronze.ERP_PX_Cat_g1v2 (
        id NVARCHAR(50),
        cat NVARCHAR(50),
        subcat NVARCHAR(50),
        maintenance NVARCHAR(50)
    );

GO