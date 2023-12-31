# SQL Query Processing Order

---------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To best understand the processing order of an SQL statement, consider the diagram.     


![SQL Processing Order](/Database%20Tips%20and%20Tricks/Advanced%20SQL%20Joins/images/SQLQueryProcessingOrderPage.png)


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SQL does not process the query in the order in which it is written, as the `SELECT` statement is processed almost last.  The correct processing order is `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `SELECT`, `ORDER BY` and `LIMIT`.  Once a query first enters the `FROM` statement, there are four types of table operators, `JOIN`, `APPLY`, `PIVOT`, and `UNPIVOT` that can be performed, and each of these operators has a series of subphases.

---------------------------------------------------------

Processing order of a SQL statement:

| Order |   Syntax  |                                         Description                                         |
|-------|-----------|---------------------------------------------------------------------------------------------|
|     1 |  FROM     |  Specifies a table, view, table variable, or derived table source, with or without an alias |
|     2 |  WHERE    |  Specifies the search condition for the rows returned by the query                          |
|     3 |  GROUP BY |  Specifies the records in which to group on                                                 |
|     4 |  HAVING   |  Restricts the results of a GROUP BY                                                        |
|     5 |  SELECT   |  Specifies which values are to be returned                                                  |
|     6 |  ORDER BY |  Specifies which values to order the result set by                                          |
|     7 |  LIMIT    |  Constrains the number of rows returned by a SELECT statement                               |

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The database engine parses each clause of the query individually and creates an execution plan for each clause. These execution plans are then combined to form a final execution plan, which is used to retrieve the desired data from the database.

---------------------------------------------------------

The four table operators and their subphases are:

| Operator |                      Subphases                          |
|----------|---------------------------------------------------------|
| JOIN     |  1) Cartesian Product 2) ON Predicate 3) Add Outer Rows |
| APPLY    |  1) Apply Table Expression 2) Add Outer Rows            |
| PIVOT    |  1) Group 2) Spread 3) Aggregate                        |
| UNPIVOT  |  1) Generate Copies 2) Extract Element 3) Remove NULLs  |

---------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The `PIVOT` and `UNPIVOT` are two operators in SQL Server that are used to generate multi-dimensional reports. The `APPLY` operator is used when you want to return values from a table-valued function.  From the diagram we can determine there is only one true type of table join, the cartesian product.  `INNER` and `OUTER JOINS` are restricted cartesian products where the `ON` predicate specifies the restriction.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To best understand that joins are simply restricted cartesian products, the following two statements below produce the exact same result set.  The first statement uses an `INNER JOIN`, and the second statement uses the `CROSS JOIN` syntax.  
*  If we were to remove the join logic from the `ON` clause on the `INNER JOIN`, an error would occur.  
*  If the join logic is removed from the `CROSS JOIN`, a full cartesian product is created.  
*  Both statements use an equi-join to filter the result set to all records that have a `CustomerID` equal in both the `Customers` and `Orders` table.  
*  Because the `CROSS JOIN` has an `ON` statement specifying how to join the tables, this join acts as an `INNER JOIN`.

```sql
--Statement 1
SELECT  *
FROM    Customers emp INNER JOIN
        Orders ord ON emp.CustomerID = ord.CustomerID;

--Statement 2
SELECT  *
FROM    Customers emp CROSS JOIN
        Orders ord ON emp.CustomerID = ord.CustomerID;
```
---------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The biggest difference between `INNER`, `OUTER`, and `CROSS JOINS` is that the `INNER JOIN` acts as a **filtering criterion**, `OUTER JOIN` acts as a **matching criterion**, and a `CROSS JOIN` gives all possible combinations.
  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For `INNER` and `OUTER JOIN`, these types of joins require a comparison operator to equate rows from the participating tables based on a common field in both the tables.  These comparison operators are described as equi-joins and theta-joins are rooted in Relational Algebra.  Introduced by Edgar F. Codd in 1970, Relational Algebra uses algebraic structures with a well-founded semantics for modeling data and defining queries on it.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lastly, SQL is a declarative language, meaning you tell the SQL engine **WHAT** to do, and not **HOW** to do it.  When a table operation is being performed, the SQL engine decides the best method for physically joining the tables (called a join algorithm).  These join algorithms are used to optimize the performance of a query when performing a join operation and are based on the table size, type of data they contain, available index, table statistics.

---------------------------------------------------------

1. [Introduction](01%20-%20Introduction.md)
2. [SQL Processing Order](02%20-%20SQL%20Query%20Processing%20Order.md)
3. [Table Types](03%20-%20Table%20Types.md)
4. [Equi, Theta, and Natural Joins](04%20-%20Equi%2C%20Theta%2C%20and%20Natural%20Joins.md)
5. [Inner Joins](05%20-%20Inner%20Join.md)
6. [Outer Joins](06%20-%20Outer%20Joins.md)
7. [Full Outer Joins](07%20-%20Full%20Outer%20Join.md)
8. [Cross Joins](08%20-%20Cross%20Join.md)
9. [Semi and Anti Joins](09%20-%20Semi%20and%20Anti%20Joins.md)
10. [Any, All, and Some](10%20-%20Any%2C%20All%2C%20and%20Some.md)
11. [Self Joins](11%20-%20Self%20Join.md)
12. [Relational Division](12%20-%20Relational%20Division.md)
13. [Set Operations](13%20-%20Set%20Operations.md)
14. [Join Algorithms](14%20-%20Join%20Algorithms.md)
15. [Exists](15%20-%20Exists.md)
16. [Complex Joins](16%20-%20Complex%20Joins.md)

https://advancedsqlpuzzles.com

