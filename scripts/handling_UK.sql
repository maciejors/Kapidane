USE kapidane_dwh
GO
-- STEP 1: Run SSIS task LoadDimensions

-- STEP 2: Run SSIS task LoadFacts with parameters 
--		StartYear set to a year <= 2012 and EndYear set to 2020

-- STEP 3: Execute the following code:
DELETE FROM Lookup_EU
WHERE CountryCode = 'UK';

-- STEP 4: Run SSIS task LoadDimensions

-- STEP 5: Run SSIS task LoadFacts with parameters 
--		StartYear set to 2021 and EndYear set to 9999

-- STEP 6: Execute the following code to check if SCD2 works:
SELECT DISTINCT CountryName, YearKey, IsMemberStateEU, ValidFromDate, ValidToDate, IsCurrent
FROM Fact_TripsNights
JOIN Dim_Geography d
ON DestinationCountryKey = d.CountryKey
WHERE d.CountryCode = 'UK'
