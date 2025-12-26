import { useEffect, useState } from "react";
import "../styles/Home.css";

const Home = ({ user }) => {
  const [books, setBooks] = useState([]);
  const [search, setSearch] = useState("");

  useEffect(() => {
    fetchBooks();
  }, []);

  const fetchBooks = async () => {
    const res = await fetch("http://localhost:5000/api/books");
    const data = await res.json();
    setBooks(data);
  };

  const handleSearch = async (e) => {
    e.preventDefault();
    const res = await fetch(`http://localhost:5000/api/books?search=${search}`);
    const data = await res.json();
    setBooks(data);
  };

  const addToCart = async (isbn) => {
    const res = await fetch("http://localhost:5000/api/cart/add", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ cust_id: user.cust_id, ISBN: isbn, quantity: 1 }),
    });
    const data = await res.json();
    alert(data.message);
  };

  return (
    <div className="home-container">
      <h2>Welcome, {user.fname}!</h2>

      <form onSubmit={handleSearch} className="search-form">
        <input
          type="text"
          placeholder="Search by title, category, author, or publisher..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />
        <button type="submit">Search</button>
      </form>

      {user.role === "admin" && (
        <div className="admin-actions">
          <button onClick={() => alert("Navigate to Add Book Page")}>Add New Book</button>
          <button onClick={() => alert("Navigate to Modify Book Page")}>Modify Book</button>
        </div>
      )}

      <div className="books-grid">
        {books.map((book) => (
          <div key={book.ISBN} className="book-card">
            <h3>{book.title}</h3>
            <p><b>Authors:</b> {book.authors}</p>
            <p><b>Category:</b> {book.category}</p>
            <p><b>Price:</b> ${book.selling_price}</p>
            <p><b>Status:</b> {book.stock_status}</p>
            {user.role === "customer" && (
              <button onClick={() => addToCart(book.ISBN)}>Add to Cart</button>
            )}
          </div>
        ))}
      </div>
    </div>
  );
};

export default Home;
