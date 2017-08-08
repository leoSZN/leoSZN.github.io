<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="ViewEmailSent.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewEmailSent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
      ILearn - View Email Sent Student
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
     <link href="media/css/jquery.dataTables.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">

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
                        <div class="panel-body" id="">
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                                <HeaderTemplate>
                                    <table id="datatable" class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Student ID</th>
                                                            <th>Stndent Name</th>
                                                            <th>Subject</th>
                                                            <th>Created Date</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>

                                            <ItemTemplate>
                                                <tr>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "StudentID") %></td>


                                                    <td><%# DataBinder.Eval(Container.DataItem, "StudentName") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Subject") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "CreatedDate") %></td>

                                                </tr>
                                            </ItemTemplate>

                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>

                            </asp:Repeater>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ILearnConnectionString %>' SelectCommand="SELECT Student.StudentID, Student.StudentName, Absent.Subject, Attendance.CreatedDate FROM Absent INNER JOIN Student ON Absent.StuID = Student.ID INNER JOIN Attendance ON Absent.AttID = Attendance.AttID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Login ON Lecturer.LoginID = Login.LoginID WHERE (Absent.EmailSent = 'Yes') AND (Login.Email = @email)">
                                <SelectParameters>

                                    <asp:Parameter Name="email"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
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
