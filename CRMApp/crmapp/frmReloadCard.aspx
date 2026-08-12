<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmReloadCard.aspx.cs" Inherits="CRMApp.crmapp.frmReloadCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>Card Reload History</h2>
        </div>
        <div></div>
    </div>
    <asp:UpdatePanel ID="upVoucheList" runat="server">
        <ContentTemplate>
            <div class="form-horizontal">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="inputCardNo" class="col-sm-3 control-label">Reload Amount</label>
                        <div class="col-sm-7">
                            <asp:TextBox ID="txtReloadAmount" runat="server" CssClass="form-control"></asp:TextBox>
                            <span style="font-family: Verdana, Geneva, Tahoma, sans-serif; font-size: smaller; font-style: oblique; color: red">Additional transaction fee RM.<asp:Label ID="lbltransactionFee" runat="server" Text=""></asp:Label>&nbsp;will be charged</span>
                        </div>
                        <div class="col-sm-2">
                            <asp:RequiredFieldValidator ID="rfvReloadAmt" runat="server" CssClass="required" ControlToValidate="txtReloadAmount" ValidationGroup="submitReload" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputTopup" class="col-sm-3 control-label">Mode Of Payment<span style="font-size: smaller; color: red;">&#42;</span></label>
                        <div class="col-sm-7">
                            <asp:DropDownList ID="ddlPaymentMode" CssClass="form-control" runat="server">
                                <asp:ListItem Value="0">-Please select-</asp:ListItem>
                                <asp:ListItem Value="FPX">FPX</asp:ListItem>
                                <asp:ListItem Value="CC">Master / Visa</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-2">
                            <asp:RequiredFieldValidator ID="rfvpaymentMode" runat="server" CssClass="required" ControlToValidate="ddlPaymentMode" InitialValue="0" ValidationGroup="submitReload" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-3 control-label">Select Amount<span style="font-size: smaller; color: red;">&#42;</span></label>
                        <div class="col-sm-9">
                            <div>
                                <asp:ImageButton ID="d10" runat="server" ImageUrl="~/crmapp/img/card-rm10.jpg" ToolTip="Reload RM 10" OnClick="d10_Click" />

                                <asp:ImageButton ID="d30" runat="server" ImageUrl="~/crmapp/img/card-rm30.jpg" ToolTip="Reload RM 20" OnClick="d30_Click" />

                                <asp:ImageButton ID="d50" runat="server" ImageUrl="~/crmapp/img/card-rm50.jpg" ToolTip="Reload RM 50" OnClick="d50_Click" />

                                <asp:ImageButton ID="d100" runat="server" ImageUrl="~/crmapp/img/card-rm100.jpg" ToolTip="Reload RM 100" OnClick="d100_Click" />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="form-group">
        <div class="col-sm-12 text-right">
            <%--<asp:Button ID="btnCancel" runat="server" Text="Back" CssClass="btn btn-action" OnClick="btnCancel_Click" />--%>
            <asp:Button ID="btnReload" runat="server" Text="Reload" ValidationGroup="submitReload" CssClass="btn btn-info" OnClick="btnSave_Click" />
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="col-sm-12">
                <div class="row">
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
                        <asp:ListView ID="lvBigrReload" runat="server" DataKeyNames="rfid_tag_no" OnItemCommand="lvBigrReload_ItemCommand" OnPagePropertiesChanging="lvBigrReload_PagePropertiesChanging"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvBigrReload_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 15%;">Card No</th>
                                            <th style="width: 15%;">Mifare card No</th>
                                            <th style="width: 15%;">Membership Card No</th>
                                            <th style="width: 15%;">Transaction No</th>
                                            <th style="width: 15%;">Transaction Date</th>
                                            <th style="width: 10%;">Reload Amount</th>
                                            <th style="width: 10%; text-align: left;">Status</th>
                                            <%--<th style="width: 5%; text-align: center;">Action</th>--%>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvBigrReload" PageSize="10">
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
                                    <td style="text-align: left;">
                                        <asp:Image ID="imgCard" runat="server" Width="30px" Height="20px" ImageUrl="~/crmapp/img/BigR_memberCardBlank.png" />
                                        <%--<%# Eval("rfid_tag_no") %>--%>
                                        <%# Eval("membership_cardno")%>
                                    </td>
                                    <td style="text-align: left;"><%# Eval("mifare_CardNo").ToString().Trim() %></span></td>
                                    <td style="text-align: left;"><%# Eval("membership_cardno").ToString().Trim() %></span></td>
                                    <td style="text-align: left;"><%# Eval("transaction_no").ToString().Trim() %></span></td>
                                    <td style="text-align: left;"><%# Eval("transaction_date").ToString().Trim() %></span></td>
                                    <td style="text-align: left;"><%# Eval("transaction_amount").ToString().Trim() %></span></td>
                                    <td style="text-align: left;"><span id="colorstatus" runat="server"><%# Eval("transaction_status").ToString().Trim() %></span></td>
                                    <%--<td style="text-align: center;">
                                    <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Voucher" CssClass="btn btn-primary btn-xs" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                                </td>--%>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 15%;">Card No</th>
                                            <th style="width: 15%;">Mifare card No</th>
                                            <th style="width: 15%;">Membership Card No</th>
                                            <th style="width: 15%;">Transaction No</th>
                                            <th style="width: 15%;">Transaction Date</th>
                                            <th style="width: 10%;">Reload Amount</th>
                                            <th style="width: 10%; text-align: left;">Status</th>
                                            <%--<th style="width: 5%; text-align: center;">Action</th>--%>
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
