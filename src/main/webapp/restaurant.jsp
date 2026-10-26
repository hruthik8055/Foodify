<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List , com.food.model.Restaurant" %>

<!DOCTYPE html>

<html lang="en">

<head>

  <meta charset="UTF-8" />

  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <title>Foodify Restaurant Page</title>

  <style>

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      background: #f7f3e9;
      color: #243b3b;
    }


    /* =========================
       NAVIGATION BAR
       ========================= */

    .navbar {
      width: 100%;
      background: #123c3d;
      color: white;

      display: flex;
      justify-content: space-between;
      align-items: center;

      padding: 18px 7%;

      position: sticky;
      top: 0;
      z-index: 1000;

      box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
    }

    .logo {
      font-size: 28px;
      font-weight: bold;
      color: #e9c46a;
    }

    .nav-links {
      display: flex;
      align-items: center;
      gap: 25px;

      list-style: none;
    }

    .nav-links a {
      color: white;
      text-decoration: none;

      font-size: 15px;

      transition: 0.3s;
    }

    .nav-links a:hover {
      color: #e9c46a;
    }

    .sign-in {
      background: #e9c46a;
      color: #123c3d !important;

      padding: 10px 18px;

      border-radius: 25px;

      font-weight: bold;
    }

    .sign-in:hover {
      background: #f4d58d;
    }


    /* =========================
       HERO SECTION
       ========================= */

    .hero {
      text-align: center;

      padding: 65px 20px;

      background:
        linear-gradient(
          rgba(18, 60, 61, 0.9),
          rgba(18, 60, 61, 0.9)
        ),
        url("https://images.unsplash.com/photo-1504674900247-0877df9cc836")
        center/cover;

      color: white;
    }

    .hero h1 {
      font-size: 42px;
      margin-bottom: 15px;
    }

    .hero p {
      font-size: 18px;
      color: #f7f3e9;
    }


    /* =========================
       RESTAURANT SECTION
       ========================= */

    .section-heading {
      text-align: center;

      margin: 40px 0 25px;
    }

    .section-heading h2 {
      color: #123c3d;

      font-size: 30px;

      margin-bottom: 8px;
    }

    .section-heading p {
      color: #667777;

      font-size: 16px;
    }


    /* =========================
       RESTAURANT GRID
       ========================= */

    .restaurant-container {

      width: 90%;
      max-width: 1350px;

      margin: 0 auto;

      display: grid;

      grid-template-columns: repeat(3, minmax(0, 1fr));

      gap: 28px;

      padding-bottom: 60px;
    }


    /* =========================
       RESTAURANT CARD
       ========================= */

    .restaurant-card {

      background: white;

      border-radius: 18px;

      overflow: hidden;

      box-shadow:
        0 5px 18px rgba(18, 60, 61, 0.12);

      transition:
        transform 0.3s ease,
        box-shadow 0.3s ease;

      min-width: 0;
    }

    .restaurant-card:hover {

      transform: translateY(-7px);

      box-shadow:
        0 12px 28px rgba(18, 60, 61, 0.20);
    }


    /* =========================
       RESTAURANT IMAGE
       ========================= */

    .restaurant-card img {

      width: 100%;

      height: 230px;

      display: block;

      object-fit: cover;

      object-position: center;

      background: #eee;
    }


    /* =========================
       CARD CONTENT
       ========================= */

    .card-content {

      padding: 18px 20px 20px;
    }

    .card-content h3 {

      color: #123c3d;

      font-size: 20px;

      margin-bottom: 9px;
    }


    /* =========================
       RATING
       ========================= */

    .rating {

      display: inline-block;

      background: #e9c46a;

      color: #123c3d;

      font-weight: bold;

      padding: 5px 10px;

      border-radius: 15px;

      font-size: 13px;

      margin-bottom: 10px;
    }


    /* =========================
       DETAILS
       ========================= */

    .details {

      color: #667777;

      font-size: 13px;

      line-height: 1.6;

      margin-bottom: 10px;
    }


    /* =========================
       DESCRIPTION
       ========================= */

    .description {

      color: #455959;

      font-size: 13px;

      line-height: 1.5;

      margin-bottom: 16px;
    }


    /* =========================
       VIEW MENU BUTTON
       ========================= */

    .view-menu {

      display: inline-block;

      background: #123c3d;

      color: white;

      text-decoration: none;

      padding: 9px 16px;

      border-radius: 25px;

      font-size: 13px;

      font-weight: 600;

      transition: 0.3s;
    }

    .view-menu:hover {

      background: #1c6263;
    }


    /* =========================
       FOOTER
       ========================= */

    footer {

      background: #123c3d;

      color: white;

      text-align: center;

      padding: 25px;

      margin-top: 20px;
    }

    footer span {

      color: #e9c46a;

      font-weight: bold;
    }


    /* =========================
       TABLET
       ========================= */

    @media (max-width: 1000px) {

      .restaurant-container {

        grid-template-columns: repeat(2, minmax(0, 1fr));

        width: 90%;

        gap: 22px;
      }

      .restaurant-card img {

        height: 220px;
      }
    }


    /* =========================
       MOBILE
       ========================= */

    @media (max-width: 650px) {

      .navbar {

        flex-direction: column;

        gap: 15px;

        padding: 18px 20px;
      }

      .nav-links {

        gap: 14px;

        flex-wrap: wrap;

        justify-content: center;
      }

      .nav-links a {

        font-size: 14px;
      }

      .hero {

        padding: 50px 20px;
      }

      .hero h1 {

        font-size: 32px;
      }

      .hero p {

        font-size: 16px;
      }

      .restaurant-container {

        grid-template-columns: 1fr;

        width: 90%;

        gap: 22px;
      }

      .restaurant-card img {

        height: 240px;
      }
    }

  </style>

