<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMerchantAddEditOutlet.aspx.cs" Inherits="CRMApp.crmapp.frmMerchantAddEditOutlet" MasterPageFile="~/crmapp/CRMBack.Master" %>

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
                if ((txtlen - dotpos) > 6)
                    return false;
            }

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Add/Edit Merchant Outlet</h2>
            </div>
            <div class="form-horizontal">
                <asp:UpdatePanel runat="server" ID="upMerchant">
                    <ContentTemplate>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Merchant Name<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlMerchName" CssClass="form-control" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantName" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlMerchName" ValidationGroup="submitValMerchantAddEditOutlet" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Branch Name<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtBranchName" CssClass="form-control focus" runat="server" placeholder="Branch Name"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvBranchName" runat="server" CssClass="required" ControlToValidate="txtBranchName" ValidationGroup="submitValMerchantAddEditOutlet" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Person In Charge</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtPersonInCharge" CssClass="form-control" runat="server" placeholder="PIC name"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantPIC" runat="server" CssClass="required" ControlToValidate="txtPersonInCharge" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Mobile Phone No<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtMobileNo" CssClass="form-control" runat="server" placeholder="Mobile phone no" MaxLength="11" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantHpNo" runat="server" CssClass="required" ControlToValidate="txtMobileNo" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Office Phone No<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtOfficeNo" CssClass="form-control" runat="server" placeholder="Office phone no" MaxLength="11" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Fax No</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtFaxNo" CssClass="form-control" runat="server" placeholder="Fax no" MaxLength="11" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Email<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Email address"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" CssClass="required" ControlToValidate="txtEmail" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Username<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server" placeholder="Login Username"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" CssClass="required" ControlToValidate="txtUsername" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12 text-center">
                                    <asp:RegularExpressionValidator ID="valRegEmail" runat="server" ControlToValidate="txtEmail"
                                        ErrorMessage="Please give valid email address" ValidationGroup="submitValMerchantAddEdit" CssClass="required"
                                        ValidationExpression="^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z\.][a-zA-Z]{1,3}$">
                                    </asp:RegularExpressionValidator>
                                    <span id="checkemailmsg" visible="false" runat="server" style="font-size: small; color: red;"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Mailing Address 1<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtAddress1" CssClass="form-control" runat="server" placeholder="Address Line 1"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvAddress1" runat="server" CssClass="required" ControlToValidate="txtAddress1" ValidationGroup="submitValMerchantAddEditOutlet" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Mailing Address 2</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtAddress2" CssClass="form-control" runat="server" placeholder="Address Line 2"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Postcode</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtPostcode" CssClass="form-control" runat="server" MaxLength="5" placeholder="Postcode" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvPostcode" runat="server" CssClass="required" ControlToValidate="txtPostcode" ValidationGroup="submitValMerchantAddEditOutlet" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">State<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlState" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantState" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlState" ValidationGroup="submitValMerchantAddEditOutlet" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">City</label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlCity" CssClass="form-control" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvCity" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlCity" ValidationGroup="submitValMerchantAddEditOutlet" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Latitude<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtLatitude" CssClass="form-control" runat="server" MaxLength="8" placeholder="Latitude" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvLatitude" runat="server" CssClass="required" ControlToValidate="txtLatitude" ValidationGroup="submitValMerchantAddEditOutlet" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Longitude<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtLongitude" CssClass="form-control" runat="server" MaxLength="10" placeholder="Longitude" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvLongitude" runat="server" CssClass="required" ControlToValidate="txtLongitude" ValidationGroup="submitValMerchantAddEditOutlet" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Remark</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtRemark" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Active Status</label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" AutoPostBack="true" runat="server">
                                        <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                        <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="col-sm-10 text-right">
                                    <div class="form-group">
                                        <span id="message" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </div>
                                <div class="col-sm-2 text-right">
                                    <div class="form-group">
                                        <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-action" OnClick="btnBack_Click" />
                                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-info" ValidationGroup="submitValMerchantAddEditOutlet" OnClick="btnSave_Click" />
                                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <asp:Literal ID="litTable" runat="server" />
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="gap-mid"></div>
    </div>
</asp:Content>
