USE dataframe;

############### Exercise 1 ###############
# The total amount of trips made per month
SELECT DATE(created_at) as DATE, TRUNCATE(SUM(`amount`)/100,1) trip_amount_month
FROM      trips
GROUP BY month(created_at);

#The total trip amount per year
SELECT DATE(created_at) as DATE, TRUNCATE(SUM(`amount`)/100,1) trip_amount_year
FROM      trips
GROUP BY year(created_at);

#The total trip amount per currency
SELECT currency as text,  TRUNCATE(SUM(`amount`)/100,1) trip_amount_currency
FROM trips
GROUP BY currency;

############### Exercise 2 ###############
#The total discount per month, excluding data from 2022.
SELECT trips_entries.discount, trips.created_at,
COALESCE(SUM(discount),0) as total_discount
FROM trips_entries
INNER JOIN trips ON trips_entries.Trip_id=trips.Trip_id
#WHERE created_at not like '%97'
WHERE YEAR(created_at) not like '2022'
GROUP BY month(created_at);

#The total discount per year, excluding data from 2022.
SELECT trips_entries.discount, trips.created_at,
COALESCE(SUM(discount),0) as total_discount
FROM trips_entries
INNER JOIN trips ON trips_entries.Trip_id=trips.Trip_id
WHERE YEAR(created_at) not like '2022'
GROUP BY year(created_at);

#The total discount per currency, excluding data from 2022.
SELECT trips_entries.discount, trips.created_at, trips.currency as text,
COALESCE(SUM(discount),0) as total_discount
FROM trips_entries
INNER JOIN trips ON trips_entries.Trip_id=trips.Trip_id
WHERE YEAR(created_at) not like '2022'
GROUP BY currency;

############### Exercise 3 ###############
# The total trip amount per city and country. Excluding those cities whose trips are lower than 3000.

SELECT trips.amount, tours.country, tours.city,
COALESCE(SUM(amount),0) as total_amount
FROM trips
  INNER JOIN trips_entries ON trips.Trip_id = trips_entries.Trip_id
  INNER JOIN tours
  ON trips_entries.tour_id = tours.tour_id
  WHERE NOT city='madrid'
  GROUP BY city
 HAVING total_amount > 3000;
