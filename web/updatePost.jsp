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

            <form action="updatepost" class="form-container" method="POST" id="myForm">

                ID <input type='text' readonly name='id' value="${listB.id}">
                Title<input type='text' id="titleInput" name='title' value="${listB.title}">
                Image <input type='text' id="imageInput" name='image' value="${listB.image}">
                Paragraph<input type='text' id="paragraphInput" name='paragraph' value="${listB.paragraph}">
                <button type="submit" class="btn" value="update">Update</button>

            </form>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#myForm').submit(function (event) {
                    var title = $('#titleInput');
                    var image = $('#imageInput');
                    var paragraph = $('#paragraphInput');

                    // Check if title is not null
                    if (title === '') {
                        event.preventDefault(); 
                        alert('All fields must be filled.');
                    }
                    
                    // Check if image is not null
                    if (image === '') {
                        event.preventDefault(); 
                        alert('All fields must be filled.');
                    }
                    
                    // Check if paragraph is not null
                    if (paragraph === '') {
                        event.preventDefault();
                        alert('All fields must be filled.');
                    }
                });
            });


        </script>
    </body>
</html>
