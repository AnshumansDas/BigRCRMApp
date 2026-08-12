<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmEmailBlasting.aspx.cs" Inherits="CRMApp.crmapp.frmEmailBlasting" MasterPageFile="~/crmapp/CRMBack.Master" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Add Email Blasting</h2>
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
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="col-sm-10 text-right">
                                    <div class="form-group">
                                        <span id="message" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                         
                           <div class="form-group" style="display:none">
                                <label for="inputEmail3" class="col-sm-1 control-label">Notification id</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="Txtid" runat="server"></asp:TextBox>
                                </div>
                            </div>
                               <div class="form-group">
                                <label for="inputEmail3" class="col-sm-1 control-label">Send To</label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlSendTo" CssClass="form-control" AutoPostBack="true" runat="server">
                                        <asp:ListItem Value="2" Text="Member"></asp:ListItem>
                                        <asp:ListItem Value="5" Text="Merchant"></asp:ListItem>
                                        <asp:ListItem Value="9" Text="Member and Merchant"></asp:ListItem>
                                        <asp:ListItem Value="15" Text="Merchant Outlet"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                          <div class="form-group">
                                <label for="inputEmail3" class="col-sm-1 control-label">Subject</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtSubject" CssClass="form-control focus" runat="server" placeholder="Subject"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">                               
                                    <label class="col-sm-1 control-label">Message</label>
                                    <div class="col-sm-9 gap-butabo">
                                        <CKEditor:CKEditorControl ID="txtMessageDescription" FilebrowserBrowseUrl="<%$ appSettings:FilebrowserBrowseUrl %>"
                                            FilebrowserImageBrowseUrl="<%$ appSettings:FilebrowserImageBrowseUrl %>" FilebrowserFlashBrowseUrl="<%$ appSettings:FilebrowserFlashBrowseUrl %>"
                                            FilebrowserUploadUrl="<%$ appSettings:FilebrowserUploadUrl %>" FilebrowserImageUploadUrl="<%$ appSettings:FilebrowserImageUploadUrl %>"
                                            FilebrowserFlashUploadUrl="<%$ appSettings:FilebrowserFlashUploadUrl %>" runat="server"
                                            TabIndex="5" CssClass="form-control" >
                                        </CKEditor:CKEditorControl>
                                    </div>                               
                            </div>
                    
                  <asp:UpdatePanel runat="server" ID="upMerchant">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-sm-12 text-right">
                                <div class="form-group">
                                 <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-action" OnClick="btnBack_Click" />
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-info" OnClick="btnSave_Click" />
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>

