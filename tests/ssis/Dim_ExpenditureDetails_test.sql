USE kapidane_dwh
GO

-- Test1: check if data is loaded correctly
-- run task here (LoadDimensions)
SELECT DISTINCT s.expend AS 'source', ExpenditureDetailsKey AS 'target', ExpenditureType 
FROM (
	SELECT expend 
	FROM kapidane_raw.dbo.expenditures 
	WHERE expend != 'TOTXDUR'
) AS s
FULL OUTER JOIN Dim_ExpenditureDetails t
ON expend = t.ExpenditureDetailsKey


-- Test2: check if data is updated correctly
DELETE FROM Dim_ExpenditureDetails
WHERE ExpenditureDetailsKey IN ('DUR', 'REST');
-- run task here (LoadDimensions)
SELECT * FROM Dim_ExpenditureDetails;