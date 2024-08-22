<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mua hàng thành công</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .success-icon {
            font-size: 5rem;
            color: #28a745;
        }
        .card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .table th {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    <div class="container mt-5">
        <div class="card">
            <div class="card-body text-center">
                <i class="fas fa-check-circle success-icon mb-3"></i>
                <h1 class="card-title">Successful purchase</h1>
                <p class="card-text">Thank you for your purchase. Below are details about the cards you purchased.</p>
            </div>
        </div>
        
        <div class="card mt-4">
            <div class="card-body">
                <h2 class="card-title">Purchased card information:</h2>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Name card</th>
                                <th>Card Number</th>
                                <th>Serial</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${purchasedCards}" var="card">
                                <tr>
                                    <td>${card.productName}</td>
                                    <td>${card.cardNumber}</td>
                                    <td>${card.seri}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="text-center mt-4">
            <a href="home" class="btn btn-primary btn-lg">
                <i class="fas fa-home mr-2"></i>Return to home page
            </a>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>