USE [kapidane_dwh]
GO;

CREATE OR ALTER VIEW Test_MovingAvg AS
SELECT f.YearKey, 
	o.CountryName AS OriginCountryName,
	AVG(f2.NightsSpentCount) AS MovingAverage
FROM Fact_TripsNights f
JOIN Fact_TripsNights f2 ON f.DestinationCountryKey = f2.DestinationCountryKey AND f.OriginCountryKey = f2.OriginCountryKey
    AND f.YearKey - f2.YearKey BETWEEN 0 AND 2
JOIN Dim_Geography o ON f.OriginCountryKey = o.CountryKey
JOIN Dim_Geography d ON f.DestinationCountryKey = d.CountryKey
WHERE o.CountryName = 'Germany' -- filters applied on page
	AND d.CountryName IN ('Austria', 'Belgium', 'Croatia', 'Czechia', 'Denmark', 'Italy', 'Switzerland')
GROUP BY f.YearKey, o.CountryName
GO


-- Moving Average test
SELECT * FROM Test_MovingAvg
WHERE YearKey >= 2013 AND YearKey <= 2020
ORDER BY YearKey;
