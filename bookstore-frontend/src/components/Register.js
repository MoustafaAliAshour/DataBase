import { useNavigate } from "react-router-dom";
import "../styles/Register.css";

const Register = () => {
  const navigate = useNavigate();

  const handleRegister = async (e) => {
    e.preventDefault();

    const formData = {
      username: e.target.username.value,
      password: e.target.password.value,
      fname: e.target.fname.value,
      lname: e.target.lname.value,
      email: e.target.email.value,
      phone: e.target.phone.value,
      address: e.target.address.value,
    };

    try {
      const res = await fetch("http://localhost:5000/api/auth/register", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      const data = await res.json();

      if (!res.ok) {
        alert(data.error || "Registration failed");
        return;
      }

      alert("Registration successful! Please login.");
      navigate("/");
    } catch (err) {
      alert("Server error");
    }
  };

  return (
    <div className="register-container">
      <h1>Register</h1>
      <form onSubmit={handleRegister}>
        <input type="text" name="fname" placeholder="First Name" required />
        <input type="text" name="lname" placeholder="Last Name" required />
        <input type="text" name="username" placeholder="Username" required />
        <input type="email" name="email" placeholder="Email" required />
        <input type="text" name="phone" placeholder="Phone" />
        <input type="text" name="address" placeholder="Address" />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Register</button>
      </form>
    </div>
  );
};

export default Register;
