<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmAdminWithdrawStatus.aspx.cs" Inherits="CRMApp.crmapp.frmAdminWithdrawStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>Withdraw Update Status</h2>
        </div>
        <div></div>
    </div>
    <div class="col-sm-12">
        <div class="form-horizontal">
            <div class="col-md-4">
                <div class="form-group">
                    <label for="lblDateRequested" class="col-sm-5 control-label">Date Requested</label>
                    <div class="col-sm-7">
                        <p class="form-control-static">
                            <asp:Label ID="lblDateRequested" runat="server">

                            </asp:Label>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="lblAvailableAmount" class="col-sm-5 control-label">Available Amount</label>
                    <div class="col-sm-7">
                        <p class="form-control-static">
                            <asp:Label ID="lblAvailableAmount" runat="server">

                            </asp:Label>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="lblReqAmount" class="col-sm-5 control-label">Requested Amount</label>
                    <div class="col-sm-7">
                        <p class="form-control-static">
                            <asp:Label ID="lblReqAmount" runat="server">

                            </asp:Label>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="lblBank" class="col-sm-5 control-label">Bank Name</label>
                    <div class="col-sm-7">
                        <p class="form-control-static">
                            <asp:Label ID="lblBank" runat="server">

                            </asp:Label>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="lblAccno" class="col-sm-5 control-label">Account Number</label>
                    <div class="col-sm-7">
                        <p class="form-control-static">
                            <asp:Label ID="lblAccno" runat="server">

                            </asp:Label>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label for="ddlActiveStatus" class="col-sm-5 control-label">Active Status&nbsp;<span style="font-size: smaller; color: red;">&#42;</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" CssClass="required" ControlToValidate="ddlActiveStatus" InitialValue="" ValidationGroup="submitVoucherSetup" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </label>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" runat="server">
                            <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                            <asp:ListItem Value="0" Text="Pending"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Completed"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Rejected"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="col-sm-12">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <span id="message" runat="server" style="font-size: smaller;"></span>
                        </div>
                    </div>
                    <div class="col-sm-6 text-right">
                        <div class="form-group">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                            <asp:Button ID="btnCancel" runat="server" TabIndex="24" Text="Cancel" CssClass="btn btn-action" />
                            <asp:Button ID="btnSave" runat="server" TabIndex="25" Text="Save" OnClick="btnSave_Click" ValidationGroup="submitStatus" CssClass="btn btn-success" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>