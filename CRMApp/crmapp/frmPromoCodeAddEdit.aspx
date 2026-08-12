<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmPromoCodeAddEdit.aspx.cs" Inherits="CRMApp.crmapp.frmPromoCodeAddEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <script type="text/javascript">
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
            //var mFive = String.fromCharCode(event.which);
            //if ((charCode == 53) && (mFive === "5")) 
            //    return true;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

    </script>

    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>Add/Edit Promocode</h2>
            <span id="message" runat="server" style="font-size: smaller;"></span>
        </div>
        <div class="form-horizontal">
            <div class="col-md-6">
                <asp:UpdatePanel runat="server" ID="upPromocodeAddEdit">
                    <ContentTemplate>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-3 control-label">Promocode Name<span style="font-size: smaller; color: red;">&#42;</span></label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txtPromocodeName" CssClass="form-control" runat="server" placeholder="Promocode name"></asp:TextBox>
                            </div>
                            <div class="col-sm-2">
                                <asp:RequiredFieldValidator ID="rfvPromocodeName" runat="server" CssClass="required" ControlToValidate="txtPromocodeName" ValidationGroup="submitPromocode" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-3 control-label">Category <span style="font-size: smaller; color: red;">&#42;</span></label>
                            <div class="col-sm-7">
                                <asp:DropDownList ID="ddlPromocodeCategory" CssClass="form-control" AutoPostBack="true" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <asp:RequiredFieldValidator ID="RFVPromoCodeCategory" runat="server" CssClass="required" ControlToValidate="ddlPromocodeCategory" InitialValue="0" ValidationGroup="submitPromocode" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-3 control-label">Type <span style="font-size: smaller; color: red;">&#42;</span></label>
                            <div class="col-sm-7">
                                <asp:DropDownList ID="ddlPromocodeType" OnSelectedIndexChanged="ddlPromocodeType_SelectedIndexChanged" CssClass="form-control" AutoPostBack="true" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <asp:RequiredFieldValidator ID="RFVPromocodeType" runat="server" CssClass="required" ControlToValidate="ddlPromocodeType" InitialValue="0" ValidationGroup="submitPromocode" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" id="lblAmountPercentage" runat="server" class="col-sm-3 control-label">Amount <span style="font-size: smaller; color: red;">&#42;</span></label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txtAmountPercentage" onkeypress="return onlyDotsAndNumbers(this,event);" CssClass="form-control" runat="server" placeholder="Amount/Percentage"></asp:TextBox>
                            </div>
                            <div class="col-sm-2">
                                <asp:RequiredFieldValidator ID="RFVAmount" runat="server" CssClass="required" ControlToValidate="txtAmountPercentage" ValidationGroup="submitPromocode" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-3 control-label">Merchant Name <span style="font-size: smaller; color: red;">&#42;</span></label>
                            <div class="col-sm-7">
                                <asp:DropDownList ID="ddlOrganizationName" OnSelectedIndexChanged="ddlOrganizationName_SelectedIndexChanged" CssClass="form-control" AutoPostBack="true" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <asp:RequiredFieldValidator ID="RFVMerchant" runat="server" CssClass="required" ControlToValidate="ddlOrganizationName" InitialValue="0" ValidationGroup="submitPromocode" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-3 control-label">Voucher Name <span style="font-size: smaller; color: red;">&#42;</span></label>
                            <div class="col-sm-7">
                                <asp:DropDownList ID="ddlVoucherName" CssClass="form-control" AutoPostBack="true" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <asp:RequiredFieldValidator ID="RFVVoucher" runat="server" CssClass="required" ControlToValidate="ddlVoucherName" InitialValue="0" ValidationGroup="submitPromocode" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-3 control-label">Availability <span style="font-size: smaller; color: red;">&#42;</span></label>
                    <div class="col-sm-4">
                        <div class="input-group date" id="startdate">
                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control datepicker1" placeholder="start date"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                        <div class="col-sm-1">
                            <asp:RequiredFieldValidator ID="RFVStartDate" runat="server" CssClass="required" ControlToValidate="txtStartDate" InitialValue="" ValidationGroup="submitPromocode" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group date">
                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control datepicker2" placeholder="end date"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                        <div class="col-sm-1">
                            <asp:RequiredFieldValidator ID="RFVEndDate" runat="server" CssClass="required" ControlToValidate="txtEndDate" InitialValue="" ValidationGroup="submitPromocode" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="up2" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12" style="text-align: right;">
                                    <asp:LinkButton ID="lnkAddNew" runat="server" CssClass="btn btn-info" ValidationGroup="submitPromocode" OnClick="lnkAddNew_Click">Save</asp:LinkButton>
                                    &nbsp;
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-info" OnClick="btnCancel_Click" />
                                </div>
                            </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
