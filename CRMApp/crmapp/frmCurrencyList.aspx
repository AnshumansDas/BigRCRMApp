<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmCurrencyList.aspx.cs" Inherits="CRMApp.crmapp.frmCurrencyList" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/Javascript">
      
        function popupcurrencyshow() {
            $("#AddNewCurrency").modal(open).find('.datepicker1,.datepicker2').datepicker({ locale: { format: 'DD/MM/YYYY' } });
        }
        function hidepopup() {
            $("#AddNewCurrency").modal("hide");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Currency Setup</h2>
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
                        <div class="col-md-2" style="text-align: right; margin-top: 16px;">
                            <asp:Button ID="btnadd" runat="server" OnClick="btnadd_Click" Text="Add New" class="btn btn-info"/>
                        </div>
                    </div>
                    <div class="gap-mid"></div>
                    <div>
                        <asp:ListView ID="lvCurrency" runat="server" DataKeyNames="currency_id" OnItemCommand="lvCurrency_ItemCommand" OnPagePropertiesChanging="lvCurrency_PagePropertiesChanging"
                            GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvCurrency_ItemDataBound" OnItemEditing="lvCurrency_ItemEditing">
                            <LayoutTemplate>
                                <div class="row">
                                    <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                                </div>
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
                                        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-12 text-right">
                                        <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvCurrency" PageSize="10">
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
                                    <td style="text-align: center;""><%# Eval("currency_type") %></td>
                                    <td style="text-align: center;""><%# Eval("point").ToString().Trim() %></td>
                                      <td style="text-align: center;""><%# Eval("amount") %></td>
                                    <td style="text-align: center;""><%# Eval("min_point").ToString().Trim() %></td>
                                      <td style="text-align: center;""><%# Eval("max_point") %></td>
                                    <td style="text-align: center;""><%# Eval("startdate").ToString().Trim() %></td>
                                      <td style="text-align: center;""><%# Eval("enddate") %></td>
                                    <td style="text-align: center;""><%# Eval("created_by").ToString().Trim() %></td>
                                    <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("status").ToString().Trim() %></span></td>
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
    <div id="AddNewCurrency" class="modal fade flat-box login-form" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">Add/Edit Currency setup</h4>
                </div>
                <div class="modal-body">                     
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-4">
                                        Currency Type<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="rfvState" InitialValue="0" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="ddlCurrency" ValidationGroup="submitValCurrencyList" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlCurrency" CssClass="form-control" OnSelectedIndexChanged="ddlCurrency_SelectedIndexChanged" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                             <div class="form-group">
                                <div class="row"> <label class="col-sm-2">
                                        Convert<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="txtConvert" ValidationGroup="submitValCurrencyList" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtConvert" runat="server" name="city" CssClass="form-control" placeholder="Point"></asp:TextBox>
                                    </div>
                                     <label class="col-sm-2">
                                        To<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="txtAmount" ValidationGroup="submitValCurrencyList" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtAmount" runat="server" name="Amount" CssClass="form-control" placeholder="Amount"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                             <div class="form-group">
                                <div class="row"> <label class="col-sm-2">
                                        Minimum<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="Txtmin" ValidationGroup="submitValCurrencyList" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="Txtmin" runat="server" name="Minimum" CssClass="form-control" placeholder="Minimum"></asp:TextBox>
                                    </div>
                                     <label class="col-sm-2">
                                        Maximum<span style="font-size: smaller; color: red;">&#42;</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" Font-Size="xx-small" ControlToValidate="Txtmax" ValidationGroup="submitValCurrencyList" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </label>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="Txtmax" runat="server" name="Maximum" CssClass="form-control" placeholder="Maximum"></asp:TextBox>
                                    </div>
                                </div>
                            </div> 
                          
                             <div class="form-group">
                                <div class="row">                              
                                 <label for="inputEmail3" class="col-sm-4 control-label">Start Date <span style="font-size: smaller; color: red;">&#42;</span></label>                               
                                    <div class="col-sm-8">
                                        <div class="input-group date" id="startdate">
                                              <asp:TextBox ID="TxtStart" runat="server" CssClass="form-control datepicker1" placeholder="start date"></asp:TextBox>
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                              </div>
                            <div class="form-group">
                                <div class="row"> 
                                      <label for="inputEmail3" class="col-sm-4 control-label">End Date <span style="font-size: smaller; color: red;">&#42;</span></label>
                                        <div class="col-sm-8">
                                            <div class="input-group date" id="enddate">
                                                   <asp:TextBox ID="TxtEnd" runat="server" CssClass="form-control datepicker2" placeholder="end date"></asp:TextBox>
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>
                                        </div>                                  
                                </div>
                            </div>   
                             </ContentTemplate>
                       </asp:UpdatePanel>   
                              <div class="form-group">
                                 <div class="row">
                                 <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                    <div class="col-md-6">
                                   <span id="message" runat="server" style="font-size: smaller;"></span>
                                   </div>
                                        
                                    <div class="col-sm-6 text-right">
                                        <div class="form-group">
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-action" OnClick="btnCancel_Click" />
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnSave_Click" ValidationGroup="submitValCurrencyList" />
                                            <%--<asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="error" ShowMessageBox="true" ShowSummary="false" />--%>
                                        </div>
                                    </div>  
                                  </ContentTemplate>
                                </asp:UpdatePanel> 
                                </div>
                               
                            </div>
                              
                  </div>

            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
   
</asp:Content>


