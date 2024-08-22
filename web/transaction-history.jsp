<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Transaction History</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .table thead th {
            background-color: #343a40;
            color: #ffffff;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .btn-home {
            margin-top: 20px;
            background-color: #007bff;
            color: #ffffff;
            border: none;
        }
        .btn-home:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Transaction History</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${transactions}" var="transaction">
                    <tr>
                        <td>${transaction.transactionDate}</td>
                        <td>${transaction.type == 'DEPOSIT' ? 'Deposit' : 'Withdrawal'}</td>
                        <td class="${transaction.type == 'DEPOSIT' ? 'text-success' : 'text-danger'}">
                            ${transaction.type == 'DEPOSIT' ? '+' : '-'}${transaction.formattedAmount}
                        </td>
                        <td>${transaction.description}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="home" class="btn btn-home">Return to Home</a>
    </div>
</body>
</html>
