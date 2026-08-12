<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmCommunityAddEdit.aspx.cs" Inherits="CRMApp.crmapp.frmCommunityAddEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
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

        function ValidateRegForm() {
            var email = document.getElementById("<%=txtEmail.ClientID%>");
            var filter = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;
            if (!filter.test(email.value)) {
                alert('Please provide a valid email address');
                email.focus;
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Add/Edit Community</h2>
            </div>

            <div id="AddNewCommunity" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title">Add New Community</h4>

                        </div>
                        <div class="modal-body">
                            <asp:UpdatePanel ID="UpdCommunity" runat="server">
                                <ContentTemplate>
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlSPid" CssClass="form-control" runat="server"></asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <asp:TextBox ID="txtCommunityName" ClientIDMode="Static" CssClass="form-control myfocus" runat="server" placeholder="Community Name"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="required" ControlToValidate="txtCommunityName" ValidationGroup="AddEditCommunityValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <asp:TextBox ID="txtCommunityUrl" CssClass="form-control" runat="server" placeholder="Activation Url"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="required" ControlToValidate="txtCommunityUrl" ValidationGroup="AddEditCommunityValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regUrl" runat="server" CssClass="required" ControlToValidate="txtCommunityUrl" ValidationExpression="^((http|https)://)?([\w-]+\.)+[\w]+(/[\w- ./?]*)?$" Text="Required valid URL" />   
                                    </div>
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlActiveStatus_Community" CssClass="form-control" runat="server">
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div id="Div2" runat="server" class="form-group" style="font-size: smaller;">
                                        <span id="message_community" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                    <asp:LinkButton ID="lnkSubmit" runat="server" OnClick="lnkSubmit_Click" ValidationGroup="AddEditCommunityValue" CssClass="btn btn-primary btn-block">Submit</asp:LinkButton>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>

            <div class="form-horizontal">
                <asp:UpdatePanel runat="server" ID="upCommunity">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="col-sm-10 text-right">
                                    <div class="form-group">
                                        <span id="message" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </div>
                                <div class="col-sm-2 text-right">
                                    <div class="form-group">
                                        <asp:Button ID="btnCancel" runat="server" Text="Back" CssClass="btn btn-action" OnClick="btnCancel_Click" />
                                        <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="submitValCommunityAddEdit" CssClass="btn btn-info" OnClick="btnSave_Click" />
                                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Community Name<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlCommunity" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCommunity_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-1" title="Add New Community">
                                    <a data-toggle="modal" data-target="#AddNewCommunity" class="btn btn-default">+</a>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlCommunity" ValidationGroup="submitValCommunityAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">Email<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Email address"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" CssClass="required" ControlToValidate="txtEmail" ValidationGroup="submitValCommunityAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="valRegEmail" runat="server" ControlToValidate="txtEmail"
                                        ErrorMessage="Please give a valid email address" ValidationGroup="submitValCommunityAddEdit" CssClass="required"
                                        ValidationExpression="^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z\.][a-zA-Z]{1,3}$">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="form-group" id="Div1" runat="server" visible="false">
                                <label class="col-sm-3 control-label"></label>
                                <div class="col-sm-7">
                                    <span id="Span2" runat="server" style="font-size: small; color: red;"></span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Address Line 1</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtAddress1" CssClass="form-control" runat="server" placeholder="Address Line 1"></asp:TextBox>
                                </div>
                                <%--<div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantAddress1" runat="server" CssClass="required" ControlToValidate="txtAddress1" ValidationGroup="submitValCommunityAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>--%>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Address Line 2</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtAddress2" CssClass="form-control" runat="server" placeholder="Address Line 2"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Postcode</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtPostcode" CssClass="form-control" runat="server" MaxLength="5" placeholder="Postcode" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">State<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlState" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantState" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlState" ValidationGroup="submitValCommunityAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">City<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlCity" CssClass="form-control" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlCity" ValidationGroup="submitValCommunityAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Person In Charge<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtPersonInCharge" CssClass="form-control" runat="server" placeholder="PIC name"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantPIC" runat="server" CssClass="required" ControlToValidate="txtPersonInCharge" ValidationGroup="submitValCommunityAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Telephone No</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtTelephoneNo" CssClass="form-control" runat="server" placeholder="Telephone no" MaxLength="11" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                </div>
                                <%--<div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantHpNo" runat="server" CssClass="required" ControlToValidate="txtTelephoneNo" ValidationGroup="submitValCommunityAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>--%>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Fax No</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtFaxNo" CssClass="form-control" runat="server" placeholder="Fax no" MaxLength="11" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">PIC Telephone No</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtPICphoneNo" CssClass="form-control" runat="server" placeholder="PIC phone no" MaxLength="11" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                </div>
                                <%--<div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantOffcNo" runat="server" CssClass="required" ControlToValidate="txtPICphoneNo" ValidationGroup="submitValCommunityAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>--%>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Activation URL</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtActivationUrl" CssClass="form-control" runat="server" placeholder="Activation URL" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Active Status</label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlActiveStatus_CommunityDetails" CssClass="form-control" runat="server">
                                        <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                        <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

        <div class="gap-mid"></div>
    </div>
    <%--<script type="text/javascript">
        function SuccessCommunityMsg() {
            $('#AddNewCommunity').modal('show');
            window.setTimeout(function () {
                $("#AddNewCommunity").modal("hide");
            }, 3500);
        }
    </script>--%>
</asp:Content>

