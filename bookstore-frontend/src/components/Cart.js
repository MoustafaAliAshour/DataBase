import { useEffect, useState } from "react";
import { useLocation } from "react-router-dom";
import "../styles/Cart.css";

const Cart = ({ user, token }) => {
  const location = useLocation();
  const cust_id = location.state?.cust_id || user?.cust_id;

  const [cartItems, setCartItems] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!cust_id) return;
    fetchCart();
  }, [cust_id]);

  const fetchCart = async () => {
    setLoading(true);
    try {
      const res = await fetch(`http://localhost:5000/api/cart/${cust_id}`, {
        headers: token ? { Authorization: `Bearer ${token}` } : {},
      });
      const data = await res.json();
      setCartItems(Array.isArray(data) ? data : data.cart || []);
    } catch (err) {
      console.error("Error fetching cart:", err);
    }
    setLoading(false);
  };

  const removeItem = async (ISBN) => {
    setLoading(true);
    try {
      await fetch("http://localhost:5000/api/cart/remove", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ cust_id, ISBN }),
      });
      await fetchCart();
    } catch (err) {
      console.error("Error removing item:", err);
    }
    setLoading(false);
  };

  const confirmPurchase = async () => {
    if (!cartItems.length) return;
    setLoading(true);
    try {
      await fetch("http://localhost:5000/api/cart/confirm", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ cust_id }),
      });
      setCartItems([]);
      alert("Purchase confirmed!");
    } catch (err) {
      console.error("Error confirming purchase:", err);
    }
    setLoading(false);
  };

  // Convert amount to number before calculating total
  const totalAmount = Array.isArray(cartItems)
    ? cartItems.reduce((acc, item) => acc + Number(item.amount || 0), 0)
    : 0;

  if (!cust_id) return <p>Error: No customer ID provided.</p>;

  return (
    <div className="cart-container">
      <h2>{user?.fname}'s Cart</h2>
      {loading ? (
        <p>Loading...</p>
      ) : !cartItems.length ? (
        <p>Your cart is empty</p>
      ) : (
        <div>
          <table>
            <thead>
              <tr>
                <th>Title</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              {cartItems.map((item) => (
                <tr key={item.ISBN}>
                  <td>{item.title}</td>
                  <td>{item.quantity}</td>
                  <td>${Number(item.amount || 0).toFixed(2)}</td>
                  <td>
                    <button onClick={() => removeItem(item.ISBN)}>Remove</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          <p className="total">Total: ${totalAmount.toFixed(2)}</p>
          <button className="confirm-btn" onClick={confirmPurchase}>
            Confirm Purchase
          </button>
        </div>
      )}
    </div>
  );
};

export default Cart;