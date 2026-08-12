<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmReceiptDetails.aspx.cs" Inherits="CRMApp.crmapp.frmReceiptDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="main-area">
        <div class="container">
            <div class="row">
                <!--col-md-3-->
                <div class="col-md-12 pt20">
                    <ol class="breadcrumb">
                        <li class="home"><a href="index.html" title="Go to Home Page">Home</a>
                        </li>
                        <li class="active">Receipt</li>
                    </ol>
                </div>
                <div id="printarea">
                    <div class="col-md-12 col-sm-12">
                        <div class="col-sm-12 bg-print visible-print-block">
                            <img src="dashboard/img/header-print.png">
                        </div>
                        <div class="clearfix"></div>
                        <h3 class="text-bigr hidden-print">Receipt</h3>
                        <div class="panel panel-default panel-box addtocart">
                            <div class="panel-body form-horizontal">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Name</label>
                                        <div class="col-sm-8">
                                            <p class="form-control-static">Aien Maisarah</p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Email</label>
                                        <div class="col-sm-8">
                                            <%--<p class="form-control-static">email@example.com</p>--%>
                                            <p class="form-control-static">
                                                <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Contact Number</label>
                                        <div class="col-sm-8">
                                            <p class="form-control-static">012-1223123</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class="col-sm-6 control-label">Transaction Number</label>
                                        <div class="col-sm-6">
                                            <%--<p class="form-control-static">A00000001</p>--%>
                                            <p class="form-control-static">
                                                <asp:Label ID="lblTransactionID" runat="server" Text=""></asp:Label>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-6 control-label">Transaction Amount</label>
                                        <div class="col-sm-6">
                                            <%--<p class="form-control-static">RM 100.90</p>--%>
                                            <p class="form-control-static">
                                                RM<asp:Label ID="lblTotalAmount" runat="server" Text="">
                                                </asp:Label>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-6 control-label">Transaction Date</label>
                                        <div class="col-sm-6">
                                            <%-- <p class="form-control-static">24-Jan-2019 12:30:12</p>--%>
                                            <p class="form-control-static">
                                                <asp:Label ID="lblTransactionDate" runat="server" Text=""></asp:Label>k
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class="col-sm-6 control-label">Payment Method</label>
                                        <div class="col-sm-6">
                                            <%--<p class="form-control-static">Visa</p>--%>
                                            <p class="form-control-static">
                                                <asp:Label ID="lblPaymentMode" runat="server" Text=""></asp:Label>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-6 control-label">Payment Status</label>
                                        <div class="col-sm-6">
                                            <p class="form-control-static">
                                                <asp:Label ID="lblPaymentStatus" Visible="false" runat="server" Text="Label"></asp:Label>
                                                <asp:Label ID="lblTransactionStatus" runat="server" Text="Label"></asp:Label>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-6 control-label">Order Number</label>
                                        <div class="col-sm-6">
                                            <%--<p class="form-control-static">NA000918920</p>--%>
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
                                    <table class="table table-receipt">
                                        <thead>
                                            <tr>
                                                <td>No</td>
                                                <td>Voucher</td>
                                                <td>QTY</td>
                                                <td>Original Price</td>
                                                <td>Discount Price</td>
                                                <td>SST Amount</td>
                                                <td>Promo Code</td>
                                                <td>Total Price</td>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <tr>
                                                <td>1</td>
                                                <td>Hi-Tea Set For 2 People (Tony Roma's)</td>
                                                <td>1</td>
                                                <td>RM13.00</td>
                                                <td>RM10.00</td>
                                                <td>SST Included</td>
                                                <td>Promo Merdeka 2018 (-RM5.00)</td>
                                                <td>RM10.00</td>
                                            </tr>
                                            <tr>
                                                <td>2</td>
                                                <td>Hi-Tea Set For 2 People (Tony Roma's)</td>
                                                <td>2</td>
                                                <td>RM13.00</td>
                                                <td>RM10.00</td>
                                                <td>SST Included</td>
                                                <td>Promo Merdeka 2018 (-RM5.00)</td>
                                                <td>RM10.00</td>
                                            </tr>
                                            <tr>
                                                <td colspan="6"></td>
                                                <td>Total Price</td>
                                                <td>RM 13.00</td>
                                            </tr>
                                            <tr>
                                                <td colspan="6"></td>
                                                <td>SST (6%)</td>
                                                <td>RM 13.00</td>
                                            </tr>
                                            <tr>
                                                <td colspan="6"></td>
                                                <td class="text-right"><span class="final-total">Grand Total</span>
                                                </td>
                                                <td><span class="final-total">RM 13.00</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-sm-12">
                        <div class="panel panel-default panel-box addtocart">
                            <div class="panel-heading">
                                Your Billing Address
                            </div>
                            <div class="panel-body bill-curent">
                                <address>
                                    <%--<p>Siti Noratiqah Binti Othman</p>--%>
                                    <p>
                                        <asp:Label ID="LblName" runat="server"></asp:Label>
                                    </p>
                                    <%--<p>Digital Pinnacle Sdn Bhd</p>--%>
                                    <p>
                                        <%--A1-20 Block F2<br>--%>
                                        <asp:Label ID="LblAddr1" runat="server"></asp:Label><br>
                                        <%--Jalan Putra Perdana 3a<br>--%>
                                        <asp:Label ID="LblAddr2" runat="server"></asp:Label><br>
                                        <%--47100 Puchong<br>--%>
                                        <asp:Label ID="LblState" runat="server"></asp:Label>
                                        <br>
                                        <asp:Label ID="LblPinCode" runat="server"></asp:Label>
                                        <br>
                                        <asp:Label ID="LblCountry" runat="server"></asp:Label>
                                        <%--Malaysia.--%>
                                    </p>
                                    <%--<p>0133402397</p>--%>
                                    <p>
                                        <asp:Label ID="LblMobile" runat="server"></asp:Label></p>
                                </address>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-offset-5 col-sm-2 text-center pb20">
                    <a id="print" href="#" class="btn btn-bigr btn-lg btn-block">Print</a>
                </div>
            </div>
            <!--row-->
        </div>
        <!--container-->
    </div>
</asp:Content>
