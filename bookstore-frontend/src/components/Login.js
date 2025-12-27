import { useNavigate, Link } from "react-router-dom";
import "../styles/Login.css";

const Login = ({ setUser }) => {
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();

    const username = e.target.username.value;
    const password = e.target.password.value;

    try {

      console.log("Attempting login with:", { username, password });

      const res = await fetch("http://localhost:5000/api/auth/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password }),
      });
      
      console.log("Attempting login with:", { username, password });
      const data = await res.json();

      if (!res.ok) {
        alert(data.error || "Login failed");
        return;
      }

      setUser(data.user);
      localStorage.setItem("token", data.token);
          alert("Logged in successfully!");
      navigate("/home");
    } catch (err) {
      alert("Server error");
    }
  };

  return (
    <div className="login-container">
      <h1>Kootoby</h1>
      <h4>Your way of getting your lovely books</h4>
      <form onSubmit={handleLogin}>
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Login</button>
      </form>
      <p>
        Don't have an account? <Link to="/register">Register</Link>
      </p>
    </div>
  );
};

export default Login;
