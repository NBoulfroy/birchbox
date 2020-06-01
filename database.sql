-- ------------------------------------------------------------------------- --
-- @Project: Test Birchbox
-- @File: database.sql
-- @Author: BOULFROY Nicolas
-- ------------------------------------------------------------------------- --

-- ------------------------------------------------------------------------- --
-- Database creation
-- ------------------------------------------------------------------------- --

CREATE DATABASE IF NOT EXISTS birchbox;

DROP TABLE IF EXISTS book_product;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS product;

CREATE TABLE customer (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(255) NOT NULL,
    CONSTRAINT pk_customer PRIMARY KEY (id)
);

CREATE TABLE product (
    id INT AUTO_INCREMENT,
    name VARCHAR(10) NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (id)
);

CREATE TABLE book (
    id INT AUTO_INCREMENT,
    ordered_at TIMESTAMP NOT NULL,
    customer_id INT NOT NULL,
    CONSTRAINT pk_order PRIMARY KEY(id),
    CONSTRAINT fk_book_customer FOREIGN KEY (customer_id) REFERENCES customer(id)
);

CREATE TABLE book_product (
    book_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT pk_book_product PRIMARY KEY (book_id, product_id),
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES book(id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES product(id)
);

INSERT INTO customer (first_name, last_name, email) VALUES
('kylian', 'Dupuis', 'kylian@gmail.com'),
('nicolas', 'de Montmorency', 'nicolas@yahoo.com'),
('guillaume', 'de Gaulle', 'guillaume@outlook.com'),
('sarah', 'Stuart', 'sarah@wanadoo.com');

INSERT INTO product (name) VALUES
('PRODUCT_1'),
('PRODUCT 2');

INSERT INTO book (ordered_at, customer_id) VALUES
('2020/06/01 12:00:00', 1),
('2020/05/29 22:00:00', 1),
('2020/04/01 09:00:00', 2),
('2020/01/01 14:00:00', 2),
('2020/05/31 19:30:00', 3),
('2020/05/31 09:15:00', 1);

INSERT INTO book_product (book_id, product_id, quantity) VALUES
(1, 1, 3),
(2, 1, 1),
(3, 2, 1),
(4, 1, 10),
(5, 1, 3),
(5, 2, 1),
(6, 2, 1);

-- ------------------------------------------------------------------------- --
-- QUERIES
-- ------------------------------------------------------------------------- --

-- 1) Get firstname and email of customers who ordered PRODUCT_1.
SELECT DISTINCT first_name, email
FROM customer
JOIN book ON book.customer_id = customer.id
JOIN book_product ON book_product.book_id = book.id
JOIN product ON product.id = book_product.product_id
WHERE product.name = 'PRODUCT_1';

-- 2) Get all the products name and quantity of products sold for the last 7 days.
SELECT product.name AS product_name, SUM(book_product.quantity) AS total_quantity
FROM product
JOIN book_product ON book_product.product_id = product.id
JOIN book ON book.id = book_product.book_id
WHERE ordered_at BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND CURDATE()
GROUP BY product.name
ORDER BY product.name DESC;
