CREATE OR ALTER VIEW Test_TripsPageView AS
SELECT o.CountryName AS 'OriginCountryName', 
	d.CountryName AS 'DestinationCountryName',
	n.YearKey, td.TripDuration, td.TripPurpose
FROM Fact_TripsNights AS n
JOIN Dim_Geography o ON n.OriginCountryKey = o.CountryKey
JOIN Dim_Geography d ON n.DestinationCountryKey = d.CountryKey
JOIN Dim_TripDetails td ON n.TripDetailsKey = td.TripDetailsKey
JOIN Dim_Year y ON n.YearKey = y.[Year]
WHERE o.CountryName = 'Germany'  -- filters applied on page
	AND d.CountryName IN ('Austria', 'Belgium', 'Croatia', 'Czechia', 'Denmark', 'Italy', 'Switzerland')
	AND n.YearKey >= 2013 AND n.YearKey <= 2020;
GO

-- TODO utilise nights count moving avg view