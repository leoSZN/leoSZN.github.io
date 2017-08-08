<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewAtt.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewAtt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View Attendance
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
      <link href="media/css/jquery.dataTables.css" rel="stylesheet" />
    <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("batt").className = "active";

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
      <li class="active">
        <a href="ViewAtt.aspx">
            <i class="fa fa-certificate mr5"></i>View Attendances
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Attendances</h5>
                        </div>
                        <div class="panel-body" id="order-container">
                            <asp:repeater id="Repeater1" runat="server" datasourceid="SqlDataSource1">
                                            <HeaderTemplate>
                                                <table id="datatable" class="table table-bordered table-hover"   style="overflow-x: scroll">
                                                    <thead>
                                                        <tr>
                                                            <th>View Attendance Details</th>
                                                            <th>Subject</th>
                                                            <th>Created Date</th>
                                                            <th>Start Time</th>
                                                            <th>End Time</th>
                                                            <th>Created By Lecturer</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td><span class="label label-primary""><asp:LinkButton ID="LinkButton1" runat="server" CommandName="view" CommandArgument='<%# Eval("AttID") %>' Text='<%# Eval("AttID") %>' OnClick="LinkButton1_Click"/></span></td>
                                               

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Subject") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "CreatedDate") %></td>

                                                    
                                                    <td><%# DataBinder.Eval(Container.DataItem, "Start Time") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "End Time") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "LecturerName") %></td>

                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ilearnConnectionString %>' SelectCommand="SELECT Attendance.AttID, Attendance.Subject, Attendance.CreatedDate, Attendance.sTime AS [Start Time], Attendance.eTime AS [End Time], Lecturer.LecturerName FROM Attendance INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID"></asp:sqldatasource>
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
