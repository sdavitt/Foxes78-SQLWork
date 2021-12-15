-- Subqueries
-- To use a secondary query to filter the results of a primary query

-- we design more complex or more specific queries for any data
-- using two queries combined into one -> a query and a subquery

-- essentially a subquery is a full query written as a modifier to a where clause in another query
-- what you're doing with a subquery is saying I want to filter the results of my primary query by those that also appear in the secondary query

-- Select <some stuff>
-- from <table>
-- where <stuff> in (<another full query>)

-- two separate queries

-- something related to payments
-- find customer_ids that have paid more than $175 total
select customer_id, sum(amount) as total_payments
from payment
group by customer_id
having sum(amount) > 175;

select * from customer;


-- we can utilize a subquery in a manner to find all of our customers who have paid more than $175
-- in many situations what we're doing with a subquery is not dissimilar to doing something with a join (related data between two tables)
-- just in many situations, the subquery is easier than the join(s)

-- a subquery can only have one selected column
-- the selected column of the subquery is what is compared to the selected column for the where clause
-- where customer_id in (subquery)
	-- means that our subquery should only select a customer_id column

-- subquery to find all of our customers who have paid more than $175
select customer_id, first_name, last_name, email
from customer
where customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) > 175
);
-- this gives us the info in customer table for the 10 customers who paid more than $175 total according to the customer_ids that exist in the payment table
-- our subquery gives us back a set of customer_ids from the payment table
-- thereby letting us use those customer_ids to determine the proper subset of customer table customers to give back from our main query


-- basic subquery: find all films with a language "English"

select *
from film
where language_id in (
	select language_id
	from language
	where name = 'English'
);

-- More complex subquery:
-- Determine if a customer from a country starting with U spent more than $175
select customer.customer_id, customer.first_name, customer.last_name, country.country
from customer
join address
on customer.address_id = address.address_id
join city
on address.city_id = city.city_id
join country
on city.country_id = country.country_id
where country.country like 'U%' and customer.customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) > 175
)
order by customer_id asc;

-- Customers 526 and 6 spent more than $175 and are from the United States
-- without the subquery, we have 54 customers from U countries
-- the subquery filters out anyone who didn't spend $175
-- leaving us with just Karl and Jennifer

-- when do I need group by?
-- group by is used when you are selecting regular columns alongside aggregate functions
-- or when you are selecting a regular column but using a having with an aggregate
-- in order for a regular column to be selected alongside an aggregate
-- that regular column must be used in an aggregate instead of normally OR appear in your group by
-- in other words -> if you want to use an aggregate anywhere in your query and also select a normal column
-- that normal must appear in a group by
select customer_id, sum(amount) as total_paid
from payment
where customer_id = 6
group by customer_id
having sum(amount) > 175;

select customer_id, amount
from payment
where customer_id = 6;