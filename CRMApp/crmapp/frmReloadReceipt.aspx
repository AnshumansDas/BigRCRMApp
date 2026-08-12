<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmReloadReceipt.aspx.cs" Inherits="CRMApp.crmapp.frmReloadReceipt" %>

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
                                <li class="home"><a href="../Home.aspx" title="Go to Home Page">Home</a>
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
                                                <label class="col-sm-6 control-label">Transaction Number</label>
                                                <div class="col-sm-6">
                                                    <%--<p class="form-control-static">A00000001</p>--%>
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblTransactionID" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                            <asp:Panel ID="Pnl_Receipt" runat="server" Visible="false">
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
                                            </asp:Panel>
                                            <asp:Panel ID="Pnl_Token" runat="server" Visible="false">
                                                <div class="form-group">
                                                    <label class="col-sm-6 control-label">Token</label>
                                                    <div class="col-sm-6">
                                                        <p class="form-control-static">
                                                            <asp:Label ID="lblToken" runat="server" Text=""></asp:Label>
                                                        </p>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <div class="form-group">
                                                <label class="col-sm-6 control-label">Transaction Date</label>
                                                <div class="col-sm-6">
                                                    <%-- <p class="form-control-static">24-Jan-2019 12:30:12</p>--%>
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
                                                        <asp:Label ID="lblPaymentStatus" Visible="false" runat="server" Text=""></asp:Label>
                                                        <asp:Label ID="lblTransactionStatus" runat="server" Text=""></asp:Label>
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
                                        <div class="col-sm-4">
                                            <%--<div class="form-group">
                                                <label class="col-sm-4 control-label">Email</label>
                                                <div class="col-sm-8">
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>--%>
                                            <div class="form-group">
                                                <label class="col-sm-6 control-label">Email</label>
                                                <div class="col-sm-6">
                                                    <p class="form-control-static">
                                                        <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                            <%--<asp:Panel ID="Pnl_Token" runat="server" Visible="false">
                                                <div class="form-group">
                                                    <label class="col-sm-6 control-label">Token</label>
                                                    <div class="col-sm-6">
                                                        <p class="form-control-static">
                                                            <asp:Label ID="lblToken" runat="server" Text=""></asp:Label>
                                                        </p>
                                                    </div>
                                                </div>
                                            </asp:Panel>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-offset-5 col-sm-2 text-center pb20">
                            <%-- <a id="print" href="#" class="btn btn-bigr btn-lg btn-block">Print</a>--%>
                            <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
                            <asp:LinkButton ID="btnPrint" runat="server" class="btn btn-danger" OnClientClick="printdiv('divReciept');">Print Receipt</asp:LinkButton>
                        </div>
                    </div>
                    <!--row-->
                </div>
                <!--container-->
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
