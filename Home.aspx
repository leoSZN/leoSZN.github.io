<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="FinalYearProjectMasterPage.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
   ILearn - Home
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="bar" runat="server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">
    
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <section class="dash-tile bg-primary">
                        <div class="tile-title">Total Students</div>
                        <div class="tile-stats">
                            <b>
                                <asp:Label ID="lblStudent" runat="server" Text="Label"></asp:Label></b>
                        </div>
                        <div class="tile-footer">
                            <a href="viewstudent.aspx">View all Student</a>
                        </div>
                        <div class="tile-icon">
                            <i class="fa fa-graduation-cap"></i>
                        </div>
                    </section>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <section class="dash-tile bg-success">
                        <div class="tile-title">Total Lecturers</div>
                        <div class="tile-stats">
                            <b>
                                <asp:Label ID="lblLec" runat="server" Text="Label"></asp:Label></b>
                        </div>
                        <div class="tile-footer">
                            <a href="ViewLec.aspx">View all Lecturers</a>
                        </div>
                        <div class="tile-icon">
                            <i class="fa fa-group"></i>
                        </div>
                    </section>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <section class="dash-tile bg-warning">
                        <div class="tile-title">Total Login Users</div>
                        <div class="tile-stats">
                            <b>
                                <asp:Label ID="lblLogin" runat="server" Text="Label"></asp:Label></b>
                        </div>
                        <div class="tile-footer">
                            <a href="ViewLogin.aspx">View all Login Users</a>
                        </div>
                        <div class="tile-icon">
                            <i class="fa fa-user"></i>
                        </div>
                    </section>
                </div>
            </div>


            <div class="row">
                <div class="col-md-12 col-lg-8">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>User Log</h5>
                        </div>
                        <div class="panel-body">
                            <div class="box-body" style="height: 275px; overflow: scroll">
                                <asp:GridView ID="gd1" runat="server" class="table table-bordered table-striped">
                                </asp:GridView>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
