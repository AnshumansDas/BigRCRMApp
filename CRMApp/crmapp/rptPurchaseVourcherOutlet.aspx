<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rptPurchaseVourcherOutlet.aspx.cs" Inherits="CRMApp.crmapp.rptPurchaseVourcherOutlet" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <!--col-md-3-->
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Purchase Voucher Report Outlet</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
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
                <div class="col-md-4" style="text-align: left; margin-top: 16px;">
                    <asp:TextBox ID="txtDateRange" runat="server" CssClass="startdate form-control" placeholder="Date Range"></asp:TextBox>
                </div>
                <div class="col-md-2" style="text-align: right; margin-top: 16px;">
                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click" />
                </div>
            </div>
            <div class="gap-mid"></div>
            <div>
                <div class="panel panel-default panel-box addtocart">
                    <div class="panel-body">
                        <div class="table-responsive">
                            <asp:ListView ID="LstVoucherTransaction" runat="server" DataKeyNames="id" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1"
                                OnItemDataBound="LstVoucherTransaction_ItemDataBound" OnPagePropertiesChanging="LstVoucherTransaction_PagePropertiesChanging">
                                <LayoutTemplate>
                                    <div class="row">
                                        <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                    </div>
                                    <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                        <thead class="cf">
                                            <tr>
                                                <th>Sl No</th>
                                                <th>DATE CREATED</th>
                                                <th>VOUCHER NAME</th>
                                                <th>PURCHASED BY</th>
                                                <th>TRANSACTION DATE</th>
                                                <th>TRANSACTION ID</th>
                                                <th>TRANSACTION AMOUNT</th>
                                                <th>TRANSACTION STATUS</th>
                                                <th>VOUCHER CODE</th>
                                                <th>VOUCHER CATEGORY</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <div class="row">
                                        <div class="gap gap-small"></div>
                                        <div class="col-md-12 text-right">
                                            <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="LstVoucherTransaction" PageSize="10">
                                                <Fields>
                                                    <asp:NextPreviousPagerField PreviousPageText="&laquo;" FirstPageText="|<" ShowPreviousPageButton="true"
                                                        ShowFirstPageButton="true" ShowNextPageButton="false" ShowLastPageButton="false"
                                                        ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                                    <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary" RenderNonBreakingSpacesBetweenControls="false"
                                                        NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                                                    <asp:NextPreviousPagerField NextPageText="&raquo;" LastPageText=">|" ShowNextPageButton="true"
                                                        ShowLastPageButton="true" ShowPreviousPageButton="false" ShowFirstPageButton="false"
                                                        ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                                </Fields>
                                            </asp:DataPager>
                                        </div>
                                    </div>
                                </LayoutTemplate>

                                <GroupTemplate>
                                    <tr>
                                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                    </tr>
                                </GroupTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td align="center"><%# Container.DataItemIndex + 1 %></td>
                                        <td><%# Eval("created_date") %></td>
                                        <td><%# Eval("voucher_name") %></td>
                                        <td><%# Eval("user_fistname") %></td>
                                        <td><%# Eval("transaction_date") %></td>
                                        <td><%# Eval("order_no") %></td>
                                        <td><%# Eval("total_amount") %></td>
                                        <td><%# Eval("Paymentstatus") %></td>
                                        <td><%# Eval("voucher_code") %></td>
                                        <td><%# Eval("voucher_main_category") %></td>
                                    </tr>
                                </ItemTemplate>

                                <EmptyDataTemplate>
                                    <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                        <thead class="cf">
                                            <tr>
                                                <th>Sl No</th>
                                                <th>DATE CREATED</th>
                                                <th>VOUCHER NAME</th>
                                                <th>PURCHASED BY</th>
                                                <th>TRANSACTION DATE</th>
                                                <th>TRANSACTION ID</th>
                                                <th>TRANSACTION AMOUNT</th>
                                                <th>TRANSACTION STATUS</th>
                                                <th>VOUCHER CODE</th>
                                                <th>VOUCHER CATEGORY</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td colspan="10" align="center">No Transaction record found!
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </div>
                    </div>
                    <div class="panel panel-default panel-box addtocart">
                        <div class="panel-body">
                            <table class="table table-checkout-final">
                                <tbody>
                                    <tr>
                                        <td colspan="7"></td>
                                        <td style="text-align: right">Total Transaction</td>
                                        <td>RM
                                                            <asp:Label ID="lblSubTotal" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>

                <asp:GridView ID="gvVoucherList" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" Visible="false"
                    EmptyDataText="No Records were found." PageSize="10" Width="100%" AllowPaging="true" CssClass="table table-striped table-bordered table-hover">
                    <Columns>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-Font-Underline="false" ItemStyle-Width="50">
                            <HeaderTemplate>
                                <asp:Label ID="lblID" runat="server" Text="No"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="created_date" HeaderText="DATE CREATED" ItemStyle-Width="120" />
                        <asp:BoundField DataField="voucher_name" HeaderText="VOUCHER NAME" ItemStyle-Width="100" />
                        <asp:BoundField DataField="user_fistname" HeaderText="PURCHASED BY" ItemStyle-Width="120" />
                        <asp:BoundField DataField="transaction_date" HeaderText="TRANSACTION DATE" ItemStyle-Width="120" />
                        <asp:BoundField DataField="order_no" HeaderText="ORDER NO" ItemStyle-Width="120" />
                        <asp:BoundField DataField="total_amount" HeaderText="TRANSACTION AMOUNT" ItemStyle-Width="120" />
                        <asp:BoundField DataField="Paymentstatus" HeaderText="TRANSACTION STATUS" ItemStyle-Width="120" />
                        <asp:BoundField DataField="voucher_code" HeaderText="VOUCHER CODE" ItemStyle-Width="120" />
                        <asp:BoundField DataField="voucher_main_category" HeaderText="VOUCHER CATEGORY" ItemStyle-Width="120" />
                    </Columns>
                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                    <SelectedRowStyle BackColor="Aquamarine" ForeColor="Blue" Font-Bold="True" />
                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" Font-Size="12px" />
                    <PagerTemplate>
                        <table id="pagerOuterTable" class="pagerOuterTable" runat="server">
                            <tr>
                                <td>
                                    <table id="pagerInnerTable" cellpadding="2" cellspacing="1" runat="server">
                                        <tr>
                                            <td class="pageCounter"><font color="purple">Page</font>
                                                <asp:TextBox ID="txtPageNumber" runat="server" Width="15px" CssClass="pageAlign"></asp:TextBox>
                                                <font color="purple">of</font>
                                                <asp:Label ID="lblPageCount" runat="server" ForeColor="Purple"></asp:Label>
                                            </td>
                                            <td class="pageFirstLast">
                                                <asp:ImageButton ID="imgFirst" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/first.gif" />&nbsp;
                                                                        <asp:LinkButton ID="btnFirst" CssClass="pagerLink" runat="server" CommandName="Page" CommandArgument="First">First</asp:LinkButton>
                                            </td>
                                            <td class="pagePrevNextNumber">
                                                <asp:ImageButton ID="btnPrevious" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/prev.gif" CommandName="Page" CommandArgument="Prev" />
                                            </td>
                                            <td class="pagePrevNextNumber">
                                                <asp:ImageButton ID="btnNext" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/next.gif" CommandName="Page" CommandArgument="Next" />
                                            </td>
                                            <td class="pageFirstLast">
                                                <asp:LinkButton ID="btnLast" CssClass="pagerLink" CommandName="Page" CommandArgument="Last" runat="server">Last</asp:LinkButton>&nbsp; 
                                                                        <asp:ImageButton ID="imgLast" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/last.gif" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </PagerTemplate>
                    <SortedAscendingCellStyle BackColor="#EDF6F6" />
                    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                    <SortedDescendingCellStyle BackColor="#D6DFDF" />
                    <SortedDescendingHeaderStyle BackColor="#002876" />
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
