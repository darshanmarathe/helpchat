
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 04/06/2012 22:20:36
-- Generated from EDMX file: C:\aditi\ChatModule\ChatDB.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Company];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- -------------------------------------------------- 
DROP Table [dbo].[AdminUserSet]
DROP Table [dbo].[ClientsSet] 
Drop Table [ChatSet]
-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'AdminUserSet'
CREATE TABLE [dbo].[AdminUser] (
    [Id] int IDENTITY(1,1) NOT NULL Primary key,
    [UserName] nvarchar(100)  NOT NULL,
    [Password] nvarchar(100)  NOT NULL,
    [IsActive] bit  NULL
);
GO

-- Creating table 'ClientsSet'
CREATE TABLE [dbo].[Clients] (
    [Email] nvarchar(200)  NOT NULL Primary Key,
    [FirstName] nvarchar(100)  NOT NULL,
    [LastName] nvarchar(100)  NOT NULL,
    [ContactNo] nvarchar(100)  NOT NULL,
    [LastLoggedIn] datetime null,
  [LoggedInWhenOffline] bit null default 0  
);
GO

-- Creating table 'ChatSet'
CREATE TABLE [dbo].[Chat] (
    [Id] int IDENTITY(1,1) NOT NULL Primary Key,
    [EmailID] nvarchar(200)  NOT NULL,
    [AdminID] int  NOT NULL,
    [ChatString] nvarchar(max)  NOT NULL,
    [PostedOn] datetime  NOT NULL,
    [IsNewToClient] bit Default 0,
    [IsNewToAdmin] bit Default 0
);
GO


-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------
CREATE PROCEDURE SP_IsNewToAdmin
(
	@EmailId nvarchar(200)
) 
	
AS
BEGIN
	update Chat
	set Chat.IsNewToAdmin =0
	where Chat.EmailID=@EmailId	
END
GO

CREATE PROCEDURE [dbo].[SP_IsNewToClient]
(
	@EmailId nvarchar(200)
) 
	
AS
BEGIN
PRINT @EmailId
	update Chat
	set Chat.IsNewToClient= 0
	where Chat.EmailID = @EmailId	
END

CREATE procedure SP_DeleteChatHistory  
(  )

As  
begin  
declare @Date datetime  

begin  
SELECT @Date = DATEADD(DAY, -30, GETDATE())  
delete  from chat where @Date > PostedOn   
   
end  
end
GO


ALTER table Chat 
Add PostedForOffline bit default 0
go



ALTER procedure [dbo].[SP_GetOnlineUsers]

As  
begin  
declare @Date datetime  

begin  
SELECT @Date = DATEADD(minute, -30, GETDATE())  

SELECT DISTINCT Email from Clients 
inner JOIN Chat on Chat.EmailID = Clients.Email
where Chat.PostedOn >    @Date
AND Chat.PostedForOffline = 0
And Clients.LoggedInWhenOffline = 0
   
end  
end
GO


