<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Manage Categories</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                padding: 30px;
                margin-top: 50px;
            }
            h1, h2 {
                color: #007bff;
            }
            .table {
                box-shadow: 0 0 5px rgba(0,0,0,0.05);
            }
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }
            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border-color: #c3e6cb;
            }
            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 34px;
            }
            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }
            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 34px;
            }
            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }
            input:checked + .slider {
                background-color: #2196F3;
            }
            input:checked + .slider:before {
                transform: translateX(26px);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <a href="home" class="btn btn-outline-primary"><i class="fas fa-home"></i> Home</a>
            </div>

            <!-- Add New Category Form -->
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h2 class="h5 mb-0">Add New Category</h2>
                </div>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>
                <div class="card-body">
                    <form action="category" method="post">
                        <div class="form-group">
                            <label for="categoryName">Category Name:</label>
                            <input type="text" class="form-control" id="categoryName" name="categoryName" value="${cate}">
                        </div>
                        <button type="submit" class="btn btn-success" name="action" value="addCategory" onclick="validateAndSubmit()"><i class="fas fa-plus"></i> Add Category</button>    
                    </form>
                </div>
            </div>

            <!-- List of Categories -->
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h2 class="h5 mb-0">Category List</h2>
                </div>
                <div class="card-body">
                    <table class="table table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${list}" var="category">
                                <tr>
                                    <td>${category.id}</td>
                                    <td>${category.name}</td>
                                    <td>
                                        <button class="btn btn-sm btn-primary" onclick="openEditModal(${category.id}, '${category.name}',${category.isDelete})">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
<!--                                        <a href="deleteCategory?id=${category.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this category?')">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </a>-->
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Edit Category Modal -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1" role="dialog" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="editCategoryModalLabel">Edit Category</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="category" method="post">
                        <div class="modal-body">
                            <input type="hidden" id="editCategoryId" name="id">
                            <div class="form-group">
                                <label for="editCategoryName">Category Name:</label>
                                <input type="text" class="form-control" id="editCategoryName" name="name">
                            </div>
                            <div class="form-group">
                                <label for="isDelete">IsShow</label>
                                <label class="switch ml-2">
                                    <input type="checkbox" id="isDelete" name="isDelete">
                                    <span class="slider"></span>
                                </label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary" name="action" value="editCategory">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            function toggleIsDelete(categoryId, isChecked) {
                $.ajax({
                    url: 'toggleCategoryIsDelete',
                    type: 'POST',
                    data: {
                        id: categoryId,
                        isDelete: isChecked
                    },
                    success: function (response) {
                        console.log('IsDelete toggled successfully');
                    },
                    error: function (xhr, status, error) {
                        console.error('Error toggling IsDelete:', error);
                    }
                });
            }

            function openEditModal(id, name, isDelete) {
                $('#editCategoryId').val(id);
                $('#editCategoryName').val(name);
                $('#isDelete').prop('checked', isDelete === 1);
                if (isDelete === 1) {
                    $('.switch').addClass('checked'); // Assuming you have a CSS class 'checked' for blue color
                } else {
                    $('.switch').removeClass('checked');
                }
                $('#editCategoryModal').modal('show');
            }

            $(document).ready(function () {
                $('#isDelete').change(function () {
                    var categoryId = $('#editCategoryId').val();
                    var isChecked = $(this).prop('checked');
                    toggleIsDelete(categoryId, isChecked);
                });
            });
            function validateAndSubmit() {
                var categoryName = document.getElementById('categoryName').value.trim();
                if (categoryName === null || categoryName === "") {
                    event.preventDefault();
                    alert("Category name cannot be empty. Please enter a valid name.");
                }
            }
        </script>
    </body>
</html>