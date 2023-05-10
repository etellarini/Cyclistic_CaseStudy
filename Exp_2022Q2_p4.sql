 -- Max Ride Lengths: Members vs Casual  -- Check for outliers
 
SELECT TOP (100)
	member_casual,
	ride_length
FROM 
	[Cyclistic].[dbo].[TripData_2022_Q2]
ORDER BY 
	ride_length DESC
