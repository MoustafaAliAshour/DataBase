import { Link, useNavigate } from "react-router-dom";
import "../styles/Navbar.css";

const Navbar = ({ user, setUser }) => {
  const navigate = useNavigate();

  const handleLogout = () => {
    setUser(null);
    navigate("/");
  };

  return (
    <nav className="navbar">
      <div className="logo">
        <Link to="/home">Kootoby</Link>
      </div>
      <div className="nav-right">
        <span className="user-name" onClick={handleLogout}>{user.fname}</span>
        <Link to="/cart" className="cart-icon">🛒</Link>
      </div>
    </nav>
  );
};

export default Navbar;
