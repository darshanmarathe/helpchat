using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
        
    }
    protected void BtnLogin_Click(object sender, EventArgs e)
    {
        ChatService chat = new ChatService();

        var client = new CompanyModel.Client
        {
            Email = txtEmailId.Text,
            FirstName = txtFirstName.Text,
            LastName = txtLastName.Text,
            ContactNo = txtContactNo.Text,
            LastLoggedIn = DateTime.Now
        };

        if ((bool)Application["Online"])
	{
		client.LoggedInWhenOffline =false ; 
	}
        else
            client.LoggedInWhenOffline = true;
        
        chat.ClientLogin(client);

        if ((bool)Application["Online"] == true)
        {
            LoginPanel.Visible= false;
            OnlinePanel.Visible = true;
            FillListBox();
        }
        else
        {
            LoginPanel.Visible = false;
            OffLinePanel.Visible = true;

            
        }
    }

    private void FillListBox()
    {
        var chat = new ChatService();
        var lists=   chat.GetChatListFull(txtEmailId.Text.Trim());
        foreach (var item in lists)
        {
             lstMessage.Items.Add(new ListItem(item.ChatString));
    
        }
    
    }


    protected void btnOnlineSend_Click(object sender, EventArgs e)
    {
        var chat = new ChatService();
        var msg = new CompanyModel.Chat();
        msg.EmailID = txtEmailId.Text.Trim();
        var FirstName = txtFirstName.Text.Trim();
          msg.AdminID = 0;
        msg.ChatString = FirstName +">>"  + txtSendMesage.Text.Trim();
        lstMessage.Items.Add(new ListItem(msg.ChatString));
       chat.PostChatMessageClient(msg);
        txtSendMesage.Text = ""; txtSendMesage.Focus();
    }
    protected void refreshChat_Tick(object sender, EventArgs e)
    {
        GetClientChatLatestMsg();
    }

    private void GetClientChatLatestMsg()
    {
        var chat = new ChatService();
        var lists = chat.GetChatForClient(txtEmailId.Text.Trim());
        if (lists.Count() == 0)
        {
            return;
        }
        //   lstMessage.Items.Clear();
        foreach (var item in lists)
        {
            lstMessage.Items.Add(new ListItem(item.ChatString));

        }
        lstMessage.SelectedIndex = lstMessage.Items.Count - 1;

    }
    protected void btnSend_Click(object sender, EventArgs e)
    {
        var chat = new ChatService();
        var msg = new CompanyModel.Chat();
        msg.EmailID = txtEmailId.Text.Trim();
        var FirstName = txtFirstName.Text.Trim();
        msg.AdminID = 0;
        string Chatmsg = FirstName + ">>" + txtLeaveMessage.Text.Trim();
        msg.ChatString = Chatmsg;
        lstMessage.Items.Add(new ListItem(msg.ChatString));
        chat.PostChatMessageClient(msg);
        GetClientChatLatestMsg();
        MEmail oemail = new MEmail();
        oemail.FromMail = msg.EmailID;
        oemail.ToMail = ConfigurationSettings.AppSettings["ToMail"].ToString();

        oemail.Subject = "Mail From " + msg.EmailID;
        try
        {
            oemail.SendMailMessage(msg.ChatString);
            lblOffLineMessage.Visible = false;
            lblmsgEmilSent.Text = "Email sent Successfully";
            txtLeaveMessage.Visible = false;
            btnOfflineReset.Visible = false;
            btnSend.Visible = false;
        }
        catch (Exception)
        {
            lblOffLineMessage.Visible = false;
            lblEmailFail.Text = "Email not sent please Try again";

            
        }
       
    }
    protected void btnOfflineReset_Click(object sender, EventArgs e)
    {
        txtLeaveMessage.Text = "";
    }
    protected void btnOffLineClose_Click(object sender, EventArgs e)
    {
        LoginPanel.Visible = true;
        OffLinePanel.Visible = false;
       
        ClearLogin();

    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearLogin();

    }

    private void ClearLogin()
    {
        txtEmailId.Text = "";
        txtFirstName.Text = "";
        txtLastName.Text = "";
        txtContactNo.Text = "";
                txtSendMesage.Text = "";
        txtLeaveMessage.Text = "";
       
    }
    protected void btnOnlineClose_Click(object sender, EventArgs e)
    {
        LoginPanel.Visible = true;
        OnlinePanel.Visible = false;
      

        ClearLogin();

    }
    protected void lnkLogout1_Click(object sender, EventArgs e)
    {
        LoginPanel.Visible = true;
        OnlinePanel.Visible = false;
        ClearLogin();

     
    }
}