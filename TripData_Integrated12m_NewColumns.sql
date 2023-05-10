-- New Columns added --

SELECT *
INTO [Cyclistic].[dbo].[TripData_Integrated12m_NewColumns]
FROM 
	(
	SELECT 
		[ride_id],
		[rideable_type],
		[member_casual],
		--[started_at],
		CONVERT(date, [started_at]) AS [started_date],
		CONVERT(time, [started_at]) AS [started_hour],
		DATENAME(month, [started_at]) AS [month],
		DATENAME(weekday, [started_at]) AS [day_name],
		--[ended_at]
  		CONVERT(date, [ended_at]) AS [ended_date],
		CONVERT(time, [ended_at]) AS [ended_hour],
		CONVERT(time, DATEADD(ms, DATEDIFF(ms, [started_at], [ended_at]), 0)) AS [ride_length],
		[start_station_name],
		[end_station_name]
	FROM [Cyclistic].[dbo].[TripData_Integrated12m_NoDupNoNulls]
	) t