USE kapidane_dwh
GO

-- Test1: check if data has been loaded correctly
-- run task here (LoadFacts)
SELECT * FROM Fact_TripsNights;


-- Test2: joins with dimensions
SELECT 'Standalone fact table', COUNT(*) AS 'Count' 
FROM Fact_TripsNights
UNION ALL
SELECT 'Fact table joined with dimensions', COUNT(*) AS 'Count'
FROM Fact_TripsNights AS f
JOIN Dim_Year y ON f.YearKey = y.[Year]
JOIN Dim_TripDetails td ON f.TripDetailsKey = td.TripDetailsKey
JOIN Dim_Geography o ON f.OriginCountryKey = o.CountryKey
JOIN Dim_Geography d ON f.DestinationCountryKey = d.CountryKey;


-- Test3: check facts uniqueness
-- run task here (LoadFacts) TWICE or more with overlapping intervals
SELECT 'All facts', COUNT(*) as 'Count' 
FROM Fact_TripsNights
UNION ALL
SELECT 'Unique facts', COUNT(*) as 'Count'
FROM (
	SELECT DISTINCT y.[Year],
		o.CountryName AS OriginCountryName, 
		d.CountryName AS DestinationCountryName,
		td.TripPurpose, td.TripDuration
	FROM Fact_TripsNights AS f
	JOIN Dim_Year y ON f.YearKey = y.[Year]
	JOIN Dim_TripDetails td ON f.TripDetailsKey = td.TripDetailsKey
	JOIN Dim_Geography o ON f.OriginCountryKey = o.CountryKey
	JOIN Dim_Geography d ON f.DestinationCountryKey = d.CountryKey
) AS f;


-- Test4: check data validity
-- run task here (LoadFacts)
SELECT 'source', COUNT(*) AS 'Count', 
	MAX(t.OBS_VALUE) AS MaxTripsCount, 
	MIN(t.OBS_VALUE) AS MinTripsCount, 
	MAX(n.OBS_VALUE) AS MinNightsSpentCount, 
	MIN(n.OBS_VALUE) AS MinNightsSpentCount
FROM kapidane_raw.dbo.trips AS t
JOIN kapidane_raw.dbo.nights AS n
	ON t.c_dest = n.c_dest 
		AND t.duration = n.duration
		AND t.geo = n.geo
		AND t.purpose = n.purpose
		AND t.TIME_PERIOD = n.TIME_PERIOD
WHERE t.OBS_VALUE IS NOT NULL AND n.OBS_VALUE IS NOT NULL
	AND t.duration != 'N_GE1'
	AND t.purpose NOT IN ('TOTAL', 'PER_VFR')
	AND LEN(t.geo) = 2 AND t.geo != 'EA'
	AND (LEN(t.c_dest) = 2 OR t.c_dest LIKE '%_OTH')
UNION ALL
SELECT 'target', COUNT(*) AS 'Count', 
	MAX(TripsCount) AS MaxTripsCount, 
	MIN(TripsCount) AS MinTripsCount, 
	MAX(NightsSpentCount) AS MinNightsSpentCount, 
	MIN(NightsSpentCount) AS MinNightsSpentCount
FROM Fact_TripsNights;
