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

                            <h4 class="text-right">Profile Settings</h4>
                        </div>
                        <form action='profile' class="form-container" method='POST' id="myForm">
                            <div class="row mt-2">
                                <div class="col-md-12"><label class="labels"></label><input  hidden="" readonly=""name="id" type="text" class="form-control"  value="${listAid.id}"></div>
                                <div class="col-md-12"><label class="labels">User</label><input  name="user" disabled="" type="text" class="form-control"  value="${listAid.user}"></div>
                                <div class="col-md-12"><label class="labels">Email</label><input name="email" disabled="" readtype="text" class="form-control"  value="${listAid.email}"></div>
                                <div class="col-md-12"><label class="labels">Balance</label><input  name="balance" disabled="" type="text" class="form-control"  value="${listAid.balance}"></div>

                            </div>
                            <div class="row mt-3">
                                <div class="col-md-12"><label class="labels">Phone</label><input name="phone"  type="text" id="phoneInput" class="form-control"  value="${listAid.phone}"></div>
                                <div class="col-md-12"><label class="labels">Address</label><input name="address"  readtype="text" class="form-control"  value="${listAid.address}"></div>
                            </div>
                            <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="submit">Save Profile</button></div>
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

                    // Convert empty phone number to 0
                    if (newPhone === '') {
                        $('#phoneInput').val('0');
                        return true;
                    }

                    // Check if phone number is a valid non-negative integer
                    if (!/^\d+$/.test(newPhone) || parseInt(newPhone, 10) < 0) {
                        event.preventDefault(); // Prevent form submission
                        alert('Phone number must be a valid non-negative integer. Please enter a valid phone number.');
                    }
                });
            });
        </script>
    </body>
</html>


