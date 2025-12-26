const express = require('express');
const cors = require('cors');
const app = express();
const port = 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Routes
const authRoutes = require('./routes/auth.js');
const bookRoutes = require('./routes/book.js');
const cartRoutes = require('./routes/cart.js');
const adminRoutes = require('./routes/admin.js');
const stockRoutes = require('./routes/stockRoutes.js');
const publisherRoutes = require('./routes/publisherRoutes.js');
const authorRoutes = require('./routes/authorRoutes.js');
const customerRoutes = require('./routes/customer.js');
// Use routes
app.use('/api/auth', authRoutes);
app.use('/api/books', bookRoutes);
app.use('/api/cart', cartRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/stock', stockRoutes);
app.use('/api/publishers', publisherRoutes);
app.use('/api/authors', authorRoutes);
app.use('/api/customer', customerRoutes);
// Start server
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});

