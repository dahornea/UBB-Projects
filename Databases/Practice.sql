/*+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| personId    | int     |
| lastName    | varchar |
| firstName   | varchar |
+-------------+---------+
personId is the primary key column for this table.
This table contains information about the ID of some persons and their first and last names.
 

Table: Address

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| addressId   | int     |
| personId    | int     |
| city        | varchar |
| state       | varchar |
+-------------+---------+
addressId is the primary key column for this table.
Each row of this table contains information about the city and state of one person with ID = PersonId.
 

Write an SQL query to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.

Return the result table in any order.*/


SELECT p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a
ON p.personId = a.personId

/*Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

The query result format is in the following example.*/

SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee)

/*Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.*/

CREATE FUNCTION getNthHighestSalary(n INT) RETURNS INT
BEGIN
    SET n = n-1;
    RETURN (
        SELECT DISTINCT Salary FROM Employee
        ORDER BY Salary DESC
        LIMIT 1 OFFSET n
    );
END

/*Table: Scores

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| score       | decimal |
+-------------+---------+
id is the primary key for this table.
Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
 

Write an SQL query to rank the scores. The ranking should be calculated according to the following rules:

The scores should be ranked from the highest to the lowest.
If there is a tie between two scores, both should have the same ranking.
After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
Return the result table ordered by score in descending order. */

SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM Scores

/*+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
 

Write an SQL query to find the employees who earn more than their managers.

Return the result table in any order.*/

SELECT e1.name AS Employee
FROM Employee e1, Employee e2
WHERE e1.managerId = e2.id AND e1.salary > e2.salary

/*Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write an SQL query to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

Return the result table in any order.*/

SELECT email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1

/*Table: Customers

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID and name of a customer.
 

Table: Orders

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key column for this table.
customerId is a foreign key of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
 

Write an SQL query to report all customers who never order anything.

Return the result table in any order.*/

SELECT name AS Customers
FROM Customers
WHERE id NOT IN (SELECT customerId FROM Orders)

/*Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. Note that you are supposed to write a DELETE statement and not a SELECT one.

After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.*/

DELETE p1
FROM Person p1, Person p2
WHERE p1.email = p2.email AND p1.id > p2.id

/*Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature on a certain day.
 

Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.*/

SELECT w1.id AS Id
FROM Weather w1, Weather w2
WHERE w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY) AND w1.temperature > w2.temperature

/*+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the primary key column for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
 

Table: Bonus

+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the primary key column for this table.
empId is a foreign key to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.
 

Write an SQL query to report the name and bonus amount of each employee with a bonus less than 1000 or null if there is no bonus.

Return the result table in any order*/

SELECT name, bonus
FROM Employee e LEFT JOIN Bonus b ON e.empId = b.empId
WHERE bonus < 1000 OR bonus IS NULL

/*Table: Orders

+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key for this table.
This table contains information about the order ID and the customer ID.
 

Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.*/

SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(order_number) DESC
LIMIT 1

/*Table: Courses

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key column for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
 

Write an SQL query to report all the classes that have at least five students.

Return the result table in any order.*/

SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5

/*Table: SalesPerson

+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| sales_id        | int     |
| name            | varchar |
| salary          | int     |
| commission_rate | int     |
| hire_date       | date    |
+-----------------+---------+
sales_id is the primary key column for this table.
Each row of this table indicates the name and the ID of a salesperson alongside their salary, commission rate, and hire date.
 

Table: Company

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| com_id      | int     |
| name        | varchar |
| city        | varchar |
+-------------+---------+
com_id is the primary key column for this table.
Each row of this table indicates the name and the ID of a company and the city in which the company is located.
 

Table: Orders

+-------------+------+
| Column Name | Type |
+-------------+------+
| order_id    | int  |
| order_date  | date |
| com_id      | int  |
| sales_id    | int  |
| amount      | int  |
+-------------+------+
order_id is the primary key column for this table.
com_id is a foreign key to com_id from the Company table.
sales_id is a foreign key to sales_id from the SalesPerson table.
Each row of this table contains information about one order. This includes the ID of the company, the ID of the salesperson, the date of the order, and the amount paid.
 

Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".

Return the result table in any order.*/

SELECT name
FROM SalesPerson s
WHERE s.sales_id NOT IN (SELECT sales_id FROM Orders o, Company c WHERE o.com_id = c.com_id AND c.name = 'RED')


/*Table: Triangle

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
(x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
 

Write an SQL query to report for every three line segments whether they can form a triangle.

Return the result table in any order.*/


/*Table: MyNumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
There is no primary key for this table. It may contain duplicates.
Each row of this table contains an integer.

Example 1:

Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output: 
+-----+
| num |
+-----+
| 6   |
+-----+
 

A single number is a number that appeared only once in the MyNumbers table.

Write an SQL query to report the largest single number. If there is no single number, report null.*/

SELECT MAX(num) AS num
FROM MyNumbers
GROUP BY num
HAVING COUNT(num) = 1

/*Table: Salary

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| name        | varchar  |
| sex         | ENUM     |
| salary      | int      |
+-------------+----------+
id is the primary key for this table.
The sex column is ENUM value of type ('m', 'f').
The table contains information about an employee.
 

Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement and no intermediate temporary tables.

Note that you must write a single update statement, do not write any select statement for this problem.*/


/*Table: ActorDirector

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| actor_id    | int     |
| director_id | int     |
| timestamp   | int     |
+-------------+---------+
timestamp is the primary key column for this table.
 

Write a SQL query for a report that provides the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.

Return the result table in any order.*/

SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp) >= 3

/*Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |
+--------------+---------+
product_id is the primary key of this table.
Each row of this table indicates the name and the price of each product.
Table: Sales

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |
+-------------+---------+
This table has no primary key, it can have repeated rows.
product_id is a foreign key to the Product table.
Each row of this table contains some information about one sale.
 

Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.

Return the result table in any order.*/

SELECT product_id, product_name, unit_price
FROM Product p
WHERE p.product_id NOT IN (SELECT product_id FROM Sales s WHERE s.sale_date BETWEEN '2019-04-01' AND '2019-12-31')

/*Table: Activity

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
The activity_type column is an ENUM of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.
 

Write an SQL query to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.

Return the result table in any order.*/

SELECT activity_date, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date
