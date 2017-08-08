<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewJoinStudent.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewJoinStudent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View Join Game Student
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
    <li class="active">
        <a href="ViewJoinStudent.aspx">
              View Join Game Student
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
       <div class="content-wrap">
        <div class="wrapper">
 
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Join Game Students <span class="label label-primary">View Student Game Result</span> </h5>
                        </div>
                        <div class="panel-body" id="">
                            <asp:repeater id="Repeater1" runat="server" datasourceid="SqlDataSource1">
                                            <HeaderTemplate>
                                                <table id="datatable" class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Join Game ID</th>
                                                            <th>Question Set ID</th>
                                                            <th>Student ID</th>
                                                            <th>Score</th>
                                                            <th>Real Time Result</th>
                                                            <th>Game ID</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                   
                                                    <td><span class="label label-primary"><asp:LinkButton ID="LinkButton1" runat="server" CommandName="view" CommandArgument='<%# Eval("QuizListID") %>' Text='<%# Eval("QuizListID") %>' /></span></td>
                                                   <td><%# DataBinder.Eval(Container.DataItem, "QsID") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "StudentID") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "RealTimeScore") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "RealTimeResult") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "RTQuizID") %></td>


                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ilearnConnectionString %>' SelectCommand="SELECT QuizListID, QsID, StudentID, RealTimeScore, RealTimeResult, RTQuizID FROM QuizList WHERE (RTQuizID = @gameID)">
                                <SelectParameters>
                                    <asp:Parameter Name="gameID" />
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
            "order": [[3, "desc"]]
        });
    </script>

</asp:Content>
