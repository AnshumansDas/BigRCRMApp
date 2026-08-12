<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmSstSetup.aspx.cs" Inherits="CRMApp.crmapp.frmSstSetup" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content runat="server" ID="cMerchant" ContentPlaceHolderID="body">
    <asp:UpdatePanel runat="server" ID="upMerchant">
    <ContentTemplate>
        <div class="row">
            <div class="col-sm-12">
                <div class="area-title bdr mt20">
                    <h2>Setup SST</h2>
                    <span id="message" runat="server" style="font-size: smaller;"></span>
                </div>
                <div></div>
            </div>
            <div class="col-sm-12">
                <div class="row">                  
                    <div class="col-md-12" style="text-align: right;">
                        <asp:LinkButton ID="lnkAddNew" runat="server" CssClass="btn btn-info" OnClick="lnkAddNew_Click">Add New</asp:LinkButton>
                    </div>
                </div>
                <div>
                    <asp:ListView ID="Lv_sst" runat="server" DataKeyNames="id" OnItemCommand="Lv_sst_ItemCommand" 
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="Lv_sst_PagePropertiesChanging" OnItemDataBound="Lv_sst_ItemDataBound" >
                        <LayoutTemplate>
                            <div class="row" style="display:none">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                         <th style="width: 1%; text-align: center;display:none">id</th>
                                         <th style="width: 1%; text-align: center;display:none">Taxname</th>
                                        <th style="width: 10%; text-align: center;">SST(%)</th>
                                        <th style="width: 15%;">Remark</th>
                                        <th style="width: 15%; text-align: center;">Created Date</th>
                                        <th style="width: 10%; text-align: center;">Created BY</th>
                                        <th style="width: 15%; text-align: center;">Updated Date</th>
                                        <th style="width: 10%; text-align: center;">Updated By</th>
                                        <th style="width: 20%; text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager2" runat="server" class="btn-group btn-group-sm" PagedControlID="Lv_sst" PageSize="10">
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
                                 <td style="text-align: center;display:none"><%# Eval("id") %></td>
                                <td style="text-align: center;display:none"><%# Eval("tax_name") %></td>
                                <td style="text-align: center;"><%# Eval("sst_value") %></td>
                                <td><%# Eval("Remarks")%></td>
                                <td style="text-align: center;"><%# Eval("created_date") %></td>
                                <td style="text-align: center;"><%# Eval("created_by") %></td>
                                <td style="text-align: center;"><%# Eval("updated_date") %></td>
                                <td style="text-align: center;"><%# Eval("updated_by") %></td>
                                <td style="text-align: center;">
                                   <%-- <asp:LinkButton ID="LinkButton1" runat="server" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" CommandName="Status"><span id="colorstatus" runat="server"><%#Eval("Status").ToString().Trim()%></span></asp:LinkButton>--%>
                                   <button style="width:80px;"><span id="colorstatus" runat="server"><%#Eval("Status").ToString().Trim()%></span></button>
                                    <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" CommandName="Edit">Edit<%--<i class="fa fa-pencil"></i>--%></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <%-- <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 10%;">Merchant ID</th>
                                            <th style="width: 20%;">Merchant Name</th>
                                            <th style="width: 10%; text-align: center;">PIC</th>
                                            <th style="width: 10%; text-align: center;">Mobile Phone</th>
                                            <th style="width: 10%; text-align: center;">Office Phone</th>
                                            <th style="width: 15%; text-align: center;">Email</th>
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
                                </table>--%>
                            <table class="table table-striped" style="width: 100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 5%; text-align: center;">ID</th>
                                        <th style="width: 5%; text-align: center;">Taxname</th>
                                        <th style="width: 10%;">SST(%)</th>
                                        <th style="width: 10%;">Remark</th>
                                        <th style="width: 5%; text-align: center;">Created Date</th>
                                        <th style="width: 10%; text-align: center;">Created BY</th>
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
                                    <%--<asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>--%>
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
<%--<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="content">
        <h3>Setup SST</h3>
        <asp:Button ID="Button1" runat="server" Text="Add" Style="height: 30px; margin-left: 90%;" />
        <table class="table table-striped" style="width: 100%" cellspacing="0">
            <thead>
                <tr>
                    <th style="width: 5%; text-align: center;">No</th>
                    <th style="width: 10%;">SST(%)</th>
                    <th style="width: 10%;">Remark</th>
                    <th style="width: 5%; text-align: center;">Created Date</th>
                    <th style="width: 10%; text-align: center;">Created BY</th>
                    <th style="width: 10%; text-align: center;">Updated Date</th>
                    <th style="width: 10%; text-align: center;">Updated By</th>
                    <th style="width: 10%; text-align: center;">Action</th>
                </tr>
            </thead>
            <tbody>
                <%--<asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>--%>
           <%-- </tbody>
        </table>
    </div>
</asp:Content>--%>

