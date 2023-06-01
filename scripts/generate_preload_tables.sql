DROP TABLE Fact_TripsNights_PreLoad
DROP TABLE Fact_Expenditures_PreLoad

SELECT * INTO Fact_TripsNights_PreLoad
FROM Fact_TripsNights
WHERE 1 = 0

SELECT * INTO Fact_Expenditures_PreLoad
FROM Fact_Expenditures
WHERE 1 = 0
