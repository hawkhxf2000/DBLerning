set search_path to pagila;

-- 1. Find all customers living in Canada. Give the first name, the last name, the email of each customer.
-- Sort by last names and then by first names (both increasing order).
select first_name, last_name, email
from customer c
         inner join address a on a.address_id = c.address_id
         inner join city c2 on c2.city_id = a.city_id
         inner join country c3 on c3.country_id = c2.country_id
where country = 'Canada'
order by last_name, first_name;

-- 2. How many employees (staff) are living in Canada?
select count(staff_id)
from staff s
         inner join address a on a.address_id = s.address_id
         inner join city c on a.city_id = c.city_id
         inner join country c2 on c.country_id = c2.country_id
where country = 'Canada';

-- 3. Find the city and the country of the customer with this email :
-- `SHARON.ROBINSON@sakilacustomer.org`
select c2.city, c3.country
from customer c1
         inner join address a on a.address_id = c1.address_id
         inner join city c2 on a.city_id = c2.city_id
         inner join country c3 on c3.country_id = c2.country_id
where c1.email = 'SHARON.ROBINSON@sakilacustomer.org';

-- 4. Find the number of customers for each country.
select c3.country, count(customer_id)
from customer c1
         inner join address a on a.address_id = c1.address_id
         inner join city c2 on a.city_id = c2.city_id
         inner join country c3 on c3.country_id = c2.country_id
group by c3.country
order by count(customer_id);

-- 5. Find the customers who have never rented any film. Give the first name, the last name and the email
-- of these customers.
select distinct first_name, last_name, email
from customer c
         left join rental r on c.customer_id = r.customer_id
where rental_id is null;

-- 6. Find the customers with rentals that haven't been returned yet. Give the first name, the last name
-- and the email of these customers.
select first_name, last_name, email
from customer c
where customer_id in
      (select distinct customer_id from rental where return_date is null);

-- 7. Find the number of rentals for each customer. Sort the results by decreasing number of rentals. Keep only the
--    customers with at least 30 rentals. Give the `customer_id`, the email and the number of rentals of each such
--    customer.
select c.customer_id, c.email, count(rental_id) as num_rental
from customer c
         left join rental r on c.customer_id = r.customer_id
group by c.customer_id
having count(rental_id) >= 30
order by count(rental_id) desc;

-- 8. Find the customers with less than 15 rentals. Give only the `customer_id` and the email of each
-- such customer.
select c.customer_id, c.email
from customer c
         inner join rental r on c.customer_id = r.customer_id
group by c.customer_id
having count(rental_id) < 15;

-- 9. Find the total amount of all payments made. Round the total to 2 decimal digits.
select round(sum(amount), 2) as total_amount
from payment;

-- 10. Find the total amount of all payments made each day. The days without any payments should **not** be listed.
-- You can use the `date` function to extract the date from a `timestamp` column. Round the totals to 2
-- decimal digits.
select date(payment_date), round(sum(amount), 2)
from payment
group by date(payment_date)
having round(sum(amount), 2) > 0
order by date(payment_date);

-- 11. Find the number of times the film `CONNECTION MICROCOSMOS` has been rented.
select f.title, count(title) num_rental
from rental r
         inner join inventory i on r.inventory_id = i.inventory_id
         inner join film f on i.film_id = f.film_id
group by f.title
having title = 'CONNECTION MICROCOSMOS';

-- 12. Find the films that have never been rented. Give the `film_id` and title of each such film.
select f.film_id, title
from film f
         left join inventory i on f.film_id = i.film_id
         left join rental r on i.inventory_id = r.inventory_id
group by f.film_id
having count(r.rental_id) = 0;

-- 13. Find the number of times each film has been rented. Give the `film_id` and title of each such
-- film in addition to the number of rentals. Sort in decreasing order of the number of rentals. Don't
-- forget films that have never been rented. Make sure your result don't contradict your results from
-- the previous question.
select f.film_id, f.title, count(rental_id)
from film f
         join inventory i on f.film_id = i.film_id
         left join rental r on i.inventory_id = r.inventory_id
group by f.film_id
order by count(rental_id) desc;

-- 14. Find all customers and all employees (staff) living in Canada. Give the first name, last name
-- and email of theses people. Sort by family names then by first names.
select first_name, last_name, email
from customer c
         inner join address a on a.address_id = c.address_id
         inner join city c2 on c2.city_id = a.city_id
         inner join country c3 on c3.country_id = c2.country_id
where country = 'Canada'
union
select first_name, last_name, email
from staff s
         inner join address a on a.address_id = s.address_id
         inner join city c on a.city_id = c.city_id
         inner join country c2 on c.country_id = c2.country_id
