<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMerchantDashboard.aspx.cs" Inherits="CRMApp.crmapp.frmMerchantDashboard" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <%--<div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Merchant Dashboard</h2>
            </div>
            <div></div>
        </div>
        <div class="col-sm-12">
            <div>
                Merchant Dashboard Details
                <div class="clearfix"></div>
            </div>
        </div>
    </div>--%>
    <div class="row">
        <!--col-md-3-->
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
                            <div class="info-box bg-aqua">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-1.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Total Online
                                <br />
                                        Points</span>
                                    <div class="progress">
                                        <div id="divTotalonlinepoints" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblTotalonlinepoints" runat="server" />
                                    </span>
                                </div>
                            </div>
                        </div>--%>
                        <div class="list-summary">
                            <div class="info-box bg-purple">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-3.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Total Purchase
                                <br />
                                        Voucher</span>
                                    <div class="progress">
                                        <div id="divlblTotalPurchaseVoucher" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblTotalPurchaseVoucher" runat="server" />
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <div class="list-summary">
                            <div class="info-box bg-aqua">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-4.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Total Redeem
                                <br />
                                        Point</span>
                                    <div class="progress">
                                        <div id="divlblvoupurchase" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblTotalRedeempoints" runat="server" />
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <div class="list-summary">
                            <div class="info-box bg-purple">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-2.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Total Redeem
                                <br />
                                        Voucher</span>
                                    <div class="progress">
                                        <div id="divlblRedeemVoucher" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblRedeemVoucher" runat="server" />
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <div class="list-summary">
                            <div class="info-box bg-aqua">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-4.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Total<br />
                                        Transaction(RM)</span>
                                    <div class="progress">
                                        <div id="divlblTotalTransaction" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblTotalTransaction" runat="server" />
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <div class="list-summary">
                            <div class="info-box bg-purple">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-4.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Status</span>
                                    <div class="progress">
                                        <div id="div1" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblMerchantStatus" runat="server" />
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <!--==================== Recently Bought area end==================== -->

                        <div class="clearfix"></div>
                        <!-- product-details-end-->
                    </div>
                    <!-- row-end-->
                </div>
                <!--col-md-12-->
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Latest Transaction</h2>
                    </div>
                    <div>

                        <asp:ListView ID="LstRecentTransaction" runat="server" DataKeyNames="transaction_number" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1"
                            OnItemDataBound="LstRecentTransaction_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row" style="display: none">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecords" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
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
                                        <tr>
                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                        </tr>
                                    </tbody>
                                </table>

                                <<div class="row">
                                    <div class="gap gap-small"></div>
                                    <div class="col-md-12 text-right">
                                        <asp:DataPager ID="DataPager2" runat="server" class="btn-group btn-group-sm" PageSize="10">
                                            <Fields>
                                                <asp:NextPreviousPagerField PreviousPageText="&laquo;" FirstPageText="|<" ShowPreviousPageButton="true"
                                                    ShowFirstPageButton="true" ShowNextPageButton="false" ShowLastPageButton="false"
                                                    ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                                <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary" RenderNonBreakingSpacesBetweenControls="false"
                                                    NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                                                <asp:NextPreviousPagerField NextPageText="&raquo;" LastPageText=">|" ShowNextPageButton="true"
                                                    ShowLastPageButton="true" ShowPreviousPageButton="false" ShowFirstPageButton="false"
                                                    ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                            </Fields>
                                        </asp:DataPager>
                                    </div>
                                </div>
                            </LayoutTemplate>
                            <GroupTemplate>
                                <tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                </tr>
                            </GroupTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td data-title="No" align="center"><%# Container.DataItemIndex + 1 %></td>
                                    <td data-title="TRANSACTION DATE"><%# Eval("transaction_date") %></td>
                                    <td data-title="TRANSACTION ID"><%# Eval("transaction_number") %></td>
                                    <td data-title="Voucher Name"><%# Eval("voucher_name") %></td>
                                    <td data-title="Price(RM)"><%# Eval("total_amount") %></td>
                                    <td data-title="Qty"><%# Eval("product_qty") %></td>
                                    <td data-title="TRANSACTION STATUS"><span id="colorstatus" runat="server"><%# Eval("purchase_status") %></span></td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
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
