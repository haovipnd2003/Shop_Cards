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
            <button style="border: none; padding: 10px; background-color: palegoldenrod; border-radius: 5px" class="btn"><a href="manageInventProduct" style="color: white; margin-right: 20px;; text-decoration: none"> <span>Invent List </span></a></button>

            <form action="updateInvent" class="form-container" method="POST">
                <h6 style="display: none">ID <input type="text" name="id" value="${product.id}"></h6>
                <h6>ID: </h6><p>${product.id}</p>  
                <h6>Card Name: </h6><p>${product.name}</p> 
                <h6>Image: </h6><img  src="${product.image}" width="80px" height="100px"  alt="ảnh" />
                <h6>Category: <p>${product.cateID}</p></h6>
                <h6>Quantity: <input type="text" name="amount" value="${product.amount}"></h6>
                <button type="submit" class="btn" >Update</button>

            </form>
        </div>


    </body>
</html>
