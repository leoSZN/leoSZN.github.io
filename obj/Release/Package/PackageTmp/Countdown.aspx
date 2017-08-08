<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Countdown.aspx.cs" Inherits="FinalYearProjectMasterPage.Countdown" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ILearn - Countdown</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" media="all" href="css/login.css" data-turbolinks-track="true" />

    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
    <!--Time-->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="scripts/jquery.signalR-2.2.1.js" data-turbolinks-track="true"></script>
    <script src="signalR/hubs"></script>

    <link href="media/css/jquery.dataTables.css" rel="stylesheet" />

       <link href="scripts/sweetalert2.min.css" rel="stylesheet" />
    <script src="scripts/sweetalert2.min.js"></script>
    <script src="scripts/Chart.js"></script>

</head>
<body class="" style="overflow-x: hidden;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="center-wrapper">
            <div class="center-content">
                <div id="questionPanel" style=" margin-left: 20px; margin-right: 40px;display: none;">
                    <div>
                    <h3 id="lQuestion" style="text-align: center">Question</h3>
                        <h2 id="lTimer" style="text-align: right;margin-left:80%;display:inline;">60</h2>
                   </div>
                    <div id="dimage" style="text-align:center;margin-bottom:10px;display:none;">
                     <img src="Image/blank.png" id="image" style="height:420px;"/>
                    </div>
                     
                    <h2 id="lAnswer"></h2>
                    <div style="position: fixed; left: 5%; top: 40%;">
                        <h2>Answers</h2>
                        <h2 id="answerCount" style="padding-left: 40%">0</h2>
                    </div>
                </div>

                <div id="statisticsPanel" style="width:55%;margin-left:25%;margin-top:2%;display:none;">
                    <canvas id="myChart"></canvas>
                    <input id="btnShowScore" class="btn btn-lg btn-primary" type="button" value="Next" style="position: absolute; left: 94%; top: 10%" />
                </div>
                <div id="topFivePanel" style="width: 70%; margin: 3% 7% 7% 15%; height: 100%; position: fixed; top: 0; left: 0; display: none">
                    <h1 style="text-align: center">Scoreboard</h1>
                    <table class="table table-hover scoreBoard" style="height: 70%">
                        <tbody>
                            <tr class="success">
                                <td style="font-size: 250%; vertical-align: middle">Ken</td>
                                <td style="font-size: 250%; vertical-align: middle; text-align: right; padding-right: 10%">1500</td>
                            </tr>
                            <tr class="primary">
                                <td style="font-size: 250%; vertical-align: middle">Ken</td>
                                <td style="font-size: 250%; vertical-align: middle; text-align: right; padding-right: 10%">1500</td>
                            </tr>
                            <tr class="info">
                                <td style="font-size: 250%; vertical-align: middle">Ken</td>
                                <td style="font-size: 250%; vertical-align: middle; text-align: right; padding-right: 10%">1500</td>
                            </tr>
                            <tr class="warning">
                                <td style="font-size: 250%; vertical-align: middle">Ken</td>
                                <td style="font-size: 250%; vertical-align: middle; text-align: right; padding-right: 10%">1500</td>
                            </tr>
                            <tr class="danger">
                                <td style="font-size: 250%; vertical-align: middle">Ken</td>
                                <td style="font-size: 250%; vertical-align: middle; text-align: right; padding-right: 10%">1500</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="answerPanel" style="width: 100%; position: fixed; left: 0px; padding-left: 0.8%; margin-top: 23%; bottom: 0; display: none">
                    <input id="option1" class="ans btn btn-primary" style="width: 47.5%; height: 100px; margin: 1%" type="button" value="A" />
                    <input id="option2" class="ans btn btn-success" style="width: 47.5%; height: 100px; margin: 1%" type="button" value="B" />
                    <input id="option3" class="ans btn btn-warning" style="width: 47.5%; height: 100px; margin: 1%" type="button" value="" />
                    <input id="option4" class="ans btn btn-danger" style="width: 47.5%; height: 100px; margin: 1%" type="button" value="" />
                </div>

                <div id="prepareScreen" style="display:">
                    <div class="row">
                        <div class="col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4">
                            <br />
                            <section class="panel bg-white no-b">
                                <div class="p15">
                                    <div style="text-align: center; font-family: Arial, Helvetica, sans-serif; font-size: 25pt">
                                        <label style="font-size: 15pt">Game PIN:&nbsp;&nbsp; </label>
                                        <label>
                                            <asp:Label ID="lblPIN" runat="server" Text="" Style="color: lawngreen"></asp:Label></label>
                                        <br />
                                    </div>
                                  
                                     <div style="text-align: center; font-family: Arial, Helvetica, sans-serif; font-size: 25pt">
                                                <label id="lbltime">11</label> <label id="df"> Seconds</label> 
                                            </div>
                                            <br />
                                            <br />
                                            <div id="actions" runat="server" style="display: none">
                                                 <input id="start" class="btn btn-primary btn-sm btn-block" type="button" value="Start" onclick="myFunction()" />
                                            </div>
                                </div>
                            </section>
                        </div>
                    </div>
                    <hr />
                    <!--Student Join-->
                    <div style="margin-left: 20px; margin-right: 20px">
                        <h3 style="display: inline">Connected Players: </h3>
                        <h3 style="display: inline" id="count">0</h3>
                        <br />
                        <br />
                        <div id="divNickName"></div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var gamepin;
            var quizID;
            var updateCounter = 0;
            var realTimePlayers;
            var realTimeQuiz;
            var counter = 0;
            var questions;
            var correctAnswer;
            var $answer = $('#image');

            //hub start
            $.connection.hub.start()
            .done(function () {
                console.log("Connected");
                generateGamePin();
                loadQuestion();
                
             
                //next
                $("#next").click(function () {
                    $.connection.myHub.server.announce("Next");
                });

                //previous
                $("#previous").click(function () {
                    $.connection.myHub.server.announce("Previous");
                });


            });
            $.connection.myHub.client.announce = function (message) {
                if (message == "Start") {
                    counter = 0;
                    $("#displayPin").text(gamepin);
                    appendQuizDetail();
                    $('#divStartingMessage').css("display", "none");
                    $('#divStatus').css("display", "inline");
                    $('#divAnswer').css("display", "inline");
                }
            }
           
            //start game
            function myFunction() {
                if ($("#count").text() != "0") {
                    $.connection.myHub.server.announce(gamepin);
                   // appendQuizDetail();
                    $("#prepareScreen").css("display", "none");
                    $("#questionPanel").css("display", "inline");
                    $("#answerPanel").css("display", "inline");
                }
                else {
                    swal("Oops!", "No players join yet!", "error");
                }
            }

            $(document).on('click', '#btnShowScore', function (e) {
                $.connection.myHub.server.getTopFive(gamepin);
            });

            $(document).on('click', '#btnNextQuestion', function (e) {
                $.connection.myHub.server.nextQuestion(gamepin);
            });

            //Display all connected player
            $.connection.myHub.client.joinClient = function (Players) {
                $("#divNickName").empty();
                var content = '<table class="table table-hover" id="playerTable" style="font-size:18pt;font-weight:bold;text-align: center;">';
                var newTr = "";
                for (var i = 0; i < Players.length; i++) {

                    if (i % 3 == 0)
                        newTr += (i > 0) ? '</tr><tr>' : '<tr>'
                    newTr += '<td id="p' + i + '">' + Players[i].NickName + '</td>';

                }
                newTr += "</tr>";
                content += newTr;
                $("#divNickName").append(content);

            }

            //add game pin and create game room
            function generateGamePin() {
                gamepin = $('#jid').text();
                quizID = $('#jqid').text();
                $.connection.myHub.server.addGamePin(gamepin, quizID);
            }

            //kick user
            $(document).on('click', '#playerTable tr td', function (e) {
                var id = $(this).attr("id").toString();
                id = id.substr(id.length - 1);
                $.connection.myHub.server.deleteNickNameFromTable(id, gamepin);
            });

           

            // load all question into list
            function loadQuestion() {
                $(function () {
                    var dataValue = '{ quizID:' + quizID + '}';
                    return $.ajax({
                        type: 'POST',
                        url: 'Countdown.aspx/loadQuestion',
                        //data: '{}',
                        data: dataValue,
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (msg) {
                            questions = msg.d;
                            if (questions.length == 0) {
                                swal("Oops!", "There is no question for this quiz!", "warning").then(function () {
                                    window.location.href = "viewlgamePin.aspx";
                                });
                            }
                        }
                    });
                });
            }

            // game time count down
            function countdown() {
                seconds = document.getElementById("lTimer").innerHTML;
                if (seconds > 0) {
                    document.getElementById("lTimer").innerHTML = seconds - 1;
                    setTimeout("countdown()", 1000);
                }
                else {
                    for (i = 0; i < 4; i++) {
                        if (questions[counter - 1].Options[i] != correctAnswer) {
                            $("#option" + (i + 1)).css("opacity", 0.5);
                        }
                    }
                    setTimeout(function () { $.connection.myHub.server.getAnswerStats(gamepin, counter - 1); }, 1500);

                }
            }

            //display and loop questions
            function appendQuizDetail() {
                if (counter < questions.length) {
                    $.connection.myHub.server.refreshAnswerCount(gamepin);
                    correctAnswer = questions[counter].CorrectAns;
                    $("#lQuestion").text(questions[counter].Question);
                    $("#option1").val(questions[counter].Options[0]).css("opacity", 1);
                    $("#option2").val(questions[counter].Options[1]).css("opacity", 1);
                   // $("#option3").val(questions[counter].Options[2]).css("opacity", 1);
                    // $("#option4").val(questions[counter].Options[3]).css("opacity", 1);
                    if (questions[counter].Options[2] == null) {
                        document.getElementById("option3").disabled = true;
                       
                    } else {
                        $("#option3").val(questions[counter].Options[2]).css("opacity", 1);
                     
                    }
                    if (questions[counter].Options[3] == null) {
                        document.getElementById("option4").disabled = true;
                    } else {
                        $("#option4").val(questions[counter].Options[3]).css("opacity", 1);
                     
                    }
                  
                    $("#lTimer").text(questions[counter].TimeLimit);
                    setTimeout("countdown()", 1000);
                    var image = questions[counter].Photo;
                    splits = image.substr(2);
                    if(image==""){
                        $("#dimage").empty();
                        $("#dimage").css("display", "none");
                    }
                    else if (image != null) {
                        $("#dimage").empty();
                        $("#dimage").append('<div style="text-align:center;margin-bottom:10px"><img src="' + splits + '" id="image" style="height:350px"/> </div>');
                        $("#dimage").css("display", "inline");
                        
                    }
                   
                }
                else {
                    $.connection.myHub.server.getPlayers(gamepin);


                }
                ++counter;
            }

            //get player and create real time
            $.connection.myHub.client.getPlayers = function (players) {
                realTimePlayers = players;
                createRealTimeQuiz(players.length);
            }

            //Connected PLayers
            $.connection.myHub.client.count = function (i) {
                $('#count').text(i);
            }


            function createRealTimeQuiz(noOfStudent, aa) {
                aa = "" + gamepin
                $(function () {
                    var dataValue = '{ quizID:' + quizID + ',noOfStudent:' + noOfStudent + ',gamePin:' + JSON.stringify(aa) + '}';
                    return $.ajax({
                        type: 'POST',
                        url: 'Countdown.aspx/createRealTimeQuiz',
                        //data: '{}',
                        data: dataValue,
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (msg) {
                            realTimeQuiz = msg.d;
                            var totalQuestion = questions.length;
                            for (i = 0; i < realTimePlayers.length; i++) {
                                updateCounter++;
                                var score = realTimePlayers[i].Points;
                                var result = ((realTimePlayers[i].Correct) / totalQuestion) * 100;
                                var studentID = realTimePlayers[i].UserName;
                                updateToQuizList(score, result, studentID, realTimePlayers[i]);
                            }
                        }
                    });
                });
            }

            function updateToQuizList(score, result, studentID, realTimePlayer) {
               
                $(function () {
                    var dataValue = '{ quizID:' + quizID + ',score:' + score + ',result:' + result + ',studentID:' + JSON.stringify(studentID) + ',realTimeQuiz:' + realTimeQuiz + '}';
                    return $.ajax({
                        type: 'POST',
                        url: 'Countdown.aspx/updateToQuizList',
                        //data: '{}',
                        data: dataValue,
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (msg) {
                            var quizListID = msg.d;
                            for (i = 0; i < realTimePlayer.answer.length; i++) {
                                updateToResultDetail(quizListID, realTimePlayer.answer[i].Correctness, realTimePlayer.answer[i].Answer, i + 1);
                                
                            }
                        }
                    });
                });
            }

            function updateToResultDetail(quizListID, correctness, answer, questionNo) {
                $(function () {
                    var dataValue = '{ quizListID:' + quizListID + ',correctness:' + JSON.stringify(correctness) + ',answer:' + JSON.stringify(answer) + ',questionNo:' + questionNo + '}';
                    return $.ajax({
                        type: 'POST',
                        url: 'Countdown.aspx/updateToResultDetail',
                        //data: '{}',
                        data: dataValue,
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function () {
                            if (updateCounter == realTimePlayers.length)
                                swal("Finished!", "You have completed the game!", "success").then(function () {
                                    window.location.href = "lhome.aspx";
                                });
                        }
                    });
                });
            }


            //========================================================================

            $.connection.myHub.client.answerCount = function (i) {
                $('#answerCount').text(i);
            }

            $.connection.myHub.client.returnAnswer = function (statsAnswer) {
                var answers = [];
                var answer1 = questions[counter - 1].Options[0];
                var answer2 = questions[counter - 1].Options[1];
                var answer3 = questions[counter - 1].Options[2];
                var answer4 = questions[counter - 1].Options[3];
                var counts = [];
                var count1 = 0; var count2 = 0; var count3 = 0; var count4 = 0;

                for (i = 0; i < statsAnswer.length; i++) {
                    if (statsAnswer[i] == answer1)
                        ++count1;
                    else if (statsAnswer[i] == answer2)
                        ++count2;
                    else if (statsAnswer[i] == answer3)
                        ++count3;
                    else if (statsAnswer[i] == answer4)
                        ++count4;
                }

                answers[0] = answer1; answers[1] = answer2; counts[0] = count1; counts[1] = count2;

                if (answer3 != null) {
                    answers[2] = answer3; counts[2] = count3;
                }
                if (answer4 != null) {
                    answers[3] = answer4; counts[3] = count4;
                }
                $("#questionPanel").css("display", "none");
                $("#statisticsPanel").css("display", "block");
                populateChart(counts, answers);
            }

            $.connection.myHub.client.stopDisplay = function () {
                document.getElementById("lTimer").innerHTML = 0;
            }

            $.connection.myHub.client.getTopFive = function (TopFive) {
                $("#topFivePanel").empty();
                var content = '<h1 style="text-align:center">Scoreboard</h1><table class="table table-hover scoreBoard" style="height:70%"><tbody>';
                for (i = 0; i < TopFive.length; i++) {
                    content += '<tr class="success">';
                    content += '<td style="font-size:250%;vertical-align:middle">' + TopFive[i].NickName + '</td>';
                    content += '<td style="font-size:250%;vertical-align:middle">' + TopFive[i].Points + '</td></tr>';
                }
                content += '</tbody></table>';
                $("#topFivePanel").append('<input id="btnNextQuestion" class="btn btn-lg btn-primary" type="button" value="Next" style="position:absolute;left:98%;top:10%"/>');
                $("#topFivePanel").append(content);
                $("#statisticsPanel").css("display", "none");
                $("#answerPanel").css("display", "none");
                $("#topFivePanel").css("display", "inline");
                actions
            }

            $.connection.myHub.client.nextQuestion = function () {
                appendQuizDetail();
                $("#statisticsPanel").empty();
                $("#statisticsPanel").append('<canvas id="myChart"></canvas> <input id="btnShowScore" class="btn btn-lg btn-primary" type="button" value="Next" style="position:absolute;left:94%;top:10%"/>');
                $("#questionPanel").css("display", "inline");
                $("#answerPanel").css("display", "inline");
                $("#statisticsPanel").css("display", "none");
                $("#topFivePanel").css("display", "none");
            }

            function populateChart(counts, answers) {
                var ctx = document.getElementById("myChart").getContext("2d");
                var myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: answers,
                        datasets: [{
                            label: '# of Votes',
                            data: counts,
                            backgroundColor: [
                               'rgb(83, 144, 255)',
                               'rgb(21, 219, 129)',
                               'rgb(218, 172, 22)',
                               'rgb(248, 104, 104)',
                            ],
                            borderColor: [
                                 'rgba(54, 162, 235, 1)',
                                 'rgba(75, 192, 192, 1)',
                                 'rgba(255, 206, 86, 1)',
                                 'rgba(255,99,132,1)',


                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        tooltips: {
                            //enabled:false
                        },
                        legend: {
                            //display:false
                        },
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    scaleShowLabels: false,
                                    display: false,
                                },
                                gridLines: {
                                    drawBorder: false,
                                    display: false
                                },
                            }],
                            xAxes: [{
                                gridLines: {
                                    display: false
                                }
                            }]
                        },
                        animation: {
                            //onProgress: drawBarValues,
                            //onComplete: drawBarValues
                        },
                    }
                });
            }


            function drawBarValues() {
                // render the value of the chart above the bar
                var ctx = this.chart.ctx;
                ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, 'normal', Chart.defaults.global.defaultFontFamily);
                ctx.fillStyle = this.chart.config.options.defaultFontColor;
                ctx.textAlign = 'center';
                ctx.textBaseline = 'bottom';
                this.data.datasets.forEach(function (dataset) {
                    for (var i = 0; i < dataset.data.length; i++) {
                        if (dataset.hidden === true && dataset._meta[Object.keys(dataset._meta)[0]].hidden !== false) { continue; }
                        var model = dataset._meta[Object.keys(dataset._meta)[0]].data[i]._model;
                        if (dataset.data[i] !== null) {
                            ctx.fillText(dataset.data[i], model.x - 1, model.y - 5);
                        }
                    }
                });
            }
            function ccdown() {
                second = document.getElementById("lbltime").innerHTML;
                if (second > 0) {
                    document.getElementById("lbltime").innerHTML = second - 1;
                    setTimeout("ccdown()", 1000);
                } else {
                    $("#actions").css("display", "inline");
                    document.getElementById("df").innerHTML = "";
                    document.getElementById("lbltime").innerHTML = "Update Attendance Time is Over.";
                    document.getElementById("lbltime").style.color = 'red';
                    document.getElementById("lbltime").style.fontSize = '15pt';
                    setTimeout(
                    function closeAtt(gamePin) {
                        gamePin = gamepin;
                        $(function () {
                            var dataValue = '{ gamePin:' + JSON.stringify(gamePin) + '}';
                            return $.ajax({
                                type: 'POST',
                                url: 'Countdown.aspx/updateAtt',
                                //data: '{}',
                                data: dataValue,
                                contentType: 'application/json; charset=utf-8',
                                dataType: 'json',
                                success: function () {

                                }
                            });
                        });
                    }, 1000)
                }
            }
        </script>

        <div style="display: none">
            <asp:Label ID="jid" runat="server" Text=""></asp:Label>
            <asp:Label ID="jqid" runat="server" Text=""></asp:Label>
            <asp:Label ID="lbllimit" runat="server" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>
