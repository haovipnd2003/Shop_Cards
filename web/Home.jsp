<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

        <style>
            /* Add custom styles */
            .card {
                margin-bottom: 20px;
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s, box-shadow 0.2s;
            }
            .card:hover {
                transform: scale(1.05);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }
            .card-img-top {
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
            }
            .card-title a {
                color: #333;
                text-decoration: none;
                transition: color 0.2s;
            }
            .card-title a:hover {
                color: #007bff;
            }
            .btn-block {
                font-size: 1rem;
                font-weight: bold;
                padding: 10px;
                border-radius: 5px;
                transition: background-color 0.2s;
            }
            .btn-danger {
                background-color: #dc3545;
                border: none;
            }
            .btn-danger:hover {
                background-color: #c82333;
            }
            .btn-success {
                background-color: #28a745;
                border: none;
            }
            .btn-success:hover {
                background-color: #218838;
            }
            .breadcrumb {
                background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
                border-radius: 5px;
            }
            .breadcrumb a {
                color: #fff;
            }
            .breadcrumb-item.active {
                color: #fff;
            }
            .category_block li {
                background-color: #f8f9fa;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-bottom: 5px;
                transition: background-color 0.2s;
            }
            .category_block li:hover, .category_block .active {
                background-color: #007bff;
                color: #fff;
            }
            .category_block li a {
                color: inherit;
                display: block;
                padding: 10px;
                text-decoration: none;
            }
            .new-product-card {
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                border: none;
                color: #fff;
                border-radius: 10px;
                overflow: hidden;
                transition: transform 0.2s, box-shadow 0.2s;
            }
            .new-product-card:hover {
                transform: scale(1.05);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }
            .new-product-card .card-header {
                background: rgba(0, 0, 0, 0.1);
                border-bottom: none;
            }
            .new-product-card .card-body {
                background: rgba(255, 255, 255, 0.1);
            }
            .new-product-card img {
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .new-product-card .card-title {
                font-weight: bold;
            }
            .new-product-card .bloc_left_price {
                font-size: 1.2rem;
            }
        </style>
        <script>

            $(document).ready(function () {
                $(document).on('click', '.page-link', function (e) {
                    e.preventDefault();
                    var page = $(this).data('page');
                    var category = $(this).data('category');
                    loadContent(page, category);
                });

                $(document).on('click', '.category-link', function (e) {
                    e.preventDefault();
                    var category = $(this).data('category');
                    loadContent(1, category); // Load the first page of the selected category
                });
            });
            function clearFiltersAndLoadHome() {
                // Clear session storage
                sessionStorage.setItem("selectedCategoryName", "");
                sessionStorage.setItem("selectedPrice", "");

                // Uncheck all price radio buttons
                $('input[name="price"]').prop('checked', false);

                // Remove highlighting from categories
                $('.category-link').removeClass('font-weight-bold text-primary');

                // Load home page content with a flag to indicate clearing filters
                window.location.href = 'home?clearFilters=true';
            }
            document.addEventListener('DOMContentLoaded', function () {
                var homeLink = document.querySelector('.breadcrumb-item a[href="#"]');
                if (homeLink) {
                    homeLink.addEventListener('click', function (e) {
                        e.preventDefault();
                        clearFiltersAndLoadHome();
                    });
                }
            });
        </script>
        <style>
            .popup {
                display: none;
                position: fixed;
                bottom: 20px;
                right: 20px;
                width: 300px;
                padding: 20px;
                color: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                z-index: 9999;
                animation: slide-in 0.5s ease-out, fade-out 0.5s ease-out 2.5s forwards;
            }

            .popup.success {
                background-color: #28a745;
            }

            .popup.failure {
                background-color: #dc3545;
            }

            .popup p {
                margin: 0;
            }

            .popup .progress {
                height: 5px;
                background-color: rgba(255, 255, 255, 0.3);
                border-radius: 5px;
                overflow: hidden;
                margin-top: 10px;
            }

            .popup .progress .progress-bar {
                height: 100%;
                background-color: #fff;
                animation: progress-bar 2.5s linear forwards;
            }

            @keyframes slide-in {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

            @keyframes fade-out {
                to {
                    opacity: 0;
                }
            }

            @keyframes progress-bar {
                from {
                    width: 100%;
                }
                to {
                    width: 0;
                }
            }
            .out-of-stock-container {
                position: relative;
            }

            .out-of-stock-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(255, 255, 255, 0.7);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1;
            }

            .out-of-stock-overlay span {
                background-color: #ff0000;
                color: white;
                padding: 5px 10px;
                font-weight: bold;
                text-transform: uppercase;
                transform: rotate(-45deg);
                font-size: 14px;
            }

            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
                cursor: not-allowed;
            }

            .btn-secondary:hover {
                background-color: #5a6268;
                border-color: #545b62;
            }
        </style>
        <script>
            // Function hiển thị popup thành công
            function showSuccessPopup() {
                var popup = document.getElementById('successPopup');
                popup.style.display = 'block';
                setTimeout(function () {
                    popup.style.display = 'none';
                }, 2000); // Sau 2 giây tự động ẩn popup
            }

            function addToCart(productId) {
                $.ajax({
                    url: 'cart',
                    type: 'GET',
                    data: {id: productId},
                    success: function (response) {
                        var parts = response.split('|');
                        if (parts[0].trim() === 'success') {
                            showSuccessPopup();
                            updateCartCount();
                            // Update the cart count display
                            var cartCountElement = document.getElementById('cartCount');
                            if (cartCountElement) {
                                cartCountElement.textContent = parts[1];
                                cartCountElement.style.display = 'inline';
                            }
                        } else {
                            showFailurePopup("The quantity in the shopping cart has been max!");
                        }
                    },
                    error: function () {
                        showFailurePopup("Erorr.Please try again!");
                    }
                });
                return false;
            }

            function showFailurePopup(message) {
                var popup = document.getElementById('failurePopup');
                popup.querySelector('p').textContent = message;
                popup.style.display = 'block';
                setTimeout(function () {
                    popup.style.display = 'none';
                }, 2000);
            }

            //Search Ajax
            function searchByName(param) {
                var txtSearch = param.value;
                $.ajax({
                    url: "/ShopCards/searchAjax",
                    type: "get", //send it through get method
                    data: {
                        txt: txtSearch
                    },
                    success: function (data) {
                        var row = document.getElementById("content");
                        row.innerHTML = data;
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });
            }
        </script>

    </head>
    <body>
        <%
            response.setHeader("Cache-Control","no-cache");
            response.setHeader("Cache-Control","no-store");
            response.setHeader("Pragma","no-cache");
            response.setDateHeader("Expire",0);
        %>
        <jsp:include page="Menu.jsp"></jsp:include>
            <div class="container">
                <div class="row">
                    <div class="col">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="home">Home</a></li>
                                <c:if test="${not empty selectedCategoryName}">
                                <li class="breadcrumb-item">${selectedCategoryName}</li>
                                </c:if>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>    

        <div class="container">
            <div class="row">
                <jsp:include page="Left.jsp"></jsp:include>
                    <div id="content" class="col-sm-9">
                        <div class="row">
                        <c:forEach items="${listP}" var="o">
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="card">
                                    <img class="card-img-top" src="${o.image}" alt="Card image cap">
                                    <div class="card-body">
                                        <h4 class="card-title show_txt"><a title="View Product">${o.name}</a></h4>
                                            <c:choose>
                                                <c:when test="${productAvailability[o.id]}">
                                                <div class="row">
                                                    <div class="col">
                                                        <p class="btn btn-danger btn-block">${o.price}</p>
                                                    </div>
                                                    <div class="col">
                                                        <a href="cart?id=${o.id}" class="btn btn-success btn-block" onclick="return addToCart('${o.id}')">Add to cart</a>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="out-of-stock-container">
                                                    <div class="out-of-stock-overlay">
                                                        <span>Sold Out</span>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <p class="btn btn-secondary btn-block" disabled>Sold Out</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="#" data-page="${currentPage - 1}" data-category="${catename}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>

                            <c:choose>
                                <c:when test="${totalPages <= 3}">
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="#" data-page="${i}" data-category="${selectedCategoryName}">${i}</a>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="startPage" value="${currentPage - 1 > 0 ? currentPage - 1 : 1}" />
                                    <c:set var="endPage" value="${startPage + 2 > totalPages ? totalPages : startPage + 2}" />

                                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="#" data-page="${i}" data-category="${selectedCategoryName}">${i}</a>
                                        </li>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="#" data-page="${currentPage + 1}" data-category="${selectedCategoryName}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Popup thông báo thành công -->
        <div class="popup success" id="successPopup">
            <p>Add to cart successfully!</p>
            <div class="progress">
                <div class="progress-bar"></div>
            </div>
        </div>
        <!-- Popup thông báo thất bại -->
        <div class="popup failure" id="failurePopup">
            <p>Add to cart fail!</p>
            <div class="progress">
                <div class="progress-bar"></div>
            </div>
        </div>

        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>