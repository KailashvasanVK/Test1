USE [EchoLock]
GO
/****** Object:  Schema [DBAEvnt]    Script Date: 8/30/2020 7:29:05 PM ******/
CREATE SCHEMA [DBAEvnt]
GO
/****** Object:  UserDefinedTableType [dbo].[ApayaaType]    Script Date: 8/30/2020 7:29:05 PM ******/
CREATE TYPE [dbo].[ApayaaType] AS TABLE(
	[Unique Id] [varchar](max) NULL,
	[Username] [varchar](250) NULL,
	[Notes] [varchar](max) NULL,
	[Source] [varchar](250) NULL,
	[Destination] [varchar](250) NULL,
	[Call Type] [varchar](100) NULL,
	[System Disposition] [varchar](250) NULL,
	[User Disposition] [varchar](250) NULL,
	[Hangup Code] [int] NULL,
	[Hangup First] [varchar](100) NULL,
	[Call Start Time] [datetime] NULL,
	[Call Answer Time] [varchar](100) NULL,
	[Call End Time] [datetime] NULL,
	[Talk Time (seconds)] [int] NULL,
	[Recording Url] [varchar](max) NULL,
	[Is Deleted] [varchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[AssetData]    Script Date: 8/30/2020 7:29:05 PM ******/
CREATE TYPE [dbo].[AssetData] AS TABLE(
	[HostName] [varchar](150) NULL,
	[AssetID] [varchar](150) NULL,
	[ServiceID] [varchar](300) NULL,
	[Facility] [varchar](100) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[C3_FileWatcherType]    Script Date: 8/30/2020 7:29:06 PM ******/
CREATE TYPE [dbo].[C3_FileWatcherType] AS TABLE(
	[FullPath] [varchar](1000) NOT NULL,
	[FileName] [varchar](350) NULL,
	[FileSize] [bigint] NULL,
	[FileCreatedAt] [datetime] NULL,
	[OldName] [varchar](250) NULL,
	[ChangeType] [varchar](100) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[EventLogType]    Script Date: 8/30/2020 7:29:06 PM ******/
CREATE TYPE [dbo].[EventLogType] AS TABLE(
	[UserAccount] [varchar](150) NOT NULL,
	[ComputerName] [varchar](150) NOT NULL,
	[EventUserName] [varchar](150) NULL,
	[EventMachine] [varchar](150) NULL,
	[InstanceID] [bigint] NULL,
	[EventID] [int] NULL,
	[EventDate] [varchar](50) NULL,
	[EventTime] [varchar](50) NULL,
	[EventMessage] [varchar](max) NULL,
	[EventSource] [varchar](300) NULL,
	[TimeGenerated] [datetime] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[KruptoconnectType]    Script Date: 8/30/2020 7:29:07 PM ******/
CREATE TYPE [dbo].[KruptoconnectType] AS TABLE(
	[UUID] [varchar](max) NULL,
	[CAMPAIGN] [varchar](50) NULL,
	[SOURCE] [varchar](250) NULL,
	[DESTINATION] [varchar](100) NULL,
	[FINAL DESTINATION] [varchar](100) NULL,
	[CALL TYPE] [varchar](100) NULL,
	[DESTINATION TYPE] [varchar](100) NULL,
	[CALL STATUS] [varchar](100) NULL,
	[CALL START TIME] [datetime] NULL,
	[CALL RINGING TIME] [datetime] NULL,
	[CALL ANSWERED TIME] [datetime] NULL,
	[CALL END TIME] [datetime] NULL,
	[TOTAL TIME] [varchar](50) NULL,
	[RINGING TIME] [varchar](50) NULL,
	[TALK TIME] [varchar](50) NULL,
	[TOTAL HOLD TIME] [varchar](50) NULL,
	[POST DIAL DELAY] [varchar](50) NULL,
	[HANGUP CAUSE] [varchar](100) NULL,
	[HANGUP CAUSE CODE] [int] NULL,
	[HANGUP FIRST] [varchar](100) NULL,
	[QUEUE ANSWERED STATUS] [varchar](100) NULL,
	[QUEUE START TIME] [varchar](100) NULL,
	[QUEUE ANSWER TIME] [varchar](100) NULL,
	[QUEUE CANCEL TIME] [varchar](100) NULL,
	[QUEUE END TIME] [varchar](100) NULL,
	[DISPOSITION] [varchar](100) NULL,
	[DISPOSITION TIME] [varchar](100) NULL,
	[NOTES] [varchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TataType]    Script Date: 8/30/2020 7:29:08 PM ******/
CREATE TYPE [dbo].[TataType] AS TABLE(
	[GroupByParameter] [varchar](max) NULL,
	[Call_ID] [varchar](max) NULL,
	[CallerANI] [varchar](250) NULL,
	[CallerID] [varchar](250) NULL,
	[ArrivalTime] [datetime] NULL,
	[Direction] [varchar](50) NULL,
	[Outcome] [varchar](50) NULL,
	[Duration] [varchar](100) NULL,
	[TalkTime] [varchar](100) NULL,
	[Transfer] [int] NULL,
	[Holds] [int] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertUTCtoIST]    Script Date: 8/30/2020 7:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE FUNCTION [dbo].[ConvertUTCtoIST]
(@UTCTime DATETIME)  
RETURNS DATETIME  
AS  
BEGIN  
  SET @UTCTime = DATEADD(MI, 330, @UTCTime)  
  --SET @UTCTime = DATEADD(MI,DATEDIFF(MI, SYSUTCDATETIME(),SYSDATETIME()),@UTCTime)
  RETURN @UTCTime  
END  
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertUTCtoPST]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  
CREATE FUNCTION [dbo].[ConvertUTCtoPST]
(@UTCTime DATETIME)  
RETURNS DATETIME  
AS  
BEGIN  
  SET @UTCTime = DATEADD(MI, 480, @UTCTime)  
  --SET @UTCTime = DATEADD(MI,DATEDIFF(MI, SYSUTCDATETIME(),SYSDATETIME()),@UTCTime)
  RETURN @UTCTime  
END  
GO
/****** Object:  UserDefinedFunction [dbo].[SplitStringfn]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitStringfn](@String varchar(MAX), @Delimiter char(1))  
returns @temptable TABLE (items varchar(MAX))           
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
END;
GO
/****** Object:  UserDefinedFunction [dbo].[StringSplit]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[StringSplit]
(
    @String  VARCHAR(MAX), @Separator CHAR(1), @rID INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN 

declare @RESULT TABLE(id int, Value VARCHAR(MAX))
--declare @String  VARCHAR(MAX) = 'Outbound_20200622-123940_+18886323862_Automatic_1161593695020.mp3'
--declare @Separator CHAR(1) = '_'
declare @ID int = 0, @Output VARCHAR(MAX)
    
 DECLARE @SeparatorPosition INT = CHARINDEX(@Separator, @String ),
        @Value VARCHAR(MAX), @StartPosition INT = 1
 
 IF @SeparatorPosition = 0  
  BEGIN
   --INSERT INTO @RESULT VALUES(@SeparatorPosition,@String)   
   RETURN @String
  END
     
 SET @String = @String + @Separator
 WHILE @SeparatorPosition > 0
  BEGIN
  set @ID = @ID + 1
   SET @Value = SUBSTRING(@String , @StartPosition, @SeparatorPosition- @StartPosition)
 
   IF( @Value <> ''  ) 
    INSERT INTO @RESULT VALUES(@ID,@Value)
   
   SET @StartPosition = @SeparatorPosition + 1
   SET @SeparatorPosition = CHARINDEX(@Separator, @String , @StartPosition)
  END    
     set @Output =  (select top 1 Value from @RESULT where id = @rID)
 
 RETURN @Output
END
GO
/****** Object:  UserDefinedFunction [dbo].[ValidateDateTime]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ValidateDateTime](@String VARCHAR(MAX) )
RETURNS VARCHAR(200)
AS
BEGIN
	
	DECLARE @RESULT1 VARCHAR(200)
	DECLARE @RESULT VARCHAR(200)
	
	 EXEC ValidateStringDateTime @String, @RESULT1 = @RESULT OUTPUT
	--set @RESULT1 = 	@RESULT
	--SET @dtString =  REPLACE(REPLACE(REPLACE(@string,'The previous system shutdown at ',''),' was unexpected.',''),'?','')
	--SET @RESULT =  CONVERT(VARCHAR,CONVERT(VARCHAR,CONVERT(DATE,RIGHT(@dtString,CHARINDEX(' ',@dtString)))) 
	--	+ ' ' + CONVERT(VARCHAR,CONVERT(TIME,LEFT(@dtString,CHARINDEX(' on',@dtString)))),121)	
	 RETURN @RESULT1
END
GO
/****** Object:  UserDefinedFunction [dbo].[WeekDaysOffFn]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[WeekDaysOffFn](@String varchar(MAX), @Delimiter varchar(1))
returns varchar(MAX)
AS           
BEGIN
	declare @daystable table (dayid int, dayname varchar(15))
	declare @temptable table (items varchar(15))
    declare @idx int           
    declare @slice varchar(MAX)
	declare @output varchar(max) = ''
    select @idx = 1           
        if len(@String)<1 or @String is null  return @output
		       
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

	insert into @daystable values (0, 'Sunday')
	insert into @daystable values (1, 'Monday')
	insert into @daystable values (2, 'Tuesday')
	insert into @daystable values (3, 'Wednesday')
	insert into @daystable values (4, 'Thursday')
	insert into @daystable values (5, 'Friday')
	insert into @daystable values (6, 'Saturday')

	select @output = case when @output ='' then cast(dayid as varchar(1)) else @output +  coalesce(',' + cast(dayid as varchar(1)), '') end from @daystable
		where dayname not in (select Items from @temptable)

RETURN @output
    
END; 
GO
/****** Object:  UserDefinedFunction [dbo].[WFHAppSettings]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[WFHAppSettings](@UserAccount varchar(50), @ComputerName varchar(100),
	@ClientAddress varchar(100))
returns bit
AS           
BEGIN

	declare @output varchar(max)

	if exists (SELECT DISTINCT ud.NTLoginName,ud.Client,ud.Team,a.ComputerName,a.ClientAddress,UD.Band,UAS.AppWatcher
		FROM (
			SELECT @UserAccount UserAccount,@ComputerName ComputerName, @ClientAddress ClientAddress,
					WFH = ARC_Enterprise_Aug2019.dbo.GetOfficeNetowrk_WFH(@ClientAddress)
				--FROM EchoLock.dbo.LockEvents (NOLOCK)
				--WHERE 
				--	--EventTime > = '2020-05-18 02:30:00.0000000' and 
				--	UserAccount = @UserAccount
				--GROUP BY  UserAccount,ComputerName, ClientAddress
			) A
		INNER JOIN EchoLock.dbo.UserDetails(NOLOCK)UD
			ON a.UserAccount = ud.NTLoginName
		LEFT JOIN EchoLock.dbo.UserAppSettings(NOLOCK)UAS
			ON ud.UserId = UAS.UserId
		WHERE (isnull(UAS.AppWatcher, 0) <> 1)
			and a.WFH = 1
			AND ud.NTLoginName NOT IN ('ahsadmin','ahswfh','system')
			and ud.Band < 3
		)
	begin
		RETURN 1
	end

	RETURN 0
		    
END;
GO
/****** Object:  UserDefinedFunction [dbo].[EcholockDailyAppData_Fn]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[EcholockDailyAppData_Fn]
( @UsageDate DATE)
RETURNS TABLE 
AS
RETURN
(
	SELECT
	AP.UsageDate,ud.ARCUserId,ap.AppId,
	CASE WHEN LA.AppName IS NULL THEN LEFT(LA.BaseUrl,25000)  ELSE LA.AppName END AS AppURL,
	CASE WHEN LA.AppName IS NULL THEN 'URL' ELSE 'APP' END AS [TYPE],
	CASE WHEN AP.Classification = 1  THEN 'Productive' 
		ELSE CASE WHEN AP.Classification = 2  THEN 'NonProductive' ELSE 
		'Unclassified' END END AS Classification,
	LAC.CategoryName,
	CASE WHEN la.AliasName IS NOT NULL THEN  la.AliasName  
		ELSE CASE WHEN LA.AppName IS NULL THEN LEFT(LA.BaseUrl,25000)
		ELSE LA.AppName END END AS DisplayName,
	AP.TimeSpentms
	FROM EchoLock.dbo.DailyAppUsage(NOLOCK)AP
	INNER JOIN EchoLock.dbo.UserDetails(NOLOCK)UD 
	ON ud.UserId = ap.UserId
	LEFT JOIN EchoLock.dbo.LookupAppCategories(NOLOCK)LAC
	ON LAC.Id = AP.Category
	INNER JOIN EchoLock.dbo.LookupApps(NOLOCK)LA 
	ON LA.Id = AP.AppId
	WHERE LA.IsActive = 1 AND AP.UsageDate = @UsageDate
)
GO
/****** Object:  UserDefinedFunction [dbo].[FnAppUsageDrillDownData]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Promodh.Kumar
-- Create date: 02/12/2019
-- Description:	DailyAppUsage - Drilldown Grid Data
-- =============================================
CREATE FUNCTION [dbo].[FnAppUsageDrillDownData]
()
RETURNS TABLE 
AS
RETURN 
(
	select app.Id, app.UserId, c.NTLoginName, app.UsageDate, app.AppId, app.Classification, app.Category, 
			case when lapp.AliasName is not null then lapp.AliasName else case when lapp.AppName is not null then AppName else lapp.BaseURL end end AppName,
			cat.CategoryName,
			app.TimeSpentms
		from Echolock.dbo.DailyAppUsage app
		(nolock)
		inner join Echolock.dbo.LookupApps lapp
		(nolock)
			on app.AppId = lapp.Id
		inner join Echolock.dbo.LookupAppCategories cat
		(nolock)
			on app.Category = cat.Id
		inner join Echolock.dbo.UserDetails c
		(nolock)
			on app.UserId = c.UserId
		where app.AppId not in (14, 16)
)
GO
/****** Object:  UserDefinedFunction [dbo].[fnAppWatcherSecurityURLCheck]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnAppWatcherSecurityURLCheck]
(	
	@CompanyId int,
	@StartDate datetime,
	@EndDate datetime,
	@currentURL varchar(1000)
)
RETURNS TABLE 
AS
RETURN 
(
	select Id,BaseUrl
		from [dbo].AppWatcher
		(nolock)
		where StartTime >= @StartDate
			and EndTime <= @EndDate
			and UserId in 
				(select UserId
					from [dbo].UserDetails
					(nolock)
					where CompanyId = @CompanyId)
			and contains (BaseUrl , @currentURL)
)
GO
/****** Object:  UserDefinedFunction [dbo].[FnDailyAppFactData]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FnDailyAppFactData]
( @UsageDate DATE)
RETURNS TABLE 
AS
RETURN
(
       SELECT
       AP.UsageDate,ud.ARCUserId,ap.AppId,
       CASE WHEN LA.AppName IS NULL THEN LEFT(LA.BaseUrl,200)  ELSE LEFT(LA.AppName, 200) END AS AppURL,
       CASE WHEN LA.AppName IS NULL THEN 'URL' ELSE 'APP' END AS [TYPE],
       CASE WHEN AP.Classification = 1  THEN 'Productive' 
              ELSE CASE WHEN AP.Classification = 2  THEN 'NonProductive' ELSE 
              'Unclassified' END END AS Classification,
       LAC.CategoryName,
       CASE WHEN la.AliasName IS NOT NULL THEN  LEFT(la.AliasName, 200)
              ELSE CASE WHEN LA.AppName IS NULL THEN LEFT(LA.BaseUrl,200)
              ELSE LEFT(LA.AppName,200) END END AS DisplayName,
       AP.TimeSpentms
       FROM EchoLock.dbo.DailyAppUsage(NOLOCK)AP
       INNER JOIN EchoLock.dbo.UserDetails(NOLOCK)UD 
       ON ud.UserId = ap.UserId
       LEFT JOIN EchoLock.dbo.LookupAppCategories(NOLOCK)LAC
       ON LAC.Id = AP.Category
       INNER JOIN EchoLock.dbo.LookupApps(NOLOCK)LA 
       ON LA.Id = AP.AppId
       WHERE LA.IsActive = 1 AND AP.UsageDate = @UsageDate
)
GO
/****** Object:  UserDefinedFunction [dbo].[FnEcholockDashboardData]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Promodh.Kumar
-- Create date: 01/11/2019
-- Description:	DashboardData with ARC Attendance
-- =============================================
CREATE FUNCTION [dbo].[FnEcholockDashboardData]
(	
	-- Add the parameters for the function here
	@CompanyId int,
    @UserId nvarchar(128), -- will be null, if for manager
    @ManagerId nvarchar(128), -- will be null, if for individual user
    @IncludeIndirect bit, -- whether to include indirect reports or not
    @FromDate datetime,
	@ToDate datetime
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select distinct a.Id, a.EventDate, a.UserId, a.TotalHours, a.WorkHours, a.LockHours, a.ProdHrs, a.NonProdHrs, a.UnClassifiedHrs,
			a.DayTotalHours, a.DayLockHours, a.DayProdHrs, a.DayNonProdHrs, a.DayUnClassifiedHrs,
			a.IsWorkingDay, a.IsLate, a.IsAdvanceOut, a.ManagerL1, a.Role, a.Team, a.Client, a.Location, a.LOB, a.Band,
			a.Grade, a.Shift, a.TimeZone, a.AppWatcherEnabled, --a.CallHours, a.IsCallHoursUser, a.LateInHours, a.AdvanceOutHours, a.IsWeekend,
			a.Present Present, a.IsDeclaredOff DeclaredOff, cast(0 as int) ApprovedLeave, a.CostCode, a.Process, a.[Group], a.SubGroup,
			a.SubFunctionality, a.Project, a.FunctionalityGroup, isnull(wfhu.IsWFH, 0) IsWFHUser, isnull(wfhd.IsWFH, 0) IsWFHDay
			--, sft.ShiftName
		from Echolock.dbo.DailyDashboardData a
		(nolock)
		inner join (select distinct UserId, EventDate
		from UserHierarchyHistory
		(nolock)
		where EventDate >= @FromDate
			and EventDate <= @ToDate
			and 1 = (case when @UserId is not null and UserId = @UserId then 1
					when @UserId is null then 1 else 0 end)
			and 1 = (case when @ManagerId is null then 1
					when @ManagerId is not null and @IncludeIndirect = 0
						and ML1 = @ManagerId
					then 1
					when @ManagerId is not null and @ManagerId in ('48D70EF0-9454-43F7-942B-4D6FDD0E94A0')
						and @IncludeIndirect = 1
						then (
							case when ML1 = '78634B37-9C8B-490E-AAF8-5B2F7F5E514F'
								or ML2 = '78634B37-9C8B-490E-AAF8-5B2F7F5E514F'
								or ML3 = '78634B37-9C8B-490E-AAF8-5B2F7F5E514F'
								or ML4 = '78634B37-9C8B-490E-AAF8-5B2F7F5E514F'
								or ML5 = '78634B37-9C8B-490E-AAF8-5B2F7F5E514F'
								or ML6 = '78634B37-9C8B-490E-AAF8-5B2F7F5E514F'
								or ML7 = '78634B37-9C8B-490E-AAF8-5B2F7F5E514F'
								or ML8 = '78634B37-9C8B-490E-AAF8-5B2F7F5E514F'
								or ML9 = '78634B37-9C8B-490E-AAF8-5B2F7F5E514F'
								or ML10 = '78634B37-9C8B-490E-AAF8-5B2F7F5E514F'
							then 0
							else 1 end
						)
					when @ManagerId is not null and @IncludeIndirect = 1
							and (ML1 = @ManagerId or ML2 = @ManagerId
							or ML3 = @ManagerId or ML4 = @ManagerId
							or ML5 = @ManagerId or ML6 = @ManagerId
							or ML7 = @ManagerId or ML8 = @ManagerId
							or ML9 = @ManagerId or ML10 = @ManagerId)
						then 1
					else 0 end
			)) b
			on a.UserId = b.UserId and a.EventDate = b.EventDate
		left join Echolock.dbo.WFHUsers wfhu
		(nolock)
			on wfhu.UserId = a.UserId --and wfhu.EventDate >= @FromDate and wfhu.EventDate <= @ToDate
		left join Echolock.dbo.WFHUsers wfhd
		(nolock)
			on wfhd.UserId = a.UserId and wfhd.EventDate = a.EventDate
		--inner join LookupShift sft
		--(nolock)
		--	on a.[Shift] = sft.Id
		--inner join Echolock.dbo.UserDetails c
		--(nolock)
		--	on a.UserId = c.UserId
		where a.WorkHours > 0
			--and (b.ManagerLevel = case when @IncludeIndirect = 0 and @ManagerId is not null then 0 else b.ManagerLevel end)
			--and c.CompanyId = @CompanyId
			and 1 = (case when @ManagerId in ('48D70EF0-9454-43F7-942B-4D6FDD0E94A0','9BEAC35D-37D4-471A-885E-8E4DF3BD5EE4','0F5444DF-00BB-48E6-ADFE-78362A27F352')
				and (a.LOB in ('Support', 'IT Services', null)
					or Team = 'Operations- Training') then 0
				else 1 end)
)
GO
/****** Object:  View [dbo].[ViewAppWatcher]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewAppWatcher]
AS
SELECT        Id, UserId, UserAccount, UserDomain, ComputerName, AppName, WindowTitle, BrowserUrl, StartTime, EndTime, TimeSpent, VersionId, CreatedOn, OperatingSystem, BaseUrl, TimeSpentms
FROM            dbo.AppWatcher
GO
/****** Object:  View [dbo].[ViewARCAttendance]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[ViewARCAttendance]
AS
	--SELECT distinct b.UserId, a.NT_UserName UserAccount, dateadd(month, 4, a.[Date]) EventDate, a.P_days Present, a.IsDeclaredOff DeclaredOff, 0 ApprovedLeave
	--	from ARC_Enterprise_Aug2019.dbo.ARC_REC_Attendance a
	--	(nolock)
	--	inner join Echolock.dbo.UserDetails b
	--	(nolock)
	--		on a.NT_UserName = b.NTLoginName

	select distinct a.UserId, b.NTLoginName UserAccount, a.EventDate, cast(1 as decimal) Present, cast(0 as bit) DeclaredOff, 0 ApprovedLeave
		from DailyDashboardData a
		(nolock)
		inner join UserDetails b
		(nolock)
			on a.UserId = b.UserId

GO
/****** Object:  View [dbo].[ViewBreakSplitConsolidated]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ViewBreakSplitConsolidated]
AS
select UserId, EventDate, BreakReason, SUM(TimeSpent) TimeSpent
FROM            dbo.DailyBreakSplitUp
group by EventDate, UserId, BreakReason
GO
/****** Object:  View [dbo].[ViewUserDetails]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ViewUserDetails]    
AS    
	SELECT a.*, b.UserIdentity PacificNTLoginName
		from Echolock.dbo.UserDetails a
		(nolock)
		left join ARC_Enterprise.dbo.ARC_REC_UserAuthentication b
		(nolock)
			on a.ARCUserId = b.UserId
GO
/****** Object:  View [dbo].[ViewUserPackageMapping]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[ViewUserPackageMapping] as

     select a.NTLoginName, a.UserId
		,max(CASE WHEN uh.managerlevel = 0 THEN uh.managerUserId END) AS ManagerLevel_0
		,max(CASE WHEN uh.managerlevel = 1 THEN uh.managerUserId END) AS ManagerLevel_1
		,max(CASE WHEN uh.managerlevel = 2 THEN uh.managerUserId END) AS ManagerLevel_2
		,max(CASE WHEN uh.managerlevel = 3 THEN uh.managerUserId END) AS ManagerLevel_3
		,case
		when b.userid is null then  1 else b.PackageId end as PackageId  
		 from UserDetails a
		left join AppPackageMapping b on b.userid = a.UserId 
		left join UserHierarchy uh on uh.NTLoginName = a.NTLoginName 
		group by a.NTLoginName, b.userid,b.PackageId,a.UserId
		
GO
/****** Object:  View [dbo].[ViewUserPackageMapping1]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[ViewUserPackageMapping1] as

     select a.NTLoginName, a.UserId
		,max(CASE WHEN uh.managerlevel = 0 THEN uh.managerUserId END) AS ManagerLevel_0
		,max(CASE WHEN uh.managerlevel = 1 THEN uh.managerUserId END) AS ManagerLevel_1
		,max(CASE WHEN uh.managerlevel = 2 THEN uh.managerUserId END) AS ManagerLevel_2
		,max(CASE WHEN uh.managerlevel = 3 THEN uh.managerUserId END) AS ManagerLevel_3
		,case
		when b.userid is null then  1 else b.PackageId end as PackageId,
		case when b.userid is null then  1 else apc.Classification end as Classification
		 from UserDetails a
		left join AppPackageMapping b on b.userid = a.UserId 
		left join UserHierarchy uh on uh.NTLoginName = a.NTLoginName 
		left join AppPackageClassification apc on apc.PackageId = b.PackageId
		group by a.NTLoginName, b.userid,b.PackageId,a.UserId,apc.Classification
		
GO
/****** Object:  StoredProcedure [DBAEvnt].[TableViewFunctionPermission]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [DBAEvnt].[TableViewFunctionPermission]                    
as                    
begin                   
               
if OBJECT_ID('tempdb..#temp') is not null                    
drop table #temp                    
select  Name into #temp from sys.tables where create_date>=GETDATE()-2 and schema_id =1                
and name not in ('TablePermission','TableViewFunctionPermission')                    
                    
Declare @tc int,@SPName Varchar(100),@sql nvarchar(1500)                    
                    
set @tc=(select COUNT(*) from #temp)                    
                    
While @tc!=0                    
Begin                    
                    
select @SPName=name from  #temp                    
                      
Set @sql='GRANT INSERT ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                    
Exec sp_executesql @SQL                    
Set @sql='GRANT SELECT ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                    
Exec sp_executesql @SQL                    
Set @sql='GRANT UPDATE ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                    
Exec sp_executesql @SQL                    
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                    
Exec sp_executesql @SQL     
                                                    
Delete From #temp where name =@SPName                    
                    
Set @tc =@tc-1                     
End                    
                    
drop table #temp                 
              
              
if OBJECT_ID('tempdb..#viewtemp') is not null                
drop table #viewtemp                
select  Name into #viewtemp from sys.views where create_date >=GETDATE()-2 and schema_id =1                
                
                
set @tc=(select COUNT(*) from #viewtemp)                
                
While @tc!=0                
Begin                
                
select @SPName=name from  #viewtemp                
                
Set @sql='GRANT SELECT ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                
Exec sp_executesql @SQL                
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                
Exec sp_executesql @SQL                
                
                
Delete From #viewtemp where name =@SPName                
                
Set @tc =@tc-1                 
End                
                
drop table #viewtemp              
              
              
if OBJECT_ID('tempdb..#functemp') is not null                
drop table #Functemp                
select  Name into #Functemp from sysobjects where xtype  in('fn')       
and crdate >=GETDATE()-2              
                
                
set @tc=(select COUNT(*) from #Functemp)                
                
While @tc!=0                
Begin                
                
select @SPName=name from  #Functemp                
                
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                
Exec sp_executesql @SQL                
Set @sql='GRANT Execute ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                
Exec sp_executesql @SQL                
                
                
Delete From #Functemp where name =@SPName                
                
Set @tc =@tc-1                 
End                
                
drop table #Functemp              
              
if OBJECT_ID('tempdb..#Tfunctemp') is not null                
drop table #Tfunctemp                
select  Name into #Tfunctemp from sysobjects where xtype  in('Tf')       
and crdate >=GETDATE()-7              
                
                
set @tc=(select COUNT(*) from #Tfunctemp)                
                
While @tc!=0                
Begin                
                
select @SPName=name from  #Tfunctemp                
                
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'    
Exec sp_executesql @SQL                
Set @sql='GRANT REFERENCES ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                
Exec sp_executesql @SQL                
                
                
Delete From #Tfunctemp where name =@SPName                
                
Set @tc =@tc-1                 
End                
                
drop table #Tfunctemp          
  
          
if OBJECT_ID('tempdb..#storedProctemp') is not null            
drop table #storedProctemp            
select  '['+SCHEMA_NAME(schema_id)+'].['+name+']'          
AS SchemaName into #storedProctemp from sys.procedures where create_date>=GETDATE()-2            
and SCHEMA_NAME(schema_id) like '%Dbo%' and name not in ('TableViewFunctionPermission')          
          
            
set @tc=(select COUNT(*) from #storedProctemp)            
            
While @tc!=0            
Begin            
            
select @SPName=SchemaName from  #storedProctemp            
            
Set @sql='GRANT EXECUTE ON '+@SPName+' TO [DB_DMLSupport]'            
            
Exec sp_executesql @SQL            
            
            
Set @sql='GRANT VIEW DEFINITION ON '+@SPName+' TO [DB_DMLSupport]'            
            
Exec sp_executesql @SQL            
            
Delete From #storedProctemp where SchemaName =@SPName            
            
Set @tc =@tc-1             
End             
              
              
                 
end  
GO
/****** Object:  StoredProcedure [DBAEvnt].[TableViewFunctionPermission_ReadOnly]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [DBAEvnt].[TableViewFunctionPermission_ReadOnly]                              
as                              
begin                             
                         
if OBJECT_ID('tempdb..#temp') is not null                              
drop table #temp                              
select  Name into #temp from sys.tables where create_date>=GETDATE()-2 and schema_id =1                          
and name not in ('TablePermission','TableViewFunctionPermission')                              
                              
Declare @tc int,@SPName Varchar(100),@sql nvarchar(1500)                              
                              
set @tc=(select COUNT(*) from #temp)                              
                              
While @tc!=0                              
Begin                              
                              
select @SPName=name from  #temp                              
                             
Set @sql='GRANT SELECT ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                              
Exec sp_executesql @SQL                              
                            
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                              
Exec sp_executesql @SQL               
                           
                              
                              
Delete From #temp where name =@SPName                              
                              
Set @tc =@tc-1                               
End                              
                              
drop table #temp                           
                        
                        
if OBJECT_ID('tempdb..#viewtemp') is not null                          
drop table #viewtemp                          
select  Name into #viewtemp from sys.views where create_date >=GETDATE()-2 and schema_id =1                    
                          
                          
set @tc=(select COUNT(*) from #viewtemp)                          
                          
While @tc!=0                          
Begin                          
                          
select @SPName=name from  #viewtemp                          
                          
Set @sql='GRANT SELECT ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                          
Exec sp_executesql @SQL                          
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                          
Exec sp_executesql @SQL                          
                          
                          
Delete From #viewtemp where name =@SPName                          
                          
Set @tc =@tc-1                           
End                          
                          
drop table #viewtemp                        
                        
                        
if OBJECT_ID('tempdb..#functemp') is not null                          
drop table #Functemp                          
select  Name into #Functemp from sysobjects where xtype  in('fn')                 
and crdate >=GETDATE()-7                        
                          
                          
set @tc=(select COUNT(*) from #Functemp)                          
                          
While @tc!=0                          
Begin                          
                          
select @SPName=name from  #Functemp                          
                          
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                          
Exec sp_executesql @SQL    
  
Set @sql='GRANT EXECUTE ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                          
Exec sp_executesql @SQL                        
                         
Delete From #Functemp where name =@SPName                          
                          
Set @tc =@tc-1                         
End                          
                          
drop table #Functemp                        
  
             
if OBJECT_ID('tempdb..#Tfunctemp') is not null                
drop table #Tfunctemp                
select  Name into #Tfunctemp from sysobjects where xtype  in('Tf')       
and crdate >=GETDATE()-2              
                
                
set @tc=(select COUNT(*) from #Tfunctemp)                
                
While @tc!=0                
Begin                
                
select @SPName=name from  #Tfunctemp                
                
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                
Exec sp_executesql @SQL                
Set @sql='GRANT REFERENCES ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                
Exec sp_executesql @SQL                
                
                
Delete From #Tfunctemp where name =@SPName                
                
Set @tc =@tc-1                 
End                
                
drop table #Tfunctemp                                
                    
if OBJECT_ID('tempdb..#storedProctemp') is not null                      
drop table #storedProctemp                      
select  '['+SCHEMA_NAME(schema_id)+'].['+name+']'                    
AS SchemaName into #storedProctemp from sys.procedures where create_date>=GETDATE()-2         
and schema_id =1 and name not in ('TableViewFunctionPermission')                    
                    
                      
set @tc=(select COUNT(*) from #storedProctemp)                      
                      
While @tc!=0                      
Begin                      
                      
select @SPName=SchemaName from  #storedProctemp                      
                      
Set @sql='GRANT VIEW DEFINITION ON '+@SPName+' TO [DB_Readonlysupport]'                      
                      
Exec sp_executesql @SQL                      
                      
Delete From #storedProctemp where SchemaName =@SPName                      
                      
Set @tc =@tc-1                       
End                       
                        
                        
                           
end  
GO
/****** Object:  StoredProcedure [dbo].[AppWatcherInsert]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Promodh Kumar
-- Create date: 31/12/2019
-- Description:	AppWatcher Insert moved to Stored Procedure for Optimization purposes
-- =============================================
CREATE PROCEDURE [dbo].[AppWatcherInsert]
(
	@UserId nvarchar(128),
	@UserAccount varchar(100),
	@UserDomain varchar(50),
	@ComputerName varchar(100),
	@AppName varchar(500),
	@WindowTitle varchar(500),
	@BrowserUrl nvarchar(max),
	@StartTime datetime2(7),
	@EndTime datetime2(7),
	@TimeSpent time(7),
	@VersionId varchar(100),
	@CreatedOn datetime2(7),
	@OperatingSystem varchar(100),
	@BaseUrl varchar(max),
	@TimeSpentms bigint
)
AS
BEGIN
	begin try
		begin tran
			insert into Echolock.dbo.AppWatcher (UserId, UserAccount, UserDomain, ComputerName, AppName, WindowTitle,
					BrowserUrl, StartTime, EndTime, TimeSpent, VersionId, CreatedOn, OperatingSystem, BaseUrl, TimeSpentms)
				values (@UserId, @UserAccount, @UserDomain, @ComputerName, @AppName, @WindowTitle,
					@BrowserUrl, @StartTime, @EndTime, @TimeSpent, @VersionId, @CreatedOn, @OperatingSystem, @BaseUrl, @TimeSpentms)

			select 1
		
		commit
	end try
	begin catch
		rollback
		declare @ErrorMessage varchar(100) 
		select @ErrorMessage = ERROR_MESSAGE()
			insert into ErrorLogs (UserAccount, ExceptionMessage, EventDetails, ComputerName)
				values ('promodh.kumar', ERROR_MESSAGE(), ERROR_MESSAGE(), 'HQ-03-IT-75')
		if @ErrorMessage like 'Violation of UNIQUE KEY%'
		begin
			select 2
		end
		else
		begin
			select 0
		end
	end catch
END
GO
/****** Object:  StoredProcedure [dbo].[ARCFactAppUsageDataJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Promodh Kumar
-- Create date: 23/03/2020
-- Description:	Echolock Detailed App Usage Data to ARC Fact Table Job
-- =============================================
CREATE PROCEDURE [dbo].[ARCFactAppUsageDataJob]
	@UsageDate DATE
AS
BEGIN

	IF OBJECT_ID('tempdb..#appdata') IS NOT NULL  drop table #appdata
	IF OBJECT_ID('tempdb..#finaldata') IS NOT NULL  drop table #finaldata
	
	create table #appdata
	(
		UsageDate date,
		DateKey int,
		ARCUserId int,
		AppId bigint,
		AppType varchar(100),
		AppURL varchar(200),
		Classification varchar(100),
		Category varchar(200),
		DisplayName varchar(200),
		TimeSpent int
	);

	create table #finaldata
	(
		UsageDate date,
		DateKey int,
		ARCUserId int,
		AppId bigint,
		AppType varchar(100),
		AppURL varchar(200),
		Classification varchar(100),
		Category varchar(200),
		DisplayName varchar(200),
		TimeSpent int
	);

	insert into #appdata (UsageDate, DateKey, ARCUserId, AppId, AppURL, AppType, Classification, Category, DisplayName, TimeSpent)
		SELECT
		   AP.UsageDate, convert(int, convert(varchar(4), AP.UsageDate, 102) + right(convert(varchar(7), AP.UsageDate, 102), 2) + right(convert(varchar(10),AP.UsageDate, 102), 2)) DateKey,
		   ud.ARCUserId,ap.AppId,
		   CASE WHEN LA.AppName IS NULL THEN LEFT(LA.BaseUrl,200)  ELSE LEFT(LA.AppName, 200) END AS AppURL,
		   CASE WHEN LA.AppName IS NULL THEN 'URL' ELSE 'APP' END AS [TYPE],
		   CASE WHEN AP.Classification = 1  THEN 'Productive' 
				  ELSE CASE WHEN AP.Classification = 2  THEN 'Non-Productive' ELSE 
				  'Unclassified' END END AS Classification,
		   LAC.CategoryName,
		   CASE WHEN la.AliasName IS NOT NULL THEN  LEFT(la.AliasName,200)
				  ELSE CASE WHEN LA.AppName IS NULL THEN LEFT(LA.BaseUrl,200)
				  ELSE LEFT(LA.AppName,200) END END AS DisplayName,
		   cast(( AP.TimeSpentms / 1000) as int) TimeSpent
		FROM EchoLock.dbo.DailyAppUsage(NOLOCK)AP
		INNER JOIN EchoLock.dbo.UserDetails(NOLOCK)UD 
			ON ud.UserId = ap.UserId
		INNER JOIN EchoLock.dbo.LookupApps(NOLOCK)LA 
			ON LA.Id = AP.AppId
		LEFT JOIN EchoLock.dbo.LookupAppCategories(NOLOCK)LAC
			ON LAC.Id = AP.Category
		WHERE LA.IsActive = 1 AND AP.UsageDate = @UsageDate
			and UD.ARCUserId is not null

	delete from #appdata
		where TimeSpent = 0

	insert into #finaldata (UsageDate, DateKey, ARCUserId, AppURL, Classification, Category, DisplayName, TimeSpent)
		select UsageDate, DateKey, ARCUserId, AppURL, Classification, Category, DisplayName, sum(TimeSpent)
			from #appdata
			group by UsageDate, DateKey, ARCUserId, AppURL, Classification, Category, DisplayName

	begin try

		begin tran

		declare @dt datetime = getdate()
		declare @createddt int = convert(int, convert(varchar(4), @dt, 102) + right(convert(varchar(7), @dt, 102), 2) + right(convert(varchar(10),@dt, 102), 2))

		merge EchoLock.dbo.FactApplicationUsage t
		using #appdata s
		on (t.DateKey = s.DateKey and t.AppURL = s.AppURL and t.UserId = s.ARCUserId)
		when matched then
			update
				set t.AppType = s.AppType, t.AppClassification = s.Classification,
					t.AppCategory = s.Category, t.DisplayName = s.DisplayName, t.TimeSpent = s.TimeSpent, t.Active = 1
		when not matched by target then
			insert (DateKey, UserId, AppType, AppURL, AppClassification, AppCategory, 
				DisplayName, TimeSpent,CreatedDt, Active)
			values (s.DateKey, s.ARCUserId, s.AppType, s.AppURL, s.Classification,
				s.Category, s.DisplayName, TimeSpent, @createddt, 1)
		;

		commit

	end try
	begin catch

		rollback

		select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

		insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
			values ('ARCFactAppUsageDataJob Error',     
				convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				getdate(), 'ARCFactAppUsageDataJob', 'SQL Server')    
  
		insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
			values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
				'Error in ARCFactAppUsageDataJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				0, 'Y', getdate(), null, 1)

	end catch

	IF OBJECT_ID('tempdb..#appdata') IS NOT NULL  drop table #appdata
	IF OBJECT_ID('tempdb..#finaldata') IS NOT NULL  drop table #finaldata
END
GO
/****** Object:  StoredProcedure [dbo].[ARCtoEcholockAttendanceSync]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*--======================================================================================        
--ARCtoEcholockAttendanceSync - ARC Attendance sync Job for Echolock
--======================================================================================        
--Created By   -  Promodh.Kumar        
--Created On   -  14/12/2019        
--Parameters   -  @AttId - ARC_REC_ATTENDANCE - ID
--======================================================================================        
--Modified By   -
--Modified On   -
--Modification Details -
--======================================================================================        
*/  
        
CREATE Proc [dbo].[ARCtoEcholockAttendanceSync]
(        
 @AttId bigint null,
 @AttDate datetime null,
 @AttUsers varchar(max) null
)
        
as        
begin        
	set transaction Isolation level read uncommitted;
	set nocount on

	IF OBJECT_ID('tempdb..#attdata') IS NOT NULL drop table #attdata 
	IF OBJECT_ID('tempdb..#currentdata') IS NOT NULL drop table #currentdata 
	IF OBJECT_ID('tempdb..#modified') IS NOT NULL drop table #modified

	select items UserId
		into #Users
		from Echolock.dbo.SplitStringfn(@AttUsers, ',')

	select *
		into #attdata
		from ARC_Enterprise_Aug2019.dbo.ARC_REC_Attendance
		(nolock)
		where (@AttId is not null and Aid = @AttId)
			or (@AttDate is not null and exists (select top 1 * from #Users)
				and Userid in (select cast(UserId as int)
					from #Users)
				and Date = @AttDate)

	if exists (select top 1 * from #attdata)
	begin

		declare @CompanyAppWatcher bit = 0

       select top 1 @CompanyAppWatcher = AppWatcher
			from Echolock.dbo.CompanyAppSettings app
            (nolock)
			inner join UserDetails ud
			(nolock)
				on ud.CompanyId = app.CompanyId
			inner join DailyDashboardData dd
			(nolock)
				on dd.UserId = ud.UserId
			inner join #attdata att
			(nolock)
				on att.Userid = dd.ARCUserId and att.[Date] = dd.EventDate
		
		select distinct att.Aid AttId, ud.UserId, att.UserId ARCUserId, att.NT_UserName NTLoginName, att.[Date] EventDate, att.AttReporting_to Manager, esft.Id Shift, att.Shift_From ShiftFrom,
				att.Shift_to ShiftTo, att.Designid, att.Functionalityid, att.Client_id ClientId, att.AttLocationid LocationId,
				att.AttLobid LOBId, fun.FunctionName Team, lob.lob LOB, desg.Designation Role, desg.Band Band, desg.Grade Grade, ud.TimeZone,
				client.Client_Name Client, loc.LocationName as [Location], att.P_Days Present, isnull(app.AppWatcher, @CompanyAppWatcher) AppWatcher, att.IsDeclaredOff DeclaredOff
			into #currentdata
			from #attdata att
			(nolock)
            inner join ARC_Enterprise_Aug2019.dbo.ARC_REC_SHIFT_INFO sft
            (nolock)
                    on att.ShiftId = sft.Shift_Id
            left join ARC_Enterprise_Aug2019.dbo.ARC_REC_LOB_INFO lob
            (nolock)
                    on att.AttLobId = lob.ID
            left join ARC_Enterprise_Aug2019.dbo.HR_Functionality fun
            (nolock)
                    on att.FunctionalityId = fun.FunctionalityId
            left join ARC_Enterprise_Aug2019.dbo.HR_Designation desg
            (nolock)
                    on att.DesignId = desg.DesigId
            left join ARC_Enterprise_Aug2019.dbo.ARC_FIN_CLIENT_INFO client
            (nolock)
                    on att.Client_Id = client.Client_Id
            left join ARC_Enterprise_Aug2019.dbo.HR_LocationMaster loc
            (nolock)
                    on att.AttLocationId = loc.LocationId
            left join Echolock.dbo.DailyDashboardData ud
            (nolock)
                    on att.NT_UserName = ud.NTLoginName and att.[Date] = ud.EventDate
            left join Echolock.dbo.LookupShift esft
            (nolock)
                    on sft.SHIFT_NAME = esft.ShiftName and sft.SHIFT_FROM = esft.WorkStartTime and sft.SHIFT_TO = esft.WorkEndTime
            left join Echolock.dbo.UserAppSettings app
            (nolock)
                    on ud.UserId = app.UserId

		begin try
			begin tran

			select cd.AttId, cd.EventDate, cd.UserId,
					case when cd.Manager <> dd.ManagerL1 then cd.Manager else null end Manager,
					case when cd.Role <> dd.Role then cd.Role else null end Role,
					case when cd.Team <> dd.Team then cd.Team else null end Team,
					case when cd.Client <> dd.Client then cd.Client else null end Client,
					case when cd.Location <> dd.Location then cd.Location else null end Location,
					case when cd.LOB <> dd.LOB then cd.LOB else null end LOB,
					case when cd.Band <> dd.Band then cd.Band else null end Band,
					case when cd.Grade <> dd.Grade then cd.Grade else null end Grade,
					case when cd.Shift <> dd.Shift then cd.Shift else dd.Shift end Shift,
					case when cd.TimeZone <> dd.TimeZone then cd.TimeZone else dd.TimeZone end TimeZone,
					case when cd.ShiftFrom <> dd.ShiftFrom then cd.ShiftFrom else null end ShiftFrom,
					case when cd.ShiftTo <> dd.ShiftTo then cd.ShiftTo else null end ShiftTo,
					cd.ARCUserId, cd.NTLoginName,
					case when cd.Present <> dd.Present then cd.Present else null end Present,
					case when cd.DeclaredOff <> dd.IsDeclaredOff then cd.DeclaredOff else null end DeclaredOff,
					AppWatcher, 0 Status
				into #modified
				from #currentdata cd
				inner join DailyDashboardData dd
				(nolock)
					on cd.UserId = dd.UserId and cd.EventDate = dd.EventDate

			update #modified
				set Status = 1
				where ((Manager is not null) or (Role is not null) or (Team is not null) or (Client is not null)
						or (Location is not null) or (LOB is not null) or (Band is not null) or (Grade is not null)
						or (ShiftFrom is not null) or (ShiftTo is not null) or (Present is not null) or (DeclaredOff is not null))

			insert into DashboardChangeHistory
					(AttId, EventDate, UserId, ManagerL1, Role, Team, Client, Location, LOB, Band, Grade, Shift, TimeZone, ShiftFrom, ShiftTo, ARCUserId,
					NTLoginName, Present, IsDeclaredOff, CreatedOn, IsJobRequired, JobRunStatus, JobRunTime)
				select AttId, EventDate, UserId, Manager, Role, Team, Client, Location, LOB, Band, Grade, Shift, TimeZone, ShiftFrom, ShiftTo, ARCUserId,
						NTLoginName, Present, DeclaredOff, getdate(), 0, 0, null
					from #modified
					where Status = 1

			update dd
				set dd.NTLoginName = cd.NTLoginName, dd.ManagerL1 = cd.Manager, dd.Shift = cd.Shift, dd.ShiftFrom = cd.ShiftFrom, dd.ShiftTo = cd.ShiftTo,
					dd.Role = cd.Role, dd.Team = cd.Team, dd.LOB = cd.LOB, dd.Band = cd.Band, dd.Grade = cd.Grade, dd.Client = cd.Client, dd.Location = cd.Location,
					dd.Present = cd.Present, dd.AppWatcherEnabled = cd.AppWatcher, dd.IsDeclaredOff = cd.DeclaredOff
				from EchoLock.dbo.DailyDashboardData dd
				inner join #modified cd
					on dd.UserId = cd.UserId and dd.EventDate = cd.EventDate
				where Status = 1

			commit
		end try
		begin catch
			rollback
		end catch
	end   

	IF OBJECT_ID('tempdb..#attdata') IS NOT NULL drop table #attdata 
	IF OBJECT_ID('tempdb..#currentdata') IS NOT NULL drop table #currentdata 
	IF OBJECT_ID('tempdb..#modified') IS NOT NULL drop table #modified
end
GO
/****** Object:  StoredProcedure [dbo].[ARCtoEcholockShiftUserInfoHourlyJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--======================================================================================      
--ARC to Echolock - Shift & UserInfo Hourly Job - Houry Job for ARC User Details integration to Echolock by Company
--======================================================================================      
--Created By  -  Promodh.Kumar      
--Created On  -  28/03/2019      
--Parameters  -  @CompanyId - Access Healthcare Company Id
--======================================================================================      
--Modified By              -      Promodh.Kumar
--Modified On              -      09/09/2019
--Modification Details     -      Added LOB, Band, Grade & Added Logic for deactivating Inactive Users
--======================================================================================    
--Modified By              -      Promodh.Kumar
--Modified On              -      18/10/2019
--Modification Details     -      Inactive to Active User scenario handled, Manager & Above - App Settings Customization & Band not updating scenario
--======================================================================================    
--Modified By              -      Promodh.Kumar
--Modified On              -      07/02/2020
--Modification Details     -      Added CostCode, Process & ARCUserId
--======================================================================================    
CREATE  PROCEDURE  [dbo].[ARCtoEcholockShiftUserInfoHourlyJob]
	-- Access Healthcare Company Id
	@CompanyId int = 1
AS
BEGIN
       set transaction Isolation level read uncommitted;      
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
       SET NOCOUNT ON;

       IF OBJECT_ID('tempdb..#final') IS NOT NULL DROP TABLE #final
       IF OBJECT_ID('tempdb..#finalband') IS NOT NULL DROP TABLE #finalband
       IF OBJECT_ID('tempdb..#Users') IS NOT NULL DROP TABLE #Users
       IF OBJECT_ID('tempdb..#UserDetails') IS NOT NULL DROP TABLE #UserDetails
       IF OBJECT_ID('tempdb..#temp') IS NOT NULL DROP TABLE #temp
       IF OBJECT_ID('tempdb..#temp2') IS NOT NULL DROP TABLE #temp2
       IF OBJECT_ID('tempdb..#temp3') IS NOT NULL DROP TABLE #temp3
       IF OBJECT_ID('tempdb..#band') IS NOT NULL DROP TABLE #band
       IF OBJECT_ID('tempdb..#shift') IS NOT NULL DROP TABLE #shift

       --ARC - Lookup Shift to Echolock - Lookup Shift

       select distinct SHIFT_NAME, SHIFT_FROM, SHIFT_TO
              into #shift
              from ARC_Enterprise_Aug2019.dbo.ARC_REC_SHIFT_INFO(nolock)
       
       begin try
       begin tran

       merge echolock.dbo.LookupShift as t
       using #shift s
              on (s.Shift_From = t.WorkStartTime and s.Shift_To = t.WorkEndTime and s.Shift_Name = t.ShiftName)
       when matched then
              update set t.ShiftName = s.Shift_Name, t.WorkStartTime = s.Shift_From, t.WorkEndTime = s.Shift_To,
                     t.WorkDuration = convert(TIME,dateadd(ms,DateDiff(ss, s.Shift_From, s.Shift_To )*1000,0),114),
                     t.CreatedBy = 'promodh.kumar'
       when not matched by target then
              insert (ShiftName, WorkStartTime, WorkEndTime, WorkDuration, CreatedBy, CreatedOn, IsActive)
              values (s.Shift_Name, s.Shift_From, s.Shift_To, convert(TIME,dateadd(ms,DateDiff(ss, s.Shift_From, s.Shift_To )*1000,0),114), 'promodh.kumar', getdate(), 1)
       ;
       commit

       end try
       begin catch

              rollback
              select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

                       insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)
                           values ('DB Shift Info Job Error', 
                                  convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
                                  getdate(), 'UserInfoHourlyJob', 'SQL Server')

                       insert into ARC_Enterprise_Aug2019.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)
                           values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',
                                  'Error in Shift Hourly Info Job', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
                                  0, 'Y', getdate(), null, 1)

       end catch
	   ---ARC - UserInfo to Echolock - UserInfo

       select USR.Userid, USR.NT_UserName, Empcode, REPORTING_TO, Designation, USR.FunctionName, client_name, FIRSTNAME, LASTNAME, EMAIL.ValidEmail, LocationName,
                     USFT.SHIFT_NAME, USFT.SHIFT_FROM, USFT.SHIFT_TO,
                     isnull((Select top 1 ID from ARC_Enterprise_Aug2019.dbo.ARC_REC_ASSOCIATE_WEEK_OFF where UserId = USR.UserId and EFF_DT_FROM <= getdate() Order by ID desc),2) WEEKOFFID,
                     USR.LOB, USR.D_Band Band, USR.D_Grade Grade, USR.CostCode, FUN.[Type] Process, GRP.GroupName, SGRP.SubGroupName, SFUN.SubFunctionality, PRJ.Project,
					 FGRP.FunctionalityGroupName
              into #temp
              from ARC_Enterprise_Aug2019.dbo.ARC_REC_USER_INFO_VY USR
					(nolock)
					inner join ARC_Enterprise_Aug2019.dbo.ARC_REC_SHIFT_INFO USFT
					(nolock)
						on USR.CurrentShiftId = USFT.SHIFT_ID
					inner join ARC_Enterprise_Aug2019.dbo.ARC_REC_ASSOICIATE_EMAILID EMAIL
					(nolock)
						on USR.Userid = EMAIL.Userid
					inner join ARC_Enterprise_Aug2019.dbo.HR_Functionality FUN
					(nolock)
						on USR.FunctionalityId = FUN.FunctionalityId
					left join ARC_Enterprise_Aug2019.dbo.HR_FunctionalityGroups FGRP
					(nolock)
						on FUN.FunctionalityGroupId = FGRP.FunctionalityGroupId
					left join ARC_Enterprise_Aug2019.dbo.HR_FunctionGroup GRP
					(nolock)
						on USR.GroupId = GRP.GroupId
					left join ARC_Enterprise_Aug2019.dbo.HR_FunctionSubGroup SGRP
					(nolock)
						on USR.SubGroupID = SGRP.SubGroupID
					left join ARC_Enterprise_Aug2019.dbo.HR_SubFunctionality SFUN
					(nolock)
						on USR.SubFunctionalityId = SFUN.SubFunctionalityId
					left join ARC_Enterprise_Aug2019.dbo.HR_Project PRJ
					(nolock)
						on USR.ProjectId = PRJ.ProjectId
              where USR.NT_UserName <> '' and Empcode is not null and Empcode <> ''

       select Empcode, Band
              into #band
              from #temp
              where Band >= 3
				or (Band = 2
					and Designation in ('Assistant Manager','Assistant Delivery Manager','Deputy Delivery Manager','Project Manager','Deputy Manager'))

       select a.Userid, a.NT_UserName as NT_UserName, Empcode, REPORTING_TO, Designation, FunctionName, client_name, FIRSTNAME, LASTNAME, ValidEmail, LocationName,
                     a.SHIFT_NAME, a.SHIFT_FROM, a.SHIFT_TO,
                     echolock.dbo.WeekDaysOffFn(b.WEEK_OFF_DAYS,',') as WorkDays, c.Id as Shift,
              isnull(d.Domain,'accesshealthcar') UserDomain, a.LOB, a.Band, a.Grade, a.CostCode, a.Process,
			  a.GroupName, a.SubGroupName, a.SubFunctionality, a.Project, a.FunctionalityGroupName,
              0 IsNew, 0 IsUpdated
              into #temp2
              from #temp a
                     inner join ARC_Enterprise_Aug2019.dbo.ARC_REC_ASSOCIATE_WEEK_OFF b on a.WEEKOFFID = b.ID
                     inner join echolock.dbo.LookupShift c on a.Shift_Name = c.ShiftName and a.SHIFT_FROM = c.WorkStartTime and a.SHIFT_TO = c.WorkEndTime
                     left join ARC_Enterprise_Aug2019.dbo.ARC_REC_UserAuthentication d on a.Userid = d.UserId

		update Echolock.dbo.UserDetails
			set Status = 4
			where Status <> 4
				and EmployeeCode in (select EmpCode
						from #temp2
						where EmpCode is not null
							and CompanyId = @CompanyId)
				and EmployeeCode is not null

       select *
              into #UserDetails
              from echolock.dbo.UserDetails
              where CompanyId = @CompanyId
                     and Status = 4 -- For only Active Users

       --Getting list of the New Users to be added
       update #temp2
              set IsNew = 1
              where Empcode not in (select EmployeeCode
                           from #UserDetails
                           where EmployeeCode is not null)
                     and Empcode is not null
					 and IsUpdated = 0

       --Getting list of Users to be updated
       merge #temp2 t
       using #UserDetails s
              on (t.Empcode = s.EmployeeCode and t.IsNew = 0 and (
                     (s.NTLoginName <> t.NT_UserName) or (s.DomainName <> t.UserDomain) or (isnull(s.FirstName,'') <> isnull(t.FIRSTNAME,'')) or (isnull(s.LastName,'') <> isnull(t.LASTNAME,'')) or
                     (isnull(s.ManagerL1,'') <> isnull(t.REPORTING_TO,'')) or (isnull(s.Role,'') <> isnull(t.Designation,'')) or (isnull(s.Team,'') <> isnull(t.FunctionName,'')) or
					 (s.Client <> t.client_name) or (s.Location <> t.LocationName) or (s.Shift <> t.Shift) or (s.WorkDays <> t.WorkDays) or
					 (isnull(s.CostCode,'') <> isnull(t.CostCode,'')) or (isnull(s.Process,'') <> isnull(t.Process,'')) or (isnull(s.LOB, '') <> isnull(t.LOB, '')) or
                     (isnull(s.Band, '') <> isnull(t.Band, '')) or (isnull(s.Grade, '') <> isnull(t.Grade, '')) or (isnull(s.[Group],'') <> isnull(t.GroupName,'')) or
					 (isnull(s.SubGroup,'') <> isnull(t.SubGroupName,'')) or (isnull(s.SubFunctionality,'') <> isnull(t.SubFunctionality,'')) or
					 (isnull(s.Project,'') <> isnull(t.Project,'')) or (isnull(s.FunctionalityGroup,'') <> isnull(t.FunctionalityGroupName,''))
              ))
       when matched then
              update set t.IsUpdated = 1
       ;

       --Getting list of the Inactive Users to be deactivated
       select a.EmployeeCode, a.NTLoginName, b.Empcode
              into #temp3
              from #UserDetails a
                     (nolock)
                     left join #temp2 b
                     (nolock)
                           on a.EmployeeCode = b.Empcode
              where b.Empcode is null
                     and a.EmployeeCode is not null

       -- Final list of Users needs to be added or updated
       select *
              into #final
              from #temp2
              where IsNew = 1 or IsUpdated = 1
              order by NT_UserName

       select a.*, b.UserId
              into #finalband
              from #band a
              left join #UserDetails b
                     on a.Empcode = b.EmployeeCode
              where (a.Band >= 3
					and convert(int, isnull(b.Band, 0)) < 3)
                    or b.EmployeeCode is null
					or (a.Band = 2 and Role in ('Assistant Manager','Assistant Delivery Manager','Deputy Delivery Manager','Project Manager','Deputy Manager'))

       begin try
              begin tran
              
              --Update Existing Users' Info
              merge echolock.dbo.UserDetails t
              using #final s
                     on (s.Empcode = t.EmployeeCode and s.IsNew = 0 and s.IsUpdated = 1)
              when matched then
                     update set t.NTLoginName = s.NT_UserName, t.DomainName = s.UserDomain, t.FirstName = s.FIRSTNAME, t.LastName = s.LASTNAME,
                           t.ManagerL1 = s.REPORTING_TO, t.Role = s.Designation, t.Team = s.FunctionName, t.Client = s.client_name,
                           t.Location = s.LocationName, t.Shift = s.Shift, t.WorkDays = s.WorkDays, t.LOB = s.LOB, t.Band = s.Band, t.Grade = s.Grade,
						   t.TimeZone = case when s.LocationName = 'Manila' then 107 else 90 end, t.CostCode = s.CostCode, t.Process = s.Process,
						   t.ARCUserId = s.Userid, t.[Group] = s.GroupName, t.SubGroup = s.SubGroupName,
						   t.SubFunctionality = s.SubFunctionality, t.Project = s.Project, t.FunctionalityGroup = s.FunctionalityGroupName
              ;

              --Update Inactive Users'
              update echolock.dbo.UserDetails
                     set Status = 8
                     where EmployeeCode in (
                           select EmployeeCode
                                  from #temp3
                     )

              --Add New Users in Users Table
              insert into echolock.dbo.Users
                     (UserId, Email, UserName, Discriminator, PasswordHash, SecurityStamp, EmailConfirmed, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnabled, AccessFailedCount)
                     (select newid(), ValidEmail, ValidEmail, 'ApplicationUser', 'AKYLMKFmrSNgINwUcY0bwbM9lLT2DgXn1DEmlKHR5QOSDtSjugT+dd/es55EMRMvmw==', newid(),
                                  0, 0, 0, 0, 0
                           from #final
                           where IsNew = 1)

              select *
                     into #Users
                     from echolock.dbo.Users

              --Add New Users' Info in UserDetails Table
              insert into echolock.dbo.UserDetails
                     (UserId, CompanyId, NTLoginName, DomainName, FirstName, LastName, EmployeeCode, ManagerL1, ManagerL2, Role, Team, Client, 
                           Location, SerialKey, CreatedBy, CreatedOn, IsAdmin, Status, Shift, WorkDays, TimeZone, CostCode, Process, ARCUserId,
						   [Group], SubGroup, SubFunctionality, Project, FunctionalityGroup)
                     (select b.UserId, @CompanyId, a.NT_UserName, a.UserDomain, a.FIRSTNAME, a.LASTNAME, a.Empcode, a.REPORTING_TO, null, a.Designation, a.FunctionName, a.client_name, 
                                  a.LocationName, newid(), 'promodh.kumar', getdate(), 0, 4, a.Shift, a.WorkDays, case when a.LocationName = 'Manila' then 107 else 90 end,
								  a.CostCode, a.Process, a.Userid, a.GroupName, a.SubGroupName, a.SubFunctionality, a.Project, a.FunctionalityGroupName
                           from #final a
                                  inner join #Users b on b.Email = a.ValidEmail and b.UserName = a.ValidEmail
                           where IsNew = 1)

              insert into EchoLock.dbo.UserAppSettings
                     (UserId, BreakTimePopup, AutoLockTime, MultiSession, OfflineTime, AppWatcher, ScreenCapture,
                                  ScreenCaptureInterval, ScreenCaptureResolution, CreatedBy, CreatedOn, PushNotification, NotificationURL, EnableHotKeys, KafkaQueueing, KafkaURL)
                     select a.UserId, 0, 180, 0, 0, 0, 0, 300, 1, 'UserInfoJob', getdate(), 0, null, 0, 0, null
                           from echolock.dbo.Users a
                                  inner join #final b on a.UserName = b.ValidEmail
                           where b.IsNew = 1 and (b.Band >= 3)

              merge echolock.dbo.UserAppSettings t
                   using #finalband s
                          on s.UserId = t.UserId and s.UserId is not null
                   when matched then
                          update set t.BreakTimePopup = 0, t.AutoLockTime = 180, t.MultiSession = 0, t.OfflineTime = 0,
                                 t.AppWatcher = 0, t.ScreenCapture = 0, t.ScreenCaptureInterval = 300, t.ScreenCaptureResolution = 1
                   when not matched by target and s.UserId is not null then
                          insert (UserId, BreakTimePopup, AutoLockTime, MultiSession, OfflineTime, AppWatcher, ScreenCapture,
                                 ScreenCaptureInterval, ScreenCaptureResolution, CreatedBy, CreatedOn, PushNotification, NotificationURL, EnableHotKeys, KafkaQueueing, KafkaURL)
                          values (s.UserId, 0, 180, 0, 0, 0, 0, 300, 1, 'UserInfoJob', getdate(), 0, null, 0, 0, null)
                   ;

              commit
       end try
       begin catch

              rollback
              --select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()
                       insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)
                           values ('DB User Info Job Error', 
                                  convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
                                  getdate(), 'UserInfoHourlyJob', 'SQL Server')
                       insert into ARC_Enterprise_Aug2019.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)
                           values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',
                                  'Error in User Hourly Info Job', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
                                  0, 'Y', getdate(), null, 1)

       end catch

       IF OBJECT_ID('tempdb..#final') IS NOT NULL DROP TABLE #final
       IF OBJECT_ID('tempdb..#Users') IS NOT NULL DROP TABLE #Users
       IF OBJECT_ID('tempdb..#UserDetails') IS NOT NULL DROP TABLE #UserDetails
       IF OBJECT_ID('tempdb..#temp') IS NOT NULL DROP TABLE #temp
       IF OBJECT_ID('tempdb..#temp2') IS NOT NULL DROP TABLE #temp2
       IF OBJECT_ID('tempdb..#temp3') IS NOT NULL DROP TABLE #temp3
       IF OBJECT_ID('tempdb..#shift') IS NOT NULL DROP TABLE #shift
END
GO
/****** Object:  StoredProcedure [dbo].[ARCtoEcholockWFHSync]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Promodh Kumar
-- Create date: 27/03/2020
-- Description:	ARC to Echolock WFH Users List Sync Job
-- =============================================
CREATE PROCEDURE [dbo].[ARCtoEcholockWFHSync]
	@JobDate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
	IF OBJECT_ID('tempdb..#wfh') IS NOT NULL  drop table #wfh  

	create table #wfh
	(
		UserId nvarchar(128) null,
		EventDAte datetime null,
		WFH bit null
	);

	insert into #wfh
		select ud.UserId, @JobDate EventDate, cast(1 as bit) WFH
			from ARC_Enterprise_Aug2019.dbo.ARC_REC_Attendance att
			(nolock)
			inner join Echolock.dbo.UserDetails ud
			(nolock)
				on att.UserId = ud.ARCUserId
			where att.[Date] = @JobDate
				--and WFH is not null and WFH = 0

	begin try
		begin tran

		merge Echolock.dbo.WFHUsers t
		using #wfh s
		on (t.UserId = s.UserId and t.EventDate = s.EventDate)
		when matched then
			update set t.IsWFH = s.WFH
		when not matched by target then
			insert (UserId, EventDate, IsWFH)
				values (s.UserId, s.EventDate, s.WFH)
		;

		commit

	end try
	begin catch
		rollback

		select @JobDate, ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

		if ERROR_MESSAGE() not like 'Violation of UNIQUE KEY%'
		begin
			insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
				values ('ARCtoEcholockWFHSync Error',     
					convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
					getdate(), 'ARCtoEcholockWFHSync', 'SQL Server')    
  
			insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
				values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
					'Error in ARCtoEcholockWFHSync', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
					0, 'Y', getdate(), null, 1)
		end
	end catch

	IF OBJECT_ID('tempdb..#wfh') IS NOT NULL  drop table #wfh

END
GO
/****** Object:  StoredProcedure [dbo].[C3_FileWatcherDetails]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_FileWatcherDetails]
(
	@Project  VARCHAR(100),
	@FullPath VARCHAR(750),
	@FileName VARCHAR(250) = NULL,
	@ModifiedAs VARCHAR(250) = NULL,
	@ChangeType VARCHAR(100) = NULL,
	@ActionAt	DATETIME,
	@FileSize BIGINT = 0
)
AS
BEGIN
	INSERT INTO C3_FileWatcherFileInfo(Project,FullPath,[FileName],OldName,ChangeType,FileCreatedAt,FileSize)
	VALUES(@Project,@FullPath,@FileName,@ModifiedAs,@ChangeType,@ActionAt,@FileSize)
END
GO
/****** Object:  StoredProcedure [dbo].[C3_FileWatcherFileInput]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_FileWatcherFileInput]
(
	@Project VARCHAR(100),
	@Data C3_FileWatcherType READONLY
)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX)
	BEGIN TRY           
		BEGIN TRANSACTION
			IF OBJECT_ID('tempdb..#TmbTblFileInput') IS NOT NULL DROP TABLE #TmbTblFileInput
			SELECT * ,@Project AS Project INTO #TmbTblFileInput FROM @Data

			INSERT INTO C3_FileWatcherFileInfo(Project,FullPath,[FileName],FileSize,FileCreatedAt,OldName,ChangeType)
			SELECT X.Project,X.FullPath,X.[FileName],X.FileSize,X.FileCreatedAt,X.OldName,X.ChangeType
			FROM (
			SELECT DT.Project,DT.FullPath,DT.[FileName],DT.FileSize,DT.FileCreatedAt,DT.OldName
			,DT.ChangeType,FI.ChangeType AS ChangeTypeTBL
			FROM #TmbTblFileInput DT
			LEFT JOIN C3_FileWatcherFileInfo(NOLOCK)FI
			ON DT.FullPath = FI.FullPath
			)X
			WHERE X.ChangeTypeTBL IS NULL

		COMMIT TRANSACTION
		SET @Result = 'Success'  
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @Result = ERROR_MESSAGE()
		INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)
		VALUES(null,'RCFileWatcher','FileWatcher','DB',GETDATE(),@Result)		
	END CATCH	
IF OBJECT_ID('tempdb..#TmbTblFileInput') IS NOT NULL DROP TABLE #TmbTblFileInput
SELECT @Result AS Result		
END
GO
/****** Object:  StoredProcedure [dbo].[C3_FileWatcherPath]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_FileWatcherPath]
(@Project VARCHAR(100))
AS
BEGIN
	SELECT FolderPath +'|'+ FileExtn+'|'+
	CONVERT(VARCHAR,WatcherTime) +'|'+ CONVERT(VARCHAR,DBTime) AS Result
	FROM C3_FileWatcher(NOLOCK) 
	WHERE Project = @Project AND IsActive = 1
	ORDER BY CreatedOn DESC
END
GO
/****** Object:  StoredProcedure [dbo].[CISOAccess]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOAccess]
(@NTUserName VARCHAR(150))
AS
BEGIN
	/*
	DECLARE @NTUserName VARCHAR(150) = 'saravanakuma.r'	
	*/

	DECLARE @Result VARCHAR(150),@SelectUser VARCHAR(150)
	SELECT @SelectUser = ud.NTLoginName 
	FROM AdminAccess(NOLOCK)AA
	INNER JOIN UserDetails(NOLOCK)UD
	ON AA.UserId = UD.UserId
	WHERE UD.[Status] = 4 AND UD.NTLoginName = @NTUserName

	if @NTUserName = @SelectUser
	BEGIN
		SET @Result = 'Success'
	END
	ELSE
	BEGIN
		SET @Result = 'Not an authorised user'
	END
	SELECT @Result AS Result
END
GO
/****** Object:  StoredProcedure [dbo].[CISOAppValidation]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOAppValidation]
(@NtUser VARCHAR(100),@AppName VARCHAR(100),@AppVersion VARCHAR(50))
AS
BEGIN
/*DECLARE @NtUser VARCHAR(100) = 'saravanakuma.r'
DECLARE @AppName VARCHAR(100) = 'CISOApp'
DECLARE @AppVersion VARCHAR(50) = '1.0.0.0'*/
DECLARE @vResult VARCHAR(50) = ''
DECLARE @aResult VARCHAR(50) = ''
DECLARE @Result VARCHAR(100) = ''

IF (SELECT TOP 1 VersionId FROM ToolsVersion(NOLOCK)
WHERE ToolName = @AppName ORDER BY CreatedOn DESC) = @AppVersion
BEGIN
SET @vResult = 'Sucess'
END
ELSE
BEGIN
SET @vResult = 'Please use updated version file'
END

SET @aResult = (SELECT TOP 1 CASE WHEN LEN(UD.NTLoginName) > 0 
THEN 'Sucess' ELSE 'Not an authorised user' END AS NTUser
FROM AdminAccess(NOLOCK)AA
INNER JOIN UserDetails(NOLOCK)UD ON ud.UserId = aa.UserId
WHERE ud.NTLoginName = @NtUser AND ud.[Status] = 4)

SELECT @vResult +'|'+ ISNULL(@aResult,'Not an authorised user') AS Result
END
GO
/****** Object:  StoredProcedure [dbo].[CISOAssetInfo]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOAssetInfo] (@Location VARCHAR(1000) = null, @Facility VARCHAR(1000) = null)
AS
BEGIN
	IF OBJECT_ID('tempdb..#TempTblAssetInfo') IS NOT NULL DROP TABLE #TempTblAssetInfo

	SELECT HN.HostNameID,HN.HostName,AssetID,ServiceID,
	FL.Facility,FL.[Location],
	CONVERT(VARCHAR(100),NULL) AppServiceID,CONVERT(VARCHAR(100),NULL) Remarks
	INTO #TempTblAssetInfo 
	FROM CISOHostNameLookup(NOLOCK)HN
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	WHERE HN.IsActive = 1 AND FL.IsActive = 1

	UPDATE T SET T.AppServiceID = AID.KeyValues, T.Remarks = 'Issue'
	FROM(
	SELECT TMP.HostNameID,AssetID,ServiceID,KeyValues 
	FROM #TempTblAssetInfo TMP
	INNER JOIN CISORegistryKeyValues(NOLOCK)KV
	ON TMP.HostNameID = KV.HostNameID 
	AND TMP.ServiceID != KV.KeyValues AND KV.KeyValues != 'INVALID'
	WHERE KV.AppID = 13 AND KV.ComputerStatus = 1 AND ErrorID = 0
	AND RunAt BETWEEN GETDATE()-7 AND GETDATE()
	GROUP BY TMP.HostNameID,AssetID,ServiceID,KeyValues 
	)AID
	INNER JOIN #TempTblAssetInfo T
	ON t.HostNameID = AID.HostNameID

	SELECT HostNameID,HostName,AssetID,ServiceID,Facility,[Location],AppServiceID,Remarks
	FROM #TempTblAssetInfo
	where 1 = case when @Facility is null then 1 when Facility = @Facility then 1 else 0 end
		and 1 = case when @Location is null then 1 when [Location] = @Location then 1 else 0 end
	ORDER BY Remarks DESC,Facility ASC

	IF OBJECT_ID('tempdb..#TempTblAssetInfo') IS NOT NULL DROP TABLE #TempTblAssetInfo
END
GO
/****** Object:  StoredProcedure [dbo].[CISOBulkAssetData]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOBulkAssetData]
(
	@AssetData AssetData READONLY,
	@CreatedBy VARCHAR(150)
)
AS
BEGIN
BEGIN TRAN
BEGIN TRY
IF(OBJECT_ID('tempdb..#TempAssetTable') IS NOT NULL)                                                    
DROP TABLE #TempAssetTable

CREATE TABLE #TempAssetTable
(
HostName		VARCHAR(150) not null,
FacilityID      INT not null,
CreatedBy		VARCHAR(150),
CreatedOn       datetime null,
AssetID		    VARCHAR(150),
ServiceID    	VARCHAR(300)
)

INSERT INTO #TempAssetTable(HostName,AssetID, ServiceID, FacilityID, CreatedBy, CreatedOn)
	select a.HostName, a.AssetID, a.ServiceID, b.FacilityID, @CreatedBy, getdate() CreatedOn  from @AssetData a
		inner join CISOFacilityLookup b
			on a.Facility = b.Facility

INSERT INTO TempCISOHostNameLookup(HostName,FacilityID,CreatedBy,CreatedOn,AssetID,ServiceID)
SELECT HostName, FacilityID, CreatedBy, CreatedOn, AssetID, ServiceID from #TempAssetTable

EXEC CISOAssetInfo

COMMIT TRAN
END TRY
BEGIN CATCH
       ROLLBACK TRAN
END CATCH
IF(OBJECT_ID('tempdb..#TempAssetTable') IS NOT NULL)                                                    
DROP TABLE #TempAssetTable 
END
GO
/****** Object:  StoredProcedure [dbo].[CISODeleteAssetData]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISODeleteAssetData]
(
	@HostNameID			INT,
	@locationName       VARCHAR(200) = null,
	@facilityName       VARCHAR(200) = null	
)
AS
BEGIN

update CISOHostNameLookup set IsActive = 0 where HostNameID = @HostNameID

EXEC CISOAssetInfo @locationName, @facilityName

END
GO
/****** Object:  StoredProcedure [dbo].[CISOEditOSPatchValue]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CISOEditOSPatchValue]
(
	@OSID		INT,
	@Monthly	VARCHAR(100),
	@Security	VARCHAR(100),
	@Servicing	VARCHAR(100),
	@ReleaseDate DATETIME,
	@IsActive	BIT
)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX)
	BEGIN TRY
		BEGIN TRANSACTION
		if @IsActive = 1
		BEGIN
			UPDATE CISORegistryDefaultValue 
			SET Monthly = @Monthly,[Security] = @Security, 
			Servicing = @Servicing,ReleaseDate = @ReleaseDate
			WHERE ID = @OSID
		END
		ELSE
		BEGIN
			UPDATE CISORegistryDefaultValue SET IsActive = @IsActive WHERE ID = @OSID
		END
		COMMIT TRANSACTION
		SET @Result = 'Success'
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @Result = ERROR_MESSAGE() 
	END CATCH
	SELECT @Result AS Result

	SELECT ID,OSName,OSVersion OSBuild,Monthly,[Security],Servicing,format(ReleaseDate, 'MM-dd-yyyy') EndLife,IsActive
	FROM CISORegistryDefaultValue(NOLOCK)
	WHERE IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[CISOEditRegistryKey]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOEditRegistryKey]
(
	@AppID				INT,
	@RegistryHive		VARCHAR(150),
	@RegistryPath		VARCHAR(300),
	@RegistryValueName	VARCHAR(100),
	@DefaultValue		VARCHAR(150),
	@CreatedBy			VARCHAR(150),
	@IsActive			BIT
)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX)
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO CISORegistryKeyPathEditLog(AppID,AppName,RegistryHive,RegistryPath,RegistryValueName,DefaultValue,IsActive,CreatedOn,CreatedBy)
			SELECT ID,AppName,RegistryHive,RegistryPath,RegistryValueName,DefaultValue,IsActive,CreatedOn,CreatedBy
			FROM CISORegistryKeyPath(NOLOCK)
			WHERE ID = @AppID
			IF @IsActive = 1
			BEGIN
				UPDATE CISORegistryKeyPath 
				SET RegistryHive = @RegistryHive, RegistryPath = @RegistryPath, 
				RegistryValueName = @RegistryValueName, DefaultValue = @DefaultValue, CreatedBy = @CreatedBy
				WHERE ID = @AppID
			END
			ELSE
			BEGIN
				UPDATE CISORegistryKeyPath SET IsActive = @IsActive WHERE ID = @AppID
			END
		COMMIT TRANSACTION
		SET @Result = 'Success' 
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @Result = ERROR_MESSAGE() 
	END CATCH
	SELECT @Result AS Result
	SELECT ID,AppName,RegistryHive,RegistryPath,RegistryValueName,DefaultValue ActualValue,IsActive
	FROM CISORegistryKeyPath(NOLOCK) 
	WHERE IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[CISOErrorLogsInsert]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Promodh Kumar
-- Create date: 13/04/2020
-- Description:	CISO Error Logs Insert
-- =============================================
CREATE PROCEDURE [dbo].[CISOErrorLogsInsert] 
	@ErrorMessage varchar(max),
	@EventDetails varchar(2000),
	@ErrorOn datetime,
	@UserName varchar(50),
	@HostName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    insert into CISOErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserName, HostName)
		values (@EventDetails, @ErrorMessage, @ErrorOn, @UserName, @HostName)
END
GO
/****** Object:  StoredProcedure [dbo].[CISOFacilityMaster]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOFacilityMaster]
(@Location VARCHAR(1500))
AS
BEGIN
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility
	CREATE TABLE #TempTblFacility([Location] VARCHAR(500)) 

	INSERT INTO #TempTblFacility              
	SELECT items FROM SplitStringfn(@Location,',')  
	
	IF @Location IS NOT NULL
	BEGIN
		SELECT DISTINCT Facility
		FROM CISOFacilityLookup(NOLOCK)FL
		INNER JOIN #TempTblFacility TMP
		ON FL.[Location] = TMP.[Location]
		WHERE --[Location] = @Location
		IsActive = 1
	END
	ELSE
	BEGIN
		SELECT DISTINCT Facility
		FROM CISOFacilityLookup(NOLOCK)
		WHERE IsActive = 1
	END
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility
END
GO
/****** Object:  StoredProcedure [dbo].[CISOGetNetworkStatus]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOGetNetworkStatus]
(@ID INT)
AS
BEGIN
	--DECLARE @ID INT = 50
	IF EXISTS(SELECT Id FROM CISOUserNetworkStatus(NOLOCK)
		WHERE ConnectionStatus = 'UP' AND CreatedTime IS NOT NULL AND ID = @ID)
	BEGIN
		SELECT Id UserId, NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IP4Address IPAddress, Connectivity, DomainType, 
		IsConnected, IsConnectedToInternet, CONVERT(VARCHAR(30), CreatedTime, 121) AS CreatedTime, 
		CONVERT(VARCHAR(30), ConnectedTime, 121) as LastConnectedTime, NetworkDescription, ConnectionName
		FROM CISOUserNetworkStatus(NOLOCK)
		WHERE ConnectionStatus = 'UP' AND CreatedTime IS NOT NULL AND ID = @ID
	END
	ELSE
	BEGIN
		SELECT Id UserId, NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IP4Address IPAddress, Connectivity, DomainType, 
		IsConnected, IsConnectedToInternet, CONVERT(VARCHAR(30), CreatedTime, 121) AS CreatedTime, 
		CONVERT(VARCHAR(30), ConnectedTime, 121) as LastConnectedTime, NetworkDescription, ConnectionName
		FROM CISOUserNetworkStatus(NOLOCK)
		WHERE ID = @ID
	END
END
GO
/****** Object:  StoredProcedure [dbo].[CISOGetRegistryInfo]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CISOGetRegistryInfo]
AS
BEGIN
	SELECT ID,AppName,RegistryHive,RegistryPath,RegistryValueName,DefaultValue ActualValue,IsActive
	FROM CISORegistryKeyPath(NOLOCK) 
	WHERE IsActive = 1

	SELECT ID,OSName,OSVersion OSBuild,Monthly,[Security],Servicing,format(ReleaseDate, 'MM-dd-yyyy') EndLife,IsActive
	FROM CISORegistryDefaultValue(NOLOCK)
	WHERE IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[CISOHostNameList]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOHostNameList]
AS
BEGIN
	SELECT HN.HostName, FL.Facility,FL.[Location]
	FROM CISOHostNameLookup(NOLOCK)HN
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	WHERE HN.IsActive = 1 AND FL.IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[CISOHotFixInfo]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CISOHotFixInfo]
AS
BEGIN
IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
IF OBJECT_ID('tempdb..#TmbTblOutput') IS NOT NULL DROP TABLE #TmbTblOutput
IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF

DECLARE @Date datetime = getdate()

CREATE TABLE #TmbTblOutput
(
HostNameID					INT,
ComputerStatus				INT,
OSName						VARCHAR(250),
OSVersion					VARCHAR(250),
OSPatch						VARCHAR(250),
SymantecStatus				INT,
--SymantecVersion				INT,
--EDPAPath					INT,
Echolock					INT,
--FORCEPOINT					INT,
--BigFix						INT,
--ManageEngineAssetExplorer	INT,
Monthly						INT,
[Security]					INT,
Servicing					INT
)

CREATE TABLE #TmbTblHotFixOutput
(
OSName			VARCHAR(250),
OSPatch			VARCHAR(250),
Monthly			INT DEFAULT 0,
[Security]		INT DEFAULT 0,
Servicing		INT DEFAULT 0,
IssMonthly	INT DEFAULT 0,
IssSecurity	INT DEFAULT 0,
IssServicing	INT DEFAULT 0,
ErrMonthly	INT DEFAULT 0,
ErrSecurity	INT DEFAULT 0,
ErrServicing	INT DEFAULT 0
)

CREATE TABLE #TmbTblColumn(ID INT,ColumnName VARCHAR(200))

DECLARE @STime DATETIME,@ETime DATETIME

SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), @Date,101))
SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,@Date), 0)))

SELECT HostNameID,ComputerStatus,
OSName,OSVersion,OSPatch,SymantecStatus,SymantecVersion,EDPAPath,Echolock,FORCEPOINT,BigFix,ManageEngineAssetExplorer,HotFixID	
INTO #TmbTblPivot
FROM
(
	SELECT 
	HostNameID,ComputerStatus,KP.AppName,KeyValues
	FROM CISORegistryKeyValues(NOLOCK)KV
	INNER JOIN CISORegistryKeyPath(NOLOCK)KP
	ON KP.ID = KV.AppID
	WHERE KV.ComputerStatus = 1
	AND RunAt BETWEEN @STime AND @ETime
)X
PIVOT (max(KeyValues)
FOR AppName IN (OSName,OSVersion,OSPatch,SymantecStatus,SymantecVersion,EDPAPath,Echolock,FORCEPOINT,BigFix,ManageEngineAssetExplorer,HotFixID)) AS PVTTable 
WHERE PVTTable.OSName != '-'

SELECT TMP.HostNameID,TMP.HotFixID,DV.Monthly,DV.[Security],DV.Servicing
INTO #TmbTblHotFix FROM #TmbTblPivot TMP
LEFT JOIN CISORegistryDefaultValue(NOLOCK)DV
ON DV.OSName = TMP.OSName AND DV.OSVersion = TMP.OSPatch

INSERT INTO #TmbTblOutput(HostNameID,ComputerStatus,OSName,OSVersion,OSPatch)
SELECT HostNameID,ComputerStatus,OSName,OSVersion,OSPatch 
FROM #TmbTblPivot

UPDATE PVT SET PVT.Monthly = 1
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.Monthly IS NOT NULL
	Where a.HotFixID LIKE '%' + q.Monthly + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE PVT SET PVT.Monthly = 0
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.Monthly IS NOT NULL
	Where a.HotFixID NOT LIKE '%' + q.Monthly + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE OT SET OT.Monthly = 2
FROM(
SELECT HostNameID
FROM #TmbTblHotFix
WHERE HotFixID like 'Err: %'
)NR
INNER JOIN #TmbTblOutput OT
ON NR.HostNameID = OT.HostNameID AND OT.Monthly = 0 

UPDATE PVT SET PVT.[Security] = 1
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.[Security] IS NOT NULL
	Where a.HotFixID LIKE '%' + q.[Security] + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE PVT SET PVT.[Security] = 0
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.[Security] IS NOT NULL
	Where a.HotFixID NOT LIKE '%' + q.[Security] + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE OT SET OT.[Security] = 2
FROM(
SELECT HostNameID
FROM #TmbTblHotFix
WHERE HotFixID like 'Err: %'
)NR
INNER JOIN #TmbTblOutput OT
ON NR.HostNameID = OT.HostNameID AND OT.[Security] = 0 

UPDATE PVT SET PVT.Servicing = 1
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.Servicing IS NOT NULL
	Where a.HotFixID LIKE '%' + q.Servicing + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE PVT SET PVT.Servicing = 0
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.Servicing IS NOT NULL
	Where a.HotFixID NOT LIKE '%' + q.Servicing + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE OT SET OT.Servicing = 2
FROM(
SELECT HostNameID
FROM #TmbTblHotFix
WHERE HotFixID like 'Err: %'
)NR
INNER JOIN #TmbTblOutput OT
ON NR.HostNameID = OT.HostNameID AND OT.Servicing = 0 

/*---STATUS VALUE DESCRIPTION---*/
/* 
0 - Issue System need to updated patch
1 - No issues
2 - Error
*/

DECLARE @SymantecStatus VARCHAR(100),@Echolock VARCHAR(100)

INSERT INTO #TmbTblColumn(ID,ColumnName)VALUES(1,'SymantecStatus')
INSERT INTO #TmbTblColumn(ID,ColumnName)VALUES(2,'Echolock')

DECLARE @Count INT, @eCount INT, 
@SqlQuery VARCHAR(MAX),@sColumn VARCHAR(100),
@Count1 INT , @Condition VARCHAR(250), @uValue VARCHAR(150)

SELECT @SymantecStatus = DefaultValue 
FROM CISORegistryKeyPath(NOLOCK) 
WHERE ID = 4 AND IsActive = 1

SELECT @Echolock = DefaultValue 
FROM CISORegistryKeyPath(NOLOCK) 
WHERE ID = 7 AND IsActive = 1

SET @Count = 1
SET @eCount = (SELECT COUNT(ID) FROM #TmbTblColumn)
SET @Count1 = 1

WHILE @Count <= @eCount
BEGIN
	SELECT TOP 1 @sColumn = ColumnName FROM #TmbTblColumn WHERE id = @Count
	WHILE @Count1 <= 3	
	BEGIN		
		if @Count1 = 1 	
		BEGIN 
			SET @Condition = '@' + @sColumn 
			IF @Condition = '@SymantecStatus' BEGIN  SET @Condition =  ' = ''' + @SymantecStatus  + '''' END
			IF @Condition = '@Echolock' BEGIN  SET @Condition =  ' = ''' + @Echolock  + '''' END
			SET @uValue = @sColumn + ' = 1'
		END
		if @Count1 = 2 	
		BEGIN 
			SET @Condition = '@' + @sColumn
			IF @Condition = '@SymantecStatus' BEGIN  SET @Condition =  ' != ''' + @SymantecStatus  + '''' END
			IF @Condition = '@Echolock' BEGIN  SET @Condition =  ' != ''' + @Echolock  + '''' END 
			SET @uValue = @sColumn + ' = 0'
		END
		if @Count1 = 3 	
		BEGIN 
			SET @Condition = ' LIKE ''Err: %'''
			SET @uValue = @sColumn + ' = 2' 
		END
		
		SET @SqlQuery = 'UPDATE PVT SET PVT.' + @uValue + '
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @sColumn + @Condition + ' 
		)Mon
		INNER JOIN #TmbTblOutput PVT
		ON mon.HostNameID = PVT.HostNameID'	
		--PRINT @SqlQuery	
		EXEC(@SqlQuery)	  
	   SET @Count1 = @Count1 +1
	   SET @Condition = ''
	   SET @uValue = ''
   END
   SET @Count = @Count + 1
   SET @Count1 = 1
END

INSERT INTO #TmbTblHotFixOutput(OSName,OSPatch)
SELECT OSName,OSPatch 
FROM #TmbTblOutput
GROUP BY OSName,OSPatch
ORDER BY 2

SELECT ROW_NUMBER() OVER(ORDER BY [name]) SNo,[Name]
INTO #TmbTblHF
FROM tempdb.SYS.COLUMNS
WHERE OBJECT_ID = OBJECT_ID('tempdb..#TmbTblHotFixOutput')
AND [name] NOT IN('OSName','OSPatch')

DECLARE @hfCount INT, @hfeCount INT, @hfsColumn VARCHAR(200)
,@SqlQueryHF VARCHAR(MAX),@CLreview VARCHAR(50),@ConditionHF VARCHAR(100)
,@addCondition VARCHAR(150)
SET @hfCount = 1
SET @hfeCount = (SELECT COUNT(SNo) FROM #TmbTblHF)

WHILE @hfCount <= @hfeCount
BEGIN
	SELECT TOP 1 @hfsColumn = [Name] FROM #TmbTblHF WHERE SNo = @hfCount
	SET @CLreview = LEFT(@hfsColumn,3)
	if @CLreview = 'Err'
	BEGIN
		SET @ConditionHF = '2'
		SET @addCondition = REPLACE(@hfsColumn,'Err','')
	END
	ELSE IF @CLreview = 'Iss'
	BEGIN
		SET @ConditionHF = '0'
		SET @addCondition = REPLACE(@hfsColumn,'Iss','')
	END
	ELSE
	BEGIN
		SET @ConditionHF = '1'
		SET @addCondition = @hfsColumn
	END

	SET @SqlQueryHF = 'UPDATE HFO SET HFO.' + @hfsColumn + ' = HT.cnt
	FROM(
		SELECT a.OSName,a.OSPatch,COUNT(HostNameID)cnt 
		FROM #TmbTblOutput a
		INNER JOIN #TmbTblHotFixOutput b
		ON a.OSName = b.OSName AND a.OSPatch = b.OSPatch
		WHERE a.Monthly = ' + @ConditionHF + '
		AND a.' + @addCondition + ' IS NOT NULL  
		GROUP BY a.OSName,a.OSPatch
	)HT
	INNER JOIN #TmbTblHotFixOutput HFO
	ON HT.OSName = HFO.OSName AND HT.OSPatch = HFO.OSPatch'	
	--PRINT @SqlQueryHF
	EXEC(@SqlQueryHF)
	SET @hfCount = @hfCount + 1
END

UPDATE #TmbTblHotFixOutput SET OSPatch = '-' WHERE OSPatch = 'No Registry Key'

SELECT * FROM #TmbTblHotFixOutput

END
GO
/****** Object:  StoredProcedure [dbo].[CISOLocationFacility]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOLocationFacility]
AS
BEGIN
	SELECT DISTINCT [Location]
	FROM CISOFacilityLookup(NOLOCK)
	WHERE IsActive = 1 AND [Location] != 'ALL'
	
	SELECT Facility
	FROM CISOFacilityLookup(NOLOCK)
	WHERE IsActive = 1
	AND Facility != 'Default'
END
GO
/****** Object:  StoredProcedure [dbo].[CISONewAssetData]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISONewAssetData]
(
	@HostName			VARCHAR(150),
	@AssetID		    VARCHAR(150),
	@ServiceID    		VARCHAR(300),
	@Facility       	VARCHAR(100),
	@CreatedBy			VARCHAR(150),
	@locationName       VARCHAR(200),
	@facilityName       VARCHAR(200)	
)
AS
BEGIN

DECLARE @FacilityId INT;

SET @FacilityId = (SELECT FacilityID from CISOFacilityLookup where Facility = @Facility)

	INSERT INTO TempCISOHostNameLookup(HostName,FacilityID,CreatedBy,CreatedOn,AssetID,ServiceID)
	VALUES(@HostName, @FacilityId, @CreatedBy, getdate(), @AssetID, @ServiceID)

	EXEC CISOAssetInfo @locationName, @facilityName
END
GO
/****** Object:  StoredProcedure [dbo].[CISONewRegistryKey]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CISONewRegistryKey]
(
	@AppName			VARCHAR(150),
	@RegistryHive		VARCHAR(150),
	@RegistryPath		VARCHAR(300) = NULL,
	@RegistryValueName	VARCHAR(100) = NULL,
	@DefaultValue		VARCHAR(150) = NULL,
	@CreatedBy			VARCHAR(150)
)
AS
BEGIN
	INSERT INTO CISORegistryKeyPath(AppName,RegistryHive,RegistryPath,RegistryValueName,DefaultValue,CreatedBy)
	VALUES(@AppName,@RegistryHive,@RegistryPath,@RegistryValueName,@DefaultValue,@CreatedBy)

	SELECT ID,AppName,RegistryHive,RegistryPath,RegistryValueName,DefaultValue ActualValue,IsActive
	FROM CISORegistryKeyPath(NOLOCK) 
	WHERE IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[CISOOSInfo]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOOSInfo]
(
	@Date DATETIME
)
AS
BEGIN
	IF OBJECT_ID('tempdb..#TmbTblOSinfo') IS NOT NULL DROP TABLE #TmbTblOSinfo

	CREATE TABLE #TmbTblOSinfo
	(
	RunAt		DATE,
	OS			VARCHAR(150),
	OSCount		INT DEFAULT 0,
	Critical	INT DEFAULT 0,
	Warning		INT DEFAULT 0,	
	)
	DECLARE @STime DATETIME,@ETime DATETIME

	SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), @Date,101))
	SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,@Date), 0)))

	INSERT INTO #TmbTblOSinfo(RunAt,OS)
	SELECT  CONVERT(VARCHAR(25),@Date,120),OSName
	FROM CISORegistryDefaultValue(NOLOCK)
	GROUP BY OSName

	UPDATE TMP set TMP.OSCount = RKV.OSCount
	FROM( 
		SELECT KeyValues,COUNT(KeyValues)AS OSCount 
		FROM CISORegistryKeyValues(NOLOCK)
		WHERE AppID = 1 AND ComputerStatus = 1
		AND RunAt BETWEEN @STime AND @ETime
		GROUP BY KeyValues
	)RKV
	INNER JOIN #TmbTblOSinfo TMP
	ON TMP.OS = RKV.KeyValues

	SELECT * FROM #TmbTblOSinfo
	IF OBJECT_ID('tempdb..#TmbTblOSinfo') IS NOT NULL DROP TABLE #TmbTblOSinfo
END
GO
/****** Object:  StoredProcedure [dbo].[CISOOutputData]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOOutputData]
AS
BEGIN

	IF OBJECT_ID('tempdb..#TmpTblDeviceInfo') IS NOT NULL DROP TABLE #TmpTblDeviceInfo
	IF OBJECT_ID('tempdb..#TmpTblNetworkInfo') IS NOT NULL DROP TABLE #TmpTblNetworkInfo
	IF OBJECT_ID('tempdb..#TmpTblCType') IS NOT NULL DROP TABLE #TmpTblCType
	IF OBJECT_ID('tempdb..#TmpTblNW') IS NOT NULL DROP TABLE #TmpTblNW

	DECLARE @sTime DATETIME = GETDATE()-30
	CREATE TABLE #TmpTblCType(UserId INT, NName VARCHAR(MAX))

	CREATE TABLE #TmpTblNW (ID INT,
	NetworkInterface VARCHAR(MAX),NetworkName VARCHAR(MAX),ConnectionStatus VARCHAR(MAX),MACAddress VARCHAR(MAX),IPAddress VARCHAR(MAX),
	Connectivity VARCHAR(MAX),DomainType VARCHAR(MAX),IsConnected VARCHAR(MAX),IsConnectedToInternet VARCHAR(MAX),CreatedTime VARCHAR(MAX),
	ConnectedTime VARCHAR(MAX),NetworkDescription VARCHAR(MAX),ConnectionName VARCHAR(MAX))

	DECLARE @ID INT, @ID1 INT

	DECLARE @NetworkInterface VARCHAR(MAX),@NetworkName VARCHAR(MAX), @ConnectionStatus VARCHAR(MAX), 
	@MACAddress VARCHAR(MAX), @IPAddress NVARCHAR(MAX),@Connectivity VARCHAR(MAX), @DomainType VARCHAR(MAX),
	@IsConnected VARCHAR(MAX), @IsConnectedToInternet VARCHAR(MAX),@CreatedTime VARCHAR(MAX), 
	@ConnectedTime VARCHAR(MAX), @NetworkDescription VARCHAR(MAX), @ConnectionName VARCHAR(MAX)

	SET NOCOUNT ON;

	SELECT 
	Id,DI.UserAccount,HostName,UserDomain,SystemType,/*ServiceTag,*/ DI.BIOSSerialNumber, CONVERT(VARCHAR(150),NULL) ConnectionType,
	MachineMake,MachineModel,OSVersion,NULLIF(CAST((CONVERT(bigint,TotalMemory) / 1073741824) AS VARCHAR),0) MemoryGB
	,ProcessorId,ProcessorName,ProcessorCount,BIOSName,BIOSVersion,BIOSMake,UpTime SystemUpTime,DI.RunAt ScanAt
	INTO #TmpTblDeviceInfo
	FROM CISOUserDeviceInfo(NOLOCK)DI
	INNER JOIN
		   (SELECT BIOSSerialNumber,MAX(RunAt) RunAt
		   FROM CISOUserDeviceInfo(NOLOCK)
		   WHERE UserAccount != 'SYSTEM' AND IsActive = 1 AND RunAt >= @sTime AND VersionId = '2020.04.28.001'
		   GROUP BY BIOSSerialNumber) MX
	ON DI.BIOSSerialNumber = MX.BIOSSerialNumber AND DI.RunAt = MX.RunAt
	
	/*Get the network UP details*/
	SELECT /*RN = ROW_NUMBER() OVER (PARTITION BY BIOSSerialNumber,HostName ORDER BY ScanAt DESC),*/
	NS.id UserId,NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IP4Address AS IPAddress,Connectivity,
	DomainType,IsConnected,IsConnectedToInternet,CreatedTime,ConnectedTime,NetworkDescription,ConnectionName
	INTO #TmpTblNetworkInfo
	FROM #TmpTblDeviceInfo tmp
	INNER JOIN CISOUserNetworkStatus(NOLOCK)NS
	ON tmp.Id = ns.Id
	WHERE NS.ConnectionStatus = 'UP' AND NS.CreatedTime IS NOT NULL
	/*Get the network Down details*/
	INSERT INTO #TmpTblNetworkInfo(/*RN,*/UserId, NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress, Connectivity, DomainType, 
	IsConnected, IsConnectedToInternet, CreatedTime, ConnectedTime, NetworkDescription, ConnectionName)
	SELECT /*RN = ROW_NUMBER() OVER (PARTITION BY BIOSSerialNumber,HostName ORDER BY ScanAt DESC),*/
	NS.Id AS UserId,NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IP4Address,Connectivity,DomainType,IsConnected,IsConnectedToInternet,
	CreatedTime,ConnectedTime as LastConnectedTime,NetworkDescription,ConnectionName
	FROM CISOUserNetworkStatus(NOLOCK)NS
	INNER JOIN 
		   (SELECT Id,BIOSSerialNumber,HostName,ScanAt FROM #TmpTblDeviceInfo a
		   LEFT JOIN #TmpTblNetworkInfo b
		   ON a.Id = b.UserId
		   WHERE b.UserId IS NULL)tmp
	ON ns.Id = tmp.Id 

	/*Get the Connection Type*/
	DECLARE ntCursor CURSOR
	READ_ONLY  FOR 
	SELECT DISTINCT UserId FROM #TmpTblNetworkInfo

	OPEN ntCursor
		   FETCH NEXT FROM ntCursor INTO  @ID
		   WHILE @@FETCH_STATUS = 0  
				  BEGIN  
				  INSERT INTO #TmpTblCType(UserId,NName)
						 SELECT @ID, SUBSTRING( 
						 ( 
								SELECT '|' + NetworkInterface +'|' +NetworkName AS 'data()'
									  FROM #TmpTblNetworkInfo 
									   WHERE UserId = @ID
									  FOR XML PATH('') 
						 ), 2 , 9999)
						 FETCH NEXT FROM ntCursor INTO @ID
				  END  
	CLOSE ntCursor  
	DEALLOCATE ntCursor 

	/*Update the connection type*/
	UPDATE DI SET DI.ConnectionType = CT.ConnectionType
	FROM (
		   SELECT UserId,
		   CASE WHEN NNAME LIKE '%Ethernet|%Remote NDIS%' THEN 'Dongle'
		   ELSE
		   CASE WHEN NNAME LIKE '%Ethernet%RNDIS%' THEN 'Dongle'	   
		   ELSE 
		   CASE WHEN NNAME LIKE '%Ethernet|Realtek %' THEN 'LAN'
		   ELSE
		   CASE WHEN NNAME LIKE '%Ethernet|Intel(R) Ethernet%' THEN 'LAN'
		   ELSE       
		   CASE WHEN NNAME LIKE '%Wireless%|% Wireless%' THEN 'WI-FI'  
		   ELSE NULL END END END END END AS ConnectionType
		   FROM #TmpTblCType)CT
	INNER JOIN #TmpTblDeviceInfo DI
	ON DI.ID = CT.UserId

	/*Merge to single line data*/
	DECLARE NWCursor CURSOR  
	READ_ONLY  FOR 
	SELECT DISTINCT UserId FROM #TmpTblNetworkInfo	 
			
	OPEN NWCursor
	FETCH NEXT FROM NWCursor INTO  @ID1
	WHILE @@FETCH_STATUS = 0  
		BEGIN
		-------
		SET @NetworkInterface = NULL; SET @NetworkName = NULL; SET @ConnectionStatus = NULL; SET @MACAddress = NULL;
		SET @IPAddress = NULL; SET @Connectivity = NULL; SET @DomainType = NULL; SET @IsConnected = NULL;
		SET @IsConnectedToInternet = NULL; SET @CreatedTime = NULL; SET @ConnectedTime = NULL;
		SET @NetworkDescription = NULL; SET @ConnectionName = NULL;

		SELECT 
			@NetworkInterface  = ISNULL(@NetworkInterface,'') + '[' + ISNULL(NetworkInterface,'-') +']'
			,@NetworkName = ISNULL(@NetworkName,'') + '[' + ISNULL(NetworkName,'-') +']'
			,@ConnectionStatus = ISNULL(@ConnectionStatus,'') + '[' + ISNULL(ConnectionStatus,'-') +']' 
			,@MACAddress = ISNULL(@MACAddress,'') + '[' + ISNULL(MACAddress,'-') +']'
			,@IPAddress = ISNULL(@IPAddress,'') + '[' + ISNULL(IPAddress,'-') +']'
			,@Connectivity = ISNULL(@Connectivity,'') + '[' + ISNULL(Connectivity,'-') +']'
			,@DomainType = ISNULL(@DomainType,'') + '[' + ISNULL(DomainType,'-') +']'
			,@IsConnected = ISNULL(@IsConnected,'') + '[' + ISNULL(CASE WHEN IsConnected = 1 THEN 'True' ELSE 'False' END,'-') +']'
			,@IsConnectedToInternet = ISNULL(@IsConnectedToInternet,'')
				+ '[' + ISNULL(CASE WHEN IsConnectedToInternet = 1 THEN 'True' ELSE 'False' END,'-') +']'
			,@CreatedTime = ISNULL(@CreatedTime,'') + '[' + ISNULL(CONVERT(VARCHAR(30),CreatedTime,121),'-')  +']'
			,@ConnectedTime = ISNULL(@ConnectedTime,'') + '[' + ISNULL(CONVERT(VARCHAR(30),ConnectedTime,121),'-')  +']'  
			,@NetworkDescription = ISNULL(@NetworkDescription,'') + '[' + ISNULL(NetworkDescription,'-') +']' 
			,@ConnectionName = ISNULL(@ConnectionName,'') + '[' + ISNULL(ConnectionName,'-') +']'
		FROM (SELECT NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IPAddress,Connectivity,
			DomainType,IsConnected,IsConnectedToInternet,CreatedTime,ConnectedTime,NetworkDescription,ConnectionName
			FROM #TmpTblNetworkInfo WHERE UserId = @ID1) AS Network_Info 
			-------
					   
			INSERT INTO #TmpTblNW(ID,NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IPAddress,Connectivity,
			DomainType,IsConnected,IsConnectedToInternet,CreatedTime,ConnectedTime,NetworkDescription,ConnectionName)              
			SELECT @ID1,@NetworkInterface ,@NetworkName , @ConnectionStatus, @MACAddress , @IPAddress ,@Connectivity 
			,@DomainType,@IsConnected,@IsConnectedToInternet,@CreatedTime,@ConnectedTime,@NetworkDescription,@ConnectionName                                 
		FETCH NEXT FROM NWCursor INTO @ID1
		END  
	CLOSE NWCursor  
	DEALLOCATE NWCursor 
	
	DECLARE @CreatedOn DATETIME = GETDATE()
	SET ANSI_WARNINGS OFF;
	
	BEGIN TRY
		BEGIN TRAN
			
			DELETE FROM CISOSystemDetails/*Delete all old Data*/

			INSERT INTO CISOSystemDetails(ID,UserAccount,[Location],Client,HostName,UserDomain,SystemType,SerialNumber,ConnectionType,MachineMake
					,MachineModel,OSVersion,MemoryGB,ProcessorId,ProcessorName,ProcessorCount,BIOSName,BIOSVersion,BIOSMake,UpTime
					,NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IPAddress,Connectivity,DomainType,IsConnected,IsConnectedToInternet
					,CreatedTime ,LastConnectedTime,NetworkDescription,ConnectionName,ScanAt,CreatedOn)
			SELECT a.Id, UserAccount
			,UD.LocationName AS [Location],UD.UserClient AS Client
			,HostName, UserDomain, SystemType, BIOSSerialNumber, ConnectionType, MachineMake, MachineModel, OSVersion, 
			MemoryGB, ProcessorId, ProcessorName, ProcessorCount, BIOSName,BIOSVersion, BIOSMake,
			CONVERT(VARCHAR(30), SystemUpTime, 121) AS UpTime,NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress, 
			Connectivity, DomainType, IsConnected, IsConnectedToInternet,CreatedTime, ConnectedTime as LastConnectedTime, NetworkDescription, ConnectionName,
			CONVERT(VARCHAR(30), ScanAt, 121) as ScanAt, @CreatedOn
			FROM #TmpTblDeviceInfo a
			LEFT JOIN #TmpTblNW  b
			ON a.Id = b.ID
			LEFT JOIN ilock.dbo.PBWUserMaster(NOLOCK)ud
			ON A.UserAccount = UD.UniqueId
			--ORDER BY ScanAt DESC
		COMMIT
	END TRY  
	BEGIN CATCH  
		ROLLBACK
		INSERT INTO CISOErrorLogs(EventDetails, ExceptionMessage, CreatedOn, UserName, HostName)  
		VALUES('DB Error - Job', ERROR_MESSAGE(), GETDATE(), 'Job', 'Job')  
	END CATCH
	
	SET ANSI_WARNINGS ON;
	SET NOCOUNT OFF; 
	IF OBJECT_ID('tempdb..#TmpTblDeviceInfo') IS NOT NULL DROP TABLE #TmpTblDeviceInfo
	IF OBJECT_ID('tempdb..#TmpTblNetworkInfo') IS NOT NULL DROP TABLE #TmpTblNetworkInfo
	IF OBJECT_ID('tempdb..#TmpTblCType') IS NOT NULL DROP TABLE #TmpTblCType
	IF OBJECT_ID('tempdb..#TmpTblNW') IS NOT NULL DROP TABLE #TmpTblNW
END
GO
/****** Object:  StoredProcedure [dbo].[CISORegistryKey]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISORegistryKey]  
AS  
BEGIN  
	SELECT ID,AppName,RegistryHive,RegistryPath,RegistryValueName  
	FROM CISORegistryKeyPath(NOLOCK)  
	WHERE IsActive = 1
	UNION
	SELECT ID,AppName,RegistryHive,RegistryPath,RegistryValueName  
	FROM CISORegistryKeyPath(NOLOCK)  
	WHERE IsActive = 0 AND AppName = 'SerialID'  
END
GO
/****** Object:  StoredProcedure [dbo].[CISORegistryKeyValueData]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISORegistryKeyValueData]
(		
	@XMLValue XML
)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX),@intPointer INT,@STime DATETIME,@ETime DATETIME
	IF OBJECT_ID('tempdb..#TmbTblRKV') IS NOT NULL DROP TABLE #TmbTblRKV
	IF OBJECT_ID('tempdb..#TmbTblHostId') IS NOT NULL DROP TABLE #TmbTblHostId
	
	SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), GETDATE(),101))
	SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,GETDATE()), 0)))
	SET @Result = ''

	BEGIN TRY
		
		EXEC SP_XML_PREPAREDOCUMENT @intPointer OUTPUT, @XMLValue

		SELECT * INTO #TmbTblRKV        
		FROM OPENXML(@intPointer,'/NewDataSet/XMLData',2)                          
		WITH 
		(
			ComputerName VARCHAR(MAX) 'ComputerName', ComputerStatus VARCHAR(MAX) 'ComputerStatus',
			AppID VARCHAR(MAX) 'AppID',KeyValues VARCHAR(MAX) 'KeyValues',RunAt VARCHAR(MAX) 'RunAt',
			ErrorID VARCHAR(MAX) 'ErrorID',CreatedBy VARCHAR(MAX) 'CreatedBy'       
		)    
		EXEC SP_XML_REMOVEDOCUMENT @intPointer
		
		BEGIN TRANSACTION
			IF (SELECT TOP 1 ComputerStatus FROM #TmbTblRKV)  = 1
			BEGIN			
					DECLARE @HostName VARCHAR(150)		
					SELECT TOP 1 @HostName = ComputerName FROM #TmbTblRKV
		
					IF NOT EXISTS(SELECT HostName FROM CISOHostNameLookup(NOLOCK)
					WHERE HostName = @HostName AND IsActive = 1)
					BEGIN
						IF EXISTS(SELECT HostName FROM CISOHostNameLookup(NOLOCK)
						WHERE HostName = @HostName)
						BEGIN
							UPDATE CISOHostNameLookup SET IsActive = 1 
							WHERE HostName = @HostName
						END
						ELSE
						BEGIN
							INSERT INTO CISOHostNameLookup(HostName,FacilityID,CreatedBy)
							VALUES(@HostName,0,'Insert')
						END
					END
			END

			SELECT HN.HostNameID,T1.ComputerStatus,T1.AppID,T1.KeyValues,T1.RunAt,T1.ErrorID,T1.CreatedBy
			INTO #TmbTblHostId 
			FROM #TmbTblRKV T1
			INNER JOIN CISOHostNameLookup(NOLOCK)HN
			ON HN.HostName = T1.ComputerName
			WHERE HN.IsActive = 1
			
			IF (SELECT COUNT(*) from #TmbTblHostId) > 0
			BEGIN				
				MERGE EchoLock.dbo.CISORegistryKeyValues AS KV
					USING (SELECT * FROM #TmbTblHostId) AS TMP
						ON tmp.HostNameID = kv.HostNameID AND tmp.AppID = kv.AppID 
						AND KV.RunAt BETWEEN @STime AND @ETime
					WHEN MATCHED AND (TMP.KeyValues !='-' AND TMP.ComputerStatus = 1)  THEN
						UPDATE SET KV.ComputerStatus = TMP.ComputerStatus, KV.KeyValues = TMP.KeyValues
							,KV.ErrorID = TMP.ErrorID,KV.RunAt = TMP.RunAt, KV.CreatedBy = TMP.CreatedBy					
					WHEN NOT MATCHED BY TARGET THEN 
						INSERT(HostNameID,ComputerStatus,AppID,KeyValues,RunAt,ErrorID,CreatedBy)
						VALUES(TMP.HostNameID,TMP.ComputerStatus,TMP.AppID,TMP.KeyValues,TMP.RunAt,TMP.ErrorID,TMP.CreatedBy)					
				;
			END
			ELSE
			BEGIN
				SET @Result = ' - No Hotname info'
			END
		COMMIT TRANSACTION

		DECLARE @OS VARCHAR(100), @Patch VARCHAR(50), @ErrID INT
		SELECT @OS =  KeyValues FROM #TmbTblRKV  WHERE AppID = 1
		SELECT @Patch =  KeyValues FROM #TmbTblRKV  WHERE AppID = 3
		SELECT @ErrID = ErrorID FROM #TmbTblRKV  WHERE AppID = 3
		
		IF (SELECT COUNT(*) FROM CISORegistryDefaultValue(NOLOCK)
		WHERE OSName+OSVersion = @OS+@Patch) = 0 
		AND (@Patch IS NOT NULL OR @Patch != '-') AND @ErrID = 0
		BEGIN
			INSERT INTO CISORegistryDefaultValue(OSName,OSVersion,IsActive)
			VALUES(@OS,@Patch,0)
		END

		SET @Result = 'Success'  + @Result		
	END TRY
	
	BEGIN CATCH  
		ROLLBACK TRANSACTION  
		SET @Result = ERROR_MESSAGE()
	END CATCH
	SELECT @Result AS Result
	IF OBJECT_ID('tempdb..#TmbTblRKV') IS NOT NULL DROP TABLE #TmbTblRKV
	IF OBJECT_ID('tempdb..#TmbTblHostId') IS NOT NULL DROP TABLE #TmbTblHostId
END
GO
/****** Object:  StoredProcedure [dbo].[CISOSystemDetailsApp]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOSystemDetailsApp]
(
	@Date DATETIME,
	@Location VARCHAR(1500) = NULL,
	@Facility VARCHAR(1500) = NULL,
	@AppName VARCHAR(500),
	@AppStatus VARCHAR(500)
)
AS
BEGIN	
	--DECLARE @Date DATETIME = '2020-02-06'
	--DECLARE @Location VARCHAR(250) = NULL
	--DECLARE @Facility VARCHAR(250) = NULL
	--DECLARE @AppName VARCHAR(500) = 'SymantecStatus'
	--DECLARE @AppStatus VARCHAR(500) = 'Healthy'

	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility	
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF	

	DECLARE @STime DATETIME,@ETime DATETIME
	DECLARE @SQLSysOverview VARCHAR(MAX)
	DECLARE @SqlQryRes VARCHAR(MAX),@AppResult VARCHAR(5)
	
	SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), @Date,101))
	SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,@Date), 0)))
	
	/*START*/
	DECLARE @ColumnName VARCHAR(MAX),@QryTmpTbl VARCHAR(500),@QryTmpTblPvt VARCHAR(500)
	DECLARE @APPColumnName VARCHAR(MAX),@SqlAppQry VARCHAR(MAX),@APPColumnPvt VARCHAR(MAX)

	CREATE TABLE #TempTblLocation([Location] VARCHAR(1500))
	CREATE TABLE #TempTblFacility([Facility] VARCHAR(1500))

	IF @Location IS NOT NULL
	BEGIN
		INSERT INTO #TempTblLocation                
		SELECT items FROM SplitStringfn(@Location,',') 
	END

	IF @Facility IS NOT NULL
	BEGIN
		INSERT INTO #TempTblFacility                
		SELECT items FROM SplitStringfn(@Facility,',') 
	END

	SET @SqlAppQry = ''

	CREATE TABLE #TmpTblOSAppInfo(HostNameID INT)
	SELECT  @ColumnName =  ISNULL(@ColumnName + ';','') + ' ALTER TABLE #TmpTblOSAppInfo ADD ' + QUOTENAME(AppName)  + ' INT'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND AppName != 'HotFixID'	
		UNION SELECT 'Monthly'
		UNION SELECT 'Security'
		UNION SELECT 'Servicing'
		UNION SELECT 'Status'
	)App

	EXEC(@ColumnName)

	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSName VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSVersion VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSBuild VARCHAR(250)

	CREATE TABLE #TmbTblPivot(HostNameID INT)

	SELECT  @APPColumnPvt =  ISNULL(@APPColumnPvt + ';','') + ' ALTER TABLE #TmbTblPivot ADD ' + QUOTENAME(AppName)  + ' VARCHAR(2000)'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 
	)App

	EXEC(@APPColumnPvt)

	SELECT @APPColumnName= ISNULL(@APPColumnName + ',','') + QUOTENAME(AppName)        
	FROM 
	(
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1
	) AS ReportTitle   


	SET @SqlAppQry = 'INSERT INTO #TmbTblPivot(HostNameID,' + @APPColumnName + ')
	SELECT HostNameID,' + @APPColumnName + '
	FROM
	(
		SELECT 
		KV.HostNameID,KP.AppName,KeyValues
		FROM CISORegistryKeyValues(NOLOCK)KV
		INNER JOIN CISORegistryKeyPath(NOLOCK)KP
		ON KP.ID = KV.AppID
		INNER JOIN CISOHostNameLookup(NOLOCK)HN
		ON KV.HostNameID = HN.HostNameID
		INNER JOIN CISOFacilityLookup(NOLOCK)FL
		ON HN.FacilityID = FL.FacilityID
		WHERE FL.IsActive = 1 AND HN.IsActive = 1 AND KV.ComputerStatus = 1
		AND RunAt BETWEEN '+ CHAR(39) + CONVERT(VARCHAR(50),@STime,121) + CHAR(39) + 
		' AND ' + CHAR(39) + CONVERT(VARCHAR(50),@ETime,121) + CHAR(39) +
		'
	)X
	PIVOT (MAX(KeyValues)
	FOR AppName IN (' + @APPColumnName + ')) AS PVTTable 
	WHERE PVTTable.OSName != ''-'''
	EXEC(@SqlAppQry)

	/*---<<<END>>>---*/

	CREATE TABLE #TmbTblHotFixOutput
	(
	OSName			VARCHAR(250),
	OSBuild			VARCHAR(250),
	Monthly			INT DEFAULT 0,
	[Security]		INT DEFAULT 0,
	Servicing		INT DEFAULT 0,
	IssueMonthly	INT DEFAULT 0,
	IssueSecurity	INT DEFAULT 0,
	IssueServicing	INT DEFAULT 0,
	ErrorMonthly	INT DEFAULT 0,
	ErrorSecurity	INT DEFAULT 0,
	ErrorServicing	INT DEFAULT 0
	)

	SELECT TMP.HostNameID,TMP.HotFixID,DV.Monthly,DV.[Security],DV.Servicing
	INTO #TmbTblHotFix 
	FROM #TmbTblPivot TMP
	LEFT JOIN CISORegistryDefaultValue(NOLOCK)DV
	ON DV.OSName = TMP.OSName AND DV.OSVersion = TMP.OSBuild

	INSERT INTO #TmpTblOSAppInfo(HostNameID,OSName,OSVersion,OSBuild)
	SELECT HostNameID,OSName,OSVersion,OSBuild 
	FROM #TmbTblPivot

	DECLARE @OSBuildCount INT,@OSBuildKB VARCHAR(150),@SQLOSBuildQry VARCHAR(MAX)
	SET @OSBuildCount = 1

	WHILE @OSBuildCount <= 3
	BEGIN
		IF @OSBuildCount = 1 BEGIN SET @OSBuildKB = '[Monthly]' END
		IF @OSBuildCount = 2 BEGIN SET @OSBuildKB = '[Security]' END
		IF @OSBuildCount = 3 BEGIN SET @OSBuildKB = '[Servicing]' END

		SET @SQLOSBuildQry = 'UPDATE PVT SET PVT.' + @OSBuildKB + ' = 1
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 0
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID NOT LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 2
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a		
			WHERE a.' + @OSBuildKB +' IS NOT NULL 
			AND a.HotFixID like ''Err: %''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID'

		EXEC(@SQLOSBuildQry)
		SET @OSBuildCount = @OSBuildCount + 1
		SET @OSBuildKB = ''
	END

	CREATE TABLE #TmbTblColumn(ID INT,AppID INT, ColumnName VARCHAR(200))
	INSERT INTO #TmbTblColumn(ID,AppID, ColumnName)
	SELECT ROW_NUMBER() OVER(ORDER BY [ID]),ID,AppName
	FROM CISORegistryKeyPath(NOLOCK) 
	WHERE IsActive = 1 AND AppName NOT LIKE 'OS%'

	DECLARE @APPColumn VARCHAR(200), @APPValue VARCHAR(200), @SQLQryApp VARCHAR(MAX)
	,@Count INT, @eCount INT--, @sColumn VARCHAR(150)

	SET @Count = 1
	SET @eCount = (SELECT COUNT(ID) FROM #TmbTblColumn)

	WHILE @Count <= @eCount
	BEGIN	
		SELECT TOP 1 @APPColumn = ColumnName FROM #TmbTblColumn WHERE id = @Count
		SELECT TOP 1 @APPValue = RKP.DefaultValue 
		FROM #TmbTblColumn a
		INNER JOIN CISORegistryKeyPath(NOLOCK)RKP
		ON A.AppID = RKP.ID
		WHERE A.ID = @Count

		SET @SQLQryApp = 'UPDATE PVT SET PVT.' + @APPColumn + ' = 1
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' = ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 0
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' != ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 2
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' LIKE ''Err: %''
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID'		

		EXEC(@SQLQryApp)
		SET @Count = @Count + 1
	END

	/**/
	INSERT INTO #TmbTblHotFixOutput(OSName,OSBuild)
	SELECT OSName,OSBuild 
	FROM #TmpTblOSAppInfo
	GROUP BY OSName,OSBuild
	ORDER BY 2

	SELECT ROW_NUMBER() OVER(ORDER BY [name]) SNo,[Name]
	INTO #TmbTblHF
	FROM tempdb.SYS.COLUMNS
	WHERE OBJECT_ID = OBJECT_ID('tempdb..#TmbTblHotFixOutput')
	AND [name] NOT IN('OSName','OSBuild')

	DECLARE @hfCount INT, @hfeCount INT, @hfsColumn VARCHAR(200)
	,@SqlQueryHF VARCHAR(MAX),@CLreview VARCHAR(50),@ConditionHF VARCHAR(100)
	,@addCondition VARCHAR(150)
	SET @hfCount = 1
	SET @hfeCount = (SELECT COUNT(SNo) FROM #TmbTblHF)

	WHILE @hfCount <= @hfeCount
	BEGIN
		SELECT TOP 1 @hfsColumn = [Name] FROM #TmbTblHF WHERE SNo = @hfCount
		SET @CLreview = LEFT(@hfsColumn,3)
		if @CLreview = 'Err'
		BEGIN
			SET @ConditionHF = '2'
			SET @addCondition = REPLACE(@hfsColumn,'Error','')
		END
		ELSE IF @CLreview = 'Iss'
		BEGIN
			SET @ConditionHF = '0'
			SET @addCondition = REPLACE(@hfsColumn,'Issue','')
		END
		ELSE
		BEGIN
			SET @ConditionHF = '1'
			SET @addCondition = @hfsColumn
		END

		SET @SqlQueryHF = 'UPDATE HFO SET HFO.' + @hfsColumn + ' = HT.cnt
		FROM(
			SELECT a.OSName,a.OSBuild,COUNT(HostNameID)cnt 
			FROM #TmpTblOSAppInfo a
			--INNER JOIN #TmbTblHotFixOutput b
			--ON a.OSName = b.OSName AND a.OSBuild = b.OSBuild
			WHERE a.' + @addCondition +' = ' + @ConditionHF + '
			AND a.' + @addCondition + ' IS NOT NULL  
			GROUP BY a.OSName,a.OSBuild
		)HT
		INNER JOIN #TmbTblHotFixOutput HFO
		ON HT.OSName = HFO.OSName AND HT.OSBuild = HFO.OSBuild'	
		--PRINT @SqlQueryHF
		EXEC(@SqlQueryHF)
		SET @hfCount = @hfCount + 1
	END

	UPDATE #TmbTblHotFixOutput SET OSBuild = '-' WHERE OSBuild = 'No Registry Key'

	DECLARE @HealthyClm VARCHAR(MAX),@SqlQryHealthy VARCHAR(MAX)
	,@CriticalClm VARCHAR(MAX), @SqlQryCritical VARCHAR(MAX)
	
	SELECT  @HealthyClm =  ISNULL(@HealthyClm + ' AND ','') + QUOTENAME(AppName)  + ' = 1'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND ID > 3 
		AND AppName NOT IN('HotFixID','FORCEPOINT')
	)App
	
	SET @SqlQryHealthy = 'UPDATE OS SET OS.[Status] = 1
		FROM(
			SELECT DISTINCT HostNameID
			FROM #TmpTblOSAppInfo 
			WHERE '+ @HealthyClm + '
			AND ([Monthly] = 1 OR [Monthly] IS NULL) AND ([Security] = 1 OR [Security] IS NULL)
			AND ([Servicing] = 1 OR [Servicing] IS NULL)
		)HT
		INNER JOIN #TmpTblOSAppInfo OS
		ON OS.HostNameID = HT.HostNameID'
	EXEC(@SqlQryHealthy)

	SELECT  @CriticalClm =  ISNULL(@CriticalClm + ' OR ','') + QUOTENAME(AppName)  + ' = 0'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND Criteria = 1
	)App

	SET @SqlQryCritical = 'UPDATE OS SET OS.[Status] = 2
		FROM(
			SELECT DISTINCT HostNameID
			FROM #TmpTblOSAppInfo 
			WHERE '+@CriticalClm + '
			OR ([Monthly] = 0 AND [Monthly] IS NOT NULL) OR ([Security] = 0 AND [Security] IS NOT NULL)
			OR ([Servicing] = 0 AND [Servicing] IS NOT NULL)
		)HT
		INNER JOIN #TmpTblOSAppInfo OS
		ON OS.HostNameID = HT.HostNameID'
	EXEC(@SqlQryCritical)
	
	UPDATE #TmpTblOSAppInfo SET [Status] = 3 WHERE [Status] IS NULL

	SET @AppResult = (SELECT CASE WHEN @AppStatus LIKE '%Healthy%' THEN '1' ELSE
		CASE WHEN @AppStatus LIKE '%Issue%' THEN  '0' ELSE
		CASE WHEN @AppStatus LIKE '%Error%' THEN  '2' END END END)
	
	SET @SqlQryRes = 'SELECT HN.AssetID,HN.HostName,FL.[Location],FL.Facility,PVT.'+ @AppName + '
	FROM #TmpTblOSAppInfo APP
	INNER JOIN CISOHostNameLookup(NOLOCK)HN
	ON APP.HostNameID = HN.HostNameID
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	INNER JOIN #TmbTblPivot PVT
	ON PVT.HostNameID = APP.HostNameID
	WHERE APP.' + @AppName + ' = ' + CHAR(39) + @AppResult + CHAR(39) 
	IF @Location IS NOT NULL
	BEGIN
		SET @SqlQryRes += 'AND FL.[Location] IN (SELECT [Location] FROM #TempTblLocation) '		
	END
	IF @Facility IS NOT NULL
	BEGIN
		SET @SqlQryRes += ' AND FL.[Facility] IN (SELECT [Facility] FROM #TempTblFacility) '
	END
	SET @SqlQryRes += ' ORDER BY 1,2,3 ASC'		
	EXEC(@SqlQryRes)	
	
	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility	
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF	
END
GO
/****** Object:  StoredProcedure [dbo].[CISOSystemDetailsOS]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOSystemDetailsOS]
(
	@Date DATETIME,
	@Location VARCHAR(1500) = NULL,
	@Facility VARCHAR(1500) = NULL,
	@OSName VARCHAR(500)	
)
AS
BEGIN

	--DECLARE @Date DATETIME = GETDATE()
	--DECLARE @Location VARCHAR(250) = NULL
	--DECLARE @Facility VARCHAR(250) = NULL
	--DECLARE @OSName VARCHAR(500) = 'WINDOWS 10 PRO'
	
	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility	

	DECLARE @STime DATETIME,@ETime DATETIME
	DECLARE @SQLSysOverview VARCHAR(MAX)
	DECLARE @SqlQryRes VARCHAR(MAX),@AppResult VARCHAR(50)
	
	SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), @Date,101))
	SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,@Date), 0)))

	CREATE TABLE #TempTblLocation([Location] VARCHAR(1500))
	CREATE TABLE #TempTblFacility([Facility] VARCHAR(1500))

	IF @Location IS NOT NULL
	BEGIN
		INSERT INTO #TempTblLocation                
		SELECT items FROM SplitStringfn(@Location,',') 
	END

	IF @Facility IS NOT NULL
	BEGIN
		INSERT INTO #TempTblFacility                
		SELECT items FROM SplitStringfn(@Facility,',') 
	END

	SET @SqlQryRes = 'SELECT HN.AssetID,HN.HostName,KV.KeyValues,FL.[Location],FL.Facility
	FROM CISORegistryKeyValues(NOLOCK)KV
	INNER JOIN CISORegistryKeyPath(NOLOCK)KP
	ON KP.ID = KV.AppID
	INNER JOIN CISOHostNameLookup(NOLOCK)HN
	ON KV.HostNameID = HN.HostNameID
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	WHERE FL.IsActive = 1 AND HN.IsActive = 1 AND KV.ComputerStatus = 1
	AND KeyValues = ' +  CHAR(39) + @OSName +  CHAR(39) + '
	AND RunAt BETWEEN '+ CHAR(39) + CONVERT(VARCHAR(50),@STime,121) + CHAR(39) + '
	AND ' + CHAR(39) + CONVERT(VARCHAR(50),@ETime,121) + CHAR(39)
	IF @Location IS NOT NULL
	BEGIN
		SET @SqlQryRes += '
		AND FL.[Location] IN (SELECT [Location] FROM #TempTblLocation) '		
	END
	IF @Facility IS NOT NULL
	BEGIN
		SET @SqlQryRes += '
		AND FL.[Facility] IN (SELECT [Facility] FROM #TempTblFacility) '
	END			 
	EXEC(@SqlQryRes)

	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility
END
GO
/****** Object:  StoredProcedure [dbo].[CISOSystemDetailsW10]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOSystemDetailsW10]
(
	@Date DATETIME,
	@Location VARCHAR(1500) = NULL,
	@Facility VARCHAR(1500) = NULL,
	@AppName VARCHAR(500),
	@AppStatus VARCHAR(500)
)
AS
BEGIN
	
	--DECLARE @Date DATETIME = '2020-02-20'
	--DECLARE @Location VARCHAR(250) = NULL
	--DECLARE @Facility VARCHAR(250) = NULL
	--DECLARE @AppName VARCHAR(500) = '1809 - W10 PRO'
	--DECLARE @AppStatus VARCHAR(500) = 'ISSUE'

	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility	
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF
	IF OBJECT_ID('tempdb..#TmpTblOSW10') IS NOT NULL DROP TABLE #TmpTblOSW10		

	DECLARE @STime DATETIME,@ETime DATETIME
	DECLARE @SQLSysOverview VARCHAR(MAX)
	DECLARE @SqlQryRes VARCHAR(MAX),@AppResult VARCHAR(50)
	
	SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), @Date,101))
	SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,@Date), 0)))
	
	/*START*/
	DECLARE @ColumnName VARCHAR(MAX),@QryTmpTbl VARCHAR(500),@QryTmpTblPvt VARCHAR(500)
	DECLARE @APPColumnName VARCHAR(MAX),@SqlAppQry VARCHAR(MAX),@APPColumnPvt VARCHAR(MAX)

	CREATE TABLE #TempTblLocation([Location] VARCHAR(1500))
	CREATE TABLE #TempTblFacility([Facility] VARCHAR(1500))

	IF @Location IS NOT NULL
	BEGIN
		INSERT INTO #TempTblLocation                
		SELECT items FROM SplitStringfn(@Location,',') 
	END

	IF @Facility IS NOT NULL
	BEGIN
		INSERT INTO #TempTblFacility                
		SELECT items FROM SplitStringfn(@Facility,',') 
	END

	SET @SqlAppQry = ''

	CREATE TABLE #TmpTblOSAppInfo(HostNameID INT)
	SELECT  @ColumnName =  ISNULL(@ColumnName + ';','') + ' ALTER TABLE #TmpTblOSAppInfo ADD ' + QUOTENAME(AppName)  + ' INT'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND AppName != 'HotFixID'	
		UNION SELECT 'Monthly'
		UNION SELECT 'Security'
		UNION SELECT 'Servicing'
		UNION SELECT 'Status'
	)App

	EXEC(@ColumnName)

	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSName VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSVersion VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSBuild VARCHAR(250)

	CREATE TABLE #TmbTblPivot(HostNameID INT)

	SELECT  @APPColumnPvt =  ISNULL(@APPColumnPvt + ';','') + ' ALTER TABLE #TmbTblPivot ADD ' + QUOTENAME(AppName)  + ' VARCHAR(2000)'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 
	)App

	EXEC(@APPColumnPvt)

	SELECT @APPColumnName= ISNULL(@APPColumnName + ',','') + QUOTENAME(AppName)        
	FROM 
	(
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1
	) AS ReportTitle   


	SET @SqlAppQry = 'INSERT INTO #TmbTblPivot(HostNameID,' + @APPColumnName + ')
	SELECT HostNameID,' + @APPColumnName + '
	FROM
	(
		SELECT 
		KV.HostNameID,KP.AppName,KeyValues
		FROM CISORegistryKeyValues(NOLOCK)KV
		INNER JOIN CISORegistryKeyPath(NOLOCK)KP
		ON KP.ID = KV.AppID
		INNER JOIN CISOHostNameLookup(NOLOCK)HN
		ON KV.HostNameID = HN.HostNameID
		INNER JOIN CISOFacilityLookup(NOLOCK)FL
		ON HN.FacilityID = FL.FacilityID
		WHERE FL.IsActive = 1 AND HN.IsActive = 1 AND KV.ComputerStatus = 1
		AND RunAt BETWEEN '+ CHAR(39) + CONVERT(VARCHAR(50),@STime,121) + CHAR(39) + 
		' AND ' + CHAR(39) + CONVERT(VARCHAR(50),@ETime,121) + CHAR(39) +
		'
	)X
	PIVOT (MAX(KeyValues)
	FOR AppName IN (' + @APPColumnName + ')) AS PVTTable 
	WHERE PVTTable.OSName != ''-'''
	EXEC(@SqlAppQry)

	/*---<<<END>>>---*/

	CREATE TABLE #TmbTblHotFixOutput
	(
	OSName			VARCHAR(250),
	OSBuild			VARCHAR(250),
	Monthly			INT DEFAULT 0,
	[Security]		INT DEFAULT 0,
	Servicing		INT DEFAULT 0,
	IssueMonthly	INT DEFAULT 0,
	IssueSecurity	INT DEFAULT 0,
	IssueServicing	INT DEFAULT 0,
	ErrorMonthly	INT DEFAULT 0,
	ErrorSecurity	INT DEFAULT 0,
	ErrorServicing	INT DEFAULT 0
	)

	SELECT TMP.HostNameID,TMP.HotFixID,DV.Monthly,DV.[Security],DV.Servicing
	INTO #TmbTblHotFix 
	FROM #TmbTblPivot TMP
	LEFT JOIN CISORegistryDefaultValue(NOLOCK)DV
	ON DV.OSName = TMP.OSName AND DV.OSVersion = TMP.OSBuild

	INSERT INTO #TmpTblOSAppInfo(HostNameID,OSName,OSVersion,OSBuild)
	SELECT HostNameID,OSName,OSVersion,OSBuild 
	FROM #TmbTblPivot

	DECLARE @OSBuildCount INT,@OSBuildKB VARCHAR(150),@SQLOSBuildQry VARCHAR(MAX)
	SET @OSBuildCount = 1

	WHILE @OSBuildCount <= 3
	BEGIN
		IF @OSBuildCount = 1 BEGIN SET @OSBuildKB = '[Monthly]' END
		IF @OSBuildCount = 2 BEGIN SET @OSBuildKB = '[Security]' END
		IF @OSBuildCount = 3 BEGIN SET @OSBuildKB = '[Servicing]' END

		SET @SQLOSBuildQry = 'UPDATE PVT SET PVT.' + @OSBuildKB + ' = 1
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 0
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID NOT LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 2
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a		
			WHERE a.' + @OSBuildKB +' IS NOT NULL 
			AND a.HotFixID like ''Err: %''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID'

		EXEC(@SQLOSBuildQry)
		SET @OSBuildCount = @OSBuildCount + 1
		SET @OSBuildKB = ''
	END

	CREATE TABLE #TmbTblColumn(ID INT,AppID INT, ColumnName VARCHAR(200))
	INSERT INTO #TmbTblColumn(ID,AppID, ColumnName)
	SELECT ROW_NUMBER() OVER(ORDER BY [ID]),ID,AppName
	FROM CISORegistryKeyPath(NOLOCK) 
	WHERE IsActive = 1 AND AppName NOT LIKE 'OS%'

	DECLARE @APPColumn VARCHAR(200), @APPValue VARCHAR(200), @SQLQryApp VARCHAR(MAX)
	,@Count INT, @eCount INT--, @sColumn VARCHAR(150)

	SET @Count = 1
	SET @eCount = (SELECT COUNT(ID) FROM #TmbTblColumn)

	WHILE @Count <= @eCount
	BEGIN	
		SELECT TOP 1 @APPColumn = ColumnName FROM #TmbTblColumn WHERE id = @Count
		SELECT TOP 1 @APPValue = RKP.DefaultValue 
		FROM #TmbTblColumn a
		INNER JOIN CISORegistryKeyPath(NOLOCK)RKP
		ON A.AppID = RKP.ID
		WHERE A.ID = @Count

		SET @SQLQryApp = 'UPDATE PVT SET PVT.' + @APPColumn + ' = 1
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' = ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 0
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' != ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 2
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' LIKE ''Err: %''
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID'		

		EXEC(@SQLQryApp)
		SET @Count = @Count + 1
	END

	/**/
	INSERT INTO #TmbTblHotFixOutput(OSName,OSBuild)
	SELECT OSName,OSBuild 
	FROM #TmpTblOSAppInfo
	GROUP BY OSName,OSBuild
	ORDER BY 2

	SELECT ROW_NUMBER() OVER(ORDER BY [name]) SNo,[Name]
	INTO #TmbTblHF
	FROM tempdb.SYS.COLUMNS
	WHERE OBJECT_ID = OBJECT_ID('tempdb..#TmbTblHotFixOutput')
	AND [name] NOT IN('OSName','OSBuild')

	DECLARE @hfCount INT, @hfeCount INT, @hfsColumn VARCHAR(200)
	,@SqlQueryHF VARCHAR(MAX),@CLreview VARCHAR(50),@ConditionHF VARCHAR(100)
	,@addCondition VARCHAR(150)
	SET @hfCount = 1
	SET @hfeCount = (SELECT COUNT(SNo) FROM #TmbTblHF)

	WHILE @hfCount <= @hfeCount
	BEGIN
		SELECT TOP 1 @hfsColumn = [Name] FROM #TmbTblHF WHERE SNo = @hfCount
		SET @CLreview = LEFT(@hfsColumn,3)
		if @CLreview = 'Err'
		BEGIN
			SET @ConditionHF = '2'
			SET @addCondition = REPLACE(@hfsColumn,'Error','')
		END
		ELSE IF @CLreview = 'Iss'
		BEGIN
			SET @ConditionHF = '0'
			SET @addCondition = REPLACE(@hfsColumn,'Issue','')
		END
		ELSE
		BEGIN
			SET @ConditionHF = '1'
			SET @addCondition = @hfsColumn
		END

		SET @SqlQueryHF = 'UPDATE HFO SET HFO.' + @hfsColumn + ' = HT.cnt
		FROM(
			SELECT a.OSName,a.OSBuild,COUNT(HostNameID)cnt 
			FROM #TmpTblOSAppInfo a
			--INNER JOIN #TmbTblHotFixOutput b
			--ON a.OSName = b.OSName AND a.OSBuild = b.OSBuild
			WHERE a.' + @addCondition +' = ' + @ConditionHF + '
			AND a.' + @addCondition + ' IS NOT NULL  
			GROUP BY a.OSName,a.OSBuild
		)HT
		INNER JOIN #TmbTblHotFixOutput HFO
		ON HT.OSName = HFO.OSName AND HT.OSBuild = HFO.OSBuild'	
		--PRINT @SqlQueryHF
		EXEC(@SqlQueryHF)
		SET @hfCount = @hfCount + 1
	END

	UPDATE #TmbTblHotFixOutput SET OSBuild = '-' WHERE OSBuild = 'No Registry Key'

	DECLARE @HealthyClm VARCHAR(MAX),@SqlQryHealthy VARCHAR(MAX)
	,@CriticalClm VARCHAR(MAX), @SqlQryCritical VARCHAR(MAX)
	
	SELECT  @HealthyClm =  ISNULL(@HealthyClm + ' AND ','') + QUOTENAME(AppName)  + ' = 1'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND ID > 3 
		AND AppName NOT IN('HotFixID','FORCEPOINT')
	)App
	
	SET @SqlQryHealthy = 'UPDATE OS SET OS.[Status] = 1
		FROM(
			SELECT DISTINCT HostNameID
			FROM #TmpTblOSAppInfo 
			WHERE '+ @HealthyClm + '
			AND ([Monthly] = 1 OR [Monthly] IS NULL) AND ([Security] = 1 OR [Security] IS NULL)
			AND ([Servicing] = 1 OR [Servicing] IS NULL)
		)HT
		INNER JOIN #TmpTblOSAppInfo OS
		ON OS.HostNameID = HT.HostNameID'
	EXEC(@SqlQryHealthy)

	SELECT  @CriticalClm =  ISNULL(@CriticalClm + ' OR ','') + QUOTENAME(AppName)  + ' = 0'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND Criteria = 1
	)App

	SET @SqlQryCritical = 'UPDATE OS SET OS.[Status] = 2
		FROM(
			SELECT DISTINCT HostNameID
			FROM #TmpTblOSAppInfo 
			WHERE '+@CriticalClm + '
			OR ([Monthly] = 0 AND [Monthly] IS NOT NULL) OR ([Security] = 0 AND [Security] IS NOT NULL)
			OR ([Servicing] = 0 AND [Servicing] IS NOT NULL)
		)HT
		INNER JOIN #TmpTblOSAppInfo OS
		ON OS.HostNameID = HT.HostNameID'
	EXEC(@SqlQryCritical)
	
	UPDATE #TmpTblOSAppInfo SET [Status] = 3 WHERE [Status] IS NULL
	
	SELECT HostNameID,
	CASE WHEN OSBuild = 'No Registry Key' THEN REPLACE(REPLACE(OSName, 'WorkStations', 'WKS'),'Windows ','W')   
	ELSE OSBuild + ' - '+ REPLACE(REPLACE(OSName, 'WorkStations', 'WKS'),'Windows ','W') END  AS OS,
	OSBuild,OSName,OSVersion,
	CASE WHEN Monthly = 1 THEN 'Healthy' ELSE 
	CASE WHEN Monthly = 0 THEN 'Issue' ELSE 
	CASE WHEN Monthly = 2 THEN 'Error' ELSE CONVERT(VARCHAR(25),Monthly) END END END AS Monthly
	--,CASE WHEN [Security] = 1 THEN 'Healthy' ELSE 
	--CASE WHEN [Security] = 0 THEN 'Issue' ELSE 
	--CASE WHEN [Security] = 2 THEN 'Error' ELSE CONVERT(VARCHAR(25),[Security]) END END END AS [Security]
	--,CASE WHEN Servicing = 1 THEN 'Healthy' ELSE 
	--CASE WHEN Servicing = 0 THEN 'Issue' ELSE 
	--CASE WHEN Servicing = 2 THEN 'Error' ELSE CONVERT(VARCHAR(25),Servicing) END END END AS Servicing	
	INTO #TmpTblOSW10
	FROM #TmpTblOSAppInfo
		
	--DECLARE @SqlQryRes VARCHAR(MAX),@AppResult VARCHAR(50)
	----select * from #TmpTblOSW10		
	--SET @AppResult = 'Healthy'
	--DECLARE @Location VARCHAR(250) = NULL
	--DECLARE @Facility VARCHAR(250) = NULL
	--DECLARE @AppName VARCHAR(250) = NULL
	--DECLARE @AppStatus VARCHAR(250) = 'HEALTHY'
			
	SET @SqlQryRes = 'SELECT HN.AssetID,HN.HostName,FL.[Location],FL.Facility,
	APP.OSName,APP.OSVersion,APP.Monthly,PVT.HotFixID	
	FROM #TmpTblOSW10 APP
	INNER JOIN CISOHostNameLookup(NOLOCK)HN
	ON APP.HostNameID = HN.HostNameID
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	INNER JOIN #TmbTblPivot PVT
	ON PVT.HostNameID = APP.HostNameID '		
	IF @AppName IS NULL
	BEGIN
		SET @SqlQryRes += '
		WHERE APP.OS LIKE ''%W10%'' ' + '
		AND APP.Monthly = ' + CHAR(39) + @AppStatus + CHAR(39)
	END
	ELSE
	BEGIN
		SET @SqlQryRes +=' 
		WHERE APP.OS = ' + CHAR(39) + @AppName + CHAR(39) +'
		AND APP.Monthly = ' + CHAR(39) + @AppStatus + CHAR(39)
	END
	IF @Location IS NOT NULL
	BEGIN
		SET @SqlQryRes += 'AND FL.[Location] IN (SELECT [Location] FROM #TempTblLocation) '		
	END
	IF @Facility IS NOT NULL
	BEGIN
		SET @SqlQryRes += ' AND FL.[Facility] IN (SELECT [Facility] FROM #TempTblFacility) '
	END
	SET @SqlQryRes += ' ORDER BY 1,2,3 ASC'		
	EXEC(@SqlQryRes)	
	
	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility	
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF	
	IF OBJECT_ID('tempdb..#TmpTblOSW10') IS NOT NULL DROP TABLE #TmpTblOSW10		
END
GO
/****** Object:  StoredProcedure [dbo].[CISOSystemDetailsW7]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOSystemDetailsW7]
(
	@Date DATETIME,
	@Location VARCHAR(1500) = NULL,
	@Facility VARCHAR(1500) = NULL,
	@AppName VARCHAR(500),
	@AppStatus VARCHAR(500)
)
AS
BEGIN
	
	--DECLARE @Date DATETIME = GETDATE()
	--DECLARE @Location VARCHAR(250) = NULL
	--DECLARE @Facility VARCHAR(250) = NULL
	--DECLARE @AppName VARCHAR(500) = 'MONTHLY'
	--DECLARE @AppStatus VARCHAR(500) = 'Healthy'

	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility	
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF
	IF OBJECT_ID('tempdb..#TmpTblOSW10') IS NOT NULL DROP TABLE #TmpTblOSW10		

	DECLARE @STime DATETIME,@ETime DATETIME
	DECLARE @SQLSysOverview VARCHAR(MAX)
	DECLARE @SqlQryRes VARCHAR(MAX),@AppResult VARCHAR(50)
	
	SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), @Date,101))
	SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,@Date), 0)))
	
	/*START*/
	DECLARE @ColumnName VARCHAR(MAX),@QryTmpTbl VARCHAR(500),@QryTmpTblPvt VARCHAR(500)
	DECLARE @APPColumnName VARCHAR(MAX),@SqlAppQry VARCHAR(MAX),@APPColumnPvt VARCHAR(MAX)

	CREATE TABLE #TempTblLocation([Location] VARCHAR(1500))
	CREATE TABLE #TempTblFacility([Facility] VARCHAR(1500))

	IF @Location IS NOT NULL
	BEGIN
		INSERT INTO #TempTblLocation                
		SELECT items FROM SplitStringfn(@Location,',') 
	END

	IF @Facility IS NOT NULL
	BEGIN
		INSERT INTO #TempTblFacility                
		SELECT items FROM SplitStringfn(@Facility,',') 
	END

	SET @SqlAppQry = ''

	CREATE TABLE #TmpTblOSAppInfo(HostNameID INT)
	SELECT  @ColumnName =  ISNULL(@ColumnName + ';','') + ' ALTER TABLE #TmpTblOSAppInfo ADD ' + QUOTENAME(AppName)  + ' INT'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND AppName != 'HotFixID'	
		UNION SELECT 'Monthly'
		UNION SELECT 'Security'
		UNION SELECT 'Servicing'
		UNION SELECT 'Status'
	)App

	EXEC(@ColumnName)

	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSName VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSVersion VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSBuild VARCHAR(250)

	CREATE TABLE #TmbTblPivot(HostNameID INT)

	SELECT  @APPColumnPvt =  ISNULL(@APPColumnPvt + ';','') + ' ALTER TABLE #TmbTblPivot ADD ' + QUOTENAME(AppName)  + ' VARCHAR(2000)'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 
	)App

	EXEC(@APPColumnPvt)

	SELECT @APPColumnName= ISNULL(@APPColumnName + ',','') + QUOTENAME(AppName)        
	FROM 
	(
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1
	) AS ReportTitle   


	SET @SqlAppQry = 'INSERT INTO #TmbTblPivot(HostNameID,' + @APPColumnName + ')
	SELECT HostNameID,' + @APPColumnName + '
	FROM
	(
		SELECT 
		KV.HostNameID,KP.AppName,KeyValues
		FROM CISORegistryKeyValues(NOLOCK)KV
		INNER JOIN CISORegistryKeyPath(NOLOCK)KP
		ON KP.ID = KV.AppID
		INNER JOIN CISOHostNameLookup(NOLOCK)HN
		ON KV.HostNameID = HN.HostNameID
		INNER JOIN CISOFacilityLookup(NOLOCK)FL
		ON HN.FacilityID = FL.FacilityID
		WHERE FL.IsActive = 1 AND HN.IsActive = 1 AND KV.ComputerStatus = 1
		AND RunAt BETWEEN '+ CHAR(39) + CONVERT(VARCHAR(50),@STime,121) + CHAR(39) + 
		' AND ' + CHAR(39) + CONVERT(VARCHAR(50),@ETime,121) + CHAR(39) +
		'
	)X
	PIVOT (MAX(KeyValues)
	FOR AppName IN (' + @APPColumnName + ')) AS PVTTable 
	WHERE PVTTable.OSName != ''-'''
	EXEC(@SqlAppQry)

	/*---<<<END>>>---*/

	CREATE TABLE #TmbTblHotFixOutput
	(
	OSName			VARCHAR(250),
	OSBuild			VARCHAR(250),
	Monthly			INT DEFAULT 0,
	[Security]		INT DEFAULT 0,
	Servicing		INT DEFAULT 0,
	IssueMonthly	INT DEFAULT 0,
	IssueSecurity	INT DEFAULT 0,
	IssueServicing	INT DEFAULT 0,
	ErrorMonthly	INT DEFAULT 0,
	ErrorSecurity	INT DEFAULT 0,
	ErrorServicing	INT DEFAULT 0
	)

	SELECT TMP.HostNameID,TMP.HotFixID,DV.Monthly,DV.[Security],DV.Servicing
	INTO #TmbTblHotFix 
	FROM #TmbTblPivot TMP
	LEFT JOIN CISORegistryDefaultValue(NOLOCK)DV
	ON DV.OSName = TMP.OSName AND DV.OSVersion = TMP.OSBuild

	INSERT INTO #TmpTblOSAppInfo(HostNameID,OSName,OSVersion,OSBuild)
	SELECT HostNameID,OSName,OSVersion,OSBuild 
	FROM #TmbTblPivot

	DECLARE @OSBuildCount INT,@OSBuildKB VARCHAR(150),@SQLOSBuildQry VARCHAR(MAX)
	SET @OSBuildCount = 1

	WHILE @OSBuildCount <= 3
	BEGIN
		IF @OSBuildCount = 1 BEGIN SET @OSBuildKB = '[Monthly]' END
		IF @OSBuildCount = 2 BEGIN SET @OSBuildKB = '[Security]' END
		IF @OSBuildCount = 3 BEGIN SET @OSBuildKB = '[Servicing]' END

		SET @SQLOSBuildQry = 'UPDATE PVT SET PVT.' + @OSBuildKB + ' = 1
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 0
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID NOT LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 2
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a		
			WHERE a.' + @OSBuildKB +' IS NOT NULL 
			AND a.HotFixID like ''Err: %''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID'

		EXEC(@SQLOSBuildQry)
		SET @OSBuildCount = @OSBuildCount + 1
		SET @OSBuildKB = ''
	END

	CREATE TABLE #TmbTblColumn(ID INT,AppID INT, ColumnName VARCHAR(200))
	INSERT INTO #TmbTblColumn(ID,AppID, ColumnName)
	SELECT ROW_NUMBER() OVER(ORDER BY [ID]),ID,AppName
	FROM CISORegistryKeyPath(NOLOCK) 
	WHERE IsActive = 1 AND AppName NOT LIKE 'OS%'

	DECLARE @APPColumn VARCHAR(200), @APPValue VARCHAR(200), @SQLQryApp VARCHAR(MAX)
	,@Count INT, @eCount INT--, @sColumn VARCHAR(150)

	SET @Count = 1
	SET @eCount = (SELECT COUNT(ID) FROM #TmbTblColumn)

	WHILE @Count <= @eCount
	BEGIN	
		SELECT TOP 1 @APPColumn = ColumnName FROM #TmbTblColumn WHERE id = @Count
		SELECT TOP 1 @APPValue = RKP.DefaultValue 
		FROM #TmbTblColumn a
		INNER JOIN CISORegistryKeyPath(NOLOCK)RKP
		ON A.AppID = RKP.ID
		WHERE A.ID = @Count

		SET @SQLQryApp = 'UPDATE PVT SET PVT.' + @APPColumn + ' = 1
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' = ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 0
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' != ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 2
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' LIKE ''Err: %''
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID'		

		EXEC(@SQLQryApp)
		SET @Count = @Count + 1
	END

	/**/
	INSERT INTO #TmbTblHotFixOutput(OSName,OSBuild)
	SELECT OSName,OSBuild 
	FROM #TmpTblOSAppInfo
	GROUP BY OSName,OSBuild
	ORDER BY 2

	SELECT ROW_NUMBER() OVER(ORDER BY [name]) SNo,[Name]
	INTO #TmbTblHF
	FROM tempdb.SYS.COLUMNS
	WHERE OBJECT_ID = OBJECT_ID('tempdb..#TmbTblHotFixOutput')
	AND [name] NOT IN('OSName','OSBuild')

	DECLARE @hfCount INT, @hfeCount INT, @hfsColumn VARCHAR(200)
	,@SqlQueryHF VARCHAR(MAX),@CLreview VARCHAR(50),@ConditionHF VARCHAR(100)
	,@addCondition VARCHAR(150)
	SET @hfCount = 1
	SET @hfeCount = (SELECT COUNT(SNo) FROM #TmbTblHF)

	WHILE @hfCount <= @hfeCount
	BEGIN
		SELECT TOP 1 @hfsColumn = [Name] FROM #TmbTblHF WHERE SNo = @hfCount
		SET @CLreview = LEFT(@hfsColumn,3)
		if @CLreview = 'Err'
		BEGIN
			SET @ConditionHF = '2'
			SET @addCondition = REPLACE(@hfsColumn,'Error','')
		END
		ELSE IF @CLreview = 'Iss'
		BEGIN
			SET @ConditionHF = '0'
			SET @addCondition = REPLACE(@hfsColumn,'Issue','')
		END
		ELSE
		BEGIN
			SET @ConditionHF = '1'
			SET @addCondition = @hfsColumn
		END

		SET @SqlQueryHF = 'UPDATE HFO SET HFO.' + @hfsColumn + ' = HT.cnt
		FROM(
			SELECT a.OSName,a.OSBuild,COUNT(HostNameID)cnt 
			FROM #TmpTblOSAppInfo a
			--INNER JOIN #TmbTblHotFixOutput b
			--ON a.OSName = b.OSName AND a.OSBuild = b.OSBuild
			WHERE a.' + @addCondition +' = ' + @ConditionHF + '
			AND a.' + @addCondition + ' IS NOT NULL  
			GROUP BY a.OSName,a.OSBuild
		)HT
		INNER JOIN #TmbTblHotFixOutput HFO
		ON HT.OSName = HFO.OSName AND HT.OSBuild = HFO.OSBuild'	
		--PRINT @SqlQueryHF
		EXEC(@SqlQueryHF)
		SET @hfCount = @hfCount + 1
	END

	UPDATE #TmbTblHotFixOutput SET OSBuild = '-' WHERE OSBuild = 'No Registry Key'

	DECLARE @HealthyClm VARCHAR(MAX),@SqlQryHealthy VARCHAR(MAX)
	,@CriticalClm VARCHAR(MAX), @SqlQryCritical VARCHAR(MAX)
	
	SELECT  @HealthyClm =  ISNULL(@HealthyClm + ' AND ','') + QUOTENAME(AppName)  + ' = 1'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND ID > 3 
		AND AppName NOT IN('HotFixID','FORCEPOINT')
	)App
	
	SET @SqlQryHealthy = 'UPDATE OS SET OS.[Status] = 1
		FROM(
			SELECT DISTINCT HostNameID
			FROM #TmpTblOSAppInfo 
			WHERE '+ @HealthyClm + '
			AND ([Monthly] = 1 OR [Monthly] IS NULL) AND ([Security] = 1 OR [Security] IS NULL)
			AND ([Servicing] = 1 OR [Servicing] IS NULL)
		)HT
		INNER JOIN #TmpTblOSAppInfo OS
		ON OS.HostNameID = HT.HostNameID'
	EXEC(@SqlQryHealthy)

	SELECT  @CriticalClm =  ISNULL(@CriticalClm + ' OR ','') + QUOTENAME(AppName)  + ' = 0'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND Criteria = 1
	)App

	SET @SqlQryCritical = 'UPDATE OS SET OS.[Status] = 2
		FROM(
			SELECT DISTINCT HostNameID
			FROM #TmpTblOSAppInfo 
			WHERE '+@CriticalClm + '
			OR ([Monthly] = 0 AND [Monthly] IS NOT NULL) OR ([Security] = 0 AND [Security] IS NOT NULL)
			OR ([Servicing] = 0 AND [Servicing] IS NOT NULL)
		)HT
		INNER JOIN #TmpTblOSAppInfo OS
		ON OS.HostNameID = HT.HostNameID'
	EXEC(@SqlQryCritical)
	
	UPDATE #TmpTblOSAppInfo SET [Status] = 3 WHERE [Status] IS NULL
	
	SELECT HostNameID,
	CASE WHEN OSBuild = 'No Registry Key' THEN REPLACE(REPLACE(OSName, 'WorkStations', 'WKS'),'Windows ','W')   
	ELSE OSBuild + ' - '+ REPLACE(REPLACE(OSName, 'WorkStations', 'WKS'),'Windows ','W') END  AS OS,
	OSBuild,OSName,OSVersion,
	CASE WHEN Monthly = 1 THEN 'Healthy' ELSE 
	CASE WHEN Monthly = 0 THEN 'Issue' ELSE 
	CASE WHEN Monthly = 2 THEN 'Error' ELSE CONVERT(VARCHAR(25),Monthly) END END END AS Monthly
	,CASE WHEN [Security] = 1 THEN 'Healthy' ELSE 
	CASE WHEN [Security] = 0 THEN 'Issue' ELSE 
	CASE WHEN [Security] = 2 THEN 'Error' ELSE CONVERT(VARCHAR(25),[Security]) END END END AS [Security]
	,CASE WHEN Servicing = 1 THEN 'Healthy' ELSE 
	CASE WHEN Servicing = 0 THEN 'Issue' ELSE 
	CASE WHEN Servicing = 2 THEN 'Error' ELSE CONVERT(VARCHAR(25),Servicing) END END END AS Servicing	
	INTO #TmpTblOSW10
	FROM #TmpTblOSAppInfo
		
	--DECLARE @SqlQryRes VARCHAR(MAX),@AppResult VARCHAR(50)
	----select * from #TmpTblOSW10		
	--SET @AppResult = 'Healthy'
	--DECLARE @Location VARCHAR(250) = NULL
	--DECLARE @Facility VARCHAR(250) = NULL
	--DECLARE @AppName VARCHAR(250) = NULL
	--DECLARE @AppStatus VARCHAR(250) = 'HEALTHY'
	
	SET @SqlQryRes = 'SELECT HN.AssetID,HN.HostName,FL.[Location],FL.Facility,
	APP.OSName,APP.OSVersion,PVT.HotFixID,'
	IF @AppName IS NULL
	BEGIN
		SET @SqlQryRes += 'APP.Monthly,APP.[Security],APP.Servicing'
	END
	ELSE
	BEGIN
		SET @SqlQryRes += 'APP.' + @AppName
	END
	SET @SqlQryRes += '
	FROM #TmpTblOSW10 APP
	INNER JOIN CISOHostNameLookup(NOLOCK)HN
	ON APP.HostNameID = HN.HostNameID
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	INNER JOIN #TmbTblPivot PVT
	ON PVT.HostNameID = APP.HostNameID
	WHERE APP.OS LIKE ''W7%'' '
	
	IF @AppName IS NULL
	BEGIN
		SET @SqlQryRes += '
		AND (APP.MONTHLY =' + CHAR(39) + @AppStatus + CHAR(39) + 
		'OR APP.[Security] =' + CHAR(39) + @AppStatus + CHAR(39) +
		'OR APP.Servicing =' + CHAR(39) + @AppStatus + CHAR(39) + ')'
	END
	ELSE
	BEGIN
		SET @SqlQryRes +=' AND APP.' + @AppName +' = ' + CHAR(39) + @AppStatus + CHAR(39) 
	END
	IF @Location IS NOT NULL
	BEGIN
		SET @SqlQryRes += 'AND FL.[Location] IN (SELECT [Location] FROM #TempTblLocation) '		
	END
	IF @Facility IS NOT NULL
	BEGIN
		SET @SqlQryRes += ' AND FL.[Facility] IN (SELECT [Facility] FROM #TempTblFacility) '
	END
	SET @SqlQryRes += ' ORDER BY 1,2,3 ASC'		
	EXEC(@SqlQryRes)	
	
	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility	
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF	
	IF OBJECT_ID('tempdb..#TmpTblOSW10') IS NOT NULL DROP TABLE #TmpTblOSW10		
END
GO
/****** Object:  StoredProcedure [dbo].[CISOSystemDetailsW8]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOSystemDetailsW8]
(
	@Date DATETIME,
	@Location VARCHAR(1500) = NULL,
	@Facility VARCHAR(1500) = NULL,
	@AppName VARCHAR(500),
	@AppStatus VARCHAR(500)
)
AS
BEGIN
	
	--DECLARE @Date DATETIME = GETDATE()
	--DECLARE @Location VARCHAR(250) = NULL
	--DECLARE @Facility VARCHAR(250) = NULL
	--DECLARE @AppName VARCHAR(500) = 'MONTHLY'
	--DECLARE @AppStatus VARCHAR(500) = 'Healthy'

	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility	
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF
	IF OBJECT_ID('tempdb..#TmpTblOSW10') IS NOT NULL DROP TABLE #TmpTblOSW10		

	DECLARE @STime DATETIME,@ETime DATETIME
	DECLARE @SQLSysOverview VARCHAR(MAX)
	DECLARE @SqlQryRes VARCHAR(MAX),@AppResult VARCHAR(50)
	
	SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), @Date,101))
	SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,@Date), 0)))
	
	/*START*/
	DECLARE @ColumnName VARCHAR(MAX),@QryTmpTbl VARCHAR(500),@QryTmpTblPvt VARCHAR(500)
	DECLARE @APPColumnName VARCHAR(MAX),@SqlAppQry VARCHAR(MAX),@APPColumnPvt VARCHAR(MAX)

	CREATE TABLE #TempTblLocation([Location] VARCHAR(1500))
	CREATE TABLE #TempTblFacility([Facility] VARCHAR(1500))

	IF @Location IS NOT NULL
	BEGIN
		INSERT INTO #TempTblLocation                
		SELECT items FROM SplitStringfn(@Location,',') 
	END

	IF @Facility IS NOT NULL
	BEGIN
		INSERT INTO #TempTblFacility                
		SELECT items FROM SplitStringfn(@Facility,',') 
	END

	SET @SqlAppQry = ''

	CREATE TABLE #TmpTblOSAppInfo(HostNameID INT)
	SELECT  @ColumnName =  ISNULL(@ColumnName + ';','') + ' ALTER TABLE #TmpTblOSAppInfo ADD ' + QUOTENAME(AppName)  + ' INT'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND AppName != 'HotFixID'	
		UNION SELECT 'Monthly'
		UNION SELECT 'Security'
		UNION SELECT 'Servicing'
		UNION SELECT 'Status'
	)App

	EXEC(@ColumnName)

	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSName VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSVersion VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSBuild VARCHAR(250)

	CREATE TABLE #TmbTblPivot(HostNameID INT)

	SELECT  @APPColumnPvt =  ISNULL(@APPColumnPvt + ';','') + ' ALTER TABLE #TmbTblPivot ADD ' + QUOTENAME(AppName)  + ' VARCHAR(2000)'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 
	)App

	EXEC(@APPColumnPvt)

	SELECT @APPColumnName= ISNULL(@APPColumnName + ',','') + QUOTENAME(AppName)        
	FROM 
	(
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1
	) AS ReportTitle   


	SET @SqlAppQry = 'INSERT INTO #TmbTblPivot(HostNameID,' + @APPColumnName + ')
	SELECT HostNameID,' + @APPColumnName + '
	FROM
	(
		SELECT 
		KV.HostNameID,KP.AppName,KeyValues
		FROM CISORegistryKeyValues(NOLOCK)KV
		INNER JOIN CISORegistryKeyPath(NOLOCK)KP
		ON KP.ID = KV.AppID
		INNER JOIN CISOHostNameLookup(NOLOCK)HN
		ON KV.HostNameID = HN.HostNameID
		INNER JOIN CISOFacilityLookup(NOLOCK)FL
		ON HN.FacilityID = FL.FacilityID
		WHERE FL.IsActive = 1 AND HN.IsActive = 1 AND KV.ComputerStatus = 1
		AND RunAt BETWEEN '+ CHAR(39) + CONVERT(VARCHAR(50),@STime,121) + CHAR(39) + 
		' AND ' + CHAR(39) + CONVERT(VARCHAR(50),@ETime,121) + CHAR(39) +
		'
	)X
	PIVOT (MAX(KeyValues)
	FOR AppName IN (' + @APPColumnName + ')) AS PVTTable 
	WHERE PVTTable.OSName != ''-'''
	EXEC(@SqlAppQry)

	/*---<<<END>>>---*/

	CREATE TABLE #TmbTblHotFixOutput
	(
	OSName			VARCHAR(250),
	OSBuild			VARCHAR(250),
	Monthly			INT DEFAULT 0,
	[Security]		INT DEFAULT 0,
	Servicing		INT DEFAULT 0,
	IssueMonthly	INT DEFAULT 0,
	IssueSecurity	INT DEFAULT 0,
	IssueServicing	INT DEFAULT 0,
	ErrorMonthly	INT DEFAULT 0,
	ErrorSecurity	INT DEFAULT 0,
	ErrorServicing	INT DEFAULT 0
	)

	SELECT TMP.HostNameID,TMP.HotFixID,DV.Monthly,DV.[Security],DV.Servicing
	INTO #TmbTblHotFix 
	FROM #TmbTblPivot TMP
	LEFT JOIN CISORegistryDefaultValue(NOLOCK)DV
	ON DV.OSName = TMP.OSName AND DV.OSVersion = TMP.OSBuild

	INSERT INTO #TmpTblOSAppInfo(HostNameID,OSName,OSVersion,OSBuild)
	SELECT HostNameID,OSName,OSVersion,OSBuild 
	FROM #TmbTblPivot

	DECLARE @OSBuildCount INT,@OSBuildKB VARCHAR(150),@SQLOSBuildQry VARCHAR(MAX)
	SET @OSBuildCount = 1

	WHILE @OSBuildCount <= 3
	BEGIN
		IF @OSBuildCount = 1 BEGIN SET @OSBuildKB = '[Monthly]' END
		IF @OSBuildCount = 2 BEGIN SET @OSBuildKB = '[Security]' END
		IF @OSBuildCount = 3 BEGIN SET @OSBuildKB = '[Servicing]' END

		SET @SQLOSBuildQry = 'UPDATE PVT SET PVT.' + @OSBuildKB + ' = 1
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 0
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID NOT LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 2
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a		
			WHERE a.' + @OSBuildKB +' IS NOT NULL 
			AND a.HotFixID like ''Err: %''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID'

		EXEC(@SQLOSBuildQry)
		SET @OSBuildCount = @OSBuildCount + 1
		SET @OSBuildKB = ''
	END

	CREATE TABLE #TmbTblColumn(ID INT,AppID INT, ColumnName VARCHAR(200))
	INSERT INTO #TmbTblColumn(ID,AppID, ColumnName)
	SELECT ROW_NUMBER() OVER(ORDER BY [ID]),ID,AppName
	FROM CISORegistryKeyPath(NOLOCK) 
	WHERE IsActive = 1 AND AppName NOT LIKE 'OS%'

	DECLARE @APPColumn VARCHAR(200), @APPValue VARCHAR(200), @SQLQryApp VARCHAR(MAX)
	,@Count INT, @eCount INT--, @sColumn VARCHAR(150)

	SET @Count = 1
	SET @eCount = (SELECT COUNT(ID) FROM #TmbTblColumn)

	WHILE @Count <= @eCount
	BEGIN	
		SELECT TOP 1 @APPColumn = ColumnName FROM #TmbTblColumn WHERE id = @Count
		SELECT TOP 1 @APPValue = RKP.DefaultValue 
		FROM #TmbTblColumn a
		INNER JOIN CISORegistryKeyPath(NOLOCK)RKP
		ON A.AppID = RKP.ID
		WHERE A.ID = @Count

		SET @SQLQryApp = 'UPDATE PVT SET PVT.' + @APPColumn + ' = 1
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' = ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 0
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' != ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 2
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' LIKE ''Err: %''
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID'		

		EXEC(@SQLQryApp)
		SET @Count = @Count + 1
	END

	/**/
	INSERT INTO #TmbTblHotFixOutput(OSName,OSBuild)
	SELECT OSName,OSBuild 
	FROM #TmpTblOSAppInfo
	GROUP BY OSName,OSBuild
	ORDER BY 2

	SELECT ROW_NUMBER() OVER(ORDER BY [name]) SNo,[Name]
	INTO #TmbTblHF
	FROM tempdb.SYS.COLUMNS
	WHERE OBJECT_ID = OBJECT_ID('tempdb..#TmbTblHotFixOutput')
	AND [name] NOT IN('OSName','OSBuild')

	DECLARE @hfCount INT, @hfeCount INT, @hfsColumn VARCHAR(200)
	,@SqlQueryHF VARCHAR(MAX),@CLreview VARCHAR(50),@ConditionHF VARCHAR(100)
	,@addCondition VARCHAR(150)
	SET @hfCount = 1
	SET @hfeCount = (SELECT COUNT(SNo) FROM #TmbTblHF)

	WHILE @hfCount <= @hfeCount
	BEGIN
		SELECT TOP 1 @hfsColumn = [Name] FROM #TmbTblHF WHERE SNo = @hfCount
		SET @CLreview = LEFT(@hfsColumn,3)
		if @CLreview = 'Err'
		BEGIN
			SET @ConditionHF = '2'
			SET @addCondition = REPLACE(@hfsColumn,'Error','')
		END
		ELSE IF @CLreview = 'Iss'
		BEGIN
			SET @ConditionHF = '0'
			SET @addCondition = REPLACE(@hfsColumn,'Issue','')
		END
		ELSE
		BEGIN
			SET @ConditionHF = '1'
			SET @addCondition = @hfsColumn
		END

		SET @SqlQueryHF = 'UPDATE HFO SET HFO.' + @hfsColumn + ' = HT.cnt
		FROM(
			SELECT a.OSName,a.OSBuild,COUNT(HostNameID)cnt 
			FROM #TmpTblOSAppInfo a
			--INNER JOIN #TmbTblHotFixOutput b
			--ON a.OSName = b.OSName AND a.OSBuild = b.OSBuild
			WHERE a.' + @addCondition +' = ' + @ConditionHF + '
			AND a.' + @addCondition + ' IS NOT NULL  
			GROUP BY a.OSName,a.OSBuild
		)HT
		INNER JOIN #TmbTblHotFixOutput HFO
		ON HT.OSName = HFO.OSName AND HT.OSBuild = HFO.OSBuild'	
		--PRINT @SqlQueryHF
		EXEC(@SqlQueryHF)
		SET @hfCount = @hfCount + 1
	END

	UPDATE #TmbTblHotFixOutput SET OSBuild = '-' WHERE OSBuild = 'No Registry Key'

	DECLARE @HealthyClm VARCHAR(MAX),@SqlQryHealthy VARCHAR(MAX)
	,@CriticalClm VARCHAR(MAX), @SqlQryCritical VARCHAR(MAX)
	
	SELECT  @HealthyClm =  ISNULL(@HealthyClm + ' AND ','') + QUOTENAME(AppName)  + ' = 1'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND ID > 3 
		AND AppName NOT IN('HotFixID','FORCEPOINT')
	)App
	
	SET @SqlQryHealthy = 'UPDATE OS SET OS.[Status] = 1
		FROM(
			SELECT DISTINCT HostNameID
			FROM #TmpTblOSAppInfo 
			WHERE '+ @HealthyClm + '
			AND ([Monthly] = 1 OR [Monthly] IS NULL) AND ([Security] = 1 OR [Security] IS NULL)
			AND ([Servicing] = 1 OR [Servicing] IS NULL)
		)HT
		INNER JOIN #TmpTblOSAppInfo OS
		ON OS.HostNameID = HT.HostNameID'
	EXEC(@SqlQryHealthy)

	SELECT  @CriticalClm =  ISNULL(@CriticalClm + ' OR ','') + QUOTENAME(AppName)  + ' = 0'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND Criteria = 1
	)App

	SET @SqlQryCritical = 'UPDATE OS SET OS.[Status] = 2
		FROM(
			SELECT DISTINCT HostNameID
			FROM #TmpTblOSAppInfo 
			WHERE '+@CriticalClm + '
			OR ([Monthly] = 0 AND [Monthly] IS NOT NULL) OR ([Security] = 0 AND [Security] IS NOT NULL)
			OR ([Servicing] = 0 AND [Servicing] IS NOT NULL)
		)HT
		INNER JOIN #TmpTblOSAppInfo OS
		ON OS.HostNameID = HT.HostNameID'
	EXEC(@SqlQryCritical)
	
	UPDATE #TmpTblOSAppInfo SET [Status] = 3 WHERE [Status] IS NULL
	
	SELECT HostNameID,
	CASE WHEN OSBuild = 'No Registry Key' THEN REPLACE(REPLACE(OSName, 'WorkStations', 'WKS'),'Windows ','W')   
	ELSE OSBuild + ' - '+ REPLACE(REPLACE(OSName, 'WorkStations', 'WKS'),'Windows ','W') END  AS OS,
	OSBuild,OSName,OSVersion,
	CASE WHEN Monthly = 1 THEN 'Healthy' ELSE 
	CASE WHEN Monthly = 0 THEN 'Issue' ELSE 
	CASE WHEN Monthly = 2 THEN 'Error' ELSE CONVERT(VARCHAR(25),Monthly) END END END AS Monthly
	,CASE WHEN [Security] = 1 THEN 'Healthy' ELSE 
	CASE WHEN [Security] = 0 THEN 'Issue' ELSE 
	CASE WHEN [Security] = 2 THEN 'Error' ELSE CONVERT(VARCHAR(25),[Security]) END END END AS [Security]
	--,CASE WHEN Servicing = 1 THEN 'Healthy' ELSE 
	--CASE WHEN Servicing = 0 THEN 'Issue' ELSE 
	--CASE WHEN Servicing = 2 THEN 'Error' ELSE CONVERT(VARCHAR(25),Servicing) END END END AS Servicing	
	INTO #TmpTblOSW10
	FROM #TmpTblOSAppInfo
		
	--DECLARE @SqlQryRes VARCHAR(MAX),@AppResult VARCHAR(50)
	----select * from #TmpTblOSW10		
	--SET @AppResult = 'Healthy'
	--DECLARE @Location VARCHAR(250) = NULL
	--DECLARE @Facility VARCHAR(250) = NULL
	--DECLARE @AppName VARCHAR(250) = NULL
	--DECLARE @AppStatus VARCHAR(250) = 'HEALTHY'
	
	SET @SqlQryRes = 'SELECT HN.AssetID,HN.HostName,FL.[Location],FL.Facility,
	APP.OSName,APP.OSVersion,PVT.HotFixID,'
	IF @AppName IS NULL
	BEGIN
		SET @SqlQryRes += 'APP.Monthly,APP.[Security]'
	END
	ELSE
	BEGIN
		SET @SqlQryRes += 'APP.' + @AppName
	END
	SET @SqlQryRes += '
	FROM #TmpTblOSW10 APP
	INNER JOIN CISOHostNameLookup(NOLOCK)HN
	ON APP.HostNameID = HN.HostNameID
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	INNER JOIN #TmbTblPivot PVT
	ON PVT.HostNameID = APP.HostNameID
	WHERE APP.OS LIKE ''W8%'' '
	
	IF @AppName IS NULL
	BEGIN
		SET @SqlQryRes += '
		AND (APP.MONTHLY =' + CHAR(39) + @AppStatus + CHAR(39) + 
		'OR APP.[Security] =' + CHAR(39) + @AppStatus + CHAR(39) + ')'
	END
	ELSE
	BEGIN
		SET @SqlQryRes +=' AND APP.' + @AppName +' = ' + CHAR(39) + @AppStatus + CHAR(39) 
	END
	IF @Location IS NOT NULL
	BEGIN
		SET @SqlQryRes += 'AND FL.[Location] IN (SELECT [Location] FROM #TempTblLocation) '		
	END
	IF @Facility IS NOT NULL
	BEGIN
		SET @SqlQryRes += ' AND FL.[Facility] IN (SELECT [Facility] FROM #TempTblFacility) '
	END
	SET @SqlQryRes += ' ORDER BY 1,2,3 ASC'		
	EXEC(@SqlQryRes)	
	
	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility	
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF	
	IF OBJECT_ID('tempdb..#TmpTblOSW10') IS NOT NULL DROP TABLE #TmpTblOSW10		
END
GO
/****** Object:  StoredProcedure [dbo].[CISOSystemInfo]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOSystemInfo]
(
	@Date DATETIME,
	@LocationName VARCHAR(1500) = NULL,
	@FacilityName VARCHAR(1500) = NULL
)
AS
BEGIN
	--DECLARE @Date DATETIME = '2020-01-30'
	--DECLARE @LocationName VARCHAR(250) = NULL
	--DECLARE @FacilityName VARCHAR(250) = NULL
	
	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility
	IF OBJECT_ID('tempdb..#TmbTblOverview') IS NOT NULL DROP TABLE #TmbTblOverview
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF
	IF OBJECT_ID('tempdb..#TmpTblAppInfo') IS NOT NULL DROP TABLE #TmpTblAppInfo

	DECLARE @STime DATETIME,@ETime DATETIME,@Location VARCHAR(1500),@Facility VARCHAR(1500)
	DECLARE @SQLSysOverview VARCHAR(MAX)

	SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), @Date,101))
	SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,@Date), 0)))
	SET @Location = @LocationName
	SET @Facility = @FacilityName
	SET @SQLSysOverview = ''

	CREATE TABLE #TempTblLocation([Location] VARCHAR(1500))
	 CREATE TABLE #TempTblFacility([Facility] VARCHAR(1500))
	CREATE TABLE #TmbTblOverview
	(
		RunAt		DATE,
		Systems		INT DEFAULT 0,
		Active		INT DEFAULT 0,
		InActive	INT DEFAULT 0,
		Critical	INT DEFAULT 0,
		Warning		INT DEFAULT 0,
		Healthy		INT DEFAULT 0,	
	)

	IF @Location IS NOT NULL
	BEGIN
		INSERT INTO #TempTblLocation                
		SELECT items FROM SplitStringfn(@Location,',') 
	END

	IF @Facility IS NOT NULL
	BEGIN
		INSERT INTO #TempTblFacility                
		SELECT items FROM SplitStringfn(@Facility,',') 
	END
	
	/*START*/
	SET @SQLSysOverview += '
	INSERT INTO #TmbTblOverview(Systems)
	SELECT COUNT(HostNameID)
	FROM CISOHostNameLookup(NOLOCK)HN
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	WHERE FL.IsActive = 1 AND HN.IsActive = 1
	'
	IF @Location IS NOT NULL
	BEGIN
		SET @SQLSysOverview += 'AND FL.[Location] IN (SELECT [Location] FROM #TempTblLocation) '		
	END
	IF @Facility IS NOT NULL
	BEGIN
		SET @SQLSysOverview += ' AND FL.[Facility] IN (SELECT [Facility] FROM #TempTblFacility) '
	END
	EXEC(@SQLSysOverview)

	SET @SQLSysOverview = ''
	SET @SQLSysOverview += '
	UPDATE #TmbTblOverview SET Active = (SELECT COUNT(DISTINCT RKV.HostNameID)
	FROM CISORegistryKeyValues(NOLOCK)RKV
	INNER JOIN CISOHostNameLookup(NOLOCK)HN
	ON RKV.HostNameID = HN.HostNameID
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	WHERE FL.IsActive = 1 AND HN.IsActive = 1 AND ComputerStatus = 1 AND ErrorID = 0
	AND RunAt BETWEEN '+ CHAR(39) + CONVERT(VARCHAR(50),@STime,121) + CHAR(39) + 
	' AND ' + CHAR(39) + CONVERT(VARCHAR(50),@ETime,121) + CHAR(39) + ' AND AppID = 1
	'
	IF @Location IS NOT NULL
	BEGIN
		SET @SQLSysOverview += 'AND FL.[Location] IN (SELECT [Location] FROM #TempTblLocation) '
	END
	IF @Facility IS NOT NULL
	BEGIN
		SET @SQLSysOverview += ' AND FL.[Facility] IN (SELECT [Facility] FROM #TempTblFacility) '
	END
	SET @SQLSysOverview += ')'

	EXEC(@SQLSysOverview)

	UPDATE #TmbTblOverview SET RunAt = @Date, InActive = (SELECT Systems-Active FROM #TmbTblOverview)
	/*---<<<END>>>---*/

	/*START*/
	DECLARE @ColumnName VARCHAR(MAX),@QryTmpTbl VARCHAR(500),@QryTmpTblPvt VARCHAR(500)
	DECLARE @APPColumnName VARCHAR(MAX),@SqlAppQry VARCHAR(MAX),@APPColumnPvt VARCHAR(MAX)

	SET @SqlAppQry = ''

	CREATE TABLE #TmpTblOSAppInfo(HostNameID INT)
	SELECT  @ColumnName =  ISNULL(@ColumnName + ';','') + ' ALTER TABLE #TmpTblOSAppInfo ADD ' + QUOTENAME(AppName)  + ' INT'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND AppName != 'HotFixID'	
		UNION SELECT 'Monthly'
		UNION SELECT 'Security'
		UNION SELECT 'Servicing'
	)App

	EXEC(@ColumnName)

	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSName VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSVersion VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSBuild VARCHAR(250)

	CREATE TABLE #TmbTblPivot(HostNameID INT)

	SELECT  @APPColumnPvt =  ISNULL(@APPColumnPvt + ';','') + ' ALTER TABLE #TmbTblPivot ADD ' + QUOTENAME(AppName)  + ' VARCHAR(2000)'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 
	)App

	EXEC(@APPColumnPvt)

	SELECT @APPColumnName= ISNULL(@APPColumnName + ',','') + QUOTENAME(AppName)        
	FROM 
	(
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1
	) AS ReportTitle   


	SET @SqlAppQry = 'INSERT INTO #TmbTblPivot(HostNameID,' + @APPColumnName + ')
	SELECT HostNameID,' + @APPColumnName + '
	FROM
	(
		SELECT 
		KV.HostNameID,KP.AppName,KeyValues
		FROM CISORegistryKeyValues(NOLOCK)KV
		INNER JOIN CISORegistryKeyPath(NOLOCK)KP
		ON KP.ID = KV.AppID
		INNER JOIN CISOHostNameLookup(NOLOCK)HN
		ON KV.HostNameID = HN.HostNameID
		INNER JOIN CISOFacilityLookup(NOLOCK)FL
		ON HN.FacilityID = FL.FacilityID
		WHERE FL.IsActive = 1 AND HN.IsActive = 1 AND KV.ComputerStatus = 1
		AND RunAt BETWEEN '+ CHAR(39) + CONVERT(VARCHAR(50),@STime,121) + CHAR(39) + 
		' AND ' + CHAR(39) + CONVERT(VARCHAR(50),@ETime,121) + CHAR(39) 
		IF @Location IS NOT NULL
		BEGIN
			SET @SqlAppQry += ' AND FL.[Location] IN (SELECT [Location] FROM #TempTblLocation) '
		END
		IF @Facility IS NOT NULL
		BEGIN
			SET @SqlAppQry += ' AND FL.[Facility] IN (SELECT [Facility] FROM #TempTblFacility) '
		END
	SET @SqlAppQry += '
	)X
	PIVOT (MAX(KeyValues)
	FOR AppName IN (' + @APPColumnName + ')) AS PVTTable 
	WHERE PVTTable.OSName != ''-'''
	EXEC(@SqlAppQry)

	/*---<<<END>>>---*/

	CREATE TABLE #TmbTblHotFixOutput
	(
	OSName			VARCHAR(250),
	OSBuild			VARCHAR(250),
	Monthly			INT DEFAULT 0,
	[Security]		INT DEFAULT 0,
	Servicing		INT DEFAULT 0,
	IssueMonthly	INT DEFAULT 0,
	IssueSecurity	INT DEFAULT 0,
	IssueServicing	INT DEFAULT 0,
	ErrorMonthly	INT DEFAULT 0,
	ErrorSecurity	INT DEFAULT 0,
	ErrorServicing	INT DEFAULT 0
	)

	SELECT TMP.HostNameID,TMP.HotFixID,DV.Monthly,DV.[Security],DV.Servicing
	INTO #TmbTblHotFix 
	FROM #TmbTblPivot TMP
	LEFT JOIN CISORegistryDefaultValue(NOLOCK)DV
	ON DV.OSName = TMP.OSName AND DV.OSVersion = TMP.OSBuild

	INSERT INTO #TmpTblOSAppInfo(HostNameID,OSName,OSVersion,OSBuild)
	SELECT HostNameID,OSName,OSVersion,OSBuild 
	FROM #TmbTblPivot

	DECLARE @OSBuildCount INT,@OSBuildKB VARCHAR(150),@SQLOSBuildQry VARCHAR(MAX)
	SET @OSBuildCount = 1

	WHILE @OSBuildCount <= 3
	BEGIN
		IF @OSBuildCount = 1 BEGIN SET @OSBuildKB = '[Monthly]' END
		IF @OSBuildCount = 2 BEGIN SET @OSBuildKB = '[Security]' END
		IF @OSBuildCount = 3 BEGIN SET @OSBuildKB = '[Servicing]' END

		SET @SQLOSBuildQry = 'UPDATE PVT SET PVT.' + @OSBuildKB + ' = 1
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 0
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID NOT LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 2
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a		
			WHERE a.' + @OSBuildKB +' IS NOT NULL 
			AND a.HotFixID like ''Err: %''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID'

		EXEC(@SQLOSBuildQry)
		SET @OSBuildCount = @OSBuildCount + 1
		SET @OSBuildKB = ''
	END

	/*---STATUS VALUE DESCRIPTION---*/
	/* 
	0 - Issue System need to updated patch
	1 - No issues
	2 - Error
	*/

	CREATE TABLE #TmbTblColumn(ID INT,AppID INT, ColumnName VARCHAR(200))
	INSERT INTO #TmbTblColumn(ID,AppID, ColumnName)
	SELECT ROW_NUMBER() OVER(ORDER BY [ID]),ID,AppName
	FROM CISORegistryKeyPath(NOLOCK) 
	WHERE IsActive = 1 AND AppName NOT LIKE 'OS%'

	DECLARE @APPColumn VARCHAR(200), @APPValue VARCHAR(200), @SQLQryApp VARCHAR(MAX)
	,@Count INT, @eCount INT--, @sColumn VARCHAR(150)

	SET @Count = 1
	SET @eCount = (SELECT COUNT(ID) FROM #TmbTblColumn)

	WHILE @Count <= @eCount
	BEGIN	
		SELECT TOP 1 @APPColumn = ColumnName FROM #TmbTblColumn WHERE id = @Count
		SELECT TOP 1 @APPValue = RKP.DefaultValue 
		FROM #TmbTblColumn a
		INNER JOIN CISORegistryKeyPath(NOLOCK)RKP
		ON A.AppID = RKP.ID
		WHERE A.ID = @Count

		SET @SQLQryApp = 'UPDATE PVT SET PVT.' + @APPColumn + ' = 1
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' = ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 0
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' != ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 2
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' LIKE ''Err: %''
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID'		

		EXEC(@SQLQryApp)
		SET @Count = @Count + 1
	END

	/**/

	INSERT INTO #TmbTblHotFixOutput(OSName,OSBuild)
	SELECT OSName,OSBuild 
	FROM #TmpTblOSAppInfo
	GROUP BY OSName,OSBuild
	ORDER BY 2

	SELECT ROW_NUMBER() OVER(ORDER BY [name]) SNo,[Name]
	INTO #TmbTblHF
	FROM tempdb.SYS.COLUMNS
	WHERE OBJECT_ID = OBJECT_ID('tempdb..#TmbTblHotFixOutput')
	AND [name] NOT IN('OSName','OSBuild')

	DECLARE @hfCount INT, @hfeCount INT, @hfsColumn VARCHAR(200)
	,@SqlQueryHF VARCHAR(MAX),@CLreview VARCHAR(50),@ConditionHF VARCHAR(100)
	,@addCondition VARCHAR(150)
	SET @hfCount = 1
	SET @hfeCount = (SELECT COUNT(SNo) FROM #TmbTblHF)

	WHILE @hfCount <= @hfeCount
	BEGIN
		SELECT TOP 1 @hfsColumn = [Name] FROM #TmbTblHF WHERE SNo = @hfCount
		SET @CLreview = LEFT(@hfsColumn,3)
		if @CLreview = 'Err'
		BEGIN
			SET @ConditionHF = '2'
			SET @addCondition = REPLACE(@hfsColumn,'Error','')
		END
		ELSE IF @CLreview = 'Iss'
		BEGIN
			SET @ConditionHF = '0'
			SET @addCondition = REPLACE(@hfsColumn,'Issue','')
		END
		ELSE
		BEGIN
			SET @ConditionHF = '1'
			SET @addCondition = @hfsColumn
		END

		SET @SqlQueryHF = 'UPDATE HFO SET HFO.' + @hfsColumn + ' = HT.cnt
		FROM(
			SELECT a.OSName,a.OSBuild,COUNT(HostNameID)cnt 
			FROM #TmpTblOSAppInfo a
			--INNER JOIN #TmbTblHotFixOutput b
			--ON a.OSName = b.OSName AND a.OSBuild = b.OSBuild
			WHERE a.' + @addCondition +' = ' + @ConditionHF + '
			AND a.' + @addCondition + ' IS NOT NULL  
			GROUP BY a.OSName,a.OSBuild
		)HT
		INNER JOIN #TmbTblHotFixOutput HFO
		ON HT.OSName = HFO.OSName AND HT.OSBuild = HFO.OSBuild'	
		--PRINT @SqlQueryHF
		EXEC(@SqlQueryHF)
		SET @hfCount = @hfCount + 1
	END

	UPDATE #TmbTblHotFixOutput SET OSBuild = '-' WHERE OSBuild = 'No Registry Key'


	CREATE TABLE #TmpTblAppInfo
	(
		AppName		VARCHAR(250),
		Systems		INT DEFAULT 0,
		Healthy		INT DEFAULT 0,
		Issue		INT DEFAULT 0,
		AppError	INT DEFAULT 0
	)


	INSERT INTO #TmpTblAppInfo(AppName)
	SELECT ColumnName FROM #TmbTblColumn WHERE ColumnName != 'HotFixID'

	DECLARE @appinfoCount INT,@appinfovCount INT ,@appinfoName VARCHAR(250)
	,@sqlappinfoqRY VARCHAR(MAX)

	SET @appinfoCount = 1
	SET @appinfovCount = (SELECT COUNT(AppID) FROM #TmbTblColumn WHERE ColumnName != 'HotFixID')

	WHILE @appinfoCount <= @appinfovCount
	BEGIN
		SELECT @appinfoName = ColumnName FROM #TmbTblColumn WHERE ID = @appinfoCount
		SET @sqlappinfoqRY = '
		UPDATE #TmpTblAppInfo 
		SET Systems = (SELECT COUNT(HostNameID) 
			FROM #TmpTblOSAppInfo
			WHERE ' + @appinfoName +' IN (0,1,2)
		)
		WHERE AppName = ' + CHAR(39) + @appinfoName + CHAR(39) + ' 
		UPDATE #TmpTblAppInfo 
		SET Healthy = (SELECT COUNT(HostNameID) 
			FROM #TmpTblOSAppInfo
			WHERE ' + @appinfoName +' = 1
		)
		WHERE AppName = ' + CHAR(39) + @appinfoName + CHAR(39) +' 
		UPDATE #TmpTblAppInfo 
		SET Issue = (SELECT COUNT(HostNameID) 
			FROM #TmpTblOSAppInfo
			WHERE ' + @appinfoName +' = 0
		)
		WHERE AppName = ' + CHAR(39) + @appinfoName + CHAR(39)+' 
		UPDATE #TmpTblAppInfo 
		SET AppError = (SELECT COUNT(HostNameID) 
			FROM #TmpTblOSAppInfo
			WHERE ' + @appinfoName +' = 2
		)
		WHERE AppName = ' + CHAR(39) + @appinfoName + CHAR(39)
		EXEC(@sqlappinfoqRY)
		SET @appinfoCount = @appinfoCount + 1	
	END

	DECLARE @HealthyClm VARCHAR(MAX),@SqlQryHealthy VARCHAR(MAX)
	,@CriticalClm VARCHAR(MAX), @SqlQryCritical VARCHAR(MAX)
	
	SELECT  @HealthyClm =  ISNULL(@HealthyClm + ' AND ','') + QUOTENAME(AppName)  + ' = 1'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND ID > 3 
		AND AppName NOT IN('HotFixID','FORCEPOINT')
	)App
	
	SET @SqlQryHealthy = 'UPDATE #TmbTblOverview SET Healthy = 
	(SELECT COUNT(HostNameID)
	FROM #TmpTblOSAppInfo 
	WHERE' + @HealthyClm + '
	AND ([Monthly] = 1 OR [Monthly] IS NULL) AND ([Security] = 1 OR [Security] IS NULL)
	AND ([Servicing] = 1 OR [Servicing] IS NULL))'
	EXEC(@SqlQryHealthy)

	SELECT  @CriticalClm =  ISNULL(@CriticalClm + ' OR ','') + QUOTENAME(AppName)  + ' = 0'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND Criteria = 1
	)App
	SET @SqlQryCritical = 'UPDATE #TmbTblOverview SET Critical = 
	(SELECT COUNT(HostNameID)
	FROM #TmpTblOSAppInfo 
	WHERE' + @CriticalClm + '
	OR ([Monthly] = 0 AND [Monthly] IS NOT NULL) OR ([Security] = 0 AND [Security] IS NOT NULL)
	OR ([Servicing] = 0 AND [Servicing] IS NOT NULL))'
	EXEC(@SqlQryCritical)
	
	UPDATE #TmbTblOverview SET Warning = (SELECT Active - (Critical + Healthy) FROM #TmbTblOverview)

	SELECT * FROM #TmbTblOverview

	SELECT OSName,COUNT(HostNameID)Systems
	FROM #TmbTblPivot
	GROUP BY OSName

	SELECT OSName,OSBuild, 
	CASE WHEN OSBuild = '-' THEN REPLACE(REPLACE(OSName, 'WorkStations', 'WKS'),'Windows ','W') 
	ELSE OSBuild + ' - '+ REPLACE(REPLACE(OSName, 'WorkStations', 'WKS'),'Windows ','W') END  AS OS,
	Monthly,IssueMonthly,ErrorMonthly,
	[Security],IssueSecurity,ErrorSecurity,
	Servicing,IssueServicing,ErrorServicing
	FROM #TmbTblHotFixOutput
	WHERE (Monthly+IssueMonthly+ErrorMonthly+
	[Security]+IssueSecurity+ErrorSecurity+
	Servicing+IssueServicing+ErrorServicing) > 0
	ORDER BY OSBuild ASC

	SELECT * FROM #TmpTblAppInfo

	IF OBJECT_ID('tempdb..#TempTblLocation') IS NOT NULL DROP TABLE #TempTblLocation  
	IF OBJECT_ID('tempdb..#TempTblFacility') IS NOT NULL DROP TABLE #TempTblFacility
	IF OBJECT_ID('tempdb..#TmbTblOverview') IS NOT NULL DROP TABLE #TmbTblOverview
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF
	IF OBJECT_ID('tempdb..#TmpTblAppInfo') IS NOT NULL DROP TABLE #TmpTblAppInfo
END
GO
/****** Object:  StoredProcedure [dbo].[CISOSystemOverview]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOSystemOverview]
(
	@Date DATETIME	
)
AS
BEGIN
	--DECLARE @Date DATETIME = '2020-02-21'
	
	IF OBJECT_ID('tempdb..#TmbTblOverview') IS NOT NULL DROP TABLE #TmbTblOverview
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF
	IF OBJECT_ID('tempdb..#TmpTblAppInfo') IS NOT NULL DROP TABLE #TmpTblAppInfo

	DECLARE @STime DATETIME,@ETime DATETIME,@SQLSysOverview VARCHAR(MAX)

	SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), @Date,101))
	SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,@Date), 0)))
	
	SET @SQLSysOverview = ''
	
	CREATE TABLE #TmbTblOverview
	(
		RunAt		DATE,
		Systems		INT DEFAULT 0,
		Active		INT DEFAULT 0,
		InActive	INT DEFAULT 0,
		Critical	INT DEFAULT 0,
		Warning		INT DEFAULT 0,
		Healthy		INT DEFAULT 0,	
	)

	/*START*/
	SET @SQLSysOverview += '
	INSERT INTO #TmbTblOverview(Systems)
	SELECT COUNT(HostNameID)
	FROM CISOHostNameLookup(NOLOCK)HN
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	WHERE FL.IsActive = 1 AND HN.IsActive = 1'	
	EXEC(@SQLSysOverview)

	SET @SQLSysOverview = ''
	SET @SQLSysOverview += '
	UPDATE #TmbTblOverview SET Active = (SELECT COUNT(DISTINCT RKV.HostNameID)
	FROM CISORegistryKeyValues(NOLOCK)RKV
	INNER JOIN CISOHostNameLookup(NOLOCK)HN
	ON RKV.HostNameID = HN.HostNameID
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON HN.FacilityID = FL.FacilityID
	WHERE FL.IsActive = 1 AND HN.IsActive = 1 AND ComputerStatus = 1 AND ErrorID = 0
	AND RunAt BETWEEN '+ CHAR(39) + CONVERT(VARCHAR(50),@STime,121) + CHAR(39) + 
	' AND ' + CHAR(39) + CONVERT(VARCHAR(50),@ETime,121) + CHAR(39) + ' AND AppID = 1'	
	SET @SQLSysOverview += ')'

	EXEC(@SQLSysOverview)

	UPDATE #TmbTblOverview SET RunAt = @Date, InActive = (SELECT Systems-Active FROM #TmbTblOverview)
	/*---<<<END>>>---*/

	/*START*/
	DECLARE @ColumnName VARCHAR(MAX),@QryTmpTbl VARCHAR(500),@QryTmpTblPvt VARCHAR(500)
	DECLARE @APPColumnName VARCHAR(MAX),@SqlAppQry VARCHAR(MAX),@APPColumnPvt VARCHAR(MAX)

	SET @SqlAppQry = ''

	CREATE TABLE #TmpTblOSAppInfo(HostNameID INT)
	SELECT  @ColumnName =  ISNULL(@ColumnName + ';','') + ' ALTER TABLE #TmpTblOSAppInfo ADD ' + QUOTENAME(AppName)  + ' INT'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND AppName != 'HotFixID'	
		UNION SELECT 'Monthly'
		UNION SELECT 'Security'
		UNION SELECT 'Servicing'
		UNION SELECT 'Status'
	)App

	EXEC(@ColumnName)

	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSName VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSVersion VARCHAR(250)
	ALTER TABLE #TmpTblOSAppInfo ALTER COLUMN OSBuild VARCHAR(250)

	CREATE TABLE #TmbTblPivot(HostNameID INT)

	SELECT  @APPColumnPvt =  ISNULL(@APPColumnPvt + ';','') + ' ALTER TABLE #TmbTblPivot ADD ' + QUOTENAME(AppName)  + ' VARCHAR(2000)'           
	FROM (	
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 
	)App

	EXEC(@APPColumnPvt)

	SELECT @APPColumnName= ISNULL(@APPColumnName + ',','') + QUOTENAME(AppName)        
	FROM 
	(
		SELECT AppName
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1
	) AS ReportTitle   


	SET @SqlAppQry = 'INSERT INTO #TmbTblPivot(HostNameID,' + @APPColumnName + ')
	SELECT HostNameID,' + @APPColumnName + '
	FROM
	(
		SELECT 
		KV.HostNameID,KP.AppName,KeyValues
		FROM CISORegistryKeyValues(NOLOCK)KV
		INNER JOIN CISORegistryKeyPath(NOLOCK)KP
		ON KP.ID = KV.AppID
		INNER JOIN CISOHostNameLookup(NOLOCK)HN
		ON KV.HostNameID = HN.HostNameID
		INNER JOIN CISOFacilityLookup(NOLOCK)FL
		ON HN.FacilityID = FL.FacilityID
		WHERE FL.IsActive = 1 AND HN.IsActive = 1 AND KV.ComputerStatus = 1
		AND RunAt BETWEEN '+ CHAR(39) + CONVERT(VARCHAR(50),@STime,121) + CHAR(39) + 
		' AND ' + CHAR(39) + CONVERT(VARCHAR(50),@ETime,121) + CHAR(39) +
		'
	)X
	PIVOT (MAX(KeyValues)
	FOR AppName IN (' + @APPColumnName + ')) AS PVTTable 
	WHERE PVTTable.OSName != ''-'''
	EXEC(@SqlAppQry)

	/*---<<<END>>>---*/

	CREATE TABLE #TmbTblHotFixOutput
	(
	OSName			VARCHAR(250),
	OSBuild			VARCHAR(250),
	Monthly			INT DEFAULT 0,
	[Security]		INT DEFAULT 0,
	Servicing		INT DEFAULT 0,
	IssueMonthly	INT DEFAULT 0,
	IssueSecurity	INT DEFAULT 0,
	IssueServicing	INT DEFAULT 0,
	ErrorMonthly	INT DEFAULT 0,
	ErrorSecurity	INT DEFAULT 0,
	ErrorServicing	INT DEFAULT 0
	)

	SELECT TMP.HostNameID,TMP.HotFixID,DV.Monthly,DV.[Security],DV.Servicing
	INTO #TmbTblHotFix 
	FROM #TmbTblPivot TMP
	LEFT JOIN CISORegistryDefaultValue(NOLOCK)DV
	ON DV.OSName = TMP.OSName AND DV.OSVersion = TMP.OSBuild

	INSERT INTO #TmpTblOSAppInfo(HostNameID,OSName,OSVersion,OSBuild)
	SELECT HostNameID,OSName,OSVersion,OSBuild 
	FROM #TmbTblPivot

	DECLARE @OSBuildCount INT,@OSBuildKB VARCHAR(150),@SQLOSBuildQry VARCHAR(MAX)
	SET @OSBuildCount = 1

	WHILE @OSBuildCount <= 3
	BEGIN
		IF @OSBuildCount = 1 BEGIN SET @OSBuildKB = '[Monthly]' END
		IF @OSBuildCount = 2 BEGIN SET @OSBuildKB = '[Security]' END
		IF @OSBuildCount = 3 BEGIN SET @OSBuildKB = '[Servicing]' END

		SET @SQLOSBuildQry = 'UPDATE PVT SET PVT.' + @OSBuildKB + ' = 1
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 0
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a
			INNER JOIN #TmbTblHotFix q 
			ON q.HostNameID = a.HostNameID AND a.' + @OSBuildKB +' IS NOT NULL
			Where a.HotFixID NOT LIKE ''%'' + q.' + @OSBuildKB +' + ''%''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID

		UPDATE PVT SET PVT.' + @OSBuildKB + ' = 2
		FROM(
			SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
			FROM #TmbTblHotFix a		
			WHERE a.' + @OSBuildKB +' IS NOT NULL 
			AND a.HotFixID like ''Err: %''
		)BK
		INNER JOIN #TmpTblOSAppInfo PVT
		ON BK.HostNameID = PVT.HostNameID'

		EXEC(@SQLOSBuildQry)
		SET @OSBuildCount = @OSBuildCount + 1
		SET @OSBuildKB = ''
	END

	CREATE TABLE #TmbTblColumn(ID INT,AppID INT, ColumnName VARCHAR(200))
	INSERT INTO #TmbTblColumn(ID,AppID, ColumnName)
	SELECT ROW_NUMBER() OVER(ORDER BY [ID]),ID,AppName
	FROM CISORegistryKeyPath(NOLOCK) 
	WHERE IsActive = 1 AND AppName NOT LIKE 'OS%'

	DECLARE @APPColumn VARCHAR(200), @APPValue VARCHAR(200), @SQLQryApp VARCHAR(MAX)
	,@Count INT, @eCount INT--, @sColumn VARCHAR(150)

	SET @Count = 1
	SET @eCount = (SELECT COUNT(ID) FROM #TmbTblColumn)

	WHILE @Count <= @eCount
	BEGIN	
		SELECT TOP 1 @APPColumn = ColumnName FROM #TmbTblColumn WHERE id = @Count
		SELECT TOP 1 @APPValue = RKP.DefaultValue 
		FROM #TmbTblColumn a
		INNER JOIN CISORegistryKeyPath(NOLOCK)RKP
		ON A.AppID = RKP.ID
		WHERE A.ID = @Count

		SET @SQLQryApp = 'UPDATE PVT SET PVT.' + @APPColumn + ' = 1
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' = ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 0
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' != ' + CHAR(39) + @APPValue + CHAR(39) +'
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID
	
		UPDATE PVT SET PVT.' + @APPColumn + ' = 2
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @APPColumn +' LIKE ''Err: %''
		)Mon
		INNER JOIN #TmpTblOSAppInfo PVT
		ON mon.HostNameID = PVT.HostNameID'		

		EXEC(@SQLQryApp)
		SET @Count = @Count + 1
	END

	/**/

	INSERT INTO #TmbTblHotFixOutput(OSName,OSBuild)
	SELECT OSName,OSBuild 
	FROM #TmpTblOSAppInfo
	GROUP BY OSName,OSBuild
	ORDER BY 2

	SELECT ROW_NUMBER() OVER(ORDER BY [name]) SNo,[Name]
	INTO #TmbTblHF
	FROM tempdb.SYS.COLUMNS
	WHERE OBJECT_ID = OBJECT_ID('tempdb..#TmbTblHotFixOutput')
	AND [name] NOT IN('OSName','OSBuild')

	DECLARE @hfCount INT, @hfeCount INT, @hfsColumn VARCHAR(200)
	,@SqlQueryHF VARCHAR(MAX),@CLreview VARCHAR(50),@ConditionHF VARCHAR(100)
	,@addCondition VARCHAR(150)
	SET @hfCount = 1
	SET @hfeCount = (SELECT COUNT(SNo) FROM #TmbTblHF)

	WHILE @hfCount <= @hfeCount
	BEGIN
		SELECT TOP 1 @hfsColumn = [Name] FROM #TmbTblHF WHERE SNo = @hfCount
		SET @CLreview = LEFT(@hfsColumn,3)
		if @CLreview = 'Err'
		BEGIN
			SET @ConditionHF = '2'
			SET @addCondition = REPLACE(@hfsColumn,'Error','')
		END
		ELSE IF @CLreview = 'Iss'
		BEGIN
			SET @ConditionHF = '0'
			SET @addCondition = REPLACE(@hfsColumn,'Issue','')
		END
		ELSE
		BEGIN
			SET @ConditionHF = '1'
			SET @addCondition = @hfsColumn
		END

		SET @SqlQueryHF = 'UPDATE HFO SET HFO.' + @hfsColumn + ' = HT.cnt
		FROM(
			SELECT a.OSName,a.OSBuild,COUNT(HostNameID)cnt 
			FROM #TmpTblOSAppInfo a
			--INNER JOIN #TmbTblHotFixOutput b
			--ON a.OSName = b.OSName AND a.OSBuild = b.OSBuild
			WHERE a.' + @addCondition +' = ' + @ConditionHF + '
			AND a.' + @addCondition + ' IS NOT NULL  
			GROUP BY a.OSName,a.OSBuild
		)HT
		INNER JOIN #TmbTblHotFixOutput HFO
		ON HT.OSName = HFO.OSName AND HT.OSBuild = HFO.OSBuild'	
		--PRINT @SqlQueryHF
		EXEC(@SqlQueryHF)
		SET @hfCount = @hfCount + 1
	END

	UPDATE #TmbTblHotFixOutput SET OSBuild = '-' WHERE OSBuild = 'No Registry Key'

	DECLARE @HealthyClm VARCHAR(MAX),@SqlQryHealthy VARCHAR(MAX)
	,@CriticalClm VARCHAR(MAX), @SqlQryCritical VARCHAR(MAX)
	
	SELECT  @HealthyClm =  ISNULL(@HealthyClm + ' AND ','') + QUOTENAME(AppName)  + ' = 1'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND ID > 3 
		AND AppName NOT IN('HotFixID','FORCEPOINT')
	)App
	
	SET @SqlQryHealthy = 'UPDATE OS SET OS.[Status] = 1
		FROM(
			SELECT DISTINCT HostNameID
			FROM #TmpTblOSAppInfo 
			WHERE '+ @HealthyClm + '
			AND ([Monthly] = 1 OR [Monthly] IS NULL) AND ([Security] = 1 OR [Security] IS NULL)
			AND ([Servicing] = 1 OR [Servicing] IS NULL)
		)HT
		INNER JOIN #TmpTblOSAppInfo OS
		ON OS.HostNameID = HT.HostNameID'
	EXEC(@SqlQryHealthy)

	SELECT  @CriticalClm =  ISNULL(@CriticalClm + ' OR ','') + QUOTENAME(AppName)  + ' = 0'           
	FROM (	
		SELECT AppName 
		FROM CISORegistryKeyPath(NOLOCK) 
		WHERE IsActive = 1 AND Criteria = 1
	)App

	SET @SqlQryCritical = 'UPDATE OS SET OS.[Status] = 2
		FROM(
			SELECT DISTINCT HostNameID
			FROM #TmpTblOSAppInfo 
			WHERE '+@CriticalClm + '
			OR ([Monthly] = 0 AND [Monthly] IS NOT NULL) OR ([Security] = 0 AND [Security] IS NOT NULL)
			OR ([Servicing] = 0 AND [Servicing] IS NOT NULL)
		)HT
		INNER JOIN #TmpTblOSAppInfo OS
		ON OS.HostNameID = HT.HostNameID'
	EXEC(@SqlQryCritical)
	
	UPDATE #TmpTblOSAppInfo SET [Status] = 3 WHERE [Status] IS NULL
	
	UPDATE #TmbTblOverview set Critical = (SELECT COUNT(HostNameID) FROM #TmpTblOSAppInfo WHERE [Status] = 2)
	UPDATE #TmbTblOverview set Warning = (SELECT COUNT(HostNameID) FROM #TmpTblOSAppInfo WHERE [Status] = 3)
	UPDATE #TmbTblOverview set Healthy = (SELECT COUNT(HostNameID) FROM #TmpTblOSAppInfo WHERE [Status] = 1)

	SELECT * FROM #TmbTblOverview
	
	SELECT [Location],Facility,AssetID,HostName,OSName, OSBuild,
	CASE WHEN [Status] = 1 THEN 'Healthy' ELSE
	CASE WHEN [Status] = 2 THEN 'Critical' ELSE
	CASE WHEN [Status] = 3 THEN 'Warning'  END END END AS [Status]
	FROM #TmpTblOSAppInfo OS
	INNER JOIN CISOHostNameLookup(NOLOCK)HN
	ON OS.HostNameID = HN.HostNameID
	INNER JOIN CISOFacilityLookup(NOLOCK)FL
	ON FL.FacilityID = HN.FacilityID
	WHERE HN.IsActive = 1 AND FL.IsActive = 1

	IF OBJECT_ID('tempdb..#TmbTblOverview') IS NOT NULL DROP TABLE #TmbTblOverview
	IF OBJECT_ID('tempdb..#TmpTblOSAppInfo') IS NOT NULL DROP TABLE #TmpTblOSAppInfo
	IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
	IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
	IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
	IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
	IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF
	IF OBJECT_ID('tempdb..#TmpTblAppInfo') IS NOT NULL DROP TABLE #TmpTblAppInfo
END
GO
/****** Object:  StoredProcedure [dbo].[CISOSystemStatus]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOSystemStatus]
(
	@Date DATETIME
)
AS
BEGIN

--DECLARE @Date DATETIME = GETDATE()

IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
IF OBJECT_ID('tempdb..#TmbTblOutput') IS NOT NULL DROP TABLE #TmbTblOutput
IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF
IF OBJECT_ID('tempdb..#TmbTblOverview') IS NOT NULL DROP TABLE #TmbTblOverview

CREATE TABLE #TmbTblOverview
(
RunAt			DATE,
Systems			INT DEFAULT 0,
UP				INT DEFAULT 0,
Unidentified	INT DEFAULT 0,
Critical		INT DEFAULT 0,
Warning			INT DEFAULT 0,	
)

CREATE TABLE #TmbTblOutput
(
HostNameID					INT,
ComputerStatus				INT,
OSName						VARCHAR(250),
OSVersion					VARCHAR(250),
OSBuild						VARCHAR(250),
SymantecStatus				INT,
SymantecVersion				INT,
EDPAPath					INT,
Echolock					INT,
--FORCEPOINT					INT,
BigFix						INT,
--ManageEngineAssetExplorer	INT,
Monthly						INT,
[Security]					INT,
Servicing					INT
)

CREATE TABLE #TmbTblHotFixOutput
(
OSName			VARCHAR(250),
OSBuild			VARCHAR(250),
Monthly			INT DEFAULT 0,
[Security]		INT DEFAULT 0,
Servicing		INT DEFAULT 0,
IssMonthly	INT DEFAULT 0,
IssSecurity	INT DEFAULT 0,
IssServicing	INT DEFAULT 0,
ErrMonthly	INT DEFAULT 0,
ErrSecurity	INT DEFAULT 0,
ErrServicing	INT DEFAULT 0
)

CREATE TABLE #TmbTblColumn(ID INT,ColumnName VARCHAR(200))

DECLARE @STime DATETIME,@ETime DATETIME

SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), @Date,101))
SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,@Date), 0)))

/*START*/
INSERT INTO #TmbTblOverview(RunAt,Systems)
SELECT CONVERT(VARCHAR(25),@Date,120),COUNT(HostNameID)
FROM CISOHostNameLookup(NOLOCK)
WHERE IsActive = 1

UPDATE #TmbTblOverview SET UP = (SELECT COUNT(DISTINCT RKV.HostNameID)
FROM CISORegistryKeyValues(NOLOCK)RKV
INNER JOIN CISOHostNameLookup(NOLOCK)HN
ON RKV.HostNameID = HN.HostNameID
WHERE HN.IsActive = 1 AND ComputerStatus = 1 AND KeyValues != '-'
AND RunAt BETWEEN @STime AND @ETime AND AppID = 1)

UPDATE #TmbTblOverview SET Unidentified = (SELECT Systems-UP FROM #TmbTblOverview)

SELECT RunAt,Systems,UP Live,Unidentified,Critical,Warning
FROM #TmbTblOverview

SELECT HN.HostName, CONVERT(VARCHAR(5),ISNULL(KV.ComputerStatus,0))SysStatus
FROM CISOHostNameLookup(NOLOCK)HN
LEFT JOIN (SELECT HostNameID,ComputerStatus 
FROM CISORegistryKeyValues(NOLOCK)
WHERE RunAt >= @STime AND RunAt <= @ETime
GROUP BY HostNameID,ComputerStatus)KV
ON KV.HostNameID = HN.HostNameID
WHERE HN.IsActive = 1
ORDER BY 1 ASC
/*END */

SELECT HostNameID,ComputerStatus,
OSName,OSVersion,OSBuild,SymantecStatus,SymantecVersion,EDPAPath,Echolock,FORCEPOINT,BigFix,ManageEngineAssetExplorer,HotFixID	
INTO #TmbTblPivot
FROM
(
	SELECT 
	KV.HostNameID,ComputerStatus,KP.AppName,KeyValues
	FROM CISORegistryKeyValues(NOLOCK)KV
	INNER JOIN CISORegistryKeyPath(NOLOCK)KP
	ON KP.ID = KV.AppID
	INNER JOIN CISOHostNameLookup(NOLOCK)HN
	ON KV.HostNameID = HN.HostNameID
	WHERE HN.IsActive = 1 AND KV.ComputerStatus = 1
	AND RunAt BETWEEN @STime AND @ETime
)X
PIVOT (max(KeyValues)
FOR AppName IN (OSName,OSVersion,OSBuild,SymantecStatus,SymantecVersion,EDPAPath,Echolock,FORCEPOINT,BigFix,ManageEngineAssetExplorer,HotFixID)) AS PVTTable 
WHERE PVTTable.OSName != '-'

SELECT TMP.HostNameID,TMP.HotFixID,DV.Monthly,DV.[Security],DV.Servicing
INTO #TmbTblHotFix FROM #TmbTblPivot TMP
LEFT JOIN CISORegistryDefaultValue(NOLOCK)DV
ON DV.OSName = TMP.OSName AND DV.OSVersion = TMP.OSBuild

INSERT INTO #TmbTblOutput(HostNameID,ComputerStatus,OSName,OSVersion,OSBuild)
SELECT HostNameID,ComputerStatus,OSName,OSVersion,OSBuild 
FROM #TmbTblPivot

UPDATE PVT SET PVT.Monthly = 1
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.Monthly IS NOT NULL
	Where a.HotFixID LIKE '%' + q.Monthly + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE PVT SET PVT.Monthly = 0
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.Monthly IS NOT NULL
	Where a.HotFixID NOT LIKE '%' + q.Monthly + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE OT SET OT.Monthly = 2
FROM(
SELECT HostNameID
FROM #TmbTblHotFix
WHERE HotFixID like 'Err: %'
)NR
INNER JOIN #TmbTblOutput OT
ON NR.HostNameID = OT.HostNameID AND OT.Monthly = 0 

UPDATE PVT SET PVT.[Security] = 1
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.[Security] IS NOT NULL
	Where a.HotFixID LIKE '%' + q.[Security] + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE PVT SET PVT.[Security] = 0
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.[Security] IS NOT NULL
	Where a.HotFixID NOT LIKE '%' + q.[Security] + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE OT SET OT.[Security] = 2
FROM(
SELECT HostNameID
FROM #TmbTblHotFix
WHERE HotFixID like 'Err: %'
)NR
INNER JOIN #TmbTblOutput OT
ON NR.HostNameID = OT.HostNameID AND OT.[Security] = 0 

UPDATE PVT SET PVT.Servicing = 1
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.Servicing IS NOT NULL
	Where a.HotFixID LIKE '%' + q.Servicing + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE PVT SET PVT.Servicing = 0
FROM(
	SELECT a.HostNameID,a.HotFixID,a.Monthly,a.[Security],a.Servicing
	FROM #TmbTblHotFix a
	INNER JOIN #TmbTblHotFix q 
	ON q.HostNameID = a.HostNameID AND a.Servicing IS NOT NULL
	Where a.HotFixID NOT LIKE '%' + q.Servicing + '%'
)Mon
INNER JOIN #TmbTblOutput PVT
ON mon.HostNameID = PVT.HostNameID

UPDATE OT SET OT.Servicing = 2
FROM(
SELECT HostNameID
FROM #TmbTblHotFix
WHERE HotFixID like 'Err: %'
)NR
INNER JOIN #TmbTblOutput OT
ON NR.HostNameID = OT.HostNameID AND OT.Servicing = 0 

/*---STATUS VALUE DESCRIPTION---*/
/* 
0 - Issue System need to updated patch
1 - No issues
2 - Error
*/

DECLARE @SymantecStatus VARCHAR(100),@Echolock VARCHAR(100)
,@SymantecVersion VARCHAR(100),@EDPAPath VARCHAR(100),@BigFix VARCHAR(100)

INSERT INTO #TmbTblColumn(ID,ColumnName)VALUES(1,'SymantecStatus')
INSERT INTO #TmbTblColumn(ID,ColumnName)VALUES(2,'Echolock')
INSERT INTO #TmbTblColumn(ID,ColumnName)VALUES(3,'SymantecVersion')
INSERT INTO #TmbTblColumn(ID,ColumnName)VALUES(4,'EDPAPath')
INSERT INTO #TmbTblColumn(ID,ColumnName)VALUES(5,'BigFix')

DECLARE @Count INT, @eCount INT, 
@SqlQuery VARCHAR(MAX),@sColumn VARCHAR(100),
@Count1 INT , @Condition VARCHAR(250), @uValue VARCHAR(150)

SELECT @SymantecStatus = DefaultValue 
FROM CISORegistryKeyPath(NOLOCK) WHERE ID = 4 AND IsActive = 1

SELECT @Echolock = DefaultValue 
FROM CISORegistryKeyPath(NOLOCK) WHERE ID = 7 AND IsActive = 1

SELECT @SymantecVersion = DefaultValue 
FROM CISORegistryKeyPath(NOLOCK) WHERE ID = 5 AND IsActive = 1

SELECT @EDPAPath = DefaultValue 
FROM CISORegistryKeyPath(NOLOCK) WHERE ID = 6 AND IsActive = 1

SELECT @BigFix = DefaultValue 
FROM CISORegistryKeyPath(NOLOCK) WHERE ID = 9 AND IsActive = 1

SET @Count = 1
SET @eCount = (SELECT COUNT(ID) FROM #TmbTblColumn)
SET @Count1 = 1

WHILE @Count <= @eCount
BEGIN
	SELECT TOP 1 @sColumn = ColumnName FROM #TmbTblColumn WHERE id = @Count
	WHILE @Count1 <= 3	
	BEGIN		
		if @Count1 = 1 	
		BEGIN 
			SET @Condition = '@' + @sColumn 
			IF @Condition = '@SymantecStatus' BEGIN  SET @Condition =  ' = ''' + @SymantecStatus  + '''' END
			IF @Condition = '@Echolock' BEGIN  SET @Condition =  ' = ''' + @Echolock  + '''' END
			IF @Condition = '@SymantecVersion' BEGIN  SET @Condition =  ' = ''' + @SymantecVersion  + '''' END
			IF @Condition = '@EDPAPath' BEGIN  SET @Condition =  ' = ''' + @EDPAPath  + '''' END
			IF @Condition = '@BigFix' BEGIN  SET @Condition =  ' = ''' + @BigFix  + '''' END

			SET @uValue = @sColumn + ' = 1'
		END
		if @Count1 = 2 	
		BEGIN 
			SET @Condition = '@' + @sColumn
			IF @Condition = '@SymantecStatus' BEGIN  SET @Condition =  ' != ''' + @SymantecStatus  + '''' END
			IF @Condition = '@Echolock' BEGIN  SET @Condition =  ' != ''' + @Echolock  + '''' END 
			IF @Condition = '@SymantecVersion' BEGIN  SET @Condition =  ' != ''' + @SymantecVersion  + '''' END 
			IF @Condition = '@EDPAPath' BEGIN  SET @Condition =  ' != ''' + @EDPAPath  + '''' END 
			IF @Condition = '@BigFix' BEGIN  SET @Condition =  ' != ''' + @BigFix  + '''' END 
			SET @uValue = @sColumn + ' = 0'
		END
		if @Count1 = 3 	
		BEGIN 
			SET @Condition = ' LIKE ''Err: %'''
			SET @uValue = @sColumn + ' = 2' 
		END
		
		SET @SqlQuery = 'UPDATE PVT SET PVT.' + @uValue + '
		FROM(
			SELECT HostNameID FROM #TmbTblPivot 
			WHERE ' + @sColumn + @Condition + ' 
		)Mon
		INNER JOIN #TmbTblOutput PVT
		ON mon.HostNameID = PVT.HostNameID'	
		--PRINT @SqlQuery	
		EXEC(@SqlQuery)	  
	   SET @Count1 = @Count1 +1
	   SET @Condition = ''
	   SET @uValue = ''
   END
   SET @Count = @Count + 1
   SET @Count1 = 1
END

INSERT INTO #TmbTblHotFixOutput(OSName,OSBuild)
SELECT OSName,OSBuild 
FROM #TmbTblOutput
GROUP BY OSName,OSBuild
ORDER BY 2

SELECT ROW_NUMBER() OVER(ORDER BY [name]) SNo,[Name]
INTO #TmbTblHF
FROM tempdb.SYS.COLUMNS
WHERE OBJECT_ID = OBJECT_ID('tempdb..#TmbTblHotFixOutput')
AND [name] NOT IN('OSName','OSBuild')

DECLARE @hfCount INT, @hfeCount INT, @hfsColumn VARCHAR(200)
,@SqlQueryHF VARCHAR(MAX),@CLreview VARCHAR(50),@ConditionHF VARCHAR(100)
,@addCondition VARCHAR(150)
SET @hfCount = 1
SET @hfeCount = (SELECT COUNT(SNo) FROM #TmbTblHF)

WHILE @hfCount <= @hfeCount
BEGIN
	SELECT TOP 1 @hfsColumn = [Name] FROM #TmbTblHF WHERE SNo = @hfCount
	SET @CLreview = LEFT(@hfsColumn,3)
	if @CLreview = 'Err'
	BEGIN
		SET @ConditionHF = '2'
		SET @addCondition = REPLACE(@hfsColumn,'Err','')
	END
	ELSE IF @CLreview = 'Iss'
	BEGIN
		SET @ConditionHF = '0'
		SET @addCondition = REPLACE(@hfsColumn,'Iss','')
	END
	ELSE
	BEGIN
		SET @ConditionHF = '1'
		SET @addCondition = @hfsColumn
	END

	SET @SqlQueryHF = 'UPDATE HFO SET HFO.' + @hfsColumn + ' = HT.cnt
	FROM(
		SELECT a.OSName,a.OSBuild,COUNT(HostNameID)cnt 
		FROM #TmbTblOutput a
		--INNER JOIN #TmbTblHotFixOutput b
		--ON a.OSName = b.OSName AND a.OSBuild = b.OSBuild
		WHERE a.' + @addCondition +' = ' + @ConditionHF + '
		AND a.' + @addCondition + ' IS NOT NULL  
		GROUP BY a.OSName,a.OSBuild
	)HT
	INNER JOIN #TmbTblHotFixOutput HFO
	ON HT.OSName = HFO.OSName AND HT.OSBuild = HFO.OSBuild'	
	--PRINT @SqlQueryHF
	EXEC(@SqlQueryHF)
	SET @hfCount = @hfCount + 1
END

UPDATE #TmbTblHotFixOutput SET OSBuild = '-' WHERE OSBuild = 'No Registry Key'

SELECT OSName,COUNT(HostNameID)SysCount 
FROM #TmbTblPivot
GROUP BY OSName

SELECT OSName, HN.HostName 
FROM #TmbTblPivot tmp
INNER JOIN CISOHostNameLookup(NOLOCK)HN
ON TMP.HostNameID = HN.HostNameID
WHERE HN.IsActive = 1
ORDER BY 1,2 ASC

SELECT OSName,OSBuild, 
CASE WHEN OSBuild = '-' THEN REPLACE(OSName,'Windows ','W') 
ELSE OSBuild + ' - '+ REPLACE(OSName,'Windows ','W') END  AS OS,
Monthly,IssMonthly IssueMonthly,ErrMonthly ErrorMonthly,
[Security],IssSecurity IssueSecurity,ErrSecurity ErrorSecurity,
Servicing,IssServicing IssueServicing,ErrServicing ErrorServicing
FROM #TmbTblHotFixOutput

SELECT 'Monthly'Patch,HN.HostName,a.OSName,a.OSVersion,a.OSBuild,HotFixID,
CASE WHEN HotFixID LIKE 'Err: %' THEN 'AppError' ELSE 'Issue' END AS [Status]
FROM #TmbTblPivot A
INNER JOIN #TmbTblOutput B
ON A.HostNameID = B.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HN
ON hn.HostNameID = a.HostNameID
WHERE B.Monthly != 1 AND B.Monthly IS NOT NULL
UNION ALL
SELECT 'Monthly'Patch,HN.HostName,a.OSName,a.OSVersion,a.OSBuild,HotFixID,'NoIssues'[Status]
FROM #TmbTblPivot a
INNER JOIN CISOHostNameLookup(NOLOCK)HN
ON hn.HostNameID = a.HostNameID
WHERE a.HostNameID NOT IN (
SELECT a.HostNameID FROM #TmbTblPivot A
INNER JOIN #TmbTblOutput B
ON A.HostNameID = B.HostNameID
WHERE B.Monthly != 1 AND B.Monthly IS NOT NULL)
UNION ALL
SELECT 'Security'Patch,HN.HostName,a.OSName,a.OSVersion,a.OSBuild,HotFixID,
CASE WHEN HotFixID LIKE 'Err: %' THEN 'AppError' ELSE 'Issue' END AS [Status]
FROM #TmbTblPivot A
INNER JOIN #TmbTblOutput B
ON A.HostNameID = B.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HN
ON hn.HostNameID = a.HostNameID
WHERE B.[Security] != 1 AND B.[Security] IS NOT NULL
UNION ALL
SELECT 'Security'Patch,HN.HostName,a.OSName,a.OSVersion,a.OSBuild,HotFixID,'NoIssues'[Status]
FROM #TmbTblPivot a
INNER JOIN CISOHostNameLookup(NOLOCK)HN
ON hn.HostNameID = a.HostNameID
INNER JOIN #TmbTblOutput C
ON c.HostNameID = a.HostNameID and c.[Security] IS NOT NULL
WHERE c.[Security] = 1
UNION ALL
SELECT 'Servicing'Patch,HN.HostName,a.OSName,a.OSVersion,a.OSBuild,HotFixID,
CASE WHEN HotFixID LIKE 'Err: %' THEN 'AppError' ELSE 'Issue' END AS [Status]
FROM #TmbTblPivot A
INNER JOIN #TmbTblOutput B
ON A.HostNameID = B.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HN
ON hn.HostNameID = a.HostNameID
WHERE B.Servicing != 1 AND B.Servicing IS NOT NULL
UNION ALL
SELECT 'Servicing'Patch,HN.HostName,a.OSName,a.OSVersion,a.OSBuild,HotFixID,'NoIssues'[Status]
FROM #TmbTblPivot a
INNER JOIN CISOHostNameLookup(NOLOCK)HN
ON hn.HostNameID = a.HostNameID
INNER JOIN #TmbTblOutput C
ON c.HostNameID = a.HostNameID and c.Servicing IS NOT NULL
WHERE c.[Servicing] = 1

SELECT 'SymantecRunStatus'App,
(SELECT COUNT(HostNameID) FROM #TmbTblOutput where SymantecStatus IS NOT NULL)SysCount
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE SymantecStatus = '1')NoIssue
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE SymantecStatus = '0')Issue
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE SymantecStatus = '2')AppError
UNION ALL
SELECT 'EcholockVersion'App,
(SELECT COUNT(HostNameID) FROM #TmbTblOutput where Echolock IS NOT NULL)SysCount
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE Echolock = '1')NoIssue
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE Echolock = '0')Issue
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE Echolock = '2')AppError
UNION ALL
SELECT 'SymantecVersion'App,
(SELECT COUNT(HostNameID) FROM #TmbTblOutput where SymantecVersion IS NOT NULL)SysCount
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE SymantecVersion = '1')NoIssue
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE SymantecVersion = '0')Issue
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE SymantecVersion = '2')AppError
UNION ALL
SELECT 'EDPAPath'App,
(SELECT COUNT(HostNameID) FROM #TmbTblOutput where EDPAPath IS NOT NULL)SysCount
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE EDPAPath = '1')NoIssue
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE EDPAPath = '0')Issue
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE EDPAPath = '2')AppError
UNION ALL
SELECT 'BigFix'App,
(SELECT COUNT(HostNameID) FROM #TmbTblOutput where BigFix IS NOT NULL)SysCount
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE BigFix = '1')NoIssue
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE BigFix = '0')Issue
,(SELECT COUNT(HostNameID) FROM #TmbTblOutput WHERE BigFix = '2')AppError


SELECT 'SymantecRunStatus'App, hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.SymantecStatus AS Remarks ,'Issue' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.SymantecStatus =0
UNION ALL
SELECT 'SymantecRunStatus'App, hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.SymantecStatus AS Remarks ,'NoIssue' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.SymantecStatus = 1
UNION ALL
SELECT 'SymantecRunStatus'App, hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.SymantecStatus AS Remarks ,'AppError' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.SymantecStatus = 2
UNION ALL
SELECT 'EcholockVersion'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.Echolock AS Remarks  ,'Issue' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.Echolock = 0
UNION ALL
SELECT 'EcholockVersion'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.Echolock AS Remarks  ,'NoIssue' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.Echolock = 1
UNION ALL
SELECT 'EcholockVersion'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.Echolock AS Remarks  ,'AppError' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.Echolock = 2
UNION ALL
SELECT 'SymantecVersion'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.SymantecVersion AS Remarks  ,'Issue' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.SymantecVersion = 0
UNION ALL
SELECT 'SymantecVersion'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.SymantecVersion AS Remarks  ,'NoIssue' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.SymantecVersion = 1
UNION ALL
SELECT 'SymantecVersion'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.SymantecVersion AS Remarks  ,'AppError' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.SymantecVersion = 2
UNION ALL
SELECT 'EDPAPath'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.EDPAPath AS Remarks  ,'Issue' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.EDPAPath = 0
UNION ALL
SELECT 'EDPAPath'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.EDPAPath AS Remarks  ,'NoIssue' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.EDPAPath = 1
UNION ALL
SELECT 'EDPAPath'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.EDPAPath AS Remarks  ,'AppError' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.EDPAPath = 2
UNION ALL
SELECT 'BigFix'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.BigFix AS Remarks  ,'Issue' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.BigFix = 0
UNION ALL
SELECT 'BigFix'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.BigFix AS Remarks ,'NoIssue' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.BigFix = 1
UNION ALL
SELECT 'BigFix'App,hnl.HostName,pvt.OSName,pvt.OSVersion,pvt.OSBuild,
pvt.BigFix AS Remarks  ,'AppError' [Status]
FROM #TmbTblPivot pvt
INNER JOIN #TmbTblOutput OPT
ON pvt.HostNameID = OPT.HostNameID
INNER JOIN CISOHostNameLookup(NOLOCK)HNL
ON hnl.HostNameID = pvt.HostNameID
WHERE OPT.BigFix = 2

IF OBJECT_ID('tempdb..#TmbTblPivot') IS NOT NULL DROP TABLE #TmbTblPivot
IF OBJECT_ID('tempdb..#TmbTblHotFix') IS NOT NULL DROP TABLE #TmbTblHotFix
IF OBJECT_ID('tempdb..#TmbTblHotFixOutput') IS NOT NULL DROP TABLE #TmbTblHotFixOutput
IF OBJECT_ID('tempdb..#TmbTblOutput') IS NOT NULL DROP TABLE #TmbTblOutput
IF OBJECT_ID('tempdb..#TmbTblColumn') IS NOT NULL DROP TABLE #TmbTblColumn
IF OBJECT_ID('tempdb..#TmbTblHF') IS NOT NULL DROP TABLE #TmbTblHF
IF OBJECT_ID('tempdb..#TmbTblOverview') IS NOT NULL DROP TABLE #TmbTblOverview

END
GO
/****** Object:  StoredProcedure [dbo].[CISOUserAccess]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOUserAccess]
(@NTUserName VARCHAR(100) = null)
AS
BEGIN

	select Id, NTLoginName, PageAccess
		from CISOUsers
		(nolock)
		where 1 = case when @NTUserName is null  then 1 when NTLoginName = @NTUserName then 1 else 0 end
			and IsActive = 1

END
GO
/****** Object:  StoredProcedure [dbo].[CISOUserCrud]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CISOUserCrud]
(@Cmd varchar(50), @NTUserName VARCHAR(100), @PageAccess varchar(50) = null)
AS
BEGIN

IF @Cmd = 'CREATE'
BEGIN
 INSERT INTO CISOUsers ([NTLoginName], [PageAccess]) values (@NTUserName, @PageAccess);
 --SELECT * from CISOUsers where NTLoginName = @NTUserName
 select 'CREATE - Success'
END
ELSE IF @Cmd = 'UPDATE'
BEGIN
 UPDATE CISOUsers set PageAccess = @PageAccess where NTLoginName = @NTUserName
 --SELECT * from CISOUsers where NTLoginName = @NTUserName
 select 'Update - Success'
END
ELSE IF @Cmd = 'DELETE'
BEGIN
 UPDATE CISOUsers set IsActive = 0 where NTLoginName = @NTUserName
 --SELECT * from CISOUsers where IsActive = 1
 select 'DELETE - Success'
END
ELSE
BEGIN
 select 'Incorrect Command!!'
END

END
GO
/****** Object:  StoredProcedure [dbo].[CISOUserDeviceInfoUpdate]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Promodh Kumar
-- Create date: 03/04/2020
-- Description:	CISO User Device Info
-- =============================================
CREATE PROCEDURE [dbo].[CISOUserDeviceInfoUpdate]
	@UserAccount varchar(100),
	@EventDate	datetime,
	@UserDomain	varchar(100),
	@ServiceTag varchar(300),
	@MachineMake varchar(300),
	@ProcessorId varchar(300),
	@KeyBoardId varchar(300),
	@MouseId varchar(300),
	@HeadsetId varchar(300),
	@MonitorId varchar(300),
	@OSVersion varchar(300),
	@SystemType varchar(300),
	@ComputerIP varchar(100),
	@RunAt datetime,
	@DeviceType varchar(100),
	@Availability bit,
	@AdapterId varchar(100),
	@InstalledOn datetime,
	@LastUpTime datetime,
	@IsConnected datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	begin try

		begin tran

		if not exists (select Id from Echolock.dbo.CISOUserDeviceInfo
				(nolock)
				where UserAccount = @UserAccount and EventDate = @EventDate)
		begin
			insert into Echolock.dbo.CISOUserDeviceInfo (EventDate,UserAccount,UserDomain,ServiceTag,MachineMake,ProcessorId,KeyboardId,MouseId,
					HeadsetId,MonitorId,OSVersion,SystemType,RunAt)
				values (@EventDate, @UserAccount, @UserDomain, @ServiceTag, @MachineMake,@ProcessorId, @KeyBoardId, @MouseId,
					@HeadsetId, @MonitorId, @OSVersion, @SystemType, @RunAt)
		end
		else
		begin
			update EchoLock.dbo.CISOUserDeviceInfo
				set UserDomain = case when isnull(UserDomain, '')  <> isnull(@UserDomain, '') then @UserDomain else UserDomain end,
					ServiceTag = case when isnull(ServiceTag, '') <> isnull(@ServiceTag, '') then @ServiceTag else ServiceTag end,
					MachineMake = case when isnull(MachineMake, '') <> isnull(@MachineMake, '') then @MachineMake else MachineMake end,
					ProcessorId = case when isnull(ProcessorId, '') <> isnull(@ProcessorId, '') then @ProcessorId else ProcessorId end,
					KeyboardId = case when isnull(KeyboardId, '') <> isnull(@KeyboardId, '') then @KeyboardId else KeyboardId end,
					MouseId = case when isnull(MouseId, '') <> isnull(@MouseId, '') then @MouseId else MouseId end,
					HeadsetId = case when isnull(HeadsetId, '') <> isnull(@HeadsetId, '') then @HeadsetId else HeadsetId end,
					MonitorId = case when isnull(MonitorId, '') <> isnull(@MonitorId, '') then @MonitorId else MonitorId end,
					OSVersion = case when isnull(OSVersion, '') <> isnull(@OSVersion, '') then @OSVersion else OSVersion end,
					SystemType = case when isnull(SystemType, '') <> isnull(@SystemType, '') then @SystemType else SystemType end,
					RunAt = case when RunAt <> @RunAt then @RunAt else RunAt end,
					ComputerIP = case when isnull(ComputerIP,'') <> isnull(@ComputerIP,'') then @ComputerIP else ComputerIP end
				where UserAccount = @UserAccount and EventDate = @EventDate
		end

		declare @userInfoId bigint
		select @userInfoId = Id from Echolock.dbo.CISOUserDeviceInfo
				(nolock)
				where UserAccount = @UserAccount and EventDate = @EventDate

		if not exists (select Id from EchoLock.dbo.CISOUserDeviceStatus
				(nolock)
				where Id = @userInfoId and DeviceType = @DeviceType)
		begin
			insert into EchoLock.dbo.CISOUserDeviceStatus (Id,DeviceType,[Availability],AdapterId,InstalledOn,LastUpTime,IsConnected,RunAt)
				values (@userInfoId, @DeviceType, @Availability, @AdapterId, @InstalledOn, @LastUpTime, @IsConnected, @RunAt)
		end
		else
		begin
			update EchoLock.dbo.CISOUserDeviceStatus
				set [Availability] = case when [Availability] <> @Availability then @Availability else Availability end,
					AdapterId = case when isnull(AdapterId,'') <> isnull(@AdapterId,'') then @AdapterId else AdapterId end,
					InstalledOn = case when InstalledOn <> @InstalledOn then @InstalledOn else InstalledOn end,
					LastUpTime = case when LastUpTime <> @LastUpTime then @LastUpTime else LastUpTime end,
					IsConnected = case when IsConnected <> @IsConnected then @IsConnected else IsConnected end,
					RunAt = case when RunAt <> @RunAt then @RunAt else RunAt end
				where Id = @userInfoId and DeviceType = @DeviceType
		end

		commit
		
		select 'Success'

	end try
	begin catch
		rollback

		select 'Failure'
	end catch
    
END
GO
/****** Object:  StoredProcedure [dbo].[CISOUserDeviceInfoUpdateNew]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SaravanaKumar
-- Create date: 09/04/2020
-- Description:	CISO User Device Info New
-- =============================================

CREATE Procedure [dbo].[CISOUserDeviceInfoUpdateNew]
	@DeviceInfoXML xml,
	@DeviceStatusXML xml,
	@NetworkStatusXML xml
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
	IF OBJECT_ID('tempdb..#TmbTblDeviceInfo') IS NOT NULL DROP TABLE #TmbTblDeviceInfo
	IF OBJECT_ID('tempdb..#TmbTblDeviceStatus') IS NOT NULL DROP TABLE #TmbTblDeviceStatus
	IF OBJECT_ID('tempdb..#TmbTblNetworkSt') IS NOT NULL DROP TABLE #TmbTblNetworkSt
	IF OBJECT_ID('tempdb..#tempDuplicates') IS NOT NULL DROP TABLE #tempDuplicates

	DECLARE @DeviceInfoId bigint, @UserAccount varchar(100), @HostName varchar(100), @EventDate datetime
	DECLARE @intPointerDI INT, @errorcount int = 0

	begin try

		EXEC SP_XML_PREPAREDOCUMENT @intPointerDI OUTPUT, @DeviceInfoXML
		SELECT * INTO #TmbTblDeviceInfo        
		FROM OPENXML(@intPointerDI,'/UserDeviceInfoDTO',1)                          
		WITH 
		(
				UserAccount VARCHAR(MAX) 'UserAccount', EventDate VARCHAR(MAX) 'EventDate',
				HostName VARCHAR(MAX) 'HostName',UserDomain VARCHAR(MAX) 'UserDomain',ServiceTag VARCHAR(MAX) 'ServiceTag',
				MachineMake VARCHAR(MAX) 'MachineMake',OSVersion VARCHAR(MAX) 'OSVersion',
				SystemType VARCHAR(MAX) 'SystemType', RunAt VARCHAR(MAX) 'RunAt', MachineModel VARCHAR(MAX) 'MachineModel',
				TotalMemory VARCHAR(MAX) 'TotalMemory',ProcessorId VARCHAR(MAX) 'ProcessorId',
				ProcessorName VARCHAR(MAX) 'ProcessorName',ProcessorCount VARCHAR(MAX) 'ProcessorCount',
				ProcessorSpeed VARCHAR(MAX) 'ProcessorSpeed', BIOSSerialNumber VARCHAR(MAX) 'BIOSSerialNumber',
				BIOSName VARCHAR(MAX) 'BIOSName',BIOSVersion VARCHAR(MAX) 'BIOSVersion',BIOSMake VARCHAR(MAX) 'BIOSMake',
				UpTime VARCHAR(MAX) 'UpTime', VersionId VARCHAR(MAX) 'VersionId'
		)    
		EXEC SP_XML_REMOVEDOCUMENT @intPointerDI

		SELECT @UserAccount = UserAccount, @HostName = HostName, @EventDate = EventDate from #TmbTblDeviceInfo

		-------------------------------------------------------------

		DECLARE @intPointerUD INT

		EXEC SP_XML_PREPAREDOCUMENT @intPointerUD OUTPUT, @DeviceStatusXML

		SELECT * INTO #TmbTblDeviceStatus         
		FROM OPENXML(@intPointerUD,'/ArrayOfUserDeviceStatusDTO/UserDeviceStatusDTO',1)                          
		WITH 
		(      
				DeviceInfoId VARCHAR(MAX) 'DeviceInfoId',DeviceId VARCHAR(MAX) 'DeviceId',DeviceType VARCHAR(MAX) 'DeviceType',
				[Availability] VARCHAR(MAX) 'Availability',InstalledOn VARCHAR(MAX) 'InstalledOn', AdapterId VARCHAR(MAX) 'AdapterId',
				LastUpTime VARCHAR(MAX) 'LastUpTime',RunAt VARCHAR(MAX) 'RunAt', [Description] VARCHAR(MAX) 'Description'
		)
		EXEC SP_XML_REMOVEDOCUMENT @intPointerUD

		--select * from #TmbTblDeviceStatus

		-----------------------------------------------------------------------

		DECLARE @intPointerNS INT

		EXEC SP_XML_PREPAREDOCUMENT @intPointerNS OUTPUT, @NetworkStatusXML

		SELECT * INTO #TmbTblNetworkSt
		FROM OPENXML(@intPointerNS,'/ArrayOfUserNetworkStatusDTO/UserNetworkStatusDTO',1)                          
		WITH 
		(             
				DeviceInfoId VARCHAR(MAX) 'DeviceInfoId',NetworkId VARCHAR(MAX) 'NetworkId',NetworkInterface VARCHAR(MAX) 'NetworkInterface',
				NetworkName VARCHAR(MAX) 'NetworkName',ConnectionType VARCHAR(MAX) 'ConnectionType',ConnectionStatus VARCHAR(MAX) 'ConnectionStatus',
				IP4Address VARCHAR(MAX) 'IP4Address',IP6Address VARCHAR(MAX) 'IP6Address',Connectivity VARCHAR(MAX) 'Connectivity',
				DomainType VARCHAR(MAX) 'DomainType',IsConnected VARCHAR(MAX) 'IsConnected',IsConnectedToInternet VARCHAR(MAX) 'IsConnectedToInternet',
				CreatedTime VARCHAR(MAX) 'CreatedTime',ConnectedTime VARCHAR(MAX) 'ConnectedTime',NetworkDescription VARCHAR(MAX) 'NetworkDescription',
				ConnectionName VARCHAR(MAX) 'ConnectionName',IsActive VARCHAR(MAX) 'IsActive', MACAddress VARCHAR(MAX) 'MACAddress'
		)    
		EXEC SP_XML_REMOVEDOCUMENT @intPointerNS

		--select * from #TmbTblNetworkSt

		delete #TmbTblNetworkSt
			where DeviceInfoId = 0
				and NetworkId in (select NetworkId
					from #TmbTblNetworkSt
					where DeviceInfoId = 1)

		update #TmbTblNetworkSt
			set DeviceInfoId = 0

	end try
	begin catch
		set @errorcount = @errorcount + 1

		insert into CISOErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserName, HostName)
			values ('DB Error - xml table creation', ERROR_MESSAGE(), getdate(), @UserAccount, @HostName)
	end catch

	if not exists (select * from #TmbTblDeviceStatus)
	begin
		if not exists (select * from #TmbTblNetworkSt)
		begin
			set @errorcount = @errorcount + 1
		end
	end

	begin try
		begin tran

		merge CISOUserDeviceInfo t
		using #TmbTblDeviceInfo s
		on (t.UserAccount = s.UserAccount and t.EventDate = s.EventDate
			and t.HostName = s.HostName)
		when matched then
			update set t.UserDomain = isnull(s.UserDomain, t.UserDomain), t.ServiceTag = isnull(s.ServiceTag, t.ServiceTag),
				t.MachineMake = isnull(s.MachineMake, t.MachineMake), t.OSVersion = isnull(s.OSVersion, t.OSVersion),
				t.SystemType = isnull(s.SystemType, t.SystemType), t.RunAt = isnull(s.RunAt, t.RunAt), t.MachineModel = isnull(s.MachineModel, t.MachineModel),
				t.TotalMemory = isnull(s.TotalMemory, t.TotalMemory), t.ProcessorId = isnull(s.ProcessorId, t.ProcessorId),
				t.ProcessorName = isnull(s.ProcessorName, t.ProcessorName), t.ProcessorCount = case when s.ProcessorCount > 0 then s.ProcessorCount else t.ProcessorCount end,
				t.BIOSSerialNumber = isnull(s.BIOSSerialNumber, t.BIOSSerialNumber), t.BIOSName = isnull(s.BIOSName, t.BIOSName),
				t.BIOSVersion = isnull(s.BIOSVersion, t.BIOSVersion), t.BIOSMake = isnull(s.BIOSMake, t.BIOSMake),
				t.UpTime = isnull(s.UpTime, t.UpTime), VersionId = isnull(s.VersionId, t.VersionId)
		when not matched by target then
			insert (UserAccount, HostName, EventDate, UserDomain, ServiceTag, MachineMake, OSVersion, SystemType, RunAt,
				MachineModel, TotalMemory, ProcessorId, ProcessorName, ProcessorCount, BIOSSerialNumber, BIOSName,
				BIOSVersion, BIOSMake, UpTime, VersionId)
			values (s.UserAccount, s.HostName, s.EventDate, s.UserDomain, s.ServiceTag, s.MachineMake, s.OSVersion,
				s.SystemType, s.RunAt, s.MachineModel, s.TotalMemory, s.ProcessorId, s.ProcessorName, s.ProcessorCount,
				s.BIOSSerialNumber, s.BIOSName, s.BIOSVersion, s.BIOSMake, s.UpTime, s.VersionId)
		;

		commit
	end try
	begin catch
		rollback

		set @errorcount = @errorcount + 1
		--select @errorcount, ERROR_MESSAGE() ErrorMessage
		insert into CISOErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserName, HostName)
			values ('DB Error - Device Info Merge', ERROR_MESSAGE(), getdate(), @UserAccount, @HostName)
	end catch

	select @DeviceInfoId = Id
		from CISOUserDeviceInfo
		(nolock)
		where UserAccount = @UserAccount and HostName = @HostName
			and EventDate = @EventDate

	--select @DeviceInfoId

	update #TmbTblDeviceStatus
		set DeviceInfoId = @DeviceInfoId

	update #TmbTblNetworkSt
		set DeviceInfoId = @DeviceInfoId

	--select NetworkId, count(*) Duplicate
	--		into #tempDuplicates
	--		from #TmbTblNetworkSt
	--		group by NetworkId

	--delete top (1)
	----select top 1 *
	--		from #TmbTblNetworkSt
	--		where NetworkId in (select NetworkId
	--				from #tempDuplicates
	--				where Duplicate > 1)
			--order by ConnectionStatus asc

	begin try
		begin tran
			
		merge CISOUserDeviceStatus t
		using #TmbTblDeviceStatus s
		on (t.Id = s.DeviceInfoId and t.DeviceId = s.DeviceId)
		when matched then
			update
				set t.DeviceType = s.DeviceType, t.[Availability] = s.[Availability], t.AdapterId = s.AdapterId,
					t.InstalledOn = s.InstalledOn, t.LastUpTime = s.LastUpTime, t.RunAt = s.RunAt,
					t.Description = s.Description
		when not matched by target then
			insert (Id, DeviceId, DeviceType, [Availability], AdapterId, InstalledOn, LastUpTime, RunAt, Description)
			values (s.DeviceInfoId, s.DeviceId, s.DeviceType, s.[Availability], AdapterId, InstalledOn, LastUpTime, RunAt, Description)
		;

		commit
	end try
	begin catch
		rollback

		set @errorcount = @errorcount + 1
		--select @errorcount, ERROR_MESSAGE() ErrorMessage
		insert into CISOErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserName, HostName)
			values ('DB Error - Device Status Merge', ERROR_MESSAGE(), getdate(), @UserAccount, @HostName)
	end catch

	begin try
		begin tran

		merge CISOUserNetworkStatus t
		using #TmbTblNetworkSt s
		on (t.Id = s.DeviceInfoId and t.NetworkId = s.NetworkId)
		when matched then
			update
				set t.NetworkInterface = s.NetworkInterface,
					t.NetworkName = s.NetworkName, t.ConnectionStatus = s.ConnectionStatus,
					t.IP4Address = s.IP4Address, t.Connectivity = s.Connectivity, t.DomainType = s.DomainType,
					t.IsConnected = s.IsConnected, t.IsConnectedToInternet = s.IsConnectedToInternet,
					t.CreatedTime = s.CreatedTime, t.ConnectedTime = s.ConnectedTime, t.NetworkDescription = s.NetworkDescription,
					t.ConnectionName = s.ConnectionName, t.MACAddress = s.MACAddress
		when not matched by target then
			insert (Id, NetworkId, NetworkInterface, NetworkName, ConnectionStatus, IP4Address, Connectivity, DomainType, IsConnected,
					IsConnectedToInternet, CreatedTime, ConnectedTime, NetworkDescription, ConnectionName, MACAddress)
			values (s.DeviceInfoId, s.NetworkId, s.NetworkInterface, s.NetworkName, s.ConnectionStatus, s.IP4Address, s.Connectivity, s.DomainType, s.IsConnected,
					s.IsConnectedToInternet, s.CreatedTime, s.ConnectedTime, s.NetworkDescription, s.ConnectionName, s.MACAddress)
		;

		commit
	end try
	begin catch
		rollback

		set @errorcount = @errorcount + 1
		--select @errorcount, ERROR_MESSAGE() ErrorMessage
		insert into CISOErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserName, HostName)
			values ('DB Error - Network Status Merge', ERROR_MESSAGE(), getdate(), @UserAccount, @HostName)
	end catch

	if (@errorcount = 0)
	begin
		begin try
		begin tran
			update CISOUserDeviceInfo
				set IsActive = 1
				where UserAccount = @UserAccount and HostName = @HostName and EventDate = @EventDate

			update CISOUserDeviceStatus
				set IsActive = 1
				where Id = @DeviceInfoId

			update CISOUserNetworkStatus
				set IsActive = 1
				where Id = @DeviceInfoId

			commit

			select 'Success' Success
		end try
		begin catch
			rollback

			--select @errorcount, ERROR_MESSAGE() ErrorMessage
			insert into CISOErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserName, HostName)
				values ('DB Error - IsActive Update', ERROR_MESSAGE(), getdate(), @UserAccount, @HostName)
		end catch
	end

	IF OBJECT_ID('tempdb..#TmbTblDeviceInfo') IS NOT NULL DROP TABLE #TmbTblDeviceInfo
	IF OBJECT_ID('tempdb..#TmbTblDeviceStatus') IS NOT NULL DROP TABLE #TmbTblDeviceStatus
	IF OBJECT_ID('tempdb..#TmbTblNetworkSt') IS NOT NULL DROP TABLE #TmbTblNetworkSt
	IF OBJECT_ID('tempdb..#tempDuplicates') IS NOT NULL DROP TABLE #tempDuplicates
END
GO
/****** Object:  StoredProcedure [dbo].[CISOUserNetworkInfoUpdate]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Promodh Kumar
-- Create date: 07/04/2020
-- Description:	CISO User Network Info
-- =============================================
CREATE PROCEDURE [dbo].[CISOUserNetworkInfoUpdate]
	@UserAccount varchar(100),
	@EventDate	datetime,
	@UserDomain	varchar(100),
	@ServiceTag varchar(300),
	@MachineMake varchar(300),
	@ProcessorId varchar(300),
	@KeyBoardId varchar(300),
	@MouseId varchar(300),
	@HeadsetId varchar(300),
	@MonitorId varchar(300),
	@OSVersion varchar(300),
	@SystemType varchar(300),
	@ComputerIP varchar(100),
	@RunAt datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	begin try

		begin tran

		if not exists (select Id from Echolock.dbo.CISOUserDeviceInfo
				(nolock)
				where UserAccount = @UserAccount and EventDate = @EventDate)
		begin
			insert into Echolock.dbo.CISOUserDeviceInfo (EventDate,UserAccount,UserDomain,ServiceTag,MachineMake,ProcessorId,KeyboardId,MouseId,
					HeadsetId,MonitorId,OSVersion,SystemType,RunAt)
				values (@EventDate, @UserAccount, @UserDomain, @ServiceTag, @MachineMake,@ProcessorId, @KeyBoardId, @MouseId,
					@HeadsetId, @MonitorId, @OSVersion, @SystemType, @RunAt)
		end
		else
		begin
			update EchoLock.dbo.CISOUserDeviceInfo
				set UserDomain = case when isnull(UserDomain, '')  <> isnull(@UserDomain, '') then @UserDomain else UserDomain end,
					ServiceTag = case when isnull(ServiceTag, '') <> isnull(@ServiceTag, '') then @ServiceTag else ServiceTag end,
					MachineMake = case when isnull(MachineMake, '') <> isnull(@MachineMake, '') then @MachineMake else MachineMake end,
					ProcessorId = case when isnull(ProcessorId, '') <> isnull(@ProcessorId, '') then @ProcessorId else ProcessorId end,
					KeyboardId = case when isnull(KeyboardId, '') <> isnull(@KeyboardId, '') then @KeyboardId else KeyboardId end,
					MouseId = case when isnull(MouseId, '') <> isnull(@MouseId, '') then @MouseId else MouseId end,
					HeadsetId = case when isnull(HeadsetId, '') <> isnull(@HeadsetId, '') then @HeadsetId else HeadsetId end,
					MonitorId = case when isnull(MonitorId, '') <> isnull(@MonitorId, '') then @MonitorId else MonitorId end,
					OSVersion = case when isnull(OSVersion, '') <> isnull(@OSVersion, '') then @OSVersion else OSVersion end,
					SystemType = case when isnull(SystemType, '') <> isnull(@SystemType, '') then @SystemType else SystemType end,
					RunAt = case when RunAt <> @RunAt then @RunAt else RunAt end,
					ComputerIP = case when isnull(ComputerIP,'') <> isnull(@ComputerIP,'') then @ComputerIP else ComputerIP end
				where UserAccount = @UserAccount and EventDate = @EventDate
		end

		declare @userInfoId bigint
		select @userInfoId = Id from Echolock.dbo.CISOUserDeviceInfo
				(nolock)
				where UserAccount = @UserAccount and EventDate = @EventDate

		commit
		
		select 'Success'

	end try
	begin catch
		rollback

		select 'Failure'
	end catch
    
END
GO
/****** Object:  StoredProcedure [dbo].[CSVKryptoConnect]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CSVKryptoConnect]
    @Krypto KruptoconnectType READONLY,
	@Apayaa ApayaaType Readonly,
	@Tata TataType Readonly,
	@Type varchar(50) null
	
AS
BEGIN
	IF(@Type = 'Kruptoconnect') 
		BEGIN

		 --IF NOT EXISTS (SELECT * FROM vendorCallRecords WHERE Call_Id IN (SELECT  UUID FROM @Krypto))
			--BEGIN
			   INSERT INTO vendorCallRecords (Call_Id, CallinitiatedTime, CallEndTime, Vendor, Comments, CreatedDate)
		    		SELECT DISTINCT UUID, [CALL START TIME], [CALL END TIME], @Type, 'Missing Record',GETDATE()
					FROM   @Krypto a
					LEFT OUTER JOIN [dbo].[arc_ar_callrecoding] b
					  ON (a.UUID = b.Uniqueid)
					  WHERE b.Uniqueid IS  NULL
			   INSERT INTO vendorCallRecords (Call_Id, CallinitiatedTime, CallEndTime, Vendor, Comments, CreatedDate)
					SELECT DISTINCT UUID, [CALL START TIME], [CALL END TIME], @Type, 'Duplicate Record',GETDATE() FROM @Krypto a
					WHERE  EXISTS
					(
						 SELECT b.Uniqueid,count(*) as count FROM [dbo].[arc_ar_callrecoding] b WHERE b.Uniqueid = a.UUID  GROUP BY b.Uniqueid HAVING count(*) > 1
					)
			--END
		END
	ELSE IF (@Type = 'Apayaa')
		BEGIN
		 --IF NOT EXISTS (SELECT * FROM vendorCallRecords WHERE Call_Id IN (SELECT  [Unique Id] FROM @Apayaa))
			--BEGIN
			   INSERT INTO vendorCallRecords (Call_Id, CallinitiatedTime, CallEndTime, Vendor, Comments, CreatedDate)
		    		SELECT DISTINCT [Unique Id], [CALL START TIME], [CALL END TIME], @Type, 'Missing Record',GETDATE()
					FROM   @Apayaa a
					LEFT OUTER JOIN [dbo].[arc_ar_callrecoding] b
					  ON (a.[Unique Id] = b.Uniqueid)
					  WHERE b.Uniqueid IS  NULL
			   INSERT INTO vendorCallRecords (Call_Id, CallinitiatedTime, CallEndTime, Vendor, Comments, CreatedDate)
					SELECT DISTINCT [Unique Id], [CALL START TIME], [CALL END TIME], @Type, 'Duplicate Record',GETDATE() FROM @Apayaa a
					WHERE  EXISTS
					(
						 SELECT b.Uniqueid,count(*) as count FROM [dbo].[arc_ar_callrecoding] b WHERE b.Uniqueid = a.[Unique Id]  GROUP BY b.Uniqueid HAVING count(*) > 1
					)
		 --END

		
		END
	ELSE IF (@Type = 'TATA')
		BEGIN
		--insert into Tata (Call_ID) select Call_ID  from @Tata
		-- IF NOT EXISTS (SELECT * FROM vendorCallRecords WHERE Call_Id IN (SELECT  [Call_ID] FROM @Tata))
		--	BEGIN	
			 
				
			   INSERT INTO vendorCallRecords (Call_Id, CallinitiatedTime, CallEndTime, Vendor, Comments, CreatedDate)
		    		SELECT DISTINCT [Call_ID], [ArrivalTime], TalkTime, @Type, 'Missing Record',GETDATE()
					FROM   @Tata a
					LEFT OUTER JOIN [dbo].[arc_ar_callrecoding] b
					  ON (a.[Call_ID] = b.Uniqueid)
					  WHERE b.Uniqueid IS  NULL
			   INSERT INTO vendorCallRecords (Call_Id, CallinitiatedTime, Vendor, Comments, CreatedDate)
					SELECT DISTINCT [Call_ID], [ArrivalTime], @Type, 'Duplicate Record',GETDATE() FROM @Tata a
					WHERE  EXISTS
					(
						 SELECT b.Uniqueid,count(*) as count FROM [dbo].[arc_ar_callrecoding] b WHERE 
						 b.Uniqueid = a.[Call_ID]  GROUP BY b.Uniqueid HAVING count(*) > 1
					)
			 --END
		
		END	
	
END
GO
/****** Object:  StoredProcedure [dbo].[Device_Info]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Device_Info] (@callType int) 
AS  
BEGIN

DECLARE @Parm INT = @callType;

IF OBJECT_ID('tempdb..#TmpTblDeviceInfo') IS NOT NULL DROP TABLE #TmpTblDeviceInfo
IF OBJECT_ID('tempdb..#TmpTblNetworkInfo') IS NOT NULL DROP TABLE #TmpTblNetworkInfo
IF OBJECT_ID('tempdb..#TmpTblCType') IS NOT NULL DROP TABLE #TmpTblCType
IF OBJECT_ID('tempdb..#TmpTblNW') IS NOT NULL DROP TABLE #TmpTblNW

DECLARE @sTime DATETIME = GETDATE()-30
CREATE TABLE #TmpTblCType(UserId int, NName VARCHAR(MAX))
DECLARE @ID INT

SELECT 
Id,DI.UserAccount,HostName,UserDomain,SystemType,/*ServiceTag,*/ DI.BIOSSerialNumber, CONVERT(VARCHAR(150),NULL) ConnectionType,
MachineMake,MachineModel,OSVersion,NULLIF(CAST((CONVERT(bigint,TotalMemory) / 1073741824) AS VARCHAR),0) MemoryGB
,ProcessorId,ProcessorName,ProcessorCount,BIOSName,BIOSVersion,BIOSMake,UpTime SystemUpTime,DI.RunAt ScanAt
INTO #TmpTblDeviceInfo
FROM CISOUserDeviceInfo(NOLOCK)DI
INNER JOIN
       (SELECT BIOSSerialNumber,MAX(RunAt) RunAt
       FROM CISOUserDeviceInfo(NOLOCK)
       WHERE RunAt >= @sTime AND VersionId = '2020.04.28.001'
       GROUP BY BIOSSerialNumber) MX
ON DI.BIOSSerialNumber = MX.BIOSSerialNumber AND DI.RunAt = MX.RunAt

SELECT RN = ROW_NUMBER() OVER (PARTITION BY BIOSSerialNumber,HostName ORDER BY ScanAt DESC),
NS.id UserId,NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IP4Address AS IPAddress,Connectivity,
DomainType,IsConnected,IsConnectedToInternet,CreatedTime,ConnectedTime,NetworkDescription,ConnectionName
INTO #TmpTblNetworkInfo
FROM #TmpTblDeviceInfo tmp
INNER JOIN CISOUserNetworkStatus(NOLOCK)NS
ON tmp.Id = ns.Id
WHERE NS.ConnectionStatus = 'UP' AND NS.CreatedTime IS NOT NULL
/*Down Data*/
INSERT INTO #TmpTblNetworkInfo(RN,UserId, NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress, Connectivity, DomainType, 
IsConnected, IsConnectedToInternet, CreatedTime, ConnectedTime, NetworkDescription, ConnectionName)
SELECT RN = ROW_NUMBER() OVER (PARTITION BY BIOSSerialNumber,HostName ORDER BY ScanAt DESC),
NS.Id AS UserId,NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IP4Address,Connectivity,DomainType,IsConnected,IsConnectedToInternet,
CreatedTime,ConnectedTime as LastConnectedTime,NetworkDescription,ConnectionName
FROM CISOUserNetworkStatus(NOLOCK)NS
INNER JOIN 
       (SELECT Id,BIOSSerialNumber,HostName,ScanAt FROM #TmpTblDeviceInfo a
       LEFT JOIN #TmpTblNetworkInfo b
       ON a.Id = b.UserId
       WHERE b.UserId IS NULL)tmp
ON ns.Id = tmp.Id 

/*Get the Connection Type*/
DECLARE ntCursor CURSOR  
READ_ONLY  FOR 
SELECT DISTINCT UserId FROM #TmpTblNetworkInfo

OPEN ntCursor
       FETCH NEXT FROM ntCursor INTO  @ID
       WHILE @@FETCH_STATUS = 0  
              BEGIN  
              INSERT INTO #TmpTblCType(UserId,NName)
                     SELECT @ID, SUBSTRING( 
                     ( 
                            SELECT '|' + NetworkInterface +'|' +NetworkName AS 'data()'
                                  FROM #TmpTblNetworkInfo 
                                   WHERE UserId = @ID
                                  FOR XML PATH('') 
                     ), 2 , 9999)
                     FETCH NEXT FROM ntCursor INTO @ID
              END  
CLOSE ntCursor  
DEALLOCATE ntCursor 

UPDATE DI SET DI.ConnectionType = CT.ConnectionType
FROM (
       SELECT UserId,
       CASE WHEN NNAME LIKE '%Ethernet|Remote NDIS%' THEN 'Dongle'
       ELSE 
       CASE WHEN NNAME LIKE '%Ethernet|Realtek %' THEN 'LAN'
       ELSE
       CASE WHEN NNAME LIKE '%Ethernet|Intel(R) Ethernet%' THEN 'LAN'
       ELSE       
       CASE WHEN NNAME LIKE '%Wireless%|% Wireless%' THEN 'WI-FI'  
       ELSE NULL END END END END AS ConnectionType
       FROM #TmpTblCType)CT
INNER JOIN #TmpTblDeviceInfo DI
ON DI.ID = CT.UserId

IF @Parm = 0
BEGIN
IF OBJECT_ID('tempdb..#TmpTblDeviceInfo01') IS NOT NULL DROP TABLE #TmpTblDeviceInfo01

       --SELECT * FROM #TmpTblDeviceInfo
       --SELECT * FROM #TmpTblNetworkInfo


SELECT TOP 1250 Id, UserAccount, HostName, UserDomain, SystemType, BIOSSerialNumber, ConnectionType, MachineMake, MachineModel, 
OSVersion, MemoryGB as TotalMemory, ProcessorId, ProcessorName, ProcessorCount, BIOSName, 
BIOSVersion, BIOSMake, CONVERT(varchar(30), ScanAt, 121) as ScanAt, CONVERT(varchar(30), SystemUpTime, 121) as UpTime 
into #TmpTblDeviceInfo01
FROM #TmpTblDeviceInfo order by Id asc

select * from #TmpTblDeviceInfo01

--SELECT UserId, NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress, Connectivity, DomainType, 
--IsConnected, IsConnectedToInternet, CONVERT(varchar(30), CreatedTime, 121) as CreatedTime, 
--CONVERT(varchar(30), ConnectedTime, 121) as LastConnectedTime, NetworkDescription, ConnectionName 
--from #TmpTblNetworkInfo order by UserId asc

SELECT UserId, NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress, Connectivity, DomainType, 
IsConnected, IsConnectedToInternet, CONVERT(varchar(30), CreatedTime, 121) as CreatedTime, 
CONVERT(varchar(30), ConnectedTime, 121) as LastConnectedTime, NetworkDescription, ConnectionName 
from #TmpTblNetworkInfo a
inner join #TmpTblDeviceInfo01 b
on a.UserId = b.Id
order by UserId asc

IF OBJECT_ID('tempdb..#TmpTblDeviceInfo01') IS NOT NULL DROP TABLE #TmpTblDeviceInfo01
END
IF @Parm = 1
BEGIN
       CREATE TABLE #TmpTblNW (ID INT,
       NetworkInterface VARCHAR(MAX),NetworkName VARCHAR(MAX),ConnectionStatus VARCHAR(MAX),MACAddress VARCHAR(MAX),IPAddress VARCHAR(MAX),
       Connectivity VARCHAR(MAX),DomainType VARCHAR(MAX),IsConnected VARCHAR(50),IsConnectedToInternet VARCHAR(MAX),CreatedTime VARCHAR(MAX),
       ConnectedTime VARCHAR(MAX),NetworkDescription VARCHAR(MAX),ConnectionName VARCHAR(MAX))

       DECLARE @ID1 INT
       DECLARE NWCursor CURSOR  
       READ_ONLY  FOR 
       SELECT DISTINCT UserId FROM #TmpTblNetworkInfo

       OPEN NWCursor
              FETCH NEXT FROM NWCursor INTO  @ID1
              WHILE @@FETCH_STATUS = 0  
                     BEGIN  
                     INSERT INTO #TmpTblNW(ID,NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IPAddress,Connectivity,
                     DomainType,IsConnected,IsConnectedToInternet,CreatedTime,ConnectedTime,NetworkDescription,ConnectionName)              
                           SELECT @ID1, 
                                  SUBSTRING( '[' +( SELECT QUOTENAME(ISNULL(NetworkInterface,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(NetworkName,'-'))  /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(ConnectionStatus,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(MACAddress,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(IPAddress,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(Connectivity,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(DomainType,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME((CASE WHEN IsConnected = 1 THEN 'True' ELSE 'False' END)) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME((CASE WHEN IsConnectedToInternet = 1 THEN 'True' ELSE 'False' END)) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(CONVERT(VARCHAR(30),CreatedTime,121),'-')) /*+ CHAR(9)*/
                                FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(CONVERT(VARCHAR(30),ConnectedTime,121),'-') ) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(NetworkDescription,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(ConnectionName,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                           FETCH NEXT FROM NWCursor INTO @ID1
                     END  
       CLOSE NWCursor  
       DEALLOCATE NWCursor 

       SELECT TOP 1250 UserAccount, HostName, UserDomain, SystemType, BIOSSerialNumber, ConnectionType, MachineMake, MachineModel, OSVersion, 
	   MemoryGB, ProcessorId, ProcessorName, ProcessorCount, BIOSName,BIOSVersion, BIOSMake,
	   CONVERT(varchar(30), SystemUpTime, 121) as UpTime,NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress, 
	   Connectivity, DomainType, IsConnected, IsConnectedToInternet, CONVERT(varchar(100), CreatedTime, 121) as CreatedTime, 
	   CONVERT(varchar(100), ConnectedTime, 121) as LastConnectedTime, NetworkDescription, ConnectionName,
	   CONVERT(varchar(30), ScanAt, 121) as ScanAt ,UD.Location,UD.Client  
		FROM #TmpTblDeviceInfo a
       LEFT JOIN #TmpTblNW  b
       ON a.Id = b.ID
	   LEFT JOIN EchoLock.dbo.UserDetails(NOLOCK)ud
	   ON A.UserAccount = UD.NTLoginName
END
IF OBJECT_ID('tempdb..#TmpTblDeviceInfo') IS NOT NULL DROP TABLE #TmpTblDeviceInfo
IF OBJECT_ID('tempdb..#TmpTblNetworkInfo') IS NOT NULL DROP TABLE #TmpTblNetworkInfo
IF OBJECT_ID('tempdb..#TmpTblCType') IS NOT NULL DROP TABLE #TmpTblCType
IF OBJECT_ID('tempdb..#TmpTblNW') IS NOT NULL DROP TABLE #TmpTblNW

END
GO
/****** Object:  StoredProcedure [dbo].[Echolock_India_BreakSplitupMail]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[Echolock_India_BreakSplitupMail]   
AS  
Begin  

Declare @sDate DATE = Echolock.dbo.ConvertUTCtoIST(GETUTCDATE()-1) 
Declare @eDate DATE = @sDate

DECLARE @StartDate AS DATETIME                                
DECLARE @EndDate AS DATETIME
SET @StartDate =  DATEADD(DAY, DATEDIFF(DAY, 0, @sDate), '02:30:00')
SET @EndDate =  DATEADD(DAY, DATEDIFF(DAY, -1, @eDate), '02:30:00')

IF OBJECT_ID('tempdb..##TempTbluserLog') IS NOT NULL DROP TABLE ##TempTbluserLog          
IF OBJECT_ID('tempdb..#TempTbluserLogs') IS NOT NULL DROP TABLE #TempTbluserLogs  
IF OBJECT_ID('tempdb..#TempTbluserLogs001') IS NOT NULL DROP TABLE #TempTbluserLogs001  
IF OBJECT_ID('tempdb..##TemptablePVT_001') IS NOT NULL DROP TABLE ##TemptablePVT_001  
IF OBJECT_ID('tempdb..#TempTblMergeData') IS NOT NULL DROP TABLE #TempTblMergeData
IF OBJECT_ID('tempdb..#TempTbluserLog1') IS NOT NULL DROP TABLE #TempTbluserLog1 
IF OBJECT_ID('tempdb..#TempTbluserLog2') IS NOT NULL DROP TABLE #TempTbluserLog2
IF OBJECT_ID('tempdb..#TempTbluserLog3') IS NOT NULL DROP TABLE #TempTbluserLog3
IF OBJECT_ID('tempdb..#TempTbluserLog4') IS NOT NULL DROP TABLE #TempTbluserLog4
IF OBJECT_ID('tempdb..#TempTbluserLog5') IS NOT NULL DROP TABLE #TempTbluserLog5
IF OBJECT_ID('tempdb..#TempTbluserLog005') IS NOT NULL DROP TABLE #TempTbluserLog005
IF OBJECT_ID('tempdb..##Temptable_001') IS NOT NULL DROP TABLE ##Temptable_001
IF OBJECT_ID('tempdb..#TempTbluserLog06') IS NOT NULL DROP TABLE #TempTbluserLog06

;WITH CTE        
AS        
(        
SELECT DISTINCT EventTypeId,
DATEADD(MI, 330, EventTime)EventTime,UserAccount,ComputerName,ReasonID 
FROM Echolock.dbo.LockEvents(NOLOCK)LE
INNER JOIN Echolock.dbo.UserDetails(NOLOCK)UD
ON LE.UserId = UD.UserId   
WHERE EventTime BETWEEN @StartDate AND @EndDate AND EventStatus = 1 
AND EventTypeId IN (0,1,2,3,5,6) AND UD.Band IN (1,2) AND UD.[Status] = 4
AND UD.Team NOT IN ('Shared Services – Application Development','Shared Services - Infrastructure Solutions')
AND (UD.[Location] != 'Manila' AND UD.[Location] IS NOT NULL)
)         
SELECT ER.EventName,BR.BreakReason,LE.EventTime,LE.UserAccount,LE.ComputerName         
INTO ##TempTbluserLog 
FROM Echolock.dbo.LookupEventType(NOLOCK)ER                          
INNER JOIN CTE AS LE ON ER.EventTypeId = LE.EventTypeId
INNER JOIN Echolock.dbo.LookupBreakReason(NOLOCK)BR
ON BR.Id=LE.ReasonID ORDER BY EventTime 
                                 
SELECT ROW_NUMBER() OVER(PARTITION BY UserAccount ORDER BY UserAccount,EventTime) RwNo,* 
INTO #TempTbluserLog1   
FROM ##TempTbluserLog ORDER BY UserAccount,EventTime
                               
;WITH CTE1                                
AS                                
(                                
 SELECT ROW_NUMBER() OVER(PARTITION BY UserAccount ORDER BY UserAccount,EventTime) RwNo,
 UserAccount,EventTime,EventName,BreakReason,ComputerName                                
 FROM #TempTbluserLog1 WHERE RwNo != 1                                 
)                                
SELECT T1.RwNo,T1.ComputerName,T1.UserAccount,T1.EventName FromEvent,T1.EventTime 
FromTime,LE1.EventName ToEvent,LE1.EventTime ToTime,LE1.BreakReason                                 
INTO #TempTbluserLog2 
FROM #TempTbluserLog1 AS T1                                
INNER JOIN CTE1 AS LE1 ON T1.UserAccount = LE1.UserAccount AND T1.RwNo = LE1.RwNo   
                              
SELECT RwNo,ComputerName,UserAccount,FromEvent,FromTime,ToEvent,ToTime,BreakReason,                              
CASE WHEN CONVERT(TIME,FromTime) BETWEEN '00:00:00:00' and '08:00:00:00' 
THEN DATEADD(DAY,-1,CONVERT(DATE,FromTime))  ELSE CONVERT(DATE,FromTime) END EventDate                              
INTO #TempTbluserLog3 FROM #TempTbluserLog2
                          
SELECT EventDate,ComputerName,UserAccount,FromEvent,FromTime,ToEvent,ToTime,BreakReason,
TimeSpend = CONVERT(TIME,(CONVERT(DATETIME,ToTime) - CONVERT(datetime,FromTime)))
INTO #TempTbluserLog4 FROM #TempTbluserLog3 
WHERE ToTime != '' AND (fromevent<>'Logoff' AND toevent <> 'Logon')   
                                
SELECT UserAccount,EventDate,BreakReason, 
TimeSpend = LEFT(CONVERT(TIME,CAST(SUM(DATEDIFF(SECOND,0,TimeSpend))/3600 AS VARCHAR(12)) 
	+ ':' + RIGHT('0' + CAST(SUM(DATEDIFF(SECOND,0,TimeSpend))/60%60 AS VARCHAR(2)),2) 
	+ ':' + right('0' + CAST(SUM(DATEDIFF(SECOND,0,TimeSpend))%60 AS VARCHAR(2)),2)),8)                         
INTO #TempTbluserLog5 FROM #TempTbluserLog4 
WHERE TimeSpend  < '09:00:00' GROUP BY BreakReason,EventDate ,UserAccount
              
SELECT UserAccount,EventDate , 
SUM(LEFT(TimeSpend,2) * 3600 + DATEDIFF(ss,0,'00' + right(left(TimeSpend,8),6))) TotalHrs         
INTO #TempTbluserLog005 FROM  #TempTbluserLog5 GROUP BY UserAccount,EventDate
        
DECLARE @TmpGlobalTable VARCHAR(MAX) = 'Temptable_' + CONVERT(VARCHAR(MAX),'001')        
DECLARE @DynamicPivotQuery AS NVARCHAR(MAX),        
        @PivotColumnNames AS NVARCHAR(MAX),        
        @PivotSelectColumnNames AS NVARCHAR(MAX)        
SELECT @PivotColumnNames= ISNULL(@PivotColumnNames + ',','')        
+ QUOTENAME(BreakReason)        
FROM (SELECT DISTINCT BreakReason FROM Echolock.dbo.LookupBreakReason(NOLOCK) WHERE IsActive = 1) AS BreakReason        
SELECT @PivotSelectColumnNames         
    = ISNULL(@PivotSelectColumnNames + ',','')        
    + 'ISNULL(' + QUOTENAME(BreakReason) + ', CONVERT(VARCHAR(10),''00:00:00'')) AS '            
    + QUOTENAME(BreakReason)        
FROM (SELECT DISTINCT BreakReason FROM Echolock.dbo.LookupBreakReason(NOLOCK) WHERE IsActive=1) AS BreakReason        
SET @DynamicPivotQuery =        
N'SELECT convert(varchar(30),EventDate)EventDate,UserAccount, ' + @PivotSelectColumnNames + '        
INTO [##' + @TmpGlobalTable + ']  FROM #TempTbluserLog5        
PIVOT(MAX(TimeSpend)        
FOR BreakReason IN (' + @PivotColumnNames + ')) AS PVTTable'        
EXEC sp_executesql @DynamicPivotQuery
                     
SELECT a.* ,CONVERT(varchar, DATEADD(ss, b.TotalHrs , 0), 108)TotalHrs  
INTO #TempTbluserLog06  FROM ##Temptable_001 a        
LEFT JOIN #TempTbluserLog005 b on a.UserAccount=b.UserAccount and a.EventDate = b.EventDate  

TRUNCATE TABLE Mail_IndiaBreakSplitup

INSERT INTO Mail_IndiaBreakSplitup([EventDate],[LOB],[Client],[Location],[Process],[Supervisor],[Grade],[UserAccount],[Break],[Discussion],  
[Fire Drill],[Fun Event],[Health Issue],[Lunch Break],[Meeting],[NoReason Update],[One on One],[Production],[QA Feedback],  
[System Downtime],[Training],[TotalHrs],[IT Issue - Internal/Client],[HR Activity])  
SELECT a.EventDate,b.LOB,b.Client,b.[Location],b.Team Process,b.ManagerL1 Supervisor,b.Grade,  
a.UserAccount,[Break],Discussion,[Fire Drill],[Fun Event],[Health Issue],[Lunch Break],Meeting,[NoReason Update],[One on One],  
Production,[QA Feedback],[System Downtime],Training,TotalHrs,[IT Issue - Internal/Client],[HR Activity]  
FROM #TempTbluserLog06 a  
INNER JOIN Echolock.dbo.UserDetails(NOLOCK)b ON a.UserAccount = b.NTLoginName

IF OBJECT_ID('tempdb..##TempTbluserLog') IS NOT NULL DROP TABLE ##TempTbluserLog          
IF OBJECT_ID('tempdb..#TempTbluserLogs') IS NOT NULL DROP TABLE #TempTbluserLogs  
IF OBJECT_ID('tempdb..#TempTbluserLogs001') IS NOT NULL DROP TABLE #TempTbluserLogs001  
IF OBJECT_ID('tempdb..##TemptablePVT_001') IS NOT NULL DROP TABLE ##TemptablePVT_001  
IF OBJECT_ID('tempdb..#TempTblMergeData') IS NOT NULL DROP TABLE #TempTblMergeData
IF OBJECT_ID('tempdb..#TempTbluserLog1') IS NOT NULL DROP TABLE #TempTbluserLog1 
IF OBJECT_ID('tempdb..#TempTbluserLog2') IS NOT NULL DROP TABLE #TempTbluserLog2
IF OBJECT_ID('tempdb..#TempTbluserLog3') IS NOT NULL DROP TABLE #TempTbluserLog3
IF OBJECT_ID('tempdb..#TempTbluserLog4') IS NOT NULL DROP TABLE #TempTbluserLog4
IF OBJECT_ID('tempdb..#TempTbluserLog5') IS NOT NULL DROP TABLE #TempTbluserLog5
IF OBJECT_ID('tempdb..#TempTbluserLog005') IS NOT NULL DROP TABLE #TempTbluserLog005
IF OBJECT_ID('tempdb..##Temptable_001') IS NOT NULL DROP TABLE ##Temptable_001
IF OBJECT_ID('tempdb..#TempTbluserLog06') IS NOT NULL DROP TABLE #TempTbluserLog06

END
GO
/****** Object:  StoredProcedure [dbo].[Echolock_Manila_BreakSplitupMail]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Echolock_Manila_BreakSplitupMail]   
AS  
Begin  

Declare @sDate DATE = Echolock.dbo.ConvertUTCtoPST (GETUTCDATE()-1) 
Declare @eDate DATE = @sDate

DECLARE @StartDate AS DATETIME                                
DECLARE @EndDate AS DATETIME
/*SET @StartDate =  DATEADD(DAY, DATEDIFF(DAY, 0, @sDate), '02:30:00')
SET @EndDate =  DATEADD(DAY, DATEDIFF(DAY, -1, @eDate), '02:30:00')*/
SET @StartDate = DATEADD(DAY, DATEDIFF(DAY, 0, @sDate),'00:00:00')                       
SET @EndDate = DATEADD(DAY, DATEDIFF(DAY, -1, @eDate),'00:00:00')  

IF OBJECT_ID('tempdb..##TempTbluserLog') IS NOT NULL DROP TABLE ##TempTbluserLog          
IF OBJECT_ID('tempdb..#TempTbluserLogs') IS NOT NULL DROP TABLE #TempTbluserLogs  
IF OBJECT_ID('tempdb..#TempTbluserLogs001') IS NOT NULL DROP TABLE #TempTbluserLogs001  
IF OBJECT_ID('tempdb..##TemptablePVT_001') IS NOT NULL DROP TABLE ##TemptablePVT_001  
IF OBJECT_ID('tempdb..#TempTblMergeData') IS NOT NULL DROP TABLE #TempTblMergeData
IF OBJECT_ID('tempdb..#TempTbluserLog1') IS NOT NULL DROP TABLE #TempTbluserLog1 
IF OBJECT_ID('tempdb..#TempTbluserLog2') IS NOT NULL DROP TABLE #TempTbluserLog2
IF OBJECT_ID('tempdb..#TempTbluserLog3') IS NOT NULL DROP TABLE #TempTbluserLog3
IF OBJECT_ID('tempdb..#TempTbluserLog4') IS NOT NULL DROP TABLE #TempTbluserLog4
IF OBJECT_ID('tempdb..#TempTbluserLog5') IS NOT NULL DROP TABLE #TempTbluserLog5
IF OBJECT_ID('tempdb..#TempTbluserLog005') IS NOT NULL DROP TABLE #TempTbluserLog005
IF OBJECT_ID('tempdb..##Temptable_001') IS NOT NULL DROP TABLE ##Temptable_001
IF OBJECT_ID('tempdb..#TempTbluserLog06') IS NOT NULL DROP TABLE #TempTbluserLog06

;WITH CTE        
AS        
(        
SELECT DISTINCT EventTypeId,
DATEADD(MI, 480, EventTime)EventTime,UserAccount,ComputerName,ReasonID 
FROM Echolock.dbo.LockEvents(NOLOCK)LE
INNER JOIN Echolock.dbo.UserDetails(NOLOCK)UD
ON LE.UserId = UD.UserId   
WHERE EventTime BETWEEN @StartDate AND @EndDate AND EventStatus = 1 
AND EventTypeId IN (0,1,2,3,5,6) AND UD.Band IN (1,2) AND UD.[Status] = 4
AND UD.Team NOT IN ('Shared Services – Application Development','Shared Services - Infrastructure Solutions')
AND UD.[Location] = 'Manila'
)         
SELECT ER.EventName,BR.BreakReason,LE.EventTime,LE.UserAccount,LE.ComputerName         
INTO ##TempTbluserLog 
FROM Echolock.dbo.LookupEventType(NOLOCK)ER                          
INNER JOIN CTE AS LE ON ER.EventTypeId = LE.EventTypeId
INNER JOIN Echolock.dbo.LookupBreakReason(NOLOCK)BR
ON BR.Id=LE.ReasonID ORDER BY EventTime 
                                 
SELECT ROW_NUMBER() OVER(PARTITION BY UserAccount ORDER BY UserAccount,EventTime) RwNo,* 
INTO #TempTbluserLog1   
FROM ##TempTbluserLog ORDER BY UserAccount,EventTime
                               
;WITH CTE1                                
AS                                
(                                
 SELECT ROW_NUMBER() OVER(PARTITION BY UserAccount ORDER BY UserAccount,EventTime) RwNo,
 UserAccount,EventTime,EventName,BreakReason,ComputerName                                
 FROM #TempTbluserLog1 WHERE RwNo != 1                                 
)                                
SELECT T1.RwNo,T1.ComputerName,T1.UserAccount,T1.EventName FromEvent,T1.EventTime 
FromTime,LE1.EventName ToEvent,LE1.EventTime ToTime,LE1.BreakReason                                 
INTO #TempTbluserLog2 
FROM #TempTbluserLog1 AS T1                                
INNER JOIN CTE1 AS LE1 ON T1.UserAccount = LE1.UserAccount AND T1.RwNo = LE1.RwNo   
                              
SELECT RwNo,ComputerName,UserAccount,FromEvent,FromTime,ToEvent,ToTime,BreakReason,                              
CASE WHEN CONVERT(TIME,FromTime) BETWEEN '00:00:00:00' and '08:00:00:00' 
THEN DATEADD(DAY,-1,CONVERT(DATE,FromTime))  ELSE CONVERT(DATE,FromTime) END EventDate                              
INTO #TempTbluserLog3 FROM #TempTbluserLog2
                          
SELECT EventDate,ComputerName,UserAccount,FromEvent,FromTime,ToEvent,ToTime,BreakReason,
TimeSpend = CONVERT(TIME,(CONVERT(DATETIME,ToTime) - CONVERT(datetime,FromTime)))
INTO #TempTbluserLog4 FROM #TempTbluserLog3 
WHERE ToTime != '' AND (fromevent<>'Logoff' AND toevent <> 'Logon')   
                                
SELECT UserAccount,EventDate,BreakReason, 
TimeSpend = LEFT(CONVERT(TIME,CAST(SUM(DATEDIFF(SECOND,0,TimeSpend))/3600 AS VARCHAR(12)) 
	+ ':' + RIGHT('0' + CAST(SUM(DATEDIFF(SECOND,0,TimeSpend))/60%60 AS VARCHAR(2)),2) 
	+ ':' + right('0' + CAST(SUM(DATEDIFF(SECOND,0,TimeSpend))%60 AS VARCHAR(2)),2)),8)                         
INTO #TempTbluserLog5 FROM #TempTbluserLog4 
WHERE TimeSpend  < '09:00:00' GROUP BY BreakReason,EventDate ,UserAccount
              
SELECT UserAccount,EventDate , 
SUM(LEFT(TimeSpend,2) * 3600 + DATEDIFF(ss,0,'00' + right(left(TimeSpend,8),6))) TotalHrs         
INTO #TempTbluserLog005 FROM  #TempTbluserLog5 GROUP BY UserAccount,EventDate
        
DECLARE @TmpGlobalTable VARCHAR(MAX) = 'Temptable_' + CONVERT(VARCHAR(MAX),'001')        
DECLARE @DynamicPivotQuery AS NVARCHAR(MAX),        
        @PivotColumnNames AS NVARCHAR(MAX),        
        @PivotSelectColumnNames AS NVARCHAR(MAX)        
SELECT @PivotColumnNames= ISNULL(@PivotColumnNames + ',','')        
+ QUOTENAME(BreakReason)        
FROM (SELECT DISTINCT BreakReason FROM Echolock.dbo.LookupBreakReason(NOLOCK) WHERE IsActive = 1) AS BreakReason        
SELECT @PivotSelectColumnNames         
    = ISNULL(@PivotSelectColumnNames + ',','')        
    + 'ISNULL(' + QUOTENAME(BreakReason) + ', CONVERT(VARCHAR(10),''00:00:00'')) AS '            
    + QUOTENAME(BreakReason)        
FROM (SELECT DISTINCT BreakReason FROM Echolock.dbo.LookupBreakReason(NOLOCK) WHERE IsActive=1) AS BreakReason        
SET @DynamicPivotQuery =        
N'SELECT convert(varchar(30),EventDate)EventDate,UserAccount, ' + @PivotSelectColumnNames + '        
INTO [##' + @TmpGlobalTable + ']  FROM #TempTbluserLog5        
PIVOT(MAX(TimeSpend)        
FOR BreakReason IN (' + @PivotColumnNames + ')) AS PVTTable'        
EXEC sp_executesql @DynamicPivotQuery
                     
SELECT a.* ,CONVERT(varchar, DATEADD(ss, b.TotalHrs , 0), 108)TotalHrs  
INTO #TempTbluserLog06  FROM ##Temptable_001 a        
LEFT JOIN #TempTbluserLog005 b on a.UserAccount=b.UserAccount and a.EventDate = b.EventDate  

TRUNCATE TABLE Mail_ManilaBreakSplitup

INSERT INTO Mail_ManilaBreakSplitup([EventDate],[LOB],[Client],[Location],[Process],[Supervisor],[Grade],[UserAccount],[Break],[Discussion],  
[Fire Drill],[Fun Event],[Health Issue],[Lunch Break],[Meeting],[NoReason Update],[One on One],[Production],[QA Feedback],  
[System Downtime],[Training],[TotalHrs],[IT Issue - Internal/Client],[HR Activity])  
SELECT a.EventDate,b.LOB,b.Client,b.[Location],b.Team Process,b.ManagerL1 Supervisor,b.Grade,  
a.UserAccount,[Break],Discussion,[Fire Drill],[Fun Event],[Health Issue],[Lunch Break],Meeting,[NoReason Update],[One on One],  
Production,[QA Feedback],[System Downtime],Training,TotalHrs,[IT Issue - Internal/Client],[HR Activity]  
FROM #TempTbluserLog06 a  
INNER JOIN Echolock.dbo.UserDetails(NOLOCK)b ON a.UserAccount = b.NTLoginName

IF OBJECT_ID('tempdb..##TempTbluserLog') IS NOT NULL DROP TABLE ##TempTbluserLog          
IF OBJECT_ID('tempdb..#TempTbluserLogs') IS NOT NULL DROP TABLE #TempTbluserLogs  
IF OBJECT_ID('tempdb..#TempTbluserLogs001') IS NOT NULL DROP TABLE #TempTbluserLogs001  
IF OBJECT_ID('tempdb..##TemptablePVT_001') IS NOT NULL DROP TABLE ##TemptablePVT_001  
IF OBJECT_ID('tempdb..#TempTblMergeData') IS NOT NULL DROP TABLE #TempTblMergeData
IF OBJECT_ID('tempdb..#TempTbluserLog1') IS NOT NULL DROP TABLE #TempTbluserLog1 
IF OBJECT_ID('tempdb..#TempTbluserLog2') IS NOT NULL DROP TABLE #TempTbluserLog2
IF OBJECT_ID('tempdb..#TempTbluserLog3') IS NOT NULL DROP TABLE #TempTbluserLog3
IF OBJECT_ID('tempdb..#TempTbluserLog4') IS NOT NULL DROP TABLE #TempTbluserLog4
IF OBJECT_ID('tempdb..#TempTbluserLog5') IS NOT NULL DROP TABLE #TempTbluserLog5
IF OBJECT_ID('tempdb..#TempTbluserLog005') IS NOT NULL DROP TABLE #TempTbluserLog005
IF OBJECT_ID('tempdb..##Temptable_001') IS NOT NULL DROP TABLE ##Temptable_001
IF OBJECT_ID('tempdb..#TempTbluserLog06') IS NOT NULL DROP TABLE #TempTbluserLog06

END
GO
/****** Object:  StoredProcedure [dbo].[EcholockAppArchiveUsageJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--======================================================================================        
--EcholockAppArchiveUsageJob - Daily App Usage Job for Echolock by Company/ Individual  
--======================================================================================        
--Created By  -  Promodh.Kumar        
--Created On  -  03/01/2020        
--Parameters  -  @CompanyId, @UserId, @FromDate, @RefTime        
--Notes                -  App Usage Calculations from Archive Table Entries        
--======================================================================================
        
CREATE Proc [dbo].[EcholockAppArchiveUsageJob]
(        
 @CompanyId int,       -- Target Company Id        
 @UserId nvarchar(128) = null,   -- Null, if for whole company        
 @FromDate datetime,      -- UTC        
 @RefTime time       -- Reference Time for calculation  
)        
        
as        
begin        
 set transaction Isolation level read uncommitted;        
 set nocount on        
  
IF OBJECT_ID('tempdb..#uniqueApps') IS NOT NULL drop table #uniqueApps  
IF OBJECT_ID('tempdb..#uniqueUrls') IS NOT NULL  drop table #uniqueUrls     
 IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL drop table #dailylogs        
 IF OBJECT_ID('tempdb..#appWatcher') IS NOT NULL drop table #appWatcher        
 IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users  
         
 /* set @RefTime = '08:30:00' */  
--declare @TimeZoneOffSet bigint=0        
 declare @Bufferhours int=3        
        
 create table #users        
 (        
  Id int identity(1,1),        
  UserId nvarchar(128),        
  ShiftId int,        
  FromTime datetime2,        
  ToTime datetime2,        
  ActualFromTime datetime2,        
  ActualToTime datetime2,       
  status bit default(1)        
 );        
        
 create table #appWatcher        
 (        
  Id bigint identity(1,1),        
  AppName varchar(500) null,        
  BaseUrl nvarchar(max) null,  
  TimeSpent bigint,        
  UserId nvarchar(128),        
  status bit default(1)  
);  
        
 create table #dailylogs        
 (        
  Id bigint identity(1,1),        
  UserId nvarchar(128),        
  AppId bigint,  
  UsageDate datetime,  
  TimeSpentms bigint,  
  status bit default(1)  
);  
        
 declare @tc int = 0, @selectedUser nvarchar(128), @ltc int = 0        
 declare @ToDate datetime=dateadd(day,1,@FromDate)        
 declare @currentUserId nvarchar(128), @currentShiftTo datetime2, @currentShiftFrom datetime2    
        
 if (@UserId is null)        
 begin        
  insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)        
   select ud.UserId, ud.Shift,        
     dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
     (case when sft.WorkEndTime > sft.WorkStartTime  
      then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
      else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
     DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
     (case when sft.WorkEndTime > sft.WorkStartTime  
      then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
      else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
    from echolock.dbo.DailyDashboardData ud (nolock)      
    inner join echolock.dbo.LookupShift sft (nolock) on ud.Shift = sft.Id  
       inner join EchoLock.dbo.LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
    where ud.UserId in        
     (select UserId        
      from echolock.dbo.UserDetails with (nolock)        
      where CompanyId = @CompanyId)        
       --and ud.Status=4 /* To process for Active Users Only */  
       and ud.NTLoginName <> 'System'
	   and ud.EventDate = @FromDate
 end        
 else        
 begin          
  insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)        
   select ud.UserId, ud.Shift,        
     dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
     (case when sft.WorkEndTime > sft.WorkStartTime  
      then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
      else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
     DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
     (case when sft.WorkEndTime > sft.WorkStartTime  
      then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
      else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
    from echolock.dbo.DailyDashboardData ud (nolock)      
    inner join echolock.dbo.LookupShift sft (nolock) on ud.Shift = sft.Id  
       inner join EchoLock.dbo.LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
    where ud.UserId = @UserId        
     --and ud.Status=4 /* To process for Active Users Only */  
     and ud.NTLoginName <> 'System'
	 and ud.EventDate = @FromDate
 end      
        
 select @tc = count(*) from #users        
        
 while @tc!=0        
 begin        
  select top 1 @selectedUser = UserId, @currentShiftFrom = FromTime, @currentShiftTo = ToTime  
   from #users        
   where status=1        
   --order by Id desc  
     
       insert into #appWatcher  
              select AppName, null, sum(TimeSpentms), UserId, 1  
                     from echolock.dbo.AppWatcherArchive 
                     (nolock)  
                     where UserId = @selectedUser  
                           and StartTime >= @currentShiftFrom
						   and StartTime <= @currentShiftTo
                           and EndTime >= @currentShiftFrom
						   and EndTime <= @currentShiftTo
                           and BaseUrl is null  
                           and AppName <> ''  
                     group by UserId, AppName  
  
       insert into #appWatcher  
              select null, BaseUrl, sum(TimeSpentms), UserId, 1  
                     from echolock.dbo.AppWatcherArchive  
                     (nolock)  
                     where UserId = @selectedUser  
                           and StartTime >= @currentShiftFrom
						   and StartTime <= @currentShiftTo
                           and EndTime >= @currentShiftFrom
						   and EndTime <= @currentShiftTo
                           and BaseUrl is not null  
                           and BaseUrl <> ''  
                     group by UserId, BaseUrl
        
  update #users        
   set status=0        
   where status=1 and UserId=@selectedUser        
  set @tc=@tc-1  
end  
  
       select distinct AppName  
              into #uniqueApps  
              from #appWatcher  
              (nolock)  
              where AppName is not null  
  
       select distinct BaseUrl  
              into #uniqueUrls  
              from #appWatcher  
              (nolock)  
              where BaseUrl is not null  
  
       begin try  
                
              begin tran  
  
          insert into echolock.dbo.LookupApps  
                     select a.AppName, null, null, getdate(), 1  
                     from #uniqueApps a  
                           (nolock)  
                           where not exists (select 'x'  
                                  from echolock.dbo.LookupApps b  
                                  (nolock)  
                                  where b.AppName = a.AppName)  
  
              insert into echolock.dbo.LookupApps  
                     select null, a.BaseUrl, null, getdate(), 1  
                           from #uniqueUrls a  
                           (nolock)  
                           where not exists (select 'x'  
                                         from echolock.dbo.LookupApps b  
                                         (nolock)  
                                         where b.BaseUrl = a.BaseUrl)  
  
              insert into #dailylogs  
                     select a.UserId, b.Id, @FromDate, a.TimeSpent, 1  
                           from #appWatcher a  
                                  (nolock)  
                                  inner join echolock.dbo.LookupApps b on a.AppName = b.AppName   
                                         and b.AppName is not null and a.AppName is not null  
  
              insert into #dailylogs  
                     select a.UserId, b.Id, @FromDate, a.TimeSpent, 1  
                           from #appWatcher a  
                                  (nolock)  
                                  inner join echolock.dbo.LookupApps b on a.BaseUrl = b.BaseUrl  
                                         and b.BaseUrl is not null and a.BaseUrl is not null  
  
              merge echolock.dbo.DailyAppUsage t      
                using #dailylogs s      
                on (s.UserId = t.UserId and s.UsageDate = t.UsageDate  
                           and s.AppId = t.AppId)  
                when matched then      
                 update set t.TimeSpentms = s.TimeSpentms, t.Classification = 3, t.Category = 1  
                when not matched by target then      
                 insert (UserId, UsageDate, AppId, TimeSpentms, Classification, Category)  
                     values (s.UserId, s.UsageDate, s.AppId, s.TimeSpentms, 3, 1)  
                ;  
  
              commit  
  
       end try  
       begin catch  
  
              select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()         
                
              rollback  
  
insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
values ('EcholockAppArchiveUsageJob Error',     
convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
getdate(), 'EcholockAppArchiveUsageJob', 'SQL Server')    
  
insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
'Error in EcholockAppArchiveUsageJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
0, 'Y', getdate(), null, 1)   
  
  
       end catch  
  
  
      
  
IF OBJECT_ID('tempdb..#uniqueApps') IS NOT NULL drop table #uniqueApps  
IF OBJECT_ID('tempdb..#uniqueUrls') IS NOT NULL  drop table #uniqueUrls     
 IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL drop table #dailylogs        
 IF OBJECT_ID('tempdb..#appWatcher') IS NOT NULL drop table #appWatcher        
 IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users  
  
exec Echolock.dbo.EcholockDailyAppClassifyJob @CompanyId, @UserId, @FromDate, @RefTime  
end

GO
/****** Object:  StoredProcedure [dbo].[EcholockAppDataTableArchive]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EcholockAppDataTableArchive]
(@TableName VARCHAR(100))
AS
BEGIN
/*declare @TableName VARCHAR(100) = 'TestTable_001'*/
DECLARE @result VARCHAR(MAX),@CreatedOn DATETIME,
@Status VARCHAR(150),@ArchiveTable VARCHAR(100),
@SqlString VARCHAR(MAX),@StartTime DATETIME
,@STime DATETIME,@ETime DATETIME, @JobCount INT

SET @result = ''
SET @Status =''
SET @StartTime = GETDATE()
SET @ArchiveTable = @TableName +'Archive'
			
SET @STime = CONVERT(DATETIME,CONVERT(VARCHAR(12), GETDATE(),101))
SET @ETime = DATEADD(MS,-3,DATEADD(DAY,1,DATEADD(DD, DATEDIFF(DD,0,GETDATE()), 0)))

SELECT @JobCount = COUNT(ID)
FROM EchoLock.dbo.EcholockTableArchiveJobLog(NOLOCK)
WHERE CreatedOn BETWEEN @STime AND @ETime AND TableName = @TableName

IF @JobCount = 0
BEGIN
	BEGIN TRY
		IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @ArchiveTable)
		BEGIN		
			SET @SqlString = 'DROP TABLE ' + @ArchiveTable
			EXEC (@SqlString)
			WAITFOR DELAY '00:00:10'

			IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @ArchiveTable)
			BEGIN	
				EXEC sp_rename @TableName,@ArchiveTable			
				EXEC EcholockAppDataTableCreate @TableName 			
			END
			ELSE
			BEGIN
				EXEC sp_rename @TableName,@ArchiveTable			
				EXEC EcholockAppDataTableCreate @TableName 			
			END
		END
		ELSE
		BEGIN
			IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @TableName)
				BEGIN
					EXEC sp_rename @TableName,@ArchiveTable
					EXEC EcholockAppDataTableCreate @TableName
				END
			ELSE
				BEGIN
					EXEC EcholockAppDataTableCreate @TableName
					SET @result = 'New '	
				END			
		END
		IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @TableName)
			BEGIN
				SELECT @CreatedOn = create_date FROM sys.TABLES WHERE NAME = @TableName
				SET @Status  = CASE WHEN @CreatedOn BETWEEN @StartTime AND GETDATE() 
				THEN 'New '+@TableName+' table created at ' + CONVERT(VARCHAR,@CreatedOn,121)   
				ELSE 'Old '+ @TableName + ' table created at ' + CONVERT(VARCHAR,@CreatedOn,121) END
				
				INSERT INTO EcholockTableArchiveJobLog(TableName,Remarks,CreatedBy)
				VALUES(@TableName,@Status,SUSER_NAME())
			END
		ELSE
			BEGIN
				SET @Status =  '<<No '+@TableName+' table>>'
			END
	SET @result = 'Success: '+ @result + @Status 
	END TRY
	BEGIN CATCH
		SET @result = 'Err: '+ ERROR_MESSAGE()
	END CATCH 
END
ELSE
BEGIN
	SET @result = 'Job Run multiple times for the table : '+ @TableName
END

SELECT @result AS Result
	
	INSERT INTO ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
	VALUES ('it@accesshealthcare.com', 'Arc_Apps_Support@accesshealthcare.com;saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',   
	'Echolock APP Data Archive', 'Hi, <BR><BR>' + @result + '<BR>' ,0, 'Y', GETDATE(), null, 1) 
END

GO
/****** Object:  StoredProcedure [dbo].[EcholockAppDataTableCreate]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EcholockAppDataTableCreate]
(@TableName VARCHAR(100))
AS
BEGIN
DECLARE @SqlString VARCHAR(MAX),
@SqlString1 VARCHAR(MAX),
@SqlString2 VARCHAR(MAX),
@SqlString3 VARCHAR(MAX),
@SqlString4 VARCHAR(MAX),
@SqlString5 VARCHAR(MAX),
@SqlString6 VARCHAR(MAX),
@Cons VARCHAR(20)

SET @Cons = REPLACE(CONVERT(VARCHAR, GETDATE(),101),'/','') + REPLACE(CONVERT(VARCHAR, GETDATE(),108),':','')

SET @SqlString = '
CREATE TABLE [dbo].['+ @TableName +'](
       [Id] [bigint] IDENTITY(1,1) NOT NULL,
       [UserId] [nvarchar](128) NOT NULL,
       [UserAccount] [varchar](100) NOT NULL,
       [UserDomain] [varchar](50) NOT NULL,
       [ComputerName] [varchar](100) NOT NULL,
       [AppName] [varchar](500) NOT NULL,
       [WindowTitle] [varchar](500) NULL,
       [BrowserUrl] [nvarchar](MAX) NULL,
       [StartTime] [datetime2](7) NOT NULL,
       [EndTime] [datetime2](7) NOT NULL,
       [TimeSpent] [time](7) NOT NULL,
       [VersionId] [varchar](100) NOT NULL,
       [CreatedOn] [datetime2](7) NOT NULL,
       [OperatingSystem] [varchar](100) NOT NULL,
       [BaseUrl] [varchar](MAX) NULL,
       [TimeSpentms] [bigint] NOT NULL,
CONSTRAINT [PK_'+ @TableName +'_'+ @Cons +'] PRIMARY KEY CLUSTERED 
([Id] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
CONSTRAINT [UC_'+ @TableName +'_'+ @Cons +'] UNIQUE NONCLUSTERED ([UserId] ASC, [StartTime] ASC, [EndTime] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY])
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]'

SET @SqlString1 = 'ALTER TABLE [dbo].['+ @TableName +'] ADD  CONSTRAINT [DF_'+ @TableName +'_CreatedOn_'+ @Cons +']  DEFAULT (getdate()) FOR [CreatedOn]'
SET @SqlString2 = 'ALTER TABLE [dbo].['+ @TableName +'] ADD  CONSTRAINT [DF_'+ @TableName +'_OperatingSystem_'+ @Cons +']  DEFAULT (''Windows'') FOR [OperatingSystem]'
SET @SqlString3 = 'ALTER TABLE [dbo].['+ @TableName +'] ADD  CONSTRAINT [DF_'+ @TableName +'_TimeSpentms_'+ @Cons +']DEFAULT ((0)) FOR [TimeSpentms]'
SET @SqlString4 = 'ALTER TABLE [dbo].['+ @TableName +']  WITH CHECK ADD  CONSTRAINT [FK_'+ @TableName +'_Userid_'+ @Cons +'] FOREIGN KEY([UserId]) 
REFERENCES [dbo].[Users] ([UserId])'
SET @SqlString5 = 'ALTER TABLE [dbo].['+ @TableName +'] CHECK CONSTRAINT [FK_'+ @TableName +'_Userid_'+ @Cons +']'
SET @SqlString6 = 'ALTER TABLE [dbo].['+ @TableName +'] ADD CONSTRAINT [UC_'+ @TableName +'_AppTime_'+ @Cons +']  UNIQUE (UserId,StartTime,AppName)
'

EXEC (@SqlString)
WAITFOR DELAY '00:00:02'
EXEC (@SqlString1)
EXEC (@SqlString2)
EXEC (@SqlString3)
EXEC (@SqlString4)
EXEC (@SqlString5)
EXEC (@SqlString6)
END
GO
/****** Object:  StoredProcedure [dbo].[EcholockAttendanceSyncJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*--======================================================================================        
--ARCtoEcholockAttendanceSync - ARC Attendance sync Job for Echolock
--======================================================================================        
--Created By   -  Promodh.Kumar        
--Created On   -  14/11/2019        
--Parameters   -  @AttId
--Notes     -  All Lock Event Time Calculations are in UTC        
--======================================================================================        
--Modified By   -
--Modified On   -
--Modification Details -
--======================================================================================        
*/  
        
CREATE Proc [dbo].[EcholockAttendanceSyncJob]
(        
	@Date datetime
)
        
as        
begin        
	set transaction Isolation level read uncommitted;
	set nocount on

	IF OBJECT_ID('tempdb..#attdata') IS NOT NULL drop table #attdata 
	IF OBJECT_ID('tempdb..#currentdata') IS NOT NULL drop table #currentdata 
	IF OBJECT_ID('tempdb..#modified') IS NOT NULL drop table #modified

	select *
		into #attdata
		from ARC_Enterprise.dbo.ARC_REC_Attendance
		(nolock)
		where [Date] = @Date

	if exists (select top 1 * from #attdata)
	begin

		declare @CompanyAppWatcher bit = 0
		
		select distinct att.Aid AttId, ud.UserId, att.UserId ARCUserId, att.NT_UserName NTLoginName, att.[Date] EventDate, att.AttReporting_to Manager, esft.Id Shift, att.Shift_From ShiftFrom,
				att.Shift_to ShiftTo, att.Designid, att.Functionalityid, att.Client_id ClientId, att.AttLocationid LocationId,
				att.AttLobid LOBId, fun.FunctionName Team, lob.lob LOB, desg.Designation Role, desg.Band Band, desg.Grade Grade, ud.TimeZone,
				client.Client_Name Client, loc.LocationName as [Location], att.P_Days Present, isnull(app.AppWatcher, @CompanyAppWatcher) AppWatcher, att.IsDeclaredOff DeclaredOff,
				cc.CostCode, fun.[Type] Process,
				grp.GroupName, sgrp.SubGroupName, sfun.SubFunctionality, prj.Project, fgrp.FunctionalityGroupName
			into #currentdata
			from #attdata att
			(nolock)
            inner join ARC_Enterprise.dbo.ARC_REC_SHIFT_INFO  sft
            (nolock)
                    on att.ShiftId = sft.Shift_Id
            left join ARC_Enterprise.dbo.ARC_REC_LOB_INFO lob
            (nolock)
                    on att.AttLobId = lob.ID
            left join ARC_Enterprise.dbo.HR_Functionality fun
            (nolock)
                    on att.FunctionalityId = fun.FunctionalityId
			left join ARC_Enterprise.dbo.HR_FunctionalityGroups fgrp
            (nolock)
                    on fun.FunctionalityGroupId = fgrp.FunctionalityGroupId
            left join ARC_Enterprise.dbo.HR_Designation desg
            (nolock)
                    on att.DesignId = desg.DesigId
            left join ARC_Enterprise.dbo.ARC_FIN_CLIENT_INFO client
            (nolock)
                    on att.Client_Id = client.Client_Id
            left join ARC_Enterprise.dbo.HR_LocationMaster loc
            (nolock)
                    on att.AttLocationId = loc.LocationId
			left join ARC_Enterprise.dbo.HR_CostCode cc
			(nolock)
					on att.CostCodeId = cc.CostCodeId
			left join ARC_Enterprise.dbo.HR_FunctionGroup grp
			(nolock)
					on att.GroupId = grp.GroupId
			left join ARC_Enterprise.dbo.HR_FunctionSubGroup sgrp
			(nolock)
					on att.SubGroupId = sgrp.SubGroupId
			left join ARC_Enterprise.dbo.HR_SubFunctionality sfun
			(nolock)
					on att.SubFunctionalityId = sfun.SubFunctionalityId
			left join ARC_Enterprise.dbo.HR_Project prj
			(nolock)
					on att.ProjectId = prj.ProjectId
            left join Echolock.dbo.DailyDashboardData ud
            (nolock)
                    on att.NT_UserName = ud.NTLoginName and att.[Date] = ud.EventDate
            left join Echolock.dbo.LookupShift esft
            (nolock)
                    on sft.SHIFT_NAME = esft.ShiftName and sft.SHIFT_FROM = esft.WorkStartTime and sft.SHIFT_TO = esft.WorkEndTime
            left join Echolock.dbo.UserAppSettings app
            (nolock)
                    on ud.UserId = app.UserId

		begin try
			begin tran

			select cd.AttId, cd.EventDate, cd.UserId,
					case when isnull(cd.Manager,'') <> isnull(dd.ManagerL1,'') then cd.Manager else null end Manager,
					case when isnull(cd.Role,'') <> isnull(dd.Role,'') then cd.Role else null end Role,
					case when isnull(cd.Team,'') <> isnull(dd.Team,'') then cd.Team else null end Team,
					case when isnull(cd.Client,'') <> isnull(dd.Client,'') then cd.Client else null end Client,
					case when isnull(cd.Location,'') <> isnull(dd.Location,'') then cd.Location else null end Location,
					case when isnull(cd.LOB,'') <> isnull(dd.LOB,'') then cd.LOB else null end LOB,
					case when isnull(cd.Band,'') <> isnull(dd.Band,'') then cd.Band else null end Band,
					case when isnull(cd.Grade,'') <> isnull(dd.Grade,'') then cd.Grade else null end Grade,
					case when cd.Shift <> dd.Shift then cd.Shift else dd.Shift end Shift,
					case when cd.TimeZone <> dd.TimeZone then cd.TimeZone else dd.TimeZone end TimeZone,
					case when cd.ShiftFrom <> dd.ShiftFrom then cd.ShiftFrom else null end ShiftFrom,
					case when cd.ShiftTo <> dd.ShiftTo then cd.ShiftTo else null end ShiftTo,
					cd.ARCUserId, cd.NTLoginName,
					case when cd.Present <> dd.Present then cd.Present else null end Present,
					case when cd.DeclaredOff <> dd.IsDeclaredOff then cd.DeclaredOff else null end DeclaredOff,
					case when isnull(cd.Costcode,'') <> isnull(dd.Costcode,'') then cd.Costcode else null end Costcode,
					case when isnull(cd.Process,'') <> isnull(dd.Process,'') then cd.Process else null end Process,
					case when isnull(cd.GroupName,'') <> isnull(dd.[Group],'') then cd.GroupName else null end [Group],
					case when isnull(cd.SubGroupName,'') <> isnull(dd.SubGroup,'') then cd.SubGroupName else null end SubGroup,
					case when isnull(cd.SubFunctionality,'') <> isnull(dd.SubFunctionality,'') then cd.SubFunctionality else null end SubFunctionality,
					case when isnull(cd.Project,'') <> isnull(dd.Project,'') then cd.Project else null end Project,
					case when isnull(cd.FunctionalityGroupName,'') <> isnull(dd.FunctionalityGroup,'') then cd.FunctionalityGroupName else null end FunctionalityGroup,
					AppWatcher,
					0 Status
				into #modified
				from #currentdata cd
				inner join DailyDashboardData dd
				(nolock)
					on cd.UserId = dd.UserId and cd.EventDate = dd.EventDate

			update #modified
				set Status = 1
				where ((Manager is not null) or (Role is not null) or (Team is not null) or (Client is not null)
						or (Location is not null) or (LOB is not null) or (Band is not null) or (Grade is not null)
						or (ShiftFrom is not null) or (ShiftTo is not null) or (Present is not null) or (DeclaredOff is not null)
						or (Costcode is not null) or (Process is not null)
						or ([Group] is not null) or (SubGroup is not null) or (SubFunctionality is not null) 
						or (Project is not null) or (FunctionalityGroup is not null))
			insert into DashboardChangeHistory
					(AttId, EventDate, UserId, ManagerL1, Role, Team, Client, Location, LOB, Band, Grade, Shift, TimeZone, ShiftFrom, ShiftTo, ARCUserId,
					NTLoginName, Present, IsDeclaredOff, CreatedOn, IsJobRequired, JobRunStatus, JobRunTime, CostCode, Process, [Group], SubGroup, SubFunctionality,
					Project, FunctionalityGroup)
				select AttId, EventDate, UserId, Manager, Role, Team, Client, Location, LOB, Band, Grade, Shift, TimeZone, ShiftFrom, ShiftTo, ARCUserId,
						NTLoginName, Present, DeclaredOff, getdate(), 0, 0, null, Costcode, Process, [Group], SubGroup, SubFunctionality, Project, FunctionalityGroup
					from #modified
					where Status = 1

			update dd
				set dd.NTLoginName = isnull(cd.NTLoginName, dd.NTLoginName), dd.ManagerL1 = isnull(cd.Manager, dd.ManagerL1), dd.Shift = cd.Shift,
					dd.ShiftFrom = isnull(cd.ShiftFrom, dd.ShiftFrom), dd.ShiftTo = isnull(cd.ShiftTo, dd.ShiftTo),
					dd.Role = isnull(cd.Role, dd.Role), dd.Team = isnull(cd.Team, dd.Team), dd.LOB = isnull(cd.LOB, dd.LOB), dd.Band = isnull(cd.Band, dd.Band),
					dd.Grade = isnull(cd.Grade, dd.Grade), dd.Client = isnull(cd.Client, dd.Client), dd.Location = isnull(cd.Location, dd.Location),
					dd.Present = isnull(cd.Present, dd.Present), dd.AppWatcherEnabled = isnull(cd.AppWatcher, dd.AppWatcherEnabled), dd.IsDeclaredOff = isnull(cd.DeclaredOff, dd.IsDeclaredOff),
					dd.Costcode = isnull(cd.Costcode, dd.CostCode), dd.Process = isnull(cd.Process, dd.Process),
					dd.[Group] = isnull(cd.[Group], dd.[Group]), dd.SubGroup = isnull(cd.SubGroup, dd.SubGroup), dd.SubFunctionality = isnull(cd.SubFunctionality, dd.SubFunctionality),
					dd.Project = isnull(cd.Project, dd.Project),
					dd.FunctionalityGroup = isnull(cd.FunctionalityGroup, dd.FunctionalityGroup)
				from EchoLock.dbo.DailyDashboardData dd
				inner join #modified cd
					on dd.UserId = cd.UserId and dd.EventDate = cd.EventDate
				where Status = 1

			commit
		end try
		begin catch
			rollback

		end catch
	end   

	IF OBJECT_ID('tempdb..#attdata') IS NOT NULL drop table #attdata 
	IF OBJECT_ID('tempdb..#currentdata') IS NOT NULL drop table #currentdata 
	IF OBJECT_ID('tempdb..#modified') IS NOT NULL drop table #modified
end
GO
/****** Object:  StoredProcedure [dbo].[EcholockBreakSplitJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
--======================================================================================          
--EcholockBreakSplitJob - Break Split up Job for Echolock by Company/ Individual        
--======================================================================================          
--Created By   -  Promodh.Kumar          
--Created On   -  04/03/2019        
--Parameters   -  @CompanyId, @UserId, @FromDate, @RefTime          
--Notes     -  All Lock Event Time Calculations are in UTC          
--======================================================================================          
--Modified By   -    Promodh.Kumar  
--Modified On   -    24/072019  
--Modification Details -   Modified to calculate Break-Split only within shift hours & Valid Lock Events only  
--======================================================================================  
*/  
          
CREATE Proc [dbo].[EcholockBreakSplitJob]        
(          
 @CompanyId int,       -- Target Company Id          
 @UserId nvarchar(128) = null,   -- Null, if for whole company          
 @FromDate datetime,      -- UTC          
 @RefTime time       -- Reference Time for calculation       
)          
          
as          
begin          
	set transaction Isolation level read uncommitted;          
	set nocount on          
           
	IF OBJECT_ID('tempdb..#result1') IS NOT NULL  drop table #result1  
	IF OBJECT_ID('tempdb..#source1logs') IS NOT NULL drop table #source1logs  
	IF OBJECT_ID('tempdb..#source2logs') IS NOT NULL drop table #source2logs        
	IF OBJECT_ID('tempdb..#breaklogs') IS NOT NULL  drop table #breaklogs        
	IF OBJECT_ID('tempdb..#lockevents') IS NOT NULL drop table #lockevents          
	IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users
          
	create table #users          
	(          
		Id int identity(1,1),          
		UserId nvarchar(128),          
		ShiftId int,          
		FromTime datetime,          
		ToTime datetime,          
		ActualFromTime datetime,          
		ActualToTime datetime,          
		status bit default(1)          
	);          
          
	create table #lockevents          
	(          
		Id bigint identity(1,1),          
		EventTypeId int,          
		ShiftId int,          
		EventTime datetime,          
		UserId nvarchar(128),          
		AFromTime datetime,          
		AToTime datetime,        
		ReasonId int,        
		UserAccount varchar(100),        
		ComputerName varchar(100),        
		status bit default(1)          
	);          
          
	create table #breaklogs        
	(        
		UserId nvarchar(128),        
		EventTypeId int,        
		EventName varchar(100),        
		EventTime datetime,        
		UserAccount varchar(100),        
		ComputerName varchar(100),        
		ReasonId int,        
		ReasonName varchar(100)        
	);        
        
	create table #source1logs        
	(        
		RwNo int,        
		UserId nvarchar(128),        
		UserAccount varchar(100),        
		ComputerName varchar(100),        
		EventTime datetime,        
		EventName varchar(100),        
		ReasonName varchar(100),        
		ReasonId int        
	);        
        
	create table #source2logs        
	(        
		RwNo int,        
		UserId nvarchar(128),        
		UserAccount varchar(100),        
		EventTime datetime,        
		EventName varchar(100),        
		ReasonName varchar(100),        
		ReasonId int        
	);        
        
	create table #result1        
	(        
		UserId nvarchar(128),        
		EventDate datetime,        
		UserAccount varchar(100),        
		ComputerName varchar(100),        
		FromEvent varchar(100),        
		FromTime datetime,        
		ToEvent varchar(100),        
		ToTime datetime,        
		ReasonId int,        
		BreakReason varchar(100),        
		TimeSpent bigint,        
	);        
        
	declare @tc int = 0, @selectedUser nvarchar(128), @ltc int = 0          
	declare @ToDate datetime=dateadd(day,1,@FromDate)          
	declare @currentUserId nvarchar(128), @currentShiftTo datetime, @currentShiftFrom datetime          
	declare @duration int=0, @mtc int=0          
	declare @refstartdate datetime, @refenddate datetime, @refstartid bigint, @refstarteventtype int, @refendeventtype int          
	declare @actuallogin datetime, @actuallogout datetime          
          
          
	---- Get Company TimeZone for Shift Calculation in UTC          
	--if(@UserId is null)          
	--begin          
	-- select @TimeZoneOffSet = CurrentUTCOffset          
	--  from CompanyAppSettings a          
	--   inner join LookupTimeZone b on a.TimeZoneId = b.Id          
	--  where a.CompanyId = @CompanyId          
	--end          
	--else          
	--begin          
	-- select @TimeZoneOffSet = CurrentUTCOffset          
	--  from UserDetails ud          
	--   inner join CompanyAppSettings a on ud.CompanyId = a.CompanyId          
	--   inner join LookupTimeZone b on a.TimeZoneId = b.Id        
	--  where ud.UserId = @UserId          
	--end          
          
	if (@UserId is null)          
	begin          
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)          
		select distinct ud.UserId, ud.Shift,          
			dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
			else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
			DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
			else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
		from DailyDashboardData ud (nolock)        
		inner join LookupShift sft (nolock) on ud.Shift = sft.Id  
			inner join LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
		where ud.UserId in          
			(select UserId          
			from UserDetails with (nolock)          
			where CompanyId = @CompanyId)          
			--and ud.Status=4 -- To process for Active Users Only          
			and ud.NTLoginName <> 'System'
			and ud.EventDate = @FromDate        
	end          
	else          
	begin            
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)          
		select distinct ud.UserId, ud.Shift,          
			dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
			else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
			DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
			else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
		from DailyDashboardData ud (nolock)        
		inner join LookupShift sft (nolock) on ud.Shift = sft.Id  
			inner join LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
		where ud.UserId = @UserId          
			--and ud.Status=4 -- To process for Active Users Only          
			and ud.NTLoginName <> 'System'
			and ud.EventDate = @FromDate
	end        
          
	select @tc = count(*) from #users          
          
	while @tc!=0          
	begin          
		set @selectedUser = (select top 1 UserId          
		from #users          
		where status=1          
		order by Id desc)          
          
		insert into #lockevents (UserId, EventTime, EventTypeId, ShiftId, AFromTime, AToTime, UserAccount, ComputerName, ReasonId)          
			select le.UserId, le.EventTime, le.EventTypeId, ud.ShiftId, ud.ActualFromTime, ud.ActualToTime, le.UserAccount, le.ComputerName, le.ReasonId        
			from LockEvents le (nolock)          
				inner join #users ud on le.UserId=ud.UserId          
			where le.EventTime >=ud.FromTime          
				and le.EventTime <= ud.ToTime          
				and le.EventTypeId not in (4,10,12)          
				and le.UserId = @selectedUser        
						and le.EventStatus = 1 /* Added for processing only Valid Lock Events */  
			order by le.EventTime          
            
		set @ltc = (select count(distinct UserId)          
			from #lockevents (nolock)          
			where UserId = @selectedUser)          
          
		while (@ltc!=0)          
		begin  
			select top 1 @currentUserId = UserId, @currentShiftTo = AToTime, @currentShiftFrom = AFromTime        
				from #lockevents (nolock)        
				where status = 1        
				order by Id desc   
  
				/* --- Added to calculate within shift hours ---*/  
  
			/*Update eventtime for event, before the shift start time and after the shift end time*/  
			update #lockevents set EventTime = @currentShiftFrom        
				where EventTime in (select top 1 EventTime        
					from #lockevents        
					where UserId = @currentUserId        
					and EventTime <= @currentShiftFrom        
					order by EventTime desc)  
  
			update #lockevents set EventTime = @currentShiftTo        
				where EventTime in (select top 1 EventTime        
					from #lockevents        
					where UserId = @currentUserId        
					and EventTime >= @currentShiftTo  
					order by EventTime asc)  
          
			delete from #lockevents        
				where UserId = @currentUserId        
					and (EventTime > @currentShiftTo or EventTime < @currentShiftFrom)        
        
			delete from #lockevents        
				where UserId = @currentUserId        
					and EventTime < @currentShiftFrom   
					/* --- Added to calculate within shift hours ---*/  
          
			insert into #breaklogs (UserId, EventTypeId, EventTime, UserAccount, ComputerName, ReasonId, EventName, ReasonName)         
				select distinct le.UserId, le.EventTypeId, EventTime, UserAccount, ComputerName, ReasonId, evt.EventName, br.BreakReason        
					from #lockevents  le (nolock)        
						inner join LookupBreakReason br on le.ReasonId = br.Id        
						inner join LookupEventType evt on evt.EventTypeId = le.EventTypeId        
					where le.EventTypeId in (0,1,2,3,5,6)        
						and le.UserId = @selectedUser        
						and le.status = 1        
					order by le.UserAccount, le.EventTime  
  
			update #breaklogs  
				set ReasonId = 3, ReasonName = 'Break'  
				where EventTypeId = 5  
        
			delete from #source1logs        
			delete from #source2logs        
        
			insert into #source1logs (RwNo, UserId, UserAccount, EventTime, EventName, ReasonName, ComputerName, ReasonId)        
				select row_number() over(partition by UserAccount order by UserAccount, EventTime) RwNo, UserId, UserAccount, EventTime, EventName, ReasonName, ComputerName, ReasonId        
					from #breaklogs        
					where UserId = @selectedUser        
        
			insert into #source2logs (RwNo, UserId, UserAccount, EventTime, EventName, ReasonName, ReasonId)   
				select row_number() over(partition by UserAccount order by UserAccount, EventTime) RwNo, UserId, UserAccount, EventTime, EventName, ReasonName, ReasonId        
					from #source1logs    
					where RwNo != 1  
        
			insert into #result1        
				select t1.UserId, @FromDate EventDate, t1.UserAccount, t1.ComputerName, t1.EventName as FromEvent, t1.EventTime FromTime,        
						t2.EventName as ToEvent, t2.EventTime as ToTime, t2.ReasonId ReasonId, t2.ReasonName BreakReason,        
						case when t2.EventTime is not null then datediff(s, t1.EventTime, t2.EventTime) else 0 end TimeSpent        
					from #source1logs t1        
						inner join #source2logs t2 on t1.RwNo = t2.RwNo and t1.UserAccount = t2.UserAccount  
  
			delete from #result1 where (FromEvent = ToEvent and ToEvent = 'Logoff')  
  
			delete from #result1 where FromTime = ToTime  
  
			/*select *  
				from #result1*/  
  
			update #result1  
				set ReasonId = 3, BreakReason = 'Break'  
				where  FromEvent = 'Logoff' and ToEvent = 'Logon'  
          
			update #lockevents set status=0 where status=1 and UserId = @selectedUser and EventTypeId in (1,0)        
        
			set @ltc = @ltc - 1          
		end          
          
		update #users          
			set status=0          
			where status=1 and UserId=@selectedUser

		set @tc=@tc-1        
	end        
        
	begin tran          
	begin try  
        
		merge DailyBreakSplitUp t        
		using #result1 s        
		on (s.UserId = t.UserId and s.EventDate = t.EventDate and s.FromEvent = t.FromEvent and s.FromTime = t.FromTime)        
		when matched then        
			update set t.FromEvent = s.FromEvent, t.FromTime = s.FromTime, t.ToEvent = s.ToEvent, t.ToTime = s.ToTime,        
			t.BreakReasonId = s.ReasonId, t.BreakReason = s.BreakReason, t.TimeSpent = s.TimeSpent        
		when not matched by target then        
			insert (UserId, EventDate, UserAccount, ComputerName, FromEvent, FromTime, ToEvent, ToTime, BreakReasonId, BreakReason, TimeSpent)        
				values (s.UserId, s.EventDate, s.UserAccount, s.ComputerName, s.FromEvent, s.FromTime, s.ToEvent, s.ToTime, s.ReasonId, s.BreakReason, s.TimeSpent)  
		;  
  
		commit      
        
	end try
	begin catch
	rollback
	      
	select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

	if ERROR_MESSAGE() like 'Violation of UNIQUE KEY%'
	begin  
		insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
			values ('EcholockBreakSplitJob Error',     
				convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				getdate(), 'EcholockBreakSplitJob', 'SQL Server')    
  
		insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
			values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
				'Error in EcholockBreakSplitJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				0, 'Y', getdate(), null, 1)
	end
	end catch        
	IF OBJECT_ID('tempdb..#result1') IS NOT NULL  drop table #result1  
	IF OBJECT_ID('tempdb..#source1logs') IS NOT NULL drop table #source1logs  
	IF OBJECT_ID('tempdb..#source2logs') IS NOT NULL drop table #source2logs        
	IF OBJECT_ID('tempdb..#breaklogs') IS NOT NULL  drop table #breaklogs        
	IF OBJECT_ID('tempdb..#lockevents') IS NOT NULL drop table #lockevents          
	IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users          
end
GO
/****** Object:  StoredProcedure [dbo].[EcholockDailyAppClassifyJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EcholockDailyAppClassifyJob]
(
	@CompanyId	INT,				-- Target Company Id      
	@UserId	NVARCHAR(128) = NULL,	-- Null, if for whole company      
	@FromDate	DATETIME,			-- UTC      
	@RefTime	TIME				-- Reference Time for calculation
)
AS      
BEGIN      
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;      
	SET NOCOUNT ON      

	IF OBJECT_ID('tempdb..#users') IS NOT NULL DROP TABLE #users
	IF OBJECT_ID('tempdb..#dailyAppUsage') IS NOT NULL  DROP TABLE #dailyAppUsage	
	IF OBJECT_ID('tempdb..#classifications') IS NOT NULL  DROP TABLE #classifications
	       
	CREATE TABLE #users      
	(      
		Id			INT IDENTITY(1,1),      
		UserId		NVARCHAR(128),
		PackageId	BIGINT,
		[status]	BIT DEFAULT(1)
	)
	
	 CREATE TABLE #dailyAppUsage
	(
		UsageDate		DATETIME,
		UserId			NVARCHAR(128),
		AppId			BIGINT,
		Classification	INT,
		Category		BIGINT
	)
      
	DECLARE @tc INT = 0, @selectedUser NVARCHAR(128), @ltc INT = 0
	DECLARE @currentUserId NVARCHAR(128)
	DECLARE @defpackage BIGINT

	SET @defpackage = (SELECT TOP 1 Id
			FROM Echolock.dbo.AppPackages(NOLOCK)
			WHERE CompanyId = @CompanyId AND IsDefault = 1)

	SELECT * INTO #classifications
		FROM Echolock.dbo.AppPackageClassification(NOLOCK)      
      
	if (@UserId IS NULL)      
	BEGIN      
		INSERT INTO #users (UserId, PackageId)
			SELECT u.UserId, CASE WHEN m.PackageId IS NOT NULL THEN m.PackageId ELSE @defpackage END
				FROM EchoLock.dbo.UserDetails(NOLOCK) u				
					LEFT OUTER JOIN Echolock.dbo.AppPackageMapping(NOLOCK) m
					ON u.UserId = m.UserId
				WHERE u.CompanyId = @CompanyId AND u.NTLoginName <> 'System' AND u.[Status] = 4
	END      
	ELSE      
	BEGIN        
		INSERT INTO #users (UserId, PackageId)
			SELECT u.UserId, CASE WHEN m.PackageId IS NOT NULL THEN m.PackageId ELSE @defpackage END
				FROM EchoLock.dbo.UserDetails(NOLOCK) u				
					LEFT OUTER JOIN Echolock.dbo.AppPackageMapping(NOLOCK) m
					ON u.UserId = m.UserId
				WHERE u.CompanyId = @CompanyId AND u.[Status] = 4
					AND u.NTLoginName <> 'System' AND u.UserId = @UserId
	END

	BEGIN TRY
		INSERT INTO #dailyAppUsage
			SELECT CurrentDate,UserId,AA.AppId,
			ISNULL(CASE WHEN AA.Classification IS NULL THEN cc.Classification ELSE aa.Classification END,3) AS Classification,
			ISNULL(CASE WHEN AA.Category IS NULL THEN cc.Category ELSE aa.Category END,1) AS category
			FROM
			(
				SELECT @FromDate AS CurrentDate, a.UserId, a.AppId,c.Classification,c.Category					
					FROM Echolock.dbo.DailyAppUsage(NOLOCK) a				
						INNER JOIN #users p
						ON a.UserId = p.UserId AND a.UsageDate = @FromDate
						LEFT JOIN #classifications c
						ON p.PackageId = c.PackageId AND a.AppId = c.AppId
			)AA
			LEFT JOIN #classifications CC 
			ON CC.AppId = AA.AppId AND AA.Classification IS NULL  AND CC.PackageId = 1 

		BEGIN TRAN		
			UPDATE t
				SET t.Classification = s.Classification, t.Category = s.Category
					FROM Echolock.dbo.DailyAppUsage(NOLOCK) t			
						INNER JOIN #dailyAppUsage(NOLOCK) s			
						ON t.UserId = s.UserId AND t.UsageDate = s.UsageDate AND t.AppId = s.AppId
		COMMIT
	END TRY
	BEGIN CATCH
		SELECT ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()       
		ROLLBACK			
			INSERT INTO echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)  
				VALUES ('EcholockDailyAppClassifyJob Error',
					CONVERT(VARCHAR, Error_Number()) + Error_Message() + CONVERT(VARCHAR, Error_Line()) + error_procedure(),  
					GETDATE(), 'EcholockDailyAppClassifyJob', 'SQL Server')  

			INSERT INTO ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)  
				VALUES ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',
					'Error in EcholockDailyAppClassifyJob', CONVERT(VARCHAR, Error_Number()) + Error_Message() + 
					CONVERT(VARCHAR, Error_Line()) + error_procedure(), 0, 'Y', GETDATE(), null, 1) 
	END CATCH

	IF OBJECT_ID('tempdb..#users') IS NOT NULL DROP TABLE #users
	IF OBJECT_ID('tempdb..#dailyAppUsage') IS NOT NULL  DROP TABLE #dailyAppUsage	
	IF OBJECT_ID('tempdb..#classifications') IS NOT NULL  DROP TABLE #classifications
END

GO
/****** Object:  StoredProcedure [dbo].[EcholockDailyAppUsageJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--======================================================================================      
--EcholockDailyAppUsageJob - Daily App Usage Job for Echolock by Company/ Individual
--======================================================================================      
--Created By	-  Promodh.Kumar      
--Created On	-  22/04/2019      
--Parameters	-  @CompanyId, @UserId, @FromDate, @RefTime      
--Notes			-  All App Usage Time Calculations are in UTC      
--======================================================================================      
--Modified By   -        
--Modified On   -        
--Modification Details -        
--======================================================================================      

CREATE PROCEDURE [dbo].[EcholockDailyAppUsageJob]        
(        
	@CompanyId INT,                                -- Target Company Id        
	@UserId      NVARCHAR(128) = null,   -- Null, if for whole company        
	@FromDate    DATETIME,                         -- UTC        
	@RefTime     TIME                              -- Reference Time for calculation  
)
        
AS        
BEGIN        
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;        
	SET NOCOUNT ON        
  
	IF OBJECT_ID('tempdb..#uniqueApps') IS NOT NULL drop table #uniqueApps  
	IF OBJECT_ID('tempdb..#uniqueUrls') IS NOT NULL  drop table #uniqueUrls     
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL drop table #dailylogs        
	IF OBJECT_ID('tempdb..#appWatcher') IS NOT NULL drop table #appWatcher        
	IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users  
	IF OBJECT_ID('tempdb..#Applogs') IS NOT NULL DROP TABLE #Applogs
         
	/* set @RefTime = '08:30:00' */  
	--declare @TimeZoneOffSet bigint=0        
	DECLARE @Bufferhours INT = 3        

	DECLARE @WeekEnd INT, @SqlQry VARCHAR(MAX),@wDate DATETIME
	SET @wDate = CONVERT(DATETIME,DATEADD(DAY,1,@FromDate))
	SELECT @WeekEnd =  CASE WHEN DATENAME(dw,@wDate) = 'Saturday' THEN  1 
	ELSE CASE WHEN DATENAME(dw,@wDate) = 'Sunday' THEN 1 ELSE 0  END END 

	create table #users        
	(        
		Id int identity(1,1),        
		UserId nvarchar(128),        
		ShiftId int,        
		FromTime datetime2,        
		ToTime datetime2,        
		ActualFromTime datetime2,        
		ActualToTime datetime2,       
		status bit default(1)        
	);        
        
	create table #appWatcher        
	(        
		Id bigint identity(1,1),        
		AppName varchar(500) null,        
		BaseUrl nvarchar(max) null,  
		TimeSpent bigint,        
		UserId nvarchar(128),        
		status bit default(1)  
	);  
        
	create table #dailylogs        
	(        
		Id bigint identity(1,1),        
		UserId nvarchar(128),        
		AppId bigint,  
		UsageDate datetime,  
		TimeSpentms bigint,  
		status bit default(1)  
	);

	create table #Applogs
	(        
		Id     bigint,
		UserId nvarchar(128),
		UserAccount   varchar(100),
		UserDomain    varchar(100),
		ComputerName  varchar(100),
		AppName       varchar(500),
		WindowTitle   varchar(500),
		BrowserUrl    nvarchar(max),
		StartTime     datetime2(7),
		EndTime       datetime2(7),
		TimeSpent     time(7),
		VersionId     varchar(100),
		CreatedOn     datetime2(7),
		OperatingSystem      varchar(100),
		BaseUrl       varchar(max),
		TimeSpentms   bigint
	) 
        
	declare @tc int = 0, @selectedUser nvarchar(128), @ltc int = 0        
	declare @ToDate datetime=dateadd(day,1,@FromDate)        
	declare @currentUserId nvarchar(128), @currentShiftTo datetime2, @currentShiftFrom datetime2    
        
	if (@UserId is null)        
	begin        
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)        
			select ud.UserId, ud.Shift,        
				dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
				else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
				DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
				else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
			from echolock.dbo.DailyDashboardData ud (nolock)      
			inner join echolock.dbo.LookupShift sft (nolock) on ud.Shift = sft.Id  
				inner join EchoLock.dbo.LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
			where ud.UserId in        
				(select UserId        
				from echolock.dbo.UserDetails with (nolock)        
				where CompanyId = @CompanyId)        
				--and ud.Status=4 /* To process for Active Users Only */  
				and ud.NTLoginName <> 'System'
					and ud.EventDate = @FromDate
	end        
	else        
	begin          
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)        
			select ud.UserId, ud.Shift,        
				dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
				else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
				DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
				else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
			from echolock.dbo.DailyDashboardData ud (nolock)      
			inner join echolock.dbo.LookupShift sft (nolock) on ud.Shift = sft.Id  
				inner join EchoLock.dbo.LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
			where ud.UserId = @UserId        
				--and ud.Status=4 /* To process for Active Users Only */  
				and ud.NTLoginName <> 'System'
				and ud.EventDate = @FromDate
	end      
        
	SELECT @tc = COUNT(*) FROM #users        
        
	WHILE @tc!=0        
	BEGIN        
		SELECT TOP 1 @selectedUser = UserId, @currentShiftFrom = ActualFromTime, @currentShiftTo = ActualToTime
		FROM #users        
		WHERE [status] = 1        
		--order by Id desc  
			TRUNCATE TABLE #Applogs
			IF @WeekEnd = 0 
			BEGIN    
				INSERT INTO #Applogs(Id,UserId,UserAccount,UserDomain,ComputerName,AppName,WindowTitle,
							BrowserUrl,StartTime,EndTime,TimeSpent,VersionId,CreatedOn,OperatingSystem,BaseUrl,TimeSpentms)
					SELECT Id,UserId,UserAccount,UserDomain,ComputerName,AppName,WindowTitle,
							BrowserUrl,StartTime,EndTime,TimeSpent,VersionId,CreatedOn,OperatingSystem,BaseUrl,TimeSpentms
						FROM echolock.dbo.AppWatcher(NOLOCK)
						WHERE UserId = @selectedUser 
							--AND StartTime >= @currentShiftFrom
							AND StartTime <=  @currentShiftTo
							AND EndTime >= @currentShiftFrom
							--AND EndTime <=  @currentShiftTo
			END
			IF @WeekEnd = 1
			BEGIN
                           
				INSERT INTO #Applogs(Id,UserId,UserAccount,UserDomain,ComputerName,AppName,WindowTitle,
								BrowserUrl,StartTime,EndTime,TimeSpent,VersionId,CreatedOn,OperatingSystem,BaseUrl,TimeSpentms)
					SELECT Id,UserId,UserAccount,UserDomain,ComputerName,AppName,WindowTitle,
							BrowserUrl,StartTime,EndTime,TimeSpent,VersionId,CreatedOn,OperatingSystem,BaseUrl,TimeSpentms
						FROM echolock.dbo.AppWatcher(NOLOCK)
						WHERE UserId = @selectedUser AND StartTime >= @currentShiftFrom AND StartTime <=  @currentShiftTo AND 
						EndTime >= @currentShiftFrom AND EndTime <=  @currentShiftTo
						UNION ALL
						SELECT Id,UserId,UserAccount,UserDomain,ComputerName,AppName,WindowTitle,
										BrowserUrl,StartTime,EndTime,TimeSpent,VersionId,CreatedOn,OperatingSystem,BaseUrl,TimeSpentms
						FROM echolock.dbo.AppWatcherarchive(NOLOCK)
						WHERE UserId = @selectedUser
							--AND StartTime >= @currentShiftFrom
							AND StartTime <=  @currentShiftTo
							AND EndTime >= @currentShiftFrom
							--AND EndTime <=  @currentShiftTo
			END    
			     
			;WITH CTE AS
			(
				SELECT *, ROW_NUMBER() OVER (PARTITION BY UserId,StartTime,AppName,BrowserUrl ORDER BY StartTime,ID) AS RNO
				FROM #Applogs
			)

			DELETE FROM CTE WHERE RNO > 1

			update #Applogs
				set StartTime = @currentShiftFrom
				where StartTime < @currentShiftFrom
		
			update #Applogs
				set EndTime = @currentShiftTo
				where EndTime > @currentShiftTo

			update #Applogs
				set TimeSpentms = DATEDIFF(MS, StartTime, EndTime)

			INSERT INTO #appWatcher    
				SELECT AppName, NULL, SUM(TimeSpentms), UserId, 1    
					FROM #Applogs        
					WHERE BaseUrl IS NULL AND AppName <> ''    
					GROUP BY UserId, AppName    
    
			INSERT INTO #appWatcher    
				SELECT NULL, BaseUrl, SUM(TimeSpentms), UserId, 1    
					FROM #Applogs
					WHERE BaseUrl IS NOT NULL AND BaseUrl <> ''    
					GROUP BY UserId, BaseUrl 
             
			UPDATE #users SET STATUS = 0          
				WHERE STATUS = 1 and UserId = @selectedUser          

			SET @tc = @tc - 1     

			TRUNCATE TABLE #Applogs      
	END  
		select distinct AppName  
			into #uniqueApps  
			from #appWatcher  
			(nolock)  
			where AppName is not null  
  
		select distinct BaseUrl  
			into #uniqueUrls  
			from #appWatcher  
			(nolock)  
			where BaseUrl is not null  
  
		begin try                  
			begin tran  
  
			insert into echolock.dbo.LookupApps  
				select a.AppName, null, null, getdate(), 1  
					from #uniqueApps a  
					(nolock)  
					where not exists (select 'x'  
							from echolock.dbo.LookupApps b  
							(nolock)  
							where b.AppName = a.AppName)  
  
			insert into echolock.dbo.LookupApps  
				select null, a.BaseUrl, null, getdate(), 1  
					from #uniqueUrls a  
					(nolock)  
					where not exists (select 'x'  
							from echolock.dbo.LookupApps b  
							(nolock)  
							where b.BaseUrl = a.BaseUrl)  
  
			insert into #dailylogs  
					select a.UserId, b.Id, @FromDate, a.TimeSpent, 1  
						from #appWatcher a  
						(nolock)  
						inner join echolock.dbo.LookupApps b on a.AppName = b.AppName   
								and b.AppName is not null and a.AppName is not null  
  
			insert into #dailylogs  
					select a.UserId, b.Id, @FromDate, a.TimeSpent, 1  
						from #appWatcher a  
						(nolock)
						inner join echolock.dbo.LookupApps b on a.BaseUrl = b.BaseUrl
							and b.BaseUrl is not null and a.BaseUrl is not null
  
			merge echolock.dbo.DailyAppUsage t      
			using #dailylogs s   
			on (s.UserId = t.UserId and s.UsageDate = t.UsageDate
			and s.AppId = t.AppId)  
			when matched then      
				update set t.TimeSpentms = s.TimeSpentms, t.Classification = 3, t.Category = 1
			when not matched by target then      
				insert (UserId, UsageDate, AppId, TimeSpentms, Classification, Category)  
					values (s.UserId, s.UsageDate, s.AppId, s.TimeSpentms, 3, 1)
			;  
  
			commit
  
		end try  
		begin catch
		  
			select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()
			                
			rollback

			if ERROR_MESSAGE() not like 'Violation of UNIQUE KEY%'
			begin  
				insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
				values ('EcholockDailyAppUsageJob Error',     
				convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				getdate(), 'EcholockDailyAppUsageJob', 'SQL Server')    
  
				insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
				values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
				'Error in EcholockDailyAppUsageJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				0, 'Y', getdate(), null, 1)   

			end
  
  
	END CATCH  
  
	IF OBJECT_ID('tempdb..#uniqueApps') IS NOT NULL drop table #uniqueApps  
	IF OBJECT_ID('tempdb..#uniqueUrls') IS NOT NULL  drop table #uniqueUrls     
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL drop table #dailylogs        
	IF OBJECT_ID('tempdb..#appWatcher') IS NOT NULL drop table #appWatcher        
	IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users  
	IF OBJECT_ID('tempdb..#Applogs') IS NOT NULL DROP TABLE #Applogs
  
	EXEC Echolock.dbo.EcholockDailyAppClassifyJob @CompanyId, @UserId, @FromDate, @RefTime  
END
GO
/****** Object:  StoredProcedure [dbo].[EcholockDailyCallUsageJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*--======================================================================================        
--EcholockDailyEventJob - Daily Event Job for Echolock by Company/ Individual        
--======================================================================================        
--Created By   -  Promodh.Kumar        
--Created On   -  26/02/2019        
--Parameters   -  @CompanyId, @UserId, @FromDate, @RefTime        
--Notes     -  All Lock Event Time Calculations are in UTC        
--======================================================================================        
--Modified By   -    Promodh.Kumar  
--Modified On   -    24/072019  
--Modification Details -   Modified to calculate Break Duration using Break Split Job Logic & Valid Lock Events only  
--======================================================================================
*/  
        
CREATE Proc [dbo].[EcholockDailyCallUsageJob]        
(        
	@CompanyId int,       -- Target Company Id
	@UserId nvarchar(128) = null,   -- Null, if for whole company
	@FromDate datetime,      -- UTC
	@RefTime time       -- Reference Time for calculation
)

as        
begin        
	set transaction Isolation level read uncommitted;        
	set nocount on  
	IF OBJECT_ID('tempdb..#users') IS NOT NULL  drop table #users
         
	--set @RefTime = '08:30:00'        
	--declare @TimeZoneOffSet bigint=0        
	declare @Bufferhours int=3        
        
	create table #users
	(
		Id int identity(1,1),
		UserId nvarchar(128),
		ShiftId int,
		FromTime datetime,
		ToTime datetime,
		status bit default(1)
	);

	declare @tc int = 0, @selectedUser nvarchar(128), @ltc int = 0
	declare @ToDate datetime=dateadd(day,1,@FromDate)
	declare @currentUserId nvarchar(128), @currentShiftTo datetime, @currentShiftFrom datetime
        
	if (@UserId is null)        
	begin        
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)        
			select distinct ud.UserId, ud.Shift,        
				dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
				else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
				DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
				else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
			from Echolock.dbo.DailyDashboardData ud (nolock)
				inner join LookupShift sft (nolock) on ud.Shift = sft.Id
				inner join LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id
			where ud.UserId in
					(select UserId
						from UserDetails with (nolock)
						where CompanyId = @CompanyId)
					--and ud.Status=4 -- To process for Active Users Only
					and ud.NTLoginName <> 'System'
					and ud.EventDate = @FromDate
	end        
	else        
	begin          
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)        
			select distinct ud.UserId, ud.Shift,        
				dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
				else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
				DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
				else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)       
			from Echolock.dbo.DailyDashboardData ud (nolock)      
				inner join LookupShift sft (nolock) on ud.Shift = sft.Id  
				inner join LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
			where ud.UserId = @UserId        
				--and ud.Status=4 -- To process for Active Users Only        
				and ud.NTLoginName <> 'System'
				and ud.EventDate = @FromDate
	end
        
	select @tc = count(*) from #users        
        
	while @tc!=0        
	begin        
		set @selectedUser = (select top 1 UserId
				from #users     
				where status=1     
				order by Id desc)
        
		update #users        
				set status=0        
			where status=1 and UserId=@selectedUser

		set @tc = @tc - 1
	end        
        
	begin try 
		begin tran
	
		commit
	end try    
	begin catch
	     
		rollback

		select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

		if ERROR_MESSAGE() not like 'Violation of UNIQUE KEY%'
		begin
			insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)
				values ('EcholockDailyEventJob Error',
					convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
					getdate(), 'EcholockDailyEventJob', 'SQL Server')
  
			insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)
				values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',
					'Error in EcholockDailyEventJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
					0, 'Y', getdate(), null, 1)
		end
	   
	end catch

	IF OBJECT_ID('tempdb..#users') IS NOT NULL  drop table #users
end
GO
/****** Object:  StoredProcedure [dbo].[EcholockDailyDashboardDataJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:           Promodh Kumar  
-- Create date: 01/08/2019  
-- Description:      Echolock Improvement Analytics Dashboard Data Calculation  
-- =============================================  
--Modified By              -      Promodh.Kumar
--Modified On              -      07/02/2020
--Modification Details     -      Added CostCode & Process
--======================================================================================
CREATE PROCEDURE [dbo].[EcholockDailyDashboardDataJob]  
       @CompanyId int,  
       @UserId nvarchar(128), -- will be null, if for manager  
       @ManagerId nvarchar(128), -- will be null, if for individual user  
       @IncludeIndirect bit, -- whether to include indirect reports or not  
       @OnlyWorkDays bit, -- whether to calculate for workdays only or based on people's presence  
       @Date datetime,  
       @UpdateHistory bit = 0  
AS  
BEGIN  
	-- SET NOCOUNT ON added to prevent extra result sets from  
	-- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	declare @companyAppWatcher bit = 0  
  
	IF OBJECT_ID('tempdb..#DashboardData') IS NOT NULL  drop table #DashboardData  
	IF OBJECT_ID('tempdb..#UserDetails') IS NOT NULL  drop table #UserDetails  
  
	create table #DashboardData  
	(  
		EventDate datetime,  
		UserId nvarchar(128),  
		TotalHours bigint,  
		WorkHours bigint,  
		LockHours bigint,  
		ProdHrs float(2),  
		NonProdHrs float(2),  
		UnClassifiedHrs float(2),
		LateInHours int,
		AdvanceOutHours int,
		TargetTotal int
	);
  
	begin try       
		insert into #DashboardData  
			exec Echolock.[dbo].[EcholockImprovementAnalytics] @CompanyId, @UserId, @ManagerId, @IncludeIndirect, @OnlyWorkDays, @Date, @Date  
  
		begin tran  
                
		merge Echolock.dbo.DailyDashboardData t  
		using #DashboardData s  
		on (t.EventDate = s.EventDate and t.UserId = s.UserId)  
		when matched then  
			update set t.TotalHours = s.TotalHours, t.WorkHours = s.WorkHours, t.LockHours = s.LockHours,  
				t.ProdHrs = round(s.ProdHrs, 3), t.NonProdHrs = round(s.NonProdHrs, 3), t.UnClassifiedHrs = round(s.UnClassifiedHrs, 3),
				t.LateInHours = s.LateInHours, t.AdvanceOutHours = s.AdvanceOutHours, t.TargetTotal = s.TargetTotal,
				t.IsLate = case when s.LateInHours > 0 then 1 else 0 end,
				t.IsAdvanceOut = case when s.AdvanceOutHours > 0 then 1 else 0 end,
				t.IsWeekend = case when datepart(dw, s.EventDate) in (1,7) then 1 else 0 end
		;
		commit
  
	end try  
	begin catch  
		rollback  
  
		select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

		if ERROR_MESSAGE() not like 'Violation of UNIQUE KEY%'
		begin  
			insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
				values ('EcholockDailyDashboardDataJob Error',     
					convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
					getdate(), 'EcholockDailyDashboardDataJob', 'SQL Server')  
  
			insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
				values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
					'Error in EcholockDailyDashboardDataJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
					0, 'Y', getdate(), null, 1)
		end
  
	end catch
  
	IF OBJECT_ID('tempdb..#UserDetails') IS NOT NULL  drop table #UserDetails  
	IF OBJECT_ID('tempdb..#DashboardData') IS NOT NULL  drop table #DashboardData  
  
END
GO
/****** Object:  StoredProcedure [dbo].[EcholockDailyDashboardIdleJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:           Promodh Kumar  
-- Create date: 01/08/2019  
-- Description:      Echolock Improvement Analytics Dashboard Data Calculation  
-- =============================================  
--Modified By              -      Promodh.Kumar
--Modified On              -      07/02/2020
--Modification Details     -      Added CostCode & Process
--======================================================================================
CREATE PROCEDURE [dbo].[EcholockDailyDashboardIdleJob] 
       @CompanyId int,
       @UserId nvarchar(128), -- will be null, if for manager
       @Date datetime
AS  
BEGIN  
       -- SET NOCOUNT ON added to prevent extra result sets from  
       -- interfering with SELECT statements.  
       SET NOCOUNT ON;  
  
    declare @companyAppWatcher bit = 0  
  
       IF OBJECT_ID('tempdb..#DashboardData') IS NOT NULL  drop table #DashboardData  
       IF OBJECT_ID('tempdb..#UserDetails') IS NOT NULL  drop table #UserDetails  
  
		create table #DashboardData  
		(  
              EventDate datetime,  
              UserId nvarchar(128),
              WorkHours bigint,
              NonProdHrs float(2),
			  DiffHrs float(2),
			  IdleHrs float(2),
			  IdleHrsms bigint
		);
  
       begin try
              insert into #DashboardData  (EventDate, UserId, WorkHours, NonProdHrs, DiffHrs, IdleHrs, IdleHrsms)
                     select dda.EventDate, dda.UserId, dda.WorkHours, dda.NonProdHrs,
							DDA.WorkHours - (DDA.ProdHrs+DDA.NonProdHrs+DDA.UnClassifiedHrs) DiffHrs,
							ISNULL(NULLIF((cast(DAU.TimeSpentms as float(2))/1000),0),0) IdleHrs,
							ISNULL(NULLIF((DAU.TimeSpentms),0),0) IdleHrsms
						from Echolock.dbo.DailyDashboardData dda
						(nolock)
						left join Echolock.dbo.DailyAppUsage dau
						(nolock)
							on dda.UserId = dau.UserId and dda.EventDate = dau.UsageDate and dau.AppId = 14
						where dda.EventDate = @Date
							and (dda.UserId = case when @UserId is not null then @UserId else dda.UserId end)
							and dda.WorkHours > (dda.ProdHrs + dda.NonProdHrs + dda.UnClassifiedHrs)
							and dda.WorkHours > 0
  
              begin tran  
                
              merge Echolock.dbo.DailyDashboardData t  
              using #DashboardData s  
              on (t.EventDate = s.EventDate and t.UserId = s.UserId)
              when matched then  
                     update set t.NonProdHrs = CASE WHEN s.DiffHrs < s.IdleHrs THEN s.NonProdHrs + s.DiffHrs ELSE s.NonProdHrs + s.IdleHrs END
			  ;

			  merge Echolock.dbo.DailyAppUsage t  
              using #DashboardData s  
              on (t.UsageDate = s.EventDate and t.UserId = s.UserId and t.AppId = 95635)  
              when matched then  
                     update set t.TimeSpentms = cast(CASE WHEN (s.DiffHrs * 1000) < s.IdleHrsms THEN (s.DiffHrs * 1000) ELSE s.IdleHrsms END as bigint),
							t.Category = 14, t.Classification = 2
			  when not matched then
				insert (UserId, UsageDate, AppId, TimeSpentms, Classification, Category)
					values (s.UserId, s.EventDate, 95635, cast(CASE WHEN (s.DiffHrs * 1000) < s.IdleHrsms THEN (s.DiffHrs * 1000) ELSE s.IdleHrsms END as bigint), 2, 14)
			  ;

              commit
  
       end try  
       begin catch  
              rollback  
  
              --select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()  
  
              insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
                     values ('EcholockDailyDashboardIdleJob Error',     
                     convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
                     getdate(), 'EcholockDailyDashboardIdleJob', 'SQL Server')  
  
              insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
                     values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
                     'Error in EcholockDailyDashboardIdleJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
                     0, 'Y', getdate(), null, 1)   
  
       end catch
  
       IF OBJECT_ID('tempdb..#UserDetails') IS NOT NULL  drop table #UserDetails  
       IF OBJECT_ID('tempdb..#DashboardData') IS NOT NULL  drop table #DashboardData  
  
END

GO
/****** Object:  StoredProcedure [dbo].[EcholockDailyEventBreakSplitJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
--======================================================================================          
--EcholockBreakSplitJob - Break Split up Job for Echolock by Company/ Individual        
--======================================================================================          
--Created By   -  Promodh.Kumar          
--Created On   -  04/03/2019        
--Parameters   -  @CompanyId, @UserId, @FromDate, @RefTime          
--Notes     -  All Lock Event Time Calculations are in UTC          
--======================================================================================          
--Modified By   -    Promodh.Kumar  
--Modified On   -    24/072019  
--Modification Details -   Modified to calculate Break-Split only within shift hours & Valid Lock Events only  
--======================================================================================  
*/  
          
CREATE Proc [dbo].[EcholockDailyEventBreakSplitJob]        
(          
 @CompanyId int,       -- Target Company Id          
 @UserId nvarchar(128) = null,   -- Null, if for whole company          
 @FromDate datetime,      -- UTC          
 @RefTime time       -- Reference Time for calculation       
)          
          
as          
begin          
	set transaction Isolation level read uncommitted;          
	set nocount on          
           
	IF OBJECT_ID('tempdb..#resultbreaklogs') IS NOT NULL  drop table #resultbreaklogs  
	IF OBJECT_ID('tempdb..#source1logs') IS NOT NULL drop table #source1logs  
	IF OBJECT_ID('tempdb..#source2logs') IS NOT NULL drop table #source2logs        
	IF OBJECT_ID('tempdb..#breaklogs') IS NOT NULL  drop table #breaklogs        
	IF OBJECT_ID('tempdb..#lockevents') IS NOT NULL drop table #lockevents          
	IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users
	IF OBJECT_ID('tempdb..#resultdailyeventslogs') IS NOT NULL  drop table #resultdailyeventslogs
	IF OBJECT_ID('tempdb..#TempDailyEvents') IS NOT NULL  drop table #TempDailyEvents  
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL  drop table #dailylogs
          
	create table #users          
	(          
		Id int identity(1,1),          
		UserId nvarchar(128),          
		ShiftId int,          
		FromTime datetime,          
		ToTime datetime,          
		ActualFromTime datetime,          
		ActualToTime datetime,          
		status bit default(1)          
	);          
          
	create table #lockevents          
	(          
		Id bigint identity(1,1),          
		EventTypeId int,          
		ShiftId int,          
		EventTime datetime,          
		UserId nvarchar(128),          
		AFromTime datetime,          
		AToTime datetime,        
		ReasonId int,        
		UserAccount varchar(100),        
		ComputerName varchar(100),        
		status bit default(1)          
	);          
          
	create table #breaklogs        
	(        
		UserId nvarchar(128),        
		EventTypeId int,        
		EventName varchar(100),        
		EventTime datetime,        
		UserAccount varchar(100),        
		ComputerName varchar(100),        
		ReasonId int,        
		ReasonName varchar(100)        
	);        
        
	create table #source1logs        
	(        
		RwNo int,        
		UserId nvarchar(128),        
		UserAccount varchar(100),        
		ComputerName varchar(100),        
		EventTime datetime,        
		EventName varchar(100),        
		ReasonName varchar(100),        
		ReasonId int,
		EventId int
	);        
        
	create table #source2logs        
	(        
		RwNo int,        
		UserId nvarchar(128),        
		UserAccount varchar(100),        
		EventTime datetime,        
		EventName varchar(100),        
		ReasonName varchar(100),        
		ReasonId int,        
		EventId int
	);        
        
	create table #resultbreaklogs        
	(        
		UserId nvarchar(128),        
		EventDate datetime,        
		UserAccount varchar(100),        
		ComputerName varchar(100),        
		FromEvent varchar(100),        
		FromTime datetime,        
		ToEvent varchar(100),        
		ToTime datetime,        
		ReasonId int,        
		BreakReason varchar(100),        
		TimeSpent bigint,        
	);

	create table #resultdailyeventslogs
	(        
		UserId nvarchar(128),        
		EventDate datetime,  
		FromEvent int,        
		FromTime datetime,        
		ToEvent int,  
		ToTime datetime,     
		TimeSpent bigint  
	);
	
	create table #dailylogs        
	(        
		Id bigint identity(1,1),        
		UserId nvarchar(128),        
		ShiftId int,        
		LoginDate datetime,        
		LogoutDate datetime,        
		TotalSeconds bigint default(0),        
		WorkSeconds bigint default(0),        
		BreakSeconds bigint default(0),        
		ActualLogin datetime,        
		ActualLogout datetime,        
		LateInTime time,        
		AdvanceOutTime time,        
		IsLatein bit,        
		status bit default(1)        
	);      
      
	create table #TempDailyEvents      
	(      
		UserId nvarchar(128),      
		UserAccount varchar(500),      
		EmployeeCode varchar(100),      
		ManagerL1 varchar(100),      
		ManagerL2 varchar(100),      
		Date datetime,      
		ShiftId int,      
		Login datetime,      
		Logout datetime,      
		TotalHrs float,      
		WorkHours float,      
		LockHrs float,      
		Role varchar(100),      
		CreatedOn datetime,      
		ShiftFrom time(7),      
		ShiftTo time(7),      
		ClientId int,      
		ShiftLogOn datetime,      
		ShiftLogOut datetime,      
		LateIn time(7),      
		AdvanceOut time(7),      
		IsLate int,      
		PresentDayStaus int      
	);         
        
	declare @tc int = 0, @selectedUser nvarchar(128), @ltc int = 0          
	declare @ToDate datetime=dateadd(day,1,@FromDate)          
	declare @currentUserId nvarchar(128), @currentShiftTo datetime, @currentShiftFrom datetime          
	declare @duration int=0, @mtc int=0, @workduration int = 0
	declare @refstartdate datetime, @refenddate datetime, @refstartid bigint, @refstarteventtype int, @refendeventtype int          
	declare @actuallogin datetime, @actuallogout datetime          
          
          
	---- Get Company TimeZone for Shift Calculation in UTC          
	--if(@UserId is null)          
	--begin          
	-- select @TimeZoneOffSet = CurrentUTCOffset          
	--  from CompanyAppSettings a          
	--   inner join LookupTimeZone b on a.TimeZoneId = b.Id          
	--  where a.CompanyId = @CompanyId          
	--end          
	--else          
	--begin          
	-- select @TimeZoneOffSet = CurrentUTCOffset          
	--  from UserDetails ud          
	--   inner join CompanyAppSettings a on ud.CompanyId = a.CompanyId          
	--   inner join LookupTimeZone b on a.TimeZoneId = b.Id        
	--  where ud.UserId = @UserId          
	--end          
          
	if (@UserId is null)          
	begin          
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)          
		select distinct ud.UserId, ud.Shift,          
			dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
			else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
			DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
			else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
		from DailyDashboardData ud (nolock)        
		inner join LookupShift sft (nolock) on ud.Shift = sft.Id  
			inner join LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
		where ud.UserId in          
			(select UserId          
			from UserDetails with (nolock)          
			where CompanyId = @CompanyId)          
			--and ud.Status=4 -- To process for Active Users Only          
			and ud.NTLoginName <> 'System'
			and ud.EventDate = @FromDate        
	end          
	else          
	begin            
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)          
		select distinct ud.UserId, ud.Shift,          
			dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
			else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
			DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
			else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
		from DailyDashboardData ud (nolock)        
		inner join LookupShift sft (nolock) on ud.Shift = sft.Id  
			inner join LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
		where ud.UserId = @UserId          
			--and ud.Status=4 -- To process for Active Users Only          
			and ud.NTLoginName <> 'System'
			and ud.EventDate = @FromDate
	end        
          
	select @tc = count(*) from #users          
          
	while @tc!=0          
	begin          
		set @selectedUser = (select top 1 UserId          
		from #users          
		where status=1          
		order by Id desc)          
          
		insert into #lockevents (UserId, EventTime, EventTypeId, ShiftId, AFromTime, AToTime, UserAccount, ComputerName, ReasonId)          
			select le.UserId, le.EventTime, le.EventTypeId, ud.ShiftId, ud.ActualFromTime, ud.ActualToTime, le.UserAccount, le.ComputerName, le.ReasonId        
			from LockEvents le (nolock)          
				inner join #users ud on le.UserId=ud.UserId          
			where le.EventTime >=ud.FromTime          
				and le.EventTime <= ud.ToTime          
				and le.EventTypeId not in (4,10,12)          
				and le.UserId = @selectedUser        
						and le.EventStatus = 1 /* Added for processing only Valid Lock Events */  
			order by le.EventTime          
            
		set @ltc = (select count(distinct UserId)          
			from #lockevents (nolock)          
			where UserId = @selectedUser)          
          
		while (@ltc!=0)          
		begin  
			select top 1 @currentUserId = UserId, @currentShiftTo = AToTime, @currentShiftFrom = AFromTime        
				from #lockevents (nolock)        
				where status = 1        
				order by Id desc
				
			-- First Login/ Connect/ Unlock Time of the day        
			set @actuallogin = (select min(EventTime)        
				from #lockevents (nolock)        
				where status=1 and UserId = @currentUserId  
				/*and EventTypeId in (1,3,5)*/  
				)  
        
			-- Last Logout/ Disconnect/ Lock Time of the day        
			set @actuallogout = (select max(EventTime)        
				from #lockevents (nolock)        
				where status=1 and UserId = @currentUserId  
				/*and EventTypeId in (0,2,6)*/  
				)

			insert into #dailylogs (ShiftId, UserId, LoginDate, LogoutDate, WorkSeconds, BreakSeconds, TotalSeconds, ActualLogin, ActualLogout)        
				select ShiftId, UserId, LoginDate, LogoutDate, 0, 0,  
						case when datediff(second,       
						case when @actuallogin > LoginDate then @actuallogin else LoginDate end,       
						case when LogoutDate > @actuallogout then @actuallogout else LogoutDate end      
						) < 0 then 0 else DATEDIFF(second,       
						case when @actuallogin > LoginDate then @actuallogin else LoginDate end,       
						case when LogoutDate > @actuallogout then @actuallogout else LogoutDate end      
						) end, @actuallogin, @actuallogout        
					from (        
						select ShiftId, UserId, (case when min(le.EventTime) < min(le.AFromTime)        
								then min(le.AFromTime) else min(le.EventTime) end) as LoginDate,        
								(case when max(le.EventTime) > max(le.AToTime)        
								then max(le.AToTime) else max(le.EventTime) end) as LogoutDate        
							from #lockevents le  
							where UserId = @currentUserId and status=1        
							group by UserId, ShiftId        
				) as temp1

			set @duration = 0
			set @mtc = 0
  
				/* --- Added to calculate within shift hours ---*/  
  
			/*Update eventtime for event, before the shift start time and after the shift end time*/  
			update #lockevents set EventTime = @currentShiftFrom        
				where EventTime in (select top 1 EventTime        
					from #lockevents        
					where UserId = @currentUserId        
					and EventTime <= @currentShiftFrom        
					order by EventTime desc)  
  
			update #lockevents set EventTime = @currentShiftTo        
				where EventTime in (select top 1 EventTime        
					from #lockevents        
					where UserId = @currentUserId        
					and EventTime >= @currentShiftTo  
					order by EventTime asc)  
          
			delete from #lockevents        
				where UserId = @currentUserId        
					and (EventTime > @currentShiftTo or EventTime < @currentShiftFrom)        
        
			delete from #lockevents        
				where UserId = @currentUserId        
					and EventTime < @currentShiftFrom   

			set @mtc = (select count(*)        
				from #lockevents        
				where UserId = @currentUserId        
					and EventTypeId in (2,0,6)        
					and status = 1 and EventTime < @currentShiftTo)        
        
			set @refstartdate = (select top 1 EventTime         
				from #lockevents        
				where EventTypeId in (1,3,10) and status=1 and UserId = @currentUserId        
				order by EventTime)
					/* --- Added to calculate within shift hours ---*/  
          
			insert into #breaklogs (UserId, EventTypeId, EventTime, UserAccount, ComputerName, ReasonId, EventName, ReasonName)         
				select distinct le.UserId, le.EventTypeId, EventTime, UserAccount, ComputerName, ReasonId, evt.EventName, br.BreakReason        
					from #lockevents  le (nolock)        
						inner join LookupBreakReason br on le.ReasonId = br.Id        
						inner join LookupEventType evt on evt.EventTypeId = le.EventTypeId        
					where le.EventTypeId in (0,1,2,3,5,6)        
						and le.UserId = @selectedUser        
						and le.status = 1        
					order by le.UserAccount, le.EventTime  
  
			update #breaklogs  
				set ReasonId = 3, ReasonName = 'Break'  
				where EventTypeId = 5  
        
			delete from #source1logs        
			delete from #source2logs        
        
			insert into #source1logs (RwNo, UserId, UserAccount, EventTime, EventId, EventName, ReasonName, ComputerName, ReasonId)        
				select row_number() over(partition by UserAccount order by UserAccount, EventTime) RwNo, UserId, UserAccount, EventTime, EventTypeId, EventName, ReasonName, ComputerName, ReasonId        
					from #breaklogs        
					where UserId = @selectedUser        
        
			insert into #source2logs (RwNo, UserId, UserAccount, EventTime, EventId, EventName, ReasonName, ReasonId)   
				select row_number() over(partition by UserAccount order by UserAccount, EventTime) RwNo, UserId, UserAccount, EventTime, EventId, EventName, ReasonName, ReasonId        
					from #source1logs    
					where RwNo != 1  
        
			insert into #resultbreaklogs        
				select t1.UserId, @FromDate EventDate, t1.UserAccount, t1.ComputerName, t1.EventName as FromEvent, t1.EventTime FromTime,        
						t2.EventName as ToEvent, t2.EventTime as ToTime, t2.ReasonId ReasonId, t2.ReasonName BreakReason,        
						case when t2.EventTime is not null then datediff(s, t1.EventTime, t2.EventTime) else 0 end TimeSpent        
					from #source1logs t1        
						inner join #source2logs t2 on t1.RwNo = t2.RwNo and t1.UserAccount = t2.UserAccount  
  
			delete from #resultbreaklogs where (FromEvent = ToEvent and ToEvent = 'Logoff')  
  
			delete from #resultbreaklogs where FromTime = ToTime  
  
			/*select *  
				from #resultbreaklogs*/

			select @duration = sum(TimeSpent) from #resultdailyeventslogs  
					where ToEvent in (1,3,5,10)
						and UserId = @currentUserId
  
			select @workduration = sum(TimeSpent) from #resultdailyeventslogs  
					where ToEvent not in (1,3,5,10)
						and UserId = @currentUserId

			update #dailylogs set BreakSeconds = isnull(@duration, 0) where UserId = @currentUserId  
			update #dailylogs set WorkSeconds = isnull(@workduration, 0) where UserId = @currentUserId  
			update #dailylogs set TotalSeconds = WorkSeconds + BreakSeconds where UserId = @currentUserId
  
			update #resultbreaklogs  
				set ReasonId = 3, BreakReason = 'Break'  
				where  FromEvent = 'Logoff' and ToEvent = 'Logon'  
          
			update #lockevents set status=0 where status=1 and UserId = @selectedUser and EventTypeId in (1,0)        
        
			set @ltc = @ltc - 1          
		end          
          
		update #users          
			set status=0          
			where status=1 and UserId=@selectedUser

		set @tc=@tc-1        
	end

	update dl set dl.IsLatein= (case when (dl.LoginDate > usrs.ActualFromTime) or (usrs.ActualToTime > dl.LogoutDate) then 1 else 0 end),        
		dl.LateInTime = (case when (dl.LoginDate > usrs.ActualFromTime) then convert(time, dl.LoginDate - usrs.ActualFromTime) else '00:00:00.000' end),        
		dl.AdvanceOutTime = (case when ((usrs.ActualToTime > dl.LogoutDate) and (dl.LogoutDate > usrs.ActualFromTime)) then convert(time, usrs.ActualToTime - dl.LogoutDate) else '00:00:00.000' end),      
		dl.LoginDate = (case when dl.TotalSeconds<=0 then null else dl.LoginDate end),      
		dl.LogoutDate = (case when dl.TotalSeconds<=0 then null else dl.LogoutDate end),      
		dl.BreakSeconds = (case when dl.TotalSeconds<=0 then 0 else dl.BreakSeconds end)      
	from #dailylogs dl        
		inner join #users usrs on dl.UserId = usrs.UserId      
      
	update #dailylogs set WorkSeconds = case when (TotalSeconds - BreakSeconds) < 0 then 0 else (TotalSeconds - BreakSeconds) end

	begin try      
	begin tran          
		insert into #TempDailyEvents (UserId, UserAccount, EmployeeCode, ManagerL1, ManagerL2, Date, ShiftId,         
				Login, Logout, TotalHrs, WorkHours, LockHrs, Role, CreatedOn, ShiftFrom, ShiftTo,         
				ClientId, ShiftLogOn, ShiftLogOut, LateIn, AdvanceOut, IsLate, PresentDayStaus)        
				select ud.UserId, ud.NTLoginName, ud.EmployeeCode, ud.ManagerL1, ud.ManagerL2, @FromDate, ud.Shift,        
				dl.ActualLogin, dl.ActualLogout, dl.TotalSeconds, dl.WorkSeconds, dl.BreakSeconds, ud.Role, getdate(), sft.WorkStartTime, sft.WorkEndTime,        
				ud.CompanyId,dl.LoginDate, dl.LogoutDate, dl.LateInTime,dl.AdvanceOutTime, dl.IsLatein, 1        
			from #dailylogs dl        
				inner join UserDetails ud on dl.UserId = ud.UserId        
				inner join LookupShift sft on ud.Shift = sft.Id        
				inner join Users usr on ud.UserId = usr.UserId      
      
		-- Entries for Users, on absent/ holiday      
		insert into #TempDailyEvents (UserId, UserAccount, EmployeeCode, ManagerL1, ManagerL2, Date, ShiftId,         
				Login, Logout, TotalHrs, WorkHours, LockHrs, Role, CreatedOn, ShiftFrom, ShiftTo,         
				ClientId, ShiftLogOn, ShiftLogOut, LateIn, AdvanceOut, IsLate, PresentDayStaus)      
				select ud.UserId, ud.NTLoginName, ud.EmployeeCode, ud.ManagerL1, ud.ManagerL2, @FromDate, ud.Shift,      
					null, null, 0, 0, 0, ud.Role, getdate(), sft.WorkStartTime, sft.WorkEndTime, ud.CompanyId,      
					null, null, '00:00:00.000', '00:00:00.000', 0, 7      
			from #users usrs      
				inner join UserDetails ud on usrs.UserId = ud.UserId      
				inner join LookupShift sft on usrs.ShiftId = sft.Id      
			where usrs.UserId not in (      
				select distinct UserId      
				from #TempDailyEvents      
			)
        
		merge DailyEvents t      
		using #TempDailyEvents s      
		on (s.UserId = t.UserId and s.Date = t.Date)      
		when matched then      
			update set t.UserAccount = s.UserAccount, t.EmployeeCode = s.EmployeeCode, t.ManagerL1 = s.ManagerL1, t.ManagerL2 = s.ManagerL2, t.ShiftId = s.ShiftId,      
				t.Login = s.Login, t.Logout = s.Logout, t.TotalHrs = s.TotalHrs, t.WorkHours = s.WorkHours, t.LockHrs = s.LockHrs, t.Role = s.Role,      
				t.CreatedOn = s.CreatedOn, t.ShiftFrom = s.ShiftFrom, t.ShiftTo = s.ShiftTo, t.ClientId = s.ClientId, t.ShiftLogOn = s.ShiftLogOn,      
				t.ShiftLogout = s.ShiftLogout, t.LateIn = s.LateIn, t.AdvanceOut = s.AdvanceOut, t.IsLate = s.IsLate, t.PresentDayStaus = s.PresentDayStaus      
		when not matched by target then      
			insert (UserId, UserAccount, EmployeeCode, ManagerL1, ManagerL2, Date, ShiftId,         
					Login, Logout, TotalHrs, WorkHours, LockHrs, Role, CreatedOn, ShiftFrom, ShiftTo,         
					ClientId, ShiftLogOn, ShiftLogOut, LateIn, AdvanceOut, IsLate, PresentDayStaus)      
				values (s.UserId, s.UserAccount, s.EmployeeCode, s.ManagerL1, s.ManagerL2, s.Date, s.ShiftId,         
					s.Login, s.Logout, s.TotalHrs, s.WorkHours, s.LockHrs, s.Role, s.CreatedOn, s.ShiftFrom, s.ShiftTo,         
					s.ClientId, s.ShiftLogOn, s.ShiftLogOut, s.LateIn, s.AdvanceOut, s.IsLate, s.PresentDayStaus)      
		;      
		commit      
     
	end try        
	begin catch   
	     
	rollback      

	select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

	if ERROR_MESSAGE() not like 'Violation of UNIQUE KEY%'
	begin
		insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
			values ('EcholockDailyEventJob Error',     
				convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				getdate(), 'EcholockDailyEventJob', 'SQL Server')    
  
		insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
			values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
				'Error in EcholockDailyEventJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				0, 'Y', getdate(), null, 1)
	end
	   
	end catch
        
	begin tran          
	begin try  
        
		merge DailyBreakSplitUp t        
		using #resultbreaklogs s        
		on (s.UserId = t.UserId and s.EventDate = t.EventDate and s.FromEvent = t.FromEvent and s.FromTime = t.FromTime)        
		when matched then        
			update set t.FromEvent = s.FromEvent, t.FromTime = s.FromTime, t.ToEvent = s.ToEvent, t.ToTime = s.ToTime,        
			t.BreakReasonId = s.ReasonId, t.BreakReason = s.BreakReason, t.TimeSpent = s.TimeSpent        
		when not matched by target then        
			insert (UserId, EventDate, UserAccount, ComputerName, FromEvent, FromTime, ToEvent, ToTime, BreakReasonId, BreakReason, TimeSpent)        
				values (s.UserId, s.EventDate, s.UserAccount, s.ComputerName, s.FromEvent, s.FromTime, s.ToEvent, s.ToTime, s.ReasonId, s.BreakReason, s.TimeSpent)  
		;  
  
		commit      
        
	end try
	begin catch
	rollback
	      
	select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

	if ERROR_MESSAGE() like 'Violation of UNIQUE KEY%'
	begin  
		insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
			values ('EcholockBreakSplitJob Error',     
				convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				getdate(), 'EcholockBreakSplitJob', 'SQL Server')    
  
		insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
			values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
				'Error in EcholockBreakSplitJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				0, 'Y', getdate(), null, 1)
	end
	end catch        
	IF OBJECT_ID('tempdb..#resultbreaklogs') IS NOT NULL  drop table #resultbreaklogs  
	IF OBJECT_ID('tempdb..#source1logs') IS NOT NULL drop table #source1logs  
	IF OBJECT_ID('tempdb..#source2logs') IS NOT NULL drop table #source2logs        
	IF OBJECT_ID('tempdb..#breaklogs') IS NOT NULL  drop table #breaklogs        
	IF OBJECT_ID('tempdb..#lockevents') IS NOT NULL drop table #lockevents          
	IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users  
	IF OBJECT_ID('tempdb..#resultdailyeventslogs') IS NOT NULL  drop table #resultdailyeventslogs
	IF OBJECT_ID('tempdb..#TempDailyEvents') IS NOT NULL  drop table #TempDailyEvents  
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL  drop table #dailylogs        
end
GO
/****** Object:  StoredProcedure [dbo].[EcholockDailyEventBreakSplitJob_New]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
--======================================================================================
--EcholockBreakSplitJob - Break Split up Job for Echolock by Company/ Individual
--======================================================================================
--Created By   -  Promodh.Kumar
--Created On   -  04/03/2019
--Parameters   -  @CompanyId, @UserId, @FromDate, @RefTime
--Notes     -  All Lock Event Time Calculations are in UTC
--======================================================================================
--Modified By   -
--Modified On   -
--Modification Details -
--======================================================================================
*/

CREATE Proc [dbo].[EcholockDailyEventBreakSplitJob_New]
(
	@CompanyId int,       -- Target Company Id
	@UserId nvarchar(128) = null,   -- Null, if for whole company
	@FromDate datetime,      -- UTC
	@RefTime time       -- Reference Time for calculation
)
as
begin
	set transaction Isolation level read uncommitted;
	set nocount on

	IF OBJECT_ID('tempdb..#resultbreaklogs') IS NOT NULL  drop table #resultbreaklogs
	IF OBJECT_ID('tempdb..#source1logs') IS NOT NULL drop table #source1logs
	IF OBJECT_ID('tempdb..#source2logs') IS NOT NULL drop table #source2logs
	IF OBJECT_ID('tempdb..#breaklogs') IS NOT NULL  drop table #breaklogs
	IF OBJECT_ID('tempdb..#lockevents') IS NOT NULL drop table #lockevents
	IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users
	IF OBJECT_ID('tempdb..#resultdailyeventslogs') IS NOT NULL  drop table #resultdailyeventslogs
	IF OBJECT_ID('tempdb..#TempDailyEvents') IS NOT NULL  drop table #TempDailyEvents
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL  drop table #dailylogs

	create table #users
	(          
		Id int identity(1,1),
		UserId nvarchar(128),
		ShiftId int,
		FromTime datetime,
		ToTime datetime,
		ActualFromTime datetime,
		ActualToTime datetime,
		status bit default(1)
	);

	create table #lockevents
	(          
		Id bigint identity(1,1),
		EventTypeId int,
		ShiftId int,
		EventTime datetime,
		UserId nvarchar(128),
		AFromTime datetime,
		AToTime datetime,
		ReasonId int,
		UserAccount varchar(100),
		ComputerName varchar(100),
		status bit default(1)
	);

	create table #lockeventsoutofshift
	(
		Id bigint identity(1,1),
		EventTypeId int,
		ShiftId int,
		EventTime datetime,
		UserId nvarchar(128),
		AFromTime datetime,
		AToTime datetime,
		ReasonId int,
		UserAccount varchar(100),
		ComputerName varchar(100),
		status bit default(1)
	);

	create table #breaklogs        
	(        
		UserId nvarchar(128),
		EventTypeId int,
		EventName varchar(100),
		EventTime datetime,
		UserAccount varchar(100),
		ComputerName varchar(100),
		ReasonId int,
		ReasonName varchar(100)
	);

	create table #source1logs
	(
		RwNo int,
		UserId nvarchar(128),
		UserAccount varchar(100),
		ComputerName varchar(100),
		EventTime datetime,
		EventName varchar(100),
		ReasonName varchar(100),
		ReasonId int,
		EventId int
	);

	create table #source2logs
	(
		RwNo int,
		UserId nvarchar(128),
		UserAccount varchar(100),
		EventTime datetime,
		EventName varchar(100),
		ReasonName varchar(100),
		ReasonId int,
		EventId int
	);

	create table #resultbreaklogs
	(
		UserId nvarchar(128),
		EventDate datetime,
		UserAccount varchar(100),
		ComputerName varchar(100),
		FromEvent varchar(100),
		FromTime datetime,
		ToEvent varchar(100),
		ToTime datetime,
		ReasonId int,
		BreakReason varchar(100),
		TimeSpent bigint,
	);

	create table #resultdailyeventslogs
	(
		UserId nvarchar(128),
		EventDate datetime,
		FromEvent int,
		FromTime datetime,
		ToEvent int,
		ToTime datetime,
		TimeSpent bigint
	);
	
	create table #dailylogs        
	(        
		Id bigint identity(1,1),        
		UserId nvarchar(128),        
		ShiftId int,        
		LoginDate datetime,        
		LogoutDate datetime,        
		TotalSeconds bigint default(0),        
		WorkSeconds bigint default(0),        
		BreakSeconds bigint default(0),        
		ActualLogin datetime,        
		ActualLogout datetime,        
		LateInTime time,        
		AdvanceOutTime time,        
		IsLatein bit,        
		status bit default(1)        
	);      
      
	create table #TempDailyEvents      
	(      
		UserId nvarchar(128),      
		UserAccount varchar(500),      
		EmployeeCode varchar(100),      
		ManagerL1 varchar(100),      
		ManagerL2 varchar(100),      
		Date datetime,      
		ShiftId int,      
		Login datetime,      
		Logout datetime,      
		TotalHrs float,      
		WorkHours float,      
		LockHrs float,      
		Role varchar(100),      
		CreatedOn datetime,      
		ShiftFrom time(7),      
		ShiftTo time(7),      
		ClientId int,      
		ShiftLogOn datetime,      
		ShiftLogOut datetime,      
		LateIn time(7),      
		AdvanceOut time(7),      
		IsLate int,      
		PresentDayStaus int      
	);         
        
	declare @tc int = 0, @selectedUser nvarchar(128), @ltc int = 0          
	declare @ToDate datetime=dateadd(day,1,@FromDate)          
	declare @currentUserId nvarchar(128), @currentShiftTo datetime, @currentShiftFrom datetime          
	declare @duration int=0, @mtc int=0, @workduration int = 0
	declare @refstartdate datetime, @refenddate datetime, @refstartid bigint, @refstarteventtype int, @refendeventtype int          
	declare @actuallogin datetime, @actuallogout datetime          
          
          
	---- Get Company TimeZone for Shift Calculation in UTC          
	--if(@UserId is null)          
	--begin          
	-- select @TimeZoneOffSet = CurrentUTCOffset          
	--  from CompanyAppSettings a          
	--   inner join LookupTimeZone b on a.TimeZoneId = b.Id          
	--  where a.CompanyId = @CompanyId          
	--end          
	--else          
	--begin          
	-- select @TimeZoneOffSet = CurrentUTCOffset          
	--  from UserDetails ud          
	--   inner join CompanyAppSettings a on ud.CompanyId = a.CompanyId          
	--   inner join LookupTimeZone b on a.TimeZoneId = b.Id        
	--  where ud.UserId = @UserId          
	--end          
          
	if (@UserId is null)          
	begin          
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)          
		select distinct ud.UserId, ud.Shift,          
			dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
			else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
			DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
			else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
		from DailyDashboardData ud (nolock)        
		inner join LookupShift sft (nolock) on ud.Shift = sft.Id  
			inner join LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
		where ud.UserId in          
			(select UserId          
			from UserDetails with (nolock)          
			where CompanyId = @CompanyId)          
			--and ud.Status=4 -- To process for Active Users Only          
			and ud.NTLoginName <> 'System'
			and ud.EventDate = @FromDate        
	end          
	else          
	begin            
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)          
		select distinct ud.UserId, ud.Shift,          
			dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
			else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
			DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
			(case when sft.WorkEndTime > sft.WorkStartTime  
			then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
			else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
		from DailyDashboardData ud (nolock)        
		inner join LookupShift sft (nolock) on ud.Shift = sft.Id  
			inner join LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
		where ud.UserId = @UserId          
			--and ud.Status=4 -- To process for Active Users Only          
			and ud.NTLoginName <> 'System'
			and ud.EventDate = @FromDate
	end        
          
	select @tc = count(*) from #users          
          
	while @tc!=0          
	begin          
		set @selectedUser = (select top 1 UserId          
		from #users          
		where status=1          
		order by Id desc)          
          
		insert into #lockevents (UserId, EventTime, EventTypeId, ShiftId, AFromTime, AToTime, UserAccount, ComputerName, ReasonId)          
			select le.UserId, le.EventTime, le.EventTypeId, ud.ShiftId, ud.ActualFromTime, ud.ActualToTime, le.UserAccount, le.ComputerName, le.ReasonId        
			from LockEvents le (nolock)          
				inner join #users ud on le.UserId=ud.UserId          
			where le.EventTime >=ud.FromTime          
				and le.EventTime <= ud.ToTime          
				and le.EventTypeId not in (4,10,12)          
				and le.UserId = @selectedUser        
						and le.EventStatus = 1 /* Added for processing only Valid Lock Events */  
			order by le.EventTime          
            
		set @ltc = (select count(distinct UserId)          
			from #lockevents (nolock)          
			where UserId = @selectedUser)          
          
		while (@ltc!=0)          
		begin  
			select top 1 @currentUserId = UserId, @currentShiftTo = AToTime, @currentShiftFrom = AFromTime        
				from #lockevents (nolock)        
				where status = 1        
				order by Id desc
				
			-- First Login/ Connect/ Unlock Time of the day        
			set @actuallogin = (select min(EventTime)        
				from #lockevents (nolock)        
				where status=1 and UserId = @currentUserId  
				/*and EventTypeId in (1,3,5)*/  
				)  
        
			-- Last Logout/ Disconnect/ Lock Time of the day        
			set @actuallogout = (select max(EventTime)        
				from #lockevents (nolock)        
				where status=1 and UserId = @currentUserId  
				/*and EventTypeId in (0,2,6)*/  
				)

			insert into #dailylogs (ShiftId, UserId, LoginDate, LogoutDate, WorkSeconds, BreakSeconds, TotalSeconds, ActualLogin, ActualLogout)        
				select ShiftId, UserId, LoginDate, LogoutDate, 0, 0,  
						case when datediff(second,       
						case when @actuallogin > LoginDate then @actuallogin else LoginDate end,       
						case when LogoutDate > @actuallogout then @actuallogout else LogoutDate end      
						) < 0 then 0 else DATEDIFF(second,       
						case when @actuallogin > LoginDate then @actuallogin else LoginDate end,       
						case when LogoutDate > @actuallogout then @actuallogout else LogoutDate end      
						) end, @actuallogin, @actuallogout        
					from (        
						select ShiftId, UserId, (case when min(le.EventTime) < min(le.AFromTime)        
								then min(le.AFromTime) else min(le.EventTime) end) as LoginDate,        
								(case when max(le.EventTime) > max(le.AToTime)        
								then max(le.AToTime) else max(le.EventTime) end) as LogoutDate        
							from #lockevents le  
							where UserId = @currentUserId and status=1        
							group by UserId, ShiftId        
				) as temp1

			set @duration = 0
			set @mtc = 0
  
				/* --- Added to calculate within shift hours ---*/  
  
			/*Update eventtime for event, before the shift start time and after the shift end time*/  
			update #lockevents set EventTime = @currentShiftFrom        
				where EventTime in (select top 1 EventTime        
					from #lockevents        
					where UserId = @currentUserId        
					and EventTime <= @currentShiftFrom        
					order by EventTime desc)  
  
			update #lockevents set EventTime = @currentShiftTo        
				where EventTime in (select top 1 EventTime        
					from #lockevents        
					where UserId = @currentUserId        
					and EventTime >= @currentShiftTo  
					order by EventTime asc)  
          
			delete from #lockevents        
				where UserId = @currentUserId        
					and (EventTime > @currentShiftTo or EventTime < @currentShiftFrom)        
        
			delete from #lockevents        
				where UserId = @currentUserId        
					and EventTime < @currentShiftFrom   

			set @mtc = (select count(*)        
				from #lockevents        
				where UserId = @currentUserId        
					and EventTypeId in (2,0,6)        
					and status = 1 and EventTime < @currentShiftTo)        
        
			set @refstartdate = (select top 1 EventTime         
				from #lockevents        
				where EventTypeId in (1,3,10) and status=1 and UserId = @currentUserId        
				order by EventTime)
					/* --- Added to calculate within shift hours ---*/  
          
			insert into #breaklogs (UserId, EventTypeId, EventTime, UserAccount, ComputerName, ReasonId, EventName, ReasonName)         
				select distinct le.UserId, le.EventTypeId, EventTime, UserAccount, ComputerName, ReasonId, evt.EventName, br.BreakReason        
					from #lockevents  le (nolock)        
						inner join LookupBreakReason br on le.ReasonId = br.Id        
						inner join LookupEventType evt on evt.EventTypeId = le.EventTypeId        
					where le.EventTypeId in (0,1,2,3,5,6)        
						and le.UserId = @selectedUser        
						and le.status = 1        
					order by le.UserAccount, le.EventTime  
  
			update #breaklogs  
				set ReasonId = 3, ReasonName = 'Break'  
				where EventTypeId = 5  
        
			delete from #source1logs        
			delete from #source2logs        
        
			insert into #source1logs (RwNo, UserId, UserAccount, EventTime, EventId, EventName, ReasonName, ComputerName, ReasonId)        
				select row_number() over(partition by UserAccount order by UserAccount, EventTime) RwNo, UserId, UserAccount, EventTime, EventTypeId, EventName, ReasonName, ComputerName, ReasonId        
					from #breaklogs        
					where UserId = @selectedUser        
        
			insert into #source2logs (RwNo, UserId, UserAccount, EventTime, EventId, EventName, ReasonName, ReasonId)   
				select row_number() over(partition by UserAccount order by UserAccount, EventTime) RwNo, UserId, UserAccount, EventTime, EventId, EventName, ReasonName, ReasonId        
					from #source1logs    
					where RwNo != 1  
        
			insert into #resultbreaklogs        
				select t1.UserId, @FromDate EventDate, t1.UserAccount, t1.ComputerName, t1.EventName as FromEvent, t1.EventTime FromTime,        
						t2.EventName as ToEvent, t2.EventTime as ToTime, t2.ReasonId ReasonId, t2.ReasonName BreakReason,        
						case when t2.EventTime is not null then datediff(s, t1.EventTime, t2.EventTime) else 0 end TimeSpent        
					from #source1logs t1        
						inner join #source2logs t2 on t1.RwNo = t2.RwNo and t1.UserAccount = t2.UserAccount  
  
			delete from #resultbreaklogs where (FromEvent = ToEvent and ToEvent = 'Logoff')  
  
			delete from #resultbreaklogs where FromTime = ToTime  
  
			/*select *  
				from #resultbreaklogs*/

			select @duration = sum(TimeSpent) from #resultdailyeventslogs  
					where ToEvent in (1,3,5,10)
						and UserId = @currentUserId
  
			select @workduration = sum(TimeSpent) from #resultdailyeventslogs  
					where ToEvent not in (1,3,5,10)
						and UserId = @currentUserId

			update #dailylogs set BreakSeconds = isnull(@duration, 0) where UserId = @currentUserId  
			update #dailylogs set WorkSeconds = isnull(@workduration, 0) where UserId = @currentUserId  
			update #dailylogs set TotalSeconds = WorkSeconds + BreakSeconds where UserId = @currentUserId
  
			update #resultbreaklogs  
				set ReasonId = 3, BreakReason = 'Break'  
				where  FromEvent = 'Logoff' and ToEvent = 'Logon'  
          
			update #lockevents set status=0 where status=1 and UserId = @selectedUser and EventTypeId in (1,0)        
        
			set @ltc = @ltc - 1          
		end          
          
		update #users          
			set status=0          
			where status=1 and UserId=@selectedUser

		set @tc=@tc-1        
	end

	update dl set dl.IsLatein= (case when (dl.LoginDate > usrs.ActualFromTime) or (usrs.ActualToTime > dl.LogoutDate) then 1 else 0 end),        
		dl.LateInTime = (case when (dl.LoginDate > usrs.ActualFromTime) then convert(time, dl.LoginDate - usrs.ActualFromTime) else '00:00:00.000' end),        
		dl.AdvanceOutTime = (case when ((usrs.ActualToTime > dl.LogoutDate) and (dl.LogoutDate > usrs.ActualFromTime)) then convert(time, usrs.ActualToTime - dl.LogoutDate) else '00:00:00.000' end),      
		dl.LoginDate = (case when dl.TotalSeconds<=0 then null else dl.LoginDate end),      
		dl.LogoutDate = (case when dl.TotalSeconds<=0 then null else dl.LogoutDate end),      
		dl.BreakSeconds = (case when dl.TotalSeconds<=0 then 0 else dl.BreakSeconds end)      
	from #dailylogs dl        
		inner join #users usrs on dl.UserId = usrs.UserId      
      
	update #dailylogs set WorkSeconds = case when (TotalSeconds - BreakSeconds) < 0 then 0 else (TotalSeconds - BreakSeconds) end

	begin try      
	begin tran          
		insert into #TempDailyEvents (UserId, UserAccount, EmployeeCode, ManagerL1, ManagerL2, Date, ShiftId,         
				Login, Logout, TotalHrs, WorkHours, LockHrs, Role, CreatedOn, ShiftFrom, ShiftTo,         
				ClientId, ShiftLogOn, ShiftLogOut, LateIn, AdvanceOut, IsLate, PresentDayStaus)        
				select ud.UserId, ud.NTLoginName, ud.EmployeeCode, ud.ManagerL1, ud.ManagerL2, @FromDate, ud.Shift,        
				dl.ActualLogin, dl.ActualLogout, dl.TotalSeconds, dl.WorkSeconds, dl.BreakSeconds, ud.Role, getdate(), sft.WorkStartTime, sft.WorkEndTime,        
				ud.CompanyId,dl.LoginDate, dl.LogoutDate, dl.LateInTime,dl.AdvanceOutTime, dl.IsLatein, 1        
			from #dailylogs dl        
				inner join UserDetails ud on dl.UserId = ud.UserId        
				inner join LookupShift sft on ud.Shift = sft.Id        
				inner join Users usr on ud.UserId = usr.UserId      
      
		-- Entries for Users, on absent/ holiday      
		insert into #TempDailyEvents (UserId, UserAccount, EmployeeCode, ManagerL1, ManagerL2, Date, ShiftId,         
				Login, Logout, TotalHrs, WorkHours, LockHrs, Role, CreatedOn, ShiftFrom, ShiftTo,         
				ClientId, ShiftLogOn, ShiftLogOut, LateIn, AdvanceOut, IsLate, PresentDayStaus)      
				select ud.UserId, ud.NTLoginName, ud.EmployeeCode, ud.ManagerL1, ud.ManagerL2, @FromDate, ud.Shift,      
					null, null, 0, 0, 0, ud.Role, getdate(), sft.WorkStartTime, sft.WorkEndTime, ud.CompanyId,      
					null, null, '00:00:00.000', '00:00:00.000', 0, 7      
			from #users usrs      
				inner join UserDetails ud on usrs.UserId = ud.UserId      
				inner join LookupShift sft on usrs.ShiftId = sft.Id      
			where usrs.UserId not in (      
				select distinct UserId      
				from #TempDailyEvents      
			)
        
		merge DailyEvents t      
		using #TempDailyEvents s      
		on (s.UserId = t.UserId and s.Date = t.Date)      
		when matched then      
			update set t.UserAccount = s.UserAccount, t.EmployeeCode = s.EmployeeCode, t.ManagerL1 = s.ManagerL1, t.ManagerL2 = s.ManagerL2, t.ShiftId = s.ShiftId,      
				t.Login = s.Login, t.Logout = s.Logout, t.TotalHrs = s.TotalHrs, t.WorkHours = s.WorkHours, t.LockHrs = s.LockHrs, t.Role = s.Role,      
				t.CreatedOn = s.CreatedOn, t.ShiftFrom = s.ShiftFrom, t.ShiftTo = s.ShiftTo, t.ClientId = s.ClientId, t.ShiftLogOn = s.ShiftLogOn,      
				t.ShiftLogout = s.ShiftLogout, t.LateIn = s.LateIn, t.AdvanceOut = s.AdvanceOut, t.IsLate = s.IsLate, t.PresentDayStaus = s.PresentDayStaus      
		when not matched by target then      
			insert (UserId, UserAccount, EmployeeCode, ManagerL1, ManagerL2, Date, ShiftId,         
					Login, Logout, TotalHrs, WorkHours, LockHrs, Role, CreatedOn, ShiftFrom, ShiftTo,         
					ClientId, ShiftLogOn, ShiftLogOut, LateIn, AdvanceOut, IsLate, PresentDayStaus)      
				values (s.UserId, s.UserAccount, s.EmployeeCode, s.ManagerL1, s.ManagerL2, s.Date, s.ShiftId,         
					s.Login, s.Logout, s.TotalHrs, s.WorkHours, s.LockHrs, s.Role, s.CreatedOn, s.ShiftFrom, s.ShiftTo,         
					s.ClientId, s.ShiftLogOn, s.ShiftLogOut, s.LateIn, s.AdvanceOut, s.IsLate, s.PresentDayStaus)      
		;      
		commit      
     
	end try        
	begin catch   
	     
	rollback      

	select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

	if ERROR_MESSAGE() not like 'Violation of UNIQUE KEY%'
	begin
		insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
			values ('EcholockDailyEventJob Error',     
				convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				getdate(), 'EcholockDailyEventJob', 'SQL Server')    
  
		insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
			values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
				'Error in EcholockDailyEventJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				0, 'Y', getdate(), null, 1)
	end
	   
	end catch
        
	begin tran          
	begin try  
        
		merge DailyBreakSplitUp t        
		using #resultbreaklogs s        
		on (s.UserId = t.UserId and s.EventDate = t.EventDate and s.FromEvent = t.FromEvent and s.FromTime = t.FromTime)        
		when matched then        
			update set t.FromEvent = s.FromEvent, t.FromTime = s.FromTime, t.ToEvent = s.ToEvent, t.ToTime = s.ToTime,        
			t.BreakReasonId = s.ReasonId, t.BreakReason = s.BreakReason, t.TimeSpent = s.TimeSpent        
		when not matched by target then        
			insert (UserId, EventDate, UserAccount, ComputerName, FromEvent, FromTime, ToEvent, ToTime, BreakReasonId, BreakReason, TimeSpent)        
				values (s.UserId, s.EventDate, s.UserAccount, s.ComputerName, s.FromEvent, s.FromTime, s.ToEvent, s.ToTime, s.ReasonId, s.BreakReason, s.TimeSpent)  
		;  
  
		commit      
        
	end try
	begin catch
	rollback
	      
	select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

	if ERROR_MESSAGE() like 'Violation of UNIQUE KEY%'
	begin  
		insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
			values ('EcholockBreakSplitJob Error',     
				convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				getdate(), 'EcholockBreakSplitJob', 'SQL Server')    
  
		insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
			values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
				'Error in EcholockBreakSplitJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				0, 'Y', getdate(), null, 1)
	end
	end catch        
	IF OBJECT_ID('tempdb..#resultbreaklogs') IS NOT NULL  drop table #resultbreaklogs  
	IF OBJECT_ID('tempdb..#source1logs') IS NOT NULL drop table #source1logs  
	IF OBJECT_ID('tempdb..#source2logs') IS NOT NULL drop table #source2logs        
	IF OBJECT_ID('tempdb..#breaklogs') IS NOT NULL  drop table #breaklogs        
	IF OBJECT_ID('tempdb..#lockevents') IS NOT NULL drop table #lockevents          
	IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users  
	IF OBJECT_ID('tempdb..#resultdailyeventslogs') IS NOT NULL  drop table #resultdailyeventslogs
	IF OBJECT_ID('tempdb..#TempDailyEvents') IS NOT NULL  drop table #TempDailyEvents  
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL  drop table #dailylogs        
end
GO
/****** Object:  StoredProcedure [dbo].[EcholockDailyEventJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*--======================================================================================        
--EcholockDailyEventJob - Daily Event Job for Echolock by Company/ Individual        
--======================================================================================        
--Created By   -  Promodh.Kumar        
--Created On   -  26/02/2019        
--Parameters   -  @CompanyId, @UserId, @FromDate, @RefTime        
--Notes     -  All Lock Event Time Calculations are in UTC        
--======================================================================================        
--Modified By   -    Promodh.Kumar  
--Modified On   -    24/072019  
--Modification Details -   Modified to calculate Break Duration using Break Split Job Logic & Valid Lock Events only  
--======================================================================================
*/  
        
CREATE Proc [dbo].[EcholockDailyEventJob]        
(        
	@CompanyId int,       -- Target Company Id
	@UserId nvarchar(128) = null,   -- Null, if for whole company
	@FromDate datetime,      -- UTC
	@RefTime time       -- Reference Time for calculation
)

as        
begin        
	set transaction Isolation level read uncommitted;        
	set nocount on  
	IF OBJECT_ID('tempdb..#TempDailyEvents') IS NOT NULL  drop table #TempDailyEvents  
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL  drop table #dailylogs  
	IF OBJECT_ID('tempdb..#lockevents') IS NOT NULL  drop table #lockevents  
	IF OBJECT_ID('tempdb..#users') IS NOT NULL  drop table #users   
	IF OBJECT_ID('tempdb..#result1') IS NOT NULL  drop table #result1   
	IF OBJECT_ID('tempdb..#source2logs') IS NOT NULL  drop table #source2logs   
	IF OBJECT_ID('tempdb..#source1logs') IS NOT NULL  drop table #source1logs   
	IF OBJECT_ID('tempdb..#breaklogs') IS NOT NULL  drop table #breaklogs   
         
	--set @RefTime = '08:30:00'        
	--declare @TimeZoneOffSet bigint=0        
	declare @Bufferhours int=3        
        
	create table #users        
	(        
		Id int identity(1,1),        
		UserId nvarchar(128),        
		ShiftId int,        
		FromTime datetime,        
		ToTime datetime,        
		ActualFromTime datetime,        
		ActualToTime datetime,        
		status bit default(1)        
	);        
        
	create table #lockevents        
	(        
		Id bigint identity(1,1),        
		EventTypeId int,        
		ShiftId int,        
		EventTime datetime,        
		UserId nvarchar(128),        
		AFromTime datetime,        
		AToTime datetime,        
		status bit default(1)        
	);        
        
	create table #dailylogs        
	(        
		Id bigint identity(1,1),        
		UserId nvarchar(128),        
		ShiftId int,        
		LoginDate datetime,        
		LogoutDate datetime,        
		TotalSeconds bigint default(0),        
		WorkSeconds bigint default(0),        
		BreakSeconds bigint default(0),        
		ActualLogin datetime,        
		ActualLogout datetime,        
		LateInTime time,        
		AdvanceOutTime time,        
		IsLatein bit,        
		status bit default(1)        
	);      
      
	create table #TempDailyEvents      
	(      
		UserId nvarchar(128),      
		UserAccount varchar(500),      
		EmployeeCode varchar(100),      
		ManagerL1 varchar(100),      
		ManagerL2 varchar(100),      
		Date datetime,      
		ShiftId int,      
		Login datetime,      
		Logout datetime,      
		TotalHrs float,      
		WorkHours float,      
		LockHrs float,      
		Role varchar(100),      
		CreatedOn datetime,      
		ShiftFrom time(7),      
		ShiftTo time(7),      
		ClientId int,      
		ShiftLogOn datetime,      
		ShiftLogOut datetime,      
		LateIn time(7),      
		AdvanceOut time(7),      
		IsLate int,      
		PresentDayStaus int      
	);      
  
	create table #breaklogs        
	(        
		UserId nvarchar(128),        
		EventTypeId int,        
		EventName varchar(100),        
		EventTime datetime  
	);        
        
	create table #source1logs        
	(        
		RwNo int,        
		UserId nvarchar(128),       
		EventTime datetime,        
		EventId int  
	);        
        
	create table #source2logs        
	(        
		RwNo int,        
		UserId nvarchar(128),  
		EventTime datetime,        
		EventId int  
	);  
  
	create table #result1        
	(        
		UserId nvarchar(128),        
		EventDate datetime,  
		FromEvent int,        
		FromTime datetime,        
		ToEvent int,  
		ToTime datetime,     
		TimeSpent bigint  
	);   
        
	declare @tc int = 0, @selectedUser nvarchar(128), @ltc int = 0        
	declare @ToDate datetime=dateadd(day,1,@FromDate)        
	declare @currentUserId nvarchar(128), @currentShiftTo datetime, @currentShiftFrom datetime        
	declare @duration int=0, @mtc int=0, @workduration int = 0  
	declare @refstartdate datetime, @refenddate datetime, @refstartid bigint, @refstarteventtype int, @refendeventtype int        
	declare @actuallogin datetime, @actuallogout datetime        
        
        
	---- Get Company TimeZone for Shift Calculation in UTC        
	--if(@UserId is null)        
	--begin        
	-- select @TimeZoneOffSet = CurrentUTCOffset        
	--  from CompanyAppSettings a        
	--   inner join LookupTimeZone b on a.TimeZoneId = b.Id        
	--  where a.CompanyId = @CompanyId        
	--end        
	--else        
	--begin        
	-- select @TimeZoneOffSet = CurrentUTCOffset        
	--  from UserDetails ud        
	--   inner join CompanyAppSettings a on ud.CompanyId = a.CompanyId        
	--   inner join LookupTimeZone b on a.TimeZoneId = b.Id        
	--  where ud.UserId = @UserId        
	--end        
        
	if (@UserId is null)        
	begin        
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)        
			select distinct ud.UserId, ud.Shift,        
				dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
				else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
				DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
				else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)  
			from Echolock.dbo.DailyDashboardData ud (nolock)      
				inner join LookupShift sft (nolock) on ud.Shift = sft.Id  
				inner join LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
			where ud.UserId in        
					(select UserId        
						from UserDetails with (nolock)        
						where CompanyId = @CompanyId)        
					--and ud.Status=4 -- To process for Active Users Only        
					and ud.NTLoginName <> 'System'
					and ud.EventDate = @FromDate
	end        
	else        
	begin          
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)        
			select distinct ud.UserId, ud.Shift,        
				dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
				else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end),  
				DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108)),  
				(case when sft.WorkEndTime > sft.WorkStartTime  
				then DATEADD(second, -tz.CurrentUTCOffset, @FromDate + ' ' + convert(varchar(5), sft.WorkEndTime,108))  
				else  DATEADD(second, -tz.CurrentUTCOffset, @ToDate + ' ' + convert(varchar(5), sft.WorkEndTime,108)) end)       
			from Echolock.dbo.DailyDashboardData ud (nolock)      
				inner join LookupShift sft (nolock) on ud.Shift = sft.Id  
				inner join LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id  
			where ud.UserId = @UserId        
				--and ud.Status=4 -- To process for Active Users Only        
				and ud.NTLoginName <> 'System'
				and ud.EventDate = @FromDate
	end      
        
	select @tc = count(*) from #users        
        
	while @tc!=0        
	begin        
		set @selectedUser = (select top 1 UserId        
				from #users        
				where status=1        
				order by Id desc)        
        
		insert into #lockevents (UserId, EventTime, EventTypeId, ShiftId, AFromTime, AToTime)        
			select le.UserId, le.EventTime, le.EventTypeId, ud.ShiftId, ud.ActualFromTime, ud.ActualToTime        
				from LockEvents le (nolock)        
					inner join #users ud on le.UserId=ud.UserId        
				where le.EventTime >=ud.FromTime        
					and le.EventTime < ud.ToTime        
					and le.EventTypeId not in (4,10,12)        
					and le.UserId = @selectedUser        
					and le.EventStatus = 1  
				order by le.EventTime  
        
		set @ltc = (select count(distinct UserId)        
				from #lockevents (nolock)        
				where UserId = @selectedUser)        
		
		while (@ltc!=0)        
		begin        
			select top 1 @currentUserId = UserId, @currentShiftTo = AToTime, @currentShiftFrom = AFromTime        
				from #lockevents (nolock)        
				where status = 1        
				order by Id desc        
        
			-- First Login/ Connect/ Unlock Time of the day        
			set @actuallogin = (select min(EventTime)        
				from #lockevents (nolock)        
				where status=1 and UserId = @currentUserId  
				/*and EventTypeId in (1,3,5)*/  
				)  
        
			-- Last Logout/ Disconnect/ Lock Time of the day        
			set @actuallogout = (select max(EventTime)        
				from #lockevents (nolock)        
				where status=1 and UserId = @currentUserId  
				/*and EventTypeId in (0,2,6)*/  
				)     
        
			insert into #dailylogs (ShiftId, UserId, LoginDate, LogoutDate, WorkSeconds, BreakSeconds, TotalSeconds, ActualLogin, ActualLogout)        
				select ShiftId, UserId, LoginDate, LogoutDate, 0, 0,  
						case when datediff(second,       
						case when @actuallogin > LoginDate then @actuallogin else LoginDate end,       
						case when LogoutDate > @actuallogout then @actuallogout else LogoutDate end      
						) < 0 then 0 else DATEDIFF(second,       
						case when @actuallogin > LoginDate then @actuallogin else LoginDate end,       
						case when LogoutDate > @actuallogout then @actuallogout else LogoutDate end      
						) end, @actuallogin, @actuallogout        
					from (        
						select ShiftId, UserId, (case when min(le.EventTime) < min(le.AFromTime)        
								then min(le.AFromTime) else min(le.EventTime) end) as LoginDate,        
								(case when max(le.EventTime) > max(le.AToTime)        
								then max(le.AToTime) else max(le.EventTime) end) as LogoutDate        
							from #lockevents le  
							where UserId = @currentUserId and status=1        
							group by UserId, ShiftId        
				) as temp1      
        
			set @duration = 0        
			set @mtc = 0        
        
			-- Update eventtime for event, before the shift start time        
			update #lockevents set EventTime = @currentShiftFrom        
				where EventTime in (select top 1 EventTime        
					from #lockevents        
					where UserId = @currentUserId        
						and EventTime < @currentShiftFrom        
					order by EventTime desc)        
  
			update #lockevents set EventTime = @currentShiftTo  
				where EventTime in (select top 1 EventTime        
					from #lockevents        
					where UserId = @currentUserId        
						and EventTime > @currentShiftTo  
					order by EventTime asc)  
           
			delete from #lockevents        
				where UserId = @currentUserId        
					and (EventTime > @currentShiftTo or EventTime < @currentShiftFrom)  
        
			set @mtc = (select count(*)        
				from #lockevents        
				where UserId = @currentUserId        
					and EventTypeId in (2,0,6)        
					and status = 1 and EventTime < @currentShiftTo)        
        
			set @refstartdate = (select top 1 EventTime         
				from #lockevents        
				where EventTypeId in (1,3,10) and status=1 and UserId = @currentUserId        
				order by EventTime)        
        
			-- Break Duration Calculation        
			delete from #breaklogs  
			delete from #result1  
  
			insert into #breaklogs (UserId, EventTypeId, EventTime)  
				select distinct le.UserId, le.EventTypeId, EventTime        
					from #lockevents  le (nolock)  
					where le.EventTypeId in (0,1,2,3,5,6)        
						and le.UserId = @selectedUser        
						and le.status = 1        
					order by le.EventTime  
        
			delete from #source1logs        
			delete from #source2logs        
        
			insert into #source1logs (RwNo, UserId, EventTime, EventId)  
				select row_number() over(partition by UserId order by UserId, EventTime) RwNo, UserId, EventTime, EventTypeId  
					from #breaklogs        
					where UserId = @selectedUser        
        
			insert into #source2logs (RwNo, UserId, EventTime, EventId)  
				select row_number() over(partition by UserId order by UserId, EventTime) RwNo, UserId, EventTime, EventId  
					from #source1logs        
					where RwNo != 1        
        
			insert into #result1 (UserId, EventDate, FromEvent, FromTime, ToEvent, ToTime, TimeSpent)  
				select t1.UserId, @FromDate EventDate, t1.EventId as FromEvent, t1.EventTime FromTime,        
						t2.EventId as ToEvent, t2.EventTime as ToTime,  
						case when t2.EventTime is not null then datediff(s, t1.EventTime, t2.EventTime) else 0 end TimeSpent        
					from #source1logs t1  
						inner join #source2logs t2 on t1.RwNo = t2.RwNo and t1.UserId = t2.UserId  
  
			delete from #result1 where (FromEvent = ToEvent and ToEvent = 0)  
  
			select @duration = sum(TimeSpent) from #result1  
					where ToEvent in (1,3,5,10)  
  
			select @workduration = sum(TimeSpent) from #result1  
					where ToEvent not in (1,3,5,10)  
        
			update #dailylogs set BreakSeconds = isnull(@duration, 0) where UserId = @currentUserId  
			update #dailylogs set WorkSeconds = isnull(@workduration, 0) where UserId = @currentUserId  
			update #dailylogs set TotalSeconds = WorkSeconds + BreakSeconds where UserId = @currentUserId  
        
			update #lockevents set status=0 where status=1 and UserId = @UserId and EventTypeId in (1,0)        
			set @ltc = @ltc - 1        
		end        
        
		update #users        
		set status=0        
		where status=1 and UserId=@selectedUser        
		set @tc=@tc-1        
	end        
        
	update dl set dl.IsLatein= (case when (dl.LoginDate > usrs.ActualFromTime) or (usrs.ActualToTime > dl.LogoutDate) then 1 else 0 end),        
		dl.LateInTime = (case when (dl.LoginDate > usrs.ActualFromTime) then convert(time, dl.LoginDate - usrs.ActualFromTime) else '00:00:00.000' end),        
		dl.AdvanceOutTime = (case when ((usrs.ActualToTime > dl.LogoutDate) and (dl.LogoutDate > usrs.ActualFromTime)) then convert(time, usrs.ActualToTime - dl.LogoutDate) else '00:00:00.000' end),      
		dl.LoginDate = (case when dl.TotalSeconds<=0 then null else dl.LoginDate end),      
		dl.LogoutDate = (case when dl.TotalSeconds<=0 then null else dl.LogoutDate end),      
		dl.BreakSeconds = (case when dl.TotalSeconds<=0 then 0 else dl.BreakSeconds end)      
	from #dailylogs dl        
		inner join #users usrs on dl.UserId = usrs.UserId      
      
	update #dailylogs set WorkSeconds = case when (TotalSeconds - BreakSeconds) < 0 then 0 else (TotalSeconds - BreakSeconds) end  
      
	begin try      
	begin tran          
		insert into #TempDailyEvents (UserId, UserAccount, EmployeeCode, ManagerL1, ManagerL2, Date, ShiftId,         
				Login, Logout, TotalHrs, WorkHours, LockHrs, Role, CreatedOn, ShiftFrom, ShiftTo,         
				ClientId, ShiftLogOn, ShiftLogOut, LateIn, AdvanceOut, IsLate, PresentDayStaus)        
				select ud.UserId, ud.NTLoginName, ud.EmployeeCode, ud.ManagerL1, ud.ManagerL2, @FromDate, ud.Shift,        
				dl.ActualLogin, dl.ActualLogout, dl.TotalSeconds, dl.WorkSeconds, dl.BreakSeconds, ud.Role, getdate(), sft.WorkStartTime, sft.WorkEndTime,        
				ud.CompanyId,dl.LoginDate, dl.LogoutDate, dl.LateInTime,dl.AdvanceOutTime, dl.IsLatein, 1        
			from #dailylogs dl        
				inner join UserDetails ud on dl.UserId = ud.UserId        
				inner join LookupShift sft on ud.Shift = sft.Id        
				inner join Users usr on ud.UserId = usr.UserId      
      
		-- Entries for Users, on absent/ holiday      
		insert into #TempDailyEvents (UserId, UserAccount, EmployeeCode, ManagerL1, ManagerL2, Date, ShiftId,         
				Login, Logout, TotalHrs, WorkHours, LockHrs, Role, CreatedOn, ShiftFrom, ShiftTo,         
				ClientId, ShiftLogOn, ShiftLogOut, LateIn, AdvanceOut, IsLate, PresentDayStaus)      
				select ud.UserId, ud.NTLoginName, ud.EmployeeCode, ud.ManagerL1, ud.ManagerL2, @FromDate, ud.Shift,      
					null, null, 0, 0, 0, ud.Role, getdate(), sft.WorkStartTime, sft.WorkEndTime, ud.CompanyId,      
					null, null, '00:00:00.000', '00:00:00.000', 0, 7      
			from #users usrs      
				inner join UserDetails ud on usrs.UserId = ud.UserId      
				inner join LookupShift sft on usrs.ShiftId = sft.Id      
			where usrs.UserId not in (      
				select distinct UserId      
				from #TempDailyEvents      
			)
        
		merge DailyEvents t      
		using #TempDailyEvents s      
		on (s.UserId = t.UserId and s.Date = t.Date)      
		when matched then      
			update set t.UserAccount = s.UserAccount, t.EmployeeCode = s.EmployeeCode, t.ManagerL1 = s.ManagerL1, t.ManagerL2 = s.ManagerL2, t.ShiftId = s.ShiftId,      
				t.Login = s.Login, t.Logout = s.Logout, t.TotalHrs = s.TotalHrs, t.WorkHours = s.WorkHours, t.LockHrs = s.LockHrs, t.Role = s.Role,      
				t.CreatedOn = s.CreatedOn, t.ShiftFrom = s.ShiftFrom, t.ShiftTo = s.ShiftTo, t.ClientId = s.ClientId, t.ShiftLogOn = s.ShiftLogOn,      
				t.ShiftLogout = s.ShiftLogout, t.LateIn = s.LateIn, t.AdvanceOut = s.AdvanceOut, t.IsLate = s.IsLate, t.PresentDayStaus = s.PresentDayStaus      
		when not matched by target then      
			insert (UserId, UserAccount, EmployeeCode, ManagerL1, ManagerL2, Date, ShiftId,         
					Login, Logout, TotalHrs, WorkHours, LockHrs, Role, CreatedOn, ShiftFrom, ShiftTo,         
					ClientId, ShiftLogOn, ShiftLogOut, LateIn, AdvanceOut, IsLate, PresentDayStaus)      
				values (s.UserId, s.UserAccount, s.EmployeeCode, s.ManagerL1, s.ManagerL2, s.Date, s.ShiftId,         
					s.Login, s.Logout, s.TotalHrs, s.WorkHours, s.LockHrs, s.Role, s.CreatedOn, s.ShiftFrom, s.ShiftTo,         
					s.ClientId, s.ShiftLogOn, s.ShiftLogOut, s.LateIn, s.AdvanceOut, s.IsLate, s.PresentDayStaus)      
		;      
		commit      
     
	end try        
	begin catch   
	     
	rollback      

	select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

	if ERROR_MESSAGE() not like 'Violation of UNIQUE KEY%'
	begin
		insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
			values ('EcholockDailyEventJob Error',     
				convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				getdate(), 'EcholockDailyEventJob', 'SQL Server')    
  
		insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
			values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
				'Error in EcholockDailyEventJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
				0, 'Y', getdate(), null, 1)
	end
	   
	end catch      
      
	IF OBJECT_ID('tempdb..#TempDailyEvents') IS NOT NULL  drop table #TempDailyEvents  
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL  drop table #dailylogs  
	IF OBJECT_ID('tempdb..#lockevents') IS NOT NULL  drop table #lockevents  
	IF OBJECT_ID('tempdb..#users') IS NOT NULL  drop table #users   
	IF OBJECT_ID('tempdb..#result1') IS NOT NULL  drop table #result1   
	IF OBJECT_ID('tempdb..#source2logs') IS NOT NULL  drop table #source2logs   
	IF OBJECT_ID('tempdb..#source1logs') IS NOT NULL  drop table #source1logs   
	IF OBJECT_ID('tempdb..#breaklogs') IS NOT NULL  drop table #breaklogs   
end
GO
/****** Object:  StoredProcedure [dbo].[EcholockDashboardData]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =============================================
-- Author:                 Promodh Kumar
-- Create date             31/10/2019
-- Description:            Echolock Dashboard Data
-- =============================================
CREATE PROCEDURE [dbo].[EcholockDashboardData]
       @CompanyId int,
       @UserId nvarchar(128), -- will be null, if for manager
       @ManagerId nvarchar(128), -- will be null, if for individual user
       @IncludeIndirect bit, -- whether to include indirect reports or not
       @FromDate datetime,
          @ToDate datetime,
          @Present decimal,
          @DeclaredOff bit,
          @ApprovedLeave int,
          @Location varchar(100)=Null,
          @Band varchar(30)=Null
AS
BEGIN
              SET NOCOUNT ON;
              select distinct a.Id,a.EventDate,a.UserId,a.TotalHours,a.WorkHours,a.LockHours,a.ProdHrs,a.NonProdHrs,
						a.UnClassifiedHrs,a.IsWorkingDay,a.IsLate,a.IsAdvanceOut,a.ManagerL1,a.Role,a.Team,a.Client,
						a.Location,a.LOB,a.Band,a.Grade,a.Shift,a.TimeZone,a.AppWatcherEnabled,
						case when d.Present is null then 0 else d.Present end Present,
						case when d.DeclaredOff is null then 0 else d.DeclaredOff end DeclaredOff,
						case when d.ApprovedLeave is null then 0 else d.ApprovedLeave end ApporvedLeave
                     from Echolock.dbo.DailyDashboardData a(nolock)
                     inner join Echolock.dbo.UserHierarchy b  (nolock) on a.UserId = b.UserId
                     inner join Echolock.dbo.UserDetails c(nolock) on a.UserId = c.UserId
                     inner join Echolock.dbo.ViewARCAttendance d     (nolock) on d.UserId = a.UserId and d.EventDate = a.EventDate
                     where (b.ManagerUserId = case when @ManagerId is not null then @ManagerId else b.ManagerUserId end)
                           and (b.UserId = case when @UserId is not null then @UserId else b.UserId end)
                           and (b.ManagerLevel = case when @IncludeIndirect = 0 then 0 else b.ManagerLevel end)
                           and c.CompanyId = @CompanyId and a.EventDate >= @FromDate and a.EventDate <= @ToDate
                           and d.Present = @Present and d.DeclaredOff = @DeclaredOff     and d.ApprovedLeave = @ApprovedLeave
              and (isnull(a.[Location],'') = (case when @Location is not null then @Location else isnull(a.[Location],'') end))
              and (isnull(a.[Band],'') = (case when @Band is not null then @Band else isnull(a.[Band],'') end))
              
END
GO
/****** Object:  StoredProcedure [dbo].[EcholockImprovementAnalytics]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--======================================================================================
--Modified By              -      Promodh.Kumar
--Modified On              -      07/02/2020
--Modification Details     -      Added CostCode & Process
--======================================================================================
CREATE PROCEDURE [dbo].[EcholockImprovementAnalytics]
       @CompanyId int,
       @UserId nvarchar(128), -- will be null, if for manager
       @ManagerId nvarchar(128), -- will be null, if for individual user
       @IncludeIndirect bit, -- whether to include indirect reports or not
       @OnlyWorkDays bit, -- whether to calculate for workdays only or based on people's presence
       @FromDate datetime,
       @ToDate datetime 
AS
BEGIN
	set transaction Isolation level read uncommitted;
	SET NOCOUNT ON;

	IF OBJECT_ID('tempdb..#users') IS NOT NULL  drop table #users
	IF OBJECT_ID('tempdb..#filteredUsers') IS NOT NULL  drop table #filteredUsers
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL  drop table #dailylogs
	IF OBJECT_ID('tempdb..#userPackages') IS NOT NULL  drop table #userPackages
	IF OBJECT_ID('tempdb..#dailyAppUsage') IS NOT NULL  drop table #dailyAppUsage
	IF OBJECT_ID('tempdb..#applogs') IS NOT NULL  drop table #applogs

	declare @currentdate datetime = @FromDate
	declare @defpackage bigint

	create table #users
	(
		UserId nvarchar(128),
		WorkDays varchar(20)
	);

	create table #filteredUsers
	(
		UserId nvarchar(128),
		WorkDays datetime
	);

	create table #dailylogs
	(
		EventDate datetime,
		UserId nvarchar(128),
		TotalHours bigint,
		WorkHours bigint,
		LockHours bigint,
		ProdHrs float(2),
		NonProdHrs float(2),
		UnClassifiedHrs float(2),
		LateInHours int,
		AdvanceOutHours int,
		TargetTotal int
	);

	create table #userPackages
	(
		UserId nvarchar(128),
		PackageId bigint
	);

	create table #dailyAppUsage
	(
		UsageDate datetime,
		UserId nvarchar(128),
		AppId bigint,
		Classification int,
		TimeSpent float(2)
	);

	create table #applogs
	(
		UsageDate datetime,
		UserId nvarchar(128),
		Classification int,
		TimeSpent float(2)
	);

	--delete from #users

	if (@ManagerId is null and @UserId is not null)
	begin
		insert into #users
			select UserId, WorkDays
				from Echolock.dbo.UserDetails
				(nolock)
				where UserId = @UserId
					and CompanyId = @CompanyId
	end
	else if (@UserId is null and @ManagerId is not null)
	begin
		if (@IncludeIndirect = 1)
		begin
		insert into #users
			select distinct a.UserId, b.WorkDays
				from Echolock.dbo.UserHierarchy a
				(nolock)
					inner join Echolock.dbo.UserDetails b
						on a.UserId = b.UserId
				where ManagerUserId = @ManagerId
						and b.CompanyId = @CompanyId
		end
		else
		begin
			insert into #users
				select distinct a.UserId, b.WorkDays
					from Echolock.dbo.UserHierarchy a
					(nolock)
						inner join Echolock.dbo.UserDetails b
							on a.UserId = b.UserId
					where ManagerUserId = @ManagerId
						and ManagerLevel = 0
						and b.CompanyId = @CompanyId
		end
	end
	else
	begin
		insert into #users
			select UserId, WorkDays
				from Echolock.dbo.UserDetails
				(nolock)
				where CompanyId = @CompanyId
	end

	while (@currentdate <= @ToDate)
	begin
		if (@OnlyWorkDays=1)
		begin
			insert into #filteredUsers
				select distinct UserId, @currentdate
					from #users
					(nolock)
					where DATEPART(dw, @currentdate) - 1 in (select value
							from string_split(WorkDays, ','))
		end
		else
		begin
			insert into #filteredUsers
				select distinct a.UserId, @currentdate
					from #users a
						inner join Echolock.dbo.DailyEvents b
						(nolock)
							on a.UserId = b.UserId
								and b.Date = @currentdate
		end

		if exists (select top 1 UserId from #filteredUsers)
		begin
			delete from #dailyAppUsage
			delete from #applogs

			insert into #dailyAppUsage
				select @currentdate as CurrentDate, a.UserId, a.AppId, 
						a.Classification,
						a.TimeSpentms / 1000 TimeSpent
					from Echolock.dbo.DailyAppUsage a
					(nolock)
					where a.UserId in (select UserId
							from #filteredUsers
							(nolock)
							where WorkDays = @currentdate)
						and a.UsageDate = @currentdate
						and a.AppId not in (14,16,95635)

			insert into #applogs
				select UsageDate, UserId, Classification, SUM(TimeSpent) TimeSpent
						from #dailyAppUsage
						group by UsageDate, UserId, Classification

			--select UsageDate, UserId, TimeSpent
			--     from #applogs

			insert into #dailylogs
				select a.[Date], a.UserId,
						case when a.TotalHrs is not null then a.TotalHrs else 0 end,
						case when a.WorkHours is not null then a.WorkHours else 0 end,
						case when a.LockHrs is not null then a.LockHrs else 0 end,
						case when prod.TimeSpent is not null then (convert(float(2),prod.TimeSpent)) else 0 end,
						case when nonprod.TimeSpent is not null then (convert(float(2),nonprod.TimeSpent)) else 0 end,
						case when unclass.TimeSpent is not null then (convert(float(2),unclass.TimeSpent)) else 0 end,
						DATEDIFF(second, '0:00:00.000', isnull(a.LateIn, '00:00:00.000')) LateInHours,
						DATEDIFF(second, '0:00:00.000', isnull(a.AdvanceOut, '00:00:00.000')) AdvanceOutHours,
						case when ShiftFrom < ShiftTo then DATEDIFF(second, ShiftFrom, ShiftTo) else DATEDIFF(second, DATEADD(hour, 12, ShiftFrom), DATEADD(hour, -12, ShiftTo)) end TargetTotal
					from dbo.DailyEvents a
					(nolock)
						left join #applogs prod
							on a.UserId = prod.UserId and a.Date = prod.UsageDate and prod.Classification = 1
						left join #applogs nonprod
							on a.UserId = nonprod.UserId and a.Date = nonprod.UsageDate and nonprod.Classification = 2
						left join #applogs unclass
							on a.UserId = unclass.UserId and a.Date = unclass.UsageDate and unclass.Classification = 3
					where a.UserId in (select UserId
							from #filteredUsers
							(nolock)
							where WorkDays = @currentdate)
						and a.[Date] = @currentdate
		end

		set @currentdate = DATEADD(day, 1, @currentdate)
	end

	select *
			from #dailylogs
			order by EventDate desc, UserId asc

	IF OBJECT_ID('tempdb..#users') IS NOT NULL  drop table #users
	IF OBJECT_ID('tempdb..#filteredUsers') IS NOT NULL  drop table #filteredUsers
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL  drop table #dailylogs
	IF OBJECT_ID('tempdb..#userPackages') IS NOT NULL  drop table #userPackages
	IF OBJECT_ID('tempdb..#dailyAppUsage') IS NOT NULL  drop table #dailyAppUsage
	IF OBJECT_ID('tempdb..#applogs') IS NOT NULL  drop table #applogs
END
GO
/****** Object:  StoredProcedure [dbo].[EcholockMyTimeHourlyReport]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EcholockMyTimeHourlyReport]
AS
BEGIN
	DECLARE
	@CompanyId INT = 1,
	@UserId nvarchar(128) = NULL,     
	@FromDate DATETIME = GETDATE(),
	@RefTime time = '00:00:00'

	DECLARE @cTime DATETIME = DATEADD(HOUR,-1,DATEADD(MI,-330,GETDATE()))
	
	--declare @HSTime DATETIME, @HETime DATETIME  	
	----SET @HSTime =  DATEADD(HOUR, DATEDIFF(HOUR, 0, '2020-03-19 13:08:06.397' ), 0)
	--SET @HSTime =  DATEADD(HOUR, DATEDIFF(HOUR, 0, @cTime), 0)
	--SET @HETime = DATEADD(MILLISECOND,(1000*60*60)-10 ,@HSTime) 
	--select @cTime,@HSTime,@HETime , GETUTCDATE()	        
	--select DATEADD(HOUR, DATEDIFF(HOUR, 0, DATEADD(MI,330,@HSTime)), 0)

	SET @FromDate = (CASE WHEN CONVERT(TIME,@FromDate) BETWEEN '00:00:00:00' AND '07:00:00:00' THEN DATEADD(DAY,-1,CONVERT(DATE,@FromDate)) ELSE CONVERT(DATE,@FromDate) END)
	SET @FromDate = CONVERT(DATE,@FromDate)
           
	IF OBJECT_ID('tempdb..#result1') IS NOT NULL  drop table #result1  
	IF OBJECT_ID('tempdb..#source1logs') IS NOT NULL drop table #source1logs  
	IF OBJECT_ID('tempdb..#source2logs') IS NOT NULL drop table #source2logs        
	IF OBJECT_ID('tempdb..#TmpTblBreaklogs') IS NOT NULL  drop table #TmpTblBreaklogs        
	IF OBJECT_ID('tempdb..#TmpTblLockevents') IS NOT NULL drop table #TmpTblLockevents          
	IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users
	IF OBJECT_ID('tempdb..#TMPTBLMYTime') IS NOT NULL drop table #TMPTBLMYTime
	IF OBJECT_ID('tempdb..#uniqueApps') IS NOT NULL drop table #uniqueApps  
	IF OBJECT_ID('tempdb..#uniqueUrls') IS NOT NULL  drop table #uniqueUrls     
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL drop table #dailylogs        
	IF OBJECT_ID('tempdb..#appWatcher') IS NOT NULL drop table #appWatcher        
	IF OBJECT_ID('tempdb..#Applogs') IS NOT NULL DROP TABLE #Applogs
    IF OBJECT_ID('tempdb..#DailyAppUsage') IS NOT NULL drop table #DailyAppUsage
	IF OBJECT_ID('tempdb..#appusers') IS NOT NULL DROP TABLE #appusers
	IF OBJECT_ID('tempdb..#classifications') IS NOT NULL  DROP TABLE #classifications
	IF OBJECT_ID('tempdb..#appfinalresult') IS NOT NULL  DROP TABLE #appfinalresult
	IF OBJECT_ID('tempdb..#DailyAppUsage') IS NOT NULL drop table #DailyAppUsage
	IF OBJECT_ID('tempdb..#tmptbleoutput') IS NOT NULL drop table #tmptbleoutput
	IF OBJECT_ID('tempdb..##TemptableMytime_01') IS NOT NULL drop table ##TemptableMytime_01
		          
	create table #users          
	(          
		Id int identity(1,1),          
		UserId nvarchar(128),          
		ShiftId int,          
		FromTime datetime,          
		ToTime datetime,          
		ActualFromTime datetime,          
		ActualToTime datetime,          
		status bit default(1)          
	);          
	    
	create table #TmpTblLockevents          
	(          
		Id bigint identity(1,1),          
		EventTypeId int,          
		ShiftId int,          
		EventTime datetime,          
		UserId nvarchar(128),          
		AFromTime datetime,          
		AToTime datetime,        
		ReasonId int,        
		UserAccount varchar(100),        
		ComputerName varchar(100),
		WFH TINYINT,        
		status bit default(1)          
	);          
          
	create table #TmpTblBreaklogs        
	(        
		UserId nvarchar(128),
		EventTypeId int,
		EventName varchar(100),
		EventTime datetime,
		UserAccount varchar(100),
		ComputerName varchar(100),
		ReasonId int,
		ReasonName varchar(100)
	);
        
	create table #source1logs        
	(        
		RwNo int,        
		UserId nvarchar(128),        
		UserAccount varchar(100),        
		ComputerName varchar(100),        
		EventTime datetime,        
		EventName varchar(100),        
		ReasonName varchar(100),        
		ReasonId int        
	);        
        
	create table #source2logs        
	(        
		RwNo int,        
		UserId nvarchar(128),        
		UserAccount varchar(100),        
		EventTime datetime,        
		EventName varchar(100),        
		ReasonName varchar(100),        
		ReasonId int        
	);        
        
	create table #result1        
	(        
		UserId nvarchar(128),        
		EventDate datetime,        
		UserAccount varchar(100),        
		ComputerName varchar(100),        
		FromEvent varchar(100),        
		FromTime datetime,        
		ToEvent varchar(100),        
		ToTime datetime,        
		ReasonId int,        
		BreakReason varchar(100),        
		TimeSpent bigint,        
	);        
        
	declare @tc int = 0, @selectedUser nvarchar(128), @ltc int = 0          
	declare @ToDate datetime=dateadd(day,1,@FromDate)          
	declare @currentUserId nvarchar(128), @currentShiftTo datetime, @currentShiftFrom datetime          
	declare @duration int=0, @mtc int=0          
	declare @refstartdate datetime, @refenddate datetime, @refstartid bigint, @refstarteventtype int, @refendeventtype int          
	declare @actuallogin datetime, @actuallogout datetime          
	declare @HSTime DATETIME, @HETime DATETIME  , @HHour INT
	
	--SET @HSTime =  DATEADD(HOUR, DATEDIFF(HOUR, 0, '2020-03-19 13:08:06.397' ), 0)
	SET @HSTime =  DATEADD(HOUR, DATEDIFF(HOUR, 0, @cTime), 0)
	SET @HETime = DATEADD(MILLISECOND,(1000*60*60)-10 ,@HSTime) 
	set @HHour=  CONVERT(INT,CONVERT(VARCHAR(2), CONVERT(VARCHAR,DATEADD(HOUR, DATEDIFF(HOUR, 0, DATEADD(MI,330,@HSTime)), 0),108)))
	                    
	if (@UserId is null)        
	begin        
		insert into #users (UserId, ShiftId, FromTime, ToTime, ActualFromTime, ActualToTime)        
			select ud.UserId, ud.Shift,        
				dateadd(SECOND, -(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),
				DATEADD(second, -tz.CurrentUTCOffset, @FromDate +' '+convert(varchar(5), sft.WorkStartTime,108))) as FromTime,  
				
				case when sft.WorkEndTime > sft.WorkStartTime  
				then  DATEADD(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)), 
				DATEADD(second, -tz.CurrentUTCOffset, @FromDate+' ' +convert(varchar(5),sft.WorkEndTime,108)))  
				else  dateadd(SECOND,(1+(datediff(second,sft.WorkDuration,'23:59:59')/2)),
				DATEADD(second, -tz.CurrentUTCOffset, @ToDate+' ' +convert(varchar(5), sft.WorkEndTime,108))) end as ToTime,  								
				@HSTime,  @HETime			
				FROM UserDetails ud (nolock)        
				INNER JOIN LookupShift sft (nolock) on ud.Shift = sft.Id  
				INNER JOIN LookupTimeZone tz (nolock) on ud.TimeZone = tz.Id
				WHERE ud.[Status] =4 and [Location] IN ('Pune','Manila','Chennai','Coimbatore')
				--and NTLoginName in ('saravanakuma.r','promodh.kumar') 
	end      

	select @tc = count(*) from #users          
          
	while @tc!=0          
	begin          
		set @selectedUser = (select top 1 UserId          
		from #users          
		where status=1          
		order by Id desc)          
          
		insert into #TmpTblLockevents (UserId, EventTime, EventTypeId, ShiftId, AFromTime, AToTime, UserAccount, ComputerName, ReasonId,WFH)          
			select le.UserId, le.EventTime, le.EventTypeId, ud.ShiftId, ud.ActualFromTime, ud.ActualToTime, le.UserAccount, le.ComputerName, le.ReasonId,
			WFH = CONVERT(TINYINT, ARC_Enterprise.dbo.GetOfficeNetowrk_WFH(LE.ClientAddress))       
			from LockEvents le (nolock)          
				inner join #users ud on le.UserId=ud.UserId          
			where le.EventTime >=ud.FromTime          
				and le.EventTime <= ud.ToTime          
				and le.EventTypeId not in (4,10,12)          
				and le.UserId = @selectedUser        
						and le.EventStatus = 1 /* Added for processing only Valid Lock Events */  
			order by le.EventTime          
            
		set @ltc = (select count(distinct UserId)          
			from #TmpTblLockevents (nolock)          
			where UserId = @selectedUser)          
          
		while (@ltc!=0)          
		begin  
			select top 1 @currentUserId = UserId, @currentShiftTo = AToTime, @currentShiftFrom = AFromTime        
				from #TmpTblLockevents (nolock)        
				where status = 1        
				order by Id desc   
  
				/* --- Added to calculate within shift hours ---*/  
  
			/*Update eventtime for event, before the shift start time and after the shift end time*/  
			update #TmpTblLockevents set EventTime = @currentShiftFrom        
				where EventTime in (select top 1 EventTime        
					from #TmpTblLockevents        
					where UserId = @currentUserId        
					and EventTime <= @currentShiftFrom        
					order by EventTime desc)  
  
			update #TmpTblLockevents set EventTime = @currentShiftTo        
				where EventTime in (select top 1 EventTime        
					from #TmpTblLockevents        
					where UserId = @currentUserId        
					and EventTime >= @currentShiftTo  
					order by EventTime asc)  
          
			delete from #TmpTblLockevents        
				where UserId = @currentUserId        
					and (EventTime > @currentShiftTo or EventTime < @currentShiftFrom)        
        
			delete from #TmpTblLockevents        
				where UserId = @currentUserId        
					and EventTime < @currentShiftFrom   
					/* --- Added to calculate within shift hours ---*/  
          
			insert into #TmpTblBreaklogs (UserId, EventTypeId, EventTime, UserAccount, ComputerName, ReasonId, EventName, ReasonName)         
				select distinct le.UserId, le.EventTypeId, EventTime, UserAccount, ComputerName, ReasonId, evt.EventName, br.BreakReason        
					from #TmpTblLockevents  le (nolock)        
						inner join LookupBreakReason br on le.ReasonId = br.Id        
						inner join LookupEventType evt on evt.EventTypeId = le.EventTypeId        
					where le.EventTypeId in (0,1,2,3,5,6)        
						and le.UserId = @selectedUser        
						and le.status = 1        
					order by le.UserAccount, le.EventTime  
  
			update #TmpTblBreaklogs  
				set ReasonId = 3, ReasonName = 'Break'  
				where EventTypeId = 5  
        
			delete from #source1logs        
			delete from #source2logs        
        
			insert into #source1logs (RwNo, UserId, UserAccount, EventTime, EventName, ReasonName, ComputerName, ReasonId)        
				select row_number() over(partition by UserAccount order by UserAccount, EventTime) RwNo, UserId, UserAccount, EventTime, EventName, ReasonName, ComputerName, ReasonId        
					from #TmpTblBreaklogs        
					where UserId = @selectedUser        
        
			insert into #source2logs (RwNo, UserId, UserAccount, EventTime, EventName, ReasonName, ReasonId)   
				select row_number() over(partition by UserAccount order by UserAccount, EventTime) RwNo, UserId, UserAccount, EventTime, EventName, ReasonName, ReasonId        
					from #source1logs    
					where RwNo != 1  
        
			insert into #result1        
				select t1.UserId, @FromDate EventDate, t1.UserAccount, t1.ComputerName, t1.EventName as FromEvent, t1.EventTime FromTime,        
						t2.EventName as ToEvent, t2.EventTime as ToTime, t2.ReasonId ReasonId, t2.ReasonName BreakReason,        
						case when t2.EventTime is not null then datediff(s, t1.EventTime, t2.EventTime) else 0 end TimeSpent        
					from #source1logs t1        
						inner join #source2logs t2 on t1.RwNo = t2.RwNo and t1.UserAccount = t2.UserAccount  
  
			delete from #result1 where (FromEvent = ToEvent and ToEvent = 'Logoff')  
  
			delete from #result1 where FromTime = ToTime  
  
			/*select *  
				from #result1*/  
  
			update #result1  
				set ReasonId = 3, BreakReason = 'Break'  
				where  FromEvent = 'Logoff' and ToEvent = 'Logon'  
          
			update #TmpTblLockevents set status=0 where status=1 and UserId = @selectedUser and EventTypeId in (1,0)        
        
			set @ltc = @ltc - 1          
		end          
          
		update #users          
			set status=0          
			where status=1 and UserId=@selectedUser

		set @tc=@tc-1        
	end        
  
	select th.EventDate, th.UserId,th.TotalHrs,mh.MyTimeHrs,bh.BreakHrs,wfh.WFH
	INTO #TMPTBLMYTime
	from(
	select EventDate, UserId,SUM(TimeSpent)TotalHrs from #result1 group by EventDate, UserId
	)th
	left join (select UserId,SUM(TimeSpent)MyTimeHrs from #result1 where BreakReason = 'Production' group by UserId) Mh
	on mh.UserId = th.UserId  
	left join (select UserId,SUM(TimeSpent)BreakHrs from #result1 where BreakReason != 'Production' group by UserId)bh
	on bh.UserId = th.UserId
	left join (	select UserId,max(id)id,WFH from #TmpTblLockevents	group by UserId,WFH)wfh
	on th.UserId = wfh.UserId
	

	create table #appWatcher
	(        
		Id bigint identity(1,1),        
		AppName varchar(500) null,        
		BaseUrl nvarchar(max) null,  
		TimeSpent bigint,        
		UserId nvarchar(128),        
		status bit default(1)  
	);  
        
	create table #dailylogs
	(        
		Id bigint identity(1,1),        
		UserId nvarchar(128),        
		AppId bigint,  
		UsageDate datetime,  
		TimeSpentms bigint,  
		status bit default(1)  
	);

	create table #Applogs
	(        
		Id     bigint,
		UserId nvarchar(128),
		UserAccount   varchar(100),
		UserDomain    varchar(100),
		ComputerName  varchar(100),
		AppName       varchar(500),
		WindowTitle   varchar(500),
		BrowserUrl    nvarchar(max),
		StartTime     datetime2(7),
		EndTime       datetime2(7),
		TimeSpent     time(7),
		VersionId     varchar(100),
		CreatedOn     datetime2(7),
		OperatingSystem      varchar(100),
		BaseUrl       varchar(max),
		TimeSpentms   bigint
	) 

	create table #DailyAppUsage
	(
		UserId		NVARCHAR(128),
		Usagedate   DATETIME,
		AppID		BIGINT,
		Classification INT,
		Category       INT,	
		TimeSpentms bigint	
	)

	set @currentUserId = null
	set @currentShiftTo = null
	set @currentShiftFrom  = null    
	set @tc = 0
	set @selectedUser = null
	set @ltc = 0 

	UPDATE #users SET status = 1
	SELECT @tc = COUNT(*) FROM #users    
	    
	WHILE @tc!=0        
	BEGIN        
		SELECT TOP 1 @selectedUser = UserId, @currentShiftFrom = ActualFromTime, @currentShiftTo = ActualToTime
		FROM #users WHERE [status] = 1        		
			TRUNCATE TABLE #Applogs
			
				INSERT INTO #Applogs(Id,UserId,UserAccount,UserDomain,ComputerName,AppName,WindowTitle,
							BrowserUrl,StartTime,EndTime,TimeSpent,VersionId,CreatedOn,OperatingSystem,BaseUrl,TimeSpentms)
					SELECT Id,UserId,UserAccount,UserDomain,ComputerName,AppName,WindowTitle,
							BrowserUrl,StartTime,EndTime,TimeSpent,VersionId,CreatedOn,OperatingSystem,BaseUrl,TimeSpentms
						FROM echolock.dbo.AppWatcher(NOLOCK)
						WHERE UserId = @selectedUser 
							--AND StartTime >= @currentShiftFrom
							AND StartTime <=  @currentShiftTo
							AND EndTime >= @currentShiftFrom
							--AND EndTime <=  @currentShiftTo			     
			;WITH CTE AS
			(
				SELECT *, ROW_NUMBER() OVER (PARTITION BY UserId,StartTime,AppName,BrowserUrl ORDER BY StartTime,ID) AS RNO
				FROM #Applogs
			)

			DELETE FROM CTE WHERE RNO > 1

			update #Applogs set StartTime = @currentShiftFrom where StartTime < @currentShiftFrom
		
			update #Applogs set EndTime = @currentShiftTo where EndTime > @currentShiftTo

			update #Applogs set TimeSpentms = DATEDIFF(MS, StartTime, EndTime)

			INSERT INTO #appWatcher    
				SELECT AppName, NULL, SUM(TimeSpentms), UserId, 1    
					FROM #Applogs        
					WHERE BaseUrl IS NULL AND AppName <> ''    
					GROUP BY UserId, AppName    
    
			INSERT INTO #appWatcher    
				SELECT NULL, BaseUrl, SUM(TimeSpentms), UserId, 1    
					FROM #Applogs
					WHERE BaseUrl IS NOT NULL AND BaseUrl <> ''    
					GROUP BY UserId, BaseUrl 
             
			UPDATE #users SET STATUS = 0          
				WHERE STATUS = 1 and UserId = @selectedUser          

			SET @tc = @tc - 1     

			TRUNCATE TABLE #Applogs      
	END  
		select distinct AppName  
			into #uniqueApps  
			from #appWatcher  (nolock)  
			where AppName is not null  
  
		select distinct BaseUrl  
			into #uniqueUrls  
			from #appWatcher  (nolock)  
			where BaseUrl is not null  
  
		begin try                  
			begin tran  
  
			insert into echolock.dbo.LookupApps  
				select a.AppName, null, null, getdate(), 1  
					from #uniqueApps a  
					(nolock)  
					where not exists (select 'x'  
							from echolock.dbo.LookupApps b  
							(nolock)  
							where b.AppName = a.AppName)  
  
			insert into echolock.dbo.LookupApps  
				select null, a.BaseUrl, null, getdate(), 1  
					from #uniqueUrls a  
					(nolock)  
					where not exists (select 'x'  
							from echolock.dbo.LookupApps b  
							(nolock)  
							where b.BaseUrl = a.BaseUrl)  
			;  
  
			commit
		  end try  
		begin catch		          
			rollback				
		END CATCH 

			insert into #dailylogs  
					select a.UserId, b.Id, @FromDate, a.TimeSpent, 1  
						from #appWatcher a  
						(nolock)  
						inner join echolock.dbo.LookupApps b on a.AppName = b.AppName   
								and b.AppName is not null and a.AppName is not null  
  
			insert into #dailylogs  
					select a.UserId, b.Id, @FromDate, a.TimeSpent, 1  
						from #appWatcher a  
						(nolock)
						inner join echolock.dbo.LookupApps b on a.BaseUrl = b.BaseUrl
							and b.BaseUrl is not null and a.BaseUrl is not null
  
			merge #DailyAppUsage t      
			using #dailylogs s   
			on (s.UserId = t.UserId and s.UsageDate = t.UsageDate
			and s.AppId = t.AppId)  
			when matched then      
				update set t.TimeSpentms = s.TimeSpentms, t.Classification = 3, t.Category = 1
			when not matched by target then      
				insert (UserId, UsageDate, AppId, TimeSpentms, Classification, Category)  
					values (s.UserId, s.UsageDate, s.AppId, s.TimeSpentms, 3, 1);

			       
	CREATE TABLE #appusers      
	(      
		Id			INT IDENTITY(1,1),      
		UserId		NVARCHAR(128),
		PackageId	BIGINT,
		[status]	BIT DEFAULT(1)
	)
	DECLARE @defpackage BIGINT
	set @tc = 0
	set @selectedUser = null
	set @ltc = 0
	set @currentUserId = null
	SET @defpackage = (SELECT TOP 1 Id FROM Echolock.dbo.AppPackages(NOLOCK) WHERE CompanyId = @CompanyId AND IsDefault = 1)
	
	SELECT * INTO #classifications FROM Echolock.dbo.AppPackageClassification(NOLOCK)
	
	INSERT INTO #appusers (UserId, PackageId)
	SELECT u.UserId, CASE WHEN m.PackageId IS NOT NULL THEN m.PackageId ELSE @defpackage END
	FROM EchoLock.dbo.UserDetails(NOLOCK) u				
		LEFT OUTER JOIN Echolock.dbo.AppPackageMapping(NOLOCK) m
		ON u.UserId = m.UserId
	WHERE u.CompanyId = @CompanyId AND u.NTLoginName <> 'System' AND u.[Status] = 4  
	
		SELECT CurrentDate,UserId,AA.AppId,
			ISNULL(CASE WHEN AA.Classification IS NULL THEN cc.Classification ELSE aa.Classification END,3) AS Classification,
			ISNULL(CASE WHEN AA.Category IS NULL THEN cc.Category ELSE aa.Category END,1) AS category,aa.TimeSpentms
			into #appfinalresult
			FROM
			(
				SELECT @FromDate AS CurrentDate, a.UserId, a.AppId,c.Classification,c.Category,a.TimeSpentms					
					FROM #DailyAppUsage(NOLOCK) a				
						INNER JOIN #appusers p
						ON a.UserId = p.UserId AND a.UsageDate = @FromDate
						LEFT JOIN #classifications c
						ON p.PackageId = c.PackageId AND a.AppId = c.AppId
			)AA
			LEFT JOIN #classifications CC 
			ON CC.AppId = AA.AppId AND AA.Classification IS NULL  AND CC.PackageId = 1

			SELECT CurrentDate,UserId,
			CASE WHEN Classification = 1 then 'Productive'
			else case when Classification = 2 then 'NonProductive' 
			else case when Classification = 3 then 'UnClassified' END  END END Classification,
			SUM(TimeSpentms) TimeSpentms
			into #tmptbleoutput
			FROM #appfinalresult
			GROUP BY CurrentDate,UserId,Classification
				            
			DECLARE @TmpGlobalTable VARCHAR(MAX) = 'TemptableMytime_' + CONVERT(VARCHAR(MAX),'01')            
			DECLARE @DynamicPivotQuery AS NVARCHAR(MAX), @PivotColumnNames AS NVARCHAR(MAX)					           
			SELECT @PivotColumnNames= '[Productive],[NonProductive],[UnClassified]'

			SET @DynamicPivotQuery =
			N'SELECT CurrentDate,UserId, ' + @PivotColumnNames + '            
			INTO [##' + @TmpGlobalTable + ']  FROM #tmptbleoutput            
			PIVOT(MAX(TimeSpentms)            
			FOR Classification IN (' + @PivotColumnNames + ')) AS PVTTable'            
			EXEC sp_executesql @DynamicPivotQuery    
			insert into EchoLockHourlyMytimeData(ReportDate,NT_Username,HHour,Client,Functionality,LOB,FunctionalityGroup,Band,[Location],
			TotalHrs,MyTimeHrs,BreakHrs,ProductiveHrs,NonProductiveHrs,UnClassifiedHrs,WorkFromOffice,CreatedOn)
			SELECT mtm.EventDate,ud.NTLoginName,@HHour HHour,ud.Client,ud.Team,ud.LOB,ud.FunctionalityGroup,ud.band,ud.[location],
			TotalHrs= CONVERT(FLOAT,REPLACE(CONVERT(VARCHAR(5), DATEADD(SECOND, ISNULL(mtm.TotalHrs,0), 0), 108),':','.'))
			,MyTimeHrs = CONVERT(FLOAT,REPLACE(CONVERT(VARCHAR(5), DATEADD(SECOND, ISNULL(mtm.MyTimeHrs,0), 0), 108),':','.'))			
			,BreakHrs = CONVERT(FLOAT,REPLACE(CONVERT(VARCHAR(5), DATEADD(SECOND, ISNULL(mtm.BreakHrs,0), 0), 108),':','.'))
			,Productive = CONVERT(FLOAT,REPLACE(CONVERT(VARCHAR(5), DATEADD(MILLISECOND, ISNULL(t.Productive,0), 0), 108),':','.'))
			,NonProductive = CONVERT(FLOAT,REPLACE(CONVERT(VARCHAR(5), DATEADD(MILLISECOND, ISNULL(t.NonProductive,0), 0), 108),':','.'))
			,UnClassified = CONVERT(FLOAT,REPLACE(CONVERT(VARCHAR(5), DATEADD(MILLISECOND, ISNULL(t.UnClassified,0), 0), 108),':','.'))
			--ISNULL(mtm.TotalHrs,0)TotalHrs,ISNULL(MyTimeHrs,0)MyTimeHrs,ISNULL(BreakHrs,0)BreakHrs,
			--ISNULL([Productive],0)[Productive],ISNULL([NonProductive],0) [NonProductive],ISNULL([UnClassified],0) [UnClassified]
			,mtm.WFH, GETDATE()
			FROM #TMPTBLMYTime mtm
			LEFT JOIN ##TemptableMytime_01 t
			on t.UserId = mtm.UserId
			INNER JOIN UserDetails(NOLOCK)ud
			ON ud.UserId = mtm.UserId

IF OBJECT_ID('tempdb..#result1') IS NOT NULL  drop table #result1  
	IF OBJECT_ID('tempdb..#source1logs') IS NOT NULL drop table #source1logs  
	IF OBJECT_ID('tempdb..#source2logs') IS NOT NULL drop table #source2logs        
	IF OBJECT_ID('tempdb..#TmpTblBreaklogs') IS NOT NULL  drop table #TmpTblBreaklogs        
	IF OBJECT_ID('tempdb..#TmpTblLockevents') IS NOT NULL drop table #TmpTblLockevents          
	IF OBJECT_ID('tempdb..#users') IS NOT NULL drop table #users
	IF OBJECT_ID('tempdb..#TMPTBLMYTime') IS NOT NULL drop table #TMPTBLMYTime
	IF OBJECT_ID('tempdb..#uniqueApps') IS NOT NULL drop table #uniqueApps  
	IF OBJECT_ID('tempdb..#uniqueUrls') IS NOT NULL  drop table #uniqueUrls     
	IF OBJECT_ID('tempdb..#dailylogs') IS NOT NULL drop table #dailylogs        
	IF OBJECT_ID('tempdb..#appWatcher') IS NOT NULL drop table #appWatcher        
	IF OBJECT_ID('tempdb..#Applogs') IS NOT NULL DROP TABLE #Applogs
    IF OBJECT_ID('tempdb..#DailyAppUsage') IS NOT NULL drop table #DailyAppUsage
	IF OBJECT_ID('tempdb..#appusers') IS NOT NULL DROP TABLE #appusers
	IF OBJECT_ID('tempdb..#classifications') IS NOT NULL  DROP TABLE #classifications
	IF OBJECT_ID('tempdb..#appfinalresult') IS NOT NULL  DROP TABLE #appfinalresult
	IF OBJECT_ID('tempdb..#DailyAppUsage') IS NOT NULL drop table #DailyAppUsage
	IF OBJECT_ID('tempdb..#tmptbleoutput') IS NOT NULL drop table #tmptbleoutput
	IF OBJECT_ID('tempdb..##TemptableMytime_01') IS NOT NULL drop table ##TemptableMytime_01
END	
GO
/****** Object:  StoredProcedure [dbo].[EcholockUserHierarchyHourlyJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--======================================================================================        
--EcholockUserHierarchyHourlyJob - User Hierarchy Job for Echolock by Company      
--======================================================================================        
--Created By   -  Promodh.Kumar        
--Created On   -  25/04/2019
--Parameters   -  @CompanyId        
--======================================================================================        
--Modified By   -          
--Modified On   -      
--Modification Details -          
--======================================================================================        

CREATE proc [dbo].[EcholockUserHierarchyHourlyJob]
(
	@CompanyId int					-- Target Company Id
)
as
begin

	declare @currentLevel int = 1
	declare @lastLevel int = 0
	declare @continueloop bit = 1

	IF OBJECT_ID('tempdb..#masterUserList') IS NOT NULL drop table #masterUserList
	IF OBJECT_ID('tempdb..#hierarchy') IS NOT NULL drop table #hierarchy

	create table #masterUserList
	(
		UserId nvarchar(128) not null,
		CompanyId int not null,
		NTLoginName varchar(50) not null,
		ManagerL1 varchar(50) null,
		Status int null
	);

	insert into #masterUserList
		select a.UserId, a.CompanyId, 
				(case when b.UserIdentity is not null then b.NT_Username else a.NTLoginName end) NTLoginName,
				a.ManagerL1, a.Status
			from echolock.dbo.UserDetails a
			(nolock)
			left join ARC_Enterprise.dbo.ARC_REC_UserAuthentication b
			(nolock)
				on a.NTLoginName = b.UserIdentity and a.DomainName = b.Domain
			where a.CompanyId = @CompanyId
				and a.Status = 4

	select distinct a.UserId, a.CompanyId, a.NTLoginName, b.NTLoginName ManagerL1, b.UserId ManagerUserId, 0 Level, a.Status
		into #hierarchy
		from #masterUserList a
		(nolock)
			left join #masterUserList b
			(nolock)
				on a.ManagerL1 = b.NTLoginName and a.CompanyId = b.CompanyId
			
	while(@continueloop > 0)
	begin	
		if(@currentLevel > @lastLevel)
		begin

			select @lastLevel = (max(Level))
				from #hierarchy
				(nolock)

			insert into #hierarchy
				select distinct a.UserId, a.CompanyId, a.NTLoginName, c.NTLoginName ManagerL1, c.UserId ManagerUserId, @lastLevel + 1 Level, a.Status
					from #hierarchy a
					(nolock)
						inner join #hierarchy b
						(nolock)
							on a.ManagerUserId = b.UserId
								and a.CompanyId = b.CompanyId
								and b.Level = 0
						inner join #hierarchy c
						(nolock)
							on b.ManagerUserId = c.UserId
								and b.CompanyId = c.CompanyId
						where a.Level = @lastLevel

			if not exists (select 'x' from #hierarchy a
				(nolock)
				inner join #hierarchy b
				(nolock)
					on a.ManagerUserId = b.UserId
						and a.CompanyId = b.CompanyId
				where a.Level = @lastLevel + 1)
			begin
				set @continueloop = 0
			end
			else
			begin
				set @currentLevel = @lastLevel + 1
			end

		end
		else
		begin
			set @continueloop = 0
		end
	end

	--select *
	--	from #hierarchy
	--	(nolock)
	begin try
	begin tran

	delete from echolock.dbo.UserHierarchy
		where CompanyId = @CompanyId
			--UserId in (select distinct UserId from
			--#hierarchy)

	insert into echolock.dbo.UserHierarchy
		(CompanyId, UserId, NTLoginName, ManagerL1, ManagerUserId, ManagerLevel, Status)
		select CompanyId, UserId, NTLoginName, ManagerL1, ManagerUserId, Level, Status
			from #hierarchy

	commit
	end try
	begin catch
	 select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()
	 rollback
	end catch

	IF OBJECT_ID('tempdb..#masterUserList') IS NOT NULL drop table #masterUserList
	IF OBJECT_ID('tempdb..#hierarchy') IS NOT NULL drop table #hierarchy

end
GO
/****** Object:  StoredProcedure [dbo].[EcholockUserHistoryJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--======================================================================================      
--EcholockUserTodayJob - Daily User History update Job for Echolock by Company/ Individual      
--======================================================================================      
--Created By   -  Promodh.Kumar      
--Created On   -  12/11/2019      
--Parameters   -  @CompanyId, @UserId, @FromDate, @RefTime
--Notes     -  All Lock Event Time Calculations are in UTC      
--======================================================================================      
--Modified By   -
--Modified On   -
--Modification Details -
--======================================================================================
CREATE Proc [dbo].[EcholockUserHistoryJob]
(
	@CompanyId int,       -- Target Company Id
	@UserId nvarchar(128) = null,   -- Null, if for whole company
	@FromDate datetime      -- UTC
)
as
begin
		set transaction Isolation level read uncommitted;
		set nocount on

		declare @CompanyAppWatcher bit = 0

		select top 1 @CompanyAppWatcher = AppWatcher
			from Echolock.dbo.CompanyAppSettings
			(nolock)
			where CompanyId = @CompanyId

		IF OBJECT_ID('tempdb..#masterUserList') IS NOT NULL DROP TABLE #masterUserList
		IF OBJECT_ID('tempdb..#existingUsers') IS NOT NULL DROP TABLE #existingUsers

		select distinct ud.UserId, att.UserId ARCUserId, att.NT_UserName NTLoginName, att.[Date] EventDate, att.AttReporting_to Manager, esft.Id Shift, att.Shift_From ShiftFrom,
					att.Shift_to ShiftTo, att.Designid, att.Functionalityid, att.Client_id ClientId, att.AttLocationid LocationId,
					isnull(att.AttLobid, VY.LOBId) LOBId, fun.FunctionName Team, isnull(lob.lob, ud.LOB) LOB, desg.Designation Role, desg.Band Band, desg.Grade Grade,
					client.Client_Name Client, loc.LocationName as [Location], att.P_Days Present, isnull(app.AppWatcher, @CompanyAppWatcher) AppWatcher, att.IsDeclaredOff DeclaredOff,
					cc.CostCode, fun.[Type] Process,
					grp.GroupName, sgrp.SubGroupName, sfun.SubFunctionality, prj.Project, fgrp.FunctionalityGroupName
			into #masterUserList
			from ARC_Enterprise_Aug2019.dbo.ARC_REC_Attendance att
			(nolock)
			inner join ARC_Enterprise_Aug2019.dbo.ARC_REC_SHIFT_INFO sft
			(nolock)
					on att.ShiftId = sft.Shift_Id
			left join ARC_Enterprise_Aug2019.dbo.ARC_REC_LOB_INFO lob
			(nolock)
					on att.AttLobId = lob.ID
			left join ARC_Enterprise_Aug2019.dbo.HR_Functionality fun
			(nolock)
					on att.FunctionalityId = fun.FunctionalityId
			left join ARC_Enterprise_Aug2019.dbo.HR_FunctionalityGroups fgrp
			(nolock)
					on fun.FunctionalityGroupId = fgrp.FunctionalityGroupId
			left join ARC_Enterprise_Aug2019.dbo.HR_Designation desg
			(nolock)
					on att.DesignId = desg.DesigId
			left join ARC_Enterprise_Aug2019.dbo.ARC_FIN_CLIENT_INFO client
			(nolock)
					on att.Client_Id = client.Client_Id
			left join ARC_Enterprise_Aug2019.dbo.HR_LocationMaster loc
			(nolock)
					on att.AttLocationId = loc.LocationId
			left join ARC_Enterprise_Aug2019.dbo.ARC_REC_USER_INFO_VY VY
			(nolock)
					on att.UserId = VY.UserId
			left join ARC_Enterprise_Aug2019.dbo.HR_Costcode cc
			(nolock)
					on att.CostCodeId = cc.CostCodeId
			left join ARC_Enterprise_Aug2019.dbo.HR_FunctionGroup grp
			(nolock)
				on att.GroupId = grp.GroupId
			left join ARC_Enterprise_Aug2019.dbo.HR_FunctionSubGroup sgrp
			(nolock)
				on att.SubGroupId = sgrp.SubGroupId
			left join ARC_Enterprise_Aug2019.dbo.HR_SubFunctionality sfun
			(nolock)
				on att.SubFunctionalityId = sfun.SubFunctionalityId
			left join ARC_Enterprise_Aug2019.dbo.HR_Project prj
			(nolock)
				on att.ProjectId = prj.ProjectId
			left join Echolock.dbo.UserDetails ud
			(nolock)
					on att.NT_UserName = ud.NTLoginName
			left join Echolock.dbo.LookupShift esft
			(nolock)
					on sft.SHIFT_NAME = esft.ShiftName and sft.SHIFT_FROM = esft.WorkStartTime and sft.SHIFT_TO = esft.WorkEndTime
			left join Echolock.dbo.UserAppSettings app
			(nolock)
					on ud.UserId = app.UserId
			where att.[Date] = @FromDate
					and ud.UserId = isnull(@UserId, ud.UserId)
					and ud.CompanyId = @CompanyId
					and att.AttLocationid NOT IN (7,8)

		select *
			into #existingUsers
			from #masterUserList
			where UserId is not null

		begin try

		begin tran
			merge Echolock.dbo.DailyDashboardData t
			using #existingUsers s
			on (s.UserId = t.UserId and s.EventDate = t.EventDate)
			when matched then
				update set t.ManagerL1 = s.Manager, t.Role = s.Role, t.Team = s.Team, t.Client = s.Client, t.Location = s.Location,
					t.LOB = s.LOB, t.Band = s.Band, t.Grade = s.Grade, t.Shift = s.Shift, t.TimeZone = case when s.Location = 'Manila' then 107 else 90 end,
					t.IsWorkingDay = case when s.Present > 0 then 1 else 0 end, t.AppWatcherEnabled = isnull(s.AppWatcher, 0),
					t.TotalHours = 0, t.WorkHours = 0, t.LockHours = 0, t.ProdHrs = 0, t.NonProdHrs = 0, t.UnClassifiedHrs = 0,
					t.ARCUserId = s.ARCUserId, t.NTLoginName = s.NTLoginName, t.ShiftFrom = s.ShiftFrom,
					t.ShiftTo = s.ShiftTo, t.Present = s.Present, t.IsDeclaredOff = s.DeclaredOff, t.ModifiedOn = getdate(),
					t.CostCode = s.CostCode, t.Process = s.Process,
					t.[Group] = s.GroupName, t.SubGroup = s.SubGroupName,
					t.SubFunctionality = s.SubFunctionality, t.Project = s.Project, t.FunctionalityGroup = s.FunctionalityGroupName
			when not matched by target then
				insert (EventDate, UserId, ManagerL1, Role, Team, Client, Location, LOB, Band, Grade, Shift, TimeZone, IsWorkingDay,
							TotalHours, WorkHours, LockHours, ProdHrs, NonProdHrs, UnClassifiedHrs, AppWatcherEnabled, ARCUserId, ShiftFrom, ShiftTo, NTLoginName,
							Present, IsDeclaredOff, CreatedOn, CostCode, Process, [Group], SubGroup, SubFunctionality, Project, FunctionalityGroup)
					values (s.EventDate, s.UserId, s.Manager, s.Role, s.Team, s.Client, s.Location,
							s.LOB, s.Band, s.Grade, s.Shift, case when s.Location = 'Manila' then 107 else 90 end, s.Present, 0, 0, 0, 0, 0, 0, s.AppWatcher,
							s.ARCUserId, s.ShiftFrom, s.ShiftTo, s.NTLoginName, s.Present, s.DeclaredOff, getdate(), s.Costcode, s.Process, s.GroupName, s.SubGroupName,
							s.SubFunctionality, s.Project, s.FunctionalityGroupName)
			;
			commit
              
		end try
		begin catch

			rollback

			select convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
								getdate(), 'UserHistoryJob', 'SQL Server'

			insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)
				values ('DB UserHistoryJob Error', 
						convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
						getdate(), 'UserHistoryJob', 'SQL Server')
			insert into ARC_Enterprise_Aug2019.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)
				values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',
						'Error in UserHistoryJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
						0, 'Y', getdate(), null, 1)

		end catch

		IF OBJECT_ID('tempdb..#existingUsers') IS NOT NULL DROP TABLE #existingUsers
		IF OBJECT_ID('tempdb..#masterUserList') IS NOT NULL DROP TABLE #masterUserList

		exec Echolock.dbo.UserHierarchyHistoryJob @CompanyId, @UserId, @FromDate
end
GO
/****** Object:  StoredProcedure [dbo].[EcholockUserTodayJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--======================================================================================      
--EcholockUserTodayJob - Daily User Today update Job for Echolock by Company/ Individual      
--======================================================================================      
--Created By   -  Promodh.Kumar      
--Created On   -  12/11/2019      
--Parameters   -  @CompanyId, @UserId, @FromDate, @RefTime
--Notes     -  All Lock Event Time Calculations are in UTC      
--======================================================================================      
--Modified By   -
--Modified On   -
--Modification Details -
--======================================================================================

CREATE Proc [dbo].[EcholockUserTodayJob]
(
	@CompanyId int,       -- Target Company Id
	@UserId nvarchar(128) = null,   -- Null, if for whole company
	@FromDate datetime      -- UTC
)
as
begin
		set transaction Isolation level read uncommitted;
		set nocount on

		declare @CompanyAppWatcher bit = 0

		select top 1 @CompanyAppWatcher = AppWatcher
				from Echolock.dbo.CompanyAppSettings
				(nolock)
				where CompanyId = @CompanyId

		IF OBJECT_ID('tempdb..#masterUserList') IS NOT NULL DROP TABLE #masterUserList
		IF OBJECT_ID('tempdb..#existingUsers') IS NOT NULL DROP TABLE #existingUsers

		select distinct ud.UserId, null ARCUserId, ud.NTLoginName, @FromDate EventDate, ud.ManagerL1 Manager, esft.Id Shift, esft.WorkStartTime ShiftFrom,
						esft.WorkEndTime ShiftTo, ud.Team, ud.LOB, ud.Role, ud.Band, ud.Grade,
						ud.Client, ud.[Location], null Present, isnull(app.AppWatcher, @CompanyAppWatcher) AppWatcher, null DeclaredOff,
						ud.[Group], ud.SubGroup, ud.SubFunctionality, ud.Project, ud.FunctionalityGroup
				into #masterUserList
				from Echolock.dbo.UserDetails ud
				left join Echolock.dbo.LookupShift esft
				(nolock)
						on ud.Shift = esft.Id
				left join Echolock.dbo.UserAppSettings app
				(nolock)
						on ud.UserId = app.UserId
				where ud.UserId = isnull(@UserId, ud.UserId)
							and ud.CompanyId = @CompanyId
				and ud.[Location] not in ('Noida','Trivandrum')

		select *
				into #existingUsers
				from #masterUserList
				where UserId is not null

		begin try

		begin tran
            merge Echolock.dbo.DailyDashboardData t
            using #existingUsers s
            on (s.UserId = t.UserId and s.EventDate = t.EventDate)
            when matched then
                update set t.ManagerL1 = s.Manager, t.Role = s.Role, t.Team = s.Team, t.Client = s.Client, t.Location = s.Location,
            t.LOB = s.LOB, t.Band = s.Band, t.Grade = s.Grade, t.Shift = s.Shift, t.TimeZone = case when s.Location = 'Manila' then 107 else 90 end,
            t.IsWorkingDay = case when s.Present > 0 then 1 else 0 end,
                        t.ARCUserId = s.ARCUserId, t.NTLoginName = s.NTLoginName, t.ShiftFrom = s.ShiftFrom,
                        t.ShiftTo = s.ShiftTo, t.Present = s.Present, t.IsDeclaredOff = s.DeclaredOff, t.ModifiedOn = getdate(),
						t.[Group] = s.[Group], t.SubGroup = s.SubGroup, t.SubFunctionality = s.SubFunctionality, t.Project = s.Project, t.FunctionalityGroup = s.FunctionalityGroup
            when not matched by target then
                insert (EventDate, UserId, ManagerL1, Role, Team, Client, Location, LOB, Band, Grade, Shift, TimeZone, IsWorkingDay,
                                TotalHours, WorkHours, LockHours, ProdHrs, NonProdHrs, UnClassifiedHrs, AppWatcherEnabled, ARCUserId, ShiftFrom, ShiftTo, NTLoginName,
                                Present, IsDeclaredOff, CreatedOn, [Group], SubGroup, SubFunctionality, Project, FunctionalityGroup)
                        values (s.EventDate, s.UserId, s.Manager, s.Role, s.Team, s.Client, s.Location,
                                s.LOB, s.Band, s.Grade, s.Shift, case when s.Location = 'Manila' then 107 else 90 end, isnull(s.Present, 1), 0, 0, 0, 0, 0, 0, s.AppWatcher,
                                s.ARCUserId, s.ShiftFrom, s.ShiftTo, s.NTLoginName, s.Present, s.DeclaredOff, getdate(), s.[Group], s.SubGroup,
								s.SubFunctionality, s.Project, s.FunctionalityGroup)
            ;
            commit
              
		end try
		begin catch

			rollback

			select convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
								getdate(), 'EcholockUserTodayJob', 'SQL Server'

			insert into echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)
						values ('DB EcholockUserTodayJob Error', 
								convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
								getdate(), 'EcholockUserTodayJob', 'SQL Server')
			insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)
				values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',
						'Error in EcholockUserTodayJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),
						0, 'Y', getdate(), null, 1)

		end catch

		IF OBJECT_ID('tempdb..#existingUsers') IS NOT NULL DROP TABLE #existingUsers
		IF OBJECT_ID('tempdb..#masterUserList') IS NOT NULL DROP TABLE #masterUserList

		exec Echolock.dbo.UserHierarchyHistoryJob @CompanyId, @UserId, @FromDate
end
GO
/****** Object:  StoredProcedure [dbo].[EchoTeamAppData]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EchoTeamAppData]
(
	@ShiftTime TIME, /*'11:25:00.0000000'*/
	@UsageDate DATE /*'2019-12-31'*/
)
AS
BEGIN
	IF OBJECT_ID('tempdb..#TempTblEchoTeam') IS NOT NULL DROP TABLE #TempTblEchoTeam
	SELECT
	AP.UsageDate,ud.NTLoginName,UD.Client,UD.Team,UD.ManagerL1,
	ap.AppId,
	CASE WHEN LA.AppName IS NULL THEN LEFT(LA.BaseUrl,30000)  ELSE LA.AppName END AppURL,
	CASE WHEN LA.AppName IS NULL THEN 'URL' ELSE 'APP' END [TYPE],
	CASE WHEN AP.Classification = 1  THEN 'Production' ELSE 
	CASE WHEN AP.Classification = 2  THEN 'Non-Production' ELSE 
	'UnClassified'END END AS Classification,LAC.CategoryName,
	CASE WHEN LA.AliasName IS NULL  THEN 'UnClassified' ELSE LA.AliasName END AS DisplayName,
	ud.[Location],dda.Present,LS.WorkStartTime,LS.WorkEndTime,AP.TimeSpentms
	INTO #TempTblEchoTeam
	FROM DailyAppUsage(NOLOCK)AP
	INNER JOIN UserDetails(NOLOCK)ud ON ud.UserId = ap.UserId
	INNER JOIN LookupAppCategories(NOLOCK)LAC ON LAC.Id = AP.Category
	INNER JOIN LookupApps(NOLOCK)LA ON LA.Id = AP.AppId
	INNER JOIN DailyDashboardData(NOLOCK)DDA 
	ON DDA.UserId = AP.UserId AND DDA.EventDate = AP.UsageDate
	INNER JOIN lookupshift(NOLOCK)LS ON LS.ID = UD.[SHIFT]
	WHERE UD.Band = 1 AND AppId NOT IN (14,16) 
	AND LS.WorkDuration =@ShiftTime  AND ap.UsageDate = @UsageDate

	SELECT CategoryName,DisplayName,
	ISNULL(Production,'00:00:00.0000000')Production,
	ISNULL([Non-Production],'00:00:00.0000000')NonProduction,
	ISNULL(Unclassified,'00:00:00.0000000')Unclassified
	FROM(
		SELECT CategoryName,DisplayName,Classification,
		CONVERT(TIME,TRIM(
		SUBSTRING(
		CONVERT(VARCHAR,DATEADD(MS,TimeSpentms,0),21),
		CHARINDEX(' ',CONVERT(VARCHAR,DATEADD(MS,TimeSpentms,0),21)),
		LEN(CONVERT(VARCHAR,DATEADD(MS,TimeSpentms,0),21))
		)))TimeSpend
		FROM(
			SELECT CategoryName,DisplayName,Classification,
			CONVERT(FLOAT,SUM(TimeSpentms))/COUNT(DISTINCT NTLoginName) TimeSpentms
			FROM #TempTblEchoTeam
			GROUP BY CategoryName,DisplayName,Classification
		)A
	)B
	PIVOT(
	MAX(TimeSpend)
	FOR Classification IN (Production,[Non-Production],Unclassified)
	) AS PVTTable
	ORDER BY 3 DESC

	SELECT * FROM #TempTblEchoTeam

	IF OBJECT_ID('tempdb..#TempTblEchoTeam') IS NOT NULL DROP TABLE #TempTblEchoTeam
END
GO
/****** Object:  StoredProcedure [dbo].[EventLogUpdate]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EventLogUpdate]
(
	@Data EventLogType READONLY,
	@RunTime BIGINT,
	@TimeZone VARCHAR(250),
	@IPv4	VARCHAR(50) NULL,
	@IPv6	VARCHAR(50) NULL,
	@OSEdition VARCHAR(250) NULL,
	@VersionID VARCHAR(50) = NULL,
	@SysDateFormat	VARCHAR(50) = NULL,
	@SysTimeFormat VARCHAR(50) = NULL
)
AS
BEGIN
DECLARE @Result VARCHAR(MAX)
	BEGIN TRY           
		BEGIN TRANSACTION
			IF OBJECT_ID('tempdb..#TmbTblEventLogs') IS NOT NULL DROP TABLE #TmbTblEventLogs
			SELECT *,@RunTime AS RunTime, @TimeZone as TimeZone,@IPv4 AS IPv4,@IPv6 AS IPv6
			,@OSEdition as OSEdition,@VersionID as VersionID,@SysDateFormat as SysDateFormat
			,@SysTimeFormat as SysTimeFormat
			INTO #TmbTblEventLogs FROM @Data

			MERGE EventLog EL
			USING #TmbTblEventLogs tmp
			ON tmp.UserAccount = EL.UserAccount AND tmp.ComputerName = EL.ComputerName
			AND tmp.EventMachine = EL.EventMachine AND tmp.TimeGenerated = EL.TimeGenerated
			WHEN NOT MATCHED BY TARGET THEN 
			
			INSERT (UserAccount, ComputerName, EventUserName, EventMachine, InstanceID, EventID,
				EventDate,EventTime, EventMessage, EventSource,  TimeGenerated, RunTime,TimeZone,IPv4,IPv6
				,OSEdition,VersionID,SysDateFormat,SysTimeFormat)

			VALUES(tmp.UserAccount, tmp.ComputerName, tmp.EventUserName, tmp.EventMachine, tmp.InstanceID,
				tmp.EventID,tmp.EventDate, tmp.EventTime, tmp.EventMessage, tmp.EventSource, tmp.TimeGenerated
				,tmp.RunTime,tmp.TimeZone,tmp.IPv4,tmp.IPv6,tmp.OSEdition,tmp.VersionID
				,tmp.SysDateFormat,tmp.SysTimeFormat)
			;
			
		COMMIT TRANSACTION
		SET @Result = 'Success'  
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @Result = ERROR_MESSAGE()	
	END CATCH	
IF OBJECT_ID('tempdb..#TmbTblEventLogs') IS NOT NULL DROP TABLE #TmbTblEventLogs
SELECT @Result AS Result	
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllTableSizes_Dialy]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllTableSizes_Dialy]        
AS        
/*
 Created by : Narayana.N
 Created Date: 03-21-2018
 Perpose: To monitor table grouth   
  
*/       
begin  
set nocount on; 
    
CREATE TABLE #TempTable        
(  
  tableName varchar(100),        
    numberofRows bigint,        
    reservedSize varchar(50),        
    dataSize varchar(50),        
    indexSize varchar(50),        
    unusedSize varchar(50)        
)  
  
DECLARE @TableName VARCHAR(100) ,@SchemaName Varchar(100),@qury varchar(max)       
DECLARE tableCursor  CURSOR        
FOR         
select   SCHEMA_NAME(schema_id) As SchemaName,name    
from sys.tables where type='u'  
OPEN tableCursor        
FETCH NEXT FROM tableCursor  INTO @SchemaName,@TableName       
        
WHILE @@Fetch_Status = 0        
BEGIN        
set @qury  =''  
set @qury  = @qury  + '  
INSERT  #TempTable    
EXEC sp_spaceused ''['+ @SchemaName +'].['+ @TableName+']'''     
exec (@qury  )  
FETCH NEXT FROM tableCursor INTO @SchemaName,@TableName    
END        
        
   
CLOSE tableCursor        
DEALLOCATE tableCursor        
  
--SELECT *FROM #TempTable  order by numberofRows desc      
insert into DBAevents_11.dbo.DialyTableCountDetails  
select @@SERVERNAME, DB_NAME(),*,CONVERT(date, getdate()) from #TempTable   
  
DROP TABLE #TempTable   
  
end  

GO
/****** Object:  StoredProcedure [dbo].[GetTableSpaceUsed]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetTableSpaceUsed]
AS
BEGIN
IF OBJECT_ID('tempdb..#TmpTblSpaceUsed') IS NOT NULL DROP TABLE #TmpTblSpaceUsed
CREATE TABLE #TmpTblSpaceUsed (
TableName sysname,
NumRows BIGINT,
ReservedSpace VARCHAR(80),
DataSpace VARCHAR(80),
IndexSize VARCHAR(80),
UnusedSpace VARCHAR(80)) 

DECLARE @str VARCHAR(800)
SET @str = 'EXEC sp_spaceused ''?'''
INSERT INTO #TmpTblSpaceUsed 
EXEC sp_msforeachtable @command1 = @str

--INSERT INTO TableSpaceUsed(TableName,NumRows,ReservedSpace,DataSpace,IndexSize,UnusedSpace)
SELECT TableName, NumRows, 
CONVERT(numeric(18,0),REPLACE(ReservedSpace,' KB','')) / 1024 as ReservedSpace_MB,
CONVERT(numeric(18,0),REPLACE(DataSpace,' KB','')) / 1024 as DataSpace_MB,
CONVERT(numeric(18,0),REPLACE(IndexSize,' KB','')) / 1024 as IndexSpace_MB,
CONVERT(numeric(18,0),REPLACE(UnusedSpace,' KB','')) / 1024 as UnusedSpace_MB
FROM #TmpTblSpaceUsed 
WHERE TableName IN ('AppWatcher','LockEvents')

IF OBJECT_ID('tempdb..#TmpTblSpaceUsed') IS NOT NULL DROP TABLE #TmpTblSpaceUsed

DECLARE @body varchar(MAX)
SET @body = cast( (
SELECT td = hTableName 
		+ '</td><td>' + CAST(hNumRows as varchar(80) ) 
		+ '</td><td>' + CAST(hReservedSpace as varchar(80))
		+ '</td><td>' + CAST(hDataSpace as varchar(80))
		+ '</td><td>' + CAST(hIndexSize as varchar(80))
		+ '</td><td>' + CAST(hUnusedSpace as varchar(80))
FROM (
      SELECT 
		hTableName = TableName,
		hNumRows = NumRows,
		hReservedSpace = ReservedSpace,
		hDataSpace = DataSpace,
		hIndexSize = IndexSize,
		hUnusedSpace = UnusedSpace
	 from TableSpaceUsed 
	 WHERE convert(date,CreatedOn) =  convert(date,GETDATE())
      ) as d
for xml path( 'tr' ), type ) as varchar(max) )
SET @body = '<table cellpadding="2" cellspacing="2" border="1">'
              + '<tr>
			  <th>TableName</th>
			  <th>NumRows</th>
			  <th>ReservedSpace</th>
			  <th>DataSpace</th>
			  <th>IndexSize</th>
			  <th>UnusedSpace</th>			  
			  </tr>'
              + replace( replace( @body, '&lt;', '<' ), '&gt;', '>' )
              + '<p>Hi</p><table><br>'

INSERT INTO ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
VALUES ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;karmegan.c1@accesshealthcare.com',    
'Echolock Table Space', @body,0, 'Y', GETDATE(), NULL, 1)  
END
GO
/****** Object:  StoredProcedure [dbo].[INDEX_Rebulid_Fragmentation]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[INDEX_Rebulid_Fragmentation]          
AS          
Begin         
        
Set Nocount on;         
          
Declare @TC int,@indexName nvarchar(500),@TableName Nvarchar(100),@idint int,@index_id int          
,@avg_fragmentation_in_percent numeric(18,2),@DBLog numeric(18,2),@qry nvarchar(500)          
          
SELECT name IndexName,OBJECT_NAME(a.object_id) TableName,avg_fragmentation_in_percent,b.index_id into #temptable          
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS a          
JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id           
where  name is not null and avg_fragmentation_in_percent>=5 and page_count >=100      
       
          
Set @TC=(select COUNT(*) from #temptable)          
          
          
while @tc!=0                  
begin                  
                  
select @index_id=index_id,@TableName =TableName,@indexName=IndexName,@avg_fragmentation_in_percent=avg_fragmentation_in_percent from #temptable           
        
if @avg_fragmentation_in_percent>=30        
begin        
          
insert into [DBAevents_11].dbo.IndexRebulidDetails(DBNAME,TableName,IndexName,REBulidStart,BFIndexFra,BLogs)          
select DB_NAME(),@TableName,@indexName,GETDATE(),@avg_fragmentation_in_percent,size from sys.database_files where type =1          
          
set @idint=SCOPE_IDENTITY()          
        
if @index_id=1        
Begin        
DBCC DBReindex(@TableName,@indexName,80)         
End         
else         
Begin        
DBCC DBReindex(@TableName,@indexName,70)          
end        
         
          
          
SELECT @avg_fragmentation_in_percent=avg_fragmentation_in_percent          
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS a          
JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id           
where  name=@indexName and OBJECT_NAME(a.object_id)=@TableName          
          
select @DBLog=size from sys.database_files where type =1          
          
          
update [DBAevents_11].dbo.IndexRebulidDetails set RebulidEnd=GETDATE(),AFIndexFra=@avg_fragmentation_in_percent,ALogs=@DBLog where  id=@idint            
end        
Else if @avg_fragmentation_in_percent>5 and @avg_fragmentation_in_percent<30        
begin        
        
insert into [DBAevents_11].dbo.IndexRebulidDetails(DBNAME,TableName,IndexName,REBulidStart,BFIndexFra,BLogs)          
select DB_NAME(),@TableName,@indexName,GETDATE(),@avg_fragmentation_in_percent,size from sys.database_files where type =1          
          
set @idint=SCOPE_IDENTITY()          
          
set @qry= 'ALTER INDEX '+@indexName+' ON '+@TableName+' REORGANIZE ; '              
 EXEC sp_executesql @qry            
          
          
SELECT @avg_fragmentation_in_percent=avg_fragmentation_in_percent          
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS a          
JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id           
where  name=@indexName and OBJECT_NAME(a.object_id)=@TableName          
          
select @DBLog=size from sys.database_files where type =1          
          
          
update [DBAevents_11].dbo.IndexRebulidDetails set RebulidEnd=GETDATE(),AFIndexFra=@avg_fragmentation_in_percent,ALogs=@DBLog where  id=@idint            
        
        
        
        
End          
                  
set @tc=@tc-1                  
delete from #temptable where IndexName =@indexName                  
end         
        
        
Set Nocount OFF;         
            
Drop table #temptable;         
End 



GO
/****** Object:  StoredProcedure [dbo].[MissingIndex]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[MissingIndex]        
as    
Begin  
Create Table #tempU  
(  
Pid int identity(1,1),  
ID int,  
Imapact bigint,  
Seek datetime,  
TableName varchar(300),  
IndexNameCreate varchar(800),  
IndexName varchar(100) default(Null)  
)  
  
  
insert into #tempU(ID,Imapact,Seek,TableName,IndexNameCreate,IndexName)    
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
 INDName      
FROM sys.dm_db_missing_index_groups dm_mig          
INNER JOIN sys.dm_db_missing_index_group_stats dm_migs          
ON dm_migs.group_handle = dm_mig.index_group_handle          
INNER JOIN sys.dm_db_missing_index_details dm_mid          
ON dm_mig.index_handle = dm_mid.index_handle          
WHERE dm_mid.database_ID = DB_ID() and avg_user_impact>80  
ORDER BY Avg_Estimated_Impact DESC     
  
select * from #tempU  
  
delete from #tempU where Pid in (  
select MAX(pid) from #tempU group by indexName having COUNT(*)>1 )  
  
select distinct IndexNameCreate,IndexName  from #tempU where IndexName not in (select isnull(name,'') from sys.indexes)  
  
End        
  




GO
/****** Object:  StoredProcedure [dbo].[Proc_spark]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Proc_spark]
	@BrowserUrl varchar(max),
	@AppName varchar(250),
	@UserDomain varchar(250),
	@WindowTitle varchar(250),
	@StartTime varchar(50),
	@EndTime varchar(50),
	@TimeSpent varchar(50),
	@VersionId varchar(10),
	@CreatedOn varchar(250),
	@OperatingSystem varchar(250)
	as
	begin
	create table #temp (BrowserUrl varchar(max)
						,AppName varchar(250),
						UserDomain varchar(250),
						WindowTitle varchar(250),
						StartTime varchar(50),
						EndTime varchar(50),
						TimeSpent varchar(50),
						VersionId varchar(10),
						CreatedOn varchar(250),
						OperatingSystem varchar(250)						
	)
	insert into #temp values (
	    @BrowserUrl 
	   ,@AppName 
	   ,@UserDomain 
	   ,@WindowTitle 
	   ,@StartTime 
	   ,@EndTime
	   ,@TimeSpent 
	   ,@VersionId 
	   ,@CreatedOn 
	   ,@OperatingSystem
	)
select #temp.*,
       UserpackageMapping.PackageId , ac.classification, ac1.classification,
       case 
	   when (ac.Classification is null and #temp.BrowserUrl is null and ac1.Classification =2) then 'NonProductive'
	   when (ac.Classification is null and #temp.BrowserUrl is null and ac1.Classification =1) then 'Productive'
       when ac.Classification = 1 and #temp.BrowserUrl != ''  then 'Productive'
       when ac.Classification = 2 and #temp.BrowserUrl != '' then 'NonProductive'
	   when ac1.Classification = 1 and #temp.BrowserUrl = ''  then 'Productive'
       when ac1.Classification = 2 and #temp.BrowserUrl = null then 'NonProductive'
       else 'Unclassified' end as Classification from #temp
       join UserpackageMapping on UserpackageMapping.NTLoginName = #temp.UserAccount 
       left join LookupApps a on a.BaseUrl= #temp.BrowserUrl 
	   left join LookupApps b on b.AppName= #temp.AppName
       left join AppPackageClassification ac on UserpackageMapping.PackageId =  ac.PackageId 
       and a.Id = ac.AppId 
	   left join AppPackageClassification ac1 on UserpackageMapping.PackageId =  ac1.PackageId 
       and b.Id = ac1.AppId order by #temp.UserAccount desc

	   drop table #temp
end
GO
/****** Object:  StoredProcedure [dbo].[ReadvendorCallRecords]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReadvendorCallRecords] 
@TYPE VARCHAR(50) NULL,
@FromDate datetime null,
@ToDate datetime null

AS
	BEGIN  
		
			SELECT * FROM  vendorCallRecords 
			WHERE Vendor = @TYPE and convert(date, convert(varchar(50),CallinitiatedTime,101)) >= CONVERT(DATE, CONVERT(varchar(50),
		    @FromDate,101)) and  convert(date,convert(varchar(50),CallinitiatedTime,101)) <= CONVERT(DATE, CONVERT(varchar(50),
		    @ToDate,101)) 
	END
GO
/****** Object:  StoredProcedure [dbo].[ReviewAppLogs]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReviewAppLogs]
AS
BEGIN

	--select top 0 ComputerName, EventTypeId, EventTime,1 Remarks
	--	from Echolock.dbo.LockEvents
	--	(nolock)

	DECLARE @CurrentDate DATE , @STime DATETIME, @ETime DATETIME, @UTCTime DATETIME
	IF OBJECT_ID('tempdb..#TempTblHostName') IS NOT NULL DROP TABLE #TempTblHostName
	IF OBJECT_ID('tempdb..#TempTblAppTime') IS NOT NULL DROP TABLE #TempTblAppTime

	SELECT @CurrentDate =  (CASE WHEN CONVERT(TIME,GETDATE()) BETWEEN '00:00:00:00' AND '08:00:00:00'                                         
	THEN DATEADD(DAY,-1,CONVERT(DATE,GETDATE())) ELSE CONVERT(DATE,GETDATE()) END)

	SET @STime =  DATEADD(MINUTE,150, CONVERT(DATETIME,CONVERT(VARCHAR(12), @CurrentDate,101)))
	SET @ETime =  DATEADD(HOUR,24,DATEADD(MINUTE,150, @STime))
	SET @UTCTime = GETUTCDATE()

	SELECT MT.ComputerName,LE.EventTypeId,LE.EventTime, 1 Remarks
	INTO #TempTblHostName
	FROM
	(
		SELECT ComputerName,MAX(EventTime)EventTime
		FROM LockEvents(NOLOCK)
		WHERE EventTime >= @STime AND EventTime < @ETime
		AND ComputerName NOT LIKE '%LAPTOP%'
		GROUP BY ComputerName
	)MT
	INNER JOIN LockEvents(NOLOCK)LE
	ON MT.ComputerName = LE.ComputerName AND MT.EventTime = LE.EventTime
	WHERE LE.EventTypeId NOT IN(16,17,18,21,22)

	SELECT TMP.ComputerName, MAX(AW.EndTime)EndTime,1 Remarks
	INTO #TempTblAppTime 
	FROM #TempTblHostName TMP
	INNER JOIN AppWatcher(NOLOCK)AW
	ON TMP.ComputerName = AW.ComputerName
	WHERE AW.StartTime >= @STime
	GROUP BY TMP.ComputerName

	UPDATE HN SET HN.Remarks = 0
	FROM (
		SELECT ET.ComputerName 
		FROM #TempTblHostName ET
		INNER JOIN #TempTblAppTime AW
		ON ET.ComputerName = AW.ComputerName
		AND DATEADD(MINUTE,-10,ET.EventTime) >=  EndTime
		--WHERE EventTypeId IN (1,3,5)
	)AP
	INNER JOIN #TempTblHostName HN
	ON HN.ComputerName = AP.ComputerName

	--UPDATE HN SET HN.Remarks = 0
	--FROM (
	--	SELECT ET.ComputerName 
	--	FROM #TempTblHostName ET
	--	INNER JOIN #TempTblAppTime AW
	--	ON ET.ComputerName = AW.ComputerName
	--	AND DATEADD(MINUTE,-10,ET.EventTime) >=  EndTime
	--	WHERE EventTypeId NOT IN (1,3,5)
	--)AP
	--INNER JOIN #TempTblHostName HN
	--ON HN.ComputerName = AP.ComputerName

	UPDATE HN SET HN.Remarks = 2
	FROM (
		SELECT ET.ComputerName,ET.EventTypeId,ET.EventTime 
		FROM #TempTblHostName ET
		LEFT JOIN #TempTblAppTime AW
		ON ET.ComputerName = AW.ComputerName
		WHERE AW.ComputerName IS NULL
	)AP
	INNER JOIN #TempTblHostName HN
	ON HN.ComputerName = AP.ComputerName

	SELECT * FROM #TempTblHostName

	IF OBJECT_ID('tempdb..#TempTblHostName') IS NOT NULL DROP TABLE #TempTblHostName
	IF OBJECT_ID('tempdb..#TempTblAppTime') IS NOT NULL DROP TABLE #TempTblAppTime
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CISODeviceInfo]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CISODeviceInfo]  
AS  
BEGIN  
  
 SELECT ID, ud.EmployeeCode, UserAccount, isnull(sd.[Location],'Chennai') as[Location], HostName, UserDomain, 
	SystemType, SerialNumber, ConnectionType,   
  MachineMake, MachineModel, OSVersion, MemoryGB, ProcessorId, ProcessorName, ProcessorCount, BIOSName,BIOSVersion, BIOSMake,  
    CONVERT(varchar(30), UpTime, 121) as UpTime, NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress,   
    Connectivity, DomainType, IsConnected, IsConnectedToInternet, CONVERT(varchar(100), CreatedTime, 121) as CreatedTime,   
    CONVERT(varchar(100), LastConnectedTime, 121) as LastConnectedTime, NetworkDescription, ConnectionName,  
    CONVERT(varchar(30), ScanAt, 121) as ScanAt  
  FROM CISOSystemDetails(nolock)sd  
  inner JOIN UserDetails(nolock)ud  
  ON sd.UserAccount = ud.NTLoginName    
  WHERE sd.IsActive = 1  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeviceInfo_backup]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DeviceInfo_backup] (@callType int) 
AS  
BEGIN

DECLARE @Parm INT = @callType;

IF OBJECT_ID('tempdb..#TmpTblDeviceInfo') IS NOT NULL DROP TABLE #TmpTblDeviceInfo
IF OBJECT_ID('tempdb..#TmpTblNetworkInfo') IS NOT NULL DROP TABLE #TmpTblNetworkInfo
IF OBJECT_ID('tempdb..#TmpTblCType') IS NOT NULL DROP TABLE #TmpTblCType
IF OBJECT_ID('tempdb..#TmpTblNW') IS NOT NULL DROP TABLE #TmpTblNW

DECLARE @sTime DATETIME = GETDATE()-30
CREATE TABLE #TmpTblCType(UserId int, NName VARCHAR(MAX))
DECLARE @ID INT

SELECT 
Id,DI.UserAccount,HostName,UserDomain,SystemType,/*ServiceTag,*/ DI.BIOSSerialNumber, CONVERT(VARCHAR(150),NULL) ConnectionType,
MachineMake,MachineModel,OSVersion,NULLIF(CAST((CONVERT(bigint,TotalMemory) / 1073741824) AS VARCHAR),0) MemoryGB
,ProcessorId,ProcessorName,ProcessorCount,BIOSName,BIOSVersion,BIOSMake,UpTime SystemUpTime,DI.RunAt ScanAt
INTO #TmpTblDeviceInfo
FROM CISOUserDeviceInfo(NOLOCK)DI
INNER JOIN
       (SELECT BIOSSerialNumber,MAX(RunAt) RunAt
       FROM CISOUserDeviceInfo(NOLOCK)
       WHERE RunAt >= @sTime AND VersionId = '2020.04.28.001'
       GROUP BY BIOSSerialNumber) MX
ON DI.BIOSSerialNumber = MX.BIOSSerialNumber AND DI.RunAt = MX.RunAt

SELECT RN = ROW_NUMBER() OVER (PARTITION BY BIOSSerialNumber,HostName ORDER BY ScanAt DESC),
NS.id UserId,NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IP4Address AS IPAddress,Connectivity,
DomainType,IsConnected,IsConnectedToInternet,CreatedTime,ConnectedTime,NetworkDescription,ConnectionName
INTO #TmpTblNetworkInfo
FROM #TmpTblDeviceInfo tmp
INNER JOIN CISOUserNetworkStatus(NOLOCK)NS
ON tmp.Id = ns.Id
WHERE NS.ConnectionStatus = 'UP' AND NS.CreatedTime IS NOT NULL
/*Down Data*/
INSERT INTO #TmpTblNetworkInfo(RN,UserId, NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress, Connectivity, DomainType, 
IsConnected, IsConnectedToInternet, CreatedTime, ConnectedTime, NetworkDescription, ConnectionName)
SELECT RN = ROW_NUMBER() OVER (PARTITION BY BIOSSerialNumber,HostName ORDER BY ScanAt DESC),
NS.Id AS UserId,NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IP4Address,Connectivity,DomainType,IsConnected,IsConnectedToInternet,
CreatedTime,ConnectedTime as LastConnectedTime,NetworkDescription,ConnectionName
FROM CISOUserNetworkStatus(NOLOCK)NS
INNER JOIN 
       (SELECT Id,BIOSSerialNumber,HostName,ScanAt FROM #TmpTblDeviceInfo a
       LEFT JOIN #TmpTblNetworkInfo b
       ON a.Id = b.UserId
       WHERE b.UserId IS NULL)tmp
ON ns.Id = tmp.Id 

/*Get the Connection Type*/
DECLARE ntCursor CURSOR  
READ_ONLY  FOR 
SELECT DISTINCT UserId FROM #TmpTblNetworkInfo

OPEN ntCursor
       FETCH NEXT FROM ntCursor INTO  @ID
       WHILE @@FETCH_STATUS = 0  
              BEGIN  
              INSERT INTO #TmpTblCType(UserId,NName)
                     SELECT @ID, SUBSTRING( 
                     ( 
                            SELECT '|' + NetworkInterface +'|' +NetworkName AS 'data()'
                                  FROM #TmpTblNetworkInfo 
                                   WHERE UserId = @ID
                                  FOR XML PATH('') 
                     ), 2 , 9999)
                     FETCH NEXT FROM ntCursor INTO @ID
              END  
CLOSE ntCursor  
DEALLOCATE ntCursor 

UPDATE DI SET DI.ConnectionType = CT.ConnectionType
FROM (
       SELECT UserId,
       CASE WHEN NNAME LIKE '%Ethernet|Remote NDIS%' THEN 'Dongle'
       ELSE 
       CASE WHEN NNAME LIKE '%Ethernet|Realtek %' THEN 'LAN'
       ELSE
       CASE WHEN NNAME LIKE '%Ethernet|Intel(R) Ethernet%' THEN 'LAN'
       ELSE       
       CASE WHEN NNAME LIKE '%Wireless%|% Wireless%' THEN 'WI-FI'  
       ELSE NULL END END END END AS ConnectionType
       FROM #TmpTblCType)CT
INNER JOIN #TmpTblDeviceInfo DI
ON DI.ID = CT.UserId

IF @Parm = 0
BEGIN
IF OBJECT_ID('tempdb..#TmpTblDeviceInfo01') IS NOT NULL DROP TABLE #TmpTblDeviceInfo01

       --SELECT * FROM #TmpTblDeviceInfo
       --SELECT * FROM #TmpTblNetworkInfo


SELECT Id, UserAccount, HostName, UserDomain, SystemType, BIOSSerialNumber, ConnectionType, MachineMake, MachineModel, 
OSVersion, MemoryGB as TotalMemory, ProcessorId, ProcessorName, ProcessorCount, BIOSName, 
BIOSVersion, BIOSMake, CONVERT(varchar(30), ScanAt, 121) as ScanAt, CONVERT(varchar(30), SystemUpTime, 121) as UpTime 
into #TmpTblDeviceInfo01
FROM #TmpTblDeviceInfo order by Id asc

select * from #TmpTblDeviceInfo01

--SELECT UserId, NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress, Connectivity, DomainType, 
--IsConnected, IsConnectedToInternet, CONVERT(varchar(30), CreatedTime, 121) as CreatedTime, 
--CONVERT(varchar(30), ConnectedTime, 121) as LastConnectedTime, NetworkDescription, ConnectionName 
--from #TmpTblNetworkInfo order by UserId asc

--SELECT UserId, NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress, Connectivity, DomainType, 
--IsConnected, IsConnectedToInternet, CONVERT(varchar(30), CreatedTime, 121) as CreatedTime, 
--CONVERT(varchar(30), ConnectedTime, 121) as LastConnectedTime, NetworkDescription, ConnectionName 
--from #TmpTblNetworkInfo a
--inner join #TmpTblDeviceInfo01 b
--on a.UserId = b.Id
--order by UserId asc

IF OBJECT_ID('tempdb..#TmpTblDeviceInfo01') IS NOT NULL DROP TABLE #TmpTblDeviceInfo01
END
IF @Parm = 1
BEGIN
       CREATE TABLE #TmpTblNW (ID INT,
       NetworkInterface VARCHAR(MAX),NetworkName VARCHAR(MAX),ConnectionStatus VARCHAR(MAX),MACAddress VARCHAR(MAX),IPAddress VARCHAR(MAX),
       Connectivity VARCHAR(MAX),DomainType VARCHAR(MAX),IsConnected VARCHAR(50),IsConnectedToInternet VARCHAR(MAX),CreatedTime VARCHAR(MAX),
       ConnectedTime VARCHAR(MAX),NetworkDescription VARCHAR(MAX),ConnectionName VARCHAR(MAX))

       DECLARE @ID1 INT
       DECLARE NWCursor CURSOR  
       READ_ONLY  FOR 
       SELECT DISTINCT UserId FROM #TmpTblNetworkInfo

       OPEN NWCursor
              FETCH NEXT FROM NWCursor INTO  @ID1
              WHILE @@FETCH_STATUS = 0  
                     BEGIN  
                     INSERT INTO #TmpTblNW(ID,NetworkInterface,NetworkName,ConnectionStatus,MACAddress,IPAddress,Connectivity,
                     DomainType,IsConnected,IsConnectedToInternet,CreatedTime,ConnectedTime,NetworkDescription,ConnectionName)              
                           SELECT @ID1, 
                                  SUBSTRING( '[' +( SELECT QUOTENAME(ISNULL(NetworkInterface,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(NetworkName,'-'))  /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(ConnectionStatus,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(MACAddress,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(IPAddress,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(Connectivity,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(DomainType,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME((CASE WHEN IsConnected = 1 THEN 'True' ELSE 'False' END)) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME((CASE WHEN IsConnectedToInternet = 1 THEN 'True' ELSE 'False' END)) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(CONVERT(VARCHAR(30),CreatedTime,121),'-')) /*+ CHAR(9)*/
                                FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(CONVERT(VARCHAR(30),ConnectedTime,121),'-') ) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(NetworkDescription,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                                  ,SUBSTRING('[' +( SELECT QUOTENAME(ISNULL(ConnectionName,'-')) /*+ CHAR(9)*/
                                         FROM #TmpTblNetworkInfo WHERE UserId = @ID1 FOR XML PATH('')  ), 2 , 9999)
                           FETCH NEXT FROM NWCursor INTO @ID1
                     END  
       CLOSE NWCursor  
       DEALLOCATE NWCursor 

       SELECT TOP 1250 UserAccount, HostName, UserDomain, SystemType, BIOSSerialNumber, ConnectionType, MachineMake, MachineModel, OSVersion, 
	   MemoryGB, ProcessorId, ProcessorName, ProcessorCount, BIOSName,BIOSVersion, BIOSMake,
	   CONVERT(varchar(30), SystemUpTime, 121) as UpTime,NetworkInterface, NetworkName, ConnectionStatus, MACAddress, IPAddress, 
	   Connectivity, DomainType, IsConnected, IsConnectedToInternet, CONVERT(varchar(100), CreatedTime, 121) as CreatedTime, 
	   CONVERT(varchar(100), ConnectedTime, 121) as LastConnectedTime, NetworkDescription, ConnectionName,
	   CONVERT(varchar(30), ScanAt, 121) as ScanAt ,UD.Location,UD.Client  
		FROM #TmpTblDeviceInfo a
       LEFT JOIN #TmpTblNW  b
       ON a.Id = b.ID
	   LEFT JOIN EchoLock.dbo.UserDetails(NOLOCK)ud
	   ON A.UserAccount = UD.NTLoginName
END
IF OBJECT_ID('tempdb..#TmpTblDeviceInfo') IS NOT NULL DROP TABLE #TmpTblDeviceInfo
IF OBJECT_ID('tempdb..#TmpTblNetworkInfo') IS NOT NULL DROP TABLE #TmpTblNetworkInfo
IF OBJECT_ID('tempdb..#TmpTblCType') IS NOT NULL DROP TABLE #TmpTblCType
IF OBJECT_ID('tempdb..#TmpTblNW') IS NOT NULL DROP TABLE #TmpTblNW

END
GO
/****** Object:  StoredProcedure [dbo].[TableViewFunctionPermission]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[TableViewFunctionPermission]                  
as                  
begin                 
             
if OBJECT_ID('tempdb..#temp') is not null                  
drop table #temp                  
select  Name into #temp from sys.tables where create_date>=GETDATE()-7 and schema_id =1              
and name not in ('TablePermission','TableViewFunctionPermission')                  
                  
Declare @tc int,@SPName Varchar(100),@sql nvarchar(1500)                  
                  
set @tc=(select COUNT(*) from #temp)                  
                  
While @tc!=0                  
Begin                  
                  
select @SPName=name from  #temp                  
                    
Set @sql='GRANT INSERT ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                  
Exec sp_executesql @SQL                  
Set @sql='GRANT SELECT ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                  
Exec sp_executesql @SQL                  
Set @sql='GRANT UPDATE ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                  
Exec sp_executesql @SQL                  
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'                  
Exec sp_executesql @SQL   
                                                  
Delete From #temp where name =@SPName                  
                  
Set @tc =@tc-1                   
End                  
                  
drop table #temp               
            
            
if OBJECT_ID('tempdb..#viewtemp') is not null              
drop table #viewtemp              
select  Name into #viewtemp from sys.views where create_date >=GETDATE()-7 and schema_id =1              
              
              
set @tc=(select COUNT(*) from #viewtemp)              
              
While @tc!=0              
Begin              
              
select @SPName=name from  #viewtemp              
              
Set @sql='GRANT SELECT ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'              
Exec sp_executesql @SQL              
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'              
Exec sp_executesql @SQL              
              
              
Delete From #viewtemp where name =@SPName              
              
Set @tc =@tc-1               
End              
              
drop table #viewtemp            
            
            
if OBJECT_ID('tempdb..#functemp') is not null              
drop table #Functemp              
select  Name into #Functemp from sysobjects where xtype  in('fn')     
and crdate >=GETDATE()-7            
              
              
set @tc=(select COUNT(*) from #Functemp)              
              
While @tc!=0              
Begin              
              
select @SPName=name from  #Functemp              
              
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'              
Exec sp_executesql @SQL              
Set @sql='GRANT Execute ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'              
Exec sp_executesql @SQL              
              
              
Delete From #Functemp where name =@SPName              
              
Set @tc =@tc-1               
End              
              
drop table #Functemp            
            
if OBJECT_ID('tempdb..#Tfunctemp') is not null              
drop table #Tfunctemp              
select  Name into #Tfunctemp from sysobjects where xtype  in('Tf')     
and crdate >=GETDATE()-7            
              
              
set @tc=(select COUNT(*) from #Tfunctemp)              
              
While @tc!=0              
Begin              
              
select @SPName=name from  #Tfunctemp              
              
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'  
Exec sp_executesql @SQL              
Set @sql='GRANT REFERENCES ON [dbo].['+@SPName +'] TO [DB_DMLSupport]'              
Exec sp_executesql @SQL              
              
              
Delete From #Tfunctemp where name =@SPName              
              
Set @tc =@tc-1               
End              
              
drop table #Tfunctemp        

        
if OBJECT_ID('tempdb..#storedProctemp') is not null          
drop table #storedProctemp          
select  '['+SCHEMA_NAME(schema_id)+'].['+name+']'        
AS SchemaName into #storedProctemp from sys.procedures where create_date>=GETDATE()-7          
and SCHEMA_NAME(schema_id) like '%Dbo%' and name not in ('TableViewFunctionPermission')        
        
          
set @tc=(select COUNT(*) from #storedProctemp)          
          
While @tc!=0          
Begin          
          
select @SPName=SchemaName from  #storedProctemp          
          
Set @sql='GRANT EXECUTE ON '+@SPName+' TO [DB_DMLSupport]'          
          
Exec sp_executesql @SQL          
          
          
Set @sql='GRANT VIEW DEFINITION ON '+@SPName+' TO [DB_DMLSupport]'          
          
Exec sp_executesql @SQL          
          
Delete From #storedProctemp where SchemaName =@SPName          
          
Set @tc =@tc-1           
End           
            
            
               
end




GO
/****** Object:  StoredProcedure [dbo].[TableViewFunctionPermission_ReadOnly]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[TableViewFunctionPermission_ReadOnly]                            
as                            
begin                           
                       
if OBJECT_ID('tempdb..#temp') is not null                            
drop table #temp                            
select  Name into #temp from sys.tables where create_date>=GETDATE()-7 and schema_id =1                        
and name not in ('TablePermission','TableViewFunctionPermission')                            
                            
Declare @tc int,@SPName Varchar(100),@sql nvarchar(1500)                            
                            
set @tc=(select COUNT(*) from #temp)                            
                            
While @tc!=0                            
Begin                            
                            
select @SPName=name from  #temp                            
                           
Set @sql='GRANT SELECT ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                            
Exec sp_executesql @SQL                            
                          
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                            
Exec sp_executesql @SQL             
                         
                            
                            
Delete From #temp where name =@SPName                            
                            
Set @tc =@tc-1                             
End                            
                            
drop table #temp                         
                      
                      
if OBJECT_ID('tempdb..#viewtemp') is not null                        
drop table #viewtemp                        
select  Name into #viewtemp from sys.views where create_date >=GETDATE()-7 and schema_id =1                  
                        
                        
set @tc=(select COUNT(*) from #viewtemp)                        
                        
While @tc!=0                        
Begin                        
                        
select @SPName=name from  #viewtemp                        
                        
Set @sql='GRANT SELECT ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                        
Exec sp_executesql @SQL                        
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                        
Exec sp_executesql @SQL                        
                        
                        
Delete From #viewtemp where name =@SPName                        
                        
Set @tc =@tc-1                         
End                        
                        
drop table #viewtemp                      
                      
                      
if OBJECT_ID('tempdb..#functemp') is not null                        
drop table #Functemp                        
select  Name into #Functemp from sysobjects where xtype  in('fn')               
--and crdate >=GETDATE()-7                      
                        
                        
set @tc=(select COUNT(*) from #Functemp)                        
                        
While @tc!=0                        
Begin                        
                        
select @SPName=name from  #Functemp                        
                        
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                        
Exec sp_executesql @SQL  

Set @sql='GRANT EXECUTE ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'                        
Exec sp_executesql @SQL                      
                       
Delete From #Functemp where name =@SPName                        
                        
Set @tc =@tc-1                         
End                        
                        
drop table #Functemp                      

           
if OBJECT_ID('tempdb..#Tfunctemp') is not null              
drop table #Tfunctemp              
select  Name into #Tfunctemp from sysobjects where xtype  in('Tf')     
--and crdate >=GETDATE()-7            
              
              
set @tc=(select COUNT(*) from #Tfunctemp)              
              
While @tc!=0              
Begin              
              
select @SPName=name from  #Tfunctemp              
              
Set @sql='GRANT VIEW DEFINITION ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'              
Exec sp_executesql @SQL              
Set @sql='GRANT REFERENCES ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'              
Exec sp_executesql @SQL      
Set @sql='GRANT SELECT ON [dbo].['+@SPName +'] TO [DB_Readonlysupport]'              
Exec sp_executesql @SQL          
              
              
Delete From #Tfunctemp where name =@SPName              
              
Set @tc =@tc-1               
End              
              
drop table #Tfunctemp                              
                  
if OBJECT_ID('tempdb..#storedProctemp') is not null                    
drop table #storedProctemp                    
select  '['+SCHEMA_NAME(schema_id)+'].['+name+']'                  
AS SchemaName into #storedProctemp from sys.procedures where create_date>=GETDATE()-7       
and schema_id =1 and name not in ('TableViewFunctionPermission')                  
                  
                    
set @tc=(select COUNT(*) from #storedProctemp)                    
                    
While @tc!=0                    
Begin                    
                    
select @SPName=SchemaName from  #storedProctemp                    
                    
Set @sql='GRANT VIEW DEFINITION ON '+@SPName+' TO [DB_Readonlysupport]'                    
                    
Exec sp_executesql @SQL                    
                    
Delete From #storedProctemp where SchemaName =@SPName                    
                    
Set @tc =@tc-1                     
End                     
                      
                      
                         
end






GO
/****** Object:  StoredProcedure [dbo].[testsystemoverview]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[testsystemoverview]
as
begin
	select '2020-01-28'RunAt,500 Systemsm,346 Live,154 Unidentified, 100 Critical, 46 Warning, 200 noissues			
end
GO
/****** Object:  StoredProcedure [dbo].[UserHierarchyHistoryJob]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- User Hierarchy History Job
-- =============================================
-- Author:		Promodh Kumar
-- Create date: 24/02/2020
-- Description:	User Hierarchy History for Individual dates with upto 12 Levels of Manager for each User
-- =============================================
CREATE PROCEDURE [dbo].[UserHierarchyHistoryJob]
	@CompanyId int,
	@UserId nvarchar(128) = null,
	@JobDate datetime	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF OBJECT_ID('tempdb..#masterUserList') IS NOT NULL  drop table #masterUserList
	IF OBJECT_ID('tempdb..#hierarchy') IS NOT NULL  drop table #hierarchy
	IF OBJECT_ID('tempdb..#hierarchyhistory') IS NOT NULL  drop table #hierarchyhistory

    create table #masterUserList
	(
		UserId nvarchar(128) not null,
		NTLoginName varchar(50) not null,
		ManagerL1 varchar(50) null,
		ARCUserId int
	);

	declare @currentLevel int = 1
	declare @lastLevel int = 0
	declare @continueloop bit = 1

	insert into #masterUserList
		select a.UserId, 
				a.NTLoginName NTLoginName,
				a.ManagerL1, a.ARCUserId
			from Echolock.dbo.DailyDashboardData a
			(nolock)
			inner join Echolock.dbo.UserDetails ud
			(nolock)
				on a.UserId = ud.UserId
			where EventDate = @JobDate
				and ud.CompanyId = @CompanyId

	select distinct a.UserId, a.NTLoginName, b.NTLoginName ManagerL1, b.UserId ManagerUserId, 0 Level, a.ARCUserId, b.ARCUserId ManagerARCUserId
		into #hierarchy
		from #masterUserList a
		(nolock)
			left join #masterUserList b
			(nolock)
				on a.ManagerL1 = b.NTLoginName
			
	while(@continueloop > 0)
	begin	
		if(@currentLevel > @lastLevel)
		begin

			select @lastLevel = (max(Level))
				from #hierarchy
				(nolock)

			insert into #hierarchy
				select distinct a.UserId, a.NTLoginName, c.NTLoginName ManagerL1, c.UserId ManagerUserId, @lastLevel + 1 Level, a.ARCUserId, c.ARCUserId ManagerARCUserId
					from #hierarchy a
					(nolock)
						inner join #hierarchy b
						(nolock)
							on a.ManagerUserId = b.UserId
								and b.Level = 0
						inner join #hierarchy c
						(nolock)
							on b.ManagerUserId = c.UserId
						where a.Level = @lastLevel

			if not exists (select 'x' from #hierarchy a
				(nolock)
				inner join #hierarchy b
				(nolock)
					on a.ManagerUserId = b.UserId
				where a.Level = @lastLevel + 1)
			begin
				set @continueloop = 0
			end
			else
			begin
				set @currentLevel = @lastLevel + 1
			end

		end
		else
		begin
			set @continueloop = 0
		end
	end

	select distinct @JobDate EventDate, UserId,
			cast(null as nvarchar(128)) ML1, cast(null as nvarchar(128)) ML2, cast(null as nvarchar(128)) ML3,
			cast(null as nvarchar(128)) ML4, cast(null as nvarchar(128)) ML5, cast(null as nvarchar(128)) ML6,
			cast(null as nvarchar(128)) ML7, cast(null as nvarchar(128)) ML8, cast(null as nvarchar(128)) ML9,
			cast(null as nvarchar(128)) ML10, cast(null as nvarchar(128)) ML11, cast(null as nvarchar(128)) ML12
		into #hierarchyhistory
		from #hierarchy
		where 1 = case when @UserId is not null and UserId = @UserId then 1
					when @UserId is null then 1
					else 0 end

	update a
		set a.ML1 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 0

	update a
		set a.ML2 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 1

	update a
		set a.ML3 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 2

	update a
		set a.ML4 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 3

	update a
		set a.ML5 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 4

	update a
		set a.ML6 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 5

	update a
		set a.ML7 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 6

	update a
		set a.ML8 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 7

	update a
		set a.ML9 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 8

	update a
		set a.ML10 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 9

	update a
		set a.ML11 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 10

	update a
		set a.ML12 = b.ManagerUserId
		from #hierarchyhistory a
		inner join #hierarchy b
			on a.UserId = b.UserId and b.Level = 11

	begin try
		
		begin tran

		merge Echolock.dbo.UserHierarchyHistory t
		using #hierarchyhistory s
		on (t.UserId = s.UserId and t.EventDate = s.EventDate)
		when matched then
			update set t.ML1 = s.ML1, t.ML2 = s.ML2, t.ML3 = s.ML3,
				t.ML4 = s.ML4, t.ML5 = s.ML5, t.ML6 = s.ML6,
				t.ML7 = s.ML7, t.ML8 = s.ML8, t.ML9 = s.ML9,
				t.ML10 = s.ML10, t.ML11 = s.ML11, t.ML12 = s.ML12
		when not matched by target then
			insert (UserId, EventDate, ML1, ML2, ML3, ML4, ML5, ML6, ML7, ML8, ML9, ML10, ML11, ML12)
			values (s.UserId, s.EventDate, s.ML1, s.ML2, s.ML3, s.ML4, s.ML5, s.ML6, s.ML7, s.ML8, s.ML9, s.ML10, s.ML11, s.ML12)
		;

		commit
	end try
	begin catch
		rollback

		select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_PROCEDURE()

		--if ERROR_MESSAGE() not like 'Violation of UNIQUE KEY%'
		--begin
			insert into Echolock.dbo.ErrorLogs (EventDetails, ExceptionMessage, CreatedOn, UserAccount, ComputerName)    
				values ('UserHierarchyHistoryJob Error',     
					convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
					getdate(), 'UserHierarchyHistoryJob', 'SQL Server')    
  
			insert into ARC_Enterprise.dbo.ARC_REC_MAIL_TRAN (FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,MAIL_STATUS,ISHTML,CREATED_DT,CC,Active)    
				values ('it@accesshealthcare.com', 'saravanakuma.r@accesshealthcare.com;promodh.kumar@accesshealthcare.com',    
					'Error in UserHierarchyHistoryJob', convert(varchar, Error_Number()) + Error_Message() + convert(varchar, Error_Line()) + error_procedure(),    
					0, 'Y', getdate(), null, 1)
		--end
	end catch

	IF OBJECT_ID('tempdb..#masterUserList') IS NOT NULL  drop table #masterUserList
	IF OBJECT_ID('tempdb..#hierarchy') IS NOT NULL  drop table #hierarchy
	IF OBJECT_ID('tempdb..#hierarchyhistory') IS NOT NULL  drop table #hierarchyhistory
END
GO
/****** Object:  StoredProcedure [dbo].[ValidateStringDateTime]    Script Date: 8/30/2020 7:29:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ValidateStringDateTime](@string VARCHAR(MAX), @Output VARCHAR(200) OUTPUT)
AS
BEGIN
	--declare @string varchar(max) = 'The previous system shutdown at 6:12:06 PM on ?6/?2/?2020 was unexpected.'
	DECLARE @dtString VARCHAR(500) 
	DECLARE @RESULT VARCHAR(200)
    BEGIN TRY       
		SET @dtString =  REPLACE(REPLACE(REPLACE(@string,'The previous system shutdown at ',''),' was unexpected.',''),'?','')
		SET @RESULT =  CONVERT(VARCHAR,CONVERT(VARCHAR,CONVERT(DATE,RIGHT(@dtString,CHARINDEX(' ',@dtString)))) 
		+ ' ' + CONVERT(VARCHAR,CONVERT(TIME,LEFT(@dtString,CHARINDEX(' on',@dtString)))),121)		
    END TRY
    BEGIN CATCH
        SET @RESULT = '0000-00-00 00:00:00'
    END CATCH
	SET @Output = @RESULT
	--select @RESULT
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AppWatcher"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAppWatcher'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAppWatcher'
GO
