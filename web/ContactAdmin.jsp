<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
<!--    <link rel="stylesheet" type="text/css" href="css/contact.css">-->
    <style>
         body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        input[type="text"],
        input[type="email"],
        textarea {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            transition: box-shadow 0.3s ease, background-color 0.3s ease;
            background-color: #e9f5ff;
            box-shadow: inset 0 0 0 2px #007bff, 0 2px 5px rgba(0,123,255,0.2);
        }
        input[type="text"]:focus,
        input[type="email"]:focus,
        textarea:focus {
            outline: none;
            box-shadow: inset 0 0 0 2px #0056b3, 0 0 10px rgba(0,123,255,0.5);
            background-color: #d0e7ff;
        }
        textarea {
            height: 150px;
            resize: vertical;
        }
        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
    </style>
    <script>
        function validateForm() {
            // Get the form fields
            var subject = document.getElementById("subject").value;
            var email = document.getElementById("email").value;
            var message = document.getElementById("message").value;

            // Check if fields are empty
            if (subject.trim() === "" || message.trim() === "") {
                event.preventDefault()
                alert("All fields are required.");
                return false; // Prevent form submission
            }
            return true; // Allow form submission
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Contact Us</h1>
        <form action="contact" method="post" onsubmit="validateForm()">
            <div class="form-group">
                <label for="subject">Subject:</label>
                <input type="text" id="subject" name="subject">
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${userEmail}" readonly>
            </div>
            <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" name="message"></textarea>
            </div>
            <button type="submit">Submit</button>
        </form>
    </div>
</body>
</html>
