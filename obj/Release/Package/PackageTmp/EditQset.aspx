<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="EditQset.aspx.cs" Inherits="FinalYearProjectMasterPage.EditQset" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Edit Question Set
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
      <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("bq").className = "active";

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
      <li class="active">
        <a href="ViewQset.aspx">
            <i class="fa fa-question-circle mr5"></i>View Question Set
        </a></li>
    <li class="active">
        <a href="EditQset.aspx">Edit Question Set
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <script type="text/javascript">
        var validFilesTypes = ["bmp", "gif", "png", "jpg"];
        function ValidateFile() {
            var file = document.getElementById("<%=FileUpload1.ClientID%>");
        var label = document.getElementById("<%=uploadmsg.ClientID%>");
        var path = file.value;
        var ext = path.substring(path.lastIndexOf(".") + 1, path.length).toLowerCase();
        var isValidFile = false;
        for (var i = 0; i < validFilesTypes.length; i++) {
            if (ext == validFilesTypes[i]) {
                isValidFile = true;
                break;
            }
        }
        if (!isValidFile) {
            label.style.color = "red";
            label.innerHTML = "Invalid File. Please upload a File with" +
    " extension:\n\n" + validFilesTypes.join(", ");
        }
        return isValidFile;
    }
    </script>
    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">

                <div class="col-md-12 col-lg-12">

                    <section class="panel">
                        <div class="panel-heading">
                            <h5>Edit Question Set</h5>
                        </div>
                        <div class="panel-body">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div id="err" runat="server" class="alert alert-danger alert-dismissable" style="display: none">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <h4><i class="ti-na"></i>Oops!</h4>
                                        <ul>
                                            <asp:Label ID="lblEmessage" runat="server" Text="  "></asp:Label>
                                        </ul>
                                    </div>

                                    <div id="Msg" runat="server" class="alert alert-success alert-dismissable" style="display: none">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <h4><i class="icon fa fa-check"></i>Success!</h4>
                                        <ul>
                                            <asp:Label ID="lblmsg" runat="server" Text="  "></asp:Label>
                                        </ul>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <div class="row">

                                <div class="col-sm-12 col-lg-6 col-xl-6">

                                    <div class="form-group">
                                        <label>Title</label>
                                        <div>
                                            <asp:TextBox ID="Textbox1" runat="server" class="form-control" placeholder="Title"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Description</label>
                                        <div>
                                            <textarea id="Textarea1" runat="server" rows="10" class="form-control" style="height: 80px;" placeholder="Desciption about Question Set"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Intro Video </label>
                                        <div>
                                            <asp:TextBox ID="Textbox2" runat="server" class="form-control" placeholder="https://www.youtube.com/watch?v=hMLf9DhFH8Y"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Type</label>
                                        <div>
                                            <asp:DropDownList ID="ddlQType" runat="server" class="form-control">
                                                <asp:ListItem>Public</asp:ListItem>
                                                <asp:ListItem>Private</asp:ListItem>

                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                </div>

                                <div class="col-sm-12 col-lg-6 col-xl-6">
                                    <div id="iphoto" runat="server" class="form-group">
                                        <label>Photo</label>
                                        <div>
                                            <asp:Image runat="server" ID="QSphoto" Height="300px" Width="500px"></asp:Image>
                                            <div class="col-sm-4 col-lg-2 col-xl-2">
                                                <asp:FileUpload accept="image/*" multiple="false" ID="FileUpload1" runat="server"></asp:FileUpload>
                                            </div>
                                            <br/>
                                            <div class="col-sm-4 col-lg-2 col-xl-2">
                                               <asp:button id="Button2" runat="server" text="Upload" OnClick="Button2_Click"  class="btn btn-primary" OnClientClick="return ValidateFile()"/>
                                            </div>
                                            <asp:Label ID="uploadmsg" runat="server"></asp:Label>
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