</head>


<body>


  <!-- =========================
       NAVIGATION BAR
       ========================= -->

  <nav class="navbar">

    <div class="logo">
      Foodify
    </div>

    <ul class="nav-links">

      <li>
        <a href="#home">Home</a>
      </li>

      <li>
        <a href="#restaurants">Restaurants</a>
      </li>

      <li>
        <a href="cart.jsp">Cart 🛒</a>
      </li>

      <li>
        <a href="profile.jsp">Profile 👤</a>
      </li>

      <% if (session.getAttribute("user") == null) { %>
<li>
  <a href="login.html" class="sign-in">Sign In</a>
</li>
<% } else { %>
<li>
  <a href="<%= request.getContextPath() %>/Logout" class="sign-in">Logout</a>
</li>
<% } %>

    </ul>

  </nav>


  <!-- =========================
       HERO SECTION
       ========================= -->

  <section class="hero" id="home">

    <h1>
      Discover Delicious Food
    </h1>

    <p>
      Order your favorite meals from the best restaurants near you.
    </p>

  </section>


  <!-- =========================
       RESTAURANT SECTION
       ========================= -->

  <section id="restaurants">

    <div class="section-heading">

      <h2>
        Popular Restaurants
      </h2>

      <p>
        Choose from our top-rated restaurants
      </p>

    </div>


    <div class="restaurant-container">


      <% 

      List<Restaurant> allRestaurants =
          (List<Restaurant>)request.getAttribute("allRestaurants");
      
      if (allRestaurants == null) {
    	    response.sendRedirect(request.getContextPath() + "/restaurant");
    	    return;
    	}

      for (Restaurant restaurant : allRestaurants) {

      %>


        <!-- RESTAURANT CARD -->

        <div class="restaurant-card">

          <img
            src="<%= request.getContextPath() + restaurant.getImagePath() %>"
            alt="Italian restaurant"
          />

          <div class="card-content">

            <h3>
              <%= restaurant.getName()%>
            </h3>

            <span class="rating">
              ⭐ <%=restaurant.getRating() %>
            </span>

            <p class="details">

              <%=restaurant.getCuisineType() %>
              <br />

             <%=restaurant.getDeliveryTime() %> min • ₹₹

            </p>

            <p class="address">

              <%=restaurant.getAddress() %>

            </p>

            <a href="Menu?restaurantId=<%= restaurant.getRestaurantId() %>" class="view-menu">
              View Menu
            </a>

          </div>

        </div>


      <% 

      }

      %>


    </div>

  </section>


  <!-- =========================
       FOOTER
       ========================= -->

  <footer>

    <p>
      © 2026
      <span>Foodify</span>.
      All rights reserved.
    </p>

  </footer>


</body>

</html>