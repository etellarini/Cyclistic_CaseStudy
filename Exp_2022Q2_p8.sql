-- Looking at total number of trips per day 

SELECT  
	day_name,
    COUNT(DISTINCT ride_id) AS TotalTrips,
    SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS MemberTrips,
    SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS CasualTrips
FROM 
	[Cyclistic].[dbo].[TripData_2022_Q2]
GROUP BY 
	day_name
ORDER BY 
	TotalTrips DESC 
