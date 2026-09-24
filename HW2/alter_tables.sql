-- 1. Добавляем ISBN книге
ALTER TABLE books
    ADD COLUMN isbn VARCHAR(20);

-- 2. ISBN должен быть уникальным
ALTER TABLE books
    ADD CONSTRAINT books_isbn_unique UNIQUE (isbn);

-- 3. Добавляем адрес клиента
ALTER TABLE customers
    ADD COLUMN address VARCHAR(255);

-- 4. Добавляем ограничение: цена книги не может быть отрицательной
ALTER TABLE books
    ADD CONSTRAINT books_price_positive
        CHECK (price >= 0);

-- 5. Добавляем ограничение на количество книг
ALTER TABLE order_items
    ADD CONSTRAINT order_items_quantity_positive
        CHECK (quantity > 0);