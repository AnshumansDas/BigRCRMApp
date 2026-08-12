<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master"  AutoEventWireup="true" CodeBehind="frmAdminWithdrawDashboard.aspx.cs" Inherits="CRMApp.crmapp.frmAdminWithdrawDashboard" %>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
   
    <div class="row">
        <!--col-md-3-->
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Withdraw Dashboard</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
            <div></div>
        </div>
       <!-- <asp:UpdatePanel ID="upMerchantDashboard" runat="server">
            <ContentTemplate>-->
                

                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Withdraw History</h2>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="form-horizontal">
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <div class="col-md-12 col-sm-12">
                                    <asp:TextBox ID="txtVoucherDateRange" runat="server" CssClass="form-control startdate" placeholder="Date Range"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-md-5 col-sm-6 control-label">Status&nbsp;<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-md-7 col-sm-6">
                                    <asp:DropDownList ID="dtStatus" CssClass="form-control" runat="server" AutoPostBack="true"   >
                                <asp:ListItem Value="">Select</asp:ListItem>
                                <asp:ListItem Value="3">Pending</asp:ListItem>
                                <asp:ListItem Value="1">Completed</asp:ListItem>
                                <asp:ListItem Value="2">Rejected</asp:ListItem>
                            </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-md-5 col-sm-6 control-label">Merchant&nbsp;<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-md-7 col-sm-6">
                                    <asp:DropDownList ID="ddlMerchantList" CssClass="form-control" runat="server" AutoPostBack="true" DataTextField="organization_name"  DataValueField="merchant_id"  >
                               
                            </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-md-5 col-sm-6 control-label">Reference No&nbsp;<span style="font-size: smaller; color: red;">&#42;</span></label>
                                <div class="col-md-7 col-sm-6">
                                    <asp:TextBox ID="txtRefno" runat="server" CssClass="form-control" placeholder="Reference No"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 col-sm-12">
                            <div class="form-group">
                                <div class="col-md-12 text-right">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click"  />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="gap gap-mid"></div>
                        <asp:ListView ID="LstRecentTransaction" runat="server" DataKeyNames="withdraw_id" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemCommand="LstRecentTransaction_ItemCommand" 
                           OnItemDataBound="LstRecentTransaction_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row" style="display: none">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecords" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
                                        <tr>
                                            <th>No</th>
                                            <th>Merchant Name</th>
                                            <th>Date Requested</th>
                                            <th>Reference No</th>
                                            <th>Amount Requested</th>
                                            <th>Bank</th>
                                            <th>Account No</th>
                                            <th>Status</th>
                                            <th>Verify</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="row">
                                    <div class="gap gap-small"></div>
                                    <div class="col-md-12 text-right">
                                        <asp:DataPager ID="DataPager2" runat="server" class="btn-group btn-group-sm" PageSize="10">
                                            <Fields>
                                                <asp:NextPreviousPagerField PreviousPageText="&laquo;" FirstPageText="|<" ShowPreviousPageButton="true"
                                                    ShowFirstPageButton="true" ShowNextPageButton="false" ShowLastPageButton="false"
                                                    ButtonCssClass="btn btn-default" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                                                <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary" RenderNonBreakingSpacesBetweenControls="false"
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
                                    <td data-title="No"  style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                   <td data-title="Organization Name"><%# Eval("organization_name") %></td>
                                    <td data-title="Requested Date"><%# Eval("requested_date") %></td>
                                    <td data-title="Reference No">
                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit" CssClass="btn btn-success btn-xs" CommandName="Edit">
                                            <%# Eval("reference_no") %></asp:LinkButton></td>
                                            
                                    <td data-title="Requested Amount"><%# Eval("requested_amount") %></td>
                                    <td data-title="Bank Name)"><%# Eval("bankname") %></td>
                                    <td data-title="Account No"><%# Eval("accno") %></td>
                                    <td data-title="Status"><span id="colorstatus" runat="server"><%# Eval("withdraw_status") %></span></td>
                                    <td data-title="Verify"> 
                                         <span id="verifyInfo" runat="server"><%# Eval("verifyflag") %></span>
                                         </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
                                        <tr>
                                           <th>No</th>
                                              <th>Merchant Name</th>
                                            <th>Date Requested</th>
                                            <th>Reference No</th>
                                            <th>Amount Requested</th>
                                            <th>Bank</th>
                                            <th>Account No</th>
                                            <th>Status</th>
                                            <th>Verify</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="10" align="center">No Transaction record found!
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </div>
                
           <!-- </ContentTemplate>
        </asp:UpdatePanel>-->
    </div>
</asp:Content>

