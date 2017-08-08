<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="OverallAtt.aspx.cs" Inherits="FinalYearProjectMasterPage.OverallAtt" EnableEventValidation="false" %>


<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
     ILearn - Overall Student List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="media/css/jquery.dataTables.css" rel="stylesheet" />
         <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("bre").className = "active";

        }
    </script>
    <style type="text/css">
        .auto-style1 {
            width: 225px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">

     <li class="active">
        <a href="OverallAtt.aspx">
            <i class="fa fa-file-text mr5"></i>Overall Report
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
                            <h5>Generate Course Report</h5>
                        </div>
                        <div class="panel-body">
                            <div id="ssID" runat="server" class="form-group">
                                <label>Subject</label>
                                <!-- /btn-group -->
                                <div>
                                    <asp:DropDownList ID="ddl" runat="server" class="form-control" DataSourceID="SqlDataSource1" DataTextField="Subject" DataValueField="Subject"></asp:DropDownList>
                                </div>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ilearnConnectionString %>' SelectCommand="SELECT DISTINCT Attendance.Subject FROM Attendance INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Login ON Lecturer.LoginID = Login.LoginID WHERE (Login.Email = @email)">
                                    <SelectParameters>
                                        <asp:Parameter Name="email"></asp:Parameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>

                            <div class="form-group">
                                <div>
                                    <asp:Button ID="btnSearch" runat="server" Text="Generate" class="btn btn-primary form-control" OnClick="btnSearch_Click" />
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
                        <div class="panel-body" id="">
                            <div id="hide" runat="server" style="display:none">
                            <table class="table table-bordered table-hover">
                                <tr>
                                    <td class="auto-style1">Lecturer Name: <asp:Label ID="Label2" runat="server" Text="" style="color:black;font-weight:bold"></asp:Label></td>
                                 <td>Subject: <asp:Label ID="Label1" runat="server" Text="" style="color:black;font-weight:bold"></asp:Label></td>
                                 <td> <asp:LinkButton ID="LinkButton3" runat="server" OnClick="Button1_Click"><i class="fa fa-file-excel-o fa-2x" aria-hidden="true" data-toggle="tooltip" data-original-title="Export to Excel"></i></asp:LinkButton></td>
                                     </tr>
                            </table>
                              </div>
                            <asp:Repeater ID="rpt1" runat="server" OnItemDataBound="OnItemDataBound">
                                <HeaderTemplate>

                                    <table id="datatable" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="width: 150px">Programs
                                                </th>
                                                <th scope="col" style="width: 150px">Students
                                                </th>
                                            </tr>
                                        </thead>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblProgram" runat="server" Text='<%# Eval("pro") %>' /></td>
                                        <td>
                                            <asp:Repeater ID="rpt2" runat="server" OnItemDataBound="OnItemDataBound2">
                                                <HeaderTemplate>
                                                    <div style="overflow-x:auto;max-height:428px">
                                                      <table class="table table-bordered table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">&nbsp;</th>
                                                                <th  scope="col" style="width: 150px">Student ID
                                                                </th>
                                                                <th scope="col" style="width: 150px">Student Name
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <img alt="" style="cursor: pointer" src="img/plus.png" />
                                                            <asp:Panel ID="pnl" runat="server" Style="display: none">
                                                                <asp:Repeater ID="rpt3" runat="server">
                                                                    <HeaderTemplate>
                                                                        <table id="datatable" class="table table-bordered table-hover">
                                                                            <tr>
                                                                                <th scope="col" style="width: 150px">Date
                                                                                </th>
                                                                                <th scope="col" style="width: 150px">Status
                                                                                </th>
                                                                            </tr>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblDate" runat="server" Text='<%# Eval("CreatedDate") %>' /></td>
                                                                            <td>
                                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' /></td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate></table></FooterTemplate>
                                                                </asp:Repeater>
                                                            </asp:Panel>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="StuID" runat="server" Text='<%# Eval("StudentID") %>' /></td>
                                                        <td>
                                                            <asp:Label ID="lblStuname" runat="server" Text='<%# Eval("StudentName") %>' /></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate></table>
                                                    </div>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                          
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
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
