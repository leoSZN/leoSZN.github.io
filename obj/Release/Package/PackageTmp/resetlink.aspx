<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="resetlink.aspx.cs" Inherits="FinalYearProjectMasterPage.resetlink" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ILearn | Reset Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" media="all" href="css/login.css" data-turbolinks-track="true" />
    <link rel="stylesheet" media="all" href="css/themify-d2b0ca15b8ecc157ee25d8d245f3714c321b057a6635a96b7ac9c791abfb3534.css" data-turbolinks-track="true" />
    <script src="js/application-f1d8a303de93cf0c17e46a4a7a8cc2191d090586dc9cf5de77952c049dbf0f93.js" data-turbolinks-track="true"></script>
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
</head>
<body class="bg-primary" style="overflow-x: hidden;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="center-wrapper">
            <div class="center-content">
                <div class="row">
                    <div class="col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4">
                        <img style="margin-bottom: 45px; display: block; margin-top: 15px; margin-left: auto; margin-right: auto;" src="img/logo.png" alt="Logo" />
                        <section class="panel bg-white no-b">
                            <div class="p15">
                                <div style="text-align: center; font-family: Arial, Helvetica, sans-serif; font-size: 20pt">
                                    <label>Password Reset</label><br />
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

                                        <div id="Msg" runat="server" class="alert alert-success alert-dismissable" style="display: none">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                            <h4><i class="icon fa fa-check"></i>Success!</h4>
                                            <ul>
                                                <li>Your password was successfully update.</li>
                                            </ul>
                                            <br />
                                            You will now be redirected to Login page in 3 seconds.
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>


                                <div id="pass" runat="server" class="field">
                                    <label for="user_email">Password</label><br />
                                    <span class="ti-lock" style="position: absolute; margin-top: 19px; margin-left: 13px; color: #cccccc;"></span>
                                    <asp:TextBox ID="txtpass" autofocus="autofocus" runat="server" class="form-control  input-lg" placeholder="Password" type="password" Style="padding-left: 34px;" autocomplete="off"></asp:TextBox>
                                </div>
                                <div id="cpass" runat="server" class="field">
                                    <label for="user_email">Confirm Password</label><br />
                                    <span class="ti-lock" style="position: absolute; margin-top: 19px; margin-left: 13px; color: #cccccc;"></span>
                                    <asp:TextBox ID="txtcpass" autofocus="autofocus" runat="server" class="form-control  input-lg" placeholder="Confirm Password" type="password" Style="padding-left: 34px;" autocomplete="off"></asp:TextBox>
                                </div>
                                <br />
                                <div class="actions">
                                    <asp:Button ID="Button1" runat="server" Text="Change" class="btn btn-primary btn-lg btn-block" Style="height: 55px" data-disable-with="Loading..." OnClick="Button1_Click" />
                                </div>

                            </div>
                        </section>
                        <p class="text-center">
                            Copyright &copy;
                            <span id="year" class="mr5">2016</span>
                            <span>ILearn</span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
