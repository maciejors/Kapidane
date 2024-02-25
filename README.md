# EU Tourism Analysis

A dashboard for EU tourism data analysis

## Images

![Overview](https://firebasestorage.googleapis.com/v0/b/my-projects-showcase.appspot.com/o/app-screenshots%2F7%2F1.png?alt=media&token=e8330d46-3033-4166-8647-7cd4a23fe81f)
![Country](https://firebasestorage.googleapis.com/v0/b/my-projects-showcase.appspot.com/o/app-screenshots%2F7%2F2.png?alt=media&token=1b546c8d-273d-42a3-8e77-d800cad6541f)
![Trips](https://firebasestorage.googleapis.com/v0/b/my-projects-showcase.appspot.com/o/app-screenshots%2F7%2F3.png?alt=media&token=6456933b-3f61-4cc4-b8ce-0aac7ddb373f)
![Expenditure](https://firebasestorage.googleapis.com/v0/b/my-projects-showcase.appspot.com/o/app-screenshots%2F7%2F4.png?alt=media&token=5e4c7a6f-00e5-4e90-b0e6-262e41759830)
![Money flow](https://firebasestorage.googleapis.com/v0/b/my-projects-showcase.appspot.com/o/app-screenshots%2F7%2F5.png?alt=media&token=bb1b8299-b60f-4ecd-8894-7d780b4a14e6)

## Short guide to first-time warehouse setup

### STEP 1:
- Run the kapidane_raw.sql script to create an intermediate database where the scraped data will be loaded
- Run the kapidane_dwh.sql script to create a data warehouse

### STEP 2:
- Run the Dim_Year.sql to populate the year dimension
- Run the lookup_EU.sql script to populate a lookup table for checking EU member statuses
- Run the countries_groups_suppl.sql to populate a supplementary table for Dim_Geography with grouped countries present in the EU data

### STEP 3:
Run the Scraping.dtsx package in SSIS to download the latest data and store it inside the intermediate database.

### STEP 4:
Open the handling_UK.sql script and follow the instructions there to load data to the warehouse

After these steps the warehouse should be ready to use for reports etc.

## Important notes related to tests

1. Some tests for dimensions might fail to execute after facts are loaded due to foreign key constraints. Make sure to run these before the LoadFacts task is first executed.

2. Some tests assume that the entire data has been loaded to the warehouse (i.e. not restricted to some period of time) and will yield false positive results otherwise.


