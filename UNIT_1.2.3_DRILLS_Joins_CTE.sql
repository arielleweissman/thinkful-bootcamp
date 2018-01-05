CREATE TABLE status_abbreviated AS
  SELECT *
  FROM status
  limit 10000

-- 1. What are the three longest trips on rainy days?
with
	rainy
as(
	select
		date
	from
		weather
	where
		events = 'Rain'
	group by 1)

select
	trip_id,
	duration,
	date(start_date) as trip_date
from
	trips
join
	rainy
on rainy.date = trip_date
order by duration desc
limit 3;

-- 2. Which station is empty most often?
select
	stations.station_id,
	stations.name,
	count(case when docks_available = 0 then 1 end) as empty_count
from
	stations
join 
	status_abbreviated
on	
	status_abbreviated.station_id = stations.station_id
group by 1
order by empty_count desc

-- 3. Return a list of stations with a count of number of trips starting at that station but ordered by dock count.
select
	trips.start_station,
	stations.dockcount,
	count(*)
from
	trips
join
	stations
on trips.start_station = stations.name
group by 1
order by 2 desc

--4. (Challenge) What's the length of the longest trip for each day it rains anywhere?
with rainy as(
select
	date
from
	weather
where
	events = 'Rain'
group by 1)

select
	date(start_date) as trip_date,
	max(duration) as longest
from
	trips
join
	rainy
on rainy.date = trip_date
group by 1
order by 1,2 desc
