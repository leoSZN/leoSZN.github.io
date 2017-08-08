<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nickname.aspx.cs" Inherits="FinalYearProjectMasterPage.nickname" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Play Game!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" media="all" href="css/themify-d2b0ca15b8ecc157ee25d8d245f3714c321b057a6635a96b7ac9c791abfb3534.css" data-turbolinks-track="true" />
    
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="scripts/jquery.signalR-2.2.1.js" data-turbolinks-track="true"></script>
        <script src="signalR/hubs"></script>
       <link href="media/css/jquery.dataTables.css" rel="stylesheet" />
  <link rel="stylesheet" media="all" href="css/login.css" data-turbolinks-track="true" />
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />

      <link href="scripts/sweetalert2.min.css" rel="stylesheet" />
    <script src="scripts/sweetalert2.min.js"></script>
</head>
<body style="overflow-x: hidden;background:white">
    <form id="form1" runat="server">
   <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
         <div id="divNickName" style="display:normal;">
        <div class="center-wrapper">
            <div class="center-content">
                <div class="row">
                    <div class="col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4" style="margin-top:100px">
                      <br/><br/><br/>
                          <section class="panel bg-white no-b">
                            <div class="p15">
                                 <div style="text-align:center;font-family:Arial, Helvetica, sans-serif;font-size:20pt">
                                   <label>Enter Your Nickname</label><br/>
                                      </div>       
                                       <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div id="err" runat="server" class="alert alert-danger alert-dismissable" style="display: none">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                            <h4><i class="ti-na"></i> Oops!</h4>
                                            <ul>
                                                <asp:Label ID="lblEmessage" runat="server" Text=""></asp:Label>
                                            </ul>
                                        </div>

                                        <div id="Msg2" runat="server" class="alert alert-success alert-dismissable" style="display: none">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                            <h4><i class="icon fa fa-check"></i> Success!</h4>
                                            <ul>
                                                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                                            </ul>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                               
                                <div id="iemail" runat="server" class="field">
                                    <span class="ti-crown" style="position: absolute; margin-top: 19px; margin-left: 13px; color: #cccccc;"></span>
                                     <input id="txtNickName" class="form-control  input-lg" style="padding-left: 34px;" type="text" placeholder ="Enter Your Nickname" autocomplete="off"/>
                                </div>
                                <br />
                                <div class="actions">
                                    <input id="btnAdd" class="btn btn-primary btn-lg btn-block" type="button" value="Enter" />
                                    
                                </div>
                    </div>
                              </section>
                    </div>
                </div>
            </div>
        </div>
          
        </div>

         <div style="display:none">
        <asp:Label ID="gamePIN" runat="server" Text="" ></asp:Label>
              <asp:Label ID="lblStuId" runat="server" Text="" ></asp:Label>
            </div>
   
        <div id="divStartingMessage" style="text-align:center;display:none;">
            <h1 style="padding-top:15%;">You're in</h1>
            <h1 id="h1NickName">Did you see your name ?</h1>
        </div>

         <div id="divKickMessage" style="text-align:center;display:none;">
            <h1 style="padding-top:20%">Oopps, You've Got Kicked ?</h1>
        </div>

         <div id="divStatus" style="padding:2%;top:100px;display:none;">

            <h3 style="display:inline"><b>Game Pin:</b> </h3>
             <h3 id="displayPin" style="display:none"></h3>
          
                <h3 id="questionNo" style="display:inline;margin-left:5%;">1 of 11</h3>

             <h3 id="lTimer" style="position:absolute;left:95%;top:-2px">0</h3>
               
            <hr style="border-color:black"/>
        </div>

         <div id="divAnswer" style="width:100%;height:100%;position:fixed;left:0px;display:none">
            <input id="option1" class="ans btn btn-primary" style="width:47.5%;height:37%;margin:1%" type="button" value="A"/>
            <input id="option2" class="ans btn btn-success" style="width:47.5%;height:37%;margin:1%" type="button" value="B"/>
            <input id="option3" class="ans btn btn-warning" style="width:47.5%;height:37%;margin:1%" type="button" value=""/>
            <input id="option4" class="ans btn btn-danger" style="width:47.5%;height:37%;margin:1%" type="button" value=""/>
        </div>
        <div id="divAfterAnswer" style="text-align:center;display:none;">
            <h1 style="">You are fast !</h1>
        </div>

        <script>
            var gamepin = $('#gamePIN').text();
            var studentID = $('#lblStuId').text();

            var quizID;
            var questions;
            var options;
            var questionID;
            var correctAnswer;
            var counter = 0;
            var seconds = 0;
            var answerAlready = 0;
            var $option1 = $('#option1');
            var $option2 = $('#option2');
            var $option3 = $('#option3');
            var $option4 = $('#option4');

            var $lQuestion = $('#lQuestion');
            var $answer = $('#lAnswer');
            $.connection.hub.start()
            .done(function () {
                $.connection.myHub.server.join(gamepin);
            });

          
            //Enter NickName
            $("#btnAdd").click(function () {          
                if ($('#txtNickName').val() != "") {
                    $.connection.myHub.server.addNickNameToTable($('#txtNickName').val(), gamepin, studentID);
                }
            else {
                    swal("Oops...", "Please enter a fantastic Nickname!", "error");
            }
            });

            //Load Questions and answer
            function loadQuestion(quizID) {
                $(function () {
                    var dataValue = '{ quizID:' + JSON.stringify(quizID) + '}';
                    return $.ajax({
                        type: 'POST',
                        url: 'nickname.aspx/loadQuestion',
                        //data: '{}',
                        data: dataValue,
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (msg) {
                            questions = msg.d;
                        }
                    });
                });
            }

            //after answer
            function countdown() {
                seconds = $("#lTimer").text();
                if (seconds > 0) {
                    $("#lTimer").text(seconds - 1);
                    setTimeout("countdown()", 1000);
                }
                else {
                    if (answerAlready == 0) {
                        $.connection.myHub.server.receiveAnswer(" ", 0, gamepin);
                    }
                    $('#divAnswer').css("display", "none");
                    $('#divAfterAnswer').css("display", "inline");
                }
            }

            //loop and display all question
            function appendQuizDetail() {
                if (counter < questions.length) {
                    correctAnswer = questions[counter].CorrectAns;
                    $option1.val(questions[counter].Options[0]);
                    $option2.val(questions[counter].Options[1]);
                   // $option3.val(questions[counter].Options[2]);
                   // $option4.val(questions[counter].Options[3]);
                    if (questions[counter].Options[2] == null) {
                        document.getElementById("option3").disabled = true;

                    } else {
                        $("#option3").val(questions[counter].Options[2]).css("opacity", 1);
                        document.getElementById("option3").disabled = false;

                    }
                    if (questions[counter].Options[3] == null) {
                        document.getElementById("option4").disabled = true;
                    } else {
                        $("#option4").val(questions[counter].Options[3]).css("opacity", 1);
                        document.getElementById("option4").disabled = false;

                    }
                    
                    $("#questionNo").text((counter + 1) + " of " + questions.length);

                    $("#lTimer").text(questions[counter].TimeLimit);
                    $('#divAnswer').css("display", "inline");
                    $('#divAfterAnswer').css("display", "none");
                    setTimeout("countdown()", 1000);
                }
                else {
                    swal({
                        title: 'Congratulation',
                        text: "You have completed the game!",
                        type: 'success',
                        showCancelButton: false,
                        confirmButtonText: 'Ok'
                    }).then(function () {
                        window.location.href = "shome.aspx";       
                    })
                 
                   

                }
                ++counter;
            }

            //start hub
            $(function () {
                $.connection.hub.start()
                .done(function () {
                    console.log("Connected");
                })
                .fail(function () { alert("ERROR!!!") });

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
                $.connection.myHub.client.notify = function (message) {
                    var splitMessage1 = message.substring(0, 4);
                    if (splitMessage1 == "Join") {
                        quizID = message.substring(4, message.length);
                        loadQuestion(quizID);
                        $('#divGamePin').css("display", "none");
                        $('#divStartingMessage').css("display", "none");
                        $('#divNickName').css("display", "inherit");
                    }
                    else if (message == "Did you see your name ?") {
                        $('#divNickName').css("display", "none");
                        $('#divGamePin').css("display", "none");
                        $('#divStartingMessage').css("display", "inline");
                    } else if (message == "Invalid Game Pin") {
                        swal({
                            title: 'Oops',
                            text: "Game Room not available.",
                            type: 'info',
                            showCancelButton: false,
                            confirmButtonText: 'Ok'
                        }).then(function () {
                            window.location.href = "default.aspx";
                        })

                      
                    } else if (message == "stopDisplay") {
                        $("#lTimer").text(0);
                        setTimeout("countdown()", 1000);
                    }
                    else
                       alert(message);
                }

                $.connection.myHub.client.kick = function () {
                    $('#divNickName').css("display", "none");
                    $('#divGamePin').css("display", "none");
                    $('#divStartingMessage').css("display", "none");
                    $('#divKickMessage').css("display", "inline");
                }
                $.connection.myHub.client.nextQuestion = function () {
                    appendQuizDetail();
                    answerAlready = 0;
                }
                $.connection.myHub.client.leave = function () {
                    window.location.href = "default.aspx";
                }
            });

            //Player Answer
            $(".ans").click(function () {
                var thisAns = $("#" + this.id).val();
                var thisPoints = 0;
                if (thisAns == correctAnswer) {
                    thisPoints = (1000 * (1 - (([5 - seconds] / [5]) / 2))); /// 5 will be replaced the original question timer
                }
                $.connection.myHub.server.receiveAnswer(thisAns, thisPoints, gamepin);
                $('#divAnswer').css("display", "none");
                $('#divAfterAnswer').css("display", "inline");
                answerAlready = 1;
            });

        </script>
    </form>
       <script src="media/js/jquery.dataTables.min.js"></script>
</body>
</html>
