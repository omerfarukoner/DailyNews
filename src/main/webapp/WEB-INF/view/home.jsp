<%-- 
    Document   : home
    Created on : Jun 14, 2019, 2:44:33 PM
    Author     : burakzengin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Daily News</title>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="static/fontawesome/css/fontawesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-2.2.4.js"></script>

        <style>
            .bd-placeholder-img {
                font-size: 1.125rem;
                text-anchor: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }

            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }
        </style>

        <script>
            var crrncy = {'EUR': {'TL': ${currency.eurToTl}, 'USD': ${currency.eurToUsd}}, 'TL': {'EUR': ${currency.tlToEur}, 'USD': ${currency.tlToUsd}}, 'USD': {'TL': ${currency.usdToTl}, 'EUR': ${currency.usdToEur}}}

            function convertCurrency() {
                var amount = $('#amount').val();
                var from = $('#currency-1').val();
                var to = $('#currency-2').val();
                var result = 0;

                try {
                    if (from === to) {
                        result = amount;
                    } else {
                        result = amount * crrncy[from][to];
                    }
                } catch (err) {
                    result = amount * (1 / crrncy[to][from]);
                }
                $('#result').val(result);

            }
            $(document).ready(function () {
                $('#amount').keyup(function () {
                    convertCurrency();
                });
            });

        </script>

        <!-- Custom styles for this template -->
        <link href="static/custom/cover.css" rel="stylesheet">
    </head>

    <body>
        <div class="fixed-top">
            <div class="card" style="width: 15rem; background-color: #3a474e; margin-left: 30px; margin-top: 20px;">
                <div class="card-body" style="text-align: center;">
                    <div class="font-size-40" style="font-size: 40px; color: white;">
                        ${weather}°
                        <span class="font-size-30" style="font-size: 30px;">C</span>
                    </div>
                    <div class="font-size-20" style="font-size: 20px; color: white;">Manisa, Turkey</div>
                </div>
            </div>
        </div>
        <div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column" >
            <header class="masthead mb-auto" style="text-align: center;">
                <div class="inner">
                    <h3 class="masthead-brand">Daily News</h3>
                    <nav class="nav nav-masthead justify-content-center">
                        <a class="nav-link active" href="#">Home</a>
                        <a class="nav-link" href="#">About</a>
                        <a class="nav-link" href="#">Team</a>
                    </nav>
                </div>
            </header>
            <main role="main" class="inner cover" style="margin-top: 30px;">

                <c:forEach var="c" items="${news}">
                    <div class="row mb-2" style="text-align: center; margin-top: 20px;">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-6">
                                    <img style="max-width: 100%;" src=${c.imageUrl}>
                                </div>
                                <div class="col-md-6" style="text-align: left; background-color: whitesmoke;">
                                    <a href="${c.link}" target="_blank"><h4 style="margin-top: 20px;">${c.header}</h4></a>
                                    <p>${c.content}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </main>
            <footer class="mastfoot mt-auto" style="text-align: center;">
                <div class="inner">
                    <p>All Right Reserved.</p>
                </div>
            </footer>
        </div>

        <div class="fixed-top" style="display: flex; justify-content: flex-end">
            <div class="card" style="width: 15rem; background-color: #3a474e; margin-right: 30px; margin-top: 20px;">
                <div class="card-body" style="text-align: center;">


                    <h5 class="card-title" style="color: whitesmoke;">Currency Converter</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <input type="text" id="amount" class="form-control form-control-sm"  placeholder="0">
                        </div>
                        <div class="col-md-6">
                            <div style="text-align: center;">
                                <select class="form-control form-control-sm" id="currency-1">
                                    <option value="USD">USD</option>
                                    <option value="EUR">EUR</option>
                                    <option value="TL">TL</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-6">
                            <input type="text" id="result" disabled="true" class="form-control form-control-sm final-result" placeholder="0">
                        </div>
                        <div class="col-md-6">
                            <div style="text-align: center;">
                                <select class="form-control form-control-sm" id="currency-2">
                                    <option value="TL">TL</option>
                                    <option value="EUR">EUR</option>
                                    <option value="USD">USD</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap -->
        <script src="static/bootstrap/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-2.2.4.js"></script>
    </body>
</html>