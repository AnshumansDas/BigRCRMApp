<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmChangePassword.aspx.cs" Inherits="CRMApp.crmapp.frmChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="upTransaction" runat="server">
        <ContentTemplate>
            <!-- main area start -->
            <div class="main-area">
                <div class="container">
                    <div class="row">
                        <!--col-md-3-->
                        <div class="col-sm-12">
                            <div class="area-title bdr mt20">
                                <h2>Change Password</h2>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label class="col-sm-2">Current Password</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtOldPassword" runat="server" TabIndex="0" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            </div>
                            <div class="col-sm-4">
                                <asp:RequiredFieldValidator ID="rfvOldPassword" runat="server" ControlToValidate="txtOldPassword" ErrorMessage="Provide Old Password"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label class="col-sm-2">New Password</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtNewPassword" runat="server" TabIndex="1" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            </div>
                            <div class="col-sm-4">
                                <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="Provide Old Password"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label class="col-sm-2">Confirm Password</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TabIndex="2" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            </div>
                            <div class="col-sm-4">
                                <asp:RequiredFieldValidator ID="rfvconfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <label class="col-sm-2"></label>
                            <div class="col-sm-4">
                                <asp:Button ID="btnPasswordUpdate" runat="server" Text="Update Password" OnClick="btnPasswordUpdate_Click" TabIndex="3" CssClass="btn btn-primary" />
                                <asp:Label ID="lblmsg" runat="server"></asp:Label>
                            </div>
                        </div>
                </div>
                <div class="form-group">
                    <div class="row">
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
