USE [ARC_REC]
GO
/****** Object:  Table [dbo].[ADM_CustomerMailDomain]    Script Date: 9/10/2020 2:33:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADM_CustomerMailDomain](
	[CMDId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[MailDomain] [varchar](100) NOT NULL,
	[Status] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[Modifiedby] [int] NULL,
	[ModifiedDt] [datetime] NULL,
	[Comments] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[CMDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AHC_AppLikeUsers]    Script Date: 9/10/2020 2:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AHC_AppLikeUsers](
	[ALID] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](100) NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[UserEmailId] [varchar](100) NULL,
	[LikedOn] [datetime] NULL,
	[Status] [tinyint] NULL,
	[UnLikedOn] [datetime] NULL,
 CONSTRAINT [pk_alid] PRIMARY KEY CLUSTERED 
(
	[ALID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AHC_JobApply]    Script Date: 9/10/2020 2:33:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AHC_JobApply](
	[Applyid] [int] IDENTITY(1,1) NOT NULL,
	[ApplyNo] [varchar](20) NULL,
	[Name] [varchar](30) NULL,
	[EmailId] [varchar](50) NULL,
	[Mobile] [varchar](50) NULL,
	[VANIP] [varchar](20) NULL,
	[HostIP] [varchar](20) NULL,
	[FBName] [varchar](100) NULL,
	[CreatedOn] [datetime] NULL,
	[Position] [varchar](50) NULL,
	[FBUserId] [varchar](100) NULL,
	[FBEmaiId] [varchar](250) NULL,
	[FBLike] [int] NULL,
 CONSTRAINT [PK_Applyid] PRIMARY KEY CLUSTERED 
(
	[Applyid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AHC_JobRefer]    Script Date: 9/10/2020 2:33:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AHC_JobRefer](
	[Referid] [int] IDENTITY(1,1) NOT NULL,
	[ReferNo] [varchar](20) NULL,
	[Designid] [int] NULL,
	[Refname] [varchar](30) NULL,
	[RefEmailId] [varchar](50) NULL,
	[RefMobile] [varchar](50) NULL,
	[VANIP] [varchar](20) NULL,
	[HostIP] [varchar](20) NULL,
	[FBName] [varchar](100) NULL,
	[CreatedOn] [datetime] NULL,
	[sessionvalue] [varchar](100) NULL,
	[FBUserId] [varchar](100) NULL,
	[Position] [varchar](50) NULL,
	[FBEmaiId] [varchar](250) NULL,
	[FBLike] [int] NULL,
 CONSTRAINT [PK_Referid] PRIMARY KEY CLUSTERED 
(
	[Referid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_APP_Privileges]    Script Date: 9/10/2020 2:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_APP_Privileges](
	[AccessID] [int] IDENTITY(1,1) NOT NULL,
	[Userid] [int] NULL,
	[NTUserName] [varchar](100) NULL,
	[Status] [tinyint] NULL,
	[Apptype] [int] NULL,
	[AppDescription] [varchar](100) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ApplyOnlineDtls]    Script Date: 9/10/2020 2:33:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ApplyOnlineDtls](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[POSITIONID] [int] NULL,
	[Name] [varchar](150) NULL,
	[Address] [varchar](300) NULL,
	[Phone] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[FileID] [int] NULL,
	[Comments] [varchar](8000) NULL,
	[CreatedIP] [varchar](50) NULL,
	[Status] [tinyint] NULL,
	[CreatedDt] [smalldatetime] NULL,
 CONSTRAINT [PK_OD_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_BATCHIMPORT_BULKERROR]    Script Date: 9/10/2020 2:33:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_BATCHIMPORT_BULKERROR](
	[FROM_MAILID] [varchar](100) NOT NULL,
	[RECIPIENTS] [varchar](max) NULL,
	[SUBJECT_TEXT] [varchar](500) NULL,
	[BODY] [nvarchar](max) NULL,
	[MAIL_STATUS] [bit] NULL,
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
	[ISHTML] [varchar](1) NULL,
	[CREATED_DT] [datetime] NULL,
	[CC] [varchar](max) NULL,
	[Active] [int] NULL,
	[FilePath] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ROW_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_CBT]    Script Date: 9/10/2020 2:33:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_CBT](
	[Data] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_CBT_FEEDBACK_ENTRY]    Script Date: 9/10/2020 2:33:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_CBT_FEEDBACK_ENTRY](
	[ENTID] [int] IDENTITY(1,1) NOT NULL,
	[INFOID] [int] NULL,
	[QUESTION_NO] [int] NULL,
	[ANSWER] [varchar](50) NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDON] [datetime] NULL,
	[STATUSID] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_CBT_FEEDBACK_INFO]    Script Date: 9/10/2020 2:33:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_CBT_FEEDBACK_INFO](
	[INFOID] [int] IDENTITY(1,1) NOT NULL,
	[USERID] [int] NULL,
	[FEEDBACK] [varchar](2000) NULL,
	[SUGGESTION] [varchar](2000) NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDON] [datetime] NULL,
	[STATUSID] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_CBT_FEEDBACK_MASTER]    Script Date: 9/10/2020 2:33:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_CBT_FEEDBACK_MASTER](
	[FBID] [int] IDENTITY(1,1) NOT NULL,
	[ATTRIBUTES] [varchar](500) NOT NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDON] [datetime] NULL,
	[MODIFIEDBY] [int] NULL,
	[MODIFIEDON] [datetime] NULL,
	[STATUSID] [tinyint] NULL,
 CONSTRAINT [PK_ARC_CBT_FEEDBACK_MASTER_ATTRIBUTES] PRIMARY KEY CLUSTERED 
(
	[ATTRIBUTES] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_CLIENT_COLORCODE]    Script Date: 9/10/2020 2:33:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_CLIENT_COLORCODE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NULL,
	[ColorCode] [varchar](10) NULL,
	[Createdby] [varchar](50) NULL,
	[Createdon] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Contract_Customer_Retention]    Script Date: 9/10/2020 2:33:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Contract_Customer_Retention](
	[ID] [int] NOT NULL,
	[CustomerID] [int] NULL,
	[RetentionDays] [int] NULL,
	[RetentionMode] [varchar](20) NULL,
	[PurgeMode] [varchar](20) NULL,
	[Description] [varchar](500) NULL,
	[Active] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Enterprise_Menu]    Script Date: 9/10/2020 2:33:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Enterprise_Menu](
	[ParentID] [int] NULL,
	[MenuName] [varchar](50) NOT NULL,
	[MenuLevel] [int] NOT NULL,
	[MenuDisplayOrder] [int] NOT NULL,
	[MenuDesc] [varchar](1000) NULL,
	[MenuDomainURL] [varchar](100) NULL,
	[MenuLinkURL] [varchar](1000) NULL,
	[Created_DT] [datetime] NOT NULL,
	[Created_By] [varchar](100) NULL,
	[isActive] [bit] NOT NULL,
	[MenuID] [int] NOT NULL,
	[LogoUrl] [varchar](200) NULL,
	[LogoRedirectionUrl] [varchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ENTERPRISE_MenuAccessByUser]    Script Date: 9/10/2020 2:33:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ENTERPRISE_MenuAccessByUser](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NOT NULL,
	[NT_Username] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Created_Dt] [datetime] NOT NULL,
	[Created_By] [varchar](75) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Enterprise_MenuDesignationRoles]    Script Date: 9/10/2020 2:34:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Enterprise_MenuDesignationRoles](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[DesignationId] [int] NULL,
	[FunctionalityId] [int] NULL,
	[Active] [bit] NULL,
	[CreatedBy] [varchar](75) NULL,
	[CreatedDt] [datetime] NULL,
UNIQUE NONCLUSTERED 
(
	[RoleId] ASC,
	[DesignationId] ASC,
	[FunctionalityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Enterprise_MenuRoles]    Script Date: 9/10/2020 2:34:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Enterprise_MenuRoles](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[RoleName] [varchar](100) NOT NULL,
	[AppName] [varchar](100) NOT NULL,
	[CreatedBy] [varchar](72) NULL,
	[CreatedDt] [datetime] NULL,
	[Active] [bit] NULL,
	[RuleExpression] [varchar](max) NULL,
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC,
	[AppName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Enterprise_MenuRolesPermission]    Script Date: 9/10/2020 2:34:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Enterprise_MenuRolesPermission](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[MenuId] [int] NULL,
	[Active] [bit] NULL,
	[CreatedBy] [varchar](75) NULL,
	[CreatedDt] [datetime] NULL,
UNIQUE NONCLUSTERED 
(
	[RoleId] ASC,
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ENTERPRISE_MenuRules]    Script Date: 9/10/2020 2:34:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ENTERPRISE_MenuRules](
	[RuleId] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NOT NULL,
	[Condition] [varchar](max) NULL,
	[CreatedBy] [varchar](100) NOT NULL,
	[CreatedDt] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Enterprise_MenuUserRoles]    Script Date: 9/10/2020 2:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Enterprise_MenuUserRoles](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[NT_UserName] [varchar](75) NULL,
	[Active] [bit] NULL,
	[CreatedBy] [varchar](75) NULL,
	[CreatedDt] [datetime] NULL,
UNIQUE NONCLUSTERED 
(
	[RoleId] ASC,
	[NT_UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ER_ACTIVITY_CALENDAR]    Script Date: 9/10/2020 2:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ER_ACTIVITY_CALENDAR](
	[EID] [int] IDENTITY(1,1) NOT NULL,
	[TITLE] [varchar](250) NULL,
	[FUNCTIONID] [int] NULL,
	[CLIENTID] [int] NULL,
	[HEADCOUNT] [int] NULL,
	[EVENTDT] [datetime] NULL,
	[FRMTIME] [time](7) NULL,
	[TOTIME] [time](7) NULL,
	[COMMENTS] [varchar](max) NULL,
	[FB_STATUS] [varchar](50) NULL,
	[FB_COMMENTS] [varchar](max) NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
	[UPDATEDBY] [int] NULL,
	[UPDATEDDT] [datetime] NULL,
 CONSTRAINT [PK_ARC_ER_ACTIVITY_CALENDAR] PRIMARY KEY CLUSTERED 
(
	[EID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ER_MAILADDRESS]    Script Date: 9/10/2020 2:34:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ER_MAILADDRESS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CLIENTID] [int] NULL,
	[FUNCTIONALITYID] [int] NULL,
	[TOMAIL] [varchar](1000) NULL,
	[CCMAIL] [varchar](1000) NULL,
	[MTYPE] [int] NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
	[UPDATEDBY] [int] NULL,
	[UPDATEDDT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ER_MEETING_CALENDAR]    Script Date: 9/10/2020 2:34:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ER_MEETING_CALENDAR](
	[MCID] [int] IDENTITY(1,1) NOT NULL,
	[TITLE] [varchar](250) NULL,
	[CLIENT_ID] [int] NULL,
	[FUNCTIONID] [int] NULL,
	[EMPCODE] [varchar](50) NULL,
	[NOOFEMP] [int] NULL,
	[MDATE] [datetime] NULL,
	[FRMTIME] [time](7) NULL,
	[TOTIME] [time](7) NULL,
	[MTYPE] [int] NULL,
	[COMMENTS] [varchar](max) NULL,
	[FEEDBACK_COMMENTS] [varchar](max) NULL,
	[FB_STATUS] [varchar](50) NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
	[UPDATEDBY] [int] NULL,
	[UPDATEDDT] [datetime] NULL,
 CONSTRAINT [PK_ARC_ER_MEETING_CALENDAR] PRIMARY KEY CLUSTERED 
(
	[MCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Facility_BehaviourDtls]    Script Date: 9/10/2020 2:34:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Facility_BehaviourDtls](
	[BID] [int] IDENTITY(1,1) NOT NULL,
	[Behaviour] [varchar](100) NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [smalldatetime] NULL,
 CONSTRAINT [PK_ARC_Facility_BehaviourDtls] PRIMARY KEY CLUSTERED 
(
	[BID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Facility_CABMaster]    Script Date: 9/10/2020 2:34:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Facility_CABMaster](
	[CabID] [int] IDENTITY(1,1) NOT NULL,
	[CabNo] [varchar](50) NULL,
	[DriverName] [varchar](50) NULL,
	[DriverContactNo] [varchar](50) NULL,
	[Status] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [smalldatetime] NULL,
	[DeletedBy] [int] NULL,
	[DeletedDt] [smalldatetime] NULL,
 CONSTRAINT [PK_ARC_Facility_CABMaster] PRIMARY KEY CLUSTERED 
(
	[CabID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Facility_DriverMaster]    Script Date: 9/10/2020 2:34:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Facility_DriverMaster](
	[DriverID] [int] IDENTITY(1,1) NOT NULL,
	[Drivername] [varchar](50) NULL,
	[Status] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [smalldatetime] NULL,
	[DeletedBy] [int] NULL,
	[DeletedDt] [smalldatetime] NULL,
 CONSTRAINT [PK_ARC_Facility_DriverMaster] PRIMARY KEY CLUSTERED 
(
	[DriverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Facility_FeedbackDtls]    Script Date: 9/10/2020 2:34:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Facility_FeedbackDtls](
	[FID] [int] IDENTITY(1,1) NOT NULL,
	[RouteID] [int] NULL,
	[CabID] [int] NULL,
	[TripType] [int] NULL,
	[DrivingStyle] [varchar](50) NULL,
	[B2] [varchar](1) NULL,
	[B3] [varchar](1) NULL,
	[B4] [varchar](1) NULL,
	[B5] [varchar](1) NULL,
	[B6] [varchar](1) NULL,
	[B7] [varchar](1) NULL,
	[N1] [varchar](1) NULL,
	[Comments] [varchar](8000) NULL,
	[FBstatus] [int] NULL,
	[FBComments] [varchar](8000) NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [smalldatetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDt] [smalldatetime] NULL,
 CONSTRAINT [PK_ARC_Facility_FeedbackDtls] PRIMARY KEY CLUSTERED 
(
	[FID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Facility_NeatnessDtls]    Script Date: 9/10/2020 2:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Facility_NeatnessDtls](
	[NID] [int] IDENTITY(1,1) NOT NULL,
	[Neatness] [varchar](50) NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [smalldatetime] NULL,
 CONSTRAINT [PK_ARC_Facility_NeatnessDtls] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Facility_RouteMaster]    Script Date: 9/10/2020 2:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Facility_RouteMaster](
	[RouteID] [int] IDENTITY(1,1) NOT NULL,
	[ShiftId] [int] NULL,
	[Routename] [varchar](100) NULL,
	[Status] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [smalldatetime] NULL,
	[DeletedBy] [int] NULL,
	[DeletedDt] [smalldatetime] NULL,
 CONSTRAINT [PK_ARC_Facility_RouteMaster] PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_FACILITY_USER_RIGHTS]    Script Date: 9/10/2020 2:34:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_FACILITY_USER_RIGHTS](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [int] NULL,
	[TYPE] [int] NULL,
	[RPTType] [int] NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
 CONSTRAINT [PK__ARC_FACI__CAFF413259DBF99D] PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_FIN_CLIENT_INFO]    Script Date: 9/10/2020 2:34:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_FIN_CLIENT_INFO](
	[Client_Id] [int] NOT NULL,
	[Client_Name] [varchar](50) NULL,
	[Short_Name] [varchar](50) NULL,
	[FullName] [varchar](100) NULL,
	[OldInternalname] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_FIN_FinanceForm]    Script Date: 9/10/2020 2:34:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_FIN_FinanceForm](
	[FormId] [int] IDENTITY(1,1) NOT NULL,
	[FormName] [varchar](50) NULL,
	[FormShortName] [varchar](25) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[AccRole] [varchar](2) NULL,
	[ParentId] [int] NULL,
	[TabId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FormId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_FIN_FinanceFormAccess]    Script Date: 9/10/2020 2:34:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_FIN_FinanceFormAccess](
	[UserId] [int] NOT NULL,
	[FormId] [int] NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[FID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[FormId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Album]    Script Date: 9/10/2020 2:34:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Album](
	[AlbumId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[CreatedBy] [varchar](100) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](100) NULL,
	[ModifiedOn] [datetime] NULL,
	[Status] [tinyint] NULL,
	[PubDate] [datetime] NULL,
	[AlbALias] [varchar](50) NULL,
 CONSTRAINT [PK_FLA_ID] PRIMARY KEY CLUSTERED 
(
	[AlbumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Album_Gallery]    Script Date: 9/10/2020 2:34:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Album_Gallery](
	[PhotoId] [int] IDENTITY(1,1) NOT NULL,
	[AlbumId] [int] NULL,
	[PhotoName] [varchar](100) NULL,
	[PhototPath] [varchar](max) NULL,
	[CreatedBy] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](150) NULL,
	[ModifiedOn] [datetime] NULL,
	[Status] [tinyint] NULL,
	[PhotoIndex] [int] NULL,
 CONSTRAINT [PK_FLG_PhotoID] PRIMARY KEY CLUSTERED 
(
	[PhotoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Album_Tag]    Script Date: 9/10/2020 2:34:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Album_Tag](
	[TagId] [int] IDENTITY(1,1) NOT NULL,
	[AlbumId] [int] NULL,
	[NT_UserId] [varchar](100) NULL,
	[CreatedBy] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](150) NULL,
	[ModifiedOn] [datetime] NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_FAT_Tagid] PRIMARY KEY CLUSTERED 
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_FORUM_ERROR_LOGS]    Script Date: 9/10/2020 2:34:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_FORUM_ERROR_LOGS](
	[ERR_ID] [int] IDENTITY(1,1) NOT NULL,
	[ERR_DESCRIPTION] [varchar](500) NULL,
	[ERR_TYPE] [varchar](50) NULL,
	[ERR_TIME] [datetime] NULL,
 CONSTRAINT [PK_ERRID] PRIMARY KEY CLUSTERED 
(
	[ERR_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Lounge_Comment_Flags]    Script Date: 9/10/2020 2:34:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Lounge_Comment_Flags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CmtId] [int] NULL,
	[ReportedBy] [varchar](75) NULL,
	[ReportedOn] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Lounge_Comment_Likes]    Script Date: 9/10/2020 2:34:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Lounge_Comment_Likes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CommId] [int] NULL,
	[Status] [tinyint] NOT NULL,
	[LikedBy] [varchar](75) NULL,
	[LikedOn] [datetime] NULL,
	[UnlikedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_FORUM_LOUNGE_HIGHlIGHT]    Script Date: 9/10/2020 2:34:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_FORUM_LOUNGE_HIGHlIGHT](
	[Hid] [int] IDENTITY(1,1) NOT NULL,
	[Content] [varchar](1000) NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_FLI_ID] PRIMARY KEY CLUSTERED 
(
	[Hid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Lounge_Message_Comments]    Script Date: 9/10/2020 2:34:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Lounge_Message_Comments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[MsgId] [int] NULL,
	[Status] [tinyint] NULL,
	[CommentedBy] [varchar](75) NULL,
	[CommentedOn] [datetime] NULL,
	[CommentText] [varchar](500) NULL,
	[ModifiedBy] [varchar](75) NULL,
	[ModifiedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Lounge_Message_Flags]    Script Date: 9/10/2020 2:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Lounge_Message_Flags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[MsgId] [int] NULL,
	[ReportedBy] [varchar](75) NULL,
	[ReportedOn] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
 CONSTRAINT [PK_FMF_ID] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Lounge_Message_Likes]    Script Date: 9/10/2020 2:34:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Lounge_Message_Likes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[MsgId] [int] NULL,
	[Status] [tinyint] NULL,
	[LikedBy] [varchar](75) NULL,
	[LikedOn] [datetime] NULL,
	[UnlikedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Lounge_Messages]    Script Date: 9/10/2020 2:34:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Lounge_Messages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MsgContent] [nvarchar](max) NULL,
	[Status] [tinyint] NOT NULL,
	[CreatedBy] [varchar](75) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](75) NULL,
	[ModifiedOn] [datetime] NULL,
	[Priority] [tinyint] NULL,
	[Type] [tinyint] NULL,
	[MsgId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Lounge_Messages_Archive]    Script Date: 9/10/2020 2:34:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Lounge_Messages_Archive](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LMid] [int] NULL,
	[MsgContent] [nvarchar](max) NULL,
	[Status] [tinyint] NOT NULL,
	[CreatedBy] [varchar](75) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](75) NULL,
	[ModifiedOn] [datetime] NULL,
	[Priority] [tinyint] NULL,
	[Type] [tinyint] NULL,
	[MsgId] [int] NULL,
	[UpdateOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_FORUM_LOUNGE_RULEBOOK_LOGS]    Script Date: 9/10/2020 2:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_FORUM_LOUNGE_RULEBOOK_LOGS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NT_userID] [varchar](75) NULL,
	[LoggedOn] [datetime] NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK_FRBG_ID] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_MessageBoard]    Script Date: 9/10/2020 2:34:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_MessageBoard](
	[MsgId] [int] IDENTITY(1,1) NOT NULL,
	[Headline] [varchar](500) NULL,
	[MessageText] [varchar](max) NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [varchar](75) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](75) NULL,
	[ModifiedOn] [datetime] NULL,
	[CoverPhotoId] [int] NULL,
	[ContentWithOutImage] [nvarchar](max) NULL,
	[AlbumId] [int] NULL,
	[Mailstatus] [tinyint] NULL,
	[Extension] [varchar](250) NULL,
	[FacilityType] [tinyint] NULL,
	[InnerImage] [varchar](30) NULL,
 CONSTRAINT [PK_FMB_MSGID] PRIMARY KEY CLUSTERED 
(
	[MsgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_MessageBoard_Archive]    Script Date: 9/10/2020 2:34:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_MessageBoard_Archive](
	[HisId] [int] IDENTITY(1,1) NOT NULL,
	[MsgId] [int] NULL,
	[Headline] [varchar](500) NULL,
	[MessageText] [varchar](max) NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [varchar](75) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](75) NULL,
	[ModifiedOn] [datetime] NULL,
	[CoverPhotoId] [int] NULL,
	[ContentWithOutImage] [nvarchar](max) NULL,
	[AlbumId] [int] NULL,
 CONSTRAINT [PK_FMB_HisId] PRIMARY KEY CLUSTERED 
(
	[HisId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_MessageBoard_Taggedusers]    Script Date: 9/10/2020 2:34:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_MessageBoard_Taggedusers](
	[TgId] [int] IDENTITY(1,1) NOT NULL,
	[MsgId] [int] NULL,
	[NT_userid] [varchar](75) NULL,
PRIMARY KEY CLUSTERED 
(
	[TgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_MessageBoard_Uploads]    Script Date: 9/10/2020 2:34:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_MessageBoard_Uploads](
	[AttchId] [int] IDENTITY(1,1) NOT NULL,
	[MsgId] [int] NULL,
	[Attch_File] [varchar](500) NULL,
	[Attch_Index] [int] NOT NULL,
	[CreatedBy] [varchar](75) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](75) NULL,
	[ModifiedOn] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
 CONSTRAINT [PK_FMU_AttchId] PRIMARY KEY CLUSTERED 
(
	[AttchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Polls]    Script Date: 9/10/2020 2:34:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Polls](
	[POLL_ID] [int] IDENTITY(1,1) NOT NULL,
	[POLL] [varchar](300) NULL,
	[OPT1] [varchar](200) NULL,
	[OPT2] [varchar](200) NULL,
	[OPT3] [varchar](200) NULL,
	[OPT4] [varchar](200) NULL,
	[CREATED_BY] [varchar](75) NULL,
	[CREATED_ON] [datetime] NULL,
	[MODIFIED_BY] [varchar](75) NULL,
	[MODIFIED_ON] [datetime] NULL,
	[STATUS] [tinyint] NULL,
	[SCHEDULED_ON] [datetime] NOT NULL,
 CONSTRAINT [PK__ARC_Foru__35E0145D2EFAF1E2] PRIMARY KEY CLUSTERED 
(
	[POLL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_Polls_Results]    Script Date: 9/10/2020 2:34:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_Polls_Results](
	[POLL_RES_ID] [int] IDENTITY(1,1) NOT NULL,
	[NT_USERNAME] [varchar](75) NULL,
	[POLL_ID] [int] NULL,
	[OPT] [varchar](200) NULL,
	[CREATED_ON] [datetime] NULL,
	[STATUS] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[POLL_RES_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Forum_User_Ideas]    Script Date: 9/10/2020 2:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Forum_User_Ideas](
	[IDEA_ID] [int] IDENTITY(1,1) NOT NULL,
	[IDEA_TEXT] [varchar](1000) NULL,
	[CREATED_BY] [varchar](75) NULL,
	[CREATED_ON] [datetime] NULL,
	[REVIEWED_BY] [varchar](75) NULL,
	[REVIEWED_ON] [datetime] NULL,
	[Status] [tinyint] NULL,
	[Comments] [varchar](500) NULL,
	[FunctionalityId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDEA_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_KIN_ACTION_ITEMS]    Script Date: 9/10/2020 2:34:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_KIN_ACTION_ITEMS](
	[AID] [int] IDENTITY(1,1) NOT NULL,
	[QID] [int] NULL,
	[ACTIONITEM] [varchar](max) NULL,
	[ROOTCAUSE] [varchar](max) NULL,
	[STATUS] [bit] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_KIN_QUERIES]    Script Date: 9/10/2020 2:34:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_KIN_QUERIES](
	[QID] [int] IDENTITY(1,1) NOT NULL,
	[QUERY] [varchar](max) NULL,
	[STATUS] [bit] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[QID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_KIN_TRANS]    Script Date: 9/10/2020 2:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_KIN_TRANS](
	[TID] [int] IDENTITY(1,1) NOT NULL,
	[QID] [int] NULL,
	[FINALCOMMENTS] [varchar](max) NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_KIN_USER_RIGHTS]    Script Date: 9/10/2020 2:34:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_KIN_USER_RIGHTS](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [int] NULL,
	[TYPE] [tinyint] NULL,
	[STATUS] [bit] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Login]    Script Date: 9/10/2020 2:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Login](
	[PWD] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_louge_clean]    Script Date: 9/10/2020 2:34:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_louge_clean](
	[ID] [float] NULL,
	[MsgContent] [nvarchar](255) NULL,
	[CreatedOn] [datetime] NULL,
	[Associate] [nvarchar](255) NULL,
	[NT_UserName] [nvarchar](255) NULL,
	[Empcode] [nvarchar](255) NULL,
	[REPORTING_TO] [nvarchar](255) NULL,
	[client_name] [nvarchar](255) NULL,
	[status] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Lounge_Admin]    Script Date: 9/10/2020 2:34:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Lounge_Admin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NTUsername] [varchar](75) NULL,
	[Status] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_LOUNGE_BAN]    Script Date: 9/10/2020 2:34:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_LOUNGE_BAN](
	[BANID] [int] IDENTITY(1,1) NOT NULL,
	[TYPEID] [tinyint] NULL,
	[RELATEDID] [int] NULL,
	[NT_USERNAME] [varchar](60) NULL,
	[BLOCKEDBY] [varchar](60) NULL,
	[BLOCKEDON] [datetime] NULL,
	[BLOCKEDMODE] [tinyint] NULL,
	[STATUS] [tinyint] NULL,
 CONSTRAINT [PK_BANID] PRIMARY KEY CLUSTERED 
(
	[BANID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Lounge_Message_Filter]    Script Date: 9/10/2020 2:34:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Lounge_Message_Filter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Content] [varchar](100) NULL,
	[Status] [tinyint] NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_ABSCOND]    Script Date: 9/10/2020 2:34:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_ABSCOND](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](50) NULL,
	[ABS_DATE] [date] NULL,
	[REMARKS] [varchar](max) NULL,
	[CREATED_DT] [datetime] NULL,
	[CREATED_BY] [int] NULL,
	[EnteredBy] [int] NULL,
	[EnteredRemark] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EMPCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_ABSCOND_LOG]    Script Date: 9/10/2020 2:34:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_ABSCOND_LOG](
	[EMPCODE] [varchar](50) NULL,
	[ABS_DATE] [date] NULL,
	[REMARKS] [varchar](max) NULL,
	[CREATED_DT] [datetime] NULL,
	[CREATED_BY] [int] NULL,
	[EnteredBY] [int] NULL,
	[EnteredRemark] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Me_CompOffUpdates]    Script Date: 9/10/2020 2:34:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Me_CompOffUpdates](
	[UserId] [int] NULL,
	[Att_Date] [date] NULL,
	[IsCompOffEligible] [int] NULL,
	[Comments] [varchar](2000) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_DISCRIPENCY_TRAN]    Script Date: 9/10/2020 2:34:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_DISCRIPENCY_TRAN](
	[TRAN_ID] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NULL,
	[DIS_TYPE] [int] NULL,
	[VERIFIED_PRESENT] [char](2) NULL,
	[VERIFIED_BY] [int] NULL,
	[VERIFIED_COMMENTS] [varchar](3000) NULL,
	[CREATED_DT] [datetime] NULL,
	[ATT_DATE] [date] NULL,
	[USERID] [int] NULL,
	[P_Days] [decimal](9, 2) NULL,
	[IsDeclaredOff] [bit] NULL,
	[CompOffEligible] [bit] NULL,
	[OTEligible] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[TRAN_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_DISCRIPENCY_TYPEINFO]    Script Date: 9/10/2020 2:34:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_DISCRIPENCY_TYPEINFO](
	[TYPE_ID] [int] IDENTITY(1,1) NOT NULL,
	[TYPE] [varchar](30) NOT NULL,
	[ACTIVE] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TYPE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_EmployeePayslip_Access]    Script Date: 9/10/2020 2:34:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_EmployeePayslip_Access](
	[UserId] [int] NULL,
	[Acc_Type] [char](2) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserId] ASC,
	[Acc_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_EXIT]    Script Date: 9/10/2020 2:35:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_EXIT](
	[REG_ID] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](50) NULL,
	[REASON_ID] [int] NULL,
	[FEEDBACK] [varchar](2000) NULL,
	[SUPERVISOR_ID] [int] NULL,
	[NOTICE_PERIOD] [int] NULL,
	[OTHER_REASON] [varchar](max) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[RELDATE_ACK] [date] NULL,
	[RELDATE_HR] [date] NULL,
	[ACTIVE] [char](1) NULL,
	[DEACTIVATED_BY] [int] NULL,
	[EnteredBy] [int] NULL,
	[EnteredRemark] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[REG_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_EXIT_CHECKLIST_INFO]    Script Date: 9/10/2020 2:35:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_EXIT_CHECKLIST_INFO](
	[CHK_ID] [int] IDENTITY(1,1) NOT NULL,
	[CHK_TEXT] [varchar](100) NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CHK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_EXIT_CHECKLIST_TRAN]    Script Date: 9/10/2020 2:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_EXIT_CHECKLIST_TRAN](
	[C_ID] [int] IDENTITY(1,1) NOT NULL,
	[REG_ID] [int] NULL,
	[CHK_ID] [int] NULL,
	[CHK_REMARK] [varchar](1000) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[C_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_EXIT_CHKLIST_ACCESS]    Script Date: 9/10/2020 2:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_EXIT_CHKLIST_ACCESS](
	[ACC_ID] [int] IDENTITY(1,1) NOT NULL,
	[USERID] [int] NULL,
	[CHKLIST_TYPE] [char](2) NULL,
	[READ] [bit] NULL,
	[WRITE] [bit] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[IS_ACTIVE] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ACC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_EXIT_REASON_INFO]    Script Date: 9/10/2020 2:35:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_EXIT_REASON_INFO](
	[REASON_ID] [int] IDENTITY(1,1) NOT NULL,
	[REASON] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[REASON_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_EXIT_STATUS_INFO]    Script Date: 9/10/2020 2:35:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_EXIT_STATUS_INFO](
	[STATUS_ID] [int] IDENTITY(0,1) NOT NULL,
	[STATUS_TEXT] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[STATUS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_EXIT_STATUS_TRAN]    Script Date: 9/10/2020 2:35:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_EXIT_STATUS_TRAN](
	[S_ID] [int] IDENTITY(1,1) NOT NULL,
	[REG_ID] [int] NULL,
	[STATUS_ID] [int] NULL,
	[REMARKS] [varchar](1000) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[TicketId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[S_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_HR_ACCESS]    Script Date: 9/10/2020 2:35:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_HR_ACCESS](
	[ACC_ID] [int] IDENTITY(1,1) NOT NULL,
	[USERID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ACC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_MaternityLeave]    Script Date: 9/10/2020 2:35:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_MaternityLeave](
	[UserId] [int] NULL,
	[DayLimit] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_PAYROLL]    Script Date: 9/10/2020 2:35:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_PAYROLL](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PAY_ROLL_DATE] [date] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_TERMINATE]    Script Date: 9/10/2020 2:35:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_TERMINATE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](50) NULL,
	[TERMINATE_DATE] [date] NULL,
	[REMARKS] [varchar](max) NULL,
	[CREATED_DT] [datetime] NULL,
	[CREATED_BY] [int] NULL,
	[EnteredBy] [int] NULL,
	[EnteredRemark] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EMPCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_VISITOR]    Script Date: 9/10/2020 2:35:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_VISITOR](
	[VISITOR_ID] [int] IDENTITY(1,1) NOT NULL,
	[VISITOR_NAME] [varchar](500) NULL,
	[REASON] [varchar](50) NULL,
	[VISIT_DATE] [date] NULL,
	[IN_TIME] [time](7) NULL,
	[OUT_TIME] [time](7) NULL,
	[VISITOR_CONTACTNO] [varchar](10) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[PRINT_STATUS] [int] NULL,
	[UPDATED_BY] [varchar](500) NULL,
	[UPDATED_DT] [datetime] NULL,
	[ACT_INTIME] [time](7) NULL,
	[ENTERED_BYSECURITY] [char](1) NULL,
	[CONTACT_PERSONID] [int] NULL,
	[VISITOR_PASSNO] [int] NULL,
	[Active] [int] NULL,
	[UpdRemarks] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[VISITOR_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ME_VISITOR_ACCESS]    Script Date: 9/10/2020 2:35:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ME_VISITOR_ACCESS](
	[ACC_ID] [int] IDENTITY(1,1) NOT NULL,
	[USERID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ACC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_MeExitAckMails]    Script Date: 9/10/2020 2:35:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_MeExitAckMails](
	[AckMailId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[mode] [varchar](2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Arc_Payslip_InValiddata]    Script Date: 9/10/2020 2:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arc_Payslip_InValiddata](
	[SLIP_ID] [float] NULL,
	[EMPCODE] [nvarchar](max) NULL,
	[PF_NUMBER] [nvarchar](max) NULL,
	[ESI_NUMBER] [nvarchar](max) NULL,
	[BANK_NAME] [nvarchar](max) NULL,
	[BANKACC_NUMBER] [nvarchar](250) NULL,
	[BASICPAY] [nvarchar](max) NULL,
	[HRA] [nvarchar](max) NULL,
	[CA] [nvarchar](max) NULL,
	[SDA] [nvarchar](max) NULL,
	[SA] [nvarchar](max) NULL,
	[GROSS_PM] [nvarchar](max) NULL,
	[PF_EMPLOYEE_PM] [nvarchar](max) NULL,
	[ESI_EMPLOYEE_PM] [nvarchar](max) NULL,
	[PF_TAX] [nvarchar](max) NULL,
	[LOP] [nvarchar](max) NULL,
	[LWF] [nvarchar](max) NULL,
	[NS_A] [nvarchar](max) NULL,
	[REF_BONUS] [nvarchar](max) NULL,
	[MEDICAL_REIM_PM] [nvarchar](max) NULL,
	[JOINING_BONUS] [nvarchar](max) NULL,
	[INCENTIVE] [nvarchar](max) NULL,
	[EARNED_LEAVE] [nvarchar](max) NULL,
	[GROSS_PA] [nvarchar](max) NULL,
	[BONUS_PA] [nvarchar](max) NULL,
	[GRATUITY_PA] [nvarchar](max) NULL,
	[PF_EMPLOYER_PA] [nvarchar](max) NULL,
	[ESI_EMPLOYER_PA] [nvarchar](max) NULL,
	[MEDICAL_REIM_PA] [nvarchar](max) NULL,
	[CTC_PA] [nvarchar](max) NULL,
	[DAYS_PAID] [numeric](18, 2) NULL,
	[LOP_DAYS] [numeric](18, 2) NULL,
	[INS] [nvarchar](max) NULL,
	[CREATED_BY] [nvarchar](max) NULL,
	[CREATED_DT] [nvarchar](max) NULL,
	[INCOME_TAX] [nvarchar](max) NULL,
	[DOJ] [nvarchar](max) NULL,
	[ErrorCode] [int] NULL,
	[ErrorColumn] [int] NULL,
	[UAN_NO] [nvarchar](max) NULL,
	[OTHER DEDUCTIONS] [nvarchar](max) NULL,
	[REASON] [nvarchar](max) NULL,
	[Userid] [nvarchar](max) NULL,
	[filename] [nvarchar](max) NULL,
	[upload_date] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Arc_Payslip_RawData]    Script Date: 9/10/2020 2:35:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arc_Payslip_RawData](
	[SLIP_ID] [float] NULL,
	[EMPCODE] [nvarchar](255) NULL,
	[PF_NUMBER] [nvarchar](255) NULL,
	[ESI_NUMBER] [nvarchar](255) NULL,
	[BANK_NAME] [nvarchar](255) NULL,
	[BANKACC_NUMBER] [nvarchar](255) NULL,
	[BASICPAY] [nvarchar](255) NULL,
	[HRA] [nvarchar](255) NULL,
	[CA] [nvarchar](255) NULL,
	[SDA] [nvarchar](255) NULL,
	[SA] [nvarchar](255) NULL,
	[GROSS_PM] [nvarchar](255) NULL,
	[PF_EMPLOYEE_PM] [nvarchar](255) NULL,
	[ESI_EMPLOYEE_PM] [nvarchar](255) NULL,
	[PF_TAX] [nvarchar](255) NULL,
	[LOP] [nvarchar](255) NULL,
	[LWF] [nvarchar](255) NULL,
	[NS_A] [nvarchar](255) NULL,
	[REF_BONUS] [nvarchar](255) NULL,
	[MEDICAL_REIM_PM] [nvarchar](255) NULL,
	[JOINING_BONUS] [nvarchar](255) NULL,
	[INCENTIVE] [nvarchar](255) NULL,
	[EARNED_LEAVE] [nvarchar](255) NULL,
	[GROSS_PA] [nvarchar](255) NULL,
	[BONUS_PA] [nvarchar](255) NULL,
	[GRATUITY_PA] [nvarchar](255) NULL,
	[PF_EMPLOYER_PA] [nvarchar](255) NULL,
	[ESI_EMPLOYER_PA] [nvarchar](255) NULL,
	[MEDICAL_REIM_PA] [nvarchar](255) NULL,
	[CTC_PA] [nvarchar](255) NULL,
	[DAYS_PAID] [nvarchar](255) NULL,
	[LOP_DAYS] [nvarchar](255) NULL,
	[INS] [nvarchar](255) NULL,
	[CREATED_BY] [nvarchar](255) NULL,
	[CREATED_DT] [nvarchar](255) NULL,
	[INCOME_TAX] [nvarchar](255) NULL,
	[DOJ] [nvarchar](255) NULL,
	[Other Deductions] [nvarchar](255) NULL,
	[UAN_NO] [nvarchar](50) NULL,
	[Userid] [nvarchar](500) NULL,
	[filename] [nvarchar](500) NULL,
	[upload_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_PAYSLIP_TEMPRAWDATA]    Script Date: 9/10/2020 2:35:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_PAYSLIP_TEMPRAWDATA](
	[SLIP_ID] [float] NULL,
	[EMPCODE] [nvarchar](255) NULL,
	[PF_NUMBER] [nvarchar](255) NULL,
	[ESI_NUMBER] [nvarchar](255) NULL,
	[BANK_NAME] [nvarchar](255) NULL,
	[BANKACC_NUMBER] [nvarchar](255) NULL,
	[BASICPAY] [nvarchar](255) NULL,
	[HRA] [nvarchar](255) NULL,
	[CA] [nvarchar](255) NULL,
	[SDA] [nvarchar](255) NULL,
	[SA] [nvarchar](255) NULL,
	[GROSS_PM] [nvarchar](255) NULL,
	[PF_EMPLOYEE_PM] [nvarchar](255) NULL,
	[ESI_EMPLOYEE_PM] [nvarchar](255) NULL,
	[PF_TAX] [nvarchar](255) NULL,
	[LOP] [nvarchar](255) NULL,
	[LWF] [nvarchar](255) NULL,
	[NS_A] [nvarchar](255) NULL,
	[REF_BONUS] [nvarchar](255) NULL,
	[MEDICAL_REIM_PM] [nvarchar](255) NULL,
	[JOINING_BONUS] [nvarchar](255) NULL,
	[INCENTIVE] [nvarchar](255) NULL,
	[EARNED_LEAVE] [nvarchar](255) NULL,
	[GROSS_PA] [nvarchar](255) NULL,
	[BONUS_PA] [nvarchar](255) NULL,
	[GRATUITY_PA] [nvarchar](255) NULL,
	[PF_EMPLOYER_PA] [nvarchar](255) NULL,
	[ESI_EMPLOYER_PA] [nvarchar](255) NULL,
	[MEDICAL_REIM_PA] [nvarchar](255) NULL,
	[CTC_PA] [nvarchar](255) NULL,
	[DAYS_PAID] [nvarchar](255) NULL,
	[LOP_DAYS] [nvarchar](255) NULL,
	[INS] [nvarchar](255) NULL,
	[CREATED_BY] [nvarchar](255) NULL,
	[CREATED_DT] [nvarchar](255) NULL,
	[INCOME_TAX] [nvarchar](255) NULL,
	[DOJ] [nvarchar](255) NULL,
	[Other Deductions] [nvarchar](255) NULL,
	[UAN_NO] [nvarchar](50) NULL,
	[Userid] [nvarchar](500) NULL,
	[filename] [nvarchar](500) NULL,
	[upload_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Arc_Payslip_Validdata]    Script Date: 9/10/2020 2:35:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arc_Payslip_Validdata](
	[SLIP_ID] [int] NULL,
	[EMPCODE] [varchar](250) NULL,
	[PF_NUMBER] [varchar](250) NULL,
	[ESI_NUMBER] [varchar](250) NULL,
	[BANK_NAME] [varchar](250) NULL,
	[BANKACC_NUMBER] [nvarchar](250) NULL,
	[BASICPAY] [decimal](20, 2) NULL,
	[HRA] [decimal](20, 2) NULL,
	[CA] [decimal](20, 2) NULL,
	[SDA] [decimal](20, 2) NULL,
	[SA] [decimal](20, 2) NULL,
	[GROSS_PM] [decimal](20, 2) NULL,
	[PF_EMPLOYEE_PM] [decimal](20, 2) NULL,
	[ESI_EMPLOYEE_PM] [decimal](20, 2) NULL,
	[PF_TAX] [decimal](20, 2) NULL,
	[LOP] [decimal](20, 2) NULL,
	[LWF] [decimal](20, 2) NULL,
	[NS_A] [decimal](20, 2) NULL,
	[REF_BONUS] [decimal](20, 2) NULL,
	[MEDICAL_REIM_PM] [decimal](20, 2) NULL,
	[JOINING_BONUS] [decimal](20, 2) NULL,
	[INCENTIVE] [decimal](20, 2) NULL,
	[EARNED_LEAVE] [decimal](20, 2) NULL,
	[GROSS_PA] [decimal](20, 2) NULL,
	[BONUS_PA] [decimal](20, 2) NULL,
	[GRATUITY_PA] [decimal](20, 2) NULL,
	[PF_EMPLOYER_PA] [decimal](20, 2) NULL,
	[ESI_EMPLOYER_PA] [decimal](20, 2) NULL,
	[MEDICAL_REIM_PA] [decimal](20, 2) NULL,
	[CTC_PA] [decimal](20, 2) NULL,
	[DAYS_PAID] [numeric](18, 2) NULL,
	[LOP_DAYS] [numeric](18, 2) NULL,
	[INS] [decimal](20, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[INCOME_TAX] [decimal](20, 2) NULL,
	[DOJ] [datetime] NULL,
	[OTHER DEDUCTIONS] [float] NULL,
	[UAN_NO] [varchar](250) NULL,
	[Userid] [nvarchar](500) NULL,
	[filename] [nvarchar](500) NULL,
	[upload_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_PAYSLIP_VALIDDATA_REASONS]    Script Date: 9/10/2020 2:35:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_PAYSLIP_VALIDDATA_REASONS](
	[SLIP_ID] [varchar](50) NULL,
	[EMPCODE] [varchar](50) NULL,
	[PF_NUMBER] [varchar](50) NULL,
	[ESI_NUMBER] [varchar](50) NULL,
	[BANK_NAME] [varchar](50) NULL,
	[BANKACC_NUMBER] [varchar](50) NULL,
	[BASICPAY] [varchar](50) NULL,
	[HRA] [varchar](50) NULL,
	[CA] [varchar](50) NULL,
	[SDA] [varchar](50) NULL,
	[SA] [varchar](50) NULL,
	[GROSS_PM] [varchar](50) NULL,
	[PF_EMPLOYEE_PM] [varchar](50) NULL,
	[ESI_EMPLOYEE_PM] [varchar](50) NULL,
	[PF_TAX] [varchar](50) NULL,
	[LOP] [varchar](50) NULL,
	[LWF] [varchar](50) NULL,
	[NS_A] [varchar](50) NULL,
	[REF_BONUS] [varchar](50) NULL,
	[MEDICAL_REIM_PM] [varchar](50) NULL,
	[JOINING_BONUS] [varchar](50) NULL,
	[INCENTIVE] [varchar](50) NULL,
	[EARNED_LEAVE] [varchar](50) NULL,
	[GROSS_PA] [varchar](50) NULL,
	[BONUS_PA] [varchar](50) NULL,
	[GRATUITY_PA] [varchar](50) NULL,
	[PF_EMPLOYER_PA] [varchar](50) NULL,
	[ESI_EMPLOYER_PA] [varchar](50) NULL,
	[MEDICAL_REIM_PA] [varchar](50) NULL,
	[CTC_PA] [varchar](50) NULL,
	[DAYS_PAID] [varchar](50) NULL,
	[LOP_DAYS] [varchar](50) NULL,
	[INS] [varchar](50) NULL,
	[CREATED_BY] [varchar](50) NULL,
	[CREATED_DT] [varchar](50) NULL,
	[INCOME_TAX] [varchar](50) NULL,
	[DOJ] [varchar](50) NULL,
	[ErrorCode] [varchar](50) NULL,
	[ErrorColumn] [varchar](50) NULL,
	[UAN_NO] [varchar](50) NULL,
	[OTHER DEDUCTIONS] [varchar](50) NULL,
	[REASON] [varchar](max) NULL,
	[SLIP_ID_reas] [varchar](50) NULL,
	[EMPCODE_reas] [varchar](50) NULL,
	[PF_NUMBER_reas] [varchar](50) NULL,
	[ESI_NUMBER_reas] [varchar](50) NULL,
	[BANK_NAME_reas] [varchar](50) NULL,
	[BANKACC_NUMBER_reas] [varchar](50) NULL,
	[BASICPAY_reas] [varchar](50) NULL,
	[HRA_reas] [varchar](50) NULL,
	[CA_reas] [varchar](50) NULL,
	[SDA_reas] [varchar](50) NULL,
	[SA_reas] [varchar](50) NULL,
	[GROSS_PM_reas] [varchar](50) NULL,
	[PF_EMPLOYEE_PM_reas] [varchar](50) NULL,
	[ESI_EMPLOYEE_PM_reas] [varchar](50) NULL,
	[PF_TAX_reas] [varchar](50) NULL,
	[LOP_reas] [varchar](50) NULL,
	[LWF_reas] [varchar](50) NULL,
	[NS_A_reas] [varchar](50) NULL,
	[REF_BONUS_reas] [varchar](50) NULL,
	[MEDICAL_REIM_PM_reas] [varchar](50) NULL,
	[JOINING_BONUS_reas] [varchar](50) NULL,
	[INCENTIVE_reas] [varchar](50) NULL,
	[EARNED_LEAVE_reas] [varchar](50) NULL,
	[GROSS_PA_reas] [varchar](50) NULL,
	[BONUS_PA_reas] [varchar](50) NULL,
	[GRATUITY_PA_reas] [varchar](50) NULL,
	[PF_EMPLOYER_PA_reas] [varchar](50) NULL,
	[ESI_EMPLOYER_PA_reas] [varchar](50) NULL,
	[MEDICAL_REIM_PA_reas] [varchar](50) NULL,
	[CTC_PA_reas] [varchar](50) NULL,
	[DAYS_PAID_reas] [varchar](50) NULL,
	[LOP_DAYS_reas] [varchar](50) NULL,
	[INS_reas] [varchar](50) NULL,
	[CREATED_BY_reas] [varchar](50) NULL,
	[CREATED_DT_reas] [varchar](50) NULL,
	[INCOME_TAX_reas] [varchar](50) NULL,
	[DOJ_reas] [varchar](50) NULL,
	[ErrorCode_reas] [varchar](50) NULL,
	[ErrorColumn_reas] [varchar](50) NULL,
	[UAN_NO_reas] [varchar](50) NULL,
	[OTHER DEDUCTIONS_reas] [varchar](50) NULL,
	[REASON1] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_POINTS]    Script Date: 9/10/2020 2:35:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_POINTS](
	[EventDate] [datetime] NULL,
	[Userid] [float] NULL,
	[Achived] [float] NULL,
	[New] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_POSITIONDTLS]    Script Date: 9/10/2020 2:35:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_POSITIONDTLS](
	[POSITIONID] [int] IDENTITY(1,1) NOT NULL,
	[PositionName] [varchar](250) NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[POSITIONID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_APPLICANT_STATUS_FB]    Script Date: 9/10/2020 2:35:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_APPLICANT_STATUS_FB](
	[REC_ID] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[STATUS_ID] [int] NULL,
	[S_ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK__ARC_REC___A3DFF16D10E215C4] PRIMARY KEY CLUSTERED 
(
	[S_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ASSESSMENT]    Script Date: 9/10/2020 2:35:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ASSESSMENT](
	[REC_ID] [int] NULL,
	[ASSESS_MODE] [varchar](1) NULL,
	[PRESENTATION] [varchar](1) NULL,
	[COMMUNICATION] [varchar](1) NULL,
	[INITIATIVE] [varchar](1) NULL,
	[SELF_CONFIDENCE] [varchar](1) NULL,
	[ADAPTABILITY] [varchar](1) NULL,
	[EXP_QUALITY] [varchar](1) NULL,
	[TECHNICAL_SKILLS] [varchar](1) NULL,
	[SUPERVISORY_SKILLS] [varchar](1) NULL,
	[GROWTH_POTENTIAL] [varchar](1) NULL,
	[OTHER_SKILLS] [varchar](1) NULL,
	[OVERALL_PERFORMANCE] [varchar](1) NULL,
	[REMARKS] [varchar](8000) NULL,
	[APPLICANT_STATUS] [varchar](1) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[RESULT] [varchar](50) NULL,
	[CTC] [decimal](10, 2) NULL,
	[JOINDATE] [date] NULL,
	[JOIN_DAYS] [int] NULL,
	[SCHEDULE_ID] [int] NULL,
	[JOIN_TIME] [time](7) NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
	[StatusCategory] [varchar](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ASSESSMENT_LOG]    Script Date: 9/10/2020 2:35:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ASSESSMENT_LOG](
	[REC_ID] [int] NULL,
	[ASSESS_MODE] [varchar](1) NULL,
	[PRESENTATION] [varchar](1) NULL,
	[COMMUNICATION] [varchar](1) NULL,
	[INITIATIVE] [varchar](1) NULL,
	[SELF_CONFIDENCE] [varchar](1) NULL,
	[ADAPTABILITY] [varchar](1) NULL,
	[EXP_QUALITY] [varchar](1) NULL,
	[TECHNICAL_SKILLS] [varchar](1) NULL,
	[SUPERVISORY_SKILLS] [varchar](1) NULL,
	[GROWTH_POTENTIAL] [varchar](1) NULL,
	[OTHER_SKILLS] [varchar](1) NULL,
	[OVERALL_PERFORMANCE] [varchar](1) NULL,
	[REMARKS] [varchar](8000) NULL,
	[APPLICANT_STATUS] [varchar](1) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[RESULT] [varchar](50) NULL,
	[CTC] [decimal](10, 2) NULL,
	[JOINDATE] [date] NULL,
	[JOIN_DAYS] [int] NULL,
	[SCHEDULE_ID] [int] NULL,
	[JOIN_TIME] [time](7) NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
	[StatusCategory] [varchar](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ASSESSMENT_SCHEDULED]    Script Date: 9/10/2020 2:35:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ASSESSMENT_SCHEDULED](
	[SCHEDULE_ID] [int] IDENTITY(1,1) NOT NULL,
	[REC_ID] [int] NULL,
	[INTERVIEWER_ID] [int] NULL,
	[SC_DATE] [date] NULL,
	[SC_FROMTIME] [time](7) NULL,
	[SC_TOTIME] [time](7) NULL,
	[SC_STATUS] [bit] NULL,
	[STATUS_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[BATCH_NO] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SCHEDULE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ASSESSMENT_SCHEDULED_LOG]    Script Date: 9/10/2020 2:35:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ASSESSMENT_SCHEDULED_LOG](
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
	[REC_ID] [int] NULL,
	[INTERVIEWER_ID] [int] NULL,
	[SC_DATE] [date] NULL,
	[SC_FROMTIME] [time](7) NULL,
	[SC_TOTIME] [time](7) NULL,
	[SC_STATUS] [bit] NULL,
	[STATUS_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[BATCH_NO] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ROW_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_AthenaUserInfo_backup]    Script Date: 9/10/2020 2:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_AthenaUserInfo_backup](
	[UserId] [int] NULL,
	[NT_UserName] [varchar](75) NULL,
	[EmpCode] [varchar](20) NULL,
	[AthenaUserName] [varchar](75) NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Attendance]    Script Date: 9/10/2020 2:35:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Attendance](
	[Aid] [int] IDENTITY(1,1) NOT NULL,
	[Userid] [int] NULL,
	[NT_UserName] [varchar](100) NULL,
	[Date] [date] NULL,
	[Shiftid] [tinyint] NULL,
	[LogOn] [datetime] NULL,
	[LogOut] [datetime] NULL,
	[TotalHrs] [numeric](18, 2) NULL,
	[WorkHours] [numeric](18, 2) NULL,
	[LockHrs] [numeric](18, 2) NULL,
	[LateIn] [numeric](18, 2) NULL,
	[LateOut] [numeric](18, 2) NULL,
	[Designid] [int] NULL,
	[Functionalityid] [int] NULL,
	[CreatedBy] [int] NULL,
	[Createdon] [datetime] NULL,
	[Shift_from] [time](7) NULL,
	[Shift_to] [time](7) NULL,
	[Verified_Present] [char](2) NULL,
	[Verified_By] [int] NULL,
	[Verified_Comments] [varchar](max) NULL,
	[Client_id] [int] NULL,
	[ActLogin] [datetime] NULL,
	[ActLogout] [datetime] NULL,
	[P_days] [numeric](18, 2) NULL,
	[CompOffEligible] [bit] NULL,
	[IsDeclaredOff] [bit] NULL,
	[OTEligible] [bit] NULL,
	[AttLocationid] [int] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[Aid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ATTENDANCE_ACCESS]    Script Date: 9/10/2020 2:35:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ATTENDANCE_ACCESS](
	[ACC_ID] [int] IDENTITY(1,1) NOT NULL,
	[USERID] [int] NOT NULL,
	[ATT_TYPE] [varchar](2) NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[USERID] ASC,
	[ATT_TYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Attendance_Archive]    Script Date: 9/10/2020 2:35:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Attendance_Archive](
	[LAid] [int] IDENTITY(1,1) NOT NULL,
	[Aid] [int] NULL,
	[Userid] [int] NULL,
	[NT_UserName] [varchar](100) NULL,
	[Date] [date] NULL,
	[Shiftid] [tinyint] NULL,
	[LogOn] [datetime] NULL,
	[LogOut] [datetime] NULL,
	[TotalHrs] [numeric](18, 2) NULL,
	[WorkHours] [numeric](18, 2) NULL,
	[LockHrs] [numeric](18, 2) NULL,
	[LateIn] [numeric](18, 2) NULL,
	[LateOut] [numeric](18, 2) NULL,
	[Designid] [int] NULL,
	[Functionalityid] [int] NULL,
	[CreatedBy] [int] NULL,
	[Createdon] [datetime] NULL,
	[Shift_from] [time](7) NULL,
	[Shift_to] [time](7) NULL,
	[Verified_Present] [char](2) NULL,
	[Verified_By] [int] NULL,
	[Verified_Comments] [varchar](max) NULL,
	[Client_id] [int] NULL,
	[ActLogin] [datetime] NULL,
	[ActLogout] [datetime] NULL,
	[P_days] [numeric](18, 2) NULL,
	[CompOffEligible] [bit] NULL,
	[IsDeclaredOff] [bit] NULL,
	[OTEligible] [bit] NULL,
	[LogOnUser] [varchar](100) NULL,
	[ALterOn] [datetime] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[LAid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Attendancelog]    Script Date: 9/10/2020 2:35:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Attendancelog](
	[Aid] [int] NULL,
	[UserId] [int] NULL,
	[NT_UserName] [varchar](100) NULL,
	[Date] [date] NULL,
	[Shiftid] [int] NULL,
	[LogOn] [datetime] NULL,
	[LogOut] [datetime] NULL,
	[TotalHrs] [numeric](9, 2) NULL,
	[WorkHours] [numeric](18, 2) NULL,
	[LockHrs] [numeric](9, 2) NULL,
	[LateIn] [numeric](9, 2) NULL,
	[LateOut] [numeric](9, 2) NULL,
	[Designid] [int] NULL,
	[Functionalityid] [int] NULL,
	[CreatedBy] [int] NULL,
	[Createdon] [datetime] NULL,
	[Shift_from] [time](7) NULL,
	[Shift_to] [time](7) NULL,
	[Verified_Present] [varchar](1) NULL,
	[Verified_By] [int] NULL,
	[Verified_Comments] [varchar](max) NULL,
	[Client_id] [int] NULL,
	[ActLogin] [datetime] NULL,
	[ActLogout] [datetime] NULL,
	[P_days] [numeric](9, 2) NULL,
	[CompOffEligible] [bit] NULL,
	[IsDeclaredOff] [bit] NULL,
	[OTEligible] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_BenchMovement]    Script Date: 9/10/2020 2:35:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_BenchMovement](
	[OldMprId] [int] NULL,
	[NewMprId] [int] NULL,
	[CustomerId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_BenchUsers]    Script Date: 9/10/2020 2:35:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_BenchUsers](
	[UserId] [int] NULL,
	[RecId] [int] NULL,
	[MPRId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_BloodGroup]    Script Date: 9/10/2020 2:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_BloodGroup](
	[BloodGroup] [int] NOT NULL,
	[GroupName] [varchar](6) NOT NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIATE_PROFILE]    Script Date: 9/10/2020 2:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIATE_PROFILE](
	[REC_ID] [int] NOT NULL,
	[PROCESS_ID] [int] NOT NULL,
	[FIRSTNAME] [varchar](50) NOT NULL,
	[LASTNAME] [varchar](50) NOT NULL,
	[DOB] [date] NOT NULL,
	[MARITAL_STATUS] [varchar](1) NOT NULL,
	[FATHER_NAME] [varchar](50) NOT NULL,
	[SPOUSE_NAME] [varchar](50) NOT NULL,
	[PER_ADDRESS1] [varchar](255) NULL,
	[PER_ADDRESS2] [varchar](255) NULL,
	[PER_LOCATION] [varchar](255) NULL,
	[PER_STATE_ID] [int] NOT NULL,
	[PER_CITY] [varchar](30) NOT NULL,
	[PER_PINCODE] [varchar](6) NOT NULL,
	[PRE_ADDRESS1] [varchar](255) NULL,
	[PRE_ADDRESS2] [varchar](255) NULL,
	[PRE_LOCATION] [varchar](50) NULL,
	[PRE_STATE_ID] [int] NOT NULL,
	[PRE_CITY] [varchar](30) NOT NULL,
	[PRE_PINCODE] [varchar](6) NOT NULL,
	[TELEPHONE_NO] [varchar](15) NOT NULL,
	[MOBILE_NO] [varchar](10) NOT NULL,
	[EMAIL_ID] [varchar](50) NOT NULL,
	[REL_EXP] [int] NOT NULL,
	[CTC] [decimal](10, 2) NOT NULL,
	[E_CTC] [decimal](10, 2) NOT NULL,
	[SHIFTS] [varchar](1) NULL,
	[KNOW_ABOUT_US] [varchar](2) NULL,
	[EMPLOYEE_ID] [varchar](12) NOT NULL,
	[EMER_CONTACT_NAME] [varchar](30) NULL,
	[EMER_CONTACT_NO] [varchar](10) NULL,
	[BLOODGROUP] [varchar](4) NOT NULL,
	[JOIN_DAYS] [int] NOT NULL,
	[PRE_APPLIED] [varchar](1) NULL,
	[CREATED_DT] [datetime] NULL,
	[FBLIKE] [int] NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[GENDER] [char](1) NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
	[locationid] [int] NULL,
	[UPDATED_DT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[REC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIATE_PROFILE_LOG]    Script Date: 9/10/2020 2:35:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIATE_PROFILE_LOG](
	[REC_ID] [int] NULL,
	[PROCESS_ID] [int] NULL,
	[FIRSTNAME] [varchar](50) NULL,
	[LASTNAME] [varchar](50) NULL,
	[DOB] [date] NULL,
	[MARITAL_STATUS] [varchar](1) NULL,
	[FATHER_NAME] [varchar](50) NULL,
	[SPOUSE_NAME] [varchar](50) NULL,
	[PER_ADDRESS1] [varchar](255) NULL,
	[PER_ADDRESS2] [varchar](255) NULL,
	[PER_LOCATION] [varchar](30) NULL,
	[PER_STATE_ID] [int] NULL,
	[PER_CITY] [varchar](30) NULL,
	[PER_PINCODE] [varchar](6) NULL,
	[PRE_ADDRESS1] [varchar](255) NULL,
	[PRE_ADDRESS2] [varchar](255) NULL,
	[PRE_LOCATION] [varchar](30) NULL,
	[PRE_STATE_ID] [int] NULL,
	[PRE_CITY] [varchar](30) NULL,
	[PRE_PINCODE] [varchar](6) NULL,
	[TELEPHONE_NO] [varchar](15) NULL,
	[MOBILE_NO] [varchar](10) NULL,
	[EMAIL_ID] [varchar](50) NULL,
	[REL_EXP] [int] NULL,
	[CTC] [decimal](10, 2) NULL,
	[E_CTC] [decimal](10, 2) NULL,
	[SHIFTS] [int] NULL,
	[KNOW_ABOUT_US] [varchar](2) NULL,
	[EMPLOYEE_ID] [varchar](12) NULL,
	[EMER_CONTACT_NAME] [varchar](30) NULL,
	[EMER_CONTACT_NO] [varchar](10) NULL,
	[BLOODGROUP] [varchar](4) NULL,
	[JOIN_DAYS] [int] NULL,
	[PRE_APPLIED] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[FBLIKE] [varchar](1) NULL,
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[GENDER] [char](1) NULL,
	[UPDATED_DT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ROW_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE]    Script Date: 9/10/2020 2:35:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE](
	[REC_ID] [int] NOT NULL,
	[NAME] [varchar](100) NULL,
	[CONTACTNO] [varchar](15) NOT NULL,
	[CREATED_DT] [datetime] NULL,
	[PROFILE_IMAGE_NAME] [varchar](75) NULL,
	[APPLY_FB] [int] NULL,
	[RegByAHS] [bit] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
	[PROCESS_ID] [int] NULL,
	[OTHER_FUNID] [int] NULL,
	[EXP_ID] [int] NULL,
	[ImagedUpdatedCount] [int] NULL,
	[LocationID] [int] NOT NULL,
	[SUBPROCESS_ID] [int] NULL,
	[RehireComments] [varchar](500) NULL,
	[Active] [int] NULL,
	[RecruitedBy] [varchar](500) NULL,
	[GENDER] [char](1) NULL,
	[PINCODE] [varchar](6) NULL,
	[LOCATION] [varchar](30) NULL,
	[STATE_ID] [int] NULL,
	[CITY] [varchar](30) NULL,
	[KNOW_ABOUT_US] [int] NULL,
	[EMAIL_ID] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[REC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE_DOC_STATUS]    Script Date: 9/10/2020 2:35:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE_DOC_STATUS](
	[REC_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[DOC_TYPE] [varchar](20) NULL,
	[DOC_FILE] [varchar](40) NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE_EDUCATION]    Script Date: 9/10/2020 2:35:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE_EDUCATION](
	[REC_ID] [int] NOT NULL,
	[INSTITUTE] [varchar](50) NOT NULL,
	[EDU_LEVEL] [int] NOT NULL,
	[COURSE_NAME] [varchar](30) NULL,
	[MAJOR] [varchar](30) NULL,
	[ENTRYORDER] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE_EDUCATION_LOG]    Script Date: 9/10/2020 2:35:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE_EDUCATION_LOG](
	[REC_ID] [int] NULL,
	[INSTITUTE] [varchar](50) NULL,
	[EDU_LEVEL] [int] NULL,
	[COURSE_NAME] [varchar](30) NULL,
	[MAJOR] [varchar](30) NULL,
	[ENTRYORDER] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ROW_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE_LOG]    Script Date: 9/10/2020 2:35:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE_LOG](
	[REC_ID] [int] NOT NULL,
	[NAME] [varchar](30) NOT NULL,
	[CONTACTNO] [varchar](15) NOT NULL,
	[CREATED_DT] [datetime] NULL,
	[PROFILE_IMAGE_NAME] [varchar](75) NULL,
	[APPLY_FB] [int] NULL,
	[RegByAHS] [bit] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
	[PROCESS_ID] [int] NULL,
	[OTHER_FUNID] [int] NULL,
	[EXP_ID] [int] NULL,
	[ImagedUpdatedCount] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE_MEDICLAIM_INFO]    Script Date: 9/10/2020 2:35:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE_MEDICLAIM_INFO](
	[MId] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](10) NULL,
	[D1Name] [varchar](100) NULL,
	[D1DOB] [date] NULL,
	[D2Name] [varchar](100) NULL,
	[D2DOB] [date] NULL,
	[D3Name] [varchar](100) NULL,
	[D3DOB] [date] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ACTIVE] [char](1) NULL,
	[MaritalStatus] [varchar](10) NULL,
	[D4Name] [varchar](100) NULL,
	[D4DOB] [date] NULL,
	[D5Name] [varchar](100) NULL,
	[D5DOB] [date] NULL,
	[REC_ID] [int] NULL,
 CONSTRAINT [PK_ARC_REC_CANDIDATE_MEDICLAIM_INFO] PRIMARY KEY CLUSTERED 
(
	[MId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE_MEDICLAIM_INFO_LOG]    Script Date: 9/10/2020 2:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE_MEDICLAIM_INFO_LOG](
	[MId] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](10) NULL,
	[D1Name] [varchar](100) NULL,
	[D1DOB] [date] NULL,
	[D2Name] [varchar](100) NULL,
	[D2DOB] [date] NULL,
	[D3Name] [varchar](100) NULL,
	[D3DOB] [date] NULL,
	[Dtype] [char](1) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ACTIVE] [char](1) NULL,
	[MaritalStatus] [varchar](10) NULL,
	[D4Name] [varchar](100) NULL,
	[D4DOB] [date] NULL,
	[D5Name] [varchar](100) NULL,
	[D5DOB] [date] NULL,
	[REC_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE_STATUS]    Script Date: 9/10/2020 2:35:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE_STATUS](
	[REC_ID] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[STATUS_ID] [int] NULL,
	[SCHEDULE_ID] [int] NULL,
	[UPDATED_DT] [datetime] NULL,
	[UPDATED_BY] [int] NULL,
	[S_ID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[S_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[REC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE_STATUS_INFO]    Script Date: 9/10/2020 2:36:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE_STATUS_INFO](
	[STATUS_TEXT] [varchar](50) NULL,
	[STATUS_ID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[STATUS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE_WORKEXP]    Script Date: 9/10/2020 2:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE_WORKEXP](
	[REC_ID] [int] NOT NULL,
	[COMPANY_NAME] [varchar](50) NULL,
	[DOJ] [date] NULL,
	[DOL] [date] NULL,
	[LEAVING_REASON] [varchar](50) NULL,
	[REF_CONTACT_NAME] [varchar](50) NULL,
	[REF_CONTACT_NO] [varchar](15) NULL,
	[ENTRYORDER] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[DESIGNATION] [varchar](2000) NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATE_WORKEXP_LOG]    Script Date: 9/10/2020 2:36:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATE_WORKEXP_LOG](
	[REC_ID] [int] NULL,
	[COMPANY_NAME] [varchar](50) NULL,
	[DOJ] [date] NULL,
	[DOL] [date] NULL,
	[LEAVING_REASON] [varchar](50) NULL,
	[REF_CONTACT_NAME] [varchar](50) NULL,
	[REF_CONTACT_NO] [varchar](15) NULL,
	[ENTRYORDER] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
	[DESIGNATION] [varchar](2000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ROW_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CANDIDATEIMG_LOG]    Script Date: 9/10/2020 2:36:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CANDIDATEIMG_LOG](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RecId] [int] NULL,
	[OldImage] [varchar](50) NULL,
	[NewImage] [varchar](50) NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CAPMAN]    Script Date: 9/10/2020 2:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CAPMAN](
	[Capid] [int] IDENTITY(1,1) NOT NULL,
	[BayId] [int] NULL,
	[BayIP] [varchar](20) NULL,
	[FacilityId] [int] NULL,
	[ClientID] [int] NULL,
	[BayStatus] [tinyint] NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [varchar](70) NULL,
	[Createdon] [datetime] NULL,
	[ModifiedBy] [varchar](70) NULL,
	[ModifiedOn] [datetime] NULL,
	[ShiftId] [tinyint] NULL,
	[FunctionalityId] [int] NULL,
 CONSTRAINT [PK_Capid] PRIMARY KEY CLUSTERED 
(
	[Capid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Arc_Rec_CapmanAccess]    Script Date: 9/10/2020 2:36:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arc_Rec_CapmanAccess](
	[Aid] [int] IDENTITY(1,1) NOT NULL,
	[NT_UserName] [varchar](75) NULL,
	[Status] [tinyint] NULL,
	[Createddate] [datetime] NULL,
	[CreatedBy] [varchar](75) NULL,
PRIMARY KEY CLUSTERED 
(
	[Aid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CLOSED]    Script Date: 9/10/2020 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CLOSED](
	[REC_ID] [int] NOT NULL,
	[MPR_ID] [int] NOT NULL,
	[REMARKS] [varchar](8000) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MPR_ID] ASC,
	[REC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CurrentCompetitor]    Script Date: 9/10/2020 2:36:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CurrentCompetitor](
	[COMPANY_ID] [int] IDENTITY(1,1) NOT NULL,
	[COMPANY_NAME] [varchar](50) NULL,
	[ACTIVE] [bit] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
 CONSTRAINT [PK_ARC_REC_CurrentCompetitor] PRIMARY KEY CLUSTERED 
(
	[COMPANY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CustomerLog]    Script Date: 9/10/2020 2:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CustomerLog](
	[UserId] [int] NULL,
	[CustomerId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_CustomerServicewiseMenuAccess]    Script Date: 9/10/2020 2:36:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_CustomerServicewiseMenuAccess](
	[CustomerId] [int] NULL,
	[ServiceId] [int] NULL,
	[MenuId] [int] NULL,
	[Active] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
	[Comments] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Designationlog]    Script Date: 9/10/2020 2:36:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Designationlog](
	[DLId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[DesignationId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[IsPromoted] [char](1) NULL,
	[OldDesignationId] [int] NULL,
 CONSTRAINT [PK__ARC_REC___2871E3482D942E62] PRIMARY KEY CLUSTERED 
(
	[DLId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Rec_DesignationRole]    Script Date: 9/10/2020 2:36:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Rec_DesignationRole](
	[FunctionalityId] [int] NULL,
	[DesigId] [int] NULL,
	[RoleId] [int] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Rec_DesignationRole_20200402]    Script Date: 9/10/2020 2:36:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Rec_DesignationRole_20200402](
	[FunctionalityId] [int] NULL,
	[DesigId] [int] NULL,
	[RoleId] [int] NULL,
	[RowId] [int] NOT NULL,
	[createddt] [datetime] NULL,
	[createdby] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Rec_DesignationRole_bkup20200117]    Script Date: 9/10/2020 2:36:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Rec_DesignationRole_bkup20200117](
	[FunctionalityId] [int] NULL,
	[DesigId] [int] NULL,
	[RoleId] [int] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Rec_DesignationRole_JAN]    Script Date: 9/10/2020 2:36:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Rec_DesignationRole_JAN](
	[FunctionalityId] [int] NULL,
	[DesigId] [int] NULL,
	[RoleId] [int] NULL,
	[RowId] [int] NOT NULL,
	[createddt] [datetime] NULL,
	[createdby] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Document_Acknowledge]    Script Date: 9/10/2020 2:36:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Document_Acknowledge](
	[AckId] [int] IDENTITY(1,1) NOT NULL,
	[DocId] [int] NULL,
	[AcknowledgeBy] [int] NULL,
	[AcknowledgeOn] [datetime] NULL,
	[AckStatus] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Arc_Rec_EmpCodePrefix]    Script Date: 9/10/2020 2:36:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arc_Rec_EmpCodePrefix](
	[Year] [int] NULL,
	[Prefix] [varchar](1) NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ErrorLog]    Script Date: 9/10/2020 2:36:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ErrorLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[LogDescription] [varchar](1000) NULL,
	[FormDescription] [varchar](1000) NULL,
	[CreatedDt] [datetime] NULL,
	[NtUserName] [varchar](250) NULL,
	[ErrId] [varchar](50) NULL,
	[ErrType] [varchar](250) NULL,
	[ErrorStackTrace] [varchar](8000) NULL,
	[AppName] [varchar](50) NULL,
	[EventType] [varchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ErrorLog_Bakup]    Script Date: 9/10/2020 2:36:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ErrorLog_Bakup](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[LogDescription] [varchar](1000) NULL,
	[FormDescription] [varchar](1000) NULL,
	[CreatedDt] [datetime] NULL,
	[NtUserName] [varchar](250) NULL,
	[ErrId] [varchar](50) NULL,
	[ErrType] [varchar](250) NULL,
	[ErrorStackTrace] [varchar](8000) NULL,
	[AppName] [varchar](50) NULL,
	[EventType] [varchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_EXPERIENCE_INFO]    Script Date: 9/10/2020 2:36:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_EXPERIENCE_INFO](
	[REL_EXP] [int] IDENTITY(1,1) NOT NULL,
	[REL_EXP_TEXT] [varchar](20) NULL,
	[ACTIVE] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[REL_EXP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[REL_EXP_TEXT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_FacilityMaster]    Script Date: 9/10/2020 2:36:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_FacilityMaster](
	[FacilityId] [int] IDENTITY(1,1) NOT NULL,
	[FacilityName] [varchar](50) NULL,
	[Active] [char](1) NULL,
	[Add1] [varchar](200) NULL,
	[Add2] [varchar](200) NULL,
	[Add3] [varchar](200) NULL,
	[Add4] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_FileCopy]    Script Date: 9/10/2020 2:36:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_FileCopy](
	[FId] [int] NULL,
	[ImageName] [varchar](20) NULL,
	[DateCopied] [datetime] NULL,
	[Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_FilePath]    Script Date: 9/10/2020 2:36:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_FilePath](
	[SourcePath] [varchar](200) NULL,
	[DestinationPath] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_FootballCountries]    Script Date: 9/10/2020 2:36:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_FootballCountries](
	[CountryId] [int] NOT NULL,
	[CountryName] [varchar](22) NOT NULL,
	[Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_FootballTeams]    Script Date: 9/10/2020 2:36:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_FootballTeams](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_FunctionalityLog]    Script Date: 9/10/2020 2:36:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_FunctionalityLog](
	[USERID] [int] NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_HeldNotJoined]    Script Date: 9/10/2020 2:36:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_HeldNotJoined](
	[UserId] [int] NOT NULL,
	[Remarks] [varchar](500) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[ReleasedDt] [datetime] NULL,
	[ReleasedBy] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_HR_ASSESSMENTINFO]    Script Date: 9/10/2020 2:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_HR_ASSESSMENTINFO](
	[HA_ID] [int] IDENTITY(1,1) NOT NULL,
	[REC_ID] [int] NULL,
	[EXP_MONTHS] [int] NULL,
	[EXP_YEARS] [int] NULL,
	[CURRENT_CTC] [decimal](10, 2) NULL,
	[EXP_CTC] [decimal](10, 2) NULL,
	[JOIN_DAYS] [int] NULL,
	[PREVIOUSLY_APPLIED] [int] NULL,
	[CURRENT_EMPLOYER] [int] NULL,
	[REMARKS] [varchar](8000) NULL,
	[SUB_PROCESS_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
 CONSTRAINT [PK_ARC_REC_HR_ASSESSMENTINFO] PRIMARY KEY CLUSTERED 
(
	[HA_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_IDCard]    Script Date: 9/10/2020 2:36:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_IDCard](
	[Name] [varchar](50) NULL,
	[Emp_Code] [varchar](50) NOT NULL,
	[Dept] [varchar](250) NULL,
	[BG] [varchar](10) NULL,
	[Add1] [varchar](50) NULL,
	[Add2] [varchar](255) NULL,
	[Add3] [varchar](255) NULL,
	[Add4] [varchar](255) NULL,
	[Emergency_no] [varchar](255) NULL,
	[SourceFile] [varchar](250) NULL,
	[FacilityId] [int] NULL,
	[rowid] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Emp_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_IDWRAPPER]    Script Date: 9/10/2020 2:36:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_IDWRAPPER](
	[TBLNAME] [varchar](50) NOT NULL,
	[COLNAME] [varchar](25) NOT NULL,
	[VALUE] [int] NOT NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_InductionMaster]    Script Date: 9/10/2020 2:36:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_InductionMaster](
	[UserId] [int] NOT NULL,
	[SupervisorId] [int] NULL,
	[CustomerId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[Trainee] [char](1) NULL,
	[TrainingCompletedBy] [int] NULL,
	[TrainingCompleted] [datetime] NULL,
	[EmailAccessId] [int] NULL,
	[FolderAccessId] [int] NULL,
	[DistributionAccessId] [int] NULL,
	[InductionTaken] [bit] NULL,
	[InductionDate] [datetime] NULL,
	[InductionBy] [int] NULL,
	[InductionId] [int] IDENTITY(1,1) NOT NULL,
	[NTReqId] [int] NULL,
	[ProximityReqId] [int] NULL,
	[FacilityId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITREQUEST]    Script Date: 9/10/2020 2:36:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITREQUEST](
	[RequestId] [int] IDENTITY(1,1) NOT NULL,
	[RequestType] [tinyint] NULL,
	[FunctionId] [int] NULL,
	[RequestFrom] [tinyint] NULL,
	[Description] [varchar](max) NULL,
	[Reason] [varchar](max) NULL,
	[Benifit] [varchar](max) NULL,
	[Supervisor] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[StatusId] [tinyint] NULL,
	[ApprovedComments] [varchar](1000) NULL,
	[Priority] [varchar](10) NULL,
	[ApproveStatus] [varchar](15) NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedOn] [datetime] NULL,
	[RequestStatus] [tinyint] NULL,
	[SCHID] [int] NULL,
	[EstDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITREQUEST_APPROVE]    Script Date: 9/10/2020 2:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITREQUEST_APPROVE](
	[APPROVEID] [int] IDENTITY(1,1) NOT NULL,
	[REQUESTID] [int] NULL,
	[PRIORITY] [varchar](10) NULL,
	[TYPE_STATUS] [varchar](15) NULL,
	[STATUS] [tinyint] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DATE] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITREQUEST_ATTACHMENT]    Script Date: 9/10/2020 2:36:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITREQUEST_ATTACHMENT](
	[AId] [int] IDENTITY(1,1) NOT NULL,
	[AFileName] [varchar](500) NULL,
	[Requestid] [int] NULL,
	[StatusId] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITREQUEST_HISTORY]    Script Date: 9/10/2020 2:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITREQUEST_HISTORY](
	[HRID] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [int] NULL,
	[RequestType] [tinyint] NULL,
	[FunctionId] [int] NULL,
	[RequestFrom] [tinyint] NULL,
	[Description] [varchar](max) NULL,
	[Reason] [varchar](max) NULL,
	[Benifit] [varchar](max) NULL,
	[Supervisor] [int] NULL,
	[RequestStatus] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[StatusId] [tinyint] NULL,
	[ApprovedComments] [varchar](1000) NULL,
	[Priority] [varchar](10) NULL,
	[ApproveStatus] [varchar](15) NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedOn] [datetime] NULL,
	[HistoryOn] [datetime] NULL,
	[SCHID] [int] NULL,
	[EstDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITREQUEST_ITLIST]    Script Date: 9/10/2020 2:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITREQUEST_ITLIST](
	[ITLISTID] [int] IDENTITY(1,1) NOT NULL,
	[REQUESTID] [int] NULL,
	[DEVELOPERID] [int] NULL,
	[ITPRIORITY] [varchar](10) NULL,
	[ITEXPECTEDDATE] [datetime] NULL,
	[ITREQUESTSTATUS] [tinyint] NULL,
	[STATUSID] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDON] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITREQUEST_Log]    Script Date: 9/10/2020 2:36:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITREQUEST_Log](
	[RequestId] [int] IDENTITY(1,1) NOT NULL,
	[RequestType] [tinyint] NULL,
	[FunctionId] [int] NULL,
	[RequestFrom] [tinyint] NULL,
	[Description] [varchar](max) NULL,
	[Reason] [varchar](max) NULL,
	[Benifit] [varchar](max) NULL,
	[Supervisor] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[StatusId] [tinyint] NULL,
	[ApprovedComments] [varchar](1000) NULL,
	[Priority] [varchar](10) NULL,
	[ApproveStatus] [varchar](15) NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedOn] [datetime] NULL,
	[RequestStatus] [tinyint] NULL,
	[SCHID] [int] NULL,
	[EstDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITREQUEST_SCHEDULE]    Script Date: 9/10/2020 2:36:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITREQUEST_SCHEDULE](
	[SCHID] [int] IDENTITY(1,1) NOT NULL,
	[SCHEDULENAME] [varchar](50) NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDATE] [datetime] NULL,
	[STATUSID] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITREQUEST_STATUS]    Script Date: 9/10/2020 2:36:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITREQUEST_STATUS](
	[REQUESTSTATUS] [int] IDENTITY(1,1) NOT NULL,
	[STATUSNAME] [varchar](100) NULL,
	[STATUS] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITRequestProcessAccess]    Script Date: 9/10/2020 2:36:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITRequestProcessAccess](
	[UserId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[Active] [int] NULL,
	[AccessMode] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITRequestStatusInfo]    Script Date: 9/10/2020 2:36:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITRequestStatusInfo](
	[StatusId] [int] NOT NULL,
	[StatusCaption] [varchar](30) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_ITRequestStatusTran]    Script Date: 9/10/2020 2:36:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_ITRequestStatusTran](
	[TranId] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [int] NULL,
	[StatusId] [int] NULL,
	[AssignedTo] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[StatusComments] [varchar](8000) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[TranId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_KYC_Details]    Script Date: 9/10/2020 2:36:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_KYC_Details](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[BankAccno] [varchar](100) NULL,
	[BankPersonName] [varchar](200) NULL,
	[BankName] [varchar](200) NULL,
	[BankBranch] [varchar](200) NULL,
	[BankIFSCCode] [varchar](50) NULL,
	[PANNo] [varchar](10) NULL,
	[PANName] [varchar](150) NULL,
	[PassportNo] [varchar](150) NULL,
	[PassportName] [varchar](150) NULL,
	[PassportExpiryDate] [date] NULL,
	[DrivingLicenseNo] [varchar](50) NULL,
	[DrivingLicenseName] [varchar](150) NULL,
	[DrivingLicenseExpiryDate] [date] NULL,
	[AadharCardNo] [varchar](50) NULL,
	[AadharCardName] [varchar](150) NULL,
	[VotersID] [varchar](50) NULL,
	[VotersCardName] [varchar](150) NULL,
	[VotersCardAddress] [varchar](500) NULL,
	[RationCardNo] [varchar](50) NULL,
	[RationCardName] [varchar](150) NULL,
	[RationCardAddress] [varchar](500) NULL,
	[Active] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[ProofsSubmitted] [varchar](500) NULL,
	[ProofsSubmittedNames] [varchar](500) NULL,
 CONSTRAINT [PK_ARC_REC_KYC_Details] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_KYC_Proofs]    Script Date: 9/10/2020 2:36:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_KYC_Proofs](
	[ProofID] [int] IDENTITY(1,1) NOT NULL,
	[ProofName] [varchar](500) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_ARC_REC_KYC_Proofs] PRIMARY KEY CLUSTERED 
(
	[ProofID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_KYC_Proofs_Tran]    Script Date: 9/10/2020 2:36:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_KYC_Proofs_Tran](
	[UserID] [varchar](100) NULL,
	[DocumentType] [varchar](200) NULL,
	[DocumentNo] [varchar](100) NULL,
	[IFSCCode] [varchar](100) NULL,
	[Name] [varchar](500) NULL,
	[BankBranch] [varchar](100) NULL,
	[ExpiryDate] [date] NULL,
	[BankName] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_KYC_ReportAccess]    Script Date: 9/10/2020 2:36:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_KYC_ReportAccess](
	[UserID] [int] NULL,
	[Active] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVE_FORWARD]    Script Date: 9/10/2020 2:36:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVE_FORWARD](
	[LEAVE_FORWARDID] [int] IDENTITY(1,1) NOT NULL,
	[LEAVE_REQID] [int] NULL,
	[FORWARD_TO] [int] NULL,
	[REMARKS] [varchar](1000) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[LEAVE_STATUS] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[LEAVE_FORWARDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVE_FORWARD_2012]    Script Date: 9/10/2020 2:36:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVE_FORWARD_2012](
	[LEAVE_FORWARDID] [int] IDENTITY(1,1) NOT NULL,
	[LEAVE_REQID] [int] NULL,
	[FORWARD_TO] [int] NULL,
	[REMARKS] [varchar](1000) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
 CONSTRAINT [PK__ARC_REC___4E5975366E8CFDC0] PRIMARY KEY CLUSTERED 
(
	[LEAVE_FORWARDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVE_HOLIDAYLIST]    Script Date: 9/10/2020 2:36:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVE_HOLIDAYLIST](
	[HOLIDAY_LISTID] [int] IDENTITY(1,1) NOT NULL,
	[HOLIDAY_DATE] [date] NOT NULL,
	[HOLIDAY_DESCRIPTION] [varchar](50) NULL,
	[CREATED_DT] [datetime] NULL,
	[CREATED_BY] [int] NULL,
	[LISTTYPE] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HOLIDAY_DATE] ASC,
	[LISTTYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVE_HOLIDAYLIST_2012]    Script Date: 9/10/2020 2:36:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVE_HOLIDAYLIST_2012](
	[HOLIDAY_LISTID] [int] IDENTITY(1,1) NOT NULL,
	[HOLIDAY_DATE] [date] NOT NULL,
	[HOLIDAY_DESCRIPTION] [varchar](50) NULL,
	[CREATED_DT] [datetime] NULL,
	[CREATED_BY] [int] NULL,
	[LISTTYPE] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HOLIDAY_LISTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVE_LISTTYPE]    Script Date: 9/10/2020 2:36:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVE_LISTTYPE](
	[ListTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ListTypeName] [varchar](100) NULL,
	[ListTypeDesc] [varchar](500) NULL,
	[Active] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVE_OPENING]    Script Date: 9/10/2020 2:37:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVE_OPENING](
	[OPENING_DATE] [date] NOT NULL,
	[EMPLOYEE_ID] [int] NOT NULL,
	[TYPEID] [int] NOT NULL,
	[LEAVES] [decimal](4, 1) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OPENING_DATE] ASC,
	[EMPLOYEE_ID] ASC,
	[TYPEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVE_OPENING_2012]    Script Date: 9/10/2020 2:37:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVE_OPENING_2012](
	[OPENING_DATE] [date] NULL,
	[EMPLOYEE_ID] [int] NOT NULL,
	[TYPEID] [int] NOT NULL,
	[LEAVES] [decimal](4, 1) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK__ARC_REC___D5D42ADF69933E79] PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVE_REQUEST]    Script Date: 9/10/2020 2:37:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVE_REQUEST](
	[LEAVE_REQID] [int] IDENTITY(1,1) NOT NULL,
	[TYPEID] [int] NULL,
	[FROMDATE] [datetime] NULL,
	[TODATE] [datetime] NULL,
	[LEAVE_DAYS] [decimal](4, 1) NULL,
	[LEAVE_MODE] [varchar](1) NULL,
	[APPLIED_TO] [int] NULL,
	[REASON] [varchar](1000) NULL,
	[LEAVE_STATUS] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ACTIVE] [varchar](1) NULL,
	[FORWARD_TO] [int] NULL,
	[RESPONSE_REMARK] [varchar](1000) NULL,
	[RESPONSE_DATE] [datetime] NULL,
	[SELECTED_LEAVES] [decimal](4, 1) NULL,
	[DataChangeTicketId] [int] NULL,
	[DEACTIVATION_BY] [int] NULL,
	[DEACTIVATION_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LEAVE_REQID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[arc_Rec_leave_request_2012]    Script Date: 9/10/2020 2:37:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[arc_Rec_leave_request_2012](
	[LEAVE_REQID] [int] IDENTITY(1,1) NOT NULL,
	[TYPEID] [int] NULL,
	[FROMDATE] [datetime] NULL,
	[TODATE] [datetime] NULL,
	[LEAVE_DAYS] [decimal](4, 1) NULL,
	[LEAVE_MODE] [varchar](1) NULL,
	[APPLIED_TO] [int] NULL,
	[REASON] [varchar](1000) NULL,
	[LEAVE_STATUS] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ACTIVE] [varchar](1) NULL,
	[FORWARD_TO] [int] NULL,
	[RESPONSE_REMARK] [varchar](1000) NULL,
	[RESPONSE_DATE] [datetime] NULL,
	[SELECTED_LEAVES] [decimal](4, 1) NULL,
	[push_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LEAVE_REQID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[arc_Rec_leave_request_2012_2]    Script Date: 9/10/2020 2:37:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[arc_Rec_leave_request_2012_2](
	[LEAVE_REQID] [int] IDENTITY(1,1) NOT NULL,
	[TYPEID] [int] NULL,
	[FROMDATE] [datetime] NULL,
	[TODATE] [datetime] NULL,
	[LEAVE_DAYS] [decimal](4, 1) NULL,
	[LEAVE_MODE] [varchar](1) NULL,
	[APPLIED_TO] [int] NULL,
	[REASON] [varchar](1000) NULL,
	[LEAVE_STATUS] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ACTIVE] [varchar](1) NULL,
	[FORWARD_TO] [int] NULL,
	[RESPONSE_REMARK] [varchar](1000) NULL,
	[RESPONSE_DATE] [datetime] NULL,
	[SELECTED_LEAVES] [decimal](4, 1) NULL,
	[push_date] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LEAVE_REQID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVE_TRAN]    Script Date: 9/10/2020 2:37:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVE_TRAN](
	[LEAVE_TRANID] [int] IDENTITY(1,1) NOT NULL,
	[LEAVE_REQID] [int] NULL,
	[LEAVE_DATE] [date] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LEAVE_TRANID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[arc_Rec_leave_tran_2012]    Script Date: 9/10/2020 2:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[arc_Rec_leave_tran_2012](
	[LEAVE_TRANID] [int] NOT NULL,
	[LEAVE_REQID] [int] NULL,
	[LEAVE_DATE] [date] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK__arc_Rec___D5D42ADF6C6FAB24] PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVE_TYPES]    Script Date: 9/10/2020 2:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVE_TYPES](
	[TYPEID] [int] IDENTITY(1,1) NOT NULL,
	[TYPE_TEXT] [varchar](20) NULL,
	[DISPLAY_ORDER] [int] NULL,
	[SHORT_TEXT] [varchar](5) NULL,
	[FlowExclusion] [varchar](20) NULL,
	[ExclusionType] [int] NULL,
	[ExclusionDesc] [varchar](100) NULL,
	[MGRID] [int] NULL,
	[CssClass] [nvarchar](400) NULL,
PRIMARY KEY CLUSTERED 
(
	[TYPEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[TYPE_TEXT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LeaveOpeningForITNet]    Script Date: 9/10/2020 2:37:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LeaveOpeningForITNet](
	[Opening_Date] [date] NULL,
	[Employee_Id] [int] NULL,
	[TypeId] [int] NULL,
	[Leaves] [decimal](10, 2) NULL,
	[Created_By] [int] NULL,
	[Created_Dt] [datetime] NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LEAVES_EL_Settled]    Script Date: 9/10/2020 2:37:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LEAVES_EL_Settled](
	[UserId] [int] NULL,
	[DateOfCredit] [date] NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LegalDocument]    Script Date: 9/10/2020 2:37:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LegalDocument](
	[DocID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentName] [varchar](50) NULL,
	[PathName] [nvarchar](500) NULL,
	[Status] [tinyint] NULL,
	[Publish] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_DocID] PRIMARY KEY CLUSTERED 
(
	[DocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LOB_INFO]    Script Date: 9/10/2020 2:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LOB_INFO](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[lob] [varchar](100) NULL,
	[created_dt] [datetime] NULL,
	[active] [int] NULL,
	[userid] [int] NULL,
 CONSTRAINT [PK_LOB_ID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_LocationMaster]    Script Date: 9/10/2020 2:37:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_LocationMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](100) NOT NULL,
	[StateId] [int] NULL,
	[Status] [tinyint] NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_MIS_CityMaster_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_MAIL_TRAN]    Script Date: 9/10/2020 2:37:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_MAIL_TRAN](
	[FROM_MAILID] [varchar](100) NOT NULL,
	[RECIPIENTS] [varchar](max) NULL,
	[SUBJECT_TEXT] [varchar](500) NULL,
	[BODY] [nvarchar](max) NULL,
	[MAIL_STATUS] [bit] NULL,
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
	[ISHTML] [varchar](1) NULL,
	[CREATED_DT] [datetime] NULL,
	[CC] [varchar](max) NULL,
	[Active] [int] NULL,
	[FilePath] [varchar](1000) NULL,
	[BCC] [varchar](1000) NULL,
	[ErrMessage] [varchar](1000) NULL,
	[Deliveryon] [datetime] NULL,
	[Erroron] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ROW_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_MAIL_TRAN_20180403]    Script Date: 9/10/2020 2:37:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_MAIL_TRAN_20180403](
	[FROM_MAILID] [varchar](100) NOT NULL,
	[RECIPIENTS] [varchar](max) NULL,
	[SUBJECT_TEXT] [varchar](100) NULL,
	[BODY] [nvarchar](max) NULL,
	[MAIL_STATUS] [bit] NULL,
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
	[ISHTML] [varchar](1) NULL,
	[CREATED_DT] [datetime] NULL,
	[CC] [varchar](max) NULL,
	[Active] [int] NULL,
	[FilePath] [varchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Mediclaim_ReportAccess]    Script Date: 9/10/2020 2:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Mediclaim_ReportAccess](
	[UserId] [int] NULL,
	[Active] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_NTLogin]    Script Date: 9/10/2020 2:37:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_NTLogin](
	[EMPCODE] [varchar](10) NULL,
	[NT_USERNAME] [varchar](75) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_NtRequirementFields]    Script Date: 9/10/2020 2:37:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_NtRequirementFields](
	[RqId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NULL,
	[FieldType] [varchar](2) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RqId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Description] ASC,
	[FieldType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_POSTALCODE]    Script Date: 9/10/2020 2:37:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_POSTALCODE](
	[PCID] [int] IDENTITY(1,1) NOT NULL,
	[PINCODE] [int] NULL,
	[LOCATION] [varchar](100) NULL,
	[CITY] [varchar](50) NULL,
	[DISTRICT] [varchar](50) NULL,
	[STATE] [varchar](50) NULL,
	[CREATEDBY] [tinyint] NULL,
	[CREATEDON] [datetime] NULL,
 CONSTRAINT [PK_PCID] PRIMARY KEY CLUSTERED 
(
	[PCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_PROCESS_INFO]    Script Date: 9/10/2020 2:37:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_PROCESS_INFO](
	[PROCESS_ID] [int] IDENTITY(1,1) NOT NULL,
	[PROCESS_NAME] [varchar](30) NOT NULL,
	[ACTIVE] [bit] NOT NULL,
	[TYPING_GPM] [int] NULL,
	[TYPING_ACCURACY] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PROCESS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Rec_ProductionQT]    Script Date: 9/10/2020 2:37:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Rec_ProductionQT](
	[PQTID] [int] IDENTITY(1,1) NOT NULL,
	[TRAGETDATE] [datetime] NULL,
	[NTUSERNAME] [varchar](100) NULL,
	[PTARGET] [int] NULL,
	[PACHIEVED] [int] NULL,
	[PERCENTAGE] [numeric](18, 2) NULL,
	[RTYPE] [tinyint] NULL,
	[CreateBy] [varchar](100) NULL,
	[CreatedOn] [datetime] NULL,
	[StatusId] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Rec_ProductionQT_Temp]    Script Date: 9/10/2020 2:37:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Rec_ProductionQT_Temp](
	[SESSIONID] [nvarchar](500) NULL,
	[TRAGETDATE] [datetime] NULL,
	[NTUSERNAME] [varchar](100) NULL,
	[PTARGET] [int] NULL,
	[PACHIEVED] [int] NULL,
	[PERCENTAGE] [numeric](18, 2) NULL,
	[RTYPE] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Proximity]    Script Date: 9/10/2020 2:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Proximity](
	[ProxyId] [int] IDENTITY(1,1) NOT NULL,
	[EmpCode] [varchar](10) NULL,
	[ProximityNo] [varchar](10) NULL,
	[Comments] [varchar](200) NULL,
	[CREATED_DT] [date] NULL,
	[CREATED_BY] [int] NULL,
	[InductionId] [int] NULL,
 CONSTRAINT [PK__ARC_REC___6AEBC03F668CB49C] PRIMARY KEY CLUSTERED 
(
	[ProxyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Proximity_Log]    Script Date: 9/10/2020 2:37:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Proximity_Log](
	[ProxyId] [int] NULL,
	[EmpCode] [varchar](10) NULL,
	[ProximityNo] [varchar](10) NULL,
	[Comments] [varchar](200) NULL,
	[CREATED_DT] [date] NULL,
	[CREATED_BY] [int] NULL,
	[InductionId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_QBANK]    Script Date: 9/10/2020 2:37:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_QBANK](
	[QTYPE] [varchar](1) NOT NULL,
	[PROCESS_ID] [int] NULL,
	[REL_EXP] [int] NULL,
	[GROUPNAME] [varchar](75) NULL,
	[IMAGENAME] [varchar](100) NULL,
	[QUESTION] [varchar](max) NULL,
	[OPTION_A] [varchar](250) NULL,
	[OPTION_B] [varchar](250) NULL,
	[OPTION_C] [varchar](250) NULL,
	[OPTION_D] [varchar](250) NULL,
	[RESULT] [varchar](1) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ACTIVE] [bit] NULL,
	[QID] [int] IDENTITY(1,1) NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL,
	[UpdatedComments] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[QID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Rec_RecruitForm]    Script Date: 9/10/2020 2:37:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Rec_RecruitForm](
	[FormId] [int] IDENTITY(1,1) NOT NULL,
	[FormName] [varchar](50) NULL,
	[FormShortName] [varchar](25) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[AccRole] [varchar](2) NULL,
	[ParentId] [int] NULL,
	[TabId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FormId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Rec_RecruitFormAccess]    Script Date: 9/10/2020 2:37:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Rec_RecruitFormAccess](
	[UserId] [int] NOT NULL,
	[FormId] [int] NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
 CONSTRAINT [PK__ARC_Rec___D8389731509D737D] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[FormId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RESIG_REASON_INFO]    Script Date: 9/10/2020 2:37:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RESIG_REASON_INFO](
	[REASON_ID] [int] IDENTITY(1,1) NOT NULL,
	[REASON] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[REASON_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RewardReportAccess]    Script Date: 9/10/2020 2:37:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RewardReportAccess](
	[Rid] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Active] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Role]    Script Date: 9/10/2020 2:37:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Status] [tinyint] NULL,
	[DefaultRole] [bit] NULL,
	[ModuleMenuId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleName] ASC,
	[FUNCTIONALITY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Role_20190211]    Script Date: 9/10/2020 2:37:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Role_20190211](
	[RoleId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Status] [tinyint] NULL,
	[DefaultRole] [bit] NULL,
	[ModuleMenuId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleName] ASC,
	[FUNCTIONALITY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Role_20200402]    Script Date: 9/10/2020 2:37:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Role_20200402](
	[RoleId] [int] NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Status] [tinyint] NULL,
	[DefaultRole] [bit] NULL,
	[ModuleMenuId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Role_bkup20190117]    Script Date: 9/10/2020 2:37:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Role_bkup20190117](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Status] [tinyint] NULL,
	[DefaultRole] [bit] NULL,
	[ModuleMenuId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Role_JAN]    Script Date: 9/10/2020 2:37:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Role_JAN](
	[RoleId] [int] NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Status] [tinyint] NULL,
	[DefaultRole] [bit] NULL,
	[ModuleMenuId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleAccess]    Script Date: 9/10/2020 2:37:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleAccess](
	[RoleAccessId] [int] IDENTITY(1,1) NOT NULL,
	[ModuleMenuId] [int] NULL,
	[UserId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleAccess_20200402]    Script Date: 9/10/2020 2:37:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleAccess_20200402](
	[RoleAccessId] [int] NOT NULL,
	[ModuleMenuId] [int] NULL,
	[UserId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleAccess_bkup20200117]    Script Date: 9/10/2020 2:37:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleAccess_bkup20200117](
	[RoleAccessId] [int] IDENTITY(1,1) NOT NULL,
	[ModuleMenuId] [int] NULL,
	[UserId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleAccess_JAN]    Script Date: 9/10/2020 2:37:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleAccess_JAN](
	[RoleAccessId] [int] NOT NULL,
	[ModuleMenuId] [int] NULL,
	[UserId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleAdmin]    Script Date: 9/10/2020 2:37:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleAdmin](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ARC_REC_RoleAdmin] PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleAdmin_bkup20200117]    Script Date: 9/10/2020 2:37:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleAdmin_bkup20200117](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleLog]    Script Date: 9/10/2020 2:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleLog](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[RoleName] [varchar](50) NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Status] [tinyint] NULL,
	[DefaultRole] [bit] NULL,
	[ModuleMenuId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleTran]    Script Date: 9/10/2020 2:37:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleTran](
	[RoleId] [int] NOT NULL,
	[MenuId] [int] NOT NULL,
	[RoleRead] [tinyint] NULL,
	[RoleWrite] [tinyint] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK__ARC_REC___966323396601D960] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleTran_20190211]    Script Date: 9/10/2020 2:37:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleTran_20190211](
	[RoleId] [int] NOT NULL,
	[MenuId] [int] NOT NULL,
	[RoleRead] [tinyint] NULL,
	[RoleWrite] [tinyint] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleTran_20200402]    Script Date: 9/10/2020 2:37:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleTran_20200402](
	[RoleId] [int] NOT NULL,
	[MenuId] [int] NOT NULL,
	[RoleRead] [tinyint] NULL,
	[RoleWrite] [tinyint] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleTran_bkup20200117]    Script Date: 9/10/2020 2:37:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleTran_bkup20200117](
	[RoleId] [int] NOT NULL,
	[MenuId] [int] NOT NULL,
	[RoleRead] [tinyint] NULL,
	[RoleWrite] [tinyint] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleTran_JAN]    Script Date: 9/10/2020 2:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleTran_JAN](
	[RoleId] [int] NOT NULL,
	[MenuId] [int] NOT NULL,
	[RoleRead] [tinyint] NULL,
	[RoleWrite] [tinyint] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_RoleTranLog]    Script Date: 9/10/2020 2:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_RoleTranLog](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[MenuId] [int] NULL,
	[RoleRead] [tinyint] NULL,
	[RoleWrite] [tinyint] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
 CONSTRAINT [PK__ARC_REC___FFEE743136139A73] PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SALARY_BREAKUP]    Script Date: 9/10/2020 2:37:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SALARY_BREAKUP](
	[REC_ID] [int] NULL,
	[M_BASIC] [decimal](10, 2) NULL,
	[M_HRA] [decimal](10, 2) NULL,
	[M_CA] [decimal](10, 2) NULL,
	[M_SDA] [decimal](10, 2) NULL,
	[M_SA] [decimal](10, 2) NULL,
	[M_GP] [decimal](10, 2) NULL,
	[M_PF] [decimal](10, 2) NULL,
	[M_GRATUITY] [decimal](10, 2) NULL,
	[M_BONUS] [decimal](10, 2) NULL,
	[M_BENEFITS] [decimal](10, 2) NULL,
	[Y_BASIC] [decimal](10, 2) NULL,
	[Y_HRA] [decimal](10, 2) NULL,
	[Y_CA] [decimal](10, 2) NULL,
	[Y_SDA] [decimal](10, 2) NULL,
	[Y_SA] [decimal](10, 2) NULL,
	[Y_GP] [decimal](10, 2) NULL,
	[Y_PF] [decimal](10, 2) NULL,
	[Y_GRATUITY] [decimal](10, 2) NULL,
	[Y_BONUS] [decimal](10, 2) NULL,
	[Y_BENEFITS] [decimal](10, 2) NULL,
	[CTC] [decimal](15, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[M_ESI] [decimal](9, 2) NULL,
	[Y_ESI] [decimal](9, 2) NULL,
	[OFFER_DESIGNATION] [varchar](200) NULL,
	[OFFER_ADDRESS] [varchar](max) NULL,
	[OTHER_ALLOWANCE] [int] NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
	[M_MRI] [decimal](10, 2) NULL,
	[Y_MRI] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SALARY_BREAKUP_LOG]    Script Date: 9/10/2020 2:37:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SALARY_BREAKUP_LOG](
	[REC_ID] [int] NULL,
	[M_BASIC] [decimal](10, 2) NULL,
	[M_HRA] [decimal](10, 2) NULL,
	[M_CA] [decimal](10, 2) NULL,
	[M_SDA] [decimal](10, 2) NULL,
	[M_SA] [decimal](10, 2) NULL,
	[M_GP] [decimal](10, 2) NULL,
	[M_PF] [decimal](10, 2) NULL,
	[M_GRATUITY] [decimal](10, 2) NULL,
	[M_BONUS] [decimal](10, 2) NULL,
	[M_BENEFITS] [decimal](10, 2) NULL,
	[Y_BASIC] [decimal](10, 2) NULL,
	[Y_HRA] [decimal](10, 2) NULL,
	[Y_CA] [decimal](10, 2) NULL,
	[Y_SDA] [decimal](10, 2) NULL,
	[Y_SA] [decimal](10, 2) NULL,
	[Y_GP] [decimal](10, 2) NULL,
	[Y_PF] [decimal](10, 2) NULL,
	[Y_GRATUITY] [decimal](10, 2) NULL,
	[Y_BONUS] [decimal](10, 2) NULL,
	[Y_BENEFITS] [decimal](10, 2) NULL,
	[CTC] [decimal](15, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[M_ESI] [decimal](9, 2) NULL,
	[Y_ESI] [decimal](9, 2) NULL,
	[OFFER_DESIGNATION] [varchar](200) NULL,
	[OFFER_ADDRESS] [varchar](max) NULL,
	[OTHER_ALLOWANCE] [int] NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
	[M_MRI] [decimal](10, 2) NULL,
	[Y_MRI] [decimal](10, 2) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SALARY_LD]    Script Date: 9/10/2020 2:37:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SALARY_LD](
	[SLIP_ID] [float] NULL,
	[EMPCODE] [nvarchar](255) NULL,
	[PF_NUMBER] [nvarchar](255) NULL,
	[ESI_NUMBER] [nvarchar](255) NULL,
	[BANK_NAME] [nvarchar](255) NULL,
	[BANKACC_NUMBER] [float] NULL,
	[BASICPAY] [float] NULL,
	[HRA] [float] NULL,
	[CA] [float] NULL,
	[SDA] [float] NULL,
	[SA] [float] NULL,
	[GROSS_PM] [float] NULL,
	[PF_EMPLOYEE_PM] [float] NULL,
	[ESI_EMPLOYEE_PM] [float] NULL,
	[PF_TAX] [float] NULL,
	[LOP] [float] NULL,
	[LWF] [float] NULL,
	[NS_A] [float] NULL,
	[REF_BONUS] [float] NULL,
	[MEDICAL_REIM_PM] [nvarchar](255) NULL,
	[JOINING_BONUS] [float] NULL,
	[INCENTIVE] [float] NULL,
	[EARNED_LEAVE] [float] NULL,
	[GROSS_PA] [float] NULL,
	[BONUS_PA] [float] NULL,
	[GRATUITY_PA] [float] NULL,
	[PF_EMPLOYER_PA] [float] NULL,
	[ESI_EMPLOYER_PA] [float] NULL,
	[MEDICAL_REIM_PA] [float] NULL,
	[CTC_PA] [float] NULL,
	[DAYS_PAID] [float] NULL,
	[LOP_DAYS] [float] NULL,
	[INS] [float] NULL,
	[CREATED_BY] [float] NULL,
	[CREATED_DT] [datetime] NULL,
	[INCOME_TAX] [float] NULL,
	[DOJ] [datetime] NULL,
	[Other Deductions] [float] NULL,
	[F39] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SALARY_SLIP]    Script Date: 9/10/2020 2:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SALARY_SLIP](
	[SLIP_ID] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](10) NULL,
	[PF_NUMBER] [varchar](200) NULL,
	[ESI_NUMBER] [varchar](200) NULL,
	[BANK_NAME] [varchar](500) NULL,
	[BANKACC_NUMBER] [nvarchar](250) NULL,
	[BASICPAY] [decimal](18, 2) NULL,
	[HRA] [decimal](18, 2) NULL,
	[CA] [decimal](18, 2) NULL,
	[SDA] [decimal](18, 2) NULL,
	[SA] [decimal](18, 2) NULL,
	[GROSS_PM] [decimal](18, 2) NULL,
	[PF_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[ESI_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[PF_TAX] [decimal](18, 2) NULL,
	[LOP] [decimal](18, 2) NULL,
	[LWF] [decimal](18, 2) NULL,
	[NS_A] [decimal](18, 2) NULL,
	[REF_BONUS] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PM] [decimal](18, 2) NULL,
	[JOINING_BONUS] [decimal](18, 2) NULL,
	[INCENTIVE] [decimal](18, 2) NULL,
	[EARNED_LEAVE] [decimal](18, 2) NULL,
	[GROSS_PA] [decimal](18, 2) NULL,
	[BONUS_PA] [decimal](18, 2) NULL,
	[GRATUITY_PA] [decimal](18, 2) NULL,
	[PF_EMPLOYER_PA] [decimal](18, 2) NULL,
	[ESI_EMPLOYER_PA] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PA] [decimal](18, 2) NULL,
	[CTC_PA] [decimal](18, 2) NULL,
	[DAYS_PAID] [numeric](6, 2) NULL,
	[LOP_DAYS] [numeric](6, 2) NULL,
	[INS] [decimal](18, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[INCOME_TAX] [decimal](18, 2) NULL,
	[DOJ] [datetime] NULL,
	[Other Deductions] [float] NULL,
	[UAN_NO] [varchar](50) NULL,
	[Userid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SLIP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SALARY_SLIP_LOG]    Script Date: 9/10/2020 2:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SALARY_SLIP_LOG](
	[SLIP_ID] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](10) NULL,
	[PF_NUMBER] [varchar](200) NULL,
	[ESI_NUMBER] [varchar](200) NULL,
	[BANK_NAME] [varchar](500) NULL,
	[BANKACC_NUMBER] [varchar](200) NULL,
	[BASICPAY] [decimal](18, 2) NULL,
	[HRA] [decimal](18, 2) NULL,
	[CA] [decimal](18, 2) NULL,
	[SDA] [decimal](18, 2) NULL,
	[SA] [decimal](18, 2) NULL,
	[GROSS_PM] [decimal](18, 2) NULL,
	[PF_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[ESI_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[PF_TAX] [decimal](18, 2) NULL,
	[LOP] [decimal](18, 2) NULL,
	[LWF] [decimal](18, 2) NULL,
	[NS_A] [decimal](18, 2) NULL,
	[REF_BONUS] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PM] [decimal](18, 2) NULL,
	[JOINING_BONUS] [decimal](18, 2) NULL,
	[INCENTIVE] [decimal](18, 2) NULL,
	[EARNED_LEAVE] [decimal](18, 2) NULL,
	[GROSS_PA] [decimal](18, 2) NULL,
	[BONUS_PA] [decimal](18, 2) NULL,
	[GRATUITY_PA] [decimal](18, 2) NULL,
	[PF_EMPLOYER_PA] [decimal](18, 2) NULL,
	[ESI_EMPLOYER_PA] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PA] [decimal](18, 2) NULL,
	[CTC_PA] [decimal](18, 2) NULL,
	[DAYS_PAID] [numeric](6, 2) NULL,
	[LOP_DAYS] [numeric](6, 2) NULL,
	[INS] [decimal](18, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[INCOME_TAX] [decimal](18, 2) NULL,
	[DOJ] [datetime] NULL,
	[Other Deductions] [float] NULL,
	[LOG_FROM] [varchar](2) NULL,
	[LOG_BATCH_ID] [int] NULL,
	[LOG_BATCH_DATE] [datetime] NULL,
	[Designation_Id] [int] NULL,
	[UAN_NO] [varchar](50) NULL,
	[Userid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SLIP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SALARY_SLIP_Temp]    Script Date: 9/10/2020 2:37:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SALARY_SLIP_Temp](
	[SLIP_ID] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](10) NULL,
	[PF_NUMBER] [varchar](200) NULL,
	[ESI_NUMBER] [varchar](200) NULL,
	[BANK_NAME] [varchar](500) NULL,
	[BANKACC_NUMBER] [varchar](200) NULL,
	[BASICPAY] [decimal](18, 2) NULL,
	[HRA] [decimal](18, 2) NULL,
	[CA] [decimal](18, 2) NULL,
	[SDA] [decimal](18, 2) NULL,
	[SA] [decimal](18, 2) NULL,
	[GROSS_PM] [decimal](18, 2) NULL,
	[PF_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[ESI_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[PF_TAX] [decimal](18, 2) NULL,
	[LOP] [decimal](18, 2) NULL,
	[LWF] [decimal](18, 2) NULL,
	[NS_A] [decimal](18, 2) NULL,
	[REF_BONUS] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PM] [decimal](18, 2) NULL,
	[JOINING_BONUS] [decimal](18, 2) NULL,
	[INCENTIVE] [decimal](18, 2) NULL,
	[EARNED_LEAVE] [decimal](18, 2) NULL,
	[GROSS_PA] [decimal](18, 2) NULL,
	[BONUS_PA] [decimal](18, 2) NULL,
	[GRATUITY_PA] [decimal](18, 2) NULL,
	[PF_EMPLOYER_PA] [decimal](18, 2) NULL,
	[ESI_EMPLOYER_PA] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PA] [decimal](18, 2) NULL,
	[CTC_PA] [decimal](18, 2) NULL,
	[DAYS_PAID] [numeric](6, 2) NULL,
	[LOP_DAYS] [numeric](6, 2) NULL,
	[INS] [decimal](18, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[INCOME_TAX] [decimal](18, 2) NULL,
	[DOJ] [datetime] NULL,
	[Other Deductions] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SALARY_SLIP_Temp1]    Script Date: 9/10/2020 2:37:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SALARY_SLIP_Temp1](
	[SLIP_ID] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](10) NULL,
	[PF_NUMBER] [varchar](200) NULL,
	[ESI_NUMBER] [varchar](200) NULL,
	[BANK_NAME] [varchar](500) NULL,
	[BANKACC_NUMBER] [varchar](200) NULL,
	[BASICPAY] [decimal](18, 2) NULL,
	[HRA] [decimal](18, 2) NULL,
	[CA] [decimal](18, 2) NULL,
	[SDA] [decimal](18, 2) NULL,
	[SA] [decimal](18, 2) NULL,
	[GROSS_PM] [decimal](18, 2) NULL,
	[PF_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[ESI_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[PF_TAX] [decimal](18, 2) NULL,
	[LOP] [decimal](18, 2) NULL,
	[LWF] [decimal](18, 2) NULL,
	[NS_A] [decimal](18, 2) NULL,
	[REF_BONUS] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PM] [decimal](18, 2) NULL,
	[JOINING_BONUS] [decimal](18, 2) NULL,
	[INCENTIVE] [decimal](18, 2) NULL,
	[EARNED_LEAVE] [decimal](18, 2) NULL,
	[GROSS_PA] [decimal](18, 2) NULL,
	[BONUS_PA] [decimal](18, 2) NULL,
	[GRATUITY_PA] [decimal](18, 2) NULL,
	[PF_EMPLOYER_PA] [decimal](18, 2) NULL,
	[ESI_EMPLOYER_PA] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PA] [decimal](18, 2) NULL,
	[CTC_PA] [decimal](18, 2) NULL,
	[DAYS_PAID] [numeric](6, 2) NULL,
	[LOP_DAYS] [numeric](6, 2) NULL,
	[INS] [decimal](18, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[INCOME_TAX] [decimal](18, 2) NULL,
	[DOJ] [datetime] NULL,
	[Other Deductions] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SALARY_SLIP_TRAN]    Script Date: 9/10/2020 2:37:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SALARY_SLIP_TRAN](
	[SLIP_ID] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](10) NULL,
	[PF_NUMBER] [varchar](200) NULL,
	[ESI_NUMBER] [varchar](200) NULL,
	[BANK_NAME] [varchar](500) NULL,
	[BANKACC_NUMBER] [varchar](200) NULL,
	[BASICPAY] [decimal](18, 2) NULL,
	[HRA] [decimal](18, 2) NULL,
	[CA] [decimal](18, 2) NULL,
	[SDA] [decimal](18, 2) NULL,
	[SA] [decimal](18, 2) NULL,
	[GROSS_PM] [decimal](18, 2) NULL,
	[PF_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[ESI_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[PF_TAX] [decimal](18, 2) NULL,
	[LOP] [decimal](18, 2) NULL,
	[LWF] [decimal](18, 2) NULL,
	[NS_A] [decimal](18, 2) NULL,
	[REF_BONUS] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PM] [decimal](18, 2) NULL,
	[JOINING_BONUS] [decimal](18, 2) NULL,
	[INCENTIVE] [decimal](18, 2) NULL,
	[EARNED_LEAVE] [decimal](18, 2) NULL,
	[GROSS_PA] [decimal](18, 2) NULL,
	[BONUS_PA] [decimal](18, 2) NULL,
	[GRATUITY_PA] [decimal](18, 2) NULL,
	[PF_EMPLOYER_PA] [decimal](18, 2) NULL,
	[ESI_EMPLOYER_PA] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PA] [decimal](18, 2) NULL,
	[CTC_PA] [decimal](18, 2) NULL,
	[DAYS_PAID] [numeric](6, 2) NULL,
	[LOP_DAYS] [numeric](6, 2) NULL,
	[INS] [decimal](18, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[INCOME_TAX] [decimal](18, 2) NULL,
	[DOJ] [datetime] NULL,
	[Other Deductions] [decimal](18, 2) NULL,
	[Designation_Id] [int] NULL,
	[UAN_NO] [varchar](50) NULL,
	[Userid] [int] NULL,
	[Uploaded_dt] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[SLIP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SELF_ATTENDANCE]    Script Date: 9/10/2020 2:37:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SELF_ATTENDANCE](
	[AID] [int] IDENTITY(1,1) NOT NULL,
	[USERID] [int] NULL,
	[ATTENDANCE_DATE] [date] NULL,
	[ATT_TYPE] [varchar](2) NULL,
	[WORKED_HRS] [numeric](8, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[LOGIN_TIME] [datetime] NULL,
	[LOGOUT_TIME] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SELF_ATTENDANCE_LOG]    Script Date: 9/10/2020 2:37:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SELF_ATTENDANCE_LOG](
	[USERID] [int] NULL,
	[ATTENDANCE_DATE] [date] NULL,
	[ATT_TYPE] [varchar](2) NULL,
	[WORKED_HRS] [numeric](8, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
	[LOGIN_TIME] [datetime] NULL,
	[LOGOUT_TIME] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ROW_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SHIFT_INFO]    Script Date: 9/10/2020 2:37:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SHIFT_INFO](
	[SHIFT_ID] [int] IDENTITY(1,1) NOT NULL,
	[SHIFT_NAME] [varchar](30) NULL,
	[SHIFT_FROM] [time](7) NULL,
	[SHIFT_TO] [time](7) NULL,
	[HOLIDAY_LISTTYPE] [int] NULL,
	[HOLIDAY_SAT] [varchar](1) NULL,
	[WORK_HRS] [decimal](9, 2) NULL,
	[SatOffEligible] [varchar](1) NULL,
	[NightShiftAllowance] [varchar](1) NULL,
	[WorkMinutes] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SHIFT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SHIFT_INFO_LOG]    Script Date: 9/10/2020 2:37:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SHIFT_INFO_LOG](
	[SHIFT_ID] [int] NOT NULL,
	[SHIFT_NAME] [varchar](30) NULL,
	[SHIFT_FROM] [time](7) NULL,
	[SHIFT_TO] [time](7) NULL,
	[HOLIDAY_LISTTYPE] [int] NULL,
	[HOLIDAY_SAT] [varchar](1) NULL,
	[WORK_HRS] [decimal](9, 2) NULL,
	[SatOffEligible] [varchar](1) NULL,
	[NightShiftAllowance] [varchar](1) NULL,
	[WorkMinutes] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SHIFT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SHIFT_TRAN]    Script Date: 9/10/2020 2:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SHIFT_TRAN](
	[USERID] [int] NULL,
	[SHIFT_ID] [int] NULL,
	[Effect_DATE] [date] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[TID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SOFTCONTROL]    Script Date: 9/10/2020 2:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SOFTCONTROL](
	[CTL_ID] [varchar](100) NOT NULL,
	[CTL_TEXT] [varchar](1000) NULL,
	[CTL_TYPE] [varchar](20) NULL,
	[CTL_VALUE] [varchar](1000) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CTL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_StaffingReport_MasterData]    Script Date: 9/10/2020 2:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_StaffingReport_MasterData](
	[Userid] [int] NULL,
	[NT_Username] [varchar](100) NULL,
	[Name] [varchar](500) NULL,
	[Empcode] [varchar](100) NULL,
	[Location] [varchar](100) NULL,
	[DOJ] [varchar](100) NULL,
	[Supervisor] [varchar](200) NULL,
	[Client] [varchar](100) NULL,
	[Process] [varchar](200) NULL,
	[LOB] [varchar](100) NULL,
	[Designation] [varchar](200) NULL,
	[Actual Designation] [varchar](200) NULL,
	[HeadCount] [int] NULL,
	[Gender] [varchar](200) NULL,
	[Shift] [varchar](200) NULL,
	[Facility] [varchar](200) NULL,
	[CriticalResource] [varchar](100) NULL,
	[Band] [int] NULL,
	[Grade] [varchar](100) NULL,
	[BU_Head] [varchar](200) NULL,
	[Arms_Functionality] [varchar](500) NULL,
	[FunctionalityGroupName] [varchar](500) NULL,
	[GroupName] [varchar](200) NULL,
	[SubGroupName] [varchar](200) NULL,
	[SubFunctionality] [varchar](200) NULL,
	[Costcode] [varchar](200) NULL,
	[Project] [varchar](200) NULL,
	[Level_1] [varchar](100) NULL,
	[Level_2] [varchar](100) NULL,
	[Level_3] [varchar](100) NULL,
	[Level_4] [varchar](100) NULL,
	[Level_5] [varchar](100) NULL,
	[Level_6] [varchar](100) NULL,
	[Level_7] [varchar](100) NULL,
	[Level_8] [varchar](100) NULL,
	[Level_9] [varchar](100) NULL,
	[Level_10] [varchar](100) NULL,
	[Level_11] [varchar](100) NULL,
	[Level_12] [varchar](100) NULL,
	[WFH] [varchar](100) NULL,
	[ShiftType] [varchar](100) NULL,
	[Essential_Name] [varchar](200) NULL,
	[AssetId] [varchar](100) NULL,
	[AssetStatus] [varchar](100) NULL,
	[BackToOfficeDate1] [date] NULL,
	[District] [varchar](300) NULL,
	[ZoneName] [varchar](300) NULL,
	[Area] [varchar](300) NULL,
	[EmpAddLocation] [varchar](300) NULL,
	[Street] [varchar](300) NULL,
	[OtherStreet] [varchar](300) NULL,
	[ContainmentZone] [varchar](300) NULL,
	[WorkFromHomePickUpAddress] [varchar](500) NULL,
	[BackToOfficeDate] [varchar](100) NULL,
	[ContainmentZone_GeoBased] [varchar](100) NULL,
	[Created_Dt] [datetime] NOT NULL,
	[Staffing_ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ARC_REC_StaffingReport_MasterData] PRIMARY KEY CLUSTERED 
(
	[Staffing_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_STATE_INFO]    Script Date: 9/10/2020 2:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_STATE_INFO](
	[STATE_ID] [int] IDENTITY(1,1) NOT NULL,
	[STATE_NAME] [varchar](50) NOT NULL,
	[ACTIVE] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[STATE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_SUBPROCESS_INFO]    Script Date: 9/10/2020 2:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_SUBPROCESS_INFO](
	[SUBPROCESS_ID] [int] IDENTITY(1,1) NOT NULL,
	[SUBPROCESS_NAME] [varchar](30) NULL,
	[PROCESS_ID] [int] NULL,
	[ACTIVE] [bit] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_Superviosrlog]    Script Date: 9/10/2020 2:37:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_Superviosrlog](
	[SLid] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[SupervisorId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDt] [datetime] NULL,
	[OldReportingTo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SLid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TAX_TDS]    Script Date: 9/10/2020 2:37:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TAX_TDS](
	[TDS_ID] [int] IDENTITY(1,1) NOT NULL,
	[USERID] [int] NULL,
	[PANNO] [varchar](20) NULL,
	[FD] [decimal](10, 2) NULL,
	[HL_INTEREST] [decimal](10, 2) NULL,
	[HL_PRINCIPAL] [decimal](10, 2) NULL,
	[MUTUALFUND] [decimal](10, 2) NULL,
	[PUBLIC_PF] [decimal](10, 2) NULL,
	[NSC_BOND] [decimal](10, 2) NULL,
	[LI_PREMIUM] [decimal](10, 2) NULL,
	[MI_PREMIUM_SELF] [decimal](10, 2) NULL,
	[MI_PREMIUM_PARENT] [decimal](10, 2) NULL,
	[PHYSICALLY_CHALANGED_INCOME] [decimal](10, 2) NULL,
	[POSTOFFICE_SAVING] [decimal](10, 2) NULL,
	[RENT] [decimal](10, 2) NULL,
	[TUITION_FEES] [decimal](10, 2) NULL,
	[DONATION] [decimal](10, 2) NULL,
	[EDUCATION_LOAN] [decimal](10, 2) NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
	[HOUSEPROPERTY_INCOME] [decimal](18, 2) NULL,
	[OTHERSOURCES_INCOME] [decimal](18, 2) NULL,
 CONSTRAINT [PK__ARC_REC___5D4C3E8C21ECA635] PRIMARY KEY CLUSTERED 
(
	[TDS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TAX_TDS_HISTORY]    Script Date: 9/10/2020 2:37:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TAX_TDS_HISTORY](
	[TDS_HID] [int] IDENTITY(1,1) NOT NULL,
	[TDS_ID] [int] NULL,
	[USERID] [int] NULL,
	[PANNO] [varchar](20) NULL,
	[FD] [decimal](10, 2) NULL,
	[HL_INTEREST] [decimal](10, 2) NULL,
	[HL_PRINCIPAL] [decimal](10, 2) NULL,
	[MUTUALFUND] [decimal](10, 2) NULL,
	[PUBLIC_PF] [decimal](10, 2) NULL,
	[NSC_BOND] [decimal](10, 2) NULL,
	[LI_PREMIUM] [decimal](10, 2) NULL,
	[MI_PREMIUM_SELF] [decimal](10, 2) NULL,
	[MI_PREMIUM_PARENT] [decimal](10, 2) NULL,
	[PHYSICALLY_CHALANGED_INCOME] [decimal](10, 2) NULL,
	[POSTOFFICE_SAVING] [decimal](10, 2) NULL,
	[RENT] [decimal](10, 2) NULL,
	[TUITION_FEES] [decimal](10, 2) NULL,
	[DONATION] [decimal](10, 2) NULL,
	[EDUCATION_LOAN] [decimal](10, 2) NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
	[HOUSEPROPERTY_INCOME] [decimal](18, 2) NULL,
	[OTHERSOURCES_INCOME] [decimal](18, 2) NULL,
 CONSTRAINT [PK__ARC_REC___7FDD143B25BD3719] PRIMARY KEY CLUSTERED 
(
	[TDS_HID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TDS_UPLOAD]    Script Date: 9/10/2020 2:37:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TDS_UPLOAD](
	[Emp ID] [nvarchar](255) NULL,
	[Emp Name] [nvarchar](255) NULL,
	[Basic + DA] [float] NULL,
	[HRA] [float] NULL,
	[Conveyance] [float] NULL,
	[SDA] [float] NULL,
	[Spl Allow] [float] NULL,
	[Bonus] [float] NULL,
	[Earned Leave] [float] NULL,
	[Raw] [float] NULL,
	[NSA] [float] NULL,
	[Others] [float] NULL,
	[Medical Reim] [float] NULL,
	[Total Annual Salary] [float] NULL,
	[HRA Exemption] [float] NULL,
	[Conveyance1] [float] NULL,
	[Medical Reim1] [float] NULL,
	[Professional Tax] [float] NULL,
	[Total] [float] NULL,
	[Taxable Salary] [float] NULL,
	[Rental Income] [float] NULL,
	[Loss On self Occupied property -Interest] [float] NULL,
	[Capital Gains] [float] NULL,
	[Other income] [float] NULL,
	[Income  other than salary] [float] NULL,
	[Gross Total Income] [float] NULL,
	[Medical Ins# Premium - 80 D] [float] NULL,
	[Medical Ins# Premium - 80 D Parents] [float] NULL,
	[Education Loan - 80 E] [float] NULL,
	[Medical Exp - Handicapped Dep# - 80 DD] [float] NULL,
	[Permanent Disability 80 U] [float] NULL,
	[Deduction U/s 80C] [float] NULL,
	[Others If any] [nvarchar](255) NULL,
	[Total1] [float] NULL,
	[Taxable Income] [float] NULL,
	[Tax Payable] [float] NULL,
	[Tax deducted in till date] [float] NULL,
	[Balance deductible] [float] NULL,
	[FileName] [nvarchar](34) NULL,
	[Upload_Date] [datetime] NULL,
	[UserId] [int] NULL,
	[Incentive] [float] NULL,
	[Pan Number] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TDS_UPLOAD_LOG ]    Script Date: 9/10/2020 2:37:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TDS_UPLOAD_LOG ](
	[Emp ID] [nvarchar](255) NULL,
	[Emp Name] [nvarchar](255) NULL,
	[Basic + DA] [float] NULL,
	[HRA] [float] NULL,
	[Conveyance] [float] NULL,
	[SDA] [float] NULL,
	[Spl Allow] [float] NULL,
	[Bonus] [float] NULL,
	[Earned Leave] [float] NULL,
	[Raw] [float] NULL,
	[NSA] [float] NULL,
	[Others] [float] NULL,
	[Medical Reim] [float] NULL,
	[Total Annual Salary] [float] NULL,
	[HRA Exemption] [float] NULL,
	[Conveyance1] [float] NULL,
	[Medical Reim1] [float] NULL,
	[Professional Tax] [float] NULL,
	[Total] [float] NULL,
	[Taxable Salary] [float] NULL,
	[Rental Income] [float] NULL,
	[Loss On self Occupied property -Interest] [float] NULL,
	[Capital Gains] [float] NULL,
	[Other income] [float] NULL,
	[Income  other than salary] [float] NULL,
	[Gross Total Income] [float] NULL,
	[Medical Ins# Premium - 80 D] [float] NULL,
	[Medical Ins# Premium - 80 D Parents] [float] NULL,
	[Education Loan - 80 E] [float] NULL,
	[Medical Exp - Handicapped Dep# - 80 DD] [float] NULL,
	[Permanent Disability 80 U] [float] NULL,
	[Deduction U/s 80C] [float] NULL,
	[Others If any] [nvarchar](255) NULL,
	[Total1] [float] NULL,
	[Taxable Income] [float] NULL,
	[Tax Payable] [float] NULL,
	[Tax deducted in till date] [float] NULL,
	[Balance deductible] [float] NULL,
	[Upload_Date] [datetime] NULL,
	[UserId] [int] NULL,
	[Incentive] [float] NULL,
	[LOG_FROM] [nvarchar](255) NULL,
	[LOG_BATCH_ID] [int] NULL,
	[LOG_BATCH_DATE] [datetime] NULL,
	[Designation_Id] [int] NULL,
	[Pan Number] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TDS_UPLOAD_TRAN]    Script Date: 9/10/2020 2:37:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TDS_UPLOAD_TRAN](
	[Emp ID] [nvarchar](255) NULL,
	[Emp Name] [nvarchar](255) NULL,
	[Basic + DA] [float] NULL,
	[HRA] [float] NULL,
	[Conveyance] [float] NULL,
	[SDA] [float] NULL,
	[Spl Allow] [float] NULL,
	[Bonus] [float] NULL,
	[Earned Leave] [float] NULL,
	[Raw] [float] NULL,
	[NSA] [float] NULL,
	[Others] [float] NULL,
	[Medical Reim] [float] NULL,
	[Total Annual Salary] [float] NULL,
	[HRA Exemption] [float] NULL,
	[Conveyance1] [float] NULL,
	[Medical Reim1] [float] NULL,
	[Professional Tax] [float] NULL,
	[Total] [float] NULL,
	[Taxable Salary] [float] NULL,
	[Rental Income] [float] NULL,
	[Loss On self Occupied property -Interest] [float] NULL,
	[Capital Gains] [float] NULL,
	[Other income] [float] NULL,
	[Income  other than salary] [float] NULL,
	[Gross Total Income] [float] NULL,
	[Medical Ins# Premium - 80 D] [float] NULL,
	[Medical Ins# Premium - 80 D Parents] [float] NULL,
	[Education Loan - 80 E] [float] NULL,
	[Medical Exp - Handicapped Dep# - 80 DD] [float] NULL,
	[Permanent Disability 80 U] [float] NULL,
	[Deduction U/s 80C] [float] NULL,
	[Others If any] [nvarchar](255) NULL,
	[Total1] [float] NULL,
	[Taxable Income] [float] NULL,
	[Tax Payable] [float] NULL,
	[Tax deducted in till date] [float] NULL,
	[Balance deductible] [float] NULL,
	[Upload_Date] [datetime] NULL,
	[UserId] [int] NULL,
	[Incentive] [float] NULL,
	[Designation_Id] [int] NULL,
	[Pan Number] [nvarchar](255) NULL,
	[Start_Date] [date] NULL,
	[End_Date] [date] NULL,
	[Uploaded_dt] [date] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PKM_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TEST]    Script Date: 9/10/2020 2:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TEST](
	[REC_ID] [int] NULL,
	[TEST_ID] [int] IDENTITY(1,1) NOT NULL,
	[TEST_TYPE] [varchar](1) NULL,
	[CREATED_DT] [datetime] NULL,
	[RESULT] [bit] NULL,
	[SCORE] [int] NULL,
	[HAS_COMPLETED] [int] NULL,
	[COMMENTS] [varchar](8000) NULL,
PRIMARY KEY CLUSTERED 
(
	[TEST_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TEST_TRAN]    Script Date: 9/10/2020 2:37:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TEST_TRAN](
	[TEST_ID] [int] NOT NULL,
	[QID] [int] NOT NULL,
	[RESULT] [varchar](1) NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TEST_ID] ASC,
	[QID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TmpUserIdChanges]    Script Date: 9/10/2020 2:37:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TmpUserIdChanges](
	[OldUserId] [int] NULL,
	[NewUserId] [int] NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
	[Nt_UserName] [varchar](75) NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TmpUserIdChangesInfo]    Script Date: 9/10/2020 2:37:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TmpUserIdChangesInfo](
	[USERID] [int] IDENTITY(1,1) NOT NULL,
	[FIRSTNAME] [varchar](50) NULL,
	[LASTNAME] [varchar](50) NULL,
	[NT_USERNAME] [varchar](75) NOT NULL,
	[DESIGNATION_ID] [int] NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[REC_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[REPORTING_TO] [varchar](75) NULL,
	[EMPCODE] [varchar](10) NULL,
	[ACTIVE] [int] NULL,
	[CLIENT_ID] [int] NULL,
	[DOJ] [date] NULL,
	[AHS_PRL] [varchar](1) NULL,
	[PreDoj] [date] NULL,
	[LastCustomerId] [int] NULL,
	[Password] [varchar](15) NULL,
	[EmailId] [varchar](75) NULL,
	[AccountType] [varchar](1) NULL,
	[ExtUser] [varchar](1) NULL,
	[UserName] [varchar](100) NULL,
	[FirstTrnDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TraineeAttendanceLog]    Script Date: 9/10/2020 2:37:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TraineeAttendanceLog](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[Aid] [int] NOT NULL,
	[Userid] [int] NULL,
	[NT_UserName] [varchar](100) NULL,
	[Date] [date] NULL,
	[Shiftid] [tinyint] NULL,
	[LogOn] [datetime] NULL,
	[LogOut] [datetime] NULL,
	[TotalHrs] [numeric](18, 2) NULL,
	[WorkHours] [numeric](18, 2) NULL,
	[LockHrs] [numeric](18, 2) NULL,
	[LateIn] [numeric](18, 2) NULL,
	[LateOut] [numeric](18, 2) NULL,
	[Designid] [int] NULL,
	[Functionalityid] [int] NULL,
	[CreatedBy] [int] NULL,
	[Createdon] [datetime] NULL,
	[Shift_from] [time](7) NULL,
	[Shift_to] [time](7) NULL,
	[Verified_Present] [char](2) NULL,
	[Verified_By] [int] NULL,
	[Verified_Comments] [varchar](max) NULL,
	[Client_id] [int] NULL,
	[ActLogin] [datetime] NULL,
	[ActLogout] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TrainingBatchAllocation]    Script Date: 9/10/2020 2:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TrainingBatchAllocation](
	[AllocationId] [int] IDENTITY(1,1) NOT NULL,
	[BatchId] [int] NULL,
	[UserId] [int] NULL,
	[TrainingCompleted] [char](1) NULL,
	[TrainingCancelled] [char](1) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[TrainingCompletedBy] [int] NULL,
	[TrainingCompletedDt] [datetime] NULL,
	[TrainingCancelledBy] [int] NULL,
	[TrainingCancelledDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TrainingBatchMaster]    Script Date: 9/10/2020 2:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TrainingBatchMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BatchName] [varchar](200) NULL,
	[BatchTypeId] [int] NULL,
	[FacilityId] [int] NULL,
	[TrainingRoomId] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[TrainerId] [int] NULL,
	[ShiftId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[Active] [char](1) NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TrainingBatchType]    Script Date: 9/10/2020 2:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TrainingBatchType](
	[BatchTypeId] [int] IDENTITY(1,1) NOT NULL,
	[BatchType] [varchar](100) NULL,
	[NoofTrainingDays] [int] NULL,
	[Active] [char](1) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ProcessCategoryId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TrainingDeactivatelog]    Script Date: 9/10/2020 2:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TrainingDeactivatelog](
	[REC_ID] [int] NULL,
	[USERID] [int] NULL,
	[MPR_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TrainingProcessCategory]    Script Date: 9/10/2020 2:37:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TrainingProcessCategory](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](2000) NULL,
	[Active] [char](1) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TrainingRoomMaster]    Script Date: 9/10/2020 2:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TrainingRoomMaster](
	[TRId] [int] IDENTITY(1,1) NOT NULL,
	[FacilityId] [int] NULL,
	[Name] [varchar](100) NULL,
	[Capacity] [int] NULL,
	[Active] [char](1) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TRANSPORT]    Script Date: 9/10/2020 2:37:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TRANSPORT](
	[TRANID] [int] IDENTITY(1,1) NOT NULL,
	[USERID] [int] NULL,
	[PICKUP_POINT] [varchar](100) NULL,
	[DROP_POINT] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[TRANID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TYPING_CONTENT]    Script Date: 9/10/2020 2:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TYPING_CONTENT](
	[CONTENT] [varchar](4000) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[CONTENT_ID] [int] IDENTITY(1,1) NOT NULL,
	[Active] [varchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[CONTENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_TYPING_TEST]    Script Date: 9/10/2020 2:37:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_TYPING_TEST](
	[REC_ID] [int] NULL,
	[GROSS_WPM] [int] NULL,
	[NET_WPM] [int] NULL,
	[ACCURACY] [decimal](5, 2) NULL,
	[CREATED_DT] [datetime] NULL,
	[TEST_ID] [int] IDENTITY(1,1) NOT NULL,
	[HAS_COMPLETED] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TEST_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_USER_INFO]    Script Date: 9/10/2020 2:37:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_USER_INFO](
	[USERID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FIRSTNAME] [varchar](50) NULL,
	[LASTNAME] [varchar](50) NULL,
	[NT_USERNAME] [varchar](75) NOT NULL,
	[DESIGNATION_ID] [int] NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[REC_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[REPORTING_TO] [varchar](75) NULL,
	[EMPCODE] [varchar](10) NULL,
	[ACTIVE] [int] NULL,
	[CLIENT_ID] [int] NULL,
	[DOJ] [date] NULL,
	[AHS_PRL] [varchar](1) NULL,
	[PreDoj] [date] NULL,
	[LastCustomerId] [int] NULL,
	[EmailId] [varchar](75) NULL,
	[AccountType] [varchar](1) NULL,
	[ExtUser] [varchar](1) NULL,
	[UserName] [varchar](100) NULL,
	[FirstTrnDt] [datetime] NULL,
	[MIDDLENAME] [varchar](50) NULL,
	[OldEmpCode] [varchar](10) NULL,
	[LocationID] [int] NOT NULL,
	[TriModifyon] [datetime] NULL,
	[HolidayTypeID] [int] NULL,
	[Lock] [int] NULL,
	[Password] [varbinary](max) NULL,
	[LOB] [int] NULL,
	[IsCritical] [int] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[MGRID] [int] NULL,
	[SubFunctionalityId] [int] NULL,
	[GroupId] [int] NULL,
	[SubGroupId] [int] NULL,
	[CostcodeId] [int] NULL,
	[ProjectID] [int] NULL,
	[VendorUserId] [int] NULL,
	[Essential_ID] [int] NOT NULL,
 CONSTRAINT [PK__ARC_REC___7B9E7F35473E2675] PRIMARY KEY CLUSTERED 
(
	[USERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__ARC_REC___C9A5552D25E7544B] UNIQUE NONCLUSTERED 
(
	[USERID] ASC,
	[REC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_USER_INFO_lOG]    Script Date: 9/10/2020 2:37:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_USER_INFO_lOG](
	[USERID] [int] NULL,
	[FIRSTNAME] [varchar](50) NULL,
	[LASTNAME] [varchar](50) NULL,
	[NT_USERNAME] [varchar](75) NULL,
	[DESIGNATION_ID] [int] NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[REC_ID] [int] NULL,
	[ACTIVE] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[REPORTING_TO] [varchar](75) NULL,
	[EMPCODE] [varchar](10) NULL,
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
	[CLIENT_ID] [int] NULL,
	[DOJ] [date] NULL,
	[PreDoj] [date] NULL,
	[LastCustomerId] [int] NULL,
	[Password] [varchar](15) NULL,
	[EmailId] [varchar](75) NULL,
	[AccountType] [varchar](1) NULL,
	[ExtUser] [varchar](1) NULL,
	[UserName] [varchar](100) NULL,
	[FirstTrnDt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ROW_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserAuthentication]    Script Date: 9/10/2020 2:37:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserAuthentication](
	[RowId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserId] [int] NOT NULL,
	[Domain] [varchar](75) NOT NULL,
	[UserIdentity] [varchar](75) NOT NULL,
	[NT_Username] [varchar](75) NOT NULL,
	[ARC_EmailAddress] [varchar](100) NULL,
 CONSTRAINT [PK__ARC_REC___1788CC4C353FFA9C] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__ARC_REC___D98B6D283AF8D3F2] UNIQUE NONCLUSTERED 
(
	[Domain] ASC,
	[UserIdentity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__ARC_REC___E687555F381C6747] UNIQUE NONCLUSTERED 
(
	[NT_Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserCustomer]    Script Date: 9/10/2020 2:37:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserCustomer](
	[UCid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CustomerID] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[PrimaryCust] [bit] NULL,
	[OldCustomerId] [int] NULL,
	[TriModifyon] [datetime] NULL,
	[rowguid] [varchar](250) NULL,
 CONSTRAINT [PK__ARC_REC___8DC22A07613D2443] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserCustomer_20190731]    Script Date: 9/10/2020 2:37:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserCustomer_20190731](
	[UCid] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[PrimaryCust] [bit] NULL,
	[OldCustomerId] [int] NULL,
	[TriModifyon] [datetime] NULL,
	[rowguid] [varchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserCustomer_backup]    Script Date: 9/10/2020 2:37:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserCustomer_backup](
	[UCid] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[PrimaryCust] [bit] NULL,
	[OldCustomerId] [int] NULL,
	[TriModifyon] [datetime] NULL,
	[rowguid] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserCustomerLog]    Script Date: 9/10/2020 2:37:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserCustomerLog](
	[UCid] [int] NULL,
	[CustomerID] [int] NULL,
	[UserId] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[PrimaryCust] [bit] NULL,
	[LogGroupId] [int] NULL,
	[Active] [int] NULL,
	[EffectiveTo] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserLastCustomer]    Script Date: 9/10/2020 2:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserLastCustomer](
	[CustomerId] [int] NULL,
	[UserId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserRole]    Script Date: 9/10/2020 2:37:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserRole](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
	[AccessLevel] [varchar](1) NULL,
 CONSTRAINT [PK__ARC_REC___5B8242DE4D4A6ED8] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC,
	[FUNCTIONALITY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserRole_20190211]    Script Date: 9/10/2020 2:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserRole_20190211](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AccessLevel] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserRole_20200402]    Script Date: 9/10/2020 2:37:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserRole_20200402](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[Rwid] [bigint] NOT NULL,
	[AccessLevel] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserRole_Bkup20200117]    Script Date: 9/10/2020 2:37:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserRole_Bkup20200117](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
	[AccessLevel] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserRole_JAN]    Script Date: 9/10/2020 2:37:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserRole_JAN](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[Rwid] [bigint] NOT NULL,
	[AccessLevel] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_UserRoleLog]    Script Date: 9/10/2020 2:37:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_UserRoleLog](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[AccessLevel] [varchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_WalkinSource]    Script Date: 9/10/2020 2:37:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_WalkinSource](
	[SourceId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](100) NULL,
	[Active] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[arc_rec_walkinsource_log]    Script Date: 9/10/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[arc_rec_walkinsource_log](
	[REC_ID] [int] NOT NULL,
	[PROCESS_ID] [int] NOT NULL,
	[FIRSTNAME] [varchar](50) NOT NULL,
	[LASTNAME] [varchar](50) NOT NULL,
	[DOB] [date] NOT NULL,
	[MARITAL_STATUS] [varchar](1) NOT NULL,
	[FATHER_NAME] [varchar](50) NOT NULL,
	[SPOUSE_NAME] [varchar](50) NOT NULL,
	[PER_ADDRESS1] [varchar](50) NOT NULL,
	[PER_ADDRESS2] [varchar](50) NOT NULL,
	[PER_LOCATION] [varchar](30) NOT NULL,
	[PER_STATE_ID] [int] NOT NULL,
	[PER_CITY] [varchar](30) NOT NULL,
	[PER_PINCODE] [varchar](6) NOT NULL,
	[PRE_ADDRESS1] [varchar](50) NOT NULL,
	[PRE_ADDRESS2] [varchar](50) NOT NULL,
	[PRE_LOCATION] [varchar](30) NOT NULL,
	[PRE_STATE_ID] [int] NOT NULL,
	[PRE_CITY] [varchar](30) NOT NULL,
	[PRE_PINCODE] [varchar](6) NOT NULL,
	[TELEPHONE_NO] [varchar](15) NOT NULL,
	[MOBILE_NO] [varchar](10) NOT NULL,
	[EMAIL_ID] [varchar](50) NOT NULL,
	[REL_EXP] [int] NOT NULL,
	[CTC] [decimal](10, 2) NOT NULL,
	[E_CTC] [decimal](10, 2) NOT NULL,
	[SHIFTS] [varchar](1) NULL,
	[KNOW_ABOUT_US] [varchar](2) NULL,
	[EMPLOYEE_ID] [varchar](12) NOT NULL,
	[EMER_CONTACT_NAME] [varchar](30) NULL,
	[EMER_CONTACT_NO] [varchar](10) NULL,
	[BLOODGROUP] [varchar](4) NOT NULL,
	[JOIN_DAYS] [int] NOT NULL,
	[PRE_APPLIED] [varchar](1) NULL,
	[CREATED_DT] [datetime] NULL,
	[FBLIKE] [int] NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[GENDER] [char](1) NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ResumeFilesDtls]    Script Date: 9/10/2020 2:37:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ResumeFilesDtls](
	[FILEID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](100) NULL,
	[FilePath] [varchar](150) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[FILEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SECURITY_ACTION_ITEMS]    Script Date: 9/10/2020 2:37:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SECURITY_ACTION_ITEMS](
	[AID] [int] IDENTITY(1,1) NOT NULL,
	[QID] [int] NULL,
	[ACTIONITEM] [varchar](max) NULL,
	[ROOTCAUSE] [varchar](max) NULL,
	[STATUS] [bit] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SECURITY_INCIDENT_DETAILS]    Script Date: 9/10/2020 2:37:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SECURITY_INCIDENT_DETAILS](
	[QID] [int] IDENTITY(1,1) NOT NULL,
	[QDESCRIPTION] [varchar](800) NULL,
	[INSDATE] [datetime] NULL,
	[INSTIME] [varchar](6) NULL,
	[FACILITY] [int] NULL,
	[LOCATION] [varchar](100) NULL,
	[QSTATUS] [int] NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
	[UPDATEDBY] [int] NULL,
	[UPDATEDDT] [datetime] NULL,
 CONSTRAINT [PK_ARC_SECURITY_INCIDENT_DETAILS] PRIMARY KEY CLUSTERED 
(
	[QID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SECURITY_INCIDENTMASTER]    Script Date: 9/10/2020 2:37:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SECURITY_INCIDENTMASTER](
	[SID] [int] IDENTITY(1,1) NOT NULL,
	[INCIDENT] [varchar](100) NULL,
	[INSDESCRIPTION] [varchar](8000) NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
	[UPDATEDBY] [int] NULL,
	[UPDATEDDT] [datetime] NULL,
 CONSTRAINT [PK_ARC_SECURITY_INCIDENTMASTER] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SECURITY_QUERY_INCIDENT]    Script Date: 9/10/2020 2:38:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SECURITY_QUERY_INCIDENT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QID] [int] NULL,
	[SID] [int] NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
	[UPDATEDBY] [int] NULL,
	[UPDATEDDT] [datetime] NULL,
 CONSTRAINT [PK_ARC_SECURITY_QUERY_INCIDENT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SECURITY_TRANS]    Script Date: 9/10/2020 2:38:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SECURITY_TRANS](
	[TID] [int] IDENTITY(1,1) NOT NULL,
	[QID] [int] NULL,
	[FINALCOMMENTS] [varchar](max) NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDDT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Setup_Menu]    Script Date: 9/10/2020 2:38:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Setup_Menu](
	[MenuParentId] [int] NULL,
	[MenuDisplayText] [varchar](100) NULL,
	[MenuDescription] [varchar](500) NULL,
	[OutputPath] [varchar](max) NULL,
	[LogoFilePath] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[BaseFuntionality_Id] [int] NULL,
	[MenuId] [int] NOT NULL,
	[DisplayOrder] [int] IDENTITY(1,1) NOT NULL,
	[MenuFileName] [varchar](75) NOT NULL,
	[Boxno] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_ARC_Setup_Menu] UNIQUE NONCLUSTERED 
(
	[MenuFileName] ASC,
	[BaseFuntionality_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Setup_Menu_20190211]    Script Date: 9/10/2020 2:38:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Setup_Menu_20190211](
	[MenuParentId] [int] NULL,
	[MenuDisplayText] [varchar](100) NULL,
	[MenuDescription] [varchar](500) NULL,
	[OutputPath] [varchar](max) NULL,
	[LogoFilePath] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[BaseFuntionality_Id] [int] NULL,
	[MenuId] [int] NOT NULL,
	[DisplayOrder] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[MenuFileName] [varchar](100) NULL,
	[Boxno] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Setup_Menu_20200402]    Script Date: 9/10/2020 2:38:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Setup_Menu_20200402](
	[MenuParentId] [int] NULL,
	[MenuDisplayText] [varchar](100) NULL,
	[MenuDescription] [varchar](500) NULL,
	[OutputPath] [varchar](max) NULL,
	[LogoFilePath] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[BaseFuntionality_Id] [int] NULL,
	[MenuId] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[MenuFileName] [varchar](100) NULL,
	[Boxno] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Setup_Menu_bkup20200117]    Script Date: 9/10/2020 2:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Setup_Menu_bkup20200117](
	[MenuParentId] [int] NULL,
	[MenuDisplayText] [varchar](100) NULL,
	[MenuDescription] [varchar](500) NULL,
	[OutputPath] [varchar](max) NULL,
	[LogoFilePath] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[BaseFuntionality_Id] [int] NULL,
	[MenuId] [int] NOT NULL,
	[DisplayOrder] [int] IDENTITY(1,1) NOT NULL,
	[MenuFileName] [varchar](75) NOT NULL,
	[Boxno] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Setup_Menu_JAN]    Script Date: 9/10/2020 2:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Setup_Menu_JAN](
	[MenuParentId] [int] NULL,
	[MenuDisplayText] [varchar](100) NULL,
	[MenuDescription] [varchar](500) NULL,
	[OutputPath] [varchar](max) NULL,
	[LogoFilePath] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[BaseFuntionality_Id] [int] NULL,
	[MenuId] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[MenuFileName] [varchar](100) NULL,
	[Boxno] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Setup_MenuLog]    Script Date: 9/10/2020 2:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Setup_MenuLog](
	[MenuParentId] [int] NULL,
	[MenuDisplayText] [varchar](100) NULL,
	[MenuDescription] [varchar](500) NULL,
	[OutputPath] [varchar](max) NULL,
	[LogoFilePath] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[BaseFuntionality_Id] [int] NULL,
	[MenuId] [int] NOT NULL,
	[DisplayOrder] [int] NULL,
	[BatchId] [int] NULL,
	[Boxno] [int] NULL,
	[MenuFileName] [varchar](75) NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SUP_COMPLIANCE_FORWARDMAILLIST]    Script Date: 9/10/2020 2:38:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SUP_COMPLIANCE_FORWARDMAILLIST](
	[UserID] [int] NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_ARC_SUP_COMPLIANCE_FORWARDMAILLIST] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SUP_COMPLIANCE_INCIDENT]    Script Date: 9/10/2020 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SUP_COMPLIANCE_INCIDENT](
	[INCIDENT_ID] [int] IDENTITY(1,1) NOT NULL,
	[STATUS_ID] [int] NULL,
	[INCIDENT_TYPE] [int] NULL,
	[INCIDENT_DATE] [date] NULL,
	[INCIDENT_TIME] [datetime] NULL,
	[FACILITY_ID] [int] NULL,
	[FLOOR] [varchar](100) NULL,
	[BAY] [varchar](100) NULL,
	[INCIDENT_COMMENTS] [varchar](max) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DATE] [date] NULL,
	[ISANANYMOUS] [int] NULL,
	[FORWARDED_BY] [int] NULL,
	[FORWARDED_TO] [varchar](max) NULL,
	[FORWARDED_ON] [datetime] NULL,
	[FORWARD_COMMENTS] [varchar](max) NULL,
	[INVESTIGATED_BY] [int] NULL,
	[INVESTIGANTION_REPORTFILENAME] [varchar](max) NULL,
	[INVESTIGATED_ON] [date] NULL,
	[CLOSED_BY] [int] NULL,
	[CLOSED_ON] [date] NULL,
	[CLOSE_COMMENTS] [varchar](max) NULL,
	[ACTIVE] [bit] NULL,
	[REJECTED_BY] [int] NULL,
	[REJECTED_ON] [date] NULL,
	[REJECT_COMMENTS] [varchar](max) NULL,
	[INCIDENTREPORTSUMMARY] [varchar](5000) NULL,
	[ACTION_ASSOCIATENAME] [varchar](5000) NULL,
	[ACTION_ASSOCIATEEMPCODE] [varchar](5000) NULL,
	[ACTION_ASSOCIATEDEPT] [varchar](5000) NULL,
	[ACTION_COMPANY] [varchar](200) NULL,
 CONSTRAINT [PK_ARC_SUP_COMPLIANCE_INCIDENT] PRIMARY KEY CLUSTERED 
(
	[INCIDENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SUP_COMPLIANCE_INCIDENTACTIONS]    Script Date: 9/10/2020 2:38:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SUP_COMPLIANCE_INCIDENTACTIONS](
	[IncidentID] [int] NOT NULL,
	[ActionDate] [date] NULL,
	[ActionSubject] [varchar](200) NULL,
	[ActionRecommondation] [varchar](300) NULL,
	[ActionPersonName] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [date] NULL,
	[ActionID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ARC_SUP_COMPLIANCE_INCIDENTACTIONS] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SUP_COMPLIANCE_INCIDENTMASTER]    Script Date: 9/10/2020 2:38:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SUP_COMPLIANCE_INCIDENTMASTER](
	[IncidentId] [int] IDENTITY(1,1) NOT NULL,
	[IncidentName] [varchar](max) NULL,
	[TAT] [int] NULL,
	[Active] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_ARC_SUP_COMPLIANCE_INCIDENTMASTER] PRIMARY KEY CLUSTERED 
(
	[IncidentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SUP_COMPLIANCE_STATUS]    Script Date: 9/10/2020 2:38:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SUP_COMPLIANCE_STATUS](
	[STATUSID] [int] IDENTITY(1,1) NOT NULL,
	[STATUSNAME] [varchar](200) NULL,
	[ACTIVE] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[STATUSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_SwitchLogin]    Script Date: 9/10/2020 2:38:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_SwitchLogin](
	[nt_username] [varchar](75) NULL,
	[appname] [varchar](100) NULL,
	[redirecturl] [varchar](500) NULL,
	[createdby] [int] NULL,
	[createddt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_TAX_USER_RIGHTS]    Script Date: 9/10/2020 2:38:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_TAX_USER_RIGHTS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [int] NULL,
	[UTYPE] [int] NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDDT] [datetime] NULL,
	[CREATEDBY] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_TDS_INVALIDDATA]    Script Date: 9/10/2020 2:38:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_TDS_INVALIDDATA](
	[Emp ID] [nvarchar](255) NULL,
	[Emp Name] [nvarchar](255) NULL,
	[Pan Number] [nvarchar](255) NULL,
	[Basic + DA] [float] NULL,
	[HRA] [float] NULL,
	[Conveyance] [float] NULL,
	[SDA] [float] NULL,
	[Spl Allow] [float] NULL,
	[Bonus] [float] NULL,
	[Incentive] [float] NULL,
	[Earned Leave] [float] NULL,
	[Raw] [float] NULL,
	[NSA] [float] NULL,
	[Others] [float] NULL,
	[Medical Reim] [float] NULL,
	[Total Annual Salary] [float] NULL,
	[HRA Exemption] [float] NULL,
	[Conveyance1] [float] NULL,
	[Medical Reim1] [float] NULL,
	[Professional Tax] [float] NULL,
	[Total] [float] NULL,
	[Taxable Salary] [float] NULL,
	[Rental Income] [float] NULL,
	[Loss On self Occupied property -Interest] [float] NULL,
	[Capital Gains] [float] NULL,
	[Other income] [float] NULL,
	[Income  other than salary] [float] NULL,
	[Gross Total Income] [float] NULL,
	[Medical Ins# Premium - 80 D] [float] NULL,
	[Medical Ins# Premium - 80 D Parents] [float] NULL,
	[Education Loan - 80 E] [float] NULL,
	[Medical Exp - Handicapped Dep# - 80 DD] [float] NULL,
	[Permanent Disability 80 U] [float] NULL,
	[Deduction U/s 80C] [float] NULL,
	[Others If any] [nvarchar](255) NULL,
	[Total1] [float] NULL,
	[Taxable Income] [float] NULL,
	[Tax Payable] [float] NULL,
	[Tax deducted in till date] [float] NULL,
	[Balance deductible] [float] NULL,
	[REASON] [varchar](255) NULL,
	[Upload_Date] [datetime] NULL,
	[UserId] [int] NULL,
	[FileName] [nvarchar](34) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_TDS_RawData]    Script Date: 9/10/2020 2:38:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_TDS_RawData](
	[Emp ID] [nvarchar](255) NULL,
	[Emp Name] [nvarchar](255) NULL,
	[Basic + DA] [float] NULL,
	[HRA] [float] NULL,
	[Conveyance] [float] NULL,
	[SDA] [float] NULL,
	[Spl Allow] [float] NULL,
	[Bonus] [float] NULL,
	[Incentive] [float] NULL,
	[Earned Leave] [float] NULL,
	[Raw] [float] NULL,
	[NSA] [float] NULL,
	[Others] [float] NULL,
	[Medical Reim] [float] NULL,
	[Total Annual Salary] [float] NULL,
	[HRA Exemption] [float] NULL,
	[Conveyance1] [float] NULL,
	[Medical Reim1] [float] NULL,
	[Professional Tax] [float] NULL,
	[Total] [float] NULL,
	[Taxable Salary] [float] NULL,
	[Rental Income] [float] NULL,
	[Loss On self Occupied property -Interest] [float] NULL,
	[Capital Gains] [float] NULL,
	[Other income] [float] NULL,
	[Income  other than salary] [float] NULL,
	[Gross Total Income] [float] NULL,
	[Medical Ins# Premium - 80 D] [float] NULL,
	[Medical Ins# Premium - 80 D Parents] [float] NULL,
	[Education Loan - 80 E] [float] NULL,
	[Medical Exp - Handicapped Dep# - 80 DD] [float] NULL,
	[Permanent Disability 80 U] [float] NULL,
	[Deduction U/s 80C] [float] NULL,
	[Others If any] [nvarchar](255) NULL,
	[Total1] [float] NULL,
	[Taxable Income] [float] NULL,
	[Tax Payable] [float] NULL,
	[Tax deducted in till date] [float] NULL,
	[Balance deductible] [float] NULL,
	[Pan Number] [nvarchar](255) NULL,
	[Upload_Date] [datetime] NULL,
	[UserId] [int] NULL,
	[FileName] [nvarchar](34) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_TDS_TEMPRawData]    Script Date: 9/10/2020 2:38:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_TDS_TEMPRawData](
	[Emp ID] [nvarchar](255) NULL,
	[Emp Name] [nvarchar](255) NULL,
	[Basic + DA] [float] NULL,
	[HRA] [float] NULL,
	[Conveyance] [float] NULL,
	[SDA] [float] NULL,
	[Spl Allow] [float] NULL,
	[Bonus] [float] NULL,
	[Incentive] [float] NULL,
	[Earned Leave] [float] NULL,
	[Raw] [float] NULL,
	[NSA] [float] NULL,
	[Others] [float] NULL,
	[Medical Reim] [float] NULL,
	[Total Annual Salary] [float] NULL,
	[HRA Exemption] [float] NULL,
	[Conveyance1] [float] NULL,
	[Medical Reim1] [float] NULL,
	[Professional Tax] [float] NULL,
	[Total] [float] NULL,
	[Taxable Salary] [float] NULL,
	[Rental Income] [float] NULL,
	[Loss On self Occupied property -Interest] [float] NULL,
	[Capital Gains] [float] NULL,
	[Other income] [float] NULL,
	[Income  other than salary] [float] NULL,
	[Gross Total Income] [float] NULL,
	[Medical Ins# Premium - 80 D] [float] NULL,
	[Medical Ins# Premium - 80 D Parents] [float] NULL,
	[Education Loan - 80 E] [float] NULL,
	[Medical Exp - Handicapped Dep# - 80 DD] [float] NULL,
	[Permanent Disability 80 U] [float] NULL,
	[Deduction U/s 80C] [float] NULL,
	[Others If any] [nvarchar](255) NULL,
	[Total1] [float] NULL,
	[Taxable Income] [float] NULL,
	[Tax Payable] [float] NULL,
	[Tax deducted in till date] [float] NULL,
	[Balance deductible] [float] NULL,
	[Pan Number] [nvarchar](255) NULL,
	[Upload_Date] [datetime] NULL,
	[UserId] [int] NULL,
	[FileName] [nvarchar](34) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_TDS_VALIDDATA]    Script Date: 9/10/2020 2:38:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_TDS_VALIDDATA](
	[Emp ID] [nvarchar](255) NULL,
	[Emp Name] [nvarchar](255) NULL,
	[Basic + DA] [float] NULL,
	[HRA] [float] NULL,
	[Conveyance] [float] NULL,
	[SDA] [float] NULL,
	[Spl Allow] [float] NULL,
	[Bonus] [float] NULL,
	[Incentive] [float] NULL,
	[Earned Leave] [float] NULL,
	[Raw] [float] NULL,
	[NSA] [float] NULL,
	[Others] [float] NULL,
	[Medical Reim] [float] NULL,
	[Total Annual Salary] [float] NULL,
	[HRA Exemption] [float] NULL,
	[Conveyance1] [float] NULL,
	[Medical Reim1] [float] NULL,
	[Professional Tax] [float] NULL,
	[Total] [float] NULL,
	[Taxable Salary] [float] NULL,
	[Rental Income] [float] NULL,
	[Loss On self Occupied property -Interest] [float] NULL,
	[Capital Gains] [float] NULL,
	[Other income] [float] NULL,
	[Income  other than salary] [float] NULL,
	[Gross Total Income] [float] NULL,
	[Medical Ins# Premium - 80 D] [float] NULL,
	[Medical Ins# Premium - 80 D Parents] [float] NULL,
	[Education Loan - 80 E] [float] NULL,
	[Medical Exp - Handicapped Dep# - 80 DD] [float] NULL,
	[Permanent Disability 80 U] [float] NULL,
	[Deduction U/s 80C] [float] NULL,
	[Others If any] [nvarchar](255) NULL,
	[Total1] [float] NULL,
	[Taxable Income] [float] NULL,
	[Tax Payable] [float] NULL,
	[Tax deducted in till date] [float] NULL,
	[Balance deductible] [float] NULL,
	[FileName] [nvarchar](34) NULL,
	[Pan Number] [nvarchar](255) NULL,
	[Upload_Date] [datetime] NULL,
	[UserId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_UnauthorisedAccess]    Script Date: 9/10/2020 2:38:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_UnauthorisedAccess](
	[UserId] [int] NOT NULL,
	[URL] [varchar](300) NULL,
	[CreatedOn] [datetime] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[SessionUser] [varchar](75) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_WheelsCabDrop]    Script Date: 9/10/2020 2:38:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_WheelsCabDrop](
	[FieldId] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [varchar](50) NOT NULL,
	[EMPCODE] [varchar](10) NOT NULL,
	[DropType] [varchar](50) NULL,
	[DropPoint] [varchar](50) NULL,
	[CabNumber] [varchar](50) NULL,
	[Shift] [varchar](50) NULL,
	[DriverName] [varchar](50) NULL,
	[DriverNumber] [varchar](50) NULL,
	[FileName] [varchar](75) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
 CONSTRAINT [PK_DINU_TEST_Whl_Cab_Drop] PRIMARY KEY CLUSTERED 
(
	[FieldId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_WheelsCabDropLog]    Script Date: 9/10/2020 2:38:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_WheelsCabDropLog](
	[FieldId] [int] NOT NULL,
	[NAME] [varchar](50) NOT NULL,
	[EMPCODE] [varchar](10) NOT NULL,
	[DropType] [varchar](50) NULL,
	[DropPoint] [varchar](50) NULL,
	[CabNumber] [varchar](50) NULL,
	[Shift] [varchar](50) NULL,
	[DriverName] [varchar](50) NULL,
	[DriverNumber] [varchar](50) NULL,
	[FileName] [varchar](75) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_WheelsCabPickup]    Script Date: 9/10/2020 2:38:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_WheelsCabPickup](
	[FieldId] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [varchar](50) NOT NULL,
	[EMPCODE] [varchar](10) NOT NULL,
	[PickupType] [varchar](50) NULL,
	[PickupPoint] [varchar](50) NULL,
	[PickupTime] [time](7) NULL,
	[CabNumber] [varchar](50) NULL,
	[DriverNumber] [varchar](50) NULL,
	[DriverName] [varchar](50) NULL,
	[Shift] [varchar](50) NULL,
	[FileName] [varchar](75) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
 CONSTRAINT [PK_DINU_TEST_Whl_Cab] PRIMARY KEY CLUSTERED 
(
	[FieldId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_WheelsCabPickupLog]    Script Date: 9/10/2020 2:38:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_WheelsCabPickupLog](
	[FieldId] [int] NOT NULL,
	[NAME] [varchar](50) NOT NULL,
	[EMPCODE] [varchar](10) NOT NULL,
	[PickupType] [varchar](50) NULL,
	[PickupPoint] [varchar](50) NULL,
	[PickupTime] [time](7) NULL,
	[CabNumber] [varchar](50) NULL,
	[DriverNumber] [varchar](50) NULL,
	[DriverName] [varchar](50) NULL,
	[Shift] [varchar](50) NULL,
	[FileName] [varchar](75) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[MODIFY_DT] [datetime] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AUDITORFEED]    Script Date: 9/10/2020 2:38:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AUDITORFEED](
	[S#No] [float] NULL,
	[Internal Auditor] [nvarchar](255) NULL,
	[SDP's] [float] NULL,
	[Timeline feed] [nvarchar](255) NULL,
	[Type ] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CDNS1]    Script Date: 9/10/2020 2:38:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CDNS1](
	[NTUSERNAME] [nvarchar](255) NULL,
	[Tdate] [datetime] NULL,
	[T] [float] NULL,
	[A] [float] NULL,
	[P] [float] NULL,
	[Type] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CDSNI]    Script Date: 9/10/2020 2:38:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CDSNI](
	[Targetdate] [datetime] NULL,
	[NTUserName] [nvarchar](255) NULL,
	[Target] [float] NULL,
	[Achieved] [float] NULL,
	[Percentage] [float] NULL,
	[Type] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currentpoints]    Script Date: 9/10/2020 2:38:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currentpoints](
	[userid] [int] NULL,
	[Cid] [int] NULL,
	[CPoints] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currentpoints1]    Script Date: 9/10/2020 2:38:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currentpoints1](
	[userid] [int] NULL,
	[Cid] [int] NULL,
	[CPoints] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer_data]    Script Date: 9/10/2020 2:38:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_data](
	[Customer_id] [int] NOT NULL,
	[Customer_Name] [varchar](100) NOT NULL,
	[Credit_card_number] [varchar](25) NOT NULL,
	[Credit_card_number_encrypt] [varbinary](max) NULL,
 CONSTRAINT [Pkey3] PRIMARY KEY CLUSTERED 
(
	[Customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DateEstimation]    Script Date: 9/10/2020 2:38:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DateEstimation](
	[ActDate] [date] NULL,
	[ActDay] [varchar](20) NULL,
	[Holiday] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectReports]    Script Date: 9/10/2020 2:38:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectReports](
	[UserId] [int] NULL,
	[Name] [varchar](75) NULL,
	[UserName] [varchar](75) NULL,
	[Level] [int] NULL,
	[Parent] [varchar](75) NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESS_QuestionBank]    Script Date: 9/10/2020 2:38:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESS_QuestionBank](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NULL,
	[Questions] [varchar](500) NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[DisplayOrder] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESS_QuestionGroup]    Script Date: 9/10/2020 2:38:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESS_QuestionGroup](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [varchar](300) NULL,
	[Status] [tinyint] NULL,
	[DisplayOrder] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_ESS_QuestionGroup] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESS_QuestionOptions]    Script Date: 9/10/2020 2:38:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESS_QuestionOptions](
	[OptionId] [int] IDENTITY(1,1) NOT NULL,
	[OptionName] [varchar](200) NULL,
	[ModuleName] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[Weightage] [int] NULL,
 CONSTRAINT [PK__ESS_Ques__92C7A1FF0E33F0C8] PRIMARY KEY CLUSTERED 
(
	[OptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESS_QuestionSurvey]    Script Date: 9/10/2020 2:38:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESS_QuestionSurvey](
	[QuestionSurveyId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[QuestionId] [int] NULL,
	[AnswerOptionsId] [int] NULL,
	[Comments] [varchar](500) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK__ESS_Ques__8D3DB7A80A635FE4] PRIMARY KEY CLUSTERED 
(
	[QuestionSurveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESS_SurveyLog]    Script Date: 9/10/2020 2:38:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESS_SurveyLog](
	[SurveyLogId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SurveyLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Eye_Facility]    Script Date: 9/10/2020 2:38:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eye_Facility](
	[FacilityId] [int] IDENTITY(1,1) NOT NULL,
	[FacilityName] [varchar](50) NULL,
	[LevelName] [varchar](10) NULL,
	[Active] [varchar](1) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[Capacity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FacilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[FacilityName] ASC,
	[LevelName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Eye_IpAccess]    Script Date: 9/10/2020 2:38:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eye_IpAccess](
	[UserId] [int] NULL,
	[Facilityid] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
UNIQUE NONCLUSTERED 
(
	[UserId] ASC,
	[Facilityid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Eye_IPDetails]    Script Date: 9/10/2020 2:38:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eye_IPDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BayNo] [varchar](20) NULL,
	[BayIP] [varchar](20) NULL,
	[Status] [tinyint] NULL,
	[Facilityid] [int] NULL,
	[ExtNo] [varchar](10) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
 CONSTRAINT [Eye_IPDetails_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[eye_ipdetails_backup]    Script Date: 9/10/2020 2:38:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eye_ipdetails_backup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BayNo] [varchar](20) NULL,
	[BayIP] [varchar](20) NULL,
	[Status] [tinyint] NULL,
	[Facilityid] [int] NULL,
	[ExtNo] [varchar](10) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Eye_IPDetailsLog]    Script Date: 9/10/2020 2:38:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eye_IPDetailsLog](
	[Id] [int] NULL,
	[BayNo] [varchar](20) NULL,
	[BayIP] [varchar](20) NULL,
	[Status] [tinyint] NULL,
	[Facilityid] [int] NULL,
	[ExtNo] [varchar](10) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK__Eye_IPDe__FFEE743155B72E55] PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FB_WinnerOfTheMonth]    Script Date: 9/10/2020 2:38:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FB_WinnerOfTheMonth](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FBID] [varchar](100) NULL,
	[FBName] [varchar](100) NULL,
	[WMonth] [tinyint] NULL,
	[WYear] [int] NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_WOM_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groove2014]    Script Date: 9/10/2020 2:38:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groove2014](
	[S# No] [float] NULL,
	[Name] [nvarchar](255) NULL,
	[Emp Code] [nvarchar](255) NULL,
	[Team] [nvarchar](255) NULL,
	[NT ID] [nvarchar](255) NULL,
	[7-Mar] [nvarchar](255) NULL,
	[F7] [nvarchar](255) NULL,
	[F8] [nvarchar](255) NULL,
	[F9] [nvarchar](255) NULL,
	[F10] [nvarchar](255) NULL,
	[F11] [nvarchar](255) NULL,
	[F12] [nvarchar](255) NULL,
	[F13] [nvarchar](255) NULL,
	[F14] [nvarchar](255) NULL,
	[F15] [nvarchar](255) NULL,
	[F16] [nvarchar](255) NULL,
	[F17] [nvarchar](255) NULL,
	[F18] [nvarchar](255) NULL,
	[F19] [nvarchar](255) NULL,
	[F20] [nvarchar](255) NULL,
	[F21] [nvarchar](255) NULL,
	[F22] [nvarchar](255) NULL,
	[F23] [nvarchar](255) NULL,
	[F24] [nvarchar](255) NULL,
	[F25] [nvarchar](255) NULL,
	[F26] [nvarchar](255) NULL,
	[F27] [nvarchar](255) NULL,
	[F28] [nvarchar](255) NULL,
	[F29] [nvarchar](255) NULL,
	[F30] [nvarchar](255) NULL,
	[F31] [nvarchar](255) NULL,
	[F32] [nvarchar](255) NULL,
	[F33] [nvarchar](255) NULL,
	[F34] [nvarchar](255) NULL,
	[F35] [nvarchar](255) NULL,
	[F36] [nvarchar](255) NULL,
	[F37] [nvarchar](255) NULL,
	[F38] [nvarchar](255) NULL,
	[F39] [nvarchar](255) NULL,
	[F40] [nvarchar](255) NULL,
	[F41] [nvarchar](255) NULL,
	[F42] [nvarchar](255) NULL,
	[F43] [nvarchar](255) NULL,
	[F44] [nvarchar](255) NULL,
	[F45] [nvarchar](255) NULL,
	[F46] [nvarchar](255) NULL,
	[F47] [nvarchar](255) NULL,
	[F48] [nvarchar](255) NULL,
	[F49] [nvarchar](255) NULL,
	[F50] [nvarchar](255) NULL,
	[F51] [nvarchar](255) NULL,
	[F52] [nvarchar](255) NULL,
	[F53] [nvarchar](255) NULL,
	[F54] [nvarchar](255) NULL,
	[F55] [nvarchar](255) NULL,
	[F56] [nvarchar](255) NULL,
	[F57] [nvarchar](255) NULL,
	[F58] [nvarchar](255) NULL,
	[F59] [nvarchar](255) NULL,
	[F60] [nvarchar](255) NULL,
	[F61] [nvarchar](255) NULL,
	[F62] [nvarchar](255) NULL,
	[F63] [nvarchar](255) NULL,
	[F64] [nvarchar](255) NULL,
	[F65] [nvarchar](255) NULL,
	[F66] [nvarchar](255) NULL,
	[F67] [nvarchar](255) NULL,
	[F68] [nvarchar](255) NULL,
	[F69] [nvarchar](255) NULL,
	[F70] [nvarchar](255) NULL,
	[F71] [nvarchar](255) NULL,
	[F72] [nvarchar](255) NULL,
	[F73] [nvarchar](255) NULL,
	[F74] [nvarchar](255) NULL,
	[F75] [nvarchar](255) NULL,
	[F76] [nvarchar](255) NULL,
	[F77] [nvarchar](255) NULL,
	[F78] [nvarchar](255) NULL,
	[F79] [nvarchar](255) NULL,
	[F80] [nvarchar](255) NULL,
	[F81] [nvarchar](255) NULL,
	[F82] [nvarchar](255) NULL,
	[F83] [nvarchar](255) NULL,
	[F84] [nvarchar](255) NULL,
	[F85] [nvarchar](255) NULL,
	[F86] [nvarchar](255) NULL,
	[F87] [nvarchar](255) NULL,
	[F88] [nvarchar](255) NULL,
	[F89] [nvarchar](255) NULL,
	[F90] [nvarchar](255) NULL,
	[F91] [nvarchar](255) NULL,
	[F92] [nvarchar](255) NULL,
	[F93] [nvarchar](255) NULL,
	[F94] [nvarchar](255) NULL,
	[F95] [nvarchar](255) NULL,
	[F96] [nvarchar](255) NULL,
	[F97] [nvarchar](255) NULL,
	[F98] [nvarchar](255) NULL,
	[F99] [nvarchar](255) NULL,
	[F100] [nvarchar](255) NULL,
	[F101] [nvarchar](255) NULL,
	[F102] [nvarchar](255) NULL,
	[F103] [nvarchar](255) NULL,
	[F104] [nvarchar](255) NULL,
	[F105] [nvarchar](255) NULL,
	[F106] [nvarchar](255) NULL,
	[F107] [nvarchar](255) NULL,
	[F108] [nvarchar](255) NULL,
	[F109] [nvarchar](255) NULL,
	[F110] [nvarchar](255) NULL,
	[F111] [nvarchar](255) NULL,
	[F112] [nvarchar](255) NULL,
	[F113] [nvarchar](255) NULL,
	[F114] [nvarchar](255) NULL,
	[F115] [nvarchar](255) NULL,
	[F116] [nvarchar](255) NULL,
	[F117] [nvarchar](255) NULL,
	[F118] [nvarchar](255) NULL,
	[F119] [nvarchar](255) NULL,
	[F120] [nvarchar](255) NULL,
	[F121] [nvarchar](255) NULL,
	[F122] [nvarchar](255) NULL,
	[F123] [nvarchar](255) NULL,
	[F124] [nvarchar](255) NULL,
	[F125] [nvarchar](255) NULL,
	[F126] [nvarchar](255) NULL,
	[F127] [nvarchar](255) NULL,
	[F128] [nvarchar](255) NULL,
	[F129] [nvarchar](255) NULL,
	[F130] [nvarchar](255) NULL,
	[F131] [nvarchar](255) NULL,
	[F132] [nvarchar](255) NULL,
	[F133] [nvarchar](255) NULL,
	[F134] [nvarchar](255) NULL,
	[F135] [nvarchar](255) NULL,
	[F136] [nvarchar](255) NULL,
	[F137] [nvarchar](255) NULL,
	[F138] [nvarchar](255) NULL,
	[F139] [nvarchar](255) NULL,
	[F140] [nvarchar](255) NULL,
	[F141] [nvarchar](255) NULL,
	[F142] [nvarchar](255) NULL,
	[F143] [nvarchar](255) NULL,
	[F144] [nvarchar](255) NULL,
	[F145] [nvarchar](255) NULL,
	[F146] [nvarchar](255) NULL,
	[F147] [nvarchar](255) NULL,
	[F148] [nvarchar](255) NULL,
	[F149] [nvarchar](255) NULL,
	[F150] [nvarchar](255) NULL,
	[F151] [nvarchar](255) NULL,
	[F152] [nvarchar](255) NULL,
	[F153] [nvarchar](255) NULL,
	[F154] [nvarchar](255) NULL,
	[F155] [nvarchar](255) NULL,
	[F156] [nvarchar](255) NULL,
	[F157] [nvarchar](255) NULL,
	[F158] [nvarchar](255) NULL,
	[F159] [nvarchar](255) NULL,
	[F160] [nvarchar](255) NULL,
	[F161] [nvarchar](255) NULL,
	[F162] [nvarchar](255) NULL,
	[F163] [nvarchar](255) NULL,
	[F164] [nvarchar](255) NULL,
	[F165] [nvarchar](255) NULL,
	[F166] [nvarchar](255) NULL,
	[F167] [nvarchar](255) NULL,
	[F168] [nvarchar](255) NULL,
	[F169] [nvarchar](255) NULL,
	[F170] [nvarchar](255) NULL,
	[F171] [nvarchar](255) NULL,
	[F172] [nvarchar](255) NULL,
	[F173] [nvarchar](255) NULL,
	[F174] [nvarchar](255) NULL,
	[F175] [nvarchar](255) NULL,
	[F176] [nvarchar](255) NULL,
	[F177] [nvarchar](255) NULL,
	[F178] [nvarchar](255) NULL,
	[F179] [nvarchar](255) NULL,
	[F180] [nvarchar](255) NULL,
	[F181] [nvarchar](255) NULL,
	[F182] [nvarchar](255) NULL,
	[F183] [nvarchar](255) NULL,
	[F184] [nvarchar](255) NULL,
	[F185] [nvarchar](255) NULL,
	[F186] [nvarchar](255) NULL,
	[F187] [nvarchar](255) NULL,
	[F188] [nvarchar](255) NULL,
	[F189] [nvarchar](255) NULL,
	[F190] [nvarchar](255) NULL,
	[F191] [nvarchar](255) NULL,
	[F192] [nvarchar](255) NULL,
	[F193] [nvarchar](255) NULL,
	[F194] [nvarchar](255) NULL,
	[F195] [nvarchar](255) NULL,
	[F196] [nvarchar](255) NULL,
	[F197] [nvarchar](255) NULL,
	[F198] [nvarchar](255) NULL,
	[F199] [nvarchar](255) NULL,
	[F200] [nvarchar](255) NULL,
	[F201] [nvarchar](255) NULL,
	[F202] [nvarchar](255) NULL,
	[F203] [nvarchar](255) NULL,
	[F204] [nvarchar](255) NULL,
	[F205] [nvarchar](255) NULL,
	[F206] [nvarchar](255) NULL,
	[F207] [nvarchar](255) NULL,
	[F208] [nvarchar](255) NULL,
	[F209] [nvarchar](255) NULL,
	[F210] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_Athena_Access]    Script Date: 9/10/2020 2:38:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_Athena_Access](
	[AccessId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[Active] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_Athena_ApprovalUsers]    Script Date: 9/10/2020 2:38:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_Athena_ApprovalUsers](
	[UserId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_Athena_Deactivate]    Script Date: 9/10/2020 2:38:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_Athena_Deactivate](
	[DeactivateId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ReqId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[Status] [int] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL,
	[Comments] [varchar](2000) NULL,
	[DeactivatedDt] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_Athena_Department]    Script Date: 9/10/2020 2:38:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_Athena_Department](
	[DeptId] [int] IDENTITY(1,1) NOT NULL,
	[Department] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_Athena_PasswordChange]    Script Date: 9/10/2020 2:38:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_Athena_PasswordChange](
	[ChangeId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ReqId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[Status] [int] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL,
	[Comments] [varchar](200) NULL,
	[PwdUpdDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_Athena_Role]    Script Date: 9/10/2020 2:38:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_Athena_Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_Athena_Terminate]    Script Date: 9/10/2020 2:38:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_Athena_Terminate](
	[TerminateId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ReqId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[Status] [int] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL,
	[CitrixReqId] [varchar](20) NULL,
	[Comments] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_Athena_Transfer]    Script Date: 9/10/2020 2:38:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_Athena_Transfer](
	[TransferId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ReqId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[Status] [int] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDt] [datetime] NULL,
	[RoleId] [int] NULL,
	[DeptId] [int] NULL,
	[CitrixUserName] [varchar](200) NULL,
	[CitrixReqId] [varchar](20) NULL,
	[Comments] [varchar](500) NULL,
	[AddCitrix] [char](1) NULL,
	[TransferDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_AthenaUsers]    Script Date: 9/10/2020 2:38:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_AthenaUsers](
	[AthenaUserId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Issue_ReqId] [int] NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
	[DeptId] [int] NULL,
	[AthenaUserName] [varchar](200) NULL,
	[CitrixUserName] [varchar](200) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[HasCitrixReq] [char](1) NULL,
	[Status] [int] NULL,
	[AthenaUNUpdatedBy] [int] NULL,
	[AthenaUNUpdDt] [datetime] NULL,
	[CitrixUNUpdatedBy] [int] NULL,
	[CitrixUNUpdatedDt] [datetime] NULL,
	[Comments] [varchar](2000) NULL,
	[CitrixReqId] [varchar](20) NULL,
	[Active] [char](1) NULL,
	[Terminated] [char](1) NULL,
	[oldAthenaUserName] [varchar](100) NULL,
	[ModifiedComments] [varchar](max) NULL,
 CONSTRAINT [PK__HD_Athen__0DBA8685674A9333] PRIMARY KEY NONCLUSTERED 
(
	[AthenaUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_AthenaUsers_Log]    Script Date: 9/10/2020 2:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_AthenaUsers_Log](
	[AthenaUserId] [int] IDENTITY(1,1) NOT NULL,
	[Issue_ReqId] [int] NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
	[DeptId] [int] NULL,
	[AthenaUserName] [varchar](200) NULL,
	[CitrixUserName] [varchar](200) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[HasCitrixReq] [char](1) NULL,
	[Status] [int] NULL,
	[AthenaUNUpdatedBy] [int] NULL,
	[AthenaUNUpdDt] [datetime] NULL,
	[CitrixUNUpdatedBy] [int] NULL,
	[CitrixUNUpdatedDt] [datetime] NULL,
	[Comments] [varchar](2000) NULL,
	[CitrixReqId] [varchar](20) NULL,
	[Active] [char](1) NULL,
	[Terminated] [char](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_ATTACHMENT_TRAN]    Script Date: 9/10/2020 2:38:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_ATTACHMENT_TRAN](
	[ATTACH_ID] [int] IDENTITY(1,1) NOT NULL,
	[ATTACH_FILENAME] [varchar](100) NULL,
	[ISS_REQID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ATTACH_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_CabRequests]    Script Date: 9/10/2020 2:38:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_CabRequests](
	[ReqId] [int] NULL,
	[AssociateId] [int] NULL,
	[TravelDt] [date] NULL,
	[Mode] [char](1) NULL,
	[Place] [varchar](2000) NULL,
	[LandMark] [varchar](2000) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[Status] [int] NULL,
	[ProcessedBy] [int] NULL,
	[ProcessedDt] [datetime] NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedDt] [datetime] NULL,
	[TravelTime] [time](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_CRITICAL_INFO]    Script Date: 9/10/2020 2:38:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_CRITICAL_INFO](
	[CRITICAL_ID] [int] IDENTITY(1,1) NOT NULL,
	[CRITICAL_TEXT] [varchar](15) NULL,
	[ACTIVE] [varchar](1) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CRITICAL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_ESCALATED_TICKETS]    Script Date: 9/10/2020 2:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_ESCALATED_TICKETS](
	[EID] [int] IDENTITY(1,1) NOT NULL,
	[ISS_REQID] [int] NOT NULL,
	[TICKET_ID] [int] NOT NULL,
	[CREATED_DT] [datetime] NULL,
 CONSTRAINT [PK__HD_ESCAL__29BBA2FA3449B6E4] PRIMARY KEY CLUSTERED 
(
	[ISS_REQID] ASC,
	[TICKET_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_ISSUE_INFO]    Script Date: 9/10/2020 2:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_ISSUE_INFO](
	[ISSUE_ID] [int] IDENTITY(1,1) NOT NULL,
	[DEPT_ID] [int] NULL,
	[ISSUE_NAME] [varchar](100) NULL,
	[ACTIVE] [varchar](1) NULL,
	[DUR_CLOSE] [int] NULL,
	[DUR_MODE] [varchar](1) NULL,
	[CRITICAL_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Description] [varchar](500) NULL,
	[old_issue_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ISSUE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_ISSUE_INFO_LOG]    Script Date: 9/10/2020 2:38:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_ISSUE_INFO_LOG](
	[ISSUE_ID] [int] NULL,
	[DEPT_ID] [int] NULL,
	[ISSUE_NAME] [varchar](100) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ACTIVE] [varchar](1) NULL,
	[DUR_CLOSE] [int] NULL,
	[DUR_MODE] [varchar](1) NULL,
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
	[CRITICAL_ID] [int] NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK__HD_ISSUE__68DB447D43A29FBB] PRIMARY KEY CLUSTERED 
(
	[ROW_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_ISSUE_REQUEST]    Script Date: 9/10/2020 2:38:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_ISSUE_REQUEST](
	[ISS_REQID] [int] IDENTITY(1,1) NOT NULL,
	[ISSUE_ID] [int] NULL,
	[TICKET_ID] [int] NULL,
	[CRITICAL_ID] [int] NULL,
	[DUR_CLOSE] [int] NULL,
	[DUR_MODE] [varchar](1) NULL,
	[COMMENTS] [varchar](1000) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[FORWARD_TO] [int] NULL,
	[ISSUE_RATE] [int] NULL,
	[old_issue_id] [int] NULL,
	[ACTIVE] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[ISS_REQID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_ISSUE_STATUS_INFO]    Script Date: 9/10/2020 2:38:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_ISSUE_STATUS_INFO](
	[STATUS_TEXT] [varchar](20) NULL,
	[STATUS_ID] [int] IDENTITY(0,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[STATUS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_ISSUE_TRAN]    Script Date: 9/10/2020 2:38:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_ISSUE_TRAN](
	[ISSUE_TRANID] [int] IDENTITY(1,1) NOT NULL,
	[ISS_REQID] [int] NULL,
	[ISSUE_STATUS] [int] NULL,
	[REMARKS] [varchar](1000) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[ISSUE_FIXTIME] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ISSUE_TRANID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_ISSUE_TRAN_INFO]    Script Date: 9/10/2020 2:38:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_ISSUE_TRAN_INFO](
	[ISSUE_STATUS] [int] NULL,
	[ISSUE_STATUS_INFO] [varchar](50) NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_PROCESS_ACCESS]    Script Date: 9/10/2020 2:38:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_PROCESS_ACCESS](
	[DEPT_ID] [int] NOT NULL,
	[USERID] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DEPT_ID] ASC,
	[USERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_StatineryItemmaster]    Script Date: 9/10/2020 2:38:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_StatineryItemmaster](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [varchar](75) NOT NULL,
	[Quantity] [varchar](30) NULL,
	[Active] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ItemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_StationeryRequest]    Script Date: 9/10/2020 2:38:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_StationeryRequest](
	[ISS_REQID] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[RequestDt] [datetime] NULL,
	[Quantity] [int] NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[ProcessedBy] [int] NULL,
	[ProcessedDt] [datetime] NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedDt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HD_TICKET_DEPARTMENT]    Script Date: 9/10/2020 2:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HD_TICKET_DEPARTMENT](
	[DEPT_ID] [int] IDENTITY(1,1) NOT NULL,
	[DEPT_NAME] [varchar](50) NULL,
	[ACTIVE] [varchar](1) NULL,
	[DEPT_MAILID] [varchar](100) NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[DEPT_HEAD] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DEPT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HR_Designation]    Script Date: 9/10/2020 2:38:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_Designation](
	[Designation] [varchar](100) NULL,
	[SearchKey] [varchar](50) NULL,
	[givenBy] [varchar](30) NULL,
	[givenDt] [datetime] NULL,
	[OUDetail] [varchar](500) NULL,
	[DesigGradeId] [int] NULL,
	[DesigFuncId] [int] NULL,
	[DesigTitleId] [int] NULL,
	[NewDesigId] [int] NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[DesigId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[NoticePeriod] [int] NULL,
	[Supervisor] [char](1) NULL,
	[HeadCountName] [varchar](10) NULL,
	[CameraPhoneAllowed] [int] NULL,
	[OP_READ] [char](1) NULL,
	[OP_EDIT] [char](1) NULL,
	[IsDesignationAMandAbove] [int] NULL,
	[HeadsandAbove] [bit] NULL,
	[Band] [tinyint] NULL,
	[Grade] [varchar](4) NULL,
	[ExpectedDays] [int] NULL,
	[ShortName] [varchar](100) NULL,
	[FCRating] [varchar](10) NULL,
	[BCRating] [varchar](10) NULL,
 CONSTRAINT [PK_HD_DesigId] PRIMARY KEY CLUSTERED 
(
	[DesigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HR_DesignationChangeLog]    Script Date: 9/10/2020 2:38:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_DesignationChangeLog](
	[OldDesigId] [int] NOT NULL,
	[NewDesigId] [int] NULL,
	[OldDesignation] [nvarchar](255) NULL,
	[NewDesignation] [nvarchar](255) NULL,
	[Grade] [varchar](3) NULL,
	[RevisedNewDesigId] [int] NULL,
	[RevisedNewDesignation] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HR_DynamicReports]    Script Date: 9/10/2020 2:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_DynamicReports](
	[Rid] [int] IDENTITY(1,1) NOT NULL,
	[ReportName] [varchar](500) NULL,
	[ReportSP] [varchar](500) NULL,
	[Remarks] [varchar](1000) NULL,
	[status] [tinyint] NULL,
	[Selection] [varchar](1000) NULL,
 CONSTRAINT [PK_HD_Rid] PRIMARY KEY CLUSTERED 
(
	[Rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HR_FacilityMaster]    Script Date: 9/10/2020 2:38:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_FacilityMaster](
	[TCId] [int] NOT NULL,
	[CountryId] [int] NULL,
	[StateId] [int] NULL,
	[Facility] [varchar](100) NOT NULL,
	[CentreType] [tinyint] NULL,
	[Address] [varchar](500) NULL,
	[City] [varchar](100) NULL,
	[Status] [tinyint] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[AreaCode] [varchar](20) NULL,
	[ContactNo] [varchar](50) NULL,
	[Pincode] [int] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[Coordinator] [varchar](50) NULL,
	[CoordinatorContactNumber] [varchar](100) NULL,
	[District] [varchar](50) NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_HFM_TCId] PRIMARY KEY CLUSTERED 
(
	[TCId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HR_Functionality]    Script Date: 9/10/2020 2:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_Functionality](
	[FunctionName] [varchar](100) NOT NULL,
	[FuncLevel] [tinyint] NOT NULL,
	[FuncParentId] [smallint] NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[FunctionalityId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[JobTitle] [varchar](100) NULL,
	[Type] [varchar](100) NULL,
	[JOB_CATEGORY_ID] [int] NULL,
	[FunctionalityGroupID] [int] NULL,
	[FunctionGroupId] [int] NULL,
	[SubFunctionGroupId] [int] NULL,
 CONSTRAINT [PK_HF_FunctionalityId] PRIMARY KEY CLUSTERED 
(
	[FunctionalityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UNI_functionname] UNIQUE NONCLUSTERED 
(
	[FunctionName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HR_LocationMaster]    Script Date: 9/10/2020 2:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_LocationMaster](
	[LocationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LocationName] [varchar](50) NULL,
	[LocationCompanyName] [varchar](100) NULL,
	[Active] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ShortName] [varchar](10) NULL,
	[EmpCodeSeedKey] [varchar](50) NULL,
	[EmpCodePrefix] [varchar](50) NULL,
	[HappinessMeterStatus] [int] NULL,
 CONSTRAINT [PK__HR_Locat__E7FEA47772959031] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hr_MPR]    Script Date: 9/10/2020 2:38:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hr_MPR](
	[TCId] [int] NULL,
	[DesigId] [int] NOT NULL,
	[FunctionalityId] [int] NOT NULL,
	[TotalPositions] [tinyint] NOT NULL,
	[SalaryMax] [int] NULL,
	[SalaryMin] [int] NULL,
	[ExpDate] [datetime] NULL,
	[Skillset] [varchar](250) NULL,
	[Qualification] [varchar](100) NULL,
	[NatureofWork] [varchar](250) NULL,
	[TargetIndustry] [varchar](250) NULL,
	[Reason] [varchar](200) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ApprovalStatus] [tinyint] NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedDate] [datetime] NULL,
	[MPRStatus] [tinyint] NOT NULL,
	[PositionsClosed] [tinyint] NULL,
	[ClosedBy] [int] NULL,
	[ClosedDate] [datetime] NULL,
	[MPRStatusDate] [datetime] NULL,
	[experience] [smallint] NULL,
	[approvalcomments] [varchar](1000) NULL,
	[expfromyears] [varchar](10) NULL,
	[exptoyears] [varchar](10) NULL,
	[MPRId] [int] IDENTITY(1,1) NOT NULL,
	[Clientid] [int] NULL,
	[Published] [tinyint] NULL,
	[PositionType] [tinyint] NULL,
	[MprCancel] [tinyint] NULL,
	[MprCancelComments] [varchar](100) NULL,
	[MDApprovalStatus] [tinyint] NULL,
	[MDApprovedBy] [int] NULL,
	[MDApprovedDate] [datetime] NULL,
	[MDapprovalcomments] [varchar](1000) NULL,
 CONSTRAINT [PK_MPRID] PRIMARY KEY CLUSTERED 
(
	[MPRId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HR_MPRClosedetails]    Script Date: 9/10/2020 2:38:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_MPRClosedetails](
	[MPRId] [int] NULL,
	[PositionsClosed] [tinyint] NULL,
	[Comments] [varchar](300) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[MPRDetId] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_MPRDetId] PRIMARY KEY CLUSTERED 
(
	[MPRDetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IndexRebulidDetails]    Script Date: 9/10/2020 2:38:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndexRebulidDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IndexName] [nvarchar](100) NULL,
	[TableName] [nvarchar](100) NULL,
	[REBulidStart] [datetime] NULL,
	[RebulidEnd] [datetime] NULL,
	[BFIndexFra] [numeric](18, 2) NULL,
	[AFIndexFra] [numeric](18, 2) NULL,
 CONSTRAINT [PK_ID_Index] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Information]    Script Date: 9/10/2020 2:38:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Information](
	[empname] [varchar](40) NULL,
	[pic] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Knol_Data]    Script Date: 9/10/2020 2:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Knol_Data](
	[Scoreid] [int] IDENTITY(1,1) NOT NULL,
	[Userid] [int] NULL,
	[CID] [int] NULL,
	[Points] [int] NULL,
	[Status] [tinyint] NULL,
	[CreatedOn] [datetime] NULL,
	[ReferenceInfo] [varchar](1000) NULL,
	[ReferenceId] [int] NULL,
	[ReasontoReduce] [varchar](500) NULL,
	[ModifiedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manila_HD_AthenaUsers]    Script Date: 9/10/2020 2:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manila_HD_AthenaUsers](
	[AthenaUserId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Issue_ReqId] [int] NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
	[DeptId] [int] NULL,
	[AthenaUserName] [varchar](200) NULL,
	[CitrixUserName] [varchar](200) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[HasCitrixReq] [char](1) NULL,
	[Status] [int] NULL,
	[AthenaUNUpdatedBy] [int] NULL,
	[AthenaUNUpdDt] [datetime] NULL,
	[CitrixUNUpdatedBy] [int] NULL,
	[CitrixUNUpdatedDt] [datetime] NULL,
	[Comments] [varchar](2000) NULL,
	[CitrixReqId] [varchar](20) NULL,
	[Active] [char](1) NULL,
	[Terminated] [char](1) NULL,
	[oldAthenaUserName] [varchar](100) NULL,
	[ModifiedComments] [varchar](max) NULL,
	[BPO_Type] [int] NULL,
	[ID_Created_Dt] [datetime] NULL,
 CONSTRAINT [pk_HD_AthenaUsers] PRIMARY KEY NONCLUSTERED 
(
	[AthenaUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MAP_Accessprivileges]    Script Date: 9/10/2020 2:38:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAP_Accessprivileges](
	[Id] [int] NOT NULL,
	[ApplicationId] [tinyint] NOT NULL,
	[PrivilegeType] [char](1) NOT NULL,
	[PrivilegeRole] [int] NOT NULL,
	[FormCode] [varchar](12) NOT NULL,
	[Read] [char](1) NULL,
	[Write] [char](1) NULL,
	[Modify] [char](1) NULL,
	[Delete] [char](1) NULL,
	[Modifiedby] [int] NULL,
	[Modifieddt] [datetime] NULL,
	[Status] [tinyint] NULL,
	[idd] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_AP_Idd] PRIMARY KEY CLUSTERED 
(
	[idd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MAP_AccessprivilegesLog]    Script Date: 9/10/2020 2:38:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAP_AccessprivilegesLog](
	[Id] [int] NOT NULL,
	[ApplicationId] [tinyint] NOT NULL,
	[Privilegetype] [char](1) NULL,
	[Privilegerole] [int] NOT NULL,
	[Description] [varchar](100) NULL,
	[Modifiedby] [int] NULL,
	[Modifieddt] [datetime] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_APL_ID] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[map_applicationforms]    Script Date: 9/10/2020 2:38:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[map_applicationforms](
	[Id] [int] NOT NULL,
	[ApplicationId] [tinyint] NOT NULL,
	[FormCode] [varchar](12) NOT NULL,
	[FormName] [varchar](50) NULL,
	[TabDisplayName] [varchar](10) NULL,
	[Module] [varchar](50) NULL,
	[PageURL] [varchar](500) NULL,
	[PageDescription] [varchar](1000) NULL,
	[FormAdmin] [char](1) NULL,
	[FormSuper] [char](1) NULL,
	[FormOperator] [char](1) NULL,
	[Status] [tinyint] NULL,
	[Createdby] [int] NOT NULL,
	[Createddt] [datetime] NULL,
	[Updatedby] [int] NULL,
	[Updateddt] [datetime] NULL,
	[Ordval] [int] NULL,
	[ModuleId] [int] NULL,
	[Menudisplay] [tinyint] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_AF_ID] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MAP_ApplicationModule]    Script Date: 9/10/2020 2:38:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAP_ApplicationModule](
	[Module] [varchar](100) NULL,
	[Ordval] [int] NULL,
	[Status] [bit] NULL,
	[imagepath] [varchar](250) NULL,
	[ordval_Assessment] [int] NULL,
	[ordval_Training] [int] NULL,
	[ordval_CentralAdmin] [int] NULL,
	[ModuleId] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_AM_ModuleId] PRIMARY KEY CLUSTERED 
(
	[ModuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MAP_Userroles]    Script Date: 9/10/2020 2:38:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAP_Userroles](
	[ID] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Applicationid] [tinyint] NOT NULL,
	[Privilegetype] [char](1) NOT NULL,
	[Privilegerole] [int] NOT NULL,
	[LevelId] [tinyint] NULL,
	[CountryId] [int] NULL,
	[ZoneId] [int] NULL,
	[HubId] [int] NULL,
	[TCId] [int] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_UR_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mergetest]    Script Date: 9/10/2020 2:38:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mergetest](
	[REC_ID] [int] NOT NULL,
	[MPR_ID] [int] NOT NULL,
	[REMARKS] [varchar](8000) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Rwid] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MIS_Frag_Tables]    Script Date: 9/10/2020 2:38:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MIS_Frag_Tables](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](400) NULL,
	[Frag_count] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MRPLogin]    Script Date: 9/10/2020 2:38:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MRPLogin](
	[Userid] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[Mailid] [nvarchar](100) NULL,
	[statusid] [int] NULL,
 CONSTRAINT [PK_Userid] PRIMARY KEY CLUSTERED 
(
	[Userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mrplogintemp]    Script Date: 9/10/2020 2:38:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mrplogintemp](
	[Userid] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[Mailid] [nvarchar](100) NULL,
	[statusid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MVCDemo_Roles]    Script Date: 9/10/2020 2:38:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MVCDemo_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MVCDemo_UserLogin]    Script Date: 9/10/2020 2:38:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MVCDemo_UserLogin](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[PWD] [varchar](100) NOT NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[RoleId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OLD_SDPS_Pro]    Script Date: 9/10/2020 2:38:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLD_SDPS_Pro](
	[Employee code] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[Target] [float] NULL,
	[Achieved] [float] NULL,
	[Percen] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[P_Footprint]    Script Date: 9/10/2020 2:38:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[P_Footprint](
	[Date] [datetime] NULL,
	[NTUSername] [nvarchar](255) NULL,
	[Target] [float] NULL,
	[Achieved] [float] NULL,
	[Achival] [float] NULL,
	[Type] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pay1]    Script Date: 9/10/2020 2:38:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pay1](
	[EMPCODE] [varchar](50) NULL,
	[PF_NUMBER] [varchar](50) NULL,
	[ESI_NUMBER] [varchar](50) NULL,
	[BANK_NAME] [varchar](50) NULL,
	[BANKACC_NUMBER] [varchar](50) NULL,
	[BASICPAY] [varchar](50) NULL,
	[HRA] [varchar](50) NULL,
	[CA] [varchar](50) NULL,
	[SDA] [varchar](50) NULL,
	[SA] [varchar](50) NULL,
	[GROSS_PM] [varchar](50) NULL,
	[PF_EMPLOYEE_PM] [varchar](50) NULL,
	[ESI_EMPLOYEE_PM] [varchar](50) NULL,
	[PF_TAX] [varchar](50) NULL,
	[   LOP   ] [varchar](50) NULL,
	[LWF] [varchar](50) NULL,
	[NS_A] [varchar](50) NULL,
	[REF_BONUS] [varchar](50) NULL,
	[MEDICAL_REIM_PM] [varchar](50) NULL,
	[JOINING_BONUS] [varchar](50) NULL,
	[INCENTIVE] [varchar](50) NULL,
	[EARNED_LEAVE] [varchar](50) NULL,
	[GROSS_PA] [varchar](50) NULL,
	[BONUS_PA] [varchar](50) NULL,
	[GRATUITY_PA] [varchar](50) NULL,
	[PF_EMPLOYER_PA] [varchar](50) NULL,
	[ESI_EMPLOYER_PA] [varchar](50) NULL,
	[MEDICAL_REIM_PA] [varchar](50) NULL,
	[CTC_PA] [varchar](50) NULL,
	[DAYS_PAID] [varchar](50) NULL,
	[LOP_DAYS] [varchar](50) NULL,
	[INS] [varchar](50) NULL,
	[CREATED_BY] [varchar](50) NULL,
	[CREATED_DT] [varchar](50) NULL,
	[INCOME_TAX] [varchar](50) NULL,
	[DOJ] [varchar](50) NULL,
	[Other Deductions] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PP_RE]    Script Date: 9/10/2020 2:38:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PP_RE](
	[Employee code] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[Target] [float] NULL,
	[Achieved] [float] NULL,
	[Archi] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rew1]    Script Date: 9/10/2020 2:38:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rew1](
	[NT login] [nvarchar](255) NULL,
	[Employee ID] [nvarchar](255) NULL,
	[Target ] [float] NULL,
	[Achieved] [float] NULL,
	[Date] [datetime] NULL,
	[perc] [numeric](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reward_DEC_2014]    Script Date: 9/10/2020 2:38:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reward_DEC_2014](
	[Name] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[Target] [float] NULL,
	[Achived] [float] NULL,
	[Percen] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RewardNov]    Script Date: 9/10/2020 2:38:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RewardNov](
	[NT login] [nvarchar](255) NULL,
	[Employee ID] [nvarchar](255) NULL,
	[Target ] [float] NULL,
	[Achieved] [float] NULL,
	[Date] [datetime] NULL,
	[Perc] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_AccessPrivilage]    Script Date: 9/10/2020 2:38:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_AccessPrivilage](
	[RRId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[NTUserName] [varchar](500) NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [varchar](250) NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Appreciation]    Script Date: 9/10/2020 2:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Appreciation](
	[AppId] [int] IDENTITY(1,1) NOT NULL,
	[Awardid] [int] NULL,
	[Comments] [varchar](500) NULL,
	[StatusId] [tinyint] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[ApprovedBy] [int] NULL,
	[Approvedon] [datetime] NULL,
	[ApprovedStatus] [tinyint] NULL,
	[ApprovedComments] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Appreciation_Users]    Script Date: 9/10/2020 2:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Appreciation_Users](
	[RRAId] [int] IDENTITY(1,1) NOT NULL,
	[AppId] [int] NULL,
	[NT_USERNAME] [varchar](100) NULL,
	[StatusId] [tinyint] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Award_Master]    Script Date: 9/10/2020 2:39:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Award_Master](
	[AwardId] [int] IDENTITY(1,1) NOT NULL,
	[AwardName] [varchar](100) NULL,
	[Userid] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[Statusid] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_CRITERA_MASTER]    Script Date: 9/10/2020 2:39:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_CRITERA_MASTER](
	[CID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [varchar](250) NULL,
	[NDESCRIPTION] [nvarchar](500) NULL,
	[POINTS] [int] NULL,
	[STATUS] [tinyint] NULL,
	[CREATEDBY] [int] NULL,
	[CREATEDON] [datetime] NULL,
	[StartRange] [numeric](18, 2) NULL,
	[EndRange] [numeric](18, 2) NULL,
	[Feeds] [varchar](200) NULL,
 CONSTRAINT [RR_CM_CID] PRIMARY KEY CLUSTERED 
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Feedback]    Script Date: 9/10/2020 2:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Feedback](
	[FBId] [int] IDENTITY(1,1) NOT NULL,
	[Feedback] [varchar](1000) NULL,
	[Userid] [int] NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_LeagueLevel]    Script Date: 9/10/2020 2:39:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_LeagueLevel](
	[LLId] [int] IDENTITY(1,1) NOT NULL,
	[League] [nvarchar](30) NULL,
	[Priority] [tinyint] NULL,
	[StartPoint] [int] NULL,
	[EndPpoint] [int] NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [RR_LLID] PRIMARY KEY CLUSTERED 
(
	[LLId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_PD]    Script Date: 9/10/2020 2:39:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_PD](
	[Pid] [float] NULL,
	[LLID] [float] NULL,
	[ProductName] [nvarchar](255) NULL,
	[PPath] [nvarchar](255) NULL,
	[PCost] [float] NULL,
	[PurchasePoint] [float] NULL,
	[Status] [float] NULL,
	[Createdby] [float] NULL,
	[CreatedOn] [datetime] NULL,
	[AboutProduct] [nvarchar](255) NULL,
	[RewardPath] [nvarchar](255) NULL,
	[RewardGiftPath] [nvarchar](255) NULL,
	[ImageType] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Po]    Script Date: 9/10/2020 2:39:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Po](
	[50000] [nvarchar](255) NULL,
	[F2] [float] NULL,
	[F3] [float] NULL,
	[F4] [float] NULL,
	[F5] [nvarchar](255) NULL,
	[F6] [float] NULL,
	[F7] [float] NULL,
	[F8] [float] NULL,
	[F9] [nvarchar](255) NULL,
	[F10] [float] NULL,
	[F11] [float] NULL,
	[F12] [float] NULL,
	[F13] [nvarchar](255) NULL,
	[F14] [nvarchar](255) NULL,
	[F15] [nvarchar](255) NULL,
	[F16] [nvarchar](255) NULL,
	[F17] [nvarchar](255) NULL,
	[F18] [nvarchar](255) NULL,
	[F19] [nvarchar](255) NULL,
	[F20] [nvarchar](255) NULL,
	[F21] [nvarchar](255) NULL,
	[F22] [nvarchar](255) NULL,
	[F23] [nvarchar](255) NULL,
	[F24] [nvarchar](255) NULL,
	[F25] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Product_Details]    Script Date: 9/10/2020 2:39:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Product_Details](
	[Pid] [int] IDENTITY(1,1) NOT NULL,
	[LLID] [tinyint] NULL,
	[ProductName] [nvarchar](100) NULL,
	[PPath] [nvarchar](250) NULL,
	[PCost] [int] NULL,
	[PurchasePoint] [int] NULL,
	[Status] [tinyint] NULL,
	[Createdby] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[AboutProduct] [varchar](1000) NULL,
	[RewardPath] [nvarchar](500) NULL,
	[RewardGiftPath] [nvarchar](500) NULL,
	[ImageType] [tinyint] NULL,
	[AchPurchasePoint] [int] NULL,
 CONSTRAINT [RR_PID] PRIMARY KEY CLUSTERED 
(
	[Pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Production_Quality_Associate_Wise]    Script Date: 9/10/2020 2:39:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Production_Quality_Associate_Wise](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventDate] [date] NULL,
	[Customerid] [int] NULL,
	[Userid] [int] NULL,
	[Achived] [numeric](18, 2) NULL,
	[Resulttype] [tinyint] NULL,
	[Status] [tinyint] NULL,
	[CreatedOn] [datetime] NULL,
	[AppType] [tinyint] NULL,
 CONSTRAINT [PQAW_ID] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Production_Quality_Associate_Wise_08022014]    Script Date: 9/10/2020 2:39:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Production_Quality_Associate_Wise_08022014](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventDate] [date] NULL,
	[Customerid] [int] NULL,
	[Userid] [int] NULL,
	[Achived] [numeric](18, 2) NULL,
	[Resulttype] [tinyint] NULL,
	[Status] [tinyint] NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Production_Quality_Associate_Wise_newflow]    Script Date: 9/10/2020 2:39:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Production_Quality_Associate_Wise_newflow](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventDate] [date] NULL,
	[Customerid] [int] NULL,
	[Userid] [int] NULL,
	[Achived] [numeric](18, 2) NULL,
	[Resulttype] [tinyint] NULL,
	[Status] [tinyint] NULL,
	[CreatedOn] [datetime] NULL,
	[AppType] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Production_Quality_Associate_Wise_oldflow]    Script Date: 9/10/2020 2:39:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Production_Quality_Associate_Wise_oldflow](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventDate] [date] NULL,
	[Customerid] [int] NULL,
	[Userid] [int] NULL,
	[Achived] [numeric](18, 2) NULL,
	[Resulttype] [tinyint] NULL,
	[Status] [tinyint] NULL,
	[CreatedOn] [datetime] NULL,
	[AppType] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Quality_Audit]    Script Date: 9/10/2020 2:39:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Quality_Audit](
	[QAid] [int] IDENTITY(1,1) NOT NULL,
	[Empcode] [varchar](10) NULL,
	[Type] [tinyint] NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_RR_PQID] PRIMARY KEY CLUSTERED 
(
	[QAid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Reward_Dec2014]    Script Date: 9/10/2020 2:39:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Reward_Dec2014](
	[NT login] [nvarchar](255) NULL,
	[Employee ID] [nvarchar](255) NULL,
	[Target ] [float] NULL,
	[Achieved] [float] NULL,
	[Date] [datetime] NULL,
	[Perc] [float] NULL,
	[statusid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_Rules]    Script Date: 9/10/2020 2:39:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_Rules](
	[Ruleid] [int] IDENTITY(1,1) NOT NULL,
	[Rules] [varchar](max) NULL,
	[Status] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[Updateon] [datetime] NULL,
 CONSTRAINT [RR_ruleid] PRIMARY KEY CLUSTERED 
(
	[Ruleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_SCOREBOARD]    Script Date: 9/10/2020 2:39:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_SCOREBOARD](
	[Scoreid] [int] IDENTITY(1,1) NOT NULL,
	[Userid] [int] NULL,
	[CID] [int] NULL,
	[Points] [int] NULL,
	[Status] [tinyint] NULL,
	[CreatedOn] [datetime] NULL,
	[ReferenceInfo] [varchar](1000) NULL,
	[ReferenceId] [int] NULL,
	[ReasontoReduce] [varchar](500) NULL,
	[ModifiedOn] [datetime] NULL,
	[AccDate] [datetime] NULL,
 CONSTRAINT [PK_Scoreid] PRIMARY KEY CLUSTERED 
(
	[Scoreid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_ScoreBoard_Archive]    Script Date: 9/10/2020 2:39:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_ScoreBoard_Archive](
	[ArchiveId] [int] IDENTITY(1,1) NOT NULL,
	[Scoreid] [int] NULL,
	[Userid] [int] NULL,
	[CID] [int] NULL,
	[Points] [int] NULL,
	[Status] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ReferenceInfo] [nvarchar](1000) NULL,
	[ReferenceId] [int] NULL,
	[ReasontoReduce] [nvarchar](500) NULL,
	[ModifiedOn] [datetime] NULL,
	[TriggerOn] [datetime] NULL,
	[TriggetType] [tinyint] NULL,
 CONSTRAINT [PK_ArchiveId] PRIMARY KEY CLUSTERED 
(
	[ArchiveId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_SCOREBOARD_PURCHASE]    Script Date: 9/10/2020 2:39:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_SCOREBOARD_PURCHASE](
	[Pchid] [int] IDENTITY(1,1) NOT NULL,
	[Userid] [int] NULL,
	[PId] [int] NULL,
	[Purchased] [tinyint] NULL,
	[RequestedOn] [datetime] NULL,
	[PurchasedOn] [datetime] NULL,
	[Updatedby] [int] NULL,
	[PurchaseStatus] [tinyint] NULL,
 CONSTRAINT [RR_PCHID] PRIMARY KEY CLUSTERED 
(
	[Pchid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_SCOREBOARD_PURCHASE_backup]    Script Date: 9/10/2020 2:39:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_SCOREBOARD_PURCHASE_backup](
	[Pchid] [int] IDENTITY(1,1) NOT NULL,
	[Userid] [int] NULL,
	[PId] [int] NULL,
	[Purchased] [tinyint] NULL,
	[RequestedOn] [datetime] NULL,
	[PurchasedOn] [datetime] NULL,
	[Updatedby] [int] NULL,
	[PurchaseStatus] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RR_WaterTown_PQ]    Script Date: 9/10/2020 2:39:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RR_WaterTown_PQ](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventDate] [date] NULL,
	[NT_UserName] [varchar](100) NULL,
	[TargetSample] [int] NULL,
	[AchError] [int] NULL,
	[Value] [numeric](18, 2) NULL,
	[Status] [tinyint] NULL,
	[CreatedOn] [datetime] NULL,
	[Type] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[safe_arc_rec_attendance]    Script Date: 9/10/2020 2:39:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[safe_arc_rec_attendance](
	[Aid] [int] IDENTITY(1,1) NOT NULL,
	[Userid] [int] NULL,
	[NT_UserName] [varchar](100) NULL,
	[Date] [date] NULL,
	[Shiftid] [tinyint] NULL,
	[LogOn] [datetime] NULL,
	[LogOut] [datetime] NULL,
	[TotalHrs] [numeric](18, 2) NULL,
	[WorkHours] [numeric](18, 2) NULL,
	[LockHrs] [numeric](18, 2) NULL,
	[LateIn] [numeric](18, 2) NULL,
	[LateOut] [numeric](18, 2) NULL,
	[Designid] [int] NULL,
	[Functionalityid] [int] NULL,
	[CreatedBy] [int] NULL,
	[Createdon] [datetime] NULL,
	[Shift_from] [time](7) NULL,
	[Shift_to] [time](7) NULL,
	[Verified_Present] [char](2) NULL,
	[Verified_By] [int] NULL,
	[Verified_Comments] [varchar](max) NULL,
	[Client_id] [int] NULL,
	[ActLogin] [datetime] NULL,
	[ActLogout] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sheet1$]    Script Date: 9/10/2020 2:39:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sheet1$](
	[EMPCODE] [nvarchar](255) NULL,
	[BANKACC_NUMBER] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shift4Att]    Script Date: 9/10/2020 2:39:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shift4Att](
	[Associate Name] [nvarchar](255) NULL,
	[Emp Code] [nvarchar](255) NULL,
	[Team] [nvarchar](255) NULL,
	[Profile] [nvarchar](255) NULL,
	[Athena ID] [nvarchar](255) NULL,
	[NT ID] [nvarchar](255) NULL,
	[Shift] [float] NULL,
	[3-Mar] [nvarchar](255) NULL,
	[4-Mar] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staffing_report_push]    Script Date: 9/10/2020 2:39:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staffing_report_push](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Payrolldate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Payrolldate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t1temp]    Script Date: 9/10/2020 2:39:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t1temp](
	[id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp]    Script Date: 9/10/2020 2:39:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp](
	[UserId] [int] NULL,
	[aid] [int] IDENTITY(1,1) NOT NULL,
	[dd] [date] NULL,
	[client_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp_Slip]    Script Date: 9/10/2020 2:39:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_Slip](
	[SLIP_ID] [int] IDENTITY(1,1) NOT NULL,
	[EMPCODE] [varchar](10) NULL,
	[PF_NUMBER] [varchar](200) NULL,
	[ESI_NUMBER] [varchar](200) NULL,
	[BANK_NAME] [varchar](500) NULL,
	[BANKACC_NUMBER] [varchar](200) NULL,
	[BASICPAY] [decimal](18, 2) NULL,
	[HRA] [decimal](18, 2) NULL,
	[CA] [decimal](18, 2) NULL,
	[SDA] [decimal](18, 2) NULL,
	[SA] [decimal](18, 2) NULL,
	[GROSS_PM] [decimal](18, 2) NULL,
	[PF_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[ESI_EMPLOYEE_PM] [decimal](18, 2) NULL,
	[PF_TAX] [decimal](18, 2) NULL,
	[LOP] [decimal](18, 2) NULL,
	[LWF] [decimal](18, 2) NULL,
	[NS_A] [decimal](18, 2) NULL,
	[REF_BONUS] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PM] [decimal](18, 2) NULL,
	[JOINING_BONUS] [decimal](18, 2) NULL,
	[INCENTIVE] [decimal](18, 2) NULL,
	[EARNED_LEAVE] [decimal](18, 2) NULL,
	[GROSS_PA] [decimal](18, 2) NULL,
	[BONUS_PA] [decimal](18, 2) NULL,
	[GRATUITY_PA] [decimal](18, 2) NULL,
	[PF_EMPLOYER_PA] [decimal](18, 2) NULL,
	[ESI_EMPLOYER_PA] [decimal](18, 2) NULL,
	[MEDICAL_REIM_PA] [decimal](18, 2) NULL,
	[CTC_PA] [decimal](18, 2) NULL,
	[DAYS_PAID] [numeric](6, 2) NULL,
	[LOP_DAYS] [numeric](6, 2) NULL,
	[INS] [decimal](18, 2) NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[INCOME_TAX] [decimal](18, 2) NULL,
	[DOJ] [datetime] NULL,
	[Other Deductions] [decimal](18, 2) NULL,
	[Designation_Id] [int] NULL,
	[UAN_NO] [varchar](50) NULL,
	[Userid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Temp1]    Script Date: 9/10/2020 2:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempARC_REC_Role]    Script Date: 9/10/2020 2:39:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempARC_REC_Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[FUNCTIONALITY_ID] [int] NOT NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[Status] [tinyint] NULL,
	[DefaultRole] [bit] NULL,
	[ModuleMenuId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempARC_REC_USER_INFO_pwdlog]    Script Date: 9/10/2020 2:39:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempARC_REC_USER_INFO_pwdlog](
	[USERID] [int] IDENTITY(1,1) NOT NULL,
	[FIRSTNAME] [varchar](50) NULL,
	[LASTNAME] [varchar](50) NULL,
	[NT_USERNAME] [varchar](75) NOT NULL,
	[DESIGNATION_ID] [int] NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[REC_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[REPORTING_TO] [varchar](75) NULL,
	[EMPCODE] [varchar](10) NULL,
	[ACTIVE] [int] NULL,
	[CLIENT_ID] [int] NULL,
	[DOJ] [date] NULL,
	[AHS_PRL] [varchar](1) NULL,
	[PreDoj] [date] NULL,
	[LastCustomerId] [int] NULL,
	[Password] [varchar](15) NULL,
	[EmailId] [varchar](75) NULL,
	[AccountType] [varchar](1) NULL,
	[ExtUser] [varchar](1) NULL,
	[UserName] [varchar](100) NULL,
	[FirstTrnDt] [datetime] NULL,
	[MIDDLENAME] [varchar](50) NULL,
	[OldEmpCode] [varchar](10) NULL,
	[LocationID] [int] NULL,
	[Password1] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempAthenaManilaUsersVimal2]    Script Date: 9/10/2020 2:39:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempAthenaManilaUsersVimal2](
	[empcode] [varchar](7) NOT NULL,
	[status] [varchar](9) NOT NULL,
	[ahsathenaname] [varchar](16) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempAthenaUsers]    Script Date: 9/10/2020 2:39:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempAthenaUsers](
	[USERID] [int] IDENTITY(1,1) NOT NULL,
	[FIRSTNAME] [varchar](50) NULL,
	[LASTNAME] [varchar](50) NULL,
	[NT_USERNAME] [varchar](75) NOT NULL,
	[DESIGNATION_ID] [int] NULL,
	[FUNCTIONALITY_ID] [int] NULL,
	[REC_ID] [int] NULL,
	[CREATED_BY] [int] NULL,
	[CREATED_DT] [datetime] NULL,
	[REPORTING_TO] [varchar](75) NULL,
	[EMPCODE] [varchar](10) NULL,
	[ACTIVE] [int] NULL,
	[CLIENT_ID] [int] NULL,
	[DOJ] [date] NULL,
	[AHS_PRL] [varchar](1) NULL,
	[PreDoj] [date] NULL,
	[LastCustomerId] [int] NULL,
	[EmailId] [varchar](75) NULL,
	[AccountType] [varchar](1) NULL,
	[ExtUser] [varchar](1) NULL,
	[UserName] [varchar](100) NULL,
	[FirstTrnDt] [datetime] NULL,
	[MIDDLENAME] [varchar](50) NULL,
	[OldEmpCode] [varchar](10) NULL,
	[LocationID] [int] NULL,
	[Password1] [varchar](100) NULL,
	[Password] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempAthenaUsersVimal]    Script Date: 9/10/2020 2:39:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempAthenaUsersVimal](
	[sno] [int] NOT NULL,
	[athenaname] [varchar](17) NULL,
	[location] [varchar](7) NULL,
	[status] [varchar](10) NULL,
	[UserId] [int] NULL,
	[doj] [date] NULL,
	[nt_username] [varchar](75) NULL,
	[empcode] [varchar](75) NULL,
	[arc_active] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempAthenaUsersVimal2]    Script Date: 9/10/2020 2:39:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempAthenaUsersVimal2](
	[sno] [int] NOT NULL,
	[location] [varchar](7) NOT NULL,
	[empcode] [varchar](7) NOT NULL,
	[ntname] [varchar](16) NOT NULL,
	[status] [varchar](100) NULL,
	[userid] [int] NULL,
	[ahsAthenaName] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempAthenaUsersVimalManila]    Script Date: 9/10/2020 2:39:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempAthenaUsersVimalManila](
	[sno] [int] NOT NULL,
	[athenaname] [varchar](16) NOT NULL,
	[doj] [varchar](11) NOT NULL,
	[nt_username] [varchar](15) NOT NULL,
	[empcode] [varchar](7) NOT NULL,
	[arc_Active] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempCDSIssueUsers]    Script Date: 9/10/2020 2:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempCDSIssueUsers](
	[UserId] [int] NULL,
	[NT_UserName] [varchar](75) NULL,
	[EmpCode] [varchar](20) NULL,
	[AthenaUserName] [varchar](75) NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[QADumpUserId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempcompopening]    Script Date: 9/10/2020 2:39:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempcompopening](
	[compopening] [numeric](38, 2) NULL,
	[Userid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempcounty]    Script Date: 9/10/2020 2:39:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempcounty](
	[zip] [varchar](10) NULL,
	[county] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempCustomerTransfer]    Script Date: 9/10/2020 2:39:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempCustomerTransfer](
	[Userid] [int] NULL,
	[Client_id] [int] NULL,
	[PreClientId] [int] NULL,
	[PreDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempmediclaim]    Script Date: 9/10/2020 2:39:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempmediclaim](
	[MId] [float] NULL,
	[EMPCODE] [nvarchar](255) NULL,
	[D1Name] [nvarchar](255) NULL,
	[D1DOB] [datetime] NULL,
	[D2Name] [nvarchar](255) NULL,
	[D2DOB] [datetime] NULL,
	[D3Name] [nvarchar](255) NULL,
	[D3DOB] [nvarchar](255) NULL,
	[D4Name] [nvarchar](255) NULL,
	[D4DOB] [nvarchar](255) NULL,
	[D5Name] [nvarchar](255) NULL,
	[D5DOB] [nvarchar](255) NULL,
	[MaritalStatus] [nvarchar](255) NULL,
	[CREATED_BY] [float] NULL,
	[CREATED_DT] [datetime] NULL,
	[ACTIVE] [float] NULL,
	[REC_ID] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempOpeningLeaves2015]    Script Date: 9/10/2020 2:39:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempOpeningLeaves2015](
	[UserId] [int] NULL,
	[TypeId] [int] NULL,
	[Type_Text] [varchar](25) NULL,
	[Leaves] [decimal](15, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempOpeningLeaves2015Completed]    Script Date: 9/10/2020 2:39:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempOpeningLeaves2015Completed](
	[UserId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempScr]    Script Date: 9/10/2020 2:39:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempScr](
	[Action] [varchar](125) NULL,
	[RequestId] [int] NULL,
	[FunctionName] [varchar](100) NOT NULL,
	[CreateName] [varchar](101) NULL,
	[Description] [varchar](max) NULL,
	[ApprovedOn] [varchar](30) NULL,
	[Supervisor] [varchar](75) NULL,
	[Status] [varchar](30) NOT NULL,
	[AssignedTo] [varchar](75) NOT NULL,
	[StatusChangedBy] [varchar](75) NOT NULL,
	[StatusChangedOn] [varchar](30) NULL,
	[StatusComments] [varchar](8000) NULL,
	[DateOfCompletion] [varchar](30) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TexFin]    Script Date: 9/10/2020 2:39:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TexFin](
	[Date] [datetime] NULL,
	[NTUSername] [nvarchar](255) NULL,
	[Target] [float] NULL,
	[Achieved] [float] NULL,
	[Percentage] [float] NULL,
	[Type] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TM_Att_log]    Script Date: 9/10/2020 2:39:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TM_Att_log](
	[shiftid] [tinyint] NULL,
	[fromdate] [date] NULL,
	[NT_username] [varchar](100) NULL,
	[Actlogin] [datetime] NULL,
	[actlogout] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmpcompoff]    Script Date: 9/10/2020 2:39:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpcompoff](
	[EMP Name] [nvarchar](255) NULL,
	[EMP ID] [nvarchar](255) NULL,
	[Process] [nvarchar](255) NULL,
	[Month] [nvarchar](255) NULL,
	[Missing Dates] [datetime] NULL,
	[Comments] [nvarchar](255) NULL,
	[compoffcredit] [decimal](10, 2) NULL,
	[userid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmpSCRRamki]    Script Date: 9/10/2020 2:39:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmpSCRRamki](
	[reqid] [int] NOT NULL,
	[Productivty/Quality Gain] [varchar](193) NOT NULL,
	[status] [varchar](32) NOT NULL,
	[reqtype] [varchar](19) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ToOPChkManagerAddResult]    Script Date: 9/10/2020 2:39:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ToOPChkManagerAddResult](
	[USERID] [int] NULL,
	[NAME] [varchar](500) NULL,
	[REPORTING_TO] [varchar](300) NULL,
	[RESULT] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tt]    Script Date: 9/10/2020 2:39:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tt](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](5) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UL_Attendance]    Script Date: 9/10/2020 2:39:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UL_Attendance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserAccount] [varchar](100) NULL,
	[UserFullName] [varchar](100) NULL,
	[Shiftid] [int] NULL,
	[LoginDate] [datetime] NULL,
	[Logout] [datetime] NULL,
	[WMin] [int] NULL,
	[Whours] [numeric](18, 2) NULL,
	[HMin] [int] NULL,
	[Hhours] [numeric](18, 2) NULL,
	[FMin] [int] NULL,
	[Fhours] [numeric](18, 2) NULL,
	[Status] [tinyint] NULL,
	[Date] [date] NULL,
	[TriggerOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERDETAILS]    Script Date: 9/10/2020 2:39:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERDETAILS](
	[USERNAME] [varchar](100) NULL,
	[password] [varchar](100) NULL,
	[usertype] [varchar](10) NULL,
	[RwId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RwId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usstatestimedets]    Script Date: 9/10/2020 2:39:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usstatestimedets](
	[statename] [varchar](150) NULL,
	[statetimezone] [varchar](15) NULL,
	[frmutcdiff] [varchar](10) NULL,
	[stateid] [int] IDENTITY(1,1) NOT NULL,
	[StateDespri] [varchar](300) NULL,
	[statecode] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ZipcodeHeaderMaster]    Script Date: 9/10/2020 2:39:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZipcodeHeaderMaster](
	[Zip] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[AreaCode] [varchar](50) NULL,
	[County] [varchar](100) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AHC_AppLikeUsers] ADD  DEFAULT (getdate()) FOR [LikedOn]
GO
ALTER TABLE [dbo].[AHC_AppLikeUsers] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[AHC_JobApply] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AHC_JobRefer] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_APP_Privileges] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_APP_Privileges] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_APP_Privileges] ADD  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[ARC_BATCHIMPORT_BULKERROR] ADD  DEFAULT ('mail.recruit@accesshealthcare.co') FOR [FROM_MAILID]
GO
ALTER TABLE [dbo].[ARC_BATCHIMPORT_BULKERROR] ADD  DEFAULT ((0)) FOR [MAIL_STATUS]
GO
ALTER TABLE [dbo].[ARC_BATCHIMPORT_BULKERROR] ADD  DEFAULT ('N') FOR [ISHTML]
GO
ALTER TABLE [dbo].[ARC_BATCHIMPORT_BULKERROR] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_BATCHIMPORT_BULKERROR] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ARC_CBT_FEEDBACK_ENTRY] ADD  DEFAULT (getdate()) FOR [CREATEDON]
GO
ALTER TABLE [dbo].[ARC_CBT_FEEDBACK_INFO] ADD  DEFAULT (getdate()) FOR [CREATEDON]
GO
ALTER TABLE [dbo].[ARC_CBT_FEEDBACK_MASTER] ADD  DEFAULT (getdate()) FOR [CREATEDON]
GO
ALTER TABLE [dbo].[ARC_CBT_FEEDBACK_MASTER] ADD  DEFAULT (getdate()) FOR [MODIFIEDON]
GO
ALTER TABLE [dbo].[ARC_CLIENT_COLORCODE] ADD  DEFAULT (getdate()) FOR [Createdon]
GO
ALTER TABLE [dbo].[ARC_Enterprise_MenuDesignationRoles] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ARC_Enterprise_MenuRoles] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ARC_Enterprise_MenuRolesPermission] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ARC_Enterprise_MenuUserRoles] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ARC_Forum_Album] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_Album] ADD  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_Album] ADD  DEFAULT (getdate()) FOR [PubDate]
GO
ALTER TABLE [dbo].[ARC_Forum_Album_Gallery] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_Album_Gallery] ADD  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_Album_Gallery] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_Album_Gallery] ADD  DEFAULT ((0)) FOR [PhotoIndex]
GO
ALTER TABLE [dbo].[ARC_Forum_Album_Tag] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_Album_Tag] ADD  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_Album_Tag] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_FORUM_ERROR_LOGS] ADD  DEFAULT (getdate()) FOR [ERR_TIME]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Comment_Flags] ADD  DEFAULT (getdate()) FOR [ReportedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Comment_Flags] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Comment_Likes] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Comment_Likes] ADD  DEFAULT (getdate()) FOR [LikedOn]
GO
ALTER TABLE [dbo].[ARC_FORUM_LOUNGE_HIGHlIGHT] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_FORUM_LOUNGE_HIGHlIGHT] ADD  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Message_Comments] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Message_Flags] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Message_Likes] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Messages] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Messages] ADD  DEFAULT ((0)) FOR [Priority]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Messages] ADD  DEFAULT ((1)) FOR [Type]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Messages] ADD  DEFAULT ((0)) FOR [MsgId]
GO
ALTER TABLE [dbo].[ARC_Forum_Lounge_Messages_Archive] ADD  DEFAULT (getdate()) FOR [UpdateOn]
GO
ALTER TABLE [dbo].[ARC_FORUM_LOUNGE_RULEBOOK_LOGS] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[ARC_Forum_MessageBoard] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_MessageBoard] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_MessageBoard] ADD  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_MessageBoard] ADD  DEFAULT ('.UDH') FOR [Extension]
GO
ALTER TABLE [dbo].[ARC_Forum_MessageBoard] ADD  DEFAULT ((1)) FOR [FacilityType]
GO
ALTER TABLE [dbo].[ARC_Forum_MessageBoard] ADD  DEFAULT ('') FOR [InnerImage]
GO
ALTER TABLE [dbo].[ARC_Forum_MessageBoard_Archive] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_MessageBoard_Archive] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_MessageBoard_Archive] ADD  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[ARC_Forum_MessageBoard_Uploads] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_Polls] ADD  DEFAULT ((1)) FOR [STATUS]
GO
ALTER TABLE [dbo].[ARC_Forum_Polls] ADD  DEFAULT (getdate()) FOR [SCHEDULED_ON]
GO
ALTER TABLE [dbo].[ARC_Forum_Polls_Results] ADD  DEFAULT ((1)) FOR [STATUS]
GO
ALTER TABLE [dbo].[ARC_Forum_User_Ideas] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_Forum_User_Ideas] ADD  DEFAULT ((0)) FOR [FunctionalityId]
GO
ALTER TABLE [dbo].[ARC_KIN_USER_RIGHTS] ADD  DEFAULT ((1)) FOR [CREATEDBY]
GO
ALTER TABLE [dbo].[ARC_KIN_USER_RIGHTS] ADD  DEFAULT (getdate()) FOR [CREATEDDT]
GO
ALTER TABLE [dbo].[ARC_Lounge_Admin] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_LOUNGE_BAN] ADD  DEFAULT (getdate()) FOR [BLOCKEDON]
GO
ALTER TABLE [dbo].[ARC_LOUNGE_BAN] ADD  DEFAULT ((1)) FOR [STATUS]
GO
ALTER TABLE [dbo].[ARC_Lounge_Message_Filter] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_ME_ABSCOND] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_ME_DISCRIPENCY_TRAN] ADD  DEFAULT ((0)) FOR [IsDeclaredOff]
GO
ALTER TABLE [dbo].[ARC_ME_DISCRIPENCY_TRAN] ADD  DEFAULT ((0)) FOR [CompOffEligible]
GO
ALTER TABLE [dbo].[ARC_ME_DISCRIPENCY_TRAN] ADD  DEFAULT ((0)) FOR [OTEligible]
GO
ALTER TABLE [dbo].[ARC_ME_DISCRIPENCY_TYPEINFO] ADD  DEFAULT ((1)) FOR [ACTIVE]
GO
ALTER TABLE [dbo].[ARC_ME_EXIT] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_ME_EXIT] ADD  DEFAULT ((0)) FOR [DEACTIVATED_BY]
GO
ALTER TABLE [dbo].[ARC_ME_EXIT_CHECKLIST_INFO] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_ME_EXIT_CHKLIST_ACCESS] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_ME_EXIT_STATUS_TRAN] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_ME_HR_ACCESS] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_ME_PAYROLL] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_ME_TERMINATE] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_ME_VISITOR] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_ME_VISITOR] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ARC_ME_VISITOR_ACCESS] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_MeExitAckMails] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ARC_REC_APPLICANT_STATUS_FB] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_APPLICANT_STATUS_FB] ADD  DEFAULT ((1)) FOR [STATUS_ID]
GO
ALTER TABLE [dbo].[ARC_REC_ASSESSMENT] ADD  CONSTRAINT [DF__ARC_REC_A__CREAT__46E78A0C]  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_ASSESSMENT_SCHEDULED] ADD  DEFAULT ((0)) FOR [SC_STATUS]
GO
ALTER TABLE [dbo].[ARC_REC_ASSESSMENT_SCHEDULED] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance] ADD  DEFAULT ((0)) FOR [Verified_By]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance] ADD  DEFAULT ((0)) FOR [Client_id]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance] ADD  DEFAULT ((0)) FOR [P_days]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance] ADD  DEFAULT ((0)) FOR [CompOffEligible]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance] ADD  DEFAULT ((0)) FOR [IsDeclaredOff]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance] ADD  DEFAULT ((0)) FOR [OTEligible]
GO
ALTER TABLE [dbo].[ARC_REC_ATTENDANCE_ACCESS] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_ATTENDANCE_ACCESS] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance_Archive] ADD  DEFAULT ((0)) FOR [Verified_By]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance_Archive] ADD  DEFAULT ((0)) FOR [Client_id]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance_Archive] ADD  DEFAULT ((0)) FOR [P_days]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance_Archive] ADD  DEFAULT ((0)) FOR [CompOffEligible]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance_Archive] ADD  DEFAULT ((0)) FOR [IsDeclaredOff]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance_Archive] ADD  DEFAULT ((0)) FOR [OTEligible]
GO
ALTER TABLE [dbo].[ARC_REC_Attendance_Archive] ADD  DEFAULT (getdate()) FOR [ALterOn]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIATE_PROFILE] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIATE_PROFILE] ADD  DEFAULT ((0)) FOR [FUNCTIONALITY_ID]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIATE_PROFILE] ADD  DEFAULT (getdate()) FOR [UPDATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIATE_PROFILE_LOG] ADD  DEFAULT ((0)) FOR [FUNCTIONALITY_ID]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIATE_PROFILE_LOG] ADD  DEFAULT (getdate()) FOR [UPDATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIDATE] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIDATE] ADD  DEFAULT ((0)) FOR [APPLY_FB]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIDATE] ADD  DEFAULT ((1)) FOR [RegByAHS]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIDATE] ADD  CONSTRAINT [df_DefaultTest_NotNull]  DEFAULT ((1)) FOR [LocationID]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIDATE_DOC_STATUS] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIDATE_EDUCATION] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIDATE_STATUS] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIDATE_STATUS] ADD  DEFAULT ((1)) FOR [STATUS_ID]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIDATE_STATUS] ADD  DEFAULT ((0)) FOR [SCHEDULE_ID]
GO
ALTER TABLE [dbo].[ARC_REC_CANDIDATE_WORKEXP] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_CAPMAN] ADD  DEFAULT ((0)) FOR [ShiftId]
GO
ALTER TABLE [dbo].[ARC_REC_CAPMAN] ADD  DEFAULT ((0)) FOR [FunctionalityId]
GO
ALTER TABLE [dbo].[Arc_Rec_CapmanAccess] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Arc_Rec_CapmanAccess] ADD  DEFAULT (getdate()) FOR [Createddate]
GO
ALTER TABLE [dbo].[ARC_REC_CLOSED] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_ErrorLog] ADD  DEFAULT (getdate()) FOR [CreatedDt]
GO
ALTER TABLE [dbo].[ARC_REC_ErrorLog] ADD  DEFAULT ('Error') FOR [EventType]
GO
ALTER TABLE [dbo].[ARC_REC_EXPERIENCE_INFO] ADD  DEFAULT ((1)) FOR [ACTIVE]
GO
ALTER TABLE [dbo].[ARC_REC_FootballCountries] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_REC_HeldNotJoined] ADD  DEFAULT ((0)) FOR [ReleasedBy]
GO
ALTER TABLE [dbo].[ARC_REC_IDWRAPPER] ADD  DEFAULT ((0)) FOR [VALUE]
GO
ALTER TABLE [dbo].[ARC_REC_ITREQUEST] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_REC_ITREQUEST] ADD  DEFAULT ((1)) FOR [RequestStatus]
GO
ALTER TABLE [dbo].[ARC_REC_ITREQUEST_APPROVE] ADD  DEFAULT ((1)) FOR [STATUS]
GO
ALTER TABLE [dbo].[ARC_REC_ITREQUEST_APPROVE] ADD  DEFAULT (getdate()) FOR [CREATED_DATE]
GO
ALTER TABLE [dbo].[ARC_REC_ITREQUEST_ATTACHMENT] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_REC_ITREQUEST_HISTORY] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_REC_ITREQUEST_HISTORY] ADD  DEFAULT (getdate()) FOR [HistoryOn]
GO
ALTER TABLE [dbo].[ARC_REC_ITREQUEST_ITLIST] ADD  DEFAULT (getdate()) FOR [CREATEDON]
GO
ALTER TABLE [dbo].[ARC_REC_ITREQUEST_SCHEDULE] ADD  DEFAULT (getdate()) FOR [CREATEDDATE]
GO
ALTER TABLE [dbo].[ARC_REC_ITREQUEST_STATUS] ADD  DEFAULT ((1)) FOR [STATUS]
GO
ALTER TABLE [dbo].[ARC_REC_ITRequestStatusTran] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_REC_KYC_Proofs] ADD  CONSTRAINT [DF_ARC_REC_KYC_Proofs_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ARC_REC_LEAVE_FORWARD] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_LEAVE_HOLIDAYLIST] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_LEAVE_OPENING] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_LEAVE_REQUEST] ADD  DEFAULT ((0)) FOR [LEAVE_STATUS]
GO
ALTER TABLE [dbo].[ARC_REC_LEAVE_REQUEST] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_LEAVE_REQUEST] ADD  DEFAULT ('Y') FOR [ACTIVE]
GO
ALTER TABLE [dbo].[ARC_REC_LEAVE_TRAN] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_LEAVE_TYPES] ADD  DEFAULT ((0)) FOR [DISPLAY_ORDER]
GO
ALTER TABLE [dbo].[ARC_REC_LegalDocument] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_REC_LocationMaster] ADD  CONSTRAINT [DF_MIS_CityMaster_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ARC_REC_MAIL_TRAN] ADD  DEFAULT ('mail.recruit@accesshealthcare.co') FOR [FROM_MAILID]
GO
ALTER TABLE [dbo].[ARC_REC_MAIL_TRAN] ADD  DEFAULT ((0)) FOR [MAIL_STATUS]
GO
ALTER TABLE [dbo].[ARC_REC_MAIL_TRAN] ADD  DEFAULT ('N') FOR [ISHTML]
GO
ALTER TABLE [dbo].[ARC_REC_MAIL_TRAN] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_MAIL_TRAN] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ARC_REC_POSTALCODE] ADD  DEFAULT ((1)) FOR [CREATEDBY]
GO
ALTER TABLE [dbo].[ARC_REC_POSTALCODE] ADD  DEFAULT (getdate()) FOR [CREATEDON]
GO
ALTER TABLE [dbo].[ARC_REC_PROCESS_INFO] ADD  DEFAULT ((1)) FOR [ACTIVE]
GO
ALTER TABLE [dbo].[ARC_Rec_ProductionQT] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_REC_Proximity] ADD  CONSTRAINT [DF__ARC_REC_P__CREAT__6874FD0E]  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_Role] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_Role] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_REC_Role] ADD  DEFAULT ((0)) FOR [DefaultRole]
GO
ALTER TABLE [dbo].[ARC_REC_Role_20190211] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_Role_20190211] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ARC_REC_Role_20190211] ADD  DEFAULT ((0)) FOR [DefaultRole]
GO
ALTER TABLE [dbo].[ARC_REC_RoleAccess] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ARC_REC_RoleLog] ADD  DEFAULT ((0)) FOR [DefaultRole]
GO
ALTER TABLE [dbo].[ARC_REC_RoleTran] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_SALARY_BREAKUP] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_SALARY_SLIP] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_SALARY_SLIP_LOG] ADD  DEFAULT ((0)) FOR [Designation_Id]
GO
ALTER TABLE [dbo].[ARC_REC_SALARY_SLIP_TRAN] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_SALARY_SLIP_TRAN] ADD  DEFAULT ((0)) FOR [Designation_Id]
GO
ALTER TABLE [dbo].[ARC_REC_SALARY_SLIP_TRAN] ADD  DEFAULT (CONVERT([date],getdate(),0)) FOR [Uploaded_dt]
GO
ALTER TABLE [dbo].[ARC_REC_SELF_ATTENDANCE] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_SHIFT_TRAN] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_SOFTCONTROL] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_StaffingReport_MasterData] ADD  CONSTRAINT [DF_ARC_REC_StaffingReport_MasterData_Created_Dt]  DEFAULT (getdate()) FOR [Created_Dt]
GO
ALTER TABLE [dbo].[ARC_REC_STATE_INFO] ADD  DEFAULT ((1)) FOR [ACTIVE]
GO
ALTER TABLE [dbo].[ARC_REC_TDS_UPLOAD_TRAN] ADD  DEFAULT (CONVERT([date],getdate(),0)) FOR [Uploaded_dt]
GO
ALTER TABLE [dbo].[ARC_REC_TEST] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_TEST] ADD  DEFAULT ((0)) FOR [RESULT]
GO
ALTER TABLE [dbo].[ARC_REC_TEST] ADD  DEFAULT ((0)) FOR [SCORE]
GO
ALTER TABLE [dbo].[ARC_REC_TEST] ADD  DEFAULT ((0)) FOR [HAS_COMPLETED]
GO
ALTER TABLE [dbo].[ARC_REC_TEST_TRAN] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_TYPING_TEST] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_REC_TYPING_TEST] ADD  DEFAULT ((0)) FOR [HAS_COMPLETED]
GO
ALTER TABLE [dbo].[ARC_REC_USER_INFO] ADD  CONSTRAINT [DF__ARC_REC_U__SubFu__4E54BFD9]  DEFAULT ((0)) FOR [SubFunctionalityId]
GO
ALTER TABLE [dbo].[ARC_REC_USER_INFO] ADD  CONSTRAINT [DF__ARC_REC_U__Group__24FF3B39]  DEFAULT ((0)) FOR [GroupId]
GO
ALTER TABLE [dbo].[ARC_REC_USER_INFO] ADD  CONSTRAINT [DF__ARC_REC_U__SubGr__25F35F72]  DEFAULT ((0)) FOR [SubGroupId]
GO
ALTER TABLE [dbo].[ARC_REC_USER_INFO] ADD  CONSTRAINT [DF__ARC_REC_U__Costc__26E783AB]  DEFAULT ((0)) FOR [CostcodeId]
GO
ALTER TABLE [dbo].[ARC_REC_USER_INFO] ADD  CONSTRAINT [DF__ARC_REC_U__Proje__7AAAA568]  DEFAULT ((0)) FOR [ProjectID]
GO
ALTER TABLE [dbo].[ARC_REC_USER_INFO] ADD  CONSTRAINT [DF__ARC_REC_U__Essen__1D417D06]  DEFAULT ((0)) FOR [Essential_ID]
GO
ALTER TABLE [dbo].[ARC_REC_UserCustomerLog] ADD  DEFAULT ((0)) FOR [PrimaryCust]
GO
ALTER TABLE [dbo].[ARC_REC_UserRole] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[ARC_Setup_Menu] ADD  DEFAULT (getdate()) FOR [CreatedDt]
GO
ALTER TABLE [dbo].[ARC_Setup_Menu] ADD  DEFAULT ((0)) FOR [Boxno]
GO
ALTER TABLE [dbo].[ARC_Setup_Menu_20190211] ADD  DEFAULT (getdate()) FOR [CreatedDt]
GO
ALTER TABLE [dbo].[ARC_Setup_Menu_20190211] ADD  DEFAULT ((0)) FOR [Boxno]
GO
ALTER TABLE [dbo].[ARC_SwitchLogin] ADD  DEFAULT (getdate()) FOR [createddt]
GO
ALTER TABLE [dbo].[ARC_UnauthorisedAccess] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ARC_WheelsCabPickupLog] ADD  CONSTRAINT [DF_ARC_WheelsCabPickupLog_MODIFY_DT]  DEFAULT (getdate()) FOR [MODIFY_DT]
GO
ALTER TABLE [dbo].[Eye_Facility] ADD  DEFAULT ('Y') FOR [Active]
GO
ALTER TABLE [dbo].[Eye_Facility] ADD  DEFAULT (getdate()) FOR [CreatedDt]
GO
ALTER TABLE [dbo].[Eye_IPDetails] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[HD_CRITICAL_INFO] ADD  DEFAULT ('Y') FOR [ACTIVE]
GO
ALTER TABLE [dbo].[HD_CRITICAL_INFO] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[HD_ESCALATED_TICKETS] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[HD_ISSUE_INFO] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[HD_ISSUE_REQUEST] ADD  CONSTRAINT [DF__HD_ISSUE___CREAT__3F9B6DFF]  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[HD_ISSUE_REQUEST] ADD  DEFAULT ((0)) FOR [ISSUE_RATE]
GO
ALTER TABLE [dbo].[HD_ISSUE_REQUEST] ADD  DEFAULT ('Y') FOR [ACTIVE]
GO
ALTER TABLE [dbo].[HD_ISSUE_TRAN] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[HD_PROCESS_ACCESS] ADD  DEFAULT (getdate()) FOR [CREATED_DT]
GO
ALTER TABLE [dbo].[hr_MPR] ADD  DEFAULT ((0)) FOR [Published]
GO
ALTER TABLE [dbo].[hr_MPR] ADD  DEFAULT ((0)) FOR [PositionType]
GO
ALTER TABLE [dbo].[hr_MPR] ADD  DEFAULT ((0)) FOR [MprCancel]
GO
ALTER TABLE [dbo].[hr_MPR] ADD  DEFAULT (NULL) FOR [MprCancelComments]
GO
ALTER TABLE [dbo].[hr_MPR] ADD  DEFAULT ((0)) FOR [MDApprovalStatus]
GO
ALTER TABLE [dbo].[IndexRebulidDetails] ADD  DEFAULT ((0)) FOR [BFIndexFra]
GO
ALTER TABLE [dbo].[IndexRebulidDetails] ADD  DEFAULT ((0)) FOR [AFIndexFra]
GO
ALTER TABLE [dbo].[MRPLogin] ADD  DEFAULT ((1)) FOR [statusid]
GO
ALTER TABLE [dbo].[Rew1] ADD  DEFAULT ((0)) FOR [perc]
GO
ALTER TABLE [dbo].[RR_AccessPrivilage] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RR_Appreciation] ADD  DEFAULT ((0)) FOR [ApprovedStatus]
GO
ALTER TABLE [dbo].[RR_Appreciation] ADD  DEFAULT ('') FOR [ApprovedComments]
GO
ALTER TABLE [dbo].[RR_CRITERA_MASTER] ADD  CONSTRAINT [DF__RR_CRITER__CREAT__2CFF3185]  DEFAULT (getdate()) FOR [CREATEDON]
GO
ALTER TABLE [dbo].[RR_Production_Quality_Associate_Wise] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[RR_Production_Quality_Associate_Wise] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RR_Production_Quality_Associate_Wise] ADD  DEFAULT ((1)) FOR [AppType]
GO
ALTER TABLE [dbo].[RR_Quality_Audit] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[RR_Quality_Audit] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RR_Reward_Dec2014] ADD  DEFAULT ((0)) FOR [statusid]
GO
ALTER TABLE [dbo].[RR_Rules] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RR_SCOREBOARD] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[RR_SCOREBOARD] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RR_SCOREBOARD] ADD  DEFAULT ('') FOR [ReasontoReduce]
GO
ALTER TABLE [dbo].[RR_SCOREBOARD] ADD  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[RR_SCOREBOARD] ADD  DEFAULT (getdate()) FOR [AccDate]
GO
ALTER TABLE [dbo].[RR_ScoreBoard_Archive] ADD  DEFAULT (getdate()) FOR [TriggerOn]
GO
ALTER TABLE [dbo].[RR_ScoreBoard_Archive] ADD  DEFAULT ((1)) FOR [TriggetType]
GO
ALTER TABLE [dbo].[RR_SCOREBOARD_PURCHASE] ADD  DEFAULT ((0)) FOR [Purchased]
GO
ALTER TABLE [dbo].[RR_WaterTown_PQ] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[RR_WaterTown_PQ] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[UL_Attendance] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[UL_Attendance] ADD  DEFAULT (getdate()) FOR [TriggerOn]
GO
ALTER TABLE [dbo].[ARC_REC_CAPMAN]  WITH CHECK ADD  CONSTRAINT [FK_Bayid] FOREIGN KEY([BayId])
REFERENCES [dbo].[Eye_IPDetails] ([Id])
GO
ALTER TABLE [dbo].[ARC_REC_CAPMAN] CHECK CONSTRAINT [FK_Bayid]
GO
ALTER TABLE [dbo].[ARC_Rec_RecruitFormAccess]  WITH CHECK ADD FOREIGN KEY([FormId])
REFERENCES [dbo].[ARC_Rec_RecruitForm] ([FormId])
GO
ALTER TABLE [dbo].[HD_StationeryRequest]  WITH CHECK ADD  CONSTRAINT [FK__ARC_REC_S__ISS_R__4B399FE2] FOREIGN KEY([ISS_REQID])
REFERENCES [dbo].[HD_ISSUE_REQUEST] ([ISS_REQID])
GO
ALTER TABLE [dbo].[HD_StationeryRequest] CHECK CONSTRAINT [FK__ARC_REC_S__ISS_R__4B399FE2]
GO
/****** Object:  DdlTrigger [NON_DB_OWNER_ALTER_TABLE]    Script Date: 9/10/2020 2:39:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [NON_DB_OWNER_ALTER_TABLE]
ON DATABASE
FOR ALTER_TABLE
AS
-- If User executing Command is not in db_owner command, rollback the transaction
IF ISNULL((SELECT IS_MEMBER('db_owner')), 0) < 1
BEGIN
   DECLARE @Tablename NVARCHAR(256)
   -- Capture Table Name
   SELECT @Tablename = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(256)')

   RAISERROR('Cannot alter the table ''%s'', because you do not have permission.', 14, 20, @Tablename)
   ROLLBACK
END

GO
DISABLE TRIGGER [NON_DB_OWNER_ALTER_TABLE] ON DATABASE
GO
/****** Object:  DdlTrigger [NON_DB_Owner_Drop_Procudure]    Script Date: 9/10/2020 2:39:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [NON_DB_Owner_Drop_Procudure]          
ON DATABASE             
FOR DROP_PROCEDURE             
AS
IF ISNULL((SELECT IS_MEMBER('db_owner')), 0) < 1
BEGIN
   DECLARE @ObjectName NVARCHAR(256)
   -- Capture Table Name
   SELECT @ObjectName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(256)')

   RAISERROR('Cannot Drop the Procedures ''%s'', because you do not have permission.', 14, 20, @ObjectName)
   ROLLBACK
END

GO
DISABLE TRIGGER [NON_DB_Owner_Drop_Procudure] ON DATABASE
GO
ENABLE TRIGGER [NON_DB_OWNER_ALTER_TABLE] ON DATABASE
GO
ENABLE TRIGGER [NON_DB_Owner_Drop_Procudure] ON DATABASE
GO
