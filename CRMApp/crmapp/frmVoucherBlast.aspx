<%@ Page Title="" Language="C#" MasterPageFile="~/crmapp/CRMBack.Master" AutoEventWireup="true" CodeBehind="frmVoucherBlast.aspx.cs" Inherits="CRMApp.crmapp.frmVoucherBlast" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /** SPINNER CREATION **/
        .loader {
            position: relative;
            text-align: center;
            margin: 15px auto 35px auto;
            z-index: 9999;
            display: block;
            width: 80px;
            height: 80px;
            border: 10px solid rgba(0, 0, 0, 0.3);
            border-radius: 50%;
            border-top-color: blue;
            animation: spin 1s ease-in-out infinite;
            -webkit-animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to {
                -webkit-transform: rotate(360deg);
            }
        }

        @-webkit-keyframes spin {
            to {
                -webkit-transform: rotate(360deg);
            }
        }
    </style>
    <script type='text/javascript'>

        //function openLoader() {

        //    $("#loadMe").modal({
        //        backdrop: "static", //remove ability to close modal with click
        //        keyboard: false, //remove option to close with keyboard
        //        show: true //Display loader!
        //    });
        //    /* setTimeout(function() {
        //         $("#loadMe").modal("hide");
        //         //hideLoader();
        //   }, 7500);
        //    */

        //}
        function openLoader() {
             
                $("#loadMe").modal({
                  backdrop: "static", //remove ability to close modal with click
                  keyboard: false, //remove option to close with keyboard
                  show: true //Display loader!
                });
                setTimeout(function() {
                  $("#loadMe").modal("hide");
                    $("#success").modal({
                      backdrop: "static", //remove ability to close modal with click
                      keyboard: false, //remove option to close with keyboard
                      show: true //Display loader!
                    });
                     location.reload(true);
                }, 300000);
            
              
         }



        function hideLoader() {
            //alert("loader hide");
            // e.preventDefault();
            $("#loadMe").modal("hide");

            $("#success").modal({
                backdrop: "static", //remove ability to close modal with click
                keyboard: false, //remove option to close with keyboard
                show: true //Display loader!
            });
            setTimeout(function () {
                location.reload(true);
            }, 4000);

        }
        function hideLoader1() {

            $("#loadMe").modal("hide");
            $("#error").modal({
                backdrop: "static", //remove ability to close modal with click
                keyboard: false, //remove option to close with keyboard
                show: true //Display loader!
            });
            setTimeout(function () {
                location.reload(true);
            }, 4000);

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-sm-12">
        <div class="area-title bdr mt20">
            <h2>Voucher Lists</h2>
        </div>
        <div></div>
    </div>

    <asp:UpdatePanel ID="upVoucheList" runat="server">
        <ContentTemplate>
            <div class="col-sm-12">
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

                <div class="row">
                    <div class="col-sm-6">
                        <br />
                        <asp:LinkButton ID="btnBlastEmail" runat="server" Text="BlastEmail" CssClass="btn btn-success pull-left just_load_please" OnClick="btnBlastEmail_Click" OnClientClick="openLoader();" />
                        <%--<asp:LinkButton ID="btnBlastEmail" runat="server" Text="BlastEmail" CssClass="btn btn-success pull-left just_load_please" OnClick="btnBlastEmail_Click" />--%>
                        <div>
                            <b>&nbsp;&nbsp;&nbsp;&nbsp;
                          <span id="ValidMsg" runat="server" style="font-size: smaller; color: green;"></span>

                            </b>
                        </div>

                    </div>
                </div>
                <div class="col-sm-4" style="text-align: right; margin-top: 16px;">
                    <span id="invalidmsg" runat="server" style="font-size: smaller;"></span>
                    <%-- <span id="checkexistedemail" runat="server" style="font-size: smaller;"></span>--%>
                </div>
                <div>
                    <asp:ListView ID="lvVoucherList" runat="server" DataKeyNames="voucher_id" OnItemCommand="lvVoucherList_ItemCommand" OnPagePropertiesChanging="lvVoucherList_PagePropertiesChanging"
                        GroupPlaceholderID="groupPlaceHolder1" ItemPlaceholderID="itemPlaceHolder1" OnItemDataBound="lvVoucherList_ItemDataBound">
                        <LayoutTemplate>
                            <div class="row">
                                <label class="col-sm-12 text-right">Total Record : <span id="totalrecord" runat="server" class="label label-primary"></span></label>
                            </div>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">Select All</th>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 15%;">Merchant Name</th>
                                        <th style="width: 15%; text-align: left;">Voucher Name</th>
                                        <th style="width: 12%; text-align: center;">Voucher Category</th>
                                        <th style="width: 5%; text-align: center;">Quantity</th>
                                        <th style="width: 10%; text-align: center;">Original Price</th>
                                        <th style="width: 10%; text-align: center;">Discount Price</th>
                                        <th style="width: 10%; text-align: center;">Voucher Fee</th>
                                        <th style="width: 10%; text-align: center;">Active Status</th>
                                        <th style="width: 10%; text-align: center;">Email</th>

                                        <th style="width: 8%; text-align: center;">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-12 text-right">
                                    <asp:DataPager ID="DataPager1" runat="server" class="btn-group btn-group-sm" PagedControlID="lvVoucherList" PageSize="10">
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
                                <td style="text-align: center;">
                                    <asp:CheckBox ID="checkslct" runat="server" /></td>
                                <td style="text-align: center;"><%# Container.DataItemIndex + 1 %></td>
                                <td><%# Eval("organization_name") %></td>
                                <td style="text-align: left;"><span id="VoucherName" runat="server"><%# Eval("voucher_name")%></span></td>
                                <td style="text-align: left;"><%# Eval("voucher_main_category") %></td>
                                <td style="text-align: center;"><%# Eval("qty")%></span></td>
                                <td style="text-align: center;"><span id="OriginalPrice" runat="server"><%# Eval("original_price") %></span></td>
                                <td style="text-align: center;"><span id="DiscountPrice" runat="server"><%# Eval("discount_price") %></span></td>
                                <td style="text-align: center;"><%# Eval("voucher_fee")%></td>
                                <td style="text-align: center;"><span id="colorstatus" runat="server"><%# Eval("active_status").ToString().Trim() %></span></td>
                                <td style="text-align: center;"><span id="lblEmail" runat="server"><%# Eval("email")%></span></td>
                                <td style="text-align: center;">
                                    <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit Voucher" CssClass="btn btn-primary btn-xs" CommandName="Edit"><i class="fa fa-pencil"></i></asp:LinkButton>
                                    <%--<asp:LinkButton ID="lnkDelete" runat="server" ToolTip="Delete Voucher" CssClass="btn btn-primary btn-xs" CommandName="Delete"><i class="fa fa-trash"></i></asp:LinkButton>--%>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table class="table table-striped" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 5%; text-align: center;">No</th>
                                        <th style="width: 15%;">Merchant Name</th>
                                        <th style="width: 15%; text-align: left;">Voucher Name</th>
                                        <th style="width: 12%; text-align: center;">Voucher Category</th>
                                        <th style="width: 5%; text-align: center;">Quantity</th>
                                        <th style="width: 10%; text-align: center;">Original Price</th>
                                        <th style="width: 10%; text-align: center;">Discount Price</th>
                                        <th style="width: 10%; text-align: center;">Voucher Fee</th>
                                        <th style="width: 10%; text-align: center;">Active Status</th>
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
        </ContentTemplate>
    </asp:UpdatePanel>
    <!-- Modal -->
    <div class="modal fade" id="loadMe" tabindex="-1" role="dialog" aria-labelledby="loadMeLabel">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-body text-center">
                    <div class="loader"></div>
                    <div clas="loader-txt">
                        <p>Please Wait...</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <!-- Modal -->
    <div class="modal fade" id="success" tabindex="-1" role="dialog" aria-labelledby="loadMeLabel">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-body text-center">
                    <p>Promotion email has been successfully sending</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <!-- Modal -->
    <div class="modal fade" id="error" tabindex="-1" role="dialog" aria-labelledby="loadMeLabel">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-body text-center">
                    <p>Allowed only 2 vouchers at a time</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
</asp:Content>
