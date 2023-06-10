CREATE OR ALTER VIEW Test_CountryPageView AS
SELECT o.CountryName AS 'OriginCountryName', 
	d.CountryName AS 'DestinationCountryName',
	d.Region,
	d.IsMemberStateEU,
	d.IncomeGroup,
	e.YearKey, 
	y.GlobalEventText,
	td.TripDuration, 
	td.TripPurpose,
	SUM(e.AvgExpenditureByNight * n.NightsSpentCount) AS TotalExpenditure,
	AVG(n.TripsCount) AS TripsCount,
	AVG(n.NightsSpentCount) AS NightsSpentCount
FROM Fact_Expenditures AS e
JOIN Fact_TripsNights n 
ON e.YearKey = n.YearKey
	AND e.TripDetailsKey = n.TripDetailsKey
	AND e.OriginCountryKey = n.OriginCountryKey
	AND e.DestinationCountryKey = n.DestinationCountryKey
JOIN Dim_Geography o ON e.OriginCountryKey = o.CountryKey
JOIN Dim_Geography d ON e.DestinationCountryKey = d.CountryKey
JOIN Dim_TripDetails td ON e.TripDetailsKey = td.TripDetailsKey
JOIN Dim_Year y ON e.YearKey = y.Year
WHERE o.CountryName = 'Poland'  -- filters applied on page
	AND d.CountryName != 'Poland'
	AND e.YearKey >= 2012 AND e.YearKey <= 2020
GROUP BY o.CountryName, 
	d.CountryName,
	d.IsMemberStateEU,
	d.IncomeGroup,
	d.Region,
	e.YearKey, 
	y.GlobalEventText,
	td.TripDuration, 
	td.TripPurpose;
GO


-- Money spent (KPI)
SELECT SUM(TotalExpenditure)
FROM Test_CountryPageView;


-- Average Trip Length (KPI)
SELECT CAST(SUM(NightsSpentCount) AS float) / SUM(TripsCount)
FROM Test_CountryPageView;


-- Trips Taken (KPI)
SELECT SUM(TripsCount)
FROM Test_CountryPageView


-- Trips Taken to EU vs non-EU (bar plot)
SELECT IsMemberStateEU, TripDuration, SUM(TripsCount)
FROM Test_CountryPageView
GROUP BY IsMemberStateEU, TripDuration
ORDER BY IsMemberStateEU DESC, TripDuration;


-- Trips Taken by Destination and Income Group (map)
SELECT IsMemberStateEU, IncomeGroup, Region, DestinationCountryName, SUM(TripsCount)
FROM Test_CountryPageView
GROUP BY IsMemberStateEU, IncomeGroup, Region, DestinationCountryName
ORDER BY Region;


-- Trips Taken by Purpose and Destination (bar plot)
SELECT TripPurpose, YearKey, IsMemberStateEU, GlobalEventText, SUM(TripsCount)
FROM Test_CountryPageView
GROUP BY TripPurpose, YearKey, IsMemberStateEU, GlobalEventText
ORDER BY TripPurpose, YearKey, IsMemberStateEU;
