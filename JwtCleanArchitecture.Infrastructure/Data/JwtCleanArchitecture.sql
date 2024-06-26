USE [master]
GO
/****** Object:  Database [JwtCleanArchitectureDb]    Script Date: 6/13/2024 11:17:50 AM ******/
CREATE DATABASE [JwtCleanArchitectureDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'JwtCleanArchitectureDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\JwtCleanArchitectureDb.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'JwtCleanArchitectureDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\JwtCleanArchitectureDb_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [JwtCleanArchitectureDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET  MULTI_USER 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET DELAYED_DURABILITY = DISABLED 
GO
USE [JwtCleanArchitectureDb]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 6/13/2024 11:17:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogins](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[IPAddress] [nvarchar](255) NOT NULL,
	[Device] [nvarchar](255) NOT NULL,
	[Browser] [nvarchar](255) NOT NULL,
	[LoginTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/13/2024 11:17:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[FirstName] [nvarchar](255) NOT NULL,
	[LastName] [nvarchar](255) NOT NULL,
	[Device] [nvarchar](255) NOT NULL,
	[IPAddress] [nvarchar](255) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Balance] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[UserLogins] ON 

INSERT [dbo].[UserLogins] ([Id], [UserId], [IPAddress], [Device], [Browser], [LoginTime]) VALUES (23, 2, N'209.150.145.82', N'Windows', N'Chrome', CAST(N'2024-06-13T05:26:54.287' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserLogins] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password], [FirstName], [LastName], [Device], [IPAddress], [CreatedAt], [Balance]) VALUES (2, N'najeeb@gmail.com', N'123', N'Najeeb', N'Ullah', N'Windows (Chrome)', N'209.150.145.82', CAST(N'2024-06-13T05:26:44.617' AS DateTime), 5)
INSERT [dbo].[Users] ([Id], [Username], [Password], [FirstName], [LastName], [Device], [IPAddress], [CreatedAt], [Balance]) VALUES (4, N'rameez', N'123', N'rameez', N'javid', N'Windows (Chrome)', N'209.150.145.82', CAST(N'2024-06-13T05:44:19.463' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[UserLogins]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
USE [master]
GO
ALTER DATABASE [JwtCleanArchitectureDb] SET  READ_WRITE 
GO
