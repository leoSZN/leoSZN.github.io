<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="ViewLGamePIN.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewLGamePIN" %>

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
        <a href="ViewLGamePIN.aspx">
            <i class="fa fa-gamepad mr5"></i>View Game PIN
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Lecturers</h5>
                        </div>
                      
                        <div class="panel-body" id="order-container">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div id="err" runat="server" class="alert alert-danger alert-dismissable" style="display: none">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <h4><i class="ti-na"></i>Oops!</h4>
                                        <ul>
                                            <asp:Label ID="lblEmessage" runat="server" Text="  "></asp:Label>
                                        </ul>
                                    </div>
                                    <div id="Msg" runat="server" class="alert alert-success alert-dismissable" style="display: none">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <h4><i class="icon fa fa-check"></i>Success!</h4>
                                        <ul>
                                            <asp:Label ID="lblmsg" runat="server" Text="  "></asp:Label>
                                        </ul>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand">
                                <HeaderTemplate>
                                    <table id="datatable" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Game PIN</th>
                                                <th>Attendance ID</th>
                                                <th>Status</th>
                                                <th>Subject</th>
                                                <th>Created Date</th>
                                                <th>Options</th>
                                            </tr>
                                        </thead>
                                </HeaderTemplate>

                                <ItemTemplate>
                                    <tr>
                                        <td><span class="label label-success"><%# DataBinder.Eval(Container.DataItem, "PIN") %></span></td>

                                        <td><%# DataBinder.Eval(Container.DataItem, "AttID") %></td>

                                        <td><%# DataBinder.Eval(Container.DataItem, "Available") %></td>

                                        <td><%# DataBinder.Eval(Container.DataItem, "Subject") %></td>

                                        <td><%# DataBinder.Eval(Container.DataItem, "CreatedDate") %></td>

                                        <td>
                                            <asp:LinkButton ID="LinkButton2" runat="server" CommandName="edit" CommandArgument='<%# Eval("AttID")%>'><i class="fa fa-edit" aria-hidden="true" data-toggle="tooltip" data-original-title="Edit"></i></asp:LinkButton>
                                            &nbsp;
                                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="share" CommandArgument='<%# Eval("PIN") %>'><i class="fa fa-share-square-o" aria-hidden="true" data-toggle="tooltip" data-original-title="Share"></i></asp:LinkButton>
                                            &nbsp;
                                            <asp:LinkButton ID="LinkButton3" runat="server" CommandName="del" CommandArgument='<%# Eval("AttID") %>'><i class="fa fa-trash-o" aria-hidden="true" data-toggle="tooltip" data-original-title="Delete"></i></asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>

                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>

                            </asp:Repeater>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ilearnConnectionString %>' SelectCommand="SELECT GamePIN.PIN, Attendance.AttID, GamePIN.Available, Attendance.Subject, Attendance.CreatedDate FROM GamePIN INNER JOIN Attendance ON GamePIN.AttID = Attendance.AttID INNER JOIN Lecturer ON Attendance.LecID = Lecturer.ID INNER JOIN Login ON Lecturer.LoginID = Login.LoginID WHERE (Login.Email = @email)">
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
    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">

        <div class="modal-dialog ">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><b style="color: red">Warning!</b></h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure want to delete this Game PIN? It will delete all the Attendent Details including the student list.</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="Button1" class="btn btn-danger" runat="server" Text="Delete" OnClick="Button1_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>

                </div>
            </div>

        </div>
    </div>

    <script src="media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">

        $('#datatable').dataTable({
            "order": [[1, "desc"]]
        });
    </script>
</asp:Content>
