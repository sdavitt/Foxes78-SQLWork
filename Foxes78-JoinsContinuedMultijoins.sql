-- Let's try out some joins
select * from actor;
select * from film_actor;

-- I want the actor first_name and last_name joined onto my film_actor table 
-- inner join to start -> only things that match
-- film_actor table gonna be table A
-- actor table gonna be table B

select film_actor.actor_id, actor.first_name, actor.last_name, film_actor.film_id, film_actor.last_update
from film_actor
join actor
on film_actor.actor_id = actor.actor_id;


-- Are there any actors not in any films?
-- I want to see the actor ids that are not present in film_actor
-- I want to see the actor ids that have no associated film_id in the film_actor table
-- aka I want to see the join between actor and film_actor where film_id is null

-- left outer join where actor is table A
select actor.actor_id, actor.first_name, actor.last_name, film_actor.film_id
from actor
left join film_actor
on actor.actor_id = film_actor.actor_id
where film_actor.film_id is null;

-- answer: There are 3 actors who appear in no films: Kevin Hart, Shoha Tsuchida, and john brandon (ids: 500, 202, 269)



select first_name, last_name, actor_id
from actor;

-- What are the names of the actors acting in the most films? The least films?

select actor.actor_id, count(film_id) as films_appeared_in, actor.first_name, actor.last_name
from film_actor
right join actor
on film_actor.actor_id = actor.actor_id
group by actor.actor_id, actor.first_name, actor.last_name
-- having count(film_id) = 0 to see just the actors in no films
order by films_appeared_in asc;

-- Most: actor_id 42, Gina Degeneres, appeared in 42 films
-- Not including actors who appeared in zero films**** - Emily Dee (id 148) appeared in the fewest films at 14



-- are there are films with no actors
-- this needs the film table and the film_actor table
-- is there a film who's id does not appear in the film_actor table
select film.film_id, film.title, film.description, film_actor.actor_id
from film
left join film_actor
on film.film_id = film_actor.film_id;

select * from film_actor where film_id = 257 or film_id = 323 or film_id = 803;

-- Multijoins!
-- I WANT FILM TITLES NEXT TO MY ACTOR NAMES IS THAT TOO MUCH TO ASK???
-- No, that's easy with multijoins :)

-- I basically just need to combine these two joins:
select actor.actor_id, actor.first_name, actor.last_name, film_actor.film_id
from actor
left join film_actor
on actor.actor_id = film_actor.actor_id;

select film.film_id, film.title, film.description, film_actor.actor_id
from film
left join film_actor
on film.film_id = film_actor.film_id;

-- multijoin - just doing one join after the other
select actor.actor_id, actor.first_name, actor.last_name, film.film_id, film.title, film.description
from actor
join film_actor
on actor.actor_id = film_actor.actor_id
join film
on film.film_id = film_actor.film_id;


-- I have customers who have addresses, those addresses have cities, those cities have countrys
select * from customer;
select * from address;
select * from city;
select * from country;

-- How many customers do I have from Greece

-- start with 1 join at a time
-- started at customer
-- joined address onto customer (share address_id)
select customer.customer_id, customer.first_name, customer.last_name, customer.address_id
from customer
join address
on customer.address_id = address.address_id;

-- join city onto address (share city_id)
select address.address_id, city.city, address.city_id
from address
join city
on address.city_id = city.city_id;

-- join country onto city (share country_id)
select city.city_id, country.country, city.country_id, country.country_id 
from city
join country
on city.country_id = country.country_id;

/*
 * Customer <- address
 * address <- city
 * city <- country
 * 
 * doesn't that look like I can just do some substitution
 * Customer <- address = address <- city = city <- country
 * So I can just do a multijoin
 * Customer <- address <- city <- country
 * thereby joining Customer and Country
 */
select customer.customer_id, customer.first_name, customer.last_name, country.country
from customer
join address
on customer.address_id = address.address_id
join city
on address.city_id = city.city_id
join country
on city.country_id = country.country_id
where country.country like 'G_____';

-- customers 3 and 596 are from Greece, customer 584 is from Gambia

-- a refresher on where ___ like ____
-- like is one of the comparisons we can use for a varchar (string) value
-- we can define a pattern and ask in a where clause is the value in a certain column 'like' (does it match) the pattern