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

SELECT c.first_name, c.last_name,
SUM(p.amount) AS 'Total Amount Paid'
FROM customer c
JOIN payment p
ON (c.customer_id = p.customer_id)
GROUP BY p.customer_id
ORDER BY c.last_name;

SELECT title, language_id FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%'
AND language_id IN(
SELECT language_id FROM language
WHERE name = 'English'); 

SELECT first_name, last_name 
FROM actor
WHERE actor_id IN(
	SELECT actor_id 
    FROM film_actor
    WHERE film_id IN(
		SELECT film_id 
        FROM film
        WHERE title =  'Alone Trip'
        )
);

SELECT first_name, last_name, email
FROM customer q
INNER JOIN address a
ON (q.address_id = a.address_id)
INNER JOIN city c
ON (a.city_id = c.city_id)
INNER JOIN country k
ON (k.country_id = c.country_id)
WHERE country = 'Canada';

SELECT title FROM film
WHERE film_id IN(
	SELECT film_id FROM film_category
	WHERE category_id IN(
		SELECT category_id FROM category
        WHERE name='Family'
    )
);

SELECT film.title, COUNT(rental.inventory_id) AS 'counts'
FROM rental
JOIN inventory
ON inventory.inventory_id = rental.inventory_id
JOIN film
ON (inventory.film_id = film.film_id)
GROUP BY rental.inventory_id
ORDER BY counts DESC;

SELECT s.store_id, SUM(p.amount) AS 'Total_amount'
FROM store s
JOIN staff st
ON s.store_id = st.store_id
JOIN payment p 
ON (p.staff_id = st.staff_id)
GROUP BY s.store_id
ORDER BY Total_amount;

SELECT s.store_id, c.city, k.country
FROM store s
JOIN address a
ON (s.address_id = a.address_id)
JOIN city c
ON (a.city_id = c.city_id)
JOIN country k
ON (c.country_id = k.country_id);


SELECT category.name, SUM(payment.amount) AS 'Total'
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN inventory
ON film_category.film_id = inventory.film_id
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category.category_id
ORDER BY Total DESC
LIMIT 5;

CREATE VIEW gross_revenue AS
SELECT category.name, SUM(payment.amount) AS 'Total'
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN inventory
ON film_category.film_id = inventory.film_id
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category.category_id
ORDER BY Total DESC
LIMIT 5;

SELECT * FROM gross_revenue;

DROP VIEW gross_revenue;