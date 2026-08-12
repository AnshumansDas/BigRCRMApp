<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmUserDashboard.aspx.cs" Inherits="CRMApp.crmapp.frmUserDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <%--<asp:ScriptManager ID="scriptmanager1" runat="server" />--%>
    <asp:UpdatePanel ID="Up1" runat="server">
        <ContentTemplate>
            <div class="row">
                <!--col-md-3-->
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Account Summary</h2>
                    </div>
                    <div></div>
                </div>
                <div class="col-sm-12">
                    <div>
                        <div class="list-summary">
                            <div class="info-box bg-aqua">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-1.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Online Points</span>
                                    <div class="progress">
                                        <div id="divlblOnlinePoint" runat="server" class="progress-bar" role="progressbar"></div>
                                        <%--<div class="progress-bar" style="width: 56%"></div>--%>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblPoints" runat="server" />
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <div class="list-summary">
                            <div class="info-box bg-red-active">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-2.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Purchase Voucher</span>
                                    <div class="progress">
                                        <div id="divlblPurchaseVoucher" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblPurchaseVoucher" runat="server" />
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <div class="list-summary">
                            <div class="info-box bg-green-active">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-1.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Redeem Points</span>
                                    <div class="progress">
                                        <div id="divlblRedeemPoints" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblRedeemPoint" runat="server" />
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <div class="list-summary">
                            <div class="info-box bg-blue-active">
                                <span class="info-box-icon">
                                    <img src="img/icon/icon-ad-4.png">
                                </span>
                                <div class="info-box-content">
                                    <span class="info-box-text">Redeem Voucher</span>
                                    <div class="progress">
                                        <div id="divlblRedeemVoucher" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="RedeemVoucher" runat="server" />
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
                                    <span class="info-box-text">Transaction(RM)</span>
                                    <div class="progress">
                                        <div id="divlblTransaction" runat="server" class="progress-bar" role="progressbar"></div>
                                    </div>
                                    <span class="progress-description">
                                        <asp:Label ID="lblTransaction" runat="server" />
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                            <!-- /.info-box -->
                        </div>
                        <asp:Panel ID="Panel_Status" Visible="false" runat="server">
                            <div class="list-summary">
                                <div class="info-box bg-fuchsia-active">
                                    <span class="info-box-icon">
                                        <img src="img/icon/icon-ad-3.png">
                                    </span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">Active Status</span>
                                        <div class="progress">
                                            <div id="divActive" runat="server" class="progress-bar" role="progressbar"></div>
                                        </div>
                                        <span class="progress-description">
                                            <asp:Label ID="lblActive" runat="server" Text="Active" />
                                        </span>
                                    </div>
                                    <!-- /.info-box-content -->
                                </div>
                                <!-- /.info-box -->
                            </div>
                        </asp:Panel>
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
                        <a href="frmTransactionHistory.aspx">ViewAll>></a>
                    </div>
                    <div>
                        <asp:ListView ID="LstRecentTransaction" runat="server" DataKeyNames="order_id" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1"
                            OnPagePropertiesChanging="LstRecentTransaction_PagePropertiesChanging">
                            <LayoutTemplate>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
                                        <tr>
                                            <th>ID</th>
                                            <th>TRANSACTION DATE</th>
                                            <th>TRANSACTION ID</th>
                                            <th>ORDER NO</th>
                                            <th>AMOUNT</th>
                                            <th>QUANTITY</th>
                                            <th>STATUS</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="gap gap-small"></div>
                                    <div class="col-md-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PageSize="10">
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
                                    <td style="text-align: center"><%# Container.DataItemIndex + 1 %></td>
                                    <td style="text-align: center"><%# Eval("transaction_time") %></td>
                                    <td style="text-align: center"><%# Eval("transaction_id") %></td>
                                    <td style="text-align: center"><%# Eval("order_no") %></td>
                                    <td style="text-align: center"><%# Eval("trans_amount") %></td>
                                    <td style="text-align: center"><%# Eval("product_qty") %></td>
                                    <td style="text-align: center"><%# Eval("transaction_status") %></td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
                                        <tr>
                                            <th>ID</th>
                                            <th>TRANSACTION DATE</th>
                                            <th>TRANSACTION ID</th>
                                            <th>ORDER NO</th>
                                            <th>AMOUNT</th>
                                            <th>QUANTITY</th>
                                            <th>STATUS</th>
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
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
