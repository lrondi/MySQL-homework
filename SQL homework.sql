USE sakila;

SELECT first_name, last_name FROM actor;

SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name' FROM actor;

SELECT actor_id, first_name, last_name FROM  actor
WHERE first_name = 'Joe';

SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%GEN%';

SELECT last_name, first_name FROM actor
WHERE last_name LIKE '%LI%';

SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN description BLOB;

ALTER TABLE actor
DROP COLUMN description;

SELECT last_name, COUNT(last_name) AS 'Number of actors'
FROM actor
GROUP BY last_name
HAVING COUNT(last_name)>=2;

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name ='GROUCHO';

UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

SHOW CREATE TABLE address;

SELECT s.first_name, s.last_name, a.address
FROM staff s
JOIN address a 
ON (s.address_id = a.address_id);

SELECT s.first_name, s.last_name,
SUM(p.amount) AS 'Total'
FROM staff s
JOIN payment p
ON s.staff_id = p.staff_id
WHERE payment_date > '2005-07-31' AND payment_date < '2005-09-01'
GROUP BY p.staff_id;

SELECT film.title, 
COUNT(film_actor.actor_id) AS 'Number of actors'
FROM film_actor
INNER JOIN film 
ON film_actor.film_id = film.film_id
GROUP BY film_actor.film_id;

SELECT COUNT(store_id) AS 'Number of copies'
FROM inventory
WHERE film_id IN (
SELECT film_id
FROM film
WHERE title = 'HUNCHBACK IMPOSSIBLE'
);
