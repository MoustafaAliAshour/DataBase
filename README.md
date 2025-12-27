# 📚 Online Bookstore Management System

Full-stack e-commerce platform with automated inventory, secure auth, and business intelligence.

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- MySQL 8.0+
- npm

### Installation

**1. Database Setup**
```bash
mysql -u root -p
source schema.sql
source sample_data.sql
source triggers.sql
source reports.sql
```

**2. Backend**
```bash
cd bookstore-backend
npm install
# Edit db/connection.js with your MySQL password
npm run dev
```

**3. Frontend**
```bash
cd bookstore-frontend
npm install
npm start
```

**4. Access**
- Frontend: http://localhost:3000
- Backend: http://localhost:5000
- Login: username: `john_doe`, password: `pass123`

## 📁 Project Structure
```
DataBase/
├── schema.sql              # Database structure
├── sample_data.sql         # 150 books, 50 customers
├── triggers.sql            # 5 automated triggers
├── reports.sql             # 10 BI reports
└── ERD.png                 # Database diagram

bookstore-backend/
├── config/                 # Database config
├── controllers/            # Business logic
├── routes/                 # API endpoints
└── server.js              # Entry point

bookstore-frontend/
├── src/
│   ├── components/        # React components
│   ├── styles/           # CSS files
│   └── App.js           # Main app
└── public/
```

## ⚡ Features

### Customer
- 🔍 Search 150+ books (title/author/category)
- 🛒 Shopping cart with real-time total
- 💳 Secure checkout
- 👤 Profile management

### Admin
- ➕ Add/modify books
- 📦 Inventory management
- 📊 10 sales reports
- ⚠️ Low stock alerts

### Automated
- 🔄 Auto-reorder at threshold
- ✅ Auto stock updates
- 🛡️ Negative stock prevention

## 🗄️ Database

**10 Tables**: BOOK, AUTHOR, PUBLISHER, STOCK, CUSTOMER, CART, PURCHASES, SUPPLY, written_by, consists_of

**5 Triggers**: Auto-reorder, stock validation, cart creation

**13 Procedures**: Search, cart ops, admin functions

**10 Reports**: Sales, customers, bestsellers, inventory

## 🔐 Security

- ✅ bcrypt password hashing (10 rounds)
- ✅ JWT authentication
- ✅ SQL injection prevention
- ✅ Role-based access control
- ✅ Input validation

## 🛠️ Tech Stack

- **Frontend**: React, React Router
- **Backend**: Node.js, Express.js
- **Database**: MySQL 8.0
- **Auth**: JWT, bcrypt
- **API**: RESTful

## 📊 Sample Data

- 150 books (Science, Art, Religion, History, Geography)
- 100 authors (Hawking, Sagan, Picasso, etc.)
- 30 publishers (Penguin, Oxford, etc.)
- 50 customers with 500+ transactions

## 🔗 API Endpoints
```
POST   /api/auth/register      - User registration
POST   /api/auth/login         - Login with JWT
GET    /api/books              - All books
GET    /api/books/search       - Search books
POST   /api/books/add          - Add book (admin)
GET    /api/cart/:cust_id      - View cart
POST   /api/cart/add           - Add to cart
POST   /api/cart/confirm       - Checkout
PUT    /api/customer/profile   - Update profile
```

## 🧪 Testing

1. Register new user
2. Login and browse books
3. Add books to cart
4. Complete checkout
5. Verify stock decreased
6. Check auto-reorder (if below threshold)

## 🐛 Troubleshooting

**Connection Error**: Check MySQL credentials in `db/connection.js`
**Port Conflict**: Change ports in `server.js` (backend) or `.env` (frontend)
**Missing Modules**: Run `npm install` in both directories

## 📈 Business Reports

Access via MySQL:
```sql
CALL sp_report_previous_month_sales();
CALL sp_report_top_customers();
CALL sp_report_top_books();
CALL sp_report_low_stock();
```

## 🎯 Future Enhancements

- [ ] Book reviews & ratings
- [ ] Advanced filters (price, year)
- [ ] Email notifications
- [ ] Payment gateway integration
- [ ] Mobile app
- [ ] Recommendation engine

## 📄 License

MIT License

## 👤 Author

**Moustafa Ashour** - Database Course Project

## 🙏 Acknowledgments

Built with MySQL, Express, React, Node.js (MERN Stack)

---

**⭐ Star this repo if you found it helpful!**
