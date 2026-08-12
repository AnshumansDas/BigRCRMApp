<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmSstSetupAddEdit.aspx.cs" Inherits="CRMApp.crmapp.frmSstSetupAddEdit" MasterPageFile="~/crmapp/CRMBack.Master"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Add/Edit Sst Details</h2>
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
                <asp:UpdatePanel runat="server" ID="upMerchant">
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
                        <div class="col-md-6">
                             <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Tax Name</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="TxtTaxName" CssClass="form-control focus" runat="server" placeholder="Tax Name"></asp:TextBox>
                                </div>
                            </div>

                             <div class="form-group" style="display:none">
                                <label for="inputEmail3" class="col-sm-3 control-label">id</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="Txtid" CssClass="form-control focus" runat="server" placeholder="id"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">SST(%)</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtSST" CssClass="form-control focus" runat="server" placeholder="SST(%)"></asp:TextBox>
                                </div>
                            </div>
                           
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Remark</label>
                                <div class="col-sm-9">
                                    <textarea id="TxtAreaRemark" CssClass="form-control" runat="server" cols="65" rows="6"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Active Status</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" AutoPostBack="true" runat="server">
                                        <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                        <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
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
