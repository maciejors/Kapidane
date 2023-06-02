USE [kapidane_dwh]
GO

DECLARE @StartYear INT = 2012;
DECLARE @NumberOfYears INT = 100;

CREATE TABLE #DimYearTemp
(
  [Year]				INT PRIMARY KEY, 
  [IsLeapYear]			NVARCHAR(3),
  [IsGlobalEvent]		NVARCHAR(3),
  [GlobalEventText]		NVARCHAR(50)
);

-- insert years
INSERT INTO #DimYearTemp([Year])
SELECT y
FROM
(
	SELECT y = @StartYear + rn - 1
	FROM
	(
		SELECT TOP (@NumberOfYears) 
			rn = ROW_NUMBER() OVER (ORDER BY s.[object_id])
		FROM sys.all_objects s
	) AS numbers
) AS years;

-- insert IsLeapYear flags
UPDATE #DimYearTemp
SET IsLeapYear = 'Yes'
WHERE ([Year] % 4 = 0) AND 
	(([Year] % 100 != 0) OR ([Year] % 400 = 0));

UPDATE #DimYearTemp
SET IsLeapYear = 'No'
WHERE IsLeapYear IS NULL;

-- global events
UPDATE #DimYearTemp
SET IsGlobalEvent = 'Yes', GlobalEventText = 'COVID-19 Pandemic'
WHERE [Year] IN (2020, 2021);

UPDATE #DimYearTemp
SET IsGlobalEvent = 'No', GlobalEventText = 'No major global event'
WHERE IsGlobalEvent IS NULL;

-- reseed Dim_Year
DELETE FROM Dim_Year WHERE 1 = 1;

INSERT INTO Dim_Year
SELECT * 
FROM #DimYearTemp;

DROP TABLE #DimYearTemp;
