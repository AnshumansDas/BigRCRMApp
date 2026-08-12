<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmBanner.aspx.cs" Inherits="CRMApp.crmapp.frmBanner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="CBBanner" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel runat="server" ID="upMember">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Banner Management</h2>
                        <span id="message" runat="server" style="font-size: smaller;"></span>
                    </div>
                    <div></div>
                </div>
                <div class="col-sm-12">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="search-categori">
                                <div class="search-box">
                                    <asp:DropDownList ID="ddlBannerCat" AutoPostBack="true" OnSelectedIndexChanged="ddlBannerCat_SelectedIndexChanged" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6" style="text-align: right;">
                            <asp:LinkButton ID="lnkAddNewBanner" runat="server" OnClick="lnkAddNewBanner_Click" CssClass="btn btn-info">Add New Banner</asp:LinkButton>
                        </div>
                    </div>
                    <div>
                        <asp:ListView ID="LV_Banner" runat="server" DataKeyNames="Content_id" OnItemCommand="LV_Banner_ItemCommand"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="LV_Banner_ItemDataBound" OnPagePropertiesChanging="LV_Banner_PagePropertiesChanging">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 10%;">Banner Title</th>
                                            <th style="width: 15%; text-align: left;">Category Name</th>
                                           <%-- <th style="width: 25%; text-align: left;">Banner Description</th>--%>
                                            <th style="width: 10%; text-align: left;">Start Date</th>
                                            <th style="width: 10%; text-align: left;">End Date</th>
                                            <th style="width: 5%; text-align: left;">Status</th>
                                            <th style="width: 5%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="LV_Banner" PageSize="10">
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
                                    <td style="text-align: left;"><%# Eval("Content_title").ToString().Trim() %></td>
                                    <td style="text-align: left;"><%# Eval("Category_name") %></td>
                                 <%--   <td style="text-align: left;"><%# Eval("content_description") %></td>--%>
                                    <td style="text-align: left;"><%# Eval("StartDate") %></td>
                                    <td style="text-align: left;"><%# Eval("EndDate") %></td>
                                    <%--<td style="text-align: left;"><%# Eval("Status") %></td>--%>
                                    <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("Status").ToString().Trim() %></span></td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Banner" CssClass="btn btn-primary btn-xs" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                           <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 10%;">Banner Title</th>
                                            <th style="width: 15%; text-align: left;">Category Name</th>
                                           <%-- <th style="width: 25%; text-align: left;">Banner Description</th>--%>
                                            <th style="width: 10%; text-align: left;">Start Date</th>
                                            <th style="width: 10%; text-align: left;">End Date</th>
                                            <th style="width: 5%; text-align: left;">Status</th>
                                            <th style="width: 5%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="10" style="text-align: center;">No Banner Details found!
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
