<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmCardHelpDesk.aspx.cs" Inherits="CRMApp.crmapp.frmCardHelpDesk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function PrintMemberHelpDesc() {
            var prntData = document.getElementById('<%= pnlgridview.ClientID %>');
            var prntWindow = window.open("_self");
            prntWindow.document.write('<html><head><title>BigR - Member Help desc Report</title><br/>');
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
    <asp:UpdatePanel runat="server" ID="upCard">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>BigR Card Management</h2>
                        <span id="message" runat="server" style="font-size: smaller;"></span>
                    </div>
                    <div></div>
                </div>
                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group-sm">
                                <label for="inputCommunity" class="col-sm-2 control-label">Community Name</label>
                                <div class="col-sm-2">
                                    <asp:DropDownList ID="ddlCommunity" runat="server" CssClass="form-control" DataValueField="community_id" DataTextField="community_name"></asp:DropDownList>
                                </div>
                                <label for="inputCommunity" class="col-sm-2 control-label">Card Status</label>
                                <div class="col-sm-2">
                                    <asp:DropDownList ID="ddlCardStatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="">-Select-</asp:ListItem>
                                        <asp:ListItem Value="Distributed">Distributed</asp:ListItem>
                                        <asp:ListItem Value="used">used</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-2">
                                    <asp:TextBox ID="txtSearch" runat="server" class="form-control" placeholder="Card No/Member Name"></asp:TextBox>
                                </div>
                                <div class="col-sm-2 pull-right">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div>
                        <asp:ListView ID="lvCard" runat="server" DataKeyNames="card_no" OnPagePropertiesChanging="lvCard_PagePropertiesChanging" OnItemDataBound="lvCard_ItemDataBound"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1">
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
                                    <td style="text-align: right;"><%# Container.DataItemIndex + 1 %></td>
                                    <td style="text-align: left;"><%# Eval("card_no") %></td>
                                    <td style="text-align: left;"><%# Eval("membership_cardno") %></td>
                                    <td style="text-align: left;"><%# Eval("member_name") %></td>
                                    <td style="text-align: left;"><%# Eval("community_name") %></td>
                                    <td style="text-align: right;"><%# Eval("current_balance", "{0:F2}") %></td>
                                    <td style="text-align: right;"><%# Eval("last_usage", "{0:F2}") %></td>
                                    <td style="text-align: left;"><%# Eval("last_usage_date") %></td>
                                    <td style="text-align: left;"><%# Eval("reg_date") %></td>
                                    <td style="text-align: left;"><%# Eval("activation_date") %></td>
                                    <td style="text-align: left;"><%# Eval("used_status") %></td>
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
                    </div>
                    <asp:Panel runat="server" ID="pnlgridview" Style="display: none">
                        <asp:GridView ID="ExportGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="membership_no" HeaderText="Membership No" SortExpression="Membership No" />
                                <asp:BoundField DataField="user_fistname" HeaderText="First Name" SortExpression="First Name" />
                                <asp:BoundField DataField="user_lastname" HeaderText="Last Name" SortExpression="Last Name" />
                                <asp:BoundField DataField="mobile_no" HeaderText="Mobile Phone" SortExpression="Mobile No" />
                                <asp:BoundField DataField="email_id" HeaderText="Email" SortExpression="Email" />
                                <asp:BoundField DataField="state_name" HeaderText="State" SortExpression="State" />
                                <asp:BoundField DataField="joined_date" HeaderText="Joined Date" SortExpression="Joined Date" />
                                <asp:BoundField DataField="updated_date" HeaderText="Update Date" SortExpression="Update Date" />
                                <asp:BoundField DataField="updated_by" HeaderText="updated By" SortExpression="Update By" />
                                <%--  <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" />--%>
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
                    <%-- <input type="button" value="Print" runat="server" onclick="Print();" />--%>
                    <%-- <asp:Button ID="btnPrint" runat="server" Text="Print" OnClientClick="Print();" />--%>
                </div>
            </div>
        </ContentTemplate>
        <%--<Triggers>
            <asp:PostBackTrigger ControlID="lnkexport" />
      </Triggers>--%>
    </asp:UpdatePanel>
</asp:Content>
