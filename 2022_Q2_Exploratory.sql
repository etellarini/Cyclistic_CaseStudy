/*
Cyclistic (Case Study): Quarterly Data Exploration, 2022_Q2
Skills used: Windows Functions, Aggregate Functions, Converting Data Types
*/

-- Total Trips: Members vs Casual 
-- Looking at overall, annual member and casual rider totals

SELECT
	[Total Trips],
    [Total Member Trips],
    [Total Casual Trips],
    ROUND([Total Member Trips] / CAST([Total Trips] AS FLOAT) * 100, 2) AS [Member Percentage],
    ROUND([Total Casual Trips] / CAST([Total Trips] AS FLOAT) * 100, 2) AS [Casual Percentage]
FROM
    (
	SELECT
		COUNT(ride_id) AS [Total Trips],
		SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS [Total Member Trips],
		SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS [Total Casual Trips]
	FROM
		[Cyclistic].[dbo].[TripData_2022_Q2]
	) t


-- Average Ride Lengths: Members vs Casual  
-- Looking at overall, member and casual average ride lengths

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


-- Time range of trips  
-- Looking at the distribution of the trips
SELECT 
	CASE 
		WHEN DATEDIFF(mi, started_hour, ended_hour) < 15 THEN '< 15 minutes'
		WHEN DATEDIFF(mi, started_hour, ended_hour) >= 15 AND DATEDIFF(mi, started_hour, ended_hour) < 30 THEN '15 - 30 minutes'
		WHEN DATEDIFF(mi, started_hour, ended_hour) >= 30 AND DATEDIFF(mi, started_hour, ended_hour) < 60 THEN '30 - 60 minutes'
		WHEN DATEDIFF(mi, started_hour, ended_hour) >= 60 AND DATEDIFF(mi, started_hour, ended_hour) < 120 THEN '1 - 2 hours'
		WHEN DATEDIFF(mi, started_hour, ended_hour) >= 120 AND DATEDIFF(mi, started_hour, ended_hour) < 240 THEN '2 - 4 hours'
		ELSE 'More than 4 hours'
	END AS time_range, 
	COUNT(*) AS num_trips
FROM 
	[Cyclistic].[dbo].[TripData_2022_Q2]
GROUP BY 
	CASE 
		WHEN DATEDIFF(mi, started_hour, ended_hour) < 15 THEN '< 15 minutes'
		WHEN DATEDIFF(mi, started_hour, ended_hour) >= 15 AND DATEDIFF(mi, started_hour, ended_hour) < 30 THEN '15 - 30 minutes'
		WHEN DATEDIFF(mi, started_hour, ended_hour) >= 30 AND DATEDIFF(mi, started_hour, ended_hour) < 60 THEN '30 - 60 minutes'
		WHEN DATEDIFF(mi, started_hour, ended_hour) >= 60 AND DATEDIFF(mi, started_hour, ended_hour) < 120 THEN '1 - 2 hours'
		WHEN DATEDIFF(mi, started_hour, ended_hour) >= 120 AND DATEDIFF(mi, started_hour, ended_hour) < 240 THEN '2 - 4 hours'
		ELSE 'More than 4 hours'
	END;


 -- Max Ride Lengths: Members vs Casual  
 -- Looking at max ride lengths to check for outliers

SELECT TOP (100)
	member_casual,
	ride_length
FROM 
	[Cyclistic].[dbo].[TripData_2022_Q2]
ORDER BY 
	ride_length DESC


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

-- Rides per day: member and casual
-- Looking at which days have the highest number of rides

SELECT
    member_casual,
    day_name AS [Top Day]
FROM (
    SELECT
        DISTINCT member_casual,
        day_name,
        ROW_NUMBER() OVER (PARTITION BY member_casual ORDER BY COUNT(day_name) DESC) rn
    FROM 
        [Cyclistic].[dbo].[TripData_2022_Q2] 
    GROUP BY
        member_casual,
        day_name
) AS subquery
WHERE
    rn = 1
ORDER BY
    member_casual DESC
OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY;



-- Looking at average ride length per day of week

SELECT
    day_name,
    CONVERT(TIME, DATEADD(SECOND, AVG(DATEDIFF(SECOND, '00:00:00', ride_length)), '00:00:00')) AS AVG_Ride_Length
FROM
    (
    SELECT
        member_casual,
        day_name,
        ride_length
    FROM
        [Cyclistic].[dbo].[TripData_2022_Q2]
    ) AS t
GROUP BY
    day_name


-- Looking at median ride length per day of week

SELECT 
    day_name,
    CONVERT(TIME, DATEADD(SECOND, median_ride_length_seconds, '00:00:00')) AS median_ride_length
FROM 
	(
    SELECT 
        day_name, 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY DATEDIFF(SECOND, '00:00:00', ride_length)) OVER (PARTITION BY day_name) AS median_ride_length_seconds
    FROM 
        [Cyclistic].[dbo].[TripData_2022_Q2]
    WHERE
        ride_length IS NOT NULL
	) AS t
GROUP BY 
    day_name,
	median_ride_length_seconds;


-- Looking at AVG ride length per day of week for casual and annual

SELECT
    day_name,
	member_Casual,
    CONVERT(TIME, DATEADD(SECOND, AVG(DATEDIFF(SECOND, '00:00:00', ride_length)), '00:00:00')) AS AVG_Ride_Length
FROM
    (
    SELECT
        member_casual,
        day_name,
        ride_length
    FROM
        [Cyclistic].[dbo].[TripData_2022_Q2]
    ) AS t
GROUP BY
    day_name,
	member_casual
ORDER BY
	member_casual,
	AVG_Ride_Length


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


-- Total rides by time of the day

SELECT
	[Total Trips],
    [Total Morning Trips],
    [Total Afternoon Trips],
	[Total Evening Trips],
	[Total Night Trips]
FROM
    (
	SELECT
		COUNT([ride_id]) AS [Total Trips],
		SUM(CASE WHEN [time_of_day] = 'morning' THEN 1 ELSE 0 END) AS [Total Morning Trips],
		SUM(CASE WHEN [time_of_day] = 'afternoon' THEN 1 ELSE 0 END) AS [Total Afternoon Trips],
		SUM(CASE WHEN [time_of_day] = 'evening' THEN 1 ELSE 0 END) AS [Total Evening Trips],
		SUM(CASE WHEN [time_of_day] = 'night' THEN 1 ELSE 0 END) AS [Total Night Trips]
	FROM
		[Cyclistic].[dbo].[TripData_2022_Q2]
	) t


-- Time of the day rides by member or casual

SELECT 
    time_of_day, 
    SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS member, 
    SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS casual
FROM 
    [Cyclistic].[dbo].[TripData_2022_Q2]
GROUP BY 
    time_of_day
