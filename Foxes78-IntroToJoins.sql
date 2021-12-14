-- Customer Table for Presidents
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(200),
	address VARCHAR(150),
	city VARCHAR(150),
	customer_state VARCHAR(100),
	zipcode VARCHAR(50)
);

-- Orders Table for Presidents
CREATE TABLE order_(
	order_id SERIAL PRIMARY KEY,
	order_date DATE DEFAULT CURRENT_DATE,
	amount NUMERIC(5,2),
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(1,'George','Washington','gwash@usa.gov', '3200 Mt Vernon Hwy', 'Mt Vernon', 'VA', '22121');

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(2,'John','Adams','jadams@usa.gov','1200 Hancock', 'Quincy', 'MA','02169');

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(3,'Thomas','Jefferson', 'tjeff@usa.gov', '931 Thomas Jefferson Pkway', 'Charlottesville','VA','02169');

INSERt INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(4,'James','Madison', 'jmad@usa.gov', '11350 Conway','Orange','VA','02169');

INSERT INTO customer(customer_id,first_name,last_name,email,address,city,customer_state,zipcode)
VALUES(5,'James','Monroe','jmonroe@usa.gov','2050 James Monroe Parkway','Charlottesville','VA','02169');

-- INSERT INFO INTO ORDERS TABLE

INSERT INTO order_(order_id,amount,customer_id)
VALUES(1,234.56,1);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(2,78.50,3);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(3,124.00,2);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(4,65.50,3);

INSERT INTO order_(order_id,amount,customer_id)
VALUES(5,55.50,NULL);

select * from customer;
select * from order_;

-- basic inner join: take only the data that makes sense/matches in both tables
select order_id, order_date, amount, order_.customer_id, first_name, last_name, email, address
from order_ -- table A
join customer -- table B
on order_.customer_id = customer.customer_id; -- when using a shared column name, you must specify which table's column you mean

-- full outer join: don't ignore any null values, include them
select order_id, amount, customer.customer_id, last_name, email
from order_
full join customer
on order_.customer_id = customer.customer_id;

-- outer join - disjoint outer join - only give me null values
select order_id, amount, customer.customer_id, last_name, email
from order_
full join customer
on order_.customer_id = customer.customer_id
where order_id is null or order_.customer_id is null;


-- normal left join - all order_ table data, include customer data where applicaple
select order_id, amount, customer.customer_id, last_name, email
from order_
left join customer
on order_.customer_id = customer.customer_id;

-- left outer join - order_ table data that has no customer
select order_id, amount, customer.customer_id, last_name, email
from order_
left join customer
on order_.customer_id = customer.customer_id
where order_.customer_id is null;

-- normal right join (some people find it easier to write a right join as a left join with the tables flipped)
-- all of the possible customers - including where our order_ data is null
select order_id, amount, customer.customer_id, last_name, email
from order_
right join customer
on order_.customer_id = customer.customer_id;

-- right outer join
select order_id, amount, customer.customer_id, last_name, email
from order_
right join customer
on order_.customer_id = customer.customer_id
where order_id is null;