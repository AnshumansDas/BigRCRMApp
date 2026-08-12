<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmFeedbackEdit.aspx.cs" Inherits="CRMApp.crmapp.frmFeedbackEdit" %>

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
                                <h2>FEEDBACK EDIT</h2>
                            </div>
                            <div></div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-2 control-label">Name</label>
                                    <div class="col-sm-10" style="margin-bottom: -5px;">
                                        <asp:Label ID="lblName" runat="server" CssClass="form-control" ReadOnly></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-2 control-label">Email</label>
                                    <div class="col-sm-10" style="margin-bottom: -5px;">
                                        <asp:Label ID="lblEmail" runat="server" CssClass="form-control" ReadOnly></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-2 control-label">Subject</label>
                                    <div class="col-sm-10" style="margin-bottom: -5px;">
                                        <asp:Label ID="lblSubject" runat="server" CssClass="form-control" ReadOnly></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-2 control-label">Message</label>
                                    <div class="col-sm-10" style="margin-bottom: -5px;">
                                        <asp:TextBox ID="txtMessage" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="8" ReadOnly></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-2 control-label">Reply Message</label>
                                    <div class="col-sm-10" style="margin-bottom: -5px;">
                                        <asp:TextBox ID="txtReplyMessage" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="8"></asp:TextBox>
                                       <asp:RequiredFieldValidator ID="RFVReplyMessage" runat="server" CssClass="required" ControlToValidate="txtReplyMessage" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator> 
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
                                <span id="message" runat="server" style="font-size: smaller;"></span>
                            </div>
                            <div class="col-sm-2">
                                <div class="pull-left">
                                    <asp:LinkButton ID="btnSave" ValidationGroup="submitValue" runat="server" CssClass="btn btn-success" OnClick="btnSave_Click"><i class="fa fa-save" aria-hidden="true"></i>&nbsp;Submit</asp:LinkButton>
                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="btn btn-default" OnClick="lnkBack_Click"><i class="fa fa-save" aria-hidden="true"></i>&nbsp;Back</asp:LinkButton>
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
