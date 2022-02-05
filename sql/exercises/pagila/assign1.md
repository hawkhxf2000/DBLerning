# 420-921-VA Database

## Assignment 1

### SQL queries on the Pagila DB

#### Submission: 16 February (before midnight)

Answer the following questions by writing SQL queries on the Pagila DB. You should have 1 SQL `select` statement for
each question. Create a file named `assign1_1234567.sql` (replace `1234567` by your student number), and write your
answers in that file. Make sure you label your answers correctly with a proper comment (such as `-- 1.`) before each
query. Write a comment at the top of that file containing your name and your student number. That `.sql` file is the
only file you will have to submit on Léa for this assignment.

When not specified, include only the columns that make sense in the results. Otherwise, include only the columns
specified in the questions. Rename the columns appropriately when necessary to improve the readability of the results.
For example, when using the `count` aggregate function, rename the column to avoid having only `count` as the column
name.

1. Find all customers living in Canada. Give the first name, the last name, the email of each customer. Sort by last
   names and then by first names (both increasing order).
2. How many employees (staff) are living in Canada?
3. Find the city and the country of the customer with this email : `SHARON.ROBINSON@sakilacustomer.org`
4. Find the number of customers for each country.
5. Find the customers who have never rented any film. Give the first name, the last name and the email of these
   customers.
6. Find the customers with rentals that haven't been returned yet. Give the first name, the last name and the email of
   these customers.
7. Find the number of rentals for each customer. Sort the results by decreasing number of rentals. Keep only the
   customers with at least 30 rentals. Give the `customer_id`, the email and the number of rentals of each such
   customer.
8. Find the customers with less than 15 rentals. Give only the `customer_id` and the email of each such customer.
9. Find the total amount of all payments made. Round the total to 2 decimal digits.
10. Find the total amount of all payments made each day. The days without any payments should **not** be listed. You can
    use the `date` function to extract the date from a `timestamp` column. Round the totals to 2 decimal digits.
11. Find the number of times the film `CONNECTION MICROCOSMOS` has been rented.
12. Find the films that have never been rented. Give the `film_id` and title of each such film.
13. Find the number of times each film has been rented. Give the `film_id` and title of each such film in addition to
    the number of rentals. Sort in decreasing order of the number of rentals. Don't forget films that have never been
    rented. Make sure your result don't contradict your results from the previous question.
14. Find all customers and all employees (staff) living in Canada. Give the first name, last name and email of theses
    people. Sort by family names then by first names.
15. Find the films not currently in stock (i.e. the films not in the inventory). Give the `film_id`, the title and the
    release year of these movies. Sort by release year (increasing order).

### Challenge questions (for bonus points)

1. Find the average length of all films. Present the results on 3 columns (each column must be an integer) : `hours`
   , `minutes` and `seconds`.
2. Find the customers with the largest number of rentals. Give the `customer_id`, first name, last name and the number
   of rentals of each such customer.
3. Find the total payment amount of each customers. Give the `customer_id`, first name, last name in addition to the
   total amount for each customer. Don't forget the customers without any rentals, their total amount should not
   be `null`, it should be 0. Round the results to 2 decimal digits. Sort the results by the total amount (decreasing
   order).
4. Find the customers with a total payment amount lower than the average. Give the `customer_id`, first name, last name
   in addition to the total amount for each customer. Don't forget the customers without any rentals, their total amount
   should not be `null`, it should be 0. Round the results to 2 decimal digits. Sort the results by the total amount (
   increasing order).
5. Find the films in stock in exactly 1 store. Give the `film_id`, the title and release year of these films. Sort by
   the release year (increasing order).
6. Find the films in stock in all the stores. Give the `film_id`, the title and release year of these films. Sort by
   the release year (increasing order).