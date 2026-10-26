<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List, com.food.model.Menu"%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Foodify - Menu</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f8f8f8;
        }


        /* =========================
           HEADER
           ========================= */

        .header {
            background-color: white;
            padding: 20px 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .logo {
            font-size: 30px;
            font-weight: bold;
            color: #e23744;
        }

        .back-btn {
            text-decoration: none;
            color: #333;
            font-size: 16px;
        }


        /* =========================
           MENU SECTION
           ========================= */

        .menu-container {
            width: 90%;
            max-width: 1400px;
            margin: 40px auto;
        }

        .menu-title {
            font-size: 32px;
            margin-bottom: 30px;
            color: #222;
        }


        /* =========================
           MENU GRID
           ========================= */

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-template-rows: repeat(2, 1fr);
            gap: 30px;
        }


        /* =========================
           MENU CARD
           ========================= */

        .menu-card {
            width: 100%;
            background-color: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.12);
            transition: 0.3s;
        }

        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.18);
        }


        /* =========================
           IMAGE
           ========================= */

        .image-container {
            position: relative;
            width: 100%;
            height: 260px;
        }

        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }


        /* =========================
           RATING
           ========================= */

        .rating {
            position: absolute;
            bottom: 12px;
            right: 12px;
            background-color: #267e3e;
            color: white;
            padding: 5px 10px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
        }


        /* =========================
           MENU INFORMATION
           ========================= */

        .menu-info {
            padding: 20px;
        }

        .menu-info h2 {
            font-size: 22px;
            color: #222;
            margin-bottom: 10px;
        }

        .description {
            font-size: 14px;
            color: #777;
            line-height: 1.5;
            margin-bottom: 18px;
        }


        /* =========================
           PRICE SECTION
           ========================= */

        .price-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .price {
            font-size: 20px;
            font-weight: bold;
            color: #222;
        }


        /* =========================
           ADD BUTTON
           ========================= */

        .add-btn {
            display: block;
            width: 100%;
            text-align: center;
            text-decoration: none;
            background-color: #e23744;
            color: white;
            padding: 12px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            transition: 0.3s;
        }

        .add-btn:hover {
            background-color: #c92532;
        }


        /* =========================
           PAGINATION
           ========================= */

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin: 40px 0 20px;
        }

        .page-btn {
            text-decoration: none;
            background-color: #e23744;
            color: white;
            padding: 10px 22px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: bold;
            transition: 0.3s;
        }

        .page-btn:hover {
            background-color: #c92532;
        }

        .page-number {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }


        /* =========================
           TABLET
           ========================= */

        @media (max-width: 900px) {

            .menu-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .image-container {
                height: 230px;
            }

        }


        /* =========================
           MOBILE
           ========================= */

        @media (max-width: 600px) {

            .header {
                padding: 18px 25px;
            }

            .logo {
                font-size: 26px;
            }

            .menu-container {
                width: 90%;
            }

            .menu-grid {
                grid-template-columns: 1fr;
                grid-template-rows: none;
            }

            .image-container {
                height: 240px;
            }

        }

    </style>

</head>


<body>


    <!-- =========================
         HEADER
         ========================= -->

    <div class="header">

        <div class="logo">
            Foodify
        </div>

        <a href="restaurant" class="back-btn">
            ← Back to restaurants
        </a>

    </div>


    <!-- =========================
         MENU
         ========================= -->

    <div class="menu-container">

        <h1 class="menu-title">
            Menu
        </h1>


        <%

        List<Menu> allMenuByRestaurant =
            (List<Menu>) request.getAttribute("allMenuByRestaurant");


        int itemsPerPage = 4;

        int totalItems = allMenuByRestaurant.size();

        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);


        String pageParameter = request.getParameter("page");

        int currentPage = 1;


        if (pageParameter != null) {

            try {

                currentPage = Integer.parseInt(pageParameter);

            } catch (NumberFormatException e) {

                currentPage = 1;

            }

        }


        if (currentPage < 1) {
            currentPage = 1;
        }

        if (currentPage > totalPages) {
            currentPage = totalPages;
        }


        int startIndex = (currentPage - 1) * itemsPerPage;

        int endIndex = Math.min(startIndex + itemsPerPage, totalItems);


        %>


        <!-- =========================
             MENU GRID
             ========================= -->

        <div class="menu-grid">


            <%

            for (int i = startIndex; i < endIndex; i++) {

                Menu menu = allMenuByRestaurant.get(i);

            %>


                <!-- MENU CARD -->

                <div class="menu-card">


                    <!-- IMAGE -->

                    <div class="image-container">

                        <img
                            src="<%= request.getContextPath() + "/" + menu.getImagePath() %>"
                            alt="<%= menu.getItemName() %>"
                        >

                        <span class="rating">
                            ★ <%= menu.getRating() %>
                        </span>

                    </div>


                    <!-- MENU INFORMATION -->

                    <div class="menu-info">

                        <h2>
                            <%= menu.getItemName() %>
                        </h2>


                        <p class="description">
                            <%= menu.getDescription() %>
                        </p>


                        <!-- PRICE -->

                        <div class="price-section">

                            <span class="price">
                                ₹<%= menu.getPrice() %>
                            </span>

                        </div>


                        <!-- ADD TO CART -->
                        
                        <form action="cartServlet" method="post">
                        <input type=hidden  name=menuId value=<%=menu.getMenuId() %>>
                        <input type=hidden  name=restaurantId value=<%=menu.getRestaurantId() %>>
                        <input type=hidden  name=qty value=1>
                        <input type=hidden  name=action value=add>
                        <input type=submit value="Add to Cart">
                        

                        </form>
                        
                       
                            
                        </a>

                    </div>

                </div>


            <%

            }

            %>


        </div>


        <!-- =========================
             PAGINATION
             ========================= -->

        <div class="pagination">


            <%

            if (currentPage > 1) {

            %>

                <a
                    href="Menu?restaurantId=<%= request.getParameter("restaurantId") %>&page=<%= currentPage - 1 %>"
                    class="page-btn">
                    ← Previous
                </a>

            <%

            }

            %>


            <span class="page-number">

                Page <%= currentPage %> of <%= totalPages %>

            </span>


            <%

            if (currentPage < totalPages) {

            %>

                <a
                    href="Menu?restaurantId=<%= request.getParameter("restaurantId") %>&page=<%= currentPage + 1 %>"
                    class="page-btn">
                    Next →
                </a>

            <%

            }

            %>


        </div>


    </div>


</body>

</html>