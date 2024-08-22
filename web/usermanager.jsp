<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>User Management</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link href="css/usermanager.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
        <style>
            body {
                background-color: #f7f9fc;
                font-family: Arial, sans-serif;
            }
            #logreg-forms {
                width: 100%;
                max-width: 400px;
                margin: 10vh auto;
                background: #e0f7fa;
                padding: 2rem;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }
            .form-signup h1 {
                margin-bottom: 1rem;
            }
            .captcha-container {
                margin-bottom: 1rem;
                text-align: center;
            }
            .captcha-container img {
                max-height: 100px;
                display: inline-block;
            }
            .captcha-container button {
                margin-left: 10px;
                vertical-align: middle;
            }
            .captcha-input {
                width: 100%;
                max-width: 150px;
                display: inline-block;
                vertical-align: middle;
            }
            .btn-block {
                margin-top: 1rem;
            }
            .text-center {
                text-align: center;
            }
            .text-danger {
                margin-bottom: 1rem;
            }
        </style>
        <!--        <script>
                    function reloadPage() {
                        // Reload the page when the form is submitted
                        document.getElementById('submitForm').submit();
                    }
                </script>-->
    </head>

    <body onload="reloadPage()">
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2> <a href="home" style="color: white; margin-right: 20px;"> <span>Home</span></a>  User Management</h2>
                            </div>
                            <div class="col-sm-6">
                                <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Account</span></a>

                            </div>
                        </div>
                    </div>
                    <form class="example" action="searchedituser"  style="margin:auto;max-width:300px">
                        <input type="text" placeholder="Search.." name="txt">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </form>
                    <br/>
                    <p>
                        <%
                            String message = (String) session.getAttribute("message");
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
                                <th>Name</th>
                                <th>Balance</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.list}" var = "a">
                                <tr>

                                    <td>${a.user}</td>
                                    <td>${a.balance}</td>
                                    <td>${a.email}</td>
                                    <td>${a.address}</td>
                                    <td>${a.phone}</td>
                                    <c:if test = "${a.isAdmin == 1}"><td>admin</td></c:if>
                                    <c:if test = "${a.isAdmin == 0}"><td>user</td></c:if>
                                        <td>
                                        <c:if test="${a.isActive == 1}">
                                            <button class="btn btn-danger" onclick="changeStatus(${a.id}, 0)">Inactive</button>
                                        </c:if>
                                        <c:if test="${a.isActive == 0}">
                                            <button class="btn btn-success" onclick="changeStatus(${a.id}, 1)">Active</button>
                                        </c:if>
                                    </td>
                                    <td>
                                        <a href="edituser?id=${a.id}"><i class="material-icons" data-toggle="tooltip" title="Edit" >&#xE254;</i></a>
                                        <a href="#deleteEmployeeModal" class="delete" data-toggle="modal" onclick="deleteuser('${a.id}')"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                                    </td>

                                </tr>
                            </c:forEach>    
                        </tbody>
                    </table>

                </div>
            </div>        
        </div>
        <!-- add Modal HTML -->
        <div id="addEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content" id="logreg-forms">
                    <form id="submitForm" action="adduser" method="post">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add Account</h4>
