using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CompanyModel;
using System.Configuration;



public partial class Admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetButtonText();
        }
    }
    protected void btnOnlineOffline_Click(object sender, EventArgs e)
    {
        if ((bool)Application["Online"] == true)
            Application["Online"] = false;
        else
            Application["Online"] = true;
        SetButtonText();
    }

    private void SetButtonText()
    {
        if ((bool)Application["Online"] == true)
        {
            btnOnlineOffline.Text = "Take Offline";

        }
        else
            btnOnlineOffline.Text = "Take Online";

    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        ChatService chat = new ChatService();
        var AUser = new AdminUser
        {
            UserName = Login1.UserName,
            Password = Login1.Password


        };

        bool loggedin = chat.AdminUserLogin(AUser);

        
        if (loggedin)
        {
            loginPanel.Visible = false;
            PanelAdmin.Visible = true;
            FillOfflineListBox();
            FillOnlineListBox();
        }
        else
        {
            
            Login1.FailureText = "Login Failed";
        }
    }

    /// <summary>
    /// Called when login complete
    /// </summary>
    private void FillOfflineListBox() {
        var chat = new ChatService();
        var offlineUsers =  chat.GetOfflineUser();
        lstOfflineUsers.Items.Clear();
        foreach (var item in offlineUsers)
        {
            ListItem lst = new ListItem(item.Email);
            lstOfflineUsers.Items.Add(lst);
        }
    
    }
    private void FillOnlineListBox() {
        var chat = new ChatService();
        var offlineUsers = chat.GetLoggedInUsers();
        lstOnlineUsers.Items.Clear();
        foreach (var item in offlineUsers)
        {
            ListItem lst = new ListItem(item.Email);
            lstOnlineUsers.Items.Add(lst);
        }
    
    }

    private void FillChatListBox()
    {
        MainChat.Items.Clear();
        var chat = new ChatService();
        var offlineUsers = chat.GetChatListFull(SelectedUser.Text);
        foreach (var item in offlineUsers)
        {
            ListItem lst = new ListItem(item.ChatString);
            MainChat.Items.Add(lst);
        }

    }
    
    protected void lstOfflineUsers_SelectedIndexChanged(object sender, EventArgs e)
    {
        SelectedUser.Text = lstOfflineUsers.SelectedItem.Text;
        selOffline.Checked = true;
        selOnline.Checked = false;
        FillChatListBox();
        lblEmailsentCLient.Text = "";
        lstOnlineUsers.SelectedIndex = -1;

    }
    protected void lstOnlineUsers_SelectedIndexChanged(object sender, EventArgs e)
    {
        SelectedUser.Text = lstOnlineUsers.SelectedItem.Text;
        selOffline.Checked = false;
        selOnline.Checked = true;
        lblEmailsentCLient.Text = "";
        FillChatListBox();
        lstOfflineUsers.SelectedIndex = -1;

 
    }
    protected void btnSend_Click(object sender, EventArgs e)
    {
        var chat = new ChatService();
        Chat ochat = new Chat();
        ochat.EmailID = SelectedUser.Text;
        //TODO : Replace 0 with right one 
        ochat.AdminID = 0;
        //TODO : Aditi Says need to be added;
        string Chatmsg = "Admin >>" + MessageToSend.Text;

        ochat.ChatString = Chatmsg;
        
        chat.PostChatMessageAdminUser(ochat , selOffline.Checked);
            GetLatestMessages();
            if (selOffline.Checked == true)
            {
                var Message = MessageToSend.Text;
                var FromEmailId = ConfigurationSettings.AppSettings["ToMail"].ToString();
                MEmail oemail = new MEmail();
                oemail.FromMail = FromEmailId;
                oemail.ToMail = SelectedUser.Text;
                oemail.Subject = "Reply From optimistikinfo.com";
                try
                {
                    oemail.SendMailMessage(Message);
                }
                catch (Exception)
                {

                    
                }
              
            }
            MainChat.Items.Add(Chatmsg);
                MessageToSend.Text = "";
            MessageToSend.Focus();
   
               
     }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        GetLatestMessages();
    }

    
    private void GetLatestMessages()
    {
      var chat = new ChatService();
        var lists = chat.GetChatForAdminUser(SelectedUser.Text.Trim());
        if (lists.Count() == 0)
        {
            return;
        }
        //   lstMessage.Items.Clear();
        foreach (var item in lists)
        {
            MainChat.Items.Add(new ListItem(item.ChatString));

        }
    }


    
    protected void btnDelChathistory_Click(object sender, EventArgs e)
    {
        var ctx = new ChatEntities();
        ctx.DeleteChatHistory();
    }
    protected void Timer2_Tick(object sender, EventArgs e)
    {
        GetLatestOnlineUser();
        MessageToSend.Focus();
    }

    private void GetLatestOnlineUser()
    {
        FillOnlineListBox();
        FillOfflineListBox();
    }

    protected void btnSignIn_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminSignUp.aspx");
    }
}