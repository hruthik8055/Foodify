<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ page import="com.food.model.Cart" %>
<%@ page import="com.food.model.CartItem" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Foodify - Checkout</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            background-color: #f7f3e9;
            color: #263f3b;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            height: 75px;
            background-color: #173f3a;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 7%;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
        }

        .logo {
            color: #f4c542;
            font-size: 30px;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: 0.3s;
        }

        .nav-links a:hover {
            color: #f4c542;
        }

        .cart-link {
            background-color: #f4c542;
            color: #173f3a !important;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: bold !important;
        }

        /* ================= PAGE ================= */

        .checkout-container {
            width: 90%;
            max-width: 1250px;
            margin: 45px auto;
        }

        .page-title {
            margin-bottom: 30px;
        }

        .page-title h1 {
            font-size: 32px;
            color: #173f3a;
            margin-bottom: 8px;
        }

        .page-title p {
            color: #6d7774;
            font-size: 15px;
        }

        /* ================= MAIN LAYOUT ================= */

        .checkout-layout {
            display: grid;
            grid-template-columns: 1.7fr 1fr;
            gap: 30px;
            align-items: start;
        }

        /* ================= LEFT SECTION ================= */

        .checkout-card {
            background-color: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 25px;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 25px;
        }

        .section-number {
            width: 32px;
            height: 32px;
            background-color: #f4c542;
            color: #173f3a;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .section-title h2 {
            color: #173f3a;
            font-size: 21px;
        }

        /* ================= FORM ================= */

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-group label {
            font-size: 14px;
            font-weight: bold;
            color: #263f3b;
            margin-bottom: 8px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #d6ddd9;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: 0.3s;
            background-color: #fff;
        }

        .form-group textarea {
            height: 95px;
            resize: none;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #173f3a;
            box-shadow: 0 0 0 2px rgba(23, 63, 58, 0.08);
        }

        /* ================= PAYMENT ================= */

        .payment-options {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .payment-option {
            border: 1px solid #d6ddd9;
            border-radius: 10px;
            padding: 16px;
            display: flex;
            align-items: center;
            gap: 15px;
            cursor: pointer;
            transition: 0.3s;
        }

        .payment-option:hover {
            border-color: #173f3a;
            background-color: #fafcfb;
        }

        .payment-option input {
            accent-color: #173f3a;
            width: 18px;
            height: 18px;
        }

        .payment-icon {
            width: 42px;
            height: 42px;
            border-radius: 8px;
            background-color: #f4c542;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .payment-details h3 {
            font-size: 15px;
            color: #173f3a;
            margin-bottom: 4px;
        }

        .payment-details p {
            font-size: 12px;
            color: #7b8581;
        }

        /* ================= RIGHT CART ================= */

        .order-summary {
            background-color: white;
            border-radius: 15px;
            padding: 28px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            position: sticky;
            top: 25px;
        }

        .order-summary h2 {
            color: #173f3a;
            font-size: 22px;
            margin-bottom: 22px;
        }

        /* ================= CART ITEM ================= */

        .cart-item {
            display: flex;
            align-items: center;
            gap: 13px;
            padding: 15px 0;
            border-bottom: 1px solid #eeeeee;
        }

        .item-image {
            width: 65px;
            height: 65px;
            border-radius: 9px;
            object-fit: cover;
            background-color: #eeeeee;
        }

        .item-details {
            flex: 1;
        }

        .item-details h3 {
            font-size: 14px;
            color: #263f3b;
            margin-bottom: 5px;
        }

        .item-details p {
            font-size: 12px;
            color: #7b8581;
        }

        .item-price {
            font-size: 14px;
            font-weight: bold;
            color: #173f3a;
        }

        /* ================= DELIVERY INFO ================= */

        .delivery-info {
            background-color: #f7f3e9;
            border-radius: 10px;
            padding: 15px;
            margin: 20px 0;
        }

        .delivery-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .delivery-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .delivery-icon {
            font-size: 21px;
        }

        .delivery-left span {
            font-size: 13px;
            color: #5e6965;
        }

        .delivery-time {
            font-weight: bold;
            color: #173f3a !important;
        }

        /* ================= PRICE DETAILS ================= */

        .price-details {
            margin-top: 20px;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 13px;
            font-size: 14px;
            color: #626d69;
        }

        .price-row span:last-child {
            color: #263f3b;
            font-weight: 500;
        }

        .price-row.discount span:last-child {
            color: #26824d;
        }

        .grand-total {
            border-top: 1px solid #dddddd;
            padding-top: 17px;
            margin-top: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .grand-total span:first-child {
            font-size: 17px;
            font-weight: bold;
            color: #173f3a;
        }

        .grand-total span:last-child {
            font-size: 22px;
            font-weight: bold;
            color: #173f3a;
        }

        /* ================= PLACE ORDER ================= */

        .place-order-btn {
            width: 100%;
            border: none;
            background-color: #f4c542;
            color: #173f3a;
            padding: 16px;
            border-radius: 9px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 25px;
            transition: 0.3s;
        }

        .place-order-btn:hover {
            background-color: #e5b82e;
            transform: translateY(-1px);
        }

        .secure-payment {
            text-align: center;
            margin-top: 14px;
            color: #7b8581;
            font-size: 12px;
        }

        /* ================= FOOTER ================= */

        .footer-note {
            text-align: center;
            margin-top: 35px;
            color: #7b8581;
            font-size: 12px;
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 900px) {

            .checkout-layout {
                grid-template-columns: 1fr;
            }

            .order-summary {
                position: static;
            }

        }

        @media (max-width: 600px) {

            .navbar {
                padding: 0 5%;
            }

            .nav-links {
                gap: 12px;
            }

            .nav-links a {
                font-size: 13px;
            }

            .checkout-container {
                width: 94%;
                margin: 30px auto;
            }

            .checkout-card,
            .order-summary {
                padding: 20px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .form-group.full {
                grid-column: auto;
            }

            .page-title h1 {
                font-size: 27px;
            }

        }

    </style>
</head>

<body>

    <!-- ================= NAVBAR ================= -->

    <nav class="navbar">

        <a href="restaurant" class="logo">
            Foodify
        </a>

        <div class="nav-links">

            <a href="restaurant">
                Home
            </a>

            <a href="cart.jsp">
                Cart
            </a>

            <a href="profile">
                Profile
            </a>

            <a href="<%= request.getContextPath() %>/Logout" class="cart-link">
    Sign Out
</a>

        </div>

    </nav>


    <!-- ================= CHECKOUT ================= -->

    <main class="checkout-container">

        <div class="page-title">

            <h1>Checkout</h1>

            <p>
                Complete your details and place your order.
            </p>

        </div>

      <form action="checkoutServlet" method ="post">
        <div class="checkout-layout">


            <!-- ================= LEFT SIDE ================= -->

            <div>


                <!-- CUSTOMER INFORMATION -->

                <div class="checkout-card">

                    <div class="section-title">

                        <div class="section-number">
                            1
                        </div>

                        <h2>
                            Delivery Information
                        </h2>

                    </div>


                    <div class="form-row">

                        <div class="form-group">

                            <label>
                                Full Name
                            </label>

                            <input
                                type="text"
                                placeholder="Enter your name"
                                required
                            >

                        </div>


                        <div class="form-group">

                            <label>
                                Phone Number
                            </label>

                            <input
                                type="tel"
                                placeholder="Enter your phone number"
                                required
                            >

                        </div>


                        <div class="form-group">

                            <label>
                                Email Address
                            </label>

                            <input
                                type="email"
                                placeholder="Enter your email"
                                required
                            >

                        </div>


                        <div class="form-group">

                            <label>
                                Pincode
                            </label>

                            <input
                                type="text"
                                placeholder="Enter pincode"
                                required
                            >

                        </div>


                        <div class="form-group full">

                            <label>
                                Delivery Address
                            </label>

                            <textarea
                                placeholder="Enter your complete delivery address"
                                required
                            ></textarea>

                        </div>

                    </div>

                </div>


                <!-- PAYMENT INFORMATION -->

                <div class="checkout-card">

                    <div class="section-title">

                        <div class="section-number">
                            2
                        </div>

                        <h2>
                            Payment Method
                        </h2>

                    </div>


                    <div class="payment-options">


                        <!-- UPI -->

                        <label class="payment-option">

                            <input
                                type="radio"
                                name="payment"
                                value="upi"
                                checked
                            >

                            <div class="payment-icon">
                                📱
                            </div>

                            <div class="payment-details">

                                <h3>
                                    UPI
                                </h3>

                                <p>
                                    Pay using Google Pay, PhonePe, Paytm or other UPI apps
                                </p>

                            </div>

                        </label>


                        <!-- CARD -->

                        <label class="payment-option">

                            <input
                                type="radio"
                                name="payment"
                                value="card"
                            >

                            <div class="payment-icon">
                                💳
                            </div>

                            <div class="payment-details">

                                <h3>
                                    Credit / Debit Card
                                </h3>

                                <p>
                                    Pay securely using your debit or credit card
                                </p>

                            </div>

                        </label>


                        <!-- CASH -->

                        <label class="payment-option">

                            <input
                                type="radio"
                                name="payment"
                                value="cod"
                            >

                            <div class="payment-icon">
                                💵
                            </div>

                            <div class="payment-details">

                                <h3>
                                    Cash on Delivery
                                </h3>

                                <p>
                                    Pay with cash when your order arrives
                                </p>

                            </div>

                        </label>


                    </div>

                </div>


            </div>


            <!-- ================= RIGHT SIDE ================= -->

            <div class="order-summary">

                <h2>
                    Your Order
                </h2>
                
                <%
                Cart cart= (Cart)session.getAttribute("cart");
                double itemTotal=0;
                double dc=30;
                double pf= 10;
                double gst=42;
                
                if(cart != null && !cart.getItems().isEmpty()){
                	for(CartItem item : cart.getItems().values()){
                		itemTotal=itemTotal + item.getTotalPrice();
                	}
                }
                
                double grandTotal= itemTotal + dc + pf + gst;
                session.setAttribute("grandTotal", grandTotal);
                %>
                
                <%
                if(cart != null && !cart.getItems().isEmpty()){
                	for(CartItem item: cart.getItems().values()){
                		%>
                		
                		 <!-- CART ITEM 1 -->
                		 
                		<div class="cart-item">

                    

                    <div class="item-details">

                        <h3>
                            <%= item.getName() %>
                        </h3>

                        <p>
                            Quantity: <%= item.getQty() %>
                        </p>

                    </div>

                    <div class="item-price">
                        ₹<%=item.getPrice() %>
                    </div>

                </div>
                		
                		<%
                	
                	}
                }
                %>


               

                

              
                <!-- DELIVERY TIME -->

                <div class="delivery-info">

                    <div class="delivery-row">

                        <div class="delivery-left">

                            <div class="delivery-icon">
                                🛵
                            </div>

                            <span>
                                Estimated Delivery
                            </span>

                        </div>

                        <span class="delivery-time">
                            30 - 40 mins
                        </span>

                    </div>

                </div>


                <!-- PRICE DETAILS -->

                <div class="price-details">

                    <div class="price-row">

                        <span>
                            Item Total
                        </span>

                        <span>
                            <%=itemTotal %>
                        </span>

                    </div>


                    <div class="price-row">

                        <span>
                            Delivery Charges
                        </span>

                        <span>
                            <%= dc %>
                        </span>

                    </div>
                    <div class="price-row">

                        <span>
                            Platform Fee
                        </span>

                        <span>
                            <%= pf %>
                        </span>

                    </div>


                    <div class="price-row">

                        <span>
                            GST
                        </span>

                        <span>
                            <%= gst %>
                        </span>

                    </div>




                    <div class="grand-total">

                        <span>
                            Grand Total
                        </span>

                        <span>
                           <%= grandTotal%>
                        </span>

                    </div>

                </div>


                <!-- PLACE ORDER -->
 <button type="submit" class="place-order-btn">
        Place Order
    </button>

                <div class="secure-payment">
                    🔒 Your payment information is secure
                </div>

            </div>

        </div>
        
        </form>


        <div class="footer-note">

            © 2026 Foodify • Delicious Food, Happier You!

        </div>

    </main>

</body>

</html>