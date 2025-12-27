const express = require("express");
const bcrypt = require('bcryptjs');
const jwt = require("jsonwebtoken");
const db = require('../db/connection');
const router = express.Router();

// Register
router.post("/register", (req, res) => {
  const { username, password, fname, lname, email, phone, address } = req.body;

  bcrypt.hash(password, 10, (err, hash) => {
    if (err) return res.status(500).json({ error: err.message });

    const query = `
      INSERT INTO customer (username, password, fname, lname, email, phone, address, role)
      VALUES (?, ?, ?, ?, ?, ?, ?, 'customer')
    `;

    db.query(query, [username, hash, fname, lname, email, phone, address], (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ message: "Registration successful", cust_id: results.insertId });
    });
  });
});

// Login
router.post("/login", (req, res) => {
  console.log("Login request received with body:", req.body);
  const { username, password } = req.body;


  db.query("SELECT * FROM customer WHERE username = ?", [username], async (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    if (rows.length === 0) return res.status(400).json({ error: "User not found" });

    const user = rows[0];
    const match = await bcrypt.compare(password, user.password);
    if (!match) return res.status(400).json({ error: "Incorrect password" });

    const token = jwt.sign({ cust_id: user.cust_id, role: user.role, fname: user.fname }, "SECRET_KEY");
    res.json({ token, user: { cust_id: user.cust_id, role: user.role, fname: user.fname } });
  });
});

module.exports = router;
