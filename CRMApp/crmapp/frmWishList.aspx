<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmWishList.aspx.cs" Inherits="CRMApp.crmapp.frmWishList" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content runat="server" ID="cMerchant" ContentPlaceHolderID="body">
    <asp:UpdatePanel ID="upTransaction" runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>My Wish List</h2>
                        <span id="message" runat="server" style="font-size: smaller;"></span>
                    </div>
                    <div></div>
                </div>
                <div class="col-sm-12">
                    <div>
                        <asp:ListView ID="lvWishList" runat="server" DataKeyNames="voucher_id,wl_id" OnItemCommand="lvWishList_ItemCommand" OnItemDeleting="lvWishList_ItemDeleting"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lvWishList_PagePropertiesChanging" OnItemDataBound="lvWishList_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 40%; text-align: left;">Voucher Name</th>
                                            <th style="width: 10%; text-align: center;">Amount(RM)</th>
                                            <th style="width: 15%; text-align: center;">Added On</th>
                                            <th style="width: 15%; text-align: center;">Category</th>
                                            <th style="width: 15%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvWishList" PageSize="10">
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
                                    <td style="text-align: left;"><%# Eval("product_name") %></td>
                                    <td style="text-align: center;"><%# Eval("product_discountprice") %></td>
                                    <td style="text-align: center;"><%# Eval("transdate") %></td>
                                    <td style="text-align: center;"><%# Eval("voucher_main_category") %></td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkDelete" CommandName="Delete" runat="server" CssClass="btn btn-danger" ToolTip="Delete document">Remove</asp:LinkButton>
                                        <asp:LinkButton ID="lnkView" runat="server" ToolTip="View Content" CssClass="btn btn-info" CommandName="View">View</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 40%; text-align: left;">Voucher Name</th>
                                            <th style="width: 10%; text-align: center;">Amount(RM)</th>
                                            <th style="width: 15%; text-align: center;">Added On</th>
                                            <th style="width: 15%; text-align: center;">Category</th>
                                            <th style="width: 15%; text-align: center;">Action</th>
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
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
