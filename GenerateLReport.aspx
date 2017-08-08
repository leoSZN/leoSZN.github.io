<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="GenerateLReport.aspx.cs" Inherits="FinalYearProjectMasterPage.GenerateLReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Generate Student List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="media/css/jquery.dataTables.css" rel="stylesheet" />
    <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("bre").className = "active";

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
    <li class="active">
        <a href="GenerateReport.aspx">
            <i class="fa fa-file-text mr5"></i>View Report
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="content-wrap">
                <div class="wrapper">
                    <div class="row">
                        <div class="col-md-4 col-lg-4">
                            <section class="panel">
                                <div class="panel-heading">
                                    <h5>Select report to generate</h5>
                                </div>

                                <div class="panel-body" id="">
                                    <div class="form-group">
                                        <label>Select Report to generate</label>
                                        <div>
                                            <asp:DropDownList ID="ddltype" runat="server" class="form-control" OnSelectedIndexChanged="ddltype_SelectedIndexChanged" AutoPostBack="True">
                                                <asp:ListItem>Student List for Attendances</asp:ListItem>
                                                <asp:ListItem>Email sent for student</asp:ListItem>
                                            </asp:DropDownList><br />
                                        </div>
                                    </div>

                                    <div id="aid" runat="server" class="form-group">
                                        <label>Select Subject</label>
                                        <div>
                                            <asp:DropDownList ID="DropDownList1" runat="server" class="form-control"></asp:DropDownList><br />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div>
                                            <asp:Button ID="Button1" runat="server" Text="Generate" class="btn btn-primary form-control" OnClick="Button1_Click" />
                                        </div>
                                    </div>


                                </div>
                            </section>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-lg-12">
                            <section class="panel">
                                <div class="panel-heading">
                                    <h5>Report Details</h5>
                                </div>
                                <div class="panel-body">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            
                                                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"></rsweb:ReportViewer>
                                          
                                            <div id="rpt1" runat="server" style="display: none">
                                                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="OnItemDataBound">
                                                    <HeaderTemplate>
                                                        <table id="datatable" class="table table-bordered table-hover">
                                                            <thead>
                                                                <tr>
                                                                      <th scope="col">Absent Date</th>
                                                                    <th>Student ID</th>
                                                                    <th>Student Name</th>
                                                                    <th>Subject</th>
                                                                  
                                                                     <th>Program</th>
                                                                </tr>
                                                            </thead>
                                                    </HeaderTemplate>

                                                    <ItemTemplate>
                                                        <tr>
                                                             <td>
                                                            <img alt="" style="cursor: pointer" src="img/plus.png" />

                                                                  <asp:Panel ID="pnl" runat="server" Style="display: none">
                                                                <asp:Repeater ID="rpt2" runat="server">
                                                                    <HeaderTemplate>
                                                                        <table id="datatable" class="table table-bordered table-hover">
                                                                            <tr>
                                                                                <th scope="col" style="width: 150px">Date</th>
                                                                                <th scope="col" style="width: 150px">Attendances ID</th>
                                                                            </tr>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblDate" runat="server" Text='<%# Eval("CreatedDate") %>' /></td>
                                                                           <td> <asp:Label ID="lblAtten" runat="server" Text='<%# Eval("AttID") %>' /></td>
                                                                           
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate></table></FooterTemplate>
                                                                </asp:Repeater>
                                                            </asp:Panel>
                                                             </td>

                                                            <td> <asp:Label ID="lblStuID" runat="server" Text='<%# Eval("StudentID") %>' /></td>

                                                            <td><%# DataBinder.Eval(Container.DataItem, "StudentName") %></td>

                                                            <td> <asp:Label ID="lblSub" runat="server" Text='<%# Eval("Subject") %>' /></td>
                                                            
                                                             <td><%# DataBinder.Eval(Container.DataItem, "pro") %></td>

                                                        </tr>
                                                    </ItemTemplate>

                                                    <FooterTemplate>
                                                        </table>
                                                    </FooterTemplate>

                                                </asp:Repeater>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>

                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ILearnConnectionString %>' SelectCommand="SELECT distinct Student.StudentID, Student.StudentName, Absent.Subject, Intake.Name + ' | ' + Faculty.Name + ' | ' + Program.Name + ' Year ' + Student.Year + ' Semester ' + Student.Semester AS pro FROM Absent INNER JOIN Student ON Absent.StuID = Student.ID INNER JOIN Attendance ON Absent.AttID = Attendance.AttID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Login ON Lecturer.LoginID = Login.LoginID INNER JOIN Intake ON Student.IntakeID = Intake.ID INNER JOIN Faculty ON Student.FacultyID = Faculty.ID INNER JOIN Program ON Student.ProgramID = Program.ID WHERE (Absent.EmailSent = 'Yes') AND (Login.Email = @email)">
                                    <SelectParameters>
                                        <asp:Parameter Name="email"></asp:Parameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                              
                            </section>
                        </div>
                    </div>

                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    <script src="media/js/jquery.dataTables.min.js"></script>

    <script type="text/javascript">

        function MyFunction() {
            $('#datatable').dataTable({
                "order": [[3, "desc"]]
            });
        }
    </script>
      <script type="text/javascript">
        $("body").on("click", "[src*=plus]", function () {
            $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("src", "img/minus.png");
        });
        $("body").on("click", "[src*=minus]", function () {
            $(this).attr("src", "img/plus.png");
            $(this).closest("tr").next().remove();
        });
    </script>
</asp:Content>
