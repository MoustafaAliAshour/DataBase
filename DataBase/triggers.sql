
-- Bookstore Database - Triggers & Stored Procedures


USE bookstore;

DELIMITER //


-- TRIGGER 1: Prevent Negative Stock

CREATE TRIGGER trg_prevent_negative_stock
BEFORE UPDATE ON stock
FOR EACH ROW
BEGIN
    IF NEW.quantity < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Stock quantity cannot be negative';
    END IF;
END//


-- TRIGGER 2: Auto-Place Order on Low Stock

CREATE TRIGGER trg_auto_order_on_low_stock
AFTER UPDATE ON stock
FOR EACH ROW
BEGIN
    DECLARE v_publisher_id INT;
    DECLARE v_order_quantity INT DEFAULT 50;
    
    IF NEW.quantity < NEW.threshold THEN
        SELECT pub_id INTO v_publisher_id
        FROM book
        WHERE ISBN = NEW.ISBN;
        
        INSERT INTO supply (ISBN, pub_id, quantity, date, status)
        VALUES (NEW.ISBN, v_publisher_id, v_order_quantity, CURDATE(), 'Pending');
    END IF;
END//


-- TRIGGER 3: Update Stock on Order Confirmation

CREATE TRIGGER trg_update_stock_on_confirm
AFTER UPDATE ON supply
FOR EACH ROW
BEGIN
    IF OLD.status = 'Pending' AND NEW.status = 'Confirmed' THEN
        UPDATE stock
        SET quantity = quantity + NEW.quantity
        WHERE ISBN = NEW.ISBN;
    END IF;
END//


-- TRIGGER 4: Initialize Stock for New Book

CREATE TRIGGER trg_init_stock_for_new_book
AFTER INSERT ON book
FOR EACH ROW
BEGIN
    INSERT INTO stock (ISBN, quantity, threshold)
    VALUES (NEW.ISBN, 0, 10);
END//


-- TRIGGER 5: Create Cart for New Customer

CREATE TRIGGER trg_create_cart_for_customer
AFTER INSERT ON customer
FOR EACH ROW
BEGIN
    INSERT INTO cart (cust_id)
    VALUES (NEW.cust_id);
END//

-- Add new book
CREATE PROCEDURE sp_add_book(
    IN p_ISBN VARCHAR(20),
    IN p_title VARCHAR(300),
    IN p_pub_year INT,
    IN p_selling_price DECIMAL(10, 2),
    IN p_category VARCHAR(20),
    IN p_pub_id INT,
    IN p_threshold INT,
    IN p_initial_quantity INT
)
BEGIN
    INSERT INTO book (ISBN, title, pub_year, selling_price, category, pub_id)
    VALUES (p_ISBN, p_title, p_pub_year, p_selling_price, p_category, p_pub_id);
    
    UPDATE stock
    SET threshold = p_threshold, quantity = p_initial_quantity
    WHERE ISBN = p_ISBN;
END//

-- Update book information
CREATE PROCEDURE sp_update_book(
    IN p_ISBN VARCHAR(20),
    IN p_title VARCHAR(300),
    IN p_pub_year INT,
    IN p_selling_price DECIMAL(10, 2),
    IN p_category VARCHAR(20)
)
BEGIN
    UPDATE book
    SET title = p_title,
        pub_year = p_pub_year,
        selling_price = p_selling_price,
        category = p_category
    WHERE ISBN = p_ISBN;
END//

-- Update stock quantity
CREATE PROCEDURE sp_update_stock(
    IN p_ISBN VARCHAR(20),
    IN p_quantity_change INT
)
BEGIN
    UPDATE stock
    SET quantity = quantity + p_quantity_change
    WHERE ISBN = p_ISBN;
END//

-- Confirm order
CREATE PROCEDURE sp_confirm_order(
    IN p_order_id INT
)
BEGIN
    UPDATE supply
    SET status = 'Confirmed'
    WHERE order_id = p_order_id AND status = 'Pending';
END//


-- SEARCH PROCEDURES


CREATE PROCEDURE sp_search_by_isbn(IN p_ISBN VARCHAR(20))
BEGIN
    SELECT * FROM vw_book_details WHERE ISBN = p_ISBN;
END//

CREATE PROCEDURE sp_search_by_title(IN p_title VARCHAR(300))
BEGIN
    SELECT * FROM vw_book_details WHERE title LIKE CONCAT('%', p_title, '%');
END//

CREATE PROCEDURE sp_search_by_category(IN p_category VARCHAR(20))
BEGIN
    SELECT * FROM vw_book_details WHERE category = p_category;
END//

CREATE PROCEDURE sp_search_by_author(IN p_author_name VARCHAR(200))
BEGIN
    SELECT DISTINCT vw.*
    FROM vw_book_details vw
    WHERE vw.authors LIKE CONCAT('%', p_author_name, '%');
END//

CREATE PROCEDURE sp_search_by_publisher(IN p_publisher_name VARCHAR(200))
BEGIN
    SELECT * FROM vw_book_details 
    WHERE publisher_name LIKE CONCAT('%', p_publisher_name, '%');
