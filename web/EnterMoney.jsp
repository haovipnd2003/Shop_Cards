<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Enter Money</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .amount-box {
                width: 100px;
                height: 50px;
                line-height: 50px;
                text-align: center;
                border: 1px solid #007bff;
                border-radius: 5px;
                margin: 10px;
                display: inline-block;
                cursor: pointer;
                background-color: #f8f9fa;
                color: #007bff;
                font-weight: bold;
            }
            .amount-box:hover {
                background-color: #007bff;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2>Enter Amount to Add</h2>

            <form id="moneyForm" action="ajaxServlet" method="post">
                <div class="form-group mt-3">
                    <label for="amount">Amount:</label>
                    <input type="text" class="form-control" id="amount" name="amount">
                    <small id="amountHelp" class="form-text text-muted">Please enter a valid amount ending in three zeros (e.g., 1000, 20000).</small>
                    <small id="amountHelp" class="form-text text-muted">Amount of money must be from 5.000 dong to 1 billion dong.</small>
                </div>
                <div id="amountOptions">
                    <div class="amount-box" data-amount="10000">10,000đ</div>
                    <div class="amount-box" data-amount="20000">20,000đ</div>
                    <div class="amount-box" data-amount="50000">50,000đ</div>
                    <div class="amount-box" data-amount="100000">100,000đ</div>
                    <div class="amount-box" data-amount="200000">200,000đ</div>
                    <div class="amount-box" data-amount="500000">500,000đ</div>
                </div>
                <input type="hidden" id="accountId" name="accountId" >
                <button type="submit" class="btn btn-primary">Add Money</button>
            </form>

        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script>
            document.querySelectorAll('.amount-box').forEach(function (element) {
                element.addEventListener('click', function () {
                    var amount = this.getAttribute('data-amount');
                    document.getElementById('amount').value = amount;
                });
            });

            document.getElementById('moneyForm').addEventListener('submit', function (event) {

                var amount = document.getElementById('amount').value.trim(); // Trim to remove whitespace
                var vndFormat = /^\d+000$/; // Regular expression for digits ending with three zeros
                var amountValue = parseInt(amount.replace(/\D/g, ''), 10); // Remove non-digit characters

                if (!vndFormat.test(amount) || isNaN(amountValue) || amountValue < 5000 || amountValue > 1000000000) {
                    event.preventDefault();
                    alert('Please enter a valid amount ending in three zeros (e.g., 1000, 20000) and between 5000 and 1 billion dong.');
                }
            });
        </script>
    </body>
</html>
