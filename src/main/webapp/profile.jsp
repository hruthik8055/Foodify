<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="com.food.model.User" %>

<%
    User user = (User) request.getAttribute("user");

    if (user == null) {
        response.sendRedirect("profile");
        return;
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Profile | Foodify</title>

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
            max-width: 850px;
            margin: 40px auto;
            padding: 0 20px;
            min-height: 65vh;
        }

        .page-heading {
            margin-bottom: 25px;
        }

        .page-heading h1 {
            color: #073b3a;
            margin-bottom: 8px;
        }

        .page-heading p {
            color: #6b7777;
            line-height: 1.6;
        }

        .profile-card {
            background: white;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 8px 28px rgba(0, 0, 0, 0.07);
        }

        .avatar {
            width: 85px;
            height: 85px;
            border-radius: 50%;
            background: #073b3a;
            color: #f5c542;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .profile-card h2 {
            color: #073b3a;
            margin-bottom: 8px;
        }

        .subtitle {
            color: #7b8585;
            margin-bottom: 28px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 9px;
            font-size: 14px;
            font-weight: bold;
            color: #263238;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #d8dfdc;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            background: white;
            color: #263238;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #073b3a;
            box-shadow: 0 0 0 3px rgba(7, 59, 58, 0.08);
        }

        .form-group input[readonly] {
            background: #f2f4f2;
            color: #6b7777;
            cursor: not-allowed;
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .help-text {
            font-size: 12px;
            color: #7b8585;
            margin-top: 7px;
        }

        .alert {
            padding: 14px 16px;
            border-radius: 8px;
            margin-bottom: 22px;
            line-height: 1.5;
        }

        .success {
            background: #e3f5e9;
            color: #176b48;
        }

        .error {
            background: #fdeaea;
            color: #a12626;
        }

        .actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 28px;
        }

        .btn {
            display: inline-block;
            border: none;
            border-radius: 8px;
            padding: 14px 22px;
            font-size: 15px;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
            text-align: center;
        }

        .primary-btn {
            background: #073b3a;
            color: white;
        }

        .primary-btn:hover {
            background: #0b5552;
        }

        .secondary-btn {
            background: #f5c542;
            color: #073b3a;
        }

        .secondary-btn:hover {
            background: #e6b52f;
        }

        footer {
            text-align: center;
            padding: 25px 15px;
            color: #7b8585;
            font-size: 13px;
        }

        @media (max-width: 600px) {
            .navbar {
                padding: 18px 5%;
            }

            .container {
                margin: 25px auto;
                padding: 0 14px;
            }

            .profile-card {
                padding: 24px 18px;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
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

        <div class="page-heading">
            <h1>My Profile</h1>
            <p>View and update your personal information.</p>
        </div>

        <section class="profile-card">

            <div class="avatar">
                <%= user.getName() != null && !user.getName().trim().isEmpty()
                    ? user.getName().trim().substring(0, 1).toUpperCase()
                    : "U" %>
            </div>

            <h2>Personal Information</h2>
            <p class="subtitle">
                Update your name and delivery address below.
            </p>

            <% if ("updated".equals(success)) { %>
                <div class="alert success">
                    Your profile update was submitted successfully.
                    Please verify that the displayed information is correct.
                </div>
            <% } %>

            <% if ("required".equals(error)) { %>
                <div class="alert error">
                    Name and address are required.
                </div>
            <% } %>

            <% if ("length".equals(error)) { %>
                <div class="alert error">
                    Your name must be at most 100 characters and your
                    address must be at most 255 characters.
                </div>
            <% } %>

            <% if ("update".equals(error)) { %>
                <div class="alert error">
                    We couldn't reload your updated profile.
                    Please check your details and try again.
                </div>
            <% } %>

            <form action="profile" method="post">

                <div class="form-group">
                    <label for="name">Full Name</label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        value="<%= user.getName() == null ? "" : user.getName() %>"
                        maxlength="100"
                        required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>

                    <input
                        type="email"
                        id="email"
                        value="<%= user.getEmail() == null ? "" : user.getEmail() %>"
                        readonly>

                    <p class="help-text">
                        Your email address cannot be changed here.
                    </p>
                </div>

                <div class="form-group">
                    <label for="address">Delivery Address</label>

                    <textarea
                        id="address"
                        name="address"
                        maxlength="255"
                        required><%= user.getAddress() == null ? "" : user.getAddress() %></textarea>
                </div>

                <div class="form-group">
                    <label for="role">Account Role</label>

                    <input
                        type="text"
                        id="role"
                        value="<%= user.getRole() == null ? "" : user.getRole() %>"
                        readonly>
                </div>

                <div class="actions">
                    <button type="submit" class="btn primary-btn">
                        Save Changes
                    </button>

                    <a href="my-orders" class="btn secondary-btn">
                        My Orders
                    </a>
                </div>

            </form>

        </section>

    </main>

    <footer>
        &copy; 2026 Foodify. Good Food, Happy Mood!
    </footer>

</body>
</html>