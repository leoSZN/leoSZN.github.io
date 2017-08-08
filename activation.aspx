<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activation.aspx.cs" Inherits="FinalYearProjectMasterPage.activation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ILearn</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
     <link rel="stylesheet" media="all" href="css/login.css" data-turbolinks-track="true" />
    <link rel="stylesheet" media="all" href="css/themify-d2b0ca15b8ecc157ee25d8d245f3714c321b057a6635a96b7ac9c791abfb3534.css" data-turbolinks-track="true" />
</head>
<body  class="bg-primary" style="overflow-x: hidden;">
    <form id="form1" runat="server">
    <div class="center-wrapper">
            <div class="center-content">
                <div class="row">
                    <div class="col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4">
                        <img style="margin-bottom: 45px; display: block; margin-top: 15px; margin-left: auto; margin-right: auto;" src="img/logo.png" alt="Logo" />
                        <section class="panel bg-white no-b">
                            <div class="p15">
                                <div class="field" style="text-align:center">
                                  <asp:Label ID="Label1" runat="server" Text="" Style="font-size:12pt;"></asp:Label>
                                    <br/><br/>
                               </div>
                                <div class="actions">
                                <asp:Button ID="Button1" runat="server" Text="Back to login page" class="btn btn-primary btn-lg btn-block" Style="height: 55px" OnClick="Button1_Click"/>
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

