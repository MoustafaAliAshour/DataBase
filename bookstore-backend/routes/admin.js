const express = require("express");
const db = require('../db/connection');
const router = express.Router();

// Add new book
router.post("/add-book", async (req, res) => {
  const { ISBN, title, pub_year, selling_price, category, pub_id, threshold } = req.body;
  try {
    await db.execute("INSERT INTO book (ISBN, title, pub_year, selling_price, category, pub_id) VALUES (?, ?, ?, ?, ?, ?)", [ISBN, title, pub_year, selling_price, category, pub_id]);
    await db.execute("INSERT INTO stock (ISBN, quantity, threshold) VALUES (?, 0, ?)", [ISBN, threshold]);
    res.json({ message: "Book added successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Modify book quantity
router.post("/modify-book", async (req, res) => {
  const { ISBN, quantity } = req.body;
  try {
    const [book] = await db.execute("SELECT quantity FROM stock WHERE ISBN = ?", [ISBN]);
    if (book[0].quantity + quantity < 0) return res.status(400).json({ error: "Stock cannot be negative" });
    await db.execute("UPDATE stock SET quantity = quantity + ? WHERE ISBN = ?", [quantity, ISBN]);
    res.json({ message: "Book updated" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;

