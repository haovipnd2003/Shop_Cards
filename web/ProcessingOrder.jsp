<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đang xử lý đơn hàng</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .processing-icon {
            font-size: 5rem;
            color: #007bff;
        }
    </style>
    <script>
        function checkOrderStatus() {
            fetch('CheckOrderStatus')
                .then(response => response.json())
                .then(data => {
                    if (data.processed) {
                        window.location.href = 'PurchaseSuccess.jsp';
                    }
                });
        }
        setInterval(checkOrderStatus, 2000);
    </script>
</head>
<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    <div class="container mt-5">
        <div class="card">
            <div class="card-body text-center">
                <i class="fas fa-spinner fa-spin processing-icon mb-3"></i>
                <h1 class="card-title">Your order is being processed</h1>
                <p class="card-text">Please wait a moment...</p>
            </div>
        </div>
    </div>
</body>
</html>