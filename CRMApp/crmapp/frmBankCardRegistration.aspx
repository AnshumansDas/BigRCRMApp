<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmBankCardRegistration.aspx.cs" Inherits="CRMApp.crmapp.frmBankCardRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <script type="text/javascript">
        function moveOnMax(field, nextFieldID) {
            if (field.value.length >= field.maxLength) {
                document.getElementById(nextFieldID).focus();
            }
        }

        function ShowNewTpinPwd() {
            if (document.getElementById("TxtNewPin1").type == "text") { document.getElementById("TxtNewPin1").type = "password"; } else { document.getElementById("TxtNewPin1").type = "text"; }
            if (document.getElementById("TxtNewPin2").type == "text") { document.getElementById("TxtNewPin2").type = "password"; } else { document.getElementById("TxtNewPin2").type = "text"; }
            if (document.getElementById("TxtNewPin3").type == "text") { document.getElementById("TxtNewPin3").type = "password"; } else { document.getElementById("TxtNewPin3").type = "text"; }
            if (document.getElementById("TxtNewPin4").type == "text") { document.getElementById("TxtNewPin4").type = "password"; } else { document.getElementById("TxtNewPin4").type = "text"; }
            if (document.getElementById("TxtNewPin5").type == "text") { document.getElementById("TxtNewPin5").type = "password"; } else { document.getElementById("TxtNewPin5").type = "text"; }
            if (document.getElementById("TxtNewPin6").type == "text") { document.getElementById("TxtNewPin6").type = "password"; } else { document.getElementById("TxtNewPin6").type = "text"; }
        }
        function ShowOldTpinPwd() {
            if (document.getElementById("txtPin1").type == "text") { document.getElementById("txtPin1").type = "password"; } else { document.getElementById("txtPin1").type = "text"; }
            if (document.getElementById("txtPin2").type == "text") { document.getElementById("txtPin2").type = "password"; } else { document.getElementById("txtPin2").type = "text"; }
            if (document.getElementById("txtPin3").type == "text") { document.getElementById("txtPin3").type = "password"; } else { document.getElementById("txtPin3").type = "text"; }
            if (document.getElementById("txtPin4").type == "text") { document.getElementById("txtPin4").type = "password"; } else { document.getElementById("txtPin4").type = "text"; }
            if (document.getElementById("txtPin5").type == "text") { document.getElementById("txtPin5").type = "password"; } else { document.getElementById("txtPin5").type = "text"; }
            if (document.getElementById("txtPin6").type == "text") { document.getElementById("txtPin6").type = "password"; } else { document.getElementById("txtPin6").type = "text"; }
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
    </script>
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>Credit/Debit Cards</h2>
        </div>
        <div class="col-sm-6 pull-right">
            <asp:LinkButton ID="LnkValidateTpin" runat="server" data-toggle="modal" Text="+Add Credit/Debit Card Details" data-target="#ValidateTPinModal" class="btn btn-success pull-right"></asp:LinkButton>
            <asp:LinkButton ID="LnkNewTPin" runat="server" data-toggle="modal" Text="+New Tpin" data-target="#NewTPinModal" class="btn btn-success pull-right"></asp:LinkButton>
        </div>
    </div>
    <div class="col-sm-12">
        <div class="gap-mid"></div>
        <div id="Div3" runat="server" class="form-group" style="font-size: smaller;">
            <span id="message_cPin" runat="server" style="font-size: smaller;"></span>
        </div>
        <div class="gap-mid"></div>
      
        <div id="NewTPinModal" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">Create 6-digit TPIN</h4>

                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-12 control-label">Please enter your new 6 digit TPIN</label>
                        </div>

                        <div class="form-group">
                            <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="TxtNewPin1" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'TxtNewPin2')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFVNPin1" runat="server" CssClass="required" ControlToValidate="TxtNewPin1" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtNewPin2" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'TxtNewPin3')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFVNPin2" runat="server" CssClass="required" ControlToValidate="TxtNewPin2" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtNewPin3" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'TxtNewPin4')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFVNPin3" runat="server" CssClass="required" ControlToValidate="TxtNewPin3" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtNewPin4" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'TxtNewPin5')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFVNPin4" runat="server" CssClass="required" ControlToValidate="TxtNewPin4" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtNewPin5" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'TxtNewPin6')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFVNPin5" runat="server" CssClass="required" ControlToValidate="TxtNewPin5" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtNewPin6" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFVNPin6" runat="server" CssClass="required" ControlToValidate="TxtNewPin6" ValidationGroup="ChangeNewPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td><a href="#" id="btnView3" onclick="ShowNewTpinPwd(this)"><i class="fa fa-eye" style="font-size: 24px"></i></a></td>
                                </tr>
                            </table>
                        </div>
                        <div class="form-group">
                            <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="LbCancelNewTPin" OnClick="LbCancelNewTPin_Click" runat="server" CssClass="btn btn-block">Cancel</asp:LinkButton></td>
                                    <td>
                                        <asp:LinkButton ID="LbNewTPin" OnClick="LbNewTPin_Click" runat="server" CssClass="btn btn-primary btn-block">Submit</asp:LinkButton></td>
                                </tr>
                            </table>
                        </div>
                        <div id="Div1" runat="server" class="form-group" style="font-size: smaller;">
                            <span id="message_nPin" runat="server" style="font-size: smaller;"></span>
                        </div>
                    </div>

                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div id="ValidateTPinModal" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">6-digit TPIN</h4>

                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-12 control-label">Please enter the 6 digit TPIN</label>
                        </div>

                        <div class="form-group">
                            <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtPin1" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" Style="font-family: fontello; color: red" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtPin2')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFNewPin1" runat="server" CssClass="required" ControlToValidate="txtPin1" ValidationGroup="ValidateTPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPin2" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtPin3')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFNewPin2" runat="server" CssClass="required" ControlToValidate="txtPin2" ValidationGroup="ValidateTPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPin3" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtPin4')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFNewPin3" runat="server" CssClass="required" ControlToValidate="txtPin3" ValidationGroup="ValidateTPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPin4" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtPin5')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFNewPin4" runat="server" CssClass="required" ControlToValidate="txtPin4" ValidationGroup="ValidateTPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPin5" ClientIDMode="Static" TextMode="Password" CssClass="form-control" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)" onkeyup="moveOnMax(this,'txtPin6')"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFNewPin5" runat="server" CssClass="required" ControlToValidate="txtPin5" ValidationGroup="ValidateTPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPin6" ClientIDMode="Static" TextMode="Password" CssClass="form-control myfocus" runat="server" PasswordChar="*" placeholder="*" Width="70%" MaxLength="1" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFNewPin6" runat="server" CssClass="required" ControlToValidate="txtPin6" ValidationGroup="ValidateTPinValue" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                    <td><a href="#" id="btnView3" onclick="ShowOldTpinPwd(this)"><i class="fa fa-eye" style="font-size: 24px"></i></a></td>
                                </tr>
                            </table>
                        </div>

                        <div class="form-group">
                            <table width="80%" cellspacing="2" cellpadding="2" align="center">
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lnkValidateCancelTPin" runat="server" OnClick="lnkValidateCancelTPin_Click" CssClass="btn btn-block">Cancel</asp:LinkButton></td>
                                    <td>
                                        <%--<asp:LinkButton ID="lnkNSubmit" runat="server" OnClick="lnkNSubmit_Click" ValidationGroup="ChangeNewPinValue" CssClass="btn btn-primary btn-block">Submit</asp:LinkButton></td>--%>
                                        <asp:LinkButton ID="LbValidateTpin" runat="server" ValidationGroup="ValidateTPinValue" OnClick="LbValidateTpin_Click" CssClass="btn btn-primary btn-block">Submit</asp:LinkButton>
                                </tr>
                            </table>
                        </div>



                    </div>

                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <div class="gap-mid"></div>

        <div>
            <asp:ListView ID="LvTokenDetails" runat="server" DataKeyNames="token_id" OnItemCommand="LvTokenDetails_ItemCommand"
                GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="LvTokenDetails_ItemDataBound">
                <LayoutTemplate>
                    <div class="row">
                        <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                    </div>
                                        <table class="table table-striped" width="100%" cellspacing="0">
                      <thead>
                        <tr>
                            <th style="width: 5%; text-align: center;"></th>
                            <th style="width: 30%; text-align: center;""></th>
                             <th style="width: 50%; text-align: center;"></th>
                         </tr>
                      </thead>
                      <tbody>
                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                      </tbody>
                    </table>
                    <div class="gap-mid"></div>
                </LayoutTemplate>
                <GroupTemplate>
                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                </GroupTemplate>
                <ItemTemplate>
                    <tr>
                        <td style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                        <td style="text-align: center;">
                            <asp:Image ID="imgCard" runat="server" Width="30px" Height="20px" ImageUrl="~/crmapp/img/maescard.jpg" /><%# Eval("mask_card_no") %> &nbsp;
                            <asp:Label ID="LblPrimary" runat="server" Text='<%# Eval("Primary_flag")%>' BackColor="Green" Font-Size="X-Small" ForeColor="White" Font-Bold="true"></asp:Label>
                            <br />
                            <%# Eval("bank")%></td>
                        <td style="text-align: right;">
                            <asp:LinkButton ID="lnkPrimary" runat="server" OnClientClick="return confirm('Are you sure you want to set this as Primary card?')" CommandName="Primary" class="btn btn-success sm pull-right" ToolTip="Primary Card">Set as Primary</asp:LinkButton>
                            <asp:Label ID="lbltokenId" Visible="false" runat="server" Text='<%# Eval("token_id") %>'></asp:Label>
                            <asp:Label ID="LblPrimaryFlag" Visible="false" runat="server" Text='<%# Eval("Is_Primary") %>'></asp:Label>
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <table class="table table-striped" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th style="width: 5%; text-align: center;">No</th>
                                <th style="width: 15%;">Card No</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="10" style="text-align: center;">You don't have Credit/Debit Card Details yet.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </div>
</asp:Content>
