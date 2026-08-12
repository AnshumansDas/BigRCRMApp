<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMemberAddEdit.aspx.cs" Inherits="CRMApp.crmapp.frmMemberAddEdit" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Contentmember" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Contentmember2" ContentPlaceHolderID="body" runat="server">

    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Add Bussiness user</h2>
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
                <asp:UpdatePanel>
                    <ContentTemplate>
                         <div class="row">
                            <div class="col-sm-12">                               
                                 <div class="col-sm-4 text-right">
                                    <div class="form-group">
                                       <div><asp:Label ID="lblstatusMessage" runat="server" ></asp:Label></div>
                                    </div>
                                </div>
                                  <div class="col-sm-4 text-right">
                                    <div class="form-group">
                                        <span id="message" runat="server" style="font-size: smaller;"></span>
                                    </div>
                                </div>  
                            </div>
                              
                        </div>                       
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Role Name</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Name</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="TxtName" CssClass="form-control" runat="server" placeholder="User Name"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">UserID</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="TxtLoginID" CssClass="form-control" runat="server" placeholder="User Name"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Email</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="TxtEmail" CssClass="form-control" runat="server" placeholder="Email id"></asp:TextBox>                                    
                                   
                                </div>
                            </div>

                        </div>
                        <div class="col-md-6" style="display: none">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Password</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="TxtPassword" CssClass="form-control" runat="server" placeholder="Password"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Confirm Password*</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="TxtConfirmPassword" TextMode="Password" CssClass="form-control" runat="server" placeholder="Confirm Password"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-11" style="text-align: right;">
                                <asp:LinkButton ID="lnkAddNew" runat="server" CssClass="btn btn-info" OnClick="lnkAddNew_Click">Save</asp:LinkButton>
                                <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-action" OnClick="btnBack_Click" />
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
               <div class="gap-mid"></div>
        </div>
    </div>

</asp:Content>
