-- Drop existing database and create new one
DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;
USE bookstore;

-- Drop tables if they exist
DROP TABLE IF EXISTS consists_of;
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS supply;
DROP TABLE IF EXISTS stock;
DROP TABLE IF EXISTS written_by;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS publisher;
DROP TABLE IF EXISTS customer;

-- 1. Publisher Table
CREATE TABLE publisher (
    pub_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    address VARCHAR(500),
    phone VARCHAR(20),
    INDEX idx_publisher_name (name)
) ENGINE=InnoDB;

-- 2. Author Table
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    INDEX idx_author_name (name)
) ENGINE=InnoDB;

-- 3. Book Table

CREATE TABLE book (
    ISBN VARCHAR(20) PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    pub_year INT,
    selling_price DECIMAL(10, 2) NOT NULL CHECK (selling_price >= 0),
    category ENUM('Science', 'Art', 'Religion', 'History', 'Geography') NOT NULL,
    pub_id INT NOT NULL,
    FOREIGN KEY (pub_id) REFERENCES publisher(pub_id) ON DELETE RESTRICT,
    INDEX idx_book_title (title),
    INDEX idx_book_category (category),
    INDEX idx_book_publisher (pub_id)
) ENGINE=InnoDB;


-- 4. Written_by Table (Book-Author M:N)

CREATE TABLE written_by (
    ISBN VARCHAR(20),
    author_id INT,
    PRIMARY KEY (ISBN, author_id),
    FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE CASCADE,
    INDEX idx_wb_author (author_id)
) ENGINE=InnoDB;


-- 5. Stock Table

CREATE TABLE stock (
    ISBN VARCHAR(20) PRIMARY KEY,
    quantity INT NOT NULL DEFAULT 0 CHECK (quantity >= 0),
    threshold INT NOT NULL DEFAULT 10 CHECK (threshold >= 0),
    FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE CASCADE,
    INDEX idx_stock_threshold (quantity, threshold)
) ENGINE=InnoDB;


-- 6. Supply Table (Orders from Publishers)

CREATE TABLE supply (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    ISBN VARCHAR(20) NOT NULL,
    pub_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    date DATE NOT NULL,
    status ENUM('Pending', 'Confirmed') DEFAULT 'Pending',
    FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE RESTRICT,
    FOREIGN KEY (pub_id) REFERENCES publisher(pub_id) ON DELETE RESTRICT,
    INDEX idx_supply_status (status),
    INDEX idx_supply_date (date),
    INDEX idx_supply_isbn (ISBN)
) ENGINE=InnoDB;


-- 7. Customer Table

CREATE TABLE customer (
    cust_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    fname VARCHAR(100) NOT NULL,
    lname VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(500),
    role ENUM('customer', 'admin') NOT NULL DEFAULT 'customer',
    INDEX idx_customer_username (username),
    INDEX idx_customer_email (email)
) ENGINE=InnoDB;



-- 8. Cart Table

CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    cust_id INT NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id) ON DELETE CASCADE,
    INDEX idx_cart_customer (cust_id)
) ENGINE=InnoDB;


-- 9. Consists_of Table (Cart Items)

CREATE TABLE consists_of (
    cart_id INT,
    ISBN VARCHAR(20),
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (cart_id, ISBN),
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id) ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE RESTRICT
) ENGINE=InnoDB;


-- 10. Purchases Table (Customer Orders/Sales)

CREATE TABLE purchases (
    pur_id INT PRIMARY KEY AUTO_INCREMENT,
    cust_id INT NOT NULL,
    ISBN VARCHAR(20) NOT NULL,
    date DATE NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id) ON DELETE RESTRICT,
    FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE RESTRICT,
    INDEX idx_purchases_date (date),
    INDEX idx_purchases_customer (cust_id),
    INDEX idx_purchases_isbn (ISBN),
    INDEX idx_purchases_customer_date (cust_id, date)
) ENGINE=InnoDB;


-- Views for Common Queries


-- View: Books with full details
CREATE VIEW vw_book_details AS
SELECT 
    b.ISBN,
    b.title,
    b.pub_year,
    b.selling_price,
    b.category,
    GROUP_CONCAT(DISTINCT a.name ORDER BY a.name SEPARATOR ', ') AS authors,
    p.name AS publisher_name,
    p.phone AS publisher_phone,
    s.quantity AS stock_quantity,
    s.threshold AS stock_threshold,
    CASE WHEN s.quantity < s.threshold THEN 'Low Stock' ELSE 'Available' END AS stock_status
FROM book b
LEFT JOIN written_by wb ON b.ISBN = wb.ISBN
LEFT JOIN author a ON wb.author_id = a.author_id
LEFT JOIN publisher p ON b.pub_id = p.pub_id
LEFT JOIN stock s ON b.ISBN = s.ISBN
GROUP BY b.ISBN, b.title, b.pub_year, b.selling_price, b.category, 
         p.name, p.phone, s.quantity, s.threshold;

-- View: Customer order summary
CREATE VIEW vw_customer_orders AS
SELECT 
    c.cust_id,
    c.username,
    CONCAT(c.fname, ' ', c.lname) AS customer_name,
    COUNT(DISTINCT p.pur_id) AS total_orders,
    SUM(p.quantity) AS total_books_purchased,
    SUM(p.amount) AS total_amount_spent,
    MAX(p.date) AS last_purchase_date
FROM customer c
LEFT JOIN purchases p ON c.cust_id = p.cust_id
GROUP BY c.cust_id, c.username, c.fname, c.lname;