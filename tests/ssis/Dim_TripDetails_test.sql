USE kapidane_dwh
GO

-- Test1: check if data is loaded correctly
SELECT DISTINCT purpose, duration FROM kapidane_raw.dbo.trips;
SELECT DISTINCT purpose, duration FROM kapidane_raw.dbo.nights;
SELECT DISTINCT purpose, duration FROM kapidane_raw.dbo.expenditures;
-- run task here (LoadDimensions)
SELECT * FROM Dim_TripDetails;


-- Test2: check if data is updated correctly
DELETE FROM Dim_TripDetails
WHERE TripDetailsKey = 'PERN1-3';
SELECT * FROM Dim_TripDetails;
-- run task here (LoadDimensions)
SELECT * FROM Dim_TripDetails;