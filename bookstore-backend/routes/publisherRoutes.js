const express = require('express');
const router = express.Router();
const publisherController = require('../controllers/publisherController');

// GET all publishers
router.get('/', publisherController.getAllPublishers);

// GET publisher by ID
router.get('/:id', publisherController.getPublisherById);

// POST create new publisher
router.post('/', async (req, res) => {
  const { name, address, phone } = req.body;
  if (!name) return res.status(400).json({ error: "Publisher name is required" });
  
  try {
    const result = await publisherController.createPublisher({ name, address, phone });
    res.json({ message: "Publisher created", publisherId: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// PUT update publisher by ID
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { name, address, phone } = req.body;

  if (!name) return res.status(400).json({ error: "Publisher name is required" });

  try {
    await publisherController.updatePublisher(id, { name, address, phone });
    res.json({ message: "Publisher updated" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// DELETE publisher by ID (admin only)
router.delete('/:id', async (req, res) => {
  const { id } = req.params;

  try {
    await publisherController.deletePublisher(id);
    res.json({ message: "Publisher deleted" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
