<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmMerchandiseList.aspx.cs" Inherits="CRMApp.crmapp.frmMerchandiseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Merchandise List</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
            <div></div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-2">Start Date</label>
                        <div class="col-sm-4">
                            <div class="input-group date" id="startdate">
                                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" placeholder="start date"></asp:TextBox>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>
                        <label class="col-sm-2">End Date</label>
                        <div class="col-sm-4">
                            <div class="input-group date" id="enddate">
                                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" placeholder="end date"></asp:TextBox>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="row">
                        <label class="col-sm-3">Merchandise Name</label>
                        <div class="col-sm-5">
                            <asp:TextBox ID="txtMerchandiseName" runat="server" TabIndex="1" CssClass="form-control"></asp:TextBox>
                        </div>
                        <label class="col-sm-1"></label>
                        <div class="col-sm-2">
                            <asp:Button ID="btnSearch" CssClass="btn btn-primary pull-right" OnClick="btnSearch_Click" runat="server" Text="Search" />
                            <%--<asp:Button ID="btnAdd" CssClass="btn btn-primary" OnClick="btnAdd_Click" runat="server" Text="Add New" />--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="upMerchandiseList" runat="server">
        <ContentTemplate>
            <div class="col-sm-12">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="search-categori">
                            <%--<div class="search-box">
                                <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" CssClass="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                <i class="fa fa-search"></i>
                            </div>--%>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <asp:LinkButton ID="btnAddMerchandise" runat="server" Text="Add New" OnClick="btnAddMerchandise_Click" CssClass="btn btn-success pull-right" />
                    </div>
                </div>
                <div>
                    <asp:ListView ID="lvMerchandiseList" runat="server" DataKeyNames="merchandise_id" OnItemCommand="lvMerchandiseList_ItemCommand" OnPagePropertiesChanging="lvMerchandiseList_PagePropertiesChanging"
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvMerchandiseList_ItemDataBound">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" style="width:100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 20%;">Merchandise Name</th>
                                        <th style="width: 15%; text-align: left;">Category</th>
                                        <th style="width: 10%; text-align: left;">Point Redeem</th>
                                        <th style="width: 5%; text-align: center;">Quantity</th>
                                        <th style="width: 8%; text-align: center;">Redeemed</th>
                                        <th style="width: 15%; text-align: center;">Availability</th>
                                        <th style="width: 10%; text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvMerchandiseList" PageSize="10">
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
                                <td style="text-align: left;"><%# Eval("merchandise_name")%></td>
                                <td style="text-align: left;"><%# Eval("merchandise_category") %></td>
                                <td style="text-align: center;"><%# Eval("points_to_redeem")%></span></td>
                                <td style="text-align: center;"><%# Eval("quantity") %></td>
                                <td style="text-align: center;"><%# Eval("redeemed") %></td>
                                <td style="text-align: center;"><%# Eval("start_date")%> to <%# Eval("end_date")%></td>
                                <td style="text-align: center;">
                                    <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Voucher" CssClass="btn btn-primary btn-xs" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                                    <asp:LinkButton ID="lnkDelete" runat="server" ToolTip="Delete Voucher" CssClass="btn btn-primary btn-xs" CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 20%;">Merchandise Name</th>
                                        <th style="width: 20%; text-align: left;">Category</th>
                                        <th style="width: 15%; text-align: left;">Point Redeem</th>
                                        <th style="width: 5%; text-align: center;">Quantity</th>
                                        <th style="width: 8%; text-align: center;">Redeemed</th>
                                        <th style="width: 8%; text-align: center;">Availability</th>
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
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
