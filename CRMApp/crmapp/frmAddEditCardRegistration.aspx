<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmAddEditCardRegistration.aspx.cs" Inherits="CRMApp.crmapp.frmAddEditCardRegistration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>BigR Card Registration</h2>
        </div>
        <div></div>
    </div>
    <div class="col-sm-12">
        <asp:UpdatePanel ID="upcardRegistration" runat="server">
            <ContentTemplate>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Member ID&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="required" ControlToValidate="txtUser" ValidationGroup="submitRegistrationSetup" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtUser" runat="server" TabIndex="0" CssClass="form-control" OnTextChanged="txtUser_TextChanged" AutoPostBack="true" placeholder="Enter the Member ID"></asp:TextBox>
                            <asp:HiddenField ID="hdnfuserId" runat="server" />
                        </div>
                        <label class="col-sm-2">Member Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span></label>
                        <div class="col-sm-4">
                            <asp:Label ID="lblUserName" runat="server" Text="" CssClass="form-control"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Community Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="rfvddlCommunity" runat="server" CssClass="required" ControlToValidate="ddlCommunity" ValidationGroup="submitRegistrationSetup" InitialValue="NA" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlCommunity" CssClass="form-control" runat="server" AutoPostBack="true" TabIndex="1" DataTextField="community_name" DataValueField="community_id">
                            </asp:DropDownList>
                        </div>
                        <label class="col-sm-2">Card No&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="required" ControlToValidate="txtCardNo" ValidationGroup="submitRegistrationSetup" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtCardNo" runat="server" TabIndex="1" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Status&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="required" ControlToValidate="ddlStatus" ValidationGroup="submitRegistrationSetup" InitialValue="NA" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlStatus" CssClass="form-control" runat="server" TabIndex="2">
                                <asp:ListItem Value="">-Please Select-</asp:ListItem>
                                <asp:ListItem Value="1">Active</asp:ListItem>                                
                                <asp:ListItem Value="2">In Active</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <%--<label class="col-sm-2">Sub Category Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="required" ControlToValidate="ddlSubCategory" ValidationGroup="submitVoucherSetup" InitialValue="NA" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlSubCategory" CssClass="form-control" runat="server" TabIndex="3" DataTextField="voucher_sub_category" DataValueField="voucher_sub_cat_id">
                            </asp:DropDownList>
                        </div>--%>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>       
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
                    <asp:Button ID="btnSave" runat="server" TabIndex="25" Text="Save" OnClick="btnSave_Click" ValidationGroup="submitRegistrationSetup" CssClass="btn btn-success" />
                </div>
            </div>
        </div>
    </div>
    </div>
</asp:Content>
