<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="ViewQset.aspx.cs" Inherits="FinalYearProjectMasterPage.ViewQ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - View Question
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="body" runat="server">
  <asp:scriptmanager id="ScriptManager1" runat="server"></asp:scriptmanager>
     <script type="text/javascript">
         function addtolist() {
            getemail = $("#email").val();
             var node = document.createElement("LI");
             var textnode = document.createTextNode(getemail+" ");
             var button = document.createElement("a");
            
             button.setAttribute('href', "#");
             button.innerHTML = "Remove";
             node.appendChild(textnode);
             node.appendChild(button);
             document.getElementById("selected").appendChild(node);
             return false;

         }
         </script>
    <div class="example-modal">
        <div class="modal modal-warning" id="myModal" role="dialog">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Delete Question Set</h4>
              </div>
              <div class="modal-body">
                              <p>Are you sure delete the Question Set?</p>                                 
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>

                  <asp:button id="Button1" runat="server" text="Delete" class="btn btn-outline" OnClick="Button1_Click"/>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
      </div>
        <div class="example-modal">
        <div class="modal modal-warning" id="myModal2" role="dialog">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Share Question Set With Friends</h4>
              </div>
              <div class="modal-body">
                              <p>A notification email with send to your friends.</p> 
                  <br />
                   <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                <input type="email" id="email" class="form-control" placeholder="Email"/><span class="input-group-btn">
                     <asp:button id="btnadd" runat="server" text="Add" class="btn btn-info btn-flat" OnClick="btnadd_Click"  OnClientClick="return addtolist()" />
                    </span>
                       
                      
              </div>
                  <div>
                      <br />
                       <ul id="selected">
                           
                       </ul></div>
                                                  
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Close</button>

                  <asp:button id="btnshare" runat="server" text="Share now " class="btn btn-outline" OnClick="btnshare_Click" />
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
      </div>


    <div class="content-wrap">
        <div class="wrapper">
            <div class="row">
           
                <div class="col-md-12 col-lg-12">

                    <section class="panel">
                        <div class="panel-heading">
                            <h5> My Question Set</h5>
                            
                        </div>
                        <div class="panel-body">
                            <asp:updatepanel id="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <div id="delmsg" runat="server" class="alert alert-danger alert-dismissable" style="display: none">
                                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                                        <h4><i class="ti-na"></i> Deleted !</h4>
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
    
        <div class="col-md-12">
          <!-- Custom Tabs -->
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#tab_1" data-toggle="tab">All</a></li>
              <li><a href="#tab_2" data-toggle="tab">Public</a></li>
              <li><a href="#tab_3" data-toggle="tab">Private</a></li>
                <li><a href="#tab_4" data-toggle="tab">Favorite</a></li>
            </ul>
            <div class="tab-content">
                
              <div class="tab-pane active" id="tab_1"><br/>
                  <asp:Label ID="lblall" runat="server" Text="Label"></asp:Label><br /><br />
                <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">

                    <ItemTemplate>
                        <div>
                            <table style=" border: 5px solid grey;width:100%" >
                                <tr>
                                    <td rowspan="3"  style="width:300px" >
                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%#Eval("Photo") %>' Height="200px" Width="200px"/></td>
                                    <td rowspan="3" style="vertical-align:top" width: "800px">
                                        <h4><strong>Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;:&nbsp;&nbsp;<%#Eval("Title")%></strong></h4>
                                        <h5> Description&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;<%#Eval("Description")%></h5>
                                        <h5> Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;<%#Eval("Type")%></h5>
                                    </td>
                                    <td style="width:10%;" >
                                        <asp:Button ID="btnPlay" runat="server" Text="Select" CommandName="Playcmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control" />
                                    </td>
                                    <td style="width:10%;" >
                                        <asp:ImageButton ID="ImgbtnEdit" runat="server"  Text="Edit" CommandName="Editcmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/edit-icon.png"/>
                                        
                                    </td>
                                </tr>
                                <tr>
                                   
                                    <td>
                                        <asp:Button ID="Button2" runat="server" Text="Share" CommandName="Sharecmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control" data-toggle="modal" data-target="#myModal2" UseSubmitBehavior="false" OnClientClick="return false;"/>
                                    </td>
                                    <td >
                                        <asp:ImageButton ID="ImgbtnCopy" runat="server"  Text="Copy" CommandName="Copycmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/copy-icon (1).png"/>
                                    </td>
                                </tr>
                                <tr style="padding-left:5px;">
                                  
                                    <td>
                                        <asp:Button ID="btnRanking" runat="server" Text="Ranking" CommandNam="Rankcmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="ImgbtnDelete" runat="server"  Text="Delete" CommandName="Deletecmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/Trash-empty-icon.png" data-toggle="modal" />
                                    </td>
                                </tr>

                            </table>
                        </div>
                    </ItemTemplate>
                    <SeparatorTemplate> 
                        <br />
                    </SeparatorTemplate>
                </asp:Repeater>

              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="tab_2">
                  <br /><br />
<asp:Repeater ID="Repeater2" runat="server" OnItemCommand="Repeater1_ItemCommand">

                    <ItemTemplate>
                        <div>
                            <table style=" border: 5px solid grey;width:100%" >
                                <tr>
                                    <td rowspan="3"  style="width:300px" >
                                        <asp:Image ID="Image2" runat="server" ImageUrl='<%#Eval("Photo") %>' Height="200px" Width="200px"/></td>
                                    <td rowspan="3" style="vertical-align:top" width: "800px">
                                        <h4><strong>Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;:&nbsp;&nbsp;<%#Eval("Title")%></strong></h4>
                                        <h5> Description&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;<%#Eval("Description")%></h5>
                                        <h5> Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;<%#Eval("Type")%></h5>
                                    </td>
                                    <td style="width:10%;" >
                                        <asp:Button ID="Button3" runat="server" Text="Play" CommandNam="Playcmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control"/>
                                    </td>
                                    <td style="width:10%;" >
                                        <asp:ImageButton ID="ImageButton1" runat="server"  Text="Edit" CommandName="Editcmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/edit-icon.png"/>
                                        
                                    </td>
                                </tr>
                                <tr>
                                   
                                    <td>
                                        <asp:Button ID="Button4" runat="server" Text="Share" CommandName="Sharecmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control"/>
                                    </td>
                                    <td >
                                        <asp:ImageButton ID="ImageButton2" runat="server"  Text="Copy" CommandName="Copycmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/copy-icon (1).png"/>
                                    </td>
                                </tr>
                                <tr style="padding-left:5px;">
                                  
                                    <td>
                                        <asp:Button ID="Button5" runat="server" Text="Ranking" CommandNam="Rankcmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="ImageButton3" runat="server"  Text="Delete" CommandName="Deletecmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/Trash-empty-icon.png" data-toggle="modal" />
                                    </td>
                                </tr>

                            </table>
                        </div>
                    </ItemTemplate>
                    <SeparatorTemplate> 
                        <br />
                    </SeparatorTemplate>
                </asp:Repeater>
              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="tab_3">
                  <br /><br />
                <asp:Repeater ID="Repeater3" runat="server" OnItemCommand="Repeater1_ItemCommand">

                    <ItemTemplate>
                        <div>
                            <table style=" border: 5px solid grey;width:100%" >
                                <tr>
                                    <td rowspan="3"  style="width:300px" >
                                        <asp:Image ID="Image3" runat="server" ImageUrl='<%#Eval("Photo") %>' Height="200px" Width="200px"/></td>
                                    <td rowspan="3" style="vertical-align:top" width: "800px">
                                        <h4><strong>Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;:&nbsp;&nbsp;<%#Eval("Title")%></strong></h4>
                                        <h5> Description&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;<%#Eval("Description")%></h5>
                                        <h5> Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;<%#Eval("Type")%></h5>
                                    </td>
                                    <td style="width:10%;" >
                                        <asp:Button ID="Button6" runat="server" Text="Play" CommandNam="Playcmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control"/>
                                    </td>
                                    <td style="width:10%;" >
                                        <asp:ImageButton ID="ImageButton4" runat="server"  Text="Edit" CommandName="Editcmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/edit-icon.png"/>
                                        
                                    </td>
                                </tr>
                                <tr>
                                   
                                    <td>
                                        <asp:Button ID="Button7" runat="server" Text="Share" CommandName="Sharecmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control"/>
                                    </td>
                                    <td >
                                        <asp:ImageButton ID="ImageButton5" runat="server"  Text="Copy" CommandName="Copycmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/copy-icon (1).png"/>
                                    </td>
                                </tr>
                                <tr style="padding-left:5px;">
                                  
                                    <td>
                                        <asp:Button ID="Button8" runat="server" Text="Ranking" CommandNam="Rankcmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="ImageButton6" runat="server"  Text="Delete" CommandName="Deletecmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/Trash-empty-icon.png" data-toggle="modal" />
                                    </td>
                                </tr>

                            </table>
                        </div>
                    </ItemTemplate>
                    <SeparatorTemplate> 
                        <br />
                    </SeparatorTemplate>
                </asp:Repeater>
              </div>
                <div class="tab-pane" id="tab_4">
                    <br /><br />
                <asp:Repeater ID="Repeater4" runat="server" OnItemCommand="Repeater1_ItemCommand">

                    <ItemTemplate>
                        <div>
                            <table style=" border: 5px solid grey;width:100%" >
                                <tr>
                                    <td rowspan="3"  style="width:300px" >
                                        <asp:Image ID="Image4" runat="server" ImageUrl='<%#Eval("Photo") %>' Height="200px" Width="200px"/></td>
                                    <td rowspan="3" style="vertical-align:top" width: "800px">
                                        <h4><strong>Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;:&nbsp;&nbsp;<%#Eval("Title")%></strong></h4>
                                        <h5> Description&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;<%#Eval("Description")%></h5>
                                        <h5> Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;<%#Eval("Type")%></h5>
                                    </td>
                                    <td style="width:10%;" >
                                        <asp:Button ID="Button9" runat="server" Text="Play" CommandNam="Playcmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control"/>
                                    </td>
                                    <td style="width:10%;" >
                                        <asp:ImageButton ID="ImageButton7" runat="server"  Text="Edit" CommandName="Editcmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/edit-icon.png"/>
                                        
                                    </td>
                                </tr>
                                <tr>
                                   
                                    <td>
                                        <asp:Button ID="Button10" runat="server" Text="Share" CommandName="Sharecmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control"/>
                                    </td>
                                    <td >
                                        <asp:ImageButton ID="ImageButton8" runat="server"  Text="Copy" CommandName="Copycmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/copy-icon (1).png"/>
                                    </td>
                                </tr>
                                <tr style="padding-left:5px;">
                                  
                                    <td>
                                        <asp:Button ID="Button11" runat="server" Text="Ranking" CommandNam="Rankcmd" CommandArgument='<%#Eval("QSId")%>' class="btn btn-primary form-control" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="ImageButton9" runat="server"  Text="Delete" CommandName="Deletecmd" CommandArgument='<%#Eval("QSId")%>' ImageUrl="~/Img/Trash-empty-icon.png" data-toggle="modal" />
                                    </td>
                                </tr>

                            </table>
                        </div>
                    </ItemTemplate>
                    <SeparatorTemplate> 
                        <br />
                    </SeparatorTemplate>
                </asp:Repeater>
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
          <!-- nav-tabs-custom -->
        </div>
                            </div>
          </section>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
