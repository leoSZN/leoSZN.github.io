<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewGameList.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewGameList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View All Game Details
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
        <a href="ViewGameList.aspx">
            <i class="fa fa-question-circle mr5"></i>View All Game Details
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
                            <h5>Lecturers  <span class="label label-primary">View Join Game Student</span></h5>
                        </div>
                        <div class="panel-body" id="order-container">
                            <asp:repeater id="Repeater1" runat="server" datasourceid="SqlDataSource1">
                                            <HeaderTemplate>
                                                <table id="datatable" class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                           <th>Game ID</th>
                                                           <th>Game PIN</th>
                                                           <th>Question Set ID</th>

                                                            <th>Created Date</th>
                                                            <th>Number Of Student</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>

                                            <ItemTemplate>
                                                <tr>
                                                    <td><span class="label label-primary"><asp:LinkButton ID="LinkButton1" runat="server" CommandName="view" CommandArgument='<%# Eval("RTQuizID") %>' Text='<%# Eval("RTQuizID") %>' OnClick="LinkButton1_Click"/></span></td>
                                                       <td><span class="label label-success"><%# DataBinder.Eval(Container.DataItem, "RTQuizID") %></span></td>
                                                      <td><%# DataBinder.Eval(Container.DataItem, "QsID") %></td>
                                                
                                                    <td><%# DataBinder.Eval(Container.DataItem, "CreateDate") %></td>

                                                   

                                                    <td><%# DataBinder.Eval(Container.DataItem, "NumOfStudent") %></td>

                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ilearnConnectionString %>' SelectCommand="SELECT RealTimeQuiz.RTQuizID, RealTimeQuiz.CreateDate, RealTimeQuiz.QsID, RealTimeQuiz.NumOfStudent, QuestionSet.Title FROM RealTimeQuiz CROSS JOIN QuestionSet"></asp:sqldatasource>
                        </div>
                    </section>

                </div>


            </div>
        </div>
    </div>
    <script src="media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">

        $('#datatable').dataTable({
            "order": [[0, "asc"]]
        });
    </script>

</asp:Content>
