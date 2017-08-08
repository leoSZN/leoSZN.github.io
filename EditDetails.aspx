<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="EditDetails.aspx.cs" Inherits="FinalYearProjectMasterPage.EditAttendance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Edit Attendance
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
         <li class="active">
        <a href="ViewLGamePIN.aspx">
            <i class="fa fa-gamepad mr5"></i>View Game PIN
        </a></li>
     <li class="active">
        <a href="EditDetails.aspx">
          Edit Details
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="content-wrap">
        <div class="wrapper">
             <div class="row">
                        <div class="col-md-12 col-lg-12">
                            <section class="panel">
                                <div class="panel-heading">
                                    <h5>Selected Program</h5>
                                </div>

                                <div class="panel-body" id="">
                                            <div class="row">
                                <div class="col-sm-12 col-lg-12 col-xl-12">
                                     <div class="form-group">
                                        <label>Selected Program</label>
                                        <div>
                                            <asp:ListBox ID="ListBox1" runat="server" style="width:100%;overflow:auto"></asp:ListBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div>
                                            <asp:Button ID="btnDel" runat="server" Text="Remove" class="btn btn-primary form-control" OnClick="btnDel_Click" />                                        </div>
                                    </div>
                                    </div>
                                   </div>
                                </div>
                            </section>
                        </div>
                    </div>
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Game & Program Settings</h5>
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
                                        <h4><i class="ti-check"></i> Success!</h4>
                                        <ul>
                                            <asp:Label ID="lblmsg" runat="server" Text="  "></asp:Label>
                                        </ul>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <div class="row">
                                <div class="col-sm-12 col-lg-6 col-xl-6">
  
                                    <div class="form-group">
                                        <label>Intake</label>
                                        <div>
                                            <asp:DropDownList ID="ddlIntake" class="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Faculty</label>
                                        <div>
                                            <asp:DropDownList ID="ddlFacu" class="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Program</label>
                                        <div>
                                            <asp:DropDownList ID="ddlProgram" class="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Year</label>
                                        <div>
                                            <asp:DropDownList ID="ddlYear" runat="server" class="form-control">
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                                <asp:ListItem>4</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Semester</label>
                                        <div>
                                            <asp:DropDownList ID="ddlsemes" runat="server" class="form-control">
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                            </asp:DropDownList><br />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div>
                                            <asp:Button ID="btnAdd" runat="server" Text="Add" class="btn btn-primary form-control" OnClick="btnAdd_Click" />
                                        </div>
                                    </div>
                                </div>
                                 <div class="col-sm-12 col-lg-6 col-xl-6">
                                    <div id="Div1" runat="server" class="form-group">
                                        <label>Subject</label>
                                        <div>
                                            <asp:TextBox ID="txtSub" runat="server" class="form-control" AutoComplete="off" Placeholder="Subject"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div>
                                            <asp:Button ID="Button2" runat="server" Text="Update" class="btn btn-primary form-control" OnClick="Button2_Click" />
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
