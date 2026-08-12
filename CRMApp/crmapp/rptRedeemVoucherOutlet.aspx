<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rptRedeemVoucherOutlet.aspx.cs" Inherits="CRMApp.crmapp.rptRedeemVoucherOutlet" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Voucher Redeemed Report Outlet</h2>
            </div>
        </div>
        <div class="col-sm-12">
            <asp:UpdatePanel ID="uprptVoucher" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <%--<div class="col-sm-6">
                        <div class="search-categori">
                            <div class="search-box">
                                <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" CssClass="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                <i class="fa fa-search"></i>
                            </div>
                        </div>
                    </div>--%>
                        <div class="col-sm-6 form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Date Range : </label>
                                <div class="col-sm-8">
                                    <asp:TextBox ID="txtDateRange" runat="server" CssClass="startdate form-control" placeholder="Date Range"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-6">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click" />
                                </div>
                                <div class="col-sm-6 pull-right">
                                    <%--<button class="btn btn-success btn-xs"><i class="fa fa-file-excel-o"></i>Excel</button>
                                <button class="btn btn-danger btn-xs"><i class="fa fa-file-pdf-o"></i>PDF</button>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="gap-mini"></div>
                    <asp:ListView ID="LstVoucherTransaction" runat="server" DataKeyNames="redeem_id" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1"
                        OnPagePropertiesChanging="LstVoucherTransaction_PagePropertiesChanging" OnItemDataBound="LstVoucherTransaction_ItemDataBound">
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
                                        <th>REDEEMED DATE</th>
                                        <th>REDEEM ID</th>
                                        <th>REDEEM STATUS</th>
                                        <th>VOUCHER CODE</th>
                                        <%--<th>VOUCHER CATEGORY</th>--%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
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
                            <div class="gap-mid"></div>
                        </LayoutTemplate>
                        <GroupTemplate>
                            <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                        </GroupTemplate>
                        <ItemTemplate>
                            <tr>
                                <td align="center"><%# Container.DataItemIndex + 1 %></td>
                                <td><%# Eval("created_date") %></td>
                                <td><%# Eval("voucher_name") %></td>
                                <td><%# Eval("user_fistname") %></td>
                                <td><%# Eval("redeem_date") %></td>
                                <td><%# Eval("redeem_trans_id") %></td>
                                <td><%# Eval("redeem_status") %></td>
                                <td><%# Eval("voucher_code") %></td>
                                <%--<td><%# Eval("voucher_main_category") %></td>--%>
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
                                        <th>REDEEMED DATE</th>
                                        <th>REDEEM ID</th>
                                        <th>REDEEM STATUS</th>
                                        <th>VOUCHER CODE</th>
                                        <%--<th>VOUCHER CATEGORY</th>--%>
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
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <div class="gap-mid"></div>
</asp:Content>
