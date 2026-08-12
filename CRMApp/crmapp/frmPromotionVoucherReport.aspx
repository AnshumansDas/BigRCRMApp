<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmPromotionVoucherReport.aspx.cs" Inherits="CRMApp.crmapp.frmPromotionVoucherReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function PrintPromotionVoucherList() {
            var prntData = document.getElementById('<%= pnlGrdPromotionVoucher.ClientID %>');
            var prntWindow = window.open("_self");
            prntWindow.document.write('<html><head><title>BigR - Promotion Voucher Report</title><br/>');
            prntWindow.document.write(prntData.innerHTML);
            prntWindow.document.write('</head></html>');
            prntWindow.document.close();
            prntWindow.focus();
            prntWindow.print();
            prntWindow.close();
        }

    </script>
</asp:Content>
<asp:Content ID="CtPromotionVoucher" ContentPlaceHolderID="body" runat="server">

    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Promotion Voucher Report</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
            <div></div>
        </div>
        <div class="col-sm-12">
            <div class="row">
                <div class="col-md-5">
                    <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                        <div class="search-box">
                            <asp:TextBox ID="txtMerchantName" runat="server" CssClass="form-control input-sm active-part" OnTextChanged="txtVoucherSearch_TextChanged" placeholder="Enter your search key ... "></asp:TextBox>
                            <i class="fa fa-search"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4" style="text-align: left; margin-top: 16px;">
                    <asp:TextBox ID="txtVoucherDateRange" runat="server" CssClass="form-control startdate" placeholder="Date Range"></asp:TextBox>
                </div>
                <asp:UpdatePanel runat="server" ID="upMerchant">
                    <ContentTemplate>
                        <div class="col-md-3" style="text-align: right; margin-top: 16px;">
                            <asp:Button ID="BtnSearch" CssClass="btn btn-primary btn-xs" OnClick="BtnSearch_Click" runat="server" Text="Search" />
                            <asp:LinkButton ID="lnkPrintpromotion" runat="server" ToolTip="Click to Print All Records" Text="Print Data" CssClass="btn btn-primary btn-xs" OnClick="lnkPrintpromotions_Click"></asp:LinkButton>
                            <asp:LinkButton ID="lnkexportpromotion" runat="server" OnClick="lnkexportpromotions_Click" CssClass="btn btn-primary btn-xs" Text="Export To Excel"></asp:LinkButton>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="gap gap-mid"></div>
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>
                    <div>
                        <asp:ListView ID="Lv_PrVoucherReport" runat="server" DataKeyNames="Voucher_Id" OnItemCommand="Lv_PrVoucherReport_ItemCommand"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="Lv_PrVoucherReport_PagePropertiesChanging" OnItemDataBound="Lv_PrVoucherReport_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 2%; text-align: left;">No</th>
                                            <th style="width: 10%; text-align: left;">Date Created</th>
                                            <th style="width: 10%;">Voucher Name</th>
                                            <th style="width: 15%;">Merchant Name</th>
                                            <th style="width: 5%; text-align: left;">Status</th>
                                            <th style="width: 5%; text-align: left;">Receipt No</th>
                                            <th style="width: 10%; text-align: left;">Purchase By</th>
                                            <th style="width: 10%; text-align: left;">Transaction Date</th>
                                            <th style="width: 5%; text-align: left;">Transaction Amount</th>
                                            <th style="width: 5%; text-align: left;">Payment Status</th>
                                            <th style="width: 10%; text-align: left;">Voucher Code</th>
                                            <th style="width: 5%; text-align: left;">Voucher Category</th>
                                            <th style="width: 5%; text-align: left;">Redeemed Date</th>
                                            <th style="width: 5%; text-align: left;">Redeemed Outlet</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="Lv_PrVoucherReport" PageSize="10">
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
                                    <td style="text-align: left;"><%# Container.DataItemIndex + 1 %></td>
                                    <td style="text-align: left;"><%# Eval("Created_Date") %></td>
                                    <td><%# Eval("Voucher_name").ToString().Trim() %></td>
                                    <td style="text-align: left;"><%# Eval("Merchant_Name") %></td>
                                    <td style="text-align: left;"><%# Eval("Status") %></td>
                                    <td style="text-align: left;"><%# Eval("Receipt_no") %></td>
                                    <td style="text-align: left;"><%# Eval("Purchased_By") %></td>
                                    <td style="text-align: left;"><%# Eval("Transaction_Date") %></td>
                                    <td style="text-align: left;"><%# Eval("Trans_Amount") %></td>
                                    <td style="text-align: left;"><%# Eval("Payment_Status") %></td>
                                    <td style="text-align: left;"><%# Eval("Voucher_Code") %></td>
                                    <td style="text-align: left;"><%# Eval("voucher_main_category") %></td>
                                    <td style="text-align: left;"><%# Eval("Redeemed_Date") %></td>
                                    <td style="text-align: left;"><%# Eval("Redeemed_Outlet") %></td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 2%; text-align: left;">No</th>
                                            <th style="width: 10%; text-align: left;">Date Created</th>
                                            <th style="width: 10%;">Voucher Name</th>
                                            <th style="width: 15%;">Merchant Name</th>
                                            <th style="width: 5%; text-align: left;">Status</th>
                                            <th style="width: 5%; text-align: left;">Receipt No</th>
                                            <th style="width: 10%; text-align: left;">Purchase By</th>
                                            <th style="width: 10%; text-align: left;">Transaction Date</th>
                                            <th style="width: 5%; text-align: left;">Transaction Amount</th>
                                            <th style="width: 5%; text-align: left;">Payment Status</th>
                                            <th style="width: 10%; text-align: left;">Voucher Code</th>
                                            <th style="width: 5%; text-align: left;">Voucher Category</th>
                                            <th style="width: 5%; text-align: left;">Redeemed Date</th>
                                            <th style="width: 5%; text-align: left;">Redeemed Outlet</th>
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
                    </div>
                    <asp:Panel runat="server" ID="pnlGrdPromotionVoucher" Style="display: none">
                        <asp:GridView ID="ExportGrdPromotionVoucher" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <%-- <asp:BoundField DataField="Created_Date" HeaderText="Date Created" SortExpression="Date Created" />--%>
                                <asp:BoundField DataField="Voucher_name" HeaderText="Voucher Name" SortExpression="Voucher Name" />
                                <asp:BoundField DataField="Merchant_Name" HeaderText="Merchant Name" SortExpression="Merchant Name" />
                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                <asp:BoundField DataField="Receipt_no" HeaderText="Receipt No" SortExpression="Receipt No" />
                                <asp:BoundField DataField="Purchased_By" HeaderText="Purchase By" SortExpression="Purchase By" />
                                <asp:BoundField DataField="Transaction_Date" HeaderText="Transaction Date" SortExpression="Transaction Date" />
                                <asp:BoundField DataField="Trans_Amount" HeaderText="Transaction Amount" SortExpression="Transaction Amount" />
                                <asp:BoundField DataField="Payment_Status" HeaderText="Payment Status" SortExpression="Payment Status" />
                                <asp:BoundField DataField="Voucher_Code" HeaderText="Voucher Code" SortExpression="Voucher Code" />
                                <%-- <asp:BoundField DataField="voucher_main_category" HeaderText="Voucher Category" SortExpression="Voucher Category" />                                --%>
                                <asp:BoundField DataField="Redeemed_Date" HeaderText="Redeemed Date" SortExpression="Redeemed Date" />
                                <asp:BoundField DataField="Redeemed_Outlet" HeaderText="Redeemed Outlet" SortExpression="Redeemed Outlet" />
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
    </div>
    </div>
    </ContentTemplate>
      <triggers>
            <asp:PostBackTrigger ControlID="lnkexportpromotion" />
          <%-- <asp:PostBackTrigger ControlID="lnkPrint" />--%>
        </triggers>
    </asp:UpdatePanel>
</asp:Content>
