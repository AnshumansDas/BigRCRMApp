<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmViewCurrencyTransaction.aspx.cs" Inherits="CRMApp.crmapp.frmViewCurrencyTransaction" MasterPageFile="~/crmapp/CRMBack.Master" %>
<asp:Content ID="Content1Transaction" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2Transaction" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>View Transaction Status</h2>
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
                <asp:UpdatePanel runat="server" ID="upNotification">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="col-sm-10 text-right">
                                    <div class="form-group">
                                        <span id="message" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-2 control-label">Status</label>
                                <div class="col-sm-9">
                                    <asp:Label ID="lblstatus" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="form-group" style="display: none">
                                <label for="inputEmail3" class="col-sm-2 control-label">Currency Type</label>
                                <div class="col-sm-9">
                                    <asp:Label ID="lblCurrency" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-2 control-label">Redeem Points</label>
                                <div class="col-sm-9">
                                    <asp:Label ID="lblPoints" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Amount</label>
                                <div class="col-sm-9 gap-butabo">
                                    <asp:Label ID="lblamount" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">Created Date</label>
                                <div class="col-sm-9 gap-butabo">
                                    <asp:Label ID="lblcreateddate" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">Updated Date</label>
                                <div class="col-sm-9 gap-butabo">
                                    <asp:Label ID="lblupdateddate" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">Remarks</label>
                                <div class="col-sm-9 gap-butabo">
                                    <asp:Label ID="lblRemarks" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 text-right">
                                <div class="form-group">
                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-action" OnClick="btnBack_Click" />
                                    <%--  <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-info" OnClick="btnSave_Click" />--%>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>




