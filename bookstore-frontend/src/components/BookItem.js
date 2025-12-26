import React from "react";
import "../styles/BookItem.css";

function BookItem({ book }) {
  return (
    <div className="book-item">
      <h3>{book.title}</h3>
      <p>Author: {book.authors}</p>
      <p>Category: {book.category}</p>
      <p>Price: ${book.selling_price}</p>
      <button>Add to Cart</button>
    </div>
  );
}

export default BookItem;
