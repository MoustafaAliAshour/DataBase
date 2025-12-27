import { useEffect, useState } from "react";
import "../styles/Home.css";

const Home = ({ user }) => {
  const [books, setBooks] = useState([]);
  const [search, setSearch] = useState("");

  useEffect(() => {
    fetchBooks();
  }, []);
useEffect(() => {
  console.log("User object:", user);
  console.log("Customer ID:", user?.cust_id);
}, [user]);
const fetchBooks = async () => {
    try {
      const res = await fetch("http://localhost:5000/api/books");
      const data = await res.json();
      

      // Only set books if data is an array
      if (Array.isArray(data)) {
        setBooks(data);
      } else {
        console.error("API returned an error:", data);
        setBooks([]); // Set empty array to prevent crash
      }
    } catch (err) {
      console.error("Network error:", err);
    }
  };

  const handleSearch = async (e) => {
    e.preventDefault();
    try {
      const res = await fetch(`http://localhost:5000/api/books/search?search=${search}`);
      const data = await res.json();
      // console.log("Fetched data:", data); // Check console to see what is returned
      
      if (Array.isArray(data)) {
        setBooks(data);
      } else {
        console.error("Search API returned an error:", data);
        setBooks([]);
      }
    } catch (err) {
      console.error("Search failed:", err);
    }
  };

  const addToCart = async (isbn) => {
  // More robust validation
  if (!user) {
    alert("Please log in first!");
    return;
  }
  
  if (!user.cust_id) {
    alert("Customer ID is missing. Please log in again.");
    console.error("User object:", user);
    return;
  }

  if (!isbn) {
    alert("Book ISBN is missing!");
    return;
  }

  console.log("Full request body:", JSON.stringify({ 
  cust_id: user.cust_id, 
  ISBN: isbn, 
  quantity: 1 
}));

  try {
    const res = await fetch("http://localhost:5000/api/cart/add", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ 
        cust_id: user.cust_id, 
        ISBN: isbn, 
        quantity: 1 
      }),
    });

    const data = await res.json();
    if (res.ok) {
      alert(data.message);
    } else {
      alert("Failed to add to cart: " + data.error);
      console.error("Server error:", data);
    }
  } catch (err) {
    console.error("Error adding to cart:", err);
    alert("Network error adding to cart");
  }
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
              <button onClick={() => {
  console.log("Adding to cart:", book.ISBN, user?.cust_id);
  addToCart(book.ISBN);
}}>Add to Cart</button>

            )}
          </div>
        ))}
      </div>
    </div>
  );
};

export default Home;



