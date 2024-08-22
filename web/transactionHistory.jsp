<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Transaction History</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            .modal-body .card {
                border: none;
                border-bottom: 1px solid #e9ecef;
            }
            .table th, .table td {
                vertical-align: middle;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
            <div class="container mt-5">
                <h2 class="mb-4">Purchase History</h2>
                <table class="table table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th>No</th>
                            <th>Date</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="itemsPerPage" value="6"/> 
                    <c:forEach var="order" items="${orders}" varStatus="status">
                        <tr>
                            <td>${(currentPage - 1) * itemsPerPage + status.index + 1}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><fmt:formatNumber value="${order.totalAmount*0.95}" type="currency" currencyCode="VND" maxFractionDigits="0"/></td>
                            <td>${order.status}</td>
                            <td>
                                <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#orderModal${order.id}">View Details</button>
                            </td>
                        </tr>

                        <!-- Modal for order details -->
                    <div class="modal fade" id="orderModal${order.id}" tabindex="-1" role="dialog" aria-labelledby="orderModalLabel${order.id}" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="orderModalLabel${order.id}">Order Details - Order ID: ${order.id}</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <c:forEach var="detail" items="${order.orderDetails}">
                                        <div class="card mb-3">
                                            <div class="card-body">
                                                <h5 class="card-title">${detail.productName}</h5>
                                                <p class="card-text"><strong>Serial:</strong> ${detail.seri}</p>
                                                <p class="card-text"><strong>Card Number:</strong> ${detail.cardNumber}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </tbody>
            </table>

            <!-- Pagination -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="?page=1">First</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage - 1}">Previous</a>
                        </li>
                    </c:if>

                    <c:choose>
                        <c:when test="${totalPages <= 5}">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="${totalPages}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="begin" value="${currentPage - 1}"/>
                            <c:set var="end" value="${currentPage + 1}"/>

                            <c:if test="${begin < 1}">
                                <c:set var="begin" value="1"/>
                                <c:set var="end" value="3"/>
                            </c:if>
                            <c:if test="${end > totalPages}">
                                <c:set var="begin" value="${totalPages - 2}"/>
                                <c:set var="end" value="${totalPages}"/>
                            </c:if>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${begin > 1}">
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>

                    <c:forEach begin="${begin}" end="${end}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${end < totalPages}">
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage + 1}">Next</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="?page=${totalPages}">Last</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <div class="text-center mt-4">
            <a href="home" class="btn btn-primary btn-lg">
                <i class="fas fa-home mr-2"></i> Return to home page
            </a>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>