const express = require('express');
const router = express.Router();
const customerController = require('../controllers/customerController');

// Update profile
router.put('/profile/:cust_id', customerController.updateProfile);

module.exports = router; 