<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmReceipt.aspx.cs" Inherits="CRMApp.crmapp.frmReceipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function printdiv(printpage) {
            var headstr = "<html><head><title></title></head><body>";
            var footstr = "</body>";
            var newstr = document.getElementById(printpage);
            var button2 = document.getElementById("<%=btnPrint.ClientID %>");
            var oldstr = document.body.innerHTML;
            button2.style.visibility = 'hidden';
            //href.style.visibility = 'hidden';                    
            document.body.innerHTML = headstr + newstr.innerHTML + footstr;
            window.print();
            document.body.innerHTML = oldstr;
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="main-area" id="divReciept">
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
                                                    <%--<p class="form-control-static">Aien Maisarah</p>--%>
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblFName" runat="server"></asp:Label>
                                                    </p>
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
                                                    <%--<p class="form-control-static">012-1223123</p>--%>
                                                    <p class="form-control-static">
                                                        <asp:Label ID="LblMob" runat="server"></asp:Label>
                                                    </p>
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


                                <asp:ListView ID="lvCartList" runat="server" DataKeyNames="voucher_id" ItemPlaceholderID="itemPlaceHolder1">
                                    <LayoutTemplate>
                                        <div class="panel panel-default panel-box addtocart">
                                            <div class="panel-body">
                                                <table class="table table-checkout head">
                                                    <tbody>
                                                        <tr>
                                                            <td>Voucher</td>
                                                            <td>QTY</td>
                                                            <td>Original Price</td>
                                                            <td>Discount Price</td>
                                                            <td>SST Amount</td>
                                                            <td>Promo Code</td>
                                                            <td>Total Price</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div class="panel panel-default panel-box addtocart">
                                            <div class="panel-body">
                                                <table class="table table-checkout">
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblProductId" runat="server" Text='<%#Eval("Product_ID")%>' Visible="false"></asp:Label>
                                                                <asp:Label ID="lblOrderId" runat="server" Text='<%#Eval("orderid")%>' Visible="false"></asp:Label>
                                                                <asp:Label runat="server" ID="lblproname" Text='<%# Eval("voucher_name") %>'></asp:Label></td>
                                                            <td>
                                                                <div class="input-group cart">
                                                                    <asp:Label runat="server" ID="LblQty" Text='<%# Eval("Product_Qty") %>'></asp:Label>
                                                            </td>

                                                            <td>
                                                                <asp:Label ID="lblPrice" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("original_price").ToString())) ? Convert.ToDouble(Eval("original_price")).ToString("N2") : "0.00" %>'></asp:Label></td>
                                                            <td>
                                                                <asp:Label ID="LblDiscountPrice" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("discount_price").ToString())) ? Convert.ToDouble(Eval("discount_price")).ToString("N2") : "0.00" %>'></asp:Label></td>
                                                            <td>
                                                                <asp:Label ID="LblSSTamount" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("sst_amount").ToString())) ? Convert.ToDouble(Eval("sst_amount")).ToString("N2") : "0.00" %>'></asp:Label></td>

                                                            <td>
                                                                <asp:Label runat="server" ID="LblPromocode" Text='<%# Eval("Promocode_name") %>'></asp:Label></td>
                                                            <td>
                                                                <asp:Label ID="lblTotalAmt" runat="server" Text='<%# (!string.IsNullOrEmpty(Eval("Total_final_price").ToString())) ? Convert.ToDouble(Eval("total_amount")).ToString("N2") : "0.00" %>'></asp:Label>
                                                                <asp:Label ID="lblBasePrice" runat="server" Text='<%#Eval("original_price")%>' Visible="false"></asp:Label>
                                                            </td>

                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                                <div class="panel panel-default panel-box addtocart">
                                    <div class="panel-body">
                                        <table class="table table-checkout-final">
                                            <tbody>
                                                <tr>
                                                    <td></td>

                                                    <td></td>
                                                    <td>Total Price</td>
                                                    <%--<td>RM 13.00</td>--%>
                                                    <td>RM<asp:Label ID="lblsumAmout2" runat="server" Text="Label"></asp:Label></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td>SST (6%)</td>
                                                    <td>RM
                                                    <asp:Label ID="lblTotaSSTAmt" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td>Promocode</td>
                                                    <td>
                                                    <asp:Label ID="LblPromocode" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                    <td><span class="final-total">Grand Total</span>
                                                    </td>
                                                    <td><span class="final-total">RM
                                    <asp:Label ID="lblTotalCartAmt" runat="server" Text="Label"></asp:Label>
                                                    </span>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>
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
                                                <asp:Label ID="LblMobile" runat="server"></asp:Label>
                                            </p>
                                            <address>
                                            </address>
                                            <address>
                                            </address>
                                            <address>
                                            </address>
                                        </address>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-offset-5 col-sm-2 text-center pb20">
                            <%-- <a id="print" href="#" class="btn btn-bigr btn-lg btn-block">Print</a>--%>
                            <asp:LinkButton ID="btnPrint" runat="server" class="btn btn-danger" OnClientClick="printdiv('divReciept');">Print Reciept</asp:LinkButton>
                        </div>
                    </div>
                    <!--row-->
                </div>
                <!--container-->
            </div>
            <%-- Code Commented By Mani 0n 04FEB2019 --%>
            <%-- <div class="main-area">
                <div class="container" id="divReciept">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="area-title bdr mt20">
                                <h2>Payment Status</h2>
                            </div>
                            <div></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="the-box-title">
                                <h2 class="text-center">Transaction Receipt</h2>
                                <h1 class="text-center text-success">
                                    <asp:Label ID="lblPaymentStatus" runat="server" Text="Label"></asp:Label>
                                </h1>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 text-center">
                            <div class="form-group">
                                <label class="col-sm-6 control-label">Transaction Status</label>
                                <div class="col-sm-6">
                                    <p class="form-control-static text-success">
                                        <asp:Label ID="lblTransactionStatus" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-6 control-label">Transaction ID</label>
                                <div class="col-sm-6">
                                    <p class="form-control-static">
                                        <asp:Label ID="lblTransactionID" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-6 control-label">Transaction Date &amp; Time</label>
                                <div class="col-sm-6">
                                    <p class="form-control-static">
                                        <asp:Label ID="lblTransactionDate" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-6 control-label">Transaction Ref. No.</label>
                                <div class="col-sm-6">
                                    <p class="form-control-static">
                                        <asp:Label ID="lblOrderNo" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-6 control-label">Email</label>
                                <div class="col-sm-6">
                                    <p class="form-control-static">
                                        <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-6 control-label">Payment Method</label>
                                <div class="col-sm-6">
                                    <p class="form-control-static">
                                        <asp:Label ID="lblPaymentMode" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-6 control-label">Total Amount</label>
                                <div class="col-sm-6">
                                    <p class="form-control-static">RM<asp:Label ID="lblTotalAmount" runat="server" Text=""></asp:Label></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-6 control-label">Token No</label>
                                <div class="col-sm-6">
                                    <p class="form-control-static">
                                        <asp:Label ID="lblTokenNo" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="text-center">
                                        <asp:LinkButton ID="btnPrint" runat="server" class="btn btn-danger" OnClientClick="printdiv('divReciept');">Print Reciept</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>--%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
