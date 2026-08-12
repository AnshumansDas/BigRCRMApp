<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmTransactionHistory.aspx.cs" Inherits="CRMApp.crmapp.frmTransactionHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <%--<asp:ScriptManager ID="scriptmanager1" runat="server" />--%>
    <asp:UpdatePanel ID="upTransaction" runat="server">
        <ContentTemplate>
            <!-- main area start -->
            <div class="main-area">
                <div class="container">
                    <div class="row">
                        <!--col-md-3-->
                        <div class="col-sm-12">
                            <div class="area-title bdr mt20">
                                <h2>TRANSACTION HISTORY</h2>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="content-breadcrumbs2">
                                <ul class="tabfull" role="tablist">
                                    <%--<li class="active"><a href="#season" aria-controls="season" role="tab" data-toggle="tab">Season Fee</a>
                                    </li>
                                    <li><a href="#parking" aria-controls="parking" role="tab" data-toggle="tab">Parking</a>
                                    </li>--%>
                                    <li><a href="#reward" aria-controls="reward" role="tab" data-toggle="tab">Reward Redemption</a>
                                    </li>
                                    <li class="active"><a href="#retail" aria-controls="retail" role="tab" data-toggle="tab">Voucher Purchase</a>
                                    </li>
                                    <%--<li><a href="#toll" aria-controls="toll" role="tab" data-toggle="tab">Toll</a>
                                    </li>
                                    <li><a href="#transit" aria-controls="transit" role="tab" data-toggle="tab">Transit</a>
                                    </li>
                                    <li><a href="#topup" aria-controls="topup" role="tab" data-toggle="tab">Topup</a>
                                    </li>--%>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="tab-content" id="tab-conte">
                                <div role="tabpanel" id="season" class="tab-pane">
                                    <div class="row">
                                        <div class="col-sm-12 mt20">
                                            <div class="form-inline">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" placeholder="Search Keyword">
                                                </div>
                                                <button type="submit" class="btn btn-info">Search</button>
                                            </div>
                                        </div>
                                        <div class="gap gap-mid"></div>
                                        <div class="col-sm-12">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <asp:ListView ID="lvSeason" runat="server" DataKeyNames="transaction_no" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1">
                                                            <LayoutTemplate>
                                                                <table id="table-list" class="table table-striped nowrap" width="100%" cellspacing="0">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Sl No</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Transaction No</th>
                                                                            <th>Amount</th>
                                                                            <th>Transaction Status</th>
                                                                            <%--<th>Action</th>--%>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                                                        <tr>
                                                                            <td style="text-align: right;" colspan="8">
                                                                                <asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvSeason" PageSize="10">
                                                                                    <Fields>
                                                                                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                                                                                            ShowNextPageButton="false" />
                                                                                        <asp:NumericPagerField ButtonType="Link" />
                                                                                        <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false" ShowPreviousPageButton="false" />
                                                                                    </Fields>
                                                                                </asp:DataPager>
                                                                            </td>
                                                                        </tr>

                                                                    </tbody>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <GroupTemplate>
                                                                <tr>
                                                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                                                </tr>
                                                            </GroupTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td><%# Container.DataItemIndex + 1 %></td>
                                                                    <td>
                                                                        <asp:Label ID="lbltrandate" runat="server" Text='<%#Eval("transaction_date")%>'></asp:Label></td>
                                                                    <td>
                                                                        <asp:Label ID="lbltranno" runat="server" Text='<%#Eval("transaction_no")%>'></asp:Label></td>
                                                                    <td>
                                                                        <asp:Label ID="lbltranamount" runat="server" Text='<%#Eval("topup_amt")%>'></asp:Label></td>
                                                                    <td><span class="text-success">
                                                                        <asp:Label ID="lbltranstatus" runat="server" Text='<%#Eval("transaction_status")%>'></asp:Label></span></td>
                                                                    <%--<td>
                                                                        <a href="#" class="btn btn-info btn-sm">
                                                                            <asp:LinkButton ID="lbtnview" ToolTip="View Item" CssClass="btn btn-danger" runat="server" CommandArgument='<%# Eval("transaction_no") %>' OnClick="lbtnview_Click"></asp:LinkButton>                                                                                                                                                   </a>
                                                                    </td>--%>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <EmptyDataTemplate>
                                                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                                    <thead class="cf">
                                                                        <tr>
                                                                            <th>Sl No</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Transaction No</th>
                                                                            <th>Amount</th>
                                                                            <th>Transaction Status</th>
                                                                            <%--<th>Action</th>--%>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td colspan="10" style="text-align: center;">No Season payment available for User!
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </EmptyDataTemplate>
                                                        </asp:ListView>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end row-->
                                </div>
                                <!-- tab content-end-->
                                <div role="tabpanel" class="tab-pane" id="parking">
                                    <div class="row">
                                        <div class="col-sm-12 mt20">
                                            <div class="form-inline">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" placeholder="Search Keyword">
                                                </div>
                                                <button type="submit" class="btn btn-info">Search</button>
                                            </div>
                                        </div>
                                        <div class="gap gap-mid"></div>
                                        <div class="col-sm-12">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <table id="table-list" class="table table-striped nowrap" width="100%" cellspacing="0">
                                                            <thead>
                                                                <tr>
                                                                    <th>Sl No</th>
                                                                    <th>Reg No</th>
                                                                    <th>Card No</th>
                                                                    <th>Date-In</th>
                                                                    <th>Date-Out</th>
                                                                    <th>Status</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td>1</td>
                                                                    <td>WIG 1234</td>
                                                                    <td>612345567890</td>
                                                                    <td>30-Jan-2018
                                                                        <br>
                                                                        08:10:32</td>
                                                                    <td>30-Jan-2018
                                                                        <br>
                                                                        08:10:32
                                                                    </td>
                                                                    <td><span class="text-success">OK</span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>2</td>
                                                                    <td>WAZ 1234</td>
                                                                    <td>612345567890</td>
                                                                    <td>30-Jan-2018
                                                                        <br>
                                                                        08:10:32</td>
                                                                    <td>30-Jan-2018
                                                                        <br>
                                                                        08:10:32
                                                                    </td>
                                                                    <td><span class="text-success">OK</span>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end row-->
                                </div>
                                <!-- tab content-end-->
                                <div role="tabpanel" class="tab-pane" id="reward">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                                                <div class="search-box">
                                                    <asp:TextBox ID="txtRedeemSearch" runat="server" OnTextChanged="txtRedeemSearch_TextChanged" CssClass="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                                    <i class="fa fa-search"></i>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4" style="text-align: left; margin-top: 16px;">
                                            <div class="form-group">
                                                <%--<i class="fa fa-search"></i>--%>
                                                <asp:TextBox ID="txtRedeemFrDate" runat="server" CssClass="form-control startdate" placeholder="From date"></asp:TextBox>
                                                <%--<asp:TextBox ID="txtRedeemToDate" runat="server" CssClass="form-control startdate" placeholder="To Date"></asp:TextBox>--%>
                                            </div>
                                            
                                        </div>
                                        <div class="col-md-2" style="text-align: right; margin-top: 16px;">
                                            <asp:Button ID="btnRedeemSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnRedeemSearch_Click" />
                                        </div>
                                        <div class="gap gap-mid"></div>
                                        <div class="col-sm-12">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <asp:ListView ID="LvRewardPointDetails" runat="server" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1">
                                                            <LayoutTemplate>
                                                                <table id="table-list" class="table table-striped nowrap" width="100%" cellspacing="0">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Sl No.</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Transaction No</th>
                                                                            <th>Reward Points</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <GroupTemplate>
                                                                <tr>
                                                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                                                </tr>
                                                            </GroupTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td data-title="Sl No." style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                                                    <td data-title="Transaction Date"><%# Eval("transaction_time") %></td>
                                                                    <td data-title="Transaction No"><%# Eval("transaction_id") %></td>
                                                                    <td data-title="Reward Points"><%# Eval("Points_avlbl") %></td>
                                                                    <td data-title="Action" style="text-align: center;">
                                                                        <a href="#" class="btn btn-info btn-sm">view</a>
                                                                        <%--<asp:LinkButton ID="lnkView" ToolTip="View" OnClientClick="return confirm('Are you sure to mark this card as Lost?');" CssClass="btn btn-primary btn-xs" runat="server" CommandName="LOST"><i class="fa fa-pencil"></i></asp:LinkButton>--%>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <EmptyDataTemplate>
                                                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                                    <thead class="cf">
                                                                        <tr>
                                                                            <th>Sl No.</th>
                                                                            <th>Reward Points</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Transaction No</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td colspan="10" style="text-align: center;">No Reward points available for User!
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </EmptyDataTemplate>
                                                        </asp:ListView>
                                                    </div>
                                                    <span class="area-title bdr mt20">
                                                        <h2>Redemption History</h2>
                                                    </span>
                                                    <div class="gap gap-mid"></div>
                                                    <div class="table-responsive">
                                                        <asp:ListView ID="Lv_MyRedeemPoints" runat="server"
                                                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1">
                                                            <LayoutTemplate>
                                                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                                    <thead class="cf">
                                                                        <tr>
                                                                            <th>Sl No.</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Transaction No</th>
                                                                            <th>Redeem Points</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <GroupTemplate>
                                                                <tr>
                                                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                                                </tr>
                                                            </GroupTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td data-title="Sl No." style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                                                    <td data-title="Transaction Date"><%# Eval("redeem_date") %></td>
                                                                    <td data-title="Transaction No"><%# Eval("redeem_trans_id") %></td>
                                                                    <td data-title="Redeem Points"><%# Eval("redeem_points") %></td>
                                                                    <td data-title="Action" style="text-align: center;">
                                                                        <%--<asp:LinkButton ID="lnkView" ToolTip="View" OnClientClick="return confirm('Are you sure to mark this card as Lost?');" CssClass="btn btn-primary btn-xs" runat="server" CommandName="LOST"><i class="fa fa-pencil"></i></asp:LinkButton>--%>
                                                
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <EmptyDataTemplate>
                                                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                                    <thead class="cf">
                                                                        <tr>
                                                                            <th>Sl No.</th>
                                                                            <th>Redeem Points</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Transaction No</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td colspan="10" style="text-align: center;">No Redeem points available for User!
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </EmptyDataTemplate>
                                                        </asp:ListView>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end row-->
                                </div>
                                <!-- tab content-end-->
                                <div role="tabpanel" class="tab-pane active" id="retail">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="search-categori" style="box-shadow: 0 0 0 3px rgba(228, 228, 228, 1);">
                                                <div class="search-box">
                                                    <asp:TextBox ID="txtRetailSearch" runat="server" OnTextChanged="txtRetailSearch_TextChanged" CssClass="form-control input-sm active-part" placeholder="Enter your search key ... "></asp:TextBox>
                                                    <i class="fa fa-search"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4" style="text-align: left; margin-top: 16px;">
                                            <asp:TextBox ID="txtVoucherDateRange" runat="server" CssClass="form-control startdate" placeholder="Date Range"></asp:TextBox>
                                        </div>
                                        <div class="col-md-2" style="text-align: right; margin-top: 16px;">
                                            <asp:Button ID="btnRetailSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnRetailSearch_Click" />
                                        </div>
                                        <%--<div class="col-sm-12 mt20">
                                            <div class="form-inline">
                                                <div class="form-group">
                                                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="From date"></asp:TextBox>
                                                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="To Date"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>--%>
                                        <div class="gap gap-mid"></div>
                                        <div class="col-sm-12">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <span class="area-title bdr mt20">
                                                        <h2>Purchase History</h2>
                                                    </span>
                                                    <div class="table-responsive">
                                                        <asp:ListView ID="lsvRetail" runat="server" DataKeyNames="order_no" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemCommand="lsvRetail_ItemCommand" OnPagePropertiesChanging="lsvRetail_PagePropertiesChanging">
                                                            <LayoutTemplate>
                                                                <table id="table-list" class="table table-striped nowrap" width="100%" cellspacing="0">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Sl No</th>
                                                                            <th>Order No</th>
                                                                            <th>Order Amount</th>
                                                                            <th>Transaction No</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Transaction Status</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <div class="row">
                                                                    <div class="col-sm-12 text-right">
                                                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lsvRetail" PageSize="10">
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
                                                                <tr>
                                                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                                                </tr>
                                                            </GroupTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td data-title="Sl No"><%# Container.DataItemIndex + 1 %></td>
                                                                    <td data-title="order no"><%# Eval("order_no") %></td>
                                                                    <td data-title="trans amount"><%# Eval("trans_amount") %></td>
                                                                    <td data-title="trans id"><%# Eval("transaction_id") %></td>
                                                                    <td data-title="trans time"><%# Eval("transaction_time") %></td>
                                                                    <td data-title="trans status"><%# Eval("transaction_status") %></td>
                                                                    <td data-title="action">
                                                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="View" CssClass="btn btn-primary btn-xs" CommandName="View"><i class="fa fa-pencil"></i></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:ListView>
                                                    </div>

                                                </div>
                                            </div>
                                            <%--<div class="text-right">
                                                <nav>
                                                    <ul class="pagination">
                                                        <li>
                                                            <a href="#" aria-label="Previous">
                                                                <span aria-hidden="true">&laquo;</span>
                                                            </a>
                                                        </li>
                                                        <li class="active"><a href="#">1</a>
                                                        </li>
                                                        <li><a href="#">2</a>
                                                        </li>
                                                        <li><a href="#">3</a>
                                                        </li>
                                                        <li><a href="#">4</a>
                                                        </li>
                                                        <li><a href="#">5</a>
                                                        </li>
                                                        <li>
                                                            <a href="#" aria-label="Next">
                                                                <span aria-hidden="true">&raquo;</span>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </nav>
                                            </div>--%>
                                        </div>
                                    </div>
                                    <!-- end row-->
                                </div>
                                <!-- tab content-end-->
                                <div role="tabpanel" class="tab-pane" id="toll">
                                    <div class="row">
                                        <div class="col-sm-12 mt20">
                                            <div class="form-inline">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" placeholder="Search Keyword">
                                                </div>
                                                <button type="submit" class="btn btn-info">Search</button>
                                            </div>
                                        </div>
                                        <div class="gap gap-mid"></div>
                                        <div class="col-sm-12">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <asp:ListView ID="lsvTollPrepaid" runat="server" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1">
                                                            <LayoutTemplate>
                                                                <table id="table-list" class="table table-striped nowrap" width="100%" cellspacing="0">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Sl No</th>
                                                                            <th>Reg No</th>
                                                                            <th>RFID-Tag No</th>
                                                                            <th>Transaction Amount</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Location</th>
                                                                            <th>Transaction Status</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <GroupTemplate>
                                                                <tr>
                                                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                                                </tr>
                                                            </GroupTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td data-title="Sl No." style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                                                    <td data-title="Reg No"><%# Eval("REGISTRATIONNO") %></td>
                                                                    <td data-title="RFID-Tag No"><%# Eval("RFIDTAGNo") %></td>
                                                                    <td data-title="Transaction Amount"><%# Eval("TRANSACTIONAMOUNT") %></td>
                                                                    <td data-title="Transaction Date"><%# Eval("TRANSACTIONDATE") %></td>
                                                                    <td data-title="TLocation"><%# Eval("TRANSACTIONLOC") %></td>
                                                                    <td data-title="Transaction Status"><%# Eval("TRANSACTIONSTATUS") %></td>
                                                                    <td data-title="Action" style="text-align: center;">
                                                                        <%--<asp:LinkButton ID="lnkView" ToolTip="View" OnClientClick="return confirm('Are you sure to mark this card as Lost?');" CssClass="btn btn-primary btn-xs" runat="server" CommandName="LOST"><i class="fa fa-pencil"></i></asp:LinkButton>--%>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <EmptyDataTemplate>
                                                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                                    <thead class="cf">
                                                                        <tr>
                                                                            <th>Sl No</th>
                                                                            <th>Reg No</th>
                                                                            <th>RFID-Tag No</th>
                                                                            <th>Transaction Amount</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Location</th>
                                                                            <th>Transaction Status</th>
                                                                            <th>Action</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td colspan="10" style="text-align: center;">No Toll Transaction available for User!
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </EmptyDataTemplate>
                                                        </asp:ListView>
                                                    </div>
                                                </div>
                                            </div>

                                            <%--<div class="text-right">
                                                <nav>
                                                    <ul class="pagination">
                                                        <li>
                                                            <a href="#" aria-label="Previous">
                                                                <span aria-hidden="true">&laquo;</span>
                                                            </a>
                                                        </li>
                                                        <li class="active"><a href="#">1</a>
                                                        </li>
                                                        <li><a href="#">2</a>
                                                        </li>
                                                        <li><a href="#">3</a>
                                                        </li>
                                                        <li><a href="#">4</a>
                                                        </li>
                                                        <li><a href="#">5</a>
                                                        </li>
                                                        <li>
                                                            <a href="#" aria-label="Next">
                                                                <span aria-hidden="true">&raquo;</span>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </nav>
                                            </div>--%>
                                        </div>
                                    </div>
                                    <!-- end row-->
                                </div>
                                <!-- tab content-end-->
                                <div role="tabpanel" class="tab-pane" id="topup">
                                    <div class="row">
                                        <div class="col-sm-12 mt20">
                                            <div class="form-inline">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" placeholder="Search Keyword">
                                                </div>
                                                <button type="submit" class="btn btn-info">Search</button>
                                            </div>
                                        </div>
                                        <div class="gap gap-mid"></div>
                                        <div class="col-sm-12">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <asp:ListView ID="lsvTopup" runat="server" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1">
                                                            <LayoutTemplate>
                                                                <table id="table-list" class="table table-striped nowrap" width="100%" cellspacing="0">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Sl No</th>
                                                                            <th>Reg No</th>
                                                                            <th>RFID-Tag No</th>
                                                                            <th>Transaction Amount</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Trasaction Point</th>
                                                                            <th>Transaction Status</th>
                                                                            <%--<th>Action</th>--%>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <GroupTemplate>
                                                                <tr>
                                                                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
                                                                </tr>
                                                            </GroupTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td data-title="Sl No." style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                                                    <td data-title="Reg No"><%# Eval("REGISTRATIONNO") %></td>
                                                                    <td data-title="RFID-Tag No"><%# Eval("RFIDTAGNO") %></td>
                                                                    <td data-title="Transaction Amount"><%# Eval("TRANSACTIONAMOUNT") %></td>
                                                                    <td data-title="Transaction Date"><%# Eval("TRANSACTIONDATE") %></td>
                                                                    <td data-title="Trasaction Point"><%# Eval("TRANSACTIONPOINT") %></td>
                                                                    <td data-title="Transaction Status"><%# Eval("TRANSACTIONSTATUS") %></td>
                                                                    <%--<td data-title="Action" style="text-align: center;">
                                                                        <asp:LinkButton ID="lnkView" ToolTip="View" OnClientClick="return confirm('Are you sure to mark this card as Lost?');" CssClass="btn btn-primary btn-xs" runat="server" CommandName="LOST"><i class="fa fa-pencil"></i></asp:LinkButton>
                                                                    </td>--%>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <EmptyDataTemplate>
                                                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                                                    <thead class="cf">
                                                                        <tr>
                                                                            <th>Sl No</th>
                                                                            <th>Reg No</th>
                                                                            <th>RFID-Tag No</th>
                                                                            <th>Transaction Amount</th>
                                                                            <th>Transaction Date</th>
                                                                            <th>Trasaction Point</th>
                                                                            <th>Transaction Status</th>
                                                                            <%--<th>Action</th>--%>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td colspan="10" style="text-align: center;">No Topup available for User!
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </EmptyDataTemplate>
                                                        </asp:ListView>
                                                    </div>
                                                </div>
                                            </div>

                                            <%--<div class="text-right">
                                                <nav>
                                                    <ul class="pagination">
                                                        <li>
                                                            <a href="#" aria-label="Previous">
                                                                <span aria-hidden="true">&laquo;</span>
                                                            </a>
                                                        </li>
                                                        <li class="active"><a href="#">1</a>
                                                        </li>
                                                        <li><a href="#">2</a>
                                                        </li>
                                                        <li><a href="#">3</a>
                                                        </li>
                                                        <li><a href="#">4</a>
                                                        </li>
                                                        <li><a href="#">5</a>
                                                        </li>
                                                        <li>
                                                            <a href="#" aria-label="Next">
                                                                <span aria-hidden="true">&raquo;</span>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </nav>
                                            </div>--%>
                                        </div>
                                    </div>
                                    <!-- end row-->
                                </div>
                                <!-- tab content-end-->
                                <div role="tabpanel" class="tab-pane" id="transit">
                                    <div class="row">
                                        <div class="col-sm-12 mt20">
                                            <div class="form-inline">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" placeholder="Search Keyword">
                                                </div>
                                                <button type="submit" class="btn btn-info">Search</button>
                                            </div>
                                        </div>
                                        <div class="gap gap-mid"></div>
                                        <div class="col-sm-12">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <div class="table-responsive">
                                                        <table id="table-list" class="table table-striped nowrap" width="100%" cellspacing="0">
                                                            <thead>
                                                                <tr>
                                                                    <th>Sl No</th>
                                                                    <th>Reg No</th>
                                                                    <th>RFID-Tag No</th>
                                                                    <th>Transit Date</th>
                                                                    <th>Location</th>
                                                                    <th>Amount</th>
                                                                    <th>Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td>1</td>
                                                                    <td>OR02AZ6729</td>
                                                                    <td>80000000207</td>
                                                                    <td>30-Jan-2018 12:18:25 PM</td>
                                                                    <td>Sungai Besi</td>
                                                                    <td>2.30</td>
                                                                    <td><a href="#" class="btn btn-info btn-sm">view</a>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>1</td>
                                                                    <td>OR02AZ6729</td>
                                                                    <td>80000000207</td>
                                                                    <td>31-Jan-2018 10:18:25 AM</td>
                                                                    <td>Bangi</td>
                                                                    <td>2.30</td>
                                                                    <td><a href="#" class="btn btn-info btn-sm">view</a>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>1</td>
                                                                    <td>OR02AZ6729</td>
                                                                    <td>80000000207</td>
                                                                    <td>10-Jan-2018 02:18:25 AM</td>
                                                                    <td>Johar Baru</td>
                                                                    <td>4.30</td>
                                                                    <td><a href="#" class="btn btn-info btn-sm">view</a>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="text-right">
                                                <nav>
                                                    <ul class="pagination">
                                                        <li>
                                                            <a href="#" aria-label="Previous">
                                                                <span aria-hidden="true">&laquo;</span>
                                                            </a>
                                                        </li>
                                                        <li class="active"><a href="#">1</a>
                                                        </li>
                                                        <li><a href="#">2</a>
                                                        </li>
                                                        <li><a href="#">3</a>
                                                        </li>
                                                        <li><a href="#">4</a>
                                                        </li>
                                                        <li><a href="#">5</a>
                                                        </li>
                                                        <li>
                                                            <a href="#" aria-label="Next">
                                                                <span aria-hidden="true">&raquo;</span>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </nav>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end row-->
                                </div>
                                <!-- tab content-end-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- main area start -->
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
