const db = require('../db/connection');

exports.getAllAuthors = async (req, res) => {
  try {
    const [authors] = await db.execute('SELECT * FROM author');
    res.json(authors);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getAuthorById = async (req, res) => {
  const { id } = req.params;
  try {
    const [author] = await db.execute('SELECT * FROM author WHERE author_id = ?', [id]);
    res.json(author);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.createAuthor = async (req, res) => {
  const { name } = req.body;
  try {
    await db.execute('INSERT INTO author (name) VALUES (?)', [name]);
    res.json({ message: 'Author created' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
