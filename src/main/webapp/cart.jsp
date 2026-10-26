<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.food.model.Cart" %>
<%@ page import="com.food.model.CartItem" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Foodify - Cart</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            background: #f7f3e9;
            color: #263f3b;
        }


        /* ================= NAVBAR ================= */

        .navbar {
            height: 70px;
            background: #173f3a;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 60px;

            color: white;
        }

        .logo {
            font-size: 30px;
            font-weight: bold;
            color: #f4c542;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 35px;
        }

        .nav-links a {
            text-decoration: none;
            color: white;
            font-size: 16px;
            transition: 0.3s;
        }

        .nav-links a:hover {
            color: #f4c542;
        }

        .cart-link {
            color: #f4c542 !important;
            font-weight: bold;
        }


        /* ================= MAIN CONTAINER ================= */

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 55px auto;
        }


        /* ================= HEADING ================= */

        .cart-heading {
            margin-bottom: 28px;
        }

        .cart-heading h1 {
            font-size: 34px;
            margin-bottom: 8px;
            color: #263f3b;
        }

        .cart-heading p {
            color: #777;
            font-size: 16px;
        }


        /* ================= CART BOX ================= */

        .cart-box {
            background: white;

            border-radius: 18px;

            padding: 28px 25px;

            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.08);

            overflow: hidden;
        }


        /* ================= CART HEADER ================= */

        .cart-header {

            display: grid;

            grid-template-columns:
                2.4fr
                1fr
                1fr
                1fr
                1fr;

            align-items: center;

            padding: 0 0 18px 0;

            border-bottom: 1px solid #e5e5e5;

            color: #555;

            font-size: 14px;

            font-weight: bold;
        }


        /* ================= CART ITEM ================= */

        .cart-item {

            display: grid;

            grid-template-columns:
                2.4fr
                1fr
                1fr
                1fr
                1fr;

            align-items: center;

            min-height: 85px;

            border-bottom: 1px solid #e5e5e5;

            color: #263f3b;
        }


        .item-name {
            font-size: 18px;
            font-weight: bold;
        }


        .item-price {
            font-size: 16px;
            color: #173f3a;
            font-weight: bold;
        }


        .item-total {
            font-size: 16px;
            color: #173f3a;
            font-weight: bold;
        }


        /* ================= QUANTITY ================= */

        .quantity-control {

            display: flex;

            align-items: center;

            gap: 10px;
        }


        .quantity-btn {

            width: 36px;
            height: 36px;

            border-radius: 50%;

            border: 1px solid #f4c542;

            background: #fff8df;

            color: #173f3a;

            font-size: 20px;

            cursor: pointer;

            transition: 0.3s;
        }


        .quantity-btn:hover {

            background: #f4c542;

            color: #173f3a;
        }


        .quantity {

            min-width: 25px;

            text-align: center;

            font-size: 16px;

            font-weight: bold;
        }


        /* ================= REMOVE BUTTON ================= */

        .remove-btn {

            width: 85px;

            padding: 9px 12px;

            border-radius: 20px;

            border: 1px solid #d9534f;

            background: transparent;

            color: #d9534f;

            cursor: pointer;

            font-size: 13px;

            transition: 0.3s;
        }


        .remove-btn:hover {

            background: #d9534f;

            color: white;
        }


        /* ================= GRAND TOTAL ================= */

        .grand-total {

            display: flex;

            justify-content: space-between;

            align-items: center;

            padding: 25px 0 5px 0;

            font-size: 22px;

            font-weight: bold;
        }


        .grand-total-price {

            color: #173f3a;

            font-size: 23px;
        }


        /* ================= BOTTOM BUTTONS ================= */

        .cart-actions {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-top: 28px;
        }


        .add-more-btn {

            text-decoration: none;

            border: 2px solid #173f3a;

            color: #173f3a;

            background: transparent;

            padding: 12px 27px;

            border-radius: 25px;

            font-weight: bold;

            font-size: 15px;

            transition: 0.3s;
        }


        .add-more-btn:hover {

            background: #173f3a;

            color: white;
        }


        .checkout-btn {

            text-decoration: none;

            background: #173f3a;

            color: white;

            padding: 14px 35px;

            border-radius: 25px;

            font-weight: bold;

            font-size: 15px;

            border: none;

            cursor: pointer;

            transition: 0.3s;
        }


        .checkout-btn:hover {

            background: #245b54;

        }


        /* ================= EMPTY CART ================= */

        .empty-cart {

            background: white;

            border-radius: 18px;

            padding: 70px 20px;

            text-align: center;

            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.08);
        }


        .empty-cart h2 {

            font-size: 28px;

            margin-bottom: 12px;

            color: #263f3b;
        }


        .empty-cart p {

            color: #777;

            margin-bottom: 25px;
        }


        .browse-btn {

            display: inline-block;

            text-decoration: none;

            background: #173f3a;

            color: white;

            padding: 12px 28px;

            border-radius: 25px;

            font-weight: bold;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 800px) {

            .navbar {
                padding: 0 25px;
            }

            .nav-links {
                gap: 15px;
            }

            .nav-links a {
                font-size: 13px;
            }

            .container {
                width: 94%;
            }

            .cart-box {
                overflow-x: auto;
            }

            .cart-header,
            .cart-item {

                min-width: 750px;

                grid-template-columns:
                    2.4fr
                    1fr
                    1fr
                    1fr
                    1fr;
            }

            .cart-actions {
                flex-direction: column;

                gap: 20px;

                align-items: stretch;
            }

            .add-more-btn,
            .checkout-btn {
                text-align: center;
            }
        }

    </style>

