## 1. SELECT

### 1.1. Выборка всех данных из таблицы

**Запрос 1.** Вывести все книги.
```sql
SELECT * FROM books;
```

**Запрос 2.** Вывести всех покупателей.
```sql
SELECT * FROM customers;
```

### 1.2. Выборка отдельных столбцов

**Запрос 1.** Вывести названия и цены книг.
```sql
SELECT title, price FROM books;
```

**Запрос 2.** Вывести идентификаторы и названия категорий.
```sql
SELECT id, name FROM categories;
```

### 1.3. Присвоение новых имен столбцам (AS)

**Запрос 1.** Переименовать столбцы названия и цены книги.
```sql
SELECT title AS book_title, price AS book_price FROM books;
```

**Запрос 2.** Переименовать столбцы покупателей.
```sql
SELECT id AS customer_id, first_name AS customer_first_name,
       last_name AS customer_last_name
FROM customers;
```

### 1.4. Выборка с вычисляемым столбцом

**Запрос 1.** Рассчитать стоимость двух экземпляров каждой книги.
```sql
SELECT title, price, price * 2 AS price_for_two
FROM books;
```

**Запрос 2.** Рассчитать стоимость каждой позиции заказа.
```sql
SELECT order_id, book_id, quantity, price,
       quantity * price AS item_total
FROM order_items;
```

### 1.5. Вычисляемые столбцы: математические функции

**Запрос 1.** Округлить цены книг до целого.
```sql
SELECT title, price, ROUND(price, 0) AS rounded_price
FROM books;
```

**Запрос 2.** Вычислить квадратный корень из цены книги.
```sql
SELECT title, price, SQRT(price) AS price_sqrt
FROM books
WHERE price >= 0;
```

### 1.6. Вычисляемые столбцы: логические функции (CASE)

**Запрос 1.** Разделить книги на недорогие и дорогие.
```sql
SELECT title, price,
       CASE WHEN price < 1000 THEN 'Недорогая'
            ELSE 'Дорогая' END AS price_group
FROM books;
```

**Запрос 2.** Назначить скидку в зависимости от цены.
```sql
SELECT title, price,
       CASE WHEN price >= 1500 THEN price * 0.90
            ELSE price * 0.95 END AS discounted_price
FROM books;
```

### 1.7. Выборка данных по условию (WHERE)

**Запрос 1.** Найти книги дешевле 1000.
```sql
SELECT title, price FROM books WHERE price < 1000;
```

**Запрос 2.** Найти книги дороже 1200.
```sql
SELECT title, price FROM books WHERE price > 1200;
```

### 1.8. Выборка данных: логические операции

**Запрос 1.** Найти книги с ценой от 500 до 1500, не включая границы.
```sql
SELECT title, price FROM books
WHERE price > 500 AND price < 1500;
```

**Запрос 2.** Найти книги дешевле 1000 или с остатком менее 10 штук.
```sql
SELECT title, price FROM books
WHERE price < 1000 OR stock_quantity < 10;
```

### 1.9. Операторы BETWEEN, IN

**Запрос 1.** Найти книги в диапазоне цен от 900 до 1200 включительно.
```sql
SELECT title, price FROM books
WHERE price BETWEEN 900 AND 1200;
```

**Запрос 2.** Найти книги из категорий с идентификаторами 1, 2 или 3.
```sql
SELECT title, category_id FROM books
WHERE category_id IN (1, 2, 3);
```

### 1.10. Выборка данных с сортировкой (ORDER BY)

**Запрос 1.** Отсортировать книги по цене по возрастанию.
```sql
SELECT title, price FROM books ORDER BY price ASC;
```

**Запрос 2.** Отсортировать книги по цене по убыванию, затем по названию.
```sql
SELECT title, price FROM books ORDER BY price DESC, title ASC;
```

### 1.11. Оператор LIKE

**Запрос 1.** Найти книги, названия которых начинаются на цифру «1».
```sql
SELECT title FROM books WHERE title LIKE '1%';
```

**Запрос 2.** Найти книги, в названии которых встречается слово «мир» (без учета регистра).
```sql
SELECT title FROM books WHERE title ILIKE '%мир%';
```

