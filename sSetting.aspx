<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="sSetting.aspx.cs" Inherits="FinalYearProjectMasterPage.sSetting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Setttings
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
     <li class="active">
        <a href="Settings.aspx">
            <i class="fa fa-cogs mr5"></i>Settings
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <div class="content-wrap">
        <div class="wrapper">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div id="err" runat="server" class="alert alert-danger alert-dismissable" style="display: none">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <h4><i class="ti-na"></i> Oops!</h4>
                        <ul>
                            <asp:Label ID="lblEmessage" runat="server" Text=""></asp:Label>
                        </ul>
                    </div>

                    <div id="Msg" runat="server" class="alert alert-success alert-dismissable" style="display: none">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <h4><i class="ti-check"></i> Success!</h4>
                        <ul>
                            <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
                        </ul>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Account Details</h5>
                        </div>
                        <div class="panel overflow-hidden no-b profile p15 panel-order">
                            <div class="row mb25">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-9">
                                            <h4 class="mb0">
                                                <b>

                                                    <span><a>
                                                        <asp:Label ID="lblEmail" runat="server" Text="Label"></asp:Label></a>
                                                    </span>
                                                </b>
                                            </h4>
                                            <br />
                                            <ul class="user-meta">
                                                <li>
                                                    <i class="fa fa-tag mr5"></i>
                                                    <span data-toggle="tooltip" data-placement="top" title="" data-original-title="Position">
                                                        <asp:Label ID="lblPosition" runat="server" Text="Label"></asp:Label></span>
                                                </li>
                                                <li>
                                                    <i class="ti-map-alt mr5"></i>
                                                    <span data-toggle="tooltip" data-placement="top" title="" data-original-title="IP Address">
                                                        <asp:Label ID="lblIp" runat="server" Text="Label"></asp:Label></span>
                                                </li>
                                                <li>
                                                    <i class="ti-world mr5"></i>
                                                    <span data-toggle="tooltip" data-placement="top" title="" data-original-title="Country">
                                                        <asp:Label ID="lblCountry" runat="server" Text="Label"></asp:Label></span>
                                                </li>
                                                <li>
                                                    <i class="ti-server mr5"></i>
                                                    <span data-toggle="tooltip" data-placement="top" title="" data-original-title="Browser">
                                                        <asp:Label ID="lblBrowser" runat="server" Text="Label"></asp:Label></span>
                                                </li>
                                                <li>
                                                    <i class="ti-blackboard mr5"></i>
                                                    <span data-toggle="tooltip" data-placement="top" title="" data-original-title="Operating System">
                                                        <asp:Label ID="lblOS" runat="server" Text="Label"></asp:Label></span>
                                                </li>
                                                <li>
                                                    <i class="fa fa-calendar mr5"></i>
                                                    <span data-toggle="tooltip" data-placement="top" title="" data-original-title="Created Date">
                                                        <asp:Label ID="lblCT" runat="server" Text="Label"></asp:Label></span>
                                                </li>
                                                <li>
                                                    <i class="ti-calendar mr5"></i>
                                                    <span data-toggle="tooltip" data-placement="top" title="" data-original-title="Intake">
                                                        <asp:Label ID="lblIntake" runat="server" Text="None"></asp:Label></span>
                                                </li>
                                                <li>
                                                    <i class="fa fa-key mr5"></i>
                                                    <span data-toggle="tooltip" data-placement="top" title="" data-original-title="Faculty">
                                                        <asp:Label ID="lblFaculty" runat="server" Text="None"></asp:Label></span>
                                                </li>
                                                <li>
                                                    <i class="fa fa-info-circle mr5"></i>
                                                    <span data-toggle="tooltip" data-placement="top" title="" data-original-title="Program">
                                                        <asp:Label ID="lblProgram" runat="server" Text="None"></asp:Label></span>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-xs-6 col-sm-3 text-center">
                                            <figure>
                                                <img src="https://gravatar.com/avatar/84abbc7635677974aba3ae3ab3eeb35a.png?s=110&amp;d=https%3A%2F%2Fselly.gg%2Fimages%2Fdefault-avatar.png" alt="" class="avatar avatar-lg img-circle avatar-bordered">
                                            </figure>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </section>
                </div>

                <div class="col-md-6 col-lg-6">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>User Settins</h5>
                        </div>
                        <div class="panel-body" id="User Settings">
                            <div class="form-group">
                                <label>Email</label><br />
                                <i class="fa fa-envelope-o input-icon"></i>
                                <asp:TextBox ID="txtEmail" runat="server" class="form-control" Style="padding-left: 35px;" type="email" placeholder="Email Address"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label>Username</label><br />
                                <span class="ti-user input-icon"></span>
                                <asp:TextBox ID="txtUsername" runat="server" class="form-control" Style="padding-left: 35px;" placeholder="Username"></asp:TextBox>
                            </div>

                            <div class="actions">
                                <asp:Button ID="Button1" runat="server" Text="Update User Information" class="btn btn-primary btn-block btn-md" data-disable-with="Loading..." OnClick="Button1_Click" />
                            </div>
                        </div>
                    </section>

                </div>

                <div class="col-md-6 col-lg-6">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Password Settings</h5>
                        </div>
                        <div class="panel-body">
                            <div id="ipass" runat="server" class="form-group">
                                <label>Password</label><br />
                                <i class="fa fa-lock input-icon"></i>
                                <asp:TextBox ID="txtNPass" runat="server" class="form-control" Style="padding-left: 35px;" type="password" placeholder="New Password"></asp:TextBox>
                            </div>

                            <div id="icpass" runat="server" class="form-group">
                                <label>Password Confirmation</label><br />
                                <span class="fa fa-lock input-icon"></span>
                                <asp:TextBox ID="txtCpass" runat="server" class="form-control" Style="padding-left: 35px;" type="password" placeholder="Confirm New Password"></asp:TextBox>
                            </div>
                            <div id="iopass" runat="server" class="form-group">
                                <label>Current Password</label><br />
                                <span class="fa fa-lock input-icon"></span>
                                <asp:TextBox ID="txtOPass" runat="server" class="form-control" Style="padding-left: 35px;" type="password" placeholder="Current Password"></asp:TextBox>
                            </div>
                            <div class="actions">
                                <asp:Button ID="Button2" runat="server" Text="Change Password" class="btn btn-primary btn-block btn-md" data-disable-with="Loading..." OnClick="Button2_Click" />
                            </div>
                        </div>
                    </section>

                </div>


            </div>
        </div>
    </div>
</asp:Content>
