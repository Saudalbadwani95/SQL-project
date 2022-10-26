-----------------------------------------------Qestion 1

SELECT st.store_id storeid, SUM(p.amount) total_amt
FROM payment p
JOIN staff s
ON p.staff_id = s.staff_id
JOIN store st
ON s.store_id = st.store_id
GROUP BY storeid;

------------------------------------------------Qestion 2

SELECT classified_category, SUM(number_of_rental) total_of_rental
FROM (SELECT
      c.name classified_category,
      COUNT(r.*) number_of_rental
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
JOIN inventory inv
ON f.film_id = inv.film_id
JOIN rental r
ON inv.inventory_id = r.inventory_id
GROUP BY  classified_category
ORDER BY classified_category) sub

GROUP BY classified_category
ORDER BY total_of_rental DESC;

----------------------------------------------- Qestion 3

WITH table1 AS(SELECT c.name classified_category,
SUM(p.amount)OVER(partition by c.name order by c.name) as total_amount
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
JOIN inventory inv
ON f.film_id = inv.film_id
JOIN rental r
ON inv.inventory_id = r.inventory_id
JOIN payment p
ON p.rental_id = r.rental_id)

SELECT classified_category, total_amount
FROM table1
GROUP BY classified_category, total_amount
ORDER BY total_amount DESC;


-------------------------------------------------- Qestion 4

WITH table1 AS(SELECT f.title film_title, f.length film_length, COUNT(r.*) number_of_rental
FROM film f
  JOIN inventory inv
  ON f.film_id = inv.film_id
  JOIN rental r
  ON inv.inventory_id = r.inventory_id
  GROUP BY f.title, f.length
  ORDER BY number_of_rental DESC
  LIMIT 10)
  SELECT film_title, film_length, number_of_rental,
  DENSE_RANK() OVER(ORDER BY number_of_rental DESC) ranks
  FROM table1
  ORDER BY number_of_rental DESC;
