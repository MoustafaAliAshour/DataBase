const express = require("express");
const db = require("../db/connection");
const router = express.Router();

// Helper function to convert execute result to usable data
const executeQuery = (query, params) => {
  return new Promise((resolve, reject) => {
    db.execute(query, params, (err, results, fields) => {
      if (err) return reject(err);
      resolve([results, fields]);
    });
  });
};

// 1️⃣ Get cart items for a customer
router.get("/:cust_id", async (req, res) => {
  const { cust_id } = req.params;
  if (!cust_id) return res.status(400).json({ error: "Missing customer ID" });

  try {
    const [rows] = await executeQuery(
      `SELECT c.ISBN, b.title, c.quantity, (c.quantity * b.selling_price) AS amount
       FROM consists_of c
       JOIN book b ON c.ISBN = b.ISBN
       JOIN cart ca ON ca.cart_id = c.cart_id
       WHERE ca.cust_id = ?`,
      [cust_id]
    );

    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

// 2️⃣ Add book to cart
router.post("/add", async (req, res) => {
  const { cust_id, ISBN, quantity } = req.body;
  
  if (!cust_id || !ISBN || !quantity) {
    return res.status(400).json({ error: "Missing cust_id, ISBN or quantity" });
  }

  try {
    const [cartRows] = await executeQuery(
      "SELECT cart_id FROM cart WHERE cust_id = ?", 
      [cust_id]
    );

    let cart_id;
    
    if (cartRows.length === 0) {
      const [result] = await executeQuery(
        "INSERT INTO cart (cust_id) VALUES (?)", 
        [cust_id]
      );
      
      cart_id = result.insertId;
      
      if (!cart_id) {
        return res.status(500).json({ error: "Failed to create cart" });
      }
    } else {
      cart_id = cartRows[0].cart_id;
    }

    await executeQuery(
      `INSERT INTO consists_of (cart_id, ISBN, quantity) 
       VALUES (?, ?, ?)
       ON DUPLICATE KEY UPDATE quantity = quantity + ?`,
      [cart_id, ISBN, quantity, quantity]
    );

    res.json({ message: "Book added to cart" });
  } catch (err) {
    console.error("Error in /cart/add:", err);
    res.status(500).json({ error: err.message });
  }
});

// 3️⃣ Remove item from cart
router.post("/remove", async (req, res) => {
  const { cust_id, ISBN } = req.body;
  if (!cust_id || !ISBN) return res.status(400).json({ error: "Missing required fields" });

  try {
    const [cartRows] = await executeQuery(
      "SELECT cart_id FROM cart WHERE cust_id = ?", 
      [cust_id]
    );
    
    if (cartRows.length === 0) {
      return res.status(400).json({ error: "Cart not found" });
    }

    const cart_id = cartRows[0].cart_id;
    await executeQuery(
      "DELETE FROM consists_of WHERE cart_id = ? AND ISBN = ?", 
      [cart_id, ISBN]
    );

    res.json({ message: "Item removed from cart" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

// 4️⃣ Confirm purchase (checkout)
router.post("/confirm", async (req, res) => {
  const { cust_id } = req.body;
  if (!cust_id) return res.status(400).json({ error: "Missing customer ID" });

  try {
    const [cartRows] = await executeQuery(
      "SELECT cart_id FROM cart WHERE cust_id = ?", 
      [cust_id]
    );
    
    if (cartRows.length === 0) {
      return res.status(400).json({ error: "Cart not found" });
    }

    const cart_id = cartRows[0].cart_id;

    const [items] = await executeQuery(
      "SELECT * FROM consists_of WHERE cart_id = ?", 
      [cart_id]
    );

    for (const item of items) {
      const [bookData] = await executeQuery(
        "SELECT selling_price FROM book WHERE ISBN = ?", 
        [item.ISBN]
      );
      
      const selling_price = bookData[0]?.selling_price || 0;

      await executeQuery(
        "INSERT INTO purchases (cust_id, ISBN, date, quantity, amount) VALUES (?, ?, NOW(), ?, ?)",
        [cust_id, item.ISBN, item.quantity, item.quantity * selling_price]
      );

      await executeQuery(
        "UPDATE stock SET quantity = quantity - ? WHERE ISBN = ?", 
        [item.quantity, item.ISBN]
      );
    }

    await executeQuery("DELETE FROM consists_of WHERE cart_id = ?", [cart_id]);

    res.json({ message: "Purchase confirmed" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

// 5️⃣ Logout (clear cart)
router.post("/logout", async (req, res) => {
  const { cust_id } = req.body;
  if (!cust_id) return res.status(400).json({ error: "Missing customer ID" });

  try {
    const [cartRows] = await executeQuery(
      "SELECT cart_id FROM cart WHERE cust_id = ?", 
      [cust_id]
    );

    if (cartRows.length > 0) {
      await executeQuery(
        "DELETE FROM consists_of WHERE cart_id = ?", 
        [cartRows[0].cart_id]
      );
    }

    res.json({ message: "Logged out and cart cleared" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;