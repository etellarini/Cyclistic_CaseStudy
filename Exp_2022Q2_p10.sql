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
