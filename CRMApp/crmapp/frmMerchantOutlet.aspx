<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMerchantOutlet.aspx.cs" Inherits="CRMApp.crmapp.frmMerchantOutlet" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content runat="server" ID="cMerchant" ContentPlaceHolderID="body">
    <asp:UpdatePanel runat="server" ID="upMerchant">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Merchant Outlet</h2>
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
                        <div class="col-md-6" style="text-align: right;">
                            <asp:LinkButton ID="lnkAddNew" runat="server" CssClass="btn btn-info" OnClick="lnkAddNew_Click">Add New</asp:LinkButton>
                        </div>
                    </div>
                    <div>
                        <asp:ListView ID="lvMerchantOutlet" runat="server" DataKeyNames="branch_id" OnItemCommand="lvMerchantOutlet_ItemCommand" OnItemDataBound="lvMerchantOutlet_ItemDataBound"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lvMerchantOutlet_PagePropertiesChanging">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 25%;">Merchant Name</th>
                                            <th style="width: 25%;">Branch Name</th>
                                            <th style="width: 16%; text-align: center;">PIC</th>
                                            <th style="width: 7%; text-align: center;">Latitude</th>
                                            <th style="width: 7%; text-align: center;">Longitude</th>
                                            <th style="width: 10%; text-align: center;">Active Status</th>
                                            <th style="width: 5%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvMerchantOutlet" PageSize="10">
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
                                    <td><%# Eval("merchant_name").ToString().Trim() %></td>
                                    <td><%# Eval("branch_name").ToString().Trim() %></td>
                                    <td style="text-align: center;"><%# Eval("person_incharge") %></td>
                                    <td style="text-align: center;"><%# Eval("latitude") %></td>
                                    <td style="text-align: center;"><%# Eval("longitude") %></td>
                                    <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("active_status").ToString().Trim() %></span></td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 25%;">Merchant Name</th>
                                            <th style="width: 25%;">Branch Name</th>
                                            <th style="width: 16%; text-align: center;">PIC</th>
                                            <th style="width: 7%; text-align: center;">Latitude</th>
                                            <th style="width: 7%; text-align: center;">Longitude</th>
                                            <th style="width: 10%; text-align: center;">Active Status</th>
                                            <th style="width: 5%; text-align: center;">Action</th>
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
