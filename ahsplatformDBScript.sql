USE [AhsPlatform]
GO
/****** Object:  Table [dbo].[C3_GroupNameInfo]    Script Date: 9/8/2020 11:18:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_GroupNameInfo](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[VendorID] [int] NOT NULL,
	[GroupName] [varchar](500) NOT NULL,
	[Department] [varchar](500) NULL,
	[Description] [varchar](600) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [varchar](150) NOT NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[ApiID] [varchar](100) NULL,
 CONSTRAINT [PK_C3_GroupNameInfo_GroupID] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_C3_GroupNameInfo_Project_GroupName] UNIQUE NONCLUSTERED 
(
	[VendorID] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_UserMaster]    Script Date: 9/8/2020 11:18:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_UserMaster](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[EmpCode] [varchar](150) NOT NULL,
	[NTUserName] [varchar](150) NOT NULL,
	[FirstName] [varchar](150) NOT NULL,
	[LastName] [varchar](150) NOT NULL,
	[Email] [varchar](300) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [varchar](150) NOT NULL,
	[CreatedOn] [datetime] NULL,
	[IsURLError] [tinyint] NULL,
	[DirectNo] [tinyint] NULL,
 CONSTRAINT [PK_C3_UserMaster_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_C3_UserMaster_EmpCode_NTUserName] UNIQUE NONCLUSTERED 
(
	[EmpCode] ASC,
	[NTUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_UserProfile]    Script Date: 9/8/2020 11:18:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_UserProfile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[VendorID] [int] NOT NULL,
	[CustomerID] [int] NULL,
	[GroupID] [int] NULL,
	[Extension] [int] NULL,
	[RoleID] [int] NULL,
	[DirectNumber] [varchar](150) NULL,
	[Department] [varchar](500) NULL,
	[ExternalId] [varchar](250) NULL,
	[Remarks] [varchar](500) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[DialerType] [int] NULL,
 CONSTRAINT [PK_C3_UserProfile_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_SchedulerUserStatus]    Script Date: 9/8/2020 11:18:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_SchedulerUserStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NTUserName] [varchar](150) NOT NULL,
	[ChangeType] [tinyint] NULL,
	[GroupName] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[IsRemove] [bit] NULL,
	[ScheduleStatus] [tinyint] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](150) NULL,
 CONSTRAINT [PK_C3_SchedulerUserStatus_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[C3_ADMN_SchedulerUserStatus_VY]    Script Date: 9/8/2020 11:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[C3_ADMN_SchedulerUserStatus_VY] AS 
SELECT US.ID,US.NTUserName,US.ChangeType,US.GroupName,US.IsActive,US.IsRemove
,UM.UserID,UM.Email,UM.FirstName,UM.LastName,UP.ExternalId
,UP.VendorID,GN.GroupID,UP.GroupID OldGroupID,UP.RoleID,UP.DialerType
FROM C3_SchedulerUserStatus(NOLOCK)US
INNER JOIN C3_UserMaster(NOLOCK)UM
ON US.NTUserName = UM.NTUserName
LEFT JOIN C3_GroupNameInfo(NOLOCK)GN
ON US.GroupName = GN.GroupName
INNER JOIN C3_UserProfile(NOLOCK)UP
ON UM.UserID = UP.UserID
WHERE US.ScheduleStatus = 0
GO
/****** Object:  Table [dbo].[C3_VendorMaster]    Script Date: 9/8/2020 11:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_VendorMaster](
	[VendorID] [int] IDENTITY(1,1) NOT NULL,
	[VendorName] [varchar](600) NOT NULL,
	[Description] [varchar](600) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [varchar](150) NOT NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_VendorMaster_VendorID] PRIMARY KEY CLUSTERED 
(
	[VendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_C3_VendorMaster_VendorName] UNIQUE NONCLUSTERED 
(
	[VendorName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_VendorRole]    Script Date: 9/8/2020 11:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_VendorRole](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[VendorID] [int] NOT NULL,
	[RoleName] [varchar](250) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [varchar](150) NOT NULL,
	[CreatedOn] [datetime] NULL,
	[ApiID] [varchar](100) NULL,
	[Description] [varchar](500) NULL,
	[uri] [varchar](700) NULL,
 CONSTRAINT [PK_C3_VendorRole_RoleID] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_C3_VendorRole_VendorID_RoleName] UNIQUE NONCLUSTERED 
(
	[VendorID] ASC,
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_USER_INFOVY]    Script Date: 9/8/2020 11:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_USER_INFOVY](
	[Userid] [float] NULL,
	[Associate] [nvarchar](255) NULL,
	[DOB] [nvarchar](255) NULL,
	[NT_UserName] [nvarchar](255) NULL,
	[Empcode] [nvarchar](255) NULL,
	[REPORTING_TO] [nvarchar](255) NULL,
	[DesigId] [float] NULL,
	[Designation] [nvarchar](255) NULL,
	[FunctionalityId] [float] NULL,
	[FunctionName] [nvarchar](255) NULL,
	[Client_Id] [float] NULL,
	[client_name] [nvarchar](255) NULL,
	[Rec_id] [float] NULL,
	[PROFILE_IMAGE_NAME] [nvarchar](255) NULL,
	[FIRSTNAME] [nvarchar](255) NULL,
	[LASTNAME] [nvarchar](255) NULL,
	[DOJ] [nvarchar](255) NULL,
	[MOBILE_NO] [float] NULL,
	[EMER_CONTACT_NO] [float] NULL,
	[PRE_LOCATION] [nvarchar](255) NULL,
	[EMAIL_ID] [nvarchar](255) NULL,
	[Associate_Email] [nvarchar](255) NULL,
	[Reportingto_Email] [nvarchar](255) NULL,
	[LocationID] [float] NULL,
	[Telephone_no] [nvarchar](255) NULL,
	[LocationName] [nvarchar](255) NULL,
	[LOB] [nvarchar](255) NULL,
	[LobID] [float] NULL,
	[CurrentShiftId] [float] NULL,
	[D_Band] [float] NULL,
	[D_Grade] [nvarchar](255) NULL,
	[VY_Gender] [nvarchar](255) NULL,
	[Location_SName] [nvarchar](255) NULL,
	[GroupId] [float] NULL,
	[GroupName] [nvarchar](255) NULL,
	[SubGroupID] [float] NULL,
	[SubGroupName] [nvarchar](255) NULL,
	[SubFunctionalityId] [float] NULL,
	[SubFunctionality] [nvarchar](255) NULL,
	[CostcodeId] [float] NULL,
	[Costcode] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_ADMN_DialerTypeMaster]    Script Date: 9/8/2020 11:18:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_ADMN_DialerTypeMaster](
	[DialerTypeID] [int] IDENTITY(1,1) NOT NULL,
	[DialerTypeName] [varchar](100) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_ADMN_DialerTypeMaster_DialerTypeID] PRIMARY KEY CLUSTERED 
(
	[DialerTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_C3_ADMN_DialerTypeMaster_DialerTypeName] UNIQUE NONCLUSTERED 
(
	[DialerTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[C3_ADMN_UserMasterList_VY]    Script Date: 9/8/2020 11:18:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[C3_ADMN_UserMasterList_VY] AS    
SELECT UM.EmpCode,UM.NTUserName,UM.Email, UI.client_name AS Client    
,UI.FunctionName AS Functionality, LocationName [Location]    
,VM.VendorName,VM.VendorID, VR.RoleName,GN.GroupName,UP.Department  
,UP.DialerType,DialerTypeName AS Dialer 
,up.ExternalId ,up.IsActive 
--,vm.VendorID,gn.GroupID,vr.RoleID  
FROM C3_UserMaster(NOLOCK)UM    
INNER JOIN /*ARC_REC.dbo.ARC_REC_USER_INFO_VY*/ARC_REC_USER_INFOVY(NOLOCK)UI    
ON UM.NTUserName = UI.NT_UserName    
INNER JOIN C3_UserProfile(NOLOCK)UP    
ON UM.UserID = UP.UserID    
INNER JOIN C3_VendorMaster(NOLOCK)VM    
ON UP.VendorID = VM.VendorID    
INNER JOIN C3_GroupNameInfo(NOLOCK)GN    
ON UP.GroupID = GN.GroupID    
INNER JOIN C3_VendorRole(NOLOCK)VR    
ON UP.RoleID = VR.RoleID 
LEFT JOIN C3_ADMN_DialerTypeMaster(NOLOCK)DTM
ON UP.DialerType = DTM.DialerTypeID
GO
/****** Object:  View [dbo].[C3_ADMN_VendorMasterList_VY]    Script Date: 9/8/2020 11:18:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[C3_ADMN_VendorMasterList_VY] AS
SELECT VendorID,VendorName,[Description]
FROM C3_VendorMaster(NOLOCK)
WHERE IsActive = 1
GO
/****** Object:  View [dbo].[C3_ADMN_GroupMasterList_VY]    Script Date: 9/8/2020 11:18:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[C3_ADMN_GroupMasterList_VY] AS
SELECT GroupID,GroupName,Department,[Description]
,VendorID 
FROM C3_GroupNameInfo(NOLOCK)
WHERE IsActive = 1
GO
/****** Object:  View [dbo].[C3_ADMN_RolesMasterList_VY]    Script Date: 9/8/2020 11:18:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[C3_ADMN_RolesMasterList_VY] AS 
SELECT RoleID,RoleName,ApiID,[Description]
,VendorID,uri 
FROM C3_VendorRole(NOLOCK)
WHERE IsActive = 1
GO
/****** Object:  View [dbo].[Arc_Ar_ClientMaster_View]    Script Date: 9/8/2020 11:18:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Arc_Ar_ClientMaster_View] 
AS  
SELECT CustomerID,0 as SubProvisionId,InternalClientName AS CustomerName,DBPrefix,FromTime,ToTime,DynamicAddTicket
,isnull(AuditModFormType,'Regular')  AuditModFormType,ISNULL(WorkingShift,'')WorkingShift,isnull(IsServiceBasedAuditMonform,'NO') IsServiceBasedAuditMonform
FROM [arc_ar_v2].dbo.ARC_AR_ClientMaster a
WHERE Status=1 and LiveStatus=1 
AND NOT EXISTS ( select CustomerID from [arc_ar_v2].dbo.Arc_Ar_SubProvisionMaster z where Status=1 and z.CustomerId= a.CustomerID ) 
UNION 
SELECT sm.CustomerId,SubProvisionId,SubProvision,SubProvisionCode,sm.FromTime,sm.ToTime,sm.DynamicAddTicket 
,isnull(sm.AuditModFormType,'Regular')  AuditModFormType,ISNULL(SM.WorkingShift,'')WorkingShift,isnull(SM.IsServiceBasedAuditMonform,'NO') IsServiceBasedAuditMonform
FROM [arc_ar_v2].dbo.Arc_Ar_SubProvisionMaster sm
inner join [arc_ar_v2].dbo.ARC_AR_ClientMaster cm on sm.CustomerId=cm.CustomerID and cm.Status =1
WHERE sm.Status=1
GO
/****** Object:  View [dbo].[ARC_REC_USER_INFO_VY]    Script Date: 9/8/2020 11:18:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[ARC_REC_USER_INFO_VY]                        
as                        
select UI.Userid,UI.Firstname+' '+isnull(Ui.Lastname,'') Associate,Cp.DOB,UI.NT_UserName,Ui.Empcode,Ui.REPORTING_TO,HD.DesigId,HD.Designation,                        
HF.FunctionalityId,HF.FunctionName,ci.Client_Id,ci.client_name,C.Rec_id,c.PROFILE_IMAGE_NAME ,UI.FIRSTNAME,Ui.LASTNAME,UI.DOJ DOJ                    
,cp.MOBILE_NO,cp.EMER_CONTACT_NO,Cp.PRE_LOCATION,Cp.EMAIL_ID        
,NT_UserName+'@accesshealthcare.co' Associate_Email,REPORTING_TO+'@accesshealthcare.co' Reportingto_Email,UI.PreDoj  
from ARC_REC.dbo.ARC_REC_USER_INFO UI                        
inner Join ARC_REC.dbo.HR_Designation HD on Hd.DesigId=UI.DESIGNATION_ID                        
inner Join ARC_REC.dbo.HR_Functionality HF on HF.FunctionalityId=UI.FUNCTIONALITY_ID                        
Inner JOin ARC_REC.dbo.ARC_FIN_CLIENT_INFO CI on CI.Client_Id=ui.Client_Id                        
left Join ARC_REC.dbo.ARC_REC_CANDIDATE C on C.REC_ID=UI.REC_ID              
left join ARC_REC.dbo.ARC_REC_CANDIATE_PROFILE CP on cp.REC_ID =c.REC_ID                     
where  ui.ACTIVE=1 --and AHS_PRL='Y' And C.REC_ID=UI.REC_ID
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 9/8/2020 11:18:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aa11]    Script Date: 9/8/2020 11:18:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aa11](
	[id] [int] NULL,
	[name] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_AR_Callrecoding]    Script Date: 9/8/2020 11:18:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_AR_Callrecoding](
	[SNO] [int] IDENTITY(1,1) NOT NULL,
	[ClaimNo] [nvarchar](max) NULL,
	[InsuranceName] [varchar](max) NULL,
	[PhoneNumber] [varchar](max) NULL,
	[CallInitiatedTime] [datetime] NULL,
	[CallEndTime] [datetime] NULL,
	[RecordingURL] [varchar](max) NULL,
	[CreatedBy] [varchar](500) NULL,
	[SourceAdded] [varchar](200) NULL,
	[Customername] [varchar](200) NULL,
	[Createddate] [datetime] NULL,
	[Extension] [varchar](20) NULL,
	[CustomerID] [int] NULL,
	[Referenceid] [int] NULL,
	[Uniqueid] [varchar](8000) NULL,
	[CallDisposition] [varchar](500) NULL,
	[Location] [varchar](50) NULL,
	[Duration] [int] NULL,
	[HoldTime] [int] NULL,
	[SubProvisionId] [int] NULL,
	[active] [int] NULL,
	[RecordingID] [varchar](255) NULL,
	[IsAPI] [tinyint] NULL,
	[APIURL] [varchar](500) NULL,
	[calldate] [date] NULL,
	[CallDirections] [varchar](250) NULL,
	[UserDisposition] [varchar](500) NULL,
 CONSTRAINT [PK_CR_SNO] PRIMARY KEY CLUSTERED 
(
	[SNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_Contract_Customer]    Script Date: 9/8/2020 11:18:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_Contract_Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FullName] [varchar](100) NULL,
	[InternalName] [varchar](40) NULL,
	[ExternalName] [varchar](40) NULL,
	[OperationHead] [varchar](100) NULL,
	[CustomerAddress] [varchar](500) NULL,
	[DOE] [date] NULL,
	[EffectiveDt] [date] NULL,
	[ContractingEntity] [varchar](50) NULL,
	[InitialContractTerms] [int] NULL,
	[AutoRenewal] [varchar](5) NULL,
	[RenewalDuration] [int] NULL,
	[RenewalNoticePeriod] [int] NULL,
	[ContractStartDt] [date] NULL,
	[ContractEndDt] [date] NULL,
	[Discount] [decimal](5, 2) NULL,
	[TAT] [int] NULL,
	[Quality] [decimal](5, 2) NULL,
	[CmpKey] [varchar](5) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDt] [datetime] NULL,
	[InvoiceTemplateType] [int] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_ARC_Contract_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_ECHOREV]    Script Date: 9/8/2020 11:18:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_ECHOREV](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[USERNAME] [varchar](100) NULL,
	[DEPARTMENT] [varchar](250) NULL,
	[REPORTING_TO] [varchar](250) NULL,
	[CALL_ID] [int] NULL,
	[PAYER_NAME] [varchar](250) NULL,
	[PAYER_PHN_NBR] [varchar](20) NULL,
	[WORKED_DATE] [datetime] NULL,
	[IVR] [varchar](15) NULL,
	[VOICE] [varchar](15) NULL,
	[HOLD] [varchar](15) NULL,
	[TOTAL] [varchar](15) NULL,
	[CREATED_USER] [varchar](100) NULL,
	[CREATED_DATE] [datetime] NULL,
	[MODIFIED_USER] [varchar](100) NULL,
	[MODIFIED_DATE] [datetime] NULL,
	[STATUS] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BTQ_USAGE]    Script Date: 9/8/2020 11:18:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BTQ_USAGE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PROCESS_NAME] [varchar](100) NULL,
	[PROJECT_NAME] [varchar](100) NULL,
	[ECHOBOT_ID] [varchar](100) NULL,
	[ACCOUNT_UNIQUEID] [varchar](100) NULL,
	[DOS_OR_ENCOUNTER] [varchar](100) NULL,
	[START_TIME] [datetime] NULL,
	[END_TIME] [datetime] NULL,
	[TIME_TAKEN] [varchar](50) NULL,
	[STATUS] [int] NULL,
	[PROCESS_STATUS] [varchar](100) NULL,
	[USER_NAME] [varchar](100) NULL,
	[EXCEPTION] [varchar](max) NULL,
	[IS_TRANSFERED] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_AdminUsers]    Script Date: 9/8/2020 11:18:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_AdminUsers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NTLoginName] [varchar](100) NOT NULL,
	[PageAccess] [varchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ControlAccess] [int] NOT NULL,
 CONSTRAINT [user_unique] UNIQUE NONCLUSTERED 
(
	[NTLoginName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_AppLoginInfo]    Script Date: 9/8/2020 11:18:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_AppLoginInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VendorID] [int] NOT NULL,
	[AppName] [varchar](200) NOT NULL,
	[ClientID] [nvarchar](1000) NULL,
	[SecretID] [nvarchar](max) NULL,
	[UserID] [nvarchar](200) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[Extension] [varchar](200) NULL,
	[URLLink] [varchar](500) NULL,
	[AppType] [varchar](200) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](200) NOT NULL,
 CONSTRAINT [PK_C3_AppLoginInfo_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_C3_AppLoginInfo_VendorID_AppName_AppType] UNIQUE NONCLUSTERED 
(
	[VendorID] ASC,
	[AppName] ASC,
	[AppType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_CallRecordingExtensions]    Script Date: 9/8/2020 11:18:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_CallRecordingExtensions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ExternalId] [varchar](100) NOT NULL,
	[extensionNumber] [varchar](100) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_CallRecordingExtensions_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_C3_CallRecordingExtensions_ExternalId] UNIQUE NONCLUSTERED 
(
	[ExternalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_ClaimNoUpdateLog]    Script Date: 9/8/2020 11:18:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_ClaimNoUpdateLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CallDate] [date] NULL,
	[SNO] [int] NOT NULL,
	[CreatedBy] [varchar](150) NULL,
	[OldClaimNo] [nvarchar](4000) NULL,
	[NewClaimNo] [nvarchar](4000) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_ClaimNoUpdateLog_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_CustomerListFlow]    Script Date: 9/8/2020 11:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_CustomerListFlow](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[ClientName] [varchar](300) NOT NULL,
	[C3URL] [varchar](500) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_CustomerListFlow_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_C3_CustomerListFlow_ClientID] UNIQUE NONCLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_FileWatcher]    Script Date: 9/8/2020 11:18:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_FileWatcher](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Project] [varchar](100) NOT NULL,
	[FolderPath] [varchar](750) NOT NULL,
	[FileExtn] [varchar](250) NOT NULL,
	[WatcherTime] [int] NOT NULL,
	[DBTime] [int] NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [varchar](100) NOT NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_FileWatcher_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_C3_FileWatcher_Project_FolderPath] UNIQUE NONCLUSTERED 
(
	[Project] ASC,
	[FolderPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_FileWatcherFileInfo]    Script Date: 9/8/2020 11:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_FileWatcherFileInfo](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Project] [varchar](100) NOT NULL,
	[FullPath] [varchar](1000) NOT NULL,
	[FileName] [varchar](350) NULL,
	[FileSize] [bigint] NULL,
	[FileCreatedAt] [datetime] NULL,
	[OldName] [varchar](250) NULL,
	[ChangeType] [varchar](100) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_FileWatcherFileInfo_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_RCDirectory]    Script Date: 9/8/2020 11:18:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_RCDirectory](
	[DID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [varchar](100) NULL,
	[ExtensionNumber] [varchar](100) NULL,
	[PhoneNumber] [varchar](100) NULL,
	[Name] [varchar](300) NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Department] [varchar](700) NULL,
	[Email] [varchar](250) NULL,
	[JobTitle] [varchar](250) NULL,
	[PhoneType] [varchar](250) NULL,
	[Label] [varchar](250) NULL,
	[UsageType] [varchar](250) NULL,
	[Status] [varchar](100) NULL,
	[Type] [varchar](100) NULL,
	[CreatedBy] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_RCDirectory_DID] PRIMARY KEY CLUSTERED 
(
	[DID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_SchedulerExtension]    Script Date: 9/8/2020 11:18:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_SchedulerExtension](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ExtensionNumber] [varchar](100) NULL,
	[Password] [nvarchar](max) NULL,
	[AccessAt] [datetime] NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](150) NULL,
 CONSTRAINT [PK_C3_SchedulerExtension_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PK_C3_SchedulerExtension_ExtensionNumber] UNIQUE NONCLUSTERED 
(
	[ExtensionNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_SchedulerLog]    Script Date: 9/8/2020 11:18:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_SchedulerLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueID] [varchar](500) NOT NULL,
	[IsSchedule] [bit] NULL,
	[StatusID] [int] NULL,
	[ScheduleAt] [datetime] NULL,
	[AssignUser] [varchar](200) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_SchedulerLog_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_UserProfileLog]    Script Date: 9/8/2020 11:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_UserProfileLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[VendorID] [int] NOT NULL,
	[CustomerID] [int] NULL,
	[GroupID] [int] NULL,
	[Extension] [int] NULL,
	[RoleID] [int] NULL,
	[DirectNumber] [varchar](150) NULL,
	[Department] [varchar](500) NULL,
	[ExternalId] [varchar](250) NULL,
	[DialerType] [int] NULL,
	[Remarks] [varchar](500) NOT NULL,
	[IsActive] [bit] NULL,
	[ModifiedBy] [varchar](150) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_UserProfileLog_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_VoiceCallErrorLog]    Script Date: 9/8/2020 11:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_VoiceCallErrorLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Uniqueid] [varchar](1000) NULL,
	[SourceAdded] [varchar](250) NULL,
	[NtUserName] [varchar](150) NULL,
	[ErrorAt] [varchar](250) NULL,
	[ErrorOn] [datetime] NULL,
	[ErrorMessage] [varchar](max) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_C3_VoiceCallErrorLog_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_VoiceCallInfo]    Script Date: 9/8/2020 11:18:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_VoiceCallInfo](
	[SNO] [int] IDENTITY(1,1) NOT NULL,
	[ClaimNo] [varchar](1000) NULL,
	[InsuranceName] [varchar](1000) NULL,
	[PhoneNumber] [varchar](300) NULL,
	[CallInitiatedTime] [datetime] NULL,
	[CallEndTime] [datetime] NULL,
	[RecordingURL] [varchar](1000) NULL,
	[CreatedBy] [varchar](250) NULL,
	[SourceAdded] [varchar](250) NULL,
	[Createddate] [datetime] NOT NULL,
	[CustomerID] [int] NULL,
	[Uniqueid] [varchar](1000) NULL,
	[CallDisposition] [varchar](500) NULL,
	[Location] [varchar](300) NULL,
	[Duration] [int] NOT NULL,
	[CallDirection] [varchar](500) NULL,
	[RecordingID] [varchar](500) NULL,
	[FileLocation] [varchar](1000) NULL,
	[APIDisposition] [varchar](350) NULL,
	[APIReason] [varchar](350) NULL,
	[APIReasonDesc] [varchar](500) NULL,
	[SchedulerStatus] [varchar](500) NULL,
	[C3Version] [varchar](100) NULL,
	[FromExtn] [varchar](100) NULL,
	[ToName] [varchar](150) NULL,
	[ToExtn] [varchar](100) NULL,
 CONSTRAINT [PK_C3_VoiceCallInfo_ID] PRIMARY KEY CLUSTERED 
(
	[SNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_VoiceCallInfo_Uniqueid] UNIQUE NONCLUSTERED 
(
	[Uniqueid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C3_VoiceCallInfoLog]    Script Date: 9/8/2020 11:18:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C3_VoiceCallInfoLog](
	[SNO] [int] IDENTITY(1,1) NOT NULL,
	[Uniqueid] [varchar](1000) NULL,
	[CreatedBy] [varchar](250) NULL,
	[ClaimNo] [varchar](1000) NULL,
	[PhoneNumber] [varchar](300) NULL,
	[CallInitiatedTime] [datetime] NULL,
	[CallEndTime] [datetime] NULL,
	[Duration] [int] NOT NULL,
	[UserDisposition] [varchar](500) NULL,
	[CallDisposition] [varchar](350) NULL,
	[CallDirection] [varchar](500) NULL,
	[Createddate] [datetime] NOT NULL,
	[RecordingID] [varchar](500) NULL,
	[RecordingURL] [varchar](1000) NULL,
	[SourceAdded] [varchar](250) NULL,
	[CustomerID] [int] NULL,
	[Location] [varchar](300) NULL,
	[InsuranceName] [varchar](1000) NULL,
	[FileLocation] [varchar](1000) NULL,
	[APIReason] [varchar](350) NULL,
	[APIReasonDesc] [varchar](500) NULL,
	[SchedulerStatus] [int] NULL,
	[C3Version] [varchar](100) NULL,
	[FromExtn] [varchar](100) NULL,
	[ToName] [varchar](150) NULL,
	[ToExtn] [varchar](100) NULL,
	[CallDate] [date] NULL,
 CONSTRAINT [PK_C3_VoiceCallInfoLog_ID] PRIMARY KEY CLUSTERED 
(
	[SNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatBot_Rewards_Decisions]    Script Date: 9/8/2020 11:18:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatBot_Rewards_Decisions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](255) NOT NULL,
	[Decisions] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CRM_DailerType]    Script Date: 9/8/2020 11:18:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_DailerType](
	[Dialerid] [int] IDENTITY(1,1) NOT NULL,
	[DialerName] [varchar](30) NULL,
	[DailerURL] [varchar](300) NULL,
	[isActive] [bit] NULL,
	[DesiredBrowser] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Dialerid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CRM_Logger]    Script Date: 9/8/2020 11:18:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_Logger](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[StackTrace] [varchar](3000) NULL,
	[UserID] [varchar](100) NULL,
	[Dialerid] [int] NULL,
	[ExceptionMessage] [varchar](100) NULL,
	[ExceptionDate] [datetime] NULL,
 CONSTRAINT [PK__CRM_Logg__358565CAC64AE5BA] PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CRM_ProcessMaster]    Script Date: 9/8/2020 11:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_ProcessMaster](
	[Processid] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [varchar](150) NULL,
	[ProcessName] [varchar](150) NULL,
	[PrimaryDial] [int] NULL,
	[SecondaryDial] [int] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Processid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CRM_RoleMaster]    Script Date: 9/8/2020 11:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_RoleMaster](
	[Roleid] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](100) NULL,
	[isActive] [bit] NULL,
	[comments] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Roleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CRM_tErrorLog]    Script Date: 9/8/2020 11:18:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_tErrorLog](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorDate] [datetime] NULL,
	[Username] [nvarchar](50) NULL,
	[SystemIP] [varchar](16) NULL,
	[ErrorMessage] [varchar](max) NULL,
	[DialerId] [int] NULL,
	[StackTrace] [varchar](3000) NULL,
	[ProcessID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CRM_tLoginTrack]    Script Date: 9/8/2020 11:18:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_tLoginTrack](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[SystemIP] [varchar](16) NULL,
	[LoginTime] [datetime] NULL,
	[DialerID] [int] NULL,
	[ProcessID] [int] NULL,
	[IsSuccess] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CRM_tUserLogin]    Script Date: 9/8/2020 11:18:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_tUserLogin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AgentName] [varchar](100) NULL,
	[Dialerid] [int] NULL,
	[UserName] [varchar](200) NULL,
	[Password] [varchar](100) NULL,
	[PWD_Modifieddt] [datetime] NULL,
	[OldPassword] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CRM_UIControlMaster]    Script Date: 9/8/2020 11:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_UIControlMaster](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DialerID] [int] NULL,
	[FieldName] [varchar](30) NULL,
	[Findby] [varchar](10) NULL,
	[Tagname] [varchar](15) NULL,
	[AttributeKey] [varchar](20) NULL,
	[AttributeValue] [varchar](30) NULL,
	[isActive] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CRM_UserMaster]    Script Date: 9/8/2020 11:18:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_UserMaster](
	[Userid] [int] IDENTITY(1,1) NOT NULL,
	[AgentName] [varchar](100) NOT NULL,
	[SupervisiorName] [varchar](100) NULL,
	[Roleid] [int] NULL,
	[Processid] [int] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AgentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CRM_VersionMaster]    Script Date: 9/8/2020 11:18:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_VersionMaster](
	[VersionID] [int] IDENTITY(1,1) NOT NULL,
	[VersionNumber] [varchar](15) NOT NULL,
	[AppName] [varchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[Comments] [varchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[VersionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[VersionNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ct_audit_log]    Script Date: 9/8/2020 11:18:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ct_audit_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[category] [varchar](500) NULL,
	[user] [varchar](500) NULL,
	[action] [varchar](500) NULL,
	[time] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_BotRunningStatus]    Script Date: 9/8/2020 11:18:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_BotRunningStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[StatusId] [int] NULL,
 CONSTRAINT [PK_CT_BotRunningStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_BotStatus]    Script Date: 9/8/2020 11:18:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_BotStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[MachineIp] [varchar](150) NULL,
	[BotName] [varchar](350) NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[StatusId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserName] [varchar](350) NULL,
	[Author] [varchar](350) NULL,
	[ProcessName] [varchar](250) NULL,
	[SubProcessName] [varchar](250) NULL,
 CONSTRAINT [PK_CT_BotStatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_BotStatusLog]    Script Date: 9/8/2020 11:18:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_BotStatusLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TokenKey] [varchar](1850) NULL,
	[Status] [varchar](650) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserName] [varchar](650) NULL,
	[Message] [varchar](max) NULL,
 CONSTRAINT [PK_CT_BotStatusLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_ECHOBOT_TRANSACTIONLOG_INFO]    Script Date: 9/8/2020 11:18:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_ECHOBOT_TRANSACTIONLOG_INFO](
	[ECHO_ID] [int] IDENTITY(1,1) NOT NULL,
	[PROCESS_NAME] [varchar](100) NULL,
	[PROCESS_TYPE] [varchar](100) NULL,
	[PROJECT_NAME] [varchar](100) NULL,
	[SUB_PROCESSNAME] [varchar](100) NULL,
	[ECHOBOT_ID] [varchar](100) NULL,
	[PROCESS_UNIQUEID] [varchar](100) NULL,
	[START_TIME] [datetime] NULL,
	[END_TIME] [datetime] NULL,
	[STATUS] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_EchoRemoteUserLog]    Script Date: 9/8/2020 11:18:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_EchoRemoteUserLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[TimeStamp] [datetime] NULL,
	[MachineIp] [varchar](250) NULL,
	[MachineName] [varchar](250) NULL,
	[Remarks] [varchar](500) NULL,
	[Action] [varchar](50) NULL,
	[ConnectedAs] [varchar](250) NULL,
	[ConnectedTo] [varchar](50) NULL,
 CONSTRAINT [PK_CT_EchoRemoteUserLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_EchoRemoteUsers]    Script Date: 9/8/2020 11:18:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_EchoRemoteUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](250) NOT NULL,
	[Domain] [varchar](250) NOT NULL,
	[IsActive] [int] NOT NULL,
 CONSTRAINT [PK_CT_EchoRemoteUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_LiveProcess]    Script Date: 9/8/2020 11:18:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_LiveProcess](
	[ProcessID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessName] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[WindowName] [varchar](50) NULL,
	[Status] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProcessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_PageAccess]    Script Date: 9/8/2020 11:18:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_PageAccess](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[PageId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[Status] [varchar](150) NULL,
	[CanRead] [bit] NULL,
	[CanWrite] [bit] NULL,
	[CanDelete] [bit] NULL,
	[ModifiedBy] [varchar](350) NULL,
 CONSTRAINT [PK_CT_RoleAccess] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_Pages]    Script Date: 9/8/2020 11:18:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_Pages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](650) NULL,
	[Status] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[MenuCaption] [varchar](650) NULL,
	[URL] [varchar](650) NULL,
	[ParentId] [int] NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_CT_Page] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_Process]    Script Date: 9/8/2020 11:18:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_Process](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Status] [varchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserName] [varchar](250) NULL,
	[ExeName] [varchar](250) NULL,
	[FileName] [varchar](250) NULL,
	[processID] [uniqueidentifier] NULL,
	[ProcessType] [varchar](100) NULL,
	[CreatedBy] [varchar](255) NULL,
	[ModifiedBy] [varchar](255) NULL,
 CONSTRAINT [PK_CT_Process] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_Process_Client]    Script Date: 9/8/2020 11:18:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_Process_Client](
	[Id] [int] NOT NULL,
	[Name] [varchar](250) NULL,
	[Status] [varchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserName] [varchar](250) NULL,
	[ExeName] [varchar](250) NULL,
	[FileName] [varchar](250) NULL,
	[processID] [uniqueidentifier] NULL,
	[Address] [nvarchar](255) NULL,
	[Contact_Mobile] [nvarchar](255) NULL,
	[Bot_Instance] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_ProjectUsage]    Script Date: 9/8/2020 11:18:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_ProjectUsage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Project] [varchar](250) NULL,
	[Process] [varchar](250) NULL,
	[SubProcess] [varchar](250) NULL,
	[Team] [varchar](250) NULL,
	[SubTeam] [varchar](250) NULL,
	[Location] [varchar](250) NULL,
	[Facility] [varchar](250) NULL,
	[UserName] [varchar](250) NULL,
	[Date] [datetime] NULL,
	[UsageCount] [int] NULL,
	[CustomField] [varchar](max) NULL,
	[Status] [varchar](250) NULL,
	[Count] [int] NULL,
 CONSTRAINT [PK_CT_ProjectUsage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_ProjectUsage434]    Script Date: 9/8/2020 11:18:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_ProjectUsage434](
	[Id] [int] NOT NULL,
	[Project] [varchar](250) NULL,
	[Process] [varchar](250) NULL,
	[SubProcess] [varchar](250) NULL,
	[Team] [varchar](250) NULL,
	[SubTeam] [varchar](250) NULL,
	[Location] [varchar](250) NULL,
	[Facility] [varchar](250) NULL,
	[UserName] [varchar](250) NULL,
	[Date] [datetime] NULL,
	[UsageCount] [int] NULL,
	[CustomField] [varchar](max) NULL,
	[Status] [varchar](250) NULL,
	[Count] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_ProjectUsage96]    Script Date: 9/8/2020 11:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_ProjectUsage96](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Project] [varchar](250) NULL,
	[Process] [varchar](250) NULL,
	[SubProcess] [varchar](250) NULL,
	[Team] [varchar](250) NULL,
	[SubTeam] [varchar](250) NULL,
	[Location] [varchar](250) NULL,
	[Facility] [varchar](250) NULL,
	[UserName] [varchar](250) NULL,
	[Date] [datetime] NULL,
	[UsageCount] [int] NULL,
	[CustomField] [varchar](max) NULL,
	[Status] [varchar](250) NULL,
	[Count] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_Roles]    Script Date: 9/8/2020 11:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](650) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[Status] [varchar](150) NULL,
 CONSTRAINT [PK_CT_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_Scheduler]    Script Date: 9/8/2020 11:18:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_Scheduler](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProcessId] [int] NULL,
	[UserId] [int] NULL,
	[TaskName] [varchar](250) NULL,
	[Description] [varchar](3050) NULL,
	[HostName] [varchar](250) NULL,
	[Repetitionmode] [varchar](50) NULL,
	[StartDateTime] [datetime] NULL,
	[RepetationInterval] [int] NULL,
	[WeekDays] [varchar](2050) NULL,
	[DaysOfMonth] [varchar](2050) NULL,
	[MonthOfYear] [varchar](2050) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CustomField] [varchar](max) NULL,
	[RunOnLastDayOfMonth] [bit] NULL,
	[UserName] [varchar](250) NULL,
	[ServerIp] [varchar](250) NULL,
	[TargetDrive] [varchar](50) NULL,
	[TokenKey] [varchar](1250) NULL,
	[botClientID] [uniqueidentifier] NULL,
	[Status] [varchar](100) NULL,
	[LastRunTime] [datetime] NULL,
	[NextRunTime] [datetime] NULL,
	[ScheduleStatus] [varchar](50) NULL,
 CONSTRAINT [PK_CT_Scheduler1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_Scheduler_Client]    Script Date: 9/8/2020 11:18:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_Scheduler_Client](
	[Id] [int] NOT NULL,
	[ProcessId] [int] NULL,
	[UserId] [int] NULL,
	[TaskName] [varchar](250) NULL,
	[Description] [varchar](3050) NULL,
	[HostName] [varchar](250) NULL,
	[Repetitionmode] [varchar](50) NULL,
	[StartDateTime] [datetime] NULL,
	[RepetationInterval] [int] NULL,
	[WeekDays] [varchar](2050) NULL,
	[DaysOfMonth] [varchar](2050) NULL,
	[MonthOfYear] [varchar](2050) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CustomField] [varchar](max) NULL,
	[RunOnLastDayOfMonth] [bit] NULL,
	[UserName] [varchar](250) NULL,
	[ServerIp] [varchar](250) NULL,
	[TargetDrive] [varchar](50) NULL,
	[TokenKey] [varchar](1250) NULL,
	[botClientID] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_SchedulerLog]    Script Date: 9/8/2020 11:18:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_SchedulerLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProcessId] [int] NULL,
	[UserId] [int] NULL,
	[TaskName] [varchar](250) NULL,
	[Description] [varchar](3050) NULL,
	[HostName] [varchar](250) NULL,
	[Repetitionmode] [varchar](50) NULL,
	[StartDateTime] [datetime] NULL,
	[RepetationInterval] [int] NULL,
	[WeekDays] [varchar](2050) NULL,
	[DaysOfMonth] [varchar](2050) NULL,
	[MonthOfYear] [varchar](2050) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[CustomField] [varchar](max) NULL,
	[RunOnLastDayOfMonth] [bit] NULL,
	[UserName] [varchar](250) NULL,
	[ServerIp] [varchar](250) NULL,
	[TargetDrive] [varchar](50) NULL,
	[TokenKey] [varchar](1250) NULL,
 CONSTRAINT [PK_CT_SchedulerLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_Servers]    Script Date: 9/8/2020 11:18:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_Servers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IpAddress] [varchar](50) NULL,
	[MachineName] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[Status] [varchar](150) NULL,
	[UserName] [varchar](250) NULL,
	[ServerType] [int] NULL,
 CONSTRAINT [PK_CT_Servers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_Transactions]    Script Date: 9/8/2020 11:18:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_Transactions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LOB] [varchar](100) NULL,
	[Process] [varchar](1000) NULL,
	[Transacations] [int] NULL,
	[Date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ct_Transactions_Testing]    Script Date: 9/8/2020 11:18:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ct_Transactions_Testing](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LOB] [varchar](100) NULL,
	[Process] [varchar](1000) NULL,
	[Transacations] [int] NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_User]    Script Date: 9/8/2020 11:18:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](250) NULL,
	[Password] [varchar](250) NULL,
	[Domain] [varchar](250) NULL,
	[NtLogin] [varchar](250) NULL,
	[Status] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[FullName] [varchar](650) NULL,
	[FirstName] [varchar](550) NULL,
	[LastName] [varchar](550) NULL,
	[Email] [varchar](650) NULL,
 CONSTRAINT [PK_CT_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_UserActivity]    Script Date: 9/8/2020 11:18:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_UserActivity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[UserName] [varchar](250) NULL,
	[Module] [varchar](250) NULL,
 CONSTRAINT [PK_CT_UserActivity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_UserRole]    Script Date: 9/8/2020 11:18:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_UserRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[Status] [varchar](50) NULL,
	[ModifiedBy] [varchar](350) NULL,
 CONSTRAINT [PK_CT_UserRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Data_Status]    Script Date: 9/8/2020 11:18:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Data_Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DecisionResults]    Script Date: 9/8/2020 11:18:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DecisionResults](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DecisionId] [int] NULL,
	[UserId] [int] NULL,
	[Result] [varchar](max) NULL,
	[Documentation] [varchar](max) NULL,
	[UserName] [varchar](150) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[FieldSetValues] [varchar](max) NULL,
	[FolderId] [int] NULL,
 CONSTRAINT [PK_DecisionResults] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DecisionStatus]    Script Date: 9/8/2020 11:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DecisionStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NULL,
 CONSTRAINT [PK_DecisionStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DecisionStickyNote]    Script Date: 9/8/2020 11:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DecisionStickyNote](
	[NoteID] [int] IDENTITY(1,1) NOT NULL,
	[Note] [varchar](max) NULL,
	[UserName] [varchar](100) NULL,
	[Created] [datetime] NULL,
	[Modified] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[NoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DecisionTreee]    Script Date: 9/8/2020 11:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DecisionTreee](
	[DecisionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NULL,
	[Json] [varchar](max) NULL,
	[Client] [varchar](150) NULL,
	[BusinessProcess] [varchar](150) NULL,
	[SubProcess] [varchar](150) NULL,
	[SubClientGroup] [varchar](150) NULL,
	[UserId] [int] NULL,
	[SupervisorId] [int] NULL,
	[StatusId] [int] NULL,
	[ParentDecisionId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[IntegrationConfig] [varchar](max) NULL,
	[TokenKey] [varchar](150) NULL,
	[UserName] [varchar](500) NULL,
	[FolderId] [int] NULL,
	[CustomField] [varchar](max) NULL,
	[FieldSetKeys] [varchar](max) NULL,
	[FileName] [varchar](1024) NULL,
 CONSTRAINT [PK_DecisionTreee] PRIMARY KEY CLUSTERED 
(
	[DecisionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DecisionTreeLog]    Script Date: 9/8/2020 11:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DecisionTreeLog](
	[DecisionIdLogId] [int] IDENTITY(1,1) NOT NULL,
	[DecisionId] [int] NULL,
	[Name] [varchar](150) NULL,
	[Json] [varchar](max) NULL,
	[Client] [varchar](150) NULL,
	[BusinessProcess] [varchar](150) NULL,
	[SubProcess] [varchar](150) NULL,
	[SubClientGroup] [varchar](150) NULL,
	[UserId] [int] NULL,
	[SupervisorId] [int] NULL,
	[StatusId] [int] NULL,
	[ParentDecisionId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[IntegrationConfig] [varchar](max) NULL,
	[TokenKey] [varchar](150) NULL,
	[UserName] [varchar](500) NULL,
	[FieldSetKeys] [varchar](max) NULL,
 CONSTRAINT [PK_DecisionTreeLog] PRIMARY KEY CLUSTERED 
(
	[DecisionIdLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DecisionTreeResults]    Script Date: 9/8/2020 11:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DecisionTreeResults](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DecisionId] [int] NULL,
	[UserId] [int] NULL,
	[Result] [varchar](max) NULL,
	[Documentation] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[Client] [varchar](150) NULL,
	[BusinessProcess] [varchar](150) NULL,
	[SubProcess] [varchar](150) NULL,
	[SubClientGroup] [varchar](150) NULL,
	[UserName] [varchar](500) NULL,
	[FieldSetValues] [varchar](max) NULL,
	[CustomField] [varchar](max) NULL,
	[Claimnumber] [varchar](250) NULL,
	[DTused] [int] NULL,
	[Calltype] [varchar](250) NULL,
	[Kickcode] [varchar](250) NULL,
	[Actiontype] [varchar](250) NULL,
 CONSTRAINT [PK_DecisionTreeResults] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_Active_Status]    Script Date: 9/8/2020 11:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_Active_Status](
	[ID] [bigint] NOT NULL,
	[TeamID] [bigint] NULL,
	[CreatedUsername] [varchar](50) NULL,
	[SystemIp] [varchar](50) NULL,
	[Status] [varchar](16) NULL,
	[ToolName] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[HostName] [varchar](50) NULL,
	[ExePath] [varchar](max) NULL,
	[TeamName] [varchar](100) NULL,
	[ToolVersion] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_ARCallTimeReport]    Script Date: 9/8/2020 11:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_ARCallTimeReport](
	[Sno] [int] IDENTITY(1,1) NOT NULL,
	[PhoneNumber] [varchar](100) NOT NULL,
	[CallOrNot] [varchar](100) NULL,
	[ExecutionTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_ExeptionLog]    Script Date: 9/8/2020 11:18:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_ExeptionLog](
	[Logid] [bigint] NOT NULL,
	[FunctionName] [varchar](max) NULL,
	[ExceptionMsg] [varchar](max) NULL,
	[ExceptionType] [varchar](max) NULL,
	[ExceptionSource] [varchar](max) NULL,
	[ExceptionURL] [varchar](max) NULL,
	[Logdate] [datetime] NULL,
	[Username] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_Flash]    Script Date: 9/8/2020 11:18:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_Flash](
	[Id] [int] NOT NULL,
	[PhoneNumber] [varchar](50) NOT NULL,
	[User] [varchar](max) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Comments] [varchar](1000) NOT NULL,
	[ISTTime] [varchar](100) NULL,
	[ML_Output] [varchar](100) NULL,
	[HoldTime] [varchar](100) NULL,
	[No_Of_Claims] [int] NULL,
	[TeamName] [varchar](100) NULL,
	[ID_Team] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_FlashComments]    Script Date: 9/8/2020 11:18:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_FlashComments](
	[Id] [int] NOT NULL,
	[Comments] [varchar](1000) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_KickCodeActiveStatus]    Script Date: 9/8/2020 11:18:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_KickCodeActiveStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Domain] [varchar](100) NOT NULL,
	[User] [varchar](100) NOT NULL,
	[SystemIP] [varchar](100) NULL,
	[Status] [varchar](100) NOT NULL,
	[Created] [datetime] NULL,
	[Modified] [datetime] NULL,
	[ExePath] [varchar](max) NULL,
	[TeamID] [int] NOT NULL,
	[TeamName] [varchar](1000) NOT NULL,
	[Version] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_KickcodeClaimTracking]    Script Date: 9/8/2020 11:18:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_KickcodeClaimTracking](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClaimID] [varchar](1000) NULL,
	[Notes] [varchar](max) NULL,
	[FinalNotes] [varchar](max) NULL,
	[StickyNote] [varchar](max) NULL,
	[UserName] [varchar](100) NULL,
	[ApplicationName] [varchar](1000) NULL,
	[Created] [datetime] NULL,
	[TeamID] [int] NULL,
	[TeamName] [varchar](1000) NULL,
	[Modified] [datetime] NULL,
	[ModifiedBy] [varchar](100) NULL,
	[IsReviewed] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_KickCodeGuide]    Script Date: 9/8/2020 11:18:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_KickCodeGuide](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WorkFlow] [varchar](1000) NULL,
	[KickCode] [varchar](1000) NULL,
	[Description] [varchar](max) NULL,
	[Next_Claim_Status] [varchar](1000) NULL,
	[Usage_Scenario] [varchar](max) NULL,
	[RequiredInformation] [varchar](max) NULL,
	[ClaimRecommendation] [varchar](max) NULL,
	[Remarks] [varchar](max) NULL,
	[Qc_Remarks] [varchar](max) NULL,
	[Notes] [varchar](max) NULL,
	[TeamID] [int] NOT NULL,
	[TeamName] [varchar](500) NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [varchar](1000) NULL,
	[Modified] [datetime] NULL,
	[ModifiedBy] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_KickCodeStickyNotes]    Script Date: 9/8/2020 11:19:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_KickCodeStickyNotes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Notes] [varchar](max) NULL,
	[UserName] [varchar](1000) NULL,
	[Created] [datetime] NULL,
	[TeamID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOC_Athena_KickCodeTemplateList]    Script Date: 9/8/2020 11:19:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOC_Athena_KickCodeTemplateList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [int] NOT NULL,
	[Reason] [varchar](1000) NOT NULL,
	[TeamID] [int] NULL,
	[TeamName] [varchar](1000) NULL,
	[Created] [datetime] NULL,
	[CreatedBy] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_KickCodeTLAccess]    Script Date: 9/8/2020 11:19:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_KickCodeTLAccess](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NTUserName] [varchar](100) NULL,
	[TeamID] [int] NULL,
	[TeamName] [varchar](100) NULL,
	[Created] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_KickcodeTracking]    Script Date: 9/8/2020 11:19:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_KickcodeTracking](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClaimID] [varchar](1000) NULL,
	[Notes] [varchar](max) NULL,
	[FinalNotes] [varchar](max) NULL,
	[UserName] [varchar](100) NULL,
	[ApplicationName] [varchar](1000) NULL,
	[Created] [datetime] NULL,
	[TeamID] [int] NULL,
	[TeamName] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_KickcodeVersionMaster]    Script Date: 9/8/2020 11:19:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_KickcodeVersionMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Version] [varchar](100) NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[AppPath] [varchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOC_Athena_ManilaLeads]    Script Date: 9/8/2020 11:19:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOC_Athena_ManilaLeads](
	[ID] [int] NOT NULL,
	[AthenaNet] [varchar](100) NULL,
	[NTLogin] [varchar](100) NULL,
	[SuperVisor] [varchar](100) NULL,
	[Status] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_Notes]    Script Date: 9/8/2020 11:19:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_Notes](
	[ID] [bigint] NOT NULL,
	[Notes] [varchar](500) NULL,
	[Definition] [varchar](max) NULL,
	[Priority] [int] NULL,
	[TeamID] [bigint] NULL,
	[CreatedUsername] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[TeamName] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_PrecallMaster]    Script Date: 9/8/2020 11:19:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_PrecallMaster](
	[ID] [int] NOT NULL,
	[TeamName] [varchar](1000) NULL,
	[GroupName] [varchar](100) NULL,
	[Shift] [varchar](100) NULL,
	[Status] [int] NULL,
	[Location] [varchar](500) NULL,
	[IsPrecallEnabled] [int] NULL,
	[IsInsuranceEligibilityEnabled] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_ProductionInfo]    Script Date: 9/8/2020 11:19:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_ProductionInfo](
	[Sno] [int] NOT NULL,
	[UserName] [varchar](500) NULL,
	[NT_Login] [varchar](500) NULL,
	[Location] [varchar](100) NULL,
	[Process] [varchar](500) NULL,
	[Date] [datetime] NULL,
	[Production] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_ProdVersionMaster]    Script Date: 9/8/2020 11:19:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_ProdVersionMaster](
	[ID] [bigint] NOT NULL,
	[ToolNameWithVersion] [varchar](50) NULL,
	[Status] [varchar](16) NULL,
	[CreatedDate] [datetime] NULL,
	[ApplicationSrcPath] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOC_Athena_StickyNotes]    Script Date: 9/8/2020 11:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOC_Athena_StickyNotes](
	[Temp1] [varchar](500) NULL,
	[Temp2] [varchar](500) NULL,
	[Temp3] [varchar](500) NULL,
	[Temp4] [varchar](500) NULL,
	[Temp5] [varchar](500) NULL,
	[Temp6] [varchar](500) NULL,
	[TeamID] [bigint] NULL,
	[CreatedUsername] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOC_Athena_submit_Tracking]    Script Date: 9/8/2020 11:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOC_Athena_submit_Tracking](
	[TrackingID] [bigint] NOT NULL,
	[ClaimNo] [varchar](200) NULL,
	[Notes] [varchar](max) NULL,
	[StartingNotes] [varchar](max) NULL,
	[FinalNotes] [varchar](max) NULL,
	[Username] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ARCStatus] [varchar](100) NULL,
	[TeamID] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_TeamMaster]    Script Date: 9/8/2020 11:19:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_TeamMaster](
	[ID] [bigint] NOT NULL,
	[TeamName] [varchar](100) NULL,
	[GroupName] [varchar](50) NULL,
	[Shift] [varchar](50) NULL,
	[Status] [varchar](16) NULL,
	[TeamID] [bigint] NULL,
	[SubProvisionCode] [varchar](200) NULL,
	[CustomerId] [int] NULL,
	[ARCFlag] [varchar](5) NULL,
	[DTArcUseTeamID] [bigint] NULL,
	[ArcDOSFutureDateFlag] [int] NULL,
	[ArcSubmitDataClr] [varchar](5) NULL,
	[Location] [varchar](100) NULL,
	[NewTeamName] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOC_Athena_TemplateList]    Script Date: 9/8/2020 11:19:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOC_Athena_TemplateList](
	[ID] [bigint] NOT NULL,
	[Value] [int] NULL,
	[Reason] [varchar](200) NULL,
	[TextLength] [int] NULL,
	[TeamID] [bigint] NULL,
	[CreatedUsername] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[TeamName] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOC_Athena_TL_Access]    Script Date: 9/8/2020 11:19:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOC_Athena_TL_Access](
	[ID] [bigint] NOT NULL,
	[EMPName] [varchar](50) NULL,
	[NTUserName] [varchar](50) NULL,
	[GroupName] [varchar](50) NULL,
	[TeamName] [varchar](100) NULL,
	[Shift] [varchar](50) NULL,
	[Status] [varchar](16) NULL,
	[TeamID] [bigint] NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_TopPayers]    Script Date: 9/8/2020 11:19:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_TopPayers](
	[Sno] [int] NOT NULL,
	[TopPayers] [varchar](500) NULL,
	[ExecutionTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOC_Athena_Tracking]    Script Date: 9/8/2020 11:19:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOC_Athena_Tracking](
	[TrackingID] [bigint] NOT NULL,
	[Notes] [text] NULL,
	[StartingNotes] [text] NULL,
	[FinalNotes] [text] NULL,
	[Username] [varchar](100) NULL,
	[CreatedDate] [datetime2](3) NULL,
	[ApplicationName] [text] NULL,
	[TeamID] [bigint] NULL,
	[ProcessDate] [datetime2](3) NULL,
	[MasterTemplate] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_UnavaialableRecords]    Script Date: 9/8/2020 11:19:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_UnavaialableRecords](
	[ID] [int] NOT NULL,
	[PhoneNumber] [varchar](100) NULL,
	[Created] [datetime] NULL,
	[CreatedBy] [varchar](500) NULL,
	[Team] [varchar](500) NULL,
	[ID_Team] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doc_Athena_UsageRecord]    Script Date: 9/8/2020 11:19:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doc_Athena_UsageRecord](
	[ID] [int] NOT NULL,
	[UserName] [varchar](500) NULL,
	[PhoneNumber] [varchar](100) NULL,
	[ML_Result] [varchar](1000) NULL,
	[Created] [datetime] NULL,
	[TeamName] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOC_Notes]    Script Date: 9/8/2020 11:19:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOC_Notes](
	[Notes] [nvarchar](max) NULL,
	[ID] [bigint] NOT NULL,
	[Definition] [varchar](max) NULL,
	[Priority] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DT_Athena_Exceptions]    Script Date: 9/8/2020 11:19:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DT_Athena_Exceptions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](100) NULL,
	[Exception] [varchar](max) NULL,
	[Class] [varchar](100) NULL,
	[Method] [varchar](100) NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DT_Athena_KickcodeClaimTracking]    Script Date: 9/8/2020 11:19:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DT_Athena_KickcodeClaimTracking](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClaimID] [varchar](1000) NULL,
	[Notes] [varchar](max) NULL,
	[FinalNotes] [varchar](max) NULL,
	[StickyNote] [varchar](max) NULL,
	[IsReviewed] [int] NULL,
	[UserName] [varchar](100) NULL,
	[Created] [datetime] NULL,
	[TeamID] [int] NULL,
	[TeamName] [varchar](1000) NULL,
	[Modified] [datetime] NULL,
	[ModifiedBy] [varchar](100) NULL,
	[KickCode] [varchar](500) NULL,
	[TemplateValues] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DT_Athena_KickCodeGuide]    Script Date: 9/8/2020 11:19:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DT_Athena_KickCodeGuide](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WorkFlow] [varchar](1000) NULL,
	[KickCode] [varchar](1000) NULL,
	[Description] [varchar](max) NULL,
	[Next_Claim_Status] [varchar](1000) NULL,
	[Usage_Scenario] [varchar](max) NULL,
	[RequiredInformation] [nvarchar](max) NULL,
	[ClaimRecommendation] [varchar](max) NULL,
	[Remarks] [varchar](max) NULL,
	[Qc_Remarks] [varchar](max) NULL,
	[Notes] [varchar](max) NULL,
	[TeamID] [int] NOT NULL,
	[TeamName] [varchar](500) NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [varchar](1000) NULL,
	[Modified] [datetime] NULL,
	[ModifiedBy] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DT_Athena_KickCodeTemplateList]    Script Date: 9/8/2020 11:19:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DT_Athena_KickCodeTemplateList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [int] NOT NULL,
	[Reason] [varchar](1000) NOT NULL,
	[TeamID] [int] NULL,
	[TeamName] [varchar](1000) NULL,
	[Created] [datetime] NULL,
	[CreatedBy] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DT_Athena_KickCodeTLAccess]    Script Date: 9/8/2020 11:19:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DT_Athena_KickCodeTLAccess](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NTUserName] [varchar](100) NULL,
	[TeamID] [int] NULL,
	[TeamName] [varchar](100) NULL,
	[Created] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DT_Athena_TeamMaster]    Script Date: 9/8/2020 11:19:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DT_Athena_TeamMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [varchar](500) NOT NULL,
	[Location] [varchar](500) NOT NULL,
	[Active] [bit] NOT NULL,
	[Created] [datetime] NULL,
	[CreatedBy] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DT_IneligibleWorkFlows]    Script Date: 9/8/2020 11:19:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DT_IneligibleWorkFlows](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PackageId] [int] NULL,
	[Package] [varchar](max) NULL,
	[IRCGroup] [varchar](5000) NULL,
 CONSTRAINT [PK_DT_IneligibleWorkFlows] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DT_NodeFilter]    Script Date: 9/8/2020 11:19:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DT_NodeFilter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Input] [varchar](7050) NULL,
	[Description] [varchar](max) NULL,
	[Condition] [varchar](6050) NULL,
	[Parameter] [varchar](7050) NULL,
	[TokenKey] [varchar](36) NULL,
 CONSTRAINT [PK_DT_NodeFilter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DTUsageMaster]    Script Date: 9/8/2020 11:19:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DTUsageMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_lic_botClient]    Script Date: 9/8/2020 11:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_lic_botClient](
	[Id] [uniqueidentifier] NOT NULL,
	[company_id] [uniqueidentifier] NOT NULL,
	[machineId] [int] NOT NULL,
	[machineName] [varchar](100) NOT NULL,
	[createdOn] [datetime] NOT NULL,
	[status] [bit] NOT NULL,
	[modifiedOn] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_lic_clientcompanyDetails]    Script Date: 9/8/2020 11:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_lic_clientcompanyDetails](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](256) NOT NULL,
	[address] [varchar](256) NULL,
	[contactEmailId] [nvarchar](256) NOT NULL,
	[contactMobile] [nvarchar](20) NULL,
	[validFrom] [datetime] NOT NULL,
	[validTo] [datetime] NOT NULL,
	[botInstances] [int] NOT NULL,
	[status] [bit] NOT NULL,
	[createdBy] [varchar](500) NOT NULL,
	[createdOn] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_lic_clientSide]    Script Date: 9/8/2020 11:19:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_lic_clientSide](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SerialKey] [nvarchar](500) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_lic_company]    Script Date: 9/8/2020 11:19:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_lic_company](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](256) NOT NULL,
	[address] [varchar](1000) NULL,
	[contactEmailId] [nvarchar](256) NOT NULL,
	[contactMobile] [varchar](20) NULL,
	[serialKey] [uniqueidentifier] NOT NULL,
	[validFrom] [datetime] NOT NULL,
	[validTo] [datetime] NOT NULL,
	[botInstances] [int] NOT NULL,
	[status] [bit] NOT NULL,
	[createdBy] [varchar](500) NOT NULL,
	[createdOn] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_lic_companyDetails]    Script Date: 9/8/2020 11:19:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_lic_companyDetails](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](256) NOT NULL,
	[address] [varchar](1000) NULL,
	[contactEmailId] [nvarchar](256) NOT NULL,
	[contactMobile] [varchar](20) NULL,
	[validFrom] [datetime] NOT NULL,
	[validTo] [datetime] NOT NULL,
	[botInstances] [int] NOT NULL,
	[status] [bit] NOT NULL,
	[createdBy] [varchar](500) NOT NULL,
	[createdOn] [datetime] NOT NULL,
	[LicenseType] [int] NULL,
	[No_WorkFlows] [int] NULL,
	[No_Bots] [int] NULL,
	[Bot_Rate] [decimal](20, 2) NULL,
	[Prime_Bot_Rate] [decimal](20, 2) NULL,
	[Rate_Base] [int] NULL,
	[Rate] [decimal](20, 2) NULL,
	[Maintenance_Hours] [int] NULL,
	[Maintenance_Rate] [decimal](20, 2) NULL,
	[ProcessName] [nvarchar](255) NULL,
	[LicenseSlab] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_lic_controlTowerInfo]    Script Date: 9/8/2020 11:19:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_lic_controlTowerInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [uniqueidentifier] NOT NULL,
	[machineId] [int] NOT NULL,
	[machineName] [varchar](100) NOT NULL,
	[ipAddress] [varchar](100) NOT NULL,
	[status] [bit] NOT NULL,
	[createdOn] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_lic_exceptions]    Script Date: 9/8/2020 11:19:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_lic_exceptions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[process_id] [uniqueidentifier] NOT NULL,
	[botClient_id] [uniqueidentifier] NOT NULL,
	[errorMessage] [varchar](2000) NOT NULL,
	[errorEvent] [varchar](500) NOT NULL,
	[errorTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_lic_process]    Script Date: 9/8/2020 11:19:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_lic_process](
	[id] [uniqueidentifier] NOT NULL,
	[company_id] [uniqueidentifier] NOT NULL,
	[name] [varchar](500) NOT NULL,
	[description] [varchar](1000) NULL,
	[createdOn] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_lic_processTransaction]    Script Date: 9/8/2020 11:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_lic_processTransaction](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[process_id] [uniqueidentifier] NOT NULL,
	[botClient_id] [uniqueidentifier] NOT NULL,
	[domainName] [varchar](100) NOT NULL,
	[userName] [varchar](100) NOT NULL,
	[referenceId] [varchar](200) NOT NULL,
	[eventStart] [datetime] NOT NULL,
	[eventEnd] [datetime] NOT NULL,
	[status] [int] NULL,
	[exception] [varchar](4000) NULL,
	[MRN] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Echobot_LicenseDetails]    Script Date: 9/8/2020 11:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Echobot_LicenseDetails](
	[RecordNo] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[SerialKey] [nvarchar](2000) NULL,
	[MachineId] [nvarchar](2000) NULL,
	[MachineName] [nvarchar](1000) NULL,
	[KeyCreatedDate] [datetime] NULL,
	[KeyExpirationDate] [datetime] NULL,
	[KeyUpdatedDate] [datetime] NULL,
	[LicenseId] [nvarchar](2000) NULL,
	[EmailAddress] [nvarchar](200) NULL,
	[ActivationDate] [datetime] NULL,
	[IsActivated] [int] NULL,
	[IsActive] [int] NULL,
	[DeactivatedDate] [datetime] NULL,
	[RenewedDate] [datetime] NULL,
 CONSTRAINT [PK_Echobot_LicenseDetails] PRIMARY KEY CLUSTERED 
(
	[RecordNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_LicenseSlab]    Script Date: 9/8/2020 11:19:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_LicenseSlab](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[No_of_Workflows] [int] NOT NULL,
	[No_of_Bots] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_LicenseType]    Script Date: 9/8/2020 11:19:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_LicenseType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LicenseType] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_Roles]    Script Date: 9/8/2020 11:19:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_Roles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.echobot_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_UserClaims]    Script Date: 9/8/2020 11:19:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_UserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](max) NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
	[IdentityUser_Id] [nvarchar](128) NULL,
 CONSTRAINT [PK_dbo.echobot_UserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_UserLogins]    Script Date: 9/8/2020 11:19:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_UserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[IdentityUser_Id] [nvarchar](128) NULL,
 CONSTRAINT [PK_dbo.echobot_UserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_UserRoles]    Script Date: 9/8/2020 11:19:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_UserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
	[IdentityUser_Id] [nvarchar](128) NULL,
 CONSTRAINT [PK_dbo.echobot_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echobot_Users]    Script Date: 9/8/2020 11:19:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echobot_Users](
	[userId] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[Discriminator] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.echobot_Users] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echolock_Feb19]    Script Date: 9/8/2020 11:19:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echolock_Feb19](
	[EventDate] [date] NULL,
	[LOB] [nvarchar](255) NULL,
	[Client] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Process] [nvarchar](255) NULL,
	[Supervisor] [nvarchar](255) NULL,
	[Grade] [nvarchar](255) NULL,
	[UserAccount] [nvarchar](255) NULL,
	[Break] [nvarchar](255) NULL,
	[Discussion] [nvarchar](255) NULL,
	[Fire Drill] [nvarchar](255) NULL,
	[Fun Event] [nvarchar](255) NULL,
	[Health Issue] [nvarchar](255) NULL,
	[Lunch Break] [nvarchar](255) NULL,
	[Meeting] [nvarchar](255) NULL,
	[NoReason Update] [nvarchar](255) NULL,
	[One on One] [nvarchar](255) NULL,
	[Production] [nvarchar](255) NULL,
	[QA Feedback] [nvarchar](255) NULL,
	[System Downtime] [nvarchar](255) NULL,
	[Training] [nvarchar](255) NULL,
	[IT Issue - Internal/Client] [nvarchar](255) NULL,
	[HR Activity] [nvarchar](255) NULL,
	[TotalHrs] [nvarchar](255) NULL,
	[BreakHour] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[echolockBreakSplitup]    Script Date: 9/8/2020 11:19:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[echolockBreakSplitup](
	[EventDate] [date] NULL,
	[LOB] [varchar](100) NULL,
	[Client] [varchar](100) NULL,
	[Location] [varchar](100) NULL,
	[Process] [varchar](100) NULL,
	[Supervisor] [varchar](100) NULL,
	[Grade] [varchar](100) NULL,
	[UserAccount] [varchar](100) NULL,
	[Break] [bigint] NULL,
	[Discussion] [bigint] NULL,
	[Fire Drill] [bigint] NULL,
	[Fun Event] [bigint] NULL,
	[Health Issue] [bigint] NULL,
	[Lunch Break] [bigint] NULL,
	[Meeting] [bigint] NULL,
	[NoReason Update] [bigint] NULL,
	[One on One] [bigint] NULL,
	[Production] [bigint] NULL,
	[QA Feedback] [bigint] NULL,
	[System Downtime] [bigint] NULL,
	[Training] [bigint] NULL,
	[IT Issue - Internal/Client] [bigint] NULL,
	[HR Activity] [bigint] NULL,
	[TotalHrs] [bigint] NULL,
	[BreakHour] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 9/8/2020 11:19:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(18,2) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Empcode] [nvarchar](100) NULL,
	[Position] [nvarchar](100) NULL,
	[Office] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EncrFileDetails]    Script Date: 9/8/2020 11:19:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EncrFileDetails](
	[FileId] [int] IDENTITY(18,2) NOT NULL,
	[PathID] [int] NULL,
	[PasswordKey] [nvarchar](100) NULL,
	[FileKey] [nvarchar](100) NULL,
	[Active] [bit] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EncrFolderDetails]    Script Date: 9/8/2020 11:19:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EncrFolderDetails](
	[Pathid] [int] IDENTITY(18,2) NOT NULL,
	[FolderNamePath] [nvarchar](500) NULL,
	[Active] [bit] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Pathid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EncrUserDetails]    Script Date: 9/8/2020 11:19:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EncrUserDetails](
	[Accessid] [int] IDENTITY(18,2) NOT NULL,
	[PathID] [int] NULL,
	[AccessUser] [nvarchar](100) NULL,
	[Active] [bit] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Accessid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_BatchID]    Script Date: 9/8/2020 11:19:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_BatchID](
	[ID] [int] NOT NULL,
	[EOB_BatchID] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex]    Script Date: 9/8/2020 11:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SNo] [int] NULL,
	[BatchNo] [varchar](50) NULL,
	[EntityName] [varchar](20) NULL,
	[EntityValue] [varchar](max) NULL,
	[RegexPattern] [varchar](max) NULL,
	[RegexMatchedCount] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_06_10_2017]    Script Date: 9/8/2020 11:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_06_10_2017](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SNo] [int] NULL,
	[BatchNo] [varchar](50) NULL,
	[EntityName] [varchar](20) NULL,
	[EntityValue] [varchar](max) NULL,
	[RegexPattern] [varchar](max) NULL,
	[RegexMatchedCount] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_11thSep]    Script Date: 9/8/2020 11:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_11thSep](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SNo] [int] NULL,
	[BatchNo] [varchar](50) NULL,
	[EntityName] [varchar](20) NULL,
	[EntityValue] [varchar](max) NULL,
	[RegexPattern] [varchar](max) NULL,
	[RegexMatchedCount] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_BatchID]    Script Date: 9/8/2020 11:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_BatchID](
	[BatchNO] [nvarchar](255) NULL,
	[PayerName] [nvarchar](255) NULL,
	[Sno] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_BatchID_1]    Script Date: 9/8/2020 11:19:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_BatchID_1](
	[Sno] [float] NULL,
	[BatchNo] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_BatchID_Output]    Script Date: 9/8/2020 11:19:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_BatchID_Output](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sno] [int] NULL,
	[BatchNO] [varchar](200) NULL,
	[PayerName] [varchar](max) NULL,
	[MatchedHeader] [varchar](max) NULL,
	[MatchedNO] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_BatchID_Output_15thsep]    Script Date: 9/8/2020 11:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_BatchID_Output_15thsep](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sno] [int] NULL,
	[BatchNO] [varchar](200) NULL,
	[PayerName] [varchar](max) NULL,
	[MatchedHeader] [varchar](max) NULL,
	[MatchedNO] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_BatchID_Output_bk_10_24_17]    Script Date: 9/8/2020 11:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_BatchID_Output_bk_10_24_17](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sno] [int] NULL,
	[BatchNO] [varchar](200) NULL,
	[PayerName] [varchar](max) NULL,
	[MatchedHeader] [varchar](max) NULL,
	[MatchedNO] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_BatchID_Output1]    Script Date: 9/8/2020 11:19:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_BatchID_Output1](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sno] [int] NULL,
	[BatchNO] [varchar](200) NULL,
	[PayerName] [varchar](max) NULL,
	[MatchedHeader] [varchar](max) NULL,
	[MatchedNO] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_BatchID1]    Script Date: 9/8/2020 11:19:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_BatchID1](
	[BatchNO] [nvarchar](255) NULL,
	[PayerName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_bk_05_09_17]    Script Date: 9/8/2020 11:19:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_bk_05_09_17](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SNo] [int] NULL,
	[BatchNo] [varchar](50) NULL,
	[EntityName] [varchar](20) NULL,
	[EntityValue] [varchar](max) NULL,
	[RegexPattern] [varchar](max) NULL,
	[RegexMatchedCount] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Headers]    Script Date: 9/8/2020 11:19:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Headers](
	[PayerName] [varchar](max) NULL,
	[matchedheader] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Headers_Index]    Script Date: 9/8/2020 11:19:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Headers_Index](
	[EntityName] [nvarchar](max) NULL,
	[RegexPattern] [nvarchar](max) NULL,
	[Headers] [nvarchar](max) NULL,
	[Hno] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Headers111]    Script Date: 9/8/2020 11:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Headers111](
	[PayerName] [varchar](max) NULL,
	[matchedheader] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Input]    Script Date: 9/8/2020 11:19:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Input](
	[Sno] [float] NULL,
	[servicename] [nvarchar](255) NULL,
	[BatchNo] [nvarchar](255) NULL,
	[InvoiceID] [nvarchar](255) NULL,
	[FromDOS] [datetime] NULL,
	[ProcedureCode] [float] NULL,
	[Modifier1] [nvarchar](255) NULL,
	[Modifier2] [nvarchar](255) NULL,
	[Modifier3] [nvarchar](255) NULL,
	[AmountBilled] [float] NULL,
	[InsRespAmt] [float] NULL,
	[UnitsBilled] [float] NULL,
	[InsPackageName] [nvarchar](255) NULL,
	[InsRollupID] [float] NULL,
	[InsRollupName] [nvarchar](255) NULL,
	[InsPackageID] [float] NULL,
	[checkNo] [float] NULL,
	[pymtAmt] [float] NULL,
	[coPayTrAmt] [float] NULL,
	[coInsTrAmt] [float] NULL,
	[dedTrAmt] [float] NULL,
	[otherTrAmt] [float] NULL,
	[globalTrAmt] [float] NULL,
	[contrAdjAmt] [float] NULL,
	[capitationAmt] [float] NULL,
	[managedCareAmt] [float] NULL,
	[otherAdjAmt] [float] NULL,
	[remiReCode] [nvarchar](255) NULL,
	[pageNo] [float] NULL,
	[InterestAmt] [float] NULL,
	[CheckAmt] [float] NULL,
	[CheckDate] [datetime] NULL,
	[InsStatus] [float] NULL,
	[MemberIdPymnt] [nvarchar](255) NULL,
	[posteddt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Input1]    Script Date: 9/8/2020 11:19:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Input1](
	[Sno] [float] NULL,
	[BatchNo] [nvarchar](255) NULL,
	[servicename] [nvarchar](255) NULL,
	[InvoiceID] [nvarchar](255) NULL,
	[FromDOS] [datetime] NULL,
	[ProcedureCode] [float] NULL,
	[Modifier1] [nvarchar](255) NULL,
	[Modifier2] [nvarchar](255) NULL,
	[Modifier3] [nvarchar](255) NULL,
	[AmountBilled] [float] NULL,
	[InsRespAmt] [float] NULL,
	[UnitsBilled] [float] NULL,
	[InsPackageName] [nvarchar](255) NULL,
	[InsRollupID] [float] NULL,
	[InsRollupName] [nvarchar](255) NULL,
	[InsPackageID] [float] NULL,
	[checkNo] [float] NULL,
	[pymtAmt] [float] NULL,
	[coPayTrAmt] [float] NULL,
	[coInsTrAmt] [float] NULL,
	[dedTrAmt] [float] NULL,
	[otherTrAmt] [float] NULL,
	[globalTrAmt] [float] NULL,
	[contrAdjAmt] [float] NULL,
	[capitationAmt] [float] NULL,
	[managedCareAmt] [float] NULL,
	[otherAdjAmt] [float] NULL,
	[remiReCode] [nvarchar](255) NULL,
	[pageNo] [float] NULL,
	[InterestAmt] [float] NULL,
	[CheckAmt] [float] NULL,
	[CheckDate] [datetime] NULL,
	[InsStatus] [float] NULL,
	[MemberIdPymnt] [float] NULL,
	[posteddt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Input2]    Script Date: 9/8/2020 11:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Input2](
	[Sno] [nvarchar](255) NULL,
	[ServiceName] [nvarchar](255) NULL,
	[BatchNo] [nvarchar](255) NULL,
	[FromDOS] [nvarchar](255) NULL,
	[ToDOS] [nvarchar](255) NULL,
	[ProcedureCode] [nvarchar](255) NULL,
	[Modifier1] [nvarchar](255) NULL,
	[Modifier2] [nvarchar](255) NULL,
	[Modifier3] [nvarchar](255) NULL,
	[AmountBilled] [nvarchar](255) NULL,
	[UnitsBilled] [nvarchar](255) NULL,
	[InsRespAmt] [nvarchar](255) NULL,
	[InsPackageName] [nvarchar](255) NULL,
	[InsRollupID] [nvarchar](255) NULL,
	[InsRollupName] [nvarchar](255) NULL,
	[InsPackageID] [nvarchar](255) NULL,
	[checkNo] [nvarchar](255) NULL,
	[pymtAmt] [nvarchar](255) NULL,
	[coPayTrAmt] [nvarchar](255) NULL,
	[coInsTrAmt] [nvarchar](255) NULL,
	[dedTrAmt] [nvarchar](255) NULL,
	[otherTrAmt] [nvarchar](255) NULL,
	[globalTrAmt] [nvarchar](255) NULL,
	[contrAdjAmt] [nvarchar](255) NULL,
	[capitationAmt] [nvarchar](255) NULL,
	[managedCareAmt] [nvarchar](255) NULL,
	[otherAdjAmt] [nvarchar](255) NULL,
	[remiReCode] [nvarchar](255) NULL,
	[pageNo] [nvarchar](255) NULL,
	[InterestAmt] [nvarchar](255) NULL,
	[InsStatus] [nvarchar](255) NULL,
	[CheckAmt] [nvarchar](255) NULL,
	[CheckDate] [nvarchar](255) NULL,
	[posteddt] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Input3]    Script Date: 9/8/2020 11:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Input3](
	[FromDOS] [nvarchar](255) NULL,
	[ToDOS] [nvarchar](255) NULL,
	[ProcedureCode] [nvarchar](255) NULL,
	[Modifier1] [nvarchar](255) NULL,
	[Modifier2] [nvarchar](255) NULL,
	[Modifier3] [nvarchar](255) NULL,
	[AmountBilled] [nvarchar](255) NULL,
	[UnitsBilled] [nvarchar](255) NULL,
	[InsRespAmt] [nvarchar](255) NULL,
	[batchnum] [nvarchar](255) NULL,
	[insPackageID] [nvarchar](255) NULL,
	[chargeID] [nvarchar](255) NULL,
	[checkNo] [nvarchar](255) NULL,
	[pymtAmt] [nvarchar](255) NULL,
	[coPayTrAmt] [nvarchar](255) NULL,
	[coInsTrAmt] [nvarchar](255) NULL,
	[dedTrAmt] [nvarchar](255) NULL,
	[otherTrAmt] [nvarchar](255) NULL,
	[globalTrAmt] [nvarchar](255) NULL,
	[contrAdjAmt] [nvarchar](255) NULL,
	[capitationAmt] [nvarchar](255) NULL,
	[managedCareAmt] [nvarchar](255) NULL,
	[otherAdjAmt] [nvarchar](255) NULL,
	[remiReCode] [nvarchar](255) NULL,
	[pageNo] [nvarchar](255) NULL,
	[InterestAmt] [nvarchar](255) NULL,
	[CheckAmt] [nvarchar](255) NULL,
	[InsStatus] [nvarchar](255) NULL,
	[MemberIdPymnt] [nvarchar](255) NULL,
	[TypeOfInsurance] [nvarchar](255) NULL,
	[InvoiceID] [nvarchar](255) NULL,
	[PatientLastName] [nvarchar](255) NULL,
	[PatientFirstName] [nvarchar](255) NULL,
	[PatientMiddleName] [nvarchar](255) NULL,
	[MemberID] [nvarchar](255) NULL,
	[InsurancePackageID] [nvarchar](255) NULL,
	[BatchId] [nvarchar](255) NULL,
	[ScanDate] [nvarchar](255) NULL,
	[BatchNo] [nvarchar](255) NULL,
	[ClientId] [nvarchar](255) NULL,
	[ServiceId] [nvarchar](255) NULL,
	[BatchType] [nvarchar](255) NULL,
	[PgCount] [nvarchar](255) NULL,
	[UploadDt] [nvarchar](255) NULL,
	[PostedDt] [nvarchar](255) NULL,
	[ServiceId1] [nvarchar](255) NULL,
	[ServiceName] [nvarchar](255) NULL,
	[PayerId] [nvarchar](255) NULL,
	[PayerName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Input4]    Script Date: 9/8/2020 11:19:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Input4](
	[Sno] [int] NULL,
	[FromDOS] [nvarchar](255) NULL,
	[ToDOS] [nvarchar](255) NULL,
	[ProcedureCode] [nvarchar](255) NULL,
	[Modifier1] [nvarchar](255) NULL,
	[Modifier2] [nvarchar](255) NULL,
	[Modifier3] [nvarchar](255) NULL,
	[AmountBilled] [nvarchar](255) NULL,
	[UnitsBilled] [nvarchar](255) NULL,
	[InsRespAmt] [nvarchar](255) NULL,
	[batchnum] [nvarchar](255) NULL,
	[insPackageID] [nvarchar](255) NULL,
	[chargeID] [nvarchar](255) NULL,
	[checkNo] [nvarchar](255) NULL,
	[pymtAmt] [nvarchar](255) NULL,
	[coPayTrAmt] [nvarchar](255) NULL,
	[coInsTrAmt] [nvarchar](255) NULL,
	[dedTrAmt] [nvarchar](255) NULL,
	[otherTrAmt] [nvarchar](255) NULL,
	[globalTrAmt] [nvarchar](255) NULL,
	[contrAdjAmt] [nvarchar](255) NULL,
	[capitationAmt] [nvarchar](255) NULL,
	[managedCareAmt] [nvarchar](255) NULL,
	[otherAdjAmt] [nvarchar](255) NULL,
	[remiReCode] [nvarchar](255) NULL,
	[pageNo] [nvarchar](255) NULL,
	[InterestAmt] [nvarchar](255) NULL,
	[CheckAmt] [nvarchar](255) NULL,
	[InsStatus] [nvarchar](255) NULL,
	[MemberIdPymnt] [nvarchar](255) NULL,
	[TypeOfInsurance] [nvarchar](255) NULL,
	[InvoiceID] [nvarchar](255) NULL,
	[PatientLastName] [nvarchar](255) NULL,
	[PatientFirstName] [nvarchar](255) NULL,
	[PatientMiddleName] [nvarchar](255) NULL,
	[MemberID] [nvarchar](255) NULL,
	[InsurancePackageID] [nvarchar](255) NULL,
	[BatchId] [nvarchar](255) NULL,
	[ScanDate] [nvarchar](255) NULL,
	[BatchNo] [nvarchar](255) NULL,
	[ClientId] [nvarchar](255) NULL,
	[ServiceId] [nvarchar](255) NULL,
	[BatchType] [nvarchar](255) NULL,
	[PgCount] [nvarchar](255) NULL,
	[UploadDt] [nvarchar](255) NULL,
	[PostedDt] [nvarchar](255) NULL,
	[ServiceId1] [nvarchar](255) NULL,
	[ServiceName] [nvarchar](255) NULL,
	[PayerId] [nvarchar](255) NULL,
	[PayerName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Input5]    Script Date: 9/8/2020 11:19:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Input5](
	[batchnum] [nvarchar](255) NULL,
	[checkNo] [nvarchar](255) NULL,
	[pymtAmt] [nvarchar](255) NULL,
	[coPayTrAmt] [nvarchar](255) NULL,
	[coInsTrAmt] [nvarchar](255) NULL,
	[dedTrAmt] [nvarchar](255) NULL,
	[otherTrAmt] [nvarchar](255) NULL,
	[globalTrAmt] [nvarchar](255) NULL,
	[contrAdjAmt] [nvarchar](255) NULL,
	[capitationAmt] [nvarchar](255) NULL,
	[managedCareAmt] [nvarchar](255) NULL,
	[otherAdjAmt] [nvarchar](255) NULL,
	[remiReCode] [nvarchar](255) NULL,
	[InterestAmt] [nvarchar](255) NULL,
	[FromDOS] [datetime] NULL,
	[ProcedureCode] [nvarchar](255) NULL,
	[Modifier1] [nvarchar](255) NULL,
	[Modifier2] [nvarchar](255) NULL,
	[Modifier3] [nvarchar](255) NULL,
	[AmountBilled] [nvarchar](255) NULL,
	[UnitsBilled] [nvarchar](255) NULL,
	[InsRespAmt] [nvarchar](255) NULL,
	[InvoiceID] [nvarchar](255) NULL,
	[InsPackageID] [nvarchar](255) NULL,
	[InsPackageName] [nvarchar](255) NULL,
	[InsRollupID] [nvarchar](255) NULL,
	[InsRollupName] [nvarchar](255) NULL,
	[sno] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Input6]    Script Date: 9/8/2020 11:19:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Input6](
	[batchnum] [nvarchar](255) NULL,
	[checkNo] [nvarchar](255) NULL,
	[pymtAmt] [nvarchar](255) NULL,
	[coPayTrAmt] [nvarchar](255) NULL,
	[coInsTrAmt] [nvarchar](255) NULL,
	[dedTrAmt] [nvarchar](255) NULL,
	[otherTrAmt] [nvarchar](255) NULL,
	[globalTrAmt] [nvarchar](255) NULL,
	[contrAdjAmt] [nvarchar](255) NULL,
	[capitationAmt] [nvarchar](255) NULL,
	[managedCareAmt] [nvarchar](255) NULL,
	[otherAdjAmt] [nvarchar](255) NULL,
	[remiReCode] [nvarchar](255) NULL,
	[InterestAmt] [nvarchar](255) NULL,
	[FromDOS] [nvarchar](255) NULL,
	[ProcedureCode] [nvarchar](255) NULL,
	[Modifier1] [nvarchar](255) NULL,
	[Modifier2] [nvarchar](255) NULL,
	[Modifier3] [nvarchar](255) NULL,
	[AmountBilled] [nvarchar](255) NULL,
	[UnitsBilled] [nvarchar](255) NULL,
	[InsRespAmt] [nvarchar](255) NULL,
	[InvoiceID] [nvarchar](255) NULL,
	[InsPackageID] [nvarchar](255) NULL,
	[InsPackageName] [nvarchar](255) NULL,
	[InsRollupID] [nvarchar](255) NULL,
	[sno] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Output]    Script Date: 9/8/2020 11:19:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Output](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[Sno] [int] NULL,
	[BatchNO] [varchar](200) NULL,
	[PayerName] [varchar](max) NULL,
	[Hno] [int] NULL,
	[MatchedHeader] [varchar](max) NULL,
	[EntityName] [varchar](500) NULL,
	[RegexPattern] [varchar](max) NULL,
	[MatchedValues] [varchar](max) NULL,
	[DocumentLineNO] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Pattern_Input]    Script Date: 9/8/2020 11:19:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Pattern_Input](
	[BatchNo] [nvarchar](255) NULL,
	[PayerName] [nvarchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_TesseractHeaders]    Script Date: 9/8/2020 11:19:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_TesseractHeaders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Sno] [int] NULL,
	[BatchNO] [varchar](200) NULL,
	[PayerName] [varchar](max) NULL,
	[MatchedHeader] [varchar](max) NULL,
	[MatchedNO] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_TesseractHeaders1]    Script Date: 9/8/2020 11:19:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_TesseractHeaders1](
	[PayerName] [varchar](max) NULL,
	[matchedheader] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_TesseractHeaders111]    Script Date: 9/8/2020 11:19:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_TesseractHeaders111](
	[PayerName] [varchar](max) NULL,
	[matchedheader] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_test]    Script Date: 9/8/2020 11:19:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_test](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SNo] [int] NULL,
	[BatchNo] [varchar](50) NULL,
	[EntityName] [varchar](20) NULL,
	[EntityValue] [varchar](max) NULL,
	[RegexPattern] [varchar](max) NULL,
	[RegexMatchedCount] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegexMachedValue]    Script Date: 9/8/2020 11:19:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegexMachedValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SNo] [int] NULL,
	[BatchNo] [varchar](50) NULL,
	[EntityName] [varchar](20) NULL,
	[EntityValue] [varchar](max) NULL,
	[RegexMatchedValue] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ERROR_LOG]    Script Date: 9/8/2020 11:19:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERROR_LOG](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LOG_DESCRIPTION] [varchar](max) NULL,
	[FILE_NAME] [varchar](250) NULL,
	[ERROR_TYPE] [varchar](100) NULL,
	[INNER_EXCEPTION] [varchar](max) NULL,
	[APP_NAME] [varchar](100) NULL,
	[FUNCTION_NAME] [varchar](150) NULL,
	[CREATEDBY] [varchar](100) NULL,
	[CREATED_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventStore]    Script Date: 9/8/2020 11:19:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventStore](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[EventType] [nvarchar](255) NULL,
	[AggregateRootId] [uniqueidentifier] NOT NULL,
	[EventDate] [datetime] NOT NULL,
	[Sequence] [int] NOT NULL,
	[Data] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacilityMaster]    Script Date: 9/8/2020 11:19:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacilityMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FacilityID] [int] NOT NULL,
	[Facility] [varchar](60) NULL,
	[LocationID] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[FacilityCode] [varchar](10) NULL,
	[FacilityAddress] [varchar](250) NULL,
	[GstNo] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[FacilityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ftp_pacific_tProcess]    Script Date: 9/8/2020 11:19:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ftp_pacific_tProcess](
	[Pid] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [varchar](50) NULL,
	[SubCenter] [varchar](50) NULL,
	[ApplicationName] [varchar](15) NULL,
	[ProcessName] [varchar](30) NULL,
	[ProcessDate] [date] NULL,
	[FileName] [varchar](150) NULL,
	[FileServerPath] [varchar](300) NULL,
	[FileClientPath] [varchar](300) NULL,
	[FileSizeinServer] [varchar](10) NULL,
	[FileSizeinClient] [varchar](10) NULL,
	[FileStatus] [tinyint] NULL,
	[ProcessDateTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FTP_Processlog]    Script Date: 9/8/2020 11:19:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FTP_Processlog](
	[Logid] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [varchar](30) NULL,
	[Level] [varchar](max) NULL,
	[Callsite] [varchar](max) NULL,
	[Type] [varchar](max) NULL,
	[Message] [varchar](max) NULL,
	[StackTrace] [varchar](max) NULL,
	[InnerException] [varchar](max) NULL,
	[LoggedOnDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FTP_ProcessMaster]    Script Date: 9/8/2020 11:19:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FTP_ProcessMaster](
	[Processid] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [varchar](50) NULL,
	[InernalName] [varchar](50) NULL,
	[ProcessType] [varchar](30) NULL,
	[ServerIp] [varchar](50) NULL,
	[UserName] [varchar](30) NULL,
	[password] [varchar](30) NULL,
	[SourcePath] [varchar](1000) NULL,
	[DestinationPath] [varchar](1000) NULL,
	[DateFormat] [varchar](15) NULL,
	[FolderDate] [varchar](15) NULL,
	[AddiFolder] [varchar](30) NULL,
	[Conditions] [varchar](300) NULL,
	[Status] [int] NULL,
	[createdon] [datetime] NULL,
	[Createdby] [varchar](60) NULL,
	[Disableon] [datetime] NULL,
	[Disabledby] [varchar](60) NULL,
	[Comments] [varchar](300) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FTP_RuleSet]    Script Date: 9/8/2020 11:19:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FTP_RuleSet](
	[Name] [nvarchar](128) NOT NULL,
	[MajorVersion] [int] NOT NULL,
	[MinorVersion] [int] NOT NULL,
	[RuleSet] [ntext] NOT NULL,
	[Status] [smallint] NULL,
	[AssemblyPath] [nvarchar](256) NULL,
	[ActivityName] [nvarchar](128) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [pk_RuleSet] PRIMARY KEY CLUSTERED 
(
	[Name] ASC,
	[MajorVersion] ASC,
	[MinorVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FTP_tFileNameDetails]    Script Date: 9/8/2020 11:19:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FTP_tFileNameDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [varchar](100) NULL,
	[FileName] [varchar](200) NULL,
	[CheckedDate] [datetime] NULL,
	[Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FTP_tHolidaylist]    Script Date: 9/8/2020 11:19:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FTP_tHolidaylist](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [varchar](50) NULL,
	[Holiyday] [varchar](200) NULL,
	[Holiday_Date] [date] NULL,
	[isActive] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FTP_tMailDetails]    Script Date: 9/8/2020 11:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FTP_tMailDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ProcessName] [varchar](30) NULL,
	[From_Mailid] [varchar](300) NULL,
	[To_Mailid] [varchar](max) NULL,
	[Cc_Mailid] [varchar](max) NULL,
	[isActive] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FTP_XmlDetails]    Script Date: 9/8/2020 11:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FTP_XmlDetails](
	[Xmlid] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [varchar](50) NULL,
	[XMLparameter] [xml] NULL,
	[Createdon] [datetime] NULL,
	[Createdby] [varchar](50) NULL,
	[Status] [int] NULL,
	[Comments] [varchar](300) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FTPMovement_Track]    Script Date: 9/8/2020 11:19:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FTPMovement_Track](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [varchar](100) NULL,
	[ProcessName] [varchar](30) NULL,
	[ProcessDate] [date] NULL,
	[BatchNo] [varchar](300) NULL,
	[FiletakenPath] [varchar](300) NULL,
	[FilePlacedPath] [varchar](500) NULL,
	[FileTakenPathSize] [int] NULL,
	[FileplacedpathSize] [bigint] NULL,
	[FilePlacedStatus] [bigint] NULL,
	[ProcessCheck] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HAP_USAGE]    Script Date: 9/8/2020 11:19:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HAP_USAGE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PROCESS_NAME] [varchar](100) NULL,
	[PROJECT_NAME] [varchar](100) NULL,
	[ECHOBOT_ID] [varchar](100) NULL,
	[ACCOUNT_UNIQUEID] [varchar](100) NULL,
	[DOS_OR_ENCOUNTER] [varchar](100) NULL,
	[CODED NOTES] [varchar](255) NULL,
	[NOTES] [varchar](255) NULL,
	[ACTION TAKEN] [varchar](255) NULL,
	[REVIEW DATE] [datetime] NULL,
	[START_TIME] [datetime] NULL,
	[END_TIME] [datetime] NULL,
	[TIME_TAKEN] [varchar](50) NULL,
	[STATUS] [int] NULL,
	[PROCESS_STATUS] [varchar](100) NULL,
	[USER_NAME] [varchar](100) NULL,
	[EXCEPTION] [varchar](max) NULL,
	[IS_TRANSFERED] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthFirst_Test]    Script Date: 9/8/2020 11:19:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthFirst_Test](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [varchar](50) NULL,
	[Status] [varchar](1000) NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HR_Functionality]    Script Date: 9/8/2020 11:19:54 PM ******/
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
	[FunctionalityId] [int] IDENTITY(1,1) NOT NULL,
	[JobTitle] [varchar](100) NULL,
	[Type] [varchar](50) NULL,
	[JOB_CATEGORY_ID] [int] NULL,
 CONSTRAINT [PK_HF_FunctionalityId] PRIMARY KEY CLUSTERED 
