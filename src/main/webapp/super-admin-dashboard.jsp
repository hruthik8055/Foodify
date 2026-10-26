<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Restaurant" %>

<%
    HttpSession adminSession = request.getSession(false);

    if (adminSession == null ||
        !"SUPER_ADMIN".equals(adminSession.getAttribute("role"))) {

        response.sendRedirect(request.getContextPath() + "/login.html");
        return;
    }

    List<Restaurant> restaurants =
        (List<Restaurant>) request.getAttribute("restaurants");

    Integer totalRestaurants =
        (Integer) request.getAttribute("totalRestaurants");

    Integer activeRestaurants =
        (Integer) request.getAttribute("activeRestaurants");

    Integer totalCustomers =
        (Integer) request.getAttribute("totalCustomers");

    Integer totalRestaurantAdmins =
        (Integer) request.getAttribute("totalRestaurantAdmins");

    if (restaurants == null) {
        response.sendRedirect(
            request.getContextPath() + "/superAdminDashboard"
        );
        return;
    }
%>
<%
    String success = request.getParameter("success");

    if ("restaurantAdded".equals(success)) {
%>
    <div style="background:#dcfce7; color:#166534;
                padding:12px; margin-bottom:20px;
                border-radius:6px;">
        Restaurant added successfully!
    </div>
<%
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Foodify | Super Admin Dashboard</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f7f6;
            color: #263238;
        }

        header {
            background: #123c35;
            color: white;
            padding: 22px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        header h1 {
            color: #f6c453;
        }

        header a {
            color: white;
            text-decoration: none;
            padding: 10px 16px;
            border: 1px solid white;
            border-radius: 6px;
        }

        .container {
            width: 90%;
            max-width: 1400px;
            margin: 30px auto;
        }

        .welcome {
            margin-bottom: 25px;
        }

        .welcome h2 {
            margin-bottom: 8px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(
                auto-fit, minmax(200px, 1fr)
            );
            gap: 20px;
            margin-bottom: 35px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.06);
            border-left: 5px solid #16836b;
        }

        .card h3 {
            color: #64748b;
            font-size: 15px;
            margin-bottom: 15px;
        }

        .card p {
            font-size: 30px;
            font-weight: bold;
            color: #123c35;
        }

        .section {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.06);
        }

        .section h2 {
            margin-bottom: 20px;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 750px;
        }

        th, td {
            text-align: left;
            padding: 14px;
            border-bottom: 1px solid #e5e7eb;
        }

        th {
            background: #123c35;
            color: white;
        }

        tr:hover {
            background: #f8fafc;
        }

        .status {
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .active {
            background: #dcfce7;
            color: #166534;
        }

        .inactive {
            background: #fee2e2;
            color: #991b1b;
        }

        .empty {
            padding: 25px;
            text-align: center;
            color: #64748b;
        }

        footer {
            text-align: center;
            padding: 25px;
            color: #64748b;
        }

        @media (max-width: 600px) {
            .container {
                width: 94%;
            }

            .section {
                padding: 15px;
            }
        }
    </style>
</head>

<body>

<header>
    <h1>Foodify 👑</h1>

    <a href="<%= request.getContextPath() %>/Logout">
        Logout
    </a>
</header>

<div class="container">

    <div class="welcome">
        <h2>Super Admin Dashboard</h2>
        <p>Manage restaurants and monitor the Foodify platform.</p>
    </div>

    <!-- Dashboard statistics -->

    <div class="stats">

        <div class="card">
            <h3>Total Restaurants</h3>
            <p><%= totalRestaurants %></p>
        </div>

        <div class="card">
            <h3>Active Restaurants</h3>
            <p><%= activeRestaurants %></p>
        </div>

        <div class="card">
            <h3>Total Customers</h3>
            <p><%= totalCustomers %></p>
        </div>

        <div class="card">
            <h3>Restaurant Admins</h3>
            <p><%= totalRestaurantAdmins %></p>
        </div>

    </div>

    <!-- Restaurant list -->

    <div class="section">

        <h2>Restaurant Management</h2>
        
        <div style="background:#f4f7f6; padding:20px;
            border-radius:10px; margin-bottom:25px;">

    <h3 style="margin-bottom:15px;">Add New Restaurant</h3>

    <form action="<%= request.getContextPath() %>/superAdminRestaurant"
          method="post">
          <input type="hidden" name="action" value="add">

        <div style="display:grid;
                    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
                    gap:15px;">

            <div>
                <label>Restaurant Name *</label>
                <input type="text" name="name" maxlength="100"
                       required
                       style="width:100%;padding:10px;margin-top:6px;">
            </div>

            <div>
                <label>Cuisine Type *</label>
                <input type="text" name="cuisineType" maxlength="100"
                       required
                       style="width:100%;padding:10px;margin-top:6px;">
            </div>

            <div>
                <label>Address *</label>
                <input type="text" name="address" maxlength="255"
                       required
                       style="width:100%;padding:10px;margin-top:6px;">
            </div>

            <div>
                <label>Delivery Time (minutes) *</label>
                <input type="number" name="deliveryTime"
                       min="1" required
                       style="width:100%;padding:10px;margin-top:6px;">
            </div>

            <div>
                <label>Rating (0–5) *</label>
                <input type="number" name="rating"
                       min="0" max="5" step="0.1"
                       value="0" required
                       style="width:100%;padding:10px;margin-top:6px;">
            </div>

            <div>
                <label>Image Path</label>
                <input type="text" name="imagePath" maxlength="255"
                       placeholder="images/restaurant.jpg"
                       style="width:100%;padding:10px;margin-top:6px;">
            </div>

        </div>

        <button type="submit"
                style="margin-top:20px;padding:12px 22px;
                       background:#16836b;color:white;
                       border:none;border-radius:6px;cursor:pointer;">
            + Add Restaurant
        </button>

    </form>
</div>

        <div class="table-wrapper">

            <table>
                <thead>
    <tr>
        <th>ID</th>
        <th>Restaurant Name</th>
        <th>Cuisine</th>
        <th>Address</th>
        <th>Rating</th>
        <th>Delivery Time</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
</thead>

<tbody>

    <% if (restaurants.isEmpty()) { %>

        <tr>
            <td colspan="8" class="empty">
                No restaurants found.
            </td>
        </tr>

    <% } else { %>

        <% for (Restaurant restaurant : restaurants) { %>

            <tr>
                <td>
                    <%= restaurant.getRestaurantId() %>
                </td>

                <td>
                    <%= restaurant.getName() %>
                </td>

                <td>
                    <%= restaurant.getCuisineType() %>
                </td>

                <td>
                    <%= restaurant.getAddress() %>
                </td>

                <td>
                    <%= restaurant.getRating() %>
                </td>

                <td>
                    <%= restaurant.getDeliveryTime() %> min
                </td>

                <td>
                    <% if (restaurant.isActive()) { %>
                        <span class="status active">Active</span>
                    <% } else { %>
                        <span class="status inactive">Inactive</span>
                    <% } %>
                </td>

                <!-- Actions column -->
                <td>

                    <!-- Update Restaurant -->
                    <form action="<%= request.getContextPath() %>/superAdminRestaurant"
                          method="post">

                        <input type="hidden" name="action" value="update">

                        <input type="hidden" name="restaurantId"
                               value="<%= restaurant.getRestaurantId() %>">

                        <input type="text" name="name"
                               value="<%= restaurant.getName() %>"
                               placeholder="Restaurant name"
                               maxlength="100" required>

                        <input type="text" name="cuisineType"
                               value="<%= restaurant.getCuisineType() %>"
                               placeholder="Cuisine"
                               maxlength="100" required>

                        <input type="text" name="address"
                               value="<%= restaurant.getAddress() %>"
                               placeholder="Address"
                               maxlength="255" required>

                        <input type="number" name="deliveryTime"
                               value="<%= restaurant.getDeliveryTime() %>"
                               min="1" required>

                        <input type="number" name="rating"
                               value="<%= restaurant.getRating() %>"
                               min="0" max="5" step="0.1" required>

                        <input type="text" name="imagePath"
                               value="<%= restaurant.getImagePath() == null ? "" : restaurant.getImagePath() %>"
                               placeholder="Image path"
                               maxlength="255">

                        <button type="submit">Update</button>
                    </form>

                    <br>

                    <!-- Activate / Deactivate Restaurant -->
                    <form action="<%= request.getContextPath() %>/superAdminRestaurant"
                          method="post">

                        <input type="hidden" name="action"
                               value="toggleStatus">

                        <input type="hidden" name="restaurantId"
                               value="<%= restaurant.getRestaurantId() %>">

                        <button type="submit">
                            <%= restaurant.isActive()
                                ? "Deactivate"
                                : "Activate" %>
                        </button>

                    </form>

                </td>

            </tr>

        <% } %>

    <% } %>

</tbody>
            </table>

        </div>
    </div>

</div>

<footer>
    &copy; 2026 Foodify. Super Admin Panel.
</footer>

</body>
</html>