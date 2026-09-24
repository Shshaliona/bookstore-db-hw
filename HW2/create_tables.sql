CREATE TABLE authors (
                         id SERIAL PRIMARY KEY,
                         first_name VARCHAR(50) NOT NULL,
                         last_name VARCHAR(50) NOT NULL,
                         country VARCHAR(50),
                         birth_year INT
);

CREATE TABLE categories (
                            id SERIAL PRIMARY KEY,
                            name VARCHAR(100) NOT NULL,
                            description TEXT
);

CREATE TABLE customers (
                           id SERIAL PRIMARY KEY,
                           first_name VARCHAR(50) NOT NULL,
                           last_name VARCHAR(50) NOT NULL,
                           email VARCHAR(100) NOT NULL,
                           phone VARCHAR(20),
                           registration_date DATE NOT NULL
);

CREATE TABLE books (
                       id SERIAL PRIMARY KEY,
                       title VARCHAR(200) NOT NULL,
                       price DECIMAL(10, 2) NOT NULL,
                       stock_quantity INT NOT NULL,
                       description TEXT,

                       author_id INT NOT NULL,
                       category_id INT NOT NULL,

                       FOREIGN KEY (author_id)
                           REFERENCES authors(id),

                       FOREIGN KEY (category_id)
                           REFERENCES categories(id)
);

CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        order_date DATE NOT NULL,
                        status VARCHAR(50) NOT NULL,
                        total_amount DECIMAL(10, 2) NOT NULL,

                        customer_id INT NOT NULL,

                        FOREIGN KEY (customer_id)
                            REFERENCES customers(id)
);

CREATE TABLE order_items (
                             order_id INT NOT NULL,
                             book_id INT NOT NULL,
                             quantity INT NOT NULL,
                             price DECIMAL(10, 2) NOT NULL,

                             PRIMARY KEY (order_id, book_id),

                             FOREIGN KEY (order_id)
                                 REFERENCES orders(id),

                             FOREIGN KEY (book_id)
                                 REFERENCES books(id)
);