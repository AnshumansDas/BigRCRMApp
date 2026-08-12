<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmAddEditMerchandise.aspx.cs" Inherits="CRMApp.crmapp.frmAddEditMerchandise" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Add/Edit Merchandise</h2>
            </div>
            <div id="viewlogo" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 style="text-align: center;">Merchandise Logo</h5>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <asp:Image ID="imgMerchandiseLogo" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-horizontal">
                <asp:UpdatePanel ID="upVoucheList" runat="server">
                    <ContentTemplate>
                        <div class="form-group">
                            <div class="row">
                                <label class="col-sm-2">Merchandise Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="rfvddlMerchant" runat="server" CssClass="required" ControlToValidate="txtMerchandiseName" ValidationGroup="submitValue" InitialValue="NA" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtMerchandiseName" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <label class="col-sm-2">Category Name&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="required" ControlToValidate="ddlCategory" ValidationGroup="submitValue" InitialValue="NA" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlCategory" CssClass="form-control" runat="server" TabIndex="2" DataTextField="merchandise_category" DataValueField="merchandise_cat_id">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="col-sm-2">Points To Redeem</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtPointsRedeem" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Description</label>
                        <div class="col-sm-10 gap-butabo">
                            <CKEditor:CKEditorControl ID="txtMerchandiseDescription" FilebrowserBrowseUrl="<%$ appSettings:FilebrowserBrowseUrl %>"
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
                <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>--%>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Redeem Offer at</label>
                        <div class="col-sm-10">
                            <asp:CheckBoxList ID="cblstOutlet" runat="server" TabIndex="7" RepeatDirection="Vertical" RepeatColumns="3" DataTextField="branch_name" DataValueField="branch_id">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Quantity&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="required" ControlToValidate="txtQty" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtQty" runat="server" TabIndex="17" CssClass="form-control"></asp:TextBox>
                        </div>

                        <label class="col-sm-2">Redeemed</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="txtRedeemed" runat="server" TabIndex="18" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Start Date&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="required" ControlToValidate="txtStartDate" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <%--<asp:TextBox ID="txtStartDate" runat="server" TabIndex="19" CssClass="form-control"></asp:TextBox>--%>
                            <div class="input-group date" id="startdate">
                                <asp:TextBox ID="txtStartDate" runat="server" TabIndex="19" CssClass="form-control" placeholder="start date"></asp:TextBox>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>

                        <label class="col-sm-2">End Date&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" CssClass="required" ControlToValidate="txtEndDate" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <%--<asp:TextBox ID="txtEndDate" runat="server" TabIndex="20" CssClass="form-control"></asp:TextBox>--%>
                            <div class="input-group date" id="enddate">
                                <asp:TextBox ID="txtEndDate" runat="server" TabIndex="20" CssClass="form-control" placeholder="end date"></asp:TextBox>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Merchandise Logo&nbsp;<span style="font-size: smaller; color: red;">&#42;</span><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="required" ControlToValidate="txtQty" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator></label>
                        <div class="col-sm-4">
                            <asp:FileUpload ID="fuPromoImage" runat="server" CssClass="btn btn-primary" />
                             <a data-toggle="modal" data-target="#viewlogo" class="btn btn-default">View Logo</a><br />
                        </div>
                        <label class="col-sm-2">Active Status</label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" runat="server">
                                <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2"></label>
                        <div class="col-sm-4">
                        </div>
                        <label class="col-sm-2"></label>
                        <div class="col-sm-4">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" Text="Save" />
                        </div>
                    </div>
                </div>
                <%--</ContentTemplate>
                </asp:UpdatePanel>--%>
            </div>
        </div>
    </div>
</asp:Content>
