USE [kapidane_dwh]
GO

INSERT INTO GeoSuppl (CountryGroupCode, CountryGroupName, Region, IncomeGroup) VALUES
('EUR_OTH', 'Other European countries', 'Europe & Central Asia', 'Not applicable'),
('AFR_OTH', 'Other African countries', 'Not applicable', 'Not applicable'),
('AME_N_OTH', 'Other North American countries', 'North America', 'Not applicable'),
('AME_C_S_OTH', 'Other Central or South American countries', 'Latin America & Caribbean', 'Not applicable'),
('ASI_OTH', 'Other Asian countries', 'Not applicable', 'Not applicable'),
('OCE_OTH', 'Other Oceanian countries', 'Not applicable', 'Not applicable');