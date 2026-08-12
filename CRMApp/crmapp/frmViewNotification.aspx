<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmViewNotification.aspx.cs" Inherits="CRMApp.crmapp.frmViewNotification" MasterPageFile="~/crmapp/CRMBack.Master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>View Notification</h2>
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
                              
                              <div class="form-group" style="display:none">
                                <label for="inputEmail3" class="col-sm-1 control-label">Notification id</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="Txtid" runat="server"></asp:TextBox>
                                </div>
                            </div>
                          
                              <%-- <div class="form-group">
                                <label for="inputEmail3" class="col-sm-1 control-label">Send To</label>
                                <div class="col-sm-4">
                                   <asp:Label ID="lblsendto" runat="server" Text=""></asp:Label>
                                </div>
                            </div>--%>

                          <div class="form-group">
                                <label for="inputEmail3" class="col-sm-1 control-label">Subject</label>
                                <div class="col-sm-11">
                                    <asp:Label ID="lblsubject" runat="server" Text=""></asp:Label>
                                 </div>
                            </div>
                            <div class="form-group">                               
                                    <label class="col-sm-1 control-label">Message</label>
                                    <div class="col-sm-9 gap-butabo">
                                       <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
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



