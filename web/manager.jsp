<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Product Management</title>
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
            function changeProductStatus(productId, newStatus) {
                $.ajax({
                    url: 'changeproductstatus',
                    type: 'POST',
                    data: {id: productId, status: newStatus},
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
                                <th>Name</th>
                                <th>Image</th>
                                <th>Price</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.listB}" var = "b">
                                <tr>
                                    <td>${b.id}</td>
                                    <td>${b.name}</td>
                                    <td><img src="${b.image}" width="80px", height="100px" alt="" /></td>
                                    <td>${b.price}</td>
                                    <td>
                                        <c:if test="${b.isDelete == 0}">
                                            <button class="btn btn-danger" onclick="changeProductStatus(${b.id}, 1)">Hide</button>
                                        </c:if>
                                        <c:if test="${b.isDelete == 1}">
                                            <button class="btn btn-success" onclick="changeProductStatus(${b.id}, 0)">Show</button>
                                        </c:if>
                                    </td>
                                    <td>
                                        <a href="delete?id=${b.id}" >Delete</a>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        <a href="updatecard?id=${b.id}">Update</a>
                                    </td>
                                </tr>
                            </c:forEach>    
                        </tbody>
                    </table>

                </div>
            </div> 
        </div>
        <!-- add Modal HTML -->
        <div id="addProductModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="submitForm" action="addcard" method="post">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add Card</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">	
                            <input hidden="" type='number' name="id">
                            Card Name<br><input type='text' name='name'><br>
                            Image <br><input type='text' name='image'><br>
                            Category <br><select name ='category'>

                                <c:forEach items="${requestScope.listC}" var = "o">
                                    <option value ="${o.id}">${o.name}</option>
                                </c:forEach>

                            </select> 
                            <br>
                            <br>
                            Price <br><input type='number' name='price'>

                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" onclick="reloadPage()" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <script src="js/deleteuser.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</html>
