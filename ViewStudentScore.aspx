<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewStudentScore.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewStudentScore" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View Student Game Result
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
     <li class="active">
        <a href="ViewStudentScore.aspx">
            View Student Game Result
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
                                                            <th>Game Score ID</th>
                                                            <th>Join Game ID</th>
                                                            <th>Correctness</th>
                                                            <th>Answer</th>
                                                            <th>Question Number</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                   
                                                   <td><%# DataBinder.Eval(Container.DataItem, "QsID") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "StudentID") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "RealTimeScore") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "RealTimeResult") %></td>
                                               
                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ilearnConnectionString %>' SelectCommand="SELECT QuizResultDetails.ResultID, QuizResultDetails.QuizListID, Student.StudentName, QuizResultDetails.Correctness, QuizResultDetails.Answer, QuizResultDetails.QuestionNum FROM QuizResultDetails INNER JOIN QuizList ON QuizResultDetails.QuizListID = QuizList.QuizListID CROSS JOIN Student CROSS JOIN QuestionSet WHERE (QuizResultDetails.QuizListID = @jGameID)">
                                <SelectParameters>
                                    <asp:Parameter Name="jGameID" />
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
            "order": [[0, "asc"]]
        });
    </script>
</asp:Content>
