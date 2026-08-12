<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMerchantAddEdit.aspx.cs" Inherits="CRMApp.crmapp.frmMerchantAddEdit" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function UploadFile(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=btnUpload.ClientID %>").click();
            }
        }
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
                <h2>Add/Edit Merchant</h2>
            </div>
            <div id="viewlogo" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 style="text-align: center;">Merchant Logo</h5>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <asp:Image ID="imgMerchantLogo" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-horizontal">
                <asp:UpdatePanel runat="server" ID="upMerchant">
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
                                        <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="submitValMerchantAddEdit" CssClass="btn btn-info" OnClick="btnSave_Click" />
                                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Merchant Code</label>
                                <div class="col-sm-7">
                                    <asp:Label ID="lblMerchantCode" runat="server" CssClass="form-control" Readonly></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Organization Name<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtMerchant" CssClass="form-control focus" runat="server" placeholder="Organization name"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchant" runat="server" CssClass="required" ControlToValidate="txtMerchant" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Company Reg.No<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtMerchantRegNo" CssClass="form-control" runat="server" placeholder="Organization registration number"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantRegNo" runat="server" CssClass="required" ControlToValidate="txtMerchantRegNo" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group" id="dvRegNoCheck" runat="server" visible="false">
                                <label class="col-sm-3 control-label"></label>
                                <div class="col-sm-7">
                                    <span id="checkregnomsg" runat="server" style="font-size: small; color: red;"></span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Merchant Type</label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlMerchantCategory" CssClass="form-control" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Person In Charge<span style="font-size: smaller; color: red;">&#42;</span></label>
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
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantOffcNo" runat="server" CssClass="required" ControlToValidate="txtOfficeNo" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Fax No</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtFaxNo" CssClass="form-control" runat="server" placeholder="Fax no" MaxLength="11" onkeypress="return isNumberKey(event)"></asp:TextBox>
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
                                    <asp:RequiredFieldValidator ID="rfvMerchantAddress1" runat="server" CssClass="required" ControlToValidate="txtAddress1" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
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
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">State<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlState" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMerchantState" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlState" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">City</label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlCity" CssClass="form-control" AutoPostBack="true" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" InitialValue="0" runat="server" CssClass="required" ControlToValidate="ddlCity" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
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
                                <label class="col-sm-3 control-label">Website </label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtMerchantWebURL" CssClass="form-control" runat="server" placeholder="Merchant website URL"></asp:TextBox>
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
                            <div class="form-group">
                                <div class="col-sm-12 text-center">
                                    <asp:RegularExpressionValidator ID="valRegEmail" runat="server" ControlToValidate="txtEmail"
                                        ErrorMessage="Please give a valid email address" ValidationGroup="submitValMerchantAddEdit" CssClass="required"
                                        ValidationExpression="^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z\.][a-zA-Z]{1,3}$">
                                    </asp:RegularExpressionValidator>
                                    <span id="checkemailmsg" runat="server" style="font-size: small; color: red;"></span>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="col-sm-12">
            <div class="form-horizontal">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-3 text-right control-label">Upload Logo</label>
                        <div class="col-sm-7">
                            <div id='file_browse_wrapper'>
                                <asp:FileUpload ID="fuMerchantLogo" runat="server" CssClass="file_browse" />
                                <asp:Button ID="btnUpload" Text="Upload" runat="server" Style="display: none" OnClick="UploadFile" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-3 control-label"><span id="uploadmsg" runat="server" style="font-size: small;"></span></label>
                        <div class="col-sm-7">
                            <a data-toggle="modal" data-target="#viewlogo" class="btn btn-default">View Merchant Logo</a>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <span id="Span1" runat="server" style="font-size: small; color: darkblue;">Note : Logo measurement (200 px width * 113 px height) &<br />
                                Maximum file size to upload is 2MB (format: png\jpg\jpeg)</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <span id="logovalidatemsg" runat="server" style="font-size: small; color: red;"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Fees Details</h2>
            </div>
            <div class="form-horizontal">
                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                    <ContentTemplate>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Fees Category</label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlFeesCategory" CssClass="form-control" OnSelectedIndexChanged="ddlFeesCategory_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                        <asp:ListItem Value="PerVoucher" Text="Per Voucher Fees"></asp:ListItem>
                                        <asp:ListItem Value="OnboardingFees" Text="Onboarding Fees"></asp:ListItem>
                                        <asp:ListItem Value="VoucherSalesProfit" Text="Voucher Sales Profit"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvFeesCategory" InitialValue="" runat="server" CssClass="required" ControlToValidate="ddlFeesCategory" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group" id="dvChargesType" runat="server" visible="false">
                                <label class="col-sm-3 control-label">Charges Type</label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlChargesType" CssClass="form-control" OnSelectedIndexChanged="ddlChargesType_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                        <asp:ListItem Value="ChargesTypeByPercent" Text="Charges by (%)"></asp:ListItem>
                                        <asp:ListItem Value="ChargesTypeByRM" Text="Charges by (RM)"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvChargesType" InitialValue="" runat="server" CssClass="required" ControlToValidate="ddlChargesType" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group" id="dvChargesbyPercent" runat="server" visible="false">
                                <label class="col-sm-3 control-label">Charges by (%) </label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtChargesbyPercent" CssClass="form-control" runat="server" MaxLength="6" placeholder="Charges by percent" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvChargesbyPercent" runat="server" CssClass="required" ControlToValidate="txtChargesbyPercent" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group" id="dvChargesbyRM" runat="server" visible="false">
                                <label class="col-sm-3 control-label">Charges by (RM)</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtChargesbyRM" CssClass="form-control" runat="server" MaxLength="12" placeholder="Charges by RM" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvChargesbyRM" runat="server" CssClass="required" ControlToValidate="txtChargesbyRM" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Premium Merchant</label>
                        <div class="col-sm-9">
                            <div class="form-group">
                                <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                                    <ContentTemplate>
                                        <div class="col-sm-2">
                                            <asp:CheckBox ID="chkPremiumStatus" runat="server" AutoPostBack="true" OnCheckedChanged="chkPremiumStatus_CheckedChanged" />&nbsp;Yes
                                        </div>
                                        <label class="col-sm-4 control-label">Premium Fees (RM)</label>
                                        <div class="col-sm-6">
                                            <asp:TextBox ID="txtPremiumFees" Enabled="false" runat="server" CssClass="form-control" MaxLength="12" placeholder="Premium Fees" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <div class="input-group date">
                                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control datepicker1" placeholder="start date"></asp:TextBox>
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="input-group date">
                                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control datepicker2" placeholder="end date"></asp:TextBox>
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>MDR Fees Details</h2>
            </div>
            <div class="form-horizontal">
                <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                    <ContentTemplate>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Bank Fees<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtMDRBankFees" CssClass="form-control" runat="server" MaxLength="12" placeholder="Bank Fees RM" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvBankFees" runat="server" CssClass="required" ControlToValidate="txtMDRBankFees" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Charges Type</label>
                                <div class="col-sm-7">
                                    <asp:DropDownList ID="ddlMDRChargesType" CssClass="form-control" OnSelectedIndexChanged="ddlMDRChargesType_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                        <asp:ListItem Value="MDRChargesTypeByRM" Text="Charges by (RM)"></asp:ListItem>
                                        <asp:ListItem Value="MDRChargesTypeByPercent" Text="Charges by (%)"></asp:ListItem>
                                        <asp:ListItem Value="MDRBothType" Text="Both Type"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMDRChargesType" InitialValue="" runat="server" CssClass="required" ControlToValidate="ddlMDRChargesType" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group" id="dvMDRChargesbyRM" runat="server" visible="false">
                                <label class="col-sm-3 control-label">Charges by (RM)</label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtMDRChargesbyRM" CssClass="form-control" runat="server" MaxLength="12" placeholder="Charges by RM" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMDRChargesbyRM" runat="server" CssClass="required" ControlToValidate="txtMDRChargesbyRM" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group" id="dvMDRChargesbyPercent" runat="server" visible="false">
                                <label class="col-sm-3 control-label">Charges by (%) </label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtMDRChargesbyPercent" CssClass="form-control" runat="server" MaxLength="6" placeholder="Charges by %" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMDRChargesbyPercent" runat="server" CssClass="required" ControlToValidate="txtMDRChargesbyPercent" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group" id="dvOr" runat="server" visible="false">
                                <label class="col-sm-7 control-label">or</label>
                            </div>
                            <div class="form-group" id="dvMDRMinimumFees" runat="server" visible="false">
                                <label class="col-sm-3 control-label">Minimum Fees (RM) </label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtMDRMinimumFees" CssClass="form-control" runat="server" MaxLength="12" placeholder="Minimum Fees" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                                </div>
                                <div class="col-sm-2">
                                    <asp:RequiredFieldValidator ID="rfvMDRMinimumFees" runat="server" CssClass="required" ControlToValidate="txtMDRMinimumFees" ValidationGroup="submitValMerchantAddEdit" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group" id="dvHigher" runat="server" visible="false">
                                <label class="col-sm-8 control-label">which ever is higher</label>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="gap-mid"></div>
    </div>
</asp:Content>
