/*
 ===============================================================
 DDL Scripts: Creating Silver Tables
 ===============================================================
 
 Scripts Purpose:
 This DDL Scripts is for tables creation in the Silver layer. 
 Columns are created as it's in the bronze layer for both soure systems.
 
 ================================================================
 */
IF OBJECT_ID('Silver.CRM_CustomerInfo', 'U') IS NOT NULL DROP TABLE Silver.CRM_CustomerInfo;

GO
    CREATE TABLE Silver.CRM_CustomerInfo (
        customer_id INT,
        customer_key NVARCHAR(50),
        customer_name NVARCHAR(150),
        marital_status NVARCHAR(20),
        gender NVARCHAR(20),
        create_date DATE,
        dwh_create_date DATETIME2 DEFAULT GETDATE()
    );

GO
    IF OBJECT_ID('Silver.CRM_ProductInfo', 'U') IS NOT NULL DROP TABLE Silver.CRM_ProdcutInfo;

GO
    CREATE TABLE Silver.CRM_ProductInfo (
        product_id INT,
        product_category_id NVARCHAR(50),
        product_key NVARCHAR(50),
        product_number NVARCHAR(50),
        product_cost INT,
        product_line NVARCHAR(50),
        product_start_date DATE,
        product_end_date DATE,
        dwh_create_date DATETIME2 DEFAULT GETDATE()
    );

GO
    IF OBJECT_ID('Silver.CRM_SaleDetails', 'U') IS NOT NULL DROP TABLE Silver.CRM_SaleDetails;

GO
    CREATE TABLE Silver.CRM_SaleDetails (
        order_number NVARCHAR(50),
        product_key NVARCHAR(50),
        customer_id INT,
        order_date DATE,
        ship_date DATE,
        due_date DATE,
        sale_quantity INT,
        price INT,
        sales INT,
        dwh_create_date DATETIME2 DEFAULT GETDATE()
    );

GO
    IF OBJECT_ID('Silver.ERP_CustomerLocation', 'U') IS NOT NULL DROP TABLE Silver.ERP_CustomerLocation;

GO
    CREATE TABLE Silver.ERP_CustomerLocation (
        customer_id NVARCHAR(50),
        country NVARCHAR(50),
        dwh_create_date DATETIME2 DEFAULT GETDATE()
    );

GO
    IF OBJECT_ID('Silver.ERP_CustomerInfo', 'U') IS NOT NULL DROP TABLE Silver.ERP_CustomerInfo;

GO
    CREATE TABLE Silver.ERP_CustomerInfo (
        customer_id NVARCHAR(50),
        birth_date DATE,
        gender NVARCHAR(50),
        dwh_create_date DATETIME2 DEFAULT GETDATE()
    );

GO
    IF OBJECT_ID('Silver.ERP_ProductCategory', 'U') IS NOT NULL DROP TABLE Silver.ERP_ProductCategory;

GO
    CREATE TABLE Silver.ERP_ProductCategory (
        product_id NVARCHAR(50),
        product_category NVARCHAR(50),
        product_subcategory NVARCHAR(50),
        maintenance NVARCHAR(50),
        dwh_create_date DATETIME2 DEFAULT GETDATE()
    );

GO