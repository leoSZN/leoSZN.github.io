<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="ViewStuAtt.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewStuAtt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Attendances Update Details
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
     <li class="active">
        <a href="ViewStuAtt.aspx">
            View Attendance Status
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
      <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Attendance Status</h5>
                        </div>
                        <div class="panel-body" id="">
                            <asp:repeater id="Repeater1" runat="server" datasourceid="SqlDataSource1">
                                            <HeaderTemplate>
                                                <table id="datatable" class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Attendance ID</th>
                                                            <th>StudentNames</th>
                                                            <th>Status</th>
                                                            <th>IP</th>
                                                            <th>Device</th>
                                                            <th>Time</th>                                                            
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                       <td><%# DataBinder.Eval(Container.DataItem, "AttID") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "StudentName") %></td>
                                                   <td><span class="label label-primary" ><%# DataBinder.Eval(Container.DataItem, "Status") %></span></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "IP") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "Device") %></td>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "Time") %></td>
                                                
                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ilearnConnectionString %>' SelectCommand="SELECT Student.StudentName, AttList.Status, AttList.IP, AttList.Device, AttList.Time, AttList.AttID, Login.Email FROM AttList INNER JOIN Student ON AttList.StuID = Student.ID INNER JOIN Login ON Student.LoginID = Login.LoginID WHERE (Login.Email = @email) AND (AttList.AttID = @id)">
                               <FilterParameters>
                                   <asp:Parameter Name="Status" />
                               </FilterParameters>
                                 <SelectParameters>
                                    <asp:Parameter Name="email" />
                                    <asp:Parameter Name="id"></asp:Parameter>
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

      
        $('#datatable').dataTable();
    </script>
</asp:Content>
