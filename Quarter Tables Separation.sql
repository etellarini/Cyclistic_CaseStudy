--Example of 2022_Q3 separation--

SELECT *
INTO [TripData_2022_Q3]
FROM [Cyclistic].[dbo].[TripData_Integrated12m_StationsAdd]
WHERE [started_date] >= '2022-07-01'
AND [started_date] < '2022-10-01';
