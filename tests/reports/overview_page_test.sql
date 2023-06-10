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
SELECT SUM(NightsSpentCount) AS 'Sum of NightsSpentCount',
	SUM(CAST(TripsCount AS bigint)) AS 'Sum of TripsCount', 
	SUM(TotalExpenditure) AS 'Total Expenditure'
FROM Test_OverviewPageView
