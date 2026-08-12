<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmChangePin.aspx.cs" Inherits="CRMApp.crmapp.frmChangePin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <script type="text/javascript">
        function moveOnMax(field, nextFieldID) {
            if (field.value.length >= field.maxLength) {
                document.getElementById(nextFieldID).focus();
            }
        }

        //function ShowPwd() {
        //    document.getElementById("txtPin1").type = "text";
        //    document.getElementById("txtPin2").type = "text";
        //    document.getElementById("txtPin3").type = "text";
        //    document.getElementById("txtPin4").type = "text";
        //    document.getElementById("txtPin5").type = "text";
        //    document.getElementById("txtPin6").type = "text";
        //}

        function ShowOldPwd() {
            if (document.getElementById("txtOldPin1").type == "text") { document.getElementById("txtOldPin1").type = "password"; } else { document.getElementById("txtOldPin1").type = "text"; }
            if (document.getElementById("txtOldPin2").type == "text") { document.getElementById("txtOldPin2").type = "password"; } else { document.getElementById("txtOldPin2").type = "text"; }
            if (document.getElementById("txtOldPin3").type == "text") { document.getElementById("txtOldPin3").type = "password"; } else { document.getElementById("txtOldPin3").type = "text"; }
            if (document.getElementById("txtOldPin4").type == "text") { document.getElementById("txtOldPin4").type = "password"; } else { document.getElementById("txtOldPin4").type = "text"; }
            if (document.getElementById("txtOldPin5").type == "text") { document.getElementById("txtOldPin5").type = "password"; } else { document.getElementById("txtOldPin5").type = "text"; }
            if (document.getElementById("txtOldPin6").type == "text") { document.getElementById("txtOldPin6").type = "password"; } else { document.getElementById("txtOldPin6").type = "text"; }
        }

        function ShowNewPwd() {
            if (document.getElementById("txtNewPin1").type == "text") { document.getElementById("txtNewPin1").type = "password"; } else { document.getElementById("txtNewPin1").type = "text"; }
            if (document.getElementById("txtNewPin2").type == "text") { document.getElementById("txtNewPin2").type = "password"; } else { document.getElementById("txtNewPin2").type = "text"; }
            if (document.getElementById("txtNewPin3").type == "text") { document.getElementById("txtNewPin3").type = "password"; } else { document.getElementById("txtNewPin3").type = "text"; }
            if (document.getElementById("txtNewPin4").type == "text") { document.getElementById("txtNewPin4").type = "password"; } else { document.getElementById("txtNewPin4").type = "text"; }
            if (document.getElementById("txtNewPin5").type == "text") { document.getElementById("txtNewPin5").type = "password"; } else { document.getElementById("txtNewPin5").type = "text"; }
            if (document.getElementById("txtNewPin6").type == "text") { document.getElementById("txtNewPin6").type = "password"; } else { document.getElementById("txtNewPin6").type = "text"; }
        }

        //function ShowNewFPwd() {
        //    document.getElementById("txtNewFPin1").type = "text";
        //    document.getElementById("txtNewFPin2").type = "text";
        //    document.getElementById("txtNewFPin3").type = "text";
        //    document.getElementById("txtNewFPin4").type = "text";
        //    document.getElementById("txtNewFPin5").type = "text";
        //    document.getElementById("txtNewFPin6").type = "text";
        //}

        //function ShowConfPwd() {
        //    document.getElementById("txtConfPin1").type = "text";
        //    document.getElementById("txtConfPin2").type = "text";
        //    document.getElementById("txtConfPin3").type = "text";
        //    document.getElementById("txtConfPin4").type = "text";
        //    document.getElementById("txtConfPin5").type = "text";
        //    document.getElementById("txtConfPin6").type = "text";
        //}

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
        function onlyDotsAndNumbers(txt, event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if (charCode == 46) {
                if (txt.value.indexOf(".") < 0)
                    return true;
                else
                    return false;
            }

            if (txt.value.indexOf(".") > 0) {
                var txtlen = txt.value.length;
                var dotpos = txt.value.indexOf(".");
                //Change the number here to allow more decimal points than 2
                if ((txtlen - dotpos) > 2)
                    return false;
            }

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

        <%--function ValidateRegForm() {
            var email = document.getElementById("<%=txtEmail.ClientID%>");
            var filter = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;
            if (!filter.test(email.value)) {
                alert('Please provide a valid email address');
                email.focus;
                return false;
            }
            return true;
        }--%>
</script>
    <div class="row">
        <div class="col-sm-12">
            <%--<div class="area-title bdr mt20">
                <h2><a data-toggle="modal" data-target="#NewPinModal" class="btn btn-default">New Transaction PIN</a></h2>
            </div>--%>
            <%--<div class="area-title bdr mt20">
                <h2><a data-toggle="modal" data-target="#ChangePinModal" class="btn btn-default">Change PIN</a></h2>
            </div>--%>
            <%--<div class="area-title bdr mt20">
                <h2><a data-toggle="modal" data-target="#ForgotPinModal" class="btn btn-default">Forgot PIN</a></h2>
            </div>--%>

            <%--<div class="area-title bdr mt20">
                <h2><a data-toggle="modal" data-target="#ForgotPinModal_New" class="btn btn-default">Forgot PIN</a></h2>
            </div>--%>

            <div class="list-summary">
                <a data-toggle="modal" data-target="#ChangePinModal">
                    <div class="info-box bg-aqua">
                        <span class="info-box-icon">
                            <img src="img/icon/icon-ad-1.png">
                        </span>
                        <div class="info-box-content">
                            <span class="info-box-text">Change Pin</span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                </a>
                <!-- /.info-box -->
            </div>
            <div class="list-summary">
                <a data-toggle="modal" data-target="#ForgotPinModal_New">
                    <div class="info-box bg-red-active">
                        <span class="info-box-icon">
                            <img src="img/icon/icon-ad-2.png">
                        </span>
                        <div class="info-box-content">
                            <span class="info-box-text">Forgot Pin</span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                </a>
                <!-- /.info-box -->
            </div>

            <%--<div id="NewPinModal" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title">6-digit PIN</h4>

                        </div>
                        <div class="modal-body">
                            <asp:UpdatePanel ID="UpdTranPin" runat="server">
                                <ContentTemplate>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-12 control-label">Please enter your new 6 digit PIN</label>
                                    </div>                                    
                                    
                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtPin1" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" style="font-family:fontello; color: red" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtPin2')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFNewPin1" runat="server" CssClass="required" ControlToValidate="txtPin1" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPin2" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtPin3')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFNewPin2" runat="server" CssClass="required" ControlToValidate="txtPin2" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPin3" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtPin4')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFNewPin3" runat="server" CssClass="required" ControlToValidate="txtPin3" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPin4" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtPin5')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFNewPin4" runat="server" CssClass="required" ControlToValidate="txtPin4" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPin5" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtPin6')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFNewPin5" runat="server" CssClass="required" ControlToValidate="txtPin5" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPin6" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFNewPin6" runat="server" CssClass="required" ControlToValidate="txtPin6" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td><a href="#" id="btnView3" onclick="ShowPwd(this)"><i class="fa fa-eye" style="font-size: 24px"></i></a></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="lnkNCancel" runat="server" OnClick="lnkNCancel_Click" CssClass="btn btn-block">Cancel</asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="lnkNSubmit" runat="server" OnClick="lnkNSubmit_Click" ValidationGroup="ChangeNewPinValue" CssClass="btn btn-primary btn-block">Submit</asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="Div3" runat="server" class="form-group" style="font-size: smaller;">
                                        <span id="message_nPin" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>--%>

            <div id="ChangePinModal" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title">Change PIN</h4>

                        </div>
                        <div class="pin-mobile modal-body">
                            <asp:UpdatePanel ID="UpdChangePin" runat="server">
                                <ContentTemplate>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-12 control-label">Please enter old 6 digit PIN</label>
                                    </div>
                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtOldPin1" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtOldPin2')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFPin1" runat="server" CssClass="required" ControlToValidate="txtOldPin1" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtOldPin2" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtOldPin3')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFPin2" runat="server" CssClass="required" ControlToValidate="txtOldPin2" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtOldPin3" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtOldPin4')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFPin3" runat="server" CssClass="required" ControlToValidate="txtOldPin3" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtOldPin4" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtOldPin5')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFPin4" runat="server" CssClass="required" ControlToValidate="txtOldPin4" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtOldPin5" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtOldPin6')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFPin5" runat="server" CssClass="required" ControlToValidate="txtOldPin5" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtOldPin6" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFPin6" runat="server" CssClass="required" ControlToValidate="txtOldPin6" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td><a href="#" id="btnView1" onclick="ShowOldPwd(this)"><i class="fa fa-eye" style="font-size: 24px"></i></a></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-12 control-label">Please enter your new 6 digit PIN</label>
                                    </div>
                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtNewPin1" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtNewPin2')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="required" ControlToValidate="txtNewPin1" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNewPin2" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtNewPin3')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="required" ControlToValidate="txtNewPin2" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNewPin3" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtNewPin4')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="required" ControlToValidate="txtNewPin3" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNewPin4" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtNewPin5')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="required" ControlToValidate="txtNewPin4" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNewPin5" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtNewPin6')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="required" ControlToValidate="txtNewPin5" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNewPin6" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="required" ControlToValidate="txtNewPin6" ValidationGroup="ChangePinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td><a href="#" id="btnView2" onclick="ShowNewPwd(this)"><i class="fa fa-eye" style="font-size: 24px"></i></a></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="lnkCancel" runat="server" OnClick="lnkCancel_Click" CssClass="btn btn-block">Cancel</asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="lnkSave" runat="server" OnClick="lnkSave_Click" ValidationGroup="ChangePinValue" CssClass="btn btn-primary btn-block">Save</asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="Div2" runat="server" class="form-group" style="font-size: smaller;">
                                        <span id="message_cPin" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>

            <%--<div id="ForgotPinModal" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title">New Transaction PIN</h4>

                        </div>
                        <div class="modal-body">
                            <asp:UpdatePanel ID="updForgotPin" runat="server">
                                <ContentTemplate>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-12 control-label">Insert Email ID</label>
                                    </div>
                                    
                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtEmail" ClientIDMode="Static" CssClass="col-sm-12 form-control myfocus" runat="server" placeholder="Email address"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" CssClass="required" ControlToValidate="txtEmail" ValidationGroup="submitValForgotPin" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="valRegEmail" runat="server" ControlToValidate="txtEmail"
                                                        ErrorMessage="Please give a valid email address" ValidationGroup="submitValForgotPin" CssClass="required"
                                                        ValidationExpression="^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z\.][a-zA-Z]{1,3}$">
                                                    </asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                        </table>                                        
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-12 control-label">Please enter new 6 digit PIN</label>
                                    </div>
                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtNewFPin1" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeyup="moveOnMax(this,'txtNewFPin2')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" CssClass="required" ControlToValidate="txtNewFPin1" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNewFPin2" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeyup="moveOnMax(this,'txtNewFPin3')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" CssClass="required" ControlToValidate="txtNewFPin2" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNewFPin3" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeyup="moveOnMax(this,'txtNewFPin4')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" CssClass="required" ControlToValidate="txtNewFPin3" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNewFPin4" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeyup="moveOnMax(this,'txtNewFPin5')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" CssClass="required" ControlToValidate="txtNewFPin4" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNewFPin5" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeyup="moveOnMax(this,'txtNewFPin6')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" CssClass="required" ControlToValidate="txtNewFPin5" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNewFPin6" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" placeholder="*" Width="70%" MaxLength="1"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" CssClass="required" ControlToValidate="txtNewFPin6" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td><a href="#" id="btnFView2" onclick="ShowNewFPwd(this)"><i class="fa fa-eye" style="font-size: 24px"></i></a></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-12 control-label">Confirm your new 6 digit PIN</label>
                                    </div>
                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtConfPin1" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeyup="moveOnMax(this,'txtConfPin2')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="required" ControlToValidate="txtConfPin1" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtConfPin2" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeyup="moveOnMax(this,'txtConfPin3')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" CssClass="required" ControlToValidate="txtConfPin2" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtConfPin3" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeyup="moveOnMax(this,'txtConfPin4')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" CssClass="required" ControlToValidate="txtConfPin3" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtConfPin4" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeyup="moveOnMax(this,'txtConfPin5')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" CssClass="required" ControlToValidate="txtConfPin4" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtConfPin5" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeyup="moveOnMax(this,'txtConfPin6')"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" CssClass="required" ControlToValidate="txtConfPin5" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtConfPin6" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" placeholder="*" Width="70%" MaxLength="1"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" CssClass="required" ControlToValidate="txtConfPin6" ValidationGroup="submitValForgotPin" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                </td>
                                                <td><a href="#" id="btnFView1" onclick="ShowConfPwd(this)"><i class="fa fa-eye" style="font-size: 24px"></i></a></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="lnkFCancel" runat="server" OnClick="lnkFCancel_Click" CssClass="btn btn-block">Cancel</asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="lnkFSave" runat="server" OnClick="lnkFSave_Click" ValidationGroup="submitValForgotPin" CssClass="btn btn-primary btn-block">Save</asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="Div1" runat="server" class="form-group" style="font-size: smaller;">
                                        <span id="message_fPin" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>--%>

            <div id="ForgotPinModal_New" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title">Forgot Transaction PIN</h4>

                        </div>
                        <div class="modal-body">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-12 control-label">Email ID</label>
                                    </div>

                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtUserEmail" ClientIDMode="Static" CssClass="col-sm-12 form-control myfocus" runat="server" placeholder="Email address" ReadOnly></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" CssClass="required" ControlToValidate="txtUserEmail" ValidationGroup="submitValForgotPin" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUserEmail"
                                                        ErrorMessage="Please give a valid email address" ValidationGroup="submitValForgotPin" CssClass="required"
                                                        ValidationExpression="^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z\.][a-zA-Z]{1,3}$">
                                                    </asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="form-group">
                                        <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                            <tr>
                                                <%--<td>
                                                    <asp:LinkButton ID="lnkFPinCancel" runat="server" OnClick="lnkFCancel_Click" CssClass="btn btn-block">Cancel</asp:LinkButton></td>--%>
                                                <td>
                                                    <asp:LinkButton ID="lnkFPinSave" runat="server" OnClick="lnkFPinSave_Click" ValidationGroup="submitValForgotPin" CssClass="btn btn-primary btn-block">Forgot PIn</asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="Div4" runat="server" class="form-group" style="font-size: smaller;">
                                        <span id="message_fPin" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
        </div>
        <div class="gap-mid"></div>
    </div>
</asp:Content>
