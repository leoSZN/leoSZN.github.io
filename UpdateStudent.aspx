<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UpdateStudent.aspx.cs" Inherits="FinalYearProjectMasterPage.UpdateStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Update Students
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .spaced input[type="radio"] {
            margin-left: 10px;
            margin-right: 5px; /* Or any other value */
        }
    </style>
    <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("bstu").className = "active";

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
    <li class="active">
        <a href="ViewStudent.aspx">
            <i class="fa fa-graduation-cap  mr5"></i>Students
        </a></li>
    <li class="active">
        <a href="UpdateStudent.aspx">Update a Students
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <asp:scriptmanager id="ScriptManager1" runat="server"></asp:scriptmanager>
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
                <div class="col-sm-6 col-lg-6 col-xl-6">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Search a Student</h5>
                        </div>
                        <div class="panel-body">
                            <div id="ssID" runat="server" class="form-group">
                                <label>Student</label>
                                <!-- /btn-group -->
                                <asp:textbox id="txtsearch" runat="server" class="form-control" autocomplete="off" placeholder="Student ID"></asp:textbox>
                            </div>

                            <div class="form-group">
                                <div>
                                    <asp:button id="btnSearch" runat="server" text="Search" class="btn btn-primary form-control" onclick="btnSearch_Click" />
                                </div>
                            </div>

                        </div>
                    </section>
                </div>
                <div class="col-md-12 col-lg-12">

                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Update a Student</h5>
                        </div>
                        <div class="panel-body">
                            <asp:updatepanel id="UpdatePanel1" runat="server">
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
                                            </asp:updatepanel>
                            <div class="row">

                                <div class="col-sm-12 col-lg-6 col-xl-6">

                                    <div class="form-group">
                                        <label>Intake</label>
                                        <div>
                                            <asp:dropdownlist id="ddlIntake" runat="server" class="form-control"></asp:dropdownlist>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Faculty</label>
                                        <div>
                                            <asp:dropdownlist id="ddlFacu" runat="server" class="form-control"></asp:dropdownlist>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Program</label>
                                        <div>
                                            <asp:dropdownlist id="ddlProgram" runat="server" class="form-control"></asp:dropdownlist>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Year</label>
                                        <div>
                                            <asp:dropdownlist id="ddlYear" runat="server" class="form-control">
                                                                <asp:ListItem>1</asp:ListItem>
                                                                <asp:ListItem>2</asp:ListItem>
                                                                <asp:ListItem>3</asp:ListItem>
                                                                <asp:ListItem>4</asp:ListItem>
                                                            </asp:dropdownlist>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Semester</label>
                                        <div>
                                            <asp:dropdownlist id="ddlSemester" runat="server" class="form-control">
                                                                <asp:ListItem>1</asp:ListItem>
                                                                <asp:ListItem>2</asp:ListItem>
                                                                <asp:ListItem>3</asp:ListItem>
                                                            </asp:dropdownlist>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-12 col-lg-6 col-xl-6">
                                    <div id="iemail" runat="server" class="form-group">
                                        <label>Email</label>
                                        <div>
                                            <asp:textbox id="txtEmail" runat="server" class="form-control" autocomplete="off" placeholder="Email" type="email"></asp:textbox>
                                        </div>
                                    </div>
                                    <div id="iID" runat="server" class="form-group">
                                        <label>Student ID</label>
                                        <div>
                                            <asp:textbox id="txtSID" runat="server" class="form-control" autocomplete="off" placeholder="Student ID"></asp:textbox>
                                        </div>
                                    </div>

                                    <div id="iname" runat="server" class="form-group">
                                        <label>Student Name</label>
                                        <div>
                                            <asp:textbox id="txtSName" runat="server" class="form-control" autocomplete="off" placeholder="Student Name"></asp:textbox>
                                        </div>
                                    </div>

                                    <div id="iIC" runat="server" class="form-group">
                                        <label>NRIC No</label>
                                        <div>
                                            <asp:textbox id="txtSIC" runat="server" class="form-control" autocomplete="off" placeholder="NRIC No"></asp:textbox>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label>Gender</label>
                                        <div>
                                            <asp:radiobuttonlist id="rd" runat="server" repeatdirection="Horizontal" cssclass="spaced">
                                                                <asp:ListItem Selected="True">Male</asp:ListItem>
                                                                <asp:ListItem>Female</asp:ListItem>
                                                            </asp:radiobuttonlist>
                                        </div>
                                    </div>

                                    <div id="iPhone" runat="server" class="form-group">
                                        <label>Phone</label>
                                        <div>
                                            <asp:textbox id="txtPhone" runat="server" class="form-control" autocomplete="off" placeholder="Phone"></asp:textbox>
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
                                            <asp:button id="Button1" runat="server" text="Update" class="btn btn-primary form-control" onclick="Button1_Click" />
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
