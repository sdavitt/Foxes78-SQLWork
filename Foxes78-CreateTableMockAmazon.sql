/* create table <table_name>(
 * 		<column_name> <datatype> <constraints>,
 * 		<column_name> <datatype> <constraints>
 * )
 */

-- Customer Table
create table customer(
	-- columns go here
	customer_id SERIAL primary key, -- serial is a auto-incrementing integer
	first_name VARCHAR(100), -- varchar is a string with a max length (100 here)
	last_name VARCHAR(100),
	address VARCHAR(150),
	billing_info VARCHAR(150)
);

-- verify create table either by looking in the database navigator
-- or just do a select statement
select * from customer;

-- Brand Table
create table brand(
	seller_id SERIAL primary key,
	brand_name VARCHAR(150) unique not null, 
	-- not null is a constraint that means this value must be provided for every brand
	-- unique is another constraint that means this value cannot be repeated within the table
	contact_number VARCHAR(15),
	address VARCHAR(150)
);

-- oops I made a mistake and now I can't rerun my create table! what do I do?
-- drop table command !USE WITH CAUTION! deletes table and all data in it
drop table brand;


select * from brand;

-- Inventory table
create table inventory(
	upc SERIAL primary key,
	product_amount INT
);

select * from inventory;

-- Order table *** i see the name order went red.... order is a keyword/taken name in postgreSQL - I can't use order as a variable/table/column name
create table order_(
	order_id SERIAL primary key,
	order_date DATE default CURRENT_DATE, -- default constraint provides a default value if no value is provided when data is added
	-- CURRENT_DATE is just a value we have access to through postgres - so it's being used as the default value for the order_date
	sub_total numeric(8,2), -- numeric(<MAX NUMBER OF DIGITS>, <DECIMAL PLACES>)
	-- note that max digits includes the decimal places: numeric(8,2) -> -999999.99 to 999999.99
	total_cost numeric(10,2),
	upc INT not null, -- not null means can't be empty
	foreign key(upc) references inventory(upc) -- the foreign key(upc) in this table references the inventory table's upc column
);

select * from order_;

-- Product Table
create table product(
	item_id SERIAL primary key,
	amount NUMERIC(5,2),
	prod_name VARCHAR(100),
	seller_id INT not null,
	foreign key(seller_id) references brand(seller_id),
	upc INT not null,
	foreign key(upc) references inventory(upc)
);

select * from product;


-- Cart Table!
create table cart(
	cart_id SERIAL primary key,
	customer_id INT not null,
	foreign key(customer_id) references customer(customer_id),
	order_id INT not null,
	foreign key(order_id) references order_(order_id)
);

select * from cart;