import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { useState } from "react";
import Login from "./components/Login";
import Register from "./components/Register";
import Home from "./components/Home";
import Cart from "./components/Cart";
import Navbar from "./components/Navbar";
import CustomerInfo from "./components/CustomerInfo";
import "./App.css";

function App() {
  const [user, setUser] = useState(null); // store logged-in user

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
        <Route path="/cart" element={<Cart user={user} />} />
        <Route
          path="/customer"
          element={
            <CustomerInfo
              customer={user}
              token={localStorage.getItem("token")}
            />
          }
        />
        <Route path="*" element={<Navigate to="/home" />} />
      </Routes>
    </Router>
  );
}

export default App;