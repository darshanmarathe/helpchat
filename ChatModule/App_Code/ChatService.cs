using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using CompanyModel;
/// <summary>
/// Summary description for ChatService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class ChatService : System.Web.Services.WebService
{

    public ChatService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    #region Client
    [WebMethod]
    public void ClientLogin(Client cl)
    {
        using (var ctx = new ChatEntities())
        {
            var client = (from c in ctx.Clients
                          where c.Email == cl.Email
                          select c);

            if (client.Count() == 0)
            {
                ctx.Clients.AddObject(cl);
            }
            else
            {
                client.First().FirstName = cl.FirstName;
                client.First().LastName = cl.LastName;
                client.First().ContactNo = cl.ContactNo;
                client.First().LastLoggedIn = DateTime.Now;
                client.First().LoggedInWhenOffline = cl.LoggedInWhenOffline;
            }
            ctx.SaveChanges();

        }
    }

    [WebMethod]
    public void PostChatMessageClient(Chat ch)
    {
        using (var ctx = new ChatEntities())
        {
            ch.IsNewToAdmin = true;
            ch.IsNewToClient = false;
            ch.PostedOn = DateTime.Now;
            ch.PostedForOffline = false;
            ctx.Chats.AddObject(ch);
            ctx.SaveChanges();
        }

    }





    #endregion

    #region Common


    [WebMethod]
    public List<Chat> GetChatListFull(string emailAddress)
    {
        using (var ctx = new ChatEntities())
        {
            var chatList = (from c in ctx.Chats
                          where c.EmailID == emailAddress
                            select c).ToList();
                        return chatList;
        }
    }


    #endregion


    #region AdminUser
    [WebMethod]
    public bool AdminUserLogin(AdminUser au)
    {
        using (var ctx = new ChatEntities())
        {
            var user = (from u in ctx.AdminUsers
                        where u.UserName == au.UserName
                        select u);
            if (user.Count()==0)
            {
                return false;
            }
            if (user.First().Password!=au.Password)
            {
                return false;
            }
            return true;
        }
         }

    [WebMethod]
    public void PostChatMessageAdminUser(Chat ch , bool isOffline)
    {
        using (var ctx = new ChatEntities())
        {
            ch.IsNewToAdmin = false;
            ch.IsNewToClient = true;
            ch.PostedOn = DateTime.Now;
            ch.PostedForOffline = isOffline;
            
            ctx.Chats.AddObject(ch);

            if (isOffline)
            {
                var user = (from u in ctx.Clients
                            where u.Email == ch.EmailID
                            select u).First();
                user.LoggedInWhenOffline = false;
                
            }
            ctx.SaveChanges();
        
        
        }

    }
    [WebMethod]
    public void SaveAdminuser(AdminUser au)
    {
        using (var ctx = new ChatEntities())
        {
            ctx.AdminUsers.AddObject(au);
            ctx.SaveChanges();
            
        }
    }


    public List<OnlineUserCollection> GetLoggedInUsers()
    {
        using (var ctx = new ChatEntities())
        {
            var chatList = ctx.SP_GetOnlineUsers().ToList();
            return chatList;
        }
    }


    public List<Client> GetOfflineUser()
    {
        using (var ctx = new ChatEntities())
        {
            var clients = (from c in ctx.Clients
                           where c.LoggedInWhenOffline == true 
                           select c).ToList();
            return clients;
        }


    }

    [WebMethod]
    public List<Chat> GetChatForClient(string emailAddress)
    {

        using (var ctx = new ChatEntities())
        {
            var chatList = (from c in ctx.Chats
                            where c.EmailID == emailAddress
                            && c.IsNewToClient == true
                            select c).ToList();
            ctx.Clear_IsNewToClient(emailAddress);
            return chatList;
        }
    

    }


    [WebMethod]
    public List<Chat> GetChatForAdminUser(string emailAddress)
    {

        using (var ctx = new ChatEntities())
        {
            var chatList = (from c in ctx.Chats
                            where c.EmailID == emailAddress
                            && c.IsNewToAdmin == true
                            select c).ToList();
            ctx.Clear_IsNewToAdmin(emailAddress);
            return chatList;
        }


    }

  

    #endregion
}
