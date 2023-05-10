-- Check how many raws with anomalie s--
SELECT  *
FROM [Cyclistic].[dbo].[TripData_Integrated12m_StationsAdd]
WHERE 
	[started_date] >= [ended_date] AND
	[started_hour] >= [ended_hour];

-- Delete anomalies --
DELETE FROM [Cyclistic].[dbo].[TripData_Integrated12m_StationsAdd]
WHERE 
	[started_date] >= [ended_date] 
	AND [started_hour] >= [ended_hour];

