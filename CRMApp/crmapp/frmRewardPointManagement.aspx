<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmRewardPointManagement.aspx.cs" Inherits="CRMApp.crmapp.frmRewardPointManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <script type="text/javascript">   
         function onlyDotsAndNumbers(txt, event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if (charCode == 46) {
                if (txt.value.indexOf(".") < 0)
                    return true;
                else
                    return false;
            }

            if (txt.value.indexOf(".") > 0) {
                var txtlen = txt.value.length;
                var dotpos = txt.value.indexOf(".");
                //Change the number here to allow more decimal points than 2
                if ((txtlen - dotpos) > 2)
                    return false;
            }

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
        function popupReward() {
            $("#AddRewardpoint").modal(open).find('.datepicker').datepicker({locale: {format: 'DD/MM/YYYY'}});
        }
        function hidepopupReward() {
            $("#AddRewardpoint").modal("hide");
        }
           

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <!--col-md-3-->
        <div class="col-sm-12">
            <div class="area-title bdr mt20">                
                <h2>REWARD POINT SETUP</h2>
              </div>
        </div>
        <asp:UpdatePanel ID="upRewardPoint" runat="server">
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
                            <asp:TextBox ID="txtVoucherDateRange" runat="server" CssClass="form-control startdate" placeholder="Date Range"></asp:TextBox>
                        </div>
                        <div class="col-md-2" style="text-align: right; margin-top: 16px;">
                            <asp:Button ID="BtnSearch" CssClass="btn btn-primary" OnClick="BtnSearch_Click" runat="server" Text="Search" />
                            <asp:Button ID="btnadd" runat="server" OnClick="btnadd_Click" Text="Add New" class="btn btn-info" />
                        </div>
                    </div>
                   <div class="col-sm-12 pull-right">
                        <span id="lblMsg" runat="server"></span>
                   </div>
                    <div class="gap-mid"></div>
                    <div>
                        <asp:ListView ID="lsvReward" runat="server" GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" DataKeyNames="reward_id"
                            OnItemCommand="lsvReward_ItemCommand" OnItemEditing="lsvReward_ItemEditing" OnPagePropertiesChanging="lsvReward_PagePropertiesChanging" OnItemDataBound="lsvReward_ItemDataBound">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
                                <table id="table-list" class="table table-striped nowrap" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Transaction Amount</th>
                                            <th>Reward Points</th>
                                            <th>Effective Date Range</th>
                                            <th>Created Date</th>
                                            <th>Created By</th>
                                            <th>Active Status</th>
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
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lsvReward" PageSize="10">
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
                                    <td data-title="Date"><%# Eval("transaction_amount") %></td>
                                    <td data-title="Sl No."><%# Eval("reward_points") %></td>
                                    <td data-title="Sl No."><%# Eval("effective_start_dt") %> TO <%# Eval("effective_end_dt") %></td>
                                    <td data-title="Sl No."><%# Eval("created_date") %></td>
                                    <td data-title="Sl No."><%# Eval("created_by") %></td>
                                    <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("active_status").ToString().Trim() %></span></td>
                                    <%--<td data-title="Sl No."><%# Eval("active_status") %></td>--%>
                                    <td style="text-align: center;">
                                        <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Content" CssClass="btn btn-primary btn-xs" CommandName="Edit">Edit</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <table id="pagination" class="col-md-12 table-striped table-bordered table-condensed cf">
                                    <thead class="cf">
                                        <tr>
                                            <th>Sl No</th>
                                            <th>Transaction Amount</th>
                                            <th>Reward Points</th>
                                            <th>Effective Date Range</th>
                                            <th>Created Date</th>
                                            <th>Created By</th>
                                            <th>Active Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="8" style="text-align: center;">No Reward Points Sets
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="AddRewardpoint" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">Add/Edit Reward points</h4>

                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpAddStatecity" runat="server">
                        <ContentTemplate>

                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-12">
                                        Transaction Amount
                                    <span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvState" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="txtTransAmt" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-12" style="margin-bottom: -5px;">
                                        <asp:TextBox ID="txtTransAmt" CssClass="form-control" runat="server" placeholder="Transaction Amount"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-sm-12">
                                        Reward Points<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvReward" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="txtReward" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-12">
                                        <asp:TextBox ID="txtReward" CssClass="form-control" runat="server" placeholder="Reward Points"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-sm-12">
                                        Start Date
                                    <span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvstartdate" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="txtStartDate" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-12">
                                        <div class="input-group date" id="startdate">
                                            <asp:TextBox ID="txtStartDate" runat="server" class="form-control datepicker" placeholder="Start Date"></asp:TextBox>
                                            <span class="input-group-addon" id="sample"><i class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-sm-12">
                                        End Date
                                   <span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvenddate" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="txtEndDate" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-12">
                                        <div class="input-group date" id="enddate">
                                            <asp:TextBox ID="txtEndDate" runat="server" class="form-control datepicker" placeholder="End Date"></asp:TextBox>
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-sm-12">
                                        Active Status
                                                 <span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvActive" InitialValue="" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="ddlActiveStatus" ValidationGroup="submitValue" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-12">
                                        <asp:DropDownList ID="ddlActiveStatus" runat="server" class="form-control">
                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                            <asp:ListItem Value="1">Active</asp:ListItem>
                                            <asp:ListItem Value="0">In Active</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <div class="form-group">
                                            <asp:Button ID="btncancel" OnClick="btnCancel_Click" runat="server" Text="Cancel" CssClass="btn btn-action" />
                                            <asp:Button ID="btnsave" OnClick="btnSave_Click" ValidationGroup="submitValue" CssClass="btn btn-success" runat="server" Text="Save" />
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

</asp:Content>
