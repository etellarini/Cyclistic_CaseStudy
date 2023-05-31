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
