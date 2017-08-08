<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="GenerateReport.aspx.cs" Inherits="FinalYearProjectMasterPage.GenerateReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Generate Attendance Report
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
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
                                <label>Select Report</label>
                                <div>
                                    <asp:DropDownList ID="DropDownList1" runat="server" class="form-control">
                                        <asp:ListItem Value="AA">Attedances Report</asp:ListItem>
                                        <asp:ListItem>Absent Report</asp:ListItem>
                                    </asp:DropDownList><br />
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
                        <div class="panel-body" id="">
                            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"></rsweb:ReportViewer>
                        </div>
                    </section>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
