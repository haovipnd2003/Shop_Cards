<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

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
        </script>
    </head>
    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2> <a href="home" style="color: white; margin-right: 20px;"> <span>Home</span></a>  Post Management</h2>
                            </div>
                            <div class="col-sm-6">
                                <a href="#addProductModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Create New Post</span></a>

                            </div>
                        </div>
                    </div>
                    <!--                    <form class="example" action="searchpost"  style="margin:auto;max-width:300px">
                                            <input type="text" placeholder="Search.." name="txt">
                                            <button type="submit"><i class="fa fa-search"></i></button>
                                        </form>-->
                    <br>
                    <table class="table table-striped table-hover">

                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Image</th>
                                <th>Paragraph</th>
                                <th>Created By</th>
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
        <!-- add Modal HTML -->
        <div id="addProductModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="addpost" method="post">
                        <div class="modal-header">						
                            <h4 class="modal-title">Create Post</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">	
                            Title<br><input type='text' name='title'><br>
                            Image <br><input type='text' name='image'><br>
                            Paragraph <br><input type='text' name='paragraph'><br>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
