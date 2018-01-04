-- 1. The ID's and durations for all trips of duration greater than 500, ordered by duration.
select
	trip_id, 
	duration 
from 
	trips 
where 
	duration > 500 
order by duration

-- 2. Every column of the stations table for station id 84.
select * 
from 
	stations 
where station_id = 84

-- 3. The min temperatures of all the occurrences of rain in zip 94301.
select 
	MinTemperatureF 
from 
	weather 
where 
	ZIP = 94301