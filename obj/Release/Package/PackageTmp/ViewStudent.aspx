<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewStudent.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View Student
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="media/css/jquery.dataTables.css" rel="stylesheet" />
     <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("bstu").className = "active";

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
    <li class="active">
        <a href="ViewStudent.aspx">
            <i class="fa fa-graduation-cap mr5"></i>Students
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
                            <asp:repeater id="Repeater1" runat="server" datasourceid="SqlDataSource1">
                                            <HeaderTemplate>
                                                <table id="datatable" class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Student ID</th>
                                                            <th>Student Name</th>
                                                            <th>Email</th>
                                                            <th>NRIC No.</th>
                                                            <th>Phone No.</th>
                                                            <th>Intake</th>
                                                            <th>Faculty</th>
                                                            <th>Program</th>
                                                            <th>Account Created IP</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>

                                            <ItemTemplate>
                                                <tr>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "Student ID") %></td>


                                                    <td><%# DataBinder.Eval(Container.DataItem, "Student Name") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Email") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "NRIC No") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Phone") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Intake") %></td>


                                                    <td><%# DataBinder.Eval(Container.DataItem, "Faculty") %></td>


                                                    <td><%# DataBinder.Eval(Container.DataItem, "Program") %></td>


                                                    <td><%# DataBinder.Eval(Container.DataItem, "Account Created IP") %></td>
                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>
                            <asp:sqldatasource id="SqlDataSource1" runat="server" connectionstring='<%$ ConnectionStrings:ILearnConnectionString %>' selectcommand="SELECT Student.StudentID AS [Student ID], Student.StudentName AS [Student Name], Login.Email, Student.StudentIC AS [NRIC No], Student.Phone, Intake.Name AS Intake, Faculty.Name AS Faculty, Program.Name + ' Year ' + Student.Year + ' Semester ' + Student.Semester AS Program, Login.AccCreatedIP + '  ' + Login.AccCreatedCountry AS [Account Created IP] FROM Student INNER JOIN Intake ON Student.IntakeID = Intake.ID INNER JOIN Faculty ON Student.FacultyID = Faculty.ID INNER JOIN Program ON Student.ProgramID = Program.ID INNER JOIN Login ON Student.LoginID = Login.LoginID ORDER BY [Student ID]"></asp:sqldatasource>
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
