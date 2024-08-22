<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <style>
            .purchase-time-column {
                min-width: 200px;
                max-width: 250px;
            }
            .status-purchased {
                color: red;
                font-weight: bold;
            }
            .status-available {
                color: green;
                font-weight: bold;
            }
        </style>
    </head>

    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2> <a href="home" style="color: white; margin-right: 20px;"> <span>Home</span></a>  <a href="manageInventProduct" style="color: white; margin-right: 20px;"> <span>Inventory</span></a></h2>
                            </div>
                            <div class="col-sm-6">
                                <a href="#addProductModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add CardNumber</span></a>
                            </div>
                        </div>
                    </div>

                    <br>
                    <c:choose>
                        <c:when test="${empty list}">
                            <div class="alert alert-info" role="alert">
                                No product details available.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Image</th>
                                        <th>Seri</th>
                                        <th>CardNumber</th>
                                        <th>Category</th>
                                        <th>Price</th>
                                        <th>Status</th>
                                        <th class="purchase-time-column">Purchase Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${list}" var="b">
                                        <tr>
                                            <td>${b.id}</td>
                                            <td>${b.name}</td>
                                            <td><img src="${b.image}" width="80px" height="100px" alt="" /></td>
                                            <td>${b.seri}</td>
                                            <td>${b.cardNumber}</td>
                                            <td>${b.cateID}</td>
                                            <td>${b.price}</td>
                                            <td class="${b.isDelete == 1 ? 'status-purchased' : 'status-available'}">
                                                ${b.status}
                                            </td>
                                            <td class="purchase-time-column">${b.deleteAt}</td>
                                        </tr>
                                    </c:forEach>    
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>        
        </div>

        <!-- add Modal HTML -->
        <div id="addProductModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="addDetailCard" method="post">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add Detail Cart</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">	
                            Seri:<br><input type='text' name='seri'><br>
                            NumberCard: <br><input type='text' name='numbercard'><br>
                            <input type="hidden" value="${param.id}" name="id">
                            <br>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Message Modal -->
        <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="messageModalLabel">Thông báo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="messageModalBody">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function showMessage(message) {
                $('#messageModalBody').text(message);
                $('#messageModal').modal('show');
            }

            $(document).ready(function () {
                <c:if test="${not empty param.error}">
                    <c:choose>
                        <c:when test="${param.error eq 'empty'}">
                            showMessage("Seri and Card Number are not Empty!");
                        </c:when>
                        <c:when test="${param.error eq 'exists'}">
                            showMessage("Seri or Card Number is Exist!");
                        </c:when>
                    </c:choose>
                </c:if>
                <c:if test="${param.success eq 'true'}">
                    showMessage("Add Card successfully!");
                </c:if>
            });
        </script>
    </body>
</html>