(
	[FunctionalityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 9/8/2020 11:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[FIN] [bigint] IDENTITY(1,1) NOT NULL,
	[TaskID] [int] NULL,
	[ReferenceCode] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryMaster]    Script Date: 9/8/2020 11:19:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryMaster](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [varchar](100) NOT NULL,
	[StockQty] [int] NOT NULL,
	[ReorderQty] [int] NOT NULL,
	[PriorityStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[iRuleTable]    Script Date: 9/8/2020 11:19:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[iRuleTable](
	[RuleSetName] [varchar](max) NULL,
	[RuleName] [varchar](max) NULL,
	[Condition] [varchar](max) NULL,
	[ThenAction] [varchar](max) NULL,
	[ElseAction] [varchar](max) NULL,
	[RuleSetPriority] [int] NULL,
	[RulePriority] [int] NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JsonStructureMaster]    Script Date: 9/8/2020 11:19:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JsonStructureMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[JSonTypeWorkflowOrData] [varchar](16) NOT NULL,
	[JSon] [varchar](max) NOT NULL,
	[VersionId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Designer]    Script Date: 9/8/2020 11:19:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Designer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModuleId] [int] NULL,
	[ImgJson] [varchar](max) NULL,
	[TokenKey] [varchar](2050) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserName] [varchar](650) NULL,
	[FileName] [varchar](650) NULL,
	[Status] [varchar](150) NULL,
	[SubModuleId] [int] NULL,
	[AudioFiles] [varchar](max) NULL,
 CONSTRAINT [PK_LMS_Designer12] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Designer_Test]    Script Date: 9/8/2020 11:19:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Designer_Test](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModuleId] [int] NULL,
	[ImgJson] [varchar](max) NULL,
	[TokenKey] [varchar](2050) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserName] [varchar](650) NULL,
	[FileName] [varchar](650) NULL,
	[Status] [varchar](150) NULL,
	[SubModuleId] [int] NULL,
	[AudioFiles] [varchar](max) NULL,
 CONSTRAINT [PK_LMS_Designer_Test12] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Modules]    Script Date: 9/8/2020 11:19:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Modules](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [varchar](250) NULL,
	[Description] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserName] [varchar](650) NULL,
	[Status] [varchar](50) NULL,
	[ModuleOverview] [varchar](max) NULL,
	[IsARCalling] [bit] NULL,
	[VoiceIndex] [int] NULL,
	[MarkThreshold] [int] NULL,
	[TimeOutDuration] [varchar](200) NULL,
	[Teamid] [int] NULL,
 CONSTRAINT [PK_LMS_Modules] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Modules_Test]    Script Date: 9/8/2020 11:19:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Modules_Test](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [varchar](250) NULL,
	[Description] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserName] [varchar](650) NULL,
	[Status] [varchar](50) NULL,
	[ModuleOverview] [varchar](max) NULL,
	[IsARCalling] [bit] NULL,
	[VoiceIndex] [int] NULL,
	[MarkThreshold] [int] NULL,
	[TimeOutDuration] [varchar](200) NULL,
	[Teamid] [int] NULL,
 CONSTRAINT [PK_LMS_Modules_Test] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Roles]    Script Date: 9/8/2020 11:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Roles](
	[roleid] [int] IDENTITY(1,1) NOT NULL,
	[rolename] [varchar](60) NULL,
	[created_user] [varchar](60) NULL,
	[created_date] [datetime] NULL,
	[modified_user] [varchar](60) NULL,
	[modified_date] [datetime] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[roleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Roles_Test]    Script Date: 9/8/2020 11:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Roles_Test](
	[roleid] [int] IDENTITY(1,1) NOT NULL,
	[rolename] [varchar](60) NULL,
	[created_user] [varchar](60) NULL,
	[created_date] [datetime] NULL,
	[modified_user] [varchar](60) NULL,
	[modified_date] [datetime] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[roleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Team]    Script Date: 9/8/2020 11:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Team](
	[teamid] [int] IDENTITY(1,1) NOT NULL,
	[team_name] [varchar](max) NOT NULL,
	[created_user] [varchar](60) NULL,
	[created_date] [datetime] NULL,
	[modified_user] [varchar](60) NULL,
	[modified_date] [datetime] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[teamid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Team_Test]    Script Date: 9/8/2020 11:20:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Team_Test](
	[teamid] [int] IDENTITY(1,1) NOT NULL,
	[team_name] [varchar](max) NOT NULL,
	[created_user] [varchar](60) NULL,
	[created_date] [datetime] NULL,
	[modified_user] [varchar](60) NULL,
	[modified_date] [datetime] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[teamid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_TestResults]    Script Date: 9/8/2020 11:20:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_TestResults](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModuleId] [int] NULL,
	[InTime] [datetime] NULL,
	[OutTime] [datetime] NULL,
	[AttendedDate] [datetime] NULL,
	[UserName] [varchar](650) NULL,
	[CorrectStepCount] [int] NULL,
	[InCorrectStepCount] [int] NULL,
	[TotalScore] [int] NULL,
	[TotalSessionTime] [varchar](50) NULL,
	[Status] [varchar](750) NULL,
	[Result] [char](1) NULL,
	[Retake] [int] NULL,
 CONSTRAINT [PK_LMS_TestResults] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_TestResults_Test]    Script Date: 9/8/2020 11:20:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_TestResults_Test](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModuleId] [int] NULL,
	[InTime] [datetime] NULL,
	[OutTime] [datetime] NULL,
	[AttendedDate] [datetime] NULL,
	[UserName] [varchar](650) NULL,
	[CorrectStepCount] [int] NULL,
	[InCorrectStepCount] [int] NULL,
	[TotalScore] [int] NULL,
	[TotalSessionTime] [varchar](50) NULL,
	[Status] [varchar](750) NULL,
	[Result] [char](1) NULL,
	[Retake] [int] NULL,
 CONSTRAINT [PK_LMS_TestResults_Test] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_UserRoleMapping]    Script Date: 9/8/2020 11:20:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_UserRoleMapping](
	[userroleid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NULL,
	[roleid] [int] NULL,
	[created_user] [varchar](60) NULL,
	[created_date] [datetime] NULL,
	[modified_user] [varchar](60) NULL,
	[modified_date] [datetime] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[userroleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_UserRoleMapping_Test]    Script Date: 9/8/2020 11:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_UserRoleMapping_Test](
	[userroleid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NULL,
	[roleid] [int] NULL,
	[created_user] [varchar](60) NULL,
	[created_date] [datetime] NULL,
	[modified_user] [varchar](60) NULL,
	[modified_date] [datetime] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[userroleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Users]    Script Date: 9/8/2020 11:20:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Users](
	[userid] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](60) NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[phone] [varchar](15) NULL,
	[created_user] [varchar](60) NULL,
	[created_date] [datetime] NULL,
	[modified_user] [varchar](60) NULL,
	[modified_date] [datetime] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Users_Test]    Script Date: 9/8/2020 11:20:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Users_Test](
	[userid] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](60) NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[phone] [varchar](15) NULL,
	[created_user] [varchar](60) NULL,
	[created_date] [datetime] NULL,
	[modified_user] [varchar](60) NULL,
	[modified_date] [datetime] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_UserTeamMapping]    Script Date: 9/8/2020 11:20:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_UserTeamMapping](
	[userteamid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NULL,
	[teamid] [int] NULL,
	[created_user] [varchar](60) NULL,
	[created_date] [datetime] NULL,
	[modified_user] [varchar](60) NULL,
	[modified_date] [datetime] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[userteamid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_UserTeamMapping_Test]    Script Date: 9/8/2020 11:20:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_UserTeamMapping_Test](
	[userteamid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NULL,
	[teamid] [int] NULL,
	[created_user] [varchar](60) NULL,
	[created_date] [datetime] NULL,
	[modified_user] [varchar](60) NULL,
	[modified_date] [datetime] NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[userteamid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 9/8/2020 11:20:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Thread] [varchar](255) NOT NULL,
	[Level] [varchar](50) NOT NULL,
	[Logger] [varchar](255) NOT NULL,
	[Message] [varchar](4000) NOT NULL,
	[Exception] [varchar](2000) NULL,
	[Host] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 9/8/2020 11:20:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Level] [varchar](max) NOT NULL,
	[CallSite] [varchar](max) NOT NULL,
	[Type] [varchar](max) NOT NULL,
	[Message] [varchar](max) NOT NULL,
	[StackTrace] [varchar](max) NOT NULL,
	[InnerException] [varchar](max) NOT NULL,
	[AdditionalInfo] [varchar](max) NOT NULL,
	[LoggedOnDate] [datetime] NOT NULL,
 CONSTRAINT [pk_logs] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterFields]    Script Date: 9/8/2020 11:20:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterFields](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
 CONSTRAINT [PK_Proto_Fields] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OAuthToken_UserTable]    Script Date: 9/8/2020 11:20:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OAuthToken_UserTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](150) NOT NULL,
	[Password] [varchar](250) NOT NULL,
	[Role] [varchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PathDetails]    Script Date: 9/8/2020 11:20:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PathDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[scandate] [date] NULL,
	[batchpaths] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBusinessProcess]    Script Date: 9/8/2020 11:20:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBusinessProcess](
	[BpId] [int] IDENTITY(1,1) NOT NULL,
	[BpName] [nvarchar](50) NULL,
	[IndustryId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_AhsPlatformBusinessProcess] PRIMARY KEY CLUSTERED 
(
	[BpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBusinessProcessFields]    Script Date: 9/8/2020 11:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBusinessProcessFields](
	[FieldId] [int] IDENTITY(1,1) NOT NULL,
	[FieldName] [nvarchar](50) NULL,
	[FieldType] [nvarchar](50) NULL,
	[BpId] [int] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[ValidationJson] [nvarchar](max) NULL,
 CONSTRAINT [PK_AhsPlatformBusinessProcessFields] PRIMARY KEY CLUSTERED 
(
	[FieldId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBW_MailInformation]    Script Date: 9/8/2020 11:20:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBW_MailInformation](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [int] NOT NULL,
	[FromMailId] [varchar](200) NULL,
	[Subject] [varchar](500) NULL,
	[ReceivedDt] [datetime] NULL,
	[FileName] [varchar](100) NULL,
	[FolderPath] [varchar](100) NULL,
	[Status] [tinyint] NULL,
	[CreatedDt] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[MailBody] [varchar](max) NULL,
	[ConversationId] [varchar](250) NULL,
	[MessageId] [varchar](250) NULL,
	[WfId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWCities]    Script Date: 9/8/2020 11:20:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWCities](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](150) NOT NULL,
	[StateId] [int] NOT NULL,
	[Active] [int] NOT NULL,
	[Tier] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWCountries]    Script Date: 9/8/2020 11:20:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWCountries](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
	[CountryName] [varchar](150) NOT NULL,
	[PhoneCode] [int] NOT NULL,
	[Active] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWDocuments]    Script Date: 9/8/2020 11:20:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWDocuments](
	[FileId] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](50) NULL,
	[FilePath] [varchar](500) NULL,
	[WfId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[Description] [varchar](max) NULL,
	[DocCategory] [varchar](100) NULL,
	[DocName] [varchar](250) NULL,
	[Country] [varchar](100) NULL,
	[ValidFromDt] [date] NULL,
	[ValidToDt] [date] NULL,
	[ModifiedBy] [varchar](250) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_PBWDocuments] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWLanguageMaster]    Script Date: 9/8/2020 11:20:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWLanguageMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LanguageName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWMasterData]    Script Date: 9/8/2020 11:20:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWMasterData](
	[MasterDataId] [int] IDENTITY(1,1) NOT NULL,
	[WorkflowId] [int] NULL,
	[Field] [nvarchar](50) NULL,
	[Value] [nvarchar](2000) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_AhsPlatformMasterData] PRIMARY KEY CLUSTERED 
