USE kapidane_dwh
GO

-- Test1: check if data has been loaded correctly
-- run task here (LoadFacts)
SELECT * FROM Fact_Expenditures;


-- Test2: Check if the TripDetailsKey is created correctly
SELECT [source], [target]
FROM (
	SELECT DISTINCT CONCAT(purpose, duration) AS 'source'
	FROM kapidane_raw.dbo.trips
	WHERE purpose NOT IN ('TOTAL', 'PER_VFR')
		AND duration != 'N_GE1'
) AS s
FULL OUTER JOIN (
	SELECT DISTINCT TripDetailsKey AS 'target'
	FROM Fact_Expenditures
) AS t
ON s.[source] = t.[target]



-- Test3: inner joins with dimensions to check for missing references
-- run task here (LoadFacts)
SELECT 'Standalone fact table', COUNT(*) AS 'Count' 
FROM Fact_Expenditures
UNION ALL
SELECT 'Fact table joined with dimensions', COUNT(*) AS 'Count'
FROM Fact_Expenditures AS f
JOIN Dim_Year y ON f.YearKey = y.[Year]
JOIN Dim_TripDetails td ON f.TripDetailsKey = td.TripDetailsKey
JOIN Dim_ExpenditureDetails ed ON f.ExpenditureDetailsKey = ed.ExpenditureDetailsKey
JOIN Dim_Geography o ON f.OriginCountryKey = o.CountryKey
JOIN Dim_Geography d ON f.DestinationCountryKey = d.CountryKey;


-- Test4: check facts uniqueness
-- run task here (LoadFacts) twice or more, with overlapping intervals
SELECT 'All facts', COUNT(*) as 'Count' 
FROM Fact_Expenditures
UNION ALL
SELECT 'Unique facts', COUNT(*) as 'Count'
FROM (
	SELECT DISTINCT y.[Year],
		o.CountryName AS OriginCountryName, 
		d.CountryName AS DestinationCountryName,
		td.TripPurpose, td.TripDuration,
		ed.ExpenditureType
	FROM Fact_Expenditures AS f
	JOIN Dim_Year y ON f.YearKey = y.[Year]
	JOIN Dim_TripDetails td ON f.TripDetailsKey = td.TripDetailsKey
	JOIN Dim_ExpenditureDetails ed ON f.ExpenditureDetailsKey = ed.ExpenditureDetailsKey
	JOIN Dim_Geography o ON f.OriginCountryKey = o.CountryKey
	JOIN Dim_Geography d ON f.DestinationCountryKey = d.CountryKey
) AS f;


-- Test5: check data validity
-- run task here (LoadFacts)
SELECT 'source', COUNT(*) AS 'Count', 
	MAX(et.OBS_VALUE) AS MaxAvgExpendPerTrip, 
	MIN(et.OBS_VALUE) AS MinAvgExpendPerTrip, 
	MAX(en.OBS_VALUE) AS MaxAvgExpendPerNight, 
	MIN(en.OBS_VALUE) AS MinAvgExpendPerNight
FROM (
	SELECT c_dest, duration, geo, purpose, expend, TIME_PERIOD, OBS_VALUE
	FROM kapidane_raw.dbo.expenditures
	WHERE statinfo = 'AVG_TRP'
) AS et
JOIN (
	SELECT c_dest, duration, geo, purpose, expend, TIME_PERIOD, OBS_VALUE
	FROM kapidane_raw.dbo.expenditures
	WHERE statinfo = 'AVG_NGT'
) AS en
ON et.c_dest = en.c_dest 
	AND et.duration = en.duration
	AND et.geo = en.geo
	AND et.purpose = en.purpose
	AND et.TIME_PERIOD = en.TIME_PERIOD
	AND et.expend = en.expend
WHERE et.OBS_VALUE IS NOT NULL AND en.OBS_VALUE IS NOT NULL
	AND et.duration != 'N_GE1'
	AND et.expend != 'TOTXDUR'
	AND et.purpose NOT IN ('TOTAL', 'PER_VFR')
	AND LEN(et.geo) = 2 AND et.geo != 'EA'
	AND (LEN(et.c_dest) = 2 OR et.c_dest LIKE '%_OTH')
UNION ALL
SELECT 'target', COUNT(*) AS 'Count', 
	MAX(AvgExpenditureByTrip) AS MaxAvgExpendPerTrip, 
	MIN(AvgExpenditureByTrip) AS MinAvgExpendPerTrip, 
	MAX(AvgExpenditureByNight) AS MaxAvgExpendPerNight, 
	MIN(AvgExpenditureByNight) AS MinAvgExpendPerNight
FROM Fact_Expenditures;