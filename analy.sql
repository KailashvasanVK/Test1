USE [Analytics]
GO
/****** Object:  UserDefinedFunction [dbo].[PPMReport_SplitStringfn]    Script Date: 9/10/2020 2:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[PPMReport_SplitStringfn]  
(@String varchar(MAX), @Delimiter char(1))    
RETURNS @temptable TABLE (items varchar(MAX))                     
AS             
BEGIN            
    declare @idx int             
    declare @slice varchar(MAX)             
    select @idx = 1             
        if len(@String)<1 or @String is null  return             
    while @idx!= 0             
    begin             
        set @idx = charindex(@Delimiter,@String)             
        if @idx!=0             
            set @slice = left(@String,@idx - 1)             
        else             
            set @slice = @String             
        if(len(@slice)>0)        
            insert into @temptable(Items) values(@slice)             
        set @String = right(@String,len(@String) - @idx)             
        if len(@String) = 0 break             
    END         
RETURN       
END   
  
GO
/****** Object:  UserDefinedFunction [dbo].[RANDBETWEEN]    Script Date: 9/10/2020 2:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[RANDBETWEEN](@LowerBound INT, @UpperBound INT)
RETURNS INT
AS
BEGIN
    DECLARE @TMP FLOAT;
    SELECT @TMP = (SELECT MyRAND FROM Get_RAND);
    RETURN CAST(@TMP* (@UpperBound - @LowerBound) + @LowerBound AS INT);
END
GO
/****** Object:  UserDefinedFunction [dbo].[Random]    Script Date: 9/10/2020 2:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Random] (@Upper INT,@Lower INT, @randomvalue numeric(18,10))
RETURNS INT
AS
BEGIN
DECLARE @Random INT
SELECT @Random = ROUND(((@Upper - @Lower -1) * @randomvalue + @Lower), 0)
RETURN @Random
END;
GO
/****** Object:  Table [dbo].[stock_report_final]    Script Date: 9/10/2020 2:50:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stock_report_final](
	[Claim ID] [nvarchar](255) NULL,
	[Transfer Type] [nvarchar](255) NULL,
	[A] [nvarchar](255) NULL,
	[Claim Status] [nvarchar](255) NULL,
	[B] [nvarchar](255) NULL,
	[Days in Status] [nvarchar](255) NULL,
	[Outstanding Amount] [float] NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Status Athena Kickcode] [nvarchar](255) NULL,
	[Current Error Text] [nvarchar](255) NULL,
	[C] [nvarchar](255) NULL,
	[Parent Worklist Name] [nvarchar](255) NULL,
	[Sub Worklist Name] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Worklist Team Organization] [nvarchar](255) NULL,
	[Workflow Type] [nvarchar](255) NULL,
	[Worklist Location] [nvarchar](255) NULL,
	[Priority] [nvarchar](255) NULL,
	[Worked] [nvarchar](255) NULL,
	[Total Athena Days] [nvarchar](255) NULL,
	[Prescribed YN] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[ONLY_claimid]  AS (substring([Claim ID],(0),charindex('-',[Claim ID]))),
	[service_date] [datetime] NULL,
	[claim_date]  AS (([claim id]+' ')+CONVERT([varchar](30),[date],(105)))
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Auto_post]    Script Date: 9/10/2020 2:50:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auto_post](
	[Claim ID] [varchar](255) NULL,
	[date] [datetime] NULL,
	[Days in Status] [varchar](255) NULL,
	[claim_date]  AS (([claim id]+' ')+CONVERT([varchar](30),[date],(105)))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Insurance package]    Script Date: 9/10/2020 2:50:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Insurance package] 
as
select sf.[Insurance Package],sf.[date]
	  ,count(sf.[claim id]) as cnt
 from Auto_post ap left join stock_report_final sf on ap.claim_date = sf.claim_date
 group by sf.[Insurance Package],sf.[date];
GO
/****** Object:  View [dbo].[Insurance Reporting Category]    Script Date: 9/10/2020 2:50:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Insurance Reporting Category] 
as
select sf.[Insurance Reporting Category],sf.[date]
	  ,count(sf.[claim id]) as cnt
 from Auto_post ap left join stock_report_final sf on ap.claim_date = sf.claim_date
 group by sf.[Insurance Reporting Category],sf.[date];
GO
/****** Object:  View [dbo].[Status Athena Kickcode]    Script Date: 9/10/2020 2:50:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Status Athena Kickcode] 
as
select sf.[Status Athena Kickcode],sf.[date]
	  ,count(sf.[claim id]) as cnt
 from Auto_post ap left join stock_report_final sf on ap.claim_date = sf.claim_date
 group by sf.[Status Athena Kickcode],sf.[date];
GO
/****** Object:  View [dbo].[Parent Worklist Name]    Script Date: 9/10/2020 2:50:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Parent Worklist Name] 
as
select sf.[Parent Worklist Name],sf.[date]
	  ,count(sf.[claim id]) as cnt
 from Auto_post ap left join stock_report_final sf on ap.claim_date = sf.claim_date
 group by sf.[Parent Worklist Name],sf.[date];
GO
/****** Object:  Table [dbo].['08-16-2019-WorklistStockReport-$']    Script Date: 9/10/2020 2:50:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].['08-16-2019-WorklistStockReport-$'](
	[Claim ID] [nvarchar](255) NULL,
	[Transfer Type] [nvarchar](255) NULL,
	[A] [nvarchar](255) NULL,
	[Claim Status] [nvarchar](255) NULL,
	[B] [nvarchar](255) NULL,
	[Days in Status] [nvarchar](255) NULL,
	[Outstanding Amount] [float] NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Status Athena Kickcode] [nvarchar](255) NULL,
	[Current Error Text] [nvarchar](255) NULL,
	[C] [nvarchar](255) NULL,
	[Parent Worklist Name] [nvarchar](255) NULL,
	[Sub Worklist Name] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Worklist Team Organization] [nvarchar](255) NULL,
	[Workflow Type] [nvarchar](255) NULL,
	[Worklist Location] [nvarchar](255) NULL,
	[Priority] [nvarchar](255) NULL,
	[Worked] [nvarchar](255) NULL,
	[Total Athena Days] [nvarchar](255) NULL,
	[Prescribed YN] [nvarchar](255) NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[09/03/2019]    Script Date: 9/10/2020 2:50:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[09/03/2019](
	[Claim ID] [nvarchar](255) NULL,
	[Transfer Type] [float] NULL,
	[Claim Status] [nvarchar](255) NULL,
	[Days in Status] [float] NULL,
	[Outstanding Amount] [money] NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Status Athena Kickcode] [nvarchar](255) NULL,
	[Current Error Text] [nvarchar](255) NULL,
	[Parent Worklist Name] [nvarchar](255) NULL,
	[Sub Worklist Name] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Worklist Team Organization] [nvarchar](255) NULL,
	[Workflow Type] [nvarchar](255) NULL,
	[Worklist Location] [nvarchar](255) NULL,
	[Priority] [float] NULL,
	[Worked] [nvarchar](255) NULL,
	[Total Athena Days] [float] NULL,
	[Prescribed YN] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[09082019]    Script Date: 9/10/2020 2:50:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[09082019](
	[Claim ID] [nvarchar](255) NULL,
	[Transfer Type] [nvarchar](255) NULL,
	[A] [nvarchar](255) NULL,
	[Claim Status] [nvarchar](255) NULL,
	[B] [nvarchar](255) NULL,
	[Days in Status] [nvarchar](255) NULL,
	[Outstanding Amount] [float] NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Status Athena Kickcode] [nvarchar](255) NULL,
	[Current Error Text] [nvarchar](255) NULL,
	[C] [nvarchar](255) NULL,
	[Parent Worklist Name] [nvarchar](255) NULL,
	[Sub Worklist Name] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Worklist Team Organization] [nvarchar](255) NULL,
	[Workflow Type] [nvarchar](255) NULL,
	[Worklist Location] [nvarchar](255) NULL,
	[Priority] [nvarchar](255) NULL,
	[Worked] [nvarchar](255) NULL,
	[Total Athena Days] [nvarchar](255) NULL,
	[Prescribed YN] [nvarchar](255) NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Abeo_AR_Alert]    Script Date: 9/10/2020 2:50:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abeo_AR_Alert](
	[Week] [datetime] NULL,
	[Alert Sent Date] [datetime] NULL,
	[Emp Name] [nvarchar](255) NULL,
	[AHS ID] [nvarchar](255) NULL,
	[Processed Date] [datetime] NULL,
	[Team] [nvarchar](255) NULL,
	[LOB] [nvarchar](255) NULL,
	[Manager] [nvarchar](255) NULL,
	[Claim #] [nvarchar](255) NULL,
	[Audit Type] [nvarchar](255) NULL,
	[Error Type] [nvarchar](255) NULL,
	[# of Errors] [float] NULL,
	[Critical Error] [nvarchar](255) NULL,
	[Non-Critical Error] [nvarchar](255) NULL,
	[RAP status] [nvarchar](255) NULL,
	[Comments] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Abeo_AR_Parameter_Raw]    Script Date: 9/10/2020 2:50:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abeo_AR_Parameter_Raw](
	[Week] [datetime] NULL,
	[WOW / Regular] [nvarchar](255) NULL,
	[Team] [nvarchar](255) NULL,
	[Region] [nvarchar](255) NULL,
	[Client  Name] [nvarchar](255) NULL,
	[Patient ID/Account #] [nvarchar](255) NULL,
	[DOS] [nvarchar](255) NULL,
	[Patient Policy Name] [nvarchar](255) NULL,
	[Follow up Code] [nvarchar](255) NULL,
	[Processed Date] [datetime] NULL,
	[Processed By] [nvarchar](255) NULL,
	[Auditor Name] [nvarchar](255) NULL,
	[Audit Date] [datetime] NULL,
	[Emp ID#] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[DOJ] [datetime] NULL,
	[Tenurity] [nvarchar](255) NULL,
	[Rework] [nvarchar](255) NULL,
	[Rework status] [nvarchar](255) NULL,
	[Rebuttal] [nvarchar](255) NULL,
	[Rebuttal status] [nvarchar](255) NULL,
	[Critical/Non Critical] [nvarchar](255) NULL,
	[Defects] [float] NULL,
	[Defective transs] [float] NULL,
	[Score] [float] NULL,
	[Quality Score] [float] NULL,
	[Attribute] [nvarchar](255) NULL,
	[Value] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Abeo_AR_Raw_data]    Script Date: 9/10/2020 2:50:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abeo_AR_Raw_data](
	[Week] [datetime] NULL,
	[WOW / Regular] [nvarchar](255) NULL,
	[Team] [nvarchar](255) NULL,
	[Region] [nvarchar](255) NULL,
	[Client  Name] [nvarchar](255) NULL,
	[Patient ID/Account #] [nvarchar](255) NULL,
	[DOS] [datetime] NULL,
	[Patient Policy Name] [nvarchar](255) NULL,
	[Follow up Code] [nvarchar](255) NULL,
	[Processed Date] [datetime] NULL,
	[Processed By] [nvarchar](255) NULL,
	[Auditor Name] [nvarchar](255) NULL,
	[Audit Date] [datetime] NULL,
	[Emp ID#] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[DOJ] [datetime] NULL,
	[Tenurity] [nvarchar](255) NULL,
	[Rework] [nvarchar](255) NULL,
	[Rework status] [nvarchar](255) NULL,
	[Rebuttal] [nvarchar](255) NULL,
	[Rebuttal status] [nvarchar](255) NULL,
	[Critical/Non Critical] [nvarchar](255) NULL,
	[Defects] [float] NULL,
	[Defective transs] [float] NULL,
	[Score] [float] NULL,
	[Quality Score] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Abeo_Coding_External_error]    Script Date: 9/10/2020 2:50:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abeo_Coding_External_error](
	[ReqId] [float] NULL,
	[Customer] [nvarchar](255) NULL,
	[Functionality] [nvarchar](255) NULL,
	[Service] [nvarchar](255) NULL,
	[Client] [nvarchar](255) NULL,
	[Created Date] [datetime] NULL,
	[Received Mode] [nvarchar](255) NULL,
	[Received Date] [nvarchar](255) NULL,
	[Classification] [nvarchar](255) NULL,
	[FeedBack Type] [nvarchar](255) NULL,
	[RepliedOn] [datetime] NULL,
	[AccountNo] [nvarchar](255) NULL,
	[FTE NT_Name] [nvarchar](255) NULL,
	[QC NT_Name] [nvarchar](255) NULL,
	[RequestedBy] [nvarchar](255) NULL,
	[ApprovedBy] [nvarchar](255) NULL,
	[AppType] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Abeo_coding_Internal_Error]    Script Date: 9/10/2020 2:50:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abeo_coding_Internal_Error](
	[Service] [nvarchar](255) NULL,
	[Client] [nvarchar](255) NULL,
	[PageNo] [float] NULL,
	[BatchNo] [nvarchar](255) NULL,
	[Classification] [nvarchar](255) NULL,
	[SubClassification] [nvarchar](255) NULL,
	[ProcessedBy] [nvarchar](255) NULL,
	[Supervisor] [nvarchar](255) NULL,
	[AuditedBy] [nvarchar](255) NULL,
	[Rebuttal status] [nvarchar](255) NULL,
	[AuditedOn] [datetime] NULL,
	[AcknowledgeStatus] [nvarchar](255) NULL,
	[AcknowledgedBy] [nvarchar](255) NULL,
	[AcknowledgedOn] [datetime] NULL,
	[Errors] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Abeo_coding_raw_data]    Script Date: 9/10/2020 2:50:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abeo_coding_raw_data](
	[Week] [datetime] NULL,
	[Unique] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[Associate] [nvarchar](255) NULL,
	[TL] [nvarchar](255) NULL,
	[Subclient] [nvarchar](255) NULL,
	[Service] [nvarchar](255) NULL,
	[BatchProcessed] [float] NULL,
	[TransactionProcessed] [float] NULL,
	[BatchAudited] [float] NULL,
	[TransactionAudited] [float] NULL,
	[ErrorCount] [float] NULL,
	[Rebutal Raised] [float] NULL,
	[Rebuttal Accepted] [float] NULL,
	[Actual Error] [float] NULL,
	[Quality Score] [float] NULL,
	[External Error] [nvarchar](255) NULL,
	[External score] [float] NULL,
	[Comment] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Action_mask]    Script Date: 9/10/2020 2:50:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Action_mask](
	[Action_Original] [varchar](255) NULL,
	[Action_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AD]    Script Date: 9/10/2020 2:50:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AD](
	[Month] [nvarchar](255) NULL,
	[Process] [nvarchar](255) NULL,
	[Actual date] [datetime] NULL,
	[Audit date] [datetime] NULL,
	[ClientUserID] [nvarchar](255) NULL,
	[NtUserid] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Manager] [nvarchar](255) NULL,
	[Claim ID] [nvarchar](255) NULL,
	[IPNAME] [nvarchar](255) NULL,
	[ACTIONS] [nvarchar](255) NULL,
	[KICKCODE] [nvarchar](255) NULL,
	[Audit Type] [nvarchar](255) NULL,
	[AUDITBY] [nvarchar](255) NULL,
	[Sub Process] [nvarchar](255) NULL,
	[WorkFlow] [nvarchar](255) NULL,
	[WOW] [nvarchar](255) NULL,
	[IRCGROUP] [nvarchar](255) NULL,
	[Parent Work List] [nvarchar](255) NULL,
	[DAYSINSTATUS] [float] NULL,
	[Dialer] [nvarchar](255) NULL,
	[QC Comments - Overall] [nvarchar](max) NULL,
	[QUALITYPERCENTAGE] [float] NULL,
	[Error count] [float] NULL,
	[Critical Claim] [float] NULL,
	[Critical Count] [float] NULL,
	[Esclation Count] [float] NULL,
	[Non Critical Count] [float] NULL,
	[Error Type] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[DU] [float] NULL,
	[Audit count] [float] NULL,
	[Rework] [nvarchar](255) NULL,
	[Rebuttal Status] [nvarchar](255) NULL,
	[Weighted Average Score] [float] NULL,
	[LOB] [nvarchar](255) NULL,
	[F38] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aging_10M]    Script Date: 9/10/2020 2:50:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aging_10M](
	[ID] [int] NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ATBCategory] [varchar](100) NULL,
	[ARDays] [int] NULL,
	[0-30] [decimal](18, 2) NULL,
	[31-60] [decimal](18, 2) NULL,
	[61-90] [decimal](18, 2) NULL,
	[91-120] [decimal](18, 2) NULL,
	[121-150] [decimal](18, 2) NULL,
	[151-180] [decimal](18, 2) NULL,
	[181+] [decimal](18, 2) NULL,
	[CategoryBalance] [decimal](18, 2) NULL,
	[Location] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[XLName] [varchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[agingreprt_10Mdata]    Script Date: 9/10/2020 2:50:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[agingreprt_10Mdata](
	[ID] [int] NOT NULL,
	[ClientID] [varchar](100) NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ATBCategory] [varchar](100) NULL,
	[ARDays] [int] NULL,
	[0-30] [decimal](18, 2) NULL,
	[31-60] [decimal](18, 2) NULL,
	[61-90] [decimal](18, 2) NULL,
	[91-120] [decimal](18, 2) NULL,
	[121-150] [decimal](18, 2) NULL,
	[151-180] [decimal](18, 2) NULL,
	[181+] [decimal](18, 2) NULL,
	[CategoryBalance] [decimal](18, 2) NULL,
	[Location] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[XLName] [varchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[agingreprt_10Mdata_copy]    Script Date: 9/10/2020 2:50:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[agingreprt_10Mdata_copy](
	[ID] [int] NOT NULL,
	[ClientID] [varchar](100) NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ATBCategory] [varchar](100) NULL,
	[ARDays] [int] NULL,
	[0-30] [decimal](18, 2) NULL,
	[31-60] [decimal](18, 2) NULL,
	[61-90] [decimal](18, 2) NULL,
	[91-120] [decimal](18, 2) NULL,
	[121-150] [decimal](18, 2) NULL,
	[151-180] [decimal](18, 2) NULL,
	[181+] [decimal](18, 2) NULL,
	[CategoryBalance] [decimal](18, 2) NULL,
	[Location] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[XLName] [varchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_10]    Script Date: 9/10/2020 2:50:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_10](
	[FileName] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_11]    Script Date: 9/10/2020 2:50:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_11](
	[FileName] [nvarchar](11) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_18Months]    Script Date: 9/10/2020 2:50:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_18Months](
	[Month] [float] NULL,
	[Year] [float] NULL,
	[ClientName] [float] NULL,
	[PayerName] [nvarchar](255) NULL,
	[BatchCount] [float] NULL,
	[TotalTrans] [float] NULL,
	[Automation] [float] NULL,
	[ManualTrans] [float] NULL,
	[ADP] [float] NULL,
	[EchoPay] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_9]    Script Date: 9/10/2020 2:50:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_9](
	[FileName] [nvarchar](9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_Analysis]    Script Date: 9/10/2020 2:50:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_Analysis](
	[Month] [float] NULL,
	[Year] [float] NULL,
	[ClientName] [float] NULL,
	[PayerName] [nvarchar](255) NULL,
	[BatchCount] [float] NULL,
	[TotalTrans] [float] NULL,
	[Automation] [float] NULL,
	[ManualTrans] [float] NULL,
	[ADP] [float] NULL,
	[EchoPay] [float] NULL,
	[date]  AS (datefromparts([year],[month],(1)))
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_claims]    Script Date: 9/10/2020 2:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_claims](
	[File Name] [nvarchar](255) NULL,
	[Date of Service] [datetime] NULL,
	[Filing Method] [nvarchar](255) NULL,
	[Filing Type] [nvarchar](255) NULL,
	[Clearinghouse] [nvarchar](255) NULL,
	[Filed By] [nvarchar](255) NULL,
	[Filed To] [nvarchar](255) NULL,
	[Created By] [nvarchar](255) NULL,
	[Date Created] [datetime] NULL,
	[Date Transmitted] [datetime] NULL,
	[Procedure Filed] [nvarchar](max) NULL,
	[Amount Filed] [float] NULL,
	[Month] [nvarchar](255) NULL,
	[Year] [int] NULL,
	[Sub-client] [nvarchar](255) NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_claims_FileName1]    Script Date: 9/10/2020 2:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_claims_FileName1](
	[FileName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_claims_FileName10]    Script Date: 9/10/2020 2:50:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_claims_FileName10](
	[FileName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_claims_FileName11]    Script Date: 9/10/2020 2:50:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_claims_FileName11](
	[FileName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_claims_FileName6]    Script Date: 9/10/2020 2:50:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_claims_FileName6](
	[FileName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_claims_FileName7]    Script Date: 9/10/2020 2:50:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_claims_FileName7](
	[FileName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_claims_FileName8]    Script Date: 9/10/2020 2:50:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_claims_FileName8](
	[FileName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_claims_FileName9]    Script Date: 9/10/2020 2:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_claims_FileName9](
	[FileName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALN_denials]    Script Date: 9/10/2020 2:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALN_denials](
	[Denials] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Ticket Number] [nvarchar](255) NULL,
	[Date Of Service] [datetime] NULL,
	[Procedure Code] [nvarchar](255) NULL,
	[Denial __Aging by DOS] [float] NULL,
	[Denial __Amt] [float] NULL,
	[Month] [nvarchar](255) NULL,
	[Sub-client] [nvarchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALNTen]    Script Date: 9/10/2020 2:50:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALNTen](
	[FileName] [varchar](10) NULL,
	[pymtamt] [float] NULL,
	[contrAdjAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Altrius_coding_internal_error]    Script Date: 9/10/2020 2:50:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Altrius_coding_internal_error](
	[Service] [nvarchar](255) NULL,
	[Client] [nvarchar](255) NULL,
	[PageNo] [float] NULL,
	[BatchNo] [nvarchar](255) NULL,
	[Classification] [nvarchar](255) NULL,
	[SubClassification] [nvarchar](255) NULL,
	[ProcessedBy] [nvarchar](255) NULL,
	[Supervisor] [nvarchar](255) NULL,
	[AuditedBy] [nvarchar](255) NULL,
	[Rebuttal status] [nvarchar](255) NULL,
	[AuditedOn] [datetime] NULL,
	[AcknowledgeStatus] [nvarchar](255) NULL,
	[AcknowledgedBy] [nvarchar](255) NULL,
	[AcknowledgedOn] [datetime] NULL,
	[Errors] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Altrius_coding_raw_data]    Script Date: 9/10/2020 2:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Altrius_coding_raw_data](
	[Week] [datetime] NULL,
	[Date] [datetime] NULL,
	[Associate] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Subclient] [nvarchar](255) NULL,
	[Service] [nvarchar](255) NULL,
	[BatchProcessed] [float] NULL,
	[TransactionProcessed] [float] NULL,
	[BatchAudited] [float] NULL,
	[TransactionAudited] [float] NULL,
	[ErrorCount] [float] NULL,
	[Rebutal Raised] [float] NULL,
	[Rebuttal Accepted] [float] NULL,
	[Actual Error] [float] NULL,
	[Quality Score] [float] NULL,
	[Comment] [float] NULL,
	[Comment2] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[APGCLAIMS_20180529]    Script Date: 9/10/2020 2:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APGCLAIMS_20180529](
	[File Name] [varchar](50) NULL,
	[Date of Service] [varchar](50) NULL,
	[Filing Method] [varchar](50) NULL,
	[Filing Type] [varchar](50) NULL,
	[Clearinghouse] [varchar](50) NULL,
	[Filed By] [varchar](50) NULL,
	[Filed To] [varchar](7999) NULL,
	[Date Created] [varchar](50) NULL,
	[Date Transmitted] [varchar](50) NULL,
	[Procedure Filed] [varchar](7999) NULL,
	[Amount Filed] [varchar](50) NULL,
	[Month] [varchar](50) NULL,
	[Year] [varchar](50) NULL,
	[Sub-client] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[APGDenial_Import_20180601]    Script Date: 9/10/2020 2:50:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APGDenial_Import_20180601](
	[Denials] [varchar](5000) NULL,
	[Name] [varchar](5000) NULL,
	[Ticket Number] [varchar](50) NULL,
	[DateOfService] [varchar](50) NULL,
	[Procedure Code] [varchar](50) NULL,
	[Denial __Aging by DOS] [varchar](50) NULL,
	[Denial __Amt] [varchar](50) NULL,
	[Month] [varchar](50) NULL,
	[Sub-client] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_USER_INFO]    Script Date: 9/10/2020 2:50:56 PM ******/
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
 CONSTRAINT [PK__ARC_REC___7B9E7F35473E2675] PRIMARY KEY CLUSTERED 
(
	[USERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [UQ__ARC_REC___C9A5552D25E7544B] UNIQUE NONCLUSTERED 
(
	[USERID] ASC,
	[REC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARDate]    Script Date: 9/10/2020 2:50:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARDate](
	[InvoiceID] [varchar](11) NULL,
	[MaxDate] [date] NULL,
	[MinDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARDAys$]    Script Date: 9/10/2020 2:50:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARDAys$](
	[Client] [nvarchar](255) NULL,
	[ReportYear] [float] NULL,
	[ReportMonth] [float] NULL,
	[ShortName] [nvarchar](255) NULL,
	[ARDays] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].['Audit Data$']    Script Date: 9/10/2020 2:50:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].['Audit Data$'](
	[Month] [nvarchar](255) NULL,
	[Process] [nvarchar](255) NULL,
	[Actual date] [datetime] NULL,
	[Audit date] [datetime] NULL,
	[ClientUserID] [nvarchar](255) NULL,
	[NtUserid] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Manager] [nvarchar](255) NULL,
	[Claim ID] [nvarchar](255) NULL,
	[IPNAME] [nvarchar](255) NULL,
	[ACTIONS] [nvarchar](255) NULL,
	[KICKCODE] [nvarchar](255) NULL,
	[Audit Type] [nvarchar](255) NULL,
	[AUDITBY] [nvarchar](255) NULL,
	[Sub Process] [nvarchar](255) NULL,
	[WorkFlow] [nvarchar](255) NULL,
	[WOW] [nvarchar](255) NULL,
	[IRCGROUP] [nvarchar](255) NULL,
	[Parent Work List] [nvarchar](255) NULL,
	[DAYSINSTATUS] [float] NULL,
	[Dialer] [nvarchar](255) NULL,
	[Link] [nvarchar](255) NULL,
	[QC Comments - Overall] [nvarchar](max) NULL,
	[QUALITYPERCENTAGE] [float] NULL,
	[Error count] [float] NULL,
	[Critical Claim] [float] NULL,
	[Critical Count] [float] NULL,
	[Esclation Count] [float] NULL,
	[Non Critical Count] [float] NULL,
	[Error Type] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[DU] [float] NULL,
	[Audit count] [float] NULL,
	[Rework] [nvarchar](255) NULL,
	[Rebuttal Status] [nvarchar](255) NULL,
	[Weighted Average Score] [float] NULL,
	[LOB] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Audit$]    Script Date: 9/10/2020 2:50:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audit$](
	[Month] [nvarchar](255) NULL,
	[Process] [nvarchar](255) NULL,
	[Actual date] [datetime] NULL,
	[Audit date] [datetime] NULL,
	[ClientUserID] [nvarchar](255) NULL,
	[NtUserid] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Manager] [nvarchar](255) NULL,
	[Claim ID] [nvarchar](255) NULL,
	[IPNAME] [nvarchar](255) NULL,
	[ACTIONS] [nvarchar](255) NULL,
	[KICKCODE] [nvarchar](255) NULL,
	[Audit Type] [nvarchar](255) NULL,
	[AUDITBY] [nvarchar](255) NULL,
	[Sub Process] [nvarchar](255) NULL,
	[WorkFlow] [nvarchar](255) NULL,
	[WOW] [nvarchar](255) NULL,
	[IRCGROUP] [nvarchar](255) NULL,
	[Parent Work List] [nvarchar](255) NULL,
	[DAYSINSTATUS] [float] NULL,
	[Dialer] [nvarchar](255) NULL,
	[Link] [nvarchar](255) NULL,
	[QC Comments - Overall] [nvarchar](max) NULL,
	[QUALITYPERCENTAGE] [float] NULL,
	[Error count] [float] NULL,
	[Critical Claim] [float] NULL,
	[Critical Count] [float] NULL,
	[Esclation Count] [float] NULL,
	[Non Critical Count] [float] NULL,
	[Error Type] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[DU] [float] NULL,
	[Audit count] [float] NULL,
	[Rework] [nvarchar](255) NULL,
	[Rebuttal Status] [nvarchar](255) NULL,
	[Weighted Average Score] [float] NULL,
	[LOB] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aug_build_new]    Script Date: 9/10/2020 2:50:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aug_build_new](
	[PRACTICE ID] [float] NULL,
	[PRACTICE NAME] [nvarchar](255) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [datetime] NULL,
	[OUTCREATED_HOUR] [float] NULL,
	[INCREATED] [datetime] NULL,
	[INCLAIMSTATUS] [nvarchar](255) NULL,
	[CLAIMID] [nvarchar](255) NULL,
	[SERVICEDATE] [datetime] NULL,
	[TRANSFERTYPE] [float] NULL,
	[PROVIDERNAME] [nvarchar](255) NULL,
	[IPNAME] [nvarchar](255) NULL,
	[IPID] [nvarchar](255) NULL,
	[IRCNAME] [nvarchar](255) NULL,
	[IRCID] [nvarchar](255) NULL,
	[IRCGROUP] [nvarchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [nvarchar](255) NULL,
	[SUB_WORKLISTNAME] [nvarchar](255) NULL,
	[WORKFLOWTYPE] [nvarchar](255) NULL,
	[WORKLIST_LOCATION] [nvarchar](255) NULL,
	[WORKLIST_ORGANIZATION] [nvarchar](255) NULL,
	[INKICKCODE] [nvarchar](255) NULL,
	[OUTCREATEDBY] [nvarchar](255) NULL,
	[OUTFLOWUSERLOCATION] [nvarchar](255) NULL,
	[DAYSINSTATUS] [float] NULL,
	[ACTION] [nvarchar](255) NULL,
	[OUTKICKCODE] [nvarchar](255) NULL,
	[OUTCLAIMSTATUS] [nvarchar](255) NULL,
	[NOTE] [nvarchar](max) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [nvarchar](255) NULL,
	[WORKCLASS] [nvarchar](255) NULL,
	[VOICETYPE] [nvarchar](255) NULL,
	[BILLTYPE] [nvarchar](255) NULL,
	[OUTPAYERKICK] [nvarchar](255) NULL,
	[DEPARTMENT] [nvarchar](255) NULL,
	[PAYER_CATEGORY] [nvarchar](255) NULL,
	[KICKS_CATEGORY] [nvarchar](255) NULL,
	[Billing] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aug_build_report]    Script Date: 9/10/2020 2:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aug_build_report](
	[PRACTICE ID] [float] NULL,
	[PRACTICE NAME] [varchar](max) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [time](7) NULL,
	[OUTCREATED_HOUR] [float] NULL,
	[INCREATED] [varchar](max) NULL,
	[INCLAIMSTATUS] [varchar](max) NULL,
	[CLAIMID] [varchar](max) NULL,
	[SERVICEDATE] [varchar](max) NULL,
	[TRANSFERTYPE] [varchar](max) NULL,
	[PROVIDERNAME] [varchar](max) NULL,
	[IPNAME] [varchar](max) NULL,
	[IPID] [float] NULL,
	[IRCNAME] [varchar](max) NULL,
	[IRCID] [float] NULL,
	[IRCGROUP] [varchar](max) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](max) NULL,
	[SUB_WORKLISTNAME] [varchar](max) NULL,
	[WORKFLOWTYPE] [varchar](max) NULL,
	[WORKLIST_LOCATION] [varchar](max) NULL,
	[WORKLIST_ORGANIZATION] [varchar](max) NULL,
	[INKICKCODE] [varchar](max) NULL,
	[OUTCREATEDBY] [varchar](max) NULL,
	[OUTFLOWUSERLOCATION] [varchar](max) NULL,
	[DAYSINSTATUS] [float] NULL,
	[ACTION] [varchar](max) NULL,
	[OUTKICKCODE] [varchar](max) NULL,
	[OUTCLAIMSTATUS] [varchar](max) NULL,
	[NOTE] [varchar](max) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](max) NULL,
	[WORKCLASS] [varchar](max) NULL,
	[VOICETYPE] [varchar](max) NULL,
	[BILLTYPE] [varchar](max) NULL,
	[OUTPAYERKICK] [varchar](max) NULL,
	[DEPARTMENT] [varchar](max) NULL,
	[PAYER_CATEGORY] [varchar](max) NULL,
	[KICKS_CATEGORY] [varchar](max) NULL,
	[Billing] [varchar](max) NULL,
	[Date_Buckets]  AS (case when datediff(day,[SERVICEDATE],[OUTCREATED_DATE])<(30) then '0-30' when datediff(day,[SERVICEDATE],[OUTCREATED_DATE])>(30) AND datediff(day,[SERVICEDATE],[OUTCREATED_DATE])<(60) then '30-60' when datediff(day,[SERVICEDATE],[OUTCREATED_DATE])>(60) AND datediff(day,[SERVICEDATE],[OUTCREATED_DATE])<(90) then '60-90' when datediff(day,[SERVICEDATE],[OUTCREATED_DATE])>(90) AND datediff(day,[SERVICEDATE],[OUTCREATED_DATE])<(120) then '90-120' when datediff(day,[SERVICEDATE],[OUTCREATED_DATE])>(120) AND datediff(day,[SERVICEDATE],[OUTCREATED_DATE])<(180) then '120-180' when datediff(day,[SERVICEDATE],[OUTCREATED_DATE])>(180) AND datediff(day,[SERVICEDATE],[OUTCREATED_DATE])<(365) then '180-365' when datediff(day,[SERVICEDATE],[OUTCREATED_DATE])>(365) then '365+' else '-' end),
	[Date_difference]  AS (isnull(datediff(day,[SERVICEDATE],[OUTCREATED_DATE]),(0))),
	[Servicedate_cal]  AS (case when [SERVICEDATE] IS NULL then '1001-01-01 00:00:00.0000000' else [SERVICEDATE] end),
	[OUTCREATED_cal]  AS (case when [OUTCREATED_DATE] IS NULL then '1001-01-01 00:00:00.0000000' else [OUTCREATED_DATE] end),
	[claimid_tansfertype]  AS (([claimid]+'-')+[TRANSFERTYPE])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aug-Build]    Script Date: 9/10/2020 2:51:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aug-Build](
	[PRACTICE ID] [varchar](255) NULL,
	[PRACTICE NAME] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[OUTCREATED_TIME] [varchar](255) NULL,
	[OUTCREATED_HOUR] [int] NULL,
	[INCREATED] [varchar](255) NULL,
	[INCLAIMSTATUS] [varchar](255) NULL,
	[CLAIMID] [varchar](255) NULL,
	[SERVICEDATE] [date] NULL,
	[TRANSFERTYPE] [varchar](255) NULL,
	[PROVIDERNAME] [varchar](255) NULL,
	[IPNAME] [varchar](255) NULL,
	[IPID] [int] NULL,
	[IRCNAME] [varchar](255) NULL,
	[IRCID] [int] NULL,
	[IRCGROUP] [varchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](255) NULL,
	[SUB_WORKLISTNAME] [varchar](255) NULL,
	[WORKFLOWTYPE] [varchar](255) NULL,
	[WORKLIST_LOCATION] [varchar](255) NULL,
	[WORKLIST_ORGANIZATION] [varchar](255) NULL,
	[INKICKCODE] [varchar](255) NULL,
	[OUTCREATEDBY] [varchar](255) NULL,
	[OUTFLOWUSERLOCATION] [varchar](255) NULL,
	[DAYSINSTATUS] [int] NULL,
	[ACTION] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[OUTCLAIMSTATUS] [varchar](255) NULL,
	[NOTE] [varchar](4000) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](255) NULL,
	[WORKCLASS] [varchar](255) NULL,
	[VOICETYPE] [varchar](255) NULL,
	[BILLTYPE] [varchar](255) NULL,
	[OUTPAYERKICK] [varchar](255) NULL,
	[DEPARTMENT] [varchar](255) NULL,
	[PAYER_CATEGORY] [varchar](255) NULL,
	[KICKS_CATEGORY] [varchar](255) NULL,
	[Billing] [varchar](255) NULL,
	[claimid_trasfertype]  AS (([claimid]+'-')+[transfertype])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auto_dummy]    Script Date: 9/10/2020 2:51:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auto_dummy](
	[Date] [date] NULL,
	[Claim ID] [varchar](255) NULL,
	[Days in Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auto_dummy_1]    Script Date: 9/10/2020 2:51:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auto_dummy_1](
	[Date] [date] NULL,
	[Claim ID] [varchar](255) NULL,
	[Days in Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Auto_post_fridays]    Script Date: 9/10/2020 2:51:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auto_post_fridays](
	[Claim ID] [nvarchar](255) NULL,
	[date] [datetime] NULL,
	[Days in Status] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Billing_mask]    Script Date: 9/10/2020 2:51:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Billing_mask](
	[Billing_mask_Original] [varchar](255) NULL,
	[Billing_mask_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[build_nov]    Script Date: 9/10/2020 2:51:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[build_nov](
	[PRACTICE ID] [float] NULL,
	[PRACTICE NAME] [varchar](255) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [datetime] NULL,
	[OUTCREATED_HOUR] [float] NULL,
	[INCREATED] [datetime] NULL,
	[INCLAIMSTATUS] [varchar](255) NULL,
	[CLAIMID] [varchar](255) NULL,
	[SERVICEDATE] [datetime] NULL,
	[TRANSFERTYPE] [float] NULL,
	[PROVIDERNAME] [varchar](255) NULL,
	[IPNAME] [varchar](255) NULL,
	[IPID] [float] NULL,
	[IRCNAME] [varchar](255) NULL,
	[IRCID] [float] NULL,
	[IRCGROUP] [varchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](255) NULL,
	[SUB_WORKLISTNAME] [varchar](255) NULL,
	[WORKFLOWTYPE] [varchar](255) NULL,
	[WORKLIST_LOCATION] [varchar](255) NULL,
	[WORKLIST_ORGANIZATION] [varchar](255) NULL,
	[INKICKCODE] [varchar](255) NULL,
	[OUTCREATEDBY] [varchar](255) NULL,
	[OUTFLOWUSERLOCATION] [varchar](255) NULL,
	[DAYSINSTATUS] [float] NULL,
	[ACTION] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[OUTCLAIMSTATUS] [varchar](255) NULL,
	[NOTE] [varchar](3503) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](255) NULL,
	[WORKCLASS] [varchar](255) NULL,
	[VOICETYPE] [varchar](255) NULL,
	[BILLTYPE] [varchar](255) NULL,
	[OUTPAYERKICK] [bit] NULL,
	[DEPARTMENT] [varchar](255) NULL,
	[PAYER_CATEGORY] [varchar](255) NULL,
	[KICKS_CATEGORY] [varchar](255) NULL,
	[Billing] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[C_MASKED]    Script Date: 9/10/2020 2:51:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[C_MASKED](
	[C_original] [varchar](255) NULL,
	[C_masked] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CBSI_denial_Import_20180530]    Script Date: 9/10/2020 2:51:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CBSI_denial_Import_20180530](
	[Denials] [varchar](5000) NULL,
	[Name] [varchar](5000) NULL,
	[Ticket Number] [varchar](50) NULL,
	[Date Of Service] [varchar](50) NULL,
	[Procedure Code] [varchar](50) NULL,
	[Denial __Aging by DOS] [varchar](50) NULL,
	[Denial __Amt] [varchar](50) NULL,
	[Month] [varchar](50) NULL,
	[Sub-client] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CBSI_Import_20180529]    Script Date: 9/10/2020 2:51:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CBSI_Import_20180529](
	[File Name] [varchar](50) NULL,
	[Date of Service] [varchar](50) NULL,
	[Filing Method] [varchar](50) NULL,
	[Filing Type] [varchar](50) NULL,
	[Clearinghouse] [varchar](50) NULL,
	[Filed By] [varchar](50) NULL,
	[Filed To] [varchar](5000) NULL,
	[Created By] [varchar](50) NULL,
	[Date Created] [varchar](50) NULL,
	[Date Transmitted] [varchar](50) NULL,
	[Procedure Filed] [varchar](5000) NULL,
	[Amount Filed] [varchar](50) NULL,
	[Month] [varchar](50) NULL,
	[Year] [varchar](50) NULL,
	[Sub-client] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CC_REPORT]    Script Date: 9/10/2020 2:51:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CC_REPORT](
	[Source#Name] [nvarchar](255) NULL,
	[Claim ID] [nvarchar](255) NULL,
	[Claim Wizard] [nvarchar](255) NULL,
	[Context] [nvarchar](255) NULL,
	[Contract Type] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Worked] [nvarchar](255) NULL,
	[Worklist] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Supervising Provider Name] [nvarchar](255) NULL,
	[Claim Submission Category] [nvarchar](255) NULL,
	[Transfer Type] [float] NULL,
	[Last Action] [nvarchar](255) NULL,
	[Days in Status] [float] NULL,
	[Service Date] [datetime] NULL,
	[Outstanding] [float] NULL,
	[Notes] [nvarchar](255) NULL,
	[CRM Case Numbers] [nvarchar](255) NULL,
	[Last CRM Case Note] [nvarchar](255) NULL,
	[Billing Batch ID] [float] NULL,
	[NewColumn#Work list] [nvarchar](255) NULL,
	[NewColumn#Location] [nvarchar](255) NULL,
	[NewColumn#Manager] [nvarchar](255) NULL,
	[NewColumn#Leads] [nvarchar](255) NULL,
	[NewColumn#Time Zome] [nvarchar](255) NULL,
	[NewColumn#State] [nvarchar](255) NULL,
	[Column1] [nvarchar](255) NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Challenge_payor]    Script Date: 9/10/2020 2:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Challenge_payor](
	[CC] [nvarchar](255) NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Challenges] [nvarchar](255) NULL,
	[Major Cateogry] [nvarchar](255) NULL,
	[Complexity] [nvarchar](255) NULL,
	[Remarks] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChallengePayorNew]    Script Date: 9/10/2020 2:51:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChallengePayorNew](
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[IPID]  AS (substring(substring([Insurance package],charindex('[',[Insurance package])+(1),charindex(']',[Insurance package])+(1)),(1),len(substring([Insurance package],charindex('[',[Insurance package])+(1),charindex(']',[Insurance package])))-(1)))
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChangeHealth_AR_Parameter_Raw]    Script Date: 9/10/2020 2:51:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChangeHealth_AR_Parameter_Raw](
	[Week] [datetime] NULL,
	[WeekNum] [nvarchar](255) NULL,
	[Client Name] [nvarchar](255) NULL,
	[OJT/Live] [nvarchar](255) NULL,
	[Client #] [nvarchar](255) NULL,
	[SOW ID #] [nvarchar](255) NULL,
	[Work Scope] [nvarchar](255) NULL,
	[Account #] [nvarchar](255) NULL,
	[Process Date] [datetime] NULL,
	[Audited Date] [datetime] NULL,
	[Pocessed By] [nvarchar](255) NULL,
	[Employee ID ] [nvarchar](255) NULL,
	[Auditor] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Account Type (Voice/Non-Voice)] [nvarchar](255) NULL,
	[Status Code] [nvarchar](255) NULL,
	[Action Code] [nvarchar](255) NULL,
	[Assistance Required (Yes/No)] [nvarchar](255) NULL,
	[Error] [nvarchar](255) NULL,
	[Rebuttal] [nvarchar](255) NULL,
	[Rebuttal Received date] [nvarchar](255) NULL,
	[Rebuttal Validated Date] [nvarchar](255) NULL,
	[Rebuttal TAT] [nvarchar](255) NULL,
	[Ops Rebuttal Comments] [nvarchar](255) NULL,
	[Auditor Rebuttal Comments] [nvarchar](255) NULL,
	[Rebuttal status] [nvarchar](255) NULL,
	[Research] [nvarchar](255) NULL,
	[Decision] [nvarchar](255) NULL,
	[Action] [nvarchar](255) NULL,
	[Documentation] [nvarchar](255) NULL,
	[Effectiveness] [nvarchar](255) NULL,
	[DPU] [nvarchar](255) NULL,
	[DPO] [nvarchar](255) NULL,
	[Hybrid] [nvarchar](255) NULL,
	[Error Count] [nvarchar](255) NULL,
	[Fatal error count] [nvarchar](255) NULL,
	[non Fatal error count] [nvarchar](255) NULL,
	[Defective call] [nvarchar](255) NULL,
	[fatal defictive call] [nvarchar](255) NULL,
	[Audit count] [nvarchar](255) NULL,
	[Opportunities] [nvarchar](255) NULL,
	[Attribute] [nvarchar](255) NULL,
	[Aspect] [nvarchar](255) NULL,
	[Value] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChangeHealth_AR_Raw_data]    Script Date: 9/10/2020 2:51:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChangeHealth_AR_Raw_data](
	[Week] [datetime] NULL,
	[WeekNum] [nvarchar](255) NULL,
	[Client Name] [nvarchar](255) NULL,
	[OJT/Live] [nvarchar](255) NULL,
	[Client #] [float] NULL,
	[SOW ID #] [float] NULL,
	[Work Scope] [nvarchar](255) NULL,
	[Account #] [nvarchar](255) NULL,
	[Process Date] [datetime] NULL,
	[Audited Date] [datetime] NULL,
	[Pocessed By] [nvarchar](255) NULL,
	[Employee ID ] [nvarchar](255) NULL,
	[Auditor] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Account Type (Voice/Non-Voice)] [nvarchar](255) NULL,
	[Status Code] [nvarchar](255) NULL,
	[Action Code] [nvarchar](255) NULL,
	[Assistance Required (Yes/No)] [nvarchar](255) NULL,
	[Error] [nvarchar](255) NULL,
	[Rebuttal] [nvarchar](255) NULL,
	[Rebuttal Received date] [datetime] NULL,
	[Rebuttal Validated Date] [datetime] NULL,
	[Rebuttal TAT] [nvarchar](255) NULL,
	[Ops Rebuttal Comments] [nvarchar](255) NULL,
	[Rebuttal status] [nvarchar](255) NULL,
	[Research] [float] NULL,
	[Decision] [float] NULL,
	[Action] [float] NULL,
	[Documentation] [float] NULL,
	[Effectiveness] [float] NULL,
	[DPU] [float] NULL,
	[DPO] [float] NULL,
	[Hybrid] [float] NULL,
	[DU] [float] NULL,
	[Error Count] [float] NULL,
	[Fatal error count] [float] NULL,
	[non Fatal error count] [float] NULL,
	[Defective call] [float] NULL,
	[fatal defictive call] [float] NULL,
	[Audit count] [float] NULL,
	[Opportunities] [float] NULL,
	[Check Open Balance] [nvarchar](255) NULL,
	[Verify Workable / Non-Workable] [nvarchar](255) NULL,
	[Check Payorclass ] [nvarchar](255) NULL,
	[Verify Bill State] [nvarchar](255) NULL,
	[Insurance Sequence Verified] [nvarchar](255) NULL,
	[Verify Edi Status( Availity Or Y/Halley Screen )] [nvarchar](255) NULL,
	[Verify Previous Comments / Claim History] [nvarchar](255) NULL,
	[Verify Rai Status] [nvarchar](255) NULL,
	[Verify Mdiv/Image Now & All Other Web Portals] [nvarchar](255) NULL,
	[Verify Authorization#/Referral] [nvarchar](255) NULL,
	[Verifying Eob/Correspondence] [nvarchar](255) NULL,
	[Verify Patient Eligibility/Cob] [nvarchar](255) NULL,
	[Call Required] [nvarchar](255) NULL,
	[Verify Payment Information] [nvarchar](255) NULL,
	[Request Eob] [nvarchar](255) NULL,
	[Verified Denial Reason] [nvarchar](255) NULL,
	[Obtain The Accurate Mailing/Appeal Address/Fax#] [nvarchar](255) NULL,
	[Verified Tfl/Afl] [nvarchar](255) NULL,
	[Verify Claim Split -Up Lines] [nvarchar](255) NULL,
	[Reprocessing Of Claim] [nvarchar](255) NULL,
	[Correct Adjustment Taken] [nvarchar](255) NULL,
	[Incorrect Adjustment code] [nvarchar](255) NULL,
	[Refilling Claim] [nvarchar](255) NULL,
	[Generating Spooler] [nvarchar](255) NULL,
	[Appropriate Ins Correction] [nvarchar](255) NULL,
	[Appeals In Respective Path/Missing Payment Form] [nvarchar](255) NULL,
	[Linking Correspondence / Routing / Stamping The Batch] [nvarchar](255) NULL,
	[Changing Payor Class] [nvarchar](255) NULL,
	[Changing Bill State] [nvarchar](255) NULL,
	[Routed To Backend] [nvarchar](255) NULL,
	[Raising RAI] [nvarchar](255) NULL,
	[Necessary Corrections In Patient Demo] [nvarchar](255) NULL,
	[Reject Bal To Patient] [nvarchar](255) NULL,
	[Review/Follow-Up Date Has Set] [nvarchar](255) NULL,
	[Irrelevant Documentation (Action Incorrect/Not Related To Action] [nvarchar](255) NULL,
	[Incorrect Documentation (Cpt Code/Bal#/Line # Is Incorrect/Incor] [nvarchar](255) NULL,
	[Incomplete Documentation] [nvarchar](255) NULL,
	[Missed To Post Notes In Mdiv/Gsf] [nvarchar](255) NULL,
	[Verified Workable/Non Workable Claim] [nvarchar](255) NULL,
	[All Required Line Items Worked] [nvarchar](255) NULL,
	[Encounter Moved To Coder/Clarification Log] [nvarchar](255) NULL,
	[Appropriate Comment Code] [nvarchar](255) NULL,
	[Posted The Rejection / Denial Correctly / Adjustment / Re-filing] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChangeHealth_AR_Tracker]    Script Date: 9/10/2020 2:51:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChangeHealth_AR_Tracker](
	[Week] [nvarchar](255) NULL,
	[Region Name] [nvarchar](255) NULL,
	[Emp Name] [nvarchar](255) NULL,
	[Client Login] [nvarchar](255) NULL,
	[Processed Date] [datetime] NULL,
	[Team] [nvarchar](255) NULL,
	[Work Scope] [nvarchar](255) NULL,
	[Manager Name] [nvarchar](255) NULL,
	[SOW ID] [float] NULL,
	[Client #] [float] NULL,
	[Account #] [float] NULL,
	[Error Type] [nvarchar](255) NULL,
	[# of Errors] [float] NULL,
	[Alert Sent Date] [datetime] NULL,
	[RAP Closer Date] [nvarchar](255) NULL,
	[RAP status] [nvarchar](255) NULL,
	[TAT (Met/Not Met)] [nvarchar](255) NULL,
	[Actions taken by Ops Ops Lead] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChangeHealth_TP_Parameter_Raw]    Script Date: 9/10/2020 2:51:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChangeHealth_TP_Parameter_Raw](
	[Week] [datetime] NULL,
	[WeekNum] [nvarchar](255) NULL,
	[Region] [nvarchar](255) NULL,
	[Client Name] [nvarchar](255) NULL,
	[Service] [nvarchar](255) NULL,
	[Batch No] [nvarchar](255) NULL,
	[Account #] [nvarchar](255) NULL,
	[Encounter No] [nvarchar](255) NULL,
	[SOW ID #] [nvarchar](255) NULL,
	[Pocessed By] [nvarchar](255) NULL,
	[Process Date] [datetime] NULL,
	[Auditor] [nvarchar](255) NULL,
	[Audited Date] [datetime] NULL,
	[Employee ID ] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Rebuttal] [nvarchar](255) NULL,
	[Rebuttal status] [nvarchar](255) NULL,
	[Action] [float] NULL,
	[Documentation] [float] NULL,
	[DPU] [float] NULL,
	[DPO] [float] NULL,
	[Hybrid] [float] NULL,
	[DU] [float] NULL,
	[Error/Not an Error] [nvarchar](255) NULL,
	[Error Count] [float] NULL,
	[Fatal error count] [float] NULL,
	[non Fatal error count] [float] NULL,
	[Audit count] [float] NULL,
	[Opportunities] [float] NULL,
	[Attribute] [nvarchar](255) NULL,
	[Value] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChangeHealth_TP_Raw_data]    Script Date: 9/10/2020 2:51:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChangeHealth_TP_Raw_data](
	[Week] [datetime] NULL,
	[WeekNum] [nvarchar](255) NULL,
	[Region] [nvarchar](255) NULL,
	[Client Name] [nvarchar](255) NULL,
	[Service] [nvarchar](255) NULL,
	[Batch No] [nvarchar](255) NULL,
	[Account #] [float] NULL,
	[Encounter No] [float] NULL,
	[SOW ID #] [float] NULL,
	[Pocessed By] [nvarchar](255) NULL,
	[Process Date] [datetime] NULL,
	[Auditor] [nvarchar](255) NULL,
	[Audited Date] [datetime] NULL,
	[Employee ID ] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Rebuttal] [nvarchar](255) NULL,
	[Rebuttal status] [nvarchar](255) NULL,
	[Action] [float] NULL,
	[Documentation] [float] NULL,
	[DPU] [float] NULL,
	[DPO] [float] NULL,
	[Hybrid] [float] NULL,
	[DU] [float] NULL,
	[Error/Not an Error] [nvarchar](255) NULL,
	[Error Count] [float] NULL,
	[Fatal error count] [float] NULL,
	[non Fatal error count] [float] NULL,
	[Audit count] [float] NULL,
	[Opportunities] [float] NULL,
	[Denial incorrect/Not posted] [float] NULL,
	[Deposit date] [float] NULL,
	[Incorrect account] [float] NULL,
	[DOS - Missing/Incorrect] [float] NULL,
	[Batch not balanced] [float] NULL,
	[Incorrect Check Number] [float] NULL,
	[Incorrect Batch Number] [float] NULL,
	[EOB not linked/incorrectly linked] [float] NULL,
	[Payclass - incorrect] [float] NULL,
	[ADJ - incorrect/Missed] [float] NULL,
	[SEQUESTRATION - Incorrect ADJ/Missed] [float] NULL,
	[ Incorrect PT Resp (Coins, Deductible) Posted/Not posted] [float] NULL,
	[Incorrect payment posting] [float] NULL,
	[Wrong CPT posting] [float] NULL,
	[Offset details not update/Incorrectly Posted] [float] NULL,
	[Back out not done/Incorrectly Done] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[claim_by_person]    Script Date: 9/10/2020 2:51:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[claim_by_person](
	[OUTCREATED_DATE] [datetime] NULL,
	[count_by] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Claim_List_4]    Script Date: 9/10/2020 2:51:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Claim_List_4](
	[Claim_ID] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Claim_List_7]    Script Date: 9/10/2020 2:51:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Claim_List_7](
	[Claim_ID] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[claim_per_day]    Script Date: 9/10/2020 2:51:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[claim_per_day](
	[OUTCREATED_DATE] [datetime] NULL,
	[count] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[claim_perday_per_person]    Script Date: 9/10/2020 2:51:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[claim_perday_per_person](
	[OUTCREATED_DATE] [datetime] NULL,
	[count_by] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dec-Build]    Script Date: 9/10/2020 2:51:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dec-Build](
	[PRACTICE ID] [int] NULL,
	[PRACTICE NAME] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[OUTCREATED_TIME] [varchar](255) NULL,
	[OUTCREATED_HOUR] [int] NULL,
	[INCREATED] [varchar](255) NULL,
	[INCLAIMSTATUS] [varchar](255) NULL,
	[CLAIMID] [varchar](255) NULL,
	[SERVICEDATE] [date] NULL,
	[TRANSFERTYPE] [varchar](255) NULL,
	[PROVIDERNAME] [varchar](255) NULL,
	[IPNAME] [varchar](255) NULL,
	[IPID] [int] NULL,
	[IRCNAME] [varchar](255) NULL,
	[IRCID] [int] NULL,
	[IRCGROUP] [varchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](255) NULL,
	[SUB_WORKLISTNAME] [varchar](255) NULL,
	[WORKFLOWTYPE] [varchar](255) NULL,
	[WORKLIST_LOCATION] [varchar](255) NULL,
	[WORKLIST_ORGANIZATION] [varchar](255) NULL,
	[INKICKCODE] [varchar](255) NULL,
	[OUTCREATEDBY] [varchar](255) NULL,
	[OUTFLOWUSERLOCATION] [varchar](255) NULL,
	[DAYSINSTATUS] [int] NULL,
	[ACTION] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[OUTCLAIMSTATUS] [varchar](255) NULL,
	[NOTE] [varchar](3216) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](255) NULL,
	[WORKCLASS] [varchar](255) NULL,
	[VOICETYPE] [varchar](255) NULL,
	[BILLTYPE] [varchar](255) NULL,
	[OUTPAYERKICK] [varchar](255) NULL,
	[DEPARTMENT] [varchar](255) NULL,
	[PAYER_CATEGORY] [varchar](255) NULL,
	[KICKS_CATEGORY] [varchar](255) NULL,
	[Billing] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dfw claims]    Script Date: 9/10/2020 2:51:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dfw claims](
	[File Name] [varchar](50) NULL,
	[Date of Service] [varchar](50) NULL,
	[Filing Method] [varchar](50) NULL,
	[Filing Type] [varchar](50) NULL,
	[Clearinghouse] [varchar](50) NULL,
	[Filed By] [varchar](50) NULL,
	[Filed To] [varchar](50) NULL,
	[Created By] [varchar](50) NULL,
	[Date Created] [varchar](50) NULL,
	[Date Transmitted] [varchar](50) NULL,
	[Procedure Filed] [varchar](5000) NULL,
	[Amount Filed] [varchar](50) NULL,
	[Month] [varchar](50) NULL,
	[Year] [varchar](50) NULL,
	[Sub-client] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dfw_claims]    Script Date: 9/10/2020 2:51:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dfw_claims](
	[File Name] [varchar](50) NULL,
	[Date of Service] [varchar](50) NULL,
	[Filing Method] [varchar](50) NULL,
	[Filing Type] [varchar](50) NULL,
	[Clearinghouse] [varchar](50) NULL,
	[Filed By] [varchar](50) NULL,
	[Filed To] [varchar](50) NULL,
	[Created By] [varchar](50) NULL,
	[Date Created] [varchar](50) NULL,
	[Date Transmitted] [varchar](50) NULL,
	[Procedure Filed] [varchar](50) NULL,
	[Amount Filed] [varchar](50) NULL,
	[Month] [varchar](50) NULL,
	[Year] [varchar](50) NULL,
	[Sub-client] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOS_TPX]    Script Date: 9/10/2020 2:51:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOS_TPX](
	[Ticket] [float] NULL,
	[DOS] [datetime] NULL,
	[Provider] [nvarchar](255) NULL,
	[Refering Provider] [nvarchar](255) NULL,
	[Rendering provider] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOS_TPX_Apr]    Script Date: 9/10/2020 2:51:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOS_TPX_Apr](
	[Ticket] [float] NULL,
	[DOS] [datetime] NULL,
	[Provider] [nvarchar](255) NULL,
	[Refering Provider] [nvarchar](255) NULL,
	[Rendering provider] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOS_TPX_Feb]    Script Date: 9/10/2020 2:51:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOS_TPX_Feb](
	[Ticket] [float] NULL,
	[DOS] [datetime] NULL,
	[Provider] [nvarchar](255) NULL,
	[Refering Provider] [nvarchar](255) NULL,
	[Rendering provider] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOS_TPX_Jan]    Script Date: 9/10/2020 2:51:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOS_TPX_Jan](
	[Ticket] [float] NULL,
	[DOS] [datetime] NULL,
	[Provider] [nvarchar](255) NULL,
	[Refering Provider] [nvarchar](255) NULL,
	[Rendering provider] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOS_TPX_Jun]    Script Date: 9/10/2020 2:51:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOS_TPX_Jun](
	[Ticket] [float] NULL,
	[DOS] [datetime] NULL,
	[Provider] [nvarchar](255) NULL,
	[Refering Provider] [nvarchar](255) NULL,
	[Rendering provider] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOS_TPX_Mar]    Script Date: 9/10/2020 2:51:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOS_TPX_Mar](
	[Ticket] [float] NULL,
	[DOS] [datetime] NULL,
	[Provider] [nvarchar](255) NULL,
	[Refering Provider] [nvarchar](255) NULL,
	[Rendering provider] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOS_TPX_May]    Script Date: 9/10/2020 2:51:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOS_TPX_May](
	[Ticket] [float] NULL,
	[DOS] [datetime] NULL,
	[Provider] [nvarchar](255) NULL,
	[Refering Provider] [nvarchar](255) NULL,
	[Rendering provider] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dump Consolidated]    Script Date: 9/10/2020 2:51:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dump Consolidated](
	[Claim ID] [nvarchar](255) NULL,
	[Context] [nvarchar](255) NULL,
	[Worklist] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Supervising Provider Name] [nvarchar](255) NULL,
	[Claim Submission Category] [nvarchar](255) NULL,
	[Last Action] [nvarchar](255) NULL,
	[Days in Status] [nvarchar](255) NULL,
	[Service Date] [datetime] NULL,
	[Outstanding] [float] NULL,
	[Last CRM Case Note] [nvarchar](255) NULL,
	[Billing Batch ID] [nvarchar](255) NULL,
	[NewColumn#Work list] [nvarchar](255) NULL,
	[NewColumn#Location] [nvarchar](255) NULL,
	[NewColumn#Manager] [nvarchar](255) NULL,
	[NewColumn#Leads] [nvarchar](255) NULL,
	[NewColumn#Time Zome] [nvarchar](255) NULL,
	[NewColumn#State] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DVR_AUG_DEC]    Script Date: 9/10/2020 2:51:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DVR_AUG_DEC](
	[DOJ] [nvarchar](255) NULL,
	[Production Date] [datetime] NULL,
	[Status] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[ECN] [nvarchar](255) NULL,
	[NT Login] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[athena] [nvarchar](255) NULL,
	[Supervisor] [nvarchar](255) NULL,
	[Manager] [nvarchar](255) NULL,
	[Process] [nvarchar](255) NULL,
	[Tenurity] [nvarchar](255) NULL,
	[Login Time] [datetime] NULL,
	[Logout Time] [datetime] NULL,
	[active Time] [datetime] NULL,
	[Break Time] [datetime] NULL,
	[Target] [nvarchar](255) NULL,
	[My Time] [float] NULL,
	[Met 1] [float] NULL,
	[Target2] [float] NULL,
	[Achieved] [float] NULL,
	[Pro %] [float] NULL,
	[Pro Met] [float] NULL,
	[achieved -(NO  RECaLL)] [float] NULL,
	[Pro % -(NO  RECaLL)] [float] NULL,
	[Pro Met -(NO  RECaLL)] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DVR-OCT18]    Script Date: 9/10/2020 2:51:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DVR-OCT18](
	[Week] [datetime] NULL,
	[Production Date] [datetime] NULL,
	[Status] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[ECN] [nvarchar](255) NULL,
	[NT Login] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Athena] [nvarchar](255) NULL,
	[Supervisor] [nvarchar](255) NULL,
	[Manager] [nvarchar](255) NULL,
	[Process] [nvarchar](255) NULL,
	[Tenurity] [nvarchar](255) NULL,
	[Login Time] [datetime] NULL,
	[Logout Time] [datetime] NULL,
	[Active Time] [datetime] NULL,
	[Break Time] [datetime] NULL,
	[Target] [nvarchar](255) NULL,
	[My Time] [float] NULL,
	[Met 1] [float] NULL,
	[Target2] [float] NULL,
	[Achieved] [float] NULL,
	[Pro %] [float] NULL,
	[Pro Met] [float] NULL,
	[Achieved -(NO  RECALL)] [float] NULL,
	[Pro % -(NO  RECALL)] [float] NULL,
	[Pro Met -(NO  RECALL)] [float] NULL,
	[Audit Count] [float] NULL,
	[Defective Count] [float] NULL,
	[Quality Score] [float] NULL,
	[Quality Met 2] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[emplyee_mask]    Script Date: 9/10/2020 2:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[emplyee_mask](
	[Employee_Original] [varchar](255) NULL,
	[Employee_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ERA_10]    Script Date: 9/10/2020 2:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERA_10](
	[InvoiceID] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ERA_11]    Script Date: 9/10/2020 2:51:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERA_11](
	[InvoiceID] [varchar](11) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ERA_9]    Script Date: 9/10/2020 2:51:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERA_9](
	[InvoiceID] [varchar](9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ERA_Payer_Payment]    Script Date: 9/10/2020 2:51:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERA_Payer_Payment](
	[InvoiceID] [varchar](500) NULL,
	[PayerCode1] [varchar](100) NULL,
	[PayerCode2] [varchar](100) NULL,
	[SubClient] [varchar](100) NULL,
	[PymtAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ERA_tPaymentPosting]    Script Date: 9/10/2020 2:51:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERA_tPaymentPosting](
	[RowNumber] [varchar](500) NULL,
	[pageNo] [int] NULL,
	[BatchNo] [varchar](500) NULL,
	[InvoiceID] [varchar](500) NULL,
	[PatientLastName] [varchar](500) NULL,
	[PatientFirstName] [varchar](500) NULL,
	[PatientMiddleName] [varchar](500) NULL,
	[AddInsPackageID] [varchar](500) NULL,
	[ICN] [varchar](500) NULL,
	[FromDOS] [varchar](500) NULL,
	[ToDOS] [varchar](500) NULL,
	[ProcedureCode] [varchar](500) NULL,
	[Modifier1] [varchar](500) NULL,
	[Modifier2] [varchar](500) NULL,
	[Modifier3] [varchar](500) NULL,
	[AmountBilled] [varchar](500) NULL,
	[UnitsBilled] [varchar](500) NULL,
	[checkNo] [varchar](500) NULL,
	[pymtAmt] [varchar](500) NULL,
	[coPayTrAmt] [varchar](500) NULL,
	[coInsTrAmt] [varchar](500) NULL,
	[dedTrAmt] [varchar](500) NULL,
	[otherTrAmt] [varchar](500) NULL,
	[globalTrAmt] [varchar](500) NULL,
	[contrAdjAmt] [varchar](500) NULL,
	[capitationAmt] [varchar](500) NULL,
	[managedCareAmt] [varchar](500) NULL,
	[otherAdjAmt] [varchar](500) NULL,
	[remiReCode] [varchar](500) NULL,
	[InterestAmt] [varchar](500) NULL,
	[CheckAmt] [varchar](500) NULL,
	[CheckDate] [varchar](500) NULL,
	[TypeOfInsurance] [varchar](500) NULL,
	[Crossoverinsurance] [varchar](500) NULL,
	[Rec] [varchar](500) NULL,
	[Status] [varchar](500) NULL,
	[SNo] [varchar](500) NULL,
	[CrossValid] [varchar](500) NULL,
	[MemberID] [varchar](500) NULL,
	[AutoID] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ERA_tPaymentPosting_derived]    Script Date: 9/10/2020 2:51:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERA_tPaymentPosting_derived](
	[RowNumber] [varchar](500) NULL,
	[pageNo] [int] NULL,
	[BatchNo] [varchar](500) NULL,
	[InvoiceID] [varchar](500) NULL,
	[PatientLastName] [varchar](500) NULL,
	[PatientFirstName] [varchar](500) NULL,
	[PatientMiddleName] [varchar](500) NULL,
	[AddInsPackageID] [varchar](500) NULL,
	[ICN] [varchar](500) NULL,
	[FromDOS] [varchar](500) NULL,
	[ToDOS] [varchar](500) NULL,
	[ProcedureCode] [varchar](500) NULL,
	[Modifier1] [varchar](500) NULL,
	[Modifier2] [varchar](500) NULL,
	[Modifier3] [varchar](500) NULL,
	[AmountBilled] [varchar](500) NULL,
	[UnitsBilled] [varchar](500) NULL,
	[checkNo] [varchar](500) NULL,
	[pymtAmt] [varchar](500) NULL,
	[coPayTrAmt] [varchar](500) NULL,
	[coInsTrAmt] [varchar](500) NULL,
	[dedTrAmt] [varchar](500) NULL,
	[otherTrAmt] [varchar](500) NULL,
	[globalTrAmt] [varchar](500) NULL,
	[contrAdjAmt] [varchar](500) NULL,
	[capitationAmt] [varchar](500) NULL,
	[managedCareAmt] [varchar](500) NULL,
	[otherAdjAmt] [varchar](500) NULL,
	[remiReCode] [varchar](500) NULL,
	[InterestAmt] [varchar](500) NULL,
	[CheckAmt] [varchar](500) NULL,
	[CheckDate] [varchar](500) NULL,
	[TypeOfInsurance] [varchar](500) NULL,
	[Crossoverinsurance] [varchar](500) NULL,
	[Rec] [varchar](500) NULL,
	[Status] [varchar](500) NULL,
	[SNo] [varchar](500) NULL,
	[CrossValid] [varchar](500) NULL,
	[MemberID] [varchar](500) NULL,
	[AutoID] [bigint] IDENTITY(1,1) NOT NULL,
	[BatchNoFileName] [varchar](100) NULL,
	[BatchNoPayerCode1] [varchar](100) NULL,
	[BatchNoPayerCode2] [varchar](100) NULL,
	[BatchNoSubClient] [varchar](100) NULL,
	[BatchNoDate] [date] NULL,
	[dummy] [varchar](200) NULL,
	[dummy1] [varchar](100) NULL,
	[dummy2] [varchar](100) NULL,
	[dummy3] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Follow_up]    Script Date: 9/10/2020 2:51:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Follow_up](
	[PRACTICE ID] [float] NULL,
	[PRACTICE NAME] [nvarchar](255) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [datetime] NULL,
	[OUTCREATED_HOUR] [float] NULL,
	[INCREATED] [datetime] NULL,
	[INCLAIMSTATUS] [nvarchar](255) NULL,
	[CLAIMID] [nvarchar](255) NULL,
	[SERVICEDATE] [datetime] NULL,
	[TRANSFERTYPE] [float] NULL,
	[PROVIDERNAME] [nvarchar](255) NULL,
	[IPNAME] [nvarchar](255) NULL,
	[IPID] [float] NULL,
	[IRCNAME] [nvarchar](255) NULL,
	[IRCID] [float] NULL,
	[IRCGROUP] [nvarchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [nvarchar](255) NULL,
	[SUB_WORKLISTNAME] [nvarchar](255) NULL,
	[WORKFLOWTYPE] [nvarchar](255) NULL,
	[WORKLIST_LOCATION] [nvarchar](255) NULL,
	[WORKLIST_ORGANIZATION] [nvarchar](255) NULL,
	[INKICKCODE] [nvarchar](255) NULL,
	[OUTCREATEDBY] [nvarchar](255) NULL,
	[OUTFLOWUSERLOCATION] [nvarchar](255) NULL,
	[DAYSINSTATUS] [float] NULL,
	[ACTION] [nvarchar](255) NULL,
	[OUTKICKCODE] [nvarchar](255) NULL,
	[OUTCLAIMSTATUS] [nvarchar](255) NULL,
	[NOTE] [nvarchar](255) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [nvarchar](255) NULL,
	[WORKCLASS] [nvarchar](255) NULL,
	[VOICETYPE] [nvarchar](255) NULL,
	[BILLTYPE] [nvarchar](255) NULL,
	[OUTPAYERKICK] [nvarchar](255) NULL,
	[DEPARTMENT] [nvarchar](255) NULL,
	[PAYER_CATEGORY] [nvarchar](255) NULL,
	[KICKS_CATEGORY] [nvarchar](255) NULL,
	[Billing] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FUP 10242019]    Script Date: 9/10/2020 2:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FUP 10242019](
	[PRACTICE ID] [bigint] NULL,
	[PRACTICE NAME] [varchar](max) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [time](7) NULL,
	[OUTCREATED_HOUR] [bigint] NULL,
	[INCREATED] [datetime] NULL,
	[INCLAIMSTATUS] [varchar](max) NULL,
	[CLAIMID] [varchar](max) NULL,
	[SERVICEDATE] [datetime] NULL,
	[TRANSFERTYPE] [bigint] NULL,
	[PROVIDERNAME] [varchar](max) NULL,
	[IPNAME] [varchar](max) NULL,
	[IPID] [bigint] NULL,
	[IRCNAME] [varchar](max) NULL,
	[IRCID] [bigint] NULL,
	[IRCGROUP] [varchar](max) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](max) NULL,
	[SUB_WORKLISTNAME] [varchar](max) NULL,
	[WORKFLOWTYPE] [varchar](max) NULL,
	[WORKLIST_LOCATION] [varchar](max) NULL,
	[WORKLIST_ORGANIZATION] [varchar](max) NULL,
	[INKICKCODE] [varchar](max) NULL,
	[OUTCREATEDBY] [varchar](max) NULL,
	[OUTFLOWUSERLOCATION] [varchar](max) NULL,
	[DAYSINSTATUS] [bigint] NULL,
	[ACTION] [varchar](max) NULL,
	[OUTKICKCODE] [varchar](max) NULL,
	[OUTCLAIMSTATUS] [varchar](max) NULL,
	[NOTE] [varchar](max) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](max) NULL,
	[WORKCLASS] [varchar](max) NULL,
	[VOICETYPE] [varchar](max) NULL,
	[BILLTYPE] [varchar](max) NULL,
	[OUTPAYERKICK] [varchar](max) NULL,
	[DEPARTMENT] [varchar](max) NULL,
	[PAYER_CATEGORY] [varchar](max) NULL,
	[KICKS_CATEGORY] [varchar](max) NULL,
	[HOSP_YN] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import_20180529]    Script Date: 9/10/2020 2:51:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import_20180529](
	[File Name] [varchar](50) NULL,
	[Date of Service] [varchar](50) NULL,
	[Filing Method] [varchar](50) NULL,
	[Filing Type] [varchar](50) NULL,
	[Clearinghouse] [varchar](50) NULL,
	[Filed By] [varchar](50) NULL,
	[Filed To] [varchar](5000) NULL,
	[Created By] [varchar](50) NULL,
	[Date Created] [varchar](50) NULL,
	[Date Transmitted] [varchar](50) NULL,
	[Procedure Filed] [varchar](5000) NULL,
	[Amount Filed] [varchar](50) NULL,
	[Month] [varchar](50) NULL,
	[Year] [varchar](50) NULL,
	[Sub-client] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inflow_additional]    Script Date: 9/10/2020 2:51:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inflow_additional](
	[row_names] [varchar](255) NULL,
	[Claim ID] [varchar](255) NULL,
	[Date] [date] NULL,
	[Category] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inflow_category]    Script Date: 9/10/2020 2:51:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inflow_category](
	[ClaimID] [varchar](255) NULL,
	[Date] [date] NULL,
	[Category] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inflow_category_1]    Script Date: 9/10/2020 2:51:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inflow_category_1](
	[row_names] [varchar](255) NULL,
	[Claim ID] [varchar](255) NULL,
	[Date] [date] NULL,
	[Category] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inflow_category_final]    Script Date: 9/10/2020 2:51:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inflow_category_final](
	[Claim ID] [varchar](255) NULL,
	[Date] [date] NULL,
	[Category] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inflow_category_final_Athena_Days]    Script Date: 9/10/2020 2:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inflow_category_final_Athena_Days](
	[row_names] [varchar](255) NULL,
	[Claim ID] [varchar](255) NULL,
	[Date] [date] NULL,
	[Category] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inflow_Category_Nov1]    Script Date: 9/10/2020 2:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inflow_Category_Nov1](
	[Claim ID] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[Category] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inflow_category_recall]    Script Date: 9/10/2020 2:51:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inflow_category_recall](
	[row_names] [varchar](255) NULL,
	[Claim ID] [varchar](255) NULL,
	[Date] [date] NULL,
	[Category] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inflow_Last_Recurring]    Script Date: 9/10/2020 2:51:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inflow_Last_Recurring](
	[Date] [date] NULL,
	[Claim ID] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[C] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[Category] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inflow_Last_Recurring_Additional]    Script Date: 9/10/2020 2:51:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inflow_Last_Recurring_Additional](
	[Date] [date] NULL,
	[Claim ID] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[C] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[Category] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inflow_masking]    Script Date: 9/10/2020 2:51:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inflow_masking](
	[Inflow_Original] [varchar](255) NULL,
	[Inflow_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inflow_Recurring]    Script Date: 9/10/2020 2:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inflow_Recurring](
	[row_names] [varchar](255) NULL,
	[Claim ID] [varchar](255) NULL,
	[Date] [date] NULL,
	[C] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[OUTKICKCODE] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview_stock]    Script Date: 9/10/2020 2:51:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview_stock](
	[Claim ID] [nvarchar](255) NULL,
	[Transfer Type] [nvarchar](255) NULL,
	[A] [nvarchar](255) NULL,
	[Claim Status] [nvarchar](255) NULL,
	[B] [nvarchar](255) NULL,
	[Days in Status] [nvarchar](255) NULL,
	[Outstanding Amount] [float] NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Status Athena Kickcode] [nvarchar](255) NULL,
	[Current Error Text] [nvarchar](255) NULL,
	[C] [nvarchar](255) NULL,
	[Parent Worklist Name] [nvarchar](255) NULL,
	[Sub Worklist Name] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Worklist Team Organization] [nvarchar](255) NULL,
	[Workflow Type] [nvarchar](255) NULL,
	[Worklist Location] [nvarchar](255) NULL,
	[Priority] [nvarchar](255) NULL,
	[Worked] [nvarchar](255) NULL,
	[Total Athena Days] [nvarchar](255) NULL,
	[Prescribed YN] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[ONLY_claimid] [nvarchar](255) NULL,
	[service_date] [datetime] NULL,
	[claim_date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IRC_mask]    Script Date: 9/10/2020 2:51:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IRC_mask](
	[IRC_Original] [varchar](255) NULL,
	[IRC_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[July]    Script Date: 9/10/2020 2:51:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[July](
	[index] [bigint] NULL,
	[PRACTICE ID] [float] NULL,
	[PRACTICE NAME] [varchar](max) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [time](7) NULL,
	[OUTCREATED_HOUR] [float] NULL,
	[INCREATED] [datetime] NULL,
	[INCLAIMSTATUS] [varchar](max) NULL,
	[CLAIMID] [varchar](max) NULL,
	[SERVICEDATE] [datetime] NULL,
	[TRANSFERTYPE] [varchar](max) NULL,
	[PROVIDERNAME] [varchar](max) NULL,
	[IPNAME] [varchar](max) NULL,
	[IPID] [float] NULL,
	[IRCNAME] [varchar](max) NULL,
	[IRCID] [float] NULL,
	[IRCGROUP] [varchar](max) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](max) NULL,
	[SUB_WORKLISTNAME] [varchar](max) NULL,
	[WORKFLOWTYPE] [varchar](max) NULL,
	[WORKLIST_LOCATION] [varchar](max) NULL,
	[WORKLIST_ORGANIZATION] [varchar](max) NULL,
	[INKICKCODE] [varchar](max) NULL,
	[OUTCREATEDBY] [varchar](max) NULL,
	[OUTFLOWUSERLOCATION] [varchar](max) NULL,
	[DAYSINSTATUS] [float] NULL,
	[ACTION] [varchar](max) NULL,
	[OUTKICKCODE] [varchar](max) NULL,
	[OUTCLAIMSTATUS] [varchar](max) NULL,
	[NOTE] [varchar](max) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](max) NULL,
	[WORKCLASS] [varchar](max) NULL,
	[VOICETYPE] [varchar](max) NULL,
	[BILLTYPE] [varchar](max) NULL,
	[OUTPAYERKICK] [varchar](max) NULL,
	[DEPARTMENT] [varchar](max) NULL,
	[PAYER_CATEGORY] [varchar](max) NULL,
	[KICKS_CATEGORY] [varchar](max) NULL,
	[Billing] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[July-Build]    Script Date: 9/10/2020 2:51:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[July-Build](
	[PRACTICE ID] [int] NULL,
	[PRACTICE NAME] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[OUTCREATED_TIME] [varchar](255) NULL,
	[OUTCREATED_HOUR] [int] NULL,
	[INCREATED] [varchar](255) NULL,
	[INCLAIMSTATUS] [varchar](255) NULL,
	[CLAIMID] [varchar](255) NULL,
	[SERVICEDATE] [date] NULL,
	[TRANSFERTYPE] [varchar](255) NULL,
	[PROVIDERNAME] [varchar](255) NULL,
	[IPNAME] [varchar](255) NULL,
	[IPID] [int] NULL,
	[IRCNAME] [varchar](255) NULL,
	[IRCID] [int] NULL,
	[IRCGROUP] [varchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](255) NULL,
	[SUB_WORKLISTNAME] [varchar](255) NULL,
	[WORKFLOWTYPE] [varchar](255) NULL,
	[WORKLIST_LOCATION] [varchar](255) NULL,
	[WORKLIST_ORGANIZATION] [varchar](255) NULL,
	[INKICKCODE] [varchar](255) NULL,
	[OUTCREATEDBY] [varchar](255) NULL,
	[OUTFLOWUSERLOCATION] [varchar](255) NULL,
	[DAYSINSTATUS] [int] NULL,
	[ACTION] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[OUTCLAIMSTATUS] [varchar](255) NULL,
	[NOTE] [varchar](4012) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](255) NULL,
	[WORKCLASS] [varchar](255) NULL,
	[VOICETYPE] [varchar](255) NULL,
	[BILLTYPE] [varchar](255) NULL,
	[OUTPAYERKICK] [varchar](255) NULL,
	[DEPARTMENT] [varchar](255) NULL,
	[PAYER_CATEGORY] [varchar](255) NULL,
	[KICKS_CATEGORY] [varchar](255) NULL,
	[Billing] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[June]    Script Date: 9/10/2020 2:51:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[June](
	[index] [bigint] NULL,
	[PRACTICE ID] [float] NULL,
	[PRACTICE NAME] [varchar](max) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [time](7) NULL,
	[OUTCREATED_HOUR] [float] NULL,
	[INCREATED] [datetime] NULL,
	[INCLAIMSTATUS] [varchar](max) NULL,
	[CLAIMID] [varchar](max) NULL,
	[SERVICEDATE] [datetime] NULL,
	[TRANSFERTYPE] [varchar](max) NULL,
	[PROVIDERNAME] [varchar](max) NULL,
	[IPNAME] [varchar](max) NULL,
	[IPID] [float] NULL,
	[IRCNAME] [varchar](max) NULL,
	[IRCID] [float] NULL,
	[IRCGROUP] [varchar](max) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](max) NULL,
	[SUB_WORKLISTNAME] [varchar](max) NULL,
	[WORKFLOWTYPE] [varchar](max) NULL,
	[WORKLIST_LOCATION] [varchar](max) NULL,
	[WORKLIST_ORGANIZATION] [varchar](max) NULL,
	[INKICKCODE] [varchar](max) NULL,
	[OUTCREATEDBY] [varchar](max) NULL,
	[OUTFLOWUSERLOCATION] [varchar](max) NULL,
	[DAYSINSTATUS] [float] NULL,
	[ACTION] [varchar](max) NULL,
	[OUTKICKCODE] [varchar](max) NULL,
	[OUTCLAIMSTATUS] [varchar](max) NULL,
	[NOTE] [varchar](max) NULL,
	[MONTHSUSERLIVE] [varchar](max) NULL,
	[LINEOFBUSINESS] [varchar](max) NULL,
	[WORKCLASS] [varchar](max) NULL,
	[VOICETYPE] [varchar](max) NULL,
	[BILLTYPE] [varchar](max) NULL,
	[OUTPAYERKICK] [varchar](max) NULL,
	[DEPARTMENT] [varchar](max) NULL,
	[PAYER_CATEGORY] [varchar](max) NULL,
	[KICKS_CATEGORY] [varchar](max) NULL,
	[Billing] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[June-Build]    Script Date: 9/10/2020 2:51:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[June-Build](
	[PRACTICE ID] [varchar](255) NULL,
	[PRACTICE NAME] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[OUTCREATED_TIME] [varchar](255) NULL,
	[OUTCREATED_HOUR] [int] NULL,
	[INCREATED] [varchar](255) NULL,
	[INCLAIMSTATUS] [varchar](255) NULL,
	[CLAIMID] [varchar](255) NULL,
	[SERVICEDATE] [date] NULL,
	[TRANSFERTYPE] [varchar](255) NULL,
	[PROVIDERNAME] [varchar](255) NULL,
	[IPNAME] [varchar](255) NULL,
	[IPID] [int] NULL,
	[IRCNAME] [varchar](255) NULL,
	[IRCID] [int] NULL,
	[IRCGROUP] [varchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](255) NULL,
	[SUB_WORKLISTNAME] [varchar](255) NULL,
	[WORKFLOWTYPE] [varchar](255) NULL,
	[WORKLIST_LOCATION] [varchar](255) NULL,
	[WORKLIST_ORGANIZATION] [varchar](255) NULL,
	[INKICKCODE] [varchar](255) NULL,
	[OUTCREATEDBY] [varchar](255) NULL,
	[OUTFLOWUSERLOCATION] [varchar](255) NULL,
	[DAYSINSTATUS] [int] NULL,
	[ACTION] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[OUTCLAIMSTATUS] [varchar](255) NULL,
	[NOTE] [varchar](4005) NULL,
	[MONTHSUSERLIVE] [varchar](255) NULL,
	[LINEOFBUSINESS] [varchar](255) NULL,
	[WORKCLASS] [varchar](255) NULL,
	[VOICETYPE] [varchar](255) NULL,
	[BILLTYPE] [varchar](255) NULL,
	[OUTPAYERKICK] [varchar](255) NULL,
	[DEPARTMENT] [varchar](255) NULL,
	[PAYER_CATEGORY] [varchar](255) NULL,
	[KICKS_CATEGORY] [varchar](255) NULL,
	[Billing] [varchar](255) NULL,
	[V41] [bit] NULL,
	[V42] [bit] NULL,
	[V43] [bit] NULL,
	[V44] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[May]    Script Date: 9/10/2020 2:51:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[May](
	[index] [bigint] NULL,
	[PRACTICE ID] [float] NULL,
	[PRACTICE NAME] [varchar](max) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [time](7) NULL,
	[OUTCREATED_HOUR] [float] NULL,
	[INCREATED] [datetime] NULL,
	[INCLAIMSTATUS] [varchar](max) NULL,
	[CLAIMID] [varchar](max) NULL,
	[SERVICEDATE] [datetime] NULL,
	[TRANSFERTYPE] [varchar](max) NULL,
	[PROVIDERNAME] [varchar](max) NULL,
	[IPNAME] [varchar](max) NULL,
	[IPID] [float] NULL,
	[IRCNAME] [varchar](max) NULL,
	[IRCID] [float] NULL,
	[IRCGROUP] [varchar](max) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](max) NULL,
	[SUB_WORKLISTNAME] [varchar](max) NULL,
	[WORKFLOWTYPE] [varchar](max) NULL,
	[WORKLIST_LOCATION] [varchar](max) NULL,
	[WORKLIST_ORGANIZATION] [varchar](max) NULL,
	[INKICKCODE] [varchar](max) NULL,
	[OUTCREATEDBY] [varchar](max) NULL,
	[OUTFLOWUSERLOCATION] [varchar](max) NULL,
	[DAYSINSTATUS] [float] NULL,
	[ACTION] [varchar](max) NULL,
	[OUTKICKCODE] [varchar](max) NULL,
	[OUTCLAIMSTATUS] [varchar](max) NULL,
	[NOTE] [varchar](max) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](max) NULL,
	[WORKCLASS] [varchar](max) NULL,
	[VOICETYPE] [varchar](max) NULL,
	[BILLTYPE] [varchar](max) NULL,
	[OUTPAYERKICK] [varchar](max) NULL,
	[DEPARTMENT] [varchar](max) NULL,
	[PAYER_CATEGORY] [varchar](max) NULL,
	[KICKS_CATEGORY] [varchar](max) NULL,
	[Billing] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[May-Build]    Script Date: 9/10/2020 2:51:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[May-Build](
	[PRACTICE ID] [varchar](255) NULL,
	[PRACTICE NAME] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[OUTCREATED_TIME] [varchar](255) NULL,
	[OUTCREATED_HOUR] [int] NULL,
	[INCREATED] [varchar](255) NULL,
	[INCLAIMSTATUS] [varchar](255) NULL,
	[CLAIMID] [varchar](255) NULL,
	[SERVICEDATE] [date] NULL,
	[TRANSFERTYPE] [varchar](255) NULL,
	[PROVIDERNAME] [varchar](255) NULL,
	[IPNAME] [varchar](255) NULL,
	[IPID] [int] NULL,
	[IRCNAME] [varchar](255) NULL,
	[IRCID] [int] NULL,
	[IRCGROUP] [varchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](255) NULL,
	[SUB_WORKLISTNAME] [varchar](255) NULL,
	[WORKFLOWTYPE] [varchar](255) NULL,
	[WORKLIST_LOCATION] [varchar](255) NULL,
	[WORKLIST_ORGANIZATION] [varchar](255) NULL,
	[INKICKCODE] [varchar](255) NULL,
	[OUTCREATEDBY] [varchar](255) NULL,
	[OUTFLOWUSERLOCATION] [varchar](255) NULL,
	[DAYSINSTATUS] [int] NULL,
	[ACTION] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[OUTCLAIMSTATUS] [varchar](255) NULL,
	[NOTE] [varchar](3584) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](255) NULL,
	[WORKCLASS] [varchar](255) NULL,
	[VOICETYPE] [varchar](255) NULL,
	[BILLTYPE] [varchar](255) NULL,
	[OUTPAYERKICK] [varchar](255) NULL,
	[DEPARTMENT] [varchar](255) NULL,
	[PAYER_CATEGORY] [varchar](255) NULL,
	[KICKS_CATEGORY] [varchar](255) NULL,
	[Billing] [varchar](255) NULL,
	[V41] [bit] NULL,
	[V42] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MidWest_Ar_ProcessMaster]    Script Date: 9/10/2020 2:51:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MidWest_Ar_ProcessMaster](
	[ProcessId] [int] IDENTITY(1,1) NOT NULL,
	[TicketId] [int] NOT NULL,
	[CallType] [varchar](50) NULL,
	[Appeal] [int] NULL,
	[IssueLog] [int] NULL,
	[IssuelogStatus] [int] NULL,
	[FeatureFollowup] [int] NULL,
	[FeatureFollowupDate] [datetime] NULL,
	[Coding] [int] NULL,
	[CallNotes] [varchar](max) NULL,
	[ProcessStatus] [int] NULL,
	[Status] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[PaymentAmount] [varchar](20) NULL,
	[PatientResponce] [varchar](50) NULL,
	[InsuranceResponce] [varchar](50) NULL,
	[IsPaymentPosting] [int] NOT NULL,
	[IsOss] [int] NOT NULL,
	[IlogSubCodeId] [int] NOT NULL,
	[ProcessDate] [date] NULL,
	[IsValidCallable] [int] NULL,
	[ProcessStartTime] [datetime] NULL,
	[BulkSubmitID] [varchar](50) NULL,
 CONSTRAINT [PK_MidWest_Ar_ProcessMaster] PRIMARY KEY CLUSTERED 
(
	[ProcessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Midwest_AR_TicketMaster]    Script Date: 9/10/2020 2:51:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Midwest_AR_TicketMaster](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NULL,
	[TicketStatus] [int] NULL,
	[LocationId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[ClientId] [int] NULL,
	[BillingNotes] [varchar](max) NULL,
	[ClientName] [varchar](200) NULL,
	[InvoiceStatus] [varchar](200) NULL,
	[visitOwner] [varchar](100) NULL,
	[TicketNumber] [varchar](100) NULL,
	[FinancialClass] [varchar](100) NULL,
	[DoctorsNPI] [varchar](200) NULL,
	[DoctorListName] [varchar](100) NULL,
	[CurrentInsurancePhone] [varchar](100) NULL,
	[Payer] [varchar](100) NULL,
	[CompanyListName] [varchar](100) NULL,
	[CaseInsuranceCarrier] [varchar](100) NULL,
	[LastFiledAge] [int] NULL,
	[CurrentInsuredId] [varchar](200) NULL,
	[AgeDOS] [int] NULL,
	[InsBalance] [decimal](18, 2) NULL,
	[TotalAmtBilled] [decimal](18, 2) NULL,
	[PatBalance] [decimal](18, 0) NULL,
	[ServiceDate] [datetime] NULL,
	[LastVOUpdateDate] [date] NULL,
	[LastFiledDate] [date] NULL,
	[FirstFiledDate] [date] NULL,
	[FirstDenialDate] [date] NULL,
	[LastDenialDate] [date] NULL,
	[PaidToAddress] [varchar](max) NULL,
	[FirstFiledAge] [int] NULL,
	[ImportType] [int] NOT NULL,
	[VisitDescription] [varchar](max) NULL,
	[QCAllocated] [int] NULL,
	[IsMultiTouch] [int] NOT NULL,
	[MultiTouchRowId] [int] NULL,
	[Shift] [varchar](25) NULL,
	[PatientName] [varbinary](max) NULL,
	[PatientBirthdate] [varbinary](max) NULL,
	[FederalTaxID] [varbinary](max) NULL,
	[FileType] [int] NULL,
	[TatStartDate] [datetime] NULL,
	[ExpectedTatEndDate] [datetime] NULL,
	[TatDurationMins] [int] NULL,
	[TatEndDate] [datetime] NULL,
	[MultiTouchFeedbackComment] [varchar](max) NULL,
	[MultiTouchCount] [int] NULL,
	[ImportRowId] [int] NULL,
	[PendingTATDuration] [int] NULL,
	[CompletedMode] [int] NULL,
 CONSTRAINT [PK__Midwest___712CC60752E34C9D] PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[New1]    Script Date: 9/10/2020 2:51:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[New1](
	[Week] [nvarchar](255) NULL,
	[Team] [nvarchar](255) NULL,
	[Processed By] [nvarchar](255) NULL,
	[Processed Date] [nvarchar](255) NULL,
	[Patient ID/Account #] [bigint] NULL,
	[Client  Name] [nvarchar](255) NULL,
	[Auditor Name] [nvarchar](255) NULL,
	[Audit Date] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Defects] [float] NULL,
	[Quality Score] [float] NULL,
	[Defective transs] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nov_build_report]    Script Date: 9/10/2020 2:51:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nov_build_report](
	[PRACTICE ID] [bigint] NULL,
	[PRACTICE NAME] [varchar](max) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [time](7) NULL,
	[OUTCREATED_HOUR] [bigint] NULL,
	[INCREATED] [datetime] NULL,
	[INCLAIMSTATUS] [varchar](max) NULL,
	[CLAIMID] [varchar](max) NULL,
	[SERVICEDATE] [datetime] NULL,
	[TRANSFERTYPE] [bigint] NULL,
	[PROVIDERNAME] [varchar](max) NULL,
	[IPNAME] [varchar](max) NULL,
	[IPID] [bigint] NULL,
	[IRCNAME] [varchar](max) NULL,
	[IRCID] [bigint] NULL,
	[IRCGROUP] [varchar](max) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](max) NULL,
	[SUB_WORKLISTNAME] [varchar](max) NULL,
	[WORKFLOWTYPE] [varchar](max) NULL,
	[WORKLIST_LOCATION] [varchar](max) NULL,
	[WORKLIST_ORGANIZATION] [varchar](max) NULL,
	[INKICKCODE] [varchar](max) NULL,
	[OUTCREATEDBY] [varchar](max) NULL,
	[OUTFLOWUSERLOCATION] [varchar](max) NULL,
	[DAYSINSTATUS] [bigint] NULL,
	[ACTION] [varchar](max) NULL,
	[OUTKICKCODE] [varchar](max) NULL,
	[OUTCLAIMSTATUS] [varchar](max) NULL,
	[NOTE] [varchar](max) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](max) NULL,
	[WORKCLASS] [varchar](max) NULL,
	[VOICETYPE] [varchar](max) NULL,
	[BILLTYPE] [varchar](max) NULL,
	[OUTPAYERKICK] [varchar](max) NULL,
	[DEPARTMENT] [varchar](max) NULL,
	[PAYER_CATEGORY] [varchar](max) NULL,
	[KICKS_CATEGORY] [varchar](max) NULL,
	[Billing] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NOV_STOCK]    Script Date: 9/10/2020 2:51:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NOV_STOCK](
	[Claim ID] [nvarchar](255) NULL,
	[Transfer Type] [nvarchar](255) NULL,
	[A] [nvarchar](255) NULL,
	[Claim Status] [nvarchar](255) NULL,
	[B] [nvarchar](255) NULL,
	[Days in Status] [nvarchar](255) NULL,
	[Outstanding Amount] [float] NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Status Athena Kickcode] [nvarchar](255) NULL,
	[Current Error Text] [nvarchar](255) NULL,
	[C] [nvarchar](255) NULL,
	[Parent Worklist Name] [nvarchar](255) NULL,
	[Sub Worklist Name] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Worklist Team Organization] [nvarchar](255) NULL,
	[Workflow Type] [nvarchar](255) NULL,
	[Worklist Location] [nvarchar](255) NULL,
	[Priority] [nvarchar](255) NULL,
	[Worked] [nvarchar](255) NULL,
	[Total Athena Days] [nvarchar](255) NULL,
	[Prescribed YN] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
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
	[F210] [nvarchar](255) NULL,
	[F211] [nvarchar](255) NULL,
	[F212] [nvarchar](255) NULL,
	[F213] [nvarchar](255) NULL,
	[F214] [nvarchar](255) NULL,
	[F215] [nvarchar](255) NULL,
	[F216] [nvarchar](255) NULL,
	[F217] [nvarchar](255) NULL,
	[F218] [nvarchar](255) NULL,
	[F219] [nvarchar](255) NULL,
	[F220] [nvarchar](255) NULL,
	[F221] [nvarchar](255) NULL,
	[F222] [nvarchar](255) NULL,
	[F223] [nvarchar](255) NULL,
	[F224] [nvarchar](255) NULL,
	[F225] [nvarchar](255) NULL,
	[F226] [nvarchar](255) NULL,
	[F227] [nvarchar](255) NULL,
	[F228] [nvarchar](255) NULL,
	[F229] [nvarchar](255) NULL,
	[F230] [nvarchar](255) NULL,
	[F231] [nvarchar](255) NULL,
	[F232] [nvarchar](255) NULL,
	[F233] [nvarchar](255) NULL,
	[F234] [nvarchar](255) NULL,
	[F235] [nvarchar](255) NULL,
	[F236] [nvarchar](255) NULL,
	[F237] [nvarchar](255) NULL,
	[F238] [nvarchar](255) NULL,
	[F239] [nvarchar](255) NULL,
	[F240] [nvarchar](255) NULL,
	[F241] [nvarchar](255) NULL,
	[F242] [nvarchar](255) NULL,
	[F243] [nvarchar](255) NULL,
	[F244] [nvarchar](255) NULL,
	[F245] [nvarchar](255) NULL,
	[F246] [nvarchar](255) NULL,
	[F247] [nvarchar](255) NULL,
	[F248] [nvarchar](255) NULL,
	[F249] [nvarchar](255) NULL,
	[F250] [nvarchar](255) NULL,
	[F251] [nvarchar](255) NULL,
	[F252] [nvarchar](255) NULL,
	[F253] [nvarchar](255) NULL,
	[F254] [nvarchar](255) NULL,
	[F255] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nov-Build]    Script Date: 9/10/2020 2:51:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nov-Build](
	[PRACTICE ID] [int] NULL,
	[PRACTICE NAME] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[OUTCREATED_TIME] [varchar](255) NULL,
	[OUTCREATED_HOUR] [int] NULL,
	[INCREATED] [varchar](255) NULL,
	[INCLAIMSTATUS] [varchar](255) NULL,
	[CLAIMID] [varchar](255) NULL,
	[SERVICEDATE] [date] NULL,
	[TRANSFERTYPE] [varchar](255) NULL,
	[PROVIDERNAME] [varchar](255) NULL,
	[IPNAME] [varchar](255) NULL,
	[IPID] [int] NULL,
	[IRCNAME] [varchar](255) NULL,
	[IRCID] [int] NULL,
	[IRCGROUP] [varchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](255) NULL,
	[SUB_WORKLISTNAME] [varchar](255) NULL,
	[WORKFLOWTYPE] [varchar](255) NULL,
	[WORKLIST_LOCATION] [varchar](255) NULL,
	[WORKLIST_ORGANIZATION] [varchar](255) NULL,
	[INKICKCODE] [varchar](255) NULL,
	[OUTCREATEDBY] [varchar](255) NULL,
	[OUTFLOWUSERLOCATION] [varchar](255) NULL,
	[DAYSINSTATUS] [int] NULL,
	[ACTION] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[OUTCLAIMSTATUS] [varchar](255) NULL,
	[NOTE] [varchar](3474) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](255) NULL,
	[WORKCLASS] [varchar](255) NULL,
	[VOICETYPE] [varchar](255) NULL,
	[BILLTYPE] [varchar](255) NULL,
	[OUTPAYERKICK] [varchar](255) NULL,
	[DEPARTMENT] [varchar](255) NULL,
	[PAYER_CATEGORY] [varchar](255) NULL,
	[KICKS_CATEGORY] [varchar](255) NULL,
	[Billing] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Oct31]    Script Date: 9/10/2020 2:51:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Oct31](
	[PRACTICE ID] [float] NULL,
	[PRACTICE NAME] [nvarchar](255) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [datetime] NULL,
	[OUTCREATED_HOUR] [float] NULL,
	[INCREATED] [datetime] NULL,
	[INCLAIMSTATUS] [nvarchar](255) NULL,
	[CLAIMID] [nvarchar](255) NULL,
	[SERVICEDATE] [datetime] NULL,
	[TRANSFERTYPE] [float] NULL,
	[PROVIDERNAME] [nvarchar](255) NULL,
	[IPNAME] [nvarchar](255) NULL,
	[IPID] [float] NULL,
	[IRCNAME] [nvarchar](255) NULL,
	[IRCID] [float] NULL,
	[IRCGROUP] [nvarchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [nvarchar](255) NULL,
	[SUB_WORKLISTNAME] [nvarchar](255) NULL,
	[WORKFLOWTYPE] [nvarchar](255) NULL,
	[WORKLIST_LOCATION] [nvarchar](255) NULL,
	[WORKLIST_ORGANIZATION] [nvarchar](255) NULL,
	[INKICKCODE] [nvarchar](255) NULL,
	[OUTCREATEDBY] [nvarchar](255) NULL,
	[OUTFLOWUSERLOCATION] [nvarchar](255) NULL,
	[DAYSINSTATUS] [float] NULL,
	[ACTION] [nvarchar](255) NULL,
	[OUTKICKCODE] [nvarchar](255) NULL,
	[OUTCLAIMSTATUS] [nvarchar](255) NULL,
	[NOTE] [nvarchar](max) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [nvarchar](255) NULL,
	[WORKCLASS] [nvarchar](255) NULL,
	[VOICETYPE] [nvarchar](255) NULL,
	[BILLTYPE] [nvarchar](255) NULL,
	[OUTPAYERKICK] [nvarchar](255) NULL,
	[DEPARTMENT] [nvarchar](255) NULL,
	[PAYER_CATEGORY] [nvarchar](255) NULL,
	[KICKS_CATEGORY] [nvarchar](255) NULL,
	[Billing] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Oct-Build]    Script Date: 9/10/2020 2:51:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Oct-Build](
	[PRACTICE ID] [int] NULL,
	[PRACTICE NAME] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[OUTCREATED_TIME] [varchar](255) NULL,
	[OUTCREATED_HOUR] [int] NULL,
	[INCREATED] [varchar](255) NULL,
	[INCLAIMSTATUS] [varchar](255) NULL,
	[CLAIMID] [varchar](255) NULL,
	[SERVICEDATE] [date] NULL,
	[TRANSFERTYPE] [int] NULL,
	[PROVIDERNAME] [varchar](255) NULL,
	[IPNAME] [varchar](255) NULL,
	[IPID] [int] NULL,
	[IRCNAME] [varchar](255) NULL,
	[IRCID] [int] NULL,
	[IRCGROUP] [varchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](255) NULL,
	[SUB_WORKLISTNAME] [varchar](255) NULL,
	[WORKFLOWTYPE] [varchar](255) NULL,
	[WORKLIST_LOCATION] [varchar](255) NULL,
	[WORKLIST_ORGANIZATION] [varchar](255) NULL,
	[INKICKCODE] [varchar](255) NULL,
	[OUTCREATEDBY] [varchar](255) NULL,
	[OUTFLOWUSERLOCATION] [varchar](255) NULL,
	[DAYSINSTATUS] [int] NULL,
	[ACTION] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[OUTCLAIMSTATUS] [varchar](255) NULL,
	[NOTE] [varchar](3860) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](255) NULL,
	[WORKCLASS] [varchar](255) NULL,
	[VOICETYPE] [varchar](255) NULL,
	[BILLTYPE] [varchar](255) NULL,
	[OUTPAYERKICK] [varchar](255) NULL,
	[DEPARTMENT] [varchar](255) NULL,
	[PAYER_CATEGORY] [varchar](255) NULL,
	[KICKS_CATEGORY] [varchar](255) NULL,
	[Billing] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[October_build_report]    Script Date: 9/10/2020 2:51:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[October_build_report](
	[PRACTICE ID] [bigint] NULL,
	[PRACTICE NAME] [varchar](max) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [time](7) NULL,
	[OUTCREATED_HOUR] [bigint] NULL,
	[INCREATED] [datetime] NULL,
	[INCLAIMSTATUS] [varchar](max) NULL,
	[CLAIMID] [varchar](max) NULL,
	[SERVICEDATE] [datetime] NULL,
	[TRANSFERTYPE] [bigint] NULL,
	[PROVIDERNAME] [varchar](max) NULL,
	[IPNAME] [varchar](max) NULL,
	[IPID] [bigint] NULL,
	[IRCNAME] [varchar](max) NULL,
	[IRCID] [bigint] NULL,
	[IRCGROUP] [varchar](max) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](max) NULL,
	[SUB_WORKLISTNAME] [varchar](max) NULL,
	[WORKFLOWTYPE] [varchar](max) NULL,
	[WORKLIST_LOCATION] [varchar](max) NULL,
	[WORKLIST_ORGANIZATION] [varchar](max) NULL,
	[INKICKCODE] [varchar](max) NULL,
	[OUTCREATEDBY] [varchar](max) NULL,
	[OUTFLOWUSERLOCATION] [varchar](max) NULL,
	[DAYSINSTATUS] [bigint] NULL,
	[ACTION] [varchar](max) NULL,
	[OUTKICKCODE] [varchar](max) NULL,
	[OUTCLAIMSTATUS] [varchar](max) NULL,
	[NOTE] [varchar](max) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](max) NULL,
	[WORKCLASS] [varchar](max) NULL,
	[VOICETYPE] [varchar](max) NULL,
	[BILLTYPE] [varchar](max) NULL,
	[OUTPAYERKICK] [varchar](max) NULL,
	[DEPARTMENT] [varchar](max) NULL,
	[PAYER_CATEGORY] [varchar](max) NULL,
	[KICKS_CATEGORY] [varchar](max) NULL,
	[Billing] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OUTCLAIMSTATUS_mask]    Script Date: 9/10/2020 2:51:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OUTCLAIMSTATUS_mask](
	[OUTCLAIMSTATUS_Original] [varchar](255) NULL,
	[OUTCLAIMSTATUS_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Outflow_masking]    Script Date: 9/10/2020 2:51:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Outflow_masking](
	[Outflow_Original] [varchar](255) NULL,
	[Outflowflow_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pacific_AR_TicketMaster]    Script Date: 9/10/2020 2:51:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pacific_AR_TicketMaster](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[QCAllocated] [int] NULL,
	[Status] [int] NULL,
	[TicketStatus] [int] NULL,
	[LocationId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[ClientId] [int] NULL,
	[TicketNumber] [varchar](100) NULL,
	[Priority] [varchar](255) NULL,
	[Account_key] [varchar](255) NULL,
	[Payer] [varchar](255) NULL,
	[mid_init] [varchar](255) NULL,
	[file_date] [datetime] NULL,
	[ClientName] [varchar](100) NULL,
	[Refile_date] [datetime] NULL,
	[Payer_key] [varchar](255) NULL,
	[charge] [float] NULL,
	[Balance] [float] NULL,
	[File_Age] [int] NULL,
	[Note_Age] [int] NULL,
	[Claim_Status] [varchar](200) NULL,
	[svc_date] [date] NULL,
	[Sort_age] [varchar](255) NULL,
	[Resp_val] [varchar](255) NULL,
	[Last_note] [varchar](255) NULL,
	[Misc_chrg] [varchar](255) NULL,
	[Unp_txn] [varchar](255) NULL,
	[Credit] [varchar](255) NULL,
	[Svc_bkt] [varchar](255) NULL,
	[Level] [varchar](255) NULL,
	[Ar_status] [varchar](255) NULL,
	[Clm_status] [varchar](255) NULL,
	[Clm_meth] [varchar](255) NULL,
	[Idle_age] [varchar](255) NULL,
	[svc_age] [varchar](255) NULL,
	[acct_key] [varchar](255) NULL,
	[plan_key] [varchar](255) NULL,
	[ImportType] [int] NOT NULL,
	[EntryDate] [date] NULL,
	[BatchHeader] [varchar](100) NULL,
	[PageNo] [varchar](50) NULL,
	[DenialNotes] [varchar](500) NULL,
	[ServiceDate] [date] NULL,
	[Claim_Balance] [varchar](100) NULL,
	[oldARTicketID] [int] NULL,
	[Shift] [varchar](25) NULL,
	[MultiTouchRowId] [int] NULL,
	[IsMultiTouch] [int] NULL,
	[PatientFirstName] [varbinary](max) NULL,
	[PatientLastName] [varbinary](max) NULL,
	[TatStartDate] [datetime] NULL,
	[ExpectedTatEndDate] [datetime] NULL,
	[TatDurationMins] [int] NULL,
	[TatEndDate] [datetime] NULL,
	[MultiTouchFeedbackComment] [varchar](max) NULL,
	[MultiTouchCount] [int] NULL,
	[ImportRowId] [int] NULL,
	[InvoiceType] [int] NULL,
	[CompletedMode] [int] NULL,
	[PendingTATDuration] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parameter]    Script Date: 9/10/2020 2:51:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parameter](
	[Month] [nvarchar](255) NULL,
	[Process] [nvarchar](255) NULL,
	[Actual date] [datetime] NULL,
	[Audit date] [datetime] NULL,
	[ClientUserID] [nvarchar](255) NULL,
	[Emp#ID] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Manager] [nvarchar](255) NULL,
	[Claim ID] [nvarchar](255) NULL,
	[IPNAME] [nvarchar](255) NULL,
	[ACTIONS] [nvarchar](255) NULL,
	[KICKCODE] [nvarchar](255) NULL,
	[Audit Type] [nvarchar](255) NULL,
	[AUDITBY] [nvarchar](255) NULL,
	[Sub Process] [nvarchar](255) NULL,
	[WorkFlow] [nvarchar](255) NULL,
	[WOW] [nvarchar](255) NULL,
	[Dialer] [nvarchar](255) NULL,
	[Link] [nvarchar](255) NULL,
	[QC Comments - Overall] [nvarchar](255) NULL,
	[QUALITYPERCENTAGE] [nvarchar](255) NULL,
	[Error count] [nvarchar](255) NULL,
	[Critical Claim] [nvarchar](255) NULL,
	[Critical Count] [nvarchar](255) NULL,
	[Esclation Count] [nvarchar](255) NULL,
	[Non Critical Count] [nvarchar](255) NULL,
	[Error Type] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Audit count] [float] NULL,
	[Attribute] [nvarchar](255) NULL,
	[Value] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[parameter$]    Script Date: 9/10/2020 2:51:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[parameter$](
	[Month] [nvarchar](255) NULL,
	[Process] [nvarchar](255) NULL,
	[Actual date] [datetime] NULL,
	[Audit date] [datetime] NULL,
	[ClientUserID] [nvarchar](255) NULL,
	[Emp#ID] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Team Lead] [nvarchar](255) NULL,
	[Manager] [nvarchar](255) NULL,
	[Claim ID] [nvarchar](255) NULL,
	[IPNAME] [nvarchar](255) NULL,
	[ACTIONS] [nvarchar](255) NULL,
	[KICKCODE] [nvarchar](255) NULL,
	[Audit Type] [nvarchar](255) NULL,
	[AUDITBY] [nvarchar](255) NULL,
	[Sub Process] [nvarchar](255) NULL,
	[WorkFlow] [nvarchar](255) NULL,
	[WOW] [nvarchar](255) NULL,
	[Dialer] [nvarchar](255) NULL,
	[Link] [nvarchar](255) NULL,
	[QC Comments - Overall] [nvarchar](255) NULL,
	[QUALITYPERCENTAGE] [nvarchar](255) NULL,
	[Error count] [nvarchar](255) NULL,
	[Critical Claim] [nvarchar](255) NULL,
	[Critical Count] [nvarchar](255) NULL,
	[Esclation Count] [nvarchar](255) NULL,
	[Non Critical Count] [nvarchar](255) NULL,
	[Error Type] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Audit count] [float] NULL,
	[Attribute] [nvarchar](255) NULL,
	[Value] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parent_Worklist_Name]    Script Date: 9/10/2020 2:51:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parent_Worklist_Name](
	[Parent_Worklist_Name] [varchar](255) NULL,
	[Maskked_Parent_Worklist_Name] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PAYER_CATEGORY_mask]    Script Date: 9/10/2020 2:51:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PAYER_CATEGORY_mask](
	[PAYER_CATEGORY_Original] [varchar](255) NULL,
	[PAYER_CATEGORY_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payer_TPX]    Script Date: 9/10/2020 2:52:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payer_TPX](
	[Ticket ] [float] NULL,
	[Batch Date] [datetime] NULL,
	[Procedure Code] [varchar](max) NULL,
	[Primary Payer] [nvarchar](255) NULL,
	[Secondary payer] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL,
	[Procedure Code1] [nvarchar](max) NULL,
	[ProcedureCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payer_TPX_Apr]    Script Date: 9/10/2020 2:52:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payer_TPX_Apr](
	[Ticket ] [float] NULL,
	[Batch Date] [datetime] NULL,
	[Procedure Code] [nvarchar](255) NULL,
	[Primary Payer] [nvarchar](255) NULL,
	[Secondary payer] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payer_TPX_Feb]    Script Date: 9/10/2020 2:52:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payer_TPX_Feb](
	[Ticket ] [float] NULL,
	[Batch Date] [datetime] NULL,
	[Procedure Code] [nvarchar](255) NULL,
	[Primary Payer] [nvarchar](255) NULL,
	[Secondary payer] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payer_TPX_Jan]    Script Date: 9/10/2020 2:52:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payer_TPX_Jan](
	[Ticket ] [float] NULL,
	[Batch Date] [datetime] NULL,
	[Procedure Code] [nvarchar](255) NULL,
	[Primary Payer] [nvarchar](255) NULL,
	[Secondary payer] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payer_TPX_Jun]    Script Date: 9/10/2020 2:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payer_TPX_Jun](
	[Ticket ] [float] NULL,
	[Batch Date] [datetime] NULL,
	[Procedure Code] [nvarchar](255) NULL,
	[Primary Payer] [nvarchar](255) NULL,
	[Secondary payer] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payer_TPX_Mar]    Script Date: 9/10/2020 2:52:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payer_TPX_Mar](
	[Ticket ] [float] NULL,
	[Batch Date] [datetime] NULL,
	[Procedure Code] [nvarchar](255) NULL,
	[Primary Payer] [nvarchar](255) NULL,
	[Secondary payer] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payer_TPX_May]    Script Date: 9/10/2020 2:52:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payer_TPX_May](
	[Ticket ] [float] NULL,
	[Batch Date] [datetime] NULL,
	[Procedure Code] [nvarchar](255) NULL,
	[Primary Payer] [nvarchar](255) NULL,
	[Secondary payer] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[Subclient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Month]    Script Date: 9/10/2020 2:52:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Month](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportMonth] [varchar](15) NULL,
	[ShortMonth] [varchar](6) NULL,
	[QuarterMonth] [varchar](15) NULL,
	[HalfYear] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Month_Bckup]    Script Date: 9/10/2020 2:52:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Month_Bckup](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportMonth] [varchar](15) NULL,
	[ShortMonth] [varchar](6) NULL,
	[QuarterMonth] [varchar](15) NULL,
	[HalfYear] [varchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_ClearGage]    Script Date: 9/10/2020 2:52:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_ClearGage](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[ProviderName] [varchar](100) NULL,
	[ClearGage] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Monthly_AgingReport]    Script Date: 9/10/2020 2:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Monthly_AgingReport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[ProviderName] [varchar](100) NULL,
	[ATBCategory] [varchar](100) NULL,
	[0-30] [decimal](18, 2) NULL,
	[31-60] [decimal](18, 2) NULL,
	[61-90] [decimal](18, 2) NULL,
	[91-120] [decimal](18, 2) NULL,
	[121-150] [decimal](18, 2) NULL,
	[151-180] [decimal](18, 2) NULL,
	[181+] [decimal](18, 2) NULL,
	[ARDays] [int] NULL,
	[CategoryBalance] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Monthly_CodingCurves]    Script Date: 9/10/2020 2:52:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Monthly_CodingCurves](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[TableVisits] [varchar](250) NULL,
	[ProviderName] [varchar](100) NULL,
	[CPTCODE] [varchar](15) NULL,
	[Fee] [decimal](18, 2) NULL,
	[CurrentFrequency] [decimal](18, 2) NULL,
	[CurrentTotalFee] [decimal](18, 2) NULL,
	[CurrentPracticeProfile] [varchar](100) NULL,
	[NationalDist] [varchar](100) NULL,
	[PracticevsNational] [varchar](100) NULL,
	[NewFrequency] [varchar](100) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Monthly_Collections]    Script Date: 9/10/2020 2:52:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Monthly_Collections](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[ProviderName] [varchar](100) NULL,
	[Collections] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Monthly_DM7]    Script Date: 9/10/2020 2:52:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Monthly_DM7](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[ProviderName] [varchar](100) NULL,
	[Voucher] [varchar](200) NULL,
	[Issue] [varchar](600) NULL,
	[Balance] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Monthly_DM7Details]    Script Date: 9/10/2020 2:52:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Monthly_DM7Details](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[DoctorName] [varchar](200) NULL,
	[PriInsName] [varchar](200) NULL,
	[AccountNumber] [varchar](100) NULL,
	[PatientName] [varchar](200) NULL,
	[ChargeAmount] [decimal](18, 2) NULL,
	[Receipts] [decimal](18, 2) NULL,
	[Adjusts] [decimal](18, 2) NULL,
	[Balance] [decimal](18, 2) NULL,
	[DateOfServ] [date] NULL,
	[DateOfPost] [date] NULL,
	[CPT] [varchar](50) NULL,
	[PrimaryDiag] [varchar](50) NULL,
	[CurrInsBillDt] [date] NULL,
	[LastActivityNoRebill] [date] NULL,
	[Voucher] [varchar](200) NULL,
	[Issue] [varchar](200) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Monthly_EncounterAnalysis]    Script Date: 9/10/2020 2:52:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Monthly_EncounterAnalysis](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[ProviderName] [varchar](100) NULL,
	[CPTCODE] [varchar](15) NULL,
	[CPTDescription] [varchar](600) NULL,
	[CPTGroup] [varchar](500) NULL,
	[CPTCount] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Monthly_Location_ChargePaymentAdjvsNet]    Script Date: 9/10/2020 2:52:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Monthly_Location_ChargePaymentAdjvsNet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[LocationName] [varchar](100) NULL,
	[GrossCharges] [decimal](18, 2) NULL,
	[VoidedCharges] [decimal](18, 2) NULL,
	[NetCharges] [decimal](18, 2) NULL,
	[GrossPayments] [decimal](18, 2) NULL,
	[VoidedPayments] [decimal](18, 2) NULL,
	[GrossPmtsafterVoids] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[ToFromUnapplied] [decimal](18, 2) NULL,
	[NetPayments] [decimal](18, 2) NULL,
	[ContractualAdj] [decimal](18, 2) NULL,
	[OtherAdj] [decimal](18, 2) NULL,
	[BadDebt] [decimal](18, 2) NULL,
	[NetAdj] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Monthly_PayorMix]    Script Date: 9/10/2020 2:52:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Monthly_PayorMix](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[ProviderName] [varchar](100) NULL,
	[PayorType] [varchar](250) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Claims] [decimal](18, 2) NULL,
	[Svcs] [decimal](18, 2) NULL,
	[PTDServices] [decimal](18, 2) NULL,
	[PTDPayments] [decimal](18, 2) NULL,
	[PTDAdj] [decimal](18, 2) NULL,
	[YTDServices] [decimal](18, 2) NULL,
	[YTDPayments] [decimal](18, 2) NULL,
	[YTDAdj] [decimal](18, 2) NULL,
	[Facility] [varchar](250) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Monthly_Prov_AgingReport]    Script Date: 9/10/2020 2:52:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Monthly_Prov_AgingReport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[ATBCategory] [varchar](100) NULL,
	[0-30] [decimal](18, 2) NULL,
	[31-60] [decimal](18, 2) NULL,
	[61-90] [decimal](18, 2) NULL,
	[91-120] [decimal](18, 2) NULL,
	[121-150] [decimal](18, 2) NULL,
	[151-180] [decimal](18, 2) NULL,
	[181+] [decimal](18, 2) NULL,
	[ARDays] [int] NULL,
	[CategoryBalance] [decimal](18, 2) NULL,
	[Location] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Monthly_Prov_ChargePaymentAdjvsNet]    Script Date: 9/10/2020 2:52:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Monthly_Prov_ChargePaymentAdjvsNet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[ProviderName] [varchar](100) NULL,
	[GrossCharges] [decimal](18, 2) NULL,
	[VoidedCharges] [decimal](18, 2) NULL,
	[NetCharges] [decimal](18, 2) NULL,
	[GrossPayments] [decimal](18, 2) NULL,
	[VoidedPayments] [decimal](18, 2) NULL,
	[GrossPmtsafterVoids] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[ToFromUnapplied] [decimal](18, 2) NULL,
	[NetPayments] [decimal](18, 2) NULL,
	[ContractualAdj] [decimal](18, 2) NULL,
	[OtherAdj] [decimal](18, 2) NULL,
	[BadDebt] [decimal](18, 2) NULL,
	[NetAdj] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Yearly_ChargePaymentAdjvsNet]    Script Date: 9/10/2020 2:52:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Yearly_ChargePaymentAdjvsNet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[ProviderName] [varchar](100) NULL,
	[NetCharges] [decimal](18, 2) NULL,
	[NetPayments] [decimal](18, 2) NULL,
	[NetAdj] [decimal](18, 2) NULL,
	[AccountsReceivable] [decimal](18, 2) NULL,
	[AR120] [decimal](18, 2) NULL,
	[ARDays] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
	[YrlyComparNC] [decimal](18, 2) NULL,
	[YrlyComparNP] [decimal](18, 2) NULL,
	[YrlyComparNA] [decimal](18, 2) NULL,
	[YrlyComparAR] [decimal](18, 2) NULL,
	[YrlyComparAR120] [decimal](18, 2) NULL,
	[YrlyComparARDay] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPM_Report_Yly_WRVU]    Script Date: 9/10/2020 2:52:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPM_Report_Yly_WRVU](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[CPTCODE] [varchar](15) NULL,
	[Modifier] [varchar](10) NULL,
	[CPTDescription] [varchar](600) NULL,
	[WRVU] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[Client] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_AgingComparison]    Script Date: 9/10/2020 2:52:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_AgingComparison](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ReportName] [varchar](100) NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](100) NULL,
	[ATBCategory] [varchar](100) NULL,
	[0-30] [decimal](18, 2) NULL,
	[31-60] [decimal](18, 2) NULL,
	[61-90] [decimal](18, 2) NULL,
	[91-120] [decimal](18, 2) NULL,
	[121-150] [decimal](18, 2) NULL,
	[151-180] [decimal](18, 2) NULL,
	[181+] [decimal](18, 2) NULL,
	[CategoryBalance] [decimal](18, 2) NULL,
	[TotalPercent] [decimal](10, 2) NULL,
	[Over90Days] [decimal](10, 2) NULL,
	[DTID] [date] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK__PPMRepor__3214EC279FCF54BD] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_AgingReport]    Script Date: 9/10/2020 2:52:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_AgingReport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ATBCategory] [varchar](100) NULL,
	[ARDays] [int] NULL,
	[0-30] [decimal](18, 2) NULL,
	[31-60] [decimal](18, 2) NULL,
	[61-90] [decimal](18, 2) NULL,
	[91-120] [decimal](18, 2) NULL,
	[121-150] [decimal](18, 2) NULL,
	[151-180] [decimal](18, 2) NULL,
	[181+] [decimal](18, 2) NULL,
	[CategoryBalance] [decimal](18, 2) NULL,
	[Location] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[XLName] [varchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_Charge]    Script Date: 9/10/2020 2:52:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_Charge](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [varchar](15) NULL,
	[ProviderName] [varchar](100) NULL,
	[GrossCharges] [decimal](18, 2) NULL,
	[VoidedCharges] [decimal](18, 2) NULL,
	[NetCharges] [decimal](18, 2) NULL,
	[GrossPayments] [decimal](18, 2) NULL,
	[VoidedPayments] [decimal](18, 2) NULL,
	[GrossPmtsafterVoids] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[ToFromUnapplied] [decimal](18, 2) NULL,
	[NetPayments] [decimal](18, 2) NULL,
	[ContractualAdj] [decimal](18, 2) NULL,
	[OtherAdj] [decimal](18, 2) NULL,
	[BadDebt] [decimal](18, 2) NULL,
	[NetAdj] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[XLName] [varchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ClearGage]    Script Date: 9/10/2020 2:52:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ClearGage](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[PPMMerchantAccount] [varchar](200) NULL,
	[Credit] [decimal](18, 2) NULL,
	[Allocation] [decimal](22, 20) NULL,
	[CreditCardFee] [decimal](18, 2) NULL,
	[DuetoClient] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ClearGage_Collection]    Script Date: 9/10/2020 2:52:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ClearGage_Collection](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ClearGage] [decimal](18, 2) NULL,
	[Collections] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ClientList]    Script Date: 9/10/2020 2:52:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ClientList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Client] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[ClientAcronym] [varchar](150) NULL,
	[Project] [int] NULL,
	[ClientFullName] [varchar](250) NULL,
	[CreatedBy] [varchar](250) NULL,
	[IsCGActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Client] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ClientListLogs]    Script Date: 9/10/2020 2:52:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ClientListLogs](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NOT NULL,
	[Project] [int] NULL,
	[Client] [varchar](500) NULL,
	[ClientAcronym] [varchar](150) NULL,
	[ClientFullName] [varchar](500) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](250) NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](150) NULL,
	[IsCGActive] [bit] NULL,
 CONSTRAINT [PK_PPMReport_ClientListLogs_RID] PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ClientName]    Script Date: 9/10/2020 2:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ClientName](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [varchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_ClientName] UNIQUE NONCLUSTERED 
(
	[ClientName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_CodingCurveList]    Script Date: 9/10/2020 2:52:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_CodingCurveList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[ReportYear] [int] NOT NULL,
	[CPTCode] [varchar](9) NULL,
	[Fee] [decimal](18, 2) NULL,
	[NationalDist] [decimal](18, 16) NULL,
	[TableName] [varchar](60) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [varchar](250) NULL,
 CONSTRAINT [PK__PPMRepor__3214EC279AD9995D] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ColumnList]    Script Date: 9/10/2020 2:52:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ColumnList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[XLSheet] [varchar](250) NULL,
	[XLColumn] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_DM7]    Script Date: 9/10/2020 2:52:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_DM7](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](60) NULL,
	[Voucher] [varchar](200) NULL,
	[Issue] [varchar](600) NULL,
	[Balance] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_DM7_Test]    Script Date: 9/10/2020 2:52:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_DM7_Test](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](60) NULL,
	[Voucher] [varchar](200) NULL,
	[Issue] [varchar](600) NULL,
	[Balance] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_DM7Details]    Script Date: 9/10/2020 2:52:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_DM7Details](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ShortName] [varchar](60) NULL,
	[DoctorName] [varchar](200) NULL,
	[PriInsName] [varchar](200) NULL,
	[AccountNumber] [varchar](100) NULL,
	[PatientName] [varchar](200) NULL,
	[ChargeAmount] [decimal](18, 2) NULL,
	[Receipts] [decimal](18, 2) NULL,
	[Adjusts] [decimal](18, 2) NULL,
	[Balance] [decimal](18, 2) NULL,
	[DateOfServ] [date] NULL,
	[DateOfPost] [date] NULL,
	[CPT] [varchar](50) NULL,
	[PrimaryDiag] [varchar](50) NULL,
	[CurrInsBillDt] [date] NULL,
	[LastActivityNoRebill] [date] NULL,
	[Voucher] [varchar](200) NULL,
	[Issue] [varchar](200) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_DOPQuery]    Script Date: 9/10/2020 2:52:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_DOPQuery](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[DOS] [varchar](15) NULL,
	[ChargeDOP] [varchar](15) NULL,
	[CPT] [varchar](25) NULL,
	[CPTDescription] [varchar](200) NULL,
	[CPTGroupDesc] [varchar](100) NULL,
	[Modifier] [varchar](25) NULL,
	[InsuranceType] [varchar](100) NULL,
	[InsPlanID] [bigint] NULL,
	[InsurancePlanName] [varchar](200) NULL,
	[ClaimDetailPOS] [int] NULL,
	[ClaimFacilityName] [varchar](100) NULL,
	[ClaimFacilityPOS] [int] NULL,
	[FacilityOfFirstVisit] [varchar](100) NULL,
	[POSofFacilityOfFirstVisit] [int] NULL,
	[DateOfFirstVisit] [varchar](15) NULL,
	[Location] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Adjustments] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[ProcedureCount] [int] NULL,
	[Units] [int] NULL,
	[ClaimID] [bigint] NULL,
	[FacilityID] [bigint] NULL,
	[PatientID] [bigint] NULL,
	[ClaimDetailID] [bigint] NULL,
	[OriginalPrimaryInsurance] [bigint] NULL,
	[ClaimDetailDiag1] [varchar](50) NULL,
	[ClaimDetailDiag2] [varchar](50) NULL,
	[ClaimDetailDiag3] [varchar](50) NULL,
	[ClaimDetailDiag4] [varchar](50) NULL,
	[ClaimDetailDiag5] [varchar](50) NULL,
	[ClaimDetailDiag6] [varchar](50) NULL,
	[ClaimDetailDiag7] [varchar](50) NULL,
	[ClaimDetailDiag8] [varchar](50) NULL,
	[PatientFullName] [varchar](100) NULL,
	[AccountNumber] [varchar](50) NULL,
	[PatientAddress1] [varchar](250) NULL,
	[PatientAddress2] [varchar](250) NULL,
	[PatientCity] [varchar](50) NULL,
	[PatientState] [varchar](50) NULL,
	[PatientZip] [varchar](50) NULL,
	[PatientHomePhone] [varchar](50) NULL,
	[PatientWorkPhone] [varchar](50) NULL,
	[PatientHomeEmail] [varchar](50) NULL,
	[PatientWorkEmail] [varchar](50) NULL,
	[PatientSex] [varchar](10) NULL,
	[Deceased] [varchar](250) NULL,
	[AgeAtDOS] [bigint] NULL,
	[PatientPCP] [varchar](100) NULL,
	[PatientReferringProvider] [varchar](100) NULL,
	[DOSYYYYMM] [varchar](50) NULL,
	[DOPYYYYMM] [varchar](50) NULL,
	[ClaimProvider] [varchar](100) NULL,
	[ClaimSupervisingProvider] [varchar](100) NULL,
	[ClaimReferringProvider] [varchar](100) NULL,
	[PrimaryInsPmts] [decimal](18, 2) NULL,
	[PatientPmts] [decimal](18, 2) NULL,
	[OtherPmts] [decimal](18, 2) NULL,
	[PatientCash] [decimal](18, 2) NULL,
	[PatientCheck] [decimal](18, 2) NULL,
	[PatientCreditCard] [decimal](18, 2) NULL,
	[PatientOtherPmtType] [decimal](18, 2) NULL,
	[PatientDOB] [varchar](15) NULL,
	[Allowed_amount] [decimal](18, 2) NULL,
	[Schedule_name] [varchar](250) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_DOSQuery]    Script Date: 9/10/2020 2:52:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_DOSQuery](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[DOS] [varchar](15) NULL,
	[ChargeDOP] [varchar](15) NULL,
	[CPT] [varchar](25) NULL,
	[CPTDescription] [varchar](200) NULL,
	[CPTGroupDesc] [varchar](100) NULL,
	[Modifier] [varchar](25) NULL,
	[InsuranceType] [varchar](100) NULL,
	[InsPlanID] [bigint] NULL,
	[InsurancePlanName] [varchar](200) NULL,
	[ClaimDetailPOS] [int] NULL,
	[ClaimFacilityName] [varchar](100) NULL,
	[ClaimFacilityPOS] [int] NULL,
	[FacilityOfFirstVisit] [varchar](100) NULL,
	[POSofFacilityOfFirstVisit] [int] NULL,
	[DateOfFirstVisit] [varchar](15) NULL,
	[Location] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Adjustments] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[ProcedureCount] [int] NULL,
	[Units] [int] NULL,
	[ClaimID] [bigint] NULL,
	[FacilityID] [bigint] NULL,
	[PatientID] [bigint] NULL,
	[ClaimDetailID] [bigint] NULL,
	[OriginalPrimaryInsurance] [bigint] NULL,
	[ClaimDetailDiag1] [varchar](50) NULL,
	[ClaimDetailDiag2] [varchar](50) NULL,
	[ClaimDetailDiag3] [varchar](50) NULL,
	[ClaimDetailDiag4] [varchar](50) NULL,
	[ClaimDetailDiag5] [varchar](50) NULL,
	[ClaimDetailDiag6] [varchar](50) NULL,
	[ClaimDetailDiag7] [varchar](50) NULL,
	[ClaimDetailDiag8] [varchar](50) NULL,
	[PatientFullName] [varchar](100) NULL,
	[AccountNumber] [varchar](50) NULL,
	[PatientAddress1] [varchar](250) NULL,
	[PatientAddress2] [varchar](250) NULL,
	[PatientCity] [varchar](50) NULL,
	[PatientState] [varchar](50) NULL,
	[PatientZip] [varchar](50) NULL,
	[PatientHomePhone] [varchar](50) NULL,
	[PatientWorkPhone] [varchar](50) NULL,
	[PatientHomeEmail] [varchar](50) NULL,
	[PatientWorkEmail] [varchar](50) NULL,
	[PatientSex] [varchar](10) NULL,
	[Deceased] [varchar](250) NULL,
	[AgeAtDOS] [bigint] NULL,
	[PatientPCP] [varchar](100) NULL,
	[PatientReferringProvider] [varchar](100) NULL,
	[DOSYYYYMM] [varchar](50) NULL,
	[DOPYYYYMM] [varchar](50) NULL,
	[ClaimProvider] [varchar](100) NULL,
	[ClaimSupervisingProvider] [varchar](100) NULL,
	[ClaimReferringProvider] [varchar](100) NULL,
	[PrimaryInsPmts] [decimal](18, 2) NULL,
	[PatientPmts] [decimal](18, 2) NULL,
	[OtherPmts] [decimal](18, 2) NULL,
	[PatientCash] [decimal](18, 2) NULL,
	[PatientCheck] [decimal](18, 2) NULL,
	[PatientCreditCard] [decimal](18, 2) NULL,
	[PatientOtherPmtType] [decimal](18, 2) NULL,
	[PatientDOB] [varchar](15) NULL,
	[Allowed_amount] [decimal](18, 2) NULL,
	[Schedule_name] [varchar](250) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_DOSQuery']    Script Date: 9/10/2020 2:52:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_DOSQuery'](
	[ClientID] [float] NULL,
	[ReportYear] [float] NULL,
	[ReportMonth] [float] NULL,
	[DOS] [nvarchar](255) NULL,
	[ChargeDOP] [nvarchar](255) NULL,
	[CPT] [float] NULL,
	[CPTDescription] [nvarchar](255) NULL,
	[CPTGroupDesc] [nvarchar](255) NULL,
	[Modifier] [nvarchar](255) NULL,
	[InsuranceType] [nvarchar](255) NULL,
	[InsPlanID] [float] NULL,
	[InsurancePlanName] [nvarchar](255) NULL,
	[ClaimDetailPOS] [float] NULL,
	[ClaimFacilityName] [nvarchar](255) NULL,
	[ClaimFacilityPOS] [float] NULL,
	[FacilityOfFirstVisit] [nvarchar](255) NULL,
	[POSofFacilityOfFirstVisit] [float] NULL,
	[DateOfFirstVisit] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Charges] [float] NULL,
	[Payments] [float] NULL,
	[Adjustments] [float] NULL,
	[Refunds] [float] NULL,
	[ProcedureCount] [float] NULL,
	[Units] [float] NULL,
	[ClaimID] [float] NULL,
	[FacilityID] [float] NULL,
	[PatientID] [float] NULL,
	[ClaimDetailID] [float] NULL,
	[OriginalPrimaryInsurance] [float] NULL,
	[ClaimDetailDiag1] [nvarchar](255) NULL,
	[ClaimDetailDiag2] [nvarchar](255) NULL,
	[ClaimDetailDiag3] [nvarchar](255) NULL,
	[ClaimDetailDiag4] [nvarchar](255) NULL,
	[ClaimDetailDiag5] [nvarchar](255) NULL,
	[ClaimDetailDiag6] [nvarchar](255) NULL,
	[ClaimDetailDiag7] [nvarchar](255) NULL,
	[ClaimDetailDiag8] [nvarchar](255) NULL,
	[PatientFullName] [nvarchar](255) NULL,
	[AccountNumber] [nvarchar](255) NULL,
	[PatientAddress1] [nvarchar](255) NULL,
	[PatientAddress2] [nvarchar](255) NULL,
	[PatientCity] [nvarchar](255) NULL,
	[PatientState] [nvarchar](255) NULL,
	[PatientZip] [float] NULL,
	[PatientHomePhone] [nvarchar](255) NULL,
	[PatientWorkPhone] [nvarchar](255) NULL,
	[PatientHomeEmail] [nvarchar](255) NULL,
	[PatientWorkEmail] [nvarchar](255) NULL,
	[PatientSex] [nvarchar](255) NULL,
	[Deceased] [nvarchar](255) NULL,
	[AgeAtDOS] [float] NULL,
	[PatientPCP] [nvarchar](255) NULL,
	[PatientReferringProvider] [nvarchar](255) NULL,
	[DOSYYYYMM] [float] NULL,
	[DOPYYYYMM] [float] NULL,
	[ClaimProvider] [nvarchar](255) NULL,
	[ClaimSupervisingProvider] [nvarchar](255) NULL,
	[ClaimReferringProvider] [nvarchar](255) NULL,
	[PrimaryInsPmts] [float] NULL,
	[PatientPmts] [float] NULL,
	[OtherPmts] [float] NULL,
	[PatientCash] [float] NULL,
	[PatientCheck] [float] NULL,
	[PatientCreditCard] [float] NULL,
	[PatientOtherPmtType] [float] NULL,
	[PatientDOB] [nvarchar](255) NULL,
	[allowed_amount] [nvarchar](255) NULL,
	[schedule_name] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECB_HeaderList]    Script Date: 9/10/2020 2:52:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECB_HeaderList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Sheet] [varchar](250) NULL,
	[Available] [varchar](250) NULL,
	[Match] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECB_MandatoryColumn]    Script Date: 9/10/2020 2:52:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECB_MandatoryColumn](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Sheet] [varchar](250) NULL,
	[Mandatory] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_AgingReport]    Script Date: 9/10/2020 2:52:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_AgingReport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ReportName] [varchar](100) NOT NULL,
	[AppointmentProvider] [varchar](200) NULL,
	[RenderingProvider] [varchar](200) NULL,
	[InsuranceGroup] [varchar](150) NULL,
	[ClaimAmount] [decimal](18, 2) NULL,
	[0-30] [decimal](18, 2) NULL,
	[31-60] [decimal](18, 2) NULL,
	[61-90] [decimal](18, 2) NULL,
	[91-120] [decimal](18, 2) NULL,
	[121-150] [decimal](18, 2) NULL,
	[151-180] [decimal](18, 2) NULL,
	[181+] [decimal](18, 2) NULL,
	[TotalBalance] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_ARBeginEnd]    Script Date: 9/10/2020 2:52:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_ARBeginEnd](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[AppointmentProvider] [varchar](200) NULL,
	[RenderingProvider] [varchar](200) NULL,
	[BeginningAR] [decimal](18, 2) NULL,
	[BilledCharge] [decimal](18, 2) NULL,
	[PatientCharge] [decimal](18, 2) NULL,
	[InsuranceCharge] [decimal](18, 2) NULL,
	[Payment] [decimal](18, 2) NULL,
	[PatientPayment] [decimal](18, 2) NULL,
	[InsurancePayment] [decimal](18, 2) NULL,
	[Contractual] [decimal](18, 2) NULL,
	[InsuranceWithheld] [decimal](18, 2) NULL,
	[WriteoffAdjustment] [decimal](18, 2) NULL,
	[Refund] [decimal](18, 2) NULL,
	[EndingAR] [decimal](18, 2) NULL,
	[ChangeinAR] [decimal](18, 2) NULL,
	[ClaimCount] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_Collection]    Script Date: 9/10/2020 2:52:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_Collection](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[AdjustmentCode] [varchar](50) NULL,
	[AdjustmentCodeName] [varchar](200) NULL,
	[AdjustmentAmount] [decimal](18, 2) NULL,
	[AdjustmentCount] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK__PPMRepor__3214EC2783EB1FFC] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_CPT]    Script Date: 9/10/2020 2:52:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_CPT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[AppointmentProvider] [varchar](200) NULL,
	[RenderingProvider] [varchar](200) NULL,
	[CPTGroup] [varchar](300) NULL,
	[ProcedureCode] [varchar](50) NULL,
	[BilledCharge] [decimal](18, 2) NULL,
	[InsuranceCharge] [decimal](18, 2) NULL,
	[SelfCharge] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[PatientPayment] [decimal](18, 2) NULL,
	[InsurancePayments] [decimal](18, 2) NULL,
	[InsuranceWithheld] [decimal](18, 2) NULL,
	[ContractualAdjustments] [decimal](18, 2) NULL,
	[WriteOffAdjustments] [decimal](18, 2) NULL,
	[RefundAmount] [decimal](18, 2) NULL,
	[BilledUnits] [decimal](18, 2) NULL,
	[ChangeinAR] [decimal](18, 2) NULL,
	[VisitCount] [decimal](18, 2) NULL,
	[PatientCount] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_CPTQuery]    Script Date: 9/10/2020 2:52:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_CPTQuery](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[RenderingProvider] [varchar](200) NULL,
	[FacilityName] [varchar](250) NULL,
	[PlaceOfService] [varchar](50) NULL,
	[InsuranceName] [varchar](250) NULL,
	[ClaimNo] [varchar](500) NULL,
	[ClaimPatientName] [varchar](250) NULL,
	[ClaimPatientAccountNo] [varchar](50) NULL,
	[CPTCode] [varchar](50) NULL,
	[CPTDescription] [varchar](350) NULL,
	[Units] [varchar](15) NULL,
	[Modifier1] [varchar](20) NULL,
	[Modifier2] [varchar](20) NULL,
	[Modifier3] [varchar](20) NULL,
	[Modifier4] [varchar](20) NULL,
	[ClaimDate] [varchar](30) NULL,
	[ServiceDate] [varchar](30) NULL,
	[BilledCharge] [decimal](18, 2) NULL,
	[InsurancePayment] [decimal](18, 2) NULL,
	[PatientPayment] [decimal](18, 2) NULL,
	[Payment] [decimal](18, 2) NULL,
	[InsuranceWithheld] [decimal](18, 2) NULL,
	[Contractual] [decimal](18, 2) NULL,
	[RefundAmount] [decimal](18, 2) NULL,
	[WriteOffAmount] [decimal](18, 2) NULL,
	[CPTBalance] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_DaySheet]    Script Date: 9/10/2020 2:52:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_DaySheet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[AppointmentProvider] [varchar](200) NULL,
	[RenderingProvider] [varchar](200) NULL,
	[BilledCharge] [decimal](18, 2) NULL,
	[SelfCharge] [decimal](18, 2) NULL,
	[InsuranceCharge] [decimal](18, 2) NULL,
	[Payment] [decimal](18, 2) NULL,
	[PatientPayment] [decimal](18, 2) NULL,
	[InsurancePayment] [decimal](18, 2) NULL,
	[Contractual] [decimal](18, 2) NULL,
	[InsuranceWithheld] [decimal](18, 2) NULL,
	[WriteOffAdjustment] [decimal](18, 2) NULL,
	[Refund] [decimal](18, 2) NULL,
	[ChangeinAR] [decimal](18, 2) NULL,
	[VisitCount] [decimal](18, 2) NULL,
	[PatientCount] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_FinancialAnalysis]    Script Date: 9/10/2020 2:52:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_FinancialAnalysis](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Adjustments] [decimal](18, 2) NULL,
	[AccountsReceivable] [decimal](18, 2) NULL,
	[AROver120] [decimal](18, 2) NULL,
	[ARDaysOutstanding] [decimal](18, 2) NULL,
	[Unapplied] [decimal](18, 2) NULL,
	[ClearGage] [decimal](18, 2) NULL,
	[Collections] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[DTID] [date] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_FinancialAnalysis_YrlyTrend]    Script Date: 9/10/2020 2:52:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_FinancialAnalysis_YrlyTrend](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Adjustments] [decimal](18, 2) NULL,
	[AccountsReceivable] [decimal](18, 2) NULL,
	[AROver120] [decimal](18, 2) NULL,
	[ARDaysOutstanding] [decimal](18, 2) NULL,
	[Unapplied] [decimal](18, 2) NULL,
	[ClearGage] [decimal](18, 2) NULL,
	[Collections] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[DTID] [date] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_OCR]    Script Date: 9/10/2020 2:52:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_OCR](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[RenderingProvider] [varchar](200) NULL,
	[CurrentDebtorName] [varchar](200) NULL,
	[ClaimID] [varchar](50) NULL,
	[PatientName] [varchar](200) NULL,
	[CPTBalance] [decimal](18, 2) NULL,
	[ServiceDate] [varchar](50) NULL,
	[ClaimDate] [varchar](50) NULL,
	[CPTCode] [varchar](50) NULL,
	[Modifier] [varchar](20) NULL,
	[LastSubmissionDate] [varchar](50) NULL,
	[PatientID] [varchar](50) NULL,
	[Destination] [varchar](200) NULL,
	[DaysOut] [int] NULL,
	[Remark] [varchar](200) NULL,
	[RemarkDesc] [varchar](350) NULL,
	[Practice] [varchar](200) NULL,
	[ClaimFacilityName] [varchar](200) NULL,
	[AppointmentProvider] [varchar](200) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_PayerMix]    Script Date: 9/10/2020 2:52:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_PayerMix](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[AppointmentProvider] [varchar](200) NULL,
	[RenderingProvider] [varchar](200) NULL,
	[InsuranceGroup] [varchar](200) NULL,
	[BilledCharge] [decimal](18, 2) NULL,
	[SelfCharge] [decimal](18, 2) NULL,
	[InsuranceCharge] [decimal](18, 2) NULL,
	[Payment] [decimal](18, 2) NULL,
	[PatientPayment] [decimal](18, 2) NULL,
	[InsurancePayment] [decimal](18, 2) NULL,
	[Contractual] [decimal](18, 2) NULL,
	[InsuranceWithheld] [decimal](18, 2) NULL,
	[WriteOffAdjustment] [decimal](18, 2) NULL,
	[Refund] [decimal](18, 2) NULL,
	[ChangeinAR] [decimal](18, 2) NULL,
	[VisitCount] [decimal](18, 2) NULL,
	[PatientCount] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_ProviderNameList]    Script Date: 9/10/2020 2:52:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_ProviderNameList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ProviderName] [varchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Name] UNIQUE NONCLUSTERED 
(
	[ClientID] ASC,
	[ProviderName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ECW_WithoutClaims]    Script Date: 9/10/2020 2:52:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ECW_WithoutClaims](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[PaymentDate] [varchar](50) NULL,
	[FacilityName] [varchar](250) NULL,
	[AppointmentProvider] [varchar](200) NULL,
	[ResourceProvider] [varchar](200) NULL,
	[PatientName] [varchar](200) NULL,
	[PatientAccountNo] [varchar](50) NULL,
	[PaymentID] [varchar](50) NULL,
	[AppointmentDate] [varchar](50) NULL,
	[VisitType] [varchar](50) NULL,
	[ChartLockStatus] [varchar](50) NULL,
	[PaymentType] [varchar](50) NULL,
	[UnbilledAmount] [decimal](18, 2) NULL,
	[Amount] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[XLName] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_FinancialDashboard]    Script Date: 9/10/2020 2:52:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_FinancialDashboard](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](100) NULL,
	[ReportName] [varchar](100) NULL,
	[CPTGroupDesc] [varchar](300) NULL,
	[TotalCount] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_Location]    Script Date: 9/10/2020 2:52:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_Location](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](100) NULL,
	[ReportName] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Adjustments] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_MatchColumnName]    Script Date: 9/10/2020 2:52:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_MatchColumnName](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[XLSheet] [varchar](250) NULL,
	[XLColumn] [varchar](250) NULL,
	[XLColumnMod] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_MatchProviderName]    Script Date: 9/10/2020 2:52:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_MatchProviderName](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[EOMName] [varchar](150) NULL,
	[DOPName] [varchar](150) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[ProjectID] [int] NOT NULL,
	[CreatedBy] [varchar](250) NULL,
 CONSTRAINT [PK__PPMRepor__3214EC27B9EAEB38] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_PayerMix]    Script Date: 9/10/2020 2:52:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_PayerMix](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](100) NULL,
	[PayorType] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK__PPMRepor__3214EC27E76C21F1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ProcedureCount]    Script Date: 9/10/2020 2:52:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ProcedureCount](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](100) NULL,
	[CPTGroupDesc] [varchar](100) NULL,
	[CPT] [varchar](100) NULL,
	[CPTDescription] [varchar](100) NULL,
	[UNITS] [bigint] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_ReportName]    Script Date: 9/10/2020 2:52:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_ReportName](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectID] [int] NULL,
	[ReportName] [varchar](200) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_ReportName] UNIQUE NONCLUSTERED 
(
	[ProjectID] ASC,
	[ReportName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_Rollforward]    Script Date: 9/10/2020 2:52:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_Rollforward](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[Adjustments] [decimal](18, 2) NULL,
	[UnappliedPayments] [decimal](18, 2) NULL,
	[AccountsReceivable] [decimal](18, 2) NULL,
	[AROver120] [decimal](18, 2) NULL,
	[ARDaysOutstanding] [decimal](18, 2) NULL,
	[UnappliedBalance] [decimal](18, 2) NULL,
	[DTID] [date] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK__PPMRepor__3214EC2764B6718A] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_Rollforward_YrlyCompare]    Script Date: 9/10/2020 2:53:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_Rollforward_YrlyCompare](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](100) NULL,
	[YrlyCharges] [decimal](18, 2) NULL,
	[YrlyPayments] [decimal](18, 2) NULL,
	[YrlyRefunds] [decimal](18, 2) NULL,
	[YrlyAdjustments] [decimal](18, 2) NULL,
	[YrlyUnappliedPayments] [decimal](18, 2) NULL,
	[YrlyAccountsReceivable] [decimal](18, 2) NULL,
	[YrlyAROver120] [decimal](18, 2) NULL,
	[YrlyARDaysOutstanding] [decimal](18, 2) NULL,
	[YrlyUnappliedBalance] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_SkipCPTEncounter]    Script Date: 9/10/2020 2:53:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_SkipCPTEncounter](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CPT] [varchar](15) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CPT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_UploadInfo]    Script Date: 9/10/2020 2:53:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_UploadInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RunAt] [datetime] NULL,
	[Project] [int] NOT NULL,
	[ClientID] [int] NOT NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[AppStatus] [varchar](250) NOT NULL,
	[ReportStatus] [varchar](max) NULL,
	[ErrorLog] [varchar](max) NULL,
	[Remarks] [varchar](250) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](250) NULL,
 CONSTRAINT [PK_PPMReport_UploadInfo_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_wRVUList]    Script Date: 9/10/2020 2:53:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_wRVUList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportYear] [int] NULL,
	[CPTCode] [varchar](15) NULL,
	[Modifier] [varchar](10) NULL,
	[CPTDescription] [varchar](600) NULL,
	[wRVU] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](250) NULL,
	[ClientID] [int] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PPMReport_wRVUReport]    Script Date: 9/10/2020 2:53:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPMReport_wRVUReport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](100) NULL,
	[CPTCode] [varchar](15) NULL,
	[CPTDescription] [varchar](600) NULL,
	[wRVUCount] [decimal](18, 2) NULL,
	[wRVUYearly] [decimal](18, 2) NULL,
	[wRVU] [decimal](18, 2) NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Privia]    Script Date: 9/10/2020 2:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Privia](
	[claim_id] [float] NULL,
	[claim_note_datetime] [datetime] NULL,
	[created_by] [varchar](255) NULL,
	[action] [varchar](255) NULL,
	[transfer_type] [float] NULL,
	[claim_status] [varchar](255) NULL,
	[patient_insurance_id] [float] NULL,
	[insurance_package_name] [varchar](255) NULL,
	[custom_insurance_grouping] [varchar](255) NULL,
	[insurance_reporting_category] [varchar](255) NULL,
	[scrub_type] [datetime] NULL,
	[rule_class] [bit] NULL,
	[claim_rule_id] [varchar](255) NULL,
	[claim_rule_name] [varchar](255) NULL,
	[athena_kick_reason_id] [float] NULL,
	[kick_code] [varchar](255) NULL,
	[kick_reason_desc] [varchar](568) NULL,
	[scrub_action] [float] NULL,
	[front_end_action] [float] NULL,
	[back_end_action] [float] NULL,
	[denial_status_entry] [float] NULL,
	[original_claim_id] [float] NULL,
	[patient_id] [float] NULL,
	[Patient_First_Name] [varchar](255) NULL,
	[Patient_last_name] [varchar](255) NULL,
	[supervising_provider_id] [float] NULL,
	[supervising_provider_name] [varchar](255) NULL,
	[rendering_provider_id] [float] NULL,
	[rendering_provider_name] [varchar](255) NULL,
	[provider_group_name] [varchar](255) NULL,
	[Provider_Group_Specialty] [varchar](255) NULL,
	[claim_service_date] [datetime] NULL,
	[registration_department] [varchar](255) NULL,
	[patient_department] [varchar](255) NULL,
	[service_department] [varchar](255) NULL,
	[claim_note_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Privia_1]    Script Date: 9/10/2020 2:53:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Privia_1](
	[claim_id] [float] NULL,
	[claim_note_datetime] [datetime] NULL,
	[created_by] [varchar](255) NULL,
	[action] [varchar](255) NULL,
	[transfer_type] [float] NULL,
	[claim_status] [varchar](255) NULL,
	[patient_insurance_id] [float] NULL,
	[insurance_package_name] [varchar](255) NULL,
	[custom_insurance_grouping] [varchar](255) NULL,
	[insurance_reporting_category] [varchar](255) NULL,
	[scrub_type] [bit] NULL,
	[rule_class] [bit] NULL,
	[claim_rule_id] [float] NULL,
	[claim_rule_name] [bit] NULL,
	[athena_kick_reason_id] [float] NULL,
	[kick_code] [varchar](255) NULL,
	[kick_reason_desc] [varchar](568) NULL,
	[scrub_action] [float] NULL,
	[front_end_action] [float] NULL,
	[back_end_action] [float] NULL,
	[denial_status_entry] [float] NULL,
	[original_claim_id] [float] NULL,
	[patient_id] [float] NULL,
	[Patient_First_Name] [varchar](255) NULL,
	[Patient_last_name] [varchar](255) NULL,
	[supervising_provider_id] [float] NULL,
	[supervising_provider_name] [varchar](255) NULL,
	[rendering_provider_id] [float] NULL,
	[rendering_provider_name] [varchar](255) NULL,
	[provider_group_name] [varchar](255) NULL,
	[Provider_Group_Specialty] [varchar](255) NULL,
	[claim_service_date] [datetime] NULL,
	[registration_department] [varchar](255) NULL,
	[patient_department] [varchar](255) NULL,
	[service_department] [varchar](255) NULL,
	[claim_note_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Privia_2]    Script Date: 9/10/2020 2:53:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Privia_2](
	[claim_note_id] [float] NULL,
	[claim_id] [float] NULL,
	[claim_note_datetime] [datetime] NULL,
	[created_by] [varchar](255) NULL,
	[action] [varchar](255) NULL,
	[transfer_type] [float] NULL,
	[claim_status] [varchar](255) NULL,
	[patient_insurance_id] [float] NULL,
	[insurance_package_name] [varchar](255) NULL,
	[custom_insurance_grouping] [varchar](255) NULL,
	[insurance_reporting_category] [varchar](255) NULL,
	[scrub_type] [bit] NULL,
	[rule_class] [bit] NULL,
	[claim_rule_id] [float] NULL,
	[claim_rule_name] [bit] NULL,
	[athena_kick_reason_id] [float] NULL,
	[kick_code] [varchar](255) NULL,
	[kick_reason_desc] [varchar](568) NULL,
	[scrub_action] [float] NULL,
	[front_end_action] [float] NULL,
	[back_end_action] [float] NULL,
	[denial_status_entry] [float] NULL,
	[original_claim_id] [float] NULL,
	[patient_id] [float] NULL,
	[Patient_First_Name] [varchar](255) NULL,
	[Patient_last_name] [varchar](255) NULL,
	[supervising_provider_id] [float] NULL,
	[supervising_provider_name] [varchar](255) NULL,
	[rendering_provider_id] [float] NULL,
	[rendering_provider_name] [varchar](255) NULL,
	[provider_group_name] [varchar](255) NULL,
	[Provider_Group_Specialty] [varchar](255) NULL,
	[claim_service_date] [datetime] NULL,
	[registration_department] [varchar](255) NULL,
	[patient_department] [varchar](255) NULL,
	[service_department] [varchar](255) NULL,
	[claim_note_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Privia_3]    Script Date: 9/10/2020 2:53:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Privia_3](
	[claim_note_id] [float] NULL,
	[claim_id] [float] NULL,
	[claim_note_date] [date] NULL,
	[created_by] [varchar](255) NULL,
	[action] [varchar](255) NULL,
	[transfer_type] [float] NULL,
	[claim_status] [varchar](255) NULL,
	[insurance_package_name] [varchar](255) NULL,
	[custom_insurance_grouping] [varchar](255) NULL,
	[kick_code] [varchar](255) NULL,
	[original_claim_id] [float] NULL,
	[Provider_Group_Specialty] [varchar](255) NULL,
	[claim_service_date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Privia_Aug]    Script Date: 9/10/2020 2:53:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Privia_Aug](
	[claim_id] [float] NULL,
	[claim_note_datetime] [datetime] NULL,
	[created_by] [varchar](255) NULL,
	[action] [varchar](255) NULL,
	[transfer_type] [float] NULL,
	[claim_status] [varchar](255) NULL,
	[patient_insurance_id] [float] NULL,
	[insurance_package_name] [varchar](255) NULL,
	[custom_insurance_grouping] [varchar](255) NULL,
	[insurance_reporting_category] [varchar](255) NULL,
	[scrub_type] [datetime] NULL,
	[rule_class] [varchar](255) NULL,
	[claim_rule_id] [varchar](255) NULL,
	[claim_rule_name] [varchar](255) NULL,
	[athena_kick_reason_id] [float] NULL,
	[kick_code] [varchar](255) NULL,
	[kick_reason_desc] [varchar](568) NULL,
	[scrub_action] [float] NULL,
	[front_end_action] [float] NULL,
	[back_end_action] [float] NULL,
	[denial_status_entry] [float] NULL,
	[original_claim_id] [float] NULL,
	[patient_id] [float] NULL,
	[Patient_First_Name] [varchar](255) NULL,
	[Patient_last_name] [varchar](255) NULL,
	[supervising_provider_id] [float] NULL,
	[supervising_provider_name] [varchar](255) NULL,
	[rendering_provider_id] [float] NULL,
	[rendering_provider_name] [varchar](255) NULL,
	[provider_group_name] [varchar](255) NULL,
	[Provider_Group_Specialty] [varchar](255) NULL,
	[claim_service_date] [datetime] NULL,
	[registration_department] [varchar](255) NULL,
	[patient_department] [varchar](255) NULL,
	[service_department] [varchar](255) NULL,
	[claim_note_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RCMExtract_AccessHealth_01012019_01312019]    Script Date: 9/10/2020 2:53:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RCMExtract_AccessHealth_01012019_01312019](
	[claim_note_id] [varchar](50) NULL,
	[claim_id] [varchar](50) NULL,
	[claim_note_datetime] [varchar](50) NULL,
	[created_by] [varchar](50) NULL,
	[action] [varchar](50) NULL,
	[transfer_type] [varchar](50) NULL,
	[claim_status] [varchar](50) NULL,
	[patient_insurance_id] [varchar](50) NULL,
	[insurance_package_name] [varchar](500) NULL,
	[custom_insurance_grouping] [varchar](50) NULL,
	[insurance_reporting_category] [varchar](50) NULL,
	[scrub_type] [varchar](50) NULL,
	[rule_class] [varchar](50) NULL,
	[claim_rule_id] [varchar](50) NULL,
	[claim_rule_name] [varchar](50) NULL,
	[athena_kick_reason_id] [varchar](50) NULL,
	[kick_code] [varchar](50) NULL,
	[kick_reason_desc] [varchar](50) NULL,
	[scrub_action] [varchar](50) NULL,
	[front_end_action] [varchar](50) NULL,
	[back_end_action] [varchar](50) NULL,
	[denial_status_entry] [varchar](50) NULL,
	[original_claim_id] [varchar](50) NULL,
	[patient_id] [varchar](50) NULL,
	[Patient_First_Name] [varchar](50) NULL,
	[Patient_last_name] [varchar](50) NULL,
	[supervising_provider_id] [varchar](50) NULL,
	[supervising_provider_name] [varchar](50) NULL,
	[rendering_provider_id] [varchar](50) NULL,
	[rendering_provider_name] [varchar](50) NULL,
	[provider_group_name] [varchar](50) NULL,
	[Provider_Group_Specialty] [varchar](50) NULL,
	[claim_service_date] [varchar](50) NULL,
	[registration_department] [varchar](50) NULL,
	[patient_department] [varchar](50) NULL,
	[service_department] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rollforward_sampledashboard]    Script Date: 9/10/2020 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rollforward_sampledashboard](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [varchar](100) NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ShortName] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[Adjustments] [decimal](18, 2) NULL,
	[UnappliedPayments] [decimal](18, 2) NULL,
	[AccountsReceivable] [decimal](18, 2) NULL,
	[AROver120] [decimal](18, 2) NULL,
	[ARDaysOutstanding] [decimal](18, 2) NULL,
	[UnappliedBalance] [decimal](18, 2) NULL,
	[DTID] [date] NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sept_build_report]    Script Date: 9/10/2020 2:53:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sept_build_report](
	[index] [bigint] NULL,
	[PRACTICE ID] [bigint] NULL,
	[PRACTICE NAME] [varchar](max) NULL,
	[OUTCREATED_DATE] [datetime] NULL,
	[OUTCREATED_TIME] [time](7) NULL,
	[OUTCREATED_HOUR] [bigint] NULL,
	[INCREATED] [varchar](max) NULL,
	[INCLAIMSTATUS] [varchar](max) NULL,
	[CLAIMID] [varchar](max) NULL,
	[SERVICEDATE] [varchar](max) NULL,
	[TRANSFERTYPE] [varchar](max) NULL,
	[PROVIDERNAME] [varchar](max) NULL,
	[IPNAME] [varchar](max) NULL,
	[IPID] [bigint] NULL,
	[IRCNAME] [varchar](max) NULL,
	[IRCID] [bigint] NULL,
	[IRCGROUP] [varchar](max) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](max) NULL,
	[SUB_WORKLISTNAME] [varchar](max) NULL,
	[WORKFLOWTYPE] [varchar](max) NULL,
	[WORKLIST_LOCATION] [varchar](max) NULL,
	[WORKLIST_ORGANIZATION] [varchar](max) NULL,
	[INKICKCODE] [varchar](max) NULL,
	[OUTCREATEDBY] [varchar](max) NULL,
	[OUTFLOWUSERLOCATION] [varchar](max) NULL,
	[DAYSINSTATUS] [bigint] NULL,
	[ACTION] [varchar](max) NULL,
	[OUTKICKCODE] [varchar](max) NULL,
	[OUTCLAIMSTATUS] [varchar](max) NULL,
	[NOTE] [varchar](max) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](max) NULL,
	[WORKCLASS] [varchar](max) NULL,
	[VOICETYPE] [varchar](max) NULL,
	[BILLTYPE] [varchar](max) NULL,
	[OUTPAYERKICK] [varchar](max) NULL,
	[DEPARTMENT] [varchar](max) NULL,
	[PAYER_CATEGORY] [varchar](max) NULL,
	[KICKS_CATEGORY] [varchar](max) NULL,
	[Billing] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sept-Build]    Script Date: 9/10/2020 2:53:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sept-Build](
	[PRACTICE ID] [int] NULL,
	[PRACTICE NAME] [varchar](255) NULL,
	[OUTCREATED_DATE] [date] NULL,
	[OUTCREATED_TIME] [varchar](255) NULL,
	[OUTCREATED_HOUR] [int] NULL,
	[INCREATED] [varchar](255) NULL,
	[INCLAIMSTATUS] [varchar](255) NULL,
	[CLAIMID] [varchar](255) NULL,
	[SERVICEDATE] [date] NULL,
	[TRANSFERTYPE] [varchar](255) NULL,
	[PROVIDERNAME] [varchar](255) NULL,
	[IPNAME] [varchar](255) NULL,
	[IPID] [int] NULL,
	[IRCNAME] [varchar](255) NULL,
	[IRCID] [int] NULL,
	[IRCGROUP] [varchar](255) NULL,
	[OUTSTANDINGBALANCE] [float] NULL,
	[PARENT_WORKLISTNAME] [varchar](255) NULL,
	[SUB_WORKLISTNAME] [varchar](255) NULL,
	[WORKFLOWTYPE] [varchar](255) NULL,
	[WORKLIST_LOCATION] [varchar](255) NULL,
	[WORKLIST_ORGANIZATION] [varchar](255) NULL,
	[INKICKCODE] [varchar](255) NULL,
	[OUTCREATEDBY] [varchar](255) NULL,
	[OUTFLOWUSERLOCATION] [varchar](255) NULL,
	[DAYSINSTATUS] [int] NULL,
	[ACTION] [varchar](255) NULL,
	[OUTKICKCODE] [varchar](255) NULL,
	[OUTCLAIMSTATUS] [varchar](255) NULL,
	[NOTE] [varchar](3998) NULL,
	[MONTHSUSERLIVE] [float] NULL,
	[LINEOFBUSINESS] [varchar](255) NULL,
	[WORKCLASS] [varchar](255) NULL,
	[VOICETYPE] [varchar](255) NULL,
	[BILLTYPE] [varchar](255) NULL,
	[OUTPAYERKICK] [varchar](255) NULL,
	[DEPARTMENT] [varchar](255) NULL,
	[PAYER_CATEGORY] [varchar](255) NULL,
	[KICKS_CATEGORY] [varchar](255) NULL,
	[Billing] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sheet1$]    Script Date: 9/10/2020 2:53:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sheet1$](
	[Ticket] [float] NULL,
	[Batch Date:] [datetime] NULL,
	[Procedure Code] [nvarchar](255) NULL,
	[Primary Payer] [nvarchar](255) NULL,
	[Secondary Payer] [nvarchar](255) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[balance] [float] NULL,
	[SubClient] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status_Athena_Kickcode]    Script Date: 9/10/2020 2:53:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status_Athena_Kickcode](
	[Status Athena Kickcode] [varchar](255) NULL,
	[Maskked] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STLOUIS_AR_TicketMaster]    Script Date: 9/10/2020 2:53:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STLOUIS_AR_TicketMaster](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[QCAllocated] [int] NULL,
	[Status] [int] NULL,
	[TicketStatus] [int] NULL,
	[LocationId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[ClientId] [int] NULL,
	[TicketNumber] [varchar](100) NULL,
	[ClientName] [varchar](255) NULL,
	[Payer] [varchar](255) NULL,
	[DOS] [datetime] NULL,
	[Description] [varchar](255) NULL,
	[ClaimID] [varchar](255) NULL,
	[Balance] [float] NULL,
	[DOP] [date] NULL,
	[CPT] [varchar](255) NULL,
	[Remark] [varchar](255) NULL,
	[LASTSUBDATE] [datetime] NULL,
	[DaysOut] [varchar](255) NULL,
	[Ins1] [varchar](255) NULL,
	[ImportType] [int] NULL,
	[PracticeAcronym] [varchar](255) NULL,
	[DoctorNumber] [varchar](255) NULL,
	[DoctorName] [varchar](255) NULL,
	[PriInsName] [varchar](255) NULL,
	[PriInsID] [varchar](255) NULL,
	[SecInsName] [varchar](255) NULL,
	[SecInsID] [varchar](255) NULL,
	[Charge] [varchar](255) NULL,
	[Receipts] [varchar](255) NULL,
	[Adjusts] [varchar](255) NULL,
	[PrimaryDiag] [varchar](255) NULL,
	[ItemUnique] [varchar](255) NULL,
	[DateAddedtoList] [varchar](255) NULL,
	[CurrentInsuranceBilledDate] [varchar](255) NULL,
	[Voucher] [varchar](255) NULL,
	[PID] [int] NULL,
	[Facility] [varchar](200) NULL,
	[PracticeID] [varchar](200) NULL,
	[REMARK2] [varchar](250) NULL,
	[MOD1] [varchar](250) NULL,
	[MOD2] [varchar](250) NULL,
	[Swtype] [varchar](250) NULL,
	[Provider] [varchar](250) NULL,
	[Shift] [varchar](25) NULL,
	[MultiTouchRowId] [int] NULL,
	[IsMultiTouch] [int] NULL,
	[PatientName] [varbinary](max) NULL,
	[PrimaryIns] [varbinary](max) NULL,
	[DOB] [varbinary](max) NULL,
	[SecondaryIns] [varbinary](max) NULL,
	[TatStartDate] [datetime] NULL,
	[ExpectedTatEndDate] [datetime] NULL,
	[TatDurationMins] [int] NULL,
	[TatEndDate] [datetime] NULL,
	[MultiTouchFeedbackComment] [varchar](max) NULL,
	[MultiTouchCount] [int] NULL,
	[ImportRowId] [int] NULL,
	[PendingTATDuration] [int] NULL,
	[CompletedMode] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock_inflow]    Script Date: 9/10/2020 2:53:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock_inflow](
	[Claim ID] [nvarchar](255) NULL,
	[Transfer Type] [float] NULL,
	[A] [nvarchar](255) NULL,
	[Claim Status] [nvarchar](255) NULL,
	[B] [nvarchar](255) NULL,
	[Days in Status] [nvarchar](255) NULL,
	[Outstanding Amount] [float] NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Status Athena Kickcode] [nvarchar](255) NULL,
	[Current Error Text] [nvarchar](255) NULL,
	[C] [nvarchar](255) NULL,
	[Parent Worklist Name] [nvarchar](255) NULL,
	[Sub Worklist Name] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Worklist Team Organization] [nvarchar](255) NULL,
	[Workflow Type] [nvarchar](255) NULL,
	[Worklist Location] [nvarchar](255) NULL,
	[Priority] [nvarchar](255) NULL,
	[Worked] [nvarchar](255) NULL,
	[Total Athena Days] [nvarchar](255) NULL,
	[Prescribed YN] [nvarchar](255) NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stock_report]    Script Date: 9/10/2020 2:53:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stock_report](
	[Claim ID] [nvarchar](255) NULL,
	[Transfer Type] [nvarchar](255) NULL,
	[A] [nvarchar](255) NULL,
	[Claim Status] [nvarchar](255) NULL,
	[B] [nvarchar](255) NULL,
	[Days in Status] [nvarchar](255) NULL,
	[Outstanding Amount] [float] NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Status Athena Kickcode] [nvarchar](255) NULL,
	[Current Error Text] [nvarchar](255) NULL,
	[C] [nvarchar](255) NULL,
	[Parent Worklist Name] [nvarchar](255) NULL,
	[Sub Worklist Name] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Worklist Team Organization] [nvarchar](255) NULL,
	[Workflow Type] [nvarchar](255) NULL,
	[Worklist Location] [nvarchar](255) NULL,
	[Priority] [nvarchar](255) NULL,
	[Worked] [nvarchar](255) NULL,
	[Total Athena Days] [nvarchar](255) NULL,
	[Prescribed YN] [nvarchar](255) NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock_report1$]    Script Date: 9/10/2020 2:53:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock_report1$](
	[Claim ID] [nvarchar](255) NULL,
	[Transfer Type] [nvarchar](255) NULL,
	[A] [nvarchar](255) NULL,
	[Claim Status] [nvarchar](255) NULL,
	[B] [nvarchar](255) NULL,
	[Days in Status] [nvarchar](255) NULL,
	[Outstanding Amount] [float] NULL,
	[Insurance Reporting Category] [nvarchar](255) NULL,
	[IRC Group] [nvarchar](255) NULL,
	[Insurance Package] [nvarchar](255) NULL,
	[Status Athena Kickcode] [nvarchar](255) NULL,
	[Current Error Text] [nvarchar](255) NULL,
	[C] [nvarchar](255) NULL,
	[Parent Worklist Name] [nvarchar](255) NULL,
	[Sub Worklist Name] [nvarchar](255) NULL,
	[Worklist Team] [nvarchar](255) NULL,
	[Worklist Team Organization] [nvarchar](255) NULL,
	[Workflow Type] [nvarchar](255) NULL,
	[Worklist Location] [nvarchar](255) NULL,
	[Priority] [nvarchar](255) NULL,
	[Worked] [nvarchar](255) NULL,
	[Total Athena Days] [nvarchar](255) NULL,
	[Prescribed YN] [nvarchar](255) NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sub_Worklist_Name_Mask]    Script Date: 9/10/2020 2:53:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sub_Worklist_Name_Mask](
	[Sub_Worklist_Name] [varchar](255) NULL,
	[Maskked_Sub_Worklist_Name_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[table_dummy]    Script Date: 9/10/2020 2:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[table_dummy](
	[name] [char](25) NULL,
	[gender] [char](25) NULL,
	[marks] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[table_dummy1]    Script Date: 9/10/2020 2:53:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[table_dummy1](
	[name] [char](25) NULL,
	[gender] [char](25) NULL,
	[marks] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table1]    Script Date: 9/10/2020 2:53:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table1](
	[TicketId_TM] [int] NOT NULL,
	[Status_TM] [int] NULL,
	[TicketStatus] [int] NULL,
	[LocationId] [int] NULL,
	[CreatedBy_TM] [int] NULL,
	[CreatedDate_TM] [datetime] NULL,
	[UpdatedBy_TM] [int] NULL,
	[UpdatedDate_TM] [datetime] NULL,
	[ClientId] [int] NULL,
	[BillingNotes] [varchar](max) NULL,
	[ClientName] [varchar](200) NULL,
	[InvoiceStatus] [varchar](200) NULL,
	[visitOwner] [varchar](100) NULL,
	[TicketNumber] [varchar](100) NULL,
	[FinancialClass] [varchar](100) NULL,
	[DoctorsNPI] [varchar](200) NULL,
	[DoctorListName] [varchar](100) NULL,
	[CurrentInsurancePhone] [varchar](100) NULL,
	[Payer] [varchar](100) NULL,
	[CompanyListName] [varchar](100) NULL,
	[CaseInsuranceCarrier] [varchar](100) NULL,
	[LastFiledAge] [int] NULL,
	[CurrentInsuredId] [varchar](200) NULL,
	[AgeDOS] [int] NULL,
	[InsBalance] [decimal](18, 2) NULL,
	[TotalAmtBilled] [decimal](18, 2) NULL,
	[PatBalance] [decimal](18, 0) NULL,
	[ServiceDate] [datetime] NULL,
	[LastVOUpdateDate] [date] NULL,
	[LastFiledDate] [date] NULL,
	[FirstFiledDate] [date] NULL,
	[FirstDenialDate] [date] NULL,
	[LastDenialDate] [date] NULL,
	[PaidToAddress] [varchar](max) NULL,
	[FirstFiledAge] [int] NULL,
	[ImportType] [int] NOT NULL,
	[VisitDescription] [varchar](max) NULL,
	[QCAllocated] [int] NULL,
	[IsMultiTouch] [int] NOT NULL,
	[MultiTouchRowId] [int] NULL,
	[Shift] [varchar](25) NULL,
	[PatientName] [varbinary](max) NULL,
	[PatientBirthdate] [varbinary](max) NULL,
	[FederalTaxID] [varbinary](max) NULL,
	[FileType] [int] NULL,
	[TatStartDate] [datetime] NULL,
	[ExpectedTatEndDate] [datetime] NULL,
	[TatDurationMins] [int] NULL,
	[TatEndDate] [datetime] NULL,
	[MultiTouchFeedbackComment] [varchar](max) NULL,
	[MultiTouchCount] [int] NULL,
	[ImportRowId] [int] NULL,
	[PendingTATDuration] [int] NULL,
	[CompletedMode] [int] NULL,
	[ProcessId] [int] NOT NULL,
	[TicketId_PM] [int] NOT NULL,
	[CallType] [varchar](50) NULL,
	[Appeal] [int] NULL,
	[IssueLog] [int] NULL,
	[IssuelogStatus] [int] NULL,
	[FeatureFollowup] [int] NULL,
	[FeatureFollowupDate] [datetime] NULL,
	[Coding] [int] NULL,
	[CallNotes] [varchar](max) NULL,
	[ProcessStatus] [int] NULL,
	[Status_PM] [int] NULL,
	[CreatedBy_PM] [int] NULL,
	[CreatedDate_PM] [datetime] NULL,
	[UpdatedBy_PM] [int] NULL,
	[UpdatedDate_PM] [datetime] NULL,
	[PaymentAmount] [varchar](20) NULL,
	[PatientResponce] [varchar](50) NULL,
	[InsuranceResponce] [varchar](50) NULL,
	[IsPaymentPosting] [int] NOT NULL,
	[IsOss] [int] NOT NULL,
	[IlogSubCodeId] [int] NOT NULL,
	[ProcessDate] [date] NULL,
	[IsValidCallable] [int] NULL,
	[ProcessStartTime] [datetime] NULL,
	[BulkSubmitID] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table2]    Script Date: 9/10/2020 2:53:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table2](
	[File Name] [nvarchar](255) NULL,
	[Date of Service] [datetime] NULL,
	[Filing Method] [nvarchar](255) NULL,
	[Filing Type] [nvarchar](255) NULL,
	[Clearinghouse] [nvarchar](255) NULL,
	[Filed By] [nvarchar](255) NULL,
	[Filed To] [nvarchar](255) NULL,
	[Created By] [nvarchar](255) NULL,
	[Date Created] [datetime] NULL,
	[Date Transmitted] [datetime] NULL,
	[Procedure Filed] [nvarchar](255) NULL,
	[Amount Filed] [float] NULL,
	[Month] [nvarchar](255) NULL,
	[Year] [int] NULL,
	[Sub-client] [nvarchar](255) NULL,
	[TicketId_TM] [int] NULL,
	[Status_TM] [int] NULL,
	[TicketStatus] [int] NULL,
	[LocationId] [int] NULL,
	[CreatedBy_TM] [int] NULL,
	[CreatedDate_TM] [datetime] NULL,
	[UpdatedBy_TM] [int] NULL,
	[UpdatedDate_TM] [datetime] NULL,
	[ClientId] [int] NULL,
	[BillingNotes] [varchar](max) NULL,
	[ClientName] [varchar](200) NULL,
	[InvoiceStatus] [varchar](200) NULL,
	[visitOwner] [varchar](100) NULL,
	[TicketNumber] [varchar](100) NULL,
	[FinancialClass] [varchar](100) NULL,
	[DoctorsNPI] [varchar](200) NULL,
	[DoctorListName] [varchar](100) NULL,
	[CurrentInsurancePhone] [varchar](100) NULL,
	[Payer] [varchar](100) NULL,
	[CompanyListName] [varchar](100) NULL,
	[CaseInsuranceCarrier] [varchar](100) NULL,
	[LastFiledAge] [int] NULL,
	[CurrentInsuredId] [varchar](200) NULL,
	[AgeDOS] [int] NULL,
	[InsBalance] [decimal](18, 2) NULL,
	[TotalAmtBilled] [decimal](18, 2) NULL,
	[PatBalance] [decimal](18, 0) NULL,
	[ServiceDate] [datetime] NULL,
	[LastVOUpdateDate] [date] NULL,
	[LastFiledDate] [date] NULL,
	[FirstFiledDate] [date] NULL,
	[FirstDenialDate] [date] NULL,
	[LastDenialDate] [date] NULL,
	[PaidToAddress] [varchar](max) NULL,
	[FirstFiledAge] [int] NULL,
	[ImportType] [int] NULL,
	[VisitDescription] [varchar](max) NULL,
	[QCAllocated] [int] NULL,
	[IsMultiTouch] [int] NULL,
	[MultiTouchRowId] [int] NULL,
	[Shift] [varchar](25) NULL,
	[PatientName] [varbinary](max) NULL,
	[PatientBirthdate] [varbinary](max) NULL,
	[FederalTaxID] [varbinary](max) NULL,
	[FileType] [int] NULL,
	[TatStartDate] [datetime] NULL,
	[ExpectedTatEndDate] [datetime] NULL,
	[TatDurationMins] [int] NULL,
	[TatEndDate] [datetime] NULL,
	[MultiTouchFeedbackComment] [varchar](max) NULL,
	[MultiTouchCount] [int] NULL,
	[ImportRowId] [int] NULL,
	[PendingTATDuration] [int] NULL,
	[CompletedMode] [int] NULL,
	[ProcessId] [int] NULL,
	[TicketId_PM] [int] NULL,
	[CallType] [varchar](50) NULL,
	[Appeal] [int] NULL,
	[IssueLog] [int] NULL,
	[IssuelogStatus] [int] NULL,
	[FeatureFollowup] [int] NULL,
	[FeatureFollowupDate] [datetime] NULL,
	[Coding] [int] NULL,
	[CallNotes] [varchar](max) NULL,
	[ProcessStatus] [int] NULL,
	[Status_PM] [int] NULL,
	[CreatedBy_PM] [int] NULL,
	[CreatedDate_PM] [datetime] NULL,
	[UpdatedBy_PM] [int] NULL,
	[UpdatedDate_PM] [datetime] NULL,
	[PaymentAmount] [varchar](20) NULL,
	[PatientResponce] [varchar](50) NULL,
	[InsuranceResponce] [varchar](50) NULL,
	[IsPaymentPosting] [int] NULL,
	[IsOss] [int] NULL,
	[IlogSubCodeId] [int] NULL,
	[ProcessDate] [date] NULL,
	[IsValidCallable] [int] NULL,
	[ProcessStartTime] [datetime] NULL,
	[BulkSubmitID] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table3]    Script Date: 9/10/2020 2:53:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table3](
	[FileName] [varchar](9) NULL,
	[SumpymtAmt] [float] NULL,
	[SumcontrAdjAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp_agingreprt_10Mdata]    Script Date: 9/10/2020 2:53:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_agingreprt_10Mdata](
	[ID] [int] NOT NULL,
	[ClientID] [int] NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[ProviderName] [varchar](100) NULL,
	[ATBCategory] [varchar](100) NULL,
	[ARDays] [int] NULL,
	[0-30] [decimal](18, 2) NULL,
	[31-60] [decimal](18, 2) NULL,
	[61-90] [decimal](18, 2) NULL,
	[91-120] [decimal](18, 2) NULL,
	[121-150] [decimal](18, 2) NULL,
	[151-180] [decimal](18, 2) NULL,
	[181+] [decimal](18, 2) NULL,
	[CategoryBalance] [decimal](18, 2) NULL,
	[Location] [varchar](150) NULL,
	[CreatedOn] [datetime] NULL,
	[XLName] [varchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp_ten_million]    Script Date: 9/10/2020 2:53:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_ten_million](
	[ID] [int] NOT NULL,
	[ClientID] [varchar](100) NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[DOS] [varchar](15) NULL,
	[ChargeDOP] [varchar](15) NULL,
	[CPT] [varchar](25) NULL,
	[CPTDescription] [varchar](200) NULL,
	[CPTGroupDesc] [varchar](100) NULL,
	[Modifier] [varchar](25) NULL,
	[InsuranceType] [varchar](100) NULL,
	[InsPlanID] [bigint] NULL,
	[InsurancePlanName] [varchar](200) NULL,
	[ClaimDetailPOS] [int] NULL,
	[ClaimFacilityName] [varchar](100) NULL,
	[ClaimFacilityPOS] [int] NULL,
	[FacilityOfFirstVisit] [varchar](100) NULL,
	[POSofFacilityOfFirstVisit] [int] NULL,
	[DateOfFirstVisit] [varchar](15) NULL,
	[Location] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Adjustments] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[ProcedureCount] [int] NULL,
	[Units] [int] NULL,
	[ClaimID] [bigint] NULL,
	[FacilityID] [bigint] NULL,
	[PatientID] [bigint] NULL,
	[ClaimDetailID] [bigint] NULL,
	[OriginalPrimaryInsurance] [bigint] NULL,
	[ClaimDetailDiag1] [varchar](50) NULL,
	[ClaimDetailDiag2] [varchar](50) NULL,
	[ClaimDetailDiag3] [varchar](50) NULL,
	[ClaimDetailDiag4] [varchar](50) NULL,
	[ClaimDetailDiag5] [varchar](50) NULL,
	[ClaimDetailDiag6] [varchar](50) NULL,
	[ClaimDetailDiag7] [varchar](50) NULL,
	[ClaimDetailDiag8] [varchar](50) NULL,
	[PatientFullName] [varchar](100) NULL,
	[AccountNumber] [varchar](50) NULL,
	[PatientAddress1] [varchar](250) NULL,
	[PatientAddress2] [varchar](250) NULL,
	[PatientCity] [varchar](50) NULL,
	[PatientState] [varchar](50) NULL,
	[PatientZip] [varchar](50) NULL,
	[PatientHomePhone] [varchar](50) NULL,
	[PatientWorkPhone] [varchar](50) NULL,
	[PatientHomeEmail] [varchar](50) NULL,
	[PatientWorkEmail] [varchar](50) NULL,
	[PatientSex] [varchar](10) NULL,
	[Deceased] [varchar](250) NULL,
	[AgeAtDOS] [bigint] NULL,
	[PatientPCP] [varchar](100) NULL,
	[PatientReferringProvider] [varchar](100) NULL,
	[DOSYYYYMM] [varchar](50) NULL,
	[DOPYYYYMM] [varchar](50) NULL,
	[ClaimProvider] [varchar](100) NULL,
	[ClaimSupervisingProvider] [varchar](100) NULL,
	[ClaimReferringProvider] [varchar](100) NULL,
	[PrimaryInsPmts] [decimal](18, 2) NULL,
	[PatientPmts] [decimal](18, 2) NULL,
	[OtherPmts] [decimal](18, 2) NULL,
	[PatientCash] [decimal](18, 2) NULL,
	[PatientCheck] [decimal](18, 2) NULL,
	[PatientCreditCard] [decimal](18, 2) NULL,
	[PatientOtherPmtType] [decimal](18, 2) NULL,
	[PatientDOB] [varchar](15) NULL,
	[Allowed_amount] [decimal](18, 2) NULL,
	[Schedule_name] [varchar](250) NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Temp1]    Script Date: 9/10/2020 2:53:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp1](
	[File Name] [nvarchar](255) NULL,
	[Date of Service] [datetime] NULL,
	[Filing Method] [nvarchar](255) NULL,
	[Filing Type] [nvarchar](255) NULL,
	[Clearinghouse] [nvarchar](255) NULL,
	[Filed By] [nvarchar](255) NULL,
	[Filed To] [nvarchar](255) NULL,
	[Created By] [nvarchar](255) NULL,
	[Date Created] [datetime] NULL,
	[Date Transmitted] [datetime] NULL,
	[Procedure Filed] [nvarchar](255) NULL,
	[Amount Filed] [float] NULL,
	[Month] [nvarchar](255) NULL,
	[Year] [int] NULL,
	[Sub-client] [nvarchar](255) NULL,
	[MidWest_Ar_ProcessMaster.CreatedBy] [int] NULL,
	[MidWest_Ar_ProcessMaster.CreatedDate] [datetime] NULL,
	[MidWest_Ar_ProcessMaster.UpdatedBy] [int] NULL,
	[MidWest_Ar_ProcessMaster.PaymentAmount] [varchar](20) NULL,
	[MidWest_Ar_ProcessMaster.Midwest_AR_TicketMaster.TicketNumber] [varchar](100) NULL,
	[MidWest_Ar_ProcessMaster.Midwest_AR_TicketMaster.FinancialClass] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempTicketNumber]    Script Date: 9/10/2020 2:53:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempTicketNumber](
	[TicketId2] [int] NOT NULL,
	[Status2] [int] NULL,
	[TicketStatus] [int] NULL,
	[LocationId] [int] NULL,
	[CreatedBy2] [int] NULL,
	[CreatedDate2] [datetime] NULL,
	[UpdatedBy2] [int] NULL,
	[UpdatedDate2] [datetime] NULL,
	[ClientId] [int] NULL,
	[BillingNotes] [varchar](max) NULL,
	[ClientName] [varchar](200) NULL,
	[InvoiceStatus] [varchar](200) NULL,
	[visitOwner] [varchar](100) NULL,
	[TicketNumber] [varchar](100) NULL,
	[FinancialClass] [varchar](100) NULL,
	[DoctorsNPI] [varchar](200) NULL,
	[DoctorListName] [varchar](100) NULL,
	[CurrentInsurancePhone] [varchar](100) NULL,
	[Payer] [varchar](100) NULL,
	[CompanyListName] [varchar](100) NULL,
	[CaseInsuranceCarrier] [varchar](100) NULL,
	[LastFiledAge] [int] NULL,
	[CurrentInsuredId] [varchar](200) NULL,
	[AgeDOS] [int] NULL,
	[InsBalance] [decimal](18, 2) NULL,
	[TotalAmtBilled] [decimal](18, 2) NULL,
	[PatBalance] [decimal](18, 0) NULL,
	[ServiceDate] [datetime] NULL,
	[LastVOUpdateDate] [date] NULL,
	[LastFiledDate] [date] NULL,
	[FirstFiledDate] [date] NULL,
	[FirstDenialDate] [date] NULL,
	[LastDenialDate] [date] NULL,
	[PaidToAddress] [varchar](max) NULL,
	[FirstFiledAge] [int] NULL,
	[ImportType] [int] NOT NULL,
	[VisitDescription] [varchar](max) NULL,
	[QCAllocated] [int] NULL,
	[IsMultiTouch] [int] NOT NULL,
	[MultiTouchRowId] [int] NULL,
	[Shift] [varchar](25) NULL,
	[PatientName] [varbinary](max) NULL,
	[PatientBirthdate] [varbinary](max) NULL,
	[FederalTaxID] [varbinary](max) NULL,
	[FileType] [int] NULL,
	[TatStartDate] [datetime] NULL,
	[ExpectedTatEndDate] [datetime] NULL,
	[TatDurationMins] [int] NULL,
	[TatEndDate] [datetime] NULL,
	[MultiTouchFeedbackComment] [varchar](max) NULL,
	[MultiTouchCount] [int] NULL,
	[ImportRowId] [int] NULL,
	[PendingTATDuration] [int] NULL,
	[CompletedMode] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[PaymentAmount] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ten_million]    Script Date: 9/10/2020 2:53:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ten_million](
	[ID] [int] NOT NULL,
	[ClientID] [varchar](100) NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[DOS] [varchar](15) NULL,
	[ChargeDOP] [varchar](15) NULL,
	[CPT] [varchar](25) NULL,
	[CPTDescription] [varchar](200) NULL,
	[CPTGroupDesc] [varchar](100) NULL,
	[Modifier] [varchar](25) NULL,
	[InsuranceType] [varchar](100) NULL,
	[InsPlanID] [bigint] NULL,
	[InsurancePlanName] [varchar](200) NULL,
	[ClaimDetailPOS] [int] NULL,
	[ClaimFacilityName] [varchar](100) NULL,
	[ClaimFacilityPOS] [int] NULL,
	[FacilityOfFirstVisit] [varchar](100) NULL,
	[POSofFacilityOfFirstVisit] [int] NULL,
	[DateOfFirstVisit] [varchar](15) NULL,
	[Location] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Adjustments] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[ProcedureCount] [int] NULL,
	[Units] [int] NULL,
	[ClaimID] [bigint] NULL,
	[FacilityID] [bigint] NULL,
	[PatientID] [bigint] NULL,
	[ClaimDetailID] [bigint] NULL,
	[OriginalPrimaryInsurance] [bigint] NULL,
	[ClaimDetailDiag1] [varchar](50) NULL,
	[ClaimDetailDiag2] [varchar](50) NULL,
	[ClaimDetailDiag3] [varchar](50) NULL,
	[ClaimDetailDiag4] [varchar](50) NULL,
	[ClaimDetailDiag5] [varchar](50) NULL,
	[ClaimDetailDiag6] [varchar](50) NULL,
	[ClaimDetailDiag7] [varchar](50) NULL,
	[ClaimDetailDiag8] [varchar](50) NULL,
	[PatientFullName] [varchar](100) NULL,
	[AccountNumber] [varchar](50) NULL,
	[PatientAddress1] [varchar](250) NULL,
	[PatientAddress2] [varchar](250) NULL,
	[PatientCity] [varchar](50) NULL,
	[PatientState] [varchar](50) NULL,
	[PatientZip] [varchar](50) NULL,
	[PatientHomePhone] [varchar](50) NULL,
	[PatientWorkPhone] [varchar](50) NULL,
	[PatientHomeEmail] [varchar](50) NULL,
	[PatientWorkEmail] [varchar](50) NULL,
	[PatientSex] [varchar](10) NULL,
	[Deceased] [varchar](250) NULL,
	[AgeAtDOS] [bigint] NULL,
	[PatientPCP] [varchar](100) NULL,
	[PatientReferringProvider] [varchar](100) NULL,
	[DOSYYYYMM] [varchar](50) NULL,
	[DOPYYYYMM] [varchar](50) NULL,
	[ClaimProvider] [varchar](100) NULL,
	[ClaimSupervisingProvider] [varchar](100) NULL,
	[ClaimReferringProvider] [varchar](100) NULL,
	[PrimaryInsPmts] [decimal](18, 2) NULL,
	[PatientPmts] [decimal](18, 2) NULL,
	[OtherPmts] [decimal](18, 2) NULL,
	[PatientCash] [decimal](18, 2) NULL,
	[PatientCheck] [decimal](18, 2) NULL,
	[PatientCreditCard] [decimal](18, 2) NULL,
	[PatientOtherPmtType] [decimal](18, 2) NULL,
	[PatientDOB] [varchar](15) NULL,
	[Allowed_amount] [decimal](18, 2) NULL,
	[Schedule_name] [varchar](250) NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ten_million_copy]    Script Date: 9/10/2020 2:53:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ten_million_copy](
	[ID] [int] NOT NULL,
	[ClientID] [varchar](100) NULL,
	[ReportYear] [int] NULL,
	[ReportMonth] [int] NULL,
	[DOS] [varchar](15) NULL,
	[ChargeDOP] [varchar](15) NULL,
	[CPT] [varchar](25) NULL,
	[CPTDescription] [varchar](200) NULL,
	[CPTGroupDesc] [varchar](100) NULL,
	[Modifier] [varchar](25) NULL,
	[InsuranceType] [varchar](100) NULL,
	[InsPlanID] [bigint] NULL,
	[InsurancePlanName] [varchar](200) NULL,
	[ClaimDetailPOS] [int] NULL,
	[ClaimFacilityName] [varchar](100) NULL,
	[ClaimFacilityPOS] [int] NULL,
	[FacilityOfFirstVisit] [varchar](100) NULL,
	[POSofFacilityOfFirstVisit] [int] NULL,
	[DateOfFirstVisit] [varchar](15) NULL,
	[Location] [varchar](100) NULL,
	[Charges] [decimal](18, 2) NULL,
	[Payments] [decimal](18, 2) NULL,
	[Adjustments] [decimal](18, 2) NULL,
	[Refunds] [decimal](18, 2) NULL,
	[ProcedureCount] [int] NULL,
	[Units] [int] NULL,
	[ClaimID] [bigint] NULL,
	[FacilityID] [bigint] NULL,
	[PatientID] [bigint] NULL,
	[ClaimDetailID] [bigint] NULL,
	[OriginalPrimaryInsurance] [bigint] NULL,
	[ClaimDetailDiag1] [varchar](50) NULL,
	[ClaimDetailDiag2] [varchar](50) NULL,
	[ClaimDetailDiag3] [varchar](50) NULL,
	[ClaimDetailDiag4] [varchar](50) NULL,
	[ClaimDetailDiag5] [varchar](50) NULL,
	[ClaimDetailDiag6] [varchar](50) NULL,
	[ClaimDetailDiag7] [varchar](50) NULL,
	[ClaimDetailDiag8] [varchar](50) NULL,
	[PatientFullName] [varchar](100) NULL,
	[AccountNumber] [varchar](50) NULL,
	[PatientAddress1] [varchar](250) NULL,
	[PatientAddress2] [varchar](250) NULL,
	[PatientCity] [varchar](50) NULL,
	[PatientState] [varchar](50) NULL,
	[PatientZip] [varchar](50) NULL,
	[PatientHomePhone] [varchar](50) NULL,
	[PatientWorkPhone] [varchar](50) NULL,
	[PatientHomeEmail] [varchar](50) NULL,
	[PatientWorkEmail] [varchar](50) NULL,
	[PatientSex] [varchar](10) NULL,
	[Deceased] [varchar](250) NULL,
	[AgeAtDOS] [bigint] NULL,
	[PatientPCP] [varchar](100) NULL,
	[PatientReferringProvider] [varchar](100) NULL,
	[DOSYYYYMM] [varchar](50) NULL,
	[DOPYYYYMM] [varchar](50) NULL,
	[ClaimProvider] [varchar](100) NULL,
	[ClaimSupervisingProvider] [varchar](100) NULL,
	[ClaimReferringProvider] [varchar](100) NULL,
	[PrimaryInsPmts] [decimal](18, 2) NULL,
	[PatientPmts] [decimal](18, 2) NULL,
	[OtherPmts] [decimal](18, 2) NULL,
	[PatientCash] [decimal](18, 2) NULL,
	[PatientCheck] [decimal](18, 2) NULL,
	[PatientCreditCard] [decimal](18, 2) NULL,
	[PatientOtherPmtType] [decimal](18, 2) NULL,
	[PatientDOB] [varchar](15) NULL,
	[Allowed_amount] [decimal](18, 2) NULL,
	[Schedule_name] [varchar](250) NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Test_direct]    Script Date: 9/10/2020 2:53:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test_direct](
	[person] [int] NULL,
	[City] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Testt]    Script Date: 9/10/2020 2:53:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Testt](
	[test] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trans_TPX]    Script Date: 9/10/2020 2:53:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trans_TPX](
	[Ticket] [float] NULL,
	[Payer ] [varchar](max) NULL,
	[Procedure Codes] [varchar](max) NULL,
	[Batch Date] [datetime] NULL,
	[Transaction Code] [varchar](max) NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[pay_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[memo] [float] NULL,
	[subclient] [float] NULL,
	[ProcedureCode] [varchar](50) NULL,
	[AmountFiled] [float] NULL,
	[PayerBatchDate] [datetime] NULL,
	[DateDifference] [int] NULL,
	[AgingBucket] [varchar](25) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trans_TPXbak]    Script Date: 9/10/2020 2:53:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trans_TPXbak](
	[Ticket] [float] NULL,
	[Payer ] [nvarchar](255) NULL,
	[Procedure Codes] [nvarchar](max) NULL,
	[Batch Date] [nvarchar](255) NULL,
	[Transaction Code] [datetime] NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[pay_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[memo] [float] NULL,
	[subclient] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trans_TPXnew]    Script Date: 9/10/2020 2:53:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trans_TPXnew](
	[Ticket] [float] NULL,
	[Payer ] [nvarchar](255) NULL,
	[Procedure Codes] [nvarchar](max) NULL,
	[Batch Date] [nvarchar](255) NULL,
	[Transaction Code] [datetime] NULL,
	[count_by] [float] NULL,
	[charge] [float] NULL,
	[personal_pay] [float] NULL,
	[ins_pay] [float] NULL,
	[charge_adj] [float] NULL,
	[ins_adj] [float] NULL,
	[pay_adj] [float] NULL,
	[misc_charge] [float] NULL,
	[memo] [float] NULL,
	[subclient] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transition_matrix]    Script Date: 9/10/2020 2:53:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transition_matrix](
	[row_names] [varchar](255) NULL,
	[2DRYBILLED] [float] NULL,
	[72HOUR] [float] NULL,
	[ACCIDENT] [float] NULL,
	[ACCIDSTATE] [float] NULL,
	[ADDRINSURE] [float] NULL,
	[ADDROFFICE] [float] NULL,
	[ADJUST] [float] NULL,
	[ADMITDATE] [float] NULL,
	[ADMSNTYPE] [float] NULL,
	[ADNEOB] [float] NULL,
	[ADNINVOICE] [float] NULL,
	[ADNMEDREC] [float] NULL,
	[ADNPATIENT] [float] NULL,
	[ADNPRAC] [float] NULL,
	[ADNREVIEW] [float] NULL,
	[ADNSTUDENT] [float] NULL,
	[AGECPTMATCH] [float] NULL,
	[AGEDXMATCH] [float] NULL,
	[AIP] [float] NULL,
	[ANESTHESIA] [float] NULL,
	[ANESTREFORMAT] [float] NULL,
	[APPEALRVW] [float] NULL,
	[ASSIGNBEN] [float] NULL,
	[ASSIST] [float] NULL,
	[ATTYREP] [float] NULL,
	[AUTH] [float] NULL,
	[BAC] [float] NULL,
	[BADPKG] [float] NULL,
	[BDE] [float] NULL,
	[BILLPATIENT] [float] NULL,
	[CAP] [float] NULL,
	[CBOAPPEAL] [float] NULL,
	[CBOPNDEOB] [float] NULL,
	[CBORVW] [float] NULL,
	[CCT] [float] NULL,
	[CHARGE] [float] NULL,
	[CHKCUT] [float] NULL,
	[CHKLOST] [float] NULL,
	[CIP] [float] NULL,
	[CIP2] [float] NULL,
	[CLIA] [float] NULL,
	[CLIENTAPPEAL] [float] NULL,
	[CLMALARMCALL] [float] NULL,
	[CLMBILLED] [float] NULL,
	[CLMDUP] [float] NULL,
	[COBPEND] [float] NULL,
	[CODIFF] [float] NULL,
	[COINSURANCE] [float] NULL,
	[CONDCODE] [float] NULL,
	[CONTRACT] [float] NULL,
	[COPAY] [float] NULL,
	[CORRECT] [float] NULL,
	[CPT] [float] NULL,
	[CPTCHANGE] [float] NULL,
	[CREDENTIAL] [float] NULL,
	[CST] [float] NULL,
	[DECEASED] [float] NULL,
	[DEDUCT] [float] NULL,
	[DEMAND] [float] NULL,
	[DENIALRECALL] [float] NULL,
	[DENIALRECALL2] [float] NULL,
	[DENIED] [float] NULL,
	[DEPEND] [float] NULL,
	[DIAGNOSIS] [float] NULL,
	[DISCHARGEDATE] [float] NULL,
	[DMCALLRVW] [float] NULL,
	[DMCODINGRVW] [float] NULL,
	[DMSPECIALHANDLE] [float] NULL,
	[DOB] [float] NULL,
	[DRGCODE] [float] NULL,
	[DROP] [float] NULL,
	[DRPBILLING] [float] NULL,
	[DRPCBOAPPROVE] [float] NULL,
	[DRPNOF] [float] NULL,
	[DRPNOTERTIARY] [float] NULL,
	[DRPPATIENT] [float] NULL,
	[DUPCHG] [float] NULL,
	[DUPSUP] [float] NULL,
	[DXCPTMATCH] [float] NULL,
	[EDI] [float] NULL,
	[EFT] [float] NULL,
	[EMPLOYER] [float] NULL,
	[EOBCHARGE] [float] NULL,
	[FACILITYID] [float] NULL,
	[FAXREMIT] [float] NULL,
	[FAXTRACK] [float] NULL,
	[FAXTRACK2] [float] NULL,
	[FEESCHEDULE] [float] NULL,
	[FIXATTACHMENT] [float] NULL,
	[FORM] [float] NULL,
	[FORMAT] [float] NULL,
	[FWRAPPEALFAIL] [float] NULL,
	[FWRCLEAR] [float] NULL,
	[FWRCONFIRMDEPOSIT] [float] NULL,
	[FWRFILINGLIMIT] [float] NULL,
	[FWRNOPOST] [float] NULL,
	[FWRPAYORNONRESPONSIVE] [float] NULL,
	[FWRSENDREMIT] [float] NULL,
	[FWRSHAREDTINREMIT] [float] NULL,
	[FWRSMALLBAL] [float] NULL,
	[FWRTERTIARY] [float] NULL,
	[GENDER] [float] NULL,
	[GENDERCPTMATCH] [float] NULL,
	[GENDERDXMATCH] [float] NULL,
	[GLOBAL] [float] NULL,
	[GRPNMBR] [float] NULL,
	[HOLD] [float] NULL,
	[HOSPICE] [float] NULL,
	[INDICATOR] [float] NULL,
	[INELIG] [float] NULL,
	[INFORM] [float] NULL,
	[INJURYDATE] [float] NULL,
	[IPN] [float] NULL,
	[LASTSEEN] [float] NULL,
	[LEGAL] [float] NULL,
	[LGLRVW] [float] NULL,
	[LMP] [float] NULL,
	[LOCCODE] [float] NULL,
	[MAMMO] [float] NULL,
	[MANAGER] [float] NULL,
	[MCAIDBAL] [float] NULL,
	[MEDPOLICY] [float] NULL,
	[MEDRXDOSEINFO] [float] NULL,
	[MGRHOLD] [float] NULL,
	[MGRPOSTINGRVW] [float] NULL,
	[MODCPTMATCH] [float] NULL,
	[MODIFIER] [float] NULL,
	[MP] [float] NULL,
	[MPB] [float] NULL,
	[MVA] [float] NULL,
	[MVAPIP] [float] NULL,
	[MVAPYMNT] [float] NULL,
	[MVAWAIT4EOB] [float] NULL,
	[NAME] [float] NULL,
	[NAMEINSURE] [float] NULL,
	[NCP] [float] NULL,
	[NCPREVIEW] [float] NULL,
	[NDCNUMB] [float] NULL,
	[NEREVIEW] [float] NULL,
	[NEXTPAYOR] [float] NULL,
	[NMN] [float] NULL,
	[NOEOB] [float] NULL,
	[NPICROSSWALKTYPE1] [float] NULL,
	[NPICROSSWALKTYPE2] [float] NULL,
	[NPICROSSWALKUNSPECIFIED] [float] NULL,
	[NPIREFERRING] [float] NULL,
	[NPP] [float] NULL,
	[OCCURCODE] [float] NULL,
	[OCCURCODEDOSMATCH] [float] NULL,
	[OCCURVALCODEMATCH] [float] NULL,
	[OON] [float] NULL,
	[OPPROVID] [float] NULL,
	[ORDERPROV] [float] NULL,
	[OTHERADJ] [float] NULL,
	[OTHERPROVPD] [float] NULL,
	[OVERPY1MRY] [float] NULL,
	[OVERPY2NDY] [float] NULL,
	[OVERPYMT] [float] NULL,
	[OVERPYMTPRACRVW] [float] NULL,
	[PAYERUNAVAILABLE] [float] NULL,
	[PAYORID] [float] NULL,
	[PAYTO] [float] NULL,
	[PCPINFO] [float] NULL,
	[PCPNOF] [float] NULL,
	[PDTOPAT] [float] NULL,
	[PKGPROB] [float] NULL,
	[PLSAPPEAL] [float] NULL,
	[PNL] [float] NULL,
	[PORTALAPPEAL] [float] NULL,
	[PORTALINQ] [float] NULL,
	[PORTALSUBMISSION] [float] NULL,
	[POS] [float] NULL,
	[POSCPTMATCH] [float] NULL,
	[POSTING] [float] NULL,
	[POSTINGINPROCESS] [float] NULL,
	[PREEXIST] [float] NULL,
	[PROVIDINVA] [float] NULL,
	[PROVIDMISS] [float] NULL,
	[PROVREVIEW] [float] NULL,
	[PROVSIG] [float] NULL,
	[PTADDRESS] [float] NULL,
	[PTBALANCE] [float] NULL,
	[PTRESP] [float] NULL,
	[PTSTATUSTOBMATCH] [float] NULL,
	[PYMTNEGCOMPLT] [float] NULL,
	[PYMTNEGINIT] [float] NULL,
	[PYMTTOPAT] [float] NULL,
	[RECALL] [float] NULL,
	[RECALL2] [float] NULL,
	[RECONSIDERATION] [float] NULL,
	[REFPROV] [float] NULL,
	[REFRL] [float] NULL,
	[REFUNDREQUEST] [float] NULL,
	[REFUNDRESOLVED] [float] NULL,
	[REGERROR] [float] NULL,
	[RELATION] [float] NULL,
	[REMITRECEIVED] [float] NULL,
	[RENDERING] [float] NULL,
	[REPROCESS] [float] NULL,
	[REPROCESS2] [float] NULL,
	[RESUBNOF] [float] NULL,
	[REVCODE] [float] NULL,
	[REVCPTMATCH] [float] NULL,
	[REVIEWCT] [float] NULL,
	[RSN] [float] NULL,
	[RSNCODE] [float] NULL,
	[RTCALLRVW] [float] NULL,
	[RVCLOSE] [float] NULL,
	[RVW4APPEAL] [float] NULL,
	[SECINS] [float] NULL,
	[SENDREFUND] [float] NULL,
	[SENDREFUNDINTEREST] [float] NULL,
	[SERVDATE] [float] NULL,
	[SERVICEMAX] [float] NULL,
	[SETTLED] [float] NULL,
	[SPECIALHANDLING] [float] NULL,
	[STCALLRVW] [float] NULL,
	[SYMPTOMDAT] [float] NULL,
	[TAKEBACK] [float] NULL,
	[TAKEBACKREQUEST] [float] NULL,
	[TAXID] [float] NULL,
	[TAXONOMY] [float] NULL,
	[TERTBILLED] [float] NULL,
	[TERTIARY] [float] NULL,
	[TKBKEXPECTED] [float] NULL,
	[TOB] [float] NULL,
	[TOBREVCODEMATCH] [float] NULL,
	[TOS] [float] NULL,
	[TOSPOSMATCH] [float] NULL,
	[TPLCODE] [float] NULL,
	[TRACER] [float] NULL,
	[TRACKINGPNDEDI] [float] NULL,
	[TRAKPAIDCLM] [float] NULL,
	[TRAKREMIT] [float] NULL,
	[UNDERPYMT] [float] NULL,
	[UNITS] [float] NULL,
	[UNRESOVP] [float] NULL,
	[VALUECODE] [float] NULL,
	[VCAP] [float] NULL,
	[W9FORM] [float] NULL,
	[W9NEEDED] [float] NULL,
	[WAIVER] [float] NULL,
	[WCWAIT4EOB] [float] NULL,
	[WEBACCESSRVW] [float] NULL,
	[WORKCOMP] [float] NULL,
	[ZPDOC] [float] NULL,
	[ZPPRAC] [float] NULL,
	[ZPRVW] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransMin1]    Script Date: 9/10/2020 2:53:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransMin1](
	[Ticket] [float] NULL,
	[ProcedureCodes] [varchar](max) NULL,
	[BatchdateMin] [datetime] NULL,
	[BatchdateMax] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransMin2]    Script Date: 9/10/2020 2:53:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransMin2](
	[Ticket] [float] NULL,
	[BatchdateMin] [datetime] NULL,
	[BatchdateMax] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnmappedInvoice]    Script Date: 9/10/2020 2:53:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnmappedInvoice](
	[FileName] [varchar](9) NULL,
	[SumpymtAmt] [float] NULL,
	[SumcontrAdjAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vanished_Claims]    Script Date: 9/10/2020 2:53:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vanished_Claims](
	[Date] [date] NULL,
	[Claim ID] [varchar](255) NULL,
	[Days in Status] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VOICETYPE]    Script Date: 9/10/2020 2:53:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VOICETYPE](
	[VOICETYPE_Original] [varchar](255) NULL,
	[VOICETYPE_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VRS_AR_TicketMaster]    Script Date: 9/10/2020 2:53:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VRS_AR_TicketMaster](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NULL,
	[TicketStatus] [int] NULL,
	[LocationId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[ClientId] [int] NULL,
	[BillingNotes] [varchar](max) NULL,
	[ClientName] [varchar](200) NULL,
	[InvoiceStatus] [varchar](200) NULL,
	[visitOwner] [varchar](100) NULL,
	[TicketNumber] [varchar](100) NULL,
	[FinancialClass] [varchar](100) NULL,
	[DoctorsNPI] [varchar](200) NULL,
	[DoctorListName] [varchar](100) NULL,
	[CurrentInsurancePhone] [varchar](100) NULL,
	[Payer] [varchar](100) NULL,
	[CompanyListName] [varchar](100) NULL,
	[CaseInsuranceCarrier] [varchar](100) NULL,
	[LastFiledAge] [int] NULL,
	[CurrentInsuredId] [varchar](200) NULL,
	[AgeDOS] [int] NULL,
	[InsBalance] [decimal](18, 2) NULL,
	[TotalAmtBilled] [decimal](18, 2) NULL,
	[PatBalance] [decimal](18, 0) NULL,
	[ServiceDate] [datetime] NULL,
	[LastVOUpdateDate] [date] NULL,
	[LastFiledDate] [date] NULL,
	[FirstFiledDate] [date] NULL,
	[FirstDenialDate] [date] NULL,
	[LastDenialDate] [date] NULL,
	[PaidToAddress] [varchar](max) NULL,
	[FirstFiledAge] [int] NULL,
	[ImportType] [int] NOT NULL,
	[VisitDescription] [varchar](max) NULL,
	[QCAllocated] [int] NULL,
	[IsMultiTouch] [int] NOT NULL,
	[MultiTouchRowId] [int] NULL,
	[Shift] [varchar](25) NULL,
	[PatientBirthdate] [varbinary](max) NULL,
	[PatientName] [varbinary](max) NULL,
	[FederalTaxID] [varbinary](max) NULL,
	[TatStartDate] [datetime] NULL,
	[ExpectedTatEndDate] [datetime] NULL,
	[TatDurationMins] [int] NULL,
	[TatEndDate] [datetime] NULL,
	[MultiTouchFeedbackComment] [varchar](max) NULL,
	[MultiTouchCount] [int] NULL,
	[ImportRowId] [int] NULL,
	[PendingTATDuration] [int] NULL,
	[CompletedMode] [int] NULL,
 CONSTRAINT [PK__VRS___712CC60752E34C9D] PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WISCONSIN_AR_TicketMaster]    Script Date: 9/10/2020 2:53:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WISCONSIN_AR_TicketMaster](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[QCAllocated] [int] NULL,
	[Status] [int] NULL,
	[TicketStatus] [int] NULL,
	[LocationId] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[ClientId] [int] NULL,
	[InvoiceState] [varchar](50) NULL,
	[Insurance] [varchar](50) NULL,
	[HCPC] [varchar](50) NULL,
	[File_Name] [varchar](50) NULL,
	[Client_Inv] [varchar](50) NULL,
	[BTSID] [varchar](50) NULL,
	[BTSComments] [varchar](50) NULL,
	[Reason] [varchar](100) NULL,
	[Payer] [varchar](100) NULL,
	[ClientName] [varchar](100) NULL,
	[BranchOffice] [varchar](100) NULL,
	[BranchNPI] [varchar](100) NULL,
	[RecordType] [int] NULL,
	[TicketNumber] [int] NULL,
	[Counter] [int] NULL,
	[RecoupmentAmt] [decimal](18, 2) NULL,
	[Charge] [decimal](18, 2) NULL,
	[Balance] [decimal](18, 2) NULL,
	[ReportDate] [datetime] NULL,
	[InvoiceDocumentDate] [datetime] NULL,
	[DOS] [datetime] NULL,
	[DateDue] [datetime] NULL,
	[Shift] [varchar](50) NULL,
	[MultipleCount] [int] NOT NULL,
	[ImportType] [int] NOT NULL,
	[MultiTouchRowId] [int] NULL,
	[IsMultiTouch] [int] NOT NULL,
	[RPAReleasedBy] [int] NULL,
	[RPAReleasedOn] [datetime] NULL,
	[ShiftTicketId] [int] NULL,
	[WebStatus] [varbinary](max) NULL,
	[RPAStatus] [tinyint] NULL,
	[Speciality] [varchar](250) NULL,
	[Filter] [varchar](250) NULL,
	[CompletedMode] [int] NOT NULL,
	[PatientName] [varbinary](max) NULL,
	[PatientID] [varbinary](max) NULL,
	[PolicyNumber] [varbinary](max) NULL,
	[State] [varbinary](max) NULL,
	[TatStartDate] [datetime] NULL,
	[ExpectedTatEndDate] [datetime] NULL,
	[TatDurationMins] [int] NULL,
	[TatEndDate] [datetime] NULL,
	[MultiTouchFeedbackComment] [varchar](max) NULL,
	[MultiTouchCount] [int] NULL,
	[ImportRowId] [int] NULL,
	[PendingTATDuration] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WORKFLOWTYPE_Masking]    Script Date: 9/10/2020 2:53:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WORKFLOWTYPE_Masking](
	[WORKFLOWTYPE_Original] [varchar](255) NULL,
	[WORKFLOWTYPE_Mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[working1]    Script Date: 9/10/2020 2:53:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[working1](
	[FileName] [varchar](500) NULL,
	[pymtamt] [float] NULL,
	[contrAdjAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[working10]    Script Date: 9/10/2020 2:53:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[working10](
	[FileName] [varchar](10) NULL,
	[pymtamt] [float] NULL,
	[contrAdjAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[working11]    Script Date: 9/10/2020 2:53:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[working11](
	[FileName] [varchar](11) NULL,
	[pymtamt] [float] NULL,
	[contrAdjAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[working6]    Script Date: 9/10/2020 2:53:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[working6](
	[FileName] [varchar](500) NULL,
	[pymtamt] [float] NULL,
	[contrAdjAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[working7]    Script Date: 9/10/2020 2:53:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[working7](
	[FileName] [varchar](500) NULL,
	[pymtamt] [float] NULL,
	[contrAdjAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[working8]    Script Date: 9/10/2020 2:53:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[working8](
	[FileName] [varchar](500) NULL,
	[pymtamt] [float] NULL,
	[contrAdjAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[working9]    Script Date: 9/10/2020 2:53:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[working9](
	[FileName] [varchar](9) NULL,
	[pymtamt] [float] NULL,
	[contrAdjAmt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Worklist_Location_mask]    Script Date: 9/10/2020 2:53:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Worklist_Location_mask](
	[Worklist Location_original] [varchar](255) NULL,
	[Worklist Location_original_mask] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Worklist_Team_mask]    Script Date: 9/10/2020 2:53:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Worklist_Team_mask](
	[Worklist_Team_original] [varchar](255) NULL,
	[Worklist Team_masked] [varchar](255) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ARC_REC_USER_INFO] ADD  CONSTRAINT [MSmerge_df_rowguid_6363F97F0264468C9B2C5DB7557D4828]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[MidWest_Ar_ProcessMaster] ADD  CONSTRAINT [DF_MidWest_Ar_ProcessMaster_Appeal]  DEFAULT ((0)) FOR [Appeal]
GO
ALTER TABLE [dbo].[MidWest_Ar_ProcessMaster] ADD  CONSTRAINT [DF_MidWest_Ar_ProcessMaster_IssueLog]  DEFAULT ((0)) FOR [IssueLog]
GO
ALTER TABLE [dbo].[MidWest_Ar_ProcessMaster] ADD  CONSTRAINT [DF_MidWest_Ar_ProcessMaster_FutureFollowup]  DEFAULT ((0)) FOR [FeatureFollowup]
GO
ALTER TABLE [dbo].[MidWest_Ar_ProcessMaster] ADD  CONSTRAINT [DF_MidWest_Ar_ProcessMaster_Coding]  DEFAULT ((0)) FOR [Coding]
GO
ALTER TABLE [dbo].[MidWest_Ar_ProcessMaster] ADD  CONSTRAINT [DF_MidWest_Ar_ProcessMaster_ProcessStatus]  DEFAULT ((0)) FOR [ProcessStatus]
GO
ALTER TABLE [dbo].[MidWest_Ar_ProcessMaster] ADD  CONSTRAINT [DF_MidWest_Ar_ProcessMaster_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[MidWest_Ar_ProcessMaster] ADD  CONSTRAINT [DF_MidWest_Ar_ProcessMaster_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[MidWest_Ar_ProcessMaster] ADD  DEFAULT ((0)) FOR [IsPaymentPosting]
GO
ALTER TABLE [dbo].[MidWest_Ar_ProcessMaster] ADD  DEFAULT ((0)) FOR [IsOss]
GO
ALTER TABLE [dbo].[MidWest_Ar_ProcessMaster] ADD  DEFAULT ((0)) FOR [IlogSubCodeId]
GO
ALTER TABLE [dbo].[Midwest_AR_TicketMaster] ADD  DEFAULT ((1)) FOR [ImportType]
GO
ALTER TABLE [dbo].[Midwest_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [QCAllocated]
GO
ALTER TABLE [dbo].[Midwest_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [IsMultiTouch]
GO
ALTER TABLE [dbo].[Midwest_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [CompletedMode]
GO
ALTER TABLE [dbo].[Pacific_AR_TicketMaster] ADD  DEFAULT ((1)) FOR [ImportType]
GO
ALTER TABLE [dbo].[Pacific_AR_TicketMaster] ADD  DEFAULT ((1)) FOR [InvoiceType]
GO
ALTER TABLE [dbo].[PPM_Report_ClearGage] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Monthly_AgingReport] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Monthly_CodingCurves] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Monthly_Collections] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Monthly_DM7] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Monthly_DM7Details] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Monthly_EncounterAnalysis] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Monthly_Location_ChargePaymentAdjvsNet] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Monthly_PayorMix] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Monthly_Prov_AgingReport] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Monthly_Prov_ChargePaymentAdjvsNet] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Yearly_ChargePaymentAdjvsNet] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPM_Report_Yly_WRVU] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_AgingComparison] ADD  CONSTRAINT [DF__PPMReport__Creat__02925FBF]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_AgingReport] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_Charge] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ClearGage] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ClearGage_Collection] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ClientList] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_ClientList] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ClientList] ADD  CONSTRAINT [DF_PPMReport_ClientList_IsCGActive]  DEFAULT ((0)) FOR [IsCGActive]
GO
ALTER TABLE [dbo].[PPMReport_ClientListLogs] ADD  CONSTRAINT [DF_PPMReport_ClientListLogs_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[PPMReport_ClientName] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_ClientName] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_CodingCurveList] ADD  CONSTRAINT [DF__PPMReport__IsAct__44CA3770]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_CodingCurveList] ADD  CONSTRAINT [DF__PPMReport__Creat__45BE5BA9]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ColumnList] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_ColumnList] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_DM7] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_DM7Details] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_DOPQuery] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_DOSQuery] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECB_HeaderList] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_ECB_HeaderList] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECB_MandatoryColumn] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_ECB_MandatoryColumn] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_AgingReport] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_ARBeginEnd] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_Collection] ADD  CONSTRAINT [DF__PPMReport__Creat__0BB1B5A5]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_CPT] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_CPTQuery] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_DaySheet] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_FinancialAnalysis] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_FinancialAnalysis_YrlyTrend] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_OCR] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_PayerMix] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_ProviderNameList] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_ECW_ProviderNameList] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ECW_WithoutClaims] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_FinancialDashboard] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_Location] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_MatchColumnName] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_MatchColumnName] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_MatchProviderName] ADD  CONSTRAINT [DF__PPMReport__IsAct__45DE573A]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_MatchProviderName] ADD  CONSTRAINT [DF__PPMReport__Creat__46D27B73]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_PayerMix] ADD  CONSTRAINT [DF__PPMReport__Creat__7EC1CEDB]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ProcedureCount] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_ReportName] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_ReportName] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_Rollforward] ADD  CONSTRAINT [DF__PPMReport__Creat__54CB950F]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_Rollforward_YrlyCompare] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_SkipCPTEncounter] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_SkipCPTEncounter] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_UploadInfo] ADD  CONSTRAINT [DF_PPMReport_UploadInfo_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_wRVUList] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PPMReport_wRVUList] ADD  CONSTRAINT [DF_PPMReport_wRVUList_ClientID]  DEFAULT ((0)) FOR [ClientID]
GO
ALTER TABLE [dbo].[PPMReport_wRVUList] ADD  CONSTRAINT [DF_PPMReport_wRVUList_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PPMReport_wRVUReport] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[STLOUIS_AR_TicketMaster] ADD  DEFAULT ((1)) FOR [ImportType]
GO
ALTER TABLE [dbo].[STLOUIS_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [CompletedMode]
GO
ALTER TABLE [dbo].[VRS_AR_TicketMaster] ADD  DEFAULT ((1)) FOR [ImportType]
GO
ALTER TABLE [dbo].[VRS_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [QCAllocated]
GO
ALTER TABLE [dbo].[VRS_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [IsMultiTouch]
GO
ALTER TABLE [dbo].[VRS_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [CompletedMode]
GO
ALTER TABLE [dbo].[WISCONSIN_AR_TicketMaster] ADD  DEFAULT (NULL) FOR [Shift]
GO
ALTER TABLE [dbo].[WISCONSIN_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [MultipleCount]
GO
ALTER TABLE [dbo].[WISCONSIN_AR_TicketMaster] ADD  DEFAULT ((1)) FOR [ImportType]
GO
ALTER TABLE [dbo].[WISCONSIN_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [IsMultiTouch]
GO
ALTER TABLE [dbo].[WISCONSIN_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [RPAStatus]
GO
ALTER TABLE [dbo].[WISCONSIN_AR_TicketMaster] ADD  DEFAULT ((0)) FOR [CompletedMode]
GO
ALTER TABLE [dbo].[PPMReport_ClientListLogs]  WITH CHECK ADD  CONSTRAINT [FK_PPMReport_ClientListLogs_ID] FOREIGN KEY([ID])
REFERENCES [dbo].[PPMReport_ClientList] ([ID])
GO
ALTER TABLE [dbo].[PPMReport_ClientListLogs] CHECK CONSTRAINT [FK_PPMReport_ClientListLogs_ID]
GO
ALTER TABLE [dbo].[PPMReport_UploadInfo]  WITH CHECK ADD  CONSTRAINT [FK_PPMReport_UploadInfo_ClientID] FOREIGN KEY([ClientID])
REFERENCES [dbo].[PPMReport_ClientList] ([ID])
GO
ALTER TABLE [dbo].[PPMReport_UploadInfo] CHECK CONSTRAINT [FK_PPMReport_UploadInfo_ClientID]
GO
ALTER TABLE [dbo].[PPMReport_wRVUList]  WITH NOCHECK ADD  CONSTRAINT [FK_PPMReport_ClientID] FOREIGN KEY([ClientID])
REFERENCES [dbo].[PPMReport_ClientList] ([ID])
GO
ALTER TABLE [dbo].[PPMReport_wRVUList] CHECK CONSTRAINT [FK_PPMReport_ClientID]
GO
/****** Object:  StoredProcedure [dbo].[ALN_pAutopostingInsert]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

      
CREATE PROCEDURE [dbo].[ALN_pAutopostingInsert]         
(          
@TableVar dbo.ALN_dAutoposting READONLY,         
@CreatedBy varchar(500) = NULL        
)          
As         
/*        
Created By  : Gobinath.M        
Created Date: 2016-02-24         
Purpose  : Insert ExcelSheet Transaction         
Ticket/SCR ID  :         
TL Verified By : Ramakrishnan.G         
         
Implemented On : Ganesh        
Implemented On : 28-April-2016        
Reviewed by : Ganesh        
Reviewed On : 28-April-2016        
          
Modified on : 06/21/2016          
Modified Propose : To Insert the Member1,2 and 3 Values.        
*/         
BEGIN          
        
Insert into ERA_tPaymentPosting ([RowNumber],[pageNo],[BatchNo],[InvoiceID],[PatientLastName],[PatientFirstName],[PatientMiddleName],  
[AddInsPackageID],[ICN],[FromDOS],[ToDOS],[ProcedureCode],[Modifier1],[Modifier2],[Modifier3],[AmountBilled],[UnitsBilled],[checkNo],[pymtAmt],[coPayTrAmt],  
[coInsTrAmt],[dedTrAmt],[otherTrAmt],[globalTrAmt],[contrAdjAmt],[capitationAmt],[managedCareAmt],[otherAdjAmt],[remiReCode],[InterestAmt],[CheckAmt],[CheckDate],  
[TypeOfInsurance],[Crossoverinsurance],[Rec],[Status],[SNo],[CrossValid],[MemberID])         
SELECT [RowNumber],[pageNo],[BatchNo],[InvoiceID],[PatientLastName],[PatientFirstName],[PatientMiddleName],  
[AddInsPackageID],[ICN],[FromDOS],[ToDOS],[ProcedureCode],[Modifier1],[Modifier2],[Modifier3],[AmountBilled],[UnitsBilled],[checkNo],[pymtAmt],[coPayTrAmt],  
[coInsTrAmt],[dedTrAmt],[otherTrAmt],[globalTrAmt],[contrAdjAmt],[capitationAmt],[managedCareAmt],[otherAdjAmt],[remiReCode],[InterestAmt],[CheckAmt],[CheckDate],  
[TypeOfInsurance],[Crossoverinsurance],[Rec],[Status],[SNo],[CrossValid],[MemberID] from @TableVar         
Select @@ROWCOUNT;         
END 
GO
/****** Object:  StoredProcedure [dbo].[DBA_Missingindex]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DBA_Missingindex]        
as        
Begin     
Set transaction Isolation Level Read uncommitted;        
Create Table #tempU          
(          
Pid int identity(1,1),          
ID int,          
Imapact bigint,          
Seek datetime,          
TableName nvarchar(500),          
IndexNameCreate nvarchar(1000),          
IndexName nvarchar(500) default(Null),      
Include nvarchar(1000)         
)          
          
          
insert into #tempU(ID,Imapact,Seek,TableName,IndexNameCreate,IndexName,Include)     
    
SELECT                   
dm_mid.database_id AS DatabaseID,                  
dm_migs.avg_user_impact*(dm_migs.user_seeks+dm_migs.user_scans) Avg_Estimated_Impact,                  
dm_migs.last_user_seek AS Last_User_Seek,                  
OBJECT_NAME(dm_mid.OBJECT_ID,dm_mid.database_id) AS [TableName],                  
                
'CREATE INDEX [IX_' + OBJECT_NAME(dm_mid.OBJECT_ID,dm_mid.database_id) + '_'                  
+ REPLACE(REPLACE(REPLACE(ISNULL(dm_mid.equality_columns,''),', ','_'),'[',''),']','') +                  
CASE                  
WHEN dm_mid.equality_columns IS NOT NULL AND dm_mid.inequality_columns IS NOT NULL THEN '_'                  
ELSE ''                  
END                  
+ REPLACE(REPLACE(REPLACE(ISNULL(dm_mid.inequality_columns,''),', ','_'),'[',''),']','')                  
+ ']'                  
+ ' ON ' + dm_mid.statement                  
+ ' (' + ISNULL (dm_mid.equality_columns,'')                  
+ CASE WHEN dm_mid.equality_columns IS NOT NULL AND dm_mid.inequality_columns IS NOT NULL THEN ',' ELSE                  
'' END                  
+ ISNULL (dm_mid.inequality_columns, '')                  
+ ')'                  
+ ISNULL (' INCLUDE (' + dm_mid.included_columns + ')', '') AS Create_Statement,          
'IX_' + OBJECT_NAME(dm_mid.OBJECT_ID,dm_mid.database_id) + '_'                  
+ REPLACE(REPLACE(REPLACE(ISNULL(dm_mid.equality_columns,''),', ','_'),'[',''),']','') +                  
CASE                  
WHEN dm_mid.equality_columns IS NOT NULL AND dm_mid.inequality_columns IS NOT NULL THEN '_'                  
ELSE ''                  
END                  
+ REPLACE(REPLACE(REPLACE(ISNULL(dm_mid.inequality_columns,''),', ','_'),'[',''),']','')                  
 INDName,included_columns              
FROM sys.dm_db_missing_index_groups dm_mig                  
INNER JOIN sys.dm_db_missing_index_group_stats dm_migs                  
ON dm_migs.group_handle = dm_mig.index_group_handle                  
INNER JOIN sys.dm_db_missing_index_details dm_mid                  
ON dm_mig.index_handle = dm_mid.index_handle                  
WHERE dm_mid.database_ID = DB_ID()          
ORDER BY Avg_Estimated_Impact DESC             
          
select * from #tempU  order by Imapact desc        
          
delete from #tempU where Pid in (          
select MAX(pid) from #tempU group by indexName having COUNT(*)>1 )          
          
          
select distinct IndexNameCreate,IndexName  from #tempU where IndexName not in (select isnull(name,'') from sys.indexes)         
         
End 
GO
/****** Object:  StoredProcedure [dbo].[GetStatusLogs]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStatusLogs]
(
@Project INT,
@sDate DATETIME,
@eDate DATETIME
)
AS
BEGIN

if @Project > 0
BEGIN
	SELECT UI.RunAt,CL.Client,ISNULL(CL.ClientAcronym,'App')ClientAcronym,
	UI.ReportYear,UI.ReportMonth
	,UI.AppStatus,UI.ReportStatus,UI.ErrorLog,UI.Remarks,UI.CreatedBy
	FROM PPMReport_UploadInfo(NOLOCK)UI
	LEFT JOIN PPMReport_ClientList(NOLOCK)CL
	ON UI.ClientID = cl.ID
	WHERE UI.RunAt >= @sDate AND UI.RunAt <= @eDate
	AND UI.Project = @Project AND UI.ReportStatus IS NOT NULL
	ORDER BY UI.RunAt DESC
END
ELSE
BEGIN
	SELECT UI.RunAt,CL.Client,ISNULL(CL.ClientAcronym,'App')ClientAcronym,
	UI.ReportYear,UI.ReportMonth
	,UI.AppStatus,UI.ReportStatus,UI.ErrorLog,UI.Remarks,UI.CreatedBy
	FROM PPMReport_UploadInfo(NOLOCK)UI
	LEFT JOIN PPMReport_ClientList(NOLOCK)CL
	ON UI.ClientID = cl.ID
	WHERE UI.RunAt >= @sDate AND UI.RunAt <= @eDate
	AND UI.Project = @Project
	ORDER BY UI.RunAt DESC
END
END
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_BotStatus]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_BotStatus]
(
	@RunAt			VARCHAR(50),
	@Project		INT,
	@ClientID		INT,
	@ReportYear		INT,
	@ReportMonth	INT,
	@AppStatus		VARCHAR(200),
	@ReportStatus	VARCHAR(MAX) = NULL,
	@ErrorLog		VARCHAR(MAX) = NULL,
	@Remarks		VARCHAR(250) = NULL,
	@CreatedBy		VARCHAR(250)	
)
AS
BEGIN
DECLARE @Result VARCHAR(MAX)
BEGIN TRY           
	BEGIN TRANSACTION 
		INSERT INTO PPMReport_UploadInfo(RunAt,Project,ClientID,ReportYear,ReportMonth,AppStatus,ReportStatus,Remarks,ErrorLog,CreatedBy)
		VALUES(@RunAt,@Project,@ClientID,@ReportYear,@ReportMonth,@AppStatus,@ReportStatus,@Remarks,@ErrorLog,@CreatedBy)
	COMMIT TRANSACTION
		SET @Result = 'Sucess'  
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	SET @Result = ERROR_MESSAGE()	
	INSERT INTO PPMReport_UploadInfo(RunAt,Project,ClientID,ReportYear,ReportMonth,AppStatus,ReportStatus,Remarks,ErrorLog,CreatedBy)
	VALUES(GETDATE(),@Project,@ClientID,@ReportYear,@ReportMonth,'BotStatus',null,'DBError',@Result,@CreatedBy)	    
END CATCH
	SELECT @Result AS Result
END
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_CodingCurveQuery]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_CodingCurveQuery]            
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))            
AS            
BEGIN            
/*Coding Curve*/            
 /*       
DECLARE @Client VARCHAR(100)='CHCL'            
DECLARE @ReportYear varchar(max) = '2017,2018,2019'            
  */      
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear            
CREATE TABLE #TempTblYear(ReportYear INT)            
INSERT INTO #TempTblYear SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')            
            
IF OBJECT_ID('tempdb..#TempTableCodingCurve01') IS NOT NULL DROP TABLE #TempTableCodingCurve01            
IF OBJECT_ID('tempdb..#TempTableCodingCurve02') IS NOT NULL DROP TABLE #TempTableCodingCurve02            
IF OBJECT_ID('tempdb..#TempTableCodingCurve03') IS NOT NULL DROP TABLE #TempTableCodingCurve03      
IF OBJECT_ID('tempdb..#PPMReport_CodingCurveList') IS NOT NULL DROP TABLE #PPMReport_CodingCurveList      
      
SELECT * INTO #PPMReport_CodingCurveList FROM PPMReport_CodingCurveList(NOLOCK)
WHERE ClientID=(SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)

SELECT ClaimProvider AS ShortName    
--CASE WHEN ClaimProvider LIKE '%, %' THEN             
--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))            
--ELSE ClaimProvider END AS ShortName     
INTO #TempTableCodingCurve01 FROM            
(SELECT ClientID, ClaimProvider  from PPMReport_DOPQuery(NOLOCK) RF            
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON RF.ClientID= CL.ID            
WHERE cl.ClientAcronym = @Client AND ReportYear IN (SELECT ReportYear FROM #TempTblYear) GROUP BY ClientID, ClaimProvider)a            
            
INSERT INTO #TempTableCodingCurve01(ShortName) VALUES('All Provider')      
            
SELECT bb.ReportYear,cc.ID ReportMonth,aa.ShortName,CPTCode,Fee,(ISNULL(NationalDist,0)*100)NationalDist,TableName            
INTO #TempTableCodingCurve02 FROM #TempTableCodingCurve01 aa            
LEFT OUTER JOIN #PPMReport_CodingCurveList(NOLOCK)bb ON  1=1       
LEFT OUTER JOIN PPM_Month(NOLOCK)cc on 1=1            
WHERE bb.ReportYear IN (SELECT ReportYear FROM #TempTblYear)             
            
SELECT ClientID,ReportMonth,ReportYear,ClaimProvider,CPT,SUM(Units)Units, ClaimProvider AS ShortName       
--CASE WHEN ClaimProvider LIKE '%, %' THEN             
--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))            
--ELSE ClaimProvider END AS ShortName             
INTO #TempTableCodingCurve03 FROM PPMReport_DOPQuery(NOLOCK)            
WHERE ReportYear IN (SELECT ReportYear FROM #TempTblYear)       
AND ID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = 'CHCL')           
GROUP BY ClientID,ReportMonth,ReportYear,ClaimProvider,CPT      
            
SELECT DISTINCT @Client ClientAcronym,        
Client = (SELECT TOP 1 ClientFullName FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client),        
aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.CPTCode,aa.Fee,ISNULL(bb.Units,0) CurrentFrequency,aa.NationalDist,aa.TableName            
FROM #TempTableCodingCurve02 AA         
LEFT JOIN #TempTableCodingCurve03 bb             
ON aa.CPTCode=bb.CPT and aa.ReportMonth=bb.ReportMonth and aa.ShortName=bb.ShortName           
and aa.ReportYear=bb.ReportYear      
ORDER BY ReportYear,ReportMonth,ShortName,CPTCode            
            
IF OBJECT_ID('tempdb..#TempTableCodingCurve01') IS NOT NULL DROP TABLE #TempTableCodingCurve01            
IF OBJECT_ID('tempdb..#TempTableCodingCurve02') IS NOT NULL DROP TABLE #TempTableCodingCurve02            
IF OBJECT_ID('tempdb..#TempTableCodingCurve03') IS NOT NULL DROP TABLE #TempTableCodingCurve03      
IF OBJECT_ID('tempdb..#PPMReport_CodingCurveList') IS NOT NULL DROP TABLE #PPMReport_CodingCurveList            
            
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_DOP]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_DOP]        
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))          
AS          
BEGIN         
/*    
DECLARE @Client VARCHAR(100)='CHCL'    
DECLARE @ReportYear varchar(max) = '2017,2018'        
*/    
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
CREATE TABLE #TempTblYear(ReportYear INT)      
      
INSERT INTO #TempTblYear      
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')      
      
SELECT  cl.ClientAcronym,CL.ClientFullName Client,ReportYear,PM.ReportMonth,DOS,ChargeDOP,CPT,CPTDescription,CPTGroupDesc,Modifier,InsuranceType,InsPlanID,        
InsurancePlanName,ClaimDetailPOS,ClaimFacilityName,ClaimFacilityPOS,FacilityOfFirstVisit,        
POSofFacilityOfFirstVisit,DateOfFirstVisit,[Location],Charges,Payments,Adjustments,        
Refunds,ProcedureCount,Units,ClaimID,FacilityID,PatientID,ClaimDetailID,OriginalPrimaryInsurance,        
PatientPCP,PatientReferringProvider,DOSYYYYMM,DOPYYYYMM,ClaimProvider,ClaimSupervisingProvider,        
ClaimReferringProvider,allowed_amount,schedule_name        
FROM PPMReport_DOPQuery(NOLOCK)FD        
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID          
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth          
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)      
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear)      
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_DOS]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_DOS]        
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))        
AS        
BEGIN        
/*    
DECLARE @Client VARCHAR(100)= 'CHCL'         
DECLARE @ReportYear varchar(max) = '2018'          
*/        
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear        
CREATE TABLE #TempTblYear(ReportYear INT)        
        
INSERT INTO #TempTblYear        
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')        
        
SELECT CL.ClientAcronym,CL.ClientFullName Client,ReportYear,PM.ReportMonth,DOS,ChargeDOP,CPT,CPTDescription,CPTGroupDesc,Modifier,InsuranceType,InsPlanID,          
InsurancePlanName,ClaimDetailPOS,ClaimFacilityName,ClaimFacilityPOS,FacilityOfFirstVisit,          
POSofFacilityOfFirstVisit,DateOfFirstVisit,[Location],Charges,Payments,Adjustments,          
Refunds,ProcedureCount,Units,ClaimID,FacilityID,PatientID,ClaimDetailID,OriginalPrimaryInsurance,          
PatientPCP,PatientReferringProvider,DOSYYYYMM,DOPYYYYMM,ClaimProvider,ClaimSupervisingProvider,          
ClaimReferringProvider,allowed_amount,schedule_name       
FROM PPMReport_DOSQuery(Nolock)FD        
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID        
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth        
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)        
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear)        
 ORDER BY FD.ReportYear,FD.ReportMonth ASC        
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear         
END      
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_EBM_BIData]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_EBM_BIData]          
(@cId int, @Year int, @month int,@Output VARCHAR(MAX) OUTPUT)                      
AS                      
BEGIN                      
	DECLARE @ErrorMessage VARCHAR(MAX)                      
	DECLARE @ClientID INT = @cId                     
	DECLARE @ReportYear INT = @Year                      
	DECLARE @ReportMonth INT = @month                      
	DECLARE @RWCount INT=0        
	DECLARE @cCount INT
	SET @cCount =  (SELECT COUNT(ID)ID FROM PPMReport_ClientList(NOLOCK) WHERE ID = @ClientID AND IsActive = 1 AND Project = 1)

	if @cCount > 0
	BEGIN
		/*Page 2 to 12*/                      
		BEGIN TRY                       
		BEGIN TRANSACTION           
                           
		/*Backup Old Name in charge*/        
		UPDATE XL SET XL.XLName = A.EOMName        
		FROM(        
		SELECT ch.id, pn.ClientID,EOMName,DOPName        
		FROM PPMReport_MatchProviderName(NOLOCK)PN        
		INNER JOIN PPMReport_Charge(NOLOCK)CH        
		ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.ProviderName        
		WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 1      
		GROUP BY CH.ID, pn.ClientID,EOMName,DOPName        
		)A        
		INNER JOIN PPMReport_Charge(NOLOCK)XL ON XL.ID=A.ID AND XL.ProviderName = A.EOMName        
		WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
        
		/*Update Provider name as DOP Name in Charge*/        
		UPDATE XL SET XL.ProviderName = A.DOPName        
		FROM(        
		SELECT ch.id, pn.ClientID,EOMName,DOPName        
		FROM PPMReport_MatchProviderName(NOLOCK)PN        
		INNER JOIN PPMReport_Charge(NOLOCK)CH        
		ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.ProviderName        
		WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 1       
		GROUP BY CH.ID, pn.ClientID,EOMName,DOPName        
		)A        
		INNER JOIN PPMReport_Charge(NOLOCK)XL ON XL.ID=A.ID AND XL.ProviderName = A.EOMName        
		WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
        
		/*Backup Old Name in AgingReport*/        
		UPDATE XL SET XL.XLName = A.EOMName        
		FROM(        
		SELECT AR.id, pn.ClientID,EOMName,DOPName        
		FROM PPMReport_MatchProviderName(NOLOCK)PN        
		INNER JOIN PPMReport_AgingReport(NOLOCK)AR        
		ON /*PN.ClientID = AR.ClientID AND*/ PN.EOMName = AR.ProviderName        
		WHERE AR.ClientID = @ClientID AND AR.ReportMonth = @ReportMonth AND AR.ReportYear = @ReportYear AND PN.ProjectID = 1  
		GROUP BY AR.id, pn.ClientID,EOMName,DOPName        
		)A        
		INNER JOIN PPMReport_AgingReport(NOLOCK)XL ON XL.ID=A.ID AND XL.ProviderName = A.EOMName         
		WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
        
		/*Update Provider name as DOP Name in AgingReport*/        
		UPDATE XL SET XL.ProviderName = A.DOPName        
		FROM(        
		SELECT AR.id, pn.ClientID,EOMName,DOPName        
		FROM PPMReport_MatchProviderName(NOLOCK)PN        
		INNER JOIN PPMReport_AgingReport(NOLOCK)AR        
		ON /*.ClientID = AR.ClientID AND*/ PN.EOMName = AR.ProviderName        
		WHERE AR.ClientID = @ClientID AND AR.ReportMonth = @ReportMonth AND AR.ReportYear = @ReportYear AND PN.ProjectID = 1  
		GROUP BY AR.id, pn.ClientID,EOMName,DOPName          
		)A        
		INNER JOIN PPMReport_AgingReport(NOLOCK)XL ON XL.ID=A.ID AND XL.ProviderName = A.EOMName        
		WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
        
                      
		IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12                      
		IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays                      
		if (SELECT Count(*) FROM PPMReport_Rollforward(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)<=0                      
		BEGIN                      
		CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),                      
		Charges DECIMAL (18, 2),NetPayments DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),                      
		UnappliedPayments DECIMAL (18, 2),AccountsReceivable DECIMAL (18, 2),AROver120 DECIMAL (18, 2),ARDaysOutstanding DECIMAL (18, 2),                     
		UnappliedBalance DECIMAL (18, 2),DTID DATE)                      
		/*UPDATE IN TEMP TABLE*/                      
		INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)                      
		SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider ProviderName,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN          
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		SUM(ISNULL(Charges,0))Charges,SUM(ISNULL(Payments,0))Payments,SUM(ISNULL(Refunds,0))Refunds,SUM(ISNULL(Adjustments,0))Adjustments,                      
		CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID FROM PPMReport_DOPQuery(NOLOCK)DP                      
		WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth                      
		GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider                      
		/*Update All Provider for Charges,Payments,Refunds,Adjustments*/                      
		INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)                      
		SELECT ClientID,ReportYear,ReportMonth, 'All Provider'ProviderName,'All Provider'ShortName,                      
		SUM(ISNULL(Charges,0))Charges,SUM(ISNULL(Payments,0))Payments,SUM(ISNULL(Refunds,0))Refunds,SUM(ISNULL(Adjustments,0))Adjustments,                      
		CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID FROM #TempTblpg1to12                       
		WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth=@ReportMonth                      
		GROUP BY ClientID,ReportYear,ReportMonth                      
		/*Update All Provider for UnappliedPayments*/                      
		UPDATE UA SET UA.UnappliedPayments = a.UnappliedPayments                                                          
		FROM (SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(NetPayments,0))UnappliedPayments                       
		FROM PPMReport_Charge(NOLOCK)                       
		WHERE ProviderName='Practice Unapplied' AND ClientID =@ClientID AND ReportYear = @ReportYear and ReportMonth=@ReportMonth                      
		GROUP BY  ClientID,ReportYear,ReportMonth) a                                                              
		INNER JOIN #TempTblpg1to12 UA                       
		ON UA.ClientID = a.ClientID AND UA.ReportYear = a.ReportYear AND UA.ReportMonth = a.ReportMonth AND UA.ProviderName = a.ProviderName                      
		/*Update All Provider for UnappliedBalance*/                      
		UPDATE UB SET UB.UnappliedBalance = aa.UnappliedBalance                                                          
		FROM (SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(CategoryBalance,0)) UnappliedBalance                       
		FROM PPMReport_AgingReport(NOLOCK)                      
		WHERE  ProviderName = 'All Provider' AND ATBCategory = 'Practice Unapplied' AND ClientID =@ClientID AND ReportYear = @ReportYear                      
		AND ReportMonth=@ReportMonth GROUP BY  ClientID,ReportYear,ReportMonth) aa                      
		INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear                       
		AND UB.ReportMonth = aa.ReportMonth AND UB.ProviderName = aa.ProviderName                      
		/*Update All Provider for AccountsReceivable*/                      
		UPDATE UB SET UB.AccountsReceivable = aa.AccountsReceivable                                                    
		FROM (SELECT ClientID,ReportYear,ReportMonth,ProviderName, ProviderName AS ShortName,                      
		--CASE WHEN ProviderName LIKE '%, %' THEN                       
		--LEFT(ProviderName,(LEN(ProviderName)-Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))        
		--ELSE ProviderName END AS ShortName,          
		SUM(ISNULL(CategoryBalance,0))AccountsReceivable                      
		FROM PPMReport_AgingReport(NOLOCK) WHERE ATBCategory='Totals'                      
		AND ClientID =@ClientID AND ReportYear = @ReportYear AND ReportMonth=@ReportMonth GROUP BY ClientID,ReportYear,ReportMonth,ProviderName) aa                      
		INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear                       
		AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName                      
		/*Update All Provider for AROver120*/                      
		UPDATE UB SET UB.AROver120 = aa.AROver120                                                 
		FROM (SELECT ClientID,ReportYear,ReportMonth,ProviderName, ProviderName  AS ShortName,                   
		--CASE WHEN ProviderName LIKE '%, %' THEN                       
		--LEFT(ProviderName,(LEN(ProviderName)-Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))                      
		--ELSE ProviderName END AS ShortName,          
		SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120                       
		FROM PPMReport_AgingReport(NOLOCK) WHERE ATBCategory NOT IN ('Totals','Practice Unapplied')                      
		AND ClientID =@ClientID AND ReportYear = @ReportYear AND ReportMonth=@ReportMonth GROUP BY ClientID,ReportYear,ReportMonth,ProviderName) aa                      
		INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear                       
		AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName                      
		/*Update netpayments, accountreceivable with calculation*/                      
		UPDATE UB SET UB.NetPayments = aa.NetPayments, ub.AccountsReceivable = aa.AccountsReceivable                      
		FROM(SELECT ClientID,ReportYear,ReportMonth,ShortName,                      
		/*ISNULL(SUM(ABS(ISNULL(Payments,0))-ABS(ISNULL(Refunds,0))-ABS(ISNULL(UnappliedPayments,0))),0)NetPayments,*/                      
		ABS(SUM(((ISNULL(Payments,0)*-1)+(ISNULL(Refunds,0)*-1))+(ISNULL(UnappliedPayments,0)*-1)))NetPayments                      
		,ISNULL(SUM(ISNULL(AccountsReceivable,0)-ISNULL(UnappliedBalance,0)),0)AccountsReceivable                      
		FROM #TempTblpg1to12 GROUP BY ClientID,ReportYear,ReportMonth,ShortName) aa                      
		INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear                       
		AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName                      
		/*ARDaysOutstanding*/                      
		SELECT ClientID,ReportMonth,ReportYear,ShortName,Charges,DTID                      
		INTO #TempTblpg1to12ARDays FROM PPMReport_Rollforward(NOLOCK) WHERE ClientID = @ClientID AND                      
		DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                       
		DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')                      
		SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1                      
		IF @RWCount = 1                      
		BEGIN                      
		UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                     
		FROM(SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((isnull(Charges,0)/(30)),0),0),0)ARDays                       
		FROM #TempTblpg1to12 WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                      
		GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges)AR   
		INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                       
		ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                      
		END                      
		ELSE                      
		BEGIN                      
		UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                      
		FROM(SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,                      
		ISNULL(NULLIF(ISNULL(ABS(isnull(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays                      
		FROM #TempTblpg1to12 AA LEFT JOIN (SELECT ClientID,ShortName,SUM(ISNULL(Charges,0))Charges FROM #TempTblpg1to12ARDays                       
		GROUP BY  ClientID,ShortName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName=bb.ShortName                      
		WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear                      
		GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable)AR                      
		INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                       
		ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                      
		END                      
		/*Final Data moved to PPMReport_Rollforward table*/                      
		INSERT INTO PPMReport_Rollforward(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,                      
		Payments,Refunds,Adjustments,UnappliedPayments,AccountsReceivable,AROver120,ARDaysOutstanding,UnappliedBalance,DTID)                      
		SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,                      
		NetPayments,Refunds,ABS(ISNULL(Adjustments,0))Adjustments,ISNULL(UnappliedPayments,0)UnappliedPayments,AccountsReceivable,                      
		AROver120,ARDaysOutstanding,ISNULL(UnappliedBalance,0)UnappliedBalance,DTID FROM #TempTblpg1to12 ORDER BY ShortName                      
		/*Yearly Compare*/                      
		INSERT INTO PPMReport_Rollforward_YrlyCompare(ClientID,ReportYear,ReportMonth,ShortName,YrlyCharges,                      
		YrlyPayments,YrlyRefunds,YrlyAdjustments,YrlyUnappliedPayments,YrlyAccountsReceivable,YrlyAROver120,                      
		YrlyARDaysOutstanding,YrlyUnappliedBalance)                      
		SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ShortName,                       
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,                      
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,                      
		CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,                      
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,                      
		CONVERT(FLOAT,ISNULL(SUM(CY.UnappliedPayments-PY.UnappliedPayments)/NULLIF(ISNULL(SUM(PY.UnappliedPayments),0),0),0))*100 YrlyUnappliedPayments,                      
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,                      
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,                      
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,                      
		CONVERT(FLOAT,ISNULL(SUM(CY.UnappliedBalance-PY.UnappliedBalance)/NULLIF(ISNULL(SUM(PY.UnappliedBalance),0),0),0))*100 YrlyUnappliedBalance                      
		FROM PPMReport_Rollforward(NOLOCK)CY LEFT JOIN (SELECT * FROM PPMReport_Rollforward(NOLOCK)                       
		WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY                       
		ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ShortName=PY.ShortName                      
		WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth                      
		GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ShortName                       
		IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12                      
		IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays                      
		END                      
                      
                      
		/*Page 13 to 22*/                      
		--DECLARE @ClientID INT = 1                      
		--DECLARE @ReportYear INT = 2017                      
		--DECLARE @ReportMonth INT = 2                      
		IF OBJECT_ID('tempdb..#TempTblpg13to22') IS NOT NULL DROP TABLE #TempTblpg13to22                      
		IF OBJECT_ID('tempdb..#TempTblFD01') IS NOT NULL DROP TABLE #TempTblFD01                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02                      
		IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                      
		BEGIN                      
		CREATE TABLE #TempTblpg13to22(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),                      
		ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2))                      
		/*GET Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,UnappliedPayments,AccountsReceivable*/                      
		SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, ReportName, TotalCount INTO #TempTblFD01                      
		FROM (SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,                      
		UnappliedPayments,AccountsReceivable FROM PPMReport_Rollforward(NOLOCK)                      
		WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth) PVT                      
		UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,UnappliedPayments,AccountsReceivable))AS unpvt;                      
		UPDATE #TempTblFD01 SET ReportName = 'Gross Charges' WHERE ReportName = 'Charges'                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                      
		SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount FROM #TempTblFD01                      
            
		/*Update Cleargage*/                      
		UPDATE UB SET UB.ClearGage = aa.Credit     
		FROM (SELECT cc.ClientID,cc.ReportMonth,cc.ReportYear,cc.ProviderName,cg.Credit                      
		FROM PPMReport_ClearGage_Collection(NOLOCK)cc                      
		LEFT JOIN PPMReport_ClientList(Nolock)cl on cc.ClientID=cl.ID                      
		LEFT JOIN PPMReport_ClearGage(NOLOCK)cg                       
		ON cl.ClientFullName = cg.PPMMerchantAccount and cc.ReportYear=cg.ReportYear and cc.ReportMonth=cg.ReportMonth                      
		WHERE cc.ClientID=@ClientID and cc.ReportMonth = @ReportMonth and cc.ReportYear = @ReportYear) aa                      
		INNER JOIN PPMReport_ClearGage_Collection UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear                       
		AND UB.ReportMonth = aa.ReportMonth AND UB.ProviderName = aa.ProviderName             
                     
		/*Get ClearGage, Collections*/                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                      
		SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, ReportName, TotalCount FROM                       
		(SELECT  ClientID,ReportYear,ReportMonth,ProviderName,'All Provider'ShortName, ISNULL(ClearGage,0)ClearGage,ISNULL(Collections,0)Collections                       
		FROM PPMReport_ClearGage_Collection(NOLOCK)                      
		WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth) PVT                      
		UNPIVOT (TotalCount FOR ReportName IN (ClearGage, Collections))AS unpvt;                    /*Get all provider EncounterAnalysis*/                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,TotalCount,ReportName)                     
		SELECT ClientID,ReportYear,ReportMonth,'All Provider'ClaimProvider,'All Provider'ShortName,                      
		CPTGroupDesc,SUM(ISNULL(Units,0))TotalCount,'EncounterAnalysis'ReportName FROM PPMReport_DOPQuery(NOLOCK)                      
		WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL                       
		AND CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/                      
		GROUP BY ClientID,ReportYear,ReportMonth,CPTGroupDesc /*HAVING SUM(ISNULL(Units,0))>0*/ ORDER BY CPTGroupDesc ASC                      
		/*Get Individual Provider EncounterAnalysis*/                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,TotalCount,ReportName)                 
		SELECT ClientID,ReportYear,ReportMonth,ClaimProvider,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		CPTGroupDesc,SUM(ISNULL(Units,0))TotalCount,'EncounterAnalysis'ReportName                      
		FROM PPMReport_DOPQuery(NOLOCK) WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND                       
		ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL AND CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/                      
		GROUP BY ClientID,ReportYear,ReportMonth,ClaimProvider,CPTGroupDesc /*HAVING SUM(ISNULL(Units,0))>0*/ ORDER BY ClaimProvider ASC                      
		/*CPT Counts All Provider*/                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                      
		SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,                      
		'CPT Counts'ReportName,SUM(ISNULL(Units,0))Units FROM PPMReport_DOPQuery(NOLOCK)DP                      
		WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL                       
		AND Dp.CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/                      
		GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth                      
		ORDER BY ProviderName,ReportYear,ReportMonth ASC                      
		/*CPT Counts Individual Provider*/                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                      
		SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider ProviderName,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		'CPT Counts'ReportName,SUM(ISNULL(Units,0))Units                      
		FROM PPMReport_DOPQuery(NOLOCK)DP                      
		WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL                       AND Dp.CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/                      
		GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider HAVING SUM(ISNULL(Units,0))>0                      
		ORDER BY ProviderName,ReportYear,ReportMonth ASC                      
		/*Work wRVU All Provider*/                      
		SELECT ClientID,dp.ReportYear,ReportMonth,CPT,SUM(Units)UNITS                      
		INTO #TempTblWorkwRVU01 FROM PPMReport_DOPQuery(NOLOCK) DP                      
		WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY ClientID,dp.ReportYear,ReportMonth,CPT                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                      
		SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,'Work wRVU'ReportName,                      
		SUM(wRVUu)wRVU FROM                      
		(SELECT ClientID,rv.ReportYear,ReportMonth,CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu                      
		FROM #TempTblWorkwRVU01(NOLOCK)cp                      
		INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                       
		GROUP BY ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units)aa                      
		GROUP BY ClientID,ReportYear,ReportMonth                      
		/*Work wRVU Individual Provider*/                      
		SELECT ClientID,dp.ReportYear,ReportMonth,CPT,SUM(Units)UNITS,ClaimProvider                      
		INTO #TempTblWorkwRVU02 FROM PPMReport_DOPQuery(NOLOCK) DP                      
		WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY ClientID,dp.ReportYear,ReportMonth,CPT,ClaimProvider                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                
		SELECT ClientID,ReportYear,ReportMonth,ClaimProvider ProviderName,ShortName,'Work wRVU'ReportName,                      
		SUM(wRVUu)wRVU FROM                      
		(SELECT ClientID,rv.ReportYear,ReportMonth,ClaimProvider,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu                      
		FROM #TempTblWorkwRVU02(NOLOCK)cp                      
		INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                       
		GROUP BY ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units,ClaimProvider)aa                   
		GROUP BY ClientID,ReportYear,ReportMonth,ClaimProvider,ShortName                      
		ORDER BY ReportYear,ReportMonth,ShortName                      
                      
		/*Update to Financial dashboard*/                      
		INSERT INTO PPMReport_FinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)                      
		SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount FROM #TempTblpg13to22                      
		IF OBJECT_ID('tempdb..#TempTblpg13to22') IS NOT NULL DROP TABLE #TempTblpg13to22                      
		IF OBJECT_ID('tempdb..#TempTblFD01') IS NOT NULL DROP TABLE #TempTblFD01                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02                      
		END                      
                      
                      
		/*Payer Mix <---> Page 26 - 45*/                      
		--DECLARE @ClientID INT = 1                      
		--DECLARE @ReportYear INT = 2017                      
		--DECLARE @ReportMonth INT = 4                      
		if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                      
		BEGIN                      
		INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)                      
		SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,                      
		InsuranceType,SUM(ISNULL(Charges,0))Charges,SUM(Payments)Payments ,SUM(Refunds) Refunds                      
		FROM PPMReport_DOPQuery(NOLOCK)DP                      
		WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,InsuranceType                      
		/*ORDER BY DP.ClientID,DP.ReportYear,DP.ReportMonth,dp.InsuranceType*/                      
		UNION                      
		SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,'UnappliedPayments'InsuranceType,0.00 charges,                      
		UnappliedPayments Payments,0.00 Refunds FROM PPMReport_Rollforward(nolock)                       
		WHERE ReportMonth=@ReportMonth and ReportYear=@ReportYear AND ClientID=@ClientID AND ProviderName = 'All Provider'                      
                 
		INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)                      
		SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		InsuranceType,SUM(ISNULL(Charges,0))Charges,                      
		SUM(Payments)Payments ,SUM(Refunds) Refunds FROM PPMReport_DOPQuery(NOLOCK)DP                      
		WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider,InsuranceType         
		ORDER BY DP.ClientID,DP.ReportYear,DP.ReportMonth,DP.ClaimProvider,dp.InsuranceType                      
		END                      
                      
		/*Aging Comparison <---> Page 47 - 48*/                      
		--DECLARE @ClientID INT = 1                      
		--DECLARE @ReportYear INT = 2017                      
		--DECLARE @ReportMonth INT = 4                      
		IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC                      
		IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                       
		WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01')<=0                      
		BEGIN                      
		CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),                      
		[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),                      
		[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE,ShortName varchar(100))                      
		/*Insurance AR*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)                      
		SELECT ac.ClientID,ac.ReportYear,AC.ReportMonth,'Aging-01'ReportName,ac.ProviderName,'Insurance AR' ATBCategory,                      
		SUM(ISNULL(ac.[0-30],0))[0-30],SUM(ISNULL(ac.[31-60],0))[31-60],SUM(ISNULL(ac.[61-90],0))[61-90],SUM(ISNULL(ac.[91-120],0))[91-120],                      
		SUM(ISNULL(ac.[121-150],0))[121-150],SUM(ISNULL(ac.[151-180],0))[151-180],SUM(ISNULL(ac.[181+],0))[181+],                      
		SUM(ISNULL(ac.[CategoryBalance],0))[CategoryBalance]  FROM PPMReport_AgingReport(NOLOCK) AC                      
		WHERE ATBCategory NOT IN('Patient', 'Totals','Practice Unapplied') and ac.ClientID = @ClientID AND                       
		ac.ReportYear = @ReportYear and ac.ReportMonth = @ReportMonth AND ProviderName='All Provider'                      
		GROUP BY ac.ClientID,ac.ReportYear,AC.ReportMonth,ac.ProviderName                      
		/*Patient AR*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)                      
		SELECT ClientID,ReportYear,AC.ReportMonth,'Aging-01'ReportName,ProviderName,'Patient AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],                      
		SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],                      
		SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]                      
		FROM PPMReport_AgingReport(NOLOCK)AC                      
		WHERE ATBCategory='Patient'AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ProviderName='All Provider'                      
		GROUP BY ClientID,ReportYear,AC.ReportMonth,ATBCategory,ProviderName                     
		/*Total AR = sum of Insurance AR & Patient AR*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)                      
		SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,ProviderName,'Total AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                      
		SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]                      
		FROM #TempTblAC GROUP BY ClientID,ReportYear,ReportMonth,ProviderName                      
		/*Total % AR*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)                      
		SELECT ClientID,ReportYear,ReportMonth,'Aging-01' ReportName, ProviderName,'Total%AR' ATBCategory                      
		,[0-30] = Round(CONVERT(FLOAT,[0-30]/NULLIF([CategoryBalance],0))*100,2)                       
		,[31-60] = Round(CONVERT(FLOAT,[31-60]/NULLIF([CategoryBalance],0))*100,2)                       
		,[61-90] = Round(CONVERT(FLOAT,[61-90]/NULLIF([CategoryBalance],0))*100,2)                       
		,[91-120] = Round(CONVERT(FLOAT,[91-120]/NULLIF([CategoryBalance],0))*100,2)                       
		,[121-150] = Round(CONVERT(FLOAT,[121-150]/NULLIF([CategoryBalance],0))*100,2)                       
		,[151-180] = Round(CONVERT(FLOAT,[151-180]/NULLIF([CategoryBalance],0))*100,2)                       
		,[181+] = Round(CONVERT(FLOAT,[181+]/NULLIF([CategoryBalance],0))*100,2)                      
		,[CategoryBalance] = Round(CONVERT(FLOAT,[CategoryBalance]/NULLIF([CategoryBalance],0))*100,2)                      
		FROM #TempTblAC WHERE ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'                      
		UPDATE #TempTblAC set DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'),                      
		ShortName = ProviderName          
		--(CASE WHEN ProviderName LIKE '%, %' THEN LEFT(ProviderName,(LEN(ProviderName)-                      
		--Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))ELSE ProviderName END)                     
		/*Chg Ins %*/                  
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)                      
		select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Ins %' ATBCategory                      
		,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)                       
		,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)                      
		,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),                      
		CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,                      
		cChg.ProviderName AS ShortName           
		--CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-                      
		--Len(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName                      
		FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)                       
		WHERE ClientID=@ClientID AND ATBCategory = 'Insurance AR' AND  ReportName = 'Aging-01'                       
		AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg                 
		ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName                      
		WHERE cChg.ATBCategory = 'Insurance AR' AND  cChg.ReportName = 'Aging-01'                      
		/*Chg Pat %*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)                      
		select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Pat %' ATBCategory                      
		,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)                       
		,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)                      
		,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),                      
		CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,                      
		cChg.ProviderName AS ShortName          
		--CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-                      
		--LEN(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName                      
		FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)                       
		WHERE ClientID=@ClientID AND ATBCategory = 'Patient AR' AND  ReportName = 'Aging-01'                       
		AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg                      
		ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName                
		WHERE cChg.ATBCategory = 'Patient AR' AND  cChg.ReportName = 'Aging-01'                      
		/*Chg Pat %*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)                      
		select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Total Chg %' ATBCategory                      
		,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)                       
		,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)                      
		,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),                      
		CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,                      
		cChg.ProviderName AS ShortName          
		--CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-                      
		--LEN(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName                      
		FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)                       
		WHERE ClientID=@ClientID AND ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'               AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg                      
		ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName                      
		WHERE cChg.ATBCategory = 'Total AR' AND  cChg.ReportName = 'Aging-01'                      
		/*Aging-01 PPMReport AgingComparison*/                      
		INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],[CategoryBalance],DTID)                      
		SELECT ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID FROM #TempTblAC ORDER BY ShortName                       
		IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC                      
		END                      
		/*Aging Comparison <---> Page 49 - 59*/                      
		IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                       
		WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02')<=0                      
		BEGIN                      
		INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],                      
		[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)                      
		SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,tb.ProviderName, tb.ProviderName AS ShortName,          
		--CASE WHEN tb.ProviderName LIKE '%, %' THEN                       
		--LEFT(tb.ProviderName,(LEN(tb.ProviderName)-Len(SUBSTRING(tb.ProviderName,CHARINDEX(', ',tb.ProviderName),LEN(tb.ProviderName)))))                      
		--ELSE tb.ProviderName END AS ShortName,          
		ATBCategory,                      
		SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],                      
		SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]                      
		,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM([CategoryBalance]) /NULLIF(ISNULL(rf.AccountsReceivable,0),0))*100,2),0)                      
		,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)                      
		,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid                      
		FROM PPMReport_AgingReport(NOLOCK) tb                       
		LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable FROM PPMReport_Rollforward(NOLOCK)                       
		WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear)rf                      
		ON tb.ProviderName = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                      
		WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth                      
		GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.ProviderName,tb.ATBCategory,rf.AccountsReceivable                      
		END                      
                      
                      
		/*Procedure Count <---> Page 60 - 79*/                      
		--DECLARE @ClientID INT = 1                      
		--DECLARE @ReportYear INT = 2017                      
		--DECLARE @ReportMonth INT = 4                      
		IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                      
		BEGIN                      
		/*All Provider*/                      
		INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,CPT,CPTDescription,UNITS)                      
		SELECT ClientID,dp.ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,CPTGroupDesc,CPT,CPTDescription,SUM(Units)UNITS                     
		FROM PPMReport_DOPQuery(NOLOCK) DP WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth                      
		GROUP BY ClientID,dp.ReportYear,ReportMonth,CPTGroupDesc,CPT,CPTDescription HAVING SUM(Units)>0 ORDER BY 2,3,4,5                      
		/*Individual Provider*/                      
		INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,CPT,CPTDescription,UNITS)                      
		SELECT ClientID,dp.ReportYear,ReportMonth,ClaimProvider,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		CPTGroupDesc,CPT,CPTDescription,SUM(Units)UNITS                      
		FROM PPMReport_DOPQuery(NOLOCK) DP WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth                      
		GROUP BY ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPTGroupDesc,CPT,CPTDescription HAVING SUM(Units)>0 ORDER BY 2,3,4,5                      
		END                      
                      
                      
		--DECLARE @ClientID INT = 1                      
		--DECLARE @ReportYear INT = 2017                      
		--DECLARE @ReportMonth INT = 4                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU001') IS NOT NULL DROP TABLE #TempTblWorkwRVU001                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU002') IS NOT NULL DROP TABLE #TempTblWorkwRVU002                      
		IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                      
		BEGIN                      
		/*Work wRVU All Provider*/                      
		SELECT ClientID,dp.ReportYear,ReportMonth,CPT,dp.CPTDescription, SUM(Units)UNITS,wRVU               
		INTO #TempTblWorkwRVU001 FROM PPMReport_DOPQuery(NOLOCK) DP                      
		LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=DP.CPT AND rv.ReportYear=DP.ReportYear                       
		AND RV.Modifier IS NULL /*and dp.CPTDescription = rv.CPTDescription*/                      
		WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY ClientID,dp.ReportYear,ReportMonth,CPT,dp.CPTDescription,wRVU HAVING SUM(Units)>0                      
		INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)                      
		SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,                      
		CPT,CPTDescription,UNITS,wRVU,(CONVERT(DECIMAL (18, 2),ISNULL(wRVU,0))*Units)RVU FROM #TempTblWorkwRVU001                      
		/*Work wRVU individual Provider*/                      
		SELECT ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPT,dp.CPTDescription, SUM(Units)UNITS,wRVU                      
		INTO #TempTblWorkwRVU002 FROM PPMReport_DOPQuery(NOLOCK) DP                      
		LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=DP.CPT AND rv.ReportYear=DP.ReportYear                       
		AND RV.Modifier IS NULL /*and dp.CPTDescription = rv.CPTDescription*/                      
		WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPT,dp.CPTDescription,wRVU HAVING SUM(Units)>0                      
		INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)                      
		SELECT ClientID,ReportYear,ReportMonth,ClaimProvider,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		CPT,CPTDescription,UNITS,wRVU,(CONVERT(DECIMAL (18, 2),ISNULL(wRVU,0))*Units)RVU FROM #TempTblWorkwRVU002                      
		END                      
		COMMIT TRANSACTION                       
		SET @ErrorMessage = 'Sucess'                       
		END TRY                                  

		BEGIN CATCH                                  
		ROLLBACK TRANSACTION                        
		SET @ErrorMessage = ERROR_MESSAGE()                            
		END CATCH                       
		SET @Output = CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage                      
	END 
	ELSE
	BEGIN
		SET @Output = CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ 'No Client'
	END
END
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_EBMBIData]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_EBMBIData]        
(@cId int, @Year int, @month int,@Output VARCHAR(MAX) OUTPUT)        
AS        
BEGIN        
DECLARE @ErrorMessage VARCHAR(MAX)        
/*Page 2 to 12*/        
BEGIN TRY         
BEGIN TRANSACTION        
DECLARE @ClientID INT = @cId        
DECLARE @ReportYear INT = @Year        
DECLARE @ReportMonth INT = @month        
DECLARE @RWCount INT=0        
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12        
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays        
if (SELECT Count(*) FROM PPMReport_Rollforward(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)<=0        
BEGIN        
CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),        
Charges DECIMAL (18, 2),NetPayments DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),        
UnappliedPayments DECIMAL (18, 2),AccountsReceivable DECIMAL (18, 2),AROver120 DECIMAL (18, 2),ARDaysOutstanding DECIMAL (18, 2),        
UnappliedBalance DECIMAL (18, 2),DTID DATE)        
/*UPDATE IN TEMP TABLE*/        
INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)        
SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider ProviderName,        
CASE WHEN ClaimProvider LIKE '%, %' THEN         
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))        
ELSE ClaimProvider END AS ShortName,        
SUM(ISNULL(Charges,0))Charges,SUM(ISNULL(Payments,0))Payments,SUM(ISNULL(Refunds,0))Refunds,SUM(ISNULL(Adjustments,0))Adjustments,        
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID FROM PPMReport_DOPQuery(NOLOCK)DP        
WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth        
GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider        
/*Update All Provider for Charges,Payments,Refunds,Adjustments*/        
INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)        
SELECT ClientID,ReportYear,ReportMonth, 'All Provider'ProviderName,'All Provider'ShortName,        
SUM(ISNULL(Charges,0))Charges,SUM(ISNULL(Payments,0))Payments,SUM(ISNULL(Refunds,0))Refunds,SUM(ISNULL(Adjustments,0))Adjustments,        
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID FROM #TempTblpg1to12         
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth=@ReportMonth        
GROUP BY ClientID,ReportYear,ReportMonth        
/*Update All Provider for UnappliedPayments*/        
UPDATE UA SET UA.UnappliedPayments = a.UnappliedPayments                                            
FROM (SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(NetPayments,0))UnappliedPayments         
FROM PPMReport_Charge(NOLOCK)         
WHERE ProviderName='Practice Unapplied' AND ClientID =@ClientID AND ReportYear = @ReportYear and ReportMonth=@ReportMonth        
GROUP BY  ClientID,ReportYear,ReportMonth) a                                                
INNER JOIN #TempTblpg1to12 UA         
ON UA.ClientID = a.ClientID AND UA.ReportYear = a.ReportYear AND UA.ReportMonth = a.ReportMonth AND UA.ProviderName = a.ProviderName        
/*Update All Provider for UnappliedBalance*/        
UPDATE UB SET UB.UnappliedBalance = aa.UnappliedBalance                                            
FROM (SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(CategoryBalance,0)) UnappliedBalance         
FROM PPMReport_AgingReport(NOLOCK)        
WHERE  ProviderName = 'All Provider' AND ATBCategory = 'Practice Unapplied' AND ClientID =@ClientID AND ReportYear = @ReportYear        
AND ReportMonth=@ReportMonth GROUP BY  ClientID,ReportYear,ReportMonth) aa        
INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear         
AND UB.ReportMonth = aa.ReportMonth AND UB.ProviderName = aa.ProviderName        
/*Update All Provider for AccountsReceivable*/        
UPDATE UB SET UB.AccountsReceivable = aa.AccountsReceivable                                      
FROM (SELECT ClientID,ReportYear,ReportMonth,ProviderName,        
CASE WHEN ProviderName LIKE '%, %' THEN         
LEFT(ProviderName,(LEN(ProviderName)-Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))        
ELSE ProviderName END AS ShortName,SUM(ISNULL(CategoryBalance,0))AccountsReceivable        
FROM PPMReport_AgingReport(NOLOCK) WHERE ATBCategory='Totals'        
AND ClientID =@ClientID AND ReportYear = @ReportYear AND ReportMonth=@ReportMonth GROUP BY ClientID,ReportYear,ReportMonth,ProviderName) aa        
INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear         
AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName        
/*Update All Provider for AROver120*/        
UPDATE UB SET UB.AROver120 = aa.AROver120                                           
FROM (SELECT ClientID,ReportYear,ReportMonth,ProviderName,        
CASE WHEN ProviderName LIKE '%, %' THEN         
LEFT(ProviderName,(LEN(ProviderName)-Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))        
ELSE ProviderName END AS ShortName,SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120         
FROM PPMReport_AgingReport(NOLOCK) WHERE ATBCategory NOT IN ('Totals','Practice Unapplied')        
AND ClientID =@ClientID AND ReportYear = @ReportYear AND ReportMonth=@ReportMonth GROUP BY ClientID,ReportYear,ReportMonth,ProviderName) aa        
INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear         
AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName        
/*Update netpayments, accountreceivable with calculation*/        
UPDATE UB SET UB.NetPayments = aa.NetPayments, ub.AccountsReceivable = aa.AccountsReceivable        
FROM(SELECT ClientID,ReportYear,ReportMonth,ShortName,        
/*ISNULL(SUM(ABS(ISNULL(Payments,0))-ABS(ISNULL(Refunds,0))-ABS(ISNULL(UnappliedPayments,0))),0)NetPayments,*/        
ABS(SUM(((ISNULL(Payments,0)*-1)+(ISNULL(Refunds,0)*-1))+(ISNULL(UnappliedPayments,0)*-1)))NetPayments        
,ISNULL(SUM(ISNULL(AccountsReceivable,0)-ISNULL(UnappliedBalance,0)),0)AccountsReceivable        
FROM #TempTblpg1to12 GROUP BY ClientID,ReportYear,ReportMonth,ShortName) aa        
INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear         
AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName        
/*ARDaysOutstanding*/        
SELECT ClientID,ReportMonth,ReportYear,ShortName,Charges,DTID        
INTO #TempTblpg1to12ARDays FROM PPMReport_Rollforward(NOLOCK) WHERE ClientID = @ClientID AND        
DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and         
DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')        
SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1        
IF @RWCount = 1        
BEGIN        
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays           
FROM(SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((isnull(Charges,0)/(30)),0),0),0)ARDays         
FROM #TempTblpg1to12 WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear        
GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges)AR        
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND         
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName        
END        
ELSE        
BEGIN        
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays        
FROM(SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,        
ISNULL(NULLIF(ISNULL(ABS(isnull(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays        
FROM #TempTblpg1to12 AA LEFT JOIN (SELECT ClientID,ShortName,SUM(ISNULL(Charges,0))Charges FROM #TempTblpg1to12ARDays         
GROUP BY  ClientID,ShortName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName=bb.ShortName        
WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear        
GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable)AR        
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND         
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName        
END        
/*Final Data moved to PPMReport_Rollforward table*/        
INSERT INTO PPMReport_Rollforward(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,        
Payments,Refunds,Adjustments,UnappliedPayments,AccountsReceivable,AROver120,ARDaysOutstanding,UnappliedBalance,DTID)        
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,        
NetPayments,Refunds,ABS(ISNULL(Adjustments,0))Adjustments,ISNULL(UnappliedPayments,0)UnappliedPayments,AccountsReceivable,        
AROver120,ARDaysOutstanding,ISNULL(UnappliedBalance,0)UnappliedBalance,DTID FROM #TempTblpg1to12 ORDER BY ShortName        
/*Yearly Compare*/        
INSERT INTO PPMReport_Rollforward_YrlyCompare(ClientID,ReportYear,ReportMonth,ShortName,YrlyCharges,        
YrlyPayments,YrlyRefunds,YrlyAdjustments,YrlyUnappliedPayments,YrlyAccountsReceivable,YrlyAROver120,        
YrlyARDaysOutstanding,YrlyUnappliedBalance)        
SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ShortName,         
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,        
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,        
CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,        
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,        
CONVERT(FLOAT,ISNULL(SUM(CY.UnappliedPayments-PY.UnappliedPayments)/NULLIF(ISNULL(SUM(PY.UnappliedPayments),0),0),0))*100 YrlyUnappliedPayments,        
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,        
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,        
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,        
CONVERT(FLOAT,ISNULL(SUM(CY.UnappliedBalance-PY.UnappliedBalance)/NULLIF(ISNULL(SUM(PY.UnappliedBalance),0),0),0))*100 YrlyUnappliedBalance        
FROM PPMReport_Rollforward(NOLOCK)CY LEFT JOIN (SELECT * FROM PPMReport_Rollforward(NOLOCK)         
WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY         
ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ShortName=PY.ShortName        
WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth        
GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ShortName         
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12        
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays        
END        
        
        
/*Page 13 to 22*/        
--DECLARE @ClientID INT = 1        
--DECLARE @ReportYear INT = 2017        
--DECLARE @ReportMonth INT = 2        
IF OBJECT_ID('tempdb..#TempTblpg13to22') IS NOT NULL DROP TABLE #TempTblpg13to22        
IF OBJECT_ID('tempdb..#TempTblFD01') IS NOT NULL DROP TABLE #TempTblFD01        
IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01        
IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02        
IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0        
BEGIN        
CREATE TABLE #TempTblpg13to22(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),        
ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2))        
/*GET Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,UnappliedPayments,AccountsReceivable*/        
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, ReportName, TotalCount INTO #TempTblFD01        
FROM (SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,        
UnappliedPayments,AccountsReceivable FROM PPMReport_Rollforward(NOLOCK)        
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth) PVT        
UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,UnappliedPayments,AccountsReceivable))AS unpvt;        
UPDATE #TempTblFD01 SET ReportName = 'Gross Charges' WHERE ReportName = 'Charges'        
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)        
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount FROM #TempTblFD01        
/*Update Cleargage*/        
UPDATE UB SET UB.ClearGage = aa.Credit                                            
FROM (SELECT cc.ClientID,cc.ReportMonth,cc.ReportYear,cc.ProviderName,cg.Credit        
FROM PPMReport_ClearGage_Collection(NOLOCK)cc        
LEFT JOIN PPMReport_ClientList(Nolock)cl on cc.ClientID=cl.ID        
LEFT JOIN PPMReport_ClearGage(nolock)cg         
ON cl.Client = cg.PPMMerchantAccount and cc.ReportYear=cg.ReportYear and cc.ReportMonth=cg.ReportMonth        
WHERE cc.ClientID=@ClientID and cc.ReportMonth = @ReportMonth and cc.ReportYear = @ReportYear) aa        
INNER JOIN PPMReport_ClearGage_Collection UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear         
AND UB.ReportMonth = aa.ReportMonth AND UB.ProviderName = aa.ProviderName        
/*Get ClearGage, Collections*/        
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)        
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, ReportName, TotalCount FROM         
(SELECT  ClientID,ReportYear,ReportMonth,ProviderName,'All Provider'ShortName, ISNULL(ClearGage,0)ClearGage,ISNULL(Collections,0)Collections         
FROM PPMReport_ClearGage_Collection(NOLOCK)        
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth) PVT        
UNPIVOT (TotalCount FOR ReportName IN (ClearGage, Collections))AS unpvt;        
/*Get all provider EncounterAnalysis*/        
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,TotalCount,ReportName)        
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ClaimProvider,'All Provider'ShortName,        
CPTGroupDesc,SUM(ISNULL(Units,0))TotalCount,'EncounterAnalysis'ReportName FROM PPMReport_DOPQuery(NOLOCK)        
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL         
AND CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/        
GROUP BY ClientID,ReportYear,ReportMonth,CPTGroupDesc HAVING SUM(ISNULL(Units,0))>0 ORDER BY CPTGroupDesc ASC        
/*Get Individual Provider EncounterAnalysis*/        
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,TotalCount,ReportName)        
SELECT ClientID,ReportYear,ReportMonth,ClaimProvider,CASE WHEN ClaimProvider LIKE '%, %' THEN         
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))        
ELSE ClaimProvider END AS ShortName,CPTGroupDesc,SUM(ISNULL(Units,0))TotalCount,'EncounterAnalysis'ReportName        
FROM PPMReport_DOPQuery(NOLOCK) WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND         
ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL AND CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/        
GROUP BY ClientID,ReportYear,ReportMonth,ClaimProvider,CPTGroupDesc HAVING SUM(ISNULL(Units,0))>0 ORDER BY ClaimProvider ASC        
/*CPT Counts All Provider*/        
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)        
SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,        
'CPT Counts'ReportName,SUM(ISNULL(Units,0))Units FROM PPMReport_DOPQuery(NOLOCK)DP        
WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL         
AND Dp.CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/        
GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth        
ORDER BY ProviderName,ReportYear,ReportMonth ASC        
/*CPT Counts Individual Provider*/        
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)        
SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider ProviderName,CASE WHEN ClaimProvider LIKE '%, %' THEN         
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))        
ELSE ClaimProvider END AS ShortName,'CPT Counts'ReportName,SUM(ISNULL(Units,0))Units        
FROM PPMReport_DOPQuery(NOLOCK)DP        
WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL         
AND Dp.CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/        
GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider HAVING SUM(ISNULL(Units,0))>0        
ORDER BY ProviderName,ReportYear,ReportMonth ASC        
/*Work wRVU All Provider*/        
SELECT ClientID,dp.ReportYear,ReportMonth,CPT,SUM(Units)UNITS        
INTO #TempTblWorkwRVU01 FROM PPMReport_DOPQuery(NOLOCK) DP        
WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth        
GROUP BY ClientID,dp.ReportYear,ReportMonth,CPT        
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)        
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,'Work wRVU'ReportName,        
SUM(wRVUu)wRVU FROM        
(SELECT ClientID,rv.ReportYear,ReportMonth,CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu        
FROM #TempTblWorkwRVU01(NOLOCK)cp        
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL         
GROUP BY ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units)aa        
GROUP BY ClientID,ReportYear,ReportMonth        
/*Work wRVU Individual Provider*/        
SELECT ClientID,dp.ReportYear,ReportMonth,CPT,SUM(Units)UNITS,ClaimProvider        
INTO #TempTblWorkwRVU02 FROM PPMReport_DOPQuery(NOLOCK) DP        
WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth        
GROUP BY ClientID,dp.ReportYear,ReportMonth,CPT,ClaimProvider        
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)        
SELECT ClientID,ReportYear,ReportMonth,ClaimProvider ProviderName,ShortName,'Work wRVU'ReportName,        
SUM(wRVUu)wRVU FROM        
(SELECT ClientID,rv.ReportYear,ReportMonth,ClaimProvider,CASE WHEN ClaimProvider LIKE '%, %' THEN         
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))        
ELSE ClaimProvider END AS ShortName,CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu        
FROM #TempTblWorkwRVU02(NOLOCK)cp        
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL         
GROUP BY ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units,ClaimProvider)aa        
GROUP BY ClientID,ReportYear,ReportMonth,ClaimProvider,ShortName        
ORDER BY ReportYear,ReportMonth,ShortName        
        
/*Update to Financial dashboard*/        
INSERT INTO PPMReport_FinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)        
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount FROM #TempTblpg13to22        
IF OBJECT_ID('tempdb..#TempTblpg13to22') IS NOT NULL DROP TABLE #TempTblpg13to22        
IF OBJECT_ID('tempdb..#TempTblFD01') IS NOT NULL DROP TABLE #TempTblFD01        
IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01        
IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02        
END        
        
        
/*Payer Mix <---> Page 26 - 45*/        
--DECLARE @ClientID INT = 1        
--DECLARE @ReportYear INT = 2017        
--DECLARE @ReportMonth INT = 4        
if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0        
BEGIN        
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)        
SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,        
InsuranceType,SUM(ISNULL(Charges,0))Charges,SUM(Payments)Payments ,SUM(Refunds) Refunds        
FROM PPMReport_DOPQuery(NOLOCK)DP        
WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth        
GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,InsuranceType        
/*ORDER BY DP.ClientID,DP.ReportYear,DP.ReportMonth,dp.InsuranceType*/        
UNION        
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,'UnappliedPayments'InsuranceType,0.00 charges,        
UnappliedPayments Payments,0.00 Refunds FROM PPMReport_Rollforward(nolock)         
WHERE ReportMonth=@ReportMonth and ReportYear=@ReportYear AND ClientID=@ClientID AND ProviderName = 'All Provider'        
        
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)        
SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider,CASE WHEN ClaimProvider LIKE '%, %' THEN         
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))        
ELSE ClaimProvider END AS ShortName,InsuranceType,SUM(ISNULL(Charges,0))Charges,        
SUM(Payments)Payments ,SUM(Refunds) Refunds FROM PPMReport_DOPQuery(NOLOCK)DP        
WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth        
GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider,InsuranceType        
ORDER BY DP.ClientID,DP.ReportYear,DP.ReportMonth,DP.ClaimProvider,dp.InsuranceType        
END        
        
/*Aging Comparison <---> Page 47 - 48*/        
--DECLARE @ClientID INT = 1        
--DECLARE @ReportYear INT = 2017        
--DECLARE @ReportMonth INT = 4        
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC        
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)         
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01')<=0        
BEGIN        
CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),        
[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),        
[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE,ShortName varchar(100))        
/*Insurance AR*/        
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)        
SELECT ac.ClientID,ac.ReportYear,AC.ReportMonth,'Aging-01'ReportName,ac.ProviderName,'Insurance AR' ATBCategory,        
SUM(ISNULL(ac.[0-30],0))[0-30],SUM(ISNULL(ac.[31-60],0))[31-60],SUM(ISNULL(ac.[61-90],0))[61-90],SUM(ISNULL(ac.[91-120],0))[91-120],        
SUM(ISNULL(ac.[121-150],0))[121-150],SUM(ISNULL(ac.[151-180],0))[151-180],SUM(ISNULL(ac.[181+],0))[181+],        
SUM(ISNULL(ac.[CategoryBalance],0))[CategoryBalance]  FROM PPMReport_AgingReport(NOLOCK) AC        
WHERE ATBCategory NOT IN('Patient', 'Totals','Practice Unapplied') and ac.ClientID = @ClientID AND         
ac.ReportYear = @ReportYear and ac.ReportMonth = @ReportMonth AND ProviderName='All Provider'        
GROUP BY ac.ClientID,ac.ReportYear,AC.ReportMonth,ac.ProviderName       
/*Patient AR*/        
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)        
SELECT ClientID,ReportYear,AC.ReportMonth,'Aging-01'ReportName,ProviderName,'Patient AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],        
SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],        
SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]        
FROM PPMReport_AgingReport(NOLOCK)AC        
WHERE ATBCategory='Patient'AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ProviderName='All Provider'        
GROUP BY ClientID,ReportYear,AC.ReportMonth,ATBCategory,ProviderName        
/*Total AR = sum of Insurance AR & Patient AR*/        
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)        
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,ProviderName,'Total AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],        
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]        
FROM #TempTblAC GROUP BY ClientID,ReportYear,ReportMonth,ProviderName        
/*Total % AR*/        
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)        
SELECT ClientID,ReportYear,ReportMonth,'Aging-01' ReportName, ProviderName,'Total%AR' ATBCategory        
,[0-30] = Round(CONVERT(FLOAT,[0-30]/NULLIF([CategoryBalance],0))*100,2)         
,[31-60] = Round(CONVERT(FLOAT,[31-60]/NULLIF([CategoryBalance],0))*100,2)         
,[61-90] = Round(CONVERT(FLOAT,[61-90]/NULLIF([CategoryBalance],0))*100,2)         
,[91-120] = Round(CONVERT(FLOAT,[91-120]/NULLIF([CategoryBalance],0))*100,2)         
,[121-150] = Round(CONVERT(FLOAT,[121-150]/NULLIF([CategoryBalance],0))*100,2)         
,[151-180] = Round(CONVERT(FLOAT,[151-180]/NULLIF([CategoryBalance],0))*100,2)         
,[181+] = Round(CONVERT(FLOAT,[181+]/NULLIF([CategoryBalance],0))*100,2)        
,[CategoryBalance] = Round(CONVERT(FLOAT,[CategoryBalance]/NULLIF([CategoryBalance],0))*100,2)        
FROM #TempTblAC WHERE ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'        
UPDATE #TempTblAC set DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'),        
ShortName = (CASE WHEN ProviderName LIKE '%, %' THEN LEFT(ProviderName,(LEN(ProviderName)-        
Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))ELSE ProviderName END)        
/*Chg Ins %*/        
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)        
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Ins %' ATBCategory        
,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)         
,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)        
,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),        
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,        
CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-        
Len(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName        
FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)         
WHERE ClientID=@ClientID AND ATBCategory = 'Insurance AR' AND  ReportName = 'Aging-01'         
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg        
ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName        
WHERE cChg.ATBCategory = 'Insurance AR' AND  cChg.ReportName = 'Aging-01'        
/*Chg Pat %*/        
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)        
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Pat %' ATBCategory        
,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)         
,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)        
,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),        
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,        
CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-        
LEN(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName        
FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)         
WHERE ClientID=@ClientID AND ATBCategory = 'Patient AR' AND  ReportName = 'Aging-01'         
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg        
ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName        
WHERE cChg.ATBCategory = 'Patient AR' AND  cChg.ReportName = 'Aging-01'        
/*Chg Pat %*/        
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)        
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Total Chg %' ATBCategory        
,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)         
,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)         
,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)        
,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),        
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,        
CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-        
LEN(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName        
FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)         
WHERE ClientID=@ClientID AND ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'         
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg    ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName        
WHERE cChg.ATBCategory = 'Total AR' AND  cChg.ReportName = 'Aging-01'        
/*Aging-01 PPMReport AgingComparison*/        
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],[CategoryBalance],DTID)        
SELECT ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID FROM #TempTblAC ORDER BY ShortName         
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC        
END        
/*Aging Comparison <---> Page 49 - 59*/        
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)         
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02')<=0        
BEGIN        
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],        
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)        
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,tb.ProviderName,CASE WHEN tb.ProviderName LIKE '%, %' THEN         
LEFT(tb.ProviderName,(LEN(tb.ProviderName)-Len(SUBSTRING(tb.ProviderName,CHARINDEX(', ',tb.ProviderName),LEN(tb.ProviderName)))))        
ELSE tb.ProviderName END AS ShortName,ATBCategory,        
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],        
SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]        
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM([CategoryBalance]) /NULLIF(ISNULL(rf.AccountsReceivable,0),0))*100,2),0)        
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)        
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid        
FROM PPMReport_AgingReport(NOLOCK) tb         
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable FROM PPMReport_Rollforward(NOLOCK)         
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear)rf        
ON tb.ProviderName = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth        
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth        
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.ProviderName,tb.ATBCategory,rf.AccountsReceivable        
END        
        
        
/*Procedure Count <---> Page 60 - 79*/        
--DECLARE @ClientID INT = 1        
--DECLARE @ReportYear INT = 2017        
--DECLARE @ReportMonth INT = 4        
IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0        
BEGIN        
/*All Provider*/        
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,CPT,CPTDescription,UNITS)        
SELECT ClientID,dp.ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,CPTGroupDesc,CPT,CPTDescription,SUM(Units)UNITS        
FROM PPMReport_DOPQuery(NOLOCK) DP WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth        
GROUP BY ClientID,dp.ReportYear,ReportMonth,CPTGroupDesc,CPT,CPTDescription HAVING SUM(Units)>0 ORDER BY 2,3,4,5        
/*Individual Provider*/        
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,CPT,CPTDescription,UNITS)        
SELECT ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CASE WHEN ClaimProvider LIKE '%, %' THEN         
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))        
ELSE ClaimProvider END AS ShortName,CPTGroupDesc,CPT,CPTDescription,SUM(Units)UNITS        
FROM PPMReport_DOPQuery(NOLOCK) DP WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth    GROUP BY ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPTGroupDesc,CPT,CPTDescription HAVING SUM(Units)>0 ORDER BY 2,3,4,
  
    
5        
END        
        
        
--DECLARE @ClientID INT = 1        
--DECLARE @ReportYear INT = 2017        
--DECLARE @ReportMonth INT = 4        
IF OBJECT_ID('tempdb..#TempTblWorkwRVU001') IS NOT NULL DROP TABLE #TempTblWorkwRVU001        
IF OBJECT_ID('tempdb..#TempTblWorkwRVU002') IS NOT NULL DROP TABLE #TempTblWorkwRVU002        
IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0        
BEGIN        
/*Work wRVU All Provider*/        
SELECT ClientID,dp.ReportYear,ReportMonth,CPT,dp.CPTDescription, SUM(Units)UNITS,wRVU        
INTO #TempTblWorkwRVU001 FROM PPMReport_DOPQuery(NOLOCK) DP        
LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=DP.CPT AND rv.ReportYear=DP.ReportYear         
AND RV.Modifier IS NULL /*and dp.CPTDescription = rv.CPTDescription*/        
WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth        
GROUP BY ClientID,dp.ReportYear,ReportMonth,CPT,dp.CPTDescription,wRVU HAVING SUM(Units)>0        
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)        
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,        
CPT,CPTDescription,UNITS,wRVU,(CONVERT(DECIMAL (18, 2),ISNULL(wRVU,0))*Units)RVU FROM #TempTblWorkwRVU001        
/*Work wRVU individual Provider*/        
SELECT ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPT,dp.CPTDescription, SUM(Units)UNITS,wRVU        
INTO #TempTblWorkwRVU002 FROM PPMReport_DOPQuery(NOLOCK) DP        
LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=DP.CPT AND rv.ReportYear=DP.ReportYear         
AND RV.Modifier IS NULL /*and dp.CPTDescription = rv.CPTDescription*/        
WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth        
GROUP BY ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPT,dp.CPTDescription,wRVU HAVING SUM(Units)>0        
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)        
SELECT ClientID,ReportYear,ReportMonth,ClaimProvider,CASE WHEN ClaimProvider LIKE '%, %' THEN         
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))        
ELSE ClaimProvider END AS ShortName,CPT,CPTDescription,UNITS,wRVU,(CONVERT(DECIMAL (18, 2),ISNULL(wRVU,0))*Units)RVU FROM #TempTblWorkwRVU002        
END        
COMMIT TRANSACTION         
SET @ErrorMessage = 'Sucess'         
END TRY                    
                              
BEGIN CATCH                    
ROLLBACK TRANSACTION          
SET @ErrorMessage = ERROR_MESSAGE()              
END CATCH         
SET @Output = CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage        
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECW_BIData]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECW_BIData]  
(@cId int, @Year int, @month int,@Output VARCHAR(MAX) OUTPUT)      
AS      
BEGIN      
	DECLARE @ErrorMessage VARCHAR(MAX)      
      
	BEGIN TRY               
	BEGIN TRANSACTION              
	DECLARE @ClientID INT = @cId              
	DECLARE @ReportYear INT = @Year              
	DECLARE @ReportMonth INT = @month              
	DECLARE @RWCount INT=0    
	DECLARE @providerList INT = 0    
    
	/*Validate Provider name list*/    
	if (SELECT COUNT(ClientID) FROM PPMReport_ECW_ProviderNameList(NOLOCK) WHERE ClientID = @ClientID AND IsActive = 1) > 0    
	 BEGIN    
	  SET @providerList = (SELECT COUNT(ClientID) FROM PPMReport_ECW_ProviderNameList(NOLOCK) WHERE ClientID = @ClientID AND IsActive = 1)    
	 END    
	ELSE    
	 BEGIN    
	  SET @providerList = 0    
	 END    
       
	/*Backup Old Name in charge*/      
	UPDATE XL SET XL.XLName = A.EOMName                
	FROM(                
	SELECT ch.id, pn.ClientID,EOMName,DOPName                
	FROM PPMReport_MatchProviderName(NOLOCK)PN                
	INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH      
	ON PN.ClientID = CH.ClientID AND PN.EOMName = CH.AppointmentProvider               
	WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2      
	GROUP BY CH.ID, pn.ClientID,EOMName,DOPName                
	)A                
	INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName                
	WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
	/*Update Provider name as DOP Name in Charge*/      
	UPDATE XL SET XL.AppointmentProvider = A.DOPName                
	FROM(                
	SELECT ch.id, pn.ClientID,EOMName,DOPName                
	FROM PPMReport_MatchProviderName(NOLOCK)PN                
	INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH                
	ON PN.ClientID = CH.ClientID AND PN.EOMName = CH.AppointmentProvider                
	WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2               
	GROUP BY CH.ID, pn.ClientID,EOMName,DOPName                
	)A                
	INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName                
	WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear          
                
	---------------------------------------------------      
      
	/*-----<<<Start FinancialAnalysis>>>-----*/      
	if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0      
	BEGIN      
	IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12      
	IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment      
	IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays      
      
	CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),      
	Charges DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),      
	AccountsReceivable DECIMAL (18, 2)DEFAULT 0,AROver120 DECIMAL (18, 2)DEFAULT 0,      
	ARDaysOutstanding DECIMAL (18, 2)DEFAULT 0,Unapplied DECIMAL (18, 2)DEFAULT 0,      
	ClearGage  DECIMAL (18, 2)DEFAULT 0,Collections  DECIMAL (18, 2)DEFAULT 0,DTID DATE)      
      
	CREATE TABLE #TempTblPayment(ClientID INT,ReportYear INT,ReportMonth INT,AppointmentProvider VARCHAR(300),      
	Charges DECIMAL (18, 2),Payment DECIMAL (18, 2),Refund DECIMAL (18, 2),Amount DECIMAL (18, 2),Contractual DECIMAL (18, 2),      
	InsuranceWithheld DECIMAL (18, 2),WriteoffAdjustment DECIMAL (18, 2))      
      
	/*All Provider == Charges,Payment,Refund , without pay amt, Adjustments */      
	INSERT INTO #TempTblPayment    
	SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.BilledCharge,0)Charge,        
	ISNULL(AR.Payment,0)Payment,ISNULL(AR.Refund,0)Refund,ISNULL(WC.Amount,0)Amount,        
	ISNULL(AR.Contractual,0)Contractual,ISNULL(AR.InsuranceWithheld,0)InsuranceWithheld,ISNULL(AR.WriteoffAdjustment,0)WriteoffAdjustment        
	FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR        
	LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear         
	AND WC.ReportMonth = @ReportMonth AND (WC.PaymentDate = 'Summary'OR WC.AppointmentProvider is null)    
	WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary')        
	AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth      
     
	/*Individual provider == Charges,Payment,Refund , without pay amt, Adjustments*/    
	if @providerList > 0    
	 BEGIN      
	  INSERT INTO #TempTblPayment    
	  SELECT PMT.ClientID,PMT.ReportYear,PMT.ReportMonth,RTRIM(LTRIM(PMT.AppointmentProvider))AppointmentProvider,PMT.Charge,      
	  PMT.Payment,PMT.Refund,SUM(ISNULL(WC.Amount,0))Amount,      
	  PMT.Contractual,PMT.InsuranceWithheld,PMT.WriteoffAdjustment    
	  FROM(    
	  SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
	  SUM(ISNULL(AR.BilledCharge,0))Charge,      
	  SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund,     
	  SUM(ISNULL(AR.Contractual,0))Contractual,SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,    
	  SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment      
	  FROM PPMReport_ECW_ARBeginEnd(NOLOCK) AR    
	  INNER JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl     
	   ON nl.ClientID = @ClientID AND RTRIM(LTRIM(NL.ProviderName)) = RTRIM(LTRIM(AR.AppointmentProvider))    
	  WHERE AR.CLIENTID = @ClientID  AND AR.ReportMonth = @ReportMonth AND AR.ReportYear = @ReportYear    
	  AND (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary')   
	  AND nl.IsActive = 1  
	  GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))    
	  )PMT    
	  LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC     
	  ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth     
	  AND WC.AppointmentProvider = PMT.AppointmentProvider AND WC.AppointmentProvider IS NOT NULL    
	  GROUP BY PMT.ClientID,PMT.ReportYear,PMT.ReportMonth,RTRIM(LTRIM(PMT.AppointmentProvider)),    
	  PMT.Charge,PMT.Payment,PMT.Refund,PMT.Contractual,PMT.InsuranceWithheld,PMT.WriteoffAdjustment    
	 END    
	ELSE    
	 BEGIN    
	  INSERT INTO #TempTblPayment    
	  SELECT pmt.ClientID,pmt.ReportYear,pmt.ReportMonth,RTRIM(LTRIM(pmt.AppointmentProvider))AppointmentProvider,      
	  ISNULL(pmt.Charge,0)Charge,ISNULL(pmt.Payment,0)Payment,pmt.Refund,ISNULL(wAmt.Amount,0)Amount,      
	  ISNULL(pmt.Contractual,0)Contractual,ISNULL(pmt.InsuranceWithheld,0)InsuranceWithheld,ISNULL(pmt.WriteoffAdjustment,0)WriteoffAdjustment      
	  FROM(      
	  SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))AppointmentProvider,    
	  SUM(ISNULL(AR.BilledCharge,0))Charge,      
	  SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund,SUM(ISNULL(AR.Contractual,0))Contractual,      
	  SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment      
	  FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR      
	  WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary')      
	  AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth      
	  GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))      
	  )pmt      
	  LEFT JOIN (SELECT WC.ClientID,WC.ReportYear,WC.ReportMonth,RTRIM(LTRIM(WC.AppointmentProvider))AppointmentProvider,    
	  SUM(ISNULL(WC.Amount,0))Amount       
	  FROM PPMReport_ECW_WithoutClaims(NOLOCK)WC       
	  WHERE WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth       
	  AND WC.PaymentDate != 'Summary'      
	  GROUP BY WC.ClientID,WC.ReportYear,WC.ReportMonth,RTRIM(LTRIM(WC.AppointmentProvider)))wAmt       
	  ON wAmt.ClientID = pmt.ClientID AND wAmt.ReportYear = pmt.ReportYear AND wAmt.ReportMonth = pmt.ReportMonth      
	  AND wAmt.AppointmentProvider = pmt.AppointmentProvider    
	 END    
    
	/*insert in #TempTblpg1to12 table*/      
	INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)      
	SELECT ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
	SUM(Charges)Charges, SUM((Payment-Refund)+Amount)Payment,SUM(Refund)Refund,      
	SUM(Contractual+InsuranceWithheld+WriteoffAdjustment)Adjustments,      
	CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID      
	FROM #TempTblPayment      
	GROUP BY ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))      
      
	/*Update Accounts Receivable */      
	UPDATE ARA SET ARA.AccountsReceivable = ISNULL(A.TotalBalance,0),ARA.AROver120 = A.AROver120      
	FROM(      
	SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,SUM(ISNULL(AR.TotalBalance,0))TotalBalance,      
	SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120      
	FROM PPMReport_ECW_AgingReport(NOLOCK)AR      
	WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'AS'      
	AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth      
	GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth      
	UNION      
	SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))AppointmentProvider,    
	SUM(ISNULL(AR.TotalBalance,0))TotalBalance,  SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120      
	FROM PPMReport_ECW_AgingReport(NOLOCK)AR      
	WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary') AND ReportName = 'AS'      
	AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth      
	GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))      
	)A      
	INNER JOIN #TempTblpg1to12 ARA       
	ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth     
	AND RTRIM(LTRIM(ARA.ProviderName)) = RTRIM(LTRIM(a.AppointmentProvider))      
      
	/*ARDaysOutstanding*/                              
	SELECT ClientID,ReportMonth,ReportYear,ProviderName,Charges,DTID                              
	INTO #TempTblpg1to12ARDays FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)       
	WHERE ClientID = @ClientID AND                              
	DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                               
	DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')                              
	SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1      
	IF @RWCount = 1      
	 BEGIN      
	 UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                             
	 FROM(      
	 SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((ISNULL(Charges,0)/(30)),0),0),0)ARDays                               
	 FROM #TempTblpg1to12       
	 WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                              
	 GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges      
	 )AR           
	 INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                               
	 ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                              
	 END      
	ELSE      
	 BEGIN      
	 UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays      
	 FROM(      
	 SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,      
	 ISNULL(NULLIF(ISNULL(ABS(ISNULL(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays                              
	 FROM #TempTblpg1to12 AA       
	 LEFT JOIN (SELECT ClientID,ProviderName,SUM(ISNULL(Charges,0))Charges       
	 FROM #TempTblpg1to12ARDays                               
	 GROUP BY  ClientID,ProviderName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName = bb.ProviderName      
	 WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear                              
	 GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable      
	 )AR                              
	 INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                               
	 ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                              
	 END      
      
	/*UnappliedBalance*/       
	UPDATE ARA SET ARA.Unapplied = ISNULL(A.TotalBalance,0)      
	FROM(      
	SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.TotalBalance,0)TotalBalance      
	FROM PPMReport_ECW_AgingReport(NOLOCK)AR      
	WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'CB'      
	AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth      
	)A      
	INNER JOIN #TempTblpg1to12 ARA       
	ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth     
	AND RTRIM(LTRIM(ARA.ProviderName)) = RTRIM(LTRIM(a.AppointmentProvider))       
      
	/*Update Cleargage*/        
	UPDATE ARA SET ARA.ClearGage = ISNULL(A.ClearGage,0)      
	FROM(      
	SELECT CL.ID ClientID,CG.ReportYear,CG.ReportMonth,'All Provider' ProviderName,ISNULL(CG.Credit,0)ClearGage      
	FROM PPMReport_ClearGage(NOLOCK)CG      
	INNER JOIN PPMReport_ClientList(NOLOCK)CL       
	ON CL.ID = @ClientID AND CL.ClientFullName = CG.PPMMerchantAccount      
	WHERE ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
	)A      
	INNER JOIN #TempTblpg1to12 ARA       
	ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName       
      
	/*Update Collections*/       
	UPDATE ARA SET ARA.Collections = ISNULL(A.Collections,0)      
	FROM(      
	SELECT ClientID,ReportYear,ReportMonth,SUM(ISNULL(AdjustmentAmount,0))Collections,'All Provider' ProviderName      
	FROM PPMReport_ECW_Collection(NOLOCK)      
	WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
	GROUP BY ClientID,ReportYear,ReportMonth      
	)A      
	INNER JOIN #TempTblpg1to12 ARA       
	ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName       
      
	/*insert to main table*/      
	INSERT INTO PPMReport_ECW_FinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,      
	AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)      
	SELECT ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,      
	AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID      
	FROM #TempTblpg1to12      
	END      
      
	/*insert to main table Yearly Compare data*/        
	if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis_YrlyTrend(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0      
	BEGIN      
	 INSERT INTO PPMReport_ECW_FinancialAnalysis_YrlyTrend(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,      
	 AccountsReceivable,AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)      
	 SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName,                               
	 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,   
	 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,                                                      
	 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,      
	 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,        
	 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,                              
	 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,      
	 CONVERT(FLOAT,ISNULL(SUM(CY.Unapplied-PY.Unapplied)/NULLIF(ISNULL(SUM(PY.Unapplied),0),0),0))*100 YrlyUnapplied,         
	 CONVERT(FLOAT,ISNULL(SUM(CY.ClearGage-PY.ClearGage)/NULLIF(ISNULL(SUM(PY.ClearGage),0),0),0))*100 YrlyClearGage,         
	 CONVERT(FLOAT,ISNULL(SUM(CY.Collections-PY.Collections)/NULLIF(ISNULL(SUM(PY.Collections),0),0),0))*100 YrlyCollections,      
	 CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,      
	 CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID      
	 FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)CY       
	 LEFT JOIN (SELECT * FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                               
	 WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY                               
	 ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ProviderName=PY.ProviderName                              
	 WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth                              
	 GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName                               
	END      
	IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12      
	IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment      
	IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays      
	/*-----<<<End FinancialAnalysis>>>-----*/      
      
      
	/*-----<<<Start CPT Report>>>-----*/      
	IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0      
	BEGIN      
	IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT      
	/*Get CPTDescription,wRVU info*/      
	SELECT ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription      
	INTO #TempTblCPT FROM PPMReport_wRVUList(NOLOCK)wrv      
	INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT      
	ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL      
	WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth      
	GROUP BY ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU      
      
	/*individual provider*/      
	INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)      
	SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
	ProcedureCode,cpt.CPTGroup,  CPTDescription,ISNULL(Units,0)Units      
	FROM(      
	SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,CPTGroup,      
	SUM(ISNULL(BilledUnits,0))Units      
	FROM PPMReport_ECW_CPT(NOLOCK)      
	WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
	AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')      
	GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider)),CPTGroup      
	)cpt      
	LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt.ProcedureCode      
	WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth      
      
	/*All provider*/      
	INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)      
	SELECT cpt1.ClientID,cpt1.ReportYear,cpt1.ReportMonth,'All Provider','All Provider',cpt1.ProcedureCode,cpt1.CPTGroup,      
	CPTDescription,ISNULL(Units,0)Units      
	FROM(      
	SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup,      
	SUM(ISNULL(BilledUnits,0))Units      
	FROM PPMReport_ECW_CPT(NOLOCK)      
	WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
	AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')      
	GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup      
	)cpt1      
	LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt1.ProcedureCode      
	WHERE cpt1.ClientID = @ClientID AND cpt1.ReportYear = @ReportYear AND cpt1.ReportMonth = @ReportMonth      
      
	END      
	IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT      
	/*-----<<<End CPT Report>>>-----*/      
      
      
	/*-----<<<Start WRVU Report>>>-----*/      
	IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0      
	BEGIN      
	IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU      
	/*Get CPTDescription,wRVU info*/      
	SELECT ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU      
	INTO #TempTblWRVU FROM PPMReport_wRVUList(NOLOCK)wrv      
	INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT      
	ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL      
	WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth      
	GROUP BY ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU      
      
	/*individual provider*/      
	INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)      
      
	SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
	ProcedureCode,CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))      
	FROM(      
	SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,      
	SUM(ISNULL(BilledUnits,0))Units      
	FROM PPMReport_ECW_CPT(NOLOCK)      
	WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
	AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')      
	GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider))      
	)cpt      
	LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode      
	WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth      
	and (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')      
      
	/*All provider*/      
	INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)      
	SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,'All Provider'AppointmentProvider,'All Provider' AppointmentProvider,ProcedureCode,      
	CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))      
	FROM(      
	SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,      
	SUM(ISNULL(BilledUnits,0))Units      
	FROM PPMReport_ECW_CPT(NOLOCK)      
	WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
	AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')      
	GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode      
	)cpt      
	LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode      
	WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth      
      
	END      
	IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU      
	/*-----<<<End WRVU Report>>>-----*/      
      
      
	/*-----<<<Start Financial Dashboard>>>-----*/      
	IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0      
	BEGIN      
	IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard      
	CREATE TABLE #TempTblFinancialDashboard(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(200),ShortName VARCHAR(200),                              
	ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2)DEFAULT 0)      
	/*Revenue Analysis*/      
	INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
	SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName, ReportName, TotalCount                             
	FROM(      
	SELECT  ClientID,ReportYear,ReportMonth,ProviderName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,      
	Unapplied,AccountsReceivable,ClearGage,Collections      
	FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                              
	WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
	) PVT                              
	UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,AccountsReceivable,ClearGage,Collections))AS unpvt;          
      
	/*Encounter Analysis*/      
	INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)      
	SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'Encounter Analysis' ReportName,CPTGroupDesc, SUM(UNITS)UNITS      
	FROM PPMReport_ProcedureCount(NOLOCK)                              
	WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
	GROUP BY ClientID,ReportYear,ReportMonth,ProviderName,CPTGroupDesc      
      
	/*CPT Count*/      
	INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
	SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'CPT' ReportName, SUM(UNITS)UNITS      
	FROM PPMReport_ProcedureCount(NOLOCK)                              
	WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
	GROUP BY ClientID,ReportYear,ReportMonth,ProviderName      
      
	/*WVRU Count*/      
	INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
	SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'WVRU' ReportName, SUM(wRVU)wRVU      
	FROM PPMReport_wRVUReport(NOLOCK)                              
	WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
	GROUP BY ClientID,ReportYear,ReportMonth,ProviderName      
      
	INSERT INTO PPMReport_FinancialDashboard (ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)      
	SELECT * FROM #TempTblFinancialDashboard      
	ORDER BY 5,6      
      
	END      
	IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard      
	/*-----<<<End Financial Dashboard>>>-----*/      
      
      
	/*-----<<<Start AgingComparison Report01>>>-----*/      
	IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC      
	IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP      
	IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)      
	WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01') = 0      
	BEGIN      
	CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),                              
	[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),                              
	[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE)                   
      
	/*Get insAR patAR*/      
	SELECT ClientID,ReportYear,ReportMonth,ReportName ATBCategory,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,      
	SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],                              
	SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],                              
	SUM(ISNULL(TotalBalance,0))TotalBalance      
	INTO #TempTblAGNCOMP FROM PPMReport_ECW_AgingReport(NOLOCK)      
	WHERE ReportName IN ('IB','PB') --AND (AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL)                          
	AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ClientID = @ClientID      
	GROUP BY ClientID,ReportYear,ReportMonth,ReportName,RTRIM(LTRIM(AppointmentProvider))      
	ORDER BY 4,5      
	UPDATE #TempTblAGNCOMP SET AppointmentProvider = 'All Provider' WHERE AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL      
	UPDATE #TempTblAGNCOMP SET ATBCategory = 'Insurance AR' WHERE ATBCategory = 'IB'      
	UPDATE #TempTblAGNCOMP SET ATBCategory = 'Patient AR' WHERE ATBCategory = 'PB'      
      
	INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,    
	[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
	SELECT ClientID,ReportYear,ReportMonth,'Aging-01',RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,ATBCategory,    
	[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],TotalBalance      
	FROM #TempTblAGNCOMP ORDER BY 4,5      
      
	/*Total sum calculation*/      
	INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,    
	[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
	SELECT ClientID,ReportYear,ReportMonth,'Aging-01',RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,'Total AR' ATBCategory,    
	SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                              
	SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([TotalBalance])TotalBalance                              
	FROM #TempTblAGNCOMP      
	GROUP BY ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))      
      
	UPDATE #TempTblAC SET DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')      
      
	INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,    
	[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)      
	SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,RTRIM(LTRIM(ProviderName))ProviderName,RTRIM(LTRIM(ProviderName))ProviderName,ATBCategory,    
	[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID      
	FROM #TempTblAC      
      
	/*Total sum % calculation*/      
	INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)      
	SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-01',aa.ProviderName,aa.ProviderName,aa.ATBCategory + ' %',      
	[0-30] = Round(CONVERT(FLOAT,aa.[0-30]/NULLIF(bb.[0-30],0))*100,2)      
	,[31-60] = Round(CONVERT(FLOAT,aa.[31-60]/NULLIF(bb.[CategoryBalance],0))*100,2)      
	,[61-90] = Round(CONVERT(FLOAT,aa.[61-90]/NULLIF(bb.[CategoryBalance],0))*100,2)      
	,[91-120] = Round(CONVERT(FLOAT,aa.[91-120]/NULLIF(bb.[CategoryBalance],0))*100,2)      
	,[121-150] = Round(CONVERT(FLOAT,aa.[121-150]/NULLIF(bb.[CategoryBalance],0))*100,2)      
	,[151-180] = Round(CONVERT(FLOAT,aa.[151-180]/NULLIF(bb.[CategoryBalance],0))*100,2)      
	,[181+] = Round(CONVERT(FLOAT,aa.[181+]/NULLIF(bb.[CategoryBalance],0))*100,2)      
	,[CategoryBalance] = Round(CONVERT(FLOAT,aa.CategoryBalance/NULLIF(bb.[CategoryBalance],0))*100,2),      
	CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
	FROM #TempTblAC aa      
	LEFT JOIN PPMReport_AgingComparison(NOLOCK)bb      
	ON BB.ClientID = @ClientID AND BB.ProviderName = AA.ProviderName AND aa.ATBCategory = bb.ATBCategory      
	AND BB.DTID = DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))      
	WHERE AA.ClientID = @ClientID AND BB.ATBCategory IN ('Insurance AR','Patient AR','Total AR') AND  BB.ReportName = 'Aging-01'      
	AND AA.ProviderName = 'All Provider'      
      
	END      
	IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC      
	IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP      
	/*-----<<<End AgingComparison Report01>>>-----*/      
      
      
	/*-----<<<Start AgingComparison Report02>>>-----*/      
      
	IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                               
	WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02') = 0                              
	BEGIN                              
	IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02      
                       
	SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02' ReportName,RTRIM(LTRIM(tb.AppointmentProvider))AppointmentProvider,InsuranceGroup,      
	SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
	SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]      
	,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(SUM(ISNULL(rf.AccountsReceivable,0)),0))*100,2),0)      
	,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)      
	,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
	INTO #TempTblRep02        
	FROM PPMReport_ECW_AgingReport(NOLOCK) tb                               
	LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable       
	FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                               
	WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear      
	)rf                              
	ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                              
	WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth      
	AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)      
	GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,RTRIM(LTRIM(tb.AppointmentProvider)),tb.InsuranceGroup      
	UNION      
	SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,'Patient'InsuranceGroup,      
	SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
	SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance      
	,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)      
	,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)    
	+ ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)      
	,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
	FROM(      
	SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,RTRIM(LTRIM(tb.AppointmentProvider))AppointmentProvider,InsuranceGroup,      
	SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
	SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable      
	FROM PPMReport_ECW_AgingReport(NOLOCK) tb                               
	LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable       
	FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                               
	WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear      
	)rf                              
	ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                              
	WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth      
	AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)      
	GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,RTRIM(LTRIM(tb.AppointmentProvider)),tb.InsuranceGroup,rf.AccountsReceivable                                
	)aa      
	GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth,RTRIM(LTRIM(aa.AppointmentProvider))      
	UNION      
	/*GET all provider details*/      
	SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,'All Provider',InsuranceGroup,      
	SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
	SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]      
	,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(ISNULL(SUM(rf.AccountsReceivable),0),0))*100,2),0)      
	,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)      
	,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
	FROM PPMReport_ECW_AgingReport(NOLOCK) tb                               
	LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable       
	FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                               
	WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear      
	)rf                              
	ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                              
	WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth      
	AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)      
	GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.InsuranceGroup      
	UNION      
	SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,'All Provider','Patient'InsuranceGroup,      
	SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
	SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance      
	,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)      
	,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)      
	,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
	FROM(      
	SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,InsuranceGroup,      
	SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
	SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable      
	FROM PPMReport_ECW_AgingReport(NOLOCK) tb                               
	LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable       
	FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                               
	WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear      
	)rf            
	ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                              
	WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth      
	AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)      
	GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,tb.InsuranceGroup,rf.AccountsReceivable                                
	)aa      
	GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth      
      
      
	INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],                              
	[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)       
	SELECT ClientID,ReportYear,ReportMonth,ReportName,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
	InsuranceGroup,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercentage,Over90days,dtid      
	FROM #TempTblRep02      
      
	END      
	IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02      
      
	/*-----<<<End AgingComparison Report02>>>-----*/      
       
	/*-----<<<Start Payer Mix >>>-----*/    
	IF OBJECT_ID('tempdb..#TempTblPName') IS NOT NULL DROP TABLE #TempTblPName      
	if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0      
	BEGIN    
    
	DECLARE @strSql1 AS VARCHAR(MAX),@strSql AS VARCHAR(MAX)    
	IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName    
	SET @strSql1 += ''    
	SET @strSql1 = 'SELECT pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider    
	INTO ##TempTblPName FROM PPMReport_ECW_PayerMix(NOLOCK)pm '    
	if @providerList > 0    
	BEGIN    
	SET @strSql1 += '   
	LEFT JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl     
	ON nl.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND RTRIM(LTRIM(NL.ProviderName)) = RTRIM(LTRIM(pm.AppointmentProvider))    
	AND nl.IsActive = 1 '    
	END    
	SET @strSql1 += 'WHERE pm.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND ReportYear = ' + CONVERT(VARCHAR,@ReportYear) +     
	' AND ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth) +     
	' AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)    
	GROUP BY pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))'    
	EXEC (@strSql1)      
	-----    
	SET @strSql += ''    
	SET @strSql = 'SELECT pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
	RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,InsuranceGroup,    
	SUM(ISNULL(BilledCharge,0))Charges,    
	Payment = (SUM(ISNULL(Payment,0)) - SUM(ISNULL(Refund,0))),    
	SUM(ISNULL(Refund,0))Refund      
	FROM PPMReport_ECW_PayerMix(NOLOCK)pm   
	'    
	if @providerList > 0    
	BEGIN    
	SET @strSql += ' INNER JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl     
	ON nl.ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND RTRIM(LTRIM(NL.ProviderName)) = RTRIM(LTRIM(pm.AppointmentProvider))   
	AND nl.IsActive = 1'     
	END    
	SET @strSql += 'WHERE pm.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND pm.ReportYear = ' + CONVERT(VARCHAR,@ReportYear) +    
	' AND pm.ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth)+       
	' AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)      
	GROUP BY pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(pm.AppointmentProvider)),InsuranceGroup      
	UNION      
	SELECT wc.ClientID,wc.ReportYear,wc.ReportMonth,RTRIM(LTRIM(wc.AppointmentProvider))AppointmentProvider,    
	RTRIM(LTRIM(wc.AppointmentProvider))AppointmentProvider,''PWOC'' InsuranceGroup,      
	0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund      
	FROM PPMReport_ECW_WithoutClaims(NOLOCK)wc    
	INNER JOIN ##TempTblPName pn    
	ON RTRIM(LTRIM(wc.AppointmentProvider)) = pn.AppointmentProvider      
	WHERE wc.ClientID = ' + CONVERT(VARCHAR,@ClientID) +' AND wc.ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+     
	' and wc.ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth ) + ' AND (PaymentDate != ''Summary'' AND PaymentDate IS NOT NULL)      
	GROUP BY wc.ClientID,wc.ReportYear,wc.ReportMonth,RTRIM(LTRIM(wc.AppointmentProvider))        
	UNION      
	/*All Provider*/      
	SELECT ClientID,ReportYear,ReportMonth,''All Provider'' AppointmentProvider,''All Provider'' AppointmentProvider,InsuranceGroup,      
	SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))-SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund      
	FROM PPMReport_ECW_PayerMix(NOLOCK)      
	WHERE ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+    
	' AND ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth) +    
	' AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)      
	GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup      
	UNION      
	SELECT wcc.ClientID,wcc.ReportYear,wcc.ReportMonth,''All Provider'' AppointmentProvider,''All Provider'' AppointmentProvider,''PWOC''InsuranceGroup,      
	0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund      
	FROM PPMReport_ECW_WithoutClaims(NOLOCK)wcc      
	LEFT JOIN ##TempTblPName(NOLOCK)nl     
	ON nl.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND RTRIM(LTRIM(NL.AppointmentProvider)) = RTRIM(LTRIM(wcc.AppointmentProvider))     
	WHERE wcc.ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND wcc.ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+    
	' AND wcc.ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth)+      
	' AND (PaymentDate != ''Summary'' AND PaymentDate IS NOT NULL)      
	GROUP BY wcc.ClientID,wcc.ReportYear,wcc.ReportMonth '     
	INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)    
	EXEC(@strSql)    
	IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName    
      
	END    
	/*-----<<<End Payer Mix >>>-----*/      
      
	COMMIT TRANSACTION               
	SET @ErrorMessage = 'Sucess'               
	END TRY                          
                            
	BEGIN CATCH                          
	ROLLBACK TRANSACTION                
	SET @ErrorMessage = ERROR_MESSAGE()                    
	END CATCH    
	IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12      
	IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment      
	IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays    
	IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT    
	IF OBJECT_ID('tempdb..#TempTblPName') IS NOT NULL DROP TABLE #TempTblPName     
	IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName              
SET @Output = CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage              
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECW_CodingCurveQuery]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECW_CodingCurveQuery]              
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))              
AS              
BEGIN              
/*Coding Curve*/              
/*
DECLARE @Client VARCHAR(100)='OSIS'              
DECLARE @ReportYear varchar(max) = '2019'              
*/
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear              
CREATE TABLE #TempTblYear(ReportYear INT)              
INSERT INTO #TempTblYear SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')              
              
IF OBJECT_ID('tempdb..#TempTableCodingCurve01') IS NOT NULL DROP TABLE #TempTableCodingCurve01              
IF OBJECT_ID('tempdb..#TempTableCodingCurve02') IS NOT NULL DROP TABLE #TempTableCodingCurve02              
IF OBJECT_ID('tempdb..#TempTableCodingCurve03') IS NOT NULL DROP TABLE #TempTableCodingCurve03        
IF OBJECT_ID('tempdb..#PPMReport_CodingCurveList') IS NOT NULL DROP TABLE #PPMReport_CodingCurveList        
        
SELECT * INTO #PPMReport_CodingCurveList FROM PPMReport_CodingCurveList(NOLOCK)  
WHERE ClientID=(SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)  
  
SELECT AppointmentProvider AS ShortName      
INTO #TempTableCodingCurve01 FROM             
(SELECT ClientID, AppointmentProvider 
FROM PPMReport_ECW_CPT(NOLOCK) RF              
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON RF.ClientID= CL.ID              
WHERE rf.AppointmentProvider != 'Summary' AND cl.ClientAcronym = @Client 
AND ReportYear IN (SELECT ReportYear FROM #TempTblYear) 
GROUP BY ClientID, AppointmentProvider)a              
              
INSERT INTO #TempTableCodingCurve01(ShortName) VALUES('All Provider')

SELECT bb.ReportYear,cc.ID ReportMonth,aa.ShortName,CPTCode,Fee,(ISNULL(NationalDist,0)*100)NationalDist,TableName              
INTO #TempTableCodingCurve02 FROM #TempTableCodingCurve01 aa              
LEFT OUTER JOIN #PPMReport_CodingCurveList(NOLOCK)bb ON  1=1         
LEFT OUTER JOIN PPM_Month(NOLOCK)cc on 1=1              
WHERE bb.ReportYear IN (SELECT ReportYear FROM #TempTblYear)               

SELECT ClientID,ReportMonth,ReportYear,AppointmentProvider AS ClaimProvider,ProcedureCode CPT,
SUM(BilledUnits)Units, AppointmentProvider AS ShortName
INTO #TempTableCodingCurve03 
FROM PPMReport_ECW_CPT(NOLOCK)              
WHERE ReportYear IN (SELECT ReportYear FROM #TempTblYear)         
AND ID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)             
GROUP BY ClientID,ReportMonth,ReportYear,AppointmentProvider,ProcedureCode
              
SELECT DISTINCT @Client ClientAcronym,          
Client = (SELECT TOP 1 ClientFullName FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client),          
aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.CPTCode,aa.Fee,ISNULL(bb.Units,0) CurrentFrequency,aa.NationalDist,aa.TableName              
FROM #TempTableCodingCurve02 AA           
LEFT JOIN #TempTableCodingCurve03 bb               
ON aa.CPTCode=bb.CPT and aa.ReportMonth=bb.ReportMonth and aa.ShortName=bb.ShortName             
and aa.ReportYear=bb.ReportYear        
ORDER BY ReportYear,ReportMonth,ShortName,CPTCode              
              
IF OBJECT_ID('tempdb..#TempTableCodingCurve01') IS NOT NULL DROP TABLE #TempTableCodingCurve01              
IF OBJECT_ID('tempdb..#TempTableCodingCurve02') IS NOT NULL DROP TABLE #TempTableCodingCurve02              
IF OBJECT_ID('tempdb..#TempTableCodingCurve03') IS NOT NULL DROP TABLE #TempTableCodingCurve03        
IF OBJECT_ID('tempdb..#PPMReport_CodingCurveList') IS NOT NULL DROP TABLE #PPMReport_CodingCurveList              
              
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECW_CPAreport]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECW_CPAreport]  
(@Client VARCHAR(60) ,@ReportYear VARCHAR(MAX))                          
AS                          
BEGIN                          
 /* 
DECLARE @Client VARCHAR(MAX) = 'AVCMD'                          
DECLARE @ReportYear varchar(max) = '2019'            
*/
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear                
IF OBJECT_ID('tempdb..#TEMPTBLCPA') IS NOT NULL DROP TABLE #TEMPTBLCPA
CREATE TABLE #TempTblYear(ReportYear INT)  
INSERT INTO #TempTblYear  
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')                          
                
SELECT cl.ClientAcronym,CL.ClientFullName Client,fd.ReportYear,Pm.ReportMonth,AppointmentProvider,RenderingProvider,  
BilledCharge,SelfCharge,InsuranceCharge,Payment,PatientPayment,InsurancePayment,Contractual,InsuranceWithheld,  
WriteOffAdjustment,Refund,ChangeinAR,VisitCount,PatientCount  
INTO #TEMPTBLCPA FROM PPMReport_ECW_Daysheet(NOLOCK)FD                
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth          
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID                   
WHERE ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)            
AND ReportYear IN (SELECT ReportYear from #TempTblYear)                
ORDER BY FD.ReportMonth asc

UPDATE #TEMPTBLCPA set AppointmentProvider = 'All Provider'
where AppointmentProvider = 'Summary' or AppointmentProvider IS NULL

select * from #TEMPTBLCPA
            
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear                 
IF OBJECT_ID('tempdb..#TEMPTBLCPA') IS NOT NULL DROP TABLE #TEMPTBLCPA
END   

GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECW_CPTReport]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECW_CPTReport]            
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))              
AS              
BEGIN             
  /*
DECLARE @Client VARCHAR(100)='OSIS'        
DECLARE @ReportYear varchar(max) = '2019'            
  */
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear
IF OBJECT_ID('tempdb..#TempTblcpt') IS NOT NULL DROP TABLE #TempTblcpt          
CREATE TABLE #TempTblYear(ReportYear INT)          
          
INSERT INTO #TempTblYear          
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')          
       
SELECT  cl.ClientAcronym,CL.ClientFullName Client,ReportYear,PM.ReportMonth,AppointmentProvider,RenderingProvider,CPTGroup,ProcedureCode,  
BilledCharge,InsuranceCharge,SelfCharge,Payments,PatientPayment,InsurancePayments,InsuranceWithheld,ContractualAdjustments,  
WriteOffAdjustments,RefundAmount,BilledUnits,ChangeinAR,VisitCount,PatientCount  
INTO #TempTblcpt FROM PPMReport_ECW_CPT(NOLOCK)FD            
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID              
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth              
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)          
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear)      

update #TempTblcpt set AppointmentProvider = 'All Provider'
where AppointmentProvider = 'Summary' or AppointmentProvider IS NULL

select * from #TempTblcpt
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear 
IF OBJECT_ID('tempdb..#TempTblcpt') IS NOT NULL DROP TABLE #TempTblcpt          
END  
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECW_FinancialAnalysisSheet]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECW_FinancialAnalysisSheet]        
(@Client VARCHAR(60),@ReportYear VARCHAR(MAX))        
AS        
BEGIN      
/*      
DECLARE @Client VARCHAR(MAX) = 'OSIS'      
DECLARE @ReportYear VARCHAR(MAX) = '2019'      
*/       
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear        
CREATE TABLE #TempTblYear(ReportYear INT)        
INSERT INTO #TempTblYear
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')        

SELECT cl.ClientAcronym,Client,RF.ReportYear,PM.ReportMonth,RF.ProviderName AS ShortName,RF.Charges,RF.Payments,RF.Adjustments,
RF.AccountsReceivable,RF.AROver120,RF.ARDaysOutstanding,YRF.Charges AS YrlyCharges,YRF.Payments AS YrlyPayments,
YRF.Adjustments AS YrlyAdjustments,YRF.AccountsReceivable AS YrlyAccountsReceivable,        
YRF.AROver120 AS YrlyAROver120,YRF.ARDaysOutstanding AS YrlyARDaysOutstanding
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)RF        
LEFT JOIN PPMReport_ECW_FinancialAnalysis_YrlyTrend(NOLOCK)YRF ON YRF.ProviderName= RF.ProviderName AND        
YRF.ClientID= RF.ClientID AND YRF.ReportYear = RF.ReportYear AND YRF.ReportMonth = RF.ReportMonth        
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON RF.ClientID= CL.ID        
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=RF.ReportMonth        
WHERE RF.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)    
AND RF.ReportYear IN (SELECT ReportYear FROM #TempTblYear)       
ORDER BY RF.ProviderName,RF.ReportYear,RF.ReportMonth ASC

IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear
END
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECW_FinancialAnalysisSheet2]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECW_FinancialAnalysisSheet2]
(@Client VARCHAR(60),@ReportYear VARCHAR(MAX))            
AS            
BEGIN      
/*        
DECLARE @Client VARCHAR(60) = 'OSIS'        
DECLARE @ReportYear varchar(max) = '2019'        
*/  
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear            
CREATE TABLE #TempTblYear(ReportYear INT)
INSERT INTO #TempTblYear            
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')            

SELECT cl.ClientAcronym,cl.ClientFullName Client,RF.ReportYear,PM.ReportMonth,RF.ProviderName,
RF.Unapplied,RF.Collections,rf.Refunds,rf.ClearGage,YRF.Unapplied AS YrlyUnapplied,YRF.Collections YrlyCollections,
YRF.Refunds AS YrlyRefunds,RF.ClearGage AS YrlyClearGage            
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)RF
LEFT JOIN PPMReport_ECW_FinancialAnalysis_YrlyTrend(NOLOCK)YRF ON YRF.ProviderName = RF.ProviderName AND            
YRF.ClientID= RF.ClientID AND YRF.ReportYear = RF.ReportYear AND YRF.ReportMonth = RF.ReportMonth            
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON RF.ClientID= CL.ID            
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=RF.ReportMonth
WHERE RF.ProviderName ='All Provider' AND RF.ClientID  = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)           
AND RF.ReportYear IN (SELECT ReportYear FROM #TempTblYear)  ORDER BY RF.ProviderName,RF.ReportYear,RF.ReportMonth ASC            
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear
END
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECW_OCRDetails]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECW_OCRDetails]            
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))            
AS            
BEGIN            
/*
DECLARE @Client VARCHAR(100) = 'OSIS'        
DECLARE @ReportYear varchar(max) = '2019'          
*/
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear            
CREATE TABLE #TempTblYear(ReportYear INT)            
INSERT INTO #TempTblYear            
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')            

SELECT CL.ClientAcronym,CL.ClientFullName Client,FD.ReportYear,PM.ReportMonth, RenderingProvider AS ProviderName,
CurrentDebtorName,ClaimID,CPTBalance,ServiceDate,ClaimDate,CPTCode,Modifier,Remark,RemarkDesc
FROM PPMReport_ECW_OCR(Nolock)FD            
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID            
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth            
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)            
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear) 
--ORDER BY FD.ReportYear,FD.ReportMonth ASC            
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear            
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECW_OCRRemark]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECW_OCRRemark]                  
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))                  
AS                  
BEGIN                  
/*
DECLARE @Client VARCHAR(100)='OSIS'
DECLARE @ReportYear varchar(max) = '2019'
*/      
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear
IF OBJECT_ID('tempdb..#TempTblOCR') IS NOT NULL DROP TABLE #TempTblOCR

CREATE TABLE #TempTblOCR(ClientAcronym VARCHAR(200),ClientFullName VARCHAR(200),ReportYear INT,ReportMonth VARCHAR(50),
ProviderName VARCHAR(200),Remark VARCHAR(500),RemarkDesc VARCHAR(500),Balance DECIMAL (18, 2))

CREATE TABLE #TempTblYear(ReportYear INT)                  
INSERT INTO #TempTblYear                  
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')                  
/*ALL PROVIDER*/
INSERT INTO #TempTblOCR(ClientAcronym,ClientFullName,ReportYear,ReportMonth,ProviderName,Remark,RemarkDesc,Balance)
SELECT cl.ClientAcronym,CL.ClientFullName,FD.ReportYear,PM.ReportMonth,'All Provider'ProviderName,
FD.Remark,FD.RemarkDesc,SUM(CPTBalance)AS Balance
FROM PPMReport_ECW_OCR(Nolock)FD                  
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID                  
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth                  
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)                  
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear)          
GROUP BY cl.ClientAcronym,CL.ClientFullName,FD.ReportYear,PM.ReportMonth,FD.Remark,FD.RemarkDesc
/*EACH PROVIDER*/
INSERT INTO #TempTblOCR(ClientAcronym,ClientFullName,ReportYear,ReportMonth,ProviderName,Remark,RemarkDesc,Balance)
SELECT cl.ClientAcronym,CL.ClientFullName,FD.ReportYear,PM.ReportMonth,RenderingProvider,
FD.Remark,FD.RemarkDesc,SUM(CPTBalance)AS Balance
FROM PPMReport_ECW_OCR(Nolock)FD                  
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID                  
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth                  
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)                  
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear)          
GROUP BY cl.ClientAcronym,CL.ClientFullName,FD.ReportYear,PM.ReportMonth,FD.RenderingProvider,FD.Remark,FD.RemarkDesc

SELECT * FROM #TempTblOCR
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear
IF OBJECT_ID('tempdb..#TempTblOCR') IS NOT NULL DROP TABLE #TempTblOCR
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMreport_ecw_outputOLD]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[PPMreport_ecw_outputOLD]
as
begin

DECLARE @ProjectID INT = 2
DECLARE @ClientID INT = 53
DECLARE @ReportMonth INT = 4
DECLARE @ReportYear INT = 2019

    
/*Backup Old Name in charge*/      
UPDATE XL SET XL.XLName = A.EOMName      
FROM(      
SELECT ch.id, pn.ClientID,EOMName,DOPName      
FROM PPMReport_MatchProviderName(NOLOCK)PN      
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH      
ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.AppointmentProvider
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName
)A      
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName      
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear      

/*Update Provider name as DOP Name in Charge*/
UPDATE XL SET XL.AppointmentProvider = A.DOPName      
FROM(      
SELECT ch.id, pn.ClientID,EOMName,DOPName      
FROM PPMReport_MatchProviderName(NOLOCK)PN      
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH      
ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.AppointmentProvider      
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName      
)A      
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName      
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear      


if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)<=0                    
BEGIN
IF OBJECT_ID('tempdb..#TempTblFinancialAnalysis') IS NOT NULL DROP TABLE #TempTblFinancialAnalysis
IF OBJECT_ID('tempdb..#TempTblFinancialAnalysisARDays') IS NOT NULL DROP TABLE #TempTblFinancialAnalysisARDays

CREATE TABLE #TempTblFinancialAnalysis(
ClientID			INT,
ReportYear			INT,
ReportMonth			INT,
ProviderName		VARCHAR(200),                    
Charges				DECIMAL(18, 2),
Payments			DECIMAL(18, 2),	
Adjustments			DECIMAL(18, 2),	
AccountsReceivable	DECIMAL(18, 2),
AROver120			DECIMAL(18, 2),
ARDaysOutstanding	DECIMAL(18, 2),
Unapplied			DECIMAL(18, 2),
ClearGage			DECIMAL(18, 2),
Collections			DECIMAL(18, 2),
Refunds				DECIMAL(18, 2),
DTID				DATE)

/*All Provider Charges*/
INSERT INTO #TempTblFinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,ClearGage,DTID)
SELECT ClientID,ReportYear,ReportMonth,'All Provider' ProviderName, BilledCharge AS Charges,0.00 ClearGage,
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID 
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) 
WHERE AppointmentProvider = 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth

/*Each Provider Charges*/
INSERT INTO #TempTblFinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,DTID)
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,SUM(ISNULL(BilledCharge,0)) Charges,
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) WHERE AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

/*All Provider Payments*/
UPDATE PAY SET PAY.Payments = aa.Payments                                                        
FROM 
(SELECT A.ClientID,A.ReportYear,A.ReportMonth,'All Provider'ProviderName,
Payments = SUM((ISNULL(A.Payment,0)-ISNULL(A.Refund,0))+ISNULL(A.Amount,0))
FROM(
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.Payment,AR.Refund,WOC.Amount
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WOC ON WOC.PaymentDate = 'Summary'
AND AR.ClientID = WOC.ClientID AND AR.ReportYear = WOC.ReportYear AND AR.ReportMonth = WOC.ReportMonth
WHERE AR.AppointmentProvider = 'Summary' 
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth
)a GROUP BY A.ClientID,A.ReportYear,A.ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis PAY ON PAY.ClientID = aa.ClientID AND PAY.ReportYear = aa.ReportYear                     
AND PAY.ReportMonth = aa.ReportMonth AND PAY.ProviderName = aa.ProviderName


/*Each Provider Payments*/
UPDATE PAY SET PAY.Payments = aa.Payments                                                        
FROM 
(SELECT A.ClientID,A.ReportYear,A.ReportMonth,AppointmentProvider,
Payments = SUM((ISNULL(A.Payment,0)-ISNULL(A.Refund,0))+ISNULL(A.Amount,0))
FROM(
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,ar.AppointmentProvider,AR.Payment,AR.Refund,WOC.Amount
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WOC ON WOC.PaymentDate != 'Summary'
AND AR.ClientID = WOC.ClientID AND AR.ReportYear = WOC.ReportYear AND AR.ReportMonth = WOC.ReportMonth
WHERE AR.AppointmentProvider != 'Summary' AND AR.AppointmentProvider = WOC.AppointmentProvider
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth
)a GROUP BY A.ClientID,A.ReportYear,A.ReportMonth,a.AppointmentProvider
) aa
INNER JOIN #TempTblFinancialAnalysis PAY ON PAY.ClientID = aa.ClientID AND PAY.ReportYear = aa.ReportYear                     
AND PAY.ReportMonth = aa.ReportMonth AND PAY.ProviderName = aa.AppointmentProvider

/*All Provider Adjustments*/
UPDATE ADJ SET ADJ.Adjustments = aa.Adjustments                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,
Adjustments = SUM(ISNULL(Contractual,0)+ISNULL(InsuranceWithheld,0)+ISNULL(WriteoffAdjustment,0))
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) 
WHERE AppointmentProvider = 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis ADJ ON ADJ.ClientID = aa.ClientID AND ADJ.ReportYear = aa.ReportYear                     
AND ADJ.ReportMonth = aa.ReportMonth AND ADJ.ProviderName = aa.ProviderName

/*Each Provider Adjustments*/
UPDATE ADJ SET ADJ.Adjustments = aa.Adjustments                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider ProviderName,
Adjustments = SUM(ISNULL(Contractual,0)+ISNULL(InsuranceWithheld,0)+ISNULL(WriteoffAdjustment,0))
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) 
WHERE AppointmentProvider != 'Summary' 
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider
) aa
INNER JOIN #TempTblFinancialAnalysis ADJ ON ADJ.ClientID = aa.ClientID AND ADJ.ReportYear = aa.ReportYear                     
AND ADJ.ReportMonth = aa.ReportMonth AND ADJ.ProviderName = aa.ProviderName

/*All Provider Accounts Receivable*/
UPDATE AR SET AR.AccountsReceivable = aa.TotalBalance                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,TotalBalance,'All Provider'ProviderName
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider = 'Summary' AND ReportName = 'AS'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis AR ON AR.ClientID = aa.ClientID AND AR.ReportYear = aa.ReportYear                     
AND AR.ReportMonth = aa.ReportMonth AND AR.ProviderName = aa.ProviderName

/*Each Provider Accounts Receivable*/
UPDATE AR SET AR.AccountsReceivable = aa.AR                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,SUM(ISNULL(TotalBalance,0))AR
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider != 'Summary' AND ReportName = 'AS'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider
) aa
INNER JOIN #TempTblFinancialAnalysis AR ON AR.ClientID = aa.ClientID AND AR.ReportYear = aa.ReportYear                     
AND AR.ReportMonth = aa.ReportMonth AND AR.ProviderName = aa.AppointmentProvider

/*All Provider AR Over 120*/
UPDATE AR SET AR.AROver120 = aa.AR120                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,
AR120 = SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider = 'Summary' AND ReportName = 'AS'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis AR ON AR.ClientID = aa.ClientID AND AR.ReportYear = aa.ReportYear                     
AND AR.ReportMonth = aa.ReportMonth AND AR.ProviderName = aa.ProviderName

/*Each Provider AR Over 120*/
UPDATE AR SET AR.AROver120 = aa.AR120                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,
AR120 = SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider != 'Summary' AND ReportName = 'AS'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider
) aa
INNER JOIN #TempTblFinancialAnalysis AR ON AR.ClientID = aa.ClientID AND AR.ReportYear = aa.ReportYear                     
AND AR.ReportMonth = aa.ReportMonth AND AR.ProviderName = aa.AppointmentProvider


/*ARDaysOutstanding*/                    
DECLARE @RWCount INT
SELECT ClientID,ReportMonth,ReportYear,ProviderName,Charges,DTID                    
INTO #TempTblFinancialAnalysisARDays FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID = @ClientID AND
DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                     
DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')

SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblFinancialAnalysisARDays)+1
IF @RWCount = 1
BEGIN
	UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays
	FROM(SELECT ClientID,ReportYear,ReportMonth,ProviderName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((ISNULL(Charges,0)/(30)),0),0),0)ARDays                     
	FROM #TempTblFinancialAnalysis WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                    
	GROUP BY ClientID,ReportYear,ReportMonth,ProviderName,AccountsReceivable,Charges)AR                    
	INNER JOIN #TempTblFinancialAnalysis ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                     
	ARD.ReportMonth = AR.ReportMonth AND ARD.ProviderName = AR.ProviderName
END                    
ELSE
BEGIN
	UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays
	FROM(SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ProviderName,
	ISNULL(NULLIF(ISNULL(ABS(isnull(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays
	FROM #TempTblFinancialAnalysis AA LEFT JOIN (SELECT ClientID,ProviderName,SUM(ISNULL(Charges,0))Charges FROM #TempTblFinancialAnalysisARDays
	GROUP BY  ClientID,ProviderName) bb ON aa.ClientID = bb.ClientID AND aa.ProviderName=bb.ProviderName
	WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear
	GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ProviderName,aa.AccountsReceivable)AR
	INNER JOIN #TempTblFinancialAnalysis ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND
	ARD.ReportMonth = AR.ReportMonth AND ARD.ProviderName = AR.ProviderName
END

/*All Provider Unapplied*/
UPDATE UA SET UA.Unapplied = aa.Unapplied                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,TotalBalance Unapplied
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider = 'Summary' AND ReportName = 'CB'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis UA ON UA.ClientID = aa.ClientID AND UA.ReportYear = aa.ReportYear                     
AND UA.ReportMonth = aa.ReportMonth AND UA.ProviderName = aa.ProviderName

-----------------------------------------------------NEED CLEARGAGE DETAILS TO UPDATE FURTHER
/*Update Cleargage*/                    
UPDATE CG SET CG.ClearGage = aa.Credit
FROM (
SELECT CL.ID,CGG.ReportMonth,CGG.ReportYear,'All Provider'ProviderName,CGG.Credit
FROM PPMReport_ClientList(NOLOCK)CL 
LEFT JOIN PPMReport_ClearGage(NOLOCK)CGG ON CL.ClientFullName = CGG.PPMMerchantAccount
WHERE IsActive = 1 AND Project = @ProjectID AND CL.ID = @ClientID AND CGG.ReportYear = @ReportYear AND CGG.ReportMonth = @ReportMonth
) aa
INNER JOIN PPMReport_ClearGage_Collection(NOLOCK) CG ON CG.ClientID = aa.ID AND CG.ReportYear = aa.ReportYear
AND CG.ReportMonth = aa.ReportMonth AND CG.ProviderName = aa.ProviderName


/*All Provider Collectioin*/
UPDATE COLL SET COLL.Collections = aa.Collections
FROM 
(SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(AdjustmentAmount,0))Collections
FROM PPMReport_ECW_Collection(NOLOCK) 
--WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis COLL ON COLL.ClientID = aa.ClientID AND COLL.ReportYear = aa.ReportYear                     
AND COLL.ReportMonth = aa.ReportMonth AND COLL.ProviderName = aa.ProviderName


/*All Provider Refunds*/
UPDATE RF SET RF.Refunds = aa.Refund
FROM 
(SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(Refund,0))Refund
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) 
WHERE AppointmentProvider = 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis RF ON RF.ClientID = aa.ClientID AND RF.ReportYear = aa.ReportYear                     
AND RF.ReportMonth = aa.ReportMonth AND RF.ProviderName = aa.ProviderName

/*Each Provider Refunds*/
UPDATE RF SET RF.Refunds = aa.Refund
FROM 
(SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider ProviderName,SUM(ISNULL(Refund,0)) Refund
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) 
WHERE AppointmentProvider != 'Summary'AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider
) aa
INNER JOIN #TempTblFinancialAnalysis RF ON RF.ClientID = aa.ClientID AND RF.ReportYear = aa.ReportYear                     
AND RF.ReportMonth = aa.ReportMonth AND RF.ProviderName = aa.ProviderName

/*Final Data moved to FinancialAnalysis table*/
INSERT INTO PPMReport_ECW_FinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,                    
Payments,Refunds,Adjustments,Unapplied,AccountsReceivable,AROver120,ARDaysOutstanding,DTID)                    
SELECT ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Refunds,ABS(ISNULL(Adjustments,0))Adjustments,
ISNULL(Unapplied,0)Unapplied,AccountsReceivable,AROver120,ARDaysOutstanding,DTID 
FROM #TempTblFinancialAnalysis

UPDATE PPMReport_ECW_FinancialAnalysis SET ClearGage = ISNULL(ClearGage,0),Collections = ISNULL(Collections,0)
WHERE ClientID=@ClientID AND ReportYear=@ReportYear AND ReportMonth=@ReportMonth

/*Yearly Compare*/
INSERT INTO PPMReport_ECW_FinancialAnalysis_YrlyTrend(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)
SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName,                     
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 AS Charges,
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 AS Payments,
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 AS Adjustments,
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 AS AccountsReceivable,
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 AS AROver120,
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 AS ARDaysOutstanding,
CONVERT(FLOAT,ISNULL(SUM(CY.Unapplied-PY.Unapplied)/NULLIF(ISNULL(SUM(PY.Unapplied),0),0),0))*100 AS Unapplied,
CONVERT(FLOAT,ISNULL(SUM(CY.ClearGage-PY.ClearGage)/NULLIF(ISNULL(SUM(PY.ClearGage),0),0),0))*100 AS ClearGage,
CONVERT(FLOAT,ISNULL(SUM(CY.Collections-PY.Collections)/NULLIF(ISNULL(SUM(PY.Collections),0),0),0))*100 AS Collections,
CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 AS Refunds,
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID
FROM #TempTblFinancialAnalysis(NOLOCK)CY 
LEFT JOIN (
SELECT * FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) 
)PY
ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ProviderName=PY.ProviderName
WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth
GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName

End
IF OBJECT_ID('tempdb..#TempTblFinancialAnalysis') IS NOT NULL DROP TABLE #TempTblFinancialAnalysis
IF OBJECT_ID('tempdb..#TempTblFinancialAnalysisARDays') IS NOT NULL DROP TABLE #TempTblFinancialAnalysisARDays

--SELECT * FROM #TempTblFinancialAnalysis
------------------------------------------------------------------------------------------------------------------------------------
--==================================================================================================================================


IF OBJECT_ID('tempdb..#TempTblFinancialDashboards') IS NOT NULL DROP TABLE #TempTblFinancialDashboards
IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01
IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02

IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear) <= 0                    
BEGIN
CREATE TABLE #TempTblFinancialDashboards(
ClientID		INT,
ReportYear		INT,
ReportMonth		INT,
ProviderName	VARCHAR(100),
ReportName		VARCHAR(100),
CPTGroupDesc	VARCHAR(100),
TotalCount		DECIMAL (18,2))

/*
<<Financial Dashboard>>
Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,AccountsReceivable,Collections,ClearGage
 */
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount)
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount
FROM (
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,
AccountsReceivable,Collections,ClearGage 
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
) PVT
UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,
AccountsReceivable,Collections,ClearGage))AS unpvt;
UPDATE #TempTblFinancialDashboards SET ReportName = 'Net Receipts' WHERE ReportName = 'Payments'

/*Encounter Analysis All Provider*/
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,CPTGroupDesc,TotalCount)
SELECT ClientID,ReportYear,ReportMonth,'All Provider' ProviderName,'EncounterAnalysis'ReportName, CPTGroup,UNITS = SUM(BilledUnits)
FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,CPTGroup

/*Encounter Analysis Each Provider*/
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,CPTGroupDesc,TotalCount)
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,'EncounterAnalysis'ReportName, CPTGroup,UNITS = SUM(BilledUnits)
FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,CPTGroup

/*CPT Counts All Provider*/
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount)
SELECT ClientID,ReportYear,ReportMonth, 'All Provider' ProviderName,'CPT Counts'ReportName,ISNULL(BilledUnits,0)Units 
FROM PPMReport_ECW_CPT(NOLOCK) 
WHERE AppointmentProvider = 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth

/*CPT Counts All Provider*/
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount)
SELECT ClientID,ReportYear,ReportMonth, AppointmentProvider ProviderName,'CPT Counts'ReportName,SUM(ISNULL(BilledUnits,0))Units 
FROM PPMReport_ECW_CPT(NOLOCK) 
WHERE AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth, AppointmentProvider

/*Work wRVU All Provider*/
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode CPT,SUM(BilledUnits)UNITS                    
INTO #TempTblWorkwRVU01 FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth                    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode
--
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount)
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'Work wRVU'ReportName,SUM(wRVUu)wRVU
FROM (
SELECT ClientID,rv.ReportYear,ReportMonth,CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu                    
FROM #TempTblWorkwRVU01(NOLOCK)cp
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL
GROUP BY ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units
)aa
GROUP BY ClientID,ReportYear,ReportMonth

/*Work wRVU Each Provider*/
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,ProcedureCode CPT,SUM(BilledUnits)UNITS                    
INTO #TempTblWorkwRVU02 FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,ProcedureCode
--
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount)              
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider ProviderName,'Work wRVU'ReportName,SUM(wRVUu)wRVU 
FROM (
SELECT ClientID,rv.ReportYear,ReportMonth,AppointmentProvider,CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu                    
FROM #TempTblWorkwRVU02(NOLOCK)cp
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                     
GROUP BY ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units,AppointmentProvider)aa                 
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

/*Update to Financial dashboard*/                    
INSERT INTO PPMReport_FinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)                    
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,ReportName,CPTGroupDesc,TotalCount
FROM #TempTblFinancialDashboards

END
IF OBJECT_ID('tempdb..#TempTblFinancialDashboards') IS NOT NULL DROP TABLE #TempTblFinancialDashboards
IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01
IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02
--SELECT * FROM #TempTblFinancialDashboards
----------------------------------------------------------------------------------------------


/*CPT Report*/
IF (SELECT COUNT(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                    
BEGIN

INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)
SELECT ClientID,CP.ReportYear,ReportMonth,'All Provider' ProviderName,'All Provider' ProviderName,ProcedureCode,CPTGroup,CPTDescription,
UNITS = SUM(ISNULL(BilledUnits,0))
FROM PPMReport_ECW_CPT(NOLOCK) CP
LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.ProcedureCode AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                     
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND CP.ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,CP.ReportYear,ReportMonth,ProcedureCode,CPTGroup,CPTDescription

INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)
SELECT ClientID,CP.ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,ProcedureCode,CPTGroup,CPTDescription,
UNITS = SUM(ISNULL(BilledUnits,0))
FROM PPMReport_ECW_CPT(NOLOCK) CP
LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.ProcedureCode AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                     
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND CP.ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,CP.ReportYear,ReportMonth,AppointmentProvider,ProcedureCode,CPTGroup,CPTDescription
END
---------------------------------------------------------------------------------------------

/*Aging Comparison All Provider*/
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01')<=0
BEGIN

CREATE TABLE #TempTblAC(
ClientID		INT,
ReportYear		INT,
ReportMonth		INT,
ReportName		VARCHAR(50),
ProviderName	VARCHAR(100),
ATBCategory		VARCHAR(50),
[0-30]			DECIMAL(18,2),
[31-60]			DECIMAL(18,2),
[61-90]			DECIMAL(18,2),
[91-120]		DECIMAL(18,2),
[121-150]		DECIMAL(18,2),
[151-180]		DECIMAL(18,2),
[181+]			DECIMAL(18,2),
CategoryBalance DECIMAL(18,2),
DTID			DATE)

/*Insurance AR*/
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,'All Provider'ProviderName,'Insurance AR' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='IB' AND AppointmentProvider = 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth
/*Patient AR*/
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,'All Provider'ProviderName,'Patient AR' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='PB' AND AppointmentProvider = 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth

/*Total AR = sum of Insurance AR & Patient AR*/                    
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,ProviderName,'Total AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                    
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]                    
FROM #TempTblAC GROUP BY ClientID,ReportYear,ReportMonth,ProviderName                    

UPDATE #TempTblAC set DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')

/*Chg Ins %*/                
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Ins %' ATBCategory                    
,[0-30] = ISNULL(Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2),0)
,[31-60] = ISNULL(Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[61-90] = ISNULL(Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[91-120] = ISNULL(Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[121-150] = ISNULL(Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[151-180] = ISNULL(Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[181+] = ISNULL(Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[CategoryBalance] = ISNULL(Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),0),
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid
FROM #TempTblAC cChg 
LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)
WHERE ClientID=@ClientID AND ATBCategory = 'Insurance AR' AND  ReportName = 'Aging-01'                     
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg               
ON cChg.ClientID=ochg.ClientID and cChg.ProviderName = oChg.ProviderName
WHERE cChg.ATBCategory = 'Insurance AR' AND  cChg.ReportName = 'Aging-01'

/*Chg Pat %*/ 
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Pat %' ATBCategory                    
,[0-30] = ISNULL(Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2),0)                    
,[31-60] = ISNULL(Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[61-90] = ISNULL(Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[91-120] = ISNULL(Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[121-150] = ISNULL(Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[151-180] = ISNULL(Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[181+] = ISNULL(Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[CategoryBalance] = ISNULL(Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),0),                    
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid
FROM #TempTblAC cChg 
LEFT JOIN (
SELECT * FROM PPMReport_AgingComparison(NOLOCK)
WHERE ClientID=@ClientID AND ATBCategory = 'Patient AR' AND  ReportName = 'Aging-01'
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))
)oChg
ON cChg.ClientID=ochg.ClientID and cChg.ProviderName = oChg.ProviderName
WHERE cChg.ATBCategory = 'Patient AR' AND  cChg.ReportName = 'Aging-01'                    

/*Total Chg Pat %*/
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Total Chg %' ATBCategory                    
,[0-30] = ISNULL(Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2),0)
,[31-60] = ISNULL(Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[61-90] = ISNULL(Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[91-120] = ISNULL(Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[121-150] = ISNULL(Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[151-180] = ISNULL(Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[181+] = ISNULL(Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[CategoryBalance] = ISNULL(Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),0),
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid
FROM #TempTblAC cChg 
LEFT JOIN 
(SELECT * FROM PPMReport_AgingComparison(NOLOCK)
WHERE ClientID=@ClientID AND ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))
)oChg
ON cChg.ClientID=ochg.ClientID and cChg.ProviderName = oChg.ProviderName
WHERE cChg.ATBCategory = 'Total AR' AND  cChg.ReportName = 'Aging-01'

/*Aging-01 PPMReport AgingComparison All Provider move*/                    
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],[CategoryBalance],DTID)
SELECT ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ProviderName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID
FROM #TempTblAC
END
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC
----------------------------------------------------------------------------------------------------------------

/*Aging Comparison - Aging 02 report*/
IF OBJECT_ID('tempdb..#TempTblAC01') IS NOT NULL DROP TABLE #TempTblAC01
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                     
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02')<=0
BEGIN
CREATE TABLE #TempTblAC01(
ClientID		INT,
ReportYear		INT,
ReportMonth		INT,
ReportName		VARCHAR(50),
ProviderName	VARCHAR(100),
ATBCategory		VARCHAR(50),
[0-30]			DECIMAL(18,2),
[31-60]			DECIMAL(18,2),
[61-90]			DECIMAL(18,2),
[91-120]		DECIMAL(18,2),
[121-150]		DECIMAL(18,2),
[151-180]		DECIMAL(18,2),
[181+]			DECIMAL(18,2),
CategoryBalance DECIMAL(18,2),
TotalPercent	DECIMAL(18,2),
Over90Days		DECIMAL(18,2),
DTID			DATE)

/*Insurance Info All Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,'All Provider'ProviderName,InsuranceGroup AS ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='IB' AND AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup

/*Insurance Info Each Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,AppointmentProvider,InsuranceGroup AS ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='IB' AND AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup

/*Patient Info All Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,'All Provider'ProviderName,'Patient' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='PB' AND AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth

/*Unapplied Info All Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,'All Provider'ProviderName,'Unapplied' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider = 'Summary' AND ReportName = 'CB'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

/*Patient Info Each Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,AppointmentProvider,'Patient' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='PB' AND AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

/*Unapplied Info All Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,AppointmentProvider,'Unapplied' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider != 'Summary' AND ReportName = 'CB'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

UPDATE #TempTblAC01 SET DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')

INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],[CategoryBalance],DTID,TotalPercent,Over90Days)
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,tb.ProviderName,tb.ProviderName,ATBCategory,
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'),
TotalPercent = ISNULL(ROUND(CONVERT(float,SUM([CategoryBalance]) /NULLIF(ISNULL(rf.AccountsReceivable,0),0))*100,2),0),
Over90days = ISNULL(ROUND(CONVERT(FLOAT,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)
FROM #TempTblAC01 tb
LEFT JOIN (
SELECT ReportMonth,ProviderName, AccountsReceivable 
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                     
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear
)rf
ON tb.ProviderName = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,tb.ReportMonth,ReportName,tb.ProviderName,ATBCategory,rf.AccountsReceivable

END
IF OBJECT_ID('tempdb..#TempTblAC01') IS NOT NULL DROP TABLE #TempTblAC01

------------------------------------------------------------------------------------------------

/*Payer Mix*/
if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0
BEGIN
IF OBJECT_ID('tempdb..#TempTblPayerMix') IS NOT NULL DROP TABLE #TempTblPayerMix
CREATE TABLE #TempTblPayerMix(
ClientID		INT,
ReportYear		INT,
ReportMonth		INT,
ProviderName	VARCHAR(200),
InsuranceGroup	VARCHAR(250),
Charges			DECIMAL(18,2),
Payments		DECIMAL(18,2),
Refund			DECIMAL(18,2))

/*All Provider*/
INSERT INTO #TempTblPayerMix(ClientID,ReportYear,ReportMonth,ProviderName,InsuranceGroup,Charges,Payments,Refund)
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,InsuranceGroup,
SUM(ISNULL(BilledCharge,0))Charges,SUM(ISNULL(Payment,0))Payment,SUM(ISNULL(Refund,0))Refund
FROM PPMReport_ECW_PayerMix(NOLOCK)
WHERE AppointmentProvider != 'Summary'
AND ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup

INSERT INTO #TempTblPayerMix(ClientID,ReportYear,ReportMonth,ProviderName,InsuranceGroup,Charges,Payments,Refund)
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'PWOC' InsuranceGroup,0.00,ISNULL(Amount,0)Amount,0.00
FROM PPMReport_ECW_WithoutClaims(NOLOCK)
WHERE PaymentDate = 'Summary' AND ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear

/*Each Provider*/
INSERT INTO #TempTblPayerMix(ClientID,ReportYear,ReportMonth,ProviderName,InsuranceGroup,Charges,Payments,Refund)
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup,
SUM(ISNULL(BilledCharge,0))Charges,SUM(ISNULL(Payment,0))Payment,SUM(ISNULL(Refund,0))Refund
FROM PPMReport_ECW_PayerMix(NOLOCK)
WHERE AppointmentProvider != 'Summary'
AND ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup

INSERT INTO #TempTblPayerMix(ClientID,ReportYear,ReportMonth,ProviderName,InsuranceGroup,Charges,Payments,Refund)
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,'PWOC' InsuranceGroup,0.00,SUM(ISNULL(Amount,0))Amount,0.00
FROM PPMReport_ECW_WithoutClaims(NOLOCK)
WHERE PaymentDate != 'Summary' AND ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)                    
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,InsuranceGroup,Charges,Payments,Refund FROM #TempTblPayerMix
END
IF OBJECT_ID('tempdb..#TempTblPayerMix') IS NOT NULL DROP TABLE #TempTblPayerMix
--------------------------------------------------------------------------------------------------

IF OBJECT_ID('tempdb..#TempTblWorkwRVUall') IS NOT NULL DROP TABLE #TempTblWorkwRVUall
IF OBJECT_ID('tempdb..#TempTblWorkwRVUProv') IS NOT NULL DROP TABLE #TempTblWorkwRVUProv
IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                    
BEGIN
/*Work wRVU All Provider*/
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode CPT,CPTGroup,SUM(BilledUnits)UNITS                    
INTO #TempTblWorkwRVUall FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth                    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup
--
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUYearly,wRVUCount,wRVU)
SELECT ClientID,rv.ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ProviderName/*,CPTGroup*/,CPT,CPTDescription,ISNULL(RV.wRVU,0)YrlyWrvu,cp.Units,
(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVU
FROM #TempTblWorkwRVUall(NOLOCK)cp
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL
GROUP BY ClientID,rv.ReportYear,ReportMonth/*,CPTGroup*/,CPT,CPTDescription,rv.wRVU,Units


/*Work wRVU Each Provider*/
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,ProcedureCode CPT,CPTGroup,SUM(BilledUnits)UNITS                    
INTO #TempTblWorkwRVUProv FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,ProcedureCode,CPTGroup
--
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUYearly,wRVUCount,wRVU)
SELECT ClientID,rv.ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider/*,CPTGroup*/,CPT,CPTDescription,ISNULL(RV.wRVU,0)YrlyWrvu,cp.Units,
(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVU
FROM #TempTblWorkwRVUProv(NOLOCK)cp
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                     
GROUP BY ClientID,rv.ReportYear,ReportMonth/*,CPTGroup*/,CPT,CPTDescription,rv.wRVU,Units,AppointmentProvider
END
IF OBJECT_ID('tempdb..#TempTblWorkwRVUall') IS NOT NULL DROP TABLE #TempTblWorkwRVUall
IF OBJECT_ID('tempdb..#TempTblWorkwRVUProv') IS NOT NULL DROP TABLE #TempTblWorkwRVUProv

end
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECWOutputData]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECWOutputData]  
(@cId int, @Year int, @month int)      
AS      
BEGIN      
DECLARE @ErrorMessage VARCHAR(MAX)      
      
BEGIN TRY               
BEGIN TRANSACTION              
DECLARE @ClientID INT = @cId              
DECLARE @ReportYear INT = @Year              
DECLARE @ReportMonth INT = @month              
DECLARE @RWCount INT=0    
DECLARE @providerList INT = 0    
    
/*Validate Provider name list*/    
if (SELECT COUNT(ClientID) FROM PPMReport_ECW_ProviderNameList(NOLOCK) WHERE ClientID = @ClientID AND IsActive = 1) > 0    
 BEGIN    
  SET @providerList = (SELECT COUNT(ClientID) FROM PPMReport_ECW_ProviderNameList(NOLOCK) WHERE ClientID = @ClientID AND IsActive = 1)    
 END    
ELSE    
 BEGIN    
  SET @providerList = 0    
 END    
       
/*Backup Old Name in charge*/      
UPDATE XL SET XL.XLName = A.EOMName                
FROM(                
SELECT ch.id, pn.ClientID,EOMName,DOPName                
FROM PPMReport_MatchProviderName(NOLOCK)PN                
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH      
ON PN.ClientID = CH.ClientID AND PN.EOMName = CH.AppointmentProvider               
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2      
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName                
)A                
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName                
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
/*Update Provider name as DOP Name in Charge*/      
UPDATE XL SET XL.AppointmentProvider = A.DOPName                
FROM(                
SELECT ch.id, pn.ClientID,EOMName,DOPName                
FROM PPMReport_MatchProviderName(NOLOCK)PN                
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH                
ON PN.ClientID = CH.ClientID AND PN.EOMName = CH.AppointmentProvider                
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2               
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName                
)A                
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName                
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear          
                
---------------------------------------------------    
/*Validate wRVU cliet data*/  
IF OBJECT_ID('tempdb..#TempTblwRVUList') IS NOT NULL DROP TABLE #TempTblwRVUList
SELECT * INTO #TempTblwRVUList
FROM PPMReport_wRVUList(NOLOCK)
WHERE IsActive = 1 AND ReportYear = @ReportYear AND ClientID = 0

if EXISTS(SELECT ID FROM PPMReport_wRVUList(NOLOCK) 
WHERE IsActive = 1 AND ClientID = @ClientID AND ReportYear = @ReportYear)
BEGIN	
	MERGE #TempTblwRVUList TMP
	USING PPMReport_wRVUList(NOLOCK)WR
	ON (TMP.CPTCode = WR.CPTCode AND ISNULL(TMP.Modifier,'') = ISNULL(WR.Modifier,'')
	AND TMP.ReportYear = WR.ReportYear AND WR.ClientID = @ClientID)	
	WHEN MATCHED THEN
		UPDATE SET TMP.CPTDescription = WR.CPTDescription, TMP.wRVU = WR.wRVU
	WHEN NOT MATCHED BY TARGET AND WR.ReportYear = @ReportYear AND WR.ClientID != 0 
	AND WR.IsActive = 1 THEN
		INSERT(ReportYear,CPTCode,Modifier,CPTDescription,wRVU,ClientID,IsActive)
		VALUES(WR.ReportYear,WR.CPTCode,WR.Modifier,WR.CPTDescription,WR.wRVU,WR.ClientID,WR.IsActive)
	;
END
-----

/*-----<<<Start FinancialAnalysis>>>-----*/      
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0      
BEGIN      
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12      
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment      
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays      
      
CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),      
Charges DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),      
AccountsReceivable DECIMAL (18, 2)DEFAULT 0,AROver120 DECIMAL (18, 2)DEFAULT 0,      
ARDaysOutstanding DECIMAL (18, 2)DEFAULT 0,Unapplied DECIMAL (18, 2)DEFAULT 0,      
ClearGage  DECIMAL (18, 2)DEFAULT 0,Collections  DECIMAL (18, 2)DEFAULT 0,DTID DATE)      
      
CREATE TABLE #TempTblPayment(ClientID INT,ReportYear INT,ReportMonth INT,AppointmentProvider VARCHAR(300),      
Charges DECIMAL (18, 2),Payment DECIMAL (18, 2),Refund DECIMAL (18, 2),Amount DECIMAL (18, 2),Contractual DECIMAL (18, 2),      
InsuranceWithheld DECIMAL (18, 2),WriteoffAdjustment DECIMAL (18, 2))      
      
/*All Provider == Charges,Payment,Refund , without pay amt, Adjustments */      
INSERT INTO #TempTblPayment    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.BilledCharge,0)Charge,        
ISNULL(AR.Payment,0)Payment,ISNULL(AR.Refund,0)Refund,ISNULL(WC.Amount,0)Amount,        
ISNULL(AR.Contractual,0)Contractual,ISNULL(AR.InsuranceWithheld,0)InsuranceWithheld,ISNULL(AR.WriteoffAdjustment,0)WriteoffAdjustment        
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR        
LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear         
AND WC.ReportMonth = @ReportMonth AND (WC.PaymentDate = 'Summary'OR WC.AppointmentProvider is null)    
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary')        
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth      
     
/*Individual provider == Charges,Payment,Refund , without pay amt, Adjustments*/    
if @providerList > 0    
 BEGIN      
  INSERT INTO #TempTblPayment    
  SELECT PMT.ClientID,PMT.ReportYear,PMT.ReportMonth,RTRIM(LTRIM(PMT.AppointmentProvider))AppointmentProvider,PMT.Charge,      
  PMT.Payment,PMT.Refund,SUM(ISNULL(WC.Amount,0))Amount,      
  PMT.Contractual,PMT.InsuranceWithheld,PMT.WriteoffAdjustment    
  FROM(    
  SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
  SUM(ISNULL(AR.BilledCharge,0))Charge,      
  SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund,     
  SUM(ISNULL(AR.Contractual,0))Contractual,SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,    
  SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment      
  FROM PPMReport_ECW_ARBeginEnd(NOLOCK) AR    
  INNER JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl     
   ON nl.ClientID = @ClientID AND RTRIM(LTRIM(NL.ProviderName)) = RTRIM(LTRIM(AR.AppointmentProvider))    
  WHERE AR.CLIENTID = @ClientID  AND AR.ReportMonth = @ReportMonth AND AR.ReportYear = @ReportYear    
  AND (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary')   
  AND nl.IsActive = 1  
  GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))    
  )PMT    
  LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC     
  ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth     
  AND WC.AppointmentProvider = PMT.AppointmentProvider AND WC.AppointmentProvider IS NOT NULL    
  GROUP BY PMT.ClientID,PMT.ReportYear,PMT.ReportMonth,RTRIM(LTRIM(PMT.AppointmentProvider)),    
  PMT.Charge,PMT.Payment,PMT.Refund,PMT.Contractual,PMT.InsuranceWithheld,PMT.WriteoffAdjustment    
 END    
ELSE    
 BEGIN    
  INSERT INTO #TempTblPayment    
  SELECT pmt.ClientID,pmt.ReportYear,pmt.ReportMonth,RTRIM(LTRIM(pmt.AppointmentProvider))AppointmentProvider,      
  ISNULL(pmt.Charge,0)Charge,ISNULL(pmt.Payment,0)Payment,pmt.Refund,ISNULL(wAmt.Amount,0)Amount,      
  ISNULL(pmt.Contractual,0)Contractual,ISNULL(pmt.InsuranceWithheld,0)InsuranceWithheld,ISNULL(pmt.WriteoffAdjustment,0)WriteoffAdjustment      
  FROM(      
  SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))AppointmentProvider,    
  SUM(ISNULL(AR.BilledCharge,0))Charge,      
  SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund,SUM(ISNULL(AR.Contractual,0))Contractual,      
  SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment      
  FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR      
  WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary')      
  AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth      
  GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))      
  )pmt      
  LEFT JOIN (SELECT WC.ClientID,WC.ReportYear,WC.ReportMonth,RTRIM(LTRIM(WC.AppointmentProvider))AppointmentProvider,    
  SUM(ISNULL(WC.Amount,0))Amount       
  FROM PPMReport_ECW_WithoutClaims(NOLOCK)WC       
  WHERE WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth       
  AND WC.PaymentDate != 'Summary'      
  GROUP BY WC.ClientID,WC.ReportYear,WC.ReportMonth,RTRIM(LTRIM(WC.AppointmentProvider)))wAmt       
  ON wAmt.ClientID = pmt.ClientID AND wAmt.ReportYear = pmt.ReportYear AND wAmt.ReportMonth = pmt.ReportMonth      
  AND wAmt.AppointmentProvider = pmt.AppointmentProvider    
 END    
    
/*insert in #TempTblpg1to12 table*/      
INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)      
SELECT ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
SUM(Charges)Charges, SUM((Payment-Refund)+Amount)Payment,SUM(Refund)Refund,      
SUM(Contractual+InsuranceWithheld+WriteoffAdjustment)Adjustments,      
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID      
FROM #TempTblPayment      
GROUP BY ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))      
      
/*Update Accounts Receivable */      
UPDATE ARA SET ARA.AccountsReceivable = ISNULL(A.TotalBalance,0),ARA.AROver120 = A.AROver120      
FROM(      
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,SUM(ISNULL(AR.TotalBalance,0))TotalBalance,      
SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120      
FROM PPMReport_ECW_AgingReport(NOLOCK)AR      
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'AS'      
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth      
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth      
UNION      
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))AppointmentProvider,    
SUM(ISNULL(AR.TotalBalance,0))TotalBalance,  SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120      
FROM PPMReport_ECW_AgingReport(NOLOCK)AR      
WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary') AND ReportName = 'AS'      
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth      
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))      
)A      
INNER JOIN #TempTblpg1to12 ARA       
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth     
AND RTRIM(LTRIM(ARA.ProviderName)) = RTRIM(LTRIM(a.AppointmentProvider))      
      
/*ARDaysOutstanding*/                              
SELECT ClientID,ReportMonth,ReportYear,ProviderName,Charges,DTID                              
INTO #TempTblpg1to12ARDays FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)       
WHERE ClientID = @ClientID AND                              
DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                               
DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')                              
SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1      
IF @RWCount = 1      
 BEGIN      
 UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                             
 FROM(      
 SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((ISNULL(Charges,0)/(30)),0),0),0)ARDays                               
 FROM #TempTblpg1to12       
 WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                              
 GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges      
 )AR           
 INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                               
 ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                              
 END      
ELSE      
 BEGIN      
 UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays      
 FROM(      
 SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,      
 ISNULL(NULLIF(ISNULL(ABS(ISNULL(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays                              
 FROM #TempTblpg1to12 AA       
 LEFT JOIN (SELECT ClientID,ProviderName,SUM(ISNULL(Charges,0))Charges       
 FROM #TempTblpg1to12ARDays                               
 GROUP BY  ClientID,ProviderName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName = bb.ProviderName      
 WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear                              
 GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable      
 )AR                              
 INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                               
 ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                              
 END      
      
/*UnappliedBalance*/       
UPDATE ARA SET ARA.Unapplied = ISNULL(A.TotalBalance,0)      
FROM(      
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.TotalBalance,0)TotalBalance      
FROM PPMReport_ECW_AgingReport(NOLOCK)AR      
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'CB'      
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth      
)A      
INNER JOIN #TempTblpg1to12 ARA       
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth     
AND RTRIM(LTRIM(ARA.ProviderName)) = RTRIM(LTRIM(a.AppointmentProvider))       
      
/*Update Cleargage*/        
UPDATE ARA SET ARA.ClearGage = ISNULL(A.ClearGage,0)      
FROM(      
SELECT CL.ID ClientID,CG.ReportYear,CG.ReportMonth,'All Provider' ProviderName,ISNULL(CG.Credit,0)ClearGage      
FROM PPMReport_ClearGage(NOLOCK)CG      
INNER JOIN PPMReport_ClientList(NOLOCK)CL       
ON CL.ID = @ClientID AND CL.ClientFullName = CG.PPMMerchantAccount      
WHERE ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
)A      
INNER JOIN #TempTblpg1to12 ARA       
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName       
      
/*Update Collections*/       
UPDATE ARA SET ARA.Collections = ISNULL(A.Collections,0)      
FROM(      
SELECT ClientID,ReportYear,ReportMonth,SUM(ISNULL(AdjustmentAmount,0))Collections,'All Provider' ProviderName      
FROM PPMReport_ECW_Collection(NOLOCK)      
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth      
)A      
INNER JOIN #TempTblpg1to12 ARA       
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName       
      
/*insert to main table*/      
INSERT INTO PPMReport_ECW_FinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,      
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)      
SELECT ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,      
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID      
FROM #TempTblpg1to12      
END      
      
/*insert to main table Yearly Compare data*/        
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis_YrlyTrend(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0      
BEGIN      
 INSERT INTO PPMReport_ECW_FinancialAnalysis_YrlyTrend(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,      
 AccountsReceivable,AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)      
 SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName,                               
 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,   
 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,                                                      
 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,      
 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,        
 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,                              
 CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,      
 CONVERT(FLOAT,ISNULL(SUM(CY.Unapplied-PY.Unapplied)/NULLIF(ISNULL(SUM(PY.Unapplied),0),0),0))*100 YrlyUnapplied,         
 CONVERT(FLOAT,ISNULL(SUM(CY.ClearGage-PY.ClearGage)/NULLIF(ISNULL(SUM(PY.ClearGage),0),0),0))*100 YrlyClearGage,         
 CONVERT(FLOAT,ISNULL(SUM(CY.Collections-PY.Collections)/NULLIF(ISNULL(SUM(PY.Collections),0),0),0))*100 YrlyCollections,      
 CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,      
 CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID      
 FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)CY       
 LEFT JOIN (SELECT * FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                               
 WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY                               
 ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ProviderName=PY.ProviderName                              
 WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth                              
 GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName                               
END      
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12      
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment      
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays      
/*-----<<<End FinancialAnalysis>>>-----*/      
      
      
/*-----<<<Start CPT Report>>>-----*/      
IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0      
BEGIN      
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT      
/*Get CPTDescription,wRVU info*/      
SELECT CPT.ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription      
INTO #TempTblCPT FROM #TempTblwRVUList(NOLOCK)wrv      
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT      
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL      
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth      
GROUP BY CPT.ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU      
      
/*individual provider*/      
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)      
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
ProcedureCode,cpt.CPTGroup,  CPTDescription,ISNULL(Units,0)Units      
FROM(      
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,CPTGroup,      
SUM(ISNULL(BilledUnits,0))Units      
FROM PPMReport_ECW_CPT(NOLOCK)      
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')      
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider)),CPTGroup      
)cpt      
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt.ProcedureCode      
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth      
      
/*All provider*/      
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)      
SELECT cpt1.ClientID,cpt1.ReportYear,cpt1.ReportMonth,'All Provider','All Provider',cpt1.ProcedureCode,cpt1.CPTGroup,      
CPTDescription,ISNULL(Units,0)Units      
FROM(      
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup,      
SUM(ISNULL(BilledUnits,0))Units      
FROM PPMReport_ECW_CPT(NOLOCK)      
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')      
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup      
)cpt1      
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt1.ProcedureCode      
WHERE cpt1.ClientID = @ClientID AND cpt1.ReportYear = @ReportYear AND cpt1.ReportMonth = @ReportMonth      
      
END      
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT      
/*-----<<<End CPT Report>>>-----*/      
      
      
/*-----<<<Start WRVU Report>>>-----*/      
IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0      
BEGIN      
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU      
/*Get CPTDescription,wRVU info*/      
SELECT CPT.ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU      
INTO #TempTblWRVU FROM #TempTblwRVUList(NOLOCK)wrv      
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT      
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL      
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth      
GROUP BY CPT.ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU      
      
/*individual provider*/      
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)      
      
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
ProcedureCode,CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))      
FROM(      
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,      
SUM(ISNULL(BilledUnits,0))Units      
FROM PPMReport_ECW_CPT(NOLOCK)      
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')      
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider))      
)cpt      
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode      
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth      
and (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')      
      
/*All provider*/      
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)      
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,'All Provider'AppointmentProvider,'All Provider' AppointmentProvider,ProcedureCode,      
CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))      
FROM(      
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,      
SUM(ISNULL(BilledUnits,0))Units      
FROM PPMReport_ECW_CPT(NOLOCK)      
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')      
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode      
)cpt      
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode      
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth      
      
END      
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU      
/*-----<<<End WRVU Report>>>-----*/      
      
      
/*-----<<<Start Financial Dashboard>>>-----*/      
IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0      
BEGIN      
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard      
CREATE TABLE #TempTblFinancialDashboard(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(200),ShortName VARCHAR(200),                              
ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2)DEFAULT 0)      
/*Revenue Analysis*/      
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName, ReportName, TotalCount                             
FROM(      
SELECT  ClientID,ReportYear,ReportMonth,ProviderName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,      
Unapplied,AccountsReceivable,ClearGage,Collections      
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                              
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
) PVT                              
UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,AccountsReceivable,ClearGage,Collections))AS unpvt;          
      
/*Encounter Analysis*/      
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)      
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'Encounter Analysis' ReportName,CPTGroupDesc, SUM(UNITS)UNITS      
FROM PPMReport_ProcedureCount(NOLOCK)                              
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName,CPTGroupDesc      
      
/*CPT Count*/      
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'CPT' ReportName, SUM(UNITS)UNITS      
FROM PPMReport_ProcedureCount(NOLOCK)                              
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName      
      
/*WVRU Count*/      
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'WVRU' ReportName, SUM(wRVU)wRVU      
FROM PPMReport_wRVUReport(NOLOCK)                              
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName      
      
INSERT INTO PPMReport_FinancialDashboard (ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)      
SELECT * FROM #TempTblFinancialDashboard      
ORDER BY 5,6      
      
END      
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard      
/*-----<<<End Financial Dashboard>>>-----*/      
      
      
/*-----<<<Start AgingComparison Report01>>>-----*/      
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC      
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP      
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)      
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01') = 0      
BEGIN      
CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),                              
[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),                              
[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE)                   
      
/*Get insAR patAR*/      
SELECT ClientID,ReportYear,ReportMonth,ReportName ATBCategory,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,      
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],                              
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],                              
SUM(ISNULL(TotalBalance,0))TotalBalance      
INTO #TempTblAGNCOMP FROM PPMReport_ECW_AgingReport(NOLOCK)      
WHERE ReportName IN ('IB','PB') --AND (AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL)                          
AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ClientID = @ClientID      
GROUP BY ClientID,ReportYear,ReportMonth,ReportName,RTRIM(LTRIM(AppointmentProvider))      
ORDER BY 4,5      
UPDATE #TempTblAGNCOMP SET AppointmentProvider = 'All Provider' WHERE AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL      
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Insurance AR' WHERE ATBCategory = 'IB'      
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Patient AR' WHERE ATBCategory = 'PB'      
      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,    
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,ATBCategory,    
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],TotalBalance      
FROM #TempTblAGNCOMP ORDER BY 4,5      
      
/*Total sum calculation*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,    
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,'Total AR' ATBCategory,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                              
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([TotalBalance])TotalBalance                              
FROM #TempTblAGNCOMP      
GROUP BY ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))      
      
UPDATE #TempTblAC SET DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')      
      
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,    
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,RTRIM(LTRIM(ProviderName))ProviderName,RTRIM(LTRIM(ProviderName))ProviderName,ATBCategory,    
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID      
FROM #TempTblAC      
      
/*Total sum % calculation*/      
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)      
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-01',aa.ProviderName,aa.ProviderName,aa.ATBCategory + ' %',      
[0-30] = Round(CONVERT(FLOAT,aa.[0-30]/NULLIF(bb.[0-30],0))*100,2)      
,[31-60] = Round(CONVERT(FLOAT,aa.[31-60]/NULLIF(bb.[CategoryBalance],0))*100,2)      
,[61-90] = Round(CONVERT(FLOAT,aa.[61-90]/NULLIF(bb.[CategoryBalance],0))*100,2)      
,[91-120] = Round(CONVERT(FLOAT,aa.[91-120]/NULLIF(bb.[CategoryBalance],0))*100,2)      
,[121-150] = Round(CONVERT(FLOAT,aa.[121-150]/NULLIF(bb.[CategoryBalance],0))*100,2)      
,[151-180] = Round(CONVERT(FLOAT,aa.[151-180]/NULLIF(bb.[CategoryBalance],0))*100,2)      
,[181+] = Round(CONVERT(FLOAT,aa.[181+]/NULLIF(bb.[CategoryBalance],0))*100,2)      
,[CategoryBalance] = Round(CONVERT(FLOAT,aa.CategoryBalance/NULLIF(bb.[CategoryBalance],0))*100,2),      
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
FROM #TempTblAC aa      
LEFT JOIN PPMReport_AgingComparison(NOLOCK)bb      
ON BB.ClientID = @ClientID AND BB.ProviderName = AA.ProviderName AND aa.ATBCategory = bb.ATBCategory      
AND BB.DTID = DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))      
WHERE AA.ClientID = @ClientID AND BB.ATBCategory IN ('Insurance AR','Patient AR','Total AR') AND  BB.ReportName = 'Aging-01'      
AND AA.ProviderName = 'All Provider'      
      
END      
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC      
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP      
/*-----<<<End AgingComparison Report01>>>-----*/      
      
      
/*-----<<<Start AgingComparison Report02>>>-----*/      
      
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                               
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02') = 0                              
BEGIN                              
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02      
                       
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02' ReportName,RTRIM(LTRIM(tb.AppointmentProvider))AppointmentProvider,InsuranceGroup,      
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]      
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(SUM(ISNULL(rf.AccountsReceivable,0)),0))*100,2),0)      
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)      
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
INTO #TempTblRep02        
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                               
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable       
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                               
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear      
)rf                              
ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                              
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth      
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)      
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,RTRIM(LTRIM(tb.AppointmentProvider)),tb.InsuranceGroup      
UNION      
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,'Patient'InsuranceGroup,      
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance      
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)      
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)    
+ ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)      
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
FROM(      
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,RTRIM(LTRIM(tb.AppointmentProvider))AppointmentProvider,InsuranceGroup,      
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable      
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                               
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable       
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                               
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear      
)rf                              
ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                              
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth      
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)      
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,RTRIM(LTRIM(tb.AppointmentProvider)),tb.InsuranceGroup,rf.AccountsReceivable                                
)aa      
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth,RTRIM(LTRIM(aa.AppointmentProvider))      
UNION      
/*GET all provider details*/      
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,'All Provider',InsuranceGroup,      
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]      
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(ISNULL(SUM(rf.AccountsReceivable),0),0))*100,2),0)      
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)      
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                               
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable       
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                               
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear      
)rf                              
ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                              
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth      
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)      
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.InsuranceGroup      
UNION      
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,'All Provider','Patient'InsuranceGroup,      
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance      
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)      
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)      
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
FROM(      
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,InsuranceGroup,      
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable      
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                               
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable       
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                               
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear      
)rf            
ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                              
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth      
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)      
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,tb.InsuranceGroup,rf.AccountsReceivable                                
)aa      
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth      
      
      
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],                              
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)       
SELECT ClientID,ReportYear,ReportMonth,ReportName,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
InsuranceGroup,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercentage,Over90days,dtid      
FROM #TempTblRep02      
      
END      
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02      
      
/*-----<<<End AgingComparison Report02>>>-----*/      
       
/*-----<<<Start Payer Mix >>>-----*/    
IF OBJECT_ID('tempdb..#TempTblPName') IS NOT NULL DROP TABLE #TempTblPName      
if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0      
BEGIN    
    
DECLARE @strSql1 AS VARCHAR(MAX),@strSql AS VARCHAR(MAX)    
IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName    
SET @strSql1 += ''    
SET @strSql1 = 'SELECT pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider    
INTO ##TempTblPName FROM PPMReport_ECW_PayerMix(NOLOCK)pm '    
if @providerList > 0    
BEGIN    
SET @strSql1 += '   
LEFT JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl     
ON nl.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND RTRIM(LTRIM(NL.ProviderName)) = RTRIM(LTRIM(pm.AppointmentProvider))    
AND nl.IsActive = 1 '    
END    
SET @strSql1 += 'WHERE pm.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND ReportYear = ' + CONVERT(VARCHAR,@ReportYear) +     
' AND ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth) +     
' AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)    
GROUP BY pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))'    
EXEC (@strSql1)      
-----    
SET @strSql += ''    
SET @strSql = 'SELECT pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,    
RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,InsuranceGroup,    
SUM(ISNULL(BilledCharge,0))Charges,    
Payment = (SUM(ISNULL(Payment,0)) - SUM(ISNULL(Refund,0))),    
SUM(ISNULL(Refund,0))Refund      
FROM PPMReport_ECW_PayerMix(NOLOCK)pm   
'    
if @providerList > 0    
BEGIN    
SET @strSql += ' INNER JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl     
ON nl.ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND RTRIM(LTRIM(NL.ProviderName)) = RTRIM(LTRIM(pm.AppointmentProvider))   
AND nl.IsActive = 1'     
END    
SET @strSql += 'WHERE pm.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND pm.ReportYear = ' + CONVERT(VARCHAR,@ReportYear) +    
' AND pm.ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth)+       
' AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)      
GROUP BY pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(pm.AppointmentProvider)),InsuranceGroup      
UNION      
SELECT wc.ClientID,wc.ReportYear,wc.ReportMonth,RTRIM(LTRIM(wc.AppointmentProvider))AppointmentProvider,    
RTRIM(LTRIM(wc.AppointmentProvider))AppointmentProvider,''PWOC'' InsuranceGroup,      
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund      
FROM PPMReport_ECW_WithoutClaims(NOLOCK)wc    
INNER JOIN ##TempTblPName pn    
ON RTRIM(LTRIM(wc.AppointmentProvider)) = pn.AppointmentProvider      
WHERE wc.ClientID = ' + CONVERT(VARCHAR,@ClientID) +' AND wc.ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+     
' and wc.ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth ) + ' AND (PaymentDate != ''Summary'' AND PaymentDate IS NOT NULL)      
GROUP BY wc.ClientID,wc.ReportYear,wc.ReportMonth,RTRIM(LTRIM(wc.AppointmentProvider))        
UNION      
/*All Provider*/      
SELECT ClientID,ReportYear,ReportMonth,''All Provider'' AppointmentProvider,''All Provider'' AppointmentProvider,InsuranceGroup,      
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))-SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund      
FROM PPMReport_ECW_PayerMix(NOLOCK)      
WHERE ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+    
' AND ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth) +    
' AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)      
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup      
UNION      
SELECT wcc.ClientID,wcc.ReportYear,wcc.ReportMonth,''All Provider'' AppointmentProvider,''All Provider'' AppointmentProvider,''PWOC''InsuranceGroup,      
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund      
FROM PPMReport_ECW_WithoutClaims(NOLOCK)wcc      
LEFT JOIN ##TempTblPName(NOLOCK)nl     
ON nl.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND RTRIM(LTRIM(NL.AppointmentProvider)) = RTRIM(LTRIM(wcc.AppointmentProvider))     
WHERE wcc.ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND wcc.ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+    
' AND wcc.ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth)+      
' AND (PaymentDate != ''Summary'' AND PaymentDate IS NOT NULL)      
GROUP BY wcc.ClientID,wcc.ReportYear,wcc.ReportMonth '     
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)    
EXEC(@strSql)    
IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName    
      
END    
/*-----<<<End Payer Mix >>>-----*/      
      
COMMIT TRANSACTION               
SET @ErrorMessage = 'Sucess'               
END TRY                          
                            
BEGIN CATCH                          
ROLLBACK TRANSACTION                
SET @ErrorMessage = ERROR_MESSAGE()                    
END CATCH    
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12      
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment      
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays    
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT    
IF OBJECT_ID('tempdb..#TempTblPName') IS NOT NULL DROP TABLE #TempTblPName     
IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName              
IF OBJECT_ID('tempdb..#TempTblwRVUList') IS NOT NULL DROP TABLE #TempTblwRVUList
SELECT CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage              
END
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECWOutputData_00]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PPMReport_ECWOutputData_00] 
(@cId int, @Year int, @month int)
AS
BEGIN
DECLARE @ErrorMessage VARCHAR(MAX)

BEGIN TRY         
BEGIN TRANSACTION        
DECLARE @ClientID INT = @cId        
DECLARE @ReportYear INT = @Year        
DECLARE @ReportMonth INT = @month        
DECLARE @RWCount INT=0
DECLARE @ProjectID INT = 2
    
/*Backup Old Name in charge*/      
UPDATE XL SET XL.XLName = A.EOMName      
FROM(      
SELECT ch.id, pn.ClientID,EOMName,DOPName      
FROM PPMReport_MatchProviderName(NOLOCK)PN      
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH      
ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.AppointmentProvider
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName
)A      
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName      
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear      

/*Update Provider name as DOP Name in Charge*/
UPDATE XL SET XL.AppointmentProvider = A.DOPName      
FROM(      
SELECT ch.id, pn.ClientID,EOMName,DOPName      
FROM PPMReport_MatchProviderName(NOLOCK)PN      
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH      
ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.AppointmentProvider      
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName      
)A      
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName      
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear      


if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)<=0                    
BEGIN
IF OBJECT_ID('tempdb..#TempTblFinancialAnalysis') IS NOT NULL DROP TABLE #TempTblFinancialAnalysis
IF OBJECT_ID('tempdb..#TempTblFinancialAnalysisARDays') IS NOT NULL DROP TABLE #TempTblFinancialAnalysisARDays

CREATE TABLE #TempTblFinancialAnalysis(
ClientID			INT,
ReportYear			INT,
ReportMonth			INT,
ProviderName		VARCHAR(200),                    
Charges				DECIMAL(18, 2),
Payments			DECIMAL(18, 2),	
Adjustments			DECIMAL(18, 2),	
AccountsReceivable	DECIMAL(18, 2),
AROver120			DECIMAL(18, 2),
ARDaysOutstanding	DECIMAL(18, 2),
Unapplied			DECIMAL(18, 2),
ClearGage			DECIMAL(18, 2),
Collections			DECIMAL(18, 2),
Refunds				DECIMAL(18, 2),
DTID				DATE)

/*All Provider Charges*/
INSERT INTO #TempTblFinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,ClearGage,DTID)
SELECT ClientID,ReportYear,ReportMonth,'All Provider' ProviderName, BilledCharge AS Charges,0.00 ClearGage,
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID 
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) 
WHERE AppointmentProvider = 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth

/*Each Provider Charges*/
INSERT INTO #TempTblFinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,DTID)
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,SUM(ISNULL(BilledCharge,0)) Charges,
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) WHERE AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

/*All Provider Payments*/
UPDATE PAY SET PAY.Payments = aa.Payments                                                        
FROM 
(SELECT A.ClientID,A.ReportYear,A.ReportMonth,'All Provider'ProviderName,
Payments = SUM((ISNULL(A.Payment,0)-ISNULL(A.Refund,0))+ISNULL(A.Amount,0))
FROM(
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.Payment,AR.Refund,WOC.Amount
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WOC ON WOC.PaymentDate = 'Summary'
AND AR.ClientID = WOC.ClientID AND AR.ReportYear = WOC.ReportYear AND AR.ReportMonth = WOC.ReportMonth
WHERE AR.AppointmentProvider = 'Summary' 
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth
)a GROUP BY A.ClientID,A.ReportYear,A.ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis PAY ON PAY.ClientID = aa.ClientID AND PAY.ReportYear = aa.ReportYear                     
AND PAY.ReportMonth = aa.ReportMonth AND PAY.ProviderName = aa.ProviderName


/*Each Provider Payments*/
UPDATE PAY SET PAY.Payments = aa.Payments                                                        
FROM 
(SELECT A.ClientID,A.ReportYear,A.ReportMonth,AppointmentProvider,
Payments = SUM((ISNULL(A.Payment,0)-ISNULL(A.Refund,0))+ISNULL(A.Amount,0))
FROM(
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,ar.AppointmentProvider,AR.Payment,AR.Refund,WOC.Amount
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WOC ON WOC.PaymentDate != 'Summary'
AND AR.ClientID = WOC.ClientID AND AR.ReportYear = WOC.ReportYear AND AR.ReportMonth = WOC.ReportMonth
WHERE AR.AppointmentProvider != 'Summary' AND AR.AppointmentProvider = WOC.AppointmentProvider
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth
)a GROUP BY A.ClientID,A.ReportYear,A.ReportMonth,a.AppointmentProvider
) aa
INNER JOIN #TempTblFinancialAnalysis PAY ON PAY.ClientID = aa.ClientID AND PAY.ReportYear = aa.ReportYear                     
AND PAY.ReportMonth = aa.ReportMonth AND PAY.ProviderName = aa.AppointmentProvider

/*All Provider Adjustments*/
UPDATE ADJ SET ADJ.Adjustments = aa.Adjustments                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,
Adjustments = SUM(ISNULL(Contractual,0)+ISNULL(InsuranceWithheld,0)+ISNULL(WriteoffAdjustment,0))
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) 
WHERE AppointmentProvider = 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis ADJ ON ADJ.ClientID = aa.ClientID AND ADJ.ReportYear = aa.ReportYear                     
AND ADJ.ReportMonth = aa.ReportMonth AND ADJ.ProviderName = aa.ProviderName

/*Each Provider Adjustments*/
UPDATE ADJ SET ADJ.Adjustments = aa.Adjustments                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider ProviderName,
Adjustments = SUM(ISNULL(Contractual,0)+ISNULL(InsuranceWithheld,0)+ISNULL(WriteoffAdjustment,0))
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) 
WHERE AppointmentProvider != 'Summary' 
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider
) aa
INNER JOIN #TempTblFinancialAnalysis ADJ ON ADJ.ClientID = aa.ClientID AND ADJ.ReportYear = aa.ReportYear                     
AND ADJ.ReportMonth = aa.ReportMonth AND ADJ.ProviderName = aa.ProviderName

/*All Provider Accounts Receivable*/
UPDATE AR SET AR.AccountsReceivable = aa.TotalBalance                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,TotalBalance,'All Provider'ProviderName
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider = 'Summary' AND ReportName = 'AS'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis AR ON AR.ClientID = aa.ClientID AND AR.ReportYear = aa.ReportYear                     
AND AR.ReportMonth = aa.ReportMonth AND AR.ProviderName = aa.ProviderName

/*Each Provider Accounts Receivable*/
UPDATE AR SET AR.AccountsReceivable = aa.AR                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,SUM(ISNULL(TotalBalance,0))AR
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider != 'Summary' AND ReportName = 'AS'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider
) aa
INNER JOIN #TempTblFinancialAnalysis AR ON AR.ClientID = aa.ClientID AND AR.ReportYear = aa.ReportYear                     
AND AR.ReportMonth = aa.ReportMonth AND AR.ProviderName = aa.AppointmentProvider

/*All Provider AR Over 120*/
UPDATE AR SET AR.AROver120 = aa.AR120                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,
AR120 = SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider = 'Summary' AND ReportName = 'AS'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis AR ON AR.ClientID = aa.ClientID AND AR.ReportYear = aa.ReportYear                     
AND AR.ReportMonth = aa.ReportMonth AND AR.ProviderName = aa.ProviderName

/*Each Provider AR Over 120*/
UPDATE AR SET AR.AROver120 = aa.AR120                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,
AR120 = SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider != 'Summary' AND ReportName = 'AS'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider
) aa
INNER JOIN #TempTblFinancialAnalysis AR ON AR.ClientID = aa.ClientID AND AR.ReportYear = aa.ReportYear                     
AND AR.ReportMonth = aa.ReportMonth AND AR.ProviderName = aa.AppointmentProvider


/*ARDaysOutstanding*/                    
SELECT ClientID,ReportMonth,ReportYear,ProviderName,Charges,DTID                    
INTO #TempTblFinancialAnalysisARDays FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID = @ClientID AND
DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                     
DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')

SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblFinancialAnalysisARDays)+1
IF @RWCount = 1
BEGIN
	UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays
	FROM(SELECT ClientID,ReportYear,ReportMonth,ProviderName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((ISNULL(Charges,0)/(30)),0),0),0)ARDays                     
	FROM #TempTblFinancialAnalysis WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                    
	GROUP BY ClientID,ReportYear,ReportMonth,ProviderName,AccountsReceivable,Charges)AR                    
	INNER JOIN #TempTblFinancialAnalysis ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                     
	ARD.ReportMonth = AR.ReportMonth AND ARD.ProviderName = AR.ProviderName
END                    
ELSE
BEGIN
	UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays
	FROM(SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ProviderName,
	ISNULL(NULLIF(ISNULL(ABS(isnull(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays
	FROM #TempTblFinancialAnalysis AA LEFT JOIN (SELECT ClientID,ProviderName,SUM(ISNULL(Charges,0))Charges FROM #TempTblFinancialAnalysisARDays
	GROUP BY  ClientID,ProviderName) bb ON aa.ClientID = bb.ClientID AND aa.ProviderName=bb.ProviderName
	WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear
	GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ProviderName,aa.AccountsReceivable)AR
	INNER JOIN #TempTblFinancialAnalysis ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND
	ARD.ReportMonth = AR.ReportMonth AND ARD.ProviderName = AR.ProviderName
END

/*All Provider Unapplied*/
UPDATE UA SET UA.Unapplied = aa.Unapplied                                                        
FROM 
(SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,TotalBalance Unapplied
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider = 'Summary' AND ReportName = 'CB'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis UA ON UA.ClientID = aa.ClientID AND UA.ReportYear = aa.ReportYear                     
AND UA.ReportMonth = aa.ReportMonth AND UA.ProviderName = aa.ProviderName

-----------------------------------------------------NEED CLEARGAGE DETAILS TO UPDATE FURTHER
/*Update Cleargage*/                    
UPDATE CG SET CG.ClearGage = aa.Credit
FROM (
SELECT CL.ID,CGG.ReportMonth,CGG.ReportYear,'All Provider'ProviderName,CGG.Credit
FROM PPMReport_ClientList(NOLOCK)CL 
LEFT JOIN PPMReport_ClearGage(NOLOCK)CGG ON CL.ClientFullName = CGG.PPMMerchantAccount
WHERE IsActive = 1 AND Project = @ProjectID AND CL.ID = @ClientID AND CGG.ReportYear = @ReportYear AND CGG.ReportMonth = @ReportMonth
) aa
INNER JOIN PPMReport_ClearGage_Collection(NOLOCK) CG ON CG.ClientID = aa.ID AND CG.ReportYear = aa.ReportYear
AND CG.ReportMonth = aa.ReportMonth AND CG.ProviderName = aa.ProviderName


/*All Provider Collectioin*/
UPDATE COLL SET COLL.Collections = aa.Collections
FROM 
(SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(AdjustmentAmount,0))Collections
FROM PPMReport_ECW_Collection(NOLOCK) 
--WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis COLL ON COLL.ClientID = aa.ClientID AND COLL.ReportYear = aa.ReportYear                     
AND COLL.ReportMonth = aa.ReportMonth AND COLL.ProviderName = aa.ProviderName


/*All Provider Refunds*/
UPDATE RF SET RF.Refunds = aa.Refund
FROM 
(SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(Refund,0))Refund
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) 
WHERE AppointmentProvider = 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth
) aa
INNER JOIN #TempTblFinancialAnalysis RF ON RF.ClientID = aa.ClientID AND RF.ReportYear = aa.ReportYear                     
AND RF.ReportMonth = aa.ReportMonth AND RF.ProviderName = aa.ProviderName

/*Each Provider Refunds*/
UPDATE RF SET RF.Refunds = aa.Refund
FROM 
(SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider ProviderName,SUM(ISNULL(Refund,0)) Refund
FROM PPMReport_ECW_ARBeginEnd(NOLOCK) 
WHERE AppointmentProvider != 'Summary'AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider
) aa
INNER JOIN #TempTblFinancialAnalysis RF ON RF.ClientID = aa.ClientID AND RF.ReportYear = aa.ReportYear                     
AND RF.ReportMonth = aa.ReportMonth AND RF.ProviderName = aa.ProviderName

/*Final Data moved to FinancialAnalysis table*/
INSERT INTO PPMReport_ECW_FinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,                    
Payments,Refunds,Adjustments,Unapplied,AccountsReceivable,AROver120,ARDaysOutstanding,DTID)                    
SELECT ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Refunds,ABS(ISNULL(Adjustments,0))Adjustments,
ISNULL(Unapplied,0)Unapplied,AccountsReceivable,AROver120,ARDaysOutstanding,DTID 
FROM #TempTblFinancialAnalysis

UPDATE PPMReport_ECW_FinancialAnalysis SET ClearGage = ISNULL(ClearGage,0),Collections = ISNULL(Collections,0)
WHERE ClientID=@ClientID AND ReportYear=@ReportYear AND ReportMonth=@ReportMonth

/*Yearly Compare*/
INSERT INTO PPMReport_ECW_FinancialAnalysis_YrlyTrend(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)
SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName,                     
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 AS Charges,
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 AS Payments,
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 AS Adjustments,
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 AS AccountsReceivable,
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 AS AROver120,
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 AS ARDaysOutstanding,
CONVERT(FLOAT,ISNULL(SUM(CY.Unapplied-PY.Unapplied)/NULLIF(ISNULL(SUM(PY.Unapplied),0),0),0))*100 AS Unapplied,
CONVERT(FLOAT,ISNULL(SUM(CY.ClearGage-PY.ClearGage)/NULLIF(ISNULL(SUM(PY.ClearGage),0),0),0))*100 AS ClearGage,
CONVERT(FLOAT,ISNULL(SUM(CY.Collections-PY.Collections)/NULLIF(ISNULL(SUM(PY.Collections),0),0),0))*100 AS Collections,
CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 AS Refunds,
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID
FROM #TempTblFinancialAnalysis(NOLOCK)CY 
LEFT JOIN (
SELECT * FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) 
)PY
ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ProviderName=PY.ProviderName
WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth
GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName

End
IF OBJECT_ID('tempdb..#TempTblFinancialAnalysis') IS NOT NULL DROP TABLE #TempTblFinancialAnalysis
IF OBJECT_ID('tempdb..#TempTblFinancialAnalysisARDays') IS NOT NULL DROP TABLE #TempTblFinancialAnalysisARDays

--SELECT * FROM #TempTblFinancialAnalysis
------------------------------------------------------------------------------------------------------------------------------------
--==================================================================================================================================


IF OBJECT_ID('tempdb..#TempTblFinancialDashboards') IS NOT NULL DROP TABLE #TempTblFinancialDashboards
IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01
IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02

IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear) <= 0                    
BEGIN
CREATE TABLE #TempTblFinancialDashboards(
ClientID		INT,
ReportYear		INT,
ReportMonth		INT,
ProviderName	VARCHAR(100),
ReportName		VARCHAR(100),
CPTGroupDesc	VARCHAR(100),
TotalCount		DECIMAL (18,2))

/*
<<Financial Dashboard>>
Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,AccountsReceivable,Collections,ClearGage
 */
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount)
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount
FROM (
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,
AccountsReceivable,Collections,ClearGage 
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
) PVT
UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,
AccountsReceivable,Collections,ClearGage))AS unpvt;
UPDATE #TempTblFinancialDashboards SET ReportName = 'Net Receipts' WHERE ReportName = 'Payments'

/*Encounter Analysis All Provider*/
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,CPTGroupDesc,TotalCount)
SELECT ClientID,ReportYear,ReportMonth,'All Provider' ProviderName,'EncounterAnalysis'ReportName, CPTGroup,UNITS = SUM(BilledUnits)
FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,CPTGroup

/*Encounter Analysis Each Provider*/
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,CPTGroupDesc,TotalCount)
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,'EncounterAnalysis'ReportName, CPTGroup,UNITS = SUM(BilledUnits)
FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,CPTGroup

/*CPT Counts All Provider*/
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount)
SELECT ClientID,ReportYear,ReportMonth, 'All Provider' ProviderName,'CPT Counts'ReportName,ISNULL(BilledUnits,0)Units 
FROM PPMReport_ECW_CPT(NOLOCK) 
WHERE AppointmentProvider = 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth

/*CPT Counts All Provider*/
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount)
SELECT ClientID,ReportYear,ReportMonth, AppointmentProvider ProviderName,'CPT Counts'ReportName,SUM(ISNULL(BilledUnits,0))Units 
FROM PPMReport_ECW_CPT(NOLOCK) 
WHERE AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth, AppointmentProvider

/*Work wRVU All Provider*/
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode CPT,SUM(BilledUnits)UNITS                    
INTO #TempTblWorkwRVU01 FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth                    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode
--
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount)
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'Work wRVU'ReportName,SUM(wRVUu)wRVU
FROM (
SELECT ClientID,rv.ReportYear,ReportMonth,CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu                    
FROM #TempTblWorkwRVU01(NOLOCK)cp
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL
GROUP BY ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units
)aa
GROUP BY ClientID,ReportYear,ReportMonth

/*Work wRVU Each Provider*/
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,ProcedureCode CPT,SUM(BilledUnits)UNITS                    
INTO #TempTblWorkwRVU02 FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,ProcedureCode
--
INSERT INTO #TempTblFinancialDashboards(ClientID,ReportYear,ReportMonth,ProviderName,ReportName,TotalCount)              
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider ProviderName,'Work wRVU'ReportName,SUM(wRVUu)wRVU 
FROM (
SELECT ClientID,rv.ReportYear,ReportMonth,AppointmentProvider,CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu                    
FROM #TempTblWorkwRVU02(NOLOCK)cp
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                     
GROUP BY ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units,AppointmentProvider)aa                 
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

/*Update to Financial dashboard*/                    
INSERT INTO PPMReport_FinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)                    
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,ReportName,CPTGroupDesc,TotalCount
FROM #TempTblFinancialDashboards

END
IF OBJECT_ID('tempdb..#TempTblFinancialDashboards') IS NOT NULL DROP TABLE #TempTblFinancialDashboards
IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01
IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02
--SELECT * FROM #TempTblFinancialDashboards
----------------------------------------------------------------------------------------------


/*CPT Report*/
IF (SELECT COUNT(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                    
BEGIN

INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)
SELECT ClientID,CP.ReportYear,ReportMonth,'All Provider' ProviderName,'All Provider' ProviderName,ProcedureCode,CPTGroup,CPTDescription,
UNITS = SUM(ISNULL(BilledUnits,0))
FROM PPMReport_ECW_CPT(NOLOCK) CP
LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.ProcedureCode AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                     
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND CP.ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,CP.ReportYear,ReportMonth,ProcedureCode,CPTGroup,CPTDescription

INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)
SELECT ClientID,CP.ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,ProcedureCode,CPTGroup,CPTDescription,
UNITS = SUM(ISNULL(BilledUnits,0))
FROM PPMReport_ECW_CPT(NOLOCK) CP
LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.ProcedureCode AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                     
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND CP.ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,CP.ReportYear,ReportMonth,AppointmentProvider,ProcedureCode,CPTGroup,CPTDescription
END
---------------------------------------------------------------------------------------------

/*Aging Comparison All Provider*/
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01')<=0
BEGIN

CREATE TABLE #TempTblAC(
ClientID		INT,
ReportYear		INT,
ReportMonth		INT,
ReportName		VARCHAR(50),
ProviderName	VARCHAR(100),
ATBCategory		VARCHAR(50),
[0-30]			DECIMAL(18,2),
[31-60]			DECIMAL(18,2),
[61-90]			DECIMAL(18,2),
[91-120]		DECIMAL(18,2),
[121-150]		DECIMAL(18,2),
[151-180]		DECIMAL(18,2),
[181+]			DECIMAL(18,2),
CategoryBalance DECIMAL(18,2),
DTID			DATE)

/*Insurance AR*/
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,'All Provider'ProviderName,'Insurance AR' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='IB' AND AppointmentProvider = 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth
/*Patient AR*/
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,'All Provider'ProviderName,'Patient AR' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='PB' AND AppointmentProvider = 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth

/*Total AR = sum of Insurance AR & Patient AR*/                    
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,ProviderName,'Total AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                    
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]                    
FROM #TempTblAC GROUP BY ClientID,ReportYear,ReportMonth,ProviderName                    

UPDATE #TempTblAC set DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')

/*Chg Ins %*/                
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Ins %' ATBCategory                    
,[0-30] = ISNULL(Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2),0)
,[31-60] = ISNULL(Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[61-90] = ISNULL(Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[91-120] = ISNULL(Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[121-150] = ISNULL(Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[151-180] = ISNULL(Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[181+] = ISNULL(Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[CategoryBalance] = ISNULL(Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),0),
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid
FROM #TempTblAC cChg 
LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)
WHERE ClientID=@ClientID AND ATBCategory = 'Insurance AR' AND  ReportName = 'Aging-01'                     
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg               
ON cChg.ClientID=ochg.ClientID and cChg.ProviderName = oChg.ProviderName
WHERE cChg.ATBCategory = 'Insurance AR' AND  cChg.ReportName = 'Aging-01'

/*Chg Pat %*/ 
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Pat %' ATBCategory                    
,[0-30] = ISNULL(Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2),0)                    
,[31-60] = ISNULL(Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[61-90] = ISNULL(Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[91-120] = ISNULL(Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[121-150] = ISNULL(Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[151-180] = ISNULL(Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[181+] = ISNULL(Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[CategoryBalance] = ISNULL(Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),0),                    
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid
FROM #TempTblAC cChg 
LEFT JOIN (
SELECT * FROM PPMReport_AgingComparison(NOLOCK)
WHERE ClientID=@ClientID AND ATBCategory = 'Patient AR' AND  ReportName = 'Aging-01'
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))
)oChg
ON cChg.ClientID=ochg.ClientID and cChg.ProviderName = oChg.ProviderName
WHERE cChg.ATBCategory = 'Patient AR' AND  cChg.ReportName = 'Aging-01'                    

/*Total Chg Pat %*/
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Total Chg %' ATBCategory                    
,[0-30] = ISNULL(Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2),0)
,[31-60] = ISNULL(Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[61-90] = ISNULL(Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[91-120] = ISNULL(Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[121-150] = ISNULL(Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[151-180] = ISNULL(Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[181+] = ISNULL(Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)
,[CategoryBalance] = ISNULL(Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),0),
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid
FROM #TempTblAC cChg 
LEFT JOIN 
(SELECT * FROM PPMReport_AgingComparison(NOLOCK)
WHERE ClientID=@ClientID AND ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))
)oChg
ON cChg.ClientID=ochg.ClientID and cChg.ProviderName = oChg.ProviderName
WHERE cChg.ATBCategory = 'Total AR' AND  cChg.ReportName = 'Aging-01'

/*Aging-01 PPMReport AgingComparison All Provider move*/                    
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],[CategoryBalance],DTID)
SELECT ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ProviderName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID
FROM #TempTblAC
END
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC
----------------------------------------------------------------------------------------------------------------

/*Aging Comparison - Aging 02 report*/
IF OBJECT_ID('tempdb..#TempTblAC01') IS NOT NULL DROP TABLE #TempTblAC01
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                     
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02')<=0
BEGIN
CREATE TABLE #TempTblAC01(
ClientID		INT,
ReportYear		INT,
ReportMonth		INT,
ReportName		VARCHAR(50),
ProviderName	VARCHAR(100),
ATBCategory		VARCHAR(50),
[0-30]			DECIMAL(18,2),
[31-60]			DECIMAL(18,2),
[61-90]			DECIMAL(18,2),
[91-120]		DECIMAL(18,2),
[121-150]		DECIMAL(18,2),
[151-180]		DECIMAL(18,2),
[181+]			DECIMAL(18,2),
CategoryBalance DECIMAL(18,2),
TotalPercent	DECIMAL(18,2),
Over90Days		DECIMAL(18,2),
DTID			DATE)

/*Insurance Info All Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,'All Provider'ProviderName,InsuranceGroup AS ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='IB' AND AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup

/*Insurance Info Each Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,AppointmentProvider,InsuranceGroup AS ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='IB' AND AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup

/*Patient Info All Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,'All Provider'ProviderName,'Patient' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='PB' AND AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth

/*Unapplied Info All Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,'All Provider'ProviderName,'Unapplied' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider = 'Summary' AND ReportName = 'CB'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

/*Patient Info Each Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,AppointmentProvider,'Patient' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK)
WHERE ReportName ='PB' AND AppointmentProvider != 'Summary'
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

/*Unapplied Info All Provider*/
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],
[91-120],[121-150],[151-180],[181+],CategoryBalance)
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,AppointmentProvider,'Unapplied' ATBCategory,
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],
SUM(ISNULL(TotalBalance,0))[CategoryBalance]
FROM PPMReport_ECW_AgingReport(NOLOCK) 
WHERE AppointmentProvider != 'Summary' AND ReportName = 'CB'
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

UPDATE #TempTblAC01 SET DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')

INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],[CategoryBalance],DTID,TotalPercent,Over90Days)
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,tb.ProviderName,tb.ProviderName,ATBCategory,
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'),
TotalPercent = ISNULL(ROUND(CONVERT(float,SUM([CategoryBalance]) /NULLIF(ISNULL(rf.AccountsReceivable,0),0))*100,2),0),
Over90days = ISNULL(ROUND(CONVERT(FLOAT,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)
FROM #TempTblAC01 tb
LEFT JOIN (
SELECT ReportMonth,ProviderName, AccountsReceivable 
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                     
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear
)rf
ON tb.ProviderName = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,tb.ReportMonth,ReportName,tb.ProviderName,ATBCategory,rf.AccountsReceivable

END
IF OBJECT_ID('tempdb..#TempTblAC01') IS NOT NULL DROP TABLE #TempTblAC01

------------------------------------------------------------------------------------------------

/*Payer Mix*/
if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0
BEGIN
IF OBJECT_ID('tempdb..#TempTblPayerMix') IS NOT NULL DROP TABLE #TempTblPayerMix
CREATE TABLE #TempTblPayerMix(
ClientID		INT,
ReportYear		INT,
ReportMonth		INT,
ProviderName	VARCHAR(200),
InsuranceGroup	VARCHAR(250),
Charges			DECIMAL(18,2),
Payments		DECIMAL(18,2),
Refund			DECIMAL(18,2))

/*All Provider*/
INSERT INTO #TempTblPayerMix(ClientID,ReportYear,ReportMonth,ProviderName,InsuranceGroup,Charges,Payments,Refund)
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,InsuranceGroup,
SUM(ISNULL(BilledCharge,0))Charges,SUM(ISNULL(Payment,0))Payment,SUM(ISNULL(Refund,0))Refund
FROM PPMReport_ECW_PayerMix(NOLOCK)
WHERE AppointmentProvider != 'Summary'
AND ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup

INSERT INTO #TempTblPayerMix(ClientID,ReportYear,ReportMonth,ProviderName,InsuranceGroup,Charges,Payments,Refund)
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'PWOC' InsuranceGroup,0.00,ISNULL(Amount,0)Amount,0.00
FROM PPMReport_ECW_WithoutClaims(NOLOCK)
WHERE PaymentDate = 'Summary' AND ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear

/*Each Provider*/
INSERT INTO #TempTblPayerMix(ClientID,ReportYear,ReportMonth,ProviderName,InsuranceGroup,Charges,Payments,Refund)
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup,
SUM(ISNULL(BilledCharge,0))Charges,SUM(ISNULL(Payment,0))Payment,SUM(ISNULL(Refund,0))Refund
FROM PPMReport_ECW_PayerMix(NOLOCK)
WHERE AppointmentProvider != 'Summary'
AND ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup

INSERT INTO #TempTblPayerMix(ClientID,ReportYear,ReportMonth,ProviderName,InsuranceGroup,Charges,Payments,Refund)
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,'PWOC' InsuranceGroup,0.00,SUM(ISNULL(Amount,0))Amount,0.00
FROM PPMReport_ECW_WithoutClaims(NOLOCK)
WHERE PaymentDate != 'Summary' AND ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider

INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)                    
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,InsuranceGroup,Charges,Payments,Refund FROM #TempTblPayerMix
END
IF OBJECT_ID('tempdb..#TempTblPayerMix') IS NOT NULL DROP TABLE #TempTblPayerMix
--------------------------------------------------------------------------------------------------

IF OBJECT_ID('tempdb..#TempTblWorkwRVUall') IS NOT NULL DROP TABLE #TempTblWorkwRVUall
IF OBJECT_ID('tempdb..#TempTblWorkwRVUProv') IS NOT NULL DROP TABLE #TempTblWorkwRVUProv
IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                    
BEGIN
/*Work wRVU All Provider*/
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode CPT,CPTGroup,SUM(BilledUnits)UNITS                    
INTO #TempTblWorkwRVUall FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth                    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup
--
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUYearly,wRVUCount,wRVU)
SELECT ClientID,rv.ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ProviderName/*,CPTGroup*/,CPT,CPTDescription,ISNULL(RV.wRVU,0)YrlyWrvu,cp.Units,
(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVU
FROM #TempTblWorkwRVUall(NOLOCK)cp
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL
GROUP BY ClientID,rv.ReportYear,ReportMonth/*,CPTGroup*/,CPT,CPTDescription,rv.wRVU,Units


/*Work wRVU Each Provider*/
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,ProcedureCode CPT,CPTGroup,SUM(BilledUnits)UNITS                    
INTO #TempTblWorkwRVUProv FROM PPMReport_ECW_CPT(NOLOCK)
WHERE AppointmentProvider != 'Summary' AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,ProcedureCode,CPTGroup
--
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUYearly,wRVUCount,wRVU)
SELECT ClientID,rv.ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider/*,CPTGroup*/,CPT,CPTDescription,ISNULL(RV.wRVU,0)YrlyWrvu,cp.Units,
(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVU
FROM #TempTblWorkwRVUProv(NOLOCK)cp
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                     
GROUP BY ClientID,rv.ReportYear,ReportMonth/*,CPTGroup*/,CPT,CPTDescription,rv.wRVU,Units,AppointmentProvider
END
IF OBJECT_ID('tempdb..#TempTblWorkwRVUall') IS NOT NULL DROP TABLE #TempTblWorkwRVUall
IF OBJECT_ID('tempdb..#TempTblWorkwRVUProv') IS NOT NULL DROP TABLE #TempTblWorkwRVUProv

COMMIT TRANSACTION         
SET @ErrorMessage = 'Sucess'         
END TRY                    
                              
BEGIN CATCH                    
ROLLBACK TRANSACTION          
SET @ErrorMessage = ERROR_MESSAGE()              
END CATCH         
SELECT CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage        
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECWOutputData_04sep2020]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECWOutputData_04sep2020]
(@cId int, @Year int, @month int)  
AS  
BEGIN  
DECLARE @ErrorMessage VARCHAR(MAX)  
  
BEGIN TRY           
BEGIN TRANSACTION          
DECLARE @ClientID INT = @cId          
DECLARE @ReportYear INT = @Year          
DECLARE @ReportMonth INT = @month          
DECLARE @RWCount INT=0
DECLARE @providerList INT = 0

/*Validate Provider name list*/
if (SELECT COUNT(ClientID) FROM PPMReport_ECW_ProviderNameList(NOLOCK) WHERE ClientID = @ClientID) > 0
	BEGIN
		SET @providerList = (SELECT COUNT(ClientID) FROM PPMReport_ECW_ProviderNameList(NOLOCK) WHERE ClientID = @ClientID)
	END
ELSE
	BEGIN
		SET @providerList = 0
	END
	  
/*Backup Old Name in charge*/  
UPDATE XL SET XL.XLName = A.EOMName            
FROM(            
SELECT ch.id, pn.ClientID,EOMName,DOPName            
FROM PPMReport_MatchProviderName(NOLOCK)PN            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH  
ON PN.ClientID = CH.ClientID AND PN.EOMName = CH.AppointmentProvider           
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2  
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName            
)A            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName            
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear    
/*Update Provider name as DOP Name in Charge*/  
UPDATE XL SET XL.AppointmentProvider = A.DOPName            
FROM(            
SELECT ch.id, pn.ClientID,EOMName,DOPName            
FROM PPMReport_MatchProviderName(NOLOCK)PN            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH            
ON PN.ClientID = CH.ClientID AND PN.EOMName = CH.AppointmentProvider            
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2           
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName            
)A            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName            
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear      
            
---------------------------------------------------  
  
/*-----<<<Start FinancialAnalysis>>>-----*/  
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0  
BEGIN  
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12  
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment  
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays  
  
CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),  
Charges DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),  
AccountsReceivable DECIMAL (18, 2)DEFAULT 0,AROver120 DECIMAL (18, 2)DEFAULT 0,  
ARDaysOutstanding DECIMAL (18, 2)DEFAULT 0,Unapplied DECIMAL (18, 2)DEFAULT 0,  
ClearGage  DECIMAL (18, 2)DEFAULT 0,Collections  DECIMAL (18, 2)DEFAULT 0,DTID DATE)  
  
CREATE TABLE #TempTblPayment(ClientID INT,ReportYear INT,ReportMonth INT,AppointmentProvider VARCHAR(300),  
Charges DECIMAL (18, 2),Payment DECIMAL (18, 2),Refund DECIMAL (18, 2),Amount DECIMAL (18, 2),Contractual DECIMAL (18, 2),  
InsuranceWithheld DECIMAL (18, 2),WriteoffAdjustment DECIMAL (18, 2))  
  
/*All Provider == Charges,Payment,Refund , without pay amt, Adjustments */  
INSERT INTO #TempTblPayment
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.BilledCharge,0)Charge,    
ISNULL(AR.Payment,0)Payment,ISNULL(AR.Refund,0)Refund,ISNULL(WC.Amount,0)Amount,    
ISNULL(AR.Contractual,0)Contractual,ISNULL(AR.InsuranceWithheld,0)InsuranceWithheld,ISNULL(AR.WriteoffAdjustment,0)WriteoffAdjustment    
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR    
LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear     
AND WC.ReportMonth = @ReportMonth AND (WC.PaymentDate = 'Summary'OR WC.AppointmentProvider is null)
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary')    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
 
/*Individual provider == Charges,Payment,Refund , without pay amt, Adjustments*/
if @providerList > 0
	BEGIN  
		INSERT INTO #TempTblPayment
		SELECT PMT.ClientID,PMT.ReportYear,PMT.ReportMonth,TRIM(PMT.AppointmentProvider)AppointmentProvider,PMT.Charge,  
		PMT.Payment,PMT.Refund,SUM(ISNULL(WC.Amount,0))Amount,  
		PMT.Contractual,PMT.InsuranceWithheld,PMT.WriteoffAdjustment
		FROM(
		SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,TRIM(AppointmentProvider)AppointmentProvider,
		SUM(ISNULL(AR.BilledCharge,0))Charge,  
		SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund, 
		SUM(ISNULL(AR.Contractual,0))Contractual,SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,
		SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment  
		FROM PPMReport_ECW_ARBeginEnd(NOLOCK) AR
		INNER JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl 
			ON nl.ClientID = @ClientID AND TRIM(NL.ProviderName) = TRIM(AR.AppointmentProvider)
		WHERE AR.CLIENTID = @ClientID  AND AR.ReportMonth = @ReportMonth AND AR.ReportYear = @ReportYear
		AND (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary') 
		GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,TRIM(AR.AppointmentProvider)
		)PMT
		LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC 
		ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth 
		AND WC.AppointmentProvider = PMT.AppointmentProvider AND WC.AppointmentProvider IS NOT NULL
		GROUP BY PMT.ClientID,PMT.ReportYear,PMT.ReportMonth,TRIM(PMT.AppointmentProvider),
		PMT.Charge,PMT.Payment,PMT.Refund,PMT.Contractual,PMT.InsuranceWithheld,PMT.WriteoffAdjustment
	END
ELSE
	BEGIN
		INSERT INTO #TempTblPayment
		SELECT pmt.ClientID,pmt.ReportYear,pmt.ReportMonth,TRIM(pmt.AppointmentProvider)AppointmentProvider,  
		ISNULL(pmt.Charge,0)Charge,ISNULL(pmt.Payment,0)Payment,pmt.Refund,ISNULL(wAmt.Amount,0)Amount,  
		ISNULL(pmt.Contractual,0)Contractual,ISNULL(pmt.InsuranceWithheld,0)InsuranceWithheld,ISNULL(pmt.WriteoffAdjustment,0)WriteoffAdjustment  
		FROM(  
		SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,TRIM(AR.AppointmentProvider)AppointmentProvider,
		SUM(ISNULL(AR.BilledCharge,0))Charge,  
		SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund,SUM(ISNULL(AR.Contractual,0))Contractual,  
		SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment  
		FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR  
		WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary')  
		AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
		GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,TRIM(AR.AppointmentProvider)  
		)pmt  
		LEFT JOIN (SELECT WC.ClientID,WC.ReportYear,WC.ReportMonth,TRIM(WC.AppointmentProvider)AppointmentProvider,
		SUM(ISNULL(WC.Amount,0))Amount   
		FROM PPMReport_ECW_WithoutClaims(NOLOCK)WC   
		WHERE WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth   
		AND WC.PaymentDate != 'Summary'  
		GROUP BY WC.ClientID,WC.ReportYear,WC.ReportMonth,TRIM(WC.AppointmentProvider))wAmt  
		ON wAmt.ClientID = pmt.ClientID AND wAmt.ReportYear = pmt.ReportYear AND wAmt.ReportMonth = pmt.ReportMonth  
		AND wAmt.AppointmentProvider = pmt.AppointmentProvider
	END
/*
SELECT pmt.ClientID,pmt.ReportYear,pmt.ReportMonth,pmt.AppointmentProvider,  
ISNULL(pmt.Charge,0)Charge,ISNULL(pmt.Payment,0)Payment,pmt.Refund,ISNULL(wAmt.Amount,0)Amount,  
ISNULL(pmt.Contractual,0)Contractual,ISNULL(pmt.InsuranceWithheld,0)InsuranceWithheld,ISNULL(pmt.WriteoffAdjustment,0)WriteoffAdjustment  
FROM(  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider,SUM(ISNULL(AR.BilledCharge,0))Charge,  
SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund,SUM(ISNULL(AR.Contractual,0))Contractual,  
SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment  
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR  
WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary')  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider  
)pmt  
INNER JOIN (SELECT WC.ClientID,WC.ReportYear,WC.ReportMonth,WC.AppointmentProvider,SUM(ISNULL(WC.Amount,0))Amount   
FROM PPMReport_ECW_WithoutClaims(NOLOCK)WC   
WHERE WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth   
AND WC.PaymentDate != 'Summary'  
GROUP BY WC.ClientID,WC.ReportYear,WC.ReportMonth,WC.AppointmentProvider)wAmt  
ON wAmt.ClientID = pmt.ClientID AND wAmt.ReportYear = pmt.ReportYear AND wAmt.ReportMonth = pmt.ReportMonth  
AND wAmt.AppointmentProvider = pmt.AppointmentProvider  
*/

/*insert in #TempTblpg1to12 table*/  
INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)  
SELECT ClientID,ReportYear,ReportMonth,TRIM(AppointmentProvider)AppointmentProvider,TRIM(AppointmentProvider)AppointmentProvider,
SUM(Charges)Charges, SUM((Payment-Refund)+Amount)Payment,SUM(Refund)Refund,  
SUM(Contractual+InsuranceWithheld+WriteoffAdjustment)Adjustments,  
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID  
FROM #TempTblPayment  
GROUP BY ClientID,ReportYear,ReportMonth,TRIM(AppointmentProvider)  
  
/*Update Accounts Receivable */  
UPDATE ARA SET ARA.AccountsReceivable = ISNULL(A.TotalBalance,0),ARA.AROver120 = A.AROver120  
FROM(  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,SUM(ISNULL(AR.TotalBalance,0))TotalBalance,  
SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120  
FROM PPMReport_ECW_AgingReport(NOLOCK)AR  
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'AS'  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth  
UNION  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,TRIM(AR.AppointmentProvider)AppointmentProvider,
SUM(ISNULL(AR.TotalBalance,0))TotalBalance,  SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120  
FROM PPMReport_ECW_AgingReport(NOLOCK)AR  
WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary') AND ReportName = 'AS'  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,TRIM(AR.AppointmentProvider)  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth 
AND TRIM(ARA.ProviderName) = TRIM(a.AppointmentProvider)   
  
/*ARDaysOutstanding*/                          
SELECT ClientID,ReportMonth,ReportYear,ProviderName,Charges,DTID                          
INTO #TempTblpg1to12ARDays FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)   
WHERE ClientID = @ClientID AND                          
DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                           
DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')                          
SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1  
IF @RWCount = 1  
BEGIN  
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                         
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((ISNULL(Charges,0)/(30)),0),0),0)ARDays                           
FROM #TempTblpg1to12   
WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                          
GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges  
)AR       
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                           
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                          
END  
ELSE  
BEGIN  
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays  
FROM(  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,  
ISNULL(NULLIF(ISNULL(ABS(ISNULL(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays                          
FROM #TempTblpg1to12 AA   
LEFT JOIN (SELECT ClientID,ProviderName,SUM(ISNULL(Charges,0))Charges   
FROM #TempTblpg1to12ARDays                           
GROUP BY  ClientID,ProviderName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName = bb.ProviderName  
WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear                          
GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable  
)AR                          
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                           
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                          
END  
  
/*UnappliedBalance*/   
UPDATE ARA SET ARA.Unapplied = ISNULL(A.TotalBalance,0)  
FROM(  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.TotalBalance,0)TotalBalance  
FROM PPMReport_ECW_AgingReport(NOLOCK)AR  
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'CB'  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth 
AND TRIM(ARA.ProviderName) = TRIM(a.AppointmentProvider)   
  
/*Update Cleargage*/    
UPDATE ARA SET ARA.Unapplied = ISNULL(A.ClearGage,0)  
FROM(  
SELECT CL.ID ClientID,CG.ReportYear,CG.ReportMonth,'All Provider' ProviderName,ISNULL(CG.Credit,0)ClearGage  
FROM PPMReport_ClearGage(NOLOCK)CG  
INNER JOIN PPMReport_ClientList(NOLOCK)CL   
ON CL.ID = @ClientID AND CL.ClientFullName = CG.PPMMerchantAccount  
WHERE ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName   
  
/*Update Collections*/   
UPDATE ARA SET ARA.Collections = ISNULL(A.Collections,0)  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,SUM(ISNULL(AdjustmentAmount,0))Collections,'All Provider' ProviderName  
FROM PPMReport_ECW_Collection(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName   
  
/*insert to main table*/  
INSERT INTO PPMReport_ECW_FinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,  
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)  
SELECT ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,  
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID  
FROM #TempTblpg1to12  
END  
  
/*insert to main table Yearly Compare data*/    
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis_YrlyTrend(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0  
BEGIN  
INSERT INTO PPMReport_ECW_FinancialAnalysis_YrlyTrend(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,  
AccountsReceivable,AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)  
SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName,                           
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,                          
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,                                                  
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,  
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,                          
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,                          
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,  
CONVERT(FLOAT,ISNULL(SUM(CY.Unapplied-PY.Unapplied)/NULLIF(ISNULL(SUM(PY.Unapplied),0),0),0))*100 YrlyUnapplied,     
CONVERT(FLOAT,ISNULL(SUM(CY.ClearGage-PY.ClearGage)/NULLIF(ISNULL(SUM(PY.ClearGage),0),0),0))*100 YrlyClearGage,     
CONVERT(FLOAT,ISNULL(SUM(CY.Collections-PY.Collections)/NULLIF(ISNULL(SUM(PY.Collections),0),0),0))*100 YrlyCollections,  
CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,  
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID  
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)CY   
LEFT JOIN (SELECT * FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY                           
ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ProviderName=PY.ProviderName                          
WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth                          
GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName                           
END  
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12  
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment  
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays  
/*-----<<<End FinancialAnalysis>>>-----*/  
  
  
/*-----<<<Start CPT Report>>>-----*/  
IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
BEGIN  
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT  
/*Get CPTDescription,wRVU info*/  
SELECT cpt.ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription  
INTO #TempTblCPT FROM PPMReport_wRVUList(NOLOCK)wrv  
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT  
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
GROUP BY cpt.ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU  
  
/*individual provider*/  
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)  
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,TRIM(AppointmentProvider)AppointmentProvider,TRIM(AppointmentProvider)AppointmentProvider,
ProcedureCode,cpt.CPTGroup,  CPTDescription,ISNULL(Units,0)Units  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,TRIM(AppointmentProvider)AppointmentProvider,CPTGroup,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,TRIM(AppointmentProvider),CPTGroup  
)cpt  
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt.ProcedureCode  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
  
/*All provider*/  
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)  
SELECT cpt1.ClientID,cpt1.ReportYear,cpt1.ReportMonth,'All Provider','All Provider',cpt1.ProcedureCode,cpt1.CPTGroup,  
CPTDescription,ISNULL(Units,0)Units  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup  
)cpt1  
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt1.ProcedureCode  
WHERE cpt1.ClientID = @ClientID AND cpt1.ReportYear = @ReportYear AND cpt1.ReportMonth = @ReportMonth  
  
END  
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT  
/*-----<<<End CPT Report>>>-----*/  
  
  
/*-----<<<Start WRVU Report>>>-----*/  
IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
BEGIN  
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU  
/*Get CPTDescription,wRVU info*/  
SELECT cpt.ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU  
INTO #TempTblWRVU FROM PPMReport_wRVUList(NOLOCK)wrv  
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT  
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
GROUP BY cpt.ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU  
  
/*individual provider*/  
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)  
  
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,TRIM(AppointmentProvider)AppointmentProvider,TRIM(AppointmentProvider)AppointmentProvider,
ProcedureCode,CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,TRIM(AppointmentProvider)AppointmentProvider,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,TRIM(AppointmentProvider)  
)cpt  
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
and (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
  
/*All provider*/  
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)  
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,'All Provider'AppointmentProvider,'All Provider' AppointmentProvider,ProcedureCode,  
CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode  
)cpt  
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
  
END  
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU  
/*-----<<<End WRVU Report>>>-----*/  
  
  
/*-----<<<Start Financial Dashboard>>>-----*/  
IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard  
BEGIN  
CREATE TABLE #TempTblFinancialDashboard(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(200),ShortName VARCHAR(200),                          
ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2)DEFAULT 0)  
/*Revenue Analysis*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName, ReportName, TotalCount                         
FROM(  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,  
Unapplied,AccountsReceivable,ClearGage,Collections  
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
) PVT                          
UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,AccountsReceivable,ClearGage,Collections))AS unpvt;      
  
/*Encounter Analysis*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'Encounter Analysis' ReportName,CPTGroupDesc, SUM(UNITS)UNITS  
FROM PPMReport_ProcedureCount(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName,CPTGroupDesc  
  
/*CPT Count*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'CPT' ReportName, SUM(UNITS)UNITS  
FROM PPMReport_ProcedureCount(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName  
  
/*WVRU Count*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'WVRU' ReportName, SUM(wRVU)wRVU  
FROM PPMReport_wRVUReport(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName  
  
INSERT INTO PPMReport_FinancialDashboard (ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)  
SELECT * FROM #TempTblFinancialDashboard  
ORDER BY 5,6  
  
END  
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard  
/*-----<<<End Financial Dashboard>>>-----*/  
  
  
/*-----<<<Start AgingComparison Report01>>>-----*/  
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC  
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP  
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)  
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01') = 0  
BEGIN  
CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),                          
[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),                          
[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE)               
  
/*Get insAR patAR*/  
SELECT ClientID,ReportYear,ReportMonth,ReportName ATBCategory,TRIM(AppointmentProvider)AppointmentProvider,  
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],                          
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],                          
SUM(ISNULL(TotalBalance,0))TotalBalance  
INTO #TempTblAGNCOMP FROM PPMReport_ECW_AgingReport(NOLOCK)  
WHERE ReportName IN ('IB','PB') --AND (AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL)                      
AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ClientID = @ClientID  
GROUP BY ClientID,ReportYear,ReportMonth,ReportName,TRIM(AppointmentProvider)  
ORDER BY 4,5  
UPDATE #TempTblAGNCOMP SET AppointmentProvider = 'All Provider' WHERE AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL  
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Insurance AR' WHERE ATBCategory = 'IB'  
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Patient AR' WHERE ATBCategory = 'PB'  
  
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)  
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',TRIM(AppointmentProvider)AppointmentProvider,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],TotalBalance  
FROM #TempTblAGNCOMP ORDER BY 4,5  
  
/*Total sum calculation*/  
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)  
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',TRIM(AppointmentProvider)AppointmentProvider,'Total AR' ATBCategory,
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                          
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([TotalBalance])TotalBalance                          
FROM #TempTblAGNCOMP  
GROUP BY ClientID,ReportYear,ReportMonth,TRIM(AppointmentProvider)  
  
UPDATE #TempTblAC SET DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')  
  
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)  
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,TRIM(ProviderName)ProviderName,TRIM(ProviderName)ProviderName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID  
FROM #TempTblAC  
  
/*Total sum % calculation*/  
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-01',aa.ProviderName,aa.ProviderName,aa.ATBCategory + ' %',  
[0-30] = Round(CONVERT(FLOAT,aa.[0-30]/NULLIF(bb.[0-30],0))*100,2)  
,[31-60] = Round(CONVERT(FLOAT,aa.[31-60]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[61-90] = Round(CONVERT(FLOAT,aa.[61-90]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[91-120] = Round(CONVERT(FLOAT,aa.[91-120]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[121-150] = Round(CONVERT(FLOAT,aa.[121-150]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[151-180] = Round(CONVERT(FLOAT,aa.[151-180]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[181+] = Round(CONVERT(FLOAT,aa.[181+]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[CategoryBalance] = Round(CONVERT(FLOAT,aa.CategoryBalance/NULLIF(bb.[CategoryBalance],0))*100,2),  
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM #TempTblAC aa  
LEFT JOIN PPMReport_AgingComparison(NOLOCK)bb  
ON BB.ClientID = @ClientID AND BB.ProviderName = AA.ProviderName AND aa.ATBCategory = bb.ATBCategory  
AND BB.DTID = DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))  
WHERE AA.ClientID = @ClientID AND BB.ATBCategory IN ('Insurance AR','Patient AR','Total AR') AND  BB.ReportName = 'Aging-01'  
AND AA.ProviderName = 'All Provider'  
  
END  
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC  
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP  
/*-----<<<End AgingComparison Report01>>>-----*/  
  
  
/*-----<<<Start AgingComparison Report02>>>-----*/  
  
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                           
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02') = 0                          
BEGIN                          
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02  
                   
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02' ReportName,TRIM(tb.AppointmentProvider)AppointmentProvider,InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(SUM(ISNULL(rf.AccountsReceivable,0)),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
INTO #TempTblRep02    
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf                          
ON TRIM(tb.AppointmentProvider) = TRIM(rf.ProviderName) AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TRIM(tb.AppointmentProvider),tb.InsuranceGroup  
UNION  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,TRIM(AppointmentProvider)AppointmentProvider,'Patient'InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)
+ ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM(  
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,TRIM(tb.AppointmentProvider)AppointmentProvider,InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable  
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf                          
ON TRIM(tb.AppointmentProvider) = TRIM(rf.ProviderName) AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,TRIM(tb.AppointmentProvider),tb.InsuranceGroup,rf.AccountsReceivable                            
)aa  
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth,TRIM(aa.AppointmentProvider)  
UNION  
/*GET all provider details*/  
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,'All Provider',InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(ISNULL(SUM(rf.AccountsReceivable),0),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf                          
ON TRIM(tb.AppointmentProvider) = TRIM(rf.ProviderName) AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.InsuranceGroup  
UNION  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,'All Provider','Patient'InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM(  
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable  
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf        
ON TRIM(tb.AppointmentProvider) = TRIM(rf.ProviderName) AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,tb.InsuranceGroup,rf.AccountsReceivable                            
)aa  
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth  
  
  
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],                          
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)   
SELECT ClientID,ReportYear,ReportMonth,ReportName,TRIM(AppointmentProvider)AppointmentProvider,TRIM(AppointmentProvider)AppointmentProvider,
InsuranceGroup,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercentage,Over90days,dtid  
FROM #TempTblRep02  
  
END  
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02  
  
/*-----<<<End AgingComparison Report02>>>-----*/  
  
/*-----<<<Start Payer Mix >>>-----*/
IF OBJECT_ID('tempdb..#TempTblPName') IS NOT NULL DROP TABLE #TempTblPName  
if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
BEGIN

DECLARE @strSql1 AS VARCHAR(MAX),@strSql AS VARCHAR(MAX)
IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName
SET @strSql1 += ''
SET @strSql1 = 'SELECT pm.ClientID,ReportYear,ReportMonth,TRIM(AppointmentProvider)AppointmentProvider
INTO ##TempTblPName FROM PPMReport_ECW_PayerMix(NOLOCK)pm '
if @providerList > 0
BEGIN
SET @strSql1 += ' INNER JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl 
ON nl.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND TRIM(NL.ProviderName) = TRIM(pm.AppointmentProvider)
'
END
SET @strSql1 += 'WHERE pm.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND ReportYear = ' + CONVERT(VARCHAR,@ReportYear) + 
' AND ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth) + 
' AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)
GROUP BY pm.ClientID,ReportYear,ReportMonth,TRIM(AppointmentProvider)'
EXEC (@strSql1)  
-----
SET @strSql += ''
SET @strSql = 'SELECT pm.ClientID,ReportYear,ReportMonth,TRIM(AppointmentProvider)AppointmentProvider,
TRIM(AppointmentProvider)AppointmentProvider,InsuranceGroup,  
SUM(ISNULL(BilledCharge,0))Charges,
Payment = (SUM(ISNULL(Payment,0))- SUM(ISNULL(Refund,0))),
SUM(ISNULL(Refund,0))Refund  
FROM PPMReport_ECW_PayerMix(NOLOCK)pm '
if @providerList > 0
BEGIN
SET @strSql += ' INNER JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl 
ON nl.ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND TRIM(NL.ProviderName) = TRIM(pm.AppointmentProvider) ' 
END
SET @strSql += 'WHERE pm.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND pm.ReportYear = ' + CONVERT(VARCHAR,@ReportYear) +
' AND pm.ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth)+   
'AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)  
GROUP BY pm.ClientID,ReportYear,ReportMonth,TRIM(pm.AppointmentProvider),InsuranceGroup  
UNION  
SELECT wc.ClientID,wc.ReportYear,wc.ReportMonth,TRIM(wc.AppointmentProvider)AppointmentProvider,
TRIM(wc.AppointmentProvider)AppointmentProvider,''PWOC'' InsuranceGroup,  
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund  
FROM PPMReport_ECW_WithoutClaims(NOLOCK)wc
INNER JOIN ##TempTblPName pn
ON TRIM(wc.AppointmentProvider) = pn.AppointmentProvider  
WHERE wc.ClientID = ' + CONVERT(VARCHAR,@ClientID) +' AND wc.ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+ 
' and wc.ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth ) + 'AND (PaymentDate != ''Summary'' AND PaymentDate IS NOT NULL)  
GROUP BY wc.ClientID,wc.ReportYear,wc.ReportMonth,TRIM(wc.AppointmentProvider)    
UNION  
/*All Provider*/  
SELECT ClientID,ReportYear,ReportMonth,''All Provider'' AppointmentProvider,''All Provider'' AppointmentProvider,InsuranceGroup,  
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))-SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund  
FROM PPMReport_ECW_PayerMix(NOLOCK)  
WHERE ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+
' AND ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth) +
'AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup  
UNION  
SELECT ClientID,ReportYear,ReportMonth,''All Provider'' AppointmentProvider,''All Provider'' AppointmentProvider,''PWOC''InsuranceGroup,  
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund  
FROM PPMReport_ECW_WithoutClaims(NOLOCK)  
WHERE ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+
' AND ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth)+  
'AND (PaymentDate != ''Summary'' AND PaymentDate IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth '
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)
EXEC(@strSql)
IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName
  
/*
SELECT ClientID,ReportYear,ReportMonth,TRIM(AppointmentProvider)AppointmentProvider
INTO #TempTblPName FROM PPMReport_ECW_PayerMix(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth  
AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider
  
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)  
  -----------====================================
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,InsuranceGroup,  
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))- SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund  
FROM PPMReport_ECW_PayerMix(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth  
AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup  
UNION  
SELECT wc.ClientID,wc.ReportYear,wc.ReportMonth,wc.AppointmentProvider,wc.AppointmentProvider,'PWOC'InsuranceGroup,  
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund  
FROM PPMReport_ECW_WithoutClaims(NOLOCK)wc
INNER JOIN #TempTblPName pn
ON wc.AppointmentProvider = pn.AppointmentProvider  
WHERE wc.ClientID = @ClientID AND wc.ReportYear = @ReportYear and wc.ReportMonth = @ReportMonth  
AND (PaymentDate != 'Summary' AND PaymentDate IS NOT NULL)  
GROUP BY wc.ClientID,wc.ReportYear,wc.AppointmentProvider,wc.ReportMonth    
  
UNION  
/*All Provider*/  
select ClientID,ReportYear,ReportMonth,'All Provider' AppointmentProvider,'All Provider' AppointmentProvider,InsuranceGroup,  
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))- SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund  
FROM PPMReport_ECW_PayerMix(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth  
AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup  
UNION  
SELECT ClientID,ReportYear,ReportMonth,'All Provider' AppointmentProvider,'All Provider' AppointmentProvider,'PWOC'InsuranceGroup,  
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund  
FROM PPMReport_ECW_WithoutClaims(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth  
AND (PaymentDate != 'Summary' AND PaymentDate IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth  
  */
END
/*-----<<<End Payer Mix >>>-----*/  
  
COMMIT TRANSACTION           
SET @ErrorMessage = 'Sucess'           
END TRY                      
                        
BEGIN CATCH                      
ROLLBACK TRANSACTION            
SET @ErrorMessage = ERROR_MESSAGE()                
END CATCH
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12  
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment  
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT
IF OBJECT_ID('tempdb..#TempTblPName') IS NOT NULL DROP TABLE #TempTblPName           
SELECT CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage          
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECWOutputData_21oct19]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[PPMReport_ECWOutputData_21oct19]  
(@cId int, @Year int, @month int)    
AS    
BEGIN    
DECLARE @ErrorMessage VARCHAR(MAX)    
    
BEGIN TRY             
BEGIN TRANSACTION            
DECLARE @ClientID INT = @cId            
DECLARE @ReportYear INT = @Year            
DECLARE @ReportMonth INT = @month            
DECLARE @RWCount INT=0       
    
/*Backup Old Name in charge*/    
UPDATE XL SET XL.XLName = A.EOMName              
FROM(              
SELECT ch.id, pn.ClientID,EOMName,DOPName              
FROM PPMReport_MatchProviderName(NOLOCK)PN              
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH    
ON PN.ClientID = CH.ClientID AND PN.EOMName = CH.AppointmentProvider             
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2    
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName              
)A              
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName              
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear      
/*Update Provider name as DOP Name in Charge*/    
UPDATE XL SET XL.AppointmentProvider = A.DOPName              
FROM(              
SELECT ch.id, pn.ClientID,EOMName,DOPName              
FROM PPMReport_MatchProviderName(NOLOCK)PN              
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH              
ON PN.ClientID = CH.ClientID AND PN.EOMName = CH.AppointmentProvider              
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2             
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName              
)A              
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName              
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
              
---------------------------------------------------    
    
/*-----<<<Start FinancialAnalysis>>>-----*/    
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0    
BEGIN    
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12    
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment    
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays    
    
CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),    
Charges DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),    
AccountsReceivable DECIMAL (18, 2)DEFAULT 0,AROver120 DECIMAL (18, 2)DEFAULT 0,    
ARDaysOutstanding DECIMAL (18, 2)DEFAULT 0,Unapplied DECIMAL (18, 2)DEFAULT 0,    
ClearGage  DECIMAL (18, 2)DEFAULT 0,Collections  DECIMAL (18, 2)DEFAULT 0,DTID DATE)    
    
CREATE TABLE #TempTblPayment(ClientID INT,ReportYear INT,ReportMonth INT,AppointmentProvider VARCHAR(300),    
Charges DECIMAL (18, 2),Payment DECIMAL (18, 2),Refund DECIMAL (18, 2),Amount DECIMAL (18, 2),Contractual DECIMAL (18, 2),    
InsuranceWithheld DECIMAL (18, 2),WriteoffAdjustment DECIMAL (18, 2))    
    
/*All Provider == Charges,Payment,Refund , without pay amt, Adjustments */    
INSERT INTO #TempTblPayment    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.BilledCharge,0)Charge,    
ISNULL(AR.Payment,0)Payment,ISNULL(AR.Refund,0)Refund,ISNULL(WC.Amount,0)Amount,    
ISNULL(AR.Contractual,0)Contractual,ISNULL(AR.InsuranceWithheld,0)InsuranceWithheld,ISNULL(AR.WriteoffAdjustment,0)WriteoffAdjustment    
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR    
LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear     
AND WC.ReportMonth = @ReportMonth AND WC.PaymentDate = 'Summary'    
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary')    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth    
    
/*Individual provider == Charges,Payment,Refund , without pay amt, Adjustments*/    
INSERT INTO #TempTblPayment    
SELECT pmt.ClientID,pmt.ReportYear,pmt.ReportMonth,pmt.AppointmentProvider,    
ISNULL(pmt.Charge,0)Charge,ISNULL(pmt.Payment,0)Payment,pmt.Refund,ISNULL(wAmt.Amount,0)Amount,    
ISNULL(pmt.Contractual,0)Contractual,ISNULL(pmt.InsuranceWithheld,0)InsuranceWithheld,ISNULL(pmt.WriteoffAdjustment,0)WriteoffAdjustment    
FROM(    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider,SUM(ISNULL(AR.BilledCharge,0))Charge,    
SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund,SUM(ISNULL(AR.Contractual,0))Contractual,    
SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment    
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR    
WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary')    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth    
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider    
)pmt    
LEFT JOIN (SELECT WC.ClientID,WC.ReportYear,WC.ReportMonth,WC.AppointmentProvider,SUM(ISNULL(WC.Amount,0))Amount     
FROM PPMReport_ECW_WithoutClaims(NOLOCK)WC     
WHERE WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth     
AND WC.PaymentDate != 'Summary'    
GROUP BY WC.ClientID,WC.ReportYear,WC.ReportMonth,WC.AppointmentProvider)wAmt    
ON wAmt.ClientID = pmt.ClientID AND wAmt.ReportYear = pmt.ReportYear AND wAmt.ReportMonth = pmt.ReportMonth    
AND wAmt.AppointmentProvider = pmt.AppointmentProvider    
    
/*insert in #TempTblpg1to12 table*/    
INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)    
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,SUM(Charges)Charges,    
SUM((Payment-Refund)+Amount)Payment,SUM(Refund)Refund,    
SUM(Contractual+InsuranceWithheld+WriteoffAdjustment)Adjustments,    
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID    
FROM #TempTblPayment    
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider    
    
/*Update Accounts Receivable */    
UPDATE ARA SET ARA.AccountsReceivable = ISNULL(A.TotalBalance,0),ARA.AROver120 = A.AROver120    
FROM(    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,SUM(ISNULL(AR.TotalBalance,0))TotalBalance,    
SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120    
FROM PPMReport_ECW_AgingReport(NOLOCK)AR    
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'AS'    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth    
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth    
UNION    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider,SUM(ISNULL(AR.TotalBalance,0))TotalBalance,    
SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120    
FROM PPMReport_ECW_AgingReport(NOLOCK)AR    
WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary') AND ReportName = 'AS'    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth    
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider    
)A    
INNER JOIN #TempTblpg1to12 ARA     
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.AppointmentProvider     
    
/*ARDaysOutstanding*/                            
SELECT ClientID,ReportMonth,ReportYear,ProviderName,Charges,DTID                            
INTO #TempTblpg1to12ARDays FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)     
WHERE ClientID = @ClientID AND                            
DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                             
DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')                            
SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1    
IF @RWCount = 1    
BEGIN    
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                           
FROM(    
SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((ISNULL(Charges,0)/(30)),0),0),0)ARDays                             
FROM #TempTblpg1to12     
WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                            
GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges    
)AR         
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                             
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                            
END    
ELSE    
BEGIN    
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays    
FROM(    
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,    
ISNULL(NULLIF(ISNULL(ABS(ISNULL(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays                            
FROM #TempTblpg1to12 AA     
LEFT JOIN (SELECT ClientID,ProviderName,SUM(ISNULL(Charges,0))Charges     
FROM #TempTblpg1to12ARDays                             
GROUP BY  ClientID,ProviderName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName = bb.ProviderName    
WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear                            
GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable    
)AR                            
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                             
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                            
END    
    
/*UnappliedBalance*/     
UPDATE ARA SET ARA.Unapplied = ISNULL(A.TotalBalance,0)    
FROM(    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.TotalBalance,0)TotalBalance    
FROM PPMReport_ECW_AgingReport(NOLOCK)AR    
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'CB'    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth    
)A    
INNER JOIN #TempTblpg1to12 ARA     
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.AppointmentProvider     
    
/*Update Cleargage*/      
UPDATE ARA SET ARA.Unapplied = ISNULL(A.ClearGage,0)    
FROM(    
SELECT CL.ID ClientID,CG.ReportYear,CG.ReportMonth,'All Provider' ProviderName,ISNULL(CG.Credit,0)ClearGage    
FROM PPMReport_ClearGage(NOLOCK)CG    
INNER JOIN PPMReport_ClientList(NOLOCK)CL     
ON CL.ID = @ClientID AND CL.ClientFullName = CG.PPMMerchantAccount    
WHERE ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
)A    
INNER JOIN #TempTblpg1to12 ARA     
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName     
    
/*Update Collections*/     
UPDATE ARA SET ARA.Collections = ISNULL(A.Collections,0)    
FROM(    
SELECT ClientID,ReportYear,ReportMonth,SUM(ISNULL(AdjustmentAmount,0))Collections,'All Provider' ProviderName    
FROM PPMReport_ECW_Collection(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
GROUP BY ClientID,ReportYear,ReportMonth    
)A    
INNER JOIN #TempTblpg1to12 ARA     
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName     
    
/*insert to main table*/    
INSERT INTO PPMReport_ECW_FinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,    
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)    
SELECT ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,    
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID    
FROM #TempTblpg1to12    
END    
    
/*insert to main table Yearly Compare data*/      
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis_YrlyTrend(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0    
BEGIN    
INSERT INTO PPMReport_ECW_FinancialAnalysis_YrlyTrend(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,    
AccountsReceivable,AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)    
SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName,                             
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,                            
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,                                                    
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,    
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,                            
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,                            
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,    
CONVERT(FLOAT,ISNULL(SUM(CY.Unapplied-PY.Unapplied)/NULLIF(ISNULL(SUM(PY.Unapplied),0),0),0))*100 YrlyUnapplied,       
CONVERT(FLOAT,ISNULL(SUM(CY.ClearGage-PY.ClearGage)/NULLIF(ISNULL(SUM(PY.ClearGage),0),0),0))*100 YrlyClearGage,       
CONVERT(FLOAT,ISNULL(SUM(CY.Collections-PY.Collections)/NULLIF(ISNULL(SUM(PY.Collections),0),0),0))*100 YrlyCollections,    
CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,    
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID    
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)CY     
LEFT JOIN (SELECT * FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                             
WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY                             
ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ProviderName=PY.ProviderName                            
WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth                            
GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName                             
END    
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12    
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment    
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays    
/*-----<<<End FinancialAnalysis>>>-----*/    
    
    
/*-----<<<Start CPT Report>>>-----*/    
IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0    
BEGIN    
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT    
/*Get CPTDescription,wRVU info*/    
SELECT ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription    
INTO #TempTblCPT FROM PPMReport_wRVUList(NOLOCK)wrv    
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT    
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL    
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth    
GROUP BY ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU    
    
/*individual provider*/    
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)    
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,AppointmentProvider,AppointmentProvider,ProcedureCode,cpt.CPTGroup,    
CPTDescription,ISNULL(Units,0)Units    
FROM(    
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider,CPTGroup,    
SUM(ISNULL(BilledUnits,0))Units    
FROM PPMReport_ECW_CPT(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider,CPTGroup    
)cpt    
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt.ProcedureCode    
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth    
    
/*All provider*/    
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)    
SELECT cpt1.ClientID,cpt1.ReportYear,cpt1.ReportMonth,'All Provider','All Provider',cpt1.ProcedureCode,cpt1.CPTGroup,    
CPTDescription,ISNULL(Units,0)Units    
FROM(    
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup,    
SUM(ISNULL(BilledUnits,0))Units    
FROM PPMReport_ECW_CPT(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup    
)cpt1    
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt1.ProcedureCode    
WHERE cpt1.ClientID = @ClientID AND cpt1.ReportYear = @ReportYear AND cpt1.ReportMonth = @ReportMonth    
    
END    
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT    
/*-----<<<End CPT Report>>>-----*/    
    
    
/*-----<<<Start WRVU Report>>>-----*/    
IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0    
BEGIN    
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU    
/*Get CPTDescription,wRVU info*/    
SELECT ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU    
INTO #TempTblWRVU FROM PPMReport_wRVUList(NOLOCK)wrv    
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT    
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL    
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth    
GROUP BY ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU    
    
/*individual provider*/    
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)    
    
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,AppointmentProvider,AppointmentProvider,ProcedureCode,    
CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))    
FROM(    
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider,    
SUM(ISNULL(BilledUnits,0))Units    
FROM PPMReport_ECW_CPT(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider    
)cpt    
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode    
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth    
and (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')    
    
/*All provider*/    
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)    
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,'All Provider'AppointmentProvider,'All Provider' AppointmentProvider,ProcedureCode,    
CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))    
FROM(    
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,    
SUM(ISNULL(BilledUnits,0))Units    
FROM PPMReport_ECW_CPT(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode    
)cpt    
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode    
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth    
    
END    
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU    
/*-----<<<End WRVU Report>>>-----*/    
    
    
/*-----<<<Start Financial Dashboard>>>-----*/    
IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0    
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard    
BEGIN    
CREATE TABLE #TempTblFinancialDashboard(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(200),ShortName VARCHAR(200),                            
ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2)DEFAULT 0)    
/*Revenue Analysis*/    
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)    
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName, ReportName, TotalCount                           
FROM(    
SELECT  ClientID,ReportYear,ReportMonth,ProviderName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,    
Unapplied,AccountsReceivable,ClearGage,Collections    
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                            
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
) PVT                            
UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,AccountsReceivable,ClearGage,Collections))AS unpvt;        
    
/*Encounter Analysis*/    
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)    
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'Encounter Analysis' ReportName,CPTGroupDesc, SUM(UNITS)UNITS    
FROM PPMReport_ProcedureCount(NOLOCK)                            
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName,CPTGroupDesc    
    
/*CPT Count*/    
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)    
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'CPT' ReportName, SUM(UNITS)UNITS    
FROM PPMReport_ProcedureCount(NOLOCK)                            
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName    
    
/*WVRU Count*/    
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)    
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'WVRU' ReportName, SUM(wRVU)wRVU    
FROM PPMReport_wRVUReport(NOLOCK)                            
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName    
    
INSERT INTO PPMReport_FinancialDashboard (ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)    
SELECT * FROM #TempTblFinancialDashboard    
ORDER BY 5,6    
    
END    
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard    
/*-----<<<End Financial Dashboard>>>-----*/    
    
    
/*-----<<<Start AgingComparison Report01>>>-----*/    
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC    
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP    
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)    
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01') = 0    
BEGIN    
CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),                            
[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),                            
[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE)                 
    
/*Get insAR patAR*/    
SELECT ClientID,ReportYear,ReportMonth,ReportName ATBCategory,AppointmentProvider,    
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],                            
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],                            
SUM(ISNULL(TotalBalance,0))TotalBalance    
INTO #TempTblAGNCOMP FROM PPMReport_ECW_AgingReport(NOLOCK)    
WHERE ReportName IN ('IB','PB') --AND (AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL)                        
AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ClientID = @ClientID    
GROUP BY ClientID,ReportYear,ReportMonth,ReportName,AppointmentProvider    
ORDER BY 4,5    
UPDATE #TempTblAGNCOMP SET AppointmentProvider = 'All Provider' WHERE AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL    
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Insurance AR' WHERE ATBCategory = 'IB'    
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Patient AR' WHERE ATBCategory = 'PB'    
    
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)    
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',AppointmentProvider,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],TotalBalance    
FROM #TempTblAGNCOMP ORDER BY 4,5    
    
/*Total sum calculation*/    
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)    
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',AppointmentProvider,'Total AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                            
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([TotalBalance])TotalBalance                            
FROM #TempTblAGNCOMP    
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider    
    
UPDATE #TempTblAC SET DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')    
    
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)    
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,ProviderName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID    
FROM #TempTblAC    
    
/*Total sum % calculation*/    
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)    
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-01',aa.ProviderName,aa.ProviderName,aa.ATBCategory + ' %',    
[0-30] = Round(CONVERT(FLOAT,aa.[0-30]/NULLIF(bb.[0-30],0))*100,2)    
,[31-60] = Round(CONVERT(FLOAT,aa.[31-60]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[61-90] = Round(CONVERT(FLOAT,aa.[61-90]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[91-120] = Round(CONVERT(FLOAT,aa.[91-120]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[121-150] = Round(CONVERT(FLOAT,aa.[121-150]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[151-180] = Round(CONVERT(FLOAT,aa.[151-180]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[181+] = Round(CONVERT(FLOAT,aa.[181+]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[CategoryBalance] = Round(CONVERT(FLOAT,aa.CategoryBalance/NULLIF(bb.[CategoryBalance],0))*100,2),    
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid    
FROM #TempTblAC aa    
LEFT JOIN PPMReport_AgingComparison(NOLOCK)bb    
ON BB.ClientID = @ClientID AND BB.ProviderName = AA.ProviderName AND aa.ATBCategory = bb.ATBCategory    
AND BB.DTID = DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))    
WHERE AA.ClientID = @ClientID AND BB.ATBCategory IN ('Insurance AR','Patient AR','Total AR') AND  BB.ReportName = 'Aging-01'    
AND AA.ProviderName = 'All Provider'    
    
END    
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC    
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP    
/*-----<<<End AgingComparison Report01>>>-----*/    
    
    
/*-----<<<Start AgingComparison Report02>>>-----*/    
    
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                             
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02') = 0                            
BEGIN                            
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02    
                     
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02' ReportName,tb.AppointmentProvider,InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]    
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(SUM(ISNULL(rf.AccountsReceivable,0)),0))*100,2),0)    
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)    
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid    
INTO #TempTblRep02      
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                             
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable     
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                             
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear    
)rf                            
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                            
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth    
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.AppointmentProvider,tb.InsuranceGroup    
UNION    
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,AppointmentProvider,'Patient'InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance    
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)    
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)    
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid    
FROM(    
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,tb.AppointmentProvider,InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable    
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                             
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable     
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                             
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear    
)rf                            
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                            
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth    
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,tb.AppointmentProvider,tb.InsuranceGroup,rf.AccountsReceivable                              
)aa    
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.AppointmentProvider    
UNION    
/*GET all provider details*/    
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,'All Provider',InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]    
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(ISNULL(SUM(rf.AccountsReceivable),0),0))*100,2),0)    
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)    
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid    
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                             
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable     
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                             
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear    
)rf                            
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                            
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth    
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.InsuranceGroup    
UNION    
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,'All Provider','Patient'InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance    
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)    
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)    
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid    
FROM(    
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable    
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                             
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable     
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                             
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear    
)rf                            
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                            
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth    
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,tb.InsuranceGroup,rf.AccountsReceivable                              
)aa    
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth    
    
    
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],                            
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)     
SELECT ClientID,ReportYear,ReportMonth,ReportName,AppointmentProvider,AppointmentProvider,InsuranceGroup,[0-30],[31-60],                            
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercentage,Over90days,dtid    
FROM #TempTblRep02    
    
END    
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02    
    
/*-----<<<End AgingComparison Report02>>>-----*/    
    
/*-----<<<Start Payer Mix >>>-----*/  
IF OBJECT_ID('tempdb..#TempTblPName') IS NOT NULL DROP TABLE #TempTblPName    
if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0    
BEGIN    
  
SELECT ClientID,ReportYear,ReportMonth,TRIM(AppointmentProvider)AppointmentProvider  
INTO #TempTblPName FROM PPMReport_ECW_PayerMix(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth    
AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider  
    
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)    
    
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,InsuranceGroup,    
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))- SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund    
FROM PPMReport_ECW_PayerMix(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth    
AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup    
UNION    
SELECT wc.ClientID,wc.ReportYear,wc.ReportMonth,wc.AppointmentProvider,wc.AppointmentProvider,'PWOC'InsuranceGroup,    
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund    
FROM PPMReport_ECW_WithoutClaims(NOLOCK)wc  
INNER JOIN #TempTblPName pn  
ON wc.AppointmentProvider = pn.AppointmentProvider    
WHERE wc.ClientID = @ClientID AND wc.ReportYear = @ReportYear and wc.ReportMonth = @ReportMonth    
AND (PaymentDate != 'Summary' AND PaymentDate IS NOT NULL)    
GROUP BY wc.ClientID,wc.ReportYear,wc.AppointmentProvider,wc.ReportMonth      
    
UNION    
/*All Provider*/    
select ClientID,ReportYear,ReportMonth,'All Provider' AppointmentProvider,'All Provider' AppointmentProvider,InsuranceGroup,    
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))- SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund    
FROM PPMReport_ECW_PayerMix(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth    
AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup    
UNION    
SELECT ClientID,ReportYear,ReportMonth,'All Provider' AppointmentProvider,'All Provider' AppointmentProvider,'PWOC'InsuranceGroup,    
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund    
FROM PPMReport_ECW_WithoutClaims(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth    
AND (PaymentDate != 'Summary' AND PaymentDate IS NOT NULL)    
GROUP BY ClientID,ReportYear,ReportMonth    
    
END  
/*-----<<<End Payer Mix >>>-----*/    
    
COMMIT TRANSACTION             
SET @ErrorMessage = 'Sucess'             
END TRY                        
                          
BEGIN CATCH                        
ROLLBACK TRANSACTION              
SET @ErrorMessage = ERROR_MESSAGE()                  
END CATCH  
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12    
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment    
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays  
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT  
IF OBJECT_ID('tempdb..#TempTblPName') IS NOT NULL DROP TABLE #TempTblPName             
SELECT CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage            
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECWOutputData_bck300919]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[PPMReport_ECWOutputData_bck300919]   
(@cId int, @Year int, @month int)  
AS  
BEGIN  
DECLARE @ErrorMessage VARCHAR(MAX)  
  
BEGIN TRY           
BEGIN TRANSACTION          
DECLARE @ClientID INT = @cId          
DECLARE @ReportYear INT = @Year          
DECLARE @ReportMonth INT = @month          
DECLARE @RWCount INT=0     
  
/*Backup Old Name in charge*/  
UPDATE XL SET XL.XLName = A.EOMName            
FROM(            
SELECT ch.id, pn.ClientID,EOMName,DOPName            
FROM PPMReport_MatchProviderName(NOLOCK)PN            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH  
ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.AppointmentProvider           
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2  
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName            
)A            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName            
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear    
/*Update Provider name as DOP Name in Charge*/  
UPDATE XL SET XL.AppointmentProvider = A.DOPName            
FROM(            
SELECT ch.id, pn.ClientID,EOMName,DOPName            
FROM PPMReport_MatchProviderName(NOLOCK)PN            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH            
ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.AppointmentProvider            
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2           
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName            
)A            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName            
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear      
            
---------------------------------------------------  
  
/*-----<<<Start FinancialAnalysis>>>-----*/  
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0  
BEGIN  
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12  
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment  
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays  
  
CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),  
Charges DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),  
AccountsReceivable DECIMAL (18, 2)DEFAULT 0,AROver120 DECIMAL (18, 2)DEFAULT 0,  
ARDaysOutstanding DECIMAL (18, 2)DEFAULT 0,Unapplied DECIMAL (18, 2)DEFAULT 0,  
ClearGage  DECIMAL (18, 2)DEFAULT 0,Collections  DECIMAL (18, 2)DEFAULT 0,DTID DATE)  
  
CREATE TABLE #TempTblPayment(ClientID INT,ReportYear INT,ReportMonth INT,AppointmentProvider VARCHAR(300),  
Charges DECIMAL (18, 2),Payment DECIMAL (18, 2),Refund DECIMAL (18, 2),Amount DECIMAL (18, 2),Contractual DECIMAL (18, 2),  
InsuranceWithheld DECIMAL (18, 2),WriteoffAdjustment DECIMAL (18, 2))  
  
/*All Provider == Charges,Payment,Refund , without pay amt, Adjustments */  
INSERT INTO #TempTblPayment  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.BilledCharge,0)Charge,  
ISNULL(AR.Payment,0)Payment,ISNULL(AR.Refund,0)Refund,ISNULL(WC.Amount,0)Amount,  
ISNULL(AR.Contractual,0)Contractual,ISNULL(AR.InsuranceWithheld,0)InsuranceWithheld,ISNULL(AR.WriteoffAdjustment,0)WriteoffAdjustment  
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR  
LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear   
AND WC.ReportMonth = @ReportMonth AND WC.PaymentDate = 'Summary'  
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary')  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
  
/*Individual provider == Charges,Payment,Refund , without pay amt, Adjustments*/  
INSERT INTO #TempTblPayment  
SELECT pmt.ClientID,pmt.ReportYear,pmt.ReportMonth,pmt.AppointmentProvider,  
ISNULL(pmt.Charge,0)Charge,ISNULL(pmt.Payment,0)Payment,pmt.Refund,ISNULL(wAmt.Amount,0)Amount,  
ISNULL(pmt.Contractual,0)Contractual,ISNULL(pmt.InsuranceWithheld,0)InsuranceWithheld,ISNULL(pmt.WriteoffAdjustment,0)WriteoffAdjustment  
FROM(  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider,SUM(ISNULL(AR.BilledCharge,0))Charge,  
SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund,SUM(ISNULL(AR.Contractual,0))Contractual,  
SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment  
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR  
WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary')  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider  
)pmt  
LEFT JOIN (SELECT WC.ClientID,WC.ReportYear,WC.ReportMonth,WC.AppointmentProvider,SUM(ISNULL(WC.Amount,0))Amount   
FROM PPMReport_ECW_WithoutClaims(NOLOCK)WC   
WHERE WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth   
AND WC.PaymentDate != 'Summary'  
GROUP BY WC.ClientID,WC.ReportYear,WC.ReportMonth,WC.AppointmentProvider)wAmt  
ON wAmt.ClientID = pmt.ClientID AND wAmt.ReportYear = pmt.ReportYear AND wAmt.ReportMonth = pmt.ReportMonth  
AND wAmt.AppointmentProvider = pmt.AppointmentProvider  
  
/*insert in #TempTblpg1to12 table*/  
INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)  
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,SUM(Charges)Charges,  
SUM((Payment-Refund)+Amount)Payment,SUM(Refund)Refund,  
SUM(Contractual+InsuranceWithheld+WriteoffAdjustment)Adjustments,  
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID  
FROM #TempTblPayment  
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider  
  
/*Update Accounts Receivable */  
UPDATE ARA SET ARA.AccountsReceivable = ISNULL(A.TotalBalance,0),ARA.AROver120 = A.AROver120  
FROM(  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,SUM(ISNULL(AR.TotalBalance,0))TotalBalance,  
SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120  
FROM PPMReport_ECW_AgingReport(NOLOCK)AR  
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'AS'  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth  
UNION  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider,SUM(ISNULL(AR.TotalBalance,0))TotalBalance,  
SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120  
FROM PPMReport_ECW_AgingReport(NOLOCK)AR  
WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary') AND ReportName = 'AS'  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.AppointmentProvider   
  
/*ARDaysOutstanding*/                          
SELECT ClientID,ReportMonth,ReportYear,ProviderName,Charges,DTID                          
INTO #TempTblpg1to12ARDays FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)   
WHERE ClientID = @ClientID AND                          
DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                           
DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')                          
SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1  
IF @RWCount = 1  
BEGIN  
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                         
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((ISNULL(Charges,0)/(30)),0),0),0)ARDays                           
FROM #TempTblpg1to12   
WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                          
GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges  
)AR       
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                           
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                          
END  
ELSE  
BEGIN  
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays  
FROM(  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,  
ISNULL(NULLIF(ISNULL(ABS(ISNULL(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays                          
FROM #TempTblpg1to12 AA   
LEFT JOIN (SELECT ClientID,ProviderName,SUM(ISNULL(Charges,0))Charges   
FROM #TempTblpg1to12ARDays                           
GROUP BY  ClientID,ProviderName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName = bb.ProviderName  
WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear                          
GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable  
)AR                          
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                           
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                          
END  
  
/*UnappliedBalance*/   
UPDATE ARA SET ARA.Unapplied = ISNULL(A.TotalBalance,0)  
FROM(  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.TotalBalance,0)TotalBalance  
FROM PPMReport_ECW_AgingReport(NOLOCK)AR  
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'CB'  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.AppointmentProvider   
  
/*Update Cleargage*/    
UPDATE ARA SET ARA.Unapplied = ISNULL(A.ClearGage,0)  
FROM(  
SELECT CL.ID ClientID,CG.ReportYear,CG.ReportMonth,'All Provider' ProviderName,ISNULL(CG.Credit,0)ClearGage  
FROM PPMReport_ClearGage(NOLOCK)CG  
INNER JOIN PPMReport_ClientList(NOLOCK)CL   
ON CL.ID = @ClientID AND CL.ClientFullName = CG.PPMMerchantAccount  
WHERE ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName   
  
/*Update Collections*/   
UPDATE ARA SET ARA.Collections = ISNULL(A.Collections,0)  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,SUM(ISNULL(AdjustmentAmount,0))Collections,'All Provider' ProviderName  
FROM PPMReport_ECW_Collection(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName   
  
/*insert to main table*/  
INSERT INTO PPMReport_ECW_FinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,  
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)  
SELECT ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,  
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID  
FROM #TempTblpg1to12  
END  
  
/*insert to main table Yearly Compare data*/    
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis_YrlyTrend(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0  
BEGIN  
INSERT INTO PPMReport_ECW_FinancialAnalysis_YrlyTrend(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,  
AccountsReceivable,AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)  
SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName,                           
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,                          
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,                                                  
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,  
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,                          
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,                          
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,  
CONVERT(FLOAT,ISNULL(SUM(CY.Unapplied-PY.Unapplied)/NULLIF(ISNULL(SUM(PY.Unapplied),0),0),0))*100 YrlyUnapplied,     
CONVERT(FLOAT,ISNULL(SUM(CY.ClearGage-PY.ClearGage)/NULLIF(ISNULL(SUM(PY.ClearGage),0),0),0))*100 YrlyClearGage,     
CONVERT(FLOAT,ISNULL(SUM(CY.Collections-PY.Collections)/NULLIF(ISNULL(SUM(PY.Collections),0),0),0))*100 YrlyCollections,  
CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,  
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID  
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)CY   
LEFT JOIN (SELECT * FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY                           
ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ProviderName=PY.ProviderName                          
WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth                          
GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName                           
END  
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12  
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment  
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays  
/*-----<<<End FinancialAnalysis>>>-----*/  
  
  
/*-----<<<Start CPT Report>>>-----*/  
IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
BEGIN  
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT  
/*Get CPTDescription,wRVU info*/  
SELECT ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription  
INTO #TempTblCPT FROM PPMReport_wRVUList(NOLOCK)wrv  
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT  
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
GROUP BY ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU  
  
/*individual provider*/  
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)  
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,AppointmentProvider,AppointmentProvider,ProcedureCode,cpt.CPTGroup,  
CPTDescription,ISNULL(Units,0)Units  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider,CPTGroup,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider,CPTGroup  
)cpt  
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt.ProcedureCode  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
  
/*All provider*/  
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)  
SELECT cpt1.ClientID,cpt1.ReportYear,cpt1.ReportMonth,'All Provider','All Provider',cpt1.ProcedureCode,cpt1.CPTGroup,  
CPTDescription,ISNULL(Units,0)Units  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup  
)cpt1  
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt1.ProcedureCode  
WHERE cpt1.ClientID = @ClientID AND cpt1.ReportYear = @ReportYear AND cpt1.ReportMonth = @ReportMonth  
  
END  
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT  
/*-----<<<End CPT Report>>>-----*/  
  
  
/*-----<<<Start WRVU Report>>>-----*/  
IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
BEGIN  
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU  
/*Get CPTDescription,wRVU info*/  
SELECT ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU  
INTO #TempTblWRVU FROM PPMReport_wRVUList(NOLOCK)wrv  
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT  
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
GROUP BY ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU  
  
/*individual provider*/  
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)  
  
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,AppointmentProvider,AppointmentProvider,ProcedureCode,  
CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider  
)cpt  
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
and (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
  
/*All provider*/  
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)  
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,'All Provider'AppointmentProvider,'All Provider' AppointmentProvider,ProcedureCode,  
CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode  
)cpt  
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
  
END  
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU  
/*-----<<<End WRVU Report>>>-----*/  
  
  
/*-----<<<Start Financial Dashboard>>>-----*/  
IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard  
BEGIN  
CREATE TABLE #TempTblFinancialDashboard(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(200),ShortName VARCHAR(200),                          
ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2)DEFAULT 0)  
/*Revenue Analysis*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName, ReportName, TotalCount                         
FROM(  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,  
Unapplied,AccountsReceivable,ClearGage,Collections  
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
) PVT                          
UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,AccountsReceivable,ClearGage,Collections))AS unpvt;      
  
/*Encounter Analysis*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'Encounter Analysis' ReportName,CPTGroupDesc, SUM(UNITS)UNITS  
FROM PPMReport_ProcedureCount(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName,CPTGroupDesc  
  
/*CPT Count*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'CPT' ReportName, SUM(UNITS)UNITS  
FROM PPMReport_ProcedureCount(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName  
  
/*WVRU Count*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'WVRU' ReportName, SUM(wRVU)wRVU  
FROM PPMReport_wRVUReport(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName  
  
INSERT INTO PPMReport_FinancialDashboard (ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)  
SELECT * FROM #TempTblFinancialDashboard  
ORDER BY 5,6  
  
END  
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard  
/*-----<<<End Financial Dashboard>>>-----*/  
  
  
/*-----<<<Start AgingComparison Report01>>>-----*/  
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC  
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP  
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)  
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01') = 0  
BEGIN  
CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),                          
[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),                          
[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE)               
  
/*Get insAR patAR*/  
SELECT ClientID,ReportYear,ReportMonth,ReportName ATBCategory,AppointmentProvider,  
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],                          
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],                          
SUM(ISNULL(TotalBalance,0))TotalBalance  
INTO #TempTblAGNCOMP FROM PPMReport_ECW_AgingReport(NOLOCK)  
WHERE ReportName IN ('IB','PB') --AND (AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL)                      
AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ClientID = @ClientID  
GROUP BY ClientID,ReportYear,ReportMonth,ReportName,AppointmentProvider  
ORDER BY 4,5  
UPDATE #TempTblAGNCOMP SET AppointmentProvider = 'All Provider' WHERE AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL  
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Insurance AR' WHERE ATBCategory = 'IB'  
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Patient AR' WHERE ATBCategory = 'PB'  
  
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)  
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',AppointmentProvider,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],TotalBalance  
FROM #TempTblAGNCOMP ORDER BY 4,5  
  
/*Total sum calculation*/  
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)  
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',AppointmentProvider,'Total AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                          
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([TotalBalance])TotalBalance                          
FROM #TempTblAGNCOMP  
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider  
  
UPDATE #TempTblAC SET DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')  
  
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)  
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,ProviderName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID  
FROM #TempTblAC  
  
/*Total sum % calculation*/  
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-01',aa.ProviderName,aa.ProviderName,aa.ATBCategory + ' %',  
[0-30] = Round(CONVERT(FLOAT,aa.[0-30]/NULLIF(bb.[0-30],0))*100,2)  
,[31-60] = Round(CONVERT(FLOAT,aa.[31-60]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[61-90] = Round(CONVERT(FLOAT,aa.[61-90]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[91-120] = Round(CONVERT(FLOAT,aa.[91-120]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[121-150] = Round(CONVERT(FLOAT,aa.[121-150]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[151-180] = Round(CONVERT(FLOAT,aa.[151-180]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[181+] = Round(CONVERT(FLOAT,aa.[181+]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[CategoryBalance] = Round(CONVERT(FLOAT,aa.CategoryBalance/NULLIF(bb.[CategoryBalance],0))*100,2),  
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM #TempTblAC aa  
LEFT JOIN PPMReport_AgingComparison(NOLOCK)bb  
ON BB.ClientID = @ClientID AND BB.ProviderName = AA.ProviderName AND aa.ATBCategory = bb.ATBCategory  
AND BB.DTID = DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))  
WHERE AA.ClientID = @ClientID AND BB.ATBCategory IN ('Insurance AR','Patient AR','Total AR') AND  BB.ReportName = 'Aging-01'  
AND AA.ProviderName = 'All Provider'  
  
END  
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC  
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP  
/*-----<<<End AgingComparison Report01>>>-----*/  
  
  
/*-----<<<Start AgingComparison Report02>>>-----*/  
  
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                           
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02') = 0                          
BEGIN                          
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02  
                   
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02' ReportName,tb.AppointmentProvider,InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(SUM(ISNULL(rf.AccountsReceivable,0)),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
INTO #TempTblRep02    
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf                          
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.AppointmentProvider,tb.InsuranceGroup  
UNION  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,AppointmentProvider,'Patient'InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM(  
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,tb.AppointmentProvider,InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable  
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf                          
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,tb.AppointmentProvider,tb.InsuranceGroup,rf.AccountsReceivable                            
)aa  
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.AppointmentProvider  
UNION  
/*GET all provider details*/  
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,'All Provider',InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(ISNULL(SUM(rf.AccountsReceivable),0),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf                          
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.InsuranceGroup  
UNION  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,'All Provider','Patient'InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM(  
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable  
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf                          
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,tb.InsuranceGroup,rf.AccountsReceivable                            
)aa  
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth  
  
  
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],                          
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)   
SELECT ClientID,ReportYear,ReportMonth,ReportName,AppointmentProvider,AppointmentProvider,InsuranceGroup,[0-30],[31-60],                          
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercentage,Over90days,dtid  
FROM #TempTblRep02  
  
END  
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02  
  
/*-----<<<End AgingComparison Report02>>>-----*/  
  
/*-----<<<Start Payer Mix >>>-----*/  
if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
BEGIN  
  
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)  
  
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,InsuranceGroup,  
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))- SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund  
FROM PPMReport_ECW_PayerMix(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth  
AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup  
UNION  
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,'PWOC'InsuranceGroup,  
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund  
FROM PPMReport_ECW_WithoutClaims(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth  
AND (PaymentDate != 'Summary' AND PaymentDate IS NOT NULL)  
GROUP BY ClientID,ReportYear,AppointmentProvider,ReportMonth  
  
UNION  
/*All Provider*/  
select ClientID,ReportYear,ReportMonth,'All Provider' AppointmentProvider,'All Provider' AppointmentProvider,InsuranceGroup,  
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))- SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund  
FROM PPMReport_ECW_PayerMix(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth  
AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup  
UNION  
SELECT ClientID,ReportYear,ReportMonth,'All Provider' AppointmentProvider,'All Provider' AppointmentProvider,'PWOC'InsuranceGroup,  
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund  
FROM PPMReport_ECW_WithoutClaims(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth  
AND (PaymentDate != 'Summary' AND PaymentDate IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth  
  
END  
/*-----<<<End Payer Mix >>>-----*/  
  
COMMIT TRANSACTION           
SET @ErrorMessage = 'Sucess'           
END TRY                      
                                
BEGIN CATCH                      
ROLLBACK TRANSACTION            
SET @ErrorMessage = ERROR_MESSAGE()                
END CATCH           
SELECT CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage          
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECWOutputData_New]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECWOutputData_New]     
(@cId int, @Year int, @month int, @Output VARCHAR(MAX)  OUTPUT)     
AS    
BEGIN   
DECLARE @ErrorMessage VARCHAR(MAX),@Result VARCHAR(MAX)  
    
BEGIN TRY             
BEGIN TRANSACTION  

--DECLARE @ErrorMessage VARCHAR(MAX),@Result VARCHAR(MAX)           
DECLARE @ClientID INT = @cId          
DECLARE @ReportYear INT = @Year            
DECLARE @ReportMonth INT = @month
DECLARE @RWCount INT=0       
    
/*Backup Old Name in charge*/    
UPDATE XL SET XL.XLName = A.EOMName              
FROM(              
SELECT ch.id, pn.ClientID,EOMName,DOPName              
FROM PPMReport_MatchProviderName(NOLOCK)PN              
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH    
ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.AppointmentProvider             
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2    
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName              
)A              
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName              
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear      
/*Update Provider name as DOP Name in Charge*/    
UPDATE XL SET XL.AppointmentProvider = A.DOPName              
FROM(              
SELECT ch.id, pn.ClientID,EOMName,DOPName              
FROM PPMReport_MatchProviderName(NOLOCK)PN              
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH              
ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.AppointmentProvider              
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2             
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName              
)A              
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName              
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
              
---------------------------------------------------    
    
/*-----<<<Start FinancialAnalysis>>>-----*/    
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0    
BEGIN    
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12    
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment    
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays    
    
CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),    
Charges DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),    
AccountsReceivable DECIMAL (18, 2)DEFAULT 0,AROver120 DECIMAL (18, 2)DEFAULT 0,    
ARDaysOutstanding DECIMAL (18, 2)DEFAULT 0,Unapplied DECIMAL (18, 2)DEFAULT 0,    
ClearGage  DECIMAL (18, 2)DEFAULT 0,Collections  DECIMAL (18, 2)DEFAULT 0,DTID DATE)    
    
CREATE TABLE #TempTblPayment(ClientID INT,ReportYear INT,ReportMonth INT,AppointmentProvider VARCHAR(300),    
Charges DECIMAL (18, 2),Payment DECIMAL (18, 2),Refund DECIMAL (18, 2),Amount DECIMAL (18, 2),Contractual DECIMAL (18, 2),    
InsuranceWithheld DECIMAL (18, 2),WriteoffAdjustment DECIMAL (18, 2))    
    
/*All Provider == Charges,Payment,Refund , without pay amt, Adjustments */    
INSERT INTO #TempTblPayment    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.BilledCharge,0)Charge,    
ISNULL(AR.Payment,0)Payment,ISNULL(AR.Refund,0)Refund,ISNULL(WC.Amount,0)Amount,    
ISNULL(AR.Contractual,0)Contractual,ISNULL(AR.InsuranceWithheld,0)InsuranceWithheld,ISNULL(AR.WriteoffAdjustment,0)WriteoffAdjustment    
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR    
LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear     
AND WC.ReportMonth = @ReportMonth AND WC.PaymentDate = 'Summary'    
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary')    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth    
    
/*Individual provider == Charges,Payment,Refund , without pay amt, Adjustments*/    
INSERT INTO #TempTblPayment    
SELECT pmt.ClientID,pmt.ReportYear,pmt.ReportMonth,pmt.AppointmentProvider,    
ISNULL(pmt.Charge,0)Charge,ISNULL(pmt.Payment,0)Payment,pmt.Refund,ISNULL(wAmt.Amount,0)Amount,    
ISNULL(pmt.Contractual,0)Contractual,ISNULL(pmt.InsuranceWithheld,0)InsuranceWithheld,ISNULL(pmt.WriteoffAdjustment,0)WriteoffAdjustment    
FROM(    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider,SUM(ISNULL(AR.BilledCharge,0))Charge,    
SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund,SUM(ISNULL(AR.Contractual,0))Contractual,    
SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment    
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR    
WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary')    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth    
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider    
)pmt    
LEFT JOIN (SELECT WC.ClientID,WC.ReportYear,WC.ReportMonth,WC.AppointmentProvider,SUM(ISNULL(WC.Amount,0))Amount     
FROM PPMReport_ECW_WithoutClaims(NOLOCK)WC     
WHERE WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth     
AND WC.PaymentDate != 'Summary'    
GROUP BY WC.ClientID,WC.ReportYear,WC.ReportMonth,WC.AppointmentProvider)wAmt    
ON wAmt.ClientID = pmt.ClientID AND wAmt.ReportYear = pmt.ReportYear AND wAmt.ReportMonth = pmt.ReportMonth    
AND wAmt.AppointmentProvider = pmt.AppointmentProvider    
    
/*insert in #TempTblpg1to12 table*/    
INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)    
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,SUM(Charges)Charges,    
SUM((Payment-Refund)+Amount)Payment,SUM(Refund)Refund,    
SUM(Contractual+InsuranceWithheld+WriteoffAdjustment)Adjustments,    
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID    
FROM #TempTblPayment    
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider    
    
/*Update Accounts Receivable */    
UPDATE ARA SET ARA.AccountsReceivable = ISNULL(A.TotalBalance,0),ARA.AROver120 = A.AROver120    
FROM(    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,SUM(ISNULL(AR.TotalBalance,0))TotalBalance,    
SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120    
FROM PPMReport_ECW_AgingReport(NOLOCK)AR    
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'AS'    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth    
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth    
UNION    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider,SUM(ISNULL(AR.TotalBalance,0))TotalBalance,    
SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120    
FROM PPMReport_ECW_AgingReport(NOLOCK)AR    
WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary') AND ReportName = 'AS'    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth    
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,AR.AppointmentProvider    
)A    
INNER JOIN #TempTblpg1to12 ARA     
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.AppointmentProvider     
    
/*ARDaysOutstanding*/                            
SELECT ClientID,ReportMonth,ReportYear,ProviderName,Charges,DTID                            
INTO #TempTblpg1to12ARDays FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)     
WHERE ClientID = @ClientID AND                            
DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                             
DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')                            
SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1    
IF @RWCount = 1    
BEGIN    
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                           
FROM(    
SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((ISNULL(Charges,0)/(30)),0),0),0)ARDays                             
FROM #TempTblpg1to12     
WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                            
GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges    
)AR         
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                             
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                            
END    
ELSE    
BEGIN    
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays    
FROM(    
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,    
ISNULL(NULLIF(ISNULL(ABS(ISNULL(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays                            
FROM #TempTblpg1to12 AA     
LEFT JOIN (SELECT ClientID,ProviderName,SUM(ISNULL(Charges,0))Charges     
FROM #TempTblpg1to12ARDays                             
GROUP BY  ClientID,ProviderName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName = bb.ProviderName    
WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear                            
GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable    
)AR                            
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                             
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                            
END    
    
/*UnappliedBalance*/     
UPDATE ARA SET ARA.Unapplied = ISNULL(A.TotalBalance,0)    
FROM(    
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.TotalBalance,0)TotalBalance    
FROM PPMReport_ECW_AgingReport(NOLOCK)AR    
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'CB'    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth    
)A    
INNER JOIN #TempTblpg1to12 ARA     
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.AppointmentProvider     
-------------    
    
/*Update Cleargage*/      
UPDATE ARA SET ARA.ClearGage = ISNULL(A.ClearGage,0)    
FROM(    
SELECT CL.ID ClientID,CG.ReportYear,CG.ReportMonth,'All Provider' ProviderName,ISNULL(CG.Credit,0)ClearGage    
FROM PPMReport_ClearGage(NOLOCK)CG    
INNER JOIN PPMReport_ClientList(NOLOCK)CL     
ON CL.ID = @ClientID AND CL.ClientFullName = CG.PPMMerchantAccount    
WHERE ReportYear = @ReportYear AND ReportMonth = @ReportMonth AND IsActive = 1 AND CL.ID = @ClientID    
)A    
INNER JOIN #TempTblpg1to12 ARA     
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName     
    
/*Update Collections*/     
UPDATE ARA SET ARA.Collections = ISNULL(A.Collections,0)    
FROM(    
SELECT ClientID,ReportYear,ReportMonth,SUM(ISNULL(AdjustmentAmount,0))Collections,'All Provider' ProviderName    
FROM PPMReport_ECW_Collection(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
GROUP BY ClientID,ReportYear,ReportMonth    
)A    
INNER JOIN #TempTblpg1to12 ARA     
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName     
    
/*insert to main table*/    
INSERT INTO PPMReport_ECW_FinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,    
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)    
SELECT ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,    
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID    
FROM #TempTblpg1to12  
END    
    

/*insert to main table Yearly Compare data*/      
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis_YrlyTrend(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0    
BEGIN    
INSERT INTO PPMReport_ECW_FinancialAnalysis_YrlyTrend(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,    
AccountsReceivable,AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)    
SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName,                             
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,                            
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,                                                    
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,    
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,                            
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,                            
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,    
CONVERT(FLOAT,ISNULL(SUM(CY.Unapplied-PY.Unapplied)/NULLIF(ISNULL(SUM(PY.Unapplied),0),0),0))*100 YrlyUnapplied,       
CONVERT(FLOAT,ISNULL(SUM(CY.ClearGage-PY.ClearGage)/NULLIF(ISNULL(SUM(PY.ClearGage),0),0),0))*100 YrlyClearGage,       
CONVERT(FLOAT,ISNULL(SUM(CY.Collections-PY.Collections)/NULLIF(ISNULL(SUM(PY.Collections),0),0),0))*100 YrlyCollections,    
CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,    
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID    
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)CY     
LEFT JOIN (SELECT * FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                             
WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY                             
ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ProviderName=PY.ProviderName                            
WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth                            
GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName                             
END    
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12    
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment    
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays    
/*-----<<<End FinancialAnalysis>>>-----*/    
    
    
/*-----<<<Start CPT Report>>>-----*/    
IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0    
BEGIN    
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT    
/*Get CPTDescription,wRVU info*/    
SELECT ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription    
INTO #TempTblCPT FROM PPMReport_wRVUList(NOLOCK)wrv    
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT    
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL    
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth    
GROUP BY ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU    
    
/*individual provider*/    
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)    
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,AppointmentProvider,AppointmentProvider,ProcedureCode,cpt.CPTGroup,    
CPTDescription,ISNULL(Units,0)Units    
FROM(    
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider,CPTGroup,    
SUM(ISNULL(BilledUnits,0))Units    
FROM PPMReport_ECW_CPT(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider,CPTGroup    
)cpt    
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt.ProcedureCode    
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth    
    
/*All provider*/    
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)    
SELECT cpt1.ClientID,cpt1.ReportYear,cpt1.ReportMonth,'All Provider','All Provider',cpt1.ProcedureCode,cpt1.CPTGroup,    
CPTDescription,ISNULL(Units,0)Units    
FROM(    
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup,    
SUM(ISNULL(BilledUnits,0))Units    
FROM PPMReport_ECW_CPT(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup    
)cpt1    
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt1.ProcedureCode    
WHERE cpt1.ClientID = @ClientID AND cpt1.ReportYear = @ReportYear AND cpt1.ReportMonth = @ReportMonth    
    
END    
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT    
/*-----<<<End CPT Report>>>-----*/    
    
    
/*-----<<<Start WRVU Report>>>-----*/    
IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0    
BEGIN    
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU    
/*Get CPTDescription,wRVU info*/    
SELECT ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU    
INTO #TempTblWRVU FROM PPMReport_wRVUList(NOLOCK)wrv    
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT    
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL    
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth    
GROUP BY ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU    
    
/*individual provider*/    
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)    
    
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,AppointmentProvider,AppointmentProvider,ProcedureCode,    
CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))    
FROM(    
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider,    
SUM(ISNULL(BilledUnits,0))Units    
FROM PPMReport_ECW_CPT(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,AppointmentProvider    
)cpt    
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode    
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth    
and (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')    
    
/*All provider*/    
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)    
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,'All Provider'AppointmentProvider,'All Provider' AppointmentProvider,ProcedureCode,    
CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))    
FROM(    
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,    
SUM(ISNULL(BilledUnits,0))Units    
FROM PPMReport_ECW_CPT(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')    
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode    
)cpt    
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode    
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth    
    
END    
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU    
/*-----<<<End WRVU Report>>>-----*/    
    
    
/*-----<<<Start Financial Dashboard>>>-----*/    
IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0    
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard    
BEGIN    
CREATE TABLE #TempTblFinancialDashboard(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(200),ShortName VARCHAR(200),                            
ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2)DEFAULT 0)    
/*Revenue Analysis*/    
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)    
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName, ReportName, TotalCount                           
FROM(    
SELECT  ClientID,ReportYear,ReportMonth,ProviderName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,    
Unapplied,AccountsReceivable,ClearGage,Collections    
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                            
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
) PVT                            
UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,AccountsReceivable,ClearGage,Collections))AS unpvt;        
    
/*Encounter Analysis*/    
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)    
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'Encounter Analysis' ReportName,CPTGroupDesc, SUM(UNITS)UNITS    
FROM PPMReport_ProcedureCount(NOLOCK)                            
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName,CPTGroupDesc    
    
/*CPT Count*/    
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)    
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'CPT' ReportName, SUM(UNITS)UNITS    
FROM PPMReport_ProcedureCount(NOLOCK)                            
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName    
    
/*WVRU Count*/    
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)    
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'WVRU' ReportName, SUM(wRVU)wRVU    
FROM PPMReport_wRVUReport(NOLOCK)                            
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth    
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName    
    
INSERT INTO PPMReport_FinancialDashboard (ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)    
SELECT * FROM #TempTblFinancialDashboard    
ORDER BY 5,6    
    
END    
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard    
/*-----<<<End Financial Dashboard>>>-----*/    
    
    
/*-----<<<Start AgingComparison Report01>>>-----*/    
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC      
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)      
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01') = 0      
BEGIN      
      
CREATE TABLE #TempTblAC(      
ClientID  INT,      
ReportYear  INT,      
ReportMonth  INT,      
ReportName  VARCHAR(50),      
ProviderName VARCHAR(100),      
ATBCategory  VARCHAR(50),      
[0-30]   DECIMAL(18,2),      
[31-60]   DECIMAL(18,2),      
[61-90]   DECIMAL(18,2),      
[91-120]  DECIMAL(18,2),      
[121-150]  DECIMAL(18,2),      
[151-180]  DECIMAL(18,2),      
[181+]   DECIMAL(18,2),      
CategoryBalance DECIMAL(18,2),      
DTID   DATE)      
      
/*Insurance AR*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,'All Provider'ProviderName,'Insurance AR' ATBCategory,      
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],      
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],      
SUM(ISNULL(TotalBalance,0))[CategoryBalance]      
FROM PPMReport_ECW_AgingReport(NOLOCK)      
WHERE ReportName ='IB' AND (AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL) AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth      
/*Patient AR*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,'All Provider'ProviderName,'Patient AR' ATBCategory,      
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],      
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],      
SUM(ISNULL(TotalBalance,0))[CategoryBalance]      
FROM PPMReport_ECW_AgingReport(NOLOCK)      
WHERE ReportName ='PB' AND (AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL) AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth      
      
/*Total AR = sum of Insurance AR & Patient AR*/                          
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,ProviderName,'Total AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                          
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]                          
FROM #TempTblAC GROUP BY ClientID,ReportYear,ReportMonth,ProviderName                          
      
UPDATE #TempTblAC set DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')      
      
/*Chg Ins %*/                      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)      
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Ins %' ATBCategory                          
,[0-30] = ISNULL(Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2),0)      
,[31-60] = ISNULL(Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[61-90] = ISNULL(Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[91-120] = ISNULL(Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[121-150] = ISNULL(Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[151-180] = ISNULL(Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[181+] = ISNULL(Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[CategoryBalance] = ISNULL(Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),0),      
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
FROM #TempTblAC cChg       
LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)      
WHERE ClientID=@ClientID AND ATBCategory = 'Insurance AR' AND  ReportName = 'Aging-01'                           
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg                     
ON cChg.ClientID=ochg.ClientID and cChg.ProviderName = oChg.ProviderName      
WHERE cChg.ATBCategory = 'Insurance AR' AND  cChg.ReportName = 'Aging-01'      
      
/*Chg Pat %*/       
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)      
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Pat %' ATBCategory                          
,[0-30] = ISNULL(Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2),0)                          
,[31-60] = ISNULL(Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[61-90] = ISNULL(Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[91-120] = ISNULL(Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[121-150] = ISNULL(Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[151-180] = ISNULL(Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[181+] = ISNULL(Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[CategoryBalance] = ISNULL(Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),0),                          
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
FROM #TempTblAC cChg       
LEFT JOIN (      
SELECT * FROM PPMReport_AgingComparison(NOLOCK)      
WHERE ClientID=@ClientID AND ATBCategory = 'Patient AR' AND  ReportName = 'Aging-01'      
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))      
)oChg      
ON cChg.ClientID=ochg.ClientID and cChg.ProviderName = oChg.ProviderName      
WHERE cChg.ATBCategory = 'Patient AR' AND  cChg.ReportName = 'Aging-01'                          
      
/*Total Chg Pat %*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)      
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Total Chg %' ATBCategory                          
,[0-30] = ISNULL(Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2),0)      
,[31-60] = ISNULL(Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[61-90] = ISNULL(Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[91-120] = ISNULL(Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[121-150] = ISNULL(Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[151-180] = ISNULL(Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[181+] = ISNULL(Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2),0)      
,[CategoryBalance] = ISNULL(Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),0),      
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
FROM #TempTblAC cChg       
LEFT JOIN       
(SELECT * FROM PPMReport_AgingComparison(NOLOCK)      
WHERE ClientID=@ClientID AND ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'      
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))      
)oChg      
ON cChg.ClientID=ochg.ClientID and cChg.ProviderName = oChg.ProviderName      
WHERE cChg.ATBCategory = 'Total AR' AND  cChg.ReportName = 'Aging-01'      
      
/*Aging-01 PPMReport AgingComparison All Provider move*/                          
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,      
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],[CategoryBalance],DTID)      
SELECT ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ProviderName,ATBCategory,      
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID      
FROM #TempTblAC      
END      
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC      
    
/*------Temp    
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC    
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP    
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)    
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01') = 0    
BEGIN    
CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),                            
[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),                            
[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE)                 
    
/*Get insAR patAR*/    
SELECT ClientID,ReportYear,ReportMonth,ReportName ATBCategory,AppointmentProvider,    
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],                            
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],                            
SUM(ISNULL(TotalBalance,0))TotalBalance    
INTO #TempTblAGNCOMP FROM PPMReport_ECW_AgingReport(NOLOCK)    
WHERE ReportName IN ('IB','PB') --AND (AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL)                        
AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ClientID = @ClientID    
GROUP BY ClientID,ReportYear,ReportMonth,ReportName,AppointmentProvider    
ORDER BY 4,5    
UPDATE #TempTblAGNCOMP SET AppointmentProvider = 'All Provider' WHERE AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL    
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Insurance AR' WHERE ATBCategory = 'IB'    
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Patient AR' WHERE ATBCategory = 'PB'    
    
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)    
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',AppointmentProvider,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],TotalBalance    
FROM #TempTblAGNCOMP ORDER BY 4,5    
    
/*Total sum calculation*/    
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)    
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',AppointmentProvider,'Total AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                        
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([TotalBalance])TotalBalance                            
FROM #TempTblAGNCOMP    
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider    
    
UPDATE #TempTblAC SET DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')    
    
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)    
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,ProviderName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID    
FROM #TempTblAC    
    
/*Total sum % calculation*/    
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)    
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-01',aa.ProviderName,aa.ProviderName,aa.ATBCategory + ' %',    
[0-30] = Round(CONVERT(FLOAT,aa.[0-30]/NULLIF(bb.[0-30],0))*100,2)    
,[31-60] = Round(CONVERT(FLOAT,aa.[31-60]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[61-90] = Round(CONVERT(FLOAT,aa.[61-90]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[91-120] = Round(CONVERT(FLOAT,aa.[91-120]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[121-150] = Round(CONVERT(FLOAT,aa.[121-150]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[151-180] = Round(CONVERT(FLOAT,aa.[151-180]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[181+] = Round(CONVERT(FLOAT,aa.[181+]/NULLIF(bb.[CategoryBalance],0))*100,2)    
,[CategoryBalance] = Round(CONVERT(FLOAT,aa.CategoryBalance/NULLIF(bb.[CategoryBalance],0))*100,2),    
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid    
FROM #TempTblAC aa    
LEFT JOIN PPMReport_AgingComparison(NOLOCK)bb    
ON BB.ClientID = @ClientID AND BB.ProviderName = AA.ProviderName AND aa.ATBCategory = bb.ATBCategory    
AND BB.DTID = DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))    
WHERE AA.ClientID = @ClientID AND BB.ATBCategory IN ('Insurance AR','Patient AR','Total AR') AND  BB.ReportName = 'Aging-01'    
AND AA.ProviderName = 'All Provider'    
    
END    
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC    
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP    
*/    
    
/*-----<<<End AgingComparison Report01>>>-----*/    
    
    
/*-----<<<Start AgingComparison Report02>>>-----*/    
    
IF OBJECT_ID('tempdb..#TempTblAC01') IS NOT NULL DROP TABLE #TempTblAC01      
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                           
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02')<=0      
BEGIN      
CREATE TABLE #TempTblAC01(      
ClientID  INT,      
ReportYear  INT,      
ReportMonth  INT,      
ReportName  VARCHAR(50),      
ProviderName VARCHAR(100),      
ATBCategory  VARCHAR(50),      
[0-30]   DECIMAL(18,2),      
[31-60]   DECIMAL(18,2),      
[61-90]   DECIMAL(18,2),      
[91-120]  DECIMAL(18,2),      
[121-150]  DECIMAL(18,2),      
[151-180]  DECIMAL(18,2),      
[181+]   DECIMAL(18,2),      
CategoryBalance DECIMAL(18,2),      
TotalPercent DECIMAL(18,2),      
Over90Days  DECIMAL(18,2),      
DTID   DATE)      
      
/*Insurance Info All Provider*/      
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],      
[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,'All Provider'ProviderName,InsuranceGroup AS ATBCategory,      
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],      
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],      
SUM(ISNULL(TotalBalance,0))[CategoryBalance]      
FROM PPMReport_ECW_AgingReport(NOLOCK)      
WHERE ReportName ='IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)      
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup      
      
/*Insurance Info Each Provider*/      
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],      
[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,AppointmentProvider,InsuranceGroup AS ATBCategory,      
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],      
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],      
SUM(ISNULL(TotalBalance,0))[CategoryBalance]      
FROM PPMReport_ECW_AgingReport(NOLOCK)      
WHERE ReportName ='IB' AND (AppointmentProvider != 'Summary'  AND AppointmentProvider IS NOT NULL)    
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup      
      
/*Patient Info All Provider*/      
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],      
[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,'All Provider'ProviderName,'Patient' ATBCategory,      
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],      
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],      
SUM(ISNULL(TotalBalance,0))[CategoryBalance]      
FROM PPMReport_ECW_AgingReport(NOLOCK)      
WHERE ReportName ='PB' AND (AppointmentProvider != 'Summary'  AND AppointmentProvider IS NOT NULL)    
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth      
      
/*Unapplied Info All Provider*/      
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],      
[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,'All Provider'ProviderName,'Unapplied' ATBCategory,      
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],      
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],      
SUM(ISNULL(TotalBalance,0))[CategoryBalance]      
FROM PPMReport_ECW_AgingReport(NOLOCK)       
WHERE (AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL) AND ReportName = 'CB'      
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider      
      
/*Patient Info Each Provider*/      
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],      
[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,AppointmentProvider,'Patient' ATBCategory,      
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],      
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],      
SUM(ISNULL(TotalBalance,0))[CategoryBalance]      
FROM PPMReport_ECW_AgingReport(NOLOCK)      
WHERE ReportName ='PB' AND (AppointmentProvider != 'Summary'  AND AppointmentProvider IS NOT NULL)    
AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider      
      
/*Unapplied Info All Provider*/      
INSERT INTO #TempTblAC01(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],      
[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-02'ReportName,AppointmentProvider,'Unapplied' ATBCategory,      
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],      
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],      
SUM(ISNULL(TotalBalance,0))[CategoryBalance]      
FROM PPMReport_ECW_AgingReport(NOLOCK)       
WHERE (AppointmentProvider != 'Summary' OR AppointmentProvider IS NOT NULL) AND ReportName = 'CB'      
AND ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider      
      
UPDATE #TempTblAC01 SET DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')      
      
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,      
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],[CategoryBalance],DTID,TotalPercent,Over90Days)      
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,tb.ProviderName,tb.ProviderName,ATBCategory,      
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'),      
TotalPercent = ISNULL(ROUND(CONVERT(float,SUM([CategoryBalance]) /NULLIF(ISNULL(rf.AccountsReceivable,0),0))*100,2),0),      
Over90days = ISNULL(ROUND(CONVERT(FLOAT,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)      
FROM #TempTblAC01 tb      
LEFT JOIN (      
SELECT ReportMonth,ProviderName, AccountsReceivable       
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear      
)rf      
ON tb.ProviderName = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth      
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth      
GROUP BY ClientID,ReportYear,tb.ReportMonth,ReportName,tb.ProviderName,ATBCategory,rf.AccountsReceivable      
      
END      
IF OBJECT_ID('tempdb..#TempTblAC01') IS NOT NULL DROP TABLE #TempTblAC01      
      
/*    
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                             
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02') = 0                            
BEGIN                            
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02    
                     
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02' ReportName,tb.AppointmentProvider,InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]    
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(SUM(ISNULL(rf.AccountsReceivable,0)),0))*100,2),0)    
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)    
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid    
INTO #TempTblRep02      
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                             
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable     
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                             
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear    
)rf                            
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                            
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth    
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.AppointmentProvider,tb.InsuranceGroup    
UNION    
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,AppointmentProvider,'Patient'InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance    
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)    
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)    
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid    
FROM(    
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,tb.AppointmentProvider,InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable    
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                             
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable     
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                             
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear    
)rf                            
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                            
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth    
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,tb.AppointmentProvider,tb.InsuranceGroup,rf.AccountsReceivable                              
)aa    
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.AppointmentProvider    
UNION    
/*GET all provider details*/    
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,'All Provider',InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]    
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(ISNULL(SUM(rf.AccountsReceivable),0),0))*100,2),0)    
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)    
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid    
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                             
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable     
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                             
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear    
)rf                            
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                            
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth    
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.InsuranceGroup    
UNION    
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,'All Provider','Patient'InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance    
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)    
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)    
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid    
FROM(    
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,InsuranceGroup,    
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],    
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable    
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                             
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable     
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                             
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear    
)rf                            
ON tb.AppointmentProvider = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                            
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth    
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,tb.InsuranceGroup,rf.AccountsReceivable                              
)aa    
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth    
    
    
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],                            
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)     
SELECT ClientID,ReportYear,ReportMonth,ReportName,AppointmentProvider,AppointmentProvider,InsuranceGroup,[0-30],[31-60],                            
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercentage,Over90days,dtid    
FROM #TempTblRep02    
    
END    
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02    
*/    
/*-----<<<End AgingComparison Report02>>>-----*/    
    
/*-----<<<Start Payer Mix >>>-----*/    
if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0    
BEGIN    
    
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)    
    
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,InsuranceGroup,    
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))- SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund    
FROM PPMReport_ECW_PayerMix(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth    
AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY ClientID,ReportYear,ReportMonth,AppointmentProvider,InsuranceGroup    
UNION    
SELECT ClientID,ReportYear,ReportMonth,AppointmentProvider,AppointmentProvider,'PWOC'InsuranceGroup,    
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund    
FROM PPMReport_ECW_WithoutClaims(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth    
AND (PaymentDate != 'Summary' AND PaymentDate IS NOT NULL)    
GROUP BY ClientID,ReportYear,AppointmentProvider,ReportMonth    
    
UNION    
/*All Provider*/    
select ClientID,ReportYear,ReportMonth,'All Provider' AppointmentProvider,'All Provider' AppointmentProvider,InsuranceGroup,    
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))- SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund    
FROM PPMReport_ECW_PayerMix(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth    
AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)    
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup    
UNION    
SELECT ClientID,ReportYear,ReportMonth,'All Provider' AppointmentProvider,'All Provider' AppointmentProvider,'PWOC'InsuranceGroup,    
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund    
FROM PPMReport_ECW_WithoutClaims(NOLOCK)    
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth    
AND (PaymentDate != 'Summary' AND PaymentDate IS NOT NULL)    
GROUP BY ClientID,ReportYear,ReportMonth    
    
END    
/*-----<<<End Payer Mix >>>-----*/    
    
COMMIT TRANSACTION             
SET @ErrorMessage = 'Sucess'             
END TRY                        
                                  
BEGIN CATCH                        
ROLLBACK TRANSACTION              
SET @ErrorMessage = ERROR_MESSAGE()                  
END CATCH 
  
SET @Output = CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage     
--select @Output              
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_ECWOutputData_TrimRmv]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_ECWOutputData_TrimRmv]
(@cId int, @Year int, @month int)  
AS  
BEGIN  
DECLARE @ErrorMessage VARCHAR(MAX)  
  
BEGIN TRY           
BEGIN TRANSACTION          
DECLARE @ClientID INT = @cId          
DECLARE @ReportYear INT = @Year          
DECLARE @ReportMonth INT = @month          
DECLARE @RWCount INT=0
DECLARE @providerList INT = 0

/*Validate Provider name list*/
if (SELECT COUNT(ClientID) FROM PPMReport_ECW_ProviderNameList(NOLOCK) WHERE ClientID = @ClientID) > 0
	BEGIN
		SET @providerList = (SELECT COUNT(ClientID) FROM PPMReport_ECW_ProviderNameList(NOLOCK) WHERE ClientID = @ClientID)
	END
ELSE
	BEGIN
		SET @providerList = 0
	END
	  
/*Backup Old Name in charge*/  
UPDATE XL SET XL.XLName = A.EOMName            
FROM(            
SELECT ch.id, pn.ClientID,EOMName,DOPName            
FROM PPMReport_MatchProviderName(NOLOCK)PN            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH  
ON PN.ClientID = CH.ClientID AND PN.EOMName = CH.AppointmentProvider           
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2  
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName            
)A            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName            
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear    
/*Update Provider name as DOP Name in Charge*/  
UPDATE XL SET XL.AppointmentProvider = A.DOPName            
FROM(            
SELECT ch.id, pn.ClientID,EOMName,DOPName            
FROM PPMReport_MatchProviderName(NOLOCK)PN            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)CH            
ON PN.ClientID = CH.ClientID AND PN.EOMName = CH.AppointmentProvider            
WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 2           
GROUP BY CH.ID, pn.ClientID,EOMName,DOPName            
)A            
INNER JOIN PPMReport_ECW_WithoutClaims(NOLOCK)XL ON XL.ID=A.ID AND XL.AppointmentProvider = A.EOMName            
WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear      
            
---------------------------------------------------  
  
/*-----<<<Start FinancialAnalysis>>>-----*/  
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0  
BEGIN  
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12  
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment  
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays  
  
CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),  
Charges DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),  
AccountsReceivable DECIMAL (18, 2)DEFAULT 0,AROver120 DECIMAL (18, 2)DEFAULT 0,  
ARDaysOutstanding DECIMAL (18, 2)DEFAULT 0,Unapplied DECIMAL (18, 2)DEFAULT 0,  
ClearGage  DECIMAL (18, 2)DEFAULT 0,Collections  DECIMAL (18, 2)DEFAULT 0,DTID DATE)  
  
CREATE TABLE #TempTblPayment(ClientID INT,ReportYear INT,ReportMonth INT,AppointmentProvider VARCHAR(300),  
Charges DECIMAL (18, 2),Payment DECIMAL (18, 2),Refund DECIMAL (18, 2),Amount DECIMAL (18, 2),Contractual DECIMAL (18, 2),  
InsuranceWithheld DECIMAL (18, 2),WriteoffAdjustment DECIMAL (18, 2))  
  
/*All Provider == Charges,Payment,Refund , without pay amt, Adjustments */  
INSERT INTO #TempTblPayment
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.BilledCharge,0)Charge,    
ISNULL(AR.Payment,0)Payment,ISNULL(AR.Refund,0)Refund,ISNULL(WC.Amount,0)Amount,    
ISNULL(AR.Contractual,0)Contractual,ISNULL(AR.InsuranceWithheld,0)InsuranceWithheld,ISNULL(AR.WriteoffAdjustment,0)WriteoffAdjustment    
FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR    
LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear     
AND WC.ReportMonth = @ReportMonth AND (WC.PaymentDate = 'Summary'OR WC.AppointmentProvider is null)
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary')    
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
 
/*Individual provider == Charges,Payment,Refund , without pay amt, Adjustments*/
if @providerList > 0
	BEGIN  
		INSERT INTO #TempTblPayment
		SELECT PMT.ClientID,PMT.ReportYear,PMT.ReportMonth,RTRIM(LTRIM(PMT.AppointmentProvider))AppointmentProvider,PMT.Charge,  
		PMT.Payment,PMT.Refund,SUM(ISNULL(WC.Amount,0))Amount,  
		PMT.Contractual,PMT.InsuranceWithheld,PMT.WriteoffAdjustment
		FROM(
		SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,
		SUM(ISNULL(AR.BilledCharge,0))Charge,  
		SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund, 
		SUM(ISNULL(AR.Contractual,0))Contractual,SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,
		SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment  
		FROM PPMReport_ECW_ARBeginEnd(NOLOCK) AR
		INNER JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl 
			ON nl.ClientID = @ClientID AND RTRIM(LTRIM(NL.ProviderName)) = RTRIM(LTRIM(AR.AppointmentProvider))
		WHERE AR.CLIENTID = @ClientID  AND AR.ReportMonth = @ReportMonth AND AR.ReportYear = @ReportYear
		AND (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary') 
		GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))
		)PMT
		LEFT JOIN PPMReport_ECW_WithoutClaims(NOLOCK)WC 
		ON WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth 
		AND WC.AppointmentProvider = PMT.AppointmentProvider AND WC.AppointmentProvider IS NOT NULL
		GROUP BY PMT.ClientID,PMT.ReportYear,PMT.ReportMonth,RTRIM(LTRIM(PMT.AppointmentProvider)),
		PMT.Charge,PMT.Payment,PMT.Refund,PMT.Contractual,PMT.InsuranceWithheld,PMT.WriteoffAdjustment
	END
ELSE
	BEGIN
		INSERT INTO #TempTblPayment
		SELECT pmt.ClientID,pmt.ReportYear,pmt.ReportMonth,RTRIM(LTRIM(pmt.AppointmentProvider))AppointmentProvider,  
		ISNULL(pmt.Charge,0)Charge,ISNULL(pmt.Payment,0)Payment,pmt.Refund,ISNULL(wAmt.Amount,0)Amount,  
		ISNULL(pmt.Contractual,0)Contractual,ISNULL(pmt.InsuranceWithheld,0)InsuranceWithheld,ISNULL(pmt.WriteoffAdjustment,0)WriteoffAdjustment  
		FROM(  
		SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))AppointmentProvider,
		SUM(ISNULL(AR.BilledCharge,0))Charge,  
		SUM(ISNULL(AR.Payment,0))Payment,SUM(ISNULL(AR.Refund,0))Refund,SUM(ISNULL(AR.Contractual,0))Contractual,  
		SUM(ISNULL(AR.InsuranceWithheld,0))InsuranceWithheld,SUM(ISNULL(AR.WriteoffAdjustment,0))WriteoffAdjustment  
		FROM PPMReport_ECW_ARBeginEnd(NOLOCK)AR  
		WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary')  
		AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
		GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))  
		)pmt  
		LEFT JOIN (SELECT WC.ClientID,WC.ReportYear,WC.ReportMonth,RTRIM(LTRIM(WC.AppointmentProvider))AppointmentProvider,
		SUM(ISNULL(WC.Amount,0))Amount   
		FROM PPMReport_ECW_WithoutClaims(NOLOCK)WC   
		WHERE WC.ClientID = @ClientID AND WC.ReportYear = @ReportYear AND WC.ReportMonth = @ReportMonth   
		AND WC.PaymentDate != 'Summary'  
		GROUP BY WC.ClientID,WC.ReportYear,WC.ReportMonth,RTRIM(LTRIM(WC.AppointmentProvider)))wAmt 	 
		ON wAmt.ClientID = pmt.ClientID AND wAmt.ReportYear = pmt.ReportYear AND wAmt.ReportMonth = pmt.ReportMonth  
		AND wAmt.AppointmentProvider = pmt.AppointmentProvider
	END

/*insert in #TempTblpg1to12 table*/  
INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)  
SELECT ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,
SUM(Charges)Charges, SUM((Payment-Refund)+Amount)Payment,SUM(Refund)Refund,  
SUM(Contractual+InsuranceWithheld+WriteoffAdjustment)Adjustments,  
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID  
FROM #TempTblPayment  
GROUP BY ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))  
  
/*Update Accounts Receivable */  
UPDATE ARA SET ARA.AccountsReceivable = ISNULL(A.TotalBalance,0),ARA.AROver120 = A.AROver120  
FROM(  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,SUM(ISNULL(AR.TotalBalance,0))TotalBalance,  
SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120  
FROM PPMReport_ECW_AgingReport(NOLOCK)AR  
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'AS'  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth  
UNION  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))AppointmentProvider,
SUM(ISNULL(AR.TotalBalance,0))TotalBalance,  SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120  
FROM PPMReport_ECW_AgingReport(NOLOCK)AR  
WHERE (AR.AppointmentProvider != 'Summary' OR AR.RenderingProvider != 'Summary') AND ReportName = 'AS'  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
GROUP BY AR.ClientID,AR.ReportYear,AR.ReportMonth,RTRIM(LTRIM(AR.AppointmentProvider))  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth 
AND RTRIM(LTRIM(ARA.ProviderName)) = RTRIM(LTRIM(a.AppointmentProvider))  
  
/*ARDaysOutstanding*/                          
SELECT ClientID,ReportMonth,ReportYear,ProviderName,Charges,DTID                          
INTO #TempTblpg1to12ARDays FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)   
WHERE ClientID = @ClientID AND                          
DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                           
DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')                          
SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1  
IF @RWCount = 1  
	BEGIN  
	UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                         
	FROM(  
	SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((ISNULL(Charges,0)/(30)),0),0),0)ARDays                           
	FROM #TempTblpg1to12   
	WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                          
	GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges  
	)AR       
	INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                           
	ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                          
	END  
ELSE  
	BEGIN  
	UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays  
	FROM(  
	SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,  
	ISNULL(NULLIF(ISNULL(ABS(ISNULL(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays                          
	FROM #TempTblpg1to12 AA   
	LEFT JOIN (SELECT ClientID,ProviderName,SUM(ISNULL(Charges,0))Charges   
	FROM #TempTblpg1to12ARDays                           
	GROUP BY  ClientID,ProviderName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName = bb.ProviderName  
	WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear                          
	GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable  
	)AR                          
	INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                           
	ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                          
	END  
  
/*UnappliedBalance*/   
UPDATE ARA SET ARA.Unapplied = ISNULL(A.TotalBalance,0)  
FROM(  
SELECT AR.ClientID,AR.ReportYear,AR.ReportMonth,'All Provider' AppointmentProvider,ISNULL(AR.TotalBalance,0)TotalBalance  
FROM PPMReport_ECW_AgingReport(NOLOCK)AR  
WHERE (AR.AppointmentProvider = 'Summary' OR AR.RenderingProvider = 'Summary') AND ReportName = 'CB'  
AND AR.ClientID = @ClientID AND AR.ReportYear = @ReportYear AND AR.ReportMonth = @ReportMonth  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth 
AND RTRIM(LTRIM(ARA.ProviderName)) = RTRIM(LTRIM(a.AppointmentProvider))   
  
/*Update Cleargage*/    
UPDATE ARA SET ARA.Unapplied = ISNULL(A.ClearGage,0)  
FROM(  
SELECT CL.ID ClientID,CG.ReportYear,CG.ReportMonth,'All Provider' ProviderName,ISNULL(CG.Credit,0)ClearGage  
FROM PPMReport_ClearGage(NOLOCK)CG  
INNER JOIN PPMReport_ClientList(NOLOCK)CL   
ON CL.ID = @ClientID AND CL.ClientFullName = CG.PPMMerchantAccount  
WHERE ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName   
  
/*Update Collections*/   
UPDATE ARA SET ARA.Collections = ISNULL(A.Collections,0)  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,SUM(ISNULL(AdjustmentAmount,0))Collections,'All Provider' ProviderName  
FROM PPMReport_ECW_Collection(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth  
)A  
INNER JOIN #TempTblpg1to12 ARA   
ON ARA.ClientID = a.ClientID AND ARA.ReportYear = a.ReportYear AND ARA.ReportMonth = a.ReportMonth AND ARA.ProviderName = a.ProviderName   
  
/*insert to main table*/  
INSERT INTO PPMReport_ECW_FinancialAnalysis(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,  
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)  
SELECT ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,AccountsReceivable,  
AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID  
FROM #TempTblpg1to12  
END  
  
/*insert to main table Yearly Compare data*/    
if (SELECT Count(*) FROM PPMReport_ECW_FinancialAnalysis_YrlyTrend(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)= 0  
BEGIN  
	INSERT INTO PPMReport_ECW_FinancialAnalysis_YrlyTrend(ClientID,ReportYear,ReportMonth,ProviderName,Charges,Payments,Adjustments,  
	AccountsReceivable,AROver120,ARDaysOutstanding,Unapplied,ClearGage,Collections,Refunds,DTID)  
	SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName,                           
	CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,                          
	CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,                                                  
	CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,  
	CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,                          
	CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,                          
	CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,  
	CONVERT(FLOAT,ISNULL(SUM(CY.Unapplied-PY.Unapplied)/NULLIF(ISNULL(SUM(PY.Unapplied),0),0),0))*100 YrlyUnapplied,     
	CONVERT(FLOAT,ISNULL(SUM(CY.ClearGage-PY.ClearGage)/NULLIF(ISNULL(SUM(PY.ClearGage),0),0),0))*100 YrlyClearGage,     
	CONVERT(FLOAT,ISNULL(SUM(CY.Collections-PY.Collections)/NULLIF(ISNULL(SUM(PY.Collections),0),0),0))*100 YrlyCollections,  
	CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,  
	CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID  
	FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)CY   
	LEFT JOIN (SELECT * FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
	WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY                           
	ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ProviderName=PY.ProviderName                          
	WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth                          
	GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ProviderName                           
END  
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12  
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment  
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays  
/*-----<<<End FinancialAnalysis>>>-----*/  
  
  
/*-----<<<Start CPT Report>>>-----*/  
IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
BEGIN  
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT  
/*Get CPTDescription,wRVU info*/  
SELECT ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription  
INTO #TempTblCPT FROM PPMReport_wRVUList(NOLOCK)wrv  
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT  
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
GROUP BY ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU  
  
/*individual provider*/  
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)  
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,
ProcedureCode,cpt.CPTGroup,  CPTDescription,ISNULL(Units,0)Units  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,CPTGroup,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider)),CPTGroup  
)cpt  
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt.ProcedureCode  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
  
/*All provider*/  
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPT,CPTGroupDesc,CPTDescription,UNITS)  
SELECT cpt1.ClientID,cpt1.ReportYear,cpt1.ReportMonth,'All Provider','All Provider',cpt1.ProcedureCode,cpt1.CPTGroup,  
CPTDescription,ISNULL(Units,0)Units  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,CPTGroup  
)cpt1  
LEFT JOIN #TempTblCPT wrv ON wrv.cptcode = cpt1.ProcedureCode  
WHERE cpt1.ClientID = @ClientID AND cpt1.ReportYear = @ReportYear AND cpt1.ReportMonth = @ReportMonth  
  
END  
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT  
/*-----<<<End CPT Report>>>-----*/  
  
  
/*-----<<<Start WRVU Report>>>-----*/  
IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
BEGIN  
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU  
/*Get CPTDescription,wRVU info*/  
SELECT ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU  
INTO #TempTblWRVU FROM PPMReport_wRVUList(NOLOCK)wrv  
INNER JOIN PPMReport_ECW_CPT(NOLOCK)CPT  
ON wrv.cptcode = cpt.ProcedureCode AND wrv.reportyear = @ReportYear AND modifier IS NULL  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
GROUP BY ClientID,wrv.ReportYear,ReportMonth,CPTCode,CPTDescription,wRVU  
  
/*individual provider*/  
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)  
  
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,
ProcedureCode,CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode,RTRIM(LTRIM(AppointmentProvider))  
)cpt  
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
and (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
  
/*All provider*/  
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)  
SELECT cpt.ClientID,cpt.ReportYear,cpt.ReportMonth,'All Provider'AppointmentProvider,'All Provider' AppointmentProvider,ProcedureCode,  
CPTDescription,ISNULL(Units,0)Units,ISNULL(wRVU,0)YlywRVU,wRVU = (ISNULL(Units,0)*ISNULL(wRVU,0))  
FROM(  
SELECT ClientID,ReportYear,ReportMonth,ProcedureCode,  
SUM(ISNULL(BilledUnits,0))Units  
FROM PPMReport_ECW_CPT(NOLOCK)  
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
AND (AppointmentProvider IS NOT NULL AND AppointmentProvider != 'Summary')  
GROUP BY ClientID,ReportYear,ReportMonth,ProcedureCode  
)cpt  
LEFT JOIN #TempTblWRVU wrv ON wrv.cptcode = cpt.ProcedureCode  
WHERE cpt.ClientID = @ClientID AND cpt.ReportYear = @ReportYear AND cpt.ReportMonth = @ReportMonth  
  
END  
IF OBJECT_ID('tempdb..#TempTblWRVU') IS NOT NULL DROP TABLE #TempTblWRVU  
/*-----<<<End WRVU Report>>>-----*/  
  
  
/*-----<<<Start Financial Dashboard>>>-----*/  
IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard  
BEGIN  
CREATE TABLE #TempTblFinancialDashboard(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(200),ShortName VARCHAR(200),                          
ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2)DEFAULT 0)  
/*Revenue Analysis*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName, ReportName, TotalCount                         
FROM(  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,  
Unapplied,AccountsReceivable,ClearGage,Collections  
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
) PVT                          
UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,Unapplied,AccountsReceivable,ClearGage,Collections))AS unpvt;      
  
/*Encounter Analysis*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'Encounter Analysis' ReportName,CPTGroupDesc, SUM(UNITS)UNITS  
FROM PPMReport_ProcedureCount(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName,CPTGroupDesc  
  
/*CPT Count*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'CPT' ReportName, SUM(UNITS)UNITS  
FROM PPMReport_ProcedureCount(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName  
  
/*WVRU Count*/  
INSERT INTO #TempTblFinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)  
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ProviderName,'WVRU' ReportName, SUM(wRVU)wRVU  
FROM PPMReport_wRVUReport(NOLOCK)                          
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth  
GROUP BY ClientID,ReportYear,ReportMonth,ProviderName  
  
INSERT INTO PPMReport_FinancialDashboard (ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)  
SELECT * FROM #TempTblFinancialDashboard  
ORDER BY 5,6  
  
END  
IF OBJECT_ID('tempdb..#TempTblFinancialDashboard') IS NOT NULL DROP TABLE #TempTblFinancialDashboard  
/*-----<<<End Financial Dashboard>>>-----*/  
  
  
/*-----<<<Start AgingComparison Report01>>>-----*/  
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC  
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP  
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)  
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01') = 0  
BEGIN  
CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),                          
[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),                          
[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE)               
  
/*Get insAR patAR*/  
SELECT ClientID,ReportYear,ReportMonth,ReportName ATBCategory,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,  
SUM(ISNULL([0-30],0))[0-30],SUM(ISNULL([31-60],0))[31-60],SUM(ISNULL([61-90],0))[61-90],SUM(ISNULL([91-120],0))[91-120],                          
SUM(ISNULL([121-150],0))[121-150],SUM(ISNULL([151-180],0))[151-180],SUM(ISNULL([181+],0))[181+],                          
SUM(ISNULL(TotalBalance,0))TotalBalance  
INTO #TempTblAGNCOMP FROM PPMReport_ECW_AgingReport(NOLOCK)  
WHERE ReportName IN ('IB','PB') --AND (AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL)                      
AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ClientID = @ClientID  
GROUP BY ClientID,ReportYear,ReportMonth,ReportName,RTRIM(LTRIM(AppointmentProvider))  
ORDER BY 4,5  
UPDATE #TempTblAGNCOMP SET AppointmentProvider = 'All Provider' WHERE AppointmentProvider = 'Summary' OR AppointmentProvider IS NULL  
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Insurance AR' WHERE ATBCategory = 'IB'  
UPDATE #TempTblAGNCOMP SET ATBCategory = 'Patient AR' WHERE ATBCategory = 'PB'  
  
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)  
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],TotalBalance  
FROM #TempTblAGNCOMP ORDER BY 4,5  
  
/*Total sum calculation*/  
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)  
SELECT ClientID,ReportYear,ReportMonth,'Aging-01',RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,'Total AR' ATBCategory,
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                          
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([TotalBalance])TotalBalance                          
FROM #TempTblAGNCOMP  
GROUP BY ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))  
  
UPDATE #TempTblAC SET DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')  
  
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)  
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,RTRIM(LTRIM(ProviderName))ProviderName,RTRIM(LTRIM(ProviderName))ProviderName,ATBCategory,
[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID  
FROM #TempTblAC  
  
/*Total sum % calculation*/  
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID)  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-01',aa.ProviderName,aa.ProviderName,aa.ATBCategory + ' %',  
[0-30] = Round(CONVERT(FLOAT,aa.[0-30]/NULLIF(bb.[0-30],0))*100,2)  
,[31-60] = Round(CONVERT(FLOAT,aa.[31-60]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[61-90] = Round(CONVERT(FLOAT,aa.[61-90]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[91-120] = Round(CONVERT(FLOAT,aa.[91-120]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[121-150] = Round(CONVERT(FLOAT,aa.[121-150]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[151-180] = Round(CONVERT(FLOAT,aa.[151-180]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[181+] = Round(CONVERT(FLOAT,aa.[181+]/NULLIF(bb.[CategoryBalance],0))*100,2)  
,[CategoryBalance] = Round(CONVERT(FLOAT,aa.CategoryBalance/NULLIF(bb.[CategoryBalance],0))*100,2),  
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM #TempTblAC aa  
LEFT JOIN PPMReport_AgingComparison(NOLOCK)bb  
ON BB.ClientID = @ClientID AND BB.ProviderName = AA.ProviderName AND aa.ATBCategory = bb.ATBCategory  
AND BB.DTID = DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'))  
WHERE AA.ClientID = @ClientID AND BB.ATBCategory IN ('Insurance AR','Patient AR','Total AR') AND  BB.ReportName = 'Aging-01'  
AND AA.ProviderName = 'All Provider'  
  
END  
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC  
IF OBJECT_ID('tempdb..#TempTblAGNCOMP') IS NOT NULL DROP TABLE #TempTblAGNCOMP  
/*-----<<<End AgingComparison Report01>>>-----*/  
  
  
/*-----<<<Start AgingComparison Report02>>>-----*/  
  
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                           
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02') = 0                          
BEGIN                          
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02  
                   
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02' ReportName,RTRIM(LTRIM(tb.AppointmentProvider))AppointmentProvider,InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(SUM(ISNULL(rf.AccountsReceivable,0)),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
INTO #TempTblRep02    
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf                          
ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,RTRIM(LTRIM(tb.AppointmentProvider)),tb.InsuranceGroup  
UNION  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,'Patient'InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)
+ ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM(  
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,RTRIM(LTRIM(tb.AppointmentProvider))AppointmentProvider,InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable  
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf                          
ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,RTRIM(LTRIM(tb.AppointmentProvider)),tb.InsuranceGroup,rf.AccountsReceivable                            
)aa  
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth,RTRIM(LTRIM(aa.AppointmentProvider))  
UNION  
/*GET all provider details*/  
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,'All Provider',InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance]  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(TotalBalance) /NULLIF(ISNULL(SUM(rf.AccountsReceivable),0),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(TotalBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf                          
ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'IB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.InsuranceGroup  
UNION  
SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,'Aging-02' ReportName,'All Provider','Patient'InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(CategoryBalance)CategoryBalance  
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM(CategoryBalance) /NULLIF(ISNULL(SUM(AccountsReceivable),0),0))*100,2),0)  
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)  
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid  
FROM(  
SELECT ClientID,ReportYear,tb.ReportMonth,ReportName,InsuranceGroup,  
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],  
SUM([151-180])[151-180],SUM([181+])[181+],SUM(TotalBalance)[CategoryBalance],rf.AccountsReceivable  
FROM PPMReport_ECW_AgingReport(NOLOCK) tb                           
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable   
FROM PPMReport_ECW_FinancialAnalysis(NOLOCK)                           
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear  
)rf        
ON RTRIM(LTRIM(tb.AppointmentProvider)) = RTRIM(LTRIM(rf.ProviderName)) AND tb.ReportMonth = rf.ReportMonth                          
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth  
AND ReportName = 'PB' AND (AppointmentProvider != 'Summary' AND AppointmentProvider IS NOT NULL)  
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,TB.ReportName,tb.InsuranceGroup,rf.AccountsReceivable                            
)aa  
GROUP BY aa.ClientID,aa.ReportYear,aa.ReportMonth  
  
  
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],                          
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)   
SELECT ClientID,ReportYear,ReportMonth,ReportName,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,
InsuranceGroup,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercentage,Over90days,dtid  
FROM #TempTblRep02  
  
END  
IF OBJECT_ID('tempdb..#TempTblRep02') IS NOT NULL DROP TABLE #TempTblRep02  
  
/*-----<<<End AgingComparison Report02>>>-----*/  
  
/*-----<<<Start Payer Mix >>>-----*/
IF OBJECT_ID('tempdb..#TempTblPName') IS NOT NULL DROP TABLE #TempTblPName  
if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear) = 0  
BEGIN

DECLARE @strSql1 AS VARCHAR(MAX),@strSql AS VARCHAR(MAX)
IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName
SET @strSql1 += ''
SET @strSql1 = 'SELECT pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider
INTO ##TempTblPName FROM PPMReport_ECW_PayerMix(NOLOCK)pm '
if @providerList > 0
BEGIN
SET @strSql1 += ' INNER JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl 
ON nl.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND RTRIM(LTRIM(NL.ProviderName)) = RTRIM(LTRIM(pm.AppointmentProvider))
'
END
SET @strSql1 += 'WHERE pm.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND ReportYear = ' + CONVERT(VARCHAR,@ReportYear) + 
' AND ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth) + 
' AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)
GROUP BY pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))'
EXEC (@strSql1)  
-----
SET @strSql += ''
SET @strSql = 'SELECT pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,
RTRIM(LTRIM(AppointmentProvider))AppointmentProvider,InsuranceGroup,  
SUM(ISNULL(BilledCharge,0))Charges,
Payment = (SUM(ISNULL(Payment,0))- SUM(ISNULL(Refund,0))),
SUM(ISNULL(Refund,0))Refund  
FROM PPMReport_ECW_PayerMix(NOLOCK)pm '
if @providerList > 0
BEGIN
SET @strSql += ' INNER JOIN PPMReport_ECW_ProviderNameList(NOLOCK)nl 
ON nl.ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND RTRIM(LTRIM(NL.ProviderName)) = RTRIM(LTRIM(pm.AppointmentProvider)) ' 
END
SET @strSql += 'WHERE pm.ClientID = ' + CONVERT(VARCHAR,@ClientID) + ' AND pm.ReportYear = ' + CONVERT(VARCHAR,@ReportYear) +
' AND pm.ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth)+   
'AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)  
GROUP BY pm.ClientID,ReportYear,ReportMonth,RTRIM(LTRIM(pm.AppointmentProvider)),InsuranceGroup  
UNION  
SELECT wc.ClientID,wc.ReportYear,wc.ReportMonth,RTRIM(LTRIM(wc.AppointmentProvider))AppointmentProvider,
RTRIM(LTRIM(wc.AppointmentProvider))AppointmentProvider,''PWOC'' InsuranceGroup,  
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund  
FROM PPMReport_ECW_WithoutClaims(NOLOCK)wc
INNER JOIN ##TempTblPName pn
ON RTRIM(LTRIM(wc.AppointmentProvider)) = pn.AppointmentProvider  
WHERE wc.ClientID = ' + CONVERT(VARCHAR,@ClientID) +' AND wc.ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+ 
' and wc.ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth ) + 'AND (PaymentDate != ''Summary'' AND PaymentDate IS NOT NULL)  
GROUP BY wc.ClientID,wc.ReportYear,wc.ReportMonth,RTRIM(LTRIM(wc.AppointmentProvider))    
UNION  
/*All Provider*/  
SELECT ClientID,ReportYear,ReportMonth,''All Provider'' AppointmentProvider,''All Provider'' AppointmentProvider,InsuranceGroup,  
SUM(ISNULL(BilledCharge,0))Charges,Payment = (SUM(ISNULL(Payment,0))-SUM(ISNULL(Refund,0))),SUM(ISNULL(Refund,0))Refund  
FROM PPMReport_ECW_PayerMix(NOLOCK)  
WHERE ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+
' AND ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth) +
'AND (AppointmentProvider != ''Summary'' AND AppointmentProvider IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth,InsuranceGroup  
UNION  
SELECT ClientID,ReportYear,ReportMonth,''All Provider'' AppointmentProvider,''All Provider'' AppointmentProvider,''PWOC''InsuranceGroup,  
0.00 Charges,SUM(ISNULL(Amount,0))Payment,0.00 Refund  
FROM PPMReport_ECW_WithoutClaims(NOLOCK)  
WHERE ClientID = ' + CONVERT(VARCHAR,@ClientID)+' AND ReportYear = ' + CONVERT(VARCHAR,@ReportYear)+
' AND ReportMonth = ' + CONVERT(VARCHAR,@ReportMonth)+  
'AND (PaymentDate != ''Summary'' AND PaymentDate IS NOT NULL)  
GROUP BY ClientID,ReportYear,ReportMonth '
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)
EXEC(@strSql)
IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName
  
END
/*-----<<<End Payer Mix >>>-----*/  
  
COMMIT TRANSACTION           
SET @ErrorMessage = 'Sucess'           
END TRY                      
                        
BEGIN CATCH                      
ROLLBACK TRANSACTION            
SET @ErrorMessage = ERROR_MESSAGE()                
END CATCH
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12  
IF OBJECT_ID('tempdb..#TempTblPayment') IS NOT NULL DROP TABLE #TempTblPayment  
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays
IF OBJECT_ID('tempdb..#TempTblCPT') IS NOT NULL DROP TABLE #TempTblCPT
IF OBJECT_ID('tempdb..#TempTblPName') IS NOT NULL DROP TABLE #TempTblPName 
IF OBJECT_ID('tempdb..##TempTblPName') IS NOT NULL DROP TABLE ##TempTblPName          
SELECT CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage          
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_OutputData]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_OutputData]          
(@cId int, @Year int, @month int)                      
AS                      
BEGIN                      
	DECLARE @ErrorMessage VARCHAR(MAX)                      
	DECLARE @ClientID INT = @cId                     
	DECLARE @ReportYear INT = @Year                      
	DECLARE @ReportMonth INT = @month                      
	DECLARE @RWCount INT=0        
	DECLARE @cCount INT
	SET @cCount =  (SELECT COUNT(ID)ID FROM PPMReport_ClientList(NOLOCK) WHERE ID = @ClientID AND IsActive = 1 AND Project = 1)

	if @cCount > 0
	BEGIN
		/*Page 2 to 12*/                      
		BEGIN TRY                       
		BEGIN TRANSACTION           
                           
		/*Backup Old Name in charge*/        
		UPDATE XL SET XL.XLName = A.EOMName        
		FROM(        
		SELECT ch.id, pn.ClientID,EOMName,DOPName        
		FROM PPMReport_MatchProviderName(NOLOCK)PN        
		INNER JOIN PPMReport_Charge(NOLOCK)CH        
		ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.ProviderName        
		WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 1      
		GROUP BY CH.ID, pn.ClientID,EOMName,DOPName        
		)A        
		INNER JOIN PPMReport_Charge(NOLOCK)XL ON XL.ID=A.ID AND XL.ProviderName = A.EOMName        
		WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
        
		/*Update Provider name as DOP Name in Charge*/        
		UPDATE XL SET XL.ProviderName = A.DOPName        
		FROM(        
		SELECT ch.id, pn.ClientID,EOMName,DOPName        
		FROM PPMReport_MatchProviderName(NOLOCK)PN        
		INNER JOIN PPMReport_Charge(NOLOCK)CH        
		ON /*PN.ClientID = CH.ClientID AND*/ PN.EOMName = CH.ProviderName        
		WHERE CH.ClientID = @ClientID AND CH.ReportMonth = @ReportMonth AND CH.ReportYear = @ReportYear AND PN.ProjectID = 1       
		GROUP BY CH.ID, pn.ClientID,EOMName,DOPName        
		)A        
		INNER JOIN PPMReport_Charge(NOLOCK)XL ON XL.ID=A.ID AND XL.ProviderName = A.EOMName        
		WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
        
		/*Backup Old Name in AgingReport*/        
		UPDATE XL SET XL.XLName = A.EOMName        
		FROM(        
		SELECT AR.id, pn.ClientID,EOMName,DOPName        
		FROM PPMReport_MatchProviderName(NOLOCK)PN        
		INNER JOIN PPMReport_AgingReport(NOLOCK)AR        
		ON /*PN.ClientID = AR.ClientID AND*/ PN.EOMName = AR.ProviderName        
		WHERE AR.ClientID = @ClientID AND AR.ReportMonth = @ReportMonth AND AR.ReportYear = @ReportYear AND PN.ProjectID = 1  
		GROUP BY AR.id, pn.ClientID,EOMName,DOPName        
		)A        
		INNER JOIN PPMReport_AgingReport(NOLOCK)XL ON XL.ID=A.ID AND XL.ProviderName = A.EOMName         
		WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
        
		/*Update Provider name as DOP Name in AgingReport*/        
		UPDATE XL SET XL.ProviderName = A.DOPName        
		FROM(        
		SELECT AR.id, pn.ClientID,EOMName,DOPName        
		FROM PPMReport_MatchProviderName(NOLOCK)PN        
		INNER JOIN PPMReport_AgingReport(NOLOCK)AR        
		ON /*.ClientID = AR.ClientID AND*/ PN.EOMName = AR.ProviderName        
		WHERE AR.ClientID = @ClientID AND AR.ReportMonth = @ReportMonth AND AR.ReportYear = @ReportYear AND PN.ProjectID = 1  
		GROUP BY AR.id, pn.ClientID,EOMName,DOPName          
		)A        
		INNER JOIN PPMReport_AgingReport(NOLOCK)XL ON XL.ID=A.ID AND XL.ProviderName = A.EOMName        
		WHERE XL.ClientID = @ClientID AND XL.ReportMonth = @ReportMonth AND XL.ReportYear = @ReportYear        
        
		/*Validate wRVU cliet data*/  
		IF OBJECT_ID('tempdb..#TempTblwRVUList') IS NOT NULL DROP TABLE #TempTblwRVUList
		SELECT * INTO #TempTblwRVUList
		FROM PPMReport_wRVUList(NOLOCK)
		WHERE IsActive = 1 AND ReportYear = @ReportYear AND ClientID = 0

		if EXISTS(SELECT ID FROM PPMReport_wRVUList(NOLOCK) 
		WHERE IsActive = 1 AND ClientID = @ClientID AND ReportYear = @ReportYear)
		BEGIN	
			MERGE #TempTblwRVUList TMP
			USING PPMReport_wRVUList(NOLOCK)WR
			ON (TMP.CPTCode = WR.CPTCode AND ISNULL(TMP.Modifier,'') = ISNULL(WR.Modifier,'')
			AND TMP.ReportYear = WR.ReportYear AND WR.ClientID = @ClientID)	
			WHEN MATCHED THEN
				UPDATE SET TMP.CPTDescription = WR.CPTDescription, TMP.wRVU = WR.wRVU
			WHEN NOT MATCHED BY TARGET AND WR.ReportYear = @ReportYear AND WR.ClientID != 0 
			AND WR.IsActive = 1 THEN
				INSERT(ReportYear,CPTCode,Modifier,CPTDescription,wRVU,ClientID,IsActive)
				VALUES(WR.ReportYear,WR.CPTCode,WR.Modifier,WR.CPTDescription,WR.wRVU,WR.ClientID,WR.IsActive)
			;
		END
		-----
              
		IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12                      
		IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays                      
		if (SELECT Count(*) FROM PPMReport_Rollforward(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)<=0                      
		BEGIN                      
		CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),                      
		Charges DECIMAL (18, 2),NetPayments DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),                      
		UnappliedPayments DECIMAL (18, 2),AccountsReceivable DECIMAL (18, 2),AROver120 DECIMAL (18, 2),ARDaysOutstanding DECIMAL (18, 2),                     
		UnappliedBalance DECIMAL (18, 2),DTID DATE)                      
		/*UPDATE IN TEMP TABLE*/                      
		INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)                      
		SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider ProviderName,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN          
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		SUM(ISNULL(Charges,0))Charges,SUM(ISNULL(Payments,0))Payments,SUM(ISNULL(Refunds,0))Refunds,SUM(ISNULL(Adjustments,0))Adjustments,                      
		CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID FROM PPMReport_DOPQuery(NOLOCK)DP                      
		WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth                      
		GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider                      
		/*Update All Provider for Charges,Payments,Refunds,Adjustments*/                      
		INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)                      
		SELECT ClientID,ReportYear,ReportMonth, 'All Provider'ProviderName,'All Provider'ShortName,                      
		SUM(ISNULL(Charges,0))Charges,SUM(ISNULL(Payments,0))Payments,SUM(ISNULL(Refunds,0))Refunds,SUM(ISNULL(Adjustments,0))Adjustments,                      
		CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID FROM #TempTblpg1to12                       
		WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth=@ReportMonth                      
		GROUP BY ClientID,ReportYear,ReportMonth                      
		/*Update All Provider for UnappliedPayments*/                      
		UPDATE UA SET UA.UnappliedPayments = a.UnappliedPayments                                                          
		FROM (SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(NetPayments,0))UnappliedPayments                       
		FROM PPMReport_Charge(NOLOCK)                       
		WHERE ProviderName='Practice Unapplied' AND ClientID =@ClientID AND ReportYear = @ReportYear and ReportMonth=@ReportMonth                      
		GROUP BY  ClientID,ReportYear,ReportMonth) a                                                              
		INNER JOIN #TempTblpg1to12 UA                       
		ON UA.ClientID = a.ClientID AND UA.ReportYear = a.ReportYear AND UA.ReportMonth = a.ReportMonth AND UA.ProviderName = a.ProviderName                      
		/*Update All Provider for UnappliedBalance*/                      
		UPDATE UB SET UB.UnappliedBalance = aa.UnappliedBalance                                                          
		FROM (SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(CategoryBalance,0)) UnappliedBalance                       
		FROM PPMReport_AgingReport(NOLOCK)                      
		WHERE  ProviderName = 'All Provider' AND ATBCategory = 'Practice Unapplied' AND ClientID =@ClientID AND ReportYear = @ReportYear                      
		AND ReportMonth=@ReportMonth GROUP BY  ClientID,ReportYear,ReportMonth) aa                      
		INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear                       
		AND UB.ReportMonth = aa.ReportMonth AND UB.ProviderName = aa.ProviderName                      
		/*Update All Provider for AccountsReceivable*/                      
		UPDATE UB SET UB.AccountsReceivable = aa.AccountsReceivable                                                    
		FROM (SELECT ClientID,ReportYear,ReportMonth,ProviderName, ProviderName AS ShortName,                      
		--CASE WHEN ProviderName LIKE '%, %' THEN                       
		--LEFT(ProviderName,(LEN(ProviderName)-Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))        
		--ELSE ProviderName END AS ShortName,          
		SUM(ISNULL(CategoryBalance,0))AccountsReceivable                      
		FROM PPMReport_AgingReport(NOLOCK) WHERE ATBCategory='Totals'                      
		AND ClientID =@ClientID AND ReportYear = @ReportYear AND ReportMonth=@ReportMonth GROUP BY ClientID,ReportYear,ReportMonth,ProviderName) aa                      
		INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear                       
		AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName                      
		/*Update All Provider for AROver120*/                      
		UPDATE UB SET UB.AROver120 = aa.AROver120                                                 
		FROM (SELECT ClientID,ReportYear,ReportMonth,ProviderName, ProviderName  AS ShortName,                   
		--CASE WHEN ProviderName LIKE '%, %' THEN                       
		--LEFT(ProviderName,(LEN(ProviderName)-Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))                      
		--ELSE ProviderName END AS ShortName,          
		SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120                       
		FROM PPMReport_AgingReport(NOLOCK) WHERE ATBCategory NOT IN ('Totals','Practice Unapplied')                      
		AND ClientID =@ClientID AND ReportYear = @ReportYear AND ReportMonth=@ReportMonth GROUP BY ClientID,ReportYear,ReportMonth,ProviderName) aa                      
		INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear                       
		AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName                      
		/*Update netpayments, accountreceivable with calculation*/                      
		UPDATE UB SET UB.NetPayments = aa.NetPayments, ub.AccountsReceivable = aa.AccountsReceivable                      
		FROM(SELECT ClientID,ReportYear,ReportMonth,ShortName,                      
		/*ISNULL(SUM(ABS(ISNULL(Payments,0))-ABS(ISNULL(Refunds,0))-ABS(ISNULL(UnappliedPayments,0))),0)NetPayments,*/                      
		ABS(SUM(((ISNULL(Payments,0)*-1)+(ISNULL(Refunds,0)*-1))+(ISNULL(UnappliedPayments,0)*-1)))NetPayments                      
		,ISNULL(SUM(ISNULL(AccountsReceivable,0)-ISNULL(UnappliedBalance,0)),0)AccountsReceivable                      
		FROM #TempTblpg1to12 GROUP BY ClientID,ReportYear,ReportMonth,ShortName) aa                      
		INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear                       
		AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName                      
		/*ARDaysOutstanding*/                      
		SELECT ClientID,ReportMonth,ReportYear,ShortName,Charges,DTID                      
		INTO #TempTblpg1to12ARDays FROM PPMReport_Rollforward(NOLOCK) WHERE ClientID = @ClientID AND                      
		DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and                       
		DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')                      
		SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1                      
		IF @RWCount = 1                      
		BEGIN                      
		UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                     
		FROM(SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((isnull(Charges,0)/(30)),0),0),0)ARDays                       
		FROM #TempTblpg1to12 WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear                      
		GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges)AR   
		INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                       
		ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                      
		END                      
		ELSE                      
		BEGIN                      
		UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays                      
		FROM(SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,                      
		ISNULL(NULLIF(ISNULL(ABS(isnull(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays                      
		FROM #TempTblpg1to12 AA LEFT JOIN (SELECT ClientID,ShortName,SUM(ISNULL(Charges,0))Charges FROM #TempTblpg1to12ARDays                       
		GROUP BY  ClientID,ShortName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName=bb.ShortName                      
		WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear                      
		GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable)AR                      
		INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND                       
		ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName                      
		END                      
		/*Final Data moved to PPMReport_Rollforward table*/                      
		INSERT INTO PPMReport_Rollforward(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,                      
		Payments,Refunds,Adjustments,UnappliedPayments,AccountsReceivable,AROver120,ARDaysOutstanding,UnappliedBalance,DTID)                      
		SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,                      
		NetPayments,Refunds,ABS(ISNULL(Adjustments,0))Adjustments,ISNULL(UnappliedPayments,0)UnappliedPayments,AccountsReceivable,                      
		AROver120,ARDaysOutstanding,ISNULL(UnappliedBalance,0)UnappliedBalance,DTID FROM #TempTblpg1to12 ORDER BY ShortName                      
		/*Yearly Compare*/                      
		INSERT INTO PPMReport_Rollforward_YrlyCompare(ClientID,ReportYear,ReportMonth,ShortName,YrlyCharges,                      
		YrlyPayments,YrlyRefunds,YrlyAdjustments,YrlyUnappliedPayments,YrlyAccountsReceivable,YrlyAROver120,                      
		YrlyARDaysOutstanding,YrlyUnappliedBalance)                      
		SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ShortName,                       
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,                      
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,                      
		CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,                      
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,                      
		CONVERT(FLOAT,ISNULL(SUM(CY.UnappliedPayments-PY.UnappliedPayments)/NULLIF(ISNULL(SUM(PY.UnappliedPayments),0),0),0))*100 YrlyUnappliedPayments,                      
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,                      
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,                      
		CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,                      
		CONVERT(FLOAT,ISNULL(SUM(CY.UnappliedBalance-PY.UnappliedBalance)/NULLIF(ISNULL(SUM(PY.UnappliedBalance),0),0),0))*100 YrlyUnappliedBalance                      
		FROM PPMReport_Rollforward(NOLOCK)CY LEFT JOIN (SELECT * FROM PPMReport_Rollforward(NOLOCK)                       
		WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY                       
		ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ShortName=PY.ShortName                      
		WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth                      
		GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ShortName                       
		IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12                      
		IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays                      
		END                      
                      
                      
		/*Page 13 to 22*/                      
		--DECLARE @ClientID INT = 1                      
		--DECLARE @ReportYear INT = 2017                      
		--DECLARE @ReportMonth INT = 2                      
		IF OBJECT_ID('tempdb..#TempTblpg13to22') IS NOT NULL DROP TABLE #TempTblpg13to22                      
		IF OBJECT_ID('tempdb..#TempTblFD01') IS NOT NULL DROP TABLE #TempTblFD01                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02                      
		IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                      
		BEGIN                      
		CREATE TABLE #TempTblpg13to22(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),                      
		ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2))                      
		/*GET Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,UnappliedPayments,AccountsReceivable*/                      
		SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, ReportName, TotalCount INTO #TempTblFD01                      
		FROM (SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,                      
		UnappliedPayments,AccountsReceivable FROM PPMReport_Rollforward(NOLOCK)                      
		WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth) PVT                      
		UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,UnappliedPayments,AccountsReceivable))AS unpvt;                      
		UPDATE #TempTblFD01 SET ReportName = 'Gross Charges' WHERE ReportName = 'Charges'                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                      
		SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount FROM #TempTblFD01                      
            
		/*Update Cleargage*/                      
		UPDATE UB SET UB.ClearGage = aa.Credit     
		FROM (SELECT cc.ClientID,cc.ReportMonth,cc.ReportYear,cc.ProviderName,cg.Credit                      
		FROM PPMReport_ClearGage_Collection(NOLOCK)cc                      
		LEFT JOIN PPMReport_ClientList(Nolock)cl on cc.ClientID=cl.ID                      
		LEFT JOIN PPMReport_ClearGage(NOLOCK)cg                       
		ON cl.ClientFullName = cg.PPMMerchantAccount and cc.ReportYear=cg.ReportYear and cc.ReportMonth=cg.ReportMonth                      
		WHERE cc.ClientID=@ClientID and cc.ReportMonth = @ReportMonth and cc.ReportYear = @ReportYear) aa                      
		INNER JOIN PPMReport_ClearGage_Collection UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear                       
		AND UB.ReportMonth = aa.ReportMonth AND UB.ProviderName = aa.ProviderName             
                     
		/*Get ClearGage, Collections*/                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                      
		SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, ReportName, TotalCount FROM                       
		(SELECT  ClientID,ReportYear,ReportMonth,ProviderName,'All Provider'ShortName, ISNULL(ClearGage,0)ClearGage,ISNULL(Collections,0)Collections                       
		FROM PPMReport_ClearGage_Collection(NOLOCK)                      
		WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth) PVT                      
		UNPIVOT (TotalCount FOR ReportName IN (ClearGage, Collections))AS unpvt;                    /*Get all provider EncounterAnalysis*/                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,TotalCount,ReportName)                     
		SELECT ClientID,ReportYear,ReportMonth,'All Provider'ClaimProvider,'All Provider'ShortName,                      
		CPTGroupDesc,SUM(ISNULL(Units,0))TotalCount,'EncounterAnalysis'ReportName FROM PPMReport_DOPQuery(NOLOCK)                      
		WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL                       
		AND CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/                      
		GROUP BY ClientID,ReportYear,ReportMonth,CPTGroupDesc /*HAVING SUM(ISNULL(Units,0))>0*/ ORDER BY CPTGroupDesc ASC                      
		/*Get Individual Provider EncounterAnalysis*/                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,TotalCount,ReportName)                 
		SELECT ClientID,ReportYear,ReportMonth,ClaimProvider,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		CPTGroupDesc,SUM(ISNULL(Units,0))TotalCount,'EncounterAnalysis'ReportName                      
		FROM PPMReport_DOPQuery(NOLOCK) WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND                       
		ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL AND CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/                      
		GROUP BY ClientID,ReportYear,ReportMonth,ClaimProvider,CPTGroupDesc /*HAVING SUM(ISNULL(Units,0))>0*/ ORDER BY ClaimProvider ASC                      
		/*CPT Counts All Provider*/                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                      
		SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,                      
		'CPT Counts'ReportName,SUM(ISNULL(Units,0))Units FROM PPMReport_DOPQuery(NOLOCK)DP                      
		WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL                       
		AND Dp.CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/                      
		GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth                      
		ORDER BY ProviderName,ReportYear,ReportMonth ASC                      
		/*CPT Counts Individual Provider*/                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                      
		SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider ProviderName,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		'CPT Counts'ReportName,SUM(ISNULL(Units,0))Units                      
		FROM PPMReport_DOPQuery(NOLOCK)DP                      
		WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL                       AND Dp.CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/                      
		GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider HAVING SUM(ISNULL(Units,0))>0                      
		ORDER BY ProviderName,ReportYear,ReportMonth ASC                      
		/*Work wRVU All Provider*/                      
		SELECT ClientID,dp.ReportYear,ReportMonth,CPT,SUM(Units)UNITS                      
		INTO #TempTblWorkwRVU01 FROM PPMReport_DOPQuery(NOLOCK) DP                      
		WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY ClientID,dp.ReportYear,ReportMonth,CPT                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                      
		SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,'Work wRVU'ReportName,                      
		SUM(wRVUu)wRVU FROM                      
		(SELECT CP.ClientID,rv.ReportYear,ReportMonth,CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu                      
		FROM #TempTblWorkwRVU01(NOLOCK)cp                      
		INNER JOIN #TempTblwRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                       
		GROUP BY CP.ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units)aa                      
		GROUP BY ClientID,ReportYear,ReportMonth                      
		/*Work wRVU Individual Provider*/                      
		SELECT ClientID,dp.ReportYear,ReportMonth,CPT,SUM(Units)UNITS,ClaimProvider                      
		INTO #TempTblWorkwRVU02 FROM PPMReport_DOPQuery(NOLOCK) DP                      
		WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY ClientID,dp.ReportYear,ReportMonth,CPT,ClaimProvider                      
		INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)                
		SELECT ClientID,ReportYear,ReportMonth,ClaimProvider ProviderName,ShortName,'Work wRVU'ReportName,                      
		SUM(wRVUu)wRVU FROM                      
		(SELECT CP.ClientID,rv.ReportYear,ReportMonth,ClaimProvider,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu                      
		FROM #TempTblWorkwRVU02(NOLOCK)cp                      
		INNER JOIN #TempTblwRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL                       
		GROUP BY CP.ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units,ClaimProvider)aa                   
		GROUP BY ClientID,ReportYear,ReportMonth,ClaimProvider,ShortName                      
		ORDER BY ReportYear,ReportMonth,ShortName                      
                      
		/*Update to Financial dashboard*/                      
		INSERT INTO PPMReport_FinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)                      
		SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount FROM #TempTblpg13to22                      
		IF OBJECT_ID('tempdb..#TempTblpg13to22') IS NOT NULL DROP TABLE #TempTblpg13to22                      
		IF OBJECT_ID('tempdb..#TempTblFD01') IS NOT NULL DROP TABLE #TempTblFD01                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02                      
		END                      
                      
                      
		/*Payer Mix <---> Page 26 - 45*/                      
		--DECLARE @ClientID INT = 1                      
		--DECLARE @ReportYear INT = 2017                      
		--DECLARE @ReportMonth INT = 4                      
		if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                      
		BEGIN                      
		INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)                      
		SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,                      
		InsuranceType,SUM(ISNULL(Charges,0))Charges,SUM(Payments)Payments ,SUM(Refunds) Refunds                      
		FROM PPMReport_DOPQuery(NOLOCK)DP                      
		WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,InsuranceType                      
		/*ORDER BY DP.ClientID,DP.ReportYear,DP.ReportMonth,dp.InsuranceType*/                      
		UNION                      
		SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,'UnappliedPayments'InsuranceType,0.00 charges,                      
		UnappliedPayments Payments,0.00 Refunds FROM PPMReport_Rollforward(nolock)                       
		WHERE ReportMonth=@ReportMonth and ReportYear=@ReportYear AND ClientID=@ClientID AND ProviderName = 'All Provider'                      
                 
		INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)                      
		SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		InsuranceType,SUM(ISNULL(Charges,0))Charges,                      
		SUM(Payments)Payments ,SUM(Refunds) Refunds FROM PPMReport_DOPQuery(NOLOCK)DP                      
		WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider,InsuranceType         
		ORDER BY DP.ClientID,DP.ReportYear,DP.ReportMonth,DP.ClaimProvider,dp.InsuranceType                      
		END                      
                      
		/*Aging Comparison <---> Page 47 - 48*/                      
		--DECLARE @ClientID INT = 1                      
		--DECLARE @ReportYear INT = 2017                      
		--DECLARE @ReportMonth INT = 4                      
		IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC                      
		IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                       
		WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01')<=0                      
		BEGIN                      
		CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),                      
		[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),                      
		[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE,ShortName varchar(100))                      
		/*Insurance AR*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)                      
		SELECT ac.ClientID,ac.ReportYear,AC.ReportMonth,'Aging-01'ReportName,ac.ProviderName,'Insurance AR' ATBCategory,                      
		SUM(ISNULL(ac.[0-30],0))[0-30],SUM(ISNULL(ac.[31-60],0))[31-60],SUM(ISNULL(ac.[61-90],0))[61-90],SUM(ISNULL(ac.[91-120],0))[91-120],                      
		SUM(ISNULL(ac.[121-150],0))[121-150],SUM(ISNULL(ac.[151-180],0))[151-180],SUM(ISNULL(ac.[181+],0))[181+],                      
		SUM(ISNULL(ac.[CategoryBalance],0))[CategoryBalance]  FROM PPMReport_AgingReport(NOLOCK) AC                      
		WHERE ATBCategory NOT IN('Patient', 'Totals','Practice Unapplied') and ac.ClientID = @ClientID AND                       
		ac.ReportYear = @ReportYear and ac.ReportMonth = @ReportMonth AND ProviderName='All Provider'                      
		GROUP BY ac.ClientID,ac.ReportYear,AC.ReportMonth,ac.ProviderName                      
		/*Patient AR*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)                      
		SELECT ClientID,ReportYear,AC.ReportMonth,'Aging-01'ReportName,ProviderName,'Patient AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],                      
		SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],                      
		SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]                      
		FROM PPMReport_AgingReport(NOLOCK)AC                      
		WHERE ATBCategory='Patient'AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ProviderName='All Provider'                      
		GROUP BY ClientID,ReportYear,AC.ReportMonth,ATBCategory,ProviderName                     
		/*Total AR = sum of Insurance AR & Patient AR*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)                      
		SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,ProviderName,'Total AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],                      
		SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]                      
		FROM #TempTblAC GROUP BY ClientID,ReportYear,ReportMonth,ProviderName                      
		/*Total % AR*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)                      
		SELECT ClientID,ReportYear,ReportMonth,'Aging-01' ReportName, ProviderName,'Total%AR' ATBCategory                      
		,[0-30] = Round(CONVERT(FLOAT,[0-30]/NULLIF([CategoryBalance],0))*100,2)                       
		,[31-60] = Round(CONVERT(FLOAT,[31-60]/NULLIF([CategoryBalance],0))*100,2)                       
		,[61-90] = Round(CONVERT(FLOAT,[61-90]/NULLIF([CategoryBalance],0))*100,2)                       
		,[91-120] = Round(CONVERT(FLOAT,[91-120]/NULLIF([CategoryBalance],0))*100,2)                       
		,[121-150] = Round(CONVERT(FLOAT,[121-150]/NULLIF([CategoryBalance],0))*100,2)                       
		,[151-180] = Round(CONVERT(FLOAT,[151-180]/NULLIF([CategoryBalance],0))*100,2)                       
		,[181+] = Round(CONVERT(FLOAT,[181+]/NULLIF([CategoryBalance],0))*100,2)                      
		,[CategoryBalance] = Round(CONVERT(FLOAT,[CategoryBalance]/NULLIF([CategoryBalance],0))*100,2)                      
		FROM #TempTblAC WHERE ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'                      
		UPDATE #TempTblAC set DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'),                      
		ShortName = ProviderName          
		--(CASE WHEN ProviderName LIKE '%, %' THEN LEFT(ProviderName,(LEN(ProviderName)-                      
		--Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))ELSE ProviderName END)                     
		/*Chg Ins %*/                  
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)                      
		select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Ins %' ATBCategory                      
		,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)                       
		,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)                      
		,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),                      
		CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,                      
		cChg.ProviderName AS ShortName           
		--CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-                      
		--Len(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName                      
		FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)                       
		WHERE ClientID=@ClientID AND ATBCategory = 'Insurance AR' AND  ReportName = 'Aging-01'                       
		AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg                 
		ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName                      
		WHERE cChg.ATBCategory = 'Insurance AR' AND  cChg.ReportName = 'Aging-01'                      
		/*Chg Pat %*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)                      
		select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Pat %' ATBCategory                      
		,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)                       
		,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)                      
		,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),                      
		CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,                      
		cChg.ProviderName AS ShortName          
		--CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-                      
		--LEN(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName                      
		FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)                       
		WHERE ClientID=@ClientID AND ATBCategory = 'Patient AR' AND  ReportName = 'Aging-01'                       
		AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg                      
		ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName                
		WHERE cChg.ATBCategory = 'Patient AR' AND  cChg.ReportName = 'Aging-01'                      
		/*Chg Pat %*/                      
		INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)                      
		select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Total Chg %' ATBCategory                      
		,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)                       
		,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)                       
		,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)                      
		,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),                      
		CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,                      
		cChg.ProviderName AS ShortName          
		--CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-                      
		--LEN(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName                      
		FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)                       
		WHERE ClientID=@ClientID AND ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'               AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg                      
		ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName                      
		WHERE cChg.ATBCategory = 'Total AR' AND  cChg.ReportName = 'Aging-01'                      
		/*Aging-01 PPMReport AgingComparison*/                      
		INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],[CategoryBalance],DTID)                      
		SELECT ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID FROM #TempTblAC ORDER BY ShortName                       
		IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC                      
		END                      
		/*Aging Comparison <---> Page 49 - 59*/                      
		IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)                       
		WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02')<=0                      
		BEGIN                      
		INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],                      
		[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)                      
		SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,tb.ProviderName, tb.ProviderName AS ShortName,          
		--CASE WHEN tb.ProviderName LIKE '%, %' THEN                       
		--LEFT(tb.ProviderName,(LEN(tb.ProviderName)-Len(SUBSTRING(tb.ProviderName,CHARINDEX(', ',tb.ProviderName),LEN(tb.ProviderName)))))                      
		--ELSE tb.ProviderName END AS ShortName,          
		ATBCategory,                      
		SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],                      
		SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]                      
		,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM([CategoryBalance]) /NULLIF(ISNULL(rf.AccountsReceivable,0),0))*100,2),0)                      
		,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)                      
		,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid                      
		FROM PPMReport_AgingReport(NOLOCK) tb                       
		LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable FROM PPMReport_Rollforward(NOLOCK)                       
		WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear)rf                      
		ON tb.ProviderName = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth                      
		WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth                      
		GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.ProviderName,tb.ATBCategory,rf.AccountsReceivable                      
		END                      
                      
                      
		/*Procedure Count <---> Page 60 - 79*/                      
		--DECLARE @ClientID INT = 1                      
		--DECLARE @ReportYear INT = 2017                      
		--DECLARE @ReportMonth INT = 4                      
		IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                      
		BEGIN                      
		/*All Provider*/                      
		INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,CPT,CPTDescription,UNITS)                      
		SELECT ClientID,dp.ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,CPTGroupDesc,CPT,CPTDescription,SUM(Units)UNITS                     
		FROM PPMReport_DOPQuery(NOLOCK) DP WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth                      
		GROUP BY ClientID,dp.ReportYear,ReportMonth,CPTGroupDesc,CPT,CPTDescription HAVING SUM(Units)>0 ORDER BY 2,3,4,5                      
		/*Individual Provider*/                      
		INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,CPT,CPTDescription,UNITS)                      
		SELECT ClientID,dp.ReportYear,ReportMonth,ClaimProvider,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		CPTGroupDesc,CPT,CPTDescription,SUM(Units)UNITS                      
		FROM PPMReport_DOPQuery(NOLOCK) DP WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth                      
		GROUP BY ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPTGroupDesc,CPT,CPTDescription HAVING SUM(Units)>0 ORDER BY 2,3,4,5                      
		END                      
                      
                      
		--DECLARE @ClientID INT = 1                      
		--DECLARE @ReportYear INT = 2017                      
		--DECLARE @ReportMonth INT = 4                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU001') IS NOT NULL DROP TABLE #TempTblWorkwRVU001                      
		IF OBJECT_ID('tempdb..#TempTblWorkwRVU002') IS NOT NULL DROP TABLE #TempTblWorkwRVU002                      
		IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0                      
		BEGIN                      
		/*Work wRVU All Provider*/                      
		SELECT DP.ClientID,dp.ReportYear,ReportMonth,CPT,dp.CPTDescription, SUM(Units)UNITS,wRVU               
		INTO #TempTblWorkwRVU001 FROM PPMReport_DOPQuery(NOLOCK) DP                      
		LEFT JOIN #TempTblwRVUList(NOLOCK)RV ON rv.CPTCode=DP.CPT AND rv.ReportYear=DP.ReportYear                       
		AND RV.Modifier IS NULL /*and dp.CPTDescription = rv.CPTDescription*/                      
		WHERE DP.ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY DP.ClientID,dp.ReportYear,ReportMonth,CPT,dp.CPTDescription,wRVU HAVING SUM(Units)>0                      
		INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)                      
		SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,                      
		CPT,CPTDescription,UNITS,wRVU,(CONVERT(DECIMAL (18, 2),ISNULL(wRVU,0))*Units)RVU FROM #TempTblWorkwRVU001                      
		/*Work wRVU individual Provider*/                      
		SELECT DP.ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPT,dp.CPTDescription, SUM(Units)UNITS,wRVU                      
		INTO #TempTblWorkwRVU002 FROM PPMReport_DOPQuery(NOLOCK) DP                      
		LEFT JOIN #TempTblwRVUList(NOLOCK)RV ON rv.CPTCode=DP.CPT AND rv.ReportYear=DP.ReportYear                       
		AND RV.Modifier IS NULL /*and dp.CPTDescription = rv.CPTDescription*/                      
		WHERE DP.ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth                      
		GROUP BY DP.ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPT,dp.CPTDescription,wRVU HAVING SUM(Units)>0                      
		INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)                      
		SELECT ClientID,ReportYear,ReportMonth,ClaimProvider,ClaimProvider AS ShortName,          
		--CASE WHEN ClaimProvider LIKE '%, %' THEN                       
		--LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))                      
		--ELSE ClaimProvider END AS ShortName,          
		CPT,CPTDescription,UNITS,wRVU,(CONVERT(DECIMAL (18, 2),ISNULL(wRVU,0))*Units)RVU FROM #TempTblWorkwRVU002                      
		END                      
		COMMIT TRANSACTION                       
		SET @ErrorMessage = 'Sucess'                       
		END TRY                                  

		BEGIN CATCH                                  
		ROLLBACK TRANSACTION                        
		SET @ErrorMessage = ERROR_MESSAGE()                            
		END CATCH                       
		SELECT CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage                      
	END 
	ELSE
	BEGIN
		SELECT CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ 'No Client'
	END
	IF OBJECT_ID('tempdb..#TempTblwRVUList') IS NOT NULL DROP TABLE #TempTblwRVUList
END
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_OutputData_04sep20]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_OutputData_04sep20]      
(@cId int, @Year int, @month int)      
AS      
BEGIN      
DECLARE @ErrorMessage VARCHAR(MAX)      
/*Page 2 to 12*/      
BEGIN TRY       
BEGIN TRANSACTION      
DECLARE @ClientID INT = @cId      
DECLARE @ReportYear INT = @Year      
DECLARE @ReportMonth INT = @month      
DECLARE @RWCount INT=0      
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12      
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays      
if (SELECT Count(*) FROM PPMReport_Rollforward(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth and ReportYear=@ReportYear)<=0      
BEGIN      
CREATE TABLE #TempTblpg1to12(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),      
Charges DECIMAL (18, 2),NetPayments DECIMAL (18, 2),Payments DECIMAL (18, 2),Refunds DECIMAL (18, 2),Adjustments DECIMAL (18, 2),      
UnappliedPayments DECIMAL (18, 2),AccountsReceivable DECIMAL (18, 2),AROver120 DECIMAL (18, 2),ARDaysOutstanding DECIMAL (18, 2),      
UnappliedBalance DECIMAL (18, 2),DTID DATE)      
/*UPDATE IN TEMP TABLE*/      
INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)      
SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider ProviderName,      
CASE WHEN ClaimProvider LIKE '%, %' THEN       
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))      
ELSE ClaimProvider END AS ShortName,      
SUM(ISNULL(Charges,0))Charges,SUM(ISNULL(Payments,0))Payments,SUM(ISNULL(Refunds,0))Refunds,SUM(ISNULL(Adjustments,0))Adjustments,      
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID FROM PPMReport_DOPQuery(NOLOCK)DP      
WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth      
GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider      
/*Update All Provider for Charges,Payments,Refunds,Adjustments*/      
INSERT INTO #TempTblpg1to12(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,Payments,Refunds,Adjustments,DTID)      
SELECT ClientID,ReportYear,ReportMonth, 'All Provider'ProviderName,'All Provider'ShortName,      
SUM(ISNULL(Charges,0))Charges,SUM(ISNULL(Payments,0))Payments,SUM(ISNULL(Refunds,0))Refunds,SUM(ISNULL(Adjustments,0))Adjustments,      
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01') DTID FROM #TempTblpg1to12       
WHERE ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth=@ReportMonth      
GROUP BY ClientID,ReportYear,ReportMonth      
/*Update All Provider for UnappliedPayments*/      
UPDATE UA SET UA.UnappliedPayments = a.UnappliedPayments                                          
FROM (SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(NetPayments,0))UnappliedPayments       
FROM PPMReport_Charge(NOLOCK)       
WHERE ProviderName='Practice Unapplied' AND ClientID =@ClientID AND ReportYear = @ReportYear and ReportMonth=@ReportMonth      
GROUP BY  ClientID,ReportYear,ReportMonth) a                                              
INNER JOIN #TempTblpg1to12 UA       
ON UA.ClientID = a.ClientID AND UA.ReportYear = a.ReportYear AND UA.ReportMonth = a.ReportMonth AND UA.ProviderName = a.ProviderName      
/*Update All Provider for UnappliedBalance*/      
UPDATE UB SET UB.UnappliedBalance = aa.UnappliedBalance                                          
FROM (SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,SUM(ISNULL(CategoryBalance,0)) UnappliedBalance       
FROM PPMReport_AgingReport(NOLOCK)      
WHERE  ProviderName = 'All Provider' AND ATBCategory = 'Practice Unapplied' AND ClientID =@ClientID AND ReportYear = @ReportYear      
AND ReportMonth=@ReportMonth GROUP BY  ClientID,ReportYear,ReportMonth) aa      
INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear       
AND UB.ReportMonth = aa.ReportMonth AND UB.ProviderName = aa.ProviderName      
/*Update All Provider for AccountsReceivable*/      
UPDATE UB SET UB.AccountsReceivable = aa.AccountsReceivable                                    
FROM (SELECT ClientID,ReportYear,ReportMonth,ProviderName,      
CASE WHEN ProviderName LIKE '%, %' THEN       
LEFT(ProviderName,(LEN(ProviderName)-Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))      
ELSE ProviderName END AS ShortName,SUM(ISNULL(CategoryBalance,0))AccountsReceivable      
FROM PPMReport_AgingReport(NOLOCK) WHERE ATBCategory='Totals'      
AND ClientID =@ClientID AND ReportYear = @ReportYear AND ReportMonth=@ReportMonth GROUP BY ClientID,ReportYear,ReportMonth,ProviderName) aa      
INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear       
AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName      
/*Update All Provider for AROver120*/      
UPDATE UB SET UB.AROver120 = aa.AROver120                                         
FROM (SELECT ClientID,ReportYear,ReportMonth,ProviderName,      
CASE WHEN ProviderName LIKE '%, %' THEN       
LEFT(ProviderName,(LEN(ProviderName)-Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))      
ELSE ProviderName END AS ShortName,SUM(ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))AROver120       
FROM PPMReport_AgingReport(NOLOCK) WHERE ATBCategory NOT IN ('Totals','Practice Unapplied')      
AND ClientID =@ClientID AND ReportYear = @ReportYear AND ReportMonth=@ReportMonth GROUP BY ClientID,ReportYear,ReportMonth,ProviderName) aa      
INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear       
AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName      
/*Update netpayments, accountreceivable with calculation*/      
UPDATE UB SET UB.NetPayments = aa.NetPayments, ub.AccountsReceivable = aa.AccountsReceivable      
FROM(SELECT ClientID,ReportYear,ReportMonth,ShortName,      
/*ISNULL(SUM(ABS(ISNULL(Payments,0))-ABS(ISNULL(Refunds,0))-ABS(ISNULL(UnappliedPayments,0))),0)NetPayments,*/      
ABS(SUM(((ISNULL(Payments,0)*-1)+(ISNULL(Refunds,0)*-1))+(ISNULL(UnappliedPayments,0)*-1)))NetPayments      
,ISNULL(SUM(ISNULL(AccountsReceivable,0)-ISNULL(UnappliedBalance,0)),0)AccountsReceivable      
FROM #TempTblpg1to12 GROUP BY ClientID,ReportYear,ReportMonth,ShortName) aa      
INNER JOIN #TempTblpg1to12 UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear       
AND UB.ReportMonth = aa.ReportMonth AND UB.ShortName = aa.ShortName      
/*ARDaysOutstanding*/      
SELECT ClientID,ReportMonth,ReportYear,ShortName,Charges,DTID      
INTO #TempTblpg1to12ARDays FROM PPMReport_Rollforward(NOLOCK) WHERE ClientID = @ClientID AND      
DTID >= DATEADD(MONTH,-2,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')) and       
DTID < CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')      
SET @RWCount = (SELECT COUNT(DISTINCT(ReportMonth)) FROM #TempTblpg1to12ARDays)+1      
IF @RWCount = 1      
BEGIN      
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays         
FROM(SELECT ClientID,ReportYear,ReportMonth,ShortName,ISNULL(NULLIF(ISNULL(ABS(AccountsReceivable),0)/NULLIF((isnull(Charges,0)/(30)),0),0),0)ARDays       
FROM #TempTblpg1to12 WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear = @ReportYear      
GROUP BY ClientID,ReportYear,ReportMonth,ShortName,AccountsReceivable,Charges)AR      
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND       
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName      
END      
ELSE      
BEGIN      
UPDATE ARD SET ARD.ARDaysOutstanding = AR.ARDays      
FROM(SELECT aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,      
ISNULL(NULLIF(ISNULL(ABS(isnull(aa.AccountsReceivable,0)),0)/NULLIF(SUM(ISNULL(aa.Charges,0)+ISNULL(bb.Charges,0))/(@RWCount*30),0),0),0) ARDays      
FROM #TempTblpg1to12 AA LEFT JOIN (SELECT ClientID,ShortName,SUM(ISNULL(Charges,0))Charges FROM #TempTblpg1to12ARDays       
GROUP BY  ClientID,ShortName) bb ON aa.ClientID = bb.ClientID AND aa.ShortName=bb.ShortName      
WHERE aa.ClientID=@ClientID AND aa.ReportMonth = @ReportMonth AND aa.ReportYear = @ReportYear      
GROUP BY  aa.ClientID,aa.ReportYear,aa.ReportMonth,aa.ShortName,aa.AccountsReceivable)AR      
INNER JOIN #TempTblpg1to12 ARD ON ARD.ClientID = AR.ClientID AND ARD.ReportYear = AR.ReportYear AND       
ARD.ReportMonth = AR.ReportMonth AND ARD.ShortName = AR.ShortName      
END      
/*Final Data moved to PPMReport_Rollforward table*/      
INSERT INTO PPMReport_Rollforward(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,      
Payments,Refunds,Adjustments,UnappliedPayments,AccountsReceivable,AROver120,ARDaysOutstanding,UnappliedBalance,DTID)      
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,Charges,      
NetPayments,Refunds,ABS(ISNULL(Adjustments,0))Adjustments,ISNULL(UnappliedPayments,0)UnappliedPayments,AccountsReceivable,      
AROver120,ARDaysOutstanding,ISNULL(UnappliedBalance,0)UnappliedBalance,DTID FROM #TempTblpg1to12 ORDER BY ShortName      
/*Yearly Compare*/      
INSERT INTO PPMReport_Rollforward_YrlyCompare(ClientID,ReportYear,ReportMonth,ShortName,YrlyCharges,      
YrlyPayments,YrlyRefunds,YrlyAdjustments,YrlyUnappliedPayments,YrlyAccountsReceivable,YrlyAROver120,      
YrlyARDaysOutstanding,YrlyUnappliedBalance)      
SELECT CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ShortName,       
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Charges)-ABS(PY.Charges))/NULLIF(ISNULL(SUM(ABS(PY.Charges)),0),0),0))*100 YrlyCharges,      
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Payments)-ABS(PY.Payments))/NULLIF(ISNULL(SUM(ABS(PY.Payments)),0),0),0))*100 YrlyPayments,      
CONVERT(FLOAT,ISNULL(SUM(CY.Refunds-PY.Refunds)/NULLIF(ISNULL(SUM(PY.Refunds),0),0),0))*100 YrlyRefunds,      
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.Adjustments)-ABS(PY.Adjustments))/NULLIF(ISNULL(SUM(ABS(PY.Adjustments)),0),0),0))*100 YrlyAdjustments,      
CONVERT(FLOAT,ISNULL(SUM(CY.UnappliedPayments-PY.UnappliedPayments)/NULLIF(ISNULL(SUM(PY.UnappliedPayments),0),0),0))*100 YrlyUnappliedPayments,      
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AccountsReceivable)-ABS(PY.AccountsReceivable))/NULLIF(ISNULL(SUM(ABS(PY.AccountsReceivable)),0),0),0))*100 YrlyAccountsReceivable,      
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.AROver120)-ABS(PY.AROver120))/NULLIF(ISNULL(SUM(ABS(PY.AROver120)),0),0),0))*100 YrlyAROver120,      
CONVERT(FLOAT,ISNULL(SUM(ABS(CY.ARDaysOutstanding)-ABS(PY.ARDaysOutstanding))/NULLIF(ISNULL(SUM(ABS(PY.ARDaysOutstanding)),0),0),0))*100 YrlyARDaysOutstanding,      
CONVERT(FLOAT,ISNULL(SUM(CY.UnappliedBalance-PY.UnappliedBalance)/NULLIF(ISNULL(SUM(PY.UnappliedBalance),0),0),0))*100 YrlyUnappliedBalance      
FROM PPMReport_Rollforward(NOLOCK)CY LEFT JOIN (SELECT * FROM PPMReport_Rollforward(NOLOCK)       
WHERE ClientID=@ClientID AND  ReportMonth=@ReportMonth AND ReportYear = (@ReportYear-1) )PY       
ON CY.ClientID = PY.ClientID AND CY.ReportMonth=PY.ReportMonth AND CY.ShortName=PY.ShortName      
WHERE CY.ClientID=@ClientID AND CY.ReportYear=@ReportYear AND CY.ReportMonth=@ReportMonth      
GROUP BY CY.ClientID,CY.ReportYear,CY.ReportMonth,CY.ShortName       
IF OBJECT_ID('tempdb..#TempTblpg1to12') IS NOT NULL DROP TABLE #TempTblpg1to12      
IF OBJECT_ID('tempdb..#TempTblpg1to12ARDays') IS NOT NULL DROP TABLE #TempTblpg1to12ARDays      
END      
      
      
/*Page 13 to 22*/      
--DECLARE @ClientID INT = 1      
--DECLARE @ReportYear INT = 2017      
--DECLARE @ReportMonth INT = 2      
IF OBJECT_ID('tempdb..#TempTblpg13to22') IS NOT NULL DROP TABLE #TempTblpg13to22      
IF OBJECT_ID('tempdb..#TempTblFD01') IS NOT NULL DROP TABLE #TempTblFD01      
IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01      
IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02      
IF (SELECT Count(*) FROM PPMReport_FinancialDashboard(NOLOCK) WHERE ClientID=@ClientID AND ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0      
BEGIN      
CREATE TABLE #TempTblpg13to22(ClientID INT,ReportYear INT,ReportMonth INT,ProviderName VARCHAR(100),ShortName VARCHAR(100),      
ReportName VARCHAR(100),CPTGroupDesc VARCHAR(100),TotalCount DECIMAL (18, 2))      
/*GET Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,UnappliedPayments,AccountsReceivable*/      
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, ReportName, TotalCount INTO #TempTblFD01      
FROM (SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,      
UnappliedPayments,AccountsReceivable FROM PPMReport_Rollforward(NOLOCK)      
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth) PVT      
UNPIVOT (TotalCount FOR ReportName IN (Charges, Payments, Adjustments,ARDaysOutstanding,Refunds,UnappliedPayments,AccountsReceivable))AS unpvt;      
UPDATE #TempTblFD01 SET ReportName = 'Gross Charges' WHERE ReportName = 'Charges'      
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount FROM #TempTblFD01      
/*Update Cleargage*/      
UPDATE UB SET UB.ClearGage = aa.Credit                                          
FROM (SELECT cc.ClientID,cc.ReportMonth,cc.ReportYear,cc.ProviderName,cg.Credit      
FROM PPMReport_ClearGage_Collection(NOLOCK)cc      
LEFT JOIN PPMReport_ClientList(Nolock)cl on cc.ClientID=cl.ID      
LEFT JOIN PPMReport_ClearGage(nolock)cg       
ON cl.Client = cg.PPMMerchantAccount and cc.ReportYear=cg.ReportYear and cc.ReportMonth=cg.ReportMonth      
WHERE cc.ClientID=@ClientID and cc.ReportMonth = @ReportMonth and cc.ReportYear = @ReportYear) aa      
INNER JOIN PPMReport_ClearGage_Collection UB ON UB.ClientID = aa.ClientID AND UB.ReportYear = aa.ReportYear       
AND UB.ReportMonth = aa.ReportMonth AND UB.ProviderName = aa.ProviderName      
/*Get ClearGage, Collections*/      
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
SELECT  ClientID,ReportYear,ReportMonth,ProviderName,ShortName, ReportName, TotalCount FROM       
(SELECT  ClientID,ReportYear,ReportMonth,ProviderName,'All Provider'ShortName, ISNULL(ClearGage,0)ClearGage,ISNULL(Collections,0)Collections       
FROM PPMReport_ClearGage_Collection(NOLOCK)      
WHERE ClientID=@ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth) PVT      
UNPIVOT (TotalCount FOR ReportName IN (ClearGage, Collections))AS unpvt;      
/*Get all provider EncounterAnalysis*/      
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,TotalCount,ReportName)      
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ClaimProvider,'All Provider'ShortName,      
CPTGroupDesc,SUM(ISNULL(Units,0))TotalCount,'EncounterAnalysis'ReportName FROM PPMReport_DOPQuery(NOLOCK)      
WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL       
AND CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/      
GROUP BY ClientID,ReportYear,ReportMonth,CPTGroupDesc HAVING SUM(ISNULL(Units,0))>0 ORDER BY CPTGroupDesc ASC      
/*Get Individual Provider EncounterAnalysis*/      
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,TotalCount,ReportName)      
SELECT ClientID,ReportYear,ReportMonth,ClaimProvider,CASE WHEN ClaimProvider LIKE '%, %' THEN       
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))      
ELSE ClaimProvider END AS ShortName,CPTGroupDesc,SUM(ISNULL(Units,0))TotalCount,'EncounterAnalysis'ReportName      
FROM PPMReport_DOPQuery(NOLOCK) WHERE ClientID = @ClientID AND ReportYear = @ReportYear AND       
ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL AND CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/      
GROUP BY ClientID,ReportYear,ReportMonth,ClaimProvider,CPTGroupDesc HAVING SUM(ISNULL(Units,0))>0 ORDER BY ClaimProvider ASC      
/*CPT Counts All Provider*/      
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,      
'CPT Counts'ReportName,SUM(ISNULL(Units,0))Units FROM PPMReport_DOPQuery(NOLOCK)DP      
WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL       
AND Dp.CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/      
GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth      
ORDER BY ProviderName,ReportYear,ReportMonth ASC      
/*CPT Counts Individual Provider*/      
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider ProviderName,CASE WHEN ClaimProvider LIKE '%, %' THEN       
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))      
ELSE ClaimProvider END AS ShortName,'CPT Counts'ReportName,SUM(ISNULL(Units,0))Units      
FROM PPMReport_DOPQuery(NOLOCK)DP      
WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear AND ReportMonth = @ReportMonth /*AND CPTGroupDesc IS NOT NULL       
AND Dp.CPT NOT IN (SELECT CPT FROM PPMReport_SkipCPTEncounter(NOLOCK))*/      
GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider HAVING SUM(ISNULL(Units,0))>0      
ORDER BY ProviderName,ReportYear,ReportMonth ASC      
/*Work wRVU All Provider*/      
SELECT ClientID,dp.ReportYear,ReportMonth,CPT,SUM(Units)UNITS      
INTO #TempTblWorkwRVU01 FROM PPMReport_DOPQuery(NOLOCK) DP      
WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth      
GROUP BY ClientID,dp.ReportYear,ReportMonth,CPT      
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,'Work wRVU'ReportName,      
SUM(wRVUu)wRVU FROM      
(SELECT ClientID,rv.ReportYear,ReportMonth,CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu      
FROM #TempTblWorkwRVU01(NOLOCK)cp      
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL       
GROUP BY ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units)aa      
GROUP BY ClientID,ReportYear,ReportMonth      
/*Work wRVU Individual Provider*/      
SELECT ClientID,dp.ReportYear,ReportMonth,CPT,SUM(Units)UNITS,ClaimProvider      
INTO #TempTblWorkwRVU02 FROM PPMReport_DOPQuery(NOLOCK) DP      
WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth      
GROUP BY ClientID,dp.ReportYear,ReportMonth,CPT,ClaimProvider      
INSERT INTO #TempTblpg13to22(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,TotalCount)      
SELECT ClientID,ReportYear,ReportMonth,ClaimProvider ProviderName,ShortName,'Work wRVU'ReportName,      
SUM(wRVUu)wRVU FROM      
(SELECT ClientID,rv.ReportYear,ReportMonth,ClaimProvider,CASE WHEN ClaimProvider LIKE '%, %' THEN       
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))      
ELSE ClaimProvider END AS ShortName,CPT,(CONVERT(DECIMAL (18, 2),ISNULL(RV.wRVU,0))*cp.Units)wRVUu      
FROM #TempTblWorkwRVU02(NOLOCK)cp      
INNER JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL       
GROUP BY ClientID,rv.ReportYear,ReportMonth,CPT,rv.wRVU,Units,ClaimProvider)aa      
GROUP BY ClientID,ReportYear,ReportMonth,ClaimProvider,ShortName      
ORDER BY ReportYear,ReportMonth,ShortName      
      
/*Update to Financial dashboard*/      
INSERT INTO PPMReport_FinancialDashboard(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount)      
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,ReportName,CPTGroupDesc,TotalCount FROM #TempTblpg13to22      
IF OBJECT_ID('tempdb..#TempTblpg13to22') IS NOT NULL DROP TABLE #TempTblpg13to22      
IF OBJECT_ID('tempdb..#TempTblFD01') IS NOT NULL DROP TABLE #TempTblFD01      
IF OBJECT_ID('tempdb..#TempTblWorkwRVU01') IS NOT NULL DROP TABLE #TempTblWorkwRVU01      
IF OBJECT_ID('tempdb..#TempTblWorkwRVU02') IS NOT NULL DROP TABLE #TempTblWorkwRVU02      
END      
      
      
/*Payer Mix <---> Page 26 - 45*/      
--DECLARE @ClientID INT = 1      
--DECLARE @ReportYear INT = 2017      
--DECLARE @ReportMonth INT = 4      
if (SELECT Count(*) FROM PPMReport_PayerMix(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0      
BEGIN      
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)      
SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,      
InsuranceType,SUM(ISNULL(Charges,0))Charges,SUM(Payments)Payments ,SUM(Refunds) Refunds      
FROM PPMReport_DOPQuery(NOLOCK)DP      
WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth      
GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,InsuranceType      
/*ORDER BY DP.ClientID,DP.ReportYear,DP.ReportMonth,dp.InsuranceType*/      
UNION      
SELECT ClientID,ReportYear,ReportMonth,ProviderName,ShortName,'UnappliedPayments'InsuranceType,0.00 charges,      
UnappliedPayments Payments,0.00 Refunds FROM PPMReport_Rollforward(nolock)       
WHERE ReportMonth=@ReportMonth and ReportYear=@ReportYear AND ClientID=@ClientID AND ProviderName = 'All Provider'      
      
INSERT INTO PPMReport_PayerMix(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,PayorType,Charges,Payments,Refunds)      
SELECT DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider,CASE WHEN ClaimProvider LIKE '%, %' THEN       
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))      
ELSE ClaimProvider END AS ShortName,InsuranceType,SUM(ISNULL(Charges,0))Charges,      
SUM(Payments)Payments ,SUM(Refunds) Refunds FROM PPMReport_DOPQuery(NOLOCK)DP      
WHERE DP.ClientID = @ClientID AND DP.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth      
GROUP BY  DP.ClientID,DP.ReportYear,DP.ReportMonth,ClaimProvider,InsuranceType      
ORDER BY DP.ClientID,DP.ReportYear,DP.ReportMonth,DP.ClaimProvider,dp.InsuranceType      
END      
      
/*Aging Comparison <---> Page 47 - 48*/      
--DECLARE @ClientID INT = 1      
--DECLARE @ReportYear INT = 2017      
--DECLARE @ReportMonth INT = 4      
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC      
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)       
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-01')<=0      
BEGIN      
CREATE TABLE #TempTblAC(ClientID INT,ReportYear INT,ReportMonth INT,ReportName varchar(50),ProviderName varchar(100),ATBCategory VARCHAR(50),      
[0-30] DECIMAL (18, 2),[31-60] DECIMAL (18, 2),[61-90] DECIMAL (18, 2),[91-120] DECIMAL (18, 2),[121-150] DECIMAL (18, 2),      
[151-180] DECIMAL (18, 2),[181+] DECIMAL (18, 2),CategoryBalance DECIMAL (18, 2),DTID DATE,ShortName varchar(100))      
/*Insurance AR*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ac.ClientID,ac.ReportYear,AC.ReportMonth,'Aging-01'ReportName,ac.ProviderName,'Insurance AR' ATBCategory,      
SUM(ISNULL(ac.[0-30],0))[0-30],SUM(ISNULL(ac.[31-60],0))[31-60],SUM(ISNULL(ac.[61-90],0))[61-90],SUM(ISNULL(ac.[91-120],0))[91-120],      
SUM(ISNULL(ac.[121-150],0))[121-150],SUM(ISNULL(ac.[151-180],0))[151-180],SUM(ISNULL(ac.[181+],0))[181+],      
SUM(ISNULL(ac.[CategoryBalance],0))[CategoryBalance]  FROM PPMReport_AgingReport(NOLOCK) AC      
WHERE ATBCategory NOT IN('Patient', 'Totals','Practice Unapplied') and ac.ClientID = @ClientID AND       
ac.ReportYear = @ReportYear and ac.ReportMonth = @ReportMonth AND ProviderName='All Provider'      
GROUP BY ac.ClientID,ac.ReportYear,AC.ReportMonth,ac.ProviderName     
/*Patient AR*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,AC.ReportMonth,'Aging-01'ReportName,ProviderName,'Patient AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],      
SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]      
FROM PPMReport_AgingReport(NOLOCK)AC      
WHERE ATBCategory='Patient'AND ClientID = @ClientID AND ReportYear = @ReportYear and ReportMonth = @ReportMonth AND ProviderName='All Provider'      
GROUP BY ClientID,ReportYear,AC.ReportMonth,ATBCategory,ProviderName      
/*Total AR = sum of Insurance AR & Patient AR*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-01'ReportName,ProviderName,'Total AR' ATBCategory,SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],      
SUM([91-120])[91-120],SUM([121-150])[121-150],SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]      
FROM #TempTblAC GROUP BY ClientID,ReportYear,ReportMonth,ProviderName      
/*Total % AR*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance)      
SELECT ClientID,ReportYear,ReportMonth,'Aging-01' ReportName, ProviderName,'Total%AR' ATBCategory      
,[0-30] = Round(CONVERT(FLOAT,[0-30]/NULLIF([CategoryBalance],0))*100,2)       
,[31-60] = Round(CONVERT(FLOAT,[31-60]/NULLIF([CategoryBalance],0))*100,2)       
,[61-90] = Round(CONVERT(FLOAT,[61-90]/NULLIF([CategoryBalance],0))*100,2)       
,[91-120] = Round(CONVERT(FLOAT,[91-120]/NULLIF([CategoryBalance],0))*100,2)       
,[121-150] = Round(CONVERT(FLOAT,[121-150]/NULLIF([CategoryBalance],0))*100,2)       
,[151-180] = Round(CONVERT(FLOAT,[151-180]/NULLIF([CategoryBalance],0))*100,2)       
,[181+] = Round(CONVERT(FLOAT,[181+]/NULLIF([CategoryBalance],0))*100,2)      
,[CategoryBalance] = Round(CONVERT(FLOAT,[CategoryBalance]/NULLIF([CategoryBalance],0))*100,2)      
FROM #TempTblAC WHERE ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'      
UPDATE #TempTblAC set DTID = CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01'),      
ShortName = (CASE WHEN ProviderName LIKE '%, %' THEN LEFT(ProviderName,(LEN(ProviderName)-      
Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))ELSE ProviderName END)      
/*Chg Ins %*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)      
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Ins %' ATBCategory      
,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)       
,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)      
,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),      
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,      
CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-      
Len(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName      
FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)       
WHERE ClientID=@ClientID AND ATBCategory = 'Insurance AR' AND  ReportName = 'Aging-01'       
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg      
ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName      
WHERE cChg.ATBCategory = 'Insurance AR' AND  cChg.ReportName = 'Aging-01'      
/*Chg Pat %*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)      
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Chg Pat %' ATBCategory      
,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)       
,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)      
,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),      
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,      
CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-      
LEN(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName      
FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)       
WHERE ClientID=@ClientID AND ATBCategory = 'Patient AR' AND  ReportName = 'Aging-01'       
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg      
ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName      
WHERE cChg.ATBCategory = 'Patient AR' AND  cChg.ReportName = 'Aging-01'      
/*Chg Pat %*/      
INSERT INTO #TempTblAC(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID,ShortName)      
select cChg.ClientID,cChg.ReportYear,cChg.ReportMonth,'Aging-01' ReportName, cChg.ProviderName,'Total Chg %' ATBCategory      
,[0-30] = Round(CONVERT(FLOAT,cChg.[0-30]/NULLIF(ochg.[0-30],0))*100,2)       
,[31-60] = Round(CONVERT(FLOAT,cChg.[31-60]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[61-90] = Round(CONVERT(FLOAT,cChg.[61-90]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[91-120] = Round(CONVERT(FLOAT,cChg.[91-120]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[121-150] = Round(CONVERT(FLOAT,cChg.[121-150]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[151-180] = Round(CONVERT(FLOAT,cChg.[151-180]/NULLIF(ochg.[CategoryBalance],0))*100,2)       
,[181+] = Round(CONVERT(FLOAT,cChg.[181+]/NULLIF(ochg.[CategoryBalance],0))*100,2)      
,[CategoryBalance] = Round(CONVERT(FLOAT,cChg.[CategoryBalance]/NULLIF(ochg.[CategoryBalance],0))*100,2),      
CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid,      
CASE WHEN cChg.ProviderName LIKE '%, %' THEN LEFT(cChg.ProviderName,(LEN(cChg.ProviderName)-      
LEN(SUBSTRING(cChg.ProviderName,CHARINDEX(', ',cChg.ProviderName),LEN(cChg.ProviderName)))))ELSE cChg.ProviderName END AS ShortName      
FROM #TempTblAC cChg LEFT JOIN (SELECT * FROM PPMReport_AgingComparison(NOLOCK)       
WHERE ClientID=@ClientID AND ATBCategory = 'Total AR' AND  ReportName = 'Aging-01'       
AND DTID =  DATEADD(MONTH,-1,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')))oChg    ON cChg.ClientID=ochg.ClientID and cChg.ShortName = oChg.ShortName      
WHERE cChg.ATBCategory = 'Total AR' AND  cChg.ReportName = 'Aging-01'      
/*Aging-01 PPMReport AgingComparison*/      
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],[CategoryBalance],DTID)      
SELECT ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,DTID FROM #TempTblAC ORDER BY ShortName       
IF OBJECT_ID('tempdb..#TempTblAC') IS NOT NULL DROP TABLE #TempTblAC      
END      
/*Aging Comparison <---> Page 49 - 59*/      
IF (SELECT Count(*) FROM PPMReport_AgingComparison(NOLOCK)       
WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear and ReportName = 'Aging-02')<=0      
BEGIN      
INSERT INTO PPMReport_AgingComparison(ClientID,ReportYear,ReportMonth,ReportName,ProviderName,ShortName,ATBCategory,[0-30],[31-60],      
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance,TotalPercent,Over90Days,DTID)      
SELECT ClientID,ReportYear,tb.ReportMonth,'Aging-02'ReportName,tb.ProviderName,CASE WHEN tb.ProviderName LIKE '%, %' THEN       
LEFT(tb.ProviderName,(LEN(tb.ProviderName)-Len(SUBSTRING(tb.ProviderName,CHARINDEX(', ',tb.ProviderName),LEN(tb.ProviderName)))))      
ELSE tb.ProviderName END AS ShortName,ATBCategory,      
SUM([0-30])[0-30],SUM([31-60])[31-60],SUM([61-90])[61-90],SUM([91-120])[91-120],SUM([121-150])[121-150],      
SUM([151-180])[151-180],SUM([181+])[181+],SUM([CategoryBalance])[CategoryBalance]      
,TotalPercentage = ISNULL(ROUND(CONVERT(float,SUM([CategoryBalance]) /NULLIF(ISNULL(rf.AccountsReceivable,0),0))*100,2),0)      
,Over90days = ISNULL(ROUND(CONVERT(float,SUM(ISNULL([91-120],0)+ISNULL([121-150],0)+ISNULL([151-180],0)+ISNULL([181+],0))/NULLIF(SUM(CategoryBalance),0))*100,2),0)      
,CONVERT(DATE,CONVERT(VARCHAR(4),@ReportYear)+'-'+CONVERT(VARCHAR(2),@ReportMonth)+'-01')dtid      
FROM PPMReport_AgingReport(NOLOCK) tb       
LEFT JOIN (SELECT ReportMonth,ProviderName, AccountsReceivable FROM PPMReport_Rollforward(NOLOCK)       
WHERE ClientID = @ClientID and ReportMonth=@ReportMonth and ReportYear=@ReportYear)rf      
ON tb.ProviderName = rf.ProviderName AND tb.ReportMonth = rf.ReportMonth      
WHERE tb.ClientID = @ClientID AND tb.ReportYear = @ReportYear and tb.ReportMonth = @ReportMonth      
GROUP BY tb.ClientID,tb.ReportYear,tb.ReportMonth,tb.ProviderName,tb.ATBCategory,rf.AccountsReceivable      
END      
      
      
/*Procedure Count <---> Page 60 - 79*/      
--DECLARE @ClientID INT = 1      
--DECLARE @ReportYear INT = 2017      
--DECLARE @ReportMonth INT = 4      
IF (SELECT Count(*) FROM PPMReport_ProcedureCount(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0      
BEGIN      
/*All Provider*/      
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,CPT,CPTDescription,UNITS)      
SELECT ClientID,dp.ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,CPTGroupDesc,CPT,CPTDescription,SUM(Units)UNITS      
FROM PPMReport_DOPQuery(NOLOCK) DP WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth      
GROUP BY ClientID,dp.ReportYear,ReportMonth,CPTGroupDesc,CPT,CPTDescription HAVING SUM(Units)>0 ORDER BY 2,3,4,5      
/*Individual Provider*/      
INSERT INTO PPMReport_ProcedureCount(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTGroupDesc,CPT,CPTDescription,UNITS)      
SELECT ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CASE WHEN ClaimProvider LIKE '%, %' THEN       
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))      
ELSE ClaimProvider END AS ShortName,CPTGroupDesc,CPT,CPTDescription,SUM(Units)UNITS      
FROM PPMReport_DOPQuery(NOLOCK) DP WHERE ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth=@ReportMonth    
GROUP BY ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPTGroupDesc,CPT,CPTDescription HAVING SUM(Units)>0 
ORDER BY 2,3,4,5      
END      
      
      
--DECLARE @ClientID INT = 1      
--DECLARE @ReportYear INT = 2017      
--DECLARE @ReportMonth INT = 4      
IF OBJECT_ID('tempdb..#TempTblWorkwRVU001') IS NOT NULL DROP TABLE #TempTblWorkwRVU001      
IF OBJECT_ID('tempdb..#TempTblWorkwRVU002') IS NOT NULL DROP TABLE #TempTblWorkwRVU002      
IF (SELECT Count(*) FROM PPMReport_wRVUReport(NOLOCK) WHERE ClientID=@ClientID and ReportMonth = @ReportMonth AND ReportYear=@ReportYear)<=0      
BEGIN      
/*Work wRVU All Provider*/      
SELECT dp.ClientID,dp.ReportYear,ReportMonth,CPT,dp.CPTDescription, SUM(Units)UNITS,wRVU      
INTO #TempTblWorkwRVU001 FROM PPMReport_DOPQuery(NOLOCK) DP      
LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=DP.CPT AND rv.ReportYear=DP.ReportYear       
AND RV.Modifier IS NULL /*and dp.CPTDescription = rv.CPTDescription*/      
WHERE dp.ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth      
GROUP BY dp.ClientID,dp.ReportYear,ReportMonth,CPT,dp.CPTDescription,wRVU HAVING SUM(Units)>0      
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)      
SELECT ClientID,ReportYear,ReportMonth,'All Provider'ProviderName,'All Provider'ShortName,      
CPT,CPTDescription,UNITS,wRVU,(CONVERT(DECIMAL (18, 2),ISNULL(wRVU,0))*Units)RVU FROM #TempTblWorkwRVU001      
/*Work wRVU individual Provider*/      
SELECT dp.ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPT,dp.CPTDescription, SUM(Units)UNITS,wRVU      
INTO #TempTblWorkwRVU002 FROM PPMReport_DOPQuery(NOLOCK) DP      
LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=DP.CPT AND rv.ReportYear=DP.ReportYear       
AND RV.Modifier IS NULL /*and dp.CPTDescription = rv.CPTDescription*/      
WHERE dp.ClientID = @ClientID AND Dp.ReportYear = @ReportYear and dp.ReportMonth = @ReportMonth      
GROUP BY dp.ClientID,dp.ReportYear,ReportMonth,ClaimProvider,CPT,dp.CPTDescription,wRVU HAVING SUM(Units)>0      
INSERT INTO PPMReport_wRVUReport(ClientID,ReportYear,ReportMonth,ProviderName,ShortName,CPTCode,CPTDescription,wRVUCount,wRVUYearly,wRVU)      
SELECT ClientID,ReportYear,ReportMonth,ClaimProvider,CASE WHEN ClaimProvider LIKE '%, %' THEN       
LEFT(ClaimProvider,(LEN(ClaimProvider)-Len(SUBSTRING(ClaimProvider,CHARINDEX(', ',ClaimProvider),LEN(ClaimProvider)))))      
ELSE ClaimProvider END AS ShortName,CPT,CPTDescription,UNITS,wRVU,(CONVERT(DECIMAL (18, 2),ISNULL(wRVU,0))*Units)RVU FROM #TempTblWorkwRVU002      
END      
COMMIT TRANSACTION       
SET @ErrorMessage = 'Sucess'       
END TRY                  
                            
BEGIN CATCH                  
ROLLBACK TRANSACTION        
SET @ErrorMessage = ERROR_MESSAGE()            
END CATCH       
SELECT CONVERT(VARCHAR(10),@cid) +'|'+ CONVERT(VARCHAR(10),@Year) +'|' + CONVERT(VARCHAR(10),@month) +'|'+ @ErrorMessage      
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg103to112]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_Pg103to112]                
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))                
AS                
BEGIN                
/*        
DECLARE @Client VARCHAR(100)='CHCL'        
DECLARE @ReportYear varchar(max) = '2017,2018,2019'      
*/      
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear                
CREATE TABLE #TempTblYear(ReportYear INT)                
INSERT INTO #TempTblYear                
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')                
                
SELECT cl.ClientAcronym,CL.ClientFullName Client,ReportYear,PM.ReportMonth,ProviderName AS ShortName,     
--CASE WHEN ProviderName LIKE '%, %' THEN                 
--LEFT(ProviderName,(LEN(ProviderName)-Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))                
--ELSE ProviderName END AS ShortName,    
Voucher,Issue,Balance                 
FROM PPMReport_DM7(Nolock)FD                
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID                
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth                
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)                
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear)        
AND Voucher NOT LIKE '%Total%' ORDER BY ShortName,FD.ReportYear,FD.ReportMonth ASC                
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg113to118]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_Pg113to118]          
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))          
AS          
BEGIN          
/*      
DECLARE @Client VARCHAR(100) = 'CHCL'      
DECLARE @ReportYear varchar(max) = '2017,2018'        
*/      
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear          
CREATE TABLE #TempTblYear(ReportYear INT)          
INSERT INTO #TempTblYear          
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')          
          
SELECT CL.ClientAcronym,CL.ClientFullName Client,ReportYear,PM.ReportMonth, DoctorName  AS ShortName      
--CASE WHEN DoctorName LIKE '%, %' THEN         
--LEFT(DoctorName,(LEN(DoctorName)-Len(SUBSTRING(DoctorName,CHARINDEX(', ',DoctorName),LEN(DoctorName)))))        
--ELSE DoctorName END AS ShortName        
,PriInsName,AccountNumber,PatientName,ChargeAmount,Receipts,          
Adjusts,Balance,DateOfServ,DateOfPost,CPT,PrimaryDiag,CurrInsBillDt,LastActivityNoRebill,Voucher,Issue          
FROM PPMReport_DM7Details(Nolock)FD          
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID          
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth          
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)          
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear) ORDER BY FD.ReportYear,FD.ReportMonth ASC          
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear          
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg13]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_Pg13]          
(@Client VARCHAR(60),@ReportYear VARCHAR(MAX))          
AS          
BEGIN    
/*      
DECLARE @Client VARCHAR(60) = 'CHCL'      
DECLARE @ReportYear varchar(max) = '2017,2018'      
*/    
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear          
CREATE TABLE #TempTblYear(ReportYear INT)          
INSERT INTO #TempTblYear          
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')          
          
SELECT cl.ClientAcronym,cl.ClientFullName Client,RF.ReportYear,PM.ReportMonth,RF.ShortName,UnappliedPayments,UnappliedBalance,Refunds,CG.ClearGage,          
YrlyUnappliedPayments,YrlyUnappliedBalance,YrlyRefunds,0.00 YrlyClearGage          
FROM PPMReport_Rollforward(NOLOCK)RF          
LEFT JOIN PPMReport_Rollforward_YrlyCompare(NOLOCK)YRF ON YRF.ShortName= RF.ShortName AND          
YRF.ClientID= RF.ClientID AND YRF.ReportYear = RF.ReportYear AND YRF.ReportMonth = RF.ReportMonth          
LEFT JOIN PPMReport_ClearGage_Collection(NOLOCK)CG ON RF.ClientID= CG.ClientID AND RF.ReportYear = CG.ReportYear     
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON RF.ClientID= CL.ID          
AND RF.ReportMonth = CG.ReportMonth AND RF.ProviderName = CG.ProviderName         
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=RF.ReportMonth          
WHERE RF.ShortName ='All Provider' AND RF.ClientID  = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)         
AND RF.ReportYear IN (SELECT ReportYear from #TempTblYear)  ORDER BY ShortName,RF.ReportYear,RF.ReportMonth ASC          
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear          
        
END     
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg14to23]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
         
CREATE PROCEDURE [dbo].[PPMReport_Pg14to23]        
(@Client VARCHAR(60) ,@ReportYear VARCHAR(MAX))        
AS        
BEGIN        
/*      
DECLARE @Client VARCHAR(60)  ='CHCL'         
DECLARE @ReportYear varchar(max) = '2017,2018'          
*/    
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear        
CREATE TABLE #TempTblYear(ReportYear INT)        
INSERT INTO #TempTblYear        
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')        
        
SELECT CL.ClientAcronym,CL.ClientFullName Client,ReportYear,PM.ReportMonth,ShortName,ReportName,CPTGroupDesc,TotalCount        
FROM PPMReport_FinancialDashboard(NOLOCK)FD          
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth    
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON fD.ClientID= CL.ID         
WHERE FD.ClientID  = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)        
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear)         
ORDER BY ShortName,FD.ReportYear,FD.ReportMonth ASC        
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear        
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg25to26]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_Pg25to26]                      
(@Client VARCHAR(60) ,@ReportYear VARCHAR(MAX))                      
AS                      
BEGIN                      
 /*              
DECLARE @Client VARCHAR(MAX) = 'CHCL'                      
DECLARE @ReportYear varchar(max) = '2018'        
  */       
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear            
IF OBJECT_ID('tempdb..#TempTblYear01') IS NOT NULL DROP TABLE #TempTblYear01                        
CREATE TABLE #TempTblYear(ReportYear INT)                      
INSERT INTO #TempTblYear                      
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')                      
            
SELECT cl.ClientAcronym,CL.ClientFullName Client,fd.ReportYear,Pm.ReportMonth,''ReportName, ProviderName as ShortName,          
--CASE WHEN ProviderName LIKE '%, %' THEN                 
--LEFT(ProviderName,(LEN(ProviderName)-Len(SUBSTRING(ProviderName,CHARINDEX(', ',ProviderName),LEN(ProviderName)))))                
--ELSE ProviderName END ShortName,            
GrossCharges,VoidedCharges,NetCharges,GrossPayments,VoidedPayments,GrossPmtsafterVoids,Refunds,ToFromUnapplied,            
NetPayments,ContractualAdj,OtherAdj,BadDebt,NetAdj             
INTO #TempTblYear01 FROM PPMReport_Charge(nolock)FD            
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth      
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID               
WHERE ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)        
and ReportYear IN (SELECT ReportYear from #TempTblYear)            
ORDER BY FD.ReportMonth asc              
UPDATE #TempTblYear01 set ShortName = 'Unapplied' where ShortName = 'Practice Unapplied'             
select * from #TempTblYear01            
        
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear             
IF OBJECT_ID('tempdb..#TempTblYear01') IS NOT NULL DROP TABLE #TempTblYear01                   
                   
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg27to46]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_Pg27to46]        
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))        
AS        
BEGIN        
/*    
DECLARE @Client VARCHAR(100)='CHCL'      
DECLARE @ReportYear varchar(max) = '2017,2018'    
*/    
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear        
CREATE TABLE #TempTblYear(ReportYear INT)        
INSERT INTO #TempTblYear        
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')        
        
SELECT cl.ClientAcronym,CL.ClientFullName Client,ReportYear,Pm.ReportMonth,ShortName,PayorType,Charges,Payments,Refunds         
FROM PPMReport_PayerMix(Nolock)FD        
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID        
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth        
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)        
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear)         
ORDER BY ShortName,FD.ReportYear,FD.ReportMonth ASC        
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear        
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_PG2to12]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_PG2to12]      
(@Client VARCHAR(60),@ReportYear VARCHAR(MAX))      
AS      
BEGIN    
/*    
DECLARE @Client VARCHAR(MAX) = 'CHCL'    
DECLARE @ReportYear VARCHAR(MAX) = '2017,2018'    
*/       
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
CREATE TABLE #TempTblYear(ReportYear INT)      
INSERT INTO #TempTblYear      
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')      
      
SELECT cl.ClientAcronym,Client,RF.ReportYear,PM.ReportMonth,RF.ShortName,Charges,Payments,Adjustments,AccountsReceivable,      
AROver120,ARDaysOutstanding,YrlyCharges,YrlyPayments,YrlyAdjustments,YrlyAccountsReceivable,      
YrlyAROver120,YrlyARDaysOutstanding FROM PPMReport_Rollforward(NOLOCK)RF      
LEFT JOIN PPMReport_Rollforward_YrlyCompare(NOLOCK)YRF ON YRF.ShortName= RF.ShortName AND      
YRF.ClientID= RF.ClientID AND YRF.ReportYear = RF.ReportYear AND YRF.ReportMonth = RF.ReportMonth      
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON RF.ClientID= CL.ID      
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=RF.ReportMonth      
WHERE RF.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)  
AND RF.ReportYear IN (SELECT ReportYear FROM #TempTblYear)     
ORDER BY ShortName,RF.ReportYear,RF.ReportMonth ASC      
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
END  
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_PG2to12_bCK]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[PPMReport_PG2to12_bCK]
@ClientName varchar(150),@ReportYear INT    
AS    
BEGIN    
/*Page2-12*/  
DECLARE @Client varchar(30)=@ClientName  
IF OBJECT_ID('tempdb..#TempTblAllCharge01') IS NOT NULL DROP TABLE #TempTblAllCharge01  
CREATE TABLE #TempTblAllCharge01(Client VARCHAR(500),RowNumber int,  
ReportYear INT,ReportMonth VARCHAR(15),ProviderName VARCHAR(100),  
NetCharges DECIMAL (18, 2),NetPayments DECIMAL (18, 2),NetAdj DECIMAL (18, 2),  
AccountsReceivable DECIMAL (18, 2),AR120 DECIMAL (18, 2),ARDays DECIMAL (18, 2),  
YrlyComparNC DECIMAL (18, 2),YrlyComparNP DECIMAL (18, 2),YrlyComparNA DECIMAL (18, 2),  
YrlyComparAR DECIMAL (18, 2),YrlyComparAR120 DECIMAL (18, 2),YrlyComparARDay DECIMAL (18, 2),ID INT)  
  
INSERT INTO #TempTblAllCharge01(RowNumber,ReportYear,ReportMonth,NetCharges,NetPayments,NetAdj,  
AccountsReceivable,AR120,ID,ARDays,Client,ProviderName)  
SELECT ROW_NUMBER() OVER(ORDER BY L1.ReportYear, PM.ID ASC)  As RowNumber,  
L1.ReportYear,L1.ReportMonth,L1.NetCharges,L1.NetPayments,L1.NetAdj,L2.AccountsReceivable,L2.AR120,PM.ID  
,CONVERT(DECIMAL (18, 2),'0.00')ARDays,L1.Client,'All Provider'ProviderName  
FROM(SELECT Client,ReportYear,ReportMonth,NetCharges,NetPayments,NetAdj   
FROM PPM_Report_Monthly_Prov_ChargePaymentAdjvsNet WHERE  
ProviderName='Grand Totals' AND Client = @Client)L1  
LEFT JOIN (SELECT ARDays.Client,ARDays.ReportYear,ARDays.ReportMonth,ar.AccountsReceivable,ARDays.AR120  
FROM(SELECT Client,ReportYear,ReportMonth,AR120=SUM(ar120.[121-150]+ar120.[151-180]+ar120.[181+])  
FROM(SELECT TB.Client,tb.ReportYear, tb.ReportMonth,   
[121-150] = [121-150] - (SELECT [121-150] FROM PPM_Report_Monthly_Prov_AgingReport(NOLOCK)   
WHERE ReportYear = tb.ReportYear AND ReportMonth = tb.ReportMonth AND Client = TB.Client AND  
ATBCategory = 'Practice Unapplied'),  
[151-180] = [151-180] - (SELECT [151-180] FROM PPM_Report_Monthly_Prov_AgingReport(NOLOCK)   
WHERE ReportYear = tb.ReportYear and ReportMonth = tb.ReportMonth And Client = TB.Client AND  
ATBCategory = 'Practice Unapplied'),  
[181+] = [181+] - (SELECT [181+] FROM PPM_Report_Monthly_Prov_AgingReport(NOLOCK)   
WHERE ReportYear = tb.ReportYear and ReportMonth = tb.ReportMonth And Client = TB.Client AND  
ATBCategory = 'Practice Unapplied')  
FROM PPM_Report_Monthly_Prov_AgingReport(NOLOCK) tb WHERE ATBCategory = 'Totals'  
AND Client = @Client)ar120 GROUP BY Client,ReportYear,ReportMonth)ARDays  
LEFT JOIN (SELECT tb.Client,tb.ReportYear, tb.ReportMonth, AccountsReceivable = tb.CategoryBalance -   
(SELECT CategoryBalance FROM PPM_Report_Monthly_Prov_AgingReport(NOLOCK)   
WHERE ReportYear = tb.ReportYear AND ReportMonth = tb.ReportMonth AND Client = TB.Client AND  
ATBCategory = 'Practice Unapplied')  
FROM PPM_Report_Monthly_Prov_AgingReport(NOLOCK) tb WHERE ATBCategory = 'Totals' AND Client = @Client)ar  
ON AR.ReportYear = ARDays.ReportYear AND AR.ReportMonth = ARDays.ReportMonth AND AR.Client = ARDays.Client)L2  
ON L1.ReportYear = L2.ReportYear and L1.ReportMonth = L2.ReportMonth and L1.Client = L2.Client  
LEFT JOIN PPM_Month(NOLOCK) PM ON L1.ReportMonth = PM.ReportMonth   
  
Declare @qry varchar(500)  
Declare @RowNumber INT,@ReportMonth VARCHAR(50),@NetCharge DECIMAL(13, 2)   
Declare @valu int , @Returncount int , @TotalNetCharge DECIMAL(13, 2)   
Declare cur cursor for  
SELECT RowNumber, ReportMonth, NetCharges FROM #TempTblAllCharge01  ORDER BY ReportYear, ID ASC     
open cur  
while 1=1  
BEGIN  
FETCH NEXT FROM cur INTO @RowNumber, @ReportMonth, @NetCharge  
if @@fetch_status = -1 break   
Declare @count int   
Set @Count = (Select COUNT(RowNumber) from #TempTblAllCharge01 Where RowNumber < @RowNumber)  
if @Count = 0   
 BEGIN    
  UPDATE #TempTblAllCharge01 SET ARDays = convert(varchar(max), isnull(AccountsReceivable,0) / nullif((NetCharges / 30),0))   
  Where RowNumber = @RowNumber  
  END  
  else if @Count > 0  
  begin    
  set @valu = @RowNumber - 2  
  if @valu = -1  
  begin  
  set @valu = 0  
  end    
  set @Returncount =  (Select COUNT(RowNumber)  From #TempTblAllCharge01 Where RowNumber Between @valu and @RowNumber)     
  Set @TotalNetCharge = (Select SUM(isnull(NetCharges,0)) / nullif((@Returncount * 30),0)    
  From #TempTblAllCharge01 Where RowNumber Between @valu and @RowNumber)  
  UPDATE #TempTblAllCharge01 SET ARDays = convert(varchar(max), isnull(AccountsReceivable,0) / nullif(@TotalNetCharge,0))  
  Where RowNumber = @RowNumber  
 END  
END  
CLOSE cur  
DEALLOCATE cur   
  
/*Each Provider*/  
IF OBJECT_ID('tempdb..#TempTblAllChargePro') IS NOT NULL DROP TABLE #TempTblAllChargePro  
SELECT Client,ReportYear,ReportMonth,ProviderName,AR=ROUND(SUM(CategoryBalance),0),  
AR120 = ROUND((SUM([121-150])+SUM([151-180])+SUM([181+])),0)  
INTO #TempTblAllChargePro FROM PPM_Report_Monthly_AgingReport(NOLOCK)WHERE ATBCategory!='Totals'  
GROUP BY Client,ReportYear,ReportMonth,ProviderName  
IF OBJECT_ID('tempdb..#TempTblAllChargePro01') IS NOT NULL DROP TABLE #TempTblAllChargePro01  
  
SELECT ROW_NUMBER() OVER(ORDER BY cpa.ProviderName,cpa.ReportYear, PM.ID ASC)  As RowNumber,  
CPA.ReportYear,cpa.ReportMonth,cpa.ProviderName,round(NetCharges,0)NetCharges,round(NetPayments,0)NetPayments,  
ROUND(NetAdj,0)NetAdj,tt.AR AccountsReceivable,tt.AR120 ,PM.ID,CONVERT(DECIMAL (18, 2),'0.00')ARDays,cpa.Client  
INTO #TempTblAllChargePro01 FROM PPM_Report_Monthly_Prov_ChargePaymentAdjvsNet(NOLOCK)cpa  
LEFT JOIN  #TempTblAllChargePro TT ON cpa.ReportMonth=tt.ReportMonth AND    
cpa.ProviderName=tt.ProviderName AND tt.ReportYear=cpa.ReportYear AND tt.Client=cpa.Client  
INNER JOIN PPM_Month(NOLOCK)pm ON pm.ReportMonth=cpa.ReportMonth   
WHERE cpa.ProviderName NOT IN ('Grand Totals','Practice Unapplied') AND cpa.Client = @Client  
Declare @qry_Pro varchar(500)  
Declare @RowNumber_Pro INT,@ReportMonth_Pro varchar(50),@NetCharge_Pro decimal(13, 2),@ProviderName_Pro VARCHAR(200)  
Declare @count_Pro int, @Returncount_Pro int, @valu_Pro int, @TotalNetCharge_Pro decimal(13, 2)   
Declare cur_Pro cursor for  
SELECT RowNumber, ReportMonth,ProviderName, NetCharges FROM #TempTblAllChargePro01  Order by ReportYear, ID asc     
open cur_Pro  
while 1=1  
BEGIN  
FETCH NEXT FROM cur_Pro INTO @RowNumber_Pro, @ReportMonth_Pro,@ProviderName_Pro, @NetCharge_Pro  
if @@fetch_status = -1 break   
Set @count_Pro = (Select COUNT(RowNumber) from #TempTblAllChargePro01 Where RowNumber < @RowNumber_Pro AND ProviderName=@ProviderName_Pro)  
if @count_Pro = 0   
 BEGIN    
  UPDATE #TempTblAllChargePro01 SET ARDays = convert(varchar(max), ISNULL(AccountsReceivable,0) / NULLIF((NetCharges / 30),0))   
  Where RowNumber = @RowNumber_Pro AND ProviderName=@ProviderName_Pro  
  END    
  else if @count_Pro > 0  
  begin    
  set @valu_Pro = @RowNumber_Pro - 2  
  if @valu_Pro = -1  
  begin  
  set @valu_Pro = 0  
  end    
  set @Returncount_Pro =  (Select COUNT(RowNumber) From #TempTblAllChargePro01   
  Where RowNumber Between @valu_Pro and @RowNumber_Pro AND ProviderName=@ProviderName_Pro)      
  Set @TotalNetCharge_Pro = (Select SUM(ISNULL(NetCharges,0)) / NULLIF((@Returncount_Pro * 30),0)  From #TempTblAllChargePro01   
  Where RowNumber Between @valu_Pro and @RowNumber_Pro AND ProviderName = @ProviderName_Pro)  
  UPDATE #TempTblAllChargePro01 SET ARDays = convert(varchar(max), ISNULL(AccountsReceivable,0) /NULLIF(@TotalNetCharge_Pro,0))  
  Where RowNumber = @RowNumber_Pro AND ProviderName=@ProviderName_Pro    
 END  
END  
CLOSE cur_Pro  
DEALLOCATE cur_Pro   
INSERT INTO #TempTblAllCharge01(ReportYear,ReportMonth,ProviderName,NetCharges,NetPayments,NetAdj,AccountsReceivable,AR120,ARDays,Client)  
SELECT ReportYear,ReportMonth,ProviderName,NetCharges,NetPayments,NetAdj,AccountsReceivable,AR120,ARDays,Client FROM #TempTblAllChargePro01 order by RowNumber  
  
/*Update Yearly Calculation*/  
IF OBJECT_ID('tempdb..#TempTblYearCompare') IS NOT NULL DROP TABLE #TempTblYearCompare  
CREATE TABLE #TempTblYearCompare(Client VARCHAR(500),  
ReportYear INT,ReportMonth VARCHAR(15),ProviderName VARCHAR(100),  
NetCharges DECIMAL (18, 2),NetPayments DECIMAL (18, 2),NetAdj DECIMAL (18, 2),  
AccountsReceivable DECIMAL (18, 2),AR120 DECIMAL (18, 2),ARDays DECIMAL (18, 2))  
DECLARE @ProviderName VARCHAR(100)  
Declare cur cursor for  
SELECT DISTINCT ProviderName FROM #TempTblAllCharge01(NOLOCK)  
open cur  
while 1=1  
BEGIN  
FETCH NEXT FROM cur INTO @ProviderName  
if @@fetch_status = -1 break   
 INSERT INTO #TempTblYearCompare(Client,ReportYear,ReportMonth,ProviderName,NetCharges,NetPayments,NetAdj,AccountsReceivable,AR120,ARDays)  
 SELECT tb.Client,tb.ReportYear, tb.ReportMonth,Tb.ProviderName,  
 NC = ROUND(CONVERT(FLOAT,((ISNULL(tb.NetCharges - (SELECT top 1 NetCharges FROM #TempTblAllCharge01   
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client  
 AND ProviderName = @ProviderName),0))/NULLIF((SELECT top 1 NetCharges FROM #TempTblAllCharge01  
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client   
 AND ProviderName = @ProviderName),0)))*100,2),  
 NP = ROUND(CONVERT(FLOAT,((ISNULL(tb.NetPayments - (SELECT top 1 NetPayments FROM #TempTblAllCharge01  
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client  
 AND ProviderName = @ProviderName),0))/NULLIF((SELECT top 1 NetPayments FROM #TempTblAllCharge01   
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client   
 AND ProviderName = @ProviderName),0)))*100,2),  
 NA = ROUND(CONVERT(FLOAT,((ISNULL(tb.NetAdj - (SELECT top 1 NetAdj FROM #TempTblAllCharge01  
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client  
 AND ProviderName = @ProviderName),0))/NULLIF((SELECT top 1 NetAdj FROM #TempTblAllCharge01  
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client   
 AND ProviderName = @ProviderName),0)))*100,2),  
 AR = ROUND(CONVERT(FLOAT,((ISNULL(tb.AccountsReceivable - (SELECT top 1 AccountsReceivable FROM #TempTblAllCharge01   
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client  
 AND ProviderName = @ProviderName),0))/NULLIF((SELECT top 1 AccountsReceivable FROM #TempTblAllCharge01   
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client   
 AND ProviderName = @ProviderName),0)))*100,2),  
 AR_120 = ROUND(CONVERT(FLOAT,((ISNULL(tb.AR120 - (SELECT top 1 AR120 FROM #TempTblAllCharge01   
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client  
 AND ProviderName = @ProviderName),0))/NULLIF((SELECT top 1 AR120 FROM #TempTblAllCharge01  
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client   
 AND ProviderName = @ProviderName),0)))*100,2),  
 AR_Day = ROUND(CONVERT(FLOAT,((ISNULL(tb.ARDays - (SELECT top 1 ARDays FROM #TempTblAllCharge01  
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client  
 AND ProviderName = @ProviderName),0))/NULLIF((SELECT top 1 ARDays FROM #TempTblAllCharge01  
 WHERE ReportYear = tb.ReportYear-1 AND ReportMonth = tb.ReportMonth AND Client = tb.Client   
 AND ProviderName = @ProviderName),0)))*100,2)  
 FROM #TempTblAllCharge01 tb   
 WHERE ProviderName = @ProviderName  
END  
CLOSE cur  
DEALLOCATE cur   
  
UPDATE RPT SET YrlyComparNC=UPD.NetCharges,YrlyComparNP=UPD.NetPayments,YrlyComparNA=UPD.NetAdj,YrlyComparAR=UPD.AccountsReceivable,  
YrlyComparAR120=UPD.AR120,YrlyComparARDay=UPD.ARDays  
FROM (SELECT AA.Client,AA.ReportYear,AA.ReportMonth,AA.ProviderName,  
BB.NetCharges,BB.NetPayments,BB.NetAdj,BB.AccountsReceivable,BB.AR120,BB.ARDays  
FROM #TempTblAllCharge01 aa  
INNER JOIN #TempTblYearCompare BB ON AA.ReportYear = BB.ReportYear AND   
AA.ReportMonth = BB.ReportMonth AND AA.Client = BB.Client AND AA.ProviderName=BB.ProviderName)UPD  
INNER JOIN #TempTblAllCharge01 RPT ON UPD.ReportYear = RPT.ReportYear AND   
UPD.ReportMonth = RPT.ReportMonth AND UPD.Client = RPT.Client AND UPD.ProviderName=RPT.ProviderName  
  
SELECT Client,ReportYear,ReportMonth,ProviderName,NetCharges,NetPayments,NetAdj,AccountsReceivable,AR120,ARDays,  
YrlyComparNC,YrlyComparNP,YrlyComparNA,YrlyComparAR,YrlyComparAR120,YrlyComparARDay   
FROM #TempTblAllCharge01 where ReportYear = @ReportYear  
  
IF OBJECT_ID('tempdb..#TempTblAllCharge01') IS NOT NULL DROP TABLE #TempTblAllCharge01  
IF OBJECT_ID('tempdb..#TempTblAllChargePro') IS NOT NULL DROP TABLE #TempTblAllChargePro  
IF OBJECT_ID('tempdb..#TempTblAllChargePro01') IS NOT NULL DROP TABLE #TempTblAllChargePro01  
IF OBJECT_ID('tempdb..#TempTblYearCompare') IS NOT NULL DROP TABLE #TempTblYearCompare  
  
end
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg2to12biswa]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[PPMReport_Pg2to12biswa]  
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))  AS  BEGIN 
 --DECLARE @Client VARCHAR(100)='The Childrens Clinic'   
 --DECLARE @ReportYear varchar(max) = '2017,2018'    
 IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear  
 CREATE TABLE #TempTblYear(ReportYear INT)  INSERT INTO #TempTblYear  
 SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')    
 SELECT CL.Client,RF.ReportYear,PM.ReportMonth,RF.ShortName,Charges,Refunds,Payments,Adjustments,AccountsReceivable, 
  AROver120,ARDaysOutstanding,YrlyCharges,YrlyPayments,YrlyAdjustments,YrlyAccountsReceivable, 
   YrlyAROver120,YrlyARDaysOutstanding FROM PPMReport_Rollforward(NOLOCK)RF  
   LEFT JOIN PPMReport_Rollforward_YrlyCompare(NOLOCK)YRF ON YRF.ShortName= RF.ShortName AND 
    YRF.ClientID= RF.ClientID AND YRF.ReportYear = RF.ReportYear AND YRF.ReportMonth = RF.ReportMonth  
    INNER JOIN PPMReport_ClientList(NOLOCK)CL ON RF.ClientID= CL.ID  INNER JOIN PPM_Month(NOLOCK)PM 
    ON pm.ID=RF.ReportMonth  WHERE RF.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) 
    WHERE Client=@Client)  AND RF.ReportYear IN (SELECT ReportYear from #TempTblYear) 
    ORDER BY ShortName,RF.ReportYear,RF.ReportMonth ASC  IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear  END
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg47to48]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_Pg47to48]      
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))      
AS      
BEGIN      
/*    
DECLARE @Client VARCHAR(100)='CHCL'       
DECLARE @ReportYear varchar(max) = '2017,2018'        
*/    
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
CREATE TABLE #TempTblYear(ReportYear INT)      
INSERT INTO #TempTblYear      
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')      
      
SELECT CL.ClientAcronym,CL.ClientFullName Client,ReportYear,PM.ReportMonth,ShortName,ATBCategory [Description],[0-30],[31-60],      
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance      
FROM PPMReport_AgingComparison(Nolock)FD      
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID      
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth      
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)      
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear)       
AND ReportName ='Aging-01' ORDER BY ShortName,FD.ReportYear,FD.ReportMonth ASC      
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg49to59]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_Pg49to59]        
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))        
AS        
BEGIN       
/*       
DECLARE @Client VARCHAR(100)='AVCMD'           
DECLARE @ReportYear varchar(max) = '2019'          
  */   
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear
IF OBJECT_ID('tempdb..#TempTblAG') IS NOT NULL DROP TABLE #TempTblAG        
CREATE TABLE #TempTblYear(ReportYear INT)        
INSERT INTO #TempTblYear        
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')        
        
SELECT CL.ClientAcronym,CL.ClientFullName Client,ReportYear,PM.ReportMonth,ShortName,ATBCategory,TotalPercent,Over90Days,[0-30],[31-60],        
[61-90],[91-120],[121-150],[151-180],[181+],CategoryBalance        
INTO #TempTblAG FROM PPMReport_AgingComparison(Nolock)FD        
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID        
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth        
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)        
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear)        
AND ReportName ='Aging-02' ORDER BY ShortName,FD.ReportYear,FD.ReportMonth ASC

UPDATE #TempTblAG SET ShortName = 'All Provider'
WHERE ShortName = 'Summary'

SELECT * FROM #TempTblAG
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear
IF OBJECT_ID('tempdb..#TempTblAG') IS NOT NULL DROP TABLE #TempTblAG        
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg60to79]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_Pg60to79]      
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))      
AS      
BEGIN      
/*    
DECLARE @Client VARCHAR(100) = 'CHCL'     
DECLARE @ReportYear varchar(max) = '2017,2018'        
*/    
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
CREATE TABLE #TempTblYear(ReportYear INT)      
INSERT INTO #TempTblYear      
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')      
      
SELECT CL.ClientAcronym,CL.ClientFullName Client,ReportYear,PM.ReportMonth,ShortName,CPTGroupDesc,CPT,CPTDescription,UNITS      
FROM PPMReport_ProcedureCount(Nolock)FD      
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON FD.ClientID= CL.ID      
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=FD.ReportMonth      
WHERE FD.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)      
AND FD.ReportYear IN (SELECT ReportYear from #TempTblYear) ORDER BY ShortName,FD.ReportYear,FD.ReportMonth ASC      
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg90to101]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_Pg90to101]      
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))      
AS      
BEGIN      
/*    
DECLARE @Client VARCHAR(100)= 'AVCMD'    
DECLARE @ReportYear varchar(max) = '2019,2020'        
*/
DECLARE @ClientID INT
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
CREATE TABLE #TempTblYear(ReportYear INT)      
 
INSERT INTO #TempTblYear      
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')

SET @ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)

IF OBJECT_ID('tempdb..#TempTblwRVUList') IS NOT NULL DROP TABLE #TempTblwRVUList
SELECT WR.ReportYear,WR.CPTCode,WR.Modifier,WR.CPTDescription
,WR.wRVU,WR.ClientID,WR.IsActive INTO #TempTblwRVUList
FROM PPMReport_wRVUList(NOLOCK)WR
INNER JOIN #TempTblYear YR ON WR.ReportYear = YR.ReportYear
WHERE IsActive = 1 AND ClientID = 0

if EXISTS(SELECT TOP 1 ID FROM PPMReport_wRVUList(NOLOCK)WR
		INNER JOIN #TempTblYear YR ON WR.ReportYear = YR.ReportYear
		WHERE WR.IsActive = 1 AND WR.ClientID = @ClientID)
BEGIN	
	MERGE #TempTblwRVUList TMP
	USING (SELECT WRv.ReportYear,WRv.CPTCode,WRv.Modifier,WRv.CPTDescription
			,WRv.wRVU,WRv.ClientID,WRv.IsActive 
			FROM PPMReport_wRVUList(NOLOCK)WRv
			INNER JOIN #TempTblYear YR ON WRv.ReportYear = YR.ReportYear
			WHERE IsActive = 1 and wrv.ClientID = @ClientID)WR
	ON (TMP.CPTCode = WR.CPTCode AND ISNULL(TMP.Modifier,'') = ISNULL(WR.Modifier,'')
	AND TMP.ReportYear = WR.ReportYear AND WR.ClientID = @ClientID)	
	WHEN MATCHED THEN
		UPDATE SET TMP.CPTDescription = WR.CPTDescription, TMP.wRVU = WR.wRVU
	WHEN NOT MATCHED BY TARGET AND WR.ReportYear IN (SELECT ReportYear FROM #TempTblYear)
	  AND WR.ClientID != 0  AND WR.IsActive = 1 THEN
		INSERT(ReportYear,CPTCode,Modifier,CPTDescription,wRVU,ClientID,IsActive)
		VALUES(WR.ReportYear,WR.CPTCode,WR.Modifier,WR.CPTDescription,WR.wRVU,WR.ClientID,WR.IsActive)
	;
END  
 
SELECT CL.ClientAcronym,CL.ClientFullName Client,CP.ReportYear,PM.ReportMonth
,ShortName,CPT,CP.CPTDescription,rv.wRVU,cp.Units,rv.wRVU*cp.Units wRVUTotal      
FROM PPMReport_ProcedureCount(NOLOCK)CP      
LEFT JOIN #TempTblwRVUList(NOLOCK)RV 
ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL       
INNER JOIN PPMReport_ClientList(NOLOCK)CL 
ON Cp.ClientID= CL.ID      
INNER JOIN PPM_Month(NOLOCK)PM 
ON pm.ID=cp.ReportMonth 
INNER JOIN #TempTblYear tyr 
ON cp.ReportYear = tyr.ReportYear     
WHERE Cp.ClientID = @ClientID /*AND CP.ReportYear IN (SELECT ReportYear from #TempTblYear)*/
GROUP BY CL.ClientAcronym,CL.ClientFullName,CP.ReportYear,PM.ReportMonth,ShortName
,CPT,CP.CPTDescription,Units,rv.wRVU      
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear      
IF OBJECT_ID('tempdb..#TempTblwRVUList') IS NOT NULL DROP TABLE #TempTblwRVUList
END 
GO
/****** Object:  StoredProcedure [dbo].[PPMReport_Pg90to101_04sep20]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_Pg90to101_04sep20]        
(@Client VARCHAR(100),@ReportYear VARCHAR(MAX))        
AS        
BEGIN        
  /*      
DECLARE @Client VARCHAR(100)= 'CHCL'      
DECLARE @ReportYear varchar(max) = '2017,2018'          
 */  
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear        
CREATE TABLE #TempTblYear(ReportYear INT)        
        
INSERT INTO #TempTblYear        
SELECT CONVERT(INT,items)ReportYear FROM PPMReport_SplitStringfn(@ReportYear,',')    
      
SELECT CL.ClientAcronym,CL.ClientFullName Client,CP.ReportYear,PM.ReportMonth,ShortName,CPT,CP.CPTDescription,rv.wRVU,cp.Units,rv.wRVU*cp.Units wRVUTotal        
FROM PPMReport_ProcedureCount(NOLOCK)CP        
LEFT JOIN PPMReport_wRVUList(NOLOCK)RV ON rv.CPTCode=cp.CPT AND rv.ReportYear=CP.ReportYear AND RV.Modifier IS NULL         
INNER JOIN PPMReport_ClientList(NOLOCK)CL ON Cp.ClientID= CL.ID        
INNER JOIN PPM_Month(NOLOCK)PM ON pm.ID=cp.ReportMonth        
WHERE Cp.ClientID = (SELECT TOP 1 ID FROM PPMReport_ClientList(NOLOCK) WHERE ClientAcronym = @Client)         
AND CP.ReportYear IN (SELECT ReportYear from #TempTblYear)        
GROUP BY CL.ClientAcronym,CL.ClientFullName,CP.ReportYear,PM.ReportMonth,ShortName,CPT,CP.CPTDescription,Units,rv.wRVU        
IF OBJECT_ID('tempdb..#TempTblYear') IS NOT NULL DROP TABLE #TempTblYear        
END 

GO
/****** Object:  StoredProcedure [dbo].[PPMReport_UploadCodingCurve]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PPMReport_UploadCodingCurve]
(
	@CreatedBy VARCHAR(150),
	@Data PPMReport_CodingCurveXL READONLY	
)
AS
DECLARE @Result VARCHAR(MAX)
BEGIN
	BEGIN TRY           
		BEGIN TRANSACTION
		IF OBJECT_ID('tempdb..#TmbTblCodingCurve') IS NOT NULL DROP TABLE #TmbTblCodingCurve
		SELECT * INTO #TmbTblCodingCurve FROM @Data

		INSERT INTO PPMReport_CodingCurveList(ClientID,ReportYear,CPTCode,Fee,NationalDist,TableName,CreatedBy)
		SELECT cl.ID, TMP.ReportYear,TMP.CPTCode,TMP.Fee,TMP.NationalDist,TMP.TableName,@CreatedBy
		FROM #TmbTblCodingCurve TMP
		INNER JOIN PPMReport_ClientList(NOLOCK)CL
		ON TMP.ClientName = cl.Client

		INSERT INTO PPMReport_UploadInfo(RunAt,Project,ClientID,ReportYear,ReportMonth,AppStatus,ReportStatus,Remarks,ErrorLog,CreatedBy)
		VALUES(GETDATE(),0,0,0,0,'Upload',null,'UploadCodingCurveXL','Success',@CreatedBy)

		COMMIT TRANSACTION
		SET @Result = 'Success'  
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
	SET @Result = ERROR_MESSAGE()
	INSERT INTO PPMReport_UploadInfo(RunAt,Project,ClientID,ReportYear,ReportMonth,AppStatus,ReportStatus,Remarks,ErrorLog,CreatedBy)
	VALUES(GETDATE(),0,0,0,0,'DBError',null,'UploadCodingCurveXL',@Result,@CreatedBy)	  
END CATCH	
	IF OBJECT_ID('tempdb..#TmbTblCodingCurve') IS NOT NULL DROP TABLE #TmbTblCodingCurve
	SELECT @Result AS Result
END
GO
/****** Object:  StoredProcedure [dbo].[Selectyear]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Selectyear] @Year int
AS
SELECT distinct ReportYear FROM dbo.PPM_Report_Monthly_Prov_ChargePaymentAdjvsNet(NOLOCK) where ReportYear=@Year
GO
/****** Object:  StoredProcedure [dbo].[Selectyearall]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Selectyearall] @Year int
AS
SELECT * FROM dbo.PPM_Report_Monthly_Prov_ChargePaymentAdjvsNet(NOLOCK) where ReportYear=@Year
GO
/****** Object:  StoredProcedure [dbo].[trail]    Script Date: 9/10/2020 2:53:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[trail] @clients nvarchar(30)
AS 
SELECT Client,ReportYear,ReportMonth,ProviderName,GrossCharges,VoidedCharges,NetCharges,GrossPayments,VoidedPayments,GrossPmtsafterVoids,
Refunds,ToFromUnapplied,NetPayments,ContractualAdj,OtherAdj,BadDebt,NetAdj 
FROM PPM_Report_Monthly_Prov_ChargePaymentAdjvsNet(NOLOCK) where Client=@clients
GO