</head>


<body>


    <!-- ================= NAVBAR ================= -->

    <nav class="navbar">

        <div class="logo">
            Foodify
        </div>

        <div class="nav-links">

            <a href="restaurant">
                Home
            </a>

            <% if (session.getAttribute("user") == null) { %>
<a href="login.html">
    Sign In
</a>
<% } else { %>
<a href="<%= request.getContextPath() %>/Logout">
    Logout
</a>
<% } %>
            <a href="#" class="cart-link">
                Cart 🛒
            </a>

            <a href="profile.jsp">
                Profile
            </a>

        </div>

    </nav>



    <!-- ================= MAIN ================= -->

    <div class="container">


        <!-- HEADING -->

        <div class="cart-heading">

            <h1>
                Your Cart 🛒
            </h1>

            <p>
                Review your selected food items
            </p>

        </div>



        <%

            Cart cart = (Cart) session.getAttribute("cart");

            Integer restaurantId =
                    (Integer) session.getAttribute("restaurantId");

            double grandTotal = 0;


            if (cart != null && !cart.getItems().isEmpty()) {

        %>


        <!-- ================= CART BOX ================= -->

        <div class="cart-box">


            <!-- ================= HEADER ================= -->

            <div class="cart-header">

                <div>
                    Item
                </div>

                <div>
                    Price
                </div>

                <div>
                    Total
                </div>

                <div>
                    Quantity
                </div>

                <div>
                    Action
                </div>

            </div>



            <!-- ================= CART ITEMS ================= -->

            <%

                for (CartItem item : cart.getItems().values()) {

                    grandTotal = item.getTotalPrice()+ grandTotal ;

                    int quantity = 1;

                    if (item.getPrice() > 0) {

                        quantity =
                            (int)(item.getTotalPrice() / item.getPrice());

                    }

            %>


            <div class="cart-item">


                <!-- ITEM -->

                <div class="item-name">

                    <%= item.getName() %>

                </div>


                <!-- PRICE -->

                <div class="item-price">

                    ₹<%= item.getPrice() %>

                </div>


                <!-- TOTAL -->

                <div class="item-total">

                    ₹<%= item.getTotalPrice() %>

                </div>


                <!-- QUANTITY -->

                <div class="quantity-control">


                    <form action="cartServlet" method="post"
                          style="display:inline;">

                        <input type="hidden"
                               name="action"
                               value="update">

                        <input type="hidden"
                               name="restaurantId"
                               value="<%= restaurantId %>">

                        <input type="hidden"
                               name="menuId"
                               value="<%= item.getMenuId() %>">

                        <input type="hidden"
                               name="quantity"
                               value="<%= item.getQty()-1%>">

                        <button type="submit"
                                class="quantity-btn">

                            −

                        </button>

                    </form>


                    <span class="quantity">

                        <%= item.getQty()%>

                    </span>


                    <form action="cartServlet" method="post"
                          style="display:inline;">

                        <input type="hidden"
                               name="action"
                               value="update">

                        <input type="hidden"
                               name="restaurantId"
                               value="<%= restaurantId %>">

                        <input type="hidden"
                               name="menuId"
                               value="<%= item.getMenuId() %>">

                        <input type="hidden"
                               name="quantity"
                               value="<%= item.getQty()+1%>">

                        <button type="submit"
                                class="quantity-btn">

                            +

                        </button>

                    </form>


                </div>



                <!-- REMOVE -->

                <form action="cartServlet"
                      method="post">

                    <input type="hidden"
                           name="action"
                           value="delete">

                    <input type="hidden"
                           name="restaurantId"
                           value="<%= restaurantId %>">

                    <input type="hidden"
                           name="menuId"
                           value="<%= item.getMenuId() %>">

                    <button type="submit"
                            class="remove-btn">

                        Remove

                    </button>

                </form>


            </div>


            <%

                }

            %>



            <!-- ================= GRAND TOTAL ================= -->

            <div class="grand-total">

                <span>
                    Grand Total
                </span>

                <span class="grand-total-price">

                    ₹<%= grandTotal %>

                </span>

            </div>


        </div>



        <!-- ================= BOTTOM ACTIONS ================= -->

        <div class="cart-actions">


            <a href="Menu?restaurantId=<%=restaurantId %>"
               class="add-more-btn">

                Add More Items

            </a>


            <a href="checkout.jsp"
               class="checkout-btn">

                Proceed to Checkout →

            </a>


        </div>


        <%

            } else {

        %>



        <!-- ================= EMPTY CART ================= -->

        <div class="empty-cart">

            <h2>
                Your Cart is Empty 🛒
            </h2>

            <p>
                Looks like you haven't added any food items yet.
            </p>

            <a href="restaurant"
               class="browse-btn">

                Browse Restaurants

            </a>

        </div>


        <%

            }

        %>


    </div>


</body>

</html>