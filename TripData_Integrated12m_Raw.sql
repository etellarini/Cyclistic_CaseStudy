-- Union of all Tables --
CREATE TABLE [Cyclistic].[dbo].[TripData_Integrated12m_Raw] (
    [ride_id] nvarchar(255),
	[rideable_type] nvarchar(255),
    [started_at] datetime,
    [ended_at] datetime,
    [start_station_name] varchar(100),
    [end_station_name] varchar(100),
    [member_casual] varchar(50)
);
INSERT INTO [Cyclistic].[dbo].[TripData_Integrated12m_Raw] (
    [ride_id], 
	[rideable_type], 
	[started_at], 
	[ended_at], 
	[start_station_name], 
    [end_station_name],
	[member_casual]
)
SELECT * FROM [Cyclistic].[dbo].[2022_04_TripData]
UNION 
SELECT * FROM [Cyclistic].[dbo].[2022_05_TripData]
UNION 
SELECT * FROM [Cyclistic].[dbo].[2022_06_TripData]
UNION 
SELECT * FROM [Cyclistic].[dbo].[2022_07_TripData]
UNION 
SELECT * FROM [Cyclistic].[dbo].[2022_08_TripData]
UNION 
SELECT * FROM [Cyclistic].[dbo].[2022_09_TripData]
UNION 
SELECT * FROM [Cyclistic].[dbo].[2022_10_TripData]
UNION 
SELECT * FROM [Cyclistic].[dbo].[2022_11_TripData]
UNION 
SELECT * FROM [Cyclistic].[dbo].[2022_12_TripData]
UNION 
SELECT * FROM [Cyclistic].[dbo].[2023_01_TripData]
UNION 
SELECT * FROM [Cyclistic].[dbo].[2023_02_TripData]
UNION
SELECT * FROM [Cyclistic].[dbo].[2023_03_TripData];
