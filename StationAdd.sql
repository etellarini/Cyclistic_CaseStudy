SELECT 
  A.[start_station_name], 
-- Created new columns with locations --
SELECT 
	A.*, 
	B1.[Location] AS [started_Location], 
	B2.[Location] AS [ended_Location] 
INTO [Cyclistic].[dbo].[TripData_Integrated12m_StationsAdd]
FROM [Cyclistic].[dbo].[TripData_Integrated12m_NewColumns] A
	LEFT JOIN [Cyclistic].[dbo].[Divvy_Bicycle_Stations] B1 ON A.[start_station_name] = B1.[station name]
	LEFT JOIN [Cyclistic].[dbo].[Divvy_Bicycle_Stations] B2 ON A.[end_station_name] = B2.[station name]
WHERE 
	B1.[started_Location] IS NOT NULL 
	AND B2.[ended_Location]  IS NOT NULL


