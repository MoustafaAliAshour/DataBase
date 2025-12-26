const express = require("express");
const db = require('../db/connection');
const router = express.Router();


// 1. Get all books

router.get("/", async (req, res) => {
  try {
    const [books] = await db.execute("SELECT * FROM vw_book_details");
    res.json(books);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// 2. Search books by title, category, author, publisher

router.get("/search", async (req, res) => {
  const { search } = req.query;
  try {
    const [books] = await db.execute(
      `SELECT * FROM vw_book_details WHERE title LIKE ? OR category LIKE ? OR authors LIKE ? OR publisher_name LIKE ?`,
      [`%${search}%`, `%${search}%`, `%${search}%`, `%${search}%`]
    );
    res.json(books);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// 3. Admin: Add new book

router.post("/add", async (req, res) => {
  const { ISBN, title, pub_year, selling_price, category, pub_id, threshold } = req.body;
  try {
    await db.execute(
      `INSERT INTO book (ISBN, title, pub_year, selling_price, category, pub_id) VALUES (?, ?, ?, ?, ?, ?)`,
      [ISBN, title, pub_year, selling_price, category, pub_id]
    );
    await db.execute(
      `INSERT INTO stock (ISBN, quantity, threshold) VALUES (?, 0, ?)`,
      [ISBN, threshold]
    );
    res.json({ message: "Book added successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// 4. Admin: Modify existing book

router.put("/update/:ISBN", async (req, res) => {
  const { ISBN } = req.params;
  const { title, pub_year, selling_price, category, pub_id, quantity, threshold } = req.body;

  try {
    // Update book info
    await db.execute(
      `UPDATE book SET title=?, pub_year=?, selling_price=?, category=?, pub_id=? WHERE ISBN=?`,
      [title, pub_year, selling_price, category, pub_id, ISBN]
    );

    // Update stock quantity and threshold
    if (quantity !== undefined || threshold !== undefined) {
      const [stock] = await db.execute("SELECT quantity FROM stock WHERE ISBN=?", [ISBN]);
      const newQuantity = quantity !== undefined ? quantity : stock[0].quantity;
      if (newQuantity < 0) return res.status(400).json({ error: "Quantity cannot be negative" });

      await db.execute(
        "UPDATE stock SET quantity=?, threshold=? WHERE ISBN=?",
        [newQuantity, threshold || stock[0].threshold, ISBN]
      );
    }

    res.json({ message: "Book updated successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
