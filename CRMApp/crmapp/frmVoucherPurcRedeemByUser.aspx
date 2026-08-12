<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmVoucherPurcRedeemByUser.aspx.cs" Inherits="CRMApp.crmapp.frmVoucherPurcRedeemByUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>My Voucher</h2>
        </div>
        <div></div>
    </div>
    <div>
        <asp:ListView ID="Lv_PurRedeemVoucherReport" runat="server" DataKeyNames="Voucher_Id" OnItemDataBound="Lv_PurRedeemVoucherReport_ItemDataBound"
            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="Lv_PurRedeemVoucherReport_PagePropertiesChanging">
            <LayoutTemplate>
                <div class="row">
                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                </div>
                <table class="table table-striped" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th style="width: 2%; text-align: left;">No</th>
                            <th style="width: 5%; text-align: left;">Receipt No</th>
                            <th style="width: 10%;">Voucher Name</th>
                            <th style="width: 5%;">Voucher Status</th>
                            <th style="width: 10%; text-align: left;">Redeemed Date</th>
                            <th style="width: 10%;">Voucher Code</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                    </tbody>
                </table>
                <div class="row">
                    <div class="col-sm-12 text-right">
                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="Lv_PurRedeemVoucherReport" PageSize="10">
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
                    <td style="text-align: left;"><%# Eval("order_no") %></td>
                    <td><%# Eval("Voucher_name").ToString().Trim() %></td>
                    <td style="text-align: left;"><%# Eval("Status") %></td>
                    <td style="text-align: left;"><%# Eval("Pur_Red_Date") %></td>
                    <td style="text-align: left;"><%# Eval("voucher_code") %></td>
                </tr>
            </ItemTemplate>
            <EmptyDataTemplate>
                <table class="table table-striped" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th style="width: 2%; text-align: left;">No</th>
                            <th style="width: 10%; text-align: left;">Receipt No</th>
                            <th style="width: 10%;">Voucher Name</th>
                            <th style="width: 15%;">Voucher Status</th>
                            <th style="width: 5%; text-align: left;">Redeemed Date</th>
                            <th style="width: 15%;">Voucher Code</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="10" style="text-align: center;">No Voucher Purchase Redeemed record found!
                            </td>
                        </tr>
                    </tbody>
                </table>
            </EmptyDataTemplate>
        </asp:ListView>
    </div>
</asp:Content>
