# AdventureWorks Sample Datset
This folder contains the AdventureWorkds sample dataset of Microsoft. 

Check out the original resources of Microsoft's GitHub Repo:
https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/adventure-works

The reason for a separate own repository is that the data is ready for import to a pgSQL Database. 

## Basict Structure
The `ddl.sql` file contains all relevant SQL statements to set up the tables and schema in your Postgres database.

The `import.sql` holds the required queries to import the AdventureWorks data from the single `.csv` files to your database. 

You'll find all required `.csv` files with data under the `CSV` folder. 

## Prerequisites
Make sure you have set up a database instance. 
All SQL scripts were tested with pgSQL and the Postgres database. 

## Import Data
1. Open a SQL query tool (e.g. DBeaver, DBVis, pgAdmin, etc.)
2. Connect to your database where you want to import the data
3. Download the **AdventureWorks** folder from the repository
4. Execute the `ddl.sql`file to create the schema and the single tables
5. Adjust the paths in the `import.sql` file according to your location of the downloaded repository folder
6. Run the import scripts