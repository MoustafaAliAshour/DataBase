
-- Bookstore Database - Admin Reports


USE bookstore;

DELIMITER //


-- REPORT 1: Total Sales for Previous Month

CREATE PROCEDURE sp_report_previous_month_sales()
BEGIN
    SELECT 
        YEAR(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) AS year,
        MONTH(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) AS month,
        MONTHNAME(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) AS month_name,
        SUM(amount) AS total_sales,
        COUNT(DISTINCT pur_id) AS total_transactions,
        SUM(quantity) AS total_books_sold,
        COUNT(DISTINCT cust_id) AS unique_customers,
        AVG(amount) AS average_transaction_value
    FROM purchases
    WHERE YEAR(date) = YEAR(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
      AND MONTH(date) = MONTH(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));
END//


-- REPORT 2: Total Sales for Specific Day

CREATE PROCEDURE sp_report_sales_by_date(IN p_date DATE)
BEGIN
    SELECT 
        p_date AS sale_date,
        SUM(amount) AS total_sales,
        COUNT(DISTINCT pur_id) AS total_transactions,
        SUM(quantity) AS total_books_sold,
        COUNT(DISTINCT cust_id) AS unique_customers,
        AVG(amount) AS average_transaction_value
    FROM purchases
    WHERE date = p_date;
    
    -- Also show breakdown by category
    SELECT 
        b.category,
        COUNT(DISTINCT p.pur_id) AS transactions,
        SUM(p.quantity) AS books_sold,
        SUM(p.amount) AS revenue
    FROM purchases p
    JOIN book b ON p.ISBN = b.ISBN
    WHERE p.date = p_date
    GROUP BY b.category
    ORDER BY revenue DESC;
END//


-- REPORT 3: Top 5 Customers (Last 3 Months)

CREATE PROCEDURE sp_report_top_customers()
BEGIN
    SELECT 
        c.cust_id,
        c.username,
        CONCAT(c.fname, ' ', c.lname) AS customer_name,
        c.email,
        c.phone,
        COUNT(DISTINCT p.pur_id) AS number_of_orders,
        SUM(p.quantity) AS total_books_purchased,
        SUM(p.amount) AS total_purchase_amount,
        AVG(p.amount) AS average_order_value,
        MAX(p.date) AS last_purchase_date
    FROM customer c
    JOIN purchases p ON c.cust_id = p.cust_id
    WHERE p.date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    GROUP BY c.cust_id, c.username, c.fname, c.lname, c.email, c.phone
    ORDER BY total_purchase_amount DESC
    LIMIT 5;
END//


-- REPORT 4: Top 10 Selling Books (Last 3 Months)

CREATE PROCEDURE sp_report_top_books()
BEGIN
    SELECT 
        b.ISBN,
        b.title,
        b.category,
        b.selling_price,
        GROUP_CONCAT(DISTINCT a.name ORDER BY a.name SEPARATOR ', ') AS authors,
        p_pub.name AS publisher,
        SUM(p.quantity) AS total_copies_sold,
        COUNT(DISTINCT p.pur_id) AS number_of_transactions,
        SUM(p.amount) AS total_revenue,
        s.quantity AS current_stock
    FROM book b
    JOIN purchases p ON b.ISBN = p.ISBN
    LEFT JOIN written_by wb ON b.ISBN = wb.ISBN
    LEFT JOIN author a ON wb.author_id = a.author_id
    JOIN publisher p_pub ON b.pub_id = p_pub.pub_id
    LEFT JOIN stock s ON b.ISBN = s.ISBN
    WHERE p.date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    GROUP BY b.ISBN, b.title, b.category, b.selling_price, p_pub.name, s.quantity
    ORDER BY total_copies_sold DESC
    LIMIT 10;
END//


-- REPORT 5: Total Orders Placed for Specific Book

