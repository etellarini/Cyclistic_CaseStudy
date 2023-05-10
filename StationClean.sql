--Remove () from Station Location --
UPDATE [Cyclistic].[dbo].[TripData_Integrated12m_StationsAdd]
SET [ended_Location] = SUBSTRING([ended_Location], 2, LEN([ended_Location]) - 2)
WHERE [ended_Location] LIKE '(%'




