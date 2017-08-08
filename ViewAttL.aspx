<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewAttL.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewAttL" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Attendance Details
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
     <li class="active">
        <a href="ViewAttL.aspx">
            View Attendance Details
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
     <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-md-4 col-lg-4">
                      <section class="panel">
                          <div class="panel-heading">
                            <h5>Attendance Details</h5>
                        </div>

                             <div class="panel-body" id="">
                                <label> Attendance ID : </label> <asp:label ID="lblatt" runat="server" text="Label"></asp:label>
                                 <br/><br/>
                                <label> Lecturer Name : </label> <asp:label ID="lblname" runat="server" text="Label"></asp:label><br/><br/>
                                <label> Subject: </label> <asp:label ID="lblsub" runat="server" text="Label"></asp:label><br/><br/>
                                  <label> Created Date: </label> <asp:label ID="lbldate" runat="server" text="Label"></asp:label><br/>
                            
                            </div>
                       </section>
                </div>
                </div>
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Students List</h5>
                        </div>
                        <div class="panel-body" id="">
                            <asp:repeater id="Repeater1" runat="server" datasourceid="SqlDataSource1">
                                            <HeaderTemplate>
                                                <table id="datatable" class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>StudentNames</th>
                                                            <th>Status</th>
                                                            <th>IP</th>
                                                            <th>Device</th>
                                                            <th>Time</th>
                                                            <th>Intake</th>
                                                            <th>Faculty</th>
                                                            <th>Program</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                   
                                                    <td><%# DataBinder.Eval(Container.DataItem, "StudentName") %></td>
                                                   <td><%# DataBinder.Eval(Container.DataItem, "Status") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "IP") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "Device") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "Time") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "Name") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "facu") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "Pro") %></td>

                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>
                            <asp:sqldatasource id="SqlDataSource1" runat="server" connectionstring='<%$ ConnectionStrings:ilearnConnectionString %>' selectcommand="SELECT Student.StudentName, AttList.Status, AttList.IP, AttList.Device, AttList.Time, Intake.Name, Faculty.Name AS facu, Program.Name + ' Year ' + Student.Year + ' Semester ' + Student.Semester AS Pro FROM AttList INNER JOIN Student ON AttList.StuID = Student.ID INNER JOIN Intake ON Student.IntakeID = Intake.ID INNER JOIN Faculty ON Student.FacultyID = Faculty.ID INNER JOIN Program ON Student.ProgramID = Program.ID WHERE (AttList.AttID = @attid) ORDER BY Pro" >
                                <SelectParameters>
                                    <asp:Parameter Name="attid" />
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
            "order": [[7, "asc"]]
        });
    </script>
</asp:Content>
