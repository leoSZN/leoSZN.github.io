<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="ViewQ.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewQ1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View Question
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
      <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("bq").className = "active";

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
     <li class="active">
        <a href="ViewQset.aspx">
            <i class="fa fa-question-circle mr5"></i>View Question Set
        </a></li>
        <li class="active">
        <a href="ViewQ.aspx">
            <i class="fa fa-question-circle mr5"></i>View Question
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="example-modal">
        <div class="modal modal-warning" id="myModal2" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Delete Question Set</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure delete the Question Set?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>

                        <asp:Button ID="Button2" runat="server" Text="Delete" class="btn btn-outline" OnClick="Button2_Click" />
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
    </div>
    <div class="example-modal">
        <div class="modal modal-warning" id="myModal" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Delete Question</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure delete the Question?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>

                        <asp:Button ID="Button1" runat="server" Text="Delete" class="btn btn-outline" OnClick="Button1_Click" />
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
    </div>

    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">

                <div class="col-md-12 col-lg-12">

                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Question Set</h5>
                        </div>
                        <div class="panel-body">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div id="msg" runat="server" class="alert alert-danger alert-dismissable" style="display: none">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <h4><i class="ti-na"></i>Deleted !</h4>
                                        <ul>
                                            <asp:Label ID="lblEmessage" runat="server" Text="  "></asp:Label>

                                        </ul>
                                    </div>

                                    <div id="delmsg" runat="server" class="alert alert-success alert-dismissable" style="display: none">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <h4><i class="icon fa fa-check"></i>Success!</h4>
                                        <ul>
                                            <asp:Label ID="lblmsg" runat="server" Text="The question is removed."></asp:Label>
                                        </ul>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <div>
                                <table>
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Image ID="Image1" runat="server" Height="150px" Width="150px" />
                                        </td>
                                        <td style="width: 55%">
                                            <h4>Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp;&nbsp;
                                                <asp:Label ID="lblTitle" runat="server"></asp:Label></h4>

                                            <h4>Description&nbsp; :&nbsp;&nbsp;
                                                <asp:Label ID="lbldesc" runat="server"></asp:Label></h4>
                                            <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="lbldes2" runat="server"></asp:Label></h4>

                                            <h4>Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp;&nbsp;
                                                <asp:Label ID="lbltype" runat="server"></asp:Label></h4>
                                        </td>
                                        <td style="width: 10%">
                                            <asp:Button ID="btnShare" runat="server" Text="Share" class="btn btn-primary form-control" />
                                            <br />
                                            <br />
                                            <asp:Button ID="btnRank" runat="server" Text="Ranking" class="btn btn-primary form-control" />
                                        </td>
                                        <td style="width: 20%; vertical-align: top">
                                            <br />
                                            <asp:ImageButton ID="ImgbtnEdit" runat="server" Text="Edit" ImageUrl="~/Img/edit-icon.png" OnClick="ImgbtnEdit_Click" /><br />
                                            <br />
                                            <asp:ImageButton ID="ImgbtnDelete" runat="server" Text="Delete" ImageUrl="~/Img/Trash-empty-icon.png" data-toggle="modal" OnClick="ImgbtnDelete_Click" />
                                        </td>
                                    </tr>

                                </table>
                            </div>
                            <div>

                                <asp:Image ID="Image2" runat="server" Height="80px" Width="100%" ImageUrl="~/Img/line.png" />
                            </div>
                            <div>
                                <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                                    <ItemTemplate>
                                        <table style="border: 2px double black; width: 100%">
                                            <tr>
                                                <td rowspan="3" style="width: 300px">
                                                    <asp:Image ID="Image3" runat="server" ImageUrl='<%#Eval("Photo") %>' Height="200px" Width="200px" />
                                                </td>
                                                <td rowspan="3" style="vertical-align: top">
                                                    <br />
                                                    <h4><strong>Question&nbsp;&nbsp;&nbsp;: </strong><%#Eval("Question1")%> </h4>

                                                    <h4><strong>Time Limit&nbsp;:</strong> <%#Eval("Timelimit")%> sec </h4>
                                                </td>
                                                <td style="width: 10%;">
                                                    <asp:ImageButton ID="ImageButton1" runat="server" Text="Edit" CommandName="Editcmd" CommandArgument='<%#Eval("QID")%>' ImageUrl="~/Img/edit-icon.png" />
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <asp:ImageButton ID="ImgbtnCopy" runat="server" Text="Copy" CommandName="Copycmd" CommandArgument='<%#Eval("QID")%>' ImageUrl="~/Img/copy-icon (1).png" />
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <asp:ImageButton ID="ImageButton2" runat="server" Text="Delete" CommandName="Deletecmd" CommandArgument='<%#Eval("QID")%>' ImageUrl="~/Img/Trash-empty-icon.png" data-toggle="modal" /></td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                    <SeparatorTemplate>
                                        <tr>
                                            <td>
                                                <br />
                                            </td>
                                        </tr>
                                    </SeparatorTemplate>
                                </asp:Repeater>

                            </div>
                            <div>
                                <br />
                                <div class="row">
                                    <div class="col-sm-12 col-lg-6 col-xl-6">
                                        <asp:Button ID="btnCreate" runat="server" Text="New Question" class="btn btn-primary form-control" OnClick="btnCreate_Click" /></div>
                                    <div class="col-sm-12 col-lg-6 col-xl-6" style="float: right">
                                        <asp:Button ID="btnBac" runat="server" Text="Back" class="btn btn-primary form-control" OnClick="btnBac_Click" /></div>
                                </div>
                            </div>

                        </div>
                    </section>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
