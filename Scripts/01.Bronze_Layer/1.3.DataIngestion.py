import os
import pandas as pd
import pyodbc
from sqlalchemy import create_engine

# Set-up configuration

Datasets = "./Datasets"
SERVER = "localhost\\SQLEXPRESS"
DATABASE = "DataWarehouse"
SCHEMA = "Bronze"

# Map file and tables

Mapping = [
    {
        "file_name": "CRM source_data/cust_info.csv",
        "table_name": "CRM_CustomerInfo",
        "separator": ",",
    },
    {
        "file_name": "CRM source_data/prd_info.csv",
        "table_name": "CRM_ProdcutInfo",
        "separator": ",",
    },
    {
        "file_name": "CRM source_data/sales_details.csv",
        "table_name": "CRM_SaleDetails",
        "separator": ",",
    },
    {
        "file_name": "ERP source_data/CUST_AZ12.csv",
        "table_name": "ERP_Loc_a101",
        "separator": ",",
    },
    {
        "file_name": "ERP source_data/LOC_A101.csv",
        "table_name": "ERP_Loc_a101",
        "separator": ",",
    },
    {
        "file_name": "ERP source_data/PX_CAT_G1V2.csv",
        "table_name": "ERP_Cust_az12",
        "separator": ",",
    },
]


# Connect Database

conn_str = f"mssql+pyodbc://{SERVER}/{DATABASE}?trusted_connection=yes&driver=ODBC+Driver+17+for+SQL+Server"
conn_engine = create_engine(conn_str)

# Loading files to respective tables

for load in Mapping:
    file_path = os.path.join(Datasets, load['file_name'])
    relate_table = f"{SCHEMA}.{load['table_name']}"

    print(f"Reading file: {load['file_name']}")
    print("======================================================")

    df = pd.read_csv(file_path, sep = load['separator'])

    print("======================================================")
    print(f"Loading Data to: {load['table_name']}")

    df.to_sql(
        name = load["table_name"],
        con = conn_engine,
        schema = SCHEMA,
        if_exists = 'replace',
        index = False
    )
    print(f"Data {len(df)} records are successfully loaded to {relate_table}")
    print("======================================================")

print("Data Ingestion to Bronze Layer is successful.")