END//


-- CUSTOMER PROCEDURES


-- Add to cart
CREATE PROCEDURE sp_add_to_cart(
    IN p_cust_id INT,
    IN p_ISBN VARCHAR(20),
    IN p_quantity INT
)
BEGIN
    DECLARE v_cart_id INT;
    DECLARE v_existing_qty INT DEFAULT 0;
    
    SELECT cart_id INTO v_cart_id FROM cart WHERE cust_id = p_cust_id;
    
    SELECT quantity INTO v_existing_qty
    FROM consists_of
    WHERE cart_id = v_cart_id AND ISBN = p_ISBN;
    
    IF v_existing_qty > 0 THEN
        UPDATE consists_of
        SET quantity = quantity + p_quantity
        WHERE cart_id = v_cart_id AND ISBN = p_ISBN;
    ELSE
        INSERT INTO consists_of (cart_id, ISBN, quantity)
        VALUES (v_cart_id, p_ISBN, p_quantity);
    END IF;
END//

-- View cart
CREATE PROCEDURE sp_view_cart(IN p_cust_id INT)
BEGIN
    DECLARE v_cart_id INT;
    SELECT cart_id INTO v_cart_id FROM cart WHERE cust_id = p_cust_id;
    
    SELECT c.ISBN, b.title, b.selling_price, c.quantity,
           (b.selling_price * c.quantity) AS total_price
    FROM consists_of c
    JOIN book b ON c.ISBN = b.ISBN
    WHERE c.cart_id = v_cart_id;
END//

-- Remove from cart
CREATE PROCEDURE sp_remove_from_cart(
    IN p_cust_id INT,
    IN p_ISBN VARCHAR(20)
)
BEGIN
    DECLARE v_cart_id INT;
    SELECT cart_id INTO v_cart_id FROM cart WHERE cust_id = p_cust_id;
    
    DELETE FROM consists_of
    WHERE cart_id = v_cart_id AND ISBN = p_ISBN;
END//

-- Checkout
CREATE PROCEDURE sp_checkout(
    IN p_cust_id INT,
    IN p_credit_card VARCHAR(20),
    IN p_expiry_date DATE
)
BEGIN
    DECLARE v_cart_id INT;
    DECLARE done INT DEFAULT 0;
    DECLARE v_ISBN VARCHAR(20);
    DECLARE v_quantity INT;
    DECLARE v_price DECIMAL(10, 2);
    DECLARE v_amount DECIMAL(10, 2);
    
    DECLARE cart_cursor CURSOR FOR
        SELECT c.ISBN, c.quantity, b.selling_price
        FROM consists_of c
        JOIN book b ON c.ISBN = b.ISBN
        WHERE c.cart_id = v_cart_id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Validate credit card
    IF p_expiry_date < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Credit card has expired';
    END IF;
    
    SELECT cart_id INTO v_cart_id FROM cart WHERE cust_id = p_cust_id;
    
    OPEN cart_cursor;
    checkout_loop: LOOP
        FETCH cart_cursor INTO v_ISBN, v_quantity, v_price;
        IF done THEN LEAVE checkout_loop; END IF;
        
        SET v_amount = v_quantity * v_price;
        
        INSERT INTO purchases (cust_id, ISBN, date, quantity, amount)
        VALUES (p_cust_id, v_ISBN, CURDATE(), v_quantity, v_amount);
        
        UPDATE stock SET quantity = quantity - v_quantity WHERE ISBN = v_ISBN;
    END LOOP;
    CLOSE cart_cursor;
    
    DELETE FROM consists_of WHERE cart_id = v_cart_id;
END//

-- View customer orders
CREATE PROCEDURE sp_view_customer_orders(IN p_cust_id INT)
BEGIN
    SELECT p.pur_id, p.date, p.ISBN, b.title, p.quantity, p.amount
    FROM purchases p
    JOIN book b ON p.ISBN = b.ISBN
    WHERE p.cust_id = p_cust_id
    ORDER BY p.date DESC;
END//

-- Clear cart
CREATE PROCEDURE sp_clear_cart(IN p_cust_id INT)
BEGIN
    DECLARE v_cart_id INT;
    SELECT cart_id INTO v_cart_id FROM cart WHERE cust_id = p_cust_id;
    DELETE FROM consists_of WHERE cart_id = v_cart_id;
END//

-- Update customer info
CREATE PROCEDURE sp_update_customer(
    IN p_cust_id INT,
    IN p_fname VARCHAR(100),
    IN p_lname VARCHAR(100),
    IN p_email VARCHAR(150),
    IN p_phone VARCHAR(20),
    IN p_address VARCHAR(500),
    IN p_password VARCHAR(255)
)
BEGIN
    UPDATE customer
    SET fname = p_fname, lname = p_lname, email = p_email,
        phone = p_phone, address = p_address, password = p_password
    WHERE cust_id = p_cust_id;
END//

DELIMITER ;