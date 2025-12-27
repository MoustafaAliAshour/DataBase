import { Link, useNavigate } from "react-router-dom";
import "../styles/Navbar.css";

const Navbar = ({ user, setUser }) => {
  const navigate = useNavigate();

  const handleLogout = () => {
    setUser(null);
    navigate("/");
  };

 const goToCart = () => {
    if (!user?.cust_id) return;
    navigate("/cart", { state: { cust_id: user.cust_id } });
  };
  const goToProfile = () => {
  navigate("/customer", { state: { cust_id: user.cust_id } });
};

  return (
    <nav className="navbar">
      <div className="logo">
        <Link to="/home">Kootoby</Link>
      </div>
      <div className="nav-right">
        {/* Customer name clickable to go to profile */}
        <span className="user-name" onClick={goToProfile} style={{ cursor: "pointer", marginRight: "10px" }}>
          {user.fname}
        </span>

        {/* Cart link */}
        <Link to="/cart" onClick={goToCart} className="cart-icon" style={{ marginRight: "10px" }}>🛒</Link>

        {/* Logout button */}
        <button onClick={handleLogout} className="logout-btn">
          Logout
        </button>
      </div>
    </nav>
  );
};

export default Navbar;