<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMerchantOutletDashboard.aspx.cs" Inherits="CRMApp.crmapp.frmMerchantOutletDashboard" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Account Summary</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
            <div></div>
        </div>
        <asp:UpdatePanel ID="upMerchantDashboard" runat="server">
            <ContentTemplate>
                <div class="col-sm-12">
                    <div>
                        <%--<div class="list-summary">
                            <div class="info-box bg-purple">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-3.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Total Purchase Vocher</span>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 56%"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblTotalPurchaseVoucher" runat="server" />
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="list-summary">
                            <div class="info-box bg-aqua">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-4.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Total Redeem Point</span>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 56%"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblTotalRedeempoints" runat="server" />
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="list-summary">
                            <div class="info-box bg-purple">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-2.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Total Redeem Voucher</span>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 56%"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblRedeemVoucher" runat="server" />
                                    </span>
                                </div>
                            </div>
                        </div>--%>
                        <div class="list-summary">
                            <div class="info-box bg-aqua">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-4.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Total Transcation</span>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 56%"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblTotalTransaction" runat="server" />
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="list-summary">
                            <div class="info-box bg-purple">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-4.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Status</span>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 56%"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblMerchantStatus" runat="server" />
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Latest Transaction</h2>
                    </div>
                    <div>
                        <%--<asp:ListView ID="LstRecentTransaction" runat="server" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1"
                            OnItemDataBound="LstRecentTransaction_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecords" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 15%; text-align: center;">Transaction Date</th>
                                            <th style="width: 15%; text-align: center;">Transaction ID</th>
                                            <th style="width: 10%; text-align: center;">Order No</th>
                                            <th style="width: 10%; text-align: center;">Payment Mode</th>
                                            <th style="width: 25%; text-align: center;">Transaction Amount (RM)</th>
                                            <th style="width: 25%; text-align: center;">Transaction Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="LstRecentTransaction" PageSize="10">
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
                                    <td style="text-align: center;"><%# Eval("transaction_date") %></td>
                                    <td style="text-align: center;"><%# Eval("transaction_id") %></td>
                                    <td style="text-align: center;"><%# Eval("order_no") %></td>
                                    <td style="text-align: center;"><%# Eval("payment_mode") %></td>
                                    <td style="text-align: center;"><%# String.Format("{0:#.00}", Eval("trans_amount")) %></td>
                                    <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("transaction_status") %></span></td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Transaction Date</th>
                                            <th>Transaction ID</th>
                                            <th>Order No</th>
                                            <th>Payment Mode</th>
                                            <th>Transaction Amount (RM)</th>
                                            <th>Transaction Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="10" align="center">No Transaction record found!
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </EmptyDataTemplate>
                        </asp:ListView>--%>
                        <asp:ListView ID="LstRecentTransaction" runat="server" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1"
                            OnItemDataBound="LstRecentTransaction_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecords" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>TRANSACTION DATE</th>
                                            <th>TRANSACTION ID</th>
                                            <th>Voucher Name</th>
                                            <th>Price(RM)</th>
                                            <<th>QUANTITY</th>
                                            <th>TRANSACTION STATUS</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="LstRecentTransaction" PageSize="10">
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
                                    <td data-title="No" align="center"><%# Container.DataItemIndex + 1 %></td>
                                    <td data-title="TRANSACTION DATE"><%# Eval("transaction_date") %></td>
                                    <td data-title="TRANSACTION ID"><%# Eval("transaction_number") %></td>
                                    <td data-title="Voucher Name"><%# Eval("voucher_name") %></td>
                                    <td data-title="Price(RM)"><%# Eval("total_amount") %></td>
                                    <td data-title="Qty"><%# Eval("product_qty") %></td>
                                    <td data-title="TRANSACTION STATUS"><span id="colorstatus" runat="server"><%# Eval("transaction_status") %></span></td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>TRANSACTION DATE</th>
                                            <th>TRANSACTION NO</th>
                                            <th>DESCRIPTION</th>
                                            <th>AMOUNT(RM)</th>
                                            <%--<th>QUANTITY</th>--%>
                                            <th>TRANSACTION STATUS</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="10" align="center">No Transaction record found!
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
