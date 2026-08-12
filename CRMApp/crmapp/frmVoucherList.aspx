<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmVoucherList.aspx.cs" Inherits="CRMApp.crmapp.frmVoucherList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>Voucher Lists</h2>
        </div>
        <div></div>
    </div>

    <asp:UpdatePanel ID="upVoucheList" runat="server">
        <ContentTemplate>
            <div class="col-sm-12">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="search-categori">
                            <div class="search-box">
                                <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" CssClass="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                <i class="fa fa-search"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <asp:linkButton ID="btnAddVoucher" runat="server" Text="Add New" OnClick="btnAddVoucher_Click" CssClass="btn btn-success pull-right" />
                    </div>
                </div>
                <div>
                    <asp:ListView ID="lvVoucherList" runat="server" DataKeyNames="voucher_id" OnItemCommand="lvVoucherList_ItemCommand" OnPagePropertiesChanging="lvVoucherList_PagePropertiesChanging"
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvVoucherList_ItemDataBound">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 15%;">Merchant Name</th>
                                        <th style="width: 15%; text-align: left;">Voucher Name</th>
                                        <th style="width: 12%; text-align: center;">Voucher Category</th>
                                        <th style="width: 5%; text-align: center;">Quantity</th>
                                        <th style="width: 10%; text-align: center;">Original Price</th>
                                        <th style="width: 10%; text-align: center;">Discount Price</th>
                                        <th style="width: 10%; text-align: center;">Voucher Fee</th>
                                        <th style="width: 10%; text-align: center;">Active Status</th>
                                        <th style="width: 8%; text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvVoucherList" PageSize="10">
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
                                <td><%# Eval("organization_name") %></td>
                                <td style="text-align: left;"><%# Eval("voucher_name")%></td>
                                <td style="text-align: left;"><%# Eval("voucher_main_category") %></td>                                
                                <td style="text-align: center;"><%# Eval("qty")%></span></td>
                                <td style="text-align: center;"><%# Eval("original_price") %></td>
                                <td style="text-align: center;"><%# Eval("discount_price") %></td>
                                <td style="text-align: center;"><%# Eval("voucher_fee")%></td>
                                <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("active_status").ToString().Trim() %></span></td>
                                <%--<td style="text-align: center;"><%# Eval("availability")%></span></td>--%>
                                <td style="text-align: center;">
                                    <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Voucher" CssClass="btn btn-primary btn-xs" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                                    <%--<asp:LinkButton ID="lnkDelete" runat="server" ToolTip="Delete Voucher" CssClass="btn btn-primary btn-xs" CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>--%>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 15%;">Merchant Name</th>
                                        <th style="width: 15%; text-align: left;">Voucher Name</th>
                                        <th style="width: 12%; text-align: center;">Voucher Category</th>
                                        <th style="width: 5%; text-align: center;">Quantity</th>
                                        <th style="width: 10%; text-align: center;">Original Price</th>
                                        <th style="width: 10%; text-align: center;">Discount Price</th>
                                        <th style="width: 10%; text-align: center;">Voucher Fee</th>
                                        <th style="width: 10%; text-align: center;">Active Status</th>
                                        <th style="width: 8%; text-align: center;">Action</th>
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
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