where country = 'Canada'
order by last_name, first_name;

-- 15. Find the films not currently in stock (i.e. the films not in the inventory). Give the `film_id`,
-- the title and the release year of these movies. Sort by release year (increasing order).
select f.film_id, f.title, release_year
from film f
         left join inventory i on f.film_id = i.film_id
where inventory_id is null
order by release_year;

-- ### Challenge questions (for bonus points)
-- 1. Find the average length of all films. Present the results on 3 columns (each column must be an integer) : `hours`
--    , `minutes` and `seconds`.
select (cast(avg(length) as int) / 60)                           as hours,
       (cast(avg(length) as int) % 60)                           as minutes,
       round(((avg(length) - cast(avg(length) as int)) * 60), 0) as seconds
from film;

-- 2. Find the customers with the largest number of rentals. Give the `customer_id`, first name, last name and the number
--    of rentals of each such customer.
select c.customer_id, first_name, last_name, count(rental_id) as num_rentals
from customer c
         inner join rental r on c.customer_id = r.customer_id
group by c.customer_id
-- in case there are several customers has same number of rentals, The max number of rentals has to be found at first,and
-- then compare the number of rentals of each customer
having count(rental_id) = (select count(rental_id) as num_rentals
                           from customer c
                                    inner join rental r on c.customer_id = r.customer_id
                           group by c.customer_id
                           order by count(rental_id) desc
                           limit 1);
-- because max() function can't use on another aggregate function(here is count()), I have to use (select count(rental_id)
-- ... limit 1) to find the max value of the count(rental_id). Actually, we can use only the last select ... limit 1 clause
-- here because there is only one customer with the largest number of rentals, but it's not safe for all condition.

-- 3. Find the total payment amount of each customers. Give the `customer_id`, first name, last name in addition to the
--    total amount for each customer. Don't forget the customers without any rentals, their total amount should not
--    be `null`, it should be 0. Round the results to 2 decimal digits. Sort the results by the total amount (decreasing
--    order).
select c.customer_id, first_name, last_name, round(coalesce(sum(amount), 0), 2) as total_amount
from customer c
         left join payment p on c.customer_id = p.customer_id
group by c.customer_id
order by total_amount desc;

-- 4. Find the customers with a total payment amount lower than the average. Give the `customer_id`, first name, last name
--    in addition to the total amount for each customer. Don't forget the customers without any rentals, their total amount
--    should not be `null`, it should be 0. Round the results to 2 decimal digits. Sort the results by the total amount (
--    increasing order).
select c.customer_id, first_name, last_name, round(coalesce(sum(amount), 0), 2) as total_amount
from customer c
         left join payment p on c.customer_id = p.customer_id
group by c.customer_id
having sum(amount) < (select sum(amount) from payment) / (select count(customer_id) from customer)
order by total_amount;

-- 5. Find the films in stock in exactly 1 store. Give the `film_id`, the title and release year of these films. Sort by
--    the release year (increasing order).

-- step1: find which store all films in stock put in
select distinct film_id, store_id
from inventory i
         join rental r on i.inventory_id = r.inventory_id -- remove the films not available for rent
where return_date is not null;
-- use return_date as the indicator of in stock

-- step2: group by film_id and count the number of store. count(store_id) = 1 means there is exactly 1 store has the
-- film inventory
select t.film_id
from (select distinct film_id, store_id
      from inventory i
               join rental r on i.inventory_id = r.inventory_id
      where return_date is not null) as t
group by t.film_id
having count(t.store_id) = 1;

--step 3: get required information from table film when the film_id is in the list queried before
select f.film_id, f.title, f.release_year
from film f
where f.film_id in
      (select t.film_id
       from (select distinct film_id, store_id
             from inventory i
                      join rental r on i.inventory_id = r.inventory_id
             where return_date is not null) as t
       group by t.film_id
       having count(t.store_id) = 1)
order by release_year;

-- 6. Find the films in stock in all the stores. Give the `film_id`, the title and release year of these films. Sort by
--    the release year (increasing order).

-- step 1: get the number of stores from table inventory
select count(t.store_id)
from (select distinct store_id from inventory) as t;

-- step 2: use the same code as before, but change 1 to number of stores.
select f.film_id, f.title, f.release_year
from film f
where f.film_id in
      (select t.film_id
       from (select distinct film_id, store_id
             from inventory i
                      join rental r on i.inventory_id = r.inventory_id
             where return_date is not null) as t
       group by t.film_id
       having count(t.store_id) = (select count(t.store_id)
                                   from (select distinct store_id from inventory) as t))
order by release_year;