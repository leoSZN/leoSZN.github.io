<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="FinalYearProjectMasterPage.signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ILearn</title>
    <meta property="og:title" content="ILearn" />
    <meta property="og:url" content="https://ilearns.azurewebsite.net" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" media="all" href="css/login.css" data-turbolinks-track="true" />
    <link rel="stylesheet" media="all" href="css/themify-d2b0ca15b8ecc157ee25d8d245f3714c321b057a6635a96b7ac9c791abfb3534.css" data-turbolinks-track="true" />
    <script src="js/application-f1d8a303de93cf0c17e46a4a7a8cc2191d090586dc9cf5de77952c049dbf0f93.js" data-turbolinks-track="true"></script>
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />

    <!--Google recaptcha-->
    <script src='https://www.google.com/recaptcha/api.js' async defer></script>
    <link href='//fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css' />
    <script type="text/javascript">
        var onloadCallback = function () {
            grecaptcha.render('html_element', {
                'sitekey': '6LcIQQkUAAAAAJOKooE9g429ggZZJPNbf1QeVSD_'
            });
        };
    </script>
</head>
<body class="bg-primary" style="overflow-x: hidden;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="center-wrapper">
            <div class="center-content">
                <div class="row">
                    <div class="col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4">
                         <img style="margin-bottom: 0px; margin-left:auto;margin-right:auto; display: block; margin-top: 10px;" src="img/logo.png" alt="Logo" />
                        <section class="panel bg-white no-b">
                            <ul class="switcher-dash-action">
                                <li><a href="signin.aspx">Log in</a></li>
                                <li class="active"><a href="signup.aspx">New account</a></li>
                            </ul>
                            <div class="p15">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div id="err" runat="server" class="alert alert-danger alert-dismissable" style="display: none">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                            <h4><i class="ti-na"></i>Oops!</h4>
                                            <ul>
                                                <asp:Label ID="lblEmessage" runat="server" Text=""></asp:Label>
                                            </ul>
                                        </div>

                                        <div id="Msg" runat="server" class="alert alert-success alert-dismissable" style="display: none">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                            <h4><i class="icon fa fa-check"></i>Success!</h4>
                                            <ul>
                                                <li>Account successfully created, please check your email to activate your account.</li>
                                            </ul>
                                        </div>

                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div id="iemail" runat="server" class="field">
                                    <label for="user_email">Email</label><br />
                                    <span class="ti-email" style="position: absolute; margin-top: 16px; margin-left: 13px; color: #cccccc;"></span>
                                    <asp:TextBox ID="txtEmail" runat="server" autocomplete="off" autofocus="autofocus" class="form-control input-lg" placeholder="Email Address" Style="padding-left: 34px;" type="email"></asp:TextBox>
                                </div>
                                <br />
                                <div id="iname" runat="server" class="field">
                                    <label for="user_username">Username</label><br />
                                    <span class="ti-crown" style="position: absolute; margin-top: 16px; margin-left: 13px; color: #cccccc;"></span>
                                    <asp:TextBox ID="txtName" runat="server" autocomplete="off" autofocus="autofocus" class="form-control input-lg" placeholder="Username" Style="padding-left: 34px;"></asp:TextBox>
                                </div>
                                <br />
                                <div id="ipass" runat="server" class="field">
                                    <label for="user_password">Password</label>

                                    <br />
                                    <span class="ti-lock" style="position: absolute; margin-top: 16px; margin-left: 13px; color: #cccccc;"></span>
                                    <asp:TextBox ID="txtPass" runat="server" autocomplete="off" class="form-control input-lg" placeholder="Password" Style="padding-left: 34px;" type="password"></asp:TextBox>
                                </div>
                                <br />
                                <div id="icpass" runat="server" class="field">
                                    <label for="user_password_confirmation">Password confirmation</label><br />
                                    <span class="ti-lock" style="position: absolute; margin-top: 16px; margin-left: 13px; color: #cccccc;"></span>
                                    <asp:TextBox ID="txtcPass" runat="server" autocomplete="off" class="form-control input-lg" placeholder="Confirm Password" Style="padding-left: 34px;" type="password"></asp:TextBox>
                                </div>
                                <br />
                                  <div class="field">
                                    <div style="text-align: center; margin-left: auto; margin-right: auto; width: 304px;">
                                        <div id="recaptcha" class="g-recaptcha" data-theme="light" data-sitekey="6LcIQQkUAAAAAJOKooE9g429ggZZJPNbf1QeVSD_" style="transform:scale(0.9);-webkit-transform:scale(0.9);transform-origin:0 0;-webkit-transform-origin:0 0;"></div>
                                        <script src='https://www.google.com/recaptcha/api.js' async defer></script>
                                        <noscript>
                                            <div>
                                                <div style="width: 302px; height: 422px; position: relative;">
                                                    <div style="width: 302px; height: 422px; position: absolute;">
                                                        <iframe src="https://www.google.com/recaptcha/api/fallback?k=6LdtagMTAAAAAML2ZhXuuDxZ-PQcvAlbNqsnd3Oz" frameborder="0" scrolling="no" style="width: 302px; height: 422px; border-style: none;"></iframe>
                                                    </div>
                                                </div>
                                                <div style="width: 300px; height: 60px; border-style: none; bottom: 12px; left: 25px; margin: 0px; padding: 0px; right: 25px; background: #f9f9f9; border: 1px solid #c1c1c1; border-radius: 3px;">
                                                    <textarea id="g-recaptcha-response" name="g-recaptcha-response" class="g-recaptcha-response" style="width: 250px; height: 40px; border: 1px solid #c1c1c1; margin: 10px 25px; padding: 0px; resize: none;"> </textarea>
                                                </div>
                                            </div>
                                        </noscript>
                                    </div>
                                </div>
                                <br />
                                <div class="actions">
                                    <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" class="btn btn-primary btn-lg btn-block" Style="height: 55px" data-disable-with="Loading..." OnClick="btnSignUp_Click" />
                                </div>

                                <div class="mt5">
                                    <a style="color: #9B9B9B;" href="reset.aspx">Forgot your password?</a>
                                </div>
                            </div>
                        </section>
                        <p class="text-center">
                            Copyright &copy;
                            <span>ILearn</span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>

</html>
