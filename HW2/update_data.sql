-- 1. Изменяем цену книги
UPDATE books
SET price = 1600.00
WHERE id = 1;

-- 2. Изменяем количество книг на складе
UPDATE books
SET stock_quantity = 9
WHERE id = 1;

-- 3. Меняем статус заказа
UPDATE orders
SET status = 'Оплачен'
WHERE id = 1;

-- 4. Изменяем телефон клиента
UPDATE customers
SET phone = '+79991234567'
WHERE id = 2;

-- 5. Меняем описание категории
UPDATE categories
SET description = 'Русская и зарубежная классическая литература'
WHERE id = 1;