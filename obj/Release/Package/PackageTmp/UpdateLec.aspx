<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UpdateLec.aspx.cs" Inherits="FinalYearProjectMasterPage.UpdateLec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Update Lecturer
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("blec").className = "active";

        }
    </script>
    <style type="text/css">
        .spaced input[type="radio"] {
            margin-left: 10px;
            margin-right: 5px; /* Or any other value */
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
    <li class="active">
        <a href="ViewLec.aspx">
            <i class="fa fa-user mr5"></i>Lecturers
        </a></li>
    <li class="active">
        <a href="UpdateLec.aspx">Update a Lecturer
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-sm-6 col-lg-6 col-xl-6">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Search a Lecturer</h5>
                        </div>
                        <div class="panel-body">
                            <div id="ssID" runat="server" class="form-group">
                                <label>Lecturer ID</label>
                                <!-- /btn-group -->
                                <asp:TextBox ID="txtsearch" runat="server" class="form-control" AutoComplete="off" Placeholder="Lecturer ID"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <div>
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn btn-primary form-control" OnClick="btnSearch_Click" />
                                </div>
                            </div>

                        </div>
                    </section>
                </div>
                <div class="col-md-6 col-lg-6">

                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Update a Lecturer</h5>
                        </div>
                        <div class="panel-body">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div id="err" runat="server" class="alert alert-danger alert-dismissable" style="display: none">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <h4><i class="ti-na"></i> Oops!</h4>
                                        <ul>
                                            <asp:Label ID="lblEmessage" runat="server" Text="  "></asp:Label>
                                        </ul>
                                    </div>

                                    <div id="Msg" runat="server" class="alert alert-success alert-dismissable" style="display: none">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <h4><i class="icon fa fa-check"></i> Success!</h4>
                                        <ul>
                                            <asp:Label ID="lblmsg" runat="server" Text="  "></asp:Label>
                                        </ul>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <div class="row">



                                <div class="col-sm-12 col-lg-12 col-xl-12">
                                    <div id="iemail" runat="server" class="form-group">
                                        <label>Email</label>
                                        <div>
                                            <asp:TextBox ID="txtemail" runat="server" class="form-control" AutoComplete="off" Placeholder="Email" type="email"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div id="iID" runat="server" class="form-group">
                                        <label>Lecturer ID</label>
                                        <div>
                                            <asp:TextBox ID="txtID" runat="server" class="form-control" AutoComplete="off" Placeholder="Lecturer ID"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div id="iname" runat="server" class="form-group">
                                        <label>Lecturer Name</label>
                                        <div>
                                            <asp:TextBox ID="txtname" runat="server" class="form-control" AutoComplete="off" Placeholder="Lecturer Name"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div id="iIC" runat="server" class="form-group">
                                        <label>NRIC No</label>
                                        <div>
                                            <asp:TextBox ID="txtSIC" runat="server" class="form-control" AutoComplete="off" Placeholder="NRIC No"></asp:TextBox>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label>Gender</label>
                                        <div>
                                            <asp:RadioButtonList ID="rd" runat="server" RepeatDirection="Horizontal" CssClass="spaced">
                                                <asp:ListItem Selected="True">Male</asp:ListItem>
                                                <asp:ListItem>Female</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>

                                    <div id="iPhone" runat="server" class="form-group">
                                        <label>Phone</label>
                                        <div>
                                            <asp:TextBox ID="txtPhone" runat="server" class="form-control" AutoComplete="off" Placeholder="Phone"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div id="iAdd" runat="server" class="form-group">
                                        <label>Address</label>
                                        <div>
                                            <textarea id="txtAddress" runat="server" rows="10" class="form-control" style="height: 80px;" placeholder="Address"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div>
                                            <asp:Button ID="Button1" runat="server" Text="Update" class="btn btn-primary form-control" OnClick="Button1_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
