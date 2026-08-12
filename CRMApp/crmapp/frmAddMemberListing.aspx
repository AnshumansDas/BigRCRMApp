<%@ Page Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmAddMemberListing.aspx.cs" Inherits="CRMApp.crmapp.frmAddMemberListing" %>

<asp:Content ID="Addmemberlist" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>All Member info</h2>
            </div>
            <div></div>
        </div>
        <asp:UpdatePanel ID="UpdateAddmemberlist" runat="server">
            <ContentTemplate>
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
                        <div class="col-md-2" style="text-align: right; margin-top: 16px;">
                            <asp:Button ID="btnadd" runat="server" OnClick="btnadd_Click" Text="Add New" class="btn btn-info"/>
                        </div>
                         <div class="col-md-4">
                             <span id="message" runat="server"></span>
                        </div>
                    </div>
                    <div class="gap-mid"></div>
                    <div>
                        <asp:ListView ID="lvAddmember" runat="server" DataKeyNames="userlogin_id" OnItemCommand="lvAddmember_ItemCommand" OnPagePropertiesChanging="lvAddmember_PagePropertiesChanging"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvAddmember_ItemDataBound" OnItemEditing="lvAddmember_ItemEditing">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 10%;text-align: center;">Membership No</th>
                                            <th style="width: 10%;text-align: center;">user name</th>
                                            <th style="width: 10%;text-align: center;">Email</th>
                                            <th style="width: 10%;text-align: center;">created Date</th>
                                            <th style="width: 10%;text-align: center;">Updated date</th>
                                            <th style="width: 10%;text-align: center;">Updated by</th>                                           
                                            <th style="width: 10%; text-align: center;">status</th>
                                            <th style="width: 10%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvAddmember" PageSize="10">
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
                                    <td style="text-align: center;""><%# Eval("membership_no") %></td>
                                    <td style="text-align: center;""><%# Eval("user_fistname").ToString().Trim() %></td>
                                      <td style="text-align: center;""><%# Eval("email_id") %></td>
                                    <td style="text-align: center;""><%# Eval("joined_date").ToString().Trim() %></td>
                                      <td style="text-align: center;""><%# Eval("updated_date") %></td>
                                    <td style="text-align: center;""><%# Eval("updated_by").ToString().Trim() %></td>                                     
                                    <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("active_status").ToString().Trim() %></span></td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" CommandName="Edit">Edit</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 10%;text-align: center;">currency type</th>
                                            <th style="width: 10%;text-align: center;">point</th>
                                            <th style="width: 10%;text-align: center;">Amount(RM)</th>
                                            <th style="width: 10%;text-align: center;">Minimum</th>
                                            <th style="width: 10%;text-align: center;">Maximum</th>
                                            <th style="width: 10%;text-align: center;">Start Date</th>
                                            <th style="width: 10%; text-align: center;">Expired Date</th>
                                             <th style="width:10%;text-align: center;">Created By</th>
                                            <th style="width: 10%; text-align: center;">status</th>
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
     </div>      
   
</asp:Content>



