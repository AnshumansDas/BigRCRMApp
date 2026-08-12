<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmPreRegistrationList.aspx.cs" Inherits="CRMApp.crmapp.frmPreRegistrationList" %>

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
                </div>
                <div>
                    <asp:ListView ID="lvPreRegistrationList" runat="server" DataKeyNames="reg_id" OnItemCommand="lvPreRegistrationList_ItemCommand" OnPagePropertiesChanging="lvPreRegistrationList_PagePropertiesChanging"
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvPreRegistrationList_ItemDataBound">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 17%;">Merchant Name</th>
                                        <th style="width: 15%; text-align: left;">Registration No</th>
                                        <th style="width: 15%; text-align: left;">Person In Charge</th>
                                        <th style="width: 15%; text-align: center;">Company Email</th>
                                        <th style="width: 5%; text-align: center;">Phone No</th>
                                        <th style="width: 5%; text-align: center;">Member Status</th>                                        
                                        <th style="width: 8%; text-align: center;">Created Date</th>
                                        <th style="width: 10%; text-align: center;">Created By</th>
                                        <th style="width: 5%; text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvPreRegistrationList" PageSize="10">
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
                                <td style="text-align: center;"><%# Eval("merchant_name") %></td>
                                <td style="text-align: left;"><%# Eval("registration_no")%></td>
                                <td style="text-align: left;"><%# Eval("person_incharge_name") %></td>
                                <td style="text-align: center;"><%# Eval("company_email")%></span></td>
                                <td style="text-align: center;"><%# Eval("phone_no") %></td>
                                <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("member_status").ToString().Trim() %></span></td>
                                <td style="text-align: center;"><%# Eval("created_date")%></td>
                                <td style="text-align: center;"><%# Eval("created_by")%></td>
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
                                        <th style="width: 17%;">Merchant Name</th>
                                        <th style="width: 15%; text-align: left;">Registration No</th>
                                        <th style="width: 15%; text-align: left;">Person In Charge</th>
                                        <th style="width: 15%; text-align: center;">Company Email</th>
                                        <th style="width: 5%; text-align: center;">Phone No</th>
                                        <th style="width: 5%; text-align: center;">Member Status</th>
                                        <th style="width: 8%; text-align: center;">Created Date</th>
                                        <th style="width: 10%; text-align: center;">Created By</th>
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
