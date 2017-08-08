<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="shome.aspx.cs" Inherits="FinalYearProjectMasterPage.shome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn- Student Home
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <section class="dash-tile bg-primary">
                        <div class="tile-title">Total Attendance</div>
                        <div class="tile-stats">
                            <b>
                                <asp:Label ID="lblatt" runat="server" Text="Label"></asp:Label></b>
                        </div>
                        <div class="tile-footer">
                            <a href="StudentAtt.aspx">View all Attendances</a>
                        </div>
                        <div class="tile-icon">
                            <i class="fa fa-certificate"></i>
                        </div>
                    </section>
                </div>

                 <div class="col-md-3 col-sm-6 col-xs-12">
                    <section class="dash-tile bg-success">
                        <div class="tile-title">Present</div>
                        <div class="tile-stats">
                            <b>
                                <asp:Label ID="lblp" runat="server" Text="Label"></asp:Label></b>
                        </div>
                         <div class="tile-footer">
                            <a>Total Present in class</a>
                        </div>
                        <div class="tile-icon">
                            <i class="fa fa-certificate"></i>
                        </div>
                    </section>
                </div>

                <div class="col-md-3 col-sm-6 col-xs-12">
                    <section class="dash-tile bg-danger">
                        <div class="tile-title">Absent</div>
                        <div class="tile-stats">
                            <b>
                                <asp:Label ID="lbla" runat="server" Text="Label"></asp:Label></b>
                        </div>
                         <div class="tile-footer">
                            <a>Total Absent in class</a>
                        </div>
                        <div class="tile-icon">
                            <i class="fa fa-certificate"></i>
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
