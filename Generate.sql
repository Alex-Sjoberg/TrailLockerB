USE [master]
GO
/****** Object:  Database [TrailLocker]    Script Date: 10/15/2013 7:31:40 PM ******/
CREATE DATABASE [TrailLocker]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TrailLocker', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\TrailLocker.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TrailLocker_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\TrailLocker_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TrailLocker] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TrailLocker].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TrailLocker] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TrailLocker] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TrailLocker] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TrailLocker] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TrailLocker] SET ARITHABORT OFF 
GO
ALTER DATABASE [TrailLocker] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TrailLocker] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [TrailLocker] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TrailLocker] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TrailLocker] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TrailLocker] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TrailLocker] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TrailLocker] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TrailLocker] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TrailLocker] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TrailLocker] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TrailLocker] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TrailLocker] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TrailLocker] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TrailLocker] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TrailLocker] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TrailLocker] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TrailLocker] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TrailLocker] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TrailLocker] SET  MULTI_USER 
GO
ALTER DATABASE [TrailLocker] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TrailLocker] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TrailLocker] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TrailLocker] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [TrailLocker]
GO
/****** Object:  User [TrailLocker]    Script Date: 10/15/2013 7:31:41 PM ******/
CREATE USER [TrailLocker] FOR LOGIN [TrailLocker] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [TrailLocker]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [TrailLocker]
GO
/****** Object:  Table [dbo].[Destinations]    Script Date: 10/15/2013 7:31:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Destinations](
        [DestinationID] [int] NOT NULL,
 CONSTRAINT [PK_Destinations] PRIMARY KEY CLUSTERED 
(
        [DestinationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 10/15/2013 7:31:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipment](
        [EquipmentID] [int] IDENTITY(1,1) NOT NULL,
        [LockerID] [int] NOT NULL,
        [EquipmentImageID] [int] NULL,
        [Name] [nvarchar](128) NOT NULL,
        [Category] [int] NOT NULL,
        [Weight] [float] NOT NULL,
        [Location] [nvarchar](128) NOT NULL,
        [IsDefault] [bit] NOT NULL,
        [CarryingCapacity] [float] NULL,
        [ExpireDate] [datetime2](7) NULL,
        [UsesRemaining] [int] NULL,
        [SleepingCapacity] [float] NULL,
        [MinimumTemperature] [float] NULL,
 CONSTRAINT [PK_Equipment] PRIMARY KEY CLUSTERED 
(
        [EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EquipmentImages]    Script Date: 10/15/2013 7:31:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EquipmentImages](
        [EquipmentImageID] [int] NOT NULL,
        [BinaryImage] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_EquipmentImages] PRIMARY KEY CLUSTERED 
(
        [EquipmentImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Friendships]    Script Date: 10/15/2013 7:31:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friendships](
        [FriendshipID] [int] IDENTITY(1,1) NOT NULL,
        [RequestorID] [int] NOT NULL,
        [RequesteeID] [int] NOT NULL,
        [AcceptDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Friendships] PRIMARY KEY CLUSTERED 
(
        [FriendshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Friendships_RequestorID_RequesteeID] UNIQUE NONCLUSTERED 
(
        [RequestorID] ASC,
        [RequesteeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Lockers]    Script Date: 10/15/2013 7:31:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lockers](
        [LockerID] [int] IDENTITY(1,1) NOT NULL,
        [UserID] [int] NOT NULL,
 CONSTRAINT [PK_Lockers] PRIMARY KEY CLUSTERED 
(
        [LockerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TripEquipment]    Script Date: 10/15/2013 7:31:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TripEquipment](
        [TripEquipmentID] [int] IDENTITY(1,1) NOT NULL,
        [TripID] [int] NOT NULL,
        [EquipmentID] [int] NOT NULL,
        [UserID] [int] NOT NULL,
        [CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_TripEquipment] PRIMARY KEY CLUSTERED 
(
        [TripEquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Trips]    Script Date: 10/15/2013 7:31:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trips](
        [TripID] [int] IDENTITY(1,1) NOT NULL,
        [DestinationID] [int] NOT NULL,
        [StartDate] [datetime2](7) NOT NULL,
        [EndDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Trips] PRIMARY KEY CLUSTERED 
(
        [TripID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/15/2013 7:31:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
        [UserID] [int] IDENTITY(1,1) NOT NULL,
        [Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
        [UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserTrips]    Script Date: 10/15/2013 7:31:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTrips](
        [UserTripID] [int] IDENTITY(1,1) NOT NULL,
        [UserID] [int] NOT NULL,
        [TripID] [int] NOT NULL,
 CONSTRAINT [PK_UserTrips] PRIMARY KEY CLUSTERED 
(
        [UserTripID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_Equipment_EquipmentImageID]    Script Date: 10/15/2013 7:31:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_Equipment_EquipmentImageID] ON [dbo].[Equipment]
(
        [EquipmentImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Friendships_RequesteeID]    Script Date: 10/15/2013 7:31:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_Friendships_RequesteeID] ON [dbo].[Friendships]
(
        [RequesteeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Friendships_RequestorID]    Script Date: 10/15/2013 7:31:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_Friendships_RequestorID] ON [dbo].[Friendships]
(
        [RequestorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Lockers_UserID]    Script Date: 10/15/2013 7:31:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_Lockers_UserID] ON [dbo].[Lockers]
(
        [UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TripEquipment_EquipmentID]    Script Date: 10/15/2013 7:31:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_TripEquipment_EquipmentID] ON [dbo].[TripEquipment]
(
        [EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TripEquipment_TripID]    Script Date: 10/15/2013 7:31:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_TripEquipment_TripID] ON [dbo].[TripEquipment]
(
        [TripID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TripEquipment_UserID]    Script Date: 10/15/2013 7:31:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_TripEquipment_UserID] ON [dbo].[TripEquipment]
(
        [UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Trips_DestinationID]    Script Date: 10/15/2013 7:31:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_Trips_DestinationID] ON [dbo].[Trips]
(
        [DestinationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserTrips_TripID]    Script Date: 10/15/2013 7:31:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserTrips_TripID] ON [dbo].[UserTrips]
(
        [TripID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserTrips_UserID]    Script Date: 10/15/2013 7:31:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserTrips_UserID] ON [dbo].[UserTrips]
(
        [UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TripEquipment] ADD  CONSTRAINT [DF_TripEquipment_CreateDate]  DEFAULT (sysdatetime()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_Equipment] FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK_Equipment_Equipment]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_EquipmentImages] FOREIGN KEY([EquipmentImageID])
REFERENCES [dbo].[EquipmentImages] ([EquipmentImageID])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK_Equipment_EquipmentImages]
GO
ALTER TABLE [dbo].[Equipment]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_Lockers] FOREIGN KEY([LockerID])
REFERENCES [dbo].[Lockers] ([LockerID])
GO
ALTER TABLE [dbo].[Equipment] CHECK CONSTRAINT [FK_Equipment_Lockers]
GO
ALTER TABLE [dbo].[Friendships]  WITH CHECK ADD  CONSTRAINT [FK_Friendships_Users_RequesteeID] FOREIGN KEY([RequesteeID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Friendships] CHECK CONSTRAINT [FK_Friendships_Users_RequesteeID]
GO
ALTER TABLE [dbo].[Friendships]  WITH CHECK ADD  CONSTRAINT [FK_Friendships_Users_RequestorID] FOREIGN KEY([RequestorID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Friendships] CHECK CONSTRAINT [FK_Friendships_Users_RequestorID]
GO
ALTER TABLE [dbo].[Lockers]  WITH CHECK ADD  CONSTRAINT [FK_Lockers_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Lockers] CHECK CONSTRAINT [FK_Lockers_Users]
GO
ALTER TABLE [dbo].[TripEquipment]  WITH CHECK ADD  CONSTRAINT [FK_TripEquipment_Equipment] FOREIGN KEY([TripEquipmentID])
REFERENCES [dbo].[Equipment] ([EquipmentID])
GO
ALTER TABLE [dbo].[TripEquipment] CHECK CONSTRAINT [FK_TripEquipment_Equipment]
GO
ALTER TABLE [dbo].[TripEquipment]  WITH CHECK ADD  CONSTRAINT [FK_TripEquipment_Trips] FOREIGN KEY([TripID])
REFERENCES [dbo].[Trips] ([TripID])
GO
ALTER TABLE [dbo].[TripEquipment] CHECK CONSTRAINT [FK_TripEquipment_Trips]
GO
ALTER TABLE [dbo].[TripEquipment]  WITH CHECK ADD  CONSTRAINT [FK_TripEquipment_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[TripEquipment] CHECK CONSTRAINT [FK_TripEquipment_Users]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [FK_Trips_Destinations] FOREIGN KEY([DestinationID])
REFERENCES [dbo].[Destinations] ([DestinationID])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [FK_Trips_Destinations]
GO
ALTER TABLE [dbo].[UserTrips]  WITH CHECK ADD  CONSTRAINT [FK_UserTrips_Trips] FOREIGN KEY([UserTripID])
REFERENCES [dbo].[Trips] ([TripID])
GO
ALTER TABLE [dbo].[UserTrips] CHECK CONSTRAINT [FK_UserTrips_Trips]
GO
ALTER TABLE [dbo].[UserTrips]  WITH CHECK ADD  CONSTRAINT [FK_UserTrips_Users] FOREIGN KEY([UserTripID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserTrips] CHECK CONSTRAINT [FK_UserTrips_Users]
GO
USE [master]
GO
ALTER DATABASE [TrailLocker] SET  READ_WRITE 
GO