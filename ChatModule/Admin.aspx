<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chat Admin</title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
            <ContentTemplate>
         
    <div>
     <h2> <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/logo.gif" />
            Admin Chat
            </h2>
                    <asp:Panel ID="loginPanel" runat="server">
         
                <asp:Button ID="btnSignIn" runat="server" Text="Create an account" BackColor="#666666" 
                            ForeColor="White" Width="165px" Height="28px" onclick="btnSignIn_Click" 
                            style="font-weight: 700" /><br />
                <br />
                           <asp:Login ID="Login1" runat="server" BackColor="#F7F7DE" BorderColor="#CCCC99" 
                               BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
                       Font-Size="10pt" Height="188px" 
                       onauthenticate="Login1_Authenticate" Width="389px">
                   <TitleTextStyle BackColor="#6B696B" Font-Bold="True" 
                       ForeColor="#FFFFFF" />
                </asp:Login>
                </asp:Panel>
        
            
        <asp:Panel ID="PanelAdmin" runat="server" Visible="false">
         <asp:Button ID="btnOnlineOffline" runat="server" Text="" 
            onclick="btnOnlineOffline_Click" />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnDelChathistory" runat="server" Text="DeleteChatHistory" />
            <br />
  
    <hr />
  
  <table width="100%">

  <tr>
  <td style="width:40px">
  
        <table width="90%">
        <tr><td>
        Offline Users : <br />
        <asp:ListBox ID="lstOfflineUsers" runat="server" Height="200px" Width="100%" 
                AutoPostBack="True" 
                onselectedindexchanged="lstOfflineUsers_SelectedIndexChanged"></asp:ListBox><br />

        </td></tr>
        <tr><td>
           <asp:Timer ID="Timer2" runat="server" Interval="20000" ontick="Timer2_Tick">
                </asp:Timer>
        
           
         Online Users : <br />
               <asp:ListBox ID="lstOnlineUsers" runat="server" Height="200px" Width="100%" 
                AutoPostBack="True" 
                onselectedindexchanged="lstOnlineUsers_SelectedIndexChanged"></asp:ListBox><br />
        </td></tr>
        
        </table>

  
  </td>

  <td style="width:60%;text-align:left;vertical-align:top;">
  <div style="width:98%;float:left">
  Selected User:
  <p >
  <asp:Label Id="SelectedUser" runat="server"></asp:Label>
  <asp:RadioButton ID="selOffline" runat="server"  Text="Offline" GroupName="A" 
         />
  <asp:RadioButton ID="selOnline" runat="server"  Text="Online" GroupName="A"/>
  <br />
      <asp:Label ID="lblEmailsentCLient" runat="server" 
          ForeColor="#009933"></asp:Label>
  </p>
      <asp:Timer ID="Timer1" runat="server" ontick="Timer1_Tick" Interval="30000">
      </asp:Timer>
  <br />
  <asp:ListBox ID="MainChat" runat="server" Height="330px" Width="95%" 
          ></asp:ListBox>
  <br />
  <br />
  <asp:TextBox ID="MessageToSend" runat="server" Width="81%" Height="30px"></asp:TextBox>
  <asp:Button ID="btnSend" runat="server" Width="15%" Text="Send" 
          onclick="btnSend_Click" Height="28px" />

  </div>
  
  </td>
  

  </tr>
  </table>
        </asp:Panel>
    </div>
     </ContentTemplate>
         </asp:UpdatePanel>
       
    </form>
</body>
</html>
