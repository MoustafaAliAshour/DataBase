import React, { useState } from "react";
import "../styles/CustomerInfo.css";
import axios from "axios";

function CustomerInfo({ customer, token }) {
  const [email, setEmail] = useState(customer.email);
  const [phone, setPhone] = useState(customer.phone);
  const [address, setAddress] = useState(customer.address);
  const [password, setPassword] = useState("");
  const [message, setMessage] = useState("");

  const handleUpdate = async () => {
    try {
      const res = await axios.put(`/api/customer/${customer.cust_id}`, {
        email,
        phone,
        address,
        password
      }, {
        headers: { Authorization: `Bearer ${token}` }
      });
      setMessage("Profile updated successfully!");
    } catch (err) {
      setMessage("Error updating profile.");
    }
  };

  return (
    <div className="customer-info">
      <h2>Customer Info</h2>
      <p>Name: {customer.fname} {customer.lname}</p>
      <label>Email:</label>
      <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
      <label>Phone:</label>
      <input type="text" value={phone} onChange={(e) => setPhone(e.target.value)} />
      <label>Address:</label>
      <input type="text" value={address} onChange={(e) => setAddress(e.target.value)} />
      <label>Password (optional):</label>
      <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} />
      <button onClick={handleUpdate}>Update Profile</button>
      {message && <p>{message}</p>}
    </div>
  );
}

export default CustomerInfo;
