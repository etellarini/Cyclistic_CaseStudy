-- Eliminated NULLS, Repetited and different from 16 LENGTH ride_id --
SELECT *
INTO [Cyclistic].[dbo].[TripData_Integrated12m_NoDupNoNulls]
FROM (
  SELECT DISTINCT *
  FROM [Cyclistic].[dbo].[TripData_Integrated12m_Raw]
) t
WHERE ride_id IS NOT NULL  
AND LEN(ride_id) = 16 
AND [rideable_type] IS NOT NULL
AND [started_at] IS NOT NULL
AND [ended_at] IS NOT NULL
AND [start_station_name] IS NOT NULL
AND [end_station_name] IS NOT NULL
AND [member_casual] IS NOT NULL;
