SELECT gor.CountryName AS 'OriginCountryName', 
	gde.CountryName as 'DestinationCountryName',
	e.YearKey, e.TripDetailsKey,
	e.AvgExpenditureByNight * n.NightsSpentCount as TotalExpenditure,
	e.ExpenditureDetailsKey
FROM Fact_Expenditures AS e
JOIN Fact_TripsNights n 
ON e.YearKey = n.YearKey
	AND e.TripDetailsKey = n.TripDetailsKey
	AND e.OriginCountryKey = n.OriginCountryKey
	AND e.DestinationCountryKey = n.DestinationCountryKey
JOIN Dim_Geography gor ON e.OriginCountryKey = gor.CountryKey
JOIN Dim_Geography gde ON e.DestinationCountryKey = gde.CountryKey
WHERE gor.CountryName = 'Portugal' AND gde.CountryName = 'Belgium'
ORDER BY e.TripDetailsKey, e.YearKey