CREATE PROCEDURE sp_report_book_order_count(IN p_ISBN VARCHAR(20))
BEGIN
    SELECT 
        b.ISBN,
        b.title,
        b.category,
        COUNT(s.order_id) AS total_orders_placed,
        SUM(s.quantity) AS total_quantity_ordered,
        SUM(CASE WHEN s.status = 'Confirmed' THEN s.quantity ELSE 0 END) AS confirmed_quantity,
        SUM(CASE WHEN s.status = 'Pending' THEN s.quantity ELSE 0 END) AS pending_quantity,
        MIN(s.date) AS first_order_date,
        MAX(s.date) AS last_order_date
    FROM book b
    LEFT JOIN supply s ON b.ISBN = s.ISBN
    WHERE b.ISBN = p_ISBN
    GROUP BY b.ISBN, b.title, b.category;
END//


-- ADDITIONAL REPORTS


-- Report: Low Stock Alert
CREATE PROCEDURE sp_report_low_stock()
BEGIN
    SELECT 
        b.ISBN,
        b.title,
        b.category,
        s.quantity AS current_stock,
        s.threshold AS reorder_threshold,
        (s.threshold - s.quantity) AS shortage,
        p.name AS publisher_name,
        p.phone AS publisher_phone
    FROM book b
    JOIN stock s ON b.ISBN = s.ISBN
    JOIN publisher p ON b.pub_id = p.pub_id
    WHERE s.quantity < s.threshold
    ORDER BY shortage DESC, s.quantity ASC;
END//

-- Report: Pending Orders
CREATE PROCEDURE sp_report_pending_orders()
BEGIN
    SELECT 
        s.order_id,
        s.ISBN,
        b.title,
        b.category,
        p.name AS publisher_name,
        p.phone AS publisher_phone,
        s.quantity AS ordered_quantity,
        s.date AS order_date,
        DATEDIFF(CURDATE(), s.date) AS days_pending
    FROM supply s
    JOIN book b ON s.ISBN = b.ISBN
    JOIN publisher p ON s.pub_id = p.pub_id
    WHERE s.status = 'Pending'
    ORDER BY days_pending DESC, s.date;
END//

