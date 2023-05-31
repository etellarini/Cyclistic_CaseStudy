-- Time of the day rides by member or casual

SELECT 
    time_of_day, 
    SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS member, 
    SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS casual
FROM 
    [Cyclistic].[dbo].[TripData_2022_Q2]
GROUP BY 
    time_of_day
