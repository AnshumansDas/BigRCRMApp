<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmGenerateQRcode.aspx.cs" Inherits="CRMApp.crmapp.frmGenerateQRcode" MasterPageFile="~/crmapp/CRMBack.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function PrintPanelData() {
            var prtGrid = document.getElementById('<%=pnlQrCode.ClientID %>');
            prtGrid.border = 0;
            var prtwin = window.open('', 'PrintPanelData', 'left=100,top=100,width=1500,height=800,tollbar=0,scrollbars=1, status=0,resizable=1');
            prtwin.document.write(prtGrid.outerHTML);
            prtwin.document.close();
            prtwin.focus();
            prtwin.print();
            prtwin.close();
        }
    </script>
</asp:Content>
<asp:Content ID="CtQrPayMerchReport" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="area-title bdr mt20">
                <h2>Generate QR Code</h2>
                <span id="message" runat="server" style="font-size: smaller;"></span>
            </div>
        </div>
        <div class="col-sm-12">
            <div class="form-horizontal">
                <asp:UpdatePanel runat="server" ID="upMerchant">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-md-12" style="text-align: center;">
                                <asp:Panel ID="pnlQrCode" runat="server">
                                    <asp:PlaceHolder ID="phQrcode" runat="server"></asp:PlaceHolder>
                                </asp:Panel>
                            </div>
                            <div class="col-md-12" style="text-align: center;">
                                <div class="form-group">
                                    <asp:Button ID="btnGenerateQrCode" CssClass="btn btn-info" OnClick="btnGenerateQrCode_Click" runat="server" Text="Generate QR" />
                                    <input id="btnPrint" type="button" value="Print QR Code" class="btn btn-success" onclick="PrintPanelData();" />
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
