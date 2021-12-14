-- Inserting Data into my newly created Mock Amazon database

/* insert into <table>(
 * 		<column>,
 * 		<column>,
 * 		<column>
 * ) values (
 * 		<value for first column>,
 * 		<value>,
 * 		<value>
 * );
 */	

insert into customer(
	first_name,
	last_name,
	address,
	billing_info
) values (
	'Doctor Algernop',
	'Krieger',
	'1 State Street, New York, New York, 10001',
	'4242-4242-4242-4242 623 05/20'
);

select * from customer;

-- you can have insert show you the newly added rows
-- you can insert multiple rows at the same time
-- let's add two more customers in one query
insert into customer(
	first_name,
	last_name,
	address,
	billing_info
) values
(	'John',
	'Gilfoyle',
	'3520 Newell Road, Palo Alto, CA',
	'4242-4242-4242-4242 623 05/20'
	),
(	'Dinesh',
	'Chugtai',
	'3520 Newell Road, Palo Alto, CA',
	'4242-4242-4242-4242 623 05/20'
	)
returning *; -- show us all of the new data that was added

-- add some data to our brand table
insert into brand(
	brand_name
) values
('Coding Temple LLC'),
('Doctor Krieger''s Half-Human Pig Hybrids, Ltd'), -- don't use double quotes in postgreSQL, this is implying a column/schema reference
-- instead, to escape an apostrophe, just use a second apostrophe
('Pied Piper')
returning *;

select * from brand;

-- insert data for our inventory table
insert into inventory(
	upc,
	product_amount
) values (3450, 1000.00), (591, 3.50), (3, 50000.00)
returning *;

-- insert data for the product table
insert into product(
	amount,
	prod_name,
	seller_id,
	upc
) values (
	999.99,
	'Piggly 3',
	2,
	591
),
(450.00, 'PiperPhone', 3, 3),
(750.00, 'Self-Paced Content', 1, 3450)
returning *;

-- insert into the order_ table
insert into order_(
	sub_total,
	total_cost,
	upc
) values
(2999.97, 17999.97, 591),
(450.00, 465.00, 3),
(1500.00, 1500.00, 3450)
returning *;

-- cart data
insert into cart(
	customer_id,
	order_id
) values (1, 3), (3, 2), (2, 1) returning *;


select  cart_id, first_name, last_name, cart.customer_id
from cart
join customer
on cart.customer_id = customer.customer_id;

select * from cart;
