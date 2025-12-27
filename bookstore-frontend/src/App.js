import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { useState } from "react";
import Login from "./components/Login";
import Register from "./components/Register";
import Home from "./components/Home";
import Cart from "./components/Cart";
import Navbar from "./components/Navbar";
import CustomerInfo from "./components/CustomerInfo";
import AddBook from "./components/AddBook";
import ModifyBook from "./components/ModifyBook";
import "./App.css";

function App() {
  const [user, setUser] = useState(null); // store logged-in user

  // Helper to get token safely
  const token = localStorage.getItem("token");

  if (!user) {
    return (
      <Router>
        <Routes>
          <Route path="/" element={<Login setUser={setUser} />} />
          <Route path="/register" element={<Register />} />
          <Route path="*" element={<Navigate to="/" />} />
        </Routes>
      </Router>
    );
  }

  return (
    <Router>
      <Navbar user={user} setUser={setUser} />
      <Routes>
        <Route path="/home" element={<Home user={user} />} />
  
        <Route
          path="/cart"
          element={<Cart user={user} token={token} />}
        />

        <Route
          path="/customer"
          element={
            <CustomerInfo
              customer={user}
              token={token}
            />
          }
        />

        <Route
          path="/add-book"
          element={
            user.role === "admin" ? (
              <AddBook token={token} />
            ) : (
              <Navigate to="/home" />
            )
          }
        />

        {}
        <Route
          path="/modify-book/:isbn"
          element={
            user.role === "admin" ? (
              <ModifyBook token={token} />
            ) : (
              <Navigate to="/home" />
            )
          }
        />

        {/* This covers just /modify-book (the search page) */}
        <Route
          path="/modify-book"
          element={
            user.role === "admin" ? (
              <ModifyBook token={token} />
            ) : (
              <Navigate to="/home" />
            )
          }
        />

        <Route path="*" element={<Navigate to="/home" />} />
      </Routes>
    </Router>
  );
}

export default App;