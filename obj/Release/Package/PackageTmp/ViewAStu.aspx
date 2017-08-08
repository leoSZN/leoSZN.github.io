<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewAStu.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewAStu1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View Absent Students
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
        <a href="ViewAStu.aspx">
            <i class="fa fa-certificate mr5"></i>View Absent Students
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Absent Students</h5>
                        </div>
                        <div class="panel-body" id="order-container">
                            <asp:repeater id="Repeater1" runat="server" datasourceid="SqlDataSource1">
                                            <HeaderTemplate>
                                                <table id="datatable" class="table table-bordered table-hover"   style="overflow-x: scroll">
                                                    <thead>
                                                        <tr>
                                                            <th>Student ID</th>
                                                            <th>Student Name</th>
                                                             <th>Program</th>
                                                            <th>Subject</th>
                                                            <th>Created Date</th>
                                                            <th>Created By Lecturer</th>
                                                             <th>Attendance ID</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                   
                                                    <td><%# DataBinder.Eval(Container.DataItem, "StudentID") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "StudentName") %></td>

                                                     <td><%# DataBinder.Eval(Container.DataItem, "Pro") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Subject") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "CreatedDate") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "LecturerName") %></td>

                                                     <td><%# DataBinder.Eval(Container.DataItem, "AttID") %></td>

                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>

                        </div>
                    </section>

                </div>


            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ilearnConnectionString %>' SelectCommand="SELECT Student.StudentID, Student.StudentName, Absent.Subject, Attendance.CreatedDate, Lecturer.LecturerName, Faculty.Name + ' ' + Program.Name + ' Year ' + Student.Year + ' Semester ' + Student.Semester AS Pro, Attendance.AttID FROM Absent INNER JOIN Student ON Absent.StuID = Student.ID INNER JOIN Attendance ON Absent.AttID = Attendance.AttID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Program ON Student.ProgramID = Program.ID INNER JOIN Faculty ON Student.FacultyID = Faculty.ID"></asp:sqldatasource>
    <script src="media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">

        $('#datatable').dataTable({
            "order": [[2, "asc"]]
        });
    </script>
</asp:Content>
