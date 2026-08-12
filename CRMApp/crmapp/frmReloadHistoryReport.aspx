<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmReloadHistoryReport.aspx.cs" Inherits="CRMApp.crmapp.frmReloadHistoryReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function PrintReloadHistoryRptList() {
            var prntData = document.getElementById('<%= pnlGrdReloadHistReport.ClientID %>');
            var prntWindow = window.open("_self");
            prntWindow.document.write('<html><head><title>BigR - Reload History Report</title><br/>');
            prntWindow.document.write(prntData.innerHTML);
            prntWindow.document.write('</head></html>');
            prntWindow.document.close();
            prntWindow.focus();
            prntWindow.print();
            prntWindow.close();
        }

    </script>
</asp:Content>
<asp:Content ID="CtReloadHistoryReport" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Reload History Report</h2>
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
                                <asp:TextBox ID="txtReloadHistoryDateRange" runat="server" CssClass="form-control startdate" placeholder="Date Range"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                        <ContentTemplate>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-4 control-label">Card No</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="TxtSearchBy" runat="server" CssClass="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <asp:Button ID="BtnSearch" CssClass="btn btn-info" OnClick="BtnSearch_Click" runat="server" Text="Search" />
                                    <asp:Button ID="btnReset" OnClick="btnReset_Click" CssClass="btn btn-danger" runat="server" Text="Reset" />
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="row">
                    <asp:UpdatePanel runat="server" ID="upMerchant">
                        <ContentTemplate>
                            <div class="col-md-12" style="text-align: right;">
                                <asp:LinkButton ID="LbPrintReloadHist" runat="server" OnClick="LbPrintReloadHist_Click" ToolTip="Print Data" CssClass="btn btn-primary btn-xs" Text="Print Data"></asp:LinkButton>
                                <asp:LinkButton ID="LBExportReloadHist" runat="server" ToolTip="Export To Excel" Text="Export to Excel" CssClass="btn btn-primary btn-xs" OnClick="LBExportReloadHist_Click"></asp:LinkButton>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="gap gap-mini"></div>
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>
                    <asp:ListView ID="Lv_ReloadHistoryReport" runat="server" DataKeyNames="topup_id" OnItemCommand="Lv_ReloadHistoryReport_ItemCommand"
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="Lv_ReloadHistoryReport_PagePropertiesChanging" OnItemDataBound="Lv_ReloadHistoryReport_ItemDataBound">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" style="font-size:12px;" class="label label-primary"></span></label>
                            </div>
                            <div>&nbsp;</div>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Transaction Amount : <span id="totaltransactionAmount" runat="server" style="font-size:12px;" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 2%; text-align: left;">No</th>
                                        <th style="width: 10%; text-align: left;">RFID Tag No</th>
                                        <th style="width: 10%;">Bank Name</th>
                                        <th style="width: 15%;">Card No</th>
                                        <th style="width: 10%; text-align: left;">Order No</th>
                                        <th style="width: 15%; text-align: left;">Transaction No</th>
                                        <th style="width: 5%; text-align: left;">Transaction Amount</th>
                                        <th style="width: 10%; text-align: left;">Transaction Date</th>
                                        <th style="width: 10%; text-align: left;">Transaction Mode</th>
                                        <th style="width: 10%; text-align: left;">Transaction Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PageSize="10" PagedControlID="Lv_ReloadHistoryReport">
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
                                <td style="text-align: left;"><%# Eval("RFID_TAGNO") %></td>
                                <td><%# Eval("BANK_NAME").ToString().Trim() %></td>
                                <td style="text-align: left;"><%# Eval("CARDNO") %></td>
                                <td style="text-align: left;"><%# Eval("ORDERNO") %></td>
                                <td style="text-align: left;"><%# Eval("TRANSACTION_NO") %></td>
                                <td style="text-align: left;">
                                    <asp:Label ID="LblTransactionAmount" runat="server" Text='<%# Eval("TRANSACTION_AMOUNT","{0:F2}") %>'></asp:Label></td>
                                <td style="text-align: left;"><%# Eval("TRANSACTION_DATE") %></td>
                                <td style="text-align: left;"><%# Eval("TRANSACTION_MODE") %></td>
                                <td style="text-align: left;"><%# Eval("TRANSACTION_STATUS") %></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 2%; text-align: left;">No</th>
                                        <th style="width: 10%; text-align: left;">RFID Tag No</th>
                                        <th style="width: 10%;">Bank Name</th>
                                        <th style="width: 15%;">Card No</th>
                                        <th style="width: 10%; text-align: left;">Order No</th>
                                        <th style="width: 15%; text-align: left;">Transaction No</th>
                                        <th style="width: 5%; text-align: left;">Transaction Amount</th>
                                        <th style="width: 10%; text-align: left;">Transaction Date</th>
                                        <th style="width: 10%; text-align: left;">Transaction Mode</th>
                                        <th style="width: 10%; text-align: left;">Transaction Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="10" style="text-align: center;">No Reload History record found!
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </EmptyDataTemplate>
                    </asp:ListView>
                    <asp:Panel runat="server" ID="pnlGrdReloadHistReport" Style="display: none">
                        <asp:GridView ID="GVReloadHistory" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="Sno" HeaderText="Sno" />
                                <asp:BoundField DataField="RFID_TAGNO" HeaderText="RFID Tag No" />
                                <asp:BoundField DataField="BANK_NAME" HeaderText="Bank Name" />
                                <asp:BoundField DataField="CARDNO" HeaderText="Card No" />
                                <asp:BoundField DataField="ORDERNO" HeaderText="Order No" />
                                <asp:BoundField DataField="TRANSACTION_NO" HeaderText="Transaction No" />
                                <asp:BoundField DataField="TRANSACTION_AMOUNT" HeaderText="Transaction Amount" />
                                <asp:BoundField DataField="TRANSACTION_DATE" HeaderText="Transaction Date" />
                                <asp:BoundField DataField="TRANSACTION_MODE" HeaderText="Transaction Mode" />
                                <asp:BoundField DataField="TRANSACTION_STATUS" HeaderText="Transaction Status" />
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
                    <asp:PostBackTrigger ControlID="LBExportReloadHist" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
