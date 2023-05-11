-- Median Ride Lengths: Members vs Casual 
-- Looking at median because of outliers influence on AVG

SELECT DISTINCT TOP 2 
	member_casual,
	CONVERT(TIME, DATEADD(MINUTE, median_ride_length, 0)) AS median_ride_length
FROM 
	(
    SELECT 
		ride_id,
        member_casual,
        ride_length,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY DATEDIFF(SECOND, 0, ride_length)/60.0) OVER(PARTITION BY member_casual) AS median_ride_length
    FROM 
		[Cyclistic].[dbo].[TripData_2022_Q2]
    WHERE 
		ride_length IS NOT NULL
	) AS subquery
ORDER BY 
	median_ride_length DESC
