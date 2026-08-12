<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MobileReloadReciept.aspx.cs" Inherits="CRMApp.crmapp.MobileReloadReciept" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        .textColor {
            color: #000000
        }

        .button-rec {
            padding: 10px 20px 10px 20px;
            background-color: blueviolet;
            color: #ffffff;
            border: 0;
            /*border-radius:5px;*/
        }
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="viewport" content="target-densitydpi=device-dpi" />
    <script type="text/javascript">
        //window.onload = function () {
        //    init();
        //};

        //function init(transactionResult, transaction_no, topup_order_id, transactionStatus, shoppingAmount, currency, paymentDate, approvalCode, paymentChannel) {
        function success() {
            //var result = document.getElementById('Label1').textContent;
            //var transactionID = document.getElementById('Label2').textContent;
            //var orderNo = document.getElementById('Label3').textContent;
            var transactionStatus = document.getElementById('Label4').textContent;
            //var shoppingAmount = document.getElementById('Label5').textContent;
            //var currency = document.getElementById('Label6').textContent;
            //var paymentDate = document.getElementById('Label7').textContent;
            ////var approvalCode = document.getElementById('Label8').textContent;
            ////var paymentChannel = document.getElementById('Label9').textContent;
            //var approvalCode = "";
            //var paymentChannel = "";
            //var paymentMode = document.getElementById('Label11').textContent;
            var errorCode = document.getElementById('Label10').textContent;
            //var cardType = document.getElementById('Label13').textContent;
            //var token = document.getElementById('lblToken').textContent;
            //var bank = document.getElementById('lblBankName').textContent;
            //var cardno = document.getElementById('lblMaskCardno').textContent;
            var success = "Your Transaction is Successfull";
            var fail = "Your Transaction is Failed";
            var cancel = "Your Transaction is Cancel by user";
            if (transactionStatus.trim() == "SUCCESSFUL") {
                //CRMPayMoney.success(result, transactionID, orderNo, transactionStatus, shoppingAmount, currency, paymentDate, approvalCode, paymentChannel, cardType, paymentMode, token, bank);
                CRMPayMoney.success(transactionStatus,success);
            }
            else if (transactionStatus.trim() == "DECLINED") {
                if (errorCode != null) {
                    //CRMPayMoney.fail(result, transactionID, orderNo, transactionStatus, shoppingAmount, currency, paymentDate, approvalCode, paymentChannel, cardType, paymentMode, token, bank);
                    CRMPayMoney.fail(transactionStatus,fail);
                }
                else {

                    //CRMPayMoney.cancel(result, transactionID, orderNo, transactionStatus, mentDate, approvalCode, paymentChannel, errorCode, token, bank);
                    CRMPayMoney.cancel(transactionStatus,cancel);
                }
            }
            /*
            if (token != "") {
                if (transactionStatus.trim() == "SUCCESSFUL") {
                    AbsecPayToken.tokensuccess(token, transactionStatus, transactionID, orderNo, paymentDate);
                }
                else if (transactionStatus.trim() == "DECLINED") {
                    if (errorCode != null) {
                        AbsecPayToken.fail(result, transactionId, orderNo, transactionStatus, paymentDate, token);
                    }
                    else {

                        AbsecPayToken.cancel(result, transactionId, orderNo, transactionStatus, paymentDate, token);
                    }
                }
            }
            else {
                if (transactionStatus.trim() == "SUCCESSFUL") {
                    AbsecPayMoney.success(result, transactionId, orderNo, transactionStatus, shoppingAmount, currency, paymentDate, approvalCode, paymentChannel, token);
                }
                else if (transactionStatus.trim() == "DECLINED") {
                    if (errorCode != null) {
                        AbsecPayMoney.fail(result, transactionId, orderNo, transactionStatus, shoppingAmount, currency, paymentDate, approvalCode, paymentChannel, errorCode);
                    }
                    else {

                        AbsecPayMoney.cancel(result, transactionId, orderNo, transactionStatus, mentDate, approvalCode, paymentChannel, errorCode);
                    }
                }
            }
            */
        }
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager runat="server" ID="scm1">
            </asp:ScriptManager>
            <table>
                <tr class="textColor">
                    <td colspan="2" style="align-items: center"><strong>Reciept Details </strong></td>
                </tr>
                <tr class="textColor">
                    <td>Transaction Result</td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr class="textColor">
                    <td>Transaction ID</td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr class="textColor">
                    <td>Order No</td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr class="textColor">
                    <td>Transaction Status</td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr class="textColor">
                    <td>Transaction Amount</td>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr class="textColor">
                    <td>Currency</td>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr class="textColor">
                    <td>Transaction Date</td>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text=""></asp:Label></td>
                </tr>
                <%--<tr class="textColor">
                    <td>Approval Status</td>
                    <td>
                        <asp:Label ID="Label8" runat="server" Text=""></asp:Label></td>
                </tr>--%>
                <%--<tr class="textColor">
                    <td>Payment Mode</td>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text=""></asp:Label>
                    </td>
                </tr>--%>
                <tr class="textColor">
                    <td>Error Code</td>
                    <td>
                        <asp:Label ID="Label10" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr class="textColor">
                    <td>Payment Mode</td>
                    <td>
                        <asp:Label ID="Label11" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr class="textColor">
                    <td>Card Type</td>
                    <td>
                        <asp:Label ID="Label13" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <asp:Panel ID="PnlToken" runat="server" Visible="false" >
                    <tr class="textColor">
                        <td>token</td>
                        <td>
                            <asp:Label ID="lblToken" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblMaskCardno" runat="server" Text="" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr class="textColor">
                        <td>bankName</td>
                        <td>
                            <asp:Label ID="lblBankName" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </asp:Panel>
                <tr>
                    <td>
                        <asp:Label ID="lblMsg" runat="server" Text="Transaction is in Progress. Please Wait ...."></asp:Label></td>
                    <td>
                        <asp:Button ID="btnBacktoHome" runat="server" CssClass="button-rec" Text="Back To Home" OnClick="btnBacktoHome_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
