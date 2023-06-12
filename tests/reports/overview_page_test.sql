USE [kapidane_dwh]
GO

CREATE OR ALTER VIEW Test_OverviewPageView AS
SELECT AVG(n.TripsCount) AS TripsCount,
	AVG(n.NightsSpentCount) AS NightsSpentCount,
	SUM(e.AvgExpenditureByNight * n.NightsSpentCount) AS TotalExpenditure
FROM Fact_Expenditures AS e
JOIN Fact_TripsNights n 
ON e.YearKey = n.YearKey
	AND e.TripDetailsKey = n.TripDetailsKey
	AND e.OriginCountryKey = n.OriginCountryKey
	AND e.DestinationCountryKey = n.DestinationCountryKey
GROUP BY e.OriginCountryKey, 
	e.DestinationCountryKey,
	e.YearKey, 
	e.TripDetailsKey;
GO


-- KPIs
SELECT SUM(CAST(TripsCount AS bigint)) AS 'Trips Taken', 
	SUM(NightsSpentCount) AS 'Total Trip Nights',
	SUM(TotalExpenditure) AS 'Total Trip Expenditure'
FROM Test_OverviewPageView