(
	[MasterDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWMasterdatamapping]    Script Date: 9/8/2020 11:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWMasterdatamapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[SubMasterID] [int] NOT NULL,
	[Wfid] [int] NOT NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWMenuMaster]    Script Date: 9/8/2020 11:20:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWMenuMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[SortBy] [int] NULL,
	[WfId] [int] NULL,
	[ActionName] [varchar](100) NULL,
	[ControllerName] [varchar](100) NULL,
	[ShowCountOnMenu] [tinyint] NULL,
	[OrderNo] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWMenuRoleMapping]    Script Date: 9/8/2020 11:20:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWMenuRoleMapping](
	[MenuRoleId] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_PBWMenuRoleMapping] PRIMARY KEY CLUSTERED 
(
	[MenuRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWStates]    Script Date: 9/8/2020 11:20:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWStates](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[StateName] [varchar](150) NOT NULL,
	[CountryId] [int] NULL,
	[Active] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWSubMenuMaster]    Script Date: 9/8/2020 11:20:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWSubMenuMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[MenuId] [int] NULL,
	[SortBy] [int] NULL,
	[WfId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWSubmenuRoleMapping]    Script Date: 9/8/2020 11:20:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWSubmenuRoleMapping](
	[SubMenuRoleId] [int] IDENTITY(1,1) NOT NULL,
	[SubMenuId] [int] NULL,
	[MenuId] [int] NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_PBWSubmenuRoleMapping] PRIMARY KEY CLUSTERED 
