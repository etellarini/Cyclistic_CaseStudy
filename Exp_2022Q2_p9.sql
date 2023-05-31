-- Start stations: member vs casual
-- Looking at start station counts

SELECT 
	DISTINCT start_station_name,
    SUM(CASE WHEN ride_id = ride_id AND start_station_name = start_station_name THEN 1 ELSE 0 END) AS total,
	SUM(CASE WHEN member_casual = 'member' AND start_station_name = start_station_name THEN 1 ELSE 0 END) AS member,
	SUM(CASE WHEN member_casual = 'casual' AND start_station_name = start_station_name THEN 1 ELSE 0 END) AS casual
FROM 
	[Cyclistic].[dbo].[TripData_2022_Q2]
GROUP BY 
	start_station_name
ORDER BY 
	-- total DESC
	-- member DESC
	casual DESC
