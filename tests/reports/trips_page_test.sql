USE [kapidane_dwh]
GO

CREATE OR ALTER VIEW Test_TripsPageView AS
SELECT o.CountryName AS 'OriginCountryName', 
	d.CountryName AS 'DestinationCountryName',
	n.YearKey, td.TripDuration, td.TripPurpose,
	n.NightsSpentCount, n.TripsCount
FROM Fact_TripsNights AS n
JOIN Dim_Geography o ON n.OriginCountryKey = o.CountryKey
JOIN Dim_Geography d ON n.DestinationCountryKey = d.CountryKey
JOIN Dim_TripDetails td ON n.TripDetailsKey = td.TripDetailsKey
JOIN Dim_Year y ON n.YearKey = y.[Year]
WHERE o.CountryName = 'Germany'  -- filters applied on page
	AND d.CountryName IN ('Austria', 'Belgium', 'Croatia', 'Czechia', 'Denmark', 'Italy', 'Switzerland')
	AND n.YearKey >= 2013 AND n.YearKey <= 2020;
GO
-- NOTE: moving average is tested in a separate file: moving_average_nightscount.sql


-- KPIs
SELECT 'Trips taken', SUM(TripsCount)
FROM Test_TripsPageView
UNION ALL
SELECT 'Average trip length', CAST(SUM(NightsSpentCount) AS float) / SUM(TripsCount)
FROM Test_TripsPageView
UNION ALL
SELECT 'Overall trip share in % (from origin)', (
	(SELECT CAST(SUM(TripsCount) AS float) * 100 FROM Test_TripsPageView) / (
		SELECT SUM(TripsCount)
		FROM Fact_TripsNights AS n
		JOIN Dim_Geography o ON n.OriginCountryKey = o.CountryKey
		JOIN Dim_Year y ON n.YearKey = y.[Year]
		WHERE o.CountryName = 'Germany'  -- filters applied on page
			AND n.YearKey >= 2013 AND n.YearKey <= 2020));


-- Nights Spent Count
SELECT YearKey, SUM(NightsSpentCount) AS 'NightsSpentCount'
FROM Test_TripsPageView
GROUP BY YearKey
ORDER BY YearKey;


-- Trips Count by Trip Purpose
SELECT YearKey, TripPurpose, SUM(TripsCount) AS 'TripsCount'
FROM Test_TripsPageView
GROUP BY YearKey, TripPurpose
ORDER BY YearKey, TripPurpose;


-- Trips Count by Trip Duration
SELECT YearKey, TripDuration, SUM(TripsCount) AS 'TripsCount'
FROM Test_TripsPageView
GROUP BY YearKey, TripDuration
ORDER BY YearKey, TripDuration;
