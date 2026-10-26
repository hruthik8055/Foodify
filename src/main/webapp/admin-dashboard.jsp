<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Menu" %>

<%
    // Verify that the user is logged in as a Restaurant Admin.
    Object roleObject = session.getAttribute("role");
    Object restaurantIdObject = session.getAttribute("restaurantId");

    if (!(roleObject instanceof String)
            || !"RESTAURANT_ADMIN".equalsIgnoreCase((String) roleObject)
            || !(restaurantIdObject instanceof Integer)) {

        response.sendRedirect("login.html");
        return;
    }

    List<Menu> menus = (List<Menu>) request.getAttribute("menus");

    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Foodify | Restaurant Admin</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            background: #f5f7fa;
            color: #263238;
        }

        header {
            background: #123c3a;
            color: white;
            padding: 20px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .logo {
            font-size: 27px;
            font-weight: bold;
            color: #ffc857;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .logout {
            background: #ffc857;
            color: #123c3a;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 7px;
            font-weight: bold;
        }

        .container {
            max-width: 1200px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .welcome {
            margin-bottom: 25px;
        }

        .welcome h1 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .welcome p {
            color: #667085;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.05);
        }

        .stat-card h3 {
            color: #667085;
            font-size: 14px;
            margin-bottom: 12px;
        }

        .stat-card p {
            font-size: 28px;
            font-weight: bold;
            color: #123c3a;
        }

        .panel {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.05);
        }

        .panel h2 {
            margin-bottom: 20px;
            font-size: 22px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        label {
            font-size: 14px;
            font-weight: bold;
        }

        input, textarea, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #d0d5dd;
            border-radius: 7px;
            font-size: 14px;
            background: white;
        }

        textarea {
            resize: vertical;
            min-height: 85px;
        }

        .checkbox-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 12px;
        }

        .checkbox-row input {
            width: auto;
        }

        .btn {
            border: none;
            padding: 11px 17px;
            border-radius: 7px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: #123c3a;
            color: white;
        }

        .btn-primary:hover {
            background: #1b5753;
        }

        .btn-edit {
            background: #e6f4ff;
            color: #0958a5;
        }

        .btn-delete {
            background: #fff0f0;
            color: #b42318;
        }

        .btn-cancel {
            background: #eaecf0;
            color: #344054;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 760px;
        }

        th, td {
            padding: 15px 12px;
            text-align: left;
            border-bottom: 1px solid #eaecf0;
            vertical-align: middle;
        }

        th {
            background: #f8fafc;
            color: #475467;
            font-size: 13px;
        }

        td {
            font-size: 14px;
        }

        .food-image {
            width: 65px;
            height: 55px;
            object-fit: cover;
            border-radius: 8px;
        }

        .status {
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .available {
            background: #dcfae6;
            color: #067647;
        }

        .unavailable {
            background: #fee4e2;
            color: #b42318;
        }

        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .actions form {
            display: inline;
        }

        .message {
            background: #dcfae6;
            color: #067647;
            padding: 14px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .empty {
            text-align: center;
            padding: 35px 10px;
            color: #667085;
        }

        footer {
            text-align: center;
            padding: 25px;
            color: #667085;
        }

        @media (max-width: 650px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full {
                grid-column: auto;
            }

            .welcome h1 {
                font-size: 25px;
            }

            .panel {
                padding: 18px;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="logo">Foodify</div>

    <div class="header-right">
        <span>Restaurant Admin</span>
        <a class="logout" href="<%= request.getContextPath() %>/Logout">
            Logout
        </a>
    </div>
</header>

<main class="container">

    <section class="welcome">
        <h1>Restaurant Dashboard 👋</h1>
        <p>Manage your restaurant's menu items from one place.</p>
    </section>

    <% if ("1".equals(success)) { %>
        <div class="message">
            Operation completed successfully!
        </div>
    <% } %>

    <section class="stats">
        <div class="stat-card">
            <h3>Total Menu Items</h3>
            <p><%= menus == null ? 0 : menus.size() %></p>
        </div>

        <div class="stat-card">
            <h3>Available Items</h3>
            <p>
                <%
                    int availableCount = 0;

                    if (menus != null) {
                        for (Menu menu : menus) {
                            if (menu.isAvailable()) {
                                availableCount++;
                            }
                        }
                    }
                %>
                <%= availableCount %>
            </p>
        </div>

        <div class="stat-card">
            <h3>Unavailable Items</h3>
            <p>
                <%= menus == null ? 0 : menus.size() - availableCount %>
            </p>
        </div>
    </section>

    <!-- ADD MENU ITEM FORM -->

    <section class="panel">
        <h2>➕ Add a Menu Item</h2>

        <form action="<%= request.getContextPath() %>/restaurantAdminMenu"
              method="post">

            <input type="hidden" name="action" value="add">

            <div class="form-grid">

                <div class="form-group">
                    <label for="itemName">Item Name *</label>
                    <input type="text" id="itemName" name="itemName"
                           maxlength="100" required>
                </div>

                <div class="form-group">
                    <label for="price">Price (₹) *</label>
                    <input type="number" id="price" name="price"
                           min="0" step="0.01" required>
                </div>

                <div class="form-group full">
                    <label for="description">Description</label>
                    <textarea id="description" name="description"
                              maxlength="255"></textarea>
                </div>

                <div class="form-group">
                    <label for="rating">Rating (0–5)</label>
                    <input type="number" id="rating" name="rating"
                           min="0" max="5" step="0.1" value="0" required>
                </div>

                <div class="form-group">
                    <label for="imagePath">Image Path</label>
                    <input type="text" id="imagePath" name="imagePath"
                           maxlength="255"
                           placeholder="images/menu/item.jpg">
                </div>

            </div>

            <div class="checkbox-row">
                <input type="checkbox" id="isAvailable"
                       name="isAvailable" value="true" checked>
                <label for="isAvailable">Item is available</label>
            </div>

            <br>

            <button class="btn btn-primary" type="submit">
                Add Menu Item
            </button>

        </form>
    </section>


    <!-- EXISTING MENU ITEMS -->

    <section class="panel">
        <h2>🍽️ Your Menu Items</h2>

        <% if (menus == null || menus.isEmpty()) { %>

            <div class="empty">
                <h3>No menu items found</h3>
                <p>Add your first menu item using the form above.</p>
            </div>

        <% } else { %>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Item</th>
                            <th>Price</th>
                            <th>Rating</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>

                    <tbody>

                    <% for (Menu menu : menus) { %>

                        <tr>
                            <td>
                                <% if (menu.getImagePath() != null
                                        && !menu.getImagePath().trim().isEmpty()) { %>

                                    <img class="food-image"
                                         src="<%= request.getContextPath() %>/<%=
                                             menu.getImagePath().replace("&", "&amp;")
                                                 .replace("\"", "&quot;")
                                                 .replace("<", "&lt;")
                                                 .replace(">", "&gt;")
                                         %>"
                                         alt="Food item">

                                <% } else { %>
                                    No image
                                <% } %>
                            </td>

                            <td>
                                <strong><%= menu.getItemName() %></strong>
                                <br>
                                <small>
                                    <%= menu.getDescription() == null
                                            ? ""
                                            : menu.getDescription() %>
                                </small>
                            </td>

                            <td>₹<%= menu.getPrice() %></td>

                            <td>⭐ <%= menu.getRating() %></td>

                            <td>
                                <% if (menu.isAvailable()) { %>
                                    <span class="status available">
                                        Available
                                    </span>
                                <% } else { %>
                                    <span class="status unavailable">
                                        Unavailable
                                    </span>
                                <% } %>
                            </td>

                            <td>
                                <div class="actions">

                                    <button type="button"
                                            class="btn btn-edit"
                                            onclick="editMenu(
                                                '<%= menu.getMenuId() %>',
                                                '<%= menu.getItemName()
                                                    .replace("\\", "\\\\")
                                                    .replace("'", "\\'")
                                                    .replace("\r", "")
                                                    .replace("\n", "\\n")
                                                    .replace("<", "&lt;")
                                                    .replace(">", "&gt;") %>',
                                                '<%= menu.getDescription() == null
                                                    ? ""
                                                    : menu.getDescription()
                                                        .replace("\\", "\\\\")
                                                        .replace("'", "\\'")
                                                        .replace("\r", "")
                                                        .replace("\n", "\\n")
                                                        .replace("<", "&lt;")
                                                        .replace(">", "&gt;") %>',
                                                '<%= menu.getPrice() %>',
                                                '<%= menu.getRating() %>',
                                                '<%= menu.getImagePath() == null
                                                    ? ""
                                                    : menu.getImagePath()
                                                        .replace("\\", "\\\\")
                                                        .replace("'", "\\'")
                                                        .replace("\r", "")
                                                        .replace("\n", "\\n")
                                                        .replace("<", "&lt;")
                                                        .replace(">", "&gt;") %>',
                                                '<%= menu.isAvailable() %>'
                                            )">
                                        Edit
                                    </button>

                                    <form action="<%= request.getContextPath() %>/restaurantAdminMenu"
                                          method="post"
                                          onsubmit="return confirm('Delete this menu item?');">

                                        <input type="hidden" name="action"
                                               value="delete">

                                        <input type="hidden" name="menuId"
                                               value="<%= menu.getMenuId() %>">

                                        <button type="submit"
                                                class="btn btn-delete">
                                            Delete
                                        </button>
                                    </form>

                                </div>
                            </td>
                        </tr>

                    <% } %>

                    </tbody>
                </table>
            </div>

        <% } %>
    </section>


    <!-- EDIT MENU ITEM FORM -->

    <section class="panel" id="editPanel" style="display:none;">

        <h2>✏️ Edit Menu Item</h2>

        <form action="<%= request.getContextPath() %>/restaurantAdminMenu"
              method="post">

            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editMenuId" name="menuId">

            <div class="form-grid">

                <div class="form-group">
                    <label for="editItemName">Item Name *</label>
                    <input type="text" id="editItemName" name="itemName"
                           maxlength="100" required>
                </div>

                <div class="form-group">
                    <label for="editPrice">Price (₹) *</label>
                    <input type="number" id="editPrice" name="price"
                           min="0" step="0.01" required>
                </div>

                <div class="form-group full">
                    <label for="editDescription">Description</label>
                    <textarea id="editDescription" name="description"
                              maxlength="255"></textarea>
                </div>

                <div class="form-group">
                    <label for="editRating">Rating (0–5)</label>
                    <input type="number" id="editRating" name="rating"
                           min="0" max="5" step="0.1" required>
                </div>

                <div class="form-group">
                    <label for="editImagePath">Image Path</label>
                    <input type="text" id="editImagePath" name="imagePath"
                           maxlength="255">
                </div>

            </div>

            <div class="checkbox-row">
                <input type="checkbox" id="editIsAvailable"
                       name="isAvailable" value="true">
                <label for="editIsAvailable">Item is available</label>
            </div>

            <br>

            <button class="btn btn-primary" type="submit">
                Save Changes
            </button>

            <button class="btn btn-cancel" type="button"
                    onclick="document.getElementById('editPanel').style.display='none';">
                Cancel
            </button>

        </form>
    </section>

</main>

<footer>
    © 2026 Foodify | Restaurant Management
</footer>

<script>
    function editMenu(id, name, description, price, rating, imagePath, available) {
        document.getElementById("editMenuId").value = id;
        document.getElementById("editItemName").value = name;
        document.getElementById("editDescription").value = description;
        document.getElementById("editPrice").value = price;
        document.getElementById("editRating").value = rating;
        document.getElementById("editImagePath").value = imagePath;
        document.getElementById("editIsAvailable").checked = available === "true";

        const panel = document.getElementById("editPanel");
        panel.style.display = "block";
        panel.scrollIntoView({ behavior: "smooth" });
    }
</script>

</body>
</html>