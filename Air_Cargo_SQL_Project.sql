create database air_cargo;
use air_cargo;
create table customer(customer_id int, first_name varchar(20), last_name varchar(20), date_of_birth date, gender char);
select * from customer;
create table passengers_on_flight(customer_id int, aircraft_id varchar(20), route_id int, depart varchar(20), arrival varchar(20), seat_num varchar(20), class_id varchar(20), travel_date date, flight_num int);
select * from passengers_on_flight;
create table ticket_details(p_date date, customer_id int, aircraft_id varchar(20), class_id varchar(20), no_of_tickets int, a_code varchar(20), price_per_ticket int, brand varchar(20));
select * from ticket_details;
create table routes(route_idair_cargo int, flight_num int, origin_airport varchar(20), destination_airport varchar(20), aircraft_id varchar(20), distance_miles int);
select * from routes;
alter table routes add constraint unique(route_id);
alter table routes add constraint check(distance_miles>0);

--  2. Write a query to display all the passengers (customers) who have travelled in routes 01 to 25. Take data from the passengers_on_flights table.
select c.customer_id, first_name, last_name, date_of_birth, gender, route_id from customer c join passengers_on_flight p on c.customer_id=p.customer_id where route_id between 1 and 25;

--  3. Write a query to identify the number of passengers and total revenue in business class from the ticket_details table.
select count(customer_id) no_of_passengers, sum(price_per_ticket) as total_revenue from ticket_details where class_id="Bussiness";

--  4. Write a query to display the full name of the customer by extracting the first name and last name from the customer table.
select concat(first_name," ",last_name) as full_name from customer;

--  5. Write a query to extract the customers who have registered and booked a ticket. Use data from the customer and ticket_details tables.
select distinct(t.customer_id), c.first_name, c.last_name from ticket_details as t left join customer as c on t.customer_id=c.customer_id;

--  6. Write a query to identify the customer’s first name and last name based on their customer ID and brand (Emirates) from the ticket_details table.
select customer.customer_id, first_name, last_name, brand from customer join ticket_details where customer.customer_id=ticket_details.customer_id and brand="emirates";

--  7. Write a query to identify the customers who have travelled by Economy Plus class using Group By and Having clause on the passengers_on_flights table.
Select count(customer_id), class_id from passengers_on_flight group by class_id having class_id="economy plus";

--  8. Write a query to identify whether the revenue has crossed 10000 using the IF clause on the ticket_details table.
select if(sum(price_per_ticket)>10000, "Revenue crossed 10000", "Revenue not crossed 10000") as revenue_check from ticket_details;

--  9. Write a query to create and grant access to a new user to perform operations on a database.
create user MrX@localhost identified by "password";
grant all on air_cargo.* to Mrx@localhost;

--  10.	Write a query to find the maximum ticket price for each class using window functions on the ticket_details table.
select distinct class_id, max(price_per_ticket) over( partition by class_id) as max_class_price from ticket_details;

--  11.	Write a query to extract the passengers whose route ID is 4 by improving the speed and performance of the passengers_on_flights table.
select customer_id from passengers_on_flight where route_id=4;

--  12.	For the route ID 4, write a query to view the execution plan of the passengers_on_flights table.
select aircraft_id, depart, arrival,travel_date,flight_num from passengers_on_flight where route_id=4;

--  13.	Write a query to create a view with only business class customers along with the brand of airlines.
create view brand as select c.first_name, c.last_name, t.customer_id, t.class_id, t.brand from air_cargo.ticket_details as t
left join customer as c on t.customer_id=c.customer_id where class_id="bussiness";
select * from brand;