<%-- 
    Document   : detailPost
    Created on : Aug 2, 2024, 7:39:43 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 20px;
                padding: 0;
            }
            .article-container {
                max-width: 800px;
                margin: auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #f9f9f9;
            }
            .article-title {
                font-size: 2em;
                margin-bottom: 20px;
            }
            .article-image img {
                width: 100%;
                height: auto;
                border-radius: 8px;
            }
            .article-paragraph {
                font-size: 1.2em;
                margin-top: 20px;
            }
            .article-createdBy {
                font-style: italic;
                color: #555;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        <div class="article-container">
            <h1 class="article-title">${listB.title}</h1>
        
            <div class="article-image">
                <img src="${listB.image}"/>
            </div>
            
            <div class="article-paragraph">
                <p>${listB.paragraph}</p>
            </div>
            
            <div class="article-createdBy">
                <p>Created by: ${listB.createdBy}</p>
            </div>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
    </body>
</html>
