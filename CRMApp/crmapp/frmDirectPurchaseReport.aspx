<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmDirectPurchaseReport.aspx.cs" Inherits="CRMApp.crmapp.frmDirectPurchaseReport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function PrintDirectPurchaseReportList() {
            var prntData = document.getElementById('<%= pnlGrdDirectPurchReport.ClientID %>');
            var prntWindow = window.open("_self");
            prntWindow.document.write('<html><head><title>QR Pay Merchant Report</title><br/>');
            prntWindow.document.write(prntData.innerHTML);
            prntWindow.document.write('</head></html>');
            prntWindow.document.close();
            prntWindow.focus();
            prntWindow.print();
            prntWindow.close();
        }

    </script>
</asp:Content>
<asp:Content ID="CtDirectPurchaseReport" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>QR Pay Merchant Report</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
        </div>
        <div class="col-sm-12">
            <div class="form-horizontal">
                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-4 control-label">Date Range</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtDirectPurchDateRange" runat="server" CssClass="form-control startdate" placeholder="Date Range"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-4 control-label">Transaction Status</label>
                            <div class="col-sm-8">
                                <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlTransactionStatus" CssClass="form-control" AutoPostBack="true" runat="server">
                                            <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                            <asp:ListItem Value="SUCCESSFUL" Text="SUCCESSFUL"></asp:ListItem>
                                            <asp:ListItem Value="DECLINED" Text="DECLINED"></asp:ListItem>
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                        <ContentTemplate>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-4 control-label">Merchant</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlMerchName" CssClass="form-control" OnSelectedIndexChanged="ddlMerchName_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-4 control-label">Outlet</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlOutlet" CssClass="form-control" AutoPostBack="true" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <asp:Button ID="BtnSearch" CssClass="btn btn-info" OnClick="BtnSearch_Click" runat="server" Text="Search" />
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="btnReset" CssClass="btn btn-danger" OnClick="btnReset_Click" runat="server" Text="Reset" />
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="row">
                    <asp:UpdatePanel runat="server" ID="upMerchant">
                        <ContentTemplate>
                            <div class="col-md-12" style="text-align: right;">
                                <asp:LinkButton ID="lnkExportExcel" runat="server" OnClick="lnkExportExcel_Click" CssClass="btn btn-primary btn-xs" Text="Export To Excel"></asp:LinkButton>
                                <asp:LinkButton ID="lnkPrintQrPayReport" runat="server" ToolTip="Click to Print All Records" Text="Print" CssClass="btn btn-primary btn-xs" OnClick="lnkPrintQrPayReport_Click"></asp:LinkButton>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="gap gap-mini"></div>
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>
                    <asp:ListView ID="lvDirectPurchReport" runat="server" OnItemCommand="lvDirectPurchReport_ItemCommand"
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lvDirectPurchReport_PagePropertiesChanging" OnItemDataBound="lvDirectPurchReport_ItemDataBound">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <div>&nbsp;</div>
                            <div class="row">
                                <label class="col-sm-4 text-right">Total Transaction Amount : <span id="totaltransactionAmount" runat="server" style="font-size: 12px;" class="label label-primary"></span></label>
                                <label class="col-sm-4 text-right">Total MDR Settlement Amount : <span id="totalMDRSettlmtAmt" runat="server" style="font-size: 12px;" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 2%; text-align: left;">No</th>
                                        <th style="width: 8%; text-align: left;">Transaction No</th>
                                        <th style="width: 10%; text-align: left;">Transaction Date</th>
                                        <th style="width: 10%; text-align: left;">Membership ID</th>
                                        <th style="width: 10%; text-align: left;">Member Name</th>
                                        <th style="width: 15%; text-align: left;">Merchant</th>
                                        <%--<th style="width: 10%; text-align: left;">Outlet</th>--%>
                                        <th style="width: 10%; text-align: left;">Payment Status</th>
                                        <th style="width: 8%; text-align: left;">Transaction Amount</th>
                                        <th style="width: 5%; text-align: left;">MDR Charge Type</th>
                                        <th style="width: 6%; text-align: left;">MDR Settlement  Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvDirectPurchReport" PageSize="10">
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
                                <%-- <td style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                <td style="text-align: center;"><%# Eval("transaction_date") %></td>
                                <td style="text-align: center;"><%# Eval("membership_no").ToString().Trim() %></td>
                                <td style="text-align: left;"><%# Eval("member_name") %></td>
                                <td style="text-align: left;"><%# Eval("organization_name") %></td>
                                <td style="text-align: left;"><%# Eval("branch_name") %></td>
                                <td style="text-align: center;"><%# Eval("transaction_id") %></td>
                                <td style="text-align: center;"><%# Eval("trans_amount") %></td>
                                <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("transaction_status") %></span></td>--%>
                                <td style="text-align: left;"><%# Container.DataItemIndex + 1 %></td>
                                <td style="text-align: left;"><%# Eval("transaction_id") %></td>
                                <td style="text-align: left;"><%# Eval("transaction_date") %></td>
                                <td style="text-align: left;"><%# Eval("membership_no").ToString().Trim() %></td>
                                <td style="text-align: left;"><%# Eval("member_name") %></td>
                                <td style="text-align: left;"><%# Eval("organization_name") %></td>
                                <%--<td style="text-align: left;"><%# Eval("branch_name") %></td>--%>
                                <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("transaction_status") %></span></td>
                                <td style="text-align: left;"><%# Eval("trans_amount","{0:F2}") %></td>
                                <td style="text-align: left;"><%# Eval("mdr_charges_type") %></td>
                                <%-- <td style="text-align: left;"><%# Eval("mdr_collection_amount","{0:F2}") %></td>--%>
                                <td style="text-align: left;"><%# Eval("mdr_settlement_amount","{0:F2}") %></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 2%; text-align: left;">No</th>
                                        <th style="width: 8%; text-align: left;">Transaction No</th>
                                        <th style="width: 10%; text-align: left;">Transaction Date</th>
                                        <th style="width: 10%; text-align: left;">Membership ID</th>
                                        <th style="width: 10%; text-align: left;">Member Name</th>
                                        <th style="width: 15%; text-align: left;">Merchant</th>
                                        <%--  <th style="width: 10%; text-align: left;">Outlet</th>--%>
                                        <th style="width: 10%; text-align: left;">Payment Status</th>
                                        <th style="width: 8%; text-align: left;">Transaction Amount</th>
                                        <th style="width: 5%; text-align: left;">MDR Charge Type</th>
                                        <%--<th style="width: 6%; text-align: left;">MDR Collection Amount</th>--%>
                                        <th style="width: 6%; text-align: left;">MDR Settlment  Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="10" style="text-align: center;">No record found!
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </EmptyDataTemplate>
                    </asp:ListView>
                    <asp:Panel runat="server" ID="pnlGrdDirectPurchReport" Style="display: none">
                        <asp:GridView ID="GVDirectPurRpt" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:TemplateField HeaderText="No">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="transaction_id" HeaderText="Transaction No" />
                                <asp:BoundField DataField="transaction_date" HeaderText="Transaction Date" />
                                <asp:BoundField DataField="membership_no" HeaderText="Membership ID" />
                                <asp:BoundField DataField="member_name" HeaderText="Member Name" />
                                <asp:BoundField DataField="organization_name" HeaderText="Merchant" />
                                <asp:BoundField DataField="transaction_status" HeaderText="Transaction Status" />
                                <asp:BoundField DataField="trans_amount" HeaderText="Transaction Amount (RM)" />
                                <asp:BoundField DataField="mdr_charges_type" HeaderText="MDR Charges Type" />
                                <asp:BoundField DataField="mdr_settlement_amount" HeaderText="MDR Settlement Amount (RM)" />

                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </asp:Panel>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="lnkExportExcel" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
