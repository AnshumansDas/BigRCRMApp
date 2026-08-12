<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmQrPayReceipt.aspx.cs" Inherits="CRMApp.crmapp.frmQrPayReceipt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<style>
		.btn {
			display: inline-block;
			padding: 4px 8px;
			margin-bottom: 0;
			font-size: 12px;
			font-weight: 400;
			line-height: 1.42857143;
			text-align: center;
			white-space: nowrap;
			vertical-align: middle;
			-ms-touch-action: manipulation;
			touch-action: manipulation;
			cursor: pointer;
			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
			user-select: none;
			background-image: none;
			border: 1px solid transparent;
			border-radius: 4px;
		}

		.btn-info {
			color: #fff;
			background-color: #00c0ef;
			border-color: #00acd6;
		}

			.btn-info:hover {
				color: #fff;
				background-color: #31b0d5;
				border-color: #269abc;
			}

			.btn-info:hover,
			.btn-info:active,
			.btn-info.hover {
				background-color: #00acd6;
			}

		.btn-success:hover,
		.btn-success:active,
		.btn-success.hover {
			background-color: #008d4c;
		}

		.btn-success:hover {
			color: #fff;
			background-color: #449d44;
			border-color: #398439;
		}

		.btn.focus,
		.btn:focus,
		.btn:hover {
			color: #fff;
			text-decoration: none;
		}

		.btn-success {
			color: #fff;
			background-color: #00a65a;
			border-color: #008d4c;
		}
	</style>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<script type="text/javascript">
		function success() {
			//var result = document.getElementById('Label1').textContent;
			//var transactionId = document.getElementById('Label2').textContent;
			//var orderNo = document.getElementById('Label3').textContent;
			var transactionStatus = document.getElementById('Label4').textContent;
			//var shoppingAmount = document.getElementById('Label5').textContent;
			//var currency = document.getElementById('Label6').textContent;
			//var paymentDate = document.getElementById('Label7').textContent;
			//var approvalCode = document.getElementById('Label8').textContent;
			//var paymentChannel = document.getElementById('Label9').textContent;
			//var processorMessage = document.getElementById('Label10').textContent;
			//var errorCode = document.getElementById('Label11').textContent;
			//var cardType = document.getElementById('Label12').textContent;
			//var paymentMode = document.getElementById('Label9').textContent;
			//var membername = document.getElementById('lblMemberName').textContent;
			//var outlet = document.getElementById('lblOutlet').textContent;

			var success = "The Transaction is Success";
			var fail = "The Transaction is Failed";
			var cancel = "The Transaction is Cancel";

			if (transactionStatus.trim() == "SUCCESSFUL") {
				//CRMPayMoney.success(result, transactionId, orderNo, transactionStatus, shoppingAmount, currency, paymentDate, approvalCode, paymentChannel, cardType, paymentMode);
				CRMPayMoney.success(transactionStatus, success);
				//CRMPayMoney.success(orderNo);
				//Aurobind param
				//public void success(final String result, final String transactionId, final String orderNo, final String transactionStatus,
				//    final String shoppingAmount, final String currency, final String paymentDate, final String  approvalCode,
				//    final String paymentChannel , final String cardType , final String paymentMode)
			}
			else if (transactionStatus.trim() == "DECLINED") {
				if (errorCode != null) {
					//CRMPayMoney.fail(result, transactionId, orderNo, transactionStatus, shoppingAmount, currency, paymentDate, approvalCode, paymentChannel, cardType, paymentMode);
					//CRMPayMoney.fail(result, transactionId, orderNo, transactionStatus, shoppingAmount, currency, paymentDate, approvalCode, paymentChannel, errorCode);
					CRMPayMoney.success(transactionStatus, fail);
					//CRMPayMoney.success(orderNo);
				}
				else {

					//CRMPayMoney.cancel(result, transactionId, orderNo, transactionStatus, paymentDate, approvalCode, paymentChannel, errorCode);
					CRMPayMoney.success(transactionStatus, cancel);
					//CRMPayMoney.success(orderNo);
					//CRMPayMoney.fail(result, transactionId, orderNo, transactionStatus, shoppingAmount, currency, paymentDate, approvalCode, paymentChannel, cardType, paymentMode);
				}
			}
		}
	</script>
