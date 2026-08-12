<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmVoucherSetup.aspx.cs" Inherits="CRMApp.crmapp.frmVoucherSetup" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <script>
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
    </script>
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>Voucher Setup</h2>
        </div>
        <div></div>
    </div>
    <div class="col-sm-12">
        <asp:UpdatePanel ID="upVoucheList" runat="server">
            <ContentTemplate>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Merchant Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="rfvddlMerchant" runat="server" CssClass="required" ControlToValidate="ddlMerchant" ValidationGroup="submitVoucherSetup" InitialValue="NA" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlMerchant" CssClass="form-control" runat="server" AutoPostBack="true" TabIndex="0" DataTextField="organization_name" DataValueField="merchant_id" OnSelectedIndexChanged="ddlMerchant_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <label class="col-sm-2">Voucher Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="required" ControlToValidate="txtVoucherName" ValidationGroup="submitVoucherSetup" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtVoucherName" runat="server" TabIndex="1" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Category Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="required" ControlToValidate="ddlCategory" ValidationGroup="submitVoucherSetup" InitialValue="NA" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlCategory" CssClass="form-control" runat="server" TabIndex="2" AutoPostBack="true" DataTextField="voucher_main_category" DataValueField="voucher_main_cat_id" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <label class="col-sm-2">Sub Category Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="required" ControlToValidate="ddlSubCategory" ValidationGroup="submitVoucherSetup" InitialValue="NA" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlSubCategory" CssClass="form-control" runat="server" TabIndex="3" DataTextField="voucher_sub_category" DataValueField="voucher_sub_cat_id">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="form-group">
            <div class="row">
                <label class="col-sm-2">Description</label>
                <div class="col-sm-10 gap-butabo">
                    <CKEditor:CKEditorControl ID="txtVoucherDescription" FilebrowserBrowseUrl="<%$ appSettings:FilebrowserBrowseUrl %>"
                        FilebrowserImageBrowseUrl="<%$ appSettings:FilebrowserImageBrowseUrl %>" FilebrowserFlashBrowseUrl="<%$ appSettings:FilebrowserFlashBrowseUrl %>"
                        FilebrowserUploadUrl="<%$ appSettings:FilebrowserUploadUrl %>" FilebrowserImageUploadUrl="<%$ appSettings:FilebrowserImageUploadUrl %>"
                        FilebrowserFlashUploadUrl="<%$ appSettings:FilebrowserFlashUploadUrl %>" runat="server"
                        TabIndex="4" CssClass="form-control">
                    </CKEditor:CKEditorControl>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <label class="col-sm-2">Redeem Offer</label>
                <div class="col-sm-10 gap-butabo">
                    <CKEditor:CKEditorControl ID="TxtRedeemOffer" FilebrowserBrowseUrl="<%$ appSettings:FilebrowserBrowseUrl %>"
                        FilebrowserImageBrowseUrl="<%$ appSettings:FilebrowserImageBrowseUrl %>" FilebrowserFlashBrowseUrl="<%$ appSettings:FilebrowserFlashBrowseUrl %>"
                        FilebrowserUploadUrl="<%$ appSettings:FilebrowserUploadUrl %>" FilebrowserImageUploadUrl="<%$ appSettings:FilebrowserImageUploadUrl %>"
                        FilebrowserFlashUploadUrl="<%$ appSettings:FilebrowserFlashUploadUrl %>" runat="server"
                        TabIndex="5" CssClass="form-control">
                    </CKEditor:CKEditorControl>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <label class="col-sm-2">Reservation</label>
                <div class="col-sm-10 gap-butabo">
                    <CKEditor:CKEditorControl ID="Reservation" FilebrowserBrowseUrl="<%$ appSettings:FilebrowserBrowseUrl %>"
                        FilebrowserImageBrowseUrl="<%$ appSettings:FilebrowserImageBrowseUrl %>" FilebrowserFlashBrowseUrl="<%$ appSettings:FilebrowserFlashBrowseUrl %>"
                        FilebrowserUploadUrl="<%$ appSettings:FilebrowserUploadUrl %>" FilebrowserImageUploadUrl="<%$ appSettings:FilebrowserImageUploadUrl %>"
                        FilebrowserFlashUploadUrl="<%$ appSettings:FilebrowserFlashUploadUrl %>" runat="server"
                        TabIndex="6" CssClass="form-control">
                    </CKEditor:CKEditorControl>
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Redeem Offer at</label>
                        <div class="col-sm-10">
                            <asp:CheckBoxList ID="cblstOutlet" runat="server" TabIndex="7" RepeatDirection="Vertical" RepeatColumns="3" DataTextField="branch_name" DataValueField="branch_id">
                                <%--<asp:ListItem Value="cb1">CB1</asp:ListItem>
                                <asp:ListItem Value="cb2">CB2</asp:ListItem>
                                <asp:ListItem Value="cb3">CB3</asp:ListItem>
                                <asp:ListItem Value="cb4">CB4</asp:ListItem>
                                <asp:ListItem Value="cb5">CB5</asp:ListItem>
                                <asp:ListItem Value="cb6">CB6</asp:ListItem>--%>
                            </asp:CheckBoxList>
                            <asp:Label runat="server" ID="lblNoRecord" Text="No Outlet Has been Added" Visible="false" ForeColor="Red"></asp:Label>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="form-group">
            <div class="row">
                <label class="col-sm-2">Redeemption Instruction</label>
                <div class="col-sm-10">
                    <CKEditor:CKEditorControl ID="RedeemInstruction" FilebrowserBrowseUrl="<%$ appSettings:FilebrowserBrowseUrl %>"
                        FilebrowserImageBrowseUrl="<%$ appSettings:FilebrowserImageBrowseUrl %>" FilebrowserFlashBrowseUrl="<%$ appSettings:FilebrowserFlashBrowseUrl %>"
                        FilebrowserUploadUrl="<%$ appSettings:FilebrowserUploadUrl %>" FilebrowserImageUploadUrl="<%$ appSettings:FilebrowserImageUploadUrl %>"
                        FilebrowserFlashUploadUrl="<%$ appSettings:FilebrowserFlashUploadUrl %>" runat="server"
                        TabIndex="8" CssClass="form-control">
                    </CKEditor:CKEditorControl>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <div class="form-group">
                <div class="row">
                    <label class="col-sm-2">SST(?%)</label>
                    <div class="col-sm-4">
                        <div class="col-sm-6">
                            <asp:RadioButton ID="included" runat="server" TabIndex="9" Text="Included" CssClass="checkbox" Checked="true" AutoPostBack="true" OnCheckedChanged="included_CheckedChanged" />
                        </div>
                        <div class="col-sm-6">
                            <asp:RadioButton ID="excluded" runat="server" TabIndex="10" Text="Excluded" CssClass="checkbox" AutoPostBack="true" OnCheckedChanged="excluded_CheckedChanged" />
                        </div>
                    </div>
                    <label class="col-sm-2">Voucher ID</label>
                    <div class="col-sm-4">
                        <div class="col-sm-6">
                            <asp:RadioButton ID="rbtnvoucher1" runat="server" TabIndex="11" Text="System Generated" CssClass="checkbox" Checked="true" AutoPostBack="true" OnCheckedChanged="rbtnvoucher1_CheckedChanged" />
                        </div>
                        <div class="col-sm-6">
                            <asp:RadioButton ID="rbtnUpload" runat="server" TabIndex="12" Text="Upload List" CssClass="checkbox" AutoPostBack="true" OnCheckedChanged="rbtnUpload_CheckedChanged" />
                            <asp:FileUpload ID="fuvoucher" runat="server" Enabled="false" />
                        </div>
                    </div>
                </div>
            </div>
            <%--</ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>--%>
            <div class="form-group">
                <div class="row">
                    <label class="col-sm-2">Quantity&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="required" ControlToValidate="txtQty" ValidationGroup="submitVoucherSetup" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtQty" runat="server" TabIndex="17" CssClass="form-control" onkeypress="return isNumberKey(event)" OnTextChanged="txtQty_TextChanged"></asp:TextBox>
                    </div>
                    <label class="col-sm-2">Bought</label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtBought" runat="server" TabIndex="18" CssClass="form-control" onkeypress="return isNumberKey(event)"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-sm-2">Original Price(RM)&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="required" ControlToValidate="txtOriginalPrice" ValidationGroup="submitVoucherSetup" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtOriginalPrice" runat="server" TabIndex="13" CssClass="form-control" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                    </div>
                    <label class="col-sm-2">Discounted Price(RM)&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="required" ControlToValidate="txtDiscountPrice" ValidationGroup="submitVoucherSetup" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtDiscountPrice" runat="server" TabIndex="14" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtDiscountPrice_TextChanged" onkeypress="return onlyDotsAndNumbers(this,event);"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label class="col-sm-2">Saving Price(RM)</label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtSaving" runat="server" TabIndex="15" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <label class="col-sm-2">Total Price(RM)</label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtTotal" runat="server" TabIndex="16" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="form-group">
        <div class="row">
            <label class="col-sm-2">Start Date&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="required" ControlToValidate="txtStartDate" ValidationGroup="submitVoucherSetup" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
            <div class="col-sm-4">
                <%--<div class="input-group date" id="startdate">
                    <asp:TextBox ID="txtStartDate" runat="server" TabIndex="19" CssClass="form-control" placeholder="start date"></asp:TextBox>
                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                </div>--%>
                <div class="input-group date">
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control datepicker1" placeholder="start date"></asp:TextBox>
                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                </div>
            </div>

            <label class="col-sm-2">End Date&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" CssClass="required" ControlToValidate="txtEndDate" ValidationGroup="submitVoucherSetup" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
            <div class="col-sm-4">
                <%--<div class="input-group date" id="enddate">
                    <asp:TextBox ID="txtEndDate" runat="server" TabIndex="20" CssClass="form-control" placeholder="end date"></asp:TextBox>
                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                </div>--%>
                <div class="input-group date">
                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control datepicker2" placeholder="end date"></asp:TextBox>
                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <div class="form-group">
                <div class="row">
                    <label class="col-sm-2">Point</label>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtPoint" runat="server" TabIndex="21" CssClass="form-control" onkeypress="return isNumberKey(event)"></asp:TextBox>
                    </div>
                    <strong><asp:Label ID="lblFeeCategory" runat="server" Cssclass="col-sm-2" Text="Fee"></asp:Label></strong>
                    <%--<label class="col-sm-2">Voucher Fees/Sales Profit</label>--%>
                    <div class="col-sm-4">
                        <asp:TextBox ID="txtFees" runat="server" TabIndex="22" CssClass="form-control" ReadOnly></asp:TextBox>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="viewlogo1" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 style="text-align: center;"><span id="simg1" runat="server" style="font-size: small;"></span></h5>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <asp:Image ID="Imagev1" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="viewlogo2" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 style="text-align: center;"><span id="simg2" runat="server" style="font-size: small;"></span></h5>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <asp:Image ID="Imagev2" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="viewlogo3" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 style="text-align: center;"><span id="simg3" runat="server" style="font-size: small;"></span></h5>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <asp:Image ID="Imagev3" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="viewlogo4" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 style="text-align: center;"><span id="simg4" runat="server" style="font-size: small;"></span></h5>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <asp:Image ID="Imagev4" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="viewlogo5" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 style="text-align: center;"><span id="simg5" runat="server" style="font-size: small;"></span></h5>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <asp:Image ID="Imagev5" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <label class="col-sm-2">Promo Image</label>
            <div class="col-sm-4">
                <span style="font-size: smaller; color: red">Note : Upload Image Size (800px width * 500px height)</span>
                <asp:FileUpload ID="fuPromoImage" runat="server" TabIndex="23" class="btn btn-primary" />
                <a data-toggle="modal" data-target="#viewlogo1" class="btn btn-default">View Voucher Image1</a><br />
                <asp:FileUpload ID="fuPromoImage12" runat="server" TabIndex="24" class="btn btn-primary" />
                <a data-toggle="modal" data-target="#viewlogo2" class="btn btn-default">View Voucher Image2</a><br />
                <asp:FileUpload ID="fuPromoImage3" runat="server" TabIndex="25" class="btn btn-primary" />
                <a data-toggle="modal" data-target="#viewlogo3" class="btn btn-default">View Voucher Image3</a><br />
                <asp:FileUpload ID="fuPromoImage4" runat="server" TabIndex="26" class="btn btn-primary" />
                <a data-toggle="modal" data-target="#viewlogo4" class="btn btn-default">View Voucher Image4</a><br />
                <asp:FileUpload ID="fuPromoImage5" runat="server" TabIndex="27" class="btn btn-primary" />
                <a data-toggle="modal" data-target="#viewlogo5" class="btn btn-default">View Voucher Image5</a>
            </div>
            <label class="col-sm-2">Active Status&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" CssClass="required" ControlToValidate="ddlActiveStatus" InitialValue="" ValidationGroup="submitVoucherSetup" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
            <div class="col-sm-4">
                <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" runat="server">
                    <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                    <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
    </div>
    <%-- <asp:UpdatePanel runat="server" ID="upContentAddEdit2" UpdateMode="Conditional">
        <ContentTemplate>--%>
    <div class="form-group">
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group">
                    <span id="message" runat="server" style="font-size: smaller;"></span>
                </div>
            </div>
            <div class="col-sm-6 text-right">
                <div class="form-group">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                    <asp:Button ID="btnCancel" runat="server" TabIndex="24" Text="Cancel" OnClick="btnCancel_Click" CssClass="btn btn-action" />
                    <asp:Button ID="btnSave" runat="server" TabIndex="25" Text="Save" OnClick="btnSave_Click" ValidationGroup="submitVoucherSetup" CssClass="btn btn-success" />
                </div>
            </div>
        </div>
    </div>
    <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
