<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmContentAddEdit.aspx.cs" Inherits="CRMApp.crmapp.frmContentAddEdit" MasterPageFile="~/crmapp/CRMBack.Master" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content runat="server" ID="cContentAddEdit" ContentPlaceHolderID="body">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Add/Edit Content</h2>
            </div>
            <div></div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Category<span style="font-size: smaller; color: red;">&#42;</span></label>
                            <div class="col-sm-6" style="margin-bottom: -5px;">
                                <asp:DropDownList ID="ddlContentCat" AutoPostBack="true" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlContentCat_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                            <div class="col-sm-4" style="margin-bottom: -5px;">
                                <asp:RequiredFieldValidator ID="rfvContentCategory" runat="server" InitialValue="0" CssClass="required" ControlToValidate="ddlContentCat" ValidationGroup="submitValContentAddEdit" ErrorMessage="Category - Required Field"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Status<span style="font-size: smaller; color: red;">&#42;</span></label>
                            <div class="col-sm-6" style="margin-bottom: -5px;">
                                <asp:DropDownList ID="ddlActiveStatus" AutoPostBack="true" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                    <asp:ListItem Value="1">Active</asp:ListItem>
                                    <asp:ListItem Value="0">Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-4" style="margin-bottom: -5px;">
                                <asp:RequiredFieldValidator ID="rfvActiveStatus" runat="server" Visible="true" CssClass="required" ControlToValidate="ddlActiveStatus" ValidationGroup="submitValContentAddEdit" ErrorMessage="Status - Required Field"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Title<span style="font-size: smaller; color: red;">&#42;</span></label>
                            <div class="col-sm-6" style="margin-bottom: -5px;">
                                <asp:TextBox ID="txtContentTitle" runat="server" placeholder="Content Title" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-4" style="margin-bottom: -5px;">
                                <asp:RequiredFieldValidator ID="rfvContentTitle" runat="server" CssClass="required" ControlToValidate="txtContentTitle" ValidationGroup="submitValContentAddEdit" ErrorMessage="Title - Required Field"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6" runat="server" id="dvCode" visible="false">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Code</label>
                            <div class="col-sm-6" style="margin-bottom: -5px;">
                                <asp:Label ID="lblContentCode" runat="server" CssClass="form-control" Readonly></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="lblTitleDescription" CssClass="control-label" Font-Bold="true" runat="server"></asp:Label>
                            <div class="gap-small"></div>
                            <CKEditor:CKEditorControl ID="txtContentDescription" FilebrowserBrowseUrl="<%$ appSettings:FilebrowserBrowseUrl %>"
                                FilebrowserImageBrowseUrl="<%$ appSettings:FilebrowserImageBrowseUrl %>" FilebrowserFlashBrowseUrl="<%$ appSettings:FilebrowserFlashBrowseUrl %>"
                                FilebrowserUploadUrl="<%$ appSettings:FilebrowserUploadUrl %>" FilebrowserImageUploadUrl="<%$ appSettings:FilebrowserImageUploadUrl %>"
                                FilebrowserFlashUploadUrl="<%$ appSettings:FilebrowserFlashUploadUrl %>" runat="server"
                                TabIndex="5" CssClass="form-control" Height="400px">
                            </CKEditor:CKEditorControl>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" runat="server" id="dvDescription1" visible="false">
                <div class="col-sm-12">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="control-label">Description</label>
                            <div class="gap-small"></div>
                            <CKEditor:CKEditorControl ID="txtContentDescription1" FilebrowserBrowseUrl="<%$ appSettings:FilebrowserBrowseUrl %>"
                                FilebrowserImageBrowseUrl="<%$ appSettings:FilebrowserImageBrowseUrl %>" FilebrowserFlashBrowseUrl="<%$ appSettings:FilebrowserFlashBrowseUrl %>"
                                FilebrowserUploadUrl="<%$ appSettings:FilebrowserUploadUrl %>" FilebrowserImageUploadUrl="<%$ appSettings:FilebrowserImageUploadUrl %>"
                                FilebrowserFlashUploadUrl="<%$ appSettings:FilebrowserFlashUploadUrl %>" runat="server"
                                TabIndex="5" CssClass="form-control" Height="400px">
                            </CKEditor:CKEditorControl>
                        </div>
                    </div>
                </div>
            </div>
            <asp:UpdatePanel runat="server" ID="upContentAddEdit2" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-2"></label>
                                    <div class="col-sm-8">
                                        <span id="message" runat="server" style="font-size: smaller;"></span>
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="pull-right">
                                            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-action" OnClick="btnBack_Click" />
                                            <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="submitValContentAddEdit" CssClass="btn btn-success" OnClick="btnSave_Click"><i class="fa fa-save" aria-hidden="true"></i>&nbsp;Submit</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
