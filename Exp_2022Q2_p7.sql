-- Looking at Median ride length per day of week for casual and annual

SELECT 
    day_name,
	member_casual,
    CONVERT(TIME, DATEADD(SECOND, median_ride_length_seconds, '00:00:00')) AS median_ride_length
FROM 
	(
    SELECT 
        day_name,
		member_casual,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY DATEDIFF(SECOND, '00:00:00', ride_length)) OVER (PARTITION BY day_name, member_casual) AS median_ride_length_seconds
    FROM 
        [Cyclistic].[dbo].[TripData_2022_Q2]
    WHERE
        ride_length IS NOT NULL
	) AS t
GROUP BY
    day_name,
	member_casual,
	CONVERT(TIME, DATEADD(SECOND, median_ride_length_seconds, '00:00:00'))
ORDER BY
	member_casual,
	median_ride_length;