<!--                                    <p class="text-danger text-center">${err}</p>-->
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="form-group">
                            <input name="email" type="email" id="user-email" class="form-control" placeholder="Email (someone@example.com)" value="${email}" required="">
                        </div>
                        <div class="form-group">
                            <input name="user" type="text" id="user-name" class="form-control" placeholder="User name" value="${user}" autofocus required="">
                        </div>
                        <div class="form-group">
                            <div class="input-group mb-3">
                                <input name="password" type="password" id="password" class="form-control" placeholder="Password" value="${password}" required="">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary eye-button" type="button" id="togglePassword">
                                        <i class="fa fa-eye" aria-hidden="true"></i>
                                    </button>
                                </div>

                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group mb-3">
                                <input name="confirmpassword" type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" value="${confirmpassword}" required="">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary eye-button" type="button" id="toggleConfirmPassword">
                                        <i class="fa fa-eye" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </div>
                            <small id="passwordStrength" class="form-text"></small>
                            <small id="passwordMatch" class="form-text"></small>
                        </div>
                        <div>
                            <label>Role</label><br>
                            <input type="radio" id="user" name="role" checked="checked" value="0"><label for="user">User</label><br>
                            <input type="radio" id="admin" name="role" value="1"><label for="admin">Admin</label>
                        </div>
                        <div>
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
    <script>
                                function changeStatus(id, status) {
                                    $.ajax({
                                        url: 'changestatus',
                                        type: 'POST',
                                        data: {id: id, status: status},
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
                                $(document).ready(function () {
//                                                $("#refresh-captcha").click(function () {
//                                                    $("#captchaImage").attr("src", "captcha?timestamp=" + new Date().getTime());
//                                                });

                                    const newPassword = document.getElementById('password');
                                    const confirmPassword = document.getElementById('confirmPassword');
                                    const passwordMatch = document.getElementById('passwordMatch');
                                    const passwordStrength = document.getElementById('passwordStrength');
                                    const togglePassword = document.getElementById('togglePassword');
                                    const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
                                    const form = document.getElementById('submitForm');
                                    function updatePassword() {
                                        const strength = getPasswordStrength(newPassword.value);
                                        passwordStrength.textContent = strength.message;
                                        passwordStrength.style.color = strength.color;
                                        if (newPassword.value === confirmPassword.value) {
                                            passwordMatch.textContent = 'Passwords match';
                                            passwordMatch.style.color = 'green';
                                        } else {
                                            passwordMatch.textContent = 'Passwords do not match';
                                            passwordMatch.style.color = 'red';
                                        }
                                    }

                                    function getPasswordStrength(password) {
                                        let message = '';
                                        let color = '';
                                        const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
                                        const mediumRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;
                                        if (strongRegex.test(password)) {
                                            message = 'Strong password';
                                            color = 'green';
                                        } else if (mediumRegex.test(password)) {
                                            message = 'Medium strength password';
                                            color = 'orange';
                                        } else {
                                            message = 'Password must have contain uppercase letter,lowercase letter,number,special character and at least 6 characters!';
                                            color = 'red';
                                        }
                                        return {message, color};
                                    }

                                    newPassword.addEventListener('input', updatePassword);
                                    confirmPassword.addEventListener('input', updatePassword);
                                    togglePassword.addEventListener('click', function () {
                                        togglePasswordVisibility(newPassword, this);
                                    });
                                    toggleConfirmPassword.addEventListener('click', function () {
                                        togglePasswordVisibility(confirmPassword, this);
                                    });
                                    form.addEventListener('submit', function (event) {
                                        const strength = getPasswordStrength(newPassword.value);
                                        if (newPassword.value !== confirmPassword.value || strength.color === 'red') {
                                            event.preventDefault();
                                            alert('Password validation failed. Please check the requirements.');
                                        }
                                    });
                                    function togglePasswordVisibility(inputField, toggleButton) {
                                        const type = inputField.getAttribute('type') === 'password' ? 'text' : 'password';
                                        inputField.setAttribute('type', type);
                                        toggleButton.querySelector('i').classList.toggle('fa-eye-slash');
                                    }



//                                    function changeStatus(userId, newUserStatus) {
//                                        $.ajax({
//                                            url: 'changestatus',
//                                            type: 'POST',
//                                            data: {id: userId, status: newUserStatus},
//                                            success: function (response) {
//                                                if (response === "success") {
//                                                    location.reload();
//                                                } else {
//                                                    alert("Failed to change status. Please try again.");
//                                                }
//                                            },
//                                            error: function () {
//                                                alert("An error occurred. Please try again.");
//                                            }
//                                        });
//                                    }

                                    function reloadPage() {
                                        // Reload the page when the form is submitted
                                       document.getElementById ('submitForm').submit();
                                    }
                                }
                                );
    </script>
</html>
