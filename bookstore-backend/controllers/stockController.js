const db = require('../db/connection');

exports.getStockByISBN = async (req, res) => {
  const { isbn } = req.params;
  try {
    const [stock] = await db.execute('SELECT * FROM stock WHERE ISBN = ?', [isbn]);
    res.json(stock);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.updateStock = async (req, res) => {
  const { isbn } = req.params;
  const { quantity } = req.body;
  try {
    await db.execute('UPDATE stock SET quantity = ? WHERE ISBN = ?', [quantity, isbn]);
    res.json({ message: 'Stock updated' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
