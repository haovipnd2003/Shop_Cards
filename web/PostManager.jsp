<%-- 
    Document   : PostManager
    Created on : Aug 2, 2024, 5:51:25 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post Management</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/usermanager.css" rel="stylesheet" />
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
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
            function changePostStatus(postId, newStatus) {
                $.ajax({
                    url: 'changepoststatus',
                    type: 'POST',
                    data: {id: postId, status: newStatus},
                    success: function (response) {
                        if (response === "success") {
                            location.reload();
                        } else {
                            alert("Failed to change status. Please try again.");
                        }
                    },
                    error: function () {
                        alert("An error occurred. Please try again.");
                    }
                });
            }

            function reloadPage() {
                // Reload the page when the form is submitted
                document.getElementById('submitForm').submit();
            }
        </script>
    </head>
    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2> <a href="home" style="color: white; margin-right: 20px;"> <span>Home</span></a>  Product Management</h2>
                            </div>
                            <div class="col-sm-6">
                                <a href="#addProductModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>

                            </div>
                        </div>
                    </div>
                    <form class="example" action="searcheditcard"  style="margin:auto;max-width:300px">
                        <input type="text" placeholder="Search.." name="txt">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </form>
                    <br>
                    <p>
                        <%
                            String message = (String) session.getAttribute("message1");
                            if (message != null) {
                                out.print(message);
                            } else {
                                out.print("");
                            }
                        %>
                    </p>
                    <table class="table table-striped table-hover">

                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Image</th>
                                <th>Paragraph</th>
                                <th>Created By</th>
                                <th>Created At</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.listB}" var = "b">
                            <tr>
                                <td>${b.id}</td>
                                <td>${b.title}</td>
                                <td><img src="${b.image}" width="80px", height="100px" alt="" /></td>
                                <td>${b.paragraph}</td>
                                <td>${b.createdBy}</td>
                                <td>${b.createdAt}</td>
                                <td>
                            <c:if test="${b.isActive == 1}">
                                <button class="btn btn-danger" onclick="changePostStatus(${b.id}, 0)">Hide</button>
                            </c:if>
                            <c:if test="${b.isActive == 0}">
                                <button class="btn btn-success" onclick="changePostStatus(${b.id}, 1)">Show</button>
                            </c:if>
                            </td>
                            <td>
                                <a href="deletepost?id=${b.id}" >Delete</a>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="updatepost?id=${b.id}">Update</a>
                            </td>
                            </tr>
                        </c:forEach>    
                        </tbody>
                    </table>

                </div>
            </div> 
        </div>
    </body>
</html>
