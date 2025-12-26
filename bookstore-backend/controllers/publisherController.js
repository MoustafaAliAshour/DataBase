const db = require('../db/connection');


exports.getAllPublishers = async (req, res) => {
  try {
    const [publishers] = await db.execute('SELECT * FROM publisher');
    res.json(publishers);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getPublisherById = async (req, res) => {
  const { id } = req.params;
  try {
    const [publisher] = await db.execute('SELECT * FROM publisher WHERE pub_id = ?', [id]);
    res.json(publisher);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.createPublisher = async (req, res) => {
  const { name, address, phone } = req.body;
  try {
    await db.execute('INSERT INTO publisher (name, address, phone) VALUES (?, ?, ?)', [name, address, phone]);
    res.json({ message: 'Publisher created' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
