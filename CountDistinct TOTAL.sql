SELECT 
	COUNT(DISTINCT [ride_id]) AS [num_ride_id],
	COUNT(DISTINCT [rideable_type]) AS [num_rideable_type],
	COUNT(DISTINCT [member_casual]) AS [num_member_casual],
	COUNT(DISTINCT [start_station_name]) AS [num_start_station_name],
	COUNT(DISTINCT [end_station_name]) AS [num_end_station_name]
FROM [Cyclistic].[dbo].[TripData_Integrated12m_StationsAdd];
