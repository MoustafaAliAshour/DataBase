import React from "react";
import BookItem from "./BookItem";
import "../styles/BookList.css";

function BookList({ books }) {
  return (
    <div className="book-list">
      {books.map((book) => (
        <BookItem key={book.ISBN} book={book} />
      ))}
    </div>
  );
}

export default BookList;
