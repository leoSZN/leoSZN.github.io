<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewLec.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewLec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View Lecturer
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="media/css/jquery.dataTables.css" rel="stylesheet" />
     <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("blec").className = "active";

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
    <li class="active">
        <a href="ViewLec.aspx">
            <i class="fa fa-group mr5"></i>Lecturers
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Lecturers</h5>
                        </div>
                        <div class="panel-body" id="order-container">
                            <asp:repeater id="Repeater1" runat="server" datasourceid="SqlDataSource1">
                                            <HeaderTemplate>
                                                <table id="datatable" class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                           <th>Lecturer ID</th>
                                                            <th>Lecturer Name</th>
                                                            <th>Lecturer Email</th>
                                                            <th>NRIC No.</th>
                                                             <th>Gender</th>
                                                            <th>Phone No.</th>
                                                            <th>Address</th>
                                                            <th>Account Created IP</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>

                                            <ItemTemplate>
                                                <tr>
                                                    <td><%# DataBinder.Eval(Container.DataItem, "LecturerID") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "LecturerName") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Email") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "LecturerIC") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Gender") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Phone") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "Address") %></td>

                                                    <td><%# DataBinder.Eval(Container.DataItem, "IP") %></td>
                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>

                                        </asp:repeater>
                            <asp:sqldatasource id="SqlDataSource1" runat="server" connectionstring='<%$ ConnectionStrings:ILearnConnectionString %>' selectcommand="SELECT Lecturer.LecturerID, Lecturer.LecturerName, Lecturer.LecturerIC, Lecturer.Gender, Lecturer.Phone, Lecturer.Address, Login.Email, Login.AccCreatedIP + ' ' + Login.AccCreatedCountry AS IP FROM Lecturer INNER JOIN Login ON Lecturer.LoginID = Login.LoginID"></asp:sqldatasource>
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
