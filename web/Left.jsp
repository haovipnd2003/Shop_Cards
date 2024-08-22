<%-- 
    Document   : Left
    Created on : Feb 19, 2024, 4:11:52 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<style>
    .font-weight-bold {
        font-weight: bold;
    }

    .text-primary {
        color: #007bff !important;
    }

    .new-product-card {
        background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
        border: none;
        color: #fff;
        position: relative;
    }

    .new-product-card .card-header {
        background: rgba(0, 0, 0, 0.1);
        border-bottom: none;
        position: relative;
        padding-right: 2.5rem;
    }

    .new-product-card .card-body {
        background: rgba(255, 255, 255, 0.1);
    }

    .new-product-card img {
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .new-product-card .card-title {
        font-weight: bold;
    }

    .new-product-card .bloc_left_price {
        font-size: 1.2rem;
    }

    .fire-icon {
        position: absolute;
        top: 10px;
        right: 10px;
        font-size: 2rem;
        color: #ff3333;
    }

    .filter-card {
        background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
        border: none;
        color: #fff;
        position: relative;
        border-radius: 8px;
        padding: 16px;
        max-width: 300px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .filter-card .card-header {
        background: rgba(0, 0, 0, 0.1);
        border-bottom: none;
        position: relative;
        padding-bottom: 12px;
        margin-bottom: 12px;
        font-size: 20px;
    }

    .filter-card .card-body {
        background: rgba(255, 255, 255, 0.1);
        padding: 8px;
    }

    .filter-card label {
        color: #fff;
        margin-left: 8px;
        cursor: pointer;
    }

    .filter-card input[type="radio"] {
        margin-bottom: 8px;
        cursor: pointer;
    }

    .filter-card .clearfix::after {
        content: "";
        clear: both;
        display: table;
    }
</style>

<div class="col-sm-3">
    <div class="card bg-light mb-3">
        <div class="card-header bg-primary text-white text-uppercase category-toggle" onclick="toggleCategories()">
            <i class="fa fa-list"></i> Categories
            <i id="arrowIcon" class="fa fa-chevron-down float-right"></i>
        </div>

        <ul id="categoryBlock" class="list-group category_block">
            <c:forEach items="${listC}" var="o">
                <c:set var="isSelected" value="${selectedCategoryName == o.name}" />
                <li class="list-group-item">
                    <a href="#" class="category-link ${isSelected ? 'font-weight-bold text-primary' : ''}"
                       data-category="${o.name}" onclick="loadContent(1, '${o.name}'); return false;">${o.name}</a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <br>

    <div class="card new-product-card mb-3">
        <div class="card-header text-uppercase">
            New product
            <i class="fas fa-fire fire-icon"></i>
        </div>
        <div class="card-body text-center">
            <img class="img-fluid mb-3" src="${p.image}" alt="${p.name}" />
            <h5 class="card-title">${p.name}</h5>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var categoryBlock = document.getElementById("categoryBlock");
        var arrowIcon = document.getElementById("arrowIcon");

        // Check session storage for the state
        if (sessionStorage.getItem("categoriesVisible") === "true") {
            categoryBlock.style.display = "block";
            arrowIcon.classList.remove("fa-chevron-down");
            arrowIcon.classList.add("fa-chevron-up");
        } else {
            categoryBlock.style.display = "none";
            arrowIcon.classList.remove("fa-chevron-up");
            arrowIcon.classList.add("fa-chevron-down");
        }
    });

    function toggleCategories() {
        var categoryBlock = document.getElementById("categoryBlock");
        var arrowIcon = document.getElementById("arrowIcon");
        if (categoryBlock.style.display === "none") {
            categoryBlock.style.display = "block";
            arrowIcon.classList.remove("fa-chevron-down");
            arrowIcon.classList.add("fa-chevron-up");
            sessionStorage.setItem("categoriesVisible", "true");
        } else {
            categoryBlock.style.display = "none";
            arrowIcon.classList.remove("fa-chevron-up");
            arrowIcon.classList.add("fa-chevron-down");
            sessionStorage.setItem("categoriesVisible", "false");
        }
    }

    function loadContent(page, category) {
        $.ajax({
            url: 'home',
            type: 'GET',
            data: {
                page: page,
                catename: category,
            },
            success: function (response) {
                $('#content').html($(response).find('#content').html());
                var breadcrumbHtml = '<li class="breadcrumb-item"><a href="home">Home</a></li>';
                if (category) {
                    breadcrumbHtml += '<li class="breadcrumb-item">' + category + '</li>';
                }
                $('.breadcrumb').html(breadcrumbHtml);
                window.history.pushState("", "", '?page=' + page + '&catename=' + category);

                // Highlight the selected category
                $('.category-link').removeClass('font-weight-bold text-primary');
                $('.category-link[data-category="' + category + '"]').addClass('font-weight-bold text-primary');
            }
        });
    }

    function getCurrentCategory() {
        return sessionStorage.getItem("selectedCategoryName") || '';
    }
</script>