<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PrepareGame.aspx.cs" Inherits="FinalYearProjectMasterPage.PrepareGame" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    ILearn - Prepare Game
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="clock/bootstrap.min.css" />
    <script type="text/javascript" src="clock/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="clock/bootstrap-clockpicker.min.css" />

    <style type="text/css">
        .navbar h3 {
            color: #f5f5f5;
            margin-top: 14px;
        }

        .hljs-pre {
            background: #f8f8f8;
            padding: 3px;
        }

        .footer {
            border-top: 1px solid #eee;
            margin-top: 40px;
            padding: 40px 0;
        }

        .input-group {
            width: 110px;
            margin-bottom: 10px;
        }

        .pull-center {
            margin-left: auto;
            margin-right: auto;
        }

        @media (min-width: 768px) {
            .container {
                max-width: 730px;
            }
        }

        @media (max-width: 767px) {
            .pull-center {
                float: right;
            }
        }
    </style>
    <script type="text/javascript">

        window.onload = function () {

            document.getElementById("bhome").className = " ";
            document.getElementById("bgame").className = "active";

        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bar" runat="server">
    <li class="active">
        <a href="ViewGamePIN.aspx">
            <i class="fa fa-gamepad mr5"></i>View Game PIN
        </a></li>
    <li class="active">
        <a href="PrepareGame.aspx">Create Game PIN
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
                                            <asp:ListBox ID="ListBox1" runat="server" Style="width: 100%; overflow: auto"></asp:ListBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div>
                                            <asp:Button ID="btnDel" runat="server" Text="Remove" class="btn btn-primary form-control" OnClick="btnDel_Click" />
                                        </div>
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
                                        <h4><i class="ti-check"></i>Success!</h4>
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
                                    <div>
                                        <label>Subject Start Time</label>
                                        <div class="input-group clockpicker " data-placement="left" data-align="top" data-autoclose="true">
                                            <asp:TextBox ID="txtstime" runat="server" class="form-control">08:00</asp:TextBox>
                                            <span class="input-group-addon">
                                                <span class="fa fa-clock-o"></span>
                                            </span>
                                        </div>

                                           <label>Subject End Time</label>
                                        <div class="input-group clockpicker " data-placement="left" data-align="top" data-autoclose="true">
                                            <asp:TextBox ID="txtetime" runat="server" class="form-control">10:00</asp:TextBox>
                                            <span class="input-group-addon">
                                                <span class="fa fa-clock-o"></span>

                                            </span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div>
                                            <asp:Button ID="Button2" runat="server" Text="Create & Publish" class="btn btn-primary form-control" OnClick="Button2_Click" />
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
    <script type="text/javascript" src="clock/bootstrap-clockpicker.min.js"></script>

    <script type="text/javascript">
        $('.clockpicker').clockpicker()
            .find('input').change(function () {
                console.log(this.value);
            });
        var input = $('#single-input').clockpicker({
            placement: 'bottom',
            align: 'left',
            autoclose: true,
            'default': 'now'
        });

        $('.clockpicker-with-callbacks').clockpicker({
            donetext: 'Done',
            init: function () {
                console.log("colorpicker initiated");
            },
            beforeShow: function () {
                console.log("before show");
            },
            afterShow: function () {
                console.log("after show");
            },
            beforeHide: function () {
                console.log("before hide");
            },
            afterHide: function () {
                console.log("after hide");
            },
            beforeHourSelect: function () {
                console.log("before hour selected");
            },
            afterHourSelect: function () {
                console.log("after hour selected");
            },
            beforeDone: function () {
                console.log("before done");
            },
            afterDone: function () {
                console.log("after done");
            }
        })
            .find('input').change(function () {
                console.log(this.value);
            });

        // Manually toggle to the minutes view
        $('#check-minutes').click(function (e) {
            // Have to stop propagation here
            e.stopPropagation();
            input.clockpicker('show')
                    .clockpicker('toggleView', 'minutes');
        });
        if (/mobile/i.test(navigator.userAgent)) {
            $('input').prop('readOnly', true);
        }
</script>
    <script type="text/javascript" src="clock/highlight.min.js"></script>
    <script type="text/javascript">
        hljs.configure({ tabReplace: '    ' });
        hljs.initHighlightingOnLoad();
</script>
</asp:Content>
