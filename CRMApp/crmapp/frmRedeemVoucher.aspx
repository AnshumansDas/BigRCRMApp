<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmRedeemVoucher.aspx.cs" Inherits="CRMApp.crmapp.frmRedeemVoucher" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="ContentRedeem" ContentPlaceHolderID="head" runat="server">
   
  <script>     
      function showpopupmsg() {
          $('#messageContents').modal(open)
      }
      function hidepopupmsg() {
          $('#messageContents').modal(close)
      }

  </script>
</asp:Content>
<asp:Content runat="server" ID="cMerchant19" ContentPlaceHolderID="body">
    <asp:UpdatePanel runat="server" ID="upMerchant19"  >
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Voucher Redeem</h2>
                        <span id="message" runat="server" style="font-size: smaller;"></span>
                    </div>
                    <div></div>
                </div>
                <div class="col-sm-12">  
                    <div class="row">
                        <div class="col-md-6">
                            <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                                <div class="search-box">
                                    <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" class="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                    <i class="fa fa-search"></i>
                                </div>
                            </div>
                        </div>
                      <%--  <div class="col-md-6" style="text-align: right;">
                            <asp:LinkButton ID="lnkAddNew" runat="server" CssClass="btn btn-info" OnClick="lnkAddNew_Click">Add New</asp:LinkButton>
                        </div>--%>
                    </div>
                    <div>
                        <asp:ListView ID="Lv_RedeemVoucher" runat="server" DataKeyNames="merchant_id,voucherCode,Memberid,id" 
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="Lv_RedeemVoucher_ItemDataBound" OnPagePropertiesChanging="Lv_RedeemVoucher_PagePropertiesChanging">
                            <LayoutTemplate>
                                <div class="row" style="display:none">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                             <th style="width: 10%; text-align: center;">Membership No</th>
                                            <th style="width: 0%; text-align: center;display:none">Merchantid</th>
                                            <th style="width: 0%; text-align: center;display:none">orderid</th>
                                            <th style="width: 10%;">Member Name</th>
                                            <th style="width: 0%; text-align: center;display:none">Voucher id</th>
                                            <th style="width: 12%; text-align: center;">Voucher Code</th>
                                            <th style="width: 10%; text-align: center;">Purchase Date</th>
                                            <th style="width: 10%; text-align: center;">Purchase Amount(RM)</th>
                                            <th style="width: 15%; text-align: center;">Redeemed Date</th>
                                            <th style="width: 10%; text-align: center;">Status</th>
                                            <th style="width: 10%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="Lv_RedeemVoucher" PageSize="10">
                                            <Fields>
                                                <asp:NextPreviousPagerField PreviousPageText="&laquo;" FirstPageText="|<" ShowPreviousPageButton="true"
                                                    ShowFirstPageButton="true" ShowNextPageButton="false" ShowLastPageButton="false"
                                                    ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                                <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary btn-xs" RenderNonBreakingSpacesBetweenControls="false"
                                                    NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                                                <asp:NextPreviousPagerField NextPageText="&raquo;" LastPageText=">|" ShowNextPageButton="true"
                                                    ShowLastPageButton="true" ShowPreviousPageButton="false" ShowFirstPageButton="false"
                                                    ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                            </Fields>
                                        </asp:DataPager>
                                    </div>
                                </div>
                                <div class="gap-mid"></div>
                            </LayoutTemplate>
                            <GroupTemplate>
                                <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                            </GroupTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                    <td style="text-align: center;"><%# Eval("Memberid") %></td>
                                    <td style="text-align: center;display:none"><%# Eval("merchant_id") %></td> 
                                    <td style="text-align: center;display:none"><%# Eval("id") %></td> 
                                    <td style="text-align: center;"><%# Eval("memberName").ToString().Trim() %></td>
                                    <td style="text-align: center;display:none""><%# Eval("voucher_id") %></td>
                                    <td style="text-align: center;"><%# Eval("voucherCode") %></td>
                                    <td style="text-align: center;"><%# Eval("purchase_date") %></td>
                                    <td style="text-align: center;"><%# Eval("Purchaseamount") %></td>
                                    <td style="text-align: center;"><%# Eval("redeemed_date") %></td>
                                    <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("status").ToString().Trim() %></span></td>
                                   <%-- <td>
                                         <button id="lnkEdit1" runat="server" onserverclick="Redeem" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" CommandName="Redeem"><%# Eval("status").ToString().Trim()%></button>
                                    </td>--%>
                                  <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" onclick="lnkPopup_Click" ><%# Eval("status").ToString().Trim() %></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                             <th style="width: 5%; text-align: center;">No</th>
                                             <th style="width: 10%; text-align: center;">Membership No</th>
                                             <th style="width: 0%; text-align: center;display:none">Merchantid</th>
                                            <th style="width: 0%; text-align: center;display:none">orderid</th>
                                            <th style="width: 10%;">Member Name</th>
                                            <th style="width: 0%; text-align: center;display:none">Voucher id</th>
                                            <th style="width: 20%; text-align: center;">Voucher Code</th>
                                            <th style="width: 10%; text-align: center;">Purchase Date</th>
                                            <th style="width: 10%; text-align: center;">Purchase Amount(RM)</th>
                                            <th style="width: 15%; text-align: center;">Redeemed Date</th>
                                            <th style="width: 10%; text-align: center;">Status</th>
                                            <th style="width: 10%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="10" style="text-align: center;">No record found!
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="messageContents" class="modal fade flat-box login-form" tabindex="-1" role="dialog" >
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title">Confirm Message</h4>

                        </div>
                        <div class="modal-body">
                            <asp:UpdatePanel ID="UpFeedBack" runat="server">
                                <ContentTemplate>
                                    <div class="form-group">
                                        <asp:TextBox ID="Txtvouchercode" runat="server" ClientIDMode="Static" CssClass="form-control myfocus" placeholder="Enter Voucher Code"></asp:TextBox>
                                        <asp:HiddenField ID="HdnTxtvouchercode" runat="server"/>
                                        <asp:HiddenField ID="HdnMerchantid" runat="server"/>
                                        <asp:HiddenField ID="Hdnuserid" runat="server"/>
                                        <asp:HiddenField ID="Hdnorderid" runat="server"/>
                                    </div>
                                    <div class="form-group">                                       
                                    <asp:DropDownList ID="ddlbranchName" CssClass="form-control"  runat="server">
                                    </asp:DropDownList>                                
                                   </div>
                                   <div class="form-group">                                       
                                   </div>
                                    <asp:LinkButton ID="lnkSubmit" runat="server" OnClick="lnkSubmit_Click" CssClass="btn btn-primary btn-block">Submit</asp:LinkButton>
                                    <div><asp:Label ID="lblMessage" runat="server" ></asp:Label></div>
                                </ContentTemplate>
                            </asp:UpdatePanel>                               
                        </div>                       
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
</asp:Content>