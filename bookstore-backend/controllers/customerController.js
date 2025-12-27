const db = require('../db/connection');
const bcrypt = require('bcryptjs');

exports.updateProfile = async (req, res) => {
  const { cust_id } = req.params;
  const { email, phone, address, password } = req.body;

  try {
    let hashedPassword = null;
    if (password && password.trim() !== '') {
      hashedPassword = await bcrypt.hash(password, 10);
    }

    const fields = [];
    const values = [];

    if (email) {
      fields.push("email = ?");
      values.push(email);
    }
    if (phone) {
      fields.push("phone = ?");
      values.push(phone);
    }
    if (address) {
      fields.push("address = ?");
      values.push(address);
    }
    if (hashedPassword) {
      fields.push("password = ?");
      values.push(hashedPassword);
    }

    if (fields.length === 0) {
      return res.status(400).json({ error: "No fields to update" });
    }

    values.push(cust_id);

    const query = `UPDATE customer SET ${fields.join(", ")} WHERE cust_id = ?`;

    db.query(query, values, (err) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ message: "Profile updated successfully" });
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
