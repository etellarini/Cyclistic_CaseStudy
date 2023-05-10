UPDATE [Cyclistic].[dbo].[TripData_Integrated12m_NewColumns]
SET [time_of_day] = 
  CASE 
    WHEN CAST([started_hour] AS TIME) >= '06:00:00' AND CAST([started_hour] AS TIME) < '11:00:00' THEN 'morning'
    WHEN CAST([started_hour] AS TIME) >= '11:00:00' AND CAST([started_hour] AS TIME) < '16:00:00' THEN 'afternoon'
    WHEN CAST([started_hour] AS TIME) >= '16:00:00' AND CAST([started_hour] AS TIME) < '21:00:00' THEN 'evening'
    ELSE 'night'
  END

