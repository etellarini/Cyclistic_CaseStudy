-- Time range of trips  -- Looking at the distribution of the lenght trips
 
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
