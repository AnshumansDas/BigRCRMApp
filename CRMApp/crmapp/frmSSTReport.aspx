<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmSSTReport.aspx.cs" Inherits="CRMApp.crmapp.frmSSTReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel runat="server" ID="upMember">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>SST Report </h2>
                        <span id="message" runat="server" style="font-size: smaller;"></span>
                    </div>
                    <div></div>
                </div>
                <div class="col-sm-12">
                    <div class="form-group">
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
                                    <asp:Button ID="BtnSearch" ValidationGroup="Search" CssClass="btn btn-primary" OnClick="BtnSearch_Click" runat="server" Text="Search" />
                                </div>
                                <div class="col-sm-6 text-right">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <asp:ListView ID="lvSSTReport" runat="server" DataKeyNames="Order_No"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lvSSTReport_PagePropertiesChanging"
                            OnItemDataBound="lvSSTReport_ItemDataBound">
                            <LayoutTemplate>
                                <table class="table-list table table-striped nowrap" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Transaction Date</th>
                                            <th>Transaction Id</th>
                                            <th>Voucher</th>
                                            <th>Tax Rate</th>
                                            <th>SST Amount</th>
                                            <th>Total Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="gap gap-mid">
                                            <label class="">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvSSTReport" PageSize="10">
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
                            </LayoutTemplate>
                            <GroupTemplate>
                                <tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                </tr>
                            </GroupTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td data-title="No" style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                    <td data-title="Name"><%# Eval("Trans_date") %></td>
                                    <td data-title="Email"><%# Eval("transaction_id") %></td>
                                    <td data-title="Subject"><%# Eval("Voucher_Name") %></td>
                                    <td data-title="Mobile No"></td>
                                    <td data-title="Role"><%# Eval("SST_Amount ") %></td>
                                    <td data-title="Create Date"><%# Eval("total_amount ") %></td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table-list table table-striped nowrap" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Transaction Date</th>
                                            <th>Transaction Id</th>
                                            <th>Voucher</th>
                                            <th>Tax Rate</th>
                                            <th>SST Amount</th>
                                            <th>Total Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="10" style="text-align: center;">No SST Report found!!!
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