(
	[SubMenuRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWUserDesignation]    Script Date: 9/8/2020 11:20:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWUserDesignation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](1000) NULL,
	[RoleLevel] [int] NULL,
	[DepartmentId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[Band] [int] NULL,
	[RoleId] [int] NULL,
	[Grade] [varchar](100) NULL,
 CONSTRAINT [PK_AhsPlatformUserRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWUserMaster]    Script Date: 9/8/2020 11:20:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWUserMaster](
	[Id] [int] NOT NULL,
	[UniqueId] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[DepartmentId] [int] NULL,
	[RoleId] [int] NULL,
	[ClientId] [int] NULL,
	[EmailId] [nvarchar](50) NULL,
	[SupervisorId] [nvarchar](50) NULL,
	[UserLob] [varchar](100) NULL,
	[UserClient] [varchar](100) NULL,
	[UserImageName] [varchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[Active] [int] NULL,
	[Grade] [varchar](100) NULL,
	[ContactNo] [varchar](12) NULL,
	[LocationName] [varchar](256) NULL,
	[CountryId] [int] NULL,
	[EmpCode] [varchar](12) NULL,
	[DepartmentName] [varchar](256) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWusermaster_20191030]    Script Date: 9/8/2020 11:20:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWusermaster_20191030](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UniqueId] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[DepartmentId] [int] NULL,
	[RoleId] [int] NULL,
	[ClientId] [int] NULL,
	[EmailId] [nvarchar](50) NULL,
	[SupervisorId] [nvarchar](50) NULL,
	[UserLob] [varchar](100) NULL,
	[UserClient] [varchar](100) NULL,
	[UserImageName] [varchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[Active] [int] NULL,
	[Grade] [varchar](100) NULL,
	[ContactNo] [varchar](10) NULL,
	[LocationName] [varchar](512) NULL,
	[DepartmentName] [varchar](512) NULL,
	[CountryId] [int] NULL,
	[EmpCode] [varchar](12) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWusermaster_20200109]    Script Date: 9/8/2020 11:20:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWusermaster_20200109](
	[Id] [int] NOT NULL,
	[UniqueId] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[DepartmentId] [int] NULL,
	[RoleId] [int] NULL,
	[ClientId] [int] NULL,
	[EmailId] [nvarchar](50) NULL,
	[SupervisorId] [nvarchar](50) NULL,
	[UserLob] [varchar](100) NULL,
	[UserClient] [varchar](100) NULL,
	[UserImageName] [varchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[Active] [int] NULL,
	[Grade] [varchar](100) NULL,
	[ContactNo] [varchar](12) NULL,
	[LocationName] [varchar](256) NULL,
	[CountryId] [int] NULL,
	[EmpCode] [varchar](12) NULL,
	[DepartmentName] [varchar](256) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWUserProfile]    Script Date: 9/8/2020 11:20:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWUserProfile](
	[ProfileId] [int] IDENTITY(1,1) NOT NULL,
	[UniqueId] [varchar](256) NULL,
	[Client] [varchar](256) NULL,
	[Functionality] [varchar](256) NULL,
	[LOB] [varchar](256) NULL,
	[Process] [varchar](256) NULL,
	[LocationName] [varchar](256) NULL,
	[DepartmentName] [varchar](1000) NULL,
	[CountryId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWUserRoleMapping]    Script Date: 9/8/2020 11:20:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWUserRoleMapping](
	[UserWorkflowRoleId] [int] IDENTITY(1,1) NOT NULL,
	[WorkflowId] [int] NULL,
	[UniqueId] [nvarchar](50) NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_PBWUserRoleMapping] PRIMARY KEY CLUSTERED 
