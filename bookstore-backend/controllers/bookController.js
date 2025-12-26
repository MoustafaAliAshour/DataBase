const db = require('../db/connection');

exports.getAllBooks = async (req, res) => {
  try {
    const [books] = await db.execute('SELECT * FROM vw_book_details');
    res.json(books);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.searchBooks = async (req, res) => {
  const { search } = req.query;
  try {
    const [books] = await db.execute(
      `SELECT * FROM vw_book_details WHERE title LIKE ? OR category LIKE ? OR authors LIKE ? OR publisher_name LIKE ?`,
      [`%${search}%`, `%${search}%`, `%${search}%`, `%${search}%`]
    );
    res.json(books);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