</head>
<body>
	<form id="form1" runat="server">
		<asp:ScriptManager runat="server" ID="scm1">
		</asp:ScriptManager>
		<div style="padding: 0px; margin: 0px; font-family: 'Helvetica Neue',Helvetica,Arial; font-size: 12px; color: #5e5959">
			<table align="center" bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td width="750">
							<table align="center" width="100%">
								<tbody>
									<tr>
										<td style="padding: 10px 10px 10px 10px">
											<table width="100%">
												<tbody>
													<tr>
														<td style="text-align: center;">
															<img src="https://staging.bigr.asia/images/logo.png" style="max-width: 100%; margin-left: 10px; width: 100px;" class="CToWUd">
														</td>
													</tr>
													<tr>
														<td align="center">
															<p style="border-bottom: 1px dotted #efebec; width: 100%">
															</p>
															<table width="80%" style="vertical-align: top; font-size: 12px; margin-top: 12px; margin-bottom: 12px">
																<tbody>
																	<tr style="vertical-align: top;">
																		<td align="right" width="50%">Transaction Date</td>
																		<td>: </td>
																		<td width="50%">
																			<asp:Label ID="Label7" runat="server"></asp:Label></td>
																	</tr>
																	<tr style="vertical-align: top;">
																		<td align="right" width="50%">Transaction No</td>
																		<td>: </td>
																		<td width="50%">
																			<asp:Label ID="Label2" runat="server"></asp:Label></td>
																	</tr>
																	<tr style="vertical-align: top;">
																		<td align="right" width="50%">Payment Status</td>
																		<td>: </td>
																		<td width="50%">
																			<asp:Label ID="Label4" runat="server"></asp:Label></td>
																	</tr>
																	<tr id="trPaymentMode" runat="server" style="vertical-align: top;">
																		<td align="right" width="50%">Payment Method</td>
																		<td>: </td>
																		<td width="50%">
																			<asp:Label ID="Label9" runat="server"></asp:Label></td>
																	</tr>

																	<tr id="trPayType" runat="server" style="vertical-align: top;">
																		<td align="right" width="50%">Card Type</td>
																		<td>: </td>
																		<td width="50%">
																			<asp:Label ID="Label12" runat="server"></asp:Label></td>
																	</tr>
																	<tr style="vertical-align: top;">
																		<td align="right" width="50%">Amount</td>
																		<td>: </td>
																		<td width="50%">
																			<asp:Label ID="Label5" runat="server"></asp:Label></td>
																	</tr>
																	<tr style="vertical-align: top;">
																		<td align="right" width="50%" style="color: #fff">Member Name</td>
																		<td></td>
																		<td width="50%">
																			<asp:Label ID="lblMemberName" runat="server"></asp:Label></td>
																	</tr>
																	<%--<tr>
																		<td align="right" width="50%" style="color: #fff">Push</td>
																		<td></td>
																		<td width="50%">
																			<asp:Label ID="Label13" runat="server"></asp:Label></td>
																	</tr>--%>

																</tbody>
															</table>
															<p style="border-bottom: 1px dotted #efebec; width: 100%">
															</p>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
									<tr>
										<td style="padding: 10px 0 20px 0" width="100%">
											<table align="center" style="font-size: 10px">
												<tbody>
													<tr>
														<td align="center">
															<asp:Button ID="btnBacktoHome" runat="server" CssClass="btn btn-info" Text="Continue to Home page" OnClick="btnBacktoHome_Click" />
														</td>
													</tr>
													<tr>
														<td align="center">
															<asp:Label ID="lblMsg" runat="server"></asp:Label>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
									<tr style="vertical-align: top;">
										<td align="right" width="50%" style="color: #fff">Outlet</td>
										<td></td>
										<td width="50%">
											<asp:Label ID="lblOutlet" runat="server"></asp:Label></td>
									</tr>
									<%--<tr id="trTransResult" runat="server" style="vertical-align: top;">
										<td align="right" width="50%">Transaction Result</td>
										<td>: </td>
										<td width="50%">
											<asp:Label ID="lblResult" runat="server"></asp:Label></td>
									</tr>--%>
									<tr id="trOrderNo" runat="server" style="vertical-align: top;">
										<td align="right" width="50%" style="color: #fff">Order No</td>
										<td></td>
										<td width="50%">
											<asp:Label ID="Label3" runat="server" Style="color: #fff"></asp:Label></td>
									</tr>
									<tr id="trCurrency" runat="server" style="vertical-align: top;">
										<td align="right" width="50%" style="color: #fff">Currency</td>
										<td></td>
										<td width="50%">
											<asp:Label ID="Label6" runat="server" Style="color: #fff"></asp:Label></td>
									</tr>
									<tr id="trApprovalStatus" runat="server" style="vertical-align: top;">
										<td align="right" width="50%" style="color: #fff">Approval Status</td>
										<td></td>
										<td width="50%">
											<asp:Label ID="Label8" runat="server" Style="color: #fff"></asp:Label></td>
									</tr>

									<tr id="trProcessorMsg" runat="server" style="vertical-align: top;">
										<td align="right" width="50%" style="color: #fff">Processor Message</td>
										<td></td>
										<td width="50%">
											<asp:Label ID="Label10" runat="server" Style="color: #fff"></asp:Label></td>
									</tr>
									<tr id="trErrorCode" runat="server" style="vertical-align: top;">
										<td align="right" width="50%" style="color: #fff">Error Code</td>
										<td></td>
										<td width="50%">
											<asp:Label ID="Label11" runat="server" Style="color: #fff"></asp:Label></td>
									</tr>
									<tr id="trResult" runat="server" style="vertical-align: top;">
										<td align="right" width="50%" style="color: #fff">Transaction Result</td>
										<td></td>
										<td width="50%">
											<asp:Label ID="Label1" runat="server" Style="color: #fff"></asp:Label></td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
</body>
</html>
