# Lab | SQL Self and cross join

#In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

### Instructions

#1. Get all pairs of actors that worked together.
select * from sakila.film_actor;
select * from sakila.actor;
select actor_id from sakila.film_actor
where film_id= film_id;

select fa1.actor_id as 'Actor x ID',a1.first_name as 'Actor x first name', a1.last_name as 'Actor x last name',
fa2.actor_id as 'Actor y ID' , a2.first_name as 'Actor y first name' , a2.last_name as 'Actor y last name'
from sakila.film_actor fa1 join sakila.actor a1 on fa1.actor_id=a1.actor_id 
join sakila.film_actor fa2 
on fa1.film_id = fa2.film_id
and fa1.actor_id <> fa2.actor_id join sakila.actor a2 on fa2.actor_id=a2.actor_id
order by fa1.actor_id, fa2.actor_id;





#2. Get all pairs of customers that have rented the same film more than 3 times.
select * from sakila.rental;
select * from sakila.inventory;
select * from sakila.film;
select * from sakila.customer;

select * from (select c1.customer_id , c1.first_name as 'First_Name_1', c1.last_name as 'Last_Name_1' from sakila.rental r1 join sakila.inventory i1 on r1.inventory_id = i1.inventory_id 
join sakila.film f1 on i1.film_id=f1.film_id join sakila.customer c1 on r1.customer_id=c1.customer_id 
group by c1.customer_id, f1.film_id
having count(r1.rental_id)>=3) sub1 join
(select c2.customer_id  , c2.first_name as 'First_Name_2', c2.last_name as 'Last_Name_2' from sakila.rental r2 join sakila.inventory i2 on r2.inventory_id = i2.inventory_id 
join sakila.film f2 on i2.film_id=f2.film_id join sakila.customer c2 on r2.customer_id=c2.customer_id
group by c2.customer_id, f2.film_id
having count(r2.rental_id) >=3)sub2
on sub1.customer_id <> sub2.customer_id;

select c1.customer_id as 'customer A', f1.film_id as 'filmA' from sakila.rental r1 join sakila.inventory i1 on r1.inventory_id = i1.inventory_id 
join sakila.film f1 on i1.film_id=f1.film_id join sakila.customer c1 on r1.customer_id=c1.customer_id order by 'filmA';

#3. Get all possible pairs of actors and films.
select * from sakila.film;
select * from sakila.film_actor;
select * from sakila.actor;

select * from (
  select distinct type from bank.card
) sub1
cross join (
  select distinct type from bank.disp
) sub2;

select * from (
select distinct actor_id, first_name, last_name from sakila.film_actor
join sakila.actor using(actor_id)
) sub1
cross join 
(select distinct film_id, title from sakila.film_actor join sakila.film using (film_id)) sub2;
