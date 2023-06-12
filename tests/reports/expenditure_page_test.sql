USE [kapidane_dwh]
GO

CREATE OR ALTER VIEW Test_ExpenditurePageView AS
SELECT o.CountryName AS 'OriginCountryName', 
	d.CountryName AS 'DestinationCountryName',
	e.YearKey, td.TripDuration, td.TripPurpose,
	ed.ExpenditureType,
	e.AvgExpenditureByNight * n.NightsSpentCount AS TotalExpenditure,
	e.AvgExpenditureByNight,
	e.AvgExpenditureByTrip
FROM Fact_Expenditures AS e
JOIN Fact_TripsNights n 
ON e.YearKey = n.YearKey
	AND e.TripDetailsKey = n.TripDetailsKey
	AND e.OriginCountryKey = n.OriginCountryKey
	AND e.DestinationCountryKey = n.DestinationCountryKey
JOIN Dim_Geography o ON e.OriginCountryKey = o.CountryKey
JOIN Dim_Geography d ON e.DestinationCountryKey = d.CountryKey
JOIN Dim_ExpenditureDetails ed ON e.ExpenditureDetailsKey = ed.ExpenditureDetailsKey
JOIN Dim_TripDetails td ON e.TripDetailsKey = td.TripDetailsKey
WHERE o.CountryName = 'Germany'  -- filters applied on page
	AND d.CountryName IN ('Austria', 'Belgium', 'Croatia', 'Czechia', 'Denmark', 'Italy', 'Switzerland')
	AND e.YearKey >= 2013 AND e.YearKey <= 2020;
GO


-- KPIs
SELECT 'Avg Expenditure by Night', AVG(AvgExpenditureByNight)
FROM Test_ExpenditurePageView
UNION ALL
SELECT 'Total Expenditure', SUM(TotalExpenditure)
FROM Test_ExpenditurePageView;


-- Avg Expenditure by Night (line plot)
SELECT YearKey, AVG(AvgExpenditureByNight)
FROM Test_ExpenditurePageView
GROUP BY YearKey;


-- Avg Expenditure by Trip (bar plot)
SELECT YearKey, TripDuration, AVG(AvgExpenditureByTrip)
FROM Test_ExpenditurePageView
GROUP BY YearKey, TripDuration
ORDER BY YearKey DESC, TripDuration;


-- Total Expenditure by Expenditure Type (treemap)
SELECT ExpenditureType, SUM(TotalExpenditure)
FROM Test_ExpenditurePageView
GROUP BY ExpenditureType
ORDER BY SUM(TotalExpenditure) DESC;

