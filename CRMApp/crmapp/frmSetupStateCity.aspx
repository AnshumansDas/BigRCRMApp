<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmSetupStateCity.aspx.cs" Inherits="CRMApp.crmapp.frmSetupStateCity" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function popupopen() {
           $("#AddStatecity").modal(open);
        }       
        function hidepopup() {
            $("#AddStatecity").modal("hide");
        }        

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Setup State and City</h2>
            </div>
            <div></div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
                         <div class="col-md-4" style="text-align: left; margin-top: 16px;">
                            <span id="message" runat="server" style="font-size: smaller;"></span>
                        </div>
                        <div class="col-md-2" style="text-align: right; margin-top: 16px;">
                            <asp:Button ID="btnadd" runat="server" OnClick="btnadd_Click" Text="Add New" class="btn btn-info"/>
                        </div>
                    </div>
                    <div class="gap-mid"></div>
                    <div>
                        <asp:ListView ID="lvStateCity" runat="server" DataKeyNames="city_id" OnItemCommand="lvStateCity_ItemCommand" OnPagePropertiesChanging="lvStateCity_PagePropertiesChanging"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvStateCity_ItemDataBound" OnItemEditing="lvStateCity_ItemEditing">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%; text-align: center;">No</th>
                                            <th style="width: 20%;text-align: center;">State Name</th>
                                            <th style="width: 45%;text-align: center;">City Name</th>
                                            <th style="width: 15%; text-align: center;">Active Status</th>
                                            <th style="width: 15%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvStateCity" PageSize="10">
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
                                    <td style="text-align: center;""><%# Eval("state_name") %></td>
                                    <td style="text-align: center;""><%# Eval("city_name").ToString().Trim() %></td>
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
                                            <th style="width: 20%;text-align: center;">State Name</th>
                                            <th style="width: 45%; text-align: center;">City Name</th>
                                            <th style="width: 15%; text-align: center;">Active Status</th>
                                            <th style="width: 15%; text-align: center;">Action</th>
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
    
    <div id="AddStatecity" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">Add/Edit Setup State city</h4>

                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpAddStatecity" runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-12">
                                        State Name<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvState" InitialValue="0" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="ddlState" ValidationGroup="submitValSetupStateCity" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-12">
                                        <asp:DropDownList ID="ddlState" CssClass="form-control" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-12">
                                        City Name<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvCity" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="txtCity" ValidationGroup="submitValSetupStateCity" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-12">
                                        <asp:TextBox ID="txtCity" runat="server" name="city" CssClass="form-control" placeholder="City name"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-12">
                                        Active Status<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvActiveStatus" InitialValue="" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="ddlActiveStatus" ValidationGroup="submitValSetupStateCity" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-12">
                                        <asp:DropDownList ID="ddlActiveStatus" CssClass="form-control" AutoPostBack="true" runat="server">
                                            <asp:ListItem Value="" Text="-Select-"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="0" Text="In-Active"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>

                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <div class="form-group">
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-action" OnClick="btnCancel_Click" />
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnSave_Click" ValidationGroup="submitValSetupStateCity" />
                                            <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />
                                        </div>
                                    </div>                                    
                                </div>

                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    </div>
</asp:Content>
