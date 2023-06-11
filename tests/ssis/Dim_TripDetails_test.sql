USE kapidane_dwh
GO

-- Test1: check if data is loaded correctly
-- run task here (LoadDimensions)
SELECT DISTINCT CONCAT(s.purpose, s.duration) AS 'source', TripDetailsKey AS 'target', TripPurpose, TripDuration 
FROM (
	SELECT purpose, duration 
	FROM kapidane_raw.dbo.trips 
	WHERE purpose NOT IN ('TOTAL', 'PER_VFR') AND duration != 'N_GE1'
	UNION ALL
	SELECT purpose, duration 
	FROM kapidane_raw.dbo.nights 
	WHERE purpose NOT IN ('TOTAL', 'PER_VFR') AND duration != 'N_GE1'
	UNION ALL
	SELECT purpose, duration 
	FROM kapidane_raw.dbo.expenditures 
	WHERE purpose NOT IN ('TOTAL', 'PER_VFR') AND duration != 'N_GE1'
) AS s
FULL OUTER JOIN Dim_TripDetails t
ON CONCAT(s.purpose, s.duration) = t.TripDetailsKey


-- Test2: check if data is updated correctly
DELETE FROM Dim_TripDetails
WHERE TripDetailsKey = 'PERN1-3';
-- run task here (LoadDimensions)
SELECT * FROM Dim_TripDetails;