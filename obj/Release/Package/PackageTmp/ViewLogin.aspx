<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewLogin.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View Login
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="media/css/jquery.dataTables.css" rel="stylesheet" />
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Students</h5>
                        </div>
                        <div class="panel-body" id="order-container">
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                                <HeaderTemplate>
                                    <table id="datatable" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>UserName</th>
                                                <th>Email</th>
                                                <th>Account Active</th>
                                                <th>Account Suspend</th>
                                                <th>Position</th>
                                                <th>Created Date</th>
                                                <th>Account Created IP</th>
                                                <th>Device</th>
                                                <th>Last Login</th>
                                            </tr>
                                        </thead>
                                </HeaderTemplate>

                                <ItemTemplate>
                                    <tr>
                                        <td><%# DataBinder.Eval(Container.DataItem, "UserName") %></td>


                                        <td><%# DataBinder.Eval(Container.DataItem, "Email") %></td>

                                        <td><%# DataBinder.Eval(Container.DataItem, "Active") %></td>

                                        <td><%# DataBinder.Eval(Container.DataItem, "Suspend") %></td>

                                        <td><%# DataBinder.Eval(Container.DataItem, "Position") %></td>

                                        <td><%# DataBinder.Eval(Container.DataItem, "CreatedDate") %></td>

                                        <td><%# DataBinder.Eval(Container.DataItem, "Account Created IP") %></td>


                                        <td><%# DataBinder.Eval(Container.DataItem, "Device") %></td>


                                        <td><%# DataBinder.Eval(Container.DataItem, "Last Login") %></td>

                                    </tr>
                                </ItemTemplate>

                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>

                            </asp:Repeater>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ILearnConnectionString %>' SelectCommand="SELECT UserName, Email, Active, Suspend, Position, CreatedDate, AccCreatedIP + ' ' + AccCreatedCountry AS [Account Created IP], Browser + ' ' + Device AS Device, LastLoginDate AS [Last Login] FROM Login"></asp:SqlDataSource>
                            
                        </div>
                    </section>

                </div>
            </div>
        </div>
    </div>

    <script src="media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">

        $('#datatable').dataTable();
    </script>
</asp:Content>
