<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Your Website</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
            .navbar {
                padding: 1rem 0; /* Add padding to the navbar */
            }
            .search-bar {
                width: 70%; /* Increase width of search bar */
            }
            .search-bar .input-group {
                width: 100%; /* Full width for input group */
                max-width: 600px; /* Limit max width for larger screens */
                margin: auto; /* Center align */
            }
            .input-group-append .btn-number {
                background-color: #28a745; /* Green background */
                color: white; /* White text */
            }
            .input-group-append .btn-number:hover {
                background-color: #218838; /* Darker green on hover */
            }
            .balance-container {
                display: flex;
                align-items: center;
                color: white;
                margin-right: 1rem;
                line-height: 30px; /* Adjust to match the navbar height */
            }
            .balance-container .balance {
                margin-right: 0.5rem; /* Margin to the right of the balance */
            }
            .btn-recharge {
                background-color: #ffc107; /* Yellow background */
                color: black; /* Black text */
                border-radius: 50%; /* Round button */
                padding: 0.5rem; /* Padding for better appearance */
                font-size: 1rem; /* Increase font size */
                display: flex;
                align-items: center;
                justify-content: center;
                width: 30px; /* Fixed width */
                height: 30px; /* Fixed height */
                line-height: 1; /* Đảm bảo không làm lệch phần tử */
            }
            .nav-item {
                display: flex;
                align-items: center; /* Đảm bảo căn chỉnh theo chiều dọc */
            }
            .btn-recharge:hover {
                background-color: #e0a800; /* Darker yellow on hover */
            }
            .btn-success {
                position: relative;
                background-color: #28a745;
                border-color: #28a745;
                transition: all 0.3s ease;
            }

            .btn-success:hover {
                background-color: #218838;
                border-color: #1e7e34;
                transform: translateY(-2px);
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .cart-link {
                display: flex;
                align-items: center;
                color: #fff;
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

            .cart-link:hover {
                background-color: rgba(255, 255, 255, 0.1);
                color: #fff;
            }

            .cart-icon-wrapper {
                position: relative;
                margin-right: 8px;
            }

            .fa-shopping-cart {
                font-size: 20px;
            }

            .cart-count {
                position: absolute;
                top: -8px;
                right: -8px;
                background-color: #ffc107;
                color: #343a40;
                border-radius: 50%;
                padding: 2px 6px;
                font-size: 12px;
                font-weight: bold;
                min-width: 18px;
                text-align: center;
            }

            .cart-text {
                font-size: 14px;
                font-weight: 500;
            }
        </style>
        <script>
            function getCartItemCount() {
                var cookies = document.cookie.split(';');
                for (var i = 0; i < cookies.length; i++) {
                    var cookie = cookies[i].trim();
                    if (cookie.indexOf('id=') === 0) {
                        var items = cookie.substring(3).split('-');
                        return items.length;
                    }
                }
                return 0;
            }

            function updateCartCount() {
                var count = getCartItemCount();
                var cartCountElement = document.getElementById('cartCount');
                if (cartCountElement) {
                    cartCountElement.textContent = count;
                    cartCountElement.style.display = count > 0 ? 'inline' : 'none';
                }
            }

            document.addEventListener('DOMContentLoaded', updateCartCount);
        </script>
    </head>
    <body>
        <!--begin of menu-->
        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="home">
                    <img src="image/logo.jpg" alt="SHOPCARDS Logo" style="height: 40px;"> <!-- Adjust the height as needed -->
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarsExampleDefault">
                    <form action="search" method="post" class="form-inline my-2 my-lg-0 mx-auto search-bar">
                        <div class="input-group">
                            <input id="searchInput" name="txt" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm" placeholder="Search...">
                            <div class="input-group-append">
                                <button type="submit" class="btn btn-number">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div>
                        <a class="cart-link" href="print">
                            <div class="cart-icon-wrapper">
                                <i class="fa fa-shopping-cart"></i>
                                <span id="cartCount" class="cart-count"></span>
                            </div>
                            <span class="cart-text">Cart</span>
                        </a>
                    </form>

                    <ul class="navbar-nav ml-auto">
                        <%
                            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
                            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
                            response.setDateHeader("Expires", 0); // Proxies
                        %>

                        <c:if test="${sessionScope.acc != null}">
                            <li class="nav-item">
                                <div class="balance-container">
                                    <span class="balance">Balance: ${sessionScope.acc.balance}</span>
                                    <a href="EnterMoney.jsp" class="btn btn-recharge">+</a>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Menu
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <c:if test="${sessionScope.acc.isAdmin == 1}">
                                        <a class="dropdown-item" href="usermanager">Manage Account</a>
                                        <a class="dropdown-item" href="manager">Manage Product</a>
                                        <a class="dropdown-item" href="category">Manage Category</a>
                                        <a class="dropdown-item" href="manageInventProduct">Inventory</a>
                                        <a class="dropdown-item" href="managepost">Manage Post</a>
                                    </c:if>
                                    <a class="dropdown-item" href="listpost">News</a>
                                    <a class="dropdown-item" href="changepassword?id=${sessionScope.acc.id}">Change password</a>
                                    <a class="dropdown-item" href="profile?id=${sessionScope.acc.id}">Edit profile ${sessionScope.acc.user}</a>
                                    <a class="dropdown-item" href="transactionHistory">Purchase history</a>
                                    <a class="dropdown-item" href="transaction-history">Transaction history</a>
                                    <a class="dropdown-item" href="logout">Logout</a>
                                    <a class="dropdown-item" href="contact">Contact</a>
                                    <div class="dropdown-divider"></div>
                                </div>
                            </li>
                        </c:if>

                        <c:if test="${sessionScope.acc == null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="guestDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-user"></i> <!-- User icon -->
                                </a>
                                <div class="dropdown-menu" aria-labelledby="guestDropdown">
                                    <a class="dropdown-item" href="listpost">News</a>
                                    <a class="dropdown-item" href="login">Login</a>
                                    <a class="dropdown-item" href="signup">Sign Up</a>
                                    <!--                            <a class="dropdown-item" href="contact">Contact</a>-->
                                </div>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="Guide.jsp">Guide</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Policy.jsp">Policy</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <section class="jumbotron text-center">
            <div class="container">
                <h1 class="jumbotron-heading">Reputable card store</h1>
                <p class="lead text-muted mb-0">Prestige creates a brand with more than 10 years of providing card products of all kinds</p>
            </div>
        </section>
        <script>
            $(document).ready(function () {
                $('#searchInput').on('keyup', function () {
                    var searchText = $(this).val();
                    $.ajax({
                        url: 'search',
                        type: 'POST',
                        data: {txt: searchText},
                        success: function (response) {
                            $('#content').html($(response).find('#content').html());
                        }
                    });
                });
            });
        </script>
        <!--end of menu-->
    </body>
</html>