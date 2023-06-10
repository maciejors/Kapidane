CREATE OR ALTER VIEW Test_MoneyFlowPageView AS
SELECT d.CountryName, d.Region, d.IncomeGroup,
	e.YearKey, td.TripPurpose,
	ed.ExpenditureType,
	e.AvgExpenditureByNight * n.NightsSpentCount AS TotalExpenditure
FROM Fact_Expenditures AS e
JOIN Fact_TripsNights n 
ON e.YearKey = n.YearKey
	AND e.TripDetailsKey = n.TripDetailsKey
	AND e.OriginCountryKey = n.OriginCountryKey
	AND e.DestinationCountryKey = n.DestinationCountryKey
JOIN Dim_Geography d ON e.DestinationCountryKey = d.CountryKey
JOIN Dim_ExpenditureDetails ed ON e.ExpenditureDetailsKey = ed.ExpenditureDetailsKey
JOIN Dim_TripDetails td ON e.TripDetailsKey = td.TripDetailsKey;
GO


-- TotalExpenditure (decomposition tree)
SELECT SUM(TotalExpenditure)
FROM Test_MoneyFlowPageView;


-- Year (decomposition tree)
SELECT YearKey, SUM(TotalExpenditure)
FROM Test_MoneyFlowPageView
GROUP BY YearKey
ORDER BY SUM(TotalExpenditure) DESC;


-- Region (decomposition tree)
SELECT Region, SUM(TotalExpenditure)
FROM Test_MoneyFlowPageView
WHERE YearKey = 2018
GROUP BY Region
ORDER BY SUM(TotalExpenditure) DESC;


-- Country (decomposition tree)
SELECT CountryName, SUM(TotalExpenditure)
FROM Test_MoneyFlowPageView
WHERE YearKey = 2018
	AND Region = 'Europe & Central Asia'
GROUP BY CountryName
ORDER BY SUM(TotalExpenditure) DESC;


-- Trip Purpose (decomposition tree)
SELECT TripPurpose, SUM(TotalExpenditure)
FROM Test_MoneyFlowPageView
WHERE YearKey = 2018
	AND Region = 'Europe & Central Asia'
	AND CountryName = 'Italy'
GROUP BY TripPurpose
ORDER BY SUM(TotalExpenditure) DESC;


-- Expenditure Type (decomposition tree)
SELECT ExpenditureType, SUM(TotalExpenditure)
FROM Test_MoneyFlowPageView
WHERE YearKey = 2018
	AND Region = 'Europe & Central Asia'
	AND CountryName = 'Italy'
	AND TripPurpose = 'Personal reasons'
GROUP BY ExpenditureType
ORDER BY SUM(TotalExpenditure) DESC;


-- Total Expenditure by Country and IncomeGroup (map)
SELECT CountryName, IncomeGroup, SUM(TotalExpenditure)
FROM Test_MoneyFlowPageView
GROUP BY CountryName, IncomeGroup, Region
ORDER BY Region;

