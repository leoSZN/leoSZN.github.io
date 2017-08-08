<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="lHome.aspx.cs" Inherits="FinalYearProjectMasterPage.lHome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Home - Lecturer Home
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
                        <div class="tile-title">Total Game PIN</div>
                        <div class="tile-stats">
                            <b>
                                <asp:Label ID="lblatt" runat="server" Text="Label"></asp:Label></b>
                        </div>
                        <div class="tile-footer">
                            <a href="ViewLGamePIN.aspx">View all Game PIN</a>
                        </div>
                        <div class="tile-icon">
                            <i class="fa fa-certificate"></i>
                        </div>
                    </section>
                </div>

                <div class="col-md-3 col-sm-6 col-xs-12">
                    <section class="dash-tile bg-success">
                        <div class="tile-title">Total Question Sets</div>
                        <div class="tile-stats">
                            <b>
                                <asp:Label ID="labelq" runat="server" Text="Label"></asp:Label></b>
                        </div>
                        <div class="tile-footer">
                            <a href="ViewQSet.aspx">View all Question Sets</a>
                        </div>
                        <div class="tile-icon">
                            <i class="fa fa-question-circle"></i>
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
