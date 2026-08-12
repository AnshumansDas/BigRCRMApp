<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMemberHelpdesk.aspx.cs" Inherits="CRMApp.crmapp.frmMemberHelpdesk" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content runat="server" ID="Memberhead" ContentPlaceHolderID="head">
    <script type="text/javascript">
        function PrintMemberHelpDesc() {
            var prntData = document.getElementById('<%= pnlgridview.ClientID %>');
            var prntWindow = window.open("_self");
            prntWindow.document.write('<html><head><title>BigR - Member Helpdesk Report</title><br/>');
            prntWindow.document.write(prntData.innerHTML);
            prntWindow.document.write('</head></html>');
            prntWindow.document.close();
            prntWindow.focus();
            prntWindow.print();
            prntWindow.close();
        }

    </script>

</asp:Content>
<asp:Content runat="server" ID="cMerchant" ContentPlaceHolderID="body">
    <asp:UpdatePanel runat="server" ID="upMerchant">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-12">
                    <div class="area-title bdr mt20">
                        <h2>Member Listing</h2>
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
                        <div class="col-md-6" style="text-align: right; margin-top: 10px;">
                            <asp:LinkButton ID="lnkPrint" runat="server" ToolTip="Click to Print All Records" Text="Print Data" CssClass="btn btn-primary btn-xs" OnClick="lnkPrint_Click"></asp:LinkButton>
                            <asp:LinkButton ID="lnkexport" runat="server" OnClick="lnkexport_click" CssClass="btn btn-primary btn-xs" Text="Export To Excel"></asp:LinkButton>
                        </div>
                    </div>
                    <div>
                        <asp:ListView ID="lvMember" runat="server" DataKeyNames="userlogin_id,email_id" OnItemCommand="lvMember_ItemCommand"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="lvMember_PagePropertiesChanging" OnItemDataBound="lvMember_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 10%; text-align: center;">Membership No</th>
                                            <th style="width: 10%; text-align: center;">First Name</th>
                                            <th style="width: 10%; text-align: center;">Last Name</th>
                                            <th style="width: 5%; text-align: center;">Mobile Phone</th>
                                            <th style="width: 10%; text-align: center;">Email</th>
                                            <th style="width: 10%; text-align: center;">State</th>
                                            <th style="width: 10%; text-align: center;">Joined Date</th>
                                            <th style="width: 10%; text-align: center;">Update Date</th>
                                            <th style="width: 10%; text-align: center;">Update By</th>
                                            <th style="width: 10%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvMember" PageSize="10">
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
                                    <td style="text-align: center;"><%# Eval("membership_no") %></td>
                                    <td style="text-align: center;"><%# Eval("user_fistname").ToString().Trim() %></td>
                                    <td style="text-align: center;"><%# Eval("user_lastname") %></td>
                                    <td style="text-align: center;"><%# Eval("mobile_no") %></td>
                                    <td style="text-align: center;"><%# Eval("email_id") %></td>
                                    <td style="text-align: center;"><%# Eval("state_name") %></td>
                                    <td style="text-align: center;"><%# Eval("joined_date") %></td>
                                    <td style="text-align: center;"><%# Eval("updated_date") %></td>
                                    <td style="text-align: center;"><%# Eval("updated_by") %></td>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkResetPassword" runat="server" ToolTip="Reset Password" CssClass="btn btn-primary btn-xs" CommandName="Edit">Reset Password</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 10%; text-align: center;">Membership No</th>
                                            <th style="width: 10%; text-align: center;">First Name</th>
                                            <th style="width: 10%; text-align: center;">Last Name</th>
                                            <th style="width: 5%; text-align: center;">Mobile Phone</th>
                                            <th style="width: 10%; text-align: center;">Email</th>
                                            <th style="width: 10%; text-align: center;">State</th>
                                            <th style="width: 10%; text-align: center;">Joined Date</th>
                                            <th style="width: 10%; text-align: center;">Update Date</th>
                                            <th style="width: 10%; text-align: center;">Update By</th>
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
                    <asp:Panel runat="server" ID="pnlgridview" Style="display: none">
                        <asp:GridView ID="ExportGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:TemplateField HeaderText="No" ItemStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="membership_no" HeaderText="Membership No" SortExpression="Membership No" />
                                <asp:BoundField DataField="user_fistname" HeaderText="First Name" SortExpression="First Name" />
                                <asp:BoundField DataField="user_lastname" HeaderText="Last Name" SortExpression="Last Name" />
                                <asp:BoundField DataField="mobile_no" HeaderText="Mobile Phone" SortExpression="Mobile No" />
                                <asp:BoundField DataField="email_id" HeaderText="Email" SortExpression="Email" />
                                <asp:BoundField DataField="state_name" HeaderText="State" SortExpression="State" />
                                <asp:BoundField DataField="joined_date" HeaderText="Joined Date" SortExpression="Joined Date" />
                                <asp:BoundField DataField="updated_date" HeaderText="Update Date" SortExpression="Update Date" />
                                <asp:BoundField DataField="updated_by" HeaderText="updated By" SortExpression="Update By" />
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </asp:Panel>
                    <%-- <input type="button" value="Print" runat="server" onclick="Print();" />--%>
                    <%-- <asp:Button ID="btnPrint" runat="server" Text="Print" OnClientClick="Print();" />--%>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="lnkexport" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
