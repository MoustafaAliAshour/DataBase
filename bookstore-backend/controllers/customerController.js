const db = require('../db/connection');
const bcrypt = require('bcryptjs');

// Update customer profile (email, phone, address, password)
exports.updateProfile = async (req, res) => {
  const { cust_id } = req.params;
  const { email, phone, address, password } = req.body;

  try {
    // Hash the password if it is being updated
    let hashedPassword = null;
    if (password) {
      hashedPassword = await bcrypt.hash(password, 10);
    }

    // Build the update query dynamically
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
    await db.execute(query, values);

    res.json({ message: "Profile updated successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
