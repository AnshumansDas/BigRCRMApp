<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmAdminDashboard.aspx.cs" Inherits="CRMApp.crmapp.frmAdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
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
                            <span class="info-box-text">Total Members</span>
                            <div class="progress">
                                <div id="divlblMembers" runat="server" class="progress-bar" role="progressbar"></div>
                            </div>
                            <span class="progress-description">
                                <asp:Label ID="lblMembers" runat="server" />
                            </span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
                <div class="list-summary">
                    <div class="info-box bg-purple">
                        <span class="info-box-icon">
                            <img src="img/icon/icon-ad-3.png">
                        </span>
                        <div class="info-box-content">
                            <span class="info-box-text">Total Merchants</span>
                            <div class="progress">
                                <div id="divlblTotalmerchant" runat="server" class="progress-bar" role="progressbar"></div>
                            </div>
                            <span class="progress-description">
                                <asp:Label ID="lblTotalmerchant" runat="server" />
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
                            <span class="info-box-text">Voucher Purchase</span>
                            <div class="progress">
                                <div id="divlblvoupurchase" runat="server" class="progress-bar" role="progressbar"></div>
                            </div>
                            <span class="progress-description">
                                RM&nbsp;<asp:Label ID="lblVoucherPurchase" runat="server" />
                            </span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
                <div class="list-summary">
                    <div class="info-box bg-aqua">
                        <span class="info-box-icon">
                            <img src="img/icon/icon-ad-2.png">
                        </span>
                        <div class="info-box-content">
                            <span class="info-box-text">Redeem Voucher</span>
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
                            <img src="img/icon/icon-ad-2.png">
                        </span>
                        <div class="info-box-content">
                            <span class="info-box-text">QrPay Purchase</span>
                            <div class="progress">
                                <div id="divlblAdvertisement" runat="server" class="progress-bar" role="progressbar"></div>
                            </div>
                            <span class="progress-description">
                                <asp:Label ID="lblQrPay"  runat="server" />
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
                <%--<table class="table table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Transaction Date</th>
                            <th>Transaction ID</th>
                            <th>Description</th>
                            <th>Price(RM)</th>
                            <th>QTY</th>
                            <th>Payment Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>01-11-2018 23:22:01</td>
                            <td>234873736</td>
                            <td>TOny Romas Hi-tea set</td>
                            <td>35.50</td>
                            <td>1</td>
                            <td><span class="label label-success">Success</span>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>01-11-2018 23:22:01</td>
                            <td>234873736</td>
                            <td>TOny Romas Hi-tea set</td>
                            <td>35.50</td>
                            <td>1</td>
                            <td><span class="label label-success">Success</span>
                            </td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>01-11-2018 23:22:01</td>
                            <td>234873736</td>
                            <td>TOny Romas Hi-tea set</td>
                            <td>35.50</td>
                            <td>1</td>
                            <td><span class="label label-success">Success</span>
                            </td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>01-11-2018 23:22:01</td>
                            <td>234873736</td>
                            <td>TOny Romas Hi-tea set</td>
                            <td>35.50</td>
                            <td>1</td>
                            <td><span class="label label-success">Success</span>
                            </td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>01-11-2018 23:22:01</td>
                            <td>234873736</td>
                            <td>TOny Romas Hi-tea set</td>
                            <td>35.50</td>
                            <td>1</td>
                            <td><span class="label label-success">Success</span>
                            </td>
                        </tr>
                    </tbody>
                </table>--%>
                <asp:ListView ID="LstRecentTransaction" runat="server" DataKeyNames="order_no" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1"
                    OnPagePropertiesChanging="LstRecentTransaction_PagePropertiesChanging">
                    <LayoutTemplate>
                        <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                            <thead class="cf">
                                <tr>
                                    <th>ID</th>
                                    <th>TRANSACTION DATE</th>
                                    <th>TRANSACTION NO</th>
                                    <th>PAYMENT MODE</th>
                                    <th>AMOUNT(RM)</th> 
                                    <th>TRANSACTION STATUS</th>
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
                            <td data-title="No" align="center"><%# Container.DataItemIndex + 1 %></td>
                            <td data-title="Order Date"><%# Eval("transaction_time") %></td>
                            <td data-title="Order No"><%# Eval("transaction_id") %></td>
                            <td data-title="qty"><%# Eval("payment_mode") %></td>
                            <%--<td data-title="Description"><%# Eval("product_desc") %></td> --%>                           
                            <td data-title="Old price"><%# Eval("trans_amount") %></td>
                            
                            <td data-title="Date"><%# Eval("transaction_status") %></td>
                        </tr>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                            <thead class="cf">
                                <tr>
                                    <th>ID</th>
                                    <th>TRANSACTION DATE</th>
                                    <th>TRANSACTION NO</th>
                                    <th>PAYMENT MODE</th>
                                    <th>AMOUNT(RM)</th>  
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
    </div>
</asp:Content>
