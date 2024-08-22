<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js
              " rel="stylesheet" id="bootstrap-css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet" id="bootstrap-css">
        <link href="css/profile.css" rel="stylesheet" />  
        <title>JSP Page</title>

    </head>
    <body>
        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row">

                <div class="col-md-5 border-right">
                    <div class="p-3 py-5">

                        <div class="d-flex justify-content-between align-items-center mb-3">

                            <h4 class="text-right">${listAid.user} Profile Settings</h4>
                        </div>
                        <form action='edituser' class="form-container" method='POST' id="myForm">
                            <div class="row mt-2">
                                <div class="col-md-12"><label class="labels"></label><input  hidden=""readonly=""name="id" type="text" class="form-control"  value="${listAid.id}"></div>
                                <div class="col-md-12"><label class="labels">User</label><input  name="user" readonly="" type="text" class="form-control"  value="${listAid.user}"></div>
                                <div class="col-md-12"><label class="labels">Email</label><input name="email" readonly="" readtype="text" class="form-control"  value="${listAid.email}"></div>
                                <div class="col-md-12"><label class="labels">Balance</label><input  name="balance" type="text" id="balanceInput" class="form-control"  value="${listAid.getRawBalance()}"></div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-12"><label class="labels">Phone</label><input type="text" id="phoneInput" name="phone" class="form-control"  value="${listAid.phone}"></div>
                                <div class="col-md-12"><label class="labels">Address</label><input name="address"  readtype="text" class="form-control"  value="${listAid.address}"></div>                            
                            </div>
                            Role <select name ='role'>
<!--                                <option hidden="" value ="${listAid.id}">${listAid.isAdmin}</option>-->
                                <c:if test="${listAid.isAdmin == 1}">m
                                    <option hidden="" value="1">Admin</option>
                                </c:if> 
                                <c:if test="${listAid.isAdmin == 0}">
                                    <option hidden="" value="0">User</option>
                                </c:if>
                                <option value="1">Admin</option>
                                <option value="0">User</option>
                            </select><br>

                            <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="submit" value="Update">Save Profile</button></div>
                        </form>

                    </div>
                </div>

            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#myForm').submit(function (event) {
                    // Get the value of the phone input
                    var newPhone = $('#phoneInput').val().trim(); // Trim to remove leading and trailing spaces
                    // Get the value of the balance input
                    var newBalance = $('#balanceInput').val().trim(); // Trim to remove leading and trailing spaces

                    // Convert empty phone number to 0
                    if (newPhone === '') {
                        $('#phoneInput').val('0');
                        return true;
                    }
                    // Convert empty balance to 0
                    if (newBalance === '') {
                        $('#balanceInput').val('0');
                        return true;
                    }

                    // Check if phone number is a valid non-negative integer
                    if (!/^\d+$/.test(newPhone) || parseInt(newPhone, 10) < 0) {
                        event.preventDefault(); // Prevent form submission
                        alert('Phone number must be a valid non-negative integer. Please enter a valid phone number.');
                    }
                    // Check if balance  is a valid non-negative integer
                    if (!/^\d+$/.test(newBalance) || parseInt(newBalance, 10) < 0) {
                        event.preventDefault(); // Prevent form submission
                        alert('Balance must be a valid non-negative integer. Please enter a valid balance.');
                    }
                });
            });
        </script>
    </body>
</html>


