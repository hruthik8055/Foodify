<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Order" %>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");

    if (orders == null) {
        response.sendRedirect("my-orders");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Orders | Foodify</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            background: #f7f5ef;
            color: #263238;
        }

        .navbar {
            background: #073b3a;
            color: white;
            padding: 18px 7%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .logo {
            font-size: 28px;
            font-weight: bold;
            color: #f5c542;
        }

        .logo span {
            color: white;
        }

        .nav-links {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
        }

        .nav-links a:hover {
            color: #f5c542;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
            min-height: 65vh;
        }

        .heading {
            margin-bottom: 25px;
        }

        .heading h1 {
            color: #073b3a;
            margin-bottom: 8px;
        }

        .heading p {
            color: #6b7777;
            line-height: 1.6;
        }

        .order-card {
            background: white;
            padding: 25px;
            border-radius: 14px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            padding-bottom: 18px;
            border-bottom: 1px solid #e6e9e6;
        }

        .order-header h2 {
            color: #073b3a;
            font-size: 20px;
        }

        .status {
            display: inline-block;
            padding: 7px 13px;
            border-radius: 20px;
            background: #fff3cf;
            color: #8b6500;
            font-size: 13px;
            font-weight: bold;
        }

        .order-details {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 22px;
            padding: 22px 0;
        }

        .label {
            color: #7b8585;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .value {
            font-size: 15px;
            font-weight: bold;
            overflow-wrap: anywhere;
        }

        .amount {
            color: #073b3a;
            font-size: 19px;
        }

        .payment {
            padding-top: 15px;
            border-top: 1px solid #e6e9e6;
            color: #596565;
            font-size: 14px;
        }

        .empty {
            background: white;
            text-align: center;
            padding: 55px 20px;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
        }

        .empty h2 {
            color: #073b3a;
            margin-bottom: 12px;
        }

        .empty p {
            color: #6b7777;
            line-height: 1.6;
            margin-bottom: 22px;
        }

        .btn {
            display: inline-block;
            padding: 13px 22px;
            border-radius: 8px;
            background: #073b3a;
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .btn:hover {
            background: #0b5552;
        }

        footer {
            text-align: center;
            padding: 25px 15px;
            color: #7b8585;
            font-size: 13px;
        }

        @media (max-width: 650px) {
            .navbar {
                padding: 18px 5%;
            }

            .container {
                margin: 25px auto;
                padding: 0 14px;
            }

            .order-details {
                grid-template-columns: 1fr 1fr;
            }

            .order-card {
                padding: 20px;
            }
        }

        @media (max-width: 400px) {
            .order-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

    <nav class="navbar">
        <div class="logo">Food<span>ify</span></div>

        <div class="nav-links">
            <a href="restaurant">Home</a>
            <a href="cart.jsp">Cart</a>
            <a href="my-orders">My Orders</a>
            <a href="profile">Profile</a>
        </div>
    </nav>

    <main class="container">

        <div class="heading">
            <h1>My Orders</h1>
            <p>View your order history and payment details.</p>
        </div>

        <% if (orders.isEmpty()) { %>

            <section class="empty">
                <h2>No orders yet!</h2>

                <p>
                    You haven't placed an order with Foodify yet.
                    Explore our restaurants and order something delicious.
                </p>

                <a href="restaurant" class="btn">Explore Restaurants</a>
            </section>

        <% } else { %>

            <% for (Order order : orders) { %>

                <section class="order-card">

                    <div class="order-header">
                        <h2>
                            Order #<%= order.getOrderId() %>
                        </h2>

                        <span class="status">
                            <%= order.getStatus() == null
                                ? "Unknown"
                                : order.getStatus() %>
                        </span>
                    </div>

                    <div class="order-details">

                        <div>
                            <div class="label">Order Date</div>

                            <div class="value">
                                <%= order.getOrderDate() == null
                                    ? "Not available"
                                    : order.getOrderDate() %>
                            </div>
                        </div>

                        <div>
                            <div class="label">Restaurant ID</div>

                            <div class="value">
                                <%= order.getRestaurantId() %>
                            </div>
                        </div>

                        <div>
                            <div class="label">Total Amount</div>

                            <div class="value amount">
                                ₹<%= String.format("%.2f",
                                    order.getTotalAmount()) %>
                            </div>
                        </div>

                    </div>

                    <div class="payment">
                        Payment method:
                        <strong>
                            <%= order.getPaymentMethod() == null
                                ? "Not specified"
                                : order.getPaymentMethod() %>
                        </strong>
                    </div>

                </section>

            <% } %>

        <% } %>

    </main>

    <footer>
        &copy; 2026 Foodify. Good Food, Happy Mood!
    </footer>

</body>
</html>