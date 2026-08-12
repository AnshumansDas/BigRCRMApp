<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMerchant.aspx.cs" Inherits="CRMApp.crmapp.frmMerchant" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content runat="server" ID="cMerchant" ContentPlaceHolderID="body">
    <asp:UpdatePanel runat="server" ID="upMerchant">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Merchant Listing</h2>
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
                        <asp:ListView ID="Lv_Merchant" runat="server" DataKeyNames="merchant_id,merchant_code,organization_name" OnItemCommand="Lv_Merchant_ItemCommand" OnItemDeleting="Lv_Merchant_ItemDeleting"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="Lv_Merchant_PagePropertiesChanging" OnItemDataBound="Lv_Merchant_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 4%; text-align: center;">No</th>
                                            <th style="width: 8%; text-align: center;">Merch Code</th>
                                            <th style="width: 20%;">Merch Name</th>
                                            <th style="width: 12%; text-align: center;">PIC</th>
                                            <th style="width: 9%; text-align: center;">Mobile Phone</th>
                                            <th style="width: 8%; text-align: center;">Office Phone</th>
                                            <th style="width: 15%; text-align: center;">Email</th>
                                            <th style="width: 8%; text-align: center;">Doc. Status</th>
                                            <th style="width: 8%; text-align: center;">Active Status</th>
                                            <th style="width: 8%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="Lv_Merchant" PageSize="10">
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
                                    <td style="text-align: center;"><%# Eval("merchant_code") %></td>
                                    <td><%# Eval("organization_name").ToString().Trim() %></td>
                                    <td style="text-align: center;"><%# Eval("person_incharge") %></td>
                                    <td style="text-align: center;"><%# Eval("mobile_phone") %></td>
                                    <td style="text-align: center;"><%# Eval("office_phone") %></td>
                                    <td style="text-align: center;"><%# Eval("email") %></td>
                                    <td style="text-align: center;"><span id="doc_status" runat="server"><%# Eval("sptdoc_status").ToString().Trim() %></span></td>
                                    <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("active_status").ToString().Trim() %></span></td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Merchant" CssClass="btn btn-primary btn-xs" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                                        <asp:LinkButton ID="lnkAddEditSptDoc" runat="server" ToolTip="Upload Support Document" CssClass="btn btn-primary btn-xs" CommandName="AddEditSptDoc"><i class="fa fa-download"></i></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 4%; text-align: center;">No</th>
                                            <th style="width: 8%; text-align: center;">Merch Code</th>
                                            <th style="width: 20%;">Merch Name</th>
                                            <th style="width: 12%; text-align: center;">PIC</th>
                                            <th style="width: 9%; text-align: center;">Mobile Phone</th>
                                            <th style="width: 8%; text-align: center;">Office Phone</th>
                                            <th style="width: 15%; text-align: center;">Email</th>
                                            <th style="width: 8%; text-align: center;">Doc. Status</th>
                                            <th style="width: 8%; text-align: center;">Active Status</th>
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
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
