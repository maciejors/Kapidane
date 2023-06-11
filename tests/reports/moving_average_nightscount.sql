USE [kapidane_dwh]
GO;
CREATE OR ALTER VIEW Test_MovingAvg AS
SELECT f.NightsSpentCount, f.YearKey, f.DestinationCountryKey, f.OriginCountryKey, AVG(f.NightsSpentCount) AS MovingAverage
FROM Fact_TripsNights f
JOIN Fact_TripsNights f2 ON f.DestinationCountryKey = f2.DestinationCountryKey AND f.OriginCountryKey = f2.OriginCountryKey
    AND f.YearKey - f2.YearKey BETWEEN 0 AND 2
GROUP BY f.NightsSpentCount, f.YearKey, f.DestinationCountryKey, f.OriginCountryKey
GO
