<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="CreateQ.aspx.cs" Inherits="FinalYearProjectMasterPage.CreateQ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Create Question
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
           <link href="scripts/sweetalert2.min.css" rel="stylesheet" />
    <script src="scripts/sweetalert2.min.js"></script>
     <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("bq").className = "active";

        }
    </script>
      <script type="text/javascript">
        function failalert() {
            swal({
                title: 'Oops!',
                text: 'Please tick an answer',
                type: 'error'
            });
        }
    </script>
       <script type="text/javascript">
           function successalert() {
            swal({
                title: 'Good Job!',
                text: 'Question successfully created!',
                type: 'success'
            }).then(function () { window.location.href = "viewq.aspx"; });
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
      <li class="active">
        <a href="ViewQ.aspx">
            <i class="fa fa-question-circle mr5"></i>View Question
        </a></li>
    <li class="active">
        <a href="CreateQ.aspx">Create Question
        </a></li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
     <asp:scriptmanager id="ScriptManager1" runat="server"></asp:scriptmanager>
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
                            <h5>Create Question</h5>
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
                                        <label>Question</label>
                                        <div>
                                            <textarea id="Textarea2" runat="server" rows="10" class="form-control" style="height: 80px;" placeholder="Question"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Time Limit</label>
                                        <div>
                                            <asp:dropdownlist id="Dropdownlist1" runat="server" class="form-control">
                                                <asp:ListItem Value="10">10 sec</asp:ListItem>
                                                <asp:ListItem Value="20">20 sec</asp:ListItem>
                                                <asp:ListItem Value="30">30 sec</asp:ListItem>
                                                <asp:ListItem Value="40">40 sec</asp:ListItem>
                                                <asp:ListItem Value="50">50 sec</asp:ListItem>                                                         
                                           </asp:dropdownlist>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Answer 1 (Required)</label>
                                        <div>
                                             <asp:textbox id="Textbox1" runat="server" class="form-control" placeholder="Answer 1"></asp:textbox>
                                            <div style="float:right">   
                                            <asp:ImageButton ID="ImageButton1" ImageUrl="~/Img/deselect.png" OnClick="ImageButton1_Click" runat="server" />
                                                </div> 
                                        </div>
                                    
                                    </div>
                                   <div class="form-group">
                                        <label>Answer 2 (Required)</label>
                                        <div>
                                             <asp:textbox id="Textbox3" runat="server" class="form-control" placeholder="Answer 2"></asp:textbox>
                                         <div style="float:right">   
                                            <asp:ImageButton ID="ImageButton2" ImageUrl="~/Img/deselect.png" onclick="ImageButton2_Click" runat="server" />
                                                </div> 
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Answer 3 </label>
                                        <div>
                                             <asp:textbox id="Textbox4" runat="server" class="form-control" placeholder="Answer 3"></asp:textbox>
                                         <div style="float:right">   
                                            <asp:ImageButton ID="ImageButton3" ImageUrl="~/Img/deselect.png" onclick="ImageButton3_Click" runat="server" />
                                                </div> 
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Answer 4 </label>
                                        <div>
                                             <asp:textbox id="Textbox5" runat="server" class="form-control" placeholder="Answer 4"></asp:textbox>
                                        <div style="float:right">   
                                            <asp:ImageButton ID="ImageButton4" ImageUrl="~/Img/deselect.png" onclick="ImageButton4_Click" runat="server" />
                                                </div> 
                                        </div>
                                    </div>
                                   
                                </div>

                                <div class="col-sm-12 col-lg-6 col-xl-6">
                                    <div id="iemail" runat="server" class="form-group">
                                        <label>Photo</label>
                                        <div>
                                            <asp:image runat="server" id="QSphoto" Height="300px" Width="500px"></asp:image>
                                            <div class="col-sm-4 col-lg-2 col-xl-2">
                                             <asp:fileupload accept="image/*" multiple="false" id="FileUpload1" runat="server" ></asp:fileupload>
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
                                            <asp:button id="Button1" runat="server" text="Create" class="btn btn-primary form-control" OnClick="Button1_Click" />
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
