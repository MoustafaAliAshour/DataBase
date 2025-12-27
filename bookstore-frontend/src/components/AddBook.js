import { useState } from "react";
import "../styles/BookList.css";

const AddBook = ({ token }) => {
  const [form, setForm] = useState({
    ISBN: "",
    title: "",
    author_id: "",
    category: "",
    pub_id: "",
    pub_year: "",
    selling_price: "",
    threshold: ""
  });

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const validate = () => {
    for (let key in form) {
      if (!form[key]) {
        alert(`Missing field: ${key}`);
        return false;
      }
    }

    if (Number(form.selling_price) <= 0) {
      alert("Price must be positive");
      return false;
    }

    if (Number(form.threshold) < 0) {
      alert("Threshold must be non-negative");
      return false;
    }

    return true;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!validate()) return;

    try {
      const res = await fetch("http://localhost:5000/api/books/add", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          ...(token ? { Authorization: `Bearer ${token}` } : {})
        },
        body: JSON.stringify(form)
      });

      const data = await res.json();

      if (res.ok) {
        alert(data.message || "Book added successfully");
        setForm({
          ISBN: "",
          title: "",
          author_id: "",
          category: "",
          pub_id: "",
          pub_year: "",
          selling_price: "",
          threshold: ""
        });
      } else {
        alert(data.error || "Failed to add book");
      }
    } catch (err) {
      console.error(err);
      alert("Network error");
    }
  };

  return (
    <div className="add-book-container">
      <h2>Add New Book</h2>

      <form onSubmit={handleSubmit}>
        <input name="ISBN" placeholder="ISBN" onChange={handleChange} value={form.ISBN} />
        <input name="title" placeholder="Title" onChange={handleChange} value={form.title} />
        <input name="author_id" placeholder="Author ID" onChange={handleChange} value={form.author_id} />
        <select name="category" onChange={handleChange} value={form.category}>
          <option value="">Select Category</option>
          <option value="Science">Science</option>
          <option value="Art">Art</option>
          <option value="Religion">Religion</option>
          <option value="History">History</option>
          <option value="Geography">Geography</option>
        </select>
        <input name="pub_id" placeholder="Publisher ID" onChange={handleChange} value={form.pub_id} />
        <input name="pub_year" type="number" placeholder="Publication Year" onChange={handleChange} value={form.pub_year} />
        <input name="selling_price" type="number" placeholder="Price" onChange={handleChange} value={form.selling_price} />
        <input name="threshold" type="number" placeholder="Stock Threshold" onChange={handleChange} value={form.threshold} />

        <button type="submit">Add Book</button>
      </form>
    </div>
  );
};

export default AddBook;