-- Report: Sales by Category (Date Range)
CREATE PROCEDURE sp_report_sales_by_category(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT 
        b.category,
        COUNT(DISTINCT p.pur_id) AS number_of_sales,
        SUM(p.quantity) AS total_books_sold,
        SUM(p.amount) AS total_revenue,
        AVG(p.amount) AS average_transaction,
        COUNT(DISTINCT p.cust_id) AS unique_customers
    FROM purchases p
    JOIN book b ON p.ISBN = b.ISBN
    WHERE p.date BETWEEN p_start_date AND p_end_date
    GROUP BY b.category
    ORDER BY total_revenue DESC;
END//

-- Report: Monthly Sales Summary
CREATE PROCEDURE sp_report_monthly_summary(
    IN p_year INT,
    IN p_month INT
)
BEGIN
    SELECT 
        DATE(date) AS sale_date,
        DAYNAME(date) AS day_of_week,
        COUNT(DISTINCT cust_id) AS unique_customers,
        COUNT(DISTINCT pur_id) AS total_transactions,
        SUM(quantity) AS books_sold,
        SUM(amount) AS daily_revenue,
        AVG(amount) AS average_transaction
    FROM purchases
    WHERE YEAR(date) = p_year AND MONTH(date) = p_month
    GROUP BY DATE(date), DAYNAME(date)
    ORDER BY DATE(date);
    
    -- Monthly totals
    SELECT 
        'MONTHLY TOTAL' AS summary,
        COUNT(DISTINCT cust_id) AS unique_customers,
        COUNT(DISTINCT pur_id) AS total_transactions,
        SUM(quantity) AS books_sold,
        SUM(amount) AS total_revenue,
        AVG(amount) AS average_transaction
    FROM purchases
    WHERE YEAR(date) = p_year AND MONTH(date) = p_month;
END//

-- Report: Customer Purchase History
CREATE PROCEDURE sp_report_customer_history(IN p_cust_id INT)
BEGIN
    SELECT 
        c.username,
        CONCAT(c.fname, ' ', c.lname) AS customer_name,
        p.pur_id AS order_id,
        p.date AS order_date,
        b.ISBN,
        b.title,
        b.category,
        p.quantity,
        b.selling_price AS unit_price,
        p.amount AS total_amount
    FROM customer c
    JOIN purchases p ON c.cust_id = p.cust_id
    JOIN book b ON p.ISBN = b.ISBN
    WHERE c.cust_id = p_cust_id
    ORDER BY p.date DESC, p.pur_id DESC;
    
    -- Customer summary
    SELECT 
        COUNT(DISTINCT pur_id) AS total_orders,
        SUM(quantity) AS total_books,
        SUM(amount) AS total_spent,
        AVG(amount) AS average_order_value,
        MIN(date) AS first_purchase,
        MAX(date) AS last_purchase
    FROM purchases
    WHERE cust_id = p_cust_id;
END//

-- Report: Revenue by Publisher
CREATE PROCEDURE sp_report_publisher_revenue(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT 
        p.pub_id,
        p.name AS publisher_name,
        p.phone AS publisher_phone,
        COUNT(DISTINCT b.ISBN) AS books_in_catalog,
        COUNT(DISTINCT pu.pur_id) AS total_sales,
        SUM(pu.quantity) AS books_sold,
        SUM(pu.amount) AS total_revenue,
        AVG(pu.amount) AS average_sale_amount
    FROM publisher p
    LEFT JOIN book b ON p.pub_id = b.pub_id
    LEFT JOIN purchases pu ON b.ISBN = pu.ISBN 
        AND pu.date BETWEEN p_start_date AND p_end_date
    GROUP BY p.pub_id, p.name, p.phone
    ORDER BY total_revenue DESC;
END//

-- Report: Books Never Sold
CREATE PROCEDURE sp_report_unsold_books()
BEGIN
    SELECT 
        b.ISBN,
        b.title,
        b.category,
        b.pub_year,
        b.selling_price,
        GROUP_CONCAT(a.name SEPARATOR ', ') AS authors,
        p.name AS publisher,
        s.quantity AS stock,
        DATEDIFF(CURDATE(), DATE_ADD(CONCAT(b.pub_year, '-01-01'), INTERVAL 0 DAY)) AS days_in_catalog
    FROM book b
    LEFT JOIN purchases pu ON b.ISBN = pu.ISBN
    LEFT JOIN written_by wb ON b.ISBN = wb.ISBN
    LEFT JOIN author a ON wb.author_id = a.author_id
    JOIN publisher p ON b.pub_id = p.pub_id
    JOIN stock s ON b.ISBN = s.ISBN
    WHERE pu.pur_id IS NULL
    GROUP BY b.ISBN, b.title, b.category, b.pub_year, b.selling_price, p.name, s.quantity
    ORDER BY b.pub_year, b.title;
END//

-- Report: Stock Movement Analysis
CREATE PROCEDURE sp_report_stock_movement()
BEGIN
    SELECT 
        b.ISBN,
        b.title,
        b.category,
        s.quantity AS current_stock,
        s.threshold,
        COALESCE(SUM(pu.quantity), 0) AS total_sold_all_time,
        COALESCE(SUM(sup.quantity), 0) AS total_ordered_all_time,
        COALESCE(SUM(CASE WHEN sup.status = 'Confirmed' THEN sup.quantity ELSE 0 END), 0) AS total_received,
        (s.quantity + COALESCE(SUM(pu.quantity), 0) - COALESCE(SUM(CASE WHEN sup.status = 'Confirmed' THEN sup.quantity ELSE 0 END), 0)) AS calculated_initial_stock
    FROM book b
    JOIN stock s ON b.ISBN = s.ISBN
    LEFT JOIN purchases pu ON b.ISBN = pu.ISBN
    LEFT JOIN supply sup ON b.ISBN = sup.ISBN
    GROUP BY b.ISBN, b.title, b.category, s.quantity, s.threshold
    ORDER BY total_sold_all_time DESC;
END//

DELIMITER ;