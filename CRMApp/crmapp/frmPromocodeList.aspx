<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmPromocodeList.aspx.cs" Inherits="CRMApp.crmapp.frmPromocodeList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Promocode List</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
            <div></div>
        </div>
        <div class="col-sm-12">
            <div class="row">
                <div class="col-md-6">
                    <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                        <div class="search-box">
                            <asp:TextBox ID="TxtSearchKey" runat="server" OnTextChanged="TxtSearchKey_TextChanged" class="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                            <i class="fa fa-search"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-6" style="text-align: right;">
                    <asp:LinkButton ID="lnkAddNewPromoCode" runat="server" CssClass="btn btn-info" OnClick="lnkAddNewPromoCode_Click">Add Promocode</asp:LinkButton>
                </div>
            </div>
            <div>
                <asp:ListView ID="LV_PromocodeList" runat="server" DataKeyNames="promocode_id" OnItemCommand="LV_PromocodeList_ItemCommand"
                    GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="LV_PromocodeList_ItemDataBound" OnPagePropertiesChanging="LV_PromocodeList_PagePropertiesChanging">
                    <LayoutTemplate>
                        <div class="row">
                            <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                        </div>
                        <table class="table table-striped" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th style="width: 5%; text-align: center;">No</th>
                                    <th style="width: 12%;">Promocode Name</th>
                                    <th style="width: 12%; text-align: left;">Voucher Category</th>
                                    <th style="width: 12%; text-align: left;">Voucher Type</th>
                                    <th style="width: 12%; text-align: left;">Amount/Percentage</th>
                                    <th style="width: 15%; text-align: left;">Merchant</th>
                                    <th style="width: 10%; text-align: left;">Voucher</th>
                                    <th style="width: 7%; text-align: left;">Availability</th>
                                    <th style="width: 7%; text-align: left;">Created Date</th>
                                    <th style="width: 5%; text-align: left;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                            </tbody>
                        </table>
                        <div class="row">
                            <div class="col-sm-12 text-right">
                                <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="LV_PromocodeList" PageSize="10">
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
                            <td style="text-align: left;"><%# Eval("promocode_name").ToString().Trim() %></td>
                            <td style="text-align: left;"><%# Eval("promocode_category") %></td>
                            <td style="text-align: left;"><%# Eval("promocode_type") %></td>
                            <td style="text-align: left;"><%# Eval("amount_percentage") %></td>
                            <td style="text-align: left;"><%# Eval("organization_name") %></td>
                            <td style="text-align: left;"><%# Eval("Voucher_name") %></td>
                            <td style="text-align: left;"><%# Eval("availability") %></td>
                            <td style="text-align: left;"><%# Eval("created_Date") %></td>
                            <td style="text-align: left;">
                                <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Banner" CssClass="btn btn-primary btn-xs" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <table class="table table-striped" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th style="width: 5%; text-align: center;">No</th>
                                    <th style="width: 5%;">Promocode Name</th>
                                    <th style="width: 10%; text-align: left;">Type</th>
                                    <th style="width: 10%; text-align: left;">Amount</th>
                                    <th style="width: 10%; text-align: left;">Merchant</th>
                                    <th style="width: 5%; text-align: left;">Voucher</th>
                                    <th style="width: 5%; text-align: center;">Availability</th>
                                    <th style="width: 5%; text-align: center;">Created Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="10" style="text-align: center;">No Promocode Details found!
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </EmptyDataTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>
</asp:Content>
