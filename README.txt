Short guide to first-time warehouse setup

STEP 1:
- Run the kapidane_raw.sql script to create an intermediate database where the scraped data will be loaded
- Run the kapidane_dwh.sql script to create a data warehouse

STEP 2:
- Run the Dim_Year.sql to populate the year dimension
- Run the lookup_EU.sql script to populate a lookup table for checking EU member statuses
- Run the countries_groups_suppl.sql to populate a supplementary table for Dim_Geography with grouped countries present in the EU data

STEP 3:
Run the Scraping.dtsx package in SSIS to download the latest data and store it inside the intermediate database.

STEP 4:
Open the handling_UK.sql script and follow the instructions there to load data to the warehouse

After these steps the warehouse should be ready to use for reports etc.

================

Important note related to tests:

Some tests for dimensions might fail to execute after facts are loaded due to foreign key constraints. Make sure to run these before the LoadFacts task is first executed.

