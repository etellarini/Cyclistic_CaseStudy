-- Complete Cleaned Table --

SELECT TOP (1000) 
      [ride_id],
      [rideable_type],
      [member_casual],
      [started_date],
      [started_hour],
      [month],
      [day_name],
      [ended_date],
      [ended_hour],
      [ride_length],
      [start_station_name],
      [end_station_name],
      [time_of_day],
      [started_Location],
      [ended_Location],
  FROM [Cyclistic].[dbo].[TripData_Integrated12m_StationsAdd]
