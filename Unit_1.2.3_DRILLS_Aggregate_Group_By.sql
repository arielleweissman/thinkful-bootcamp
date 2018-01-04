--- 1. What was the hottest day in our data set? Where was that?
SELECT 
	ZIP, 
	max(MaxTemperatureF) maxTemp
FROM 
	weather
GROUP BY 1
ORDER BY 2 DESC 
limit 1

-- 2. How many trips started at each station?
select
	start_station,
	count(*) as station_count
from trips
group by 1
order by 2 desc

-- 3. What's the shortest trip that happened?
select
	min(duration) as length
from trips

-- 4. What is the average trip duration, by end station?
select
	end_station,
	avg(duration) as avg_trip
from trips
group by 1
order by 2 desc