(
	[UserWorkflowRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkFlowException]    Script Date: 9/8/2020 11:20:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWWorkFlowException](
	[ExceptionId] [int] IDENTITY(1,1) NOT NULL,
	[WfId] [int] NULL,
	[ExceptionName] [nvarchar](50) NULL,
	[ExceptionJson] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_PBWWorkFlowException] PRIMARY KEY CLUSTERED 
(
	[ExceptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkFlowExceptionTransaction]    Script Date: 9/8/2020 11:20:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWWorkFlowExceptionTransaction](
	[ExceptionTransactionId] [int] IDENTITY(1,1) NOT NULL,
	[ExceptionId] [int] NULL,
	[FIN] [int] NULL,
	[WfID] [int] NULL,
	[ExceptionJson] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[rptTblSyncDate] [datetime] NULL,
	[rptTranRefId] [int] NULL,
 CONSTRAINT [PK_PBWWorkFlowExceptionTransaction] PRIMARY KEY CLUSTERED 
(
	[ExceptionTransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkFlowExceptionTransactionHistory]    Script Date: 9/8/2020 11:20:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWWorkFlowExceptionTransactionHistory](
	[ExceptionTransactionHistoryId] [int] IDENTITY(1,1) NOT NULL,
	[ExceptionTransactionId] [int] NULL,
	[ExceptionId] [int] NULL,
	[FIN] [int] NULL,
	[WfID] [int] NULL,
	[ExceptionJson] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[HCreatedBy] [nvarchar](50) NULL,
	[HCreatedDate] [datetime] NULL,
	[rptTblSyncDate] [datetime] NULL,
	[rptTranRefId] [int] NULL,
 CONSTRAINT [PK_PBWWorkFlowExceptionTransactionHistory] PRIMARY KEY CLUSTERED 
(
	[ExceptionTransactionHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkFlowMaster]    Script Date: 9/8/2020 11:20:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWWorkFlowMaster](
	[WorkFlowId] [int] IDENTITY(1,1) NOT NULL,
	[WorkFlowName] [nvarchar](50) NULL,
	[ClientId] [int] NULL,
	[BpId] [int] NULL,
	[WorkFlowJson] [nvarchar](max) NULL,
	[DataJson] [nvarchar](max) NULL,
	[ExpenseJson] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[Active] [bit] NULL,
	[Description] [nvarchar](500) NULL,
	[Version] [nvarchar](50) NULL,
	[WorkFlowVersionId] [int] NULL,
	[DataVersionId] [int] NULL,
	[IsWorkFlowActive] [bit] NULL,
	[IsDataActive] [bit] NULL,
	[SubVersion] [nvarchar](50) NULL,
	[RuleJSon] [varchar](max) NULL,
 CONSTRAINT [PK_AhsPlatformWorkFlowMaster] PRIMARY KEY CLUSTERED 
(
	[WorkFlowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkFlowRoleMaster]    Script Date: 9/8/2020 11:20:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWWorkFlowRoleMaster](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[WfId] [int] NULL,
	[HierarchyLevel] [int] NULL,
 CONSTRAINT [PK_PBWWorkFlowRoleMaster] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkflowTATDetails]    Script Date: 9/8/2020 11:20:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWWorkflowTATDetails](
	[TATID] [int] IDENTITY(1,1) NOT NULL,
	[WorkflowId] [int] NULL,
	[FIN] [int] NULL,
	[RoleId] [int] NULL,
	[EmailToUniqueId] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkflowTransaction]    Script Date: 9/8/2020 11:20:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWWorkflowTransaction](
	[WorkflowId] [int] NULL,
	[DataJson] [nvarchar](max) NULL,
	[WorkFlowStateId] [int] NULL,
	[RoleId] [int] NULL,
	[Status] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[Fin] [int] IDENTITY(1,1) NOT NULL,
	[RequestId] [bigint] NULL,
	[WorkflowVersion] [varchar](100) NULL,
	[WorkflowSubVersion] [varchar](100) NULL,
	[rptTblSyncDate] [datetime] NULL,
	[IsTranLastEntry] [bit] NULL,
	[rptTranRefId] [int] NULL,
	[ParentWorkFlowStateId] [int] NULL,
	[ParentFin] [int] NULL,
	[BucketInDate] [datetime] NULL,
	[BucketOutDate] [datetime] NULL,
 CONSTRAINT [PK_PBWWorkflowTransaction] PRIMARY KEY CLUSTERED 
(
	[Fin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkflowTransactionHistory]    Script Date: 9/8/2020 11:20:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWWorkflowTransactionHistory](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Fin] [nvarchar](50) NOT NULL,
	[WorkflowId] [int] NULL,
	[DataJson] [nvarchar](max) NULL,
	[WorkFlowStateId] [int] NULL,
	[RoleId] [int] NULL,
	[Status] [nvarchar](50) NULL,
	[UserId] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[RequestId] [bigint] NULL,
	[WorkflowVersion] [varchar](100) NULL,
	[WorkflowSubVersion] [varchar](100) NULL,
	[rptTblSyncDate] [datetime] NULL,
	[IsTranLastEntry] [bit] NULL,
	[rptTranRefId] [int] NULL,
	[ParentWorkFlowStateId] [int] NULL,
	[ParentFin] [int] NULL,
	[BucketDate] [datetime] NULL,
	[BucketInDate] [datetime] NULL,
	[BucketOutDate] [datetime] NULL,
 CONSTRAINT [PK_AhsPlatformWorkflowHistory] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkSpaceMaster]    Script Date: 9/8/2020 11:20:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWWorkSpaceMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WorkspaceName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCategoryItemMapping]    Script Date: 9/8/2020 11:20:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCategoryItemMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MasterID] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCityList]    Script Date: 9/8/2020 11:20:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCityList](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](100) NULL,
	[StateName] [nvarchar](100) NULL,
	[CountryName] [nvarchar](100) NULL,
 CONSTRAINT [PK_PCityList] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PClient]    Script Date: 9/8/2020 11:20:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PClient](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[IndustryId] [int] NULL,
	[ClientName] [nvarchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_AhsPlatformClient] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PDepartment]    Script Date: 9/8/2020 11:20:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PDepartment](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](50) NULL,
	[ClientId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_AhsPlatformDepartment] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PDWComponentInstance]    Script Date: 9/8/2020 11:20:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PDWComponentInstance](
	[InstanceId] [int] NOT NULL,
	[ServerId] [int] NOT NULL,
	[ComponentId] [int] NOT NULL,
	[Status] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ComponentInstance_1] PRIMARY KEY CLUSTERED 
