<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewGamePIN.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewGamePIN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View Game PIN
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
     <link href="media/css/jquery.dataTables.css" rel="stylesheet" />
     <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("bgame").className = "active";

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
     <li class="active">
        <a href="ViewGamePIN.aspx">
            <i class="fa fa-gamepad mr5"></i>View Game PIN
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Lecturers</h5>
                        </div>
                        <div class="panel-body" id="order-container">
                            <asp:repeater id="Repeater1" runat="server" datasourceid="SqlDataSource1">
                                            <HeaderTemplate>
                                                <table id="datatable" class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                           <th>Game PIN</th>
                                                           <th>Attendance ID</th>
                                                            <th>Subject</th>
                                                            <th>Created Date</th>
                                                            <th>Created By Lecturer</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>

                                            <ItemTemplate>
                                                <tr>
                                                    <td><span class="label label-success"><%# DataBinder.Eval(Container.DataItem, "PIN") %></span></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "AttID") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Subject") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "CreatedDate") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "LecturerName") %></td>

                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>
                            <asp:sqldatasource id="SqlDataSource1" runat="server" connectionstring='<%$ ConnectionStrings:ilearnConnectionString %>' selectcommand="SELECT GamePIN.PIN, Attendance.AttID, Attendance.Subject, Attendance.CreatedDate, Lecturer.LecturerName FROM GamePIN INNER JOIN Attendance ON GamePIN.AttID = Attendance.AttID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID"></asp:sqldatasource>
                            
                        </div>
                    </section>

                </div>


            </div>
        </div>
    </div>
    <script src="media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">

        $('#datatable').dataTable({
            "order": [[1, "asc"]]
        });
    </script>
</asp:Content>
