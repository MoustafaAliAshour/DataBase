const express = require('express');
const router = express.Router();
const authorController = require('../controllers/authorController');

// GET all authors
router.get('/', authorController.getAllAuthors);

// GET author by ID
router.get('/:id', authorController.getAuthorById);

// POST create new author
router.post('/', authorController.createAuthor);

module.exports = router;
