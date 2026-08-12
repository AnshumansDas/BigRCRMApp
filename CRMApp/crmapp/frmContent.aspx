<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmContent.aspx.cs" Inherits="CRMApp.crmapp.frmContent" MasterPageFile="~/crmapp/CRMBack.Master" %>
<asp:Content ID="chead" runat="server" ContentPlaceHolderID="head">
</asp:Content>
<asp:Content runat="server" ID="cContent" ContentPlaceHolderID="body">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Content Listing</h2>
            </div>
            <div></div>
        </div>
        <%--<asp:UpdatePanel runat="server" ID="upContent">
            <ContentTemplate>--%>
                <div class="col-sm-12">
                    <div class="row">
                        <label class="col-sm-2 control-label">Content Category</label>
                        <div class="col-md-5">
                            <asp:DropDownList ID="ddlContentCat" AutoPostBack="true" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlContentCat_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="col-sm-5 text-right">
                            <span id="message" runat="server" style="font-size: smaller;"></span>
                            <asp:Button ID="btnAddNewContent" CssClass="btn btn-primary" OnClick="btnAddNewContent_Click" Text="Add" runat="server" />
                            <%--<asp:Button ID="lnkAddNewContent" Text="Add New" CssClass="btn btn-primary" OnClick="lnkAddNewContent_Click" runat="server"></asp:LinkButton>--%>
                            <%--<asp:linkButton ID="lnkAddNewContent" runat="server" Text="Add New" OnClick="lnkAddNewContent_Click" CssClass="btn btn-success pull-right" />--%>
                            <%--<a href="frmContentAddEdit.aspx" class="btn btn-primary">Add New</a>--%>
                        </div>
                    </div>
                    <div>
                        <asp:ListView ID="lvContentList" runat="server" DataKeyNames="content_id" OnItemCommand="lvContentList_ItemCommand" GroupPlaceholderID="groupPlaceHolder1" 
                            ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lvContentList_PagePropertiesChanging" OnItemDataBound="lvContentList_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 30%;">Content Name</th>
                                            <th style="width: 15%; text-align: center;">Category</th>
                                            <th style="width: 10%; text-align: center;">Created Date</th>
                                            <th style="width: 10%; text-align: center;">Updated Date</th>
                                            <th style="width: 10%; text-align: center;">Updated By</th>
                                            <th style="width: 10%; text-align: center;">Active Status</th>
                                            <th style="width: 10%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="dpContentList" runat="server" class="btn-group btn-group-sm" PagedControlID="lvContentList" PageSize="10">
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
                                    <td><%# Eval("content_title").ToString().Trim() %></td>
                                    <td style="text-align: center;"><%# Eval("category_name") %></td>
                                    <td style="text-align: center;"><%# Eval("created_date") %></td>
                                    <td style="text-align: center;"><%# Eval("updated_date") %></td>
                                    <td style="text-align: center;"><%# Eval("update_by") %></td>
                                    <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("activestatus").ToString().Trim() %></span></td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" CommandName="Edit_Content"><i class="fa fa-pencil"></i></asp:LinkButton>
                                        <%--<i class="fa fa-pencil"></i>--%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 30%;">Content Name</th>
                                            <th style="width: 15%; text-align: center;">Category</th>
                                            <th style="width: 10%; text-align: center;">Created Date</th>
                                            <th style="width: 10%; text-align: center;">Updated Date</th>
                                            <th style="width: 10%; text-align: center;">Updated By</th>
                                            <th style="width: 10%; text-align: center;">Active Status</th>
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
            <%--</ContentTemplate>
        </asp:UpdatePanel>--%>
    </div>
</asp:Content>
