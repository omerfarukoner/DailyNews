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

            .btn-circle {
                width: 30px;
                height: 30px;
                text-align: center;
                padding: 6px 0;
                font-size: 12px;
                line-height: 1.428571429;
                border-radius: 15px;
            }

            .btn-circle.btn-lg {
                width: 50px;
                height: 50px;
                padding: 10px 16px;
                font-size: 18px;
                line-height: 1.33;
                border-radius: 25px;
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

            var MyBlobBuilder = function () {
                this.parts = [];
            }

            MyBlobBuilder.prototype.append = function (part) {
                this.parts.push(part);
                this.blob = undefined; // Invalidate the blob
            };

            MyBlobBuilder.prototype.getBlob = function () {
                if (!this.blob) {
                    this.blob = new Blob(this.parts, {type: "audio/mpeg"});
                }
                return this.blob;
            };

            var myBlobBuilder = new MyBlobBuilder();
            var downloadLink, selectedMusic;

            $(document).ready(function () {

                $('#amount').keyup(function () {
                    convertCurrency();
                });

                $("#file").on("click", function () {
                    $("input").trigger("click");
                });

                $("#transferButton").click(function () {
                    var e = document.getElementById("musicList");
                    selectedMusic = e.options[e.selectedIndex].value;
                    downloadLink = document.getElementById("download");

                    let socket1 = new WebSocket("wss://dailynewsserver.herokuapp.com/dailynewsserver/" + selectedMusic);
                    socket1.onopen = function (e) {
                        //alert("[open] Connection established");
                    };

                    socket1.onmessage = function (event) {
                        myBlobBuilder.append(event.data);
                        document.getElementById('download').click();
                    };

                    socket1.onclose = function (event) {
                        if (event.wasClean) {
                            //alert(`[close] Connection closed cleanly, code=${event.code} reason=${event.reason}`);
                        } else {
                            // e.g. server process killed or network down
                            // event.code is usually 1006 in this case
                            //alert('[close] Connection died');
                        }
                    };

                    socket1.onerror = function (error) {
                        //alert(`[error] ${error.message}`);
                    };
                });

                $("#download").click(function () {
                    var data = myBlobBuilder.getBlob();
                    downloadLink.href = URL.createObjectURL(data);
                    downloadLink.download = selectedMusic + '.mp3';
                });
            });
        </script>
        <!-- Custom styles for this template -->
        <link href="static/custom/cover.css" rel="stylesheet">
    </head>

    <body>
        <div class="fixed-top" style="z-index: auto;">
            <div>
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
            <div>
                <div class="card" style="width: 15rem; background-color: #3a474e; margin-left: 30px; margin-top: 20px;">
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
            <div>
                <div class="card" style="width: 15rem; background-color: #3a474e; margin-left: 30px; margin-top: 20px;">
                    <div class="card-body" style="text-align: center;">
                        <div class="row justify-content-center" style="margin-top: 10px;">
                            <button id="file" type="button" class="btn btn-primary btn-circle btn-lg"><i class="fa fa-plus"></i></button>
                            <input id="file" type="file" style="display: none;"/>
                        </div>
                        <h5 style="color: white; margin-top: 10px;">Upload Your Music</h5>
                        <h5 style="color: whitesmoke; margin-top: 40px; margin-bottom: 40px;">OR</h5>
                        <div class="row">
                            <div class="col-md-12">
                                <div style="text-align: center;">
                                    <select class="form-control form-control-sm" style="text-align: center;" id="musicList">
                                        <option>Bad Guy</option>
                                        <option>Eearfquake</option>
                                        <option>I think</option>
                                        <option>Kehlani</option>
                                        <option>Puppet</option>
                                        <option>What</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                            <div class="col-md-2"></div>
                            <div class="col-md-8">
                                <button id="transferButton" type="button" style="padding: 5px 10px;" class="btn btn-secondary">Download</button>
                                <a hidden href="javascript:void(0)" id="download"></a>
                            </div>
                            <div class="col-md-2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
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
                                    <a href="${c.link}" target="_blank"><img style="max-width: 100%;" src=${c.imageUrl}></a>
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

        <!-- Bootstrap -->
        <script src="static/bootstrap/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-2.2.4.js"></script>
    </body>
</html>