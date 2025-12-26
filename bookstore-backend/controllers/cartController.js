const db = require('../db/connection');


exports.getCartItems = async (req, res) => {
  const { cust_id } = req.params;
  try {
    const [items] = await db.execute(
      `SELECT c.ISBN, b.title, c.quantity, (c.quantity * b.selling_price) AS amount
       FROM consists_of c
       JOIN book b ON c.ISBN = b.ISBN
       JOIN cart ca ON ca.cart_id = c.cart_id
       WHERE ca.cust_id = ?`,
      [cust_id]
    );
    res.json(items);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.addToCart = async (req, res) => {
  const { cust_id, ISBN, quantity } = req.body;
  try {
    const [cart] = await db.execute('SELECT cart_id FROM cart WHERE cust_id = ?', [cust_id]);
    let cart_id;
    if (cart.length === 0) {
      const [newCart] = await db.execute('INSERT INTO cart (cust_id) VALUES (?)', [cust_id]);
      cart_id = newCart.insertId;
    } else {
      cart_id = cart[0].cart_id;
    }
    await db.execute(
      'INSERT INTO consists_of (cart_id, ISBN, quantity) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE quantity = quantity + ?',
      [cart_id, ISBN, quantity, quantity]
    );
    res.json({ message: 'Book added to cart' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.removeFromCart = async (req, res) => {
  const { cust_id, ISBN } = req.body;
  try {
    const [cart] = await db.execute('SELECT cart_id FROM cart WHERE cust_id = ?', [cust_id]);
    if (cart.length === 0) return res.status(400).json({ error: 'Cart not found' });
    await db.execute('DELETE FROM consists_of WHERE cart_id = ? AND ISBN = ?', [cart[0].cart_id, ISBN]);
    res.json({ message: 'Item removed' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.confirmPurchase = async (req, res) => {
  const { cust_id } = req.body;
  try {
    const [cart] = await db.execute('SELECT cart_id FROM cart WHERE cust_id = ?', [cust_id]);
    if (cart.length === 0) return res.status(400).json({ error: 'Cart not found' });

    const cart_id = cart[0].cart_id;
    const [items] = await db.execute('SELECT * FROM consists_of WHERE cart_id = ?', [cart_id]);

    for (const item of items) {
      const [book] = await db.execute('SELECT selling_price FROM book WHERE ISBN = ?', [item.ISBN]);
      const amount = item.quantity * book[0].selling_price;

      await db.execute(
        'INSERT INTO purchases (cust_id, ISBN, date, quantity, amount) VALUES (?, ?, NOW(), ?, ?)',
        [cust_id, item.ISBN, item.quantity, amount]
      );
      await db.execute('UPDATE stock SET quantity = quantity - ? WHERE ISBN = ?', [item.quantity, item.ISBN]);
    }

    await db.execute('DELETE FROM consists_of WHERE cart_id = ?', [cart_id]);
    res.json({ message: 'Purchase confirmed' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

