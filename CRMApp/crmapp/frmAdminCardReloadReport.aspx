<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmAdminCardReloadReport.aspx.cs" Inherits="CRMApp.crmapp.frmAdminCardReloadReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <script type="text/javascript">
        function PrintReloadReport() {
            var prntData = document.getElementById('<%= pnlgridview.ClientID %>');
            var prntWindow = window.open("_self");
            prntWindow.document.write('<html><head><title>BigR - Bigr Card Reload Report</title><br/>');
            prntWindow.document.write(prntData.innerHTML);
            prntWindow.document.write('</head></html>');
            prntWindow.document.close();
            prntWindow.focus();
            prntWindow.print();
            prntWindow.close();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
<div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Reload Report</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
        </div>
        <div class="col-sm-12">
            <asp:UpdatePanel runat="server" ID="upMerchant">
                <ContentTemplate>
                    <div class="form-horizontal">
                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-4 control-label">Search By:</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtSearch" runat="server" class="form-control" placeholder="Card No/Member Name"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-4 control-label">Card Status:</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlCardStatus" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="0">-Select-</asp:ListItem>
                                            <asp:ListItem Value="Distributed">Distributed</asp:ListItem>
                                            <asp:ListItem Value="used">used</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-4 control-label">Community:</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlCommunity" runat="server" CssClass="form-control" DataValueField="community_id" DataTextField="community_name"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group alignright">
                                    <asp:Button ID="BtnSearch" CssClass="btn btn-info" OnClick="BtnSearch_Click" runat="server" Text="Search" />
                                    <asp:Button ID="btnReset" CssClass="btn btn-danger" OnClick="btnReset_Click" runat="server" Text="Reset" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <%--<asp:UpdatePanel runat="server" ID="upMerchant">
                        <ContentTemplate>--%>
                            <div class="col-md-12" style="text-align: right;">
                                <asp:LinkButton ID="lnkExportExcel" runat="server" OnClick="lnkExportExcel_Click" CssClass="btn btn-primary btn-xs" Text="Export To Excel"></asp:LinkButton>
                                <asp:LinkButton ID="lnkPrintReport" runat="server" ToolTip="Click to Print All Records" Text="Print" CssClass="btn btn-primary btn-xs" OnClick="lnkPrintReport_Click"></asp:LinkButton>
                            </div>
                            <%--  </ContentTemplate>
                    </asp:UpdatePanel>--%>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="gap gap-mini"></div>
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>
                    <asp:ListView ID="lvCard" runat="server" OnItemCommand="lvCard_ItemCommand"
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lvCard_PagePropertiesChanging" OnItemDataBound="lvCard_ItemDataBound">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 5%; text-align: center;">Card No</th>
                                        <th style="width: 10%; text-align: center;">Membership No</th>
                                        <th style="width: 15%; text-align: center;">Member Name</th>
                                        <th style="width: 10%; text-align: center;">Community Name</th>
                                        <th style="width: 10%; text-align: center;">Current Balance</th>
                                        <th style="width: 10%; text-align: center;">Last Usage</th>
                                        <th style="width: 10%; text-align: center;">Last Usage Date</th>
                                        <th style="width: 10%; text-align: center;">Registered Date</th>
                                        <th style="width: 10%; text-align: center;">Activation Date</th>
                                        <th style="width: 5%; text-align: center;">Card Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvCard" PageSize="10">
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
                                <td style="text-align: center;"><%# Eval("card_no") %></td>
                                <td style="text-align: center;"><%# Eval("membership_cardno") %></td>
                                <td style="text-align: center;"><%# Eval("member_name") %></td>
                                <td style="text-align: center;"><%# Eval("community_name") %></td>
                                <td style="text-align: center;"><%# Eval("current_balance","{0:F2}") %></td>
                                <td style="text-align: center;"><%# Eval("last_usage","{0:F2}") %></td>
                                <td style="text-align: center;"><%# Eval("last_usage_date") %></td>
                                <td style="text-align: center;"><%# Eval("reg_date") %></td>
                                <td style="text-align: center;"><%# Eval("activation_date") %></td>
                                <td style="text-align: center;"><%# Eval("used_status") %></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 5%; text-align: center;">Card No</th>
                                        <th style="width: 10%; text-align: center;">Membership No</th>
                                        <th style="width: 15%; text-align: center;">Member Name</th>
                                        <th style="width: 10%; text-align: center;">Community Name</th>
                                        <th style="width: 10%; text-align: center;">Current Balance</th>
                                        <th style="width: 10%; text-align: center;">Last Usage</th>
                                        <th style="width: 10%; text-align: center;">Last Usage Date</th>
                                        <th style="width: 10%; text-align: center;">Registered Date</th>
                                        <th style="width: 10%; text-align: center;">Activation Date</th>
                                        <th style="width: 5%; text-align: center;">Card Status</th>
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
                    <asp:Panel runat="server" ID="pnlgridview" Style="display: none">
                        <asp:GridView ID="ExportGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="card_no" HeaderText="Card No" />
                                <asp:BoundField DataField="membership_cardno" HeaderText="Membership Card No" />
                                <asp:BoundField DataField="member_name" HeaderText="Member Name" />
                                <asp:BoundField DataField="community_name" HeaderText="Community Name" />
                                <asp:BoundField DataField="current_balance" HeaderText="Current Balance" />
                                <asp:BoundField DataField="last_usage" HeaderText="Last Usage" />
                                <asp:BoundField DataField="last_usage_date" HeaderText="Last Usage Date" />
                                <asp:BoundField DataField="reg_date" HeaderText="Reg Date" />
                                <asp:BoundField DataField="activation_date" HeaderText="Activation Date" />
                                <asp:BoundField DataField="used_status" HeaderText="Card Status" />
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
