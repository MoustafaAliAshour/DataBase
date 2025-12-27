const express = require('express');
const router = express.Router();
const customerController = require('../controllers/customerController');
const db = require('../db/connection'); 


// Get customer profile
router.get('/:cust_id', (req, res) => {
  const { cust_id } = req.params;

  db.query(
    'SELECT cust_id, username, fname, lname, email, phone, address, role FROM customer WHERE cust_id = ?',
    [cust_id],
    (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      if (results.length === 0) return res.status(404).json({ error: 'Customer not found' });

      res.json(results[0]);
    }
  );
});

// Update customer profile
router.put('/:cust_id', customerController.updateProfile);

module.exports = router;
