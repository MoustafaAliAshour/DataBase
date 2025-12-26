const express = require('express');
const db = require('../db/connection');
const router = express.Router();


// 1. Get stock by ISBN

router.get('/:isbn', async (req, res) => {
  const { isbn } = req.params;
  try {
    const [stock] = await db.execute("SELECT * FROM stock WHERE ISBN=?", [isbn]);
    if (stock.length === 0) return res.status(404).json({ error: "Stock not found" });
    res.json(stock[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// 2. Update stock quantity (admin)

router.put('/:isbn', async (req, res) => {
  const { isbn } = req.params;
  const { quantity } = req.body;
  try {
    const [stock] = await db.execute("SELECT quantity, threshold FROM stock WHERE ISBN=?", [isbn]);
    if (stock.length === 0) return res.status(404).json({ error: "Stock not found" });

    const newQuantity = stock[0].quantity + quantity;
    if (newQuantity < 0) return res.status(400).json({ error: "Quantity cannot be negative" });

    await db.execute("UPDATE stock SET quantity=? WHERE ISBN=?", [newQuantity, isbn]);

    // Check threshold to create automatic supply order
    if (newQuantity < stock[0].threshold) {
      const orderQuantity = 10; // predefined constant order quantity
      await db.execute(
        "INSERT INTO supply (ISBN, pub_id, quantity, date, status) SELECT ISBN, pub_id, ?, NOW(), 'Pending' FROM book WHERE ISBN=?",
        [orderQuantity, isbn]
      );
    }

    res.json({ message: "Stock updated successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
