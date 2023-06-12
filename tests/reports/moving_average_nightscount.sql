USE [kapidane_dwh]
GO

CREATE OR ALTER VIEW Test_MovingAvg_Nights_Temp AS
SELECT f.YearKey, 
	SUM(f.NightsSpentCount) AS NightsSpentCount
FROM Fact_TripsNights f
JOIN Dim_Geography o ON f.OriginCountryKey = o.CountryKey
JOIN Dim_Geography d ON f.DestinationCountryKey = d.CountryKey
WHERE o.CountryName = 'Germany' -- filters applied on page
	AND d.CountryName IN ('Austria', 'Belgium', 'Croatia', 'Czechia', 'Denmark', 'Italy', 'Switzerland')
GROUP BY f.YearKey, o.CountryName;
GO


-- Moving Avg test:
SELECT f2.YearKey + 2 AS [Year], AVG(f.NightsSpentCount) AS NightsCountMovingAvg
FROM Test_MovingAvg_Nights_Temp AS f
JOIN Test_MovingAvg_Nights_Temp AS f2 
	ON f.YearKey - f2.YearKey BETWEEN 0 AND 2
GROUP BY f2.YearKey;

