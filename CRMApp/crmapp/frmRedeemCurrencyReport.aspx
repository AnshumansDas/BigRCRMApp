<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmRedeemCurrencyReport.aspx.cs" Inherits="CRMApp.crmapp.frmRedeemCurrencyReport" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="ContentTransactions" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
     function ShowStatuspopup() {
            $("#statusupdatePopup").modal(open);
        };
        function HideStatuspopup() {
            $("#statusupdatePopup").modal("hide");
        };
     </script>
</asp:Content>
<asp:Content ID="CtTransactions" ContentPlaceHolderID="body" runat="server">
  
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Reddem Voucher Report</h2>
                        <span id="message" runat="server" style="font-size: smaller;"></span>
                    </div>
                    <div></div>
                </div>
                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                                <div class="search-box">
                                    <asp:TextBox ID="txtTransactionsearch" runat="server" CssClass="form-control input-sm active-part" OnTextChanged="txtTransactionsearch_TextChanged" placeholder="Enter your search key ... "></asp:TextBox>
                                    <i class="fa fa-search"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4" style="text-align: left; margin-top: 16px;">
                            <asp:TextBox ID="txtTransactionDateRange" runat="server" CssClass="form-control startdate" placeholder="Date Range"></asp:TextBox>
                        </div>
                        <div class="col-md-2" style="text-align: right; margin-top: 16px;">
                            <asp:Button ID="BtnSearch" CssClass="btn btn-primary btn-sm" OnClick="BtnSearch_Click" runat="server" Text="Search" />
                        </div>
                    </div>
                    <div class="gap gap-mid"></div>
                      <asp:UpdatePanel runat="server" ID="upTransactions">
                      <ContentTemplate>
                    <asp:ListView ID="Lv_Transaction" runat="server" DataKeyNames="redeem_id" OnItemCommand="Lv_Transaction_ItemCommand"
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="Lv_Transaction_PagePropertiesChanging" OnItemDataBound="Lv_Transaction_ItemDataBound">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>Sl No</th>
                                        <th>Member Name</th>
                                        <th>Receive Address</th>
                                        <th>Currency Type</th>
                                        <th>Point</th>
                                        <th>Amount</th>
                                        <th>Request Date</th>
                                        <th>Updated Date</th>
                                       <%-- <th>Status</th>--%>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="Lv_Transaction" PageSize="10">
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
                                <td><%# Container.DataItemIndex + 1 %></td>
                                <td><%# Eval("created_by") %></td>
                                <td><%# Eval("Receive_address") %></td>
                                <td><%# Eval("currency_type") %></td>
                                <td><%# Eval("redeem_points") %></td>
                                <td><%# Eval("amount") %></td>
                                <td><%# Eval("created_date") %></td>
                                <td><%# Eval("updated_date") %></td>
                               <%-- <td><span id="colorstatus" runat="server"></span></td>--%>
                                <td data-title="action">
                                     <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="View" CssClass="btn btn-primary btn-xs" CommandName='<%# Eval("status").ToString().Trim() %>'><%# Eval("status").ToString().Trim() %>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>Sl No</th>
                                         <th>Member Name</th>
                                        <th>Recieve Address</th>
                                        <th>Currency Type</th>
                                        <th>Point</th>
                                        <th>Amount</th>
                                        <th>Request Date</th>
                                        <th>Updated Date</th>
                                       <%-- <th>Status</th>--%>
                                        <th>Action</th>
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
                     </ContentTemplate>
                   </asp:UpdatePanel>
                </div>
            </div>
      

     <div id="statusupdatePopup" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">Update Status</h4>

                </div>
                 <div class="modal-body">
                    <asp:UpdatePanel ID="UpStatus" runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-4">
                                        Status<span style="font-size: smaller; color: red;">&#42;</span>
                                   </label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlstatus" CssClass="form-control" runat="server">
                                        <asp:ListItem Value="0" Text="Pending"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Approved"></asp:ListItem>                                       
                                        <asp:ListItem Value="2" Text="Reject"></asp:ListItem>
                                    </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                             <div class="form-group">
                                <div class="row"> 
                                    <label class="col-sm-4">
                                       Member Name
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="TxtName" runat="server" name="city" CssClass="form-control" placeholder="Member Name"></asp:TextBox>
                                    </div>                                    
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row"> 
                                    <label class="col-sm-4">
                                       Currency Type
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="TxtcurrencyType" runat="server" name="city" CssClass="form-control" placeholder=""></asp:TextBox>
                                    </div>                                    
                                </div>
                            </div>
                             <div class="form-group">
                                <div class="row"> 
                                    <label class="col-sm-4">
                                      Receive Address
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="TxtReceiveAddress" runat="server" name="city" CssClass="form-control" placeholder=""></asp:TextBox>
                                    </div>                                    
                                </div>
                            </div>  
                              <div class="form-group" style="display:none">
                                <div class="row"> 
                                    <label class="col-sm-4">
                                     Redeem id
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="TxtRedeemid" runat="server"  CssClass="form-control" placeholder=""></asp:TextBox>
                                    </div>                                    
                                </div>
                            </div>                           
                           
                             <div class="form-group">
                                <div class="row"> 
                                    <label class="col-sm-4">
                                       Email
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="TxtEmail" runat="server" name="city" CssClass="form-control" placeholder=""></asp:TextBox>
                                    </div>                                    
                                </div>
                            </div>
                            
                             <div class="form-group">
                                <div class="row"> 
                                    <label class="col-sm-4">
                                       Mobile No
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="TxtPhone" runat="server" name="city" CssClass="form-control" placeholder=""></asp:TextBox>
                                    </div>                                    
                                </div>
                            </div>
                           
                             <div class="form-group">
                                <div class="row"> 
                                    <label class="col-sm-2">
                                        point
                                    </label>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtPoint" runat="server" name="city" CssClass="form-control" placeholder="Point"></asp:TextBox>
                                    </div>
                                     <label class="col-sm-2">
                                        Coin
                                    </label>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtCoin" runat="server" name="Amount" CssClass="form-control" placeholder="Amount"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                             <div class="form-group">
                                <div class="row"> 
                                    <label class="col-sm-4">
                                      Remarks
                                    </label>
                                    <div class="col-sm-8">   
                                    <asp:TextBox ID="TxtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" style="height:100px"></asp:TextBox>
                                    </div>                                    
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <div class="form-group">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" onclick="btnsave_click"/>
                                       </div>
                                    </div>                                    
                                </div>

                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>


            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

</asp:Content>
