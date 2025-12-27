import { useState } from "react";
import "../styles/BookList.css"; // Reusing the same CSS for consistent design

const ModifyBook = ({ token }) => {
  const [isbnSearch, setIsbnSearch] = useState("");
  const [isFound, setIsFound] = useState(false);

  const [form, setForm] = useState({
    title: "",
    author_id: "", // Display only, typically hard to update in simple form due to M:N relation
    category: "",
    pub_id: "",
    pub_year: "",
    selling_price: "",
    threshold: "",
    quantity: "" // Added quantity as the backend update route handles stock
  });

  // Step 1: Search for the book by ISBN
  const handleSearch = async (e) => {
    e.preventDefault();
    if (!isbnSearch) {
      alert("Please enter an ISBN to search");
      return;
    }

    try {
      // Assuming a GET route exists: /api/books/:ISBN 
      // If your search route is different, update this URL
      const res = await fetch(`http://localhost:5000/api/books/${isbnSearch}`, {
        headers: { ...(token ? { Authorization: `Bearer ${token}` } : {}) }
      });
      const data = await res.json();

      if (res.ok && data) {
        setForm({
          title: data.title || "",
          author_id: data.authors ? data.authors.join(", ") : "", // Handle array if necessary
          category: data.category || "",
          pub_id: data.pub_id || "",
          pub_year: data.pub_year || "",
          selling_price: data.selling_price || "",
          threshold: data.threshold || "",
          quantity: data.quantity || ""
        });
        setIsFound(true);
      } else {
        alert("Book not found");
        setIsFound(false);
      }
    } catch (err) {
      console.error(err);
      alert("Error searching for book");
    }
  };

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const validate = () => {
    // Basic validation, ensure required fields aren't empty
    if (!form.title || !form.category || !form.pub_id) {
        alert("Title, Category, and Publisher ID are required");
        return false;
    }

    if (Number(form.selling_price) < 0) {
      alert("Price cannot be negative");
      return false;
    }

    if (Number(form.quantity) < 0) {
        alert("Quantity cannot be negative");
        return false;
    }

    if (Number(form.threshold) < 0) {
      alert("Threshold cannot be negative");
      return false;
    }

    return true;
  };

  // Step 2: Submit updates via PUT
  const handleUpdate = async (e) => {
    e.preventDefault();

    if (!validate()) return;

    try {
      const res = await fetch(`http://localhost:5000/api/books/update/${isbnSearch}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          ...(token ? { Authorization: `Bearer ${token}` } : {})
        },
        // Only sending the fields the backend expects for modification
        body: JSON.stringify({
            title: form.title,
            pub_year: form.pub_year,
            selling_price: form.selling_price,
            category: form.category,
            pub_id: form.pub_id,
            quantity: form.quantity,
            threshold: form.threshold
        })
      });

      const data = await res.json();

      if (res.ok) {
        alert(data.message || "Book updated successfully");
        // Reset search to modify another book
        setIsFound(false);
        setIsbnSearch("");
        setForm({
            title: "", author_id: "", category: "", pub_id: "", 
            pub_year: "", selling_price: "", threshold: "", quantity: ""
        });
      } else {
        alert(data.error || "Failed to update book");
      }
    } catch (err) {
      console.error(err);
      alert("Network error");
    }
  };

  return (
    <div className="add-book-container">
      <h2>Modify Book</h2>

      {/* Search Input Area */}
      <div style={{marginBottom: "20px"}}>
        <input 
            name="isbnSearch" 
            placeholder="Search by ISBN" 
            value={isbnSearch}
            onChange={(e) => setIsbnSearch(e.target.value)}
            disabled={isFound} // Disable input once book is found
        />
        {!isFound ? (
            <button type="button" onClick={handleSearch} style={{marginTop: "10px"}}>Search</button>
        ) : (
            <button type="button" onClick={() => setIsFound(false)} style={{marginTop: "10px", backgroundColor: "#777"}}>Cancel / Search New</button>
        )}
      </div>

      {/* Edit Form - Only Shows if Book is Found */}
      {isFound && (
        <form onSubmit={handleUpdate}>
            <label>Title:</label>
            <input name="title" placeholder="Title" onChange={handleChange} value={form.title} />

            <label>Author (Read-Only):</label>
            <input name="author_id" value={form.author_id} disabled style={{backgroundColor: "#e0e0e0", cursor: "not-allowed"}} />

            <label>Category:</label>
            <select name="category" onChange={handleChange} value={form.category}>
            <option value="">Select Category</option>
            <option value="Science">Science</option>
            <option value="Art">Art</option>
            <option value="Religion">Religion</option>
            <option value="History">History</option>
            <option value="Geography">Geography</option>
            </select>

            <label>Publisher ID:</label>
            <input name="pub_id" placeholder="Publisher ID" onChange={handleChange} value={form.pub_id} />

            <label>Publication Year:</label>
            <input name="pub_year" type="number" placeholder="Publication Year" onChange={handleChange} value={form.pub_year} />

            <label>Selling Price:</label>
            <input name="selling_price" type="number" placeholder="Price" onChange={handleChange} value={form.selling_price} />

            <label>Quantity:</label>
            <input name="quantity" type="number" placeholder="Stock Quantity" onChange={handleChange} value={form.quantity} />

            <label>Threshold:</label>
            <input name="threshold" type="number" placeholder="Stock Threshold" onChange={handleChange} value={form.threshold} />

            <button type="submit">Update Book</button>
        </form>
      )}
    </div>
  );
};

export default ModifyBook;