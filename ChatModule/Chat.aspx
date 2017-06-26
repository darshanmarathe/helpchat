<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Chat.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 177px;
        }
        .style5
        {
            width: 244px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/logo.gif" />
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" DynamicLayout="False">
                    <ProgressTemplate>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
              <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/ajax-loader.gif" 
                            Width="39px" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
          
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
       
                <caption>
                    <asp:Panel ID="LoginPanel" runat="server" Visible="true">
                          <h2 "color:white" style="background-color:Gray; color: #000000; font-style: normal; height: 33px; width:400px">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Client Login
                    </h2>
                     
                        <table title="Client Login">
                            <caption>
                                <tr>
                                    <td class="style1">
                                        <asp:Label ID="lblEmailId" runat="server" Text="EmailId">
                                </asp:Label>
                                    </td>
                                    <td class="style5">
                                        <asp:TextBox ID="txtEmailId" runat="server" Height="28px" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rvEmaiId" runat="server" 
                                            ControlToValidate="txtEmailId" ErrorMessage="Please Enter EmailAddress" 
                                            ForeColor="Red" ValidationGroup="logClient">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RvRegularExpEmail" runat="server" 
                                            ControlToValidate="txtEmailId" ErrorMessage="Please Enter Vaild EmailId" 
                                            ForeColor="Red" 
                                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                            ValidationGroup="logClient">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style1">
                                        <asp:Label ID="lblFirstName" runat="server" Text="First Name">
                                </asp:Label>
                                    </td>
                                    <td class="style5">
                                        <asp:TextBox ID="txtFirstName" runat="server" Height="28px" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rvFirstName" runat="server" 
                                            ControlToValidate="txtFirstName" ErrorMessage="Please Enter FirstName" 
                                            ForeColor="Red" ValidationGroup="logClient">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style1">
                                        <asp:Label ID="lblLastName" runat="server" Text="Last Name">
                                </asp:Label>
                                    </td>
                                    <td class="style5">
                                        <asp:TextBox ID="txtLastName" runat="server" Height="28px" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rvLastName" runat="server" 
                                            ControlToValidate="txtLastName" ErrorMessage="Please Enter LastName" 
                                            ForeColor="Red" ValidationGroup="logClient">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style1">
                                        <asp:Label ID="lblContactNo" runat="server" Text="Contact No">
                                </asp:Label>
                                    </td>
                                    <td class="style5">
                                        <asp:TextBox ID="txtContactNo" runat="server" Height="28px" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <caption>
                                    &nbsp;
                                    <br />
                                    <tr>
                                        <td class="style1">
                                        </td>
                                        <td class="style5">
                                            <br />
                                            <asp:Button ID="BtnLogin" runat="server" OnClick="BtnLogin_Click" Text="Login" 
                                                ValidationGroup="logClient" />
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="btnReset" runat="server" Text="Reset" 
                                                onclick="btnReset_Click" />
                                        </td>
                                    </tr>
                                </caption>
                                </tr>
                            </caption>
                        </table>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                            ShowMessageBox="True" ShowSummary="False" ValidationGroup="logClient" />
                    </asp:Panel>
                 
                </caption>
                
                <asp:Panel ID="OffLinePanel" runat="server" Visible="false">
         <br />
                &nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblOffLineMessage" runat="server" 
                        Text="Admin is not Online Pleae leave your Message" BorderColor="Silver" 
                         ForeColor="red" style="font-weight: 700"></asp:Label>
                    
                    &nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblmsgEmilSent" runat="server" ForeColor="#009933" 
                        style="font-weight: 700" ></asp:Label>
                    
                    &nbsp;&nbsp;&nbsp;
                       <asp:Label ID="lblEmailFail" runat="server" ForeColor="Red" 
                        style="font-weight: 700" ></asp:Label>
                 <br />
                &nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtLeaveMessage" runat="server" TextMode="MultiLine" 
                        Width="305px" Height="85px" BorderColor="Silver" BorderStyle="Solid"></asp:TextBox>
                    <br />
                    <br />
                  
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnSend" runat="server" Text="Send" onclick="btnSend_Click" 
                        Width="70px" /> &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnOfflineReset"  runat="server" Text="Reset" 
                        onclick="btnOfflineReset_Click" Width="70px" /> &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnOffLineClose" runat="server" Text="Close" 
                        onclick="btnOffLineClose_Click" Width="70px" />

                    
                </asp:Panel>
              
                <asp:Panel ID="OnlinePanel" runat="server" Visible="false">
              
                    <asp:UpdatePanel ID="updateChat" runat="server">
                    <ContentTemplate>
                    <asp:Timer ID="refreshChat" runat="server" Interval="20000" 
                            ontick="refreshChat_Tick"></asp:Timer>
                    <asp:ListBox ID="lstMessage" runat="server" Width="424px" Height="171px"></asp:ListBox>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                    <asp:TextBox ID="txtSendMesage" runat="server" Height="25px" Width="349px"></asp:TextBox>
                    <asp:Button ID="btnOnlineSend" runat="server" Text="Send" 
                        onclick="btnOnlineSend_Click" Width="68px" />
                    <br />
                    <br />
                </asp:Panel>
                </ContentTemplate>
</asp:UpdatePanel> 

</div> </form> </body> </html> 