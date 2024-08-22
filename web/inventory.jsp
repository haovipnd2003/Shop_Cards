<%-- 
    Document   : inventory
    Created on : Jul 8, 2024, 5:40:25 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Inventory</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/usermanager.css" rel="stylesheet" />
        <style></style>
    </head>

    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2> <a href="home" style="color: white; margin-right: 20px;"> <span>Home</span></a>  Inventory</h2>
                            </div>
                           <!-- <div class="col-sm-6">
                                <a href="#addProductModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>

                            </div>-->
                        </div>
                    </div>

                    <br>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Category</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.list}" var = "b">
                                <tr>
                                    <td>${b.id}</td>
                                    <td>${b.name}</td>
                                    <td><img src="${b.image}" width="80px", height="100px" alt="" /></td>
                                    <td>${b.price}</td>
                                    <td>${b.amount}</td>
                                    <td>${b.cateID}</td>
                                    <td>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        
                                        <a href="detailInvent?id=${b.id}">Detail</a>
                                    </td>
                                </tr>
                            </c:forEach>    
                        </tbody>
                    </table>

                </div>
            </div>        
        </div>
        <!-- add Modal HTML -->
      <!--  <div id="addProductModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="addcard" method="post">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add Card</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">	
                            <input hidden="" type='number' name="id">
                            Card Name<br><input type='text' name='name'><br>
                            Image <br><input type='text' name='image'><br>
                            Category <br><select name ='category'>
                                <option value="1">Viettel</option>
                                <option value="2">Vinaphone</option>
                                <option value="3">Mobiphone</option>
                                <option value="4">Vietnammobile</option>
                                <option value="5">Garena</option>
                            </select> 
                            <br>
                            <br>
                            Price <br><input type='number' name='price'>

                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>-->
    </body>
    <script src="js/deleteuser.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</html>

