<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UpdateLogin.aspx.cs" Inherits="FinalYearProjectMasterPage.UpdateLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Update Login
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .spaced input[type="radio"] {
            margin-left: 10px;
            margin-right: 5px;
        }
    </style>
    <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("buser").className = "active";

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
    <li class="active">
        <a href="ViewLogin.aspx">
            <i class="fa fa-user mr5"></i>Login Users
        </a></li>
    <li class="active">
        <a href="UpdateLogin.aspx">Update a Login Users
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-sm-6 col-lg-6 col-xl-6">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Search a Login User</h5>
                        </div>
                        <div class="panel-body">
                            <div id="ssID" runat="server" class="form-group">
                                <label>Login Email</label>
                                <!-- /btn-group -->
                                <asp:TextBox ID="txtsearch" runat="server" class="form-control" AutoComplete="off" Placeholder="Email Address"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <div>
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-primary form-control" OnClick="btnSearch_Click" />
                                </div>
                            </div>

                        </div>
                    </section>
                </div>
                <div class="col-md-6 col-lg-6">

                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Update a Login User</h5>
                        </div>
                        <div class="panel-body">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div id="err" runat="server" class="alert alert-danger alert-dismissable" style="display: none">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <h4><i class="ti-na"></i>Oops!</h4>
                                        <ul>
                                            <asp:Label ID="lblEmessage" runat="server" Text="  "></asp:Label>
                                        </ul>
                                    </div>

                                    <div id="Msg" runat="server" class="alert alert-success alert-dismissable" style="display: none">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <h4><i class="icon fa fa-check"></i>Success!</h4>
                                        <ul>
                                            <asp:Label ID="lblmsg" runat="server" Text="  "></asp:Label>
                                        </ul>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <div class="row">



                                <div class="col-sm-12 col-lg-12 col-xl-12">
                                    <div id="iun" runat="server" class="form-group">
                                        <label>Username</label>
                                        <div>
                                            <asp:TextBox ID="txtUsername" runat="server" class="form-control" AutoComplete="off" Placeholder="Username"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div id="iemail" runat="server" class="form-group">
                                        <label>Email</label>
                                        <div>
                                            <asp:TextBox ID="txtEmail" runat="server" class="form-control" AutoComplete="off" Placeholder="Email" type="email"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label>Position</label>
                                        <div>
                                            <asp:DropDownList ID="ddlPO" runat="server" class="form-control">
                                                <asp:ListItem>Admin</asp:ListItem>
                                                <asp:ListItem>Guest</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label>Account Suspend status</label>
                                        <div class="field">
                                            <label>
                                                <asp:CheckBox ID="rM" runat="server" />
                                                <span class="label-text">Suspend Account</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div>
                                            <asp:Button ID="Button1" runat="server" Text="Update" class="btn btn-primary form-control" OnClick="Button1_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
