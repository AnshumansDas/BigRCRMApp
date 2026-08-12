<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMerchantHelpdesk.aspx.cs" Inherits="CRMApp.crmapp.frmMerchantHelpdesk" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content runat="server" ID="cMerchantcontent" ContentPlaceHolderID="head">
    <script type="text/javascript">
        function PrintMerchantHelpdesc() {
            var prntData = document.getElementById('<%= pnlGrdMerchanthelpdesc.ClientID %>');
            var prntWindow = window.open("_self");
            prntWindow.document.write('<html><head><title>BigR - Merchant Help desc Report</title><br/>');
            prntWindow.document.write(prntData.innerHTML);
            prntWindow.document.write('</head></html>');
            prntWindow.document.close();
            prntWindow.focus();
            prntWindow.print();
            prntWindow.close();
        }
    </script>
</asp:Content>
<asp:Content runat="server" ID="cMerchant" ContentPlaceHolderID="body">
    <asp:UpdatePanel runat="server" ID="upMerchant">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Merchant Helpdesk</h2>
                        <span id="message" runat="server" style="font-size: smaller;"></span>
                    </div>
                    <div></div>
                </div>
                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                                <div class="search-box">
                                    <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" class="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                    <i class="fa fa-search"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6" style="text-align: right; margin-top: 10px;">
                            <asp:LinkButton ID="lnkMerchantdescPrint" runat="server" ToolTip="Click to Print All Records" Text="Print Data" CssClass="btn btn-primary btn-xs" OnClick="lnkMerchantdescPrint_Click"></asp:LinkButton>
                            <asp:LinkButton ID="lnkMerchantdescexport" runat="server" OnClick="lnkMerchantdescexport_click" CssClass="btn btn-primary btn-xs" Text="Export To Excel"></asp:LinkButton>
                        </div>
                    </div>
                    <div>
                        <asp:ListView ID="Lv_Merchant" runat="server" DataKeyNames="merchant_code, email" OnItemCommand="Lv_Merchant_ItemCommand"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="Lv_Merchant_PagePropertiesChanging" OnItemDataBound="Lv_Merchant_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 10%; text-align: center;">Registration No</th>
                                            <th style="width: 25%;">Merchant Name</th>
                                            <th style="width: 10%; text-align: center;">PIC</th>
                                            <th style="width: 10%; text-align: center;">Email</th>
                                            <th style="width: 10%; text-align: center;">Fees Category</th>
                                            <th style="width: 10%; text-align: center;">Update Date</th>
                                            <th style="width: 10%; text-align: center;">Update By</th>
                                            <th style="width: 10%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="Lv_Merchant" PageSize="10">
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
                                    <td style="text-align: center;"><%# Eval("merchant_number") %></td>
                                    <td><%# Eval("organization_name").ToString().Trim() %></td>
                                    <td style="text-align: center;"><%# Eval("person_incharge") %></td>
                                    <td style="text-align: center;"><%# Eval("email") %></td>
                                    <td style="text-align: center;"><%# Eval("fees_category") %></td>
                                    <td style="text-align: center;"><%# Eval("updated_date") %></td>
                                    <td style="text-align: center;"><%# Eval("updated_by") %></td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkResetPassword" runat="server" ToolTip="Reset Password" CssClass="btn btn-primary btn-xs" CommandName="Edit">Reset Password</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 10%; text-align: center;">Registration No</th>
                                            <th style="width: 25%;">Merchant Name</th>
                                            <th style="width: 10%; text-align: center;">PIC</th>
                                            <th style="width: 10%; text-align: center;">Email</th>
                                            <th style="width: 10%; text-align: center;">Fees Category</th>
                                            <th style="width: 10%; text-align: center;">Update Date</th>
                                            <th style="width: 10%; text-align: center;">Update By</th>
                                            <th style="width: 10%; text-align: center;">Action</th>
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
                    <asp:Panel runat="server" ID="pnlGrdMerchanthelpdesc" Style="display: none">
                        <asp:GridView ID="ExportGrdMerchanthelpdesc" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:TemplateField HeaderText="No" ItemStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="merchant_number" HeaderText="Registration No" SortExpression="Registration No" />
                                <asp:BoundField DataField="organization_name" HeaderText="Merchant Name" SortExpression="Merchant Name" />
                                <asp:BoundField DataField="person_incharge" HeaderText="PIC" SortExpression="PIC" />
                                <asp:BoundField DataField="email" HeaderText="Email" SortExpression="Email" />
                                <asp:BoundField DataField="fees_category" HeaderText="Fees Category" SortExpression="Fees Category" />
                                <asp:BoundField DataField="updated_date" HeaderText="Update Date" SortExpression="Update Date" />
                                <asp:BoundField DataField="updated_by" HeaderText="Update By" SortExpression="Update By" />
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
        <Triggers>
            <asp:PostBackTrigger ControlID="lnkMerchantdescexport" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
