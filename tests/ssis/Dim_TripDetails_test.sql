USE kapidane_dwh
GO

-- Test1: check if data is loaded correctly
SELECT DISTINCT purpose, duration 
FROM kapidane_raw.dbo.trips 
WHERE purpose NOT IN ('TOTAL', 'PER_VFR') AND duration != 'N_GE1';
SELECT DISTINCT purpose, duration 
FROM kapidane_raw.dbo.nights 
WHERE purpose NOT IN ('TOTAL', 'PER_VFR') AND duration != 'N_GE1';
SELECT DISTINCT purpose, duration 
FROM kapidane_raw.dbo.expenditures 
WHERE purpose NOT IN ('TOTAL', 'PER_VFR') AND duration != 'N_GE1';
-- run task here (LoadDimensions)
SELECT * FROM Dim_TripDetails;


-- Test2: check if data is updated correctly
DELETE FROM Dim_TripDetails
WHERE TripDetailsKey = 'PERN1-3';
SELECT * FROM Dim_TripDetails;
-- run task here (LoadDimensions)
SELECT * FROM Dim_TripDetails;