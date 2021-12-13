-- single line comment is done with 2 dashes
/*
 * multiline comment
 * is done
 *  with /* */
 */

-- the hello world print statement of the SQL world: the select all command
-- SELECT <columns> FROM <table>;
-- asterisk means every column
select *
from actor;

-- select just the first and last name in the actor table 
select first_name, last_name
from actor;

-- what if I want specific data?
-- LIKE and WHERE clause can be used to get data that matches a pattern
select first_name, last_name
from actor
where first_name like 'Nick';

-- in the case of a specific value, we don't necessarily need like
-- we can just say where column = value
select first_name, last_name
from actor
where first_name = 'Nick';

-- SQL has wildcards to represent a single letter, multiple letters
-- what if I wanted all names starting with N of any length?
-- % wildcard representing any letters
select first_name, last_name
from actor
where first_name like 'N%';

select first_name, last_name
from actor
where first_name like '%nn%';

-- just like we have a wildcard for multiple letters
-- we have a wildcard for a single letter _
select first_name, last_name
from actor
where first_name like 'T__';

-- can use both wildcards
-- capture any name with two n's in the middle with at least two letters after the n's (aka Anne is not captured)
select first_name, last_name, actor_id
from actor
where first_name like '%nn__%';

-- some comparison operators useful for numerical values
-- Greater than (>) and less than (<)
-- Greater or equal to (>=) and less than or equal to (<=)
-- Equal (=) and not equal (<>)

-- check out whats in the payment table - select everything
select *
from payment;

-- let's use our numerical comparison operators
-- query for data that shows customers who paid more than $2
select customer_id, amount, payment_date
from payment
where amount > 2;

-- what about rentals less than or equal to $2?
select customer_id, amount, payment_date
from payment
where amount <= 2;

-- what if I wanted to see that result sorted by the cheapest rental?
-- ORDER by 
select customer_id, amount, payment_date
from payment
where amount <= 2
order by amount asc;
-- asc for ascending, desc for descending

-- where between 
-- between lets us specify a range of numerical values 
select customer_id, amount, rental_id
from payment
where amount between 2 and 7.99
order by amount desc;


-- aggregations - aka condensing many rows of data down into a single value
-- first example - how many total payments are in my payments table
select count(amount)
from payment;

-- SQL aggregate functions take many rows of similar data and condense them into a useful single value
/* SUM() - total sum of numerical values
 * COUNT() - total number of rows of any type of value
 * 		DISTINCT keyword lets us grab the count of unique value
 * AVG() - average value
 * MIN() - minimum value
 * MAX() - maximum value
 */

-- provide a column name as the argument for an aggregate in the select clause
-- the syntax for using an aggregate mimics the python syntax for a function call
select SUM(amount)
from payment;

-- can select multiple aggregates in one query
select SUM(amount), AVG(amount)
from payment;

-- I can alias an aggregate to give it's column a new name
select AVG(amount) as Average_Payment_Amount
from payment;

-- we can find the total number of unique customers by using COUNT() with DISTINCT
select COUNT(distinct customer_id) as Number_of_unique_customers
from payment;

-- figure out what data you're lookin at query
select *
from payment;

-- find the max payment
select MAX(amount), MIN(amount), AVG(amount)
from payment;

-- to me, that max payment seems really high based on the other payments I was seeing
-- let me write a query to check the top 10 or so payment amounts
select amount
from payment
order by amount desc;

-- maybe I want to look at the average payment ignoring the 90 extremely expensive payments and the free rentals
-- there we can see our average payment went from 6.63 to 4.22 when ignoring our 'outlier' payments
select AVG(amount)
from payment
where amount between 0.01 and 20;

-- how much money are we making total (sum) from the different prices of rentals?
-- we're going to need to use the aggregate 'separately' for different prices
-- we could do this in many queries
select sum(amount)
from payment
where amount = 7.99;

-- we can do this all in one query using a GROUP BY clause
-- GROUP BY clauses specifically work with aggregates when selecting an aggregate and a non-aggregate at the same time
select sum(amount), count(amount), amount
from payment
group by amount
order by sum(amount) desc;

-- which customer spent the most money?
-- sum(amount) grouped by customer_id?
select sum(amount), count(amount), customer_id
from payment
group by customer_id
having sum(amount) >= 1000
order by count(amount) desc;


-- let's check out the customer table
select * 
from customer;

-- there is a similar modifier for group by and aggregates
-- to the where clause
-- a having clause modifies an aggregate used with a group by
-- the same way that the where clause modifies a select clause
select count(customer_id), email
from customer
where email like 'j%w%'
group by email
having count(customer_id) > 0;


-- a look ahead at more complex DQL and tomorrow
-- joins

-- what if we took the earlier query looking at our highest spending customers
select sum(amount), count(amount), customer_id
from payment
group by customer_id
having sum(amount) >= 1000
order by count(amount) desc;

-- and we wanted to know more about these customers
-- I wanted their names and date created and whether or not they're currently active customers
-- things I want: the sum of the amount of payments, the count of the amount of payments grouped by the customer_id
-- along with the first_name, last_name, and active status of each customer
-- half of that data is in the payment table 
-- half of that data is in the customer table
-- how do I get it all in one query?
-- JOINs

-- PRIMARY KEYS & FOREIGN KEYS
-- primary keys are the unqiue identifier (usually id column) in each table
-- foreign keys are a reference to another table's primary key within a table
-- so in the case of customer_id - customer_id is the primary key of the customer table
-- and a foreign key in the payment table 
-- thereby creating a link between the two tables -> the foreign key is responsible for maintaining the relationship between the tables

select * from customer;
select * from payment;

-- to do a join I specify a table to join and two columns to join together
-- select columns
-- from table A
-- join table B
-- on table_A.column = table_B.column
-- whatever other modifiers
select sum(amount), count(amount), payment.customer_id, first_name, last_name, create_date, active
from payment
join customer
on customer.customer_id = payment.customer_id
group by payment.customer_id, first_name, last_name, create_date, active
having sum(amount) >= 1000
order by count(amount) desc;

-- all regular columns selected alongside aggregates must appear in a group by clause


-- Copy HW question
/*
* actual query written and ran
* select blah
* blah blah
* blah;
*/
-- answer