-- Average Ride Lengths: Members vs Casual -- Looking at overall, member and casual average ride lengths

SELECT 
    CONVERT(TIME, DATEADD(SECOND, AVG(DATEPART(SECOND, [ride_length])) 
                     + AVG(DATEPART(MINUTE, [ride_length])) * 60 
                     + AVG(DATEPART(HOUR, [ride_length])) * 3600, 0)) AS [Avg RideLength_Overall],
    CONVERT(TIME, DATEADD(SECOND, AVG(CASE WHEN [member_casual] = 'member' THEN DATEPART(SECOND, [ride_length]) 
                                           ELSE 0 END)
                     + AVG(CASE WHEN [member_casual] = 'member' THEN DATEPART(MINUTE, [ride_length]) 
                                           ELSE 0 END) * 60 
                     + AVG(CASE WHEN [member_casual] = 'member' THEN DATEPART(HOUR, [ride_length]) 
                                           ELSE 0 END) * 3600, 0)) AS [Avg RideLength_Member],
    CONVERT(TIME, DATEADD(SECOND, AVG(CASE WHEN [member_casual] = 'casual' THEN DATEPART(SECOND, [ride_length]) 
                                           ELSE 0 END)
                     + AVG(CASE WHEN [member_casual] = 'casual' THEN DATEPART(MINUTE, [ride_length]) 
                                           ELSE 0 END) * 60 
                     + AVG(CASE WHEN [member_casual] = 'casual' THEN DATEPART(HOUR, [ride_length]) 
                                           ELSE 0 END) * 3600, 0)) AS [Avg RideLength_Casual]
FROM 
    [Cyclistic].[dbo].[TripData_2022_Q2];
