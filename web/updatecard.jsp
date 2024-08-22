<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/updatecard.css" rel="stylesheet" /> 
    </head>
    <body>


        <div class="form-popup" id="myForm">

            <form action="updatecard" class="form-container" method="POST" id="myForm">

                ID <input type='text' readonly name='id' value="${listB.id}">
                Card Name<input type='text' id="cardNameInput" name='name' value="${listB.name}">
                Image <input type='text' id="imageInput" name='image' value="${listB.image}">
                Category <select name ='category'>
                    <option hidden="" value ="${listS.id}">${listS.name}</option>
                    <c:forEach items="${requestScope.listC}" var = "o">
                        <option value ="${o.id}">${o.name}</option>
                    </c:forEach>    
                </select><br>
                <br>
                Price<input type='text' id="priceInput" name='price' value="${listB.getRawPrice()}">
                <button type="submit" class="btn" value="update">Update</button>

            </form>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#myForm').submit(function (event) {
                    // Get the value of the price input
                    var price = $('#priceInput').val().trim(); // Trim to remove leading and trailing spaces

                    // Check if price is not null and contains only digits
                    if (price === '' || isNaN(price) || parseInt(price) < 0) {
                        event.preventDefault(); // Prevent form submission
                        alert('Price must be a valid number equal or greater than 0. Please enter a valid price.');
                    }
                });

                $('#myForm').submit(function (event) {
                    // Get the value of the card name input
                    var cardName = $('#cardNameInput').val().trim(); // Trim to remove leading and trailing spaces

                    // Check if cardName is null or empty
                    if (cardName === '') {
                        event.preventDefault(); // Prevent form submission
                        alert('Card Name cannot be empty. Please enter a valid Card Name.');
                    }
                });

                $('#myForm').submit(function (event) {
                    // Get the value of the card name input
                    var image = $('#imageInput').val().trim(); // Trim to remove leading and trailing spaces

                    // Check if cardName is null or empty
                    if (image === '') {
                        event.preventDefault(); // Prevent form submission
                        alert('Image cannot be empty. Please enter a valid Card Name.');
                    }
                });
            });


        </script>
    </body>
</html>
