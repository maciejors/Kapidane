USE kapidane_dwh
GO

-- Test1: check if data is loaded correctly
-- run task here (LoadDimensions)
SELECT * FROM Dim_Geography;


-- Test2: check if no data was lost
-- run task here (LoadDimensions)
SELECT 'Countries', 'Source', COUNT(*), MAX(Income_Group), MIN(Region)
FROM kapidane_raw.dbo.countries
WHERE Country_Code IS NOT NULL AND Region IS NOT NULL
UNION ALL
SELECT 'Countries', 'Target', COUNT(*), MAX(IncomeGroup), MIN(Region)
FROM Dim_Geography
WHERE CountryCode NOT LIKE '%OTH'
	AND IsCurrent = 'Yes'
UNION ALL
SELECT 'Country groups', 'Source', COUNT(*), MAX(IncomeGroup), MIN(Region)
FROM GeoSuppl
UNION ALL
SELECT 'Country groups', 'Target', COUNT(*), MAX(IncomeGroup), MIN(Region)
FROM Dim_Geography
WHERE CountryCode LIKE '%OTH'
	AND IsCurrent = 'Yes';


-- Test3: check if data is updated correctly
DELETE FROM Dim_Geography
WHERE CountryCode = 'IE';
-- run task here (LoadDimensions)
SELECT * FROM Dim_Geography WHERE CountryCode = 'IE';


-- Test4: a simple test to check if SCD2 works
UPDATE Dim_Geography
SET IncomeGroup = 'Low income'
WHERE CountryCode = 'PL';
-- run task here (LoadDimensions)
SELECT * FROM Dim_Geography
WHERE CountryCode = 'PL';