### 1.12. Выбор уникальных элементов столбца (DISTINCT)

**Запрос 1.** Вывести уникальные идентификаторы авторов, у которых есть книги.
```sql
SELECT DISTINCT author_id FROM books;
```

**Запрос 2.** Вывести уникальные идентификаторы категорий книг.
```sql
SELECT DISTINCT category_id FROM books;
```

### 1.13. Ограничение количества строк (LIMIT / OFFSET)

**Запрос 1.** Вывести три самые дешевые книги.
```sql
SELECT title, price FROM books ORDER BY price ASC LIMIT 3;
```

**Запрос 2.** Пропустить первую книгу и вывести следующие две.
```sql
SELECT id, title FROM books ORDER BY id LIMIT 2 OFFSET 1;
```

## 2. JOIN

### 2.1. INNER JOIN

**Запрос 1.** Вывести книги вместе с их авторами.
```sql
SELECT b.title, a.first_name || ' ' || a.last_name AS author_name
FROM books AS b
INNER JOIN authors AS a ON b.author_id = a.id;
```

**Запрос 2.** Вывести книги вместе с их категориями.
```sql
SELECT b.title, c.name AS category_name
FROM books AS b
INNER JOIN categories AS c ON b.category_id = c.id;
```

### 2.2. LEFT JOIN

**Запрос 1.** Вывести всех авторов, включая авторов без книг.
```sql
SELECT a.first_name || ' ' || a.last_name AS author_name, b.title
FROM authors AS a
LEFT JOIN books AS b ON b.author_id = a.id;
```

**Запрос 2.** Вывести всех покупателей, включая тех, кто не оформлял заказов.
```sql
SELECT c.first_name || ' ' || c.last_name AS customer_name, o.id AS order_id
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.id;
```

### 2.3. RIGHT JOIN

**Запрос 1.** Вывести все категории, даже если в них нет книг.
```sql
SELECT b.title, c.name AS category_name
FROM books AS b
RIGHT JOIN categories AS c ON b.category_id = c.id;
```

**Запрос 2.** Вывести всех авторов, даже если у них нет книг.
```sql
SELECT b.title, a.first_name || ' ' || a.last_name AS author_name
FROM books AS b
RIGHT JOIN authors AS a ON b.author_id = a.id;
```

### 2.4. CROSS JOIN

**Запрос 1.** Получить все возможные сочетания авторов и категорий.
```sql
SELECT a.first_name || ' ' || a.last_name AS author_name, c.name AS category_name
FROM authors AS a
CROSS JOIN categories AS c;
```

**Запрос 2.** Получить все возможные сочетания покупателей и категорий.
```sql
SELECT cu.first_name || ' ' || cu.last_name AS customer_name, ca.name AS category_name
FROM customers AS cu
CROSS JOIN categories AS ca;
```

### 2.5. FULL OUTER JOIN

**Запрос 1.** Вывести всех авторов и все книги, включая записи без пары.
```sql
SELECT a.first_name || ' ' || a.last_name AS author_name, b.title
FROM authors AS a
FULL OUTER JOIN books AS b ON b.author_id = a.id;
```

**Запрос 2.** Вывести все категории и все книги, включая записи без пары.
```sql
SELECT c.name AS category_name, b.title
FROM categories AS c
FULL OUTER JOIN books AS b ON b.category_id = c.id;
```

### 2.6. Соединение нескольких таблиц

**Запрос 1.** Вывести название книги, автора и категорию.
```sql
SELECT b.title, a.first_name || ' ' || a.last_name AS author_name, c.name AS category_name
FROM books AS b
INNER JOIN authors AS a ON b.author_id = a.id
INNER JOIN categories AS c ON b.category_id = c.id;
```

**Запрос 2.** Вывести покупателя, номер заказа и названия заказанных книг.
```sql
SELECT c.first_name || ' ' || c.last_name AS customer_name, o.id AS order_id, b.title
FROM customers AS c
INNER JOIN orders AS o ON o.customer_id = c.id
INNER JOIN order_items AS oi ON oi.order_id = o.id
INNER JOIN books AS b ON b.id = oi.book_id;
```
