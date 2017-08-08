<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="StudentAtt.aspx.cs" Inherits="FinalYearProjectMasterPage.StudentAtt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Student Attendance
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
        <a href="StudentAtt.aspx">
            <i class="fa fa-certificate mr5"></i>Attendance Details
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
       <div class="content-wrap">
        <div class="wrapper">

            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Attendance Details</h5>
                        </div>
                        <div class="panel-body" id="">
                            <asp:repeater id="Repeater1" runat="server" datasourceid="SqlDataSource1">
                                            <HeaderTemplate>
                                                <table id="datatable" class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>AttID</th>
                                                            <th>Subject</th>
                                                            <th>Date Time</th>
                                                            <th>By Lecturer</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                   
                                                   <td><span class="label label-primary"><asp:LinkButton ID="LinkButton1" runat="server" CommandName="view" CommandArgument='<%# Eval("AttID") %>' Text='<%# Eval("AttID") %>' OnClick="LinkButton1_Click"/></span></td>
                                                   <td><%# DataBinder.Eval(Container.DataItem, "Subject") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "CreatedDate") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "LecturerName") %></td>

                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ilearnConnectionString %>' SelectCommand="SELECT Attendance.AttID, Attendance.Subject, Attendance.CreatedDate, Lecturer.LecturerName FROM AttList INNER JOIN Student ON AttList.StuID = Student.ID INNER JOIN Login ON Student.LoginID = Login.LoginID INNER JOIN Attendance ON AttList.AttID = Attendance.AttID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID WHERE (Login.Email = @email)">
                                <SelectParameters>
                                    <asp:Parameter Name="email" />
                                </SelectParameters>
                            </asp:sqldatasource>
                        </div>
                    </section>

                </div>


            </div>
        </div>
    </div>
    <script src="media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">

      
        $('#datatable').dataTable({
            "order": [[0, "desc"]]
        });
    </script>
</asp:Content>
