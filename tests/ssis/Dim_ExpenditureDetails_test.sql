USE kapidane_dwh
GO

-- Test1: check if data is loaded correctly
SELECT DISTINCT expend FROM kapidane_raw.dbo.expenditures WHERE expend != 'TOTXDUR';
-- run task here (LoadDimensions)
SELECT * FROM Dim_ExpenditureDetails;


-- Test2: check if data is updated correctly
DELETE FROM Dim_ExpenditureDetails
WHERE ExpenditureDetailsKey IN ('DUR', 'REST');
SELECT * FROM Dim_ExpenditureDetails;
-- run task here (LoadDimensions)
SELECT * FROM Dim_ExpenditureDetails;