<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmQrPayMerchNormalUserReport.aspx.cs" Inherits="CRMApp.crmapp.frmQrPayMerchNormalUserReport" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function PrintPromotionVoucherList() {
            var prntData = document.getElementById('<%= pnlGrdPromotionVoucher.ClientID %>');
            var prntWindow = window.open("_self");
            prntWindow.document.write('<html><head><title>QR PAY User Report</title><br/>');
            prntWindow.document.write(prntData.innerHTML);
            prntWindow.document.write('</head></html>');
            prntWindow.document.close();
            prntWindow.focus();
            prntWindow.print();
            prntWindow.close();
        }

</script>
</asp:Content>
<asp:Content ID="CtQrPayMerchReport" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>QR Pay User Report</h2>
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
                                <asp:TextBox ID="txtQrPayDateRange" runat="server" CssClass="form-control startdate" placeholder="Date Range"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                        <ContentTemplate>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-4 control-label">Transaction Status</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlTransactionStatus" CssClass="form-control" AutoPostBack="true" runat="server">
                                            <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                            <asp:ListItem Value="SUCCESSFUL" Text="SUCCESSFUL"></asp:ListItem>
                                            <asp:ListItem Value="DECLINED" Text="DECLINED"></asp:ListItem>
                                            <%--<asp:ListItem Value="FAILED" Text="FAILED"></asp:ListItem>
                                            <asp:ListItem Value="PENDING" Text="PENDING"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <asp:Button ID="BtnSearch" CssClass="btn btn-info" OnClick="BtnSearch_Click" runat="server" Text="Search" />
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
                    <asp:ListView ID="lvMerchOutletReport" runat="server" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lvMerchOutletReport_PagePropertiesChanging" OnItemDataBound="lvMerchOutletReport_ItemDataBound">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 2%; text-align: center;">No</th>
                                        <th style="width: 15%; text-align: center;">Transaction Date</th>
                                        <th style="width: 10%; text-align: center;">Membership ID</th>
                                        <th style="width: 15%; text-align: left;">Member Name</th>
                                        <th style="width: 15%; text-align: left;">Merchant</th>
                                        <th style="width: 15%; text-align: left;">Outlet</th>
                                        <th style="width: 8%; text-align: center;">Transaction No</th>
                                        <th style="width: 12%; text-align: center;">Amount (RM)</th>
                                        <th style="width: 8%; text-align: center;">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvMerchOutletReport" PageSize="10">
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
                                <td style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                <td style="text-align: center;"><%# Eval("transaction_date") %></td>
                                <td style="text-align: center;"><%# Eval("membership_no").ToString().Trim() %></td>
                                <td style="text-align: left;"><%# Eval("member_name") %></td>
                                <td style="text-align: left;"><%# Eval("organization_name") %></td>
                                <td style="text-align: left;"><%# Eval("branch_name") %></td>
                                <td style="text-align: center;"><%# Eval("transaction_id") %></td>
                                <td style="text-align: center;"><%# Eval("trans_amount") %></td>
                                <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("transaction_status") %></span></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 2%; text-align: center;">No</th>
                                        <th style="width: 15%; text-align: center;">Transaction Date</th>
                                        <th style="width: 10%; text-align: center;">Membership ID</th>
                                        <th style="width: 15%; text-align: left;">Member Name</th>
                                        <th style="width: 15%; text-align: left;">Merchant</th>
                                        <th style="width: 15%; text-align: left;">Outlet</th>
                                        <th style="width: 8%; text-align: center;">Transaction No</th>
                                        <th style="width: 12%; text-align: center;">Amount (RM)</th>
                                        <th style="width: 8%; text-align: center;">Status</th>
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
                    <asp:Panel runat="server" ID="pnlGrdPromotionVoucher" Style="display: none">
                        <asp:GridView ID="ExportGrdPromotionVoucher" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:TemplateField HeaderText="No">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="transaction_date" HeaderText="Transaction Date" />
                                <asp:BoundField DataField="membership_no" HeaderText="Membership ID" />
                                <asp:BoundField DataField="member_name" HeaderText="Member Name" />
                                <asp:BoundField DataField="organization_name" HeaderText="Merchant" />
                                <asp:BoundField DataField="branch_name" HeaderText="Outlet" />
                                <asp:BoundField DataField="transaction_id" HeaderText="Transaction No" />
                                <asp:BoundField DataField="trans_amount" HeaderText="Transaction Amount (RM)" />
                                <asp:BoundField DataField="transaction_status" HeaderText="Transaction Status" />
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