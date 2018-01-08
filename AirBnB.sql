SELECT 
	id, 
	name,
	CAST(price AS NUMERIC) price
FROM 
	listings

ORDER BY price DESC
Limit 10;

-- Cannot read the prices correctly because in text format with $ characters.
-- Listings summary table does not have $ character so I will look at this table.

SELECT 
	id, 
	name,
	CAST(price AS NUMERIC) price
FROM 
	listings_summary

ORDER BY price DESC
Limit 10;

-- The most expensive listing is "LOHI! MBR w jacuzzi!! Walk to Downtown or Broncos" is the Lower Highland neighborhood.
-- This listing is VERY expensive at nearly $10,000 per night, let's take a closer look.

SELECT 
	l.id,
	l.name,
	l.neighbourhood,
	l.description,
	l.property_type, 
	l.room_type,
	l.accommodates,
	l.bathrooms,
	l.bedrooms,
	l.beds, 
	l.amenities,
	cast(ls.price AS NUMERIC) price_conv,
	l.security_deposit, 
	l.cleaning_fee,
	l.review_scores_rating,
	l.number_of_reviews, 
	l.reviews_per_month
FROM 
	listings l
JOIN 
	listings_summary ls
ON 
	l.id=ls.id
ORDER BY price_conv desc
LIMIT 1

-- For a private bedroom in a shared home, this seems a bit dubious. 
--Let's look at the next most expensive listing.


SELECT 
	l.id,
	l.name,
	l.neighbourhood,
	l.description,
	l.property_type, 
	l.room_type,
	l.accommodates,
	l.bathrooms,
	l.bedrooms,
	l.beds, 
	l.amenities,
	cast(ls.price AS NUMERIC) price_conv,
	l.security_deposit, 
	l.cleaning_fee,
	l.review_scores_rating,
	l.number_of_reviews, 
	l.reviews_per_month
FROM 
	listings l
JOIN 
	listings_summary ls
ON 
	l.id=ls.id
WHERE l.id='16165257'
ORDER BY price_conv desc
LIMIT 1

-- At $2,200 per night, this listing in the heart of downtown denver offers the entire home to renters.
-- Amentities include TV, Wifi, AC, Pool, Fitness and Free parking.
-- The listing also doesn't have a cleaning fee.
-- With 22 reviews and review rating score of 93 we can assume this space is a reasonable deal. Let's look at its reviews

select
	r.*
from reviews r
join listings l
on r.listing_id = l.id
WHERE l.id='16165257';

--Looks like 15 out of the 22 reviews claim that the host canceled the reservation before guests arrival.
--The remaining reviews are positive.

--2. What neighbourhoods are the most popular?
select
	neighbourhood,
	count(*)
from listings
group by 1
order by 2 desc;

--The most popular neighbourhood is "Five Points" I defined "most popular" as neighbourhood with most listings.


--3. What time of year is the cheapest time to go to your city? What about the busiest?
select 
	strftime('%m', date(date)) month,
	round(avg(cast((replace(replace(price, '$', ''), ',', '')) as NUMERIC)), 2) price,
	count(*) listing_avail
from calendar
where
	available = 't'
group by 1
order by 2 asc

--based on availibilty, the cheapest time of year in Denver is January and February at about $141 per night.

select
	strftime('%m', date(date)) month,
	sum(case when available = 'f' then 1 end) as tot_no_avail,
	sum(case when available = 't' then 1 end) as tot_avail
from calendar
group by 1
order by 2 desc

-- based on availability, it looks like early Fall (October and September) and Summer (June-August) are the busiest times of year.
-- I assume this has much to do with weather and vacation time.