import React, { useEffect, useState } from "react";
import "../styles/CustomerInfo.css";
import axios from "axios";
import { useLocation } from "react-router-dom";

function CustomerInfo({ token }) {
  const location = useLocation();
  const cust_id = location.state?.cust_id;

  const [customerData, setCustomerData] = useState({
    email: "",
    phone: "",
    address: "",
  });
  const [password, setPassword] = useState("");
  const [message, setMessage] = useState("");

  // Edit states
  const [editField, setEditField] = useState(null); // "email", "phone", "address", "password"
  const [showPassword, setShowPassword] = useState(false);

  // Fetch customer info on mount
  useEffect(() => {
    if (!cust_id) return;

    const fetchCustomer = async () => {
      try {
        const res = await axios.get(`http://localhost:5000/api/customer/${cust_id}`, {
          headers: { Authorization: `Bearer ${token}` },
        });
        const data = res.data;

        // Preload the existing data
        setCustomerData({
          email: data.email || "",
          phone: data.phone || "",
          address: data.address || "",
        });
      } catch (err) {
        console.error("Error fetching customer info:", err);
        setMessage("Failed to load customer info.");
      }
    };

    fetchCustomer();
  }, [cust_id, token]);

  const handleUpdate = async (field) => {
  try {
    const updatedData = {
      ...customerData,
      password: password || undefined, // only send password if changed
    };

    await axios.put(`http://localhost:5000/api/customer/${cust_id}`, updatedData, {
      headers: { Authorization: `Bearer ${token}` },
    });

    setMessage("Profile updated successfully!");
    setEditField(null);
    if (field === "password") setPassword("");
  } catch (err) {
    console.error(err.response ? err.response.data : err);
    setMessage("Error updating profile.");
  }
};

  const renderField = (label, value, fieldKey, setter, type = "text") => (
    <div className="field-container">
      <label>{label}:</label>
      {editField === fieldKey ? (
        <div className="edit-input">
          <input
            type={type === "password" && !showPassword ? "password" : "text"}
            value={value}
            placeholder={type === "password" ? "Change your password" : ""}
            onChange={(e) => setter(e.target.value)}
          />
          {fieldKey === "password" && (
            <button
              type="button"
              className="eye-btn"
              onClick={() => setShowPassword((prev) => !prev)}
            >
              {showPassword ? "🙈" : "👁️"}
            </button>
          )}
          <button onClick={() => handleUpdate(fieldKey)}>Done</button>
        </div>
      ) : (
        <div className="field-display">
          <span>{type === "password" ? "Change your password" : value}</span>
          <button onClick={() => setEditField(fieldKey)}>Edit</button>
        </div>
      )}
    </div>
  );

  if (!cust_id) {
    return <p>Error: No customer ID provided.</p>;
  }

  return (
    <div className="customer-info">
      <h2>Customer Info</h2>
      {renderField("Email", customerData.email, "email", (val) =>
        setCustomerData({ ...customerData, email: val })
      )}
      {renderField("Phone", customerData.phone, "phone", (val) =>
        setCustomerData({ ...customerData, phone: val })
      )}
      {renderField("Address", customerData.address, "address", (val) =>
        setCustomerData({ ...customerData, address: val })
      )}
      {renderField("Password", password, "password", setPassword, "password")}

      {message && <p className="message">{message}</p>}
    </div>
  );
}

export default CustomerInfo;