(
	[InstanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PDWComponentMaster]    Script Date: 9/8/2020 11:20:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PDWComponentMaster](
	[ComponentId] [int] NOT NULL,
	[ComponentAssembly] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ComponentMaster] PRIMARY KEY CLUSTERED 
(
	[ComponentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PDWInventory]    Script Date: 9/8/2020 11:20:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PDWInventory](
	[FIN] [nvarchar](50) NOT NULL,
	[ProcessId] [int] NULL,
	[ReferenceCode] [nvarchar](250) NULL,
	[ReferenceCaption] [nvarchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[FIN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PDWLog]    Script Date: 9/8/2020 11:20:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PDWLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LogDate] [datetime] NULL,
	[Thread] [nvarchar](50) NULL,
	[LogType] [nvarchar](50) NULL,
	[Logger] [nvarchar](50) NULL,
	[Message] [nvarchar](max) NULL,
	[Exception] [varchar](2000) NULL,
 CONSTRAINT [PK_PDWLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PDWProcessQueue]    Script Date: 9/8/2020 11:20:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PDWProcessQueue](
	[PQId] [int] NOT NULL,
	[FIN] [nvarchar](50) NULL,
	[ComponentId] [int] NULL,
	[Stage] [nvarchar](50) NULL,
	[InstanceId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ProcessQueue] PRIMARY KEY CLUSTERED 
(
	[PQId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PDWProcessScheduler]    Script Date: 9/8/2020 11:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PDWProcessScheduler](
	[ProcessId] [int] NOT NULL,
	[ProcessDescription] [nvarchar](250) NULL,
	[ProcessJson] [nvarchar](max) NULL,
	[StartupJson] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ProcessScheduler] PRIMARY KEY CLUSTERED 
(
	[ProcessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PDWRunTimeEngine]    Script Date: 9/8/2020 11:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PDWRunTimeEngine](
	[ServerId] [int] NOT NULL,
	[ServerName] [nvarchar](50) NULL,
	[IPAddress] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_WorkFlowMaster] PRIMARY KEY CLUSTERED 
(
	[ServerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PIndustry]    Script Date: 9/8/2020 11:20:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PIndustry](
	[IndustryId] [int] IDENTITY(1,1) NOT NULL,
	[Industry] [nvarchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_AhsPlatformIndustry] PRIMARY KEY CLUSTERED 
(
	[IndustryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PItems]    Script Date: 9/8/2020 11:20:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PItems](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[UOM] [nvarchar](100) NOT NULL,
	[Price] [decimal](15, 2) NOT NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[Active] [bit] NULL,
	[Wfid] [int] NULL,
	[ParentCategory] [int] NULL,
	[SeatingCapacity] [nvarchar](50) NULL,
	[Kmslimit] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PItemVendorMapping]    Script Date: 9/8/2020 11:20:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PItemVendorMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VendorId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PLog]    Script Date: 9/8/2020 11:20:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Fin] [int] NULL,
	[LogType] [varchar](100) NULL,
	[LogMessage] [varchar](max) NULL,
	[LogStackTrace] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[WorkflowId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PMailTran]    Script Date: 9/8/2020 11:20:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMailTran](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FromMailId] [varchar](256) NULL,
	[ToMailIds] [varchar](max) NOT NULL,
	[CC] [varchar](max) NULL,
	[SubjectText] [varchar](max) NULL,
	[Body] [nvarchar](max) NULL,
	[MailStatus] [int] NULL,
	[IsHTML] [bit] NULL,
	[AttachmentPath] [varchar](max) NULL,
	[Fin] [int] NULL,
	[CreateDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](100) NULL,
	[WorkflowId] [int] NULL,
	[UserId] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_CODING_PROV]    Script Date: 9/8/2020 11:20:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_CODING_PROV](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DEPARTMENT] [varchar](150) NULL,
	[PLACEOFSERVICE] [varchar](150) NULL,
	[SERVICEPROVIDER] [varchar](100) NULL,
	[BILLINGPROVIDER] [varchar](100) NULL,
	[REFERRINGPROVIDER] [varchar](100) NULL,
	[SIGNER_DOC] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_CODING_TRANS_old]    Script Date: 9/8/2020 11:20:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_CODING_TRANS_old](
	[ECHO_ID] [int] IDENTITY(1,1) NOT NULL,
	[PROCESS_NAME] [varchar](100) NULL,
	[PROJECT_NAME] [varchar](100) NULL,
	[ECHOBOT_ID] [varchar](100) NULL,
	[ACCOUNT_UNIQUEID] [varchar](100) NULL,
	[SIGNER_DOC] [varchar](100) NULL,
	[ACC_SIGN_CON] [varchar](200) NULL,
	[OFFICEVISIT] [varchar](100) NULL,
	[START_TIME] [datetime] NULL,
	[END_TIME] [datetime] NULL,
	[STATUS] [int] NULL,
	[PROCESS_STATUS] [varchar](100) NULL,
	[Username] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_USAGE]    Script Date: 9/8/2020 11:20:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_USAGE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PROCESS_NAME] [varchar](100) NULL,
	[PROJECT_NAME] [varchar](100) NULL,
	[ECHOBOT_ID] [varchar](100) NULL,
	[ACCOUNT_UNIQUEID] [varchar](100) NULL,
	[DOS_OR_ENCOUNTER] [varchar](100) NULL,
	[START_TIME] [datetime] NULL,
	[END_TIME] [datetime] NULL,
	[TIME_TAKEN] [time](7) NULL,
	[STATUS] [int] NULL,
	[PROCESS_STATUS] [varchar](100) NULL,
	[USER_NAME] [varchar](100) NULL,
	[EXCEPTION] [varchar](max) NULL,
	[IS_TRANSFERED] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_USAGE_20200102]    Script Date: 9/8/2020 11:20:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_USAGE_20200102](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PROCESS_NAME] [varchar](100) NULL,
	[PROJECT_NAME] [varchar](100) NULL,
	[ECHOBOT_ID] [varchar](100) NULL,
	[ACCOUNT_UNIQUEID] [varchar](100) NULL,
	[DOS_OR_ENCOUNTER] [varchar](100) NULL,
	[START_TIME] [datetime] NULL,
	[END_TIME] [datetime] NULL,
	[TIME_TAKEN] [time](7) NULL,
	[STATUS] [int] NULL,
	[PROCESS_STATUS] [varchar](100) NULL,
	[USER_NAME] [varchar](100) NULL,
	[EXCEPTION] [varchar](max) NULL,
	[IS_TRANSFERED] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_CodingCurveList]    Script Date: 9/8/2020 11:20:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_CodingCurveList](
	[ClientID] [float] NULL,
	[ReportYear] [float] NULL,
	[CPTCode] [nvarchar](255) NULL,
	[Fee] [float] NULL,
	[NationalDistribution] [float] NULL,
	[TableName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_FinancialAnalysis]    Script Date: 9/8/2020 11:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_FinancialAnalysis](
	[ClientID] [float] NULL,
	[ReportYear] [float] NULL,
	[ReportMonth] [float] NULL,
	[ProviderName] [nvarchar](255) NULL,
	[Charges] [float] NULL,
	[Payments] [float] NULL,
	[Adjustments] [float] NULL,
	[AccountsReceivable] [float] NULL,
	[AROver120] [float] NULL,
	[ARDaysOutstanding] [float] NULL,
	[Unapplied] [float] NULL,
	[Refunds] [float] NULL,
	[DTID] [nvarchar](255) NULL,
	[Collection] [float] NULL,
	[Cleargage] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcessQueue]    Script Date: 9/8/2020 11:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessQueue](
	[PQID] [bigint] IDENTITY(1,1) NOT NULL,
	[FIN] [int] NULL,
	[ComponentID] [int] NULL,
	[Status] [int] NULL,
	[FileName] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcurementFacilityMaster]    Script Date: 9/8/2020 11:20:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcurementFacilityMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FacilityID] [int] NOT NULL,
	[Facility] [varchar](60) NULL,
	[LocationID] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[FacilityCode] [varchar](10) NULL,
	[FacilityAddress] [varchar](250) NULL,
	[GstNo] [varchar](50) NULL,
 CONSTRAINT [PK_ProcurementFacilityMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRuleMaster]    Script Date: 9/8/2020 11:20:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRuleMaster](
	[RuleId] [int] IDENTITY(1,1) NOT NULL,
	[RuleName] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[Condition] [nvarchar](max) NULL,
	[ThenAction] [nvarchar](max) NULL,
	[ElseAction] [nvarchar](max) NULL,
	[Priority] [int] NULL,
	[Message] [nvarchar](max) NULL,
	[WorkflowId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
 CONSTRAINT [PK_PRuleMaster] PRIMARY KEY CLUSTERED 
(
	[RuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRuleSet]    Script Date: 9/8/2020 11:20:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRuleSet](
	[RuleSetId] [int] IDENTITY(1,1) NOT NULL,
	[RuleSetName] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[AssociatedAssembly] [nvarchar](100) NULL,
	[Type] [nvarchar](50) NULL,
	[WorkflowId] [int] NULL,
	[Priority] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
 CONSTRAINT [PK_PRuleSet] PRIMARY KEY CLUSTERED 
(
	[RuleSetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRuleSetMapping]    Script Date: 9/8/2020 11:20:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRuleSetMapping](
	[MappingId] [int] IDENTITY(1,1) NOT NULL,
	[RuleSetId] [int] NOT NULL,
	[RuleId] [int] NOT NULL,
	[Version] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[WorkflowId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
 CONSTRAINT [PK_PRuleSetMapping] PRIMARY KEY CLUSTERED 
(
	[MappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PSubDepartment]    Script Date: 9/8/2020 11:20:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PSubDepartment](
	[SubdepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[SubDepartmentName] [nvarchar](50) NULL,
	[DepartmentId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_AhsPlatformSubDepartment] PRIMARY KEY CLUSTERED 
(
	[SubdepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PVendors]    Script Date: 9/8/2020 11:20:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PVendors](
	[VendorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](500) NULL,
	[VendorEmail] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[Active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[VendorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Query]    Script Date: 9/8/2020 11:20:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Query](
	[NOTE] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Query223232]    Script Date: 9/8/2020 11:20:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Query223232](
	[NOTE] [nvarchar](max) NULL,
	[PRACTICENAME] [nvarchar](255) NULL,
	[CLAIMID] [nvarchar](255) NULL,
	[IRCNAME] [nvarchar](255) NULL,
	[WORKLIST_LOCATION] [nvarchar](255) NULL,
	[OUTFLOWUSERLOCATION] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegexPattern_temp]    Script Date: 9/8/2020 11:20:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegexPattern_temp](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SNo] [int] NULL,
	[BatchNo] [varchar](50) NULL,
	[EntityName] [varchar](20) NULL,
	[EntityValue] [varchar](max) NULL,
	[RegexPattern] [varchar](max) NULL,
	[RegexPattern1] [varchar](max) NULL,
	[RegexMatchedCount] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptMapping]    Script Date: 9/8/2020 11:20:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptMapping](
	[MappingId] [int] IDENTITY(1,1) NOT NULL,
	[WorkflowId] [int] NULL,
	[DataJSonPoint] [nvarchar](1000) NULL,
	[rptColumnName] [nvarchar](100) NULL,
	[RowOrdinal] [int] NULL,
	[ParentColumn] [nvarchar](100) NULL,
	[DisplayName] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rptTransaction]    Script Date: 9/8/2020 11:20:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rptTransaction](
	[TranID] [int] IDENTITY(1,1) NOT NULL,
	[RowOrdinal] [int] NOT NULL,
	[ParentID] [int] NULL,
	[SourceColumn] [nvarchar](max) NULL,
	[nvarchar1] [nvarchar](max) NULL,
	[nvarchar2] [nvarchar](max) NULL,
	[nvarchar3] [nvarchar](max) NULL,
	[nvarchar4] [nvarchar](max) NULL,
	[nvarchar5] [nvarchar](max) NULL,
	[nvarchar6] [nvarchar](max) NULL,
	[nvarchar7] [nvarchar](max) NULL,
	[nvarchar8] [nvarchar](max) NULL,
	[nvarchar9] [nvarchar](max) NULL,
	[nvarchar10] [nvarchar](max) NULL,
	[nvarchar11] [nvarchar](max) NULL,
	[nvarchar12] [nvarchar](max) NULL,
	[nvarchar13] [nvarchar](max) NULL,
	[nvarchar14] [nvarchar](max) NULL,
	[nvarchar15] [nvarchar](max) NULL,
	[nvarchar16] [nvarchar](max) NULL,
	[nvarchar17] [nvarchar](max) NULL,
	[nvarchar18] [nvarchar](max) NULL,
	[nvarchar19] [nvarchar](max) NULL,
	[nvarchar20] [nvarchar](max) NULL,
	[nvarchar21] [nvarchar](max) NULL,
	[nvarchar22] [nvarchar](max) NULL,
	[nvarchar23] [nvarchar](max) NULL,
	[nvarchar24] [nvarchar](max) NULL,
	[nvarchar25] [nvarchar](max) NULL,
	[nvarchar26] [nvarchar](max) NULL,
	[nvarchar27] [nvarchar](max) NULL,
	[nvarchar28] [nvarchar](max) NULL,
	[nvarchar29] [nvarchar](max) NULL,
	[nvarchar30] [nvarchar](max) NULL,
	[nvarchar31] [nvarchar](max) NULL,
	[nvarchar32] [nvarchar](max) NULL,
	[nvarchar33] [nvarchar](max) NULL,
	[nvarchar34] [nvarchar](max) NULL,
	[nvarchar35] [nvarchar](max) NULL,
	[nvarchar36] [nvarchar](max) NULL,
	[nvarchar37] [nvarchar](max) NULL,
	[nvarchar38] [nvarchar](max) NULL,
	[nvarchar39] [nvarchar](max) NULL,
	[nvarchar40] [nvarchar](max) NULL,
	[nvarchar41] [nvarchar](max) NULL,
	[nvarchar42] [nvarchar](max) NULL,
	[nvarchar43] [nvarchar](max) NULL,
	[nvarchar44] [nvarchar](max) NULL,
	[nvarchar45] [nvarchar](max) NULL,
	[nvarchar46] [nvarchar](max) NULL,
	[nvarchar47] [nvarchar](max) NULL,
	[nvarchar48] [nvarchar](max) NULL,
	[nvarchar49] [nvarchar](max) NULL,
	[nvarchar50] [nvarchar](max) NULL,
	[float1] [float] NULL,
	[float2] [float] NULL,
	[float3] [float] NULL,
	[float4] [float] NULL,
	[float5] [float] NULL,
	[float6] [float] NULL,
	[float7] [float] NULL,
	[float8] [float] NULL,
	[float9] [float] NULL,
	[float10] [float] NULL,
	[int1] [int] NULL,
	[int2] [int] NULL,
	[int3] [int] NULL,
	[int4] [int] NULL,
	[int5] [int] NULL,
	[int6] [int] NULL,
	[int7] [int] NULL,
	[int8] [int] NULL,
	[bit1] [int] NULL,
	[bit2] [int] NULL,
	[bit3] [int] NULL,
	[bit4] [int] NULL,
	[datetime1] [datetime] NULL,
	[datetime2] [datetime] NULL,
	[datetime3] [datetime] NULL,
	[datetime4] [datetime] NULL,
	[datetime5] [datetime] NULL,
	[datetime6] [datetime] NULL,
	[datetime7] [datetime] NULL,
	[datetime8] [datetime] NULL,
	[rpt_CreatedDate] [datetime] NULL,
	[rpt_CreatedBy] [nvarchar](100) NULL,
	[rpt_ModifiedDate] [datetime] NULL,
	[rpt_ModifiedBy] [nvarchar](100) NULL,
	[WorkflowId] [int] NULL,
	[date1] [date] NULL,
	[date2] [date] NULL,
	[date3] [date] NULL,
	[date4] [date] NULL,
	[TranRefID] [varchar](10) NULL,
	[Fin] [int] NULL,
	[LogId] [int] NULL,
	[WorkFlowStateId] [int] NULL,
	[RoleId] [int] NULL,
	[Status] [nvarchar](100) NULL,
	[UserId] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](100) NULL,
	[LastModifiedDate] [datetime] NULL,
	[RequestId] [bigint] NULL,
	[WorkflowVersion] [nvarchar](100) NULL,
	[WorkflowSubVersion] [nvarchar](100) NULL,
	[IsTranLastEntry] [bit] NULL,
	[ParentGroupNo] [float] NULL,
	[BucketInDate] [datetime] NULL,
	[BucketOutDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TranID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavingsAcknowledgement]    Script Date: 9/8/2020 11:20:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavingsAcknowledgement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SolutionId] [uniqueidentifier] NULL,
	[TicketNo] [varchar](256) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavingsAddInventory]    Script Date: 9/8/2020 11:20:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavingsAddInventory](
	[InventoryId] [uniqueidentifier] NULL,
	[SolutionId] [uniqueidentifier] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[TicketNo] [varchar](256) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavingsFlatSavings]    Script Date: 9/8/2020 11:20:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavingsFlatSavings](
	[FTECostId] [uniqueidentifier] NULL,
	[SolutionId] [uniqueidentifier] NULL,
	[MonthName] [varchar](100) NULL,
	[YearNo] [int] NULL,
	[LOB] [varchar](256) NULL,
	[Functionality] [varchar](256) NULL,
	[Customer] [varchar](256) NULL,
	[Description] [varchar](max) NULL,
	[Attachments] [varchar](max) NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[ModifiedBy] [varchar](100) NULL,
	[Status] [varchar](100) NULL,
	[Type] [varchar](100) NULL,
	[SavingsMode] [varchar](1) NULL,
	[Title] [varchar](max) NULL,
	[SavingsILValue] [float] NULL,
	[SavingsOPSValue] [float] NULL,
	[SavingsFINValue] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavingsLog]    Script Date: 9/8/2020 11:20:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavingsLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[SolutionId] [uniqueidentifier] NULL,
	[LogType] [varchar](10) NULL,
	[LogMessage] [varchar](2000) NULL,
	[LogStackTrace] [varchar](8000) NULL,
	[AlertRequired] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[Log_Event] [varchar](100) NULL,
	[StartDateTime] [datetime] NULL,
	[EndDateTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavingsMicrosServiceRegistry]    Script Date: 9/8/2020 11:20:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavingsMicrosServiceRegistry](
	[RegisterId] [uniqueidentifier] NULL,
	[SolutionId] [uniqueidentifier] NULL,
	[TranROIMode] [varchar](256) NULL,
	[Status] [varchar](32) NULL,
	[LOB] [varchar](256) NULL,
	[Functionality] [varchar](256) NULL,
	[Customer] [varchar](256) NULL,
	[Description] [varchar](max) NULL,
	[Attachments] [varchar](max) NULL,
	[MicroServiceEffort] [varchar](32) NULL,
	[Title] [varchar](2000) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[TranROI] [int] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavingsRPASolutions]    Script Date: 9/8/2020 11:20:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavingsRPASolutions](
	[SolutionId] [uniqueidentifier] NULL,
	[SolutionName] [varchar](256) NULL,
	[SolId] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](256) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](256) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sheet1$]    Script Date: 9/8/2020 11:20:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sheet1$](
	[Name] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[UOM] [nvarchar](255) NULL,
	[Price] [nvarchar](255) NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[CreatedDate] [nvarchar](255) NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedDate] [nvarchar](255) NULL,
	[Active] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sheet133$]    Script Date: 9/8/2020 11:20:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sheet133$](
	[Input] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Condition] [nvarchar](255) NULL,
	[Parameter] [nvarchar](255) NULL,
	[Token ] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusNotes]    Script Date: 9/8/2020 11:20:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusNotes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [varchar](50) NULL,
	[ProcessFlow] [varchar](max) NULL,
	[DraftedNotes] [varchar](max) NULL,
	[ActualNotes] [varchar](max) NULL,
 CONSTRAINT [PK_StatusNotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SummaData]    Script Date: 9/8/2020 11:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SummaData](
	[NOTE] [varchar](max) NULL,
	[PRACTICENAME] [varchar](max) NULL,
	[CLAIMID] [varchar](max) NULL,
	[IRCNAME] [varchar](max) NULL,
	[WORKLIST_LOCATION] [varchar](max) NULL,
	[OUTFLOWUSERLOCATION] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_BOTRATE_DETAILS]    Script Date: 9/8/2020 11:20:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_BOTRATE_DETAILS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessId] [int] NULL,
	[LicenceType] [nvarchar](255) NULL,
	[YearlyCost] [int] NULL,
	[MonthlyCost] [int] NULL,
	[Bot] [int] NULL,
	[Botrate] [decimal](18, 0) NULL,
	[PrimeBot] [int] NULL,
	[PrimeBotRate] [int] NULL,
	[RateType] [nvarchar](255) NULL,
	[Rate] [int] NULL,
	[MaintenanceHours] [nvarchar](255) NULL,
	[MaintenanceRate] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[No_of_Workfolws] [int] NULL,
	[No_of_Bots] [int] NULL,
	[AmortizeMonth] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_Botrate_details_Audit]    Script Date: 9/8/2020 11:20:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_Botrate_details_Audit](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessId] [int] NULL,
	[LicenceType] [nvarchar](255) NULL,
	[YearlyCost] [int] NULL,
	[MonthlyCost] [int] NULL,
	[Bot] [int] NULL,
	[Botrate] [decimal](18, 0) NULL,
	[PrimeBot] [int] NULL,
	[PrimeBotRate] [int] NULL,
	[RateType] [nvarchar](255) NULL,
	[Rate] [int] NULL,
	[MaintenanceHours] [nvarchar](255) NULL,
	[MaintenanceRate] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[No_of_Workfolws] [int] NULL,
	[No_of_Bots] [int] NULL,
	[AmortizeMonth] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_kafka_log]    Script Date: 9/8/2020 11:20:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_kafka_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[servername] [nvarchar](max) NULL,
	[topicname] [nvarchar](max) NULL,
	[data] [nvarchar](max) NULL,
	[createdon] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLogin]    Script Date: 9/8/2020 11:20:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLogin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[Role] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRuleSet]    Script Date: 9/8/2020 11:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRuleSet](
	[RuleId] [int] IDENTITY(1,1) NOT NULL,
	[RulesJson] [varchar](max) NOT NULL,
	[ActionJson] [varchar](max) NOT NULL,
	[Condition] [varchar](max) NOT NULL,
	[ThenAction] [varchar](max) NULL,
	[ElseAction] [varchar](max) NULL,
	[ErrorMessage] [varchar](max) NULL,
	[CreatedBy] [varchar](250) NOT NULL,
	[CreatedDt] [datetime] NOT NULL,
	[ModifiedBy] [varchar](250) NULL,
	[ModifiedDt] [datetime] NULL,
	[Active] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Temp_DecisionTree_20180409]    Script Date: 9/8/2020 11:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp_DecisionTree_20180409](
	[DecisionId] [int] NOT NULL,
	[Name] [varchar](150) NULL,
	[Json] [varchar](max) NULL,
	[Client] [varchar](150) NULL,
	[BusinessProcess] [varchar](150) NULL,
	[SubProcess] [varchar](150) NULL,
	[SubClientGroup] [varchar](150) NULL,
	[UserId] [int] NULL,
	[SupervisorId] [int] NULL,
	[StatusId] [int] NULL,
	[ParentDecisionId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[IntegrationConfig] [varchar](max) NULL,
	[TokenKey] [varchar](150) NULL,
	[UserName] [varchar](500) NULL,
	[FolderId] [int] NULL,
	[CustomField] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempSavingsDetailed1#]    Script Date: 9/8/2020 11:20:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempSavingsDetailed1#](
	[Vertical] [nvarchar](max) NULL,
	[OverAllConfirmedFTE] [int] NULL,
	[EnterpriseConfirmedFTE] [int] NULL,
	[MarqueeConfirmedFTE] [int] NULL,
	[NicheConfirmedFTE] [int] NULL,
	[Fin] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Test]    Script Date: 9/8/2020 11:20:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Age] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestTable]    Script Date: 9/8/2020 11:20:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTable](
	[EmpID] [int] IDENTITY(1,1) NOT NULL,
	[EmpName] [varchar](100) NOT NULL,
	[Salary] [int] NULL,
	[ManagerID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestUser]    Script Date: 9/8/2020 11:21:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Age] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_TestUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TranROI]    Script Date: 9/8/2020 11:21:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TranROI](
	[ROIId] [int] IDENTITY(1,1) NOT NULL,
	[Mode] [varchar](256) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VDS_DailerType]    Script Date: 9/8/2020 11:21:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VDS_DailerType](
	[Dialerid] [int] IDENTITY(1,1) NOT NULL,
	[DialerName] [varchar](30) NULL,
	[DailerURL] [varchar](300) NULL,
	[isActive] [bit] NULL,
	[DesiredBrowser] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Dialerid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VDS_ProcessMaster]    Script Date: 9/8/2020 11:21:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VDS_ProcessMaster](
	[Processid] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [varchar](150) NULL,
	[ProcessName] [varchar](150) NULL,
	[PrimaryDial] [int] NULL,
	[SecondaryDial] [int] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Processid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VDS_RoleMaster]    Script Date: 9/8/2020 11:21:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VDS_RoleMaster](
	[Roleid] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](100) NULL,
	[isActive] [bit] NULL,
	[comments] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Roleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VDS_tErrorLog]    Script Date: 9/8/2020 11:21:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VDS_tErrorLog](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorDate] [datetime] NULL,
	[Username] [nvarchar](50) NULL,
	[SystemIP] [varchar](16) NULL,
	[ErrorMessage] [varchar](max) NULL,
	[DialerId] [int] NULL,
	[StackTrace] [varchar](3000) NULL,
	[ProcessID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VDS_tLoginTrack]    Script Date: 9/8/2020 11:21:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VDS_tLoginTrack](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[SystemIP] [varchar](16) NULL,
	[LoginTime] [datetime] NULL,
	[DialerID] [int] NULL,
	[ProcessID] [int] NULL,
	[IsSuccess] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VDS_tUserLogin]    Script Date: 9/8/2020 11:21:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VDS_tUserLogin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AgentName] [varchar](100) NULL,
	[Dialerid] [int] NULL,
	[UserName] [varchar](200) NULL,
	[Password] [varchar](100) NULL,
	[PWD_Modifieddt] [datetime] NULL,
	[OldPassword] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VDS_UIControlMaster]    Script Date: 9/8/2020 11:21:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VDS_UIControlMaster](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DialerID] [int] NULL,
	[FieldName] [varchar](30) NULL,
	[Findby] [varchar](10) NULL,
	[Tagname] [varchar](15) NULL,
	[AttributeKey] [varchar](20) NULL,
	[AttributeValue] [varchar](30) NULL,
	[isActive] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VDS_UserMaster]    Script Date: 9/8/2020 11:21:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VDS_UserMaster](
	[Userid] [int] IDENTITY(1,1) NOT NULL,
	[AgentName] [varchar](100) NOT NULL,
	[SupervisiorName] [varchar](100) NULL,
	[Roleid] [int] NULL,
	[Processid] [int] NULL,
	[isActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AgentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VDS_VersionMaster]    Script Date: 9/8/2020 11:21:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VDS_VersionMaster](
	[VersionID] [int] IDENTITY(1,1) NOT NULL,
	[VersionNumber] [varchar](15) NOT NULL,
	[AppName] [varchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[Comments] [varchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[VersionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[VersionNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VDSNewUserlist]    Script Date: 9/8/2020 11:21:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VDSNewUserlist](
	[UserName] [varchar](75) NULL,
	[UserRole] [varchar](20) NULL,
	[PrimaryUserName] [varchar](150) NULL,
	[Primarypassword] [varchar](300) NULL,
	[SecondaryUserName] [varchar](150) NULL,
	[Secondarypassword] [varchar](300) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkFlowRedirectURL]    Script Date: 9/8/2020 11:21:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkFlowRedirectURL](
	[ID] [uniqueidentifier] NULL,
	[WorkflowId] [int] NULL,
	[WorkflowStateId] [int] NULL,
	[URL] [varchar](256) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ARC_AR_Callrecoding] ADD  DEFAULT (getdate()) FOR [Createddate]
GO
ALTER TABLE [dbo].[ARC_AR_Callrecoding] ADD  DEFAULT ((0)) FOR [Referenceid]
GO
ALTER TABLE [dbo].[ARC_AR_Callrecoding] ADD  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[ARC_AR_Callrecoding] ADD  DEFAULT ((0)) FOR [IsAPI]
GO
ALTER TABLE [dbo].[ARC_AR_Callrecoding] ADD  DEFAULT (NULL) FOR [calldate]
GO
ALTER TABLE [dbo].[ARC_AR_Callrecoding] ADD  DEFAULT (NULL) FOR [CallDirections]
GO
ALTER TABLE [dbo].[C3_AdminUsers] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_AdminUsers] ADD  DEFAULT ((0)) FOR [ControlAccess]
GO
ALTER TABLE [dbo].[C3_ADMN_DialerTypeMaster] ADD  CONSTRAINT [DF_C3_ADMN_DialerTypeMaster_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_ADMN_DialerTypeMaster] ADD  CONSTRAINT [DF_C3_ADMN_DialerTypeMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_AppLoginInfo] ADD  CONSTRAINT [DF_C3_AppLoginInfo_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_AppLoginInfo] ADD  CONSTRAINT [DF_C3_AppLoginInfo_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_CallRecordingExtensions] ADD  CONSTRAINT [DF_C3_CallRecordingExtensions_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_CallRecordingExtensions] ADD  CONSTRAINT [DF_C3_CallRecordingExtensions_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_ClaimNoUpdateLog] ADD  CONSTRAINT [DF_C3_ClaimNoUpdateLog_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_CustomerListFlow] ADD  CONSTRAINT [DF_C3_CustomerListFlow_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_CustomerListFlow] ADD  CONSTRAINT [DF_C3_CustomerListFlow_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_FileWatcher] ADD  CONSTRAINT [DF_C3_FileWatcher_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_FileWatcher] ADD  CONSTRAINT [DF_C3_FileWatcher_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_FileWatcherFileInfo] ADD  CONSTRAINT [DF_C3_FileWatcherFileInfo_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_GroupNameInfo] ADD  CONSTRAINT [DF_C3_GroupNameInfo_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_GroupNameInfo] ADD  CONSTRAINT [DF_C3_GroupNameInfo_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_RCDirectory] ADD  CONSTRAINT [DF_C3_RCDirectory_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_SchedulerExtension] ADD  CONSTRAINT [DF_C3_SchedulerExtension_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_SchedulerExtension] ADD  CONSTRAINT [DF_C3_SchedulerExtension_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_SchedulerLog] ADD  CONSTRAINT [DF_C3_SchedulerLog_IsSchedule]  DEFAULT ((1)) FOR [IsSchedule]
GO
ALTER TABLE [dbo].[C3_SchedulerLog] ADD  CONSTRAINT [DF_C3_SchedulerLog_StatusID]  DEFAULT ((0)) FOR [StatusID]
GO
ALTER TABLE [dbo].[C3_SchedulerLog] ADD  CONSTRAINT [DF_C3_SchedulerLog_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_SchedulerUserStatus] ADD  CONSTRAINT [DF_C3_SchedulerUserStatus_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_SchedulerUserStatus] ADD  CONSTRAINT [DF_C3_SchedulerUserStatus_IsRemove]  DEFAULT ((0)) FOR [IsRemove]
GO
ALTER TABLE [dbo].[C3_SchedulerUserStatus] ADD  CONSTRAINT [DF_C3_SchedulerUserStatus_ScheduleStatus]  DEFAULT ((0)) FOR [ScheduleStatus]
GO
ALTER TABLE [dbo].[C3_SchedulerUserStatus] ADD  CONSTRAINT [DF_C3_SchedulerUserStatus_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_UserMaster] ADD  CONSTRAINT [DF_C3_UserMaster_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_UserMaster] ADD  CONSTRAINT [DF_C3_UserMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_UserMaster] ADD  CONSTRAINT [DF_C3_UserMaster_IsURLError]  DEFAULT ((0)) FOR [IsURLError]
GO
ALTER TABLE [dbo].[C3_UserMaster] ADD  CONSTRAINT [DF_C3_UserMaster_DirectNo]  DEFAULT ((0)) FOR [DirectNo]
GO
ALTER TABLE [dbo].[C3_UserProfile] ADD  CONSTRAINT [DF_C3_UserProfile_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_UserProfile] ADD  CONSTRAINT [DF_C3_UserProfile_ModifiedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_UserProfileLog] ADD  CONSTRAINT [DF_C3_UserProfileLog_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_UserProfileLog] ADD  CONSTRAINT [DF_C3_UserProfileLog_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[C3_VendorMaster] ADD  CONSTRAINT [DF_C3_VendorMaster_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_VendorMaster] ADD  CONSTRAINT [DF_C3_VendorMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_VendorRole] ADD  CONSTRAINT [DF_C3_VendorRole_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[C3_VendorRole] ADD  CONSTRAINT [DF_C3_VendorRole_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_VoiceCallErrorLog] ADD  CONSTRAINT [DF_C3_VoiceCallErrorLog_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[C3_VoiceCallInfo] ADD  CONSTRAINT [DF_C3_VoiceCallInfo_Createddate]  DEFAULT (getdate()) FOR [Createddate]
GO
ALTER TABLE [dbo].[C3_VoiceCallInfo] ADD  CONSTRAINT [DF_C3_VoiceCallInfo_DURATION]  DEFAULT ((0)) FOR [Duration]
GO
ALTER TABLE [dbo].[C3_VoiceCallInfo] ADD  DEFAULT (NULL) FOR [SchedulerStatus]
GO
ALTER TABLE [dbo].[C3_VoiceCallInfoLog] ADD  CONSTRAINT [DF_C3_VoiceCallInfoLog_DURATION]  DEFAULT ((0)) FOR [Duration]
GO
ALTER TABLE [dbo].[C3_VoiceCallInfoLog] ADD  CONSTRAINT [DF_C3_VoiceCallInfoLog_Createddate]  DEFAULT (getdate()) FOR [Createddate]
GO
ALTER TABLE [dbo].[C3_VoiceCallInfoLog] ADD  CONSTRAINT [DF_C3_VoiceCallInfoLog_CallDate]  DEFAULT (CONVERT([date],dateadd(minute,(-630),getdate()))) FOR [CallDate]
GO
ALTER TABLE [dbo].[CT_BotStatusLog] ADD  CONSTRAINT [DF_CT_BotStatusLog_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[CT_BotStatusLog] ADD  CONSTRAINT [DF_CT_BotStatusLog_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[CT_PageAccess] ADD  CONSTRAINT [DF_CT_PageAccess_CanRead]  DEFAULT ((0)) FOR [CanRead]
GO
ALTER TABLE [dbo].[CT_PageAccess] ADD  CONSTRAINT [DF_CT_PageAccess_CanWrite]  DEFAULT ((0)) FOR [CanWrite]
GO
ALTER TABLE [dbo].[CT_PageAccess] ADD  CONSTRAINT [DF_CT_PageAccess_CanDelete]  DEFAULT ((0)) FOR [CanDelete]
GO
ALTER TABLE [dbo].[CT_Scheduler] ADD  CONSTRAINT [DF_CT_Scheduler_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[CT_Scheduler] ADD  CONSTRAINT [DF_CT_Scheduler_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[CT_SchedulerLog] ADD  CONSTRAINT [DF_CT_SchedulerLog_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[CT_SchedulerLog] ADD  CONSTRAINT [DF_CT_SchedulerLog_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[DecisionResults] ADD  CONSTRAINT [DF_DecisionResults_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[DecisionResults] ADD  CONSTRAINT [DF_DecisionResults_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[DecisionTreeLog] ADD  CONSTRAINT [DF_DecisionTreeLog_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[DecisionTreeLog] ADD  CONSTRAINT [DF_DecisionTreeLog_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[DecisionTreeResults] ADD  CONSTRAINT [DF_DecisionTreeResults_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[DecisionTreeResults] ADD  CONSTRAINT [DF_DecisionTreeResults_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[ERROR_LOG] ADD  DEFAULT (getdate()) FOR [CREATED_DATE]
GO
ALTER TABLE [dbo].[FTP_Processlog] ADD  DEFAULT (getutcdate()) FOR [LoggedOnDate]
GO
ALTER TABLE [dbo].[LMS_Designer] ADD  CONSTRAINT [DF_LMS_Designer12_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[LMS_Designer] ADD  CONSTRAINT [DF_LMS_Designer12_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[LMS_Roles] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[LMS_Roles_Test] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[LMS_Team] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[LMS_Team_Test] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[LMS_UserRoleMapping] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[LMS_UserRoleMapping_Test] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[LMS_Users] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[LMS_Users_Test] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[LMS_UserTeamMapping] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[LMS_UserTeamMapping_Test] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[Logs] ADD  CONSTRAINT [df_logs_loggedondate]  DEFAULT (getutcdate()) FOR [LoggedOnDate]
GO
ALTER TABLE [dbo].[OAuthToken_UserTable] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PBW_MailInformation] ADD  CONSTRAINT [DF__PBW_MailD__Statu__36B2B8F1]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[PBW_MailInformation] ADD  DEFAULT (getdate()) FOR [CreatedDt]
GO
ALTER TABLE [dbo].[PBWCities] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[PBWCountries] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[PBWMenuMaster] ADD  DEFAULT ((0)) FOR [ShowCountOnMenu]
GO
ALTER TABLE [dbo].[PBWStates] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[PBWWorkFlowMaster] ADD  DEFAULT ((0)) FOR [IsWorkFlowActive]
GO
ALTER TABLE [dbo].[PBWWorkFlowMaster] ADD  DEFAULT ((0)) FOR [IsDataActive]
GO
ALTER TABLE [dbo].[PBWWorkflowTransaction] ADD  DEFAULT (NULL) FOR [rptTblSyncDate]
GO
ALTER TABLE [dbo].[PBWWorkflowTransactionHistory] ADD  DEFAULT (NULL) FOR [rptTblSyncDate]
GO
ALTER TABLE [dbo].[PMailTran] ADD  DEFAULT ((0)) FOR [MailStatus]
GO
ALTER TABLE [dbo].[PRuleMaster] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PRuleSet] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PRuleSetMapping] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[rptMapping] ADD  DEFAULT ((0)) FOR [RowOrdinal]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [ParentID]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [SourceColumn]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar1]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar2]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar3]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar4]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar5]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar6]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar7]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar8]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar9]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar10]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar11]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar12]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar13]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar14]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar15]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar16]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar17]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar18]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar19]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar20]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar21]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar22]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar23]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar24]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar25]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar26]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar27]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar28]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar29]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar30]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar31]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar32]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar33]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar34]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar35]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar36]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar37]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar38]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar39]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar40]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar41]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar42]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar43]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar44]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar45]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar46]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar47]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar48]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar49]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [nvarchar50]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [float1]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [float2]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [float3]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [float4]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [float5]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [float6]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [float7]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [float8]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [float9]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [float10]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [int1]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [int2]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [int3]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [int4]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [int5]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [int6]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [int7]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [int8]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [bit1]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [bit2]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [bit3]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [bit4]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [datetime1]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [datetime2]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [datetime3]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [datetime4]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [datetime5]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [datetime6]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [datetime7]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [datetime8]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [date1]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [date2]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [date3]
GO
ALTER TABLE [dbo].[rptTransaction] ADD  DEFAULT (NULL) FOR [date4]
GO
ALTER TABLE [dbo].[SavingsAddInventory] ADD  DEFAULT (newid()) FOR [InventoryId]
GO
ALTER TABLE [dbo].[SavingsFlatSavings] ADD  DEFAULT (newid()) FOR [FTECostId]
GO
ALTER TABLE [dbo].[SavingsLog] ADD  DEFAULT ((0)) FOR [AlertRequired]
GO
ALTER TABLE [dbo].[SavingsMicrosServiceRegistry] ADD  DEFAULT (newid()) FOR [RegisterId]
GO
ALTER TABLE [dbo].[SavingsMicrosServiceRegistry] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[SavingsRPASolutions] ADD  DEFAULT (newid()) FOR [SolutionId]
GO
ALTER TABLE [dbo].[T_BOTRATE_DETAILS] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblRuleSet] ADD  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[TestUser] ADD  CONSTRAINT [DF_TestUser_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[WorkFlowRedirectURL] ADD  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[C3_AppLoginInfo]  WITH CHECK ADD  CONSTRAINT [FK_C3_AppLoginInfo_VendorID] FOREIGN KEY([VendorID])
REFERENCES [dbo].[C3_VendorMaster] ([VendorID])
GO
ALTER TABLE [dbo].[C3_AppLoginInfo] CHECK CONSTRAINT [FK_C3_AppLoginInfo_VendorID]
GO
ALTER TABLE [dbo].[C3_ClaimNoUpdateLog]  WITH CHECK ADD  CONSTRAINT [FK_C3_ClaimNoUpdateLog_SNO] FOREIGN KEY([SNO])
REFERENCES [dbo].[ARC_AR_Callrecoding] ([SNO])
GO
ALTER TABLE [dbo].[C3_ClaimNoUpdateLog] CHECK CONSTRAINT [FK_C3_ClaimNoUpdateLog_SNO]
GO
ALTER TABLE [dbo].[C3_GroupNameInfo]  WITH CHECK ADD  CONSTRAINT [FK_C3_GroupNameInfo_VendorID] FOREIGN KEY([VendorID])
REFERENCES [dbo].[C3_VendorMaster] ([VendorID])
GO
ALTER TABLE [dbo].[C3_GroupNameInfo] CHECK CONSTRAINT [FK_C3_GroupNameInfo_VendorID]
GO
ALTER TABLE [dbo].[C3_UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_C3_UserProfile_NewGroupID] FOREIGN KEY([GroupID])
REFERENCES [dbo].[C3_GroupNameInfo] ([GroupID])
GO
ALTER TABLE [dbo].[C3_UserProfile] CHECK CONSTRAINT [FK_C3_UserProfile_NewGroupID]
GO
ALTER TABLE [dbo].[C3_UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_C3_UserProfile_RoleID] FOREIGN KEY([RoleID])
REFERENCES [dbo].[C3_VendorRole] ([RoleID])
GO
ALTER TABLE [dbo].[C3_UserProfile] CHECK CONSTRAINT [FK_C3_UserProfile_RoleID]
GO
ALTER TABLE [dbo].[C3_UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_C3_UserProfile_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[C3_UserMaster] ([UserID])
GO
ALTER TABLE [dbo].[C3_UserProfile] CHECK CONSTRAINT [FK_C3_UserProfile_UserID]
GO
ALTER TABLE [dbo].[C3_UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_C3_UserProfile_VendorID] FOREIGN KEY([VendorID])
REFERENCES [dbo].[C3_VendorMaster] ([VendorID])
GO
ALTER TABLE [dbo].[C3_UserProfile] CHECK CONSTRAINT [FK_C3_UserProfile_VendorID]
GO
ALTER TABLE [dbo].[C3_UserProfileLog]  WITH CHECK ADD  CONSTRAINT [FK_C3_UserProfileLog_NewGroupID] FOREIGN KEY([GroupID])
REFERENCES [dbo].[C3_GroupNameInfo] ([GroupID])
GO
ALTER TABLE [dbo].[C3_UserProfileLog] CHECK CONSTRAINT [FK_C3_UserProfileLog_NewGroupID]
GO
ALTER TABLE [dbo].[C3_UserProfileLog]  WITH CHECK ADD  CONSTRAINT [FK_C3_UserProfileLog_RoleID] FOREIGN KEY([RoleID])
REFERENCES [dbo].[C3_VendorRole] ([RoleID])
GO
ALTER TABLE [dbo].[C3_UserProfileLog] CHECK CONSTRAINT [FK_C3_UserProfileLog_RoleID]
GO
ALTER TABLE [dbo].[C3_UserProfileLog]  WITH CHECK ADD  CONSTRAINT [FK_C3_UserProfileLog_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[C3_UserMaster] ([UserID])
GO
ALTER TABLE [dbo].[C3_UserProfileLog] CHECK CONSTRAINT [FK_C3_UserProfileLog_UserID]
GO
ALTER TABLE [dbo].[C3_UserProfileLog]  WITH CHECK ADD  CONSTRAINT [FK_C3_UserProfileLog_VendorID] FOREIGN KEY([VendorID])
REFERENCES [dbo].[C3_VendorMaster] ([VendorID])
GO
ALTER TABLE [dbo].[C3_UserProfileLog] CHECK CONSTRAINT [FK_C3_UserProfileLog_VendorID]
GO
ALTER TABLE [dbo].[C3_VendorRole]  WITH CHECK ADD  CONSTRAINT [FK_C3_VendorRole_VendorID] FOREIGN KEY([VendorID])
REFERENCES [dbo].[C3_VendorMaster] ([VendorID])
GO
ALTER TABLE [dbo].[C3_VendorRole] CHECK CONSTRAINT [FK_C3_VendorRole_VendorID]
GO
ALTER TABLE [dbo].[CRM_tUserLogin]  WITH CHECK ADD FOREIGN KEY([Dialerid])
REFERENCES [dbo].[CRM_DailerType] ([Dialerid])
GO
ALTER TABLE [dbo].[CRM_UIControlMaster]  WITH CHECK ADD FOREIGN KEY([DialerID])
REFERENCES [dbo].[CRM_DailerType] ([Dialerid])
GO
ALTER TABLE [dbo].[CRM_UserMaster]  WITH CHECK ADD FOREIGN KEY([Roleid])
REFERENCES [dbo].[CRM_RoleMaster] ([Roleid])
GO
ALTER TABLE [dbo].[CRM_UserMaster]  WITH CHECK ADD  CONSTRAINT [FK_UserMaster_ProcessMaster] FOREIGN KEY([Processid])
REFERENCES [dbo].[CRM_ProcessMaster] ([Processid])
GO
ALTER TABLE [dbo].[CRM_UserMaster] CHECK CONSTRAINT [FK_UserMaster_ProcessMaster]
GO
ALTER TABLE [dbo].[CT_EchoRemoteUserLog]  WITH CHECK ADD  CONSTRAINT [FK_CT_EchoRemoteUserLog_CT_EchoRemoteUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[CT_EchoRemoteUsers] ([Id])
GO
ALTER TABLE [dbo].[CT_EchoRemoteUserLog] CHECK CONSTRAINT [FK_CT_EchoRemoteUserLog_CT_EchoRemoteUsers]
GO
ALTER TABLE [dbo].[DecisionTreeResults]  WITH CHECK ADD FOREIGN KEY([DTused])
REFERENCES [dbo].[DTUsageMaster] ([Id])
GO
ALTER TABLE [dbo].[DT_Athena_KickcodeClaimTracking]  WITH CHECK ADD FOREIGN KEY([TeamID])
REFERENCES [dbo].[DT_Athena_TeamMaster] ([ID])
GO
ALTER TABLE [dbo].[DT_Athena_KickCodeGuide]  WITH NOCHECK ADD FOREIGN KEY([TeamID])
REFERENCES [dbo].[DT_Athena_TeamMaster] ([ID])
GO
ALTER TABLE [dbo].[DT_Athena_KickCodeTemplateList]  WITH NOCHECK ADD FOREIGN KEY([TeamID])
REFERENCES [dbo].[DT_Athena_TeamMaster] ([ID])
GO
ALTER TABLE [dbo].[DT_Athena_KickCodeTLAccess]  WITH CHECK ADD FOREIGN KEY([TeamID])
REFERENCES [dbo].[DT_Athena_TeamMaster] ([ID])
GO
ALTER TABLE [dbo].[echobot_lic_botClient]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[echobot_lic_companyDetails] ([id])
GO
ALTER TABLE [dbo].[echobot_lic_companyDetails]  WITH CHECK ADD FOREIGN KEY([LicenseType])
REFERENCES [dbo].[echobot_LicenseType] ([ID])
GO
ALTER TABLE [dbo].[echobot_lic_companyDetails]  WITH CHECK ADD FOREIGN KEY([LicenseSlab])
REFERENCES [dbo].[echobot_LicenseSlab] ([ID])
GO
ALTER TABLE [dbo].[echobot_lic_controlTowerInfo]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[echobot_lic_companyDetails] ([id])
GO
ALTER TABLE [dbo].[echobot_lic_process]  WITH CHECK ADD FOREIGN KEY([company_id])
REFERENCES [dbo].[echobot_lic_companyDetails] ([id])
GO
ALTER TABLE [dbo].[echobot_lic_processTransaction]  WITH CHECK ADD FOREIGN KEY([botClient_id])
REFERENCES [dbo].[echobot_lic_botClient] ([Id])
GO
ALTER TABLE [dbo].[echobot_lic_processTransaction]  WITH CHECK ADD FOREIGN KEY([botClient_id])
REFERENCES [dbo].[echobot_lic_botClient] ([Id])
GO
ALTER TABLE [dbo].[echobot_lic_processTransaction]  WITH CHECK ADD FOREIGN KEY([process_id])
REFERENCES [dbo].[echobot_lic_process] ([id])
GO
ALTER TABLE [dbo].[echobot_lic_processTransaction]  WITH CHECK ADD FOREIGN KEY([process_id])
REFERENCES [dbo].[echobot_lic_process] ([id])
GO
ALTER TABLE [dbo].[echobot_UserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.echobot_UserClaims_dbo.echobot_Users_IdentityUser_Id] FOREIGN KEY([IdentityUser_Id])
REFERENCES [dbo].[echobot_Users] ([userId])
GO
ALTER TABLE [dbo].[echobot_UserClaims] CHECK CONSTRAINT [FK_dbo.echobot_UserClaims_dbo.echobot_Users_IdentityUser_Id]
GO
ALTER TABLE [dbo].[echobot_UserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.echobot_UserLogins_dbo.echobot_Users_IdentityUser_Id] FOREIGN KEY([IdentityUser_Id])
REFERENCES [dbo].[echobot_Users] ([userId])
GO
ALTER TABLE [dbo].[echobot_UserLogins] CHECK CONSTRAINT [FK_dbo.echobot_UserLogins_dbo.echobot_Users_IdentityUser_Id]
GO
ALTER TABLE [dbo].[echobot_UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.echobot_UserRoles_dbo.echobot_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[echobot_Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[echobot_UserRoles] CHECK CONSTRAINT [FK_dbo.echobot_UserRoles_dbo.echobot_Roles_RoleId]
GO
ALTER TABLE [dbo].[echobot_UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.echobot_UserRoles_dbo.echobot_Users_IdentityUser_Id] FOREIGN KEY([IdentityUser_Id])
REFERENCES [dbo].[echobot_Users] ([userId])
GO
ALTER TABLE [dbo].[echobot_UserRoles] CHECK CONSTRAINT [FK_dbo.echobot_UserRoles_dbo.echobot_Users_IdentityUser_Id]
GO
ALTER TABLE [dbo].[LMS_Modules]  WITH CHECK ADD  CONSTRAINT [fk_teamid] FOREIGN KEY([Teamid])
REFERENCES [dbo].[LMS_Team] ([teamid])
GO
ALTER TABLE [dbo].[LMS_Modules] CHECK CONSTRAINT [fk_teamid]
GO
ALTER TABLE [dbo].[LMS_UserRoleMapping]  WITH CHECK ADD FOREIGN KEY([roleid])
REFERENCES [dbo].[LMS_Roles] ([roleid])
GO
ALTER TABLE [dbo].[LMS_UserRoleMapping]  WITH CHECK ADD FOREIGN KEY([userid])
REFERENCES [dbo].[LMS_Users] ([userid])
GO
ALTER TABLE [dbo].[LMS_UserRoleMapping_Test]  WITH CHECK ADD FOREIGN KEY([roleid])
REFERENCES [dbo].[LMS_Roles_Test] ([roleid])
GO
ALTER TABLE [dbo].[LMS_UserRoleMapping_Test]  WITH CHECK ADD FOREIGN KEY([userid])
REFERENCES [dbo].[LMS_Users_Test] ([userid])
GO
ALTER TABLE [dbo].[LMS_UserTeamMapping]  WITH CHECK ADD FOREIGN KEY([teamid])
REFERENCES [dbo].[LMS_Team] ([teamid])
GO
ALTER TABLE [dbo].[LMS_UserTeamMapping]  WITH CHECK ADD FOREIGN KEY([userid])
REFERENCES [dbo].[LMS_Users] ([userid])
GO
ALTER TABLE [dbo].[LMS_UserTeamMapping_Test]  WITH CHECK ADD FOREIGN KEY([teamid])
REFERENCES [dbo].[LMS_Team_Test] ([teamid])
GO
ALTER TABLE [dbo].[LMS_UserTeamMapping_Test]  WITH CHECK ADD FOREIGN KEY([userid])
REFERENCES [dbo].[LMS_Users_Test] ([userid])
GO
ALTER TABLE [dbo].[PBusinessProcessFields]  WITH CHECK ADD  CONSTRAINT [FK_PBusinessProcessFields_PBusinessProcess] FOREIGN KEY([BpId])
REFERENCES [dbo].[PBusinessProcess] ([BpId])
GO
ALTER TABLE [dbo].[PBusinessProcessFields] CHECK CONSTRAINT [FK_PBusinessProcessFields_PBusinessProcess]
GO
ALTER TABLE [dbo].[PBWMasterData]  WITH CHECK ADD  CONSTRAINT [FK_PBWMasterData_PBWWorkFlowMaster] FOREIGN KEY([WorkflowId])
REFERENCES [dbo].[PBWWorkFlowMaster] ([WorkFlowId])
GO
ALTER TABLE [dbo].[PBWMasterData] CHECK CONSTRAINT [FK_PBWMasterData_PBWWorkFlowMaster]
GO
ALTER TABLE [dbo].[PBWUserRoleMapping]  WITH CHECK ADD  CONSTRAINT [FK_PBWUserRoleMapping_PBWWorkFlowMaster] FOREIGN KEY([WorkflowId])
REFERENCES [dbo].[PBWWorkFlowMaster] ([WorkFlowId])
GO
ALTER TABLE [dbo].[PBWUserRoleMapping] CHECK CONSTRAINT [FK_PBWUserRoleMapping_PBWWorkFlowMaster]
GO
ALTER TABLE [dbo].[PBWUserRoleMapping]  WITH CHECK ADD  CONSTRAINT [FK_PBWUserRoleMapping_PBWWorkFlowRoleMaster] FOREIGN KEY([RoleId])
REFERENCES [dbo].[PBWWorkFlowRoleMaster] ([RoleId])
GO
ALTER TABLE [dbo].[PBWUserRoleMapping] CHECK CONSTRAINT [FK_PBWUserRoleMapping_PBWWorkFlowRoleMaster]
GO
ALTER TABLE [dbo].[PBWWorkFlowException]  WITH CHECK ADD  CONSTRAINT [FK_PBWWorkFlowException_PBWWorkFlowMaster] FOREIGN KEY([WfId])
REFERENCES [dbo].[PBWWorkFlowMaster] ([WorkFlowId])
GO
ALTER TABLE [dbo].[PBWWorkFlowException] CHECK CONSTRAINT [FK_PBWWorkFlowException_PBWWorkFlowMaster]
GO
ALTER TABLE [dbo].[PBWWorkFlowExceptionTransaction]  WITH CHECK ADD  CONSTRAINT [FK_PBWWorkFlowExceptionTransaction_PBWWorkFlowException] FOREIGN KEY([ExceptionId])
REFERENCES [dbo].[PBWWorkFlowException] ([ExceptionId])
GO
ALTER TABLE [dbo].[PBWWorkFlowExceptionTransaction] CHECK CONSTRAINT [FK_PBWWorkFlowExceptionTransaction_PBWWorkFlowException]
GO
ALTER TABLE [dbo].[PBWWorkFlowExceptionTransaction]  WITH CHECK ADD  CONSTRAINT [FK_PBWWorkFlowExceptionTransaction_PBWWorkflowTransaction] FOREIGN KEY([FIN])
REFERENCES [dbo].[PBWWorkflowTransaction] ([Fin])
GO
ALTER TABLE [dbo].[PBWWorkFlowExceptionTransaction] CHECK CONSTRAINT [FK_PBWWorkFlowExceptionTransaction_PBWWorkflowTransaction]
GO
ALTER TABLE [dbo].[PBWWorkFlowMaster]  WITH CHECK ADD  CONSTRAINT [FK_PBWWorkFlowMaster_PBusinessProcess] FOREIGN KEY([BpId])
REFERENCES [dbo].[PBusinessProcess] ([BpId])
GO
ALTER TABLE [dbo].[PBWWorkFlowMaster] CHECK CONSTRAINT [FK_PBWWorkFlowMaster_PBusinessProcess]
GO
ALTER TABLE [dbo].[PBWWorkFlowRoleMaster]  WITH CHECK ADD  CONSTRAINT [FK_PBWWorkFlowRoleMaster_PBWWorkFlowMaster] FOREIGN KEY([WfId])
REFERENCES [dbo].[PBWWorkFlowMaster] ([WorkFlowId])
GO
ALTER TABLE [dbo].[PBWWorkFlowRoleMaster] CHECK CONSTRAINT [FK_PBWWorkFlowRoleMaster_PBWWorkFlowMaster]
GO
ALTER TABLE [dbo].[PClient]  WITH CHECK ADD  CONSTRAINT [FK_PClient_PIndustry] FOREIGN KEY([IndustryId])
REFERENCES [dbo].[PIndustry] ([IndustryId])
GO
ALTER TABLE [dbo].[PClient] CHECK CONSTRAINT [FK_PClient_PIndustry]
GO
ALTER TABLE [dbo].[PRuleSetMapping]  WITH CHECK ADD  CONSTRAINT [FK_PRuleSetMapping_PRuleMaster] FOREIGN KEY([RuleId])
REFERENCES [dbo].[PRuleMaster] ([RuleId])
GO
ALTER TABLE [dbo].[PRuleSetMapping] CHECK CONSTRAINT [FK_PRuleSetMapping_PRuleMaster]
GO
ALTER TABLE [dbo].[PRuleSetMapping]  WITH CHECK ADD  CONSTRAINT [FK_PRuleSetMapping_PRuleSet] FOREIGN KEY([RuleSetId])
REFERENCES [dbo].[PRuleSet] ([RuleSetId])
GO
ALTER TABLE [dbo].[PRuleSetMapping] CHECK CONSTRAINT [FK_PRuleSetMapping_PRuleSet]
GO
ALTER TABLE [dbo].[PSubDepartment]  WITH CHECK ADD  CONSTRAINT [FK_PSubDepartment_PDepartment] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[PDepartment] ([DepartmentId])
GO
ALTER TABLE [dbo].[PSubDepartment] CHECK CONSTRAINT [FK_PSubDepartment_PDepartment]
GO
ALTER TABLE [dbo].[T_BOTRATE_DETAILS]  WITH CHECK ADD FOREIGN KEY([ProcessId])
REFERENCES [dbo].[CT_Process_Client] ([Id])
GO
ALTER TABLE [dbo].[VDS_tUserLogin]  WITH CHECK ADD FOREIGN KEY([Dialerid])
REFERENCES [dbo].[VDS_DailerType] ([Dialerid])
GO
ALTER TABLE [dbo].[VDS_UIControlMaster]  WITH CHECK ADD FOREIGN KEY([DialerID])
REFERENCES [dbo].[VDS_DailerType] ([Dialerid])
GO
ALTER TABLE [dbo].[VDS_UserMaster]  WITH CHECK ADD FOREIGN KEY([Roleid])
REFERENCES [dbo].[VDS_RoleMaster] ([Roleid])
GO
ALTER TABLE [dbo].[VDS_UserMaster]  WITH CHECK ADD  CONSTRAINT [FK_VDS_UserMaster_ProcessMaster] FOREIGN KEY([Processid])
REFERENCES [dbo].[VDS_ProcessMaster] ([Processid])
GO
ALTER TABLE [dbo].[VDS_UserMaster] CHECK CONSTRAINT [FK_VDS_UserMaster_ProcessMaster]
GO
