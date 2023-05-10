-- Total Trips: Members vs Casual -- Looking at overall, annual member and casual rider totals

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
