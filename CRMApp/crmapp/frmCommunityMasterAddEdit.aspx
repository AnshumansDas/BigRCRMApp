<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmCommunityMasterAddEdit.aspx.cs" Inherits="CRMApp.crmapp.frmCommunityMasterAddEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel runat="server" ID="upFeedbackList">
        <ContentTemplate>
            <div class="main-area">
                <div class="container">
                    <div class="row">
                        <!--col-md-3-->
                        <div class="col-sm-12">
                            <div class="area-title bdr mt20">
                                <h2>Register Community</h2>
                            </div>
                            <div></div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-2 control-label">Service Provider</label>
                                    <div class="col-sm-10" style="margin-bottom: -5px;">
                                        <asp:DropDownList ID="ddlSPid" CssClass="form-control" runat="server"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfSpID" runat="server" CssClass="required" ControlToValidate="ddlSPid" InitialValue="0" ValidationGroup="AddEditCommunityValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-2 control-label">Community Name</label>
                                    <div class="col-sm-10" style="margin-bottom: -5px;">
                                        <asp:TextBox ID="txtCommunityName" ClientIDMode="Static" CssClass="form-control myfocus" runat="server" placeholder="Community Name"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="required" ControlToValidate="txtCommunityName" ValidationGroup="AddEditCommunityValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-2 control-label">Activation URL</label>
                                    <div class="col-sm-10" style="margin-bottom: -5px;">
                                        <asp:TextBox ID="txtCommunityUrl" CssClass="form-control" runat="server" placeholder="Activation Url"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="required" ControlToValidate="txtCommunityUrl" ValidationGroup="AddEditCommunityValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regUrl" runat="server" CssClass="required" ControlToValidate="txtCommunityUrl" ValidationExpression="^((http|https)://)?([\w-]+\.)+[\w]+(/[\w- ./?]*)?$" Text="Required valid URL" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-2 control-label">Status</label>
                                    <div class="col-sm-10" style="margin-bottom: -5px;">
                                        <asp:DropDownList ID="ddlActiveStatus_Community" CssClass="form-control" runat="server">
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>                            
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-2 control-label"></label>
                            <div class="col-sm-8">
                                <span id="message_community" runat="server" style="font-size: smaller;"></span>
                            </div>
                            <div class="col-sm-2">
                                <div class="pull-left">
                                    <asp:LinkButton ID="btnSave" ValidationGroup="AddEditCommunityValue" runat="server" CssClass="btn btn-success" OnClick="btnSave_Click"><i class="fa fa-save" aria-hidden="true"></i>&nbsp;Submit</asp:LinkButton>
                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="btn btn-default" OnClick="lnkBack_Click"><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;Back</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="gap gap-mini"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
