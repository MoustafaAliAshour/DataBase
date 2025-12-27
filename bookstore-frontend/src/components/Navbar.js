import { Link, useNavigate } from "react-router-dom";
import "../styles/Navbar.css";

const Navbar = ({ user, setUser }) => {
  const navigate = useNavigate();

  const handleLogout = () => {
    setUser(null);
    navigate("/");
  };

  const goToProfile = () => {
    navigate("/customer"); // Navigate to CustomerInfo page
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
        <Link to="/cart" className="cart-icon" style={{ marginRight: "10px" }}>🛒</Link>

        {/* Logout button */}
        <button onClick={handleLogout} className="logout-btn">
          Logout
        </button>
      </div>
    </nav>
  );
};

export default Navbar;