import { useEffect, useState } from "react";
import "../styles/Cart.css";

const Cart = ({ user }) => {
  const [cartItems, setCartItems] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (user?.cust_id) fetchCart();
  }, [user?.cust_id]);

  const fetchCart = async () => {
    setLoading(true);
    try {
      const res = await fetch(`http://localhost:5000/api/cart/${user.cust_id}`);
      const data = await res.json();
      setCartItems(data);
    } catch (err) {
      console.error(err);
    }
    setLoading(false);
  };

  const removeItem = async (ISBN) => {
    setLoading(true);
    await fetch("http://localhost:5000/api/cart/remove", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ cust_id: user.cust_id, ISBN }),
    });
    await fetchCart();
  };

  const confirmPurchase = async () => {
    if (cartItems.length === 0) return;
    setLoading(true);
    await fetch("http://localhost:5000/api/cart/confirm", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ cust_id: user.cust_id }),
    });
    setCartItems([]);
    setLoading(false);
    alert("Purchase confirmed!");
  };

  const totalAmount = cartItems.reduce((acc, item) => acc + item.amount, 0);

  return (
    <div className="cart-container">
      <h2>{user?.fname}'s Cart</h2>
      {loading ? (
        <p>Loading...</p>
      ) : cartItems.length === 0 ? (
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
              {cartItems.map(item => (
                <tr key={item.ISBN}>
                  <td>{item.title}</td>
                  <td>{item.quantity}</td>
                  <td>${item.amount.toFixed(2)}</td>
                  <td>
                    <button onClick={() => removeItem(item.ISBN)}>Remove</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          <p className="total">Total: ${totalAmount.toFixed(2)}</p>
          <button className="confirm-btn" onClick={confirmPurchase}>Confirm Purchase</button>
        </div>
      )}
    </div>
  );
};

export default Cart;
