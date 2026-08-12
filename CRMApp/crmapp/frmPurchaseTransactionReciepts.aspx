<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmPurchaseTransactionReciepts.aspx.cs" Inherits="CRMApp.crmapp.frmPurchaseTransactionReciepts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="upReciept" runat="server">
        <ContentTemplate>
            <!-- main area start -->
            <div class="main-area">
                <div class="container">
                    <div class="row">
                        <!--col-md-3-->
                        <div class="col-md-12 pt20">
                            <ol class="breadcrumb">
                                <li class="home"><a href="./Home.aspx" title="Go to Home Page">Home</a>
                                </li>
                                <li class="active">Receipt</li>
                            </ol>
                        </div>
                        <div id="printarea">
                            <div class="col-md-12 col-sm-12">
                                <div class="col-sm-12 bg-print visible-print-block">
                                    <img src="img/header-print.png">
                                </div>
                                <div class="clearfix"></div>
                                <h3 class="text-bigr hidden-print">Receipt</h3>
                                <div class="panel panel-default panel-box addtocart">
                                    <div class="panel-body form-horizontal">
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label">Name</label>
                                                <div class="col-sm-8">
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblName" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label">Email</label>
                                                <div class="col-sm-8">
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label">Contact Number</label>
                                                <div class="col-sm-8">
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblPhone" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <label class="col-sm-6 control-label">Transaction Number</label>
                                                <div class="col-sm-6">
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblTransactionNo" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-6 control-label">Transaction Amount</label>
                                                <div class="col-sm-6">
                                                    <p class="form-control-static">
                                                        RM&nbsp;<asp:Label ID="lblTransactionAmount" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-6 control-label">Transaction Date</label>
                                                <div class="col-sm-6">
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblTransactionDate" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <label class="col-sm-6 control-label">Payment Method</label>
                                                <div class="col-sm-6">
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblPaymentMode" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-6 control-label">Payment Status</label>
                                                <div class="col-sm-6">
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblPaymentSTatus" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-6 control-label">Order Number</label>
                                                <div class="col-sm-6">
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblOrderNo" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default panel-box addtocart">
                                    <div class="panel-body">
                                        <div class="table-responsive">
                                            <asp:ListView ID="lsvTransSummary" runat="server" DataKeyNames="voucher_id" GroupPlaceholderID="groupPlaceHolder1"
                                                ItemPlaceholderID="itemPlaceHolder1">
                                                <LayoutTemplate>
                                                    <table class="table table-receipt" cellspacing="0">
                                                        <thead>
                                                            <tr>
                                                                <th>Sl No</th>
                                                                <th>Voucher Name</th>
                                                                <th>Voucher Code</th>
                                                                <th>Qty</th>
                                                                <th>Original Price(RM)</th>
                                                                <th>Discount Price(RM)</th>
                                                                <th>SST Amount(RM)</th>
                                                                <th>Promocode</th>
                                                                <th>Total Price(RM)</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </LayoutTemplate>
                                                <GroupTemplate>
                                                    <tr>
                                                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                                    </tr>
                                                </GroupTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><%# Container.DataItemIndex + 1 %></td>
                                                        <td><%# Eval("voucher_name") %></td>
                                                        <td><%# Eval("voucher_code") %></td>
                                                        <td><%# Eval("product_qty") %></td>
                                                        <td><%# Eval("original_price","{0:F2}") %></td>
                                                        <td><%# Eval("discount_price","{0:F2}") %></td>
                                                        <td><%# Eval("sst_amount","{0:F2}") %></td>
                                                        <td><%# Eval("promocode_name") %></td>
                                                        <td><%# Eval("discount_price","{0:F2}") %></td>
                                                        <%--<td data-title="trans status"><%# Eval("total_tax_amount") %></td>  --%>
                                                    </tr>
                                                    <%--<tr>
                                                        <td colspan="7"></td>
                                                        <td>Total Price</td>
                                                        <td>RM
                                                            <asp:Label ID="lblSubTotal" runat="server" Text=""></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7"></td>
                                                        <td>SST (6%)</td>
                                                        <td>RM
                                                            <asp:Label ID="lblTaxAmount" runat="server" Text=""></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7"></td>
                                                        <td class="text-right"><span class="final-total">Grand Total</span>
                                                        </td>
                                                        <td><span class="final-total">RM
                                                            <asp:Label ID="lblGrandTotal" runat="server" Text=""></asp:Label></span>
                                                        </td>
                                                    </tr>--%>
                                                </ItemTemplate>

                                                <EmptyDataTemplate>
                                                    <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                        <thead class="cf">
                                                            <tr>
                                                                <th>Sl No</th>
                                                                <th>Voucher Name</th>
                                                                <th>Voucher Code</th>
                                                                <th>Original Price(RM)</th>
                                                                <th>Discount Price(RM)</th>
                                                                <th>SST Amount(RM)</th>
                                                                <th>Promocode</th>
                                                                <th>Total Price</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="10" style="text-align: center;">No Toll Transaction available for User!
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </EmptyDataTemplate>
                                            </asp:ListView>
                                        </div>
                                    </div>
                                    <div class="panel panel-default panel-box addtocart">
                                        <div class="panel-body">
                                            <table class="table table-checkout-final">
                                                <tbody>
                                                    <tr>
                                                        <td colspan="7"></td>
                                                        <td style="text-align:right">Total Price</td>
                                                        <td>RM
                                                            <asp:Label ID="lblSubTotal" runat="server" Text=""></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7"></td>
                                                        <td style="text-align:right">SST (6%)</td>
                                                        <td>RM
                                                            <asp:Label ID="lblTaxAmount" runat="server" Text=""></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7"></td>
                                                        <td class="text-right"><span class="final-total">Grand Total</span>
                                                        </td>
                                                        <td><span class="final-total">RM
                                                            <asp:Label ID="lblGrandTotal" runat="server" Text=""></asp:Label></span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>

                                    </div>
                                    <div class="col-sm-12">
                                        <div class="panel panel-default panel-box addtocart">
                                            <div class="panel-heading">
                                                Your Billing Address
                                            </div>
                                            <div class="panel-body bill-curent">
                                                <address>
                                                    <p>
                                                        <asp:Label ID="lblBillName" runat="server" Text=""></asp:Label>
                                                    </p>
                                                    <p>
                                                        <asp:Label ID="lblcity" runat="server" Text=""></asp:Label>
                                                    </p>
                                                    <p>
                                                        <asp:Label ID="lbladress1" runat="server" Text=""></asp:Label><br>
                                                        <asp:Label ID="lbladdress2" runat="server" Text=""></asp:Label><br>
                                                        <asp:Label ID="lblPostcode" runat="server" Text=""></asp:Label>
                                                        <asp:Label ID="lblState" runat="server" Text=""></asp:Label><br>
                                                        <asp:Label ID="lblCountry" runat="server" Text=""></asp:Label>
                                                    </p>
                                                    <p>
                                                        <asp:Label ID="lblphoneno" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </address>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-offset-5 col-sm-2 text-center pb20 hidden-print">
                                    <a id="print" href="#" class="btn btn-bigr btn-lg btn-block">Print</a>
                                </div>
                            </div>
                            <!--row-->
                        </div>
                        <!--container-->
                    </div>
                    <!-- main area end -->
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
