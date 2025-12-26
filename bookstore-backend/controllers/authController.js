const db = require('../db/connection');
const bcrypt = require('bcryptjs');

exports.register = async (req, res) => {
  const { username, password, fname, lname, email, phone, address, role } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    await db.execute(
      `INSERT INTO customer (username, password, fname, lname, email, phone, address, role)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [username, hashedPassword, fname, lname, email, phone, address, role || 'customer']
    );
    res.json({ message: 'Registration successful' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.login = async (req, res) => {
  const { username, password } = req.body;
  try {
    const [users] = await db.execute(`SELECT * FROM customer WHERE username = ?`, [username]);
    if (users.length === 0) return res.status(400).json({ error: 'Invalid username or password' });

    const user = users[0];
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ error: 'Invalid username or password' });

    res.json({
      message: 'Login successful',
      user: {
        cust_id: user.cust_id,
        username: user.username,
        fname: user.fname,
        role: user.role
      }
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
