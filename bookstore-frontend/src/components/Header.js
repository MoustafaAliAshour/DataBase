import React from "react";
import "../styles/Header.css";

function Header() {
  return (
    <header className="header">
      <h1>Bookstore</h1>
      <nav>
        <a href="/">Home</a>
        <a href="/cart">Cart</a>
      </nav>
    </header>
  );
}

export default Header;
