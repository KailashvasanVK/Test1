USE [Echoc3]
GO
/****** Object:  UserDefinedFunction [dbo].[C3_StringSplit]    Script Date: 8/30/2020 6:36:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[C3_StringSplit]
(
    @String  VARCHAR(MAX), @Separator CHAR(1), @rID INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN 

DECLARE @RESULT TABLE(id int, [Value] VARCHAR(MAX))
DECLARE @ID INT = 0, @Output VARCHAR(MAX)
SET  @String = REPLACE(@String,'.mp3','')
DECLARE @SeparatorPosition INT = CHARINDEX(@Separator, @String ),
@Value VARCHAR(MAX), @StartPosition INT = 1
 
 IF @SeparatorPosition = 0  
  BEGIN   
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
     SET @Output = (SELECT TOP 1 VALUE FROM @RESULT WHERE id = @rID)
 
 RETURN @Output
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnSplitString]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[fnSplitString](@String varchar(MAX), @Delimiter char(1)) 
returns @temptable TABLE (items varchar(MAX)) 
as 
begin 
declare @idx int 
declare @slice varchar(8000) 

select @idx = 1 
if len(@String)<1 or @String is null return 

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
end 
return 
end;

GO
/****** Object:  UserDefinedFunction [dbo].[GetCurrentDateTime]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
create function [dbo].[GetCurrentDateTime]( @Date Datetime,@LocationId int,@ToTS varchar(50))   
Returns Datetime   
As   
Begin   
declare @OutputDate datetime   
IF ISDATE(@Date) = 1   
BEGIN   
Declare @Min int, @Sign int =-1,@TM varchar(50) =''   
if @ToTS = 'GMT'   
Begin   
 set @Sign = 1   
End   
SELECT @Min = @Sign * Timesign * ((DATEPART(HOUR, TimeDifferent) * 60) + (DATEPART(MINUTE, TimeDifferent) ))   
from EXTR_ARC_AR_V1.dbo.ARC_AR_LocationMaster with (nolock)  
Where Locationid=@LocationId   
Select @OutputDate = convert(datetime,DATEADD(MINUTE, @Min ,@Date))   
End   
else   
Begin   
set @OutputDate = convert(datetime, '01/01/1980')   
End   
   
return @OutputDate;   
End;  
GO
/****** Object:  UserDefinedFunction [dbo].[Removeduplicatesfromstring]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Removeduplicatesfromstring]  
(  
 @List VARCHAR(MAX),  
 @Delim CHAR  
)  
RETURNS  
VARCHAR(MAX)  
AS  
BEGIN  
DECLARE @ParsedList TABLE  
(  
Item VARCHAR(MAX)  
)  
DECLARE @list1 VARCHAR(MAX), @Pos INT, @rList VARCHAR(MAX)  
SET @list = LTRIM(RTRIM(@list)) + @Delim  
SET @pos = CHARINDEX(@delim, @list, 1)  
WHILE @pos > 0  
BEGIN  
SET @list1 = LTRIM(RTRIM(LEFT(@list, @pos - 1)))  
IF @list1 <> ''  
INSERT INTO @ParsedList VALUES (CAST(@list1 AS VARCHAR(MAX)))  
SET @list = SUBSTRING(@list, @pos+1, LEN(@list))  
SET @pos = CHARINDEX(@delim, @list, 1)  
END  
SELECT @rlist = COALESCE(@rlist+',','') + item  
FROM (SELECT DISTINCT Item FROM @ParsedList) t  
 RETURN @rlist  
END  
GO
/****** Object:  StoredProcedure [dbo].[Arc_Ar_CallrecordingDailyMailer]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Arc_Ar_CallrecordingDailyMailer]  
as  
begin  
     
   if object_id('tempdb..#tempdata') is not null drop table #tempdata  
         create table #tempdata(RowId int identity(1,1),Vendor varchar(250),LastImportDate datetime)  
   insert into #tempdata(Vendor,LastImportDate)  
   select  SourceAdded,FORMAT(max(Createddate) ,'MM/dd/yyyy hh:mm') updateddate  
   from arc_ar_callrecoding  
   group by SourceAdded  
   order by FORMAT(max(Createddate) ,'MM/dd/yyyy hh:mm') desc  
   
  
   DECLARE @Calldata varchar(max)='',@MailBody varchar(max)=null  
   SELECT @Calldata='<table cellpading="3" cellspacing="0" border ="1" style="font-family: verdana; font-size: 12px"><tbody><tr align="left" valign="top" style="font-weight:bold;color:#fff;background:#267cc7;  
   font-style:italic;border: solid 1px #000;"><td>Vendor</td><td>LastImportDate</td></tr>'+CAST((select Vendor as 'td','',  
   LastImportDate  as 'td','' FROM #tempdata  
   FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX)) ;  
   SET @Calldata = @Calldata+'</tbody></table>';  
   Set @MailBody ='<html><head><style>body{font-family: verdana;font-size: 12px;}.box{  
   filter: progid:DXImageTransform.Microsoft.gradient( startColorstr=''#ffffff'', endColorstr=''#eeeeee'', GradientType=0 );  
   -webkit-border-radius: 5px;-moz-border-radius: 5px; border-radius: 5px; -moz-background-clip: padding;-webkit-background-clip: padding-box;  
    background-clip: padding-box;border: 1px solid #aaaaaa;-webkit-box-shadow: 0 0 3px #ffffff inset, 0 1px 1px rgba(0,0,0,0.1);  
    -moz-box-shadow: 0 0 3px #ffffff inset, 0 1px 1px rgba(0,0,0,0.1); box-shadow: 0 0 3px #ffffff inset, 0 1px 1px rgba(0,0,0,0.1);  
    padding: 8px; }.cellheader {color: #004276;font-weight: bold;background-color: #eeeeee;vertical-align: top;min-width: 120px;}  
    table.display{ border-collapse: collapse;word-wrap: break-word;font-family: verdana;font-size: 12px;width: 100%;}  
    table.display tbody td {border: 0.1em solid #d8dcdf;padding: 5px;} div.forcewrap{white-space: normal;word-wrap: break-word;width: 22em;}  
    </style></head><body>  
    <div style="margin-left: 5px; font-weight: bold">  <p> Hi, <br />  
    <br />This is to notify that callrecording last import details vendor wise<br><br> <br><br></p></div>  
    <div >'+isnull(@Calldata,'''')+'</div>  
   <br />  
   <br />  
   <div><img width="300px" height="70px" src="https://www.accesshealthcare.co/appimages/arc_flow.png" alt="" /></div> <div>  
   ** This is an auto-generated email. Please do not reply to this email.**</div></body></html>'  
  
   DECLARE @CC varchar(max)='',@RECIPIENTS varchar(max)='sakkaravarth.k@accesshealthcare.com;arunkumar.p@accesshealthcare.com;barathi.a@accesshealthcare.com;  
     karthiknainar.c@accesshealthcare.com;ramesh.v2@accesshealthcare.com;niranjan.m@accesshealthcare.com;kailashvasan.vk@accesshealthcare.com',@Subject varchar(max)='callrecording Import Details'  
    ,@FROM_MAILID varchar(250)='mail.support@accesshealthcare.co';  
    Exec ARC_REC..SP_INS_ARC_REC_MAIL_TRAN @FROM_MAILID = @FROM_MAILID,@RECIPIENTS = @RECIPIENTS, @CC = @CC,@SUBJECT_TEXT = @Subject,@BODY =@MailBody,@ISHTML = 'Y',@FilePath = ''  
     if object_id('tempdb..#tempdata') is not null drop table #tempdata  
end  
  

GO
/****** Object:  StoredProcedure [dbo].[ARC_AR_CallRecordingInfoForAllCustomers]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ARC_AR_CallRecordingInfoForAllCustomers]        
(               
 @FromDate datetime=null,               
 @ToDate datetime=null,               
 @UserId int=0,            
 @CustomerId int=13  ,          
 @Vendor varchar(50)='',          
 @Ntusername varchar(100)='',          
 @GroupName varchar(100)='',          
 @SubGroupName varchar(100)='',  
 @SelectedCustomerId varchar(50)=''            
)             
AS             
BEGIN             
            
 --declare  @FromDate datetime='07/01/2020',               
 --@ToDate datetime='07/30/2020',               
 --@UserId int=0,            
 --@CustomerId int=101  ,          
 --@Vendor varchar(50)=''   ,        
 --@Ntusername varchar(100)='',        
 --@SubGroupName varchar(100)='',        
 --@GroupName varchar(100)='',  
 --@SelectedCustomerId varchar(50)='0'         
            
        if (isnull(@SelectedCustomerId,'')!='')  
  begin  
   SELECT   ROW_NUMBER() OVER (ORDER BY ClaimNo)  as SNO,ClaimNo,PhoneNumber,   Convert(varchar(50),CallInitiatedTime)  as CallInitiatedTime,    
   Convert(varchar(50),CallEndTime) as CallEndTime,   
   case  when SourceAdded ='RingCentral' and  isnull(RecordingURL,'') <> '' then 'file:'+replace(RecordingURL,'\','/') else     isnull(RecordingURL,'') end as  RecordingURL,       
   CD.CreatedBy as Agent,Extension,Uniqueid,CallDisposition,UI.FunctionName Functionality , UI.LocationName AgentLocation,CONVERT(time(0), DATEADD(SECOND, isnull(Duration,0), 0)) as [Duration (HH:MM:SS)],          
   SourceAdded as Vendor,Upper(UI.GroupName) GroupName, Upper(UI.SubGroupName) as SubGroupName          
   from ARC_AR_CallRECODING CD          
   INNER JOIN ARC_REC..arc_Rec_user_info_vy UI ON CD.CreatedBy=UI.NT_USERNAME           
   where       CallInitiatedTime between dateAdd(n, 480, @FromDate) and dateAdd(n, 1920, @Todate)        
   and isnull(sourceadded,'')= case when isnull(@Vendor,'')='' then isnull(sourceadded,'') else  @Vendor end         
   and CD.CustomerID= case when convert(int,@SelectedCustomerId)=0 then CD.CustomerID else convert(int,@SelectedCustomerId) end         
   order by  SNO asc   
  end  
  else  
  begin  
   SELECT   ROW_NUMBER() OVER (ORDER BY ClaimNo)  as SNO,ClaimNo,PhoneNumber,   Convert(varchar(50),CallInitiatedTime)  as CallInitiatedTime,    
   Convert(varchar(50),CallEndTime) as CallEndTime,   
   case  when SourceAdded ='RingCentral' and  isnull(RecordingURL,'') <> '' then 'file:'+replace(RecordingURL,'\','/') else     isnull(RecordingURL,'') end as  RecordingURL,       
   CD.CreatedBy as Agent,Extension,Uniqueid,CallDisposition,UI.FunctionName Functionality , UI.LocationName AgentLocation,CONVERT(time(0), DATEADD(SECOND, isnull(Duration,0), 0)) as [Duration (HH:MM:SS)],          
   --CONVERT(time(0), DATEADD(SECOND, isnull(HoldTime,0), 0)) as [HoldTime (HH:MM:SS)],            
   SourceAdded as Vendor,Upper(UI.GroupName) GroupName, Upper(UI.SubGroupName) as SubGroupName          
   from ARC_AR_CallRECODING CD          
   INNER JOIN ARC_REC..arc_Rec_user_info_vy UI ON CD.CreatedBy=UI.NT_USERNAME           
   where       CallInitiatedTime between dateAdd(n, 480, @FromDate) and dateAdd(n, 1920, @Todate)        
   and isnull(createdby,'')= case when isnull(@Ntusername ,'') ='' then isnull(createdby,'') else @Ntusername end         
   and isnull(sourceadded,'')= case when isnull(@Vendor,'')='' then isnull(sourceadded,'') else  @Vendor end         
   and isnull(GroupName,'') = case when isnull(@GroupName,'')='' then isnull(GroupName,'')   else @GroupName end        
   and isnull(SubGroupName,'')=case when isnull(@SubGroupName,'')='' then isnull(SubGroupName,'') else @SubGroupName end        
   and CD.CustomerID=@CustomerId    
   order by  SNO asc   
 end         
         
            
END   
GO
/****** Object:  StoredProcedure [dbo].[ARC_Ar_getfiledetails]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ARC_Ar_getfiledetails]      
as      
begin      
        
declare @rowno int=0      
      
 if OBJECT_ID('tempdb..#Five9call') is not null drop table #Five9call      
 create table #Five9call(FId int identity(1,1),FilePath varchar(500),CustomerId int)      
 insert into  #Five9call(FilePath,CustomerId)      
 select '\\fs3\ARC_FLOW\New_Batches\WaterTown\ArcDumpAttachments\'+FolderPath+'\'+FileName,1001       
 from [LNKTPARFLOW].[ARC_FLOW].[dbo].[ADM_MailDownload] where    
  Subject like 'Scheduled%Report:%CDR-Five9'  and Status=0      
  
  if OBJECT_ID('tempdb..#Ringcall') is not null drop table #Ringcall      
 create table #Ringcall(FId int identity(1,1),FilePath varchar(500),CustomerId int)      
 insert into  #Ringcall(FilePath,CustomerId)      
 select '\\fs3\ARC_FLOW\New_Batches\WaterTown\ArcDumpAttachments\'+FolderPath+'\'+FileName,1005       
 from [LNKTPARFLOW].[ARC_FLOW].[dbo].[ADM_MailDownload] where    
  Subject like 'Scheduled%reports%from%RingCentral%'  and Status=0      
      
      
   if OBJECT_ID('tempdb..#templcustomersdetails') is not null drop table #templcustomersdetails        
 create table #templcustomersdetails(rowid int identity(1,1) primary key,impid int,Customerid int,Customername varchar(100),      
 Filelocatedpath varchar(500),Additional varchar(100),Datetocheck varchar(10),Dateformate varchar(20),      
 FileFormat varchar(10),Delimiter varchar(5),EmailIds varchar(max),CCEmailids varchar(max),clientspname varchar(300),tablename varchar(300),      
 Headercountcheck tinyint,dbsp varchar(500),SubprovisionId int)      
      
 insert into  #templcustomersdetails (impid,Customerid,Customername,Filelocatedpath,Additional,Datetocheck,Dateformate,FileFormat,      
 Delimiter,EmailIds,CCEmailids,clientspname,tablename,Headercountcheck,dbsp,SubprovisionId)      
       
       
 select FF.Fileid,CM.CustomerID,CM.DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
 FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)      
 from EXTR_ARC_AR_V1.dbo.arc_ar_clientmaster CM with (nolock) left join arc_ar_autoimportspdetails SP on SP.customerid=CM.CustomerID and SP.status=1      
 inner join ARC_AR_Fileformat FF on FF.Customerid=CM.CustomerID     and Sp.SubprovisionId=FF.SubprovisionId    
 where CM.status in(1,2) and FF.Status=1 AND CM.Status=1 AND CM.LiveStatus=1 and ff.customerid not in(53)      
 union      
  select FF.Fileid,0 CustomerID, 'Splink' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  where FF.CustomerId=0 AND FF.Status=1    
  union      
  select FF.Fileid,1003 CustomerID, 'TCN' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  where FF.CustomerId=1003 AND FF.Status=1  
  
  union      
  select FF.Fileid,1004 CustomerID, 'Kruptoconnect' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,  
  isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  where FF.CustomerId=1004 AND FF.Status=1  
       
 union  
  select FF.Fileid,1000 CustomerID, 'TATA' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  where FF.CustomerId=1000 AND FF.Status=1       
 union      
  select FF.Fileid,1001 CustomerID, 'FIVe9' DBPrefix,Fc.FilePath as Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  inner join #Five9call Fc on Fc.CustomerId=FF.CustomerId      
  where FF.CustomerId=1001 AND FF.Status=1       
 union      
  select FF.Fileid,1005 CustomerID, 'RingCentral' DBPrefix,Fc.FilePath as Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  inner join #Ringcall Fc on Fc.CustomerId=FF.CustomerId      
  where FF.CustomerId=1005 AND FF.Status=1       
 union    
  select FF.Fileid,1002 CustomerID, 'APAYAA' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,     
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1    
  where FF.CustomerId=1002 AND FF.Status=1  
 union    
  select FF.Fileid,1006 CustomerID, 'VIVA' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,     
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1    
  where FF.CustomerId=1006 AND FF.Status=1     
       
 declare @temptablerowcount int=(Select Count(*) From #templcustomersdetails)         
      
While @temptablerowcount> @rowno      
begin      
  set @rowno = @rowno + 1      
  Declare @fromdate date='',@FrmTime varchar(20) = '',@ToTime varchar(20) = '',@intFDate int=0,@intTDate int = 1 ,@StartDate datetime = null,@EndDate datetime = null        
  select @FromDate = case when isnull(@FromDate,'')='' then GETDATE() else @FromDate end           
  Select  @FrmTime= Starttime,@ToTime=endtime from ARC_AR_Fileformat where Fileid  = (select impid from #templcustomersdetails where rowid= @rowno) and status=1              
  set @fromdate = getdate()-convert(datetime,@ToTime)          
  set @StartDate=dbo.getcurrentdatetime((convert(varchar,DATEADD(day,@intFDate,@fromdate),110) +' '+  isnull(@FrmTime,'')),1,'GMT')            
  set @EndDate=dbo.getcurrentdatetime((convert(varchar,DATEADD(day,@intTDate,@fromdate),110) +' '+  isnull(@ToTime,'')) ,1,'GMT')         
            
        
 if  EXISTS (select FI.FilePath from ARC_AR_Fileformat FF with (nolock) left join ARC_Ar_fileimportstatus FI on FI.Fileid=FF.Fileid      
 where FI.importstatus=3  and FF.Status=1 and  FF.Fileid=(select impid from #templcustomersdetails with(nolock) where rowid= @rowno)   and      
 FI.CreatedDt between @StartDate and @EndDate and FF.Multipleuploades!=1 and FF.status=1)      
      
begin      
   delete  #templcustomersdetails where rowid=@rowno      
end      
end      
      
 select * from   #templcustomersdetails  where  Filelocatedpath is not null and Filelocatedpath!=''  --and Customerid in(0)      
 if OBJECT_ID('tempdb..#templcustomersdetails') is not null drop table #templcustomersdetails       
       
end   
  
  
  

GO
/****** Object:  StoredProcedure [dbo].[ARC_Ar_getfiledetails_RingCentral]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ARC_Ar_getfiledetails_RingCentral]      
as      
begin      
        
declare @rowno int=0      
      
 if OBJECT_ID('tempdb..#Five9call') is not null drop table #Five9call      
 create table #Five9call(FId int identity(1,1),FilePath varchar(500),CustomerId int)      
 insert into  #Five9call(FilePath,CustomerId)      
 select '\\fs3\ARC_FLOW\New_Batches\WaterTown\ArcDumpAttachments\'+FolderPath+'\'+FileName,1001       
 from [LNKTPARFLOW].[ARC_FLOW].[dbo].[ADM_MailDownload] where    
  Subject like 'Scheduled%Report:%CDR-Five9'  and Status=0      
  
  if OBJECT_ID('tempdb..#Ringcall') is not null drop table #Ringcall      
 create table #Ringcall(FId int identity(1,1),FilePath varchar(500),CustomerId int)      
 insert into  #Ringcall(FilePath,CustomerId)      
 select '\\fs3\ARC_FLOW\New_Batches\WaterTown\ArcDumpAttachments\'+FolderPath+'\'+FileName,1005       
 from [LNKTPARFLOW].[ARC_FLOW].[dbo].[ADM_MailDownload] where    
  Subject like 'Scheduled%reports%from%RingCentral%'  and Status=0      
      
      
   if OBJECT_ID('tempdb..#templcustomersdetails') is not null drop table #templcustomersdetails        
 create table #templcustomersdetails(rowid int identity(1,1) primary key,impid int,Customerid int,Customername varchar(100),      
 Filelocatedpath varchar(500),Additional varchar(100),Datetocheck varchar(10),Dateformate varchar(20),      
 FileFormat varchar(10),Delimiter varchar(5),EmailIds varchar(max),CCEmailids varchar(max),clientspname varchar(300),tablename varchar(300),      
 Headercountcheck tinyint,dbsp varchar(500),SubprovisionId int)      
      
 insert into  #templcustomersdetails (impid,Customerid,Customername,Filelocatedpath,Additional,Datetocheck,Dateformate,FileFormat,      
 Delimiter,EmailIds,CCEmailids,clientspname,tablename,Headercountcheck,dbsp,SubprovisionId)      
       
       
 select FF.Fileid,CM.CustomerID,CM.DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
 FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)      
 from EXTR_ARC_AR_V1.dbo.arc_ar_clientmaster CM with (nolock) left join arc_ar_autoimportspdetails SP on SP.customerid=CM.CustomerID and SP.status=1      
 inner join ARC_AR_Fileformat FF on FF.Customerid=CM.CustomerID     and Sp.SubprovisionId=FF.SubprovisionId    
 where CM.status in(1,2) and FF.Status=1 AND CM.Status=1 AND CM.LiveStatus=1 and ff.customerid not in(53)      
 union      
  select FF.Fileid,0 CustomerID, 'Splink' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  where FF.CustomerId=0 AND FF.Status=1    
  union      
  select FF.Fileid,1003 CustomerID, 'TCN' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  where FF.CustomerId=1003 AND FF.Status=1  
  
  union      
  select FF.Fileid,1004 CustomerID, 'Kruptoconnect' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,  
  isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  where FF.CustomerId=1004 AND FF.Status=1  
       
 union  
 select FF.Fileid,1000 CustomerID, 'TATA' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  where FF.CustomerId=1000 AND FF.Status=1       
 union      
  select FF.Fileid,1001 CustomerID, 'FIVe9' DBPrefix,Fc.FilePath as Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  inner join #Five9call Fc on Fc.CustomerId=FF.CustomerId      
  where FF.CustomerId=1001 AND FF.Status=1       
 union      
  select FF.Fileid,1005 CustomerID, 'RingCentral' DBPrefix,Fc.FilePath as Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,      
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1      
  inner join #Ringcall Fc on Fc.CustomerId=FF.CustomerId      
  where FF.CustomerId=1005 AND FF.Status=1       
 union    
  select FF.Fileid,1002 CustomerID, 'APAYAA' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,     
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1    
  where FF.CustomerId=1002 AND FF.Status=1  
 union    
  select FF.Fileid,1006 CustomerID, 'VIVA' DBPrefix,FF.Filelocatedpath,FF.Additional,FF.Datetocheck,FF.Dateformate,     
  FF.Fileformat,FF.Delimiter,FF.EmailIds,FF.CCEmailids,SP.clientspname,SP.tablename,FF.Headercolumncountcheck,SP.dbspname,isnull(SP.SubprovisionId,0)       
  from ARC_AR_Fileformat FF       
  left join arc_ar_autoimportspdetails SP on SP.customerid=FF.CustomerId and SP.status=1    
  where FF.CustomerId=1006 AND FF.Status=1     
       
 declare @temptablerowcount int=(Select Count(*) From #templcustomersdetails)         
      
While @temptablerowcount> @rowno      
begin      
  set @rowno = @rowno + 1      
  Declare @fromdate date='',@FrmTime varchar(20) = '',@ToTime varchar(20) = '',@intFDate int=0,@intTDate int = 1 ,@StartDate datetime = null,@EndDate datetime = null        
  select @FromDate = case when isnull(@FromDate,'')='' then GETDATE() else @FromDate end           
  Select  @FrmTime= Starttime,@ToTime=endtime from ARC_AR_Fileformat where Fileid  = (select impid from #templcustomersdetails where rowid= @rowno) and status=1              
  set @fromdate = getdate()-convert(datetime,@ToTime)          
  set @StartDate=dbo.getcurrentdatetime((convert(varchar,DATEADD(day,@intFDate,@fromdate),110) +' '+  isnull(@FrmTime,'')),1,'GMT')            
  set @EndDate=dbo.getcurrentdatetime((convert(varchar,DATEADD(day,@intTDate,@fromdate),110) +' '+  isnull(@ToTime,'')) ,1,'GMT')         
            
        
 if  EXISTS (select FI.FilePath from ARC_AR_Fileformat FF with (nolock) left join ARC_Ar_fileimportstatus FI on FI.Fileid=FF.Fileid      
 where FI.importstatus=3  and FF.Status=1 and  FF.Fileid=(select impid from #templcustomersdetails with(nolock) where rowid= @rowno)   and      
 FI.CreatedDt between @StartDate and @EndDate and FF.Multipleuploades!=1 and FF.status=1)      
      
begin      
   delete  #templcustomersdetails where rowid=@rowno      
end      
end      
      
 select * from   #templcustomersdetails  where  Filelocatedpath is not null and 
 Filelocatedpath!='' and Customerid in(1005)      
 if OBJECT_ID('tempdb..#templcustomersdetails') is not null drop table #templcustomersdetails       
       

end   
  
  
  


GO
/****** Object:  StoredProcedure [dbo].[ARC_Ar_insertfileimportstatusdetails]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[ARC_Ar_insertfileimportstatusdetails]  
(@FilePath varchar(500)=null,  
@Customerid int=0,  
@Rowscount int=0,  
@importstatus int=0,  
@ErrorDescription varchar(max)=null,  
@Identityno varchar(25)=null,  
@action tinyint=0,  
@fileid int=0,  
@SubprovisionId int=0)  
as  
begin  
if(@action=1)  
 begin  
   
    insert into ARC_Ar_fileimportstatus(Customerid,FilePath,importstatus,Rowscount,ErrorDescription,CreatedDt,Identityno,Fileid,SubprovisionId)  
   select @Customerid,@FilePath,@importstatus,@Rowscount,@ErrorDescription,getdate(),@Identityno,@fileid,@SubprovisionId  
 end  
if(@action=2)  
 begin  
   update ARC_Ar_fileimportstatus set FilePath=@FilePath,Customerid=@Customerid,  
   Rowscount=@Rowscount,importstatus=@importstatus,ErrorDescription=@ErrorDescription,UpdatedDt=getdate()   
   where Identityno=@Identityno  
    end  
end  
  
  
  
  
GO
/****** Object:  StoredProcedure [dbo].[Autoimport_FlatFile_Column_Header]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE ProcEDURE [dbo].[Autoimport_FlatFile_Column_Header](@ClientId INT,@SubProvisionId int = 0)                         
AS                     
SET NOCOUNT ON                
BEGIN 
	IF @ClientId =1006
	BEGIN
		SELECT  'ACCOUNT' ExcelFieldName union
		SELECT  'FROM' union
		SELECT  'TO' union
		SELECT  'COUNTRY' union
		SELECT  'DESCRIPTION' union
		SELECT  'CONNECTTIME' union
		SELECT  'DISCONNECTTIME' union
		SELECT  'CHARGEDTIMEHOURMINSEC' 
	END
	IF @ClientId =0
	BEGIN
		SELECT  'ACCOUNT' ExcelFieldName union
		SELECT  'FROM' union
		SELECT  'TO' union
		SELECT  'COUNTRY' union
		SELECT  'DESCRIPTION' union
		SELECT  'DATETIME' union
		SELECT  'CHARGEDTIMEHOURMINSEC' 
	END
	IF @ClientId =1003 
	BEGIN
		
		
		select 'CALLID' ExcelFieldName union
		select 'CALLTYPE' union
		select 'CALLTIME'  union
		select 'TASKGROUPNAME' union
		select 'CLIENTNAME' union
		select 'AGENTUSERNAME' union
		select 'AGENTCALLHUNTGROUPNAME' union
		select 'RESULT' union
		select 'CUSTOMERPHONENUMBER' union
		select 'AGENTCALLRESPONSETEXTCLAIMID' union
		select 'AGENTCALLTALKDURATION' union
		select 'CALLRECORDINGLINK'

	END
	
	IF @ClientId=1000
	begin
	SELECT  'GROUPBYPARAMETER' ExcelFieldName union
		SELECT  'CALLID' union
		SELECT  'CALLERANI' union
		SELECT  'CALLERID' union
		SELECT  'ARRIVALTIME' union
		SELECT  'DIRECTION' union
		SELECT  'OUTCOME' union
		SELECT  'DURATION' union
		SELECT  'TALKTIME' union
		SELECT  'TRANSFER' union
		SELECT  'TALKTIME' union
		SELECT  'HOLDS'
	end
	IF @ClientId=1001
	begin
	SELECT  'CALLID' ExcelFieldName union
		SELECT  'TIMESTAMP' union
		SELECT  'CAMPAIGN' union
		SELECT  'CALLTYPE' union
		SELECT  'AGENT' union
		SELECT  'AGENTNAME' union
		SELECT  'DISPOSITION' union
		SELECT  'ANI' union
		SELECT  'CUSTOMERNAME' union
		SELECT  'DNIS' union
		SELECT  'CALLTIME' union
		select 'IVRTIME' union
		SELECT  'QUEUEWAITTIME' union
		SELECT  'RINGTIME'union
		SELECT  'TALKTIME' union
		SELECT  'PARKTIME'union
		SELECT  'AFTERCALLWORKTIME' union
		SELECT  'TRANSFERS'union
		SELECT 'ABANDONED' union 
		select 'RECORDINGS' union 
		select 'BILLINGADDDIGIT' union
		select 'BILLINGCLAIMID' union
		select 'CUSTOMACCOUNTNUMBER' union
		select 'CLAIMID' union
		select 'ADDITIONALCLAIMID'  
	end
	IF @ClientId=1002
	begin

	    SELECT  'UNIQUEID' ExcelFieldName union
		SELECT  'USERNAME' union
		SELECT  'NOTES' union
		SELECT  'SOURCE' union
		SELECT  'DESTINATION' union
		SELECT  'CALLTYPE' union
		SELECT  'SYSTEMDISPOSITION' union
		SELECT  'USERDISPOSITION' union
		SELECT  'HANGUPCODE' union
		SELECT  'HANGUPFIRST' union
		select 'CALLSTARTTIME' union
		SELECT  'CALLANSWERTIME' union
		SELECT  'CALLENDTIME'union
		SELECT  'TALKTIMESECONDS' union
		SELECT  'RECORDINGURL' union
		SELECT  'ISDELETED' 
		  
	end
	IF @ClientId=1004
	begin
	    SELECT  'UUID' ExcelFieldName union
		SELECT  'CAMPAIGN' union
		SELECT  'SOURCE' union
		SELECT  'DESTINATION' union
		SELECT  'FINALDESTINATION' union
		SELECT  'CALLTYPE' union
		SELECT  'CALLSTATUS' union
		SELECT  'CALLSTARTTIME' union
		SELECT  'CALLRINGINGTIME' union
		SELECT  'CALLANSWEREDTIME' union
		select  'CALLENDTIME' union
		SELECT  'TOTALTIME' union
		SELECT  'TALKTIME'union
		SELECT  'TOTALHOLDTIME' union
		SELECT  'POSTDIALDELAY' union
		SELECT  'HANGUPCAUSE' union
		SELECT  'HANGUPCAUSECODE' union
		SELECT  'HANGUPFIRST' union
		SELECT  'QUEUEANSWEREDSTATUS' union
		SELECT  'QUEUESTARTTIME' union
		SELECT  'QUEUEANSWERTIME' union
		SELECT  'QUEUECANCELTIME' union
		SELECT  'QUEUEENDTIME' union
		SELECT  'DISPOSITION' union
		SELECT  'DISPOSITIONTIME' union
		SELECT  'NOTES' 
		  
	end
	IF @ClientId=1005
	begin
	    SELECT  'SESSIONID' ExcelFieldName union
		SELECT  'FROMNAME' union
		SELECT  'FROMNUMBER' union
		SELECT  'TONAME' union
		SELECT  'TONUMBER' union
		SELECT  'RESULT' union
		SELECT  'CALLLENGTH' union
		SELECT  'HANDLETIME' union
		SELECT  'CALLSTARTTIME' union
		SELECT  'CALLDIRECTION' union
		select  'QUEUE' 
		  
	end
END





GO
/****** Object:  StoredProcedure [dbo].[C3_FileWatcherDetails]    Script Date: 8/30/2020 6:36:02 PM ******/
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
/****** Object:  StoredProcedure [dbo].[C3_FileWatcherFileInput]    Script Date: 8/30/2020 6:36:02 PM ******/
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
/****** Object:  StoredProcedure [dbo].[C3_FileWatcherPath]    Script Date: 8/30/2020 6:36:02 PM ******/
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
/****** Object:  StoredProcedure [dbo].[C3_GetAppLoginInfo]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_GetAppLoginInfo]
(
	@VendorName VARCHAR(250)
	,@AppName	VARCHAR(200)
	,@AppType	VARCHAR(200)
)
AS
BEGIN
	SELECT LI.ClientID,LI.SecretID,LI.UserID,LI.[Password],LI.Extension,LI.URLLink 
	FROM C3_AppLoginInfo(NOLOCK)LI
	INNER JOIN C3_VendorMaster(NOLOCK)VM
	ON LI.VendorID = VM.VendorID
	WHERE LI.IsActive = 1 AND VM.IsActive = 1
	AND LI.AppName = @AppName AND LI.AppType = @AppType
	AND VM.VendorName = @VendorName
END
GO
/****** Object:  StoredProcedure [dbo].[C3_MapAudioFile]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_MapAudioFile]
AS
BEGIN
	Declare @Result VARCHAR(MAX), @row INT
	BEGIN TRY    
		SET @row = 0
		UPDATE ARC SET ARC.RecordingURL = FP.FullPath
		FROM (
			   SELECT CR.SNO,fi.FullPath,CR.RecordingID,CR.Uniqueid,CR.SourceAdded
			   FROM C3_FileWatcherFileInfo(NOLOCK)FI
			   INNER JOIN ARC_AR_Callrecoding(NOLOCK)CR
			   ON dbo.C3_StringSplit(FI.[FileName],'_',5) = CR.RecordingID
			   WHERE FI.FileSize > 0 AND CR.SourceAdded = 'RingCentral' 
			   AND cr.RecordingURL IS NULL
		)FP
		INNER JOIN ARC_AR_Callrecoding(NOLOCK)ARC
		ON FP.SNO = ARC.SNO
		SET @row = @@ROWCOUNT;
		SET @Result = 'Success - ' + CONVERT(VARCHAR(50),@row)
	END TRY
	BEGIN CATCH		
		SET @Result = ERROR_MESSAGE()
		INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)
		VALUES(null,'Ringcentral',null,'AudioFileMap-DB',GETDATE(),@Result)	
	END CATCH
SELECT @Result AS Result
END

----
GO
/****** Object:  StoredProcedure [dbo].[C3_NewAppLoginInfo]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_NewAppLoginInfo]
(
	@VendorName VARCHAR(250)
	,@AppName	VARCHAR(200) 
	,@ClientID	NVARCHAR(1000)
	,@SecretID	NVARCHAR(MAX)
	,@UserID	NVARCHAR(200) 
	,@Password	NVARCHAR(MAX)
	,@Extension	VARCHAR(200)
	,@URLLink	VARCHAR(500)
	,@AppType	VARCHAR(200)
	,@CreatedBy	VARCHAR(200)
)
AS
BEGIN
Declare @Result VARCHAR(MAX)
	BEGIN TRY  
		INSERT INTO C3_AppLoginInfo(VendorID,AppName,ClientID,SecretID,UserID,[Password],Extension,URLLink,AppType,CreatedBy)
		SELECT VM.VendorID, @AppName,@ClientID,@SecretID,@UserID,@Password,@Extension,@URLLink,@AppType,@CreatedBy
		FROM C3_VendorMaster(NOLOCK)VM
		WHERE VendorName = @VendorName AND IsActive = 1
		SET @Result = 'Success'
	END TRY
	BEGIN CATCH		
		SET @Result = ERROR_MESSAGE()
		INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)
		VALUES(@AppName,@VendorName,@CreatedBy,'NewApp-DB' ,GETDATE(),@Result)	
	END CATCH
SELECT @Result AS Result	
END

------
GO
/****** Object:  StoredProcedure [dbo].[C3_RCDirectoryInfo]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_RCDirectoryInfo]
(
	@Data C3_RCDirectory_Type READONLY
	,@CreatedBy VARCHAR(150) = NULL
)
AS
BEGIN
	TRUNCATE TABLE C3_RCDirectory
	INSERT INTO C3_RCDirectory(ID,ExtensionNumber,PhoneNumber,[Name],FirstName,LastName
	,Department,Email,JobTitle,PhoneType,Label,UsageType,[Status],[Type],CreatedBy)
	SELECT id,extensionNumber,phoneNumber,[name],firstName,lastName
	,department,email,jobTitle,Phonetype,label,usageType,[status],[type],@CreatedBy
	FROM @Data
	SELECT 'Success'
END
GO
/****** Object:  StoredProcedure [dbo].[C3_RCSchedulerUpdate]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_RCSchedulerUpdate]
(
	@Uniqueid			VARCHAR(1000) = NULL,	
	@CreatedBy			VARCHAR(250) = NULL,		
	@PhoneNumber		VARCHAR(300) = NULL,
	@CallInitiatedTime	DATETIME = NULL,
	@CallEndTime		DATETIME = NULL,	
	@Duration			INT = 0,		
	@Location			VARCHAR(300) = NULL,
	@RecordingID		VARCHAR(500) = NULL,
	@RecordingURL		VARCHAR(1000) = NULL,
	@FileLocation		VARCHAR(1000) = NULL,
	@CallDirection		VARCHAR(500) = NULL,
	@UserDisposition	VARCHAR(500) = NULL,
	@APIDisposition		VARCHAR(500) = NULL,
	@APIReason			VARCHAR(350) = NULL,
	@APIReasonDesc		VARCHAR(500) = NULL,
	@ClaimNo			VARCHAR(500) = NULL,
	@SchedulerStatus	VARCHAR(100) = null,
	@UpdateOption		INT = 1,
	@IsExist			TINYINT
)
AS
BEGIN
	Declare @Result VARCHAR(MAX), @CustomerID INT
	BEGIN TRY     	
	SET @Result = 'No data'
	IF OBJECT_ID('tempdb..#TmpTblExData') IS NOT NULL DROP TABLE #TmpTblExData

	/*Get existing values to review null data*/
	SELECT 'AR' TName, PhoneNumber,CallInitiatedTime,CallEndTime,APIURL,CreatedBy,CustomerID,Uniqueid,CallDisposition,
		[Location],Duration,CallDirections,RecordingID,UserDisposition
	INTO #TmpTblExData
	FROM ARC_AR_Callrecoding(NOLOCK) WHERE Uniqueid = @Uniqueid AND SourceAdded = 'RingCentral'
	UNION ALL
	SELECT 'C3' TName, PhoneNumber,CallInitiatedTime,CallEndTime,RecordingURL,CreatedBy,CustomerID,Uniqueid,APIDisposition,
		[Location],Duration,CallDirection,RecordingID,CallDisposition
	FROM C3_VoiceCallInfo(NOLOCK) WHERE Uniqueid = @Uniqueid

	if EXISTS(SELECT Uniqueid FROM #TmpTblExData WHERE Uniqueid = @Uniqueid)
	BEGIN		
		SET @CallInitiatedTime = CASE WHEN @CallInitiatedTime IS NOT NULL THEN DATEADD(MI,330,@CallInitiatedTime) ELSE @CallInitiatedTime END
		if @IsExist = 1
		BEGIN		
			/*Assign existing or new values to update*/
			SELECT TOP 1
			@PhoneNumber = CASE WHEN PhoneNumber IS NOT NULL THEN PhoneNumber ELSE @PhoneNumber END
			,@CallInitiatedTime = CASE WHEN CallInitiatedTime IS NOT NULL THEN CallInitiatedTime ELSE @CallInitiatedTime END
			,@CallInitiatedTime = CASE WHEN CallInitiatedTime IS NOT NULL THEN CallInitiatedTime ELSE @CallInitiatedTime END
			,@RecordingURL = CASE WHEN APIURL IS NOT NULL THEN APIURL ELSE @RecordingURL END
			,@CreatedBy = CASE WHEN CreatedBy IS NOT NULL THEN CreatedBy ELSE @CreatedBy END					
			,@Location = CASE WHEN [Location] IS NOT NULL THEN [Location] ELSE @Location END
			,@Duration = CASE WHEN Duration = @Duration THEN Duration ELSE 
							CASE WHEN Duration < @Duration THEN @Duration ELSE Duration END END
			,@CallDirection = CASE WHEN CallDirections IS NOT NULL THEN CallDirections ELSE @CallDirection END
			,@RecordingID = CASE WHEN RecordingID IS NOT NULL THEN RecordingID ELSE @RecordingID END				
			FROM #TmpTblExData
			WHERE TName = 'AR'
		END

		SET @CreatedBy = REPLACE(RTRIM(LTRIM(@CreatedBy)),' ','.');
		SET @PhoneNumber = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@PhoneNumber,'+',''),'(',''),')',''),' ',''),'-','');
		
		if @APIDisposition IS NOT NULL
		BEGIN
			SET @RecordingID = CASE WHEN @RecordingID IS NULL THEN 'No ID|' + @APIDisposition ELSE @RecordingID END
		END
		SELECT @CustomerID = CLIENT_ID FROM ARC_REC.DBO.ARC_REC_USER_INFO(NOLOCK) WHERE NT_USERNAME = @CreatedBy

		SELECT TOP 1 @APIDisposition = CASE WHEN CallDisposition = '' THEN @APIDisposition ELSE 
			CASE WHEN CallDisposition != @APIDisposition THEN 
			CASE WHEN ISNULL(@APIDisposition,'')='' THEN CallDisposition ELSE @APIDisposition END
			ELSE CallDisposition END END
			FROM #TmpTblExData WHERE TName = 'AR'

		if @CallInitiatedTime IS NOT NULL AND @Duration >= 0
		BEGIN		
			SET @CallEndTime = DATEADD(SECOND,@Duration,@CallInitiatedTime)
		END
		
		IF @APIDisposition IS NULL OR @APIDisposition = 'In Progress'
		BEGIN
			SET @APIDisposition = 'Connected'
		END

		if @UpdateOption = 1
		BEGIN
			UPDATE ARC_AR_Callrecoding SET PhoneNumber = @PhoneNumber ,CallInitiatedTime = @CallInitiatedTime
			,CallEndTime = @CallEndTime ,APIURL = @RecordingURL ,CreatedBy = @CreatedBy,CustomerID = @CustomerID
			,[Location] = @Location ,Duration = @Duration
			,CallDirections = @CallDirection ,RecordingID = @RecordingID
			,CallDisposition = @APIDisposition
			WHERE Uniqueid = @Uniqueid
		END
		ELSE IF @UpdateOption = 2
		BEGIN
			UPDATE ARC_AR_Callrecoding SET CallDisposition = @APIDisposition WHERE Uniqueid = @Uniqueid
		END
		ELSE IF @UpdateOption = 3
		BEGIN
			UPDATE ARC_AR_Callrecoding SET UserDisposition = @UserDisposition WHERE Uniqueid = @Uniqueid
		END
		ELSE IF @UpdateOption = 4
		BEGIN
			UPDATE ARC_AR_Callrecoding SET ClaimNo = @ClaimNo WHERE Uniqueid = @Uniqueid
		END		
		SET @Result = 'AR-Updated' 

		if EXISTS(SELECT Uniqueid FROM #TmpTblExData WHERE Uniqueid = @Uniqueid AND TName = 'C3')
		BEGIN
		if @UpdateOption = 1
		BEGIN	
			UPDATE C3_VoiceCallInfo SET PhoneNumber = @PhoneNumber ,CallInitiatedTime = @CallInitiatedTime
			,CallEndTime = @CallEndTime ,RecordingURL = @RecordingURL ,CreatedBy = @CreatedBy,CustomerID = @CustomerID
			,[Location] = @Location ,Duration = @Duration
			,CallDirection = @CallDirection ,RecordingID = @RecordingID, FileLocation = @FileLocation
			,APIDisposition = @APIDisposition, APIReason = @APIReason, APIReasonDesc = @APIReasonDesc
			,SchedulerStatus = @SchedulerStatus
			WHERE Uniqueid = @Uniqueid
		END
		ELSE IF @UpdateOption = 2
		BEGIN
			UPDATE C3_VoiceCallInfo SET APIDisposition = @APIDisposition, APIReason = @APIReason, APIReasonDesc = @APIReasonDesc
			,FileLocation = @FileLocation
			WHERE Uniqueid = @Uniqueid
		END
		ELSE IF @UpdateOption = 3
		BEGIN
			UPDATE C3_VoiceCallInfo SET CallDisposition = @UserDisposition,FileLocation = @FileLocation WHERE Uniqueid = @Uniqueid
		END
		ELSE IF @UpdateOption = 4
		BEGIN
			UPDATE C3_VoiceCallInfo SET ClaimNo = @ClaimNo,FileLocation = @FileLocation WHERE Uniqueid = @Uniqueid
		END
		SET @Result = @Result + '|C3-Updated' 
		END
	END
END TRY
	BEGIN CATCH		
		SET @Result = ERROR_MESSAGE()
		INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)
		VALUES(@Uniqueid,'Ringcentral',@CreatedBy,'RCScheduler-DB',GETDATE(),@Result)	
	END CATCH
IF OBJECT_ID('tempdb..#TmpTblExData') IS NOT NULL DROP TABLE #TmpTblExData
SELECT @Result AS Result		
END


GO
/****** Object:  StoredProcedure [dbo].[C3_RecordingIDScheduler]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_RecordingIDScheduler]  
(   
 @STime VARCHAR(50) = NULL,  
 @ETime VARCHAR(50) = NULL,  
 @RunOption TINYINT = 1  
 ,@IsLive TINYINT = NULL  
)  
AS  
BEGIN  
 DECLARE @SQLQuery VARCHAR(MAX),@SQLLive VARCHAR(MAX)  
 SET @SQLQuery = ''  
   
 if  @RunOption > 0  
 BEGIN  
  SET @SQLQuery += 'SELECT DISTINCT Uniqueid   
  FROM ARC_AR_Callrecoding(NOLOCK)   
  WHERE SourceAdded = ''RingCentral'' AND Uniqueid IS NOT NULL   
  AND Createddate >= ' + CHAR(39) + @STime + CHAR(39) + '   
  AND Createddate <= ' + CHAR(39) + @ETime + CHAR(39)  
 END  
 ELSE  
 BEGIN  
  /*SET @SQLQuery += 'SELECT DISTINCT Uniqueid   
  FROM C3_VoiceCallInfo(NOLOCK)   
  WHERE Uniqueid IS NOT NULL   
  AND Createddate >= ' + CHAR(39) + @STime + CHAR(39) + '   
  AND Createddate <= ' + CHAR(39) + @ETime + CHAR(39) +'  
  AND CallEndTime IS NULL AND SchedulerStatus = ''1'''*/  
  SET @SQLQuery += 'SELECT DISTINCT Uniqueid FROM (  
   SELECT ROW_NUMBER() OVER (PARTITION BY createdby  
   ORDER BY createdby,CallInitiatedTime DESC) AS RNO  
   ,Uniqueid,createdby,CallInitiatedTime    
   FROM ARC_AR_Callrecoding(NOLOCK)   
   WHERE sourceadded = ''RingCentral''   
   AND Createddate >= ' + CHAR(39) + @STime + CHAR(39) + '   
   AND Createddate <= ' + CHAR(39) + @ETime + CHAR(39) + '  
   AND CallEndTime IS NULL AND createdby IS NOT NULL  
  )X WHERE X.RNO > 1
  union
  SELECT DISTINCT Uniqueid FROM (  
   SELECT ROW_NUMBER() OVER (PARTITION BY createdby  
   ORDER BY createdby,CallInitiatedTime DESC) AS RNO  
   ,Uniqueid,createdby,CallInitiatedTime    
   FROM ARC_AR_Callrecoding(NOLOCK)   
   WHERE sourceadded = ''RingCentral''   
   AND Createddate >= ' + CHAR(39) + @STime + CHAR(39) + '   
   AND Createddate <= ' + CHAR(39) + @ETime + CHAR(39) + '  
   AND CallEndTime IS NULL AND createdby IS NOT NULL  
  And CallInitiatedTime<=dateadd(minute,-30,getdate())
    )X WHERE X.RNO = 1'  
 END  
  
 IF @RunOption = 1  
 BEGIN  
  SET @SQLQuery += '   
  AND (PhoneNumber IS NULL OR CallInitiatedTime IS NULL   
  OR CreatedBy IS NULL OR RecordingID IS NULL) '    
 END  
 ELSE IF @RunOption = 2  
 BEGIN  
  SET @SQLQuery += '   
  AND (PhoneNumber IS NULL OR CallInitiatedTime IS NULL   
  OR CreatedBy IS NULL OR RecordingID IS NULL   
  OR CallEndTime IS NULL) '  
 END   
 ELSE IF @RunOption = 3  
 BEGIN  
  SET @SQLQuery += '   
  AND RecordingID IS NULL AND CallEndTime IS NOT NULL '  
 END   
 ELSE IF @RunOption = 4  
 BEGIN  
  SET @SQLQuery += '   
  AND RecordingID IS NULL'  
 END   
 ELSE IF @RunOption = 5  
 BEGIN  
  SET @SQLQuery += '   
  AND CreatedBy IS NULL AND (CallDirections != ''Inbound'' OR CallDirections IS NULL)'   
 END   
 ELSE IF @RunOption = 6  
 BEGIN  
  SET @SQLQuery += '   
  AND CallEndTime IS NULL'  
 END   
 --PRINT @SQLQuery   
 EXEC(@SQLQuery)   
END
GO
/****** Object:  StoredProcedure [dbo].[C3_SchedulerInfo]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_SchedulerInfo]
(
@STime VARCHAR(50) = NULL
,@ETime VARCHAR(50) = NULL
,@RunOption TINYINT = 1
,@Input VARCHAR(50) = NULL
,@IsLive TINYINT = NULL
)
AS
BEGIN
	DECLARE @SQLQuery VARCHAR(MAX)
	SET @SQLQuery = ''

	SET @SQLQuery += 'SELECT DISTINCT Uniqueid 
		FROM C3_VoiceCallInfo(NOLOCK) 
		WHERE Uniqueid IS NOT NULL 
		AND Createddate >= ' + CHAR(39) + @STime + CHAR(39) + ' 
		AND Createddate <= ' + CHAR(39) + @ETime + CHAR(39) 
	IF @RunOption = 1
	BEGIN
		SET @SQLQuery += Char(10) + ' AND SchedulerStatus = '+ 
		CHAR(39) + @Input + CHAR(39)
	END
	ELSE IF @RunOption = 2
	BEGIN
		SET @SQLQuery += Char(10) + ' AND FileLocation = '+ 
		CHAR(39) + @Input + CHAR(39)
	END
	ELSE IF @RunOption = 3
	BEGIN
		SET @SQLQuery += Char(10) + ' AND ClaimNo = '+ 
		CHAR(39) + ISNULL(@Input,'') + CHAR(39)
	END
	ELSE IF @RunOption = 4
	BEGIN
		SET @SQLQuery += Char(10) + ' AND CallDisposition = '+ 
		CHAR(39) + @Input + CHAR(39)
	END
	ELSE IF @RunOption = 5
	BEGIN
		SET @SQLQuery += Char(10) + ' AND CALLENDTIME IS NOT NULL AND FileLocation != ''Dis''  AND APIDisposition = '+ 
		CHAR(39) + @Input + CHAR(39)
	END
	--PRINT @SQLQuery	
	EXEC(@SQLQuery)	
END


GO
/****** Object:  StoredProcedure [dbo].[C3_SchedulerUpdate]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_SchedulerUpdate]  
(  
 @PhoneNumber  VARCHAR(300) = NULL,  
 @CallInitiatedTime DATETIME = NULL,  
 @CallEndTime  DATETIME = NULL,  
 @RecordingURL  VARCHAR(1000) = NULL,  
 @CreatedBy   VARCHAR(250) = NULL,   
 @Uniqueid   VARCHAR(1000) = NULL,  
 @CallDisposition VARCHAR(500) = NULL,  
 @Location   VARCHAR(300) = NULL,  
 @Duration   INT = 0,   
 @CallDirection  VARCHAR(500) = NULL,  
 @RecordingID  VARCHAR(500) = NULL,  
 @FileLocation  VARCHAR(1000) = NULL,  
 @APIReason   VARCHAR(350) = NULL,  
 @APIReasonDesc  VARCHAR(500) = NULL,  
 @IsExist   TINYINT  
)  
AS  
BEGIN  
 Declare @Result VARCHAR(MAX), @CustomerID INT,@calldate date  
 BEGIN TRY        
 SET @Result = 'No data'  
 IF OBJECT_ID('tempdb..#TmpTblExData') IS NOT NULL DROP TABLE #TmpTblExData  
  
 /*Get existing values to review null data*/  
 SELECT 'AR' TName, PhoneNumber,CallInitiatedTime,CallEndTime,APIURL,CreatedBy,CustomerID,Uniqueid,CallDisposition,  
  [Location],Duration,CallDirections,RecordingID,calldate  
 INTO #TmpTblExData  
 FROM ARC_AR_Callrecoding(NOLOCK) WHERE Uniqueid = @Uniqueid AND SourceAdded = 'RingCentral'  
 UNION ALL  
 SELECT 'C3' TName, PhoneNumber,CallInitiatedTime,CallEndTime,RecordingURL,CreatedBy,CustomerID,Uniqueid,CallDisposition,  
  [Location],Duration,CallDirection,RecordingID,NUll  
 FROM C3_VoiceCallInfo(NOLOCK) WHERE Uniqueid = @Uniqueid  
  
  
 if EXISTS(SELECT Uniqueid FROM #TmpTblExData WHERE Uniqueid = @Uniqueid)  
 BEGIN    
  SET @CallInitiatedTime = CASE WHEN @CallInitiatedTime IS NOT NULL THEN DATEADD(MI,330,@CallInitiatedTime) ELSE @CallInitiatedTime END  
  if @IsExist = 1  
  BEGIN    
   /*Assign existing or new values to update*/  
   SELECT TOP 1  
   @PhoneNumber = CASE WHEN PhoneNumber IS NOT NULL THEN PhoneNumber ELSE @PhoneNumber END  
   ,@CallInitiatedTime = CASE WHEN CallInitiatedTime IS NOT NULL THEN CallInitiatedTime ELSE @CallInitiatedTime END  
   ,@CallInitiatedTime = CASE WHEN CallInitiatedTime IS NOT NULL THEN CallInitiatedTime ELSE @CallInitiatedTime END  
   ,@RecordingURL = CASE WHEN APIURL IS NOT NULL THEN APIURL ELSE @RecordingURL END  
   ,@CreatedBy = CASE WHEN CreatedBy IS NOT NULL THEN CreatedBy ELSE @CreatedBy END    
   /*,@CallDisposition = CASE WHEN CallDisposition IS NOT NULL THEN CallDisposition ELSE @CallDisposition END*/  
   ,@Location = CASE WHEN [Location] IS NOT NULL THEN [Location] ELSE @Location END  
   ,@Duration = CASE WHEN Duration = @Duration THEN Duration ELSE   
       CASE WHEN Duration < @Duration THEN @Duration ELSE Duration END END  
   ,@CallDirection = CASE WHEN CallDirections IS NOT NULL THEN CallDirections ELSE @CallDirection END  
   ,@RecordingID = CASE WHEN RecordingID IS NOT NULL THEN RecordingID ELSE @RecordingID END  
   ,@calldate=calldate   
   FROM #TmpTblExData  
   WHERE TName = 'AR'  
  END  
  
  SET @CreatedBy = REPLACE(RTRIM(LTRIM(@CreatedBy)),' ','.');  
  SET @PhoneNumber = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@PhoneNumber,'+',''),'(',''),')',''),' ',''),'-','');  
  if @CallDisposition IS NOT NULL  
  BEGIN  
   SET @RecordingID = CASE WHEN @RecordingID IS NULL THEN 'No ID|' + @CallDisposition ELSE @RecordingID END  
  END  
  SELECT @CustomerID = CLIENT_ID FROM ARC_REC.DBO.ARC_REC_USER_INFO(NOLOCK) WHERE NT_USERNAME = @CreatedBy  
  
  if @CallInitiatedTime IS NOT NULL AND @Duration >= 0  
  BEGIN    
   SET @CallEndTime = DATEADD(SECOND,@Duration,@CallInitiatedTime)  
  END  
  
  UPDATE ARC_AR_Callrecoding SET PhoneNumber = @PhoneNumber ,CallInitiatedTime = @CallInitiatedTime  
   ,CallEndTime = @CallEndTime ,APIURL = @RecordingURL ,CreatedBy = @CreatedBy,CustomerID = @CustomerID  
   /*,CallDisposition = @CallDisposition*/,[Location] = @Location ,Duration = @Duration  
   ,CallDirections = @CallDirection ,RecordingID = @RecordingID  
  WHERE Uniqueid = @Uniqueid AND SourceAdded = 'RingCentral' and calldate=@calldate  
   SET @Result = 'AR-Updated'   
  if EXISTS(SELECT Uniqueid FROM #TmpTblExData WHERE Uniqueid = @Uniqueid AND TName = 'C3')  
  BEGIN  
   UPDATE C3_VoiceCallInfo SET PhoneNumber = @PhoneNumber ,CallInitiatedTime = @CallInitiatedTime  
   ,CallEndTime = @CallEndTime ,RecordingURL = @RecordingURL ,CreatedBy = @CreatedBy,CustomerID = @CustomerID  
   /*,CallDisposition = @CallDisposition*/,[Location] = @Location ,Duration = @Duration  
   ,CallDirection = @CallDirection ,RecordingID = @RecordingID, FileLocation = @FileLocation  
   ,APIDisposition = @CallDisposition, APIReason = @APIReason, APIReasonDesc = @APIReasonDesc  
  WHERE Uniqueid = @Uniqueid AND SourceAdded = 'RingCentral'  
   SET @Result = @Result + '|C3-Updated'   
  END  
 END  
END TRY  
 BEGIN CATCH    
  SET @Result = ERROR_MESSAGE()  
  INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)  
  VALUES(@Uniqueid,'Ringcentral',@CreatedBy,'Scheduler-DB',GETDATE(),@Result)   
 END CATCH  
IF OBJECT_ID('tempdb..#TmpTblExData') IS NOT NULL DROP TABLE #TmpTblExData  
SELECT @Result AS Result    
END  
GO
/****** Object:  StoredProcedure [dbo].[C3_URLRedirect]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_URLRedirect]
(
	@Ntuser VARCHAR(150)
)
AS
BEGIN
	
	IF EXISTS(SELECT IsURLError FROM C3_UserMaster(NOLOCK) 
			WHERE NTUserName = @Ntuser AND IsURLError = 1)
	BEGIN
		SELECT 'Success'
	END
	ELSE
	BEGIN
		/*SELECT 'https://portal.accesshealthcare.co/ar_echoc3/'*/
		SELECT TOP 1 ISNULL(CL.C3URL,'Success') C3URL
		FROM ARC_REC.dbo.ARC_REC_UserCustomer(NOLOCK)UC
		INNER JOIN ARC_REC.dbo.ARC_REC_USER_INFO/*ARC_REC_USER_INFOVY*/(NOLOCK)UI
		ON UC.UserId = UI.USERID
		LEFT JOIN C3_CustomerListFlow(NOLOCK)CL
		ON UC.CustomerID = CL.ClientID and cl.IsActive = 1
		WHERE UI.NT_USERNAME = @Ntuser
		ORDER BY UC.TriModifyon DESC
	END
END

GO
/****** Object:  StoredProcedure [dbo].[C3_VoiceCallApiErrrorInfo]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[C3_VoiceCallApiErrrorInfo]
(
	@Uniqueid		VARCHAR(1000) = NULL,
	@SourceAdded	VARCHAR(250) = NULL,
	@NtUserName		VARCHAR(150) = NULL,
	@ErrorAt		VARCHAR(250) = NULL,
	@ErrorOn		DATETIME = NULL,
	@ErrorMessage	VARCHAR(MAX) = NULL
)
AS
BEGIN
	INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)
	VALUES(@Uniqueid,@SourceAdded,@NtUserName,@ErrorAt,@ErrorOn,@ErrorMessage)	
END

GO
/****** Object:  StoredProcedure [dbo].[C3_VoiceCallApiInfo]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_VoiceCallApiInfo]  
(  
	@Uniqueid VARCHAR(500),
	@Data C3_CallInfo_Type READONLY, 
	@IsInsert   TINYINT,
	@Result	VARCHAR(250) = NULL
)
AS  
BEGIN
DECLARE @spResult VARCHAR(MAX), @CustomerID INT, @sTime DATETIME
DECLARE @cDate DATE,@sDateTime DATETIME, @ID INT, @lstEndCall DATETIME
DECLARE @tblPHNO VARCHAR(300),@tblSTime DATETIME, @tblCreatedBy VARCHAR(250), @tblCustomerID INT  
,@tblCallDirection VARCHAR(500),@FileLoc VARCHAR(5),@tblCallDisposition VARCHAR(250)
,@tblClaimNo VARCHAR(250),@tblCallEndTime DATETIME,@tblDuration INT,@tblReason VARCHAR(250)
DECLARE @ClaimNo	VARCHAR(250),
@ToPhoneNumber		VARCHAR(150),
@CallInitiatedTime	DateTime,		
@RecordingURL		VARCHAR(1000),
@FromName			VARCHAR(150),		
@CallDisposition	VARCHAR(350),
@ToLocation			VARCHAR(250),
@ToName				VARCHAR(150),
@Duration			INT = 0,
@Direction			VARCHAR(350),
@RecordingID		VARCHAR(150),	
@FromExtn			VARCHAR(150),
@PageURL			VARCHAR(250),
@Reason				VARCHAR(250),
@ReasonDescription	VARCHAR(1000),
@CreatedBy			VARCHAR(250),
@PhoneNumber		VARCHAR(250),
@SourceAdded		VARCHAR(100),
@CallEndTime		DATETIME,
@EndCallEventFlag	INT = NULL,
@UserSystemDateTime	DATETIME = NULL,
@SchedulerStatus	VARCHAR(50)= NULL,
@APIResult			VARCHAR(250)

 BEGIN TRY               
	  IF @Uniqueid IS NOT NULL  
	  BEGIN  
		IF OBJECT_ID('tempdb..#TmbTblC3CallInfo') IS NOT NULL DROP TABLE #TmbTblC3CallInfo
		IF OBJECT_ID('tempdb..#TmbTblC3ECall') IS NOT NULL DROP TABLE #TmbTblC3ECall
		SELECT * INTO #TmbTblC3CallInfo FROM @Data

	  /*Assign existing or new values to update*/
		SELECT TOP 1
			@ClaimNo = ClaimNo,
			@ToPhoneNumber = ToPhoneNumber,
			@CallInitiatedTime = CallInitiatedTime,
			@RecordingURL = RecordingURL,
			@FromName = FromName,
			@CallDisposition = CallDisposition,
			@ToLocation = ToLocation,
			@ToName = ToName,
			@Duration = Duration,
			@Direction = Direction,
			@RecordingID = RecordingID,
			@FromExtn = FromExtn,
			@PageURL = PageURL,
			/*CASE WHEN PageURL LIKE '%echoc3.accesshealthcare.co/echoc3_dialer%' THEN 'V1' 
					ELSE CASE WHEN PageURL LIKE '%arflow.accesshealthcare.co/ar_echoc3%' THEN 'V2' ELSE NULL END END,*/
			@Reason = Reason,
			@ReasonDescription = ReasonDescription,
			@EndCallEventFlag = EndCallEventFlag,
			@UserSystemDateTime = UserSystemDateTime,
			@APIResult = @Result
		FROM #TmbTblC3CallInfo	

		/*Assign the variable with condition*/
		SET @CreatedBy = CASE WHEN @FromName IS NOT NULL THEN @FromName ELSE @FromExtn END  
		SET @PhoneNumber = @ToPhoneNumber   
		SET @SourceAdded = 'RingCentral'  
		SET @CreatedBy = REPLACE(RTRIM(LTRIM(@CreatedBy)),' ','.');  
		SET @PhoneNumber = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@PhoneNumber,'+',''),'(',''),')',''),' ',''),'-','');  
		SELECT @CustomerID = CLIENT_ID FROM ARC_REC.DBO.ARC_REC_USER_INFO(NOLOCK) WHERE NT_USERNAME = @CreatedBy  				
		SET @UserSystemDateTime = CASE WHEN @UserSystemDateTime IS NOT NULL THEN DATEADD(MI,330,@UserSystemDateTime) 
								ELSE @UserSystemDateTime END 
		SET @FileLoc = null
		if DATEADD(HOUR,-9,GETDATE()) <= @CallInitiatedTime
		BEGIN
			SET @CallInitiatedTime =  DATEADD(MI,330,@CallInitiatedTime)
			SET @SchedulerStatus = NULL
		END
		ELSE
		BEGIN
			SET @CallInitiatedTime =  DATEADD(SECOND,-1,GETDATE())
			SET @SchedulerStatus = '2'
		END  
		
		/*Validate the uniqueid exist then inser and update */
		if EXISTS(SELECT Uniqueid FROM C3_VoiceCallInfo(NOLOCK) WHERE Uniqueid = @Uniqueid)  
		BEGIN      
			
			/*Get existing values to review null data*/  
			SELECT @tblPHNO = PhoneNumber, @tblSTime= CallInitiatedTime, @tblCreatedBy =CreatedBy  
			, @tblCustomerID = CustomerID, @tblCallDirection = CallDirection
			, @tblCallEndTime = CallEndTime
			, @tblCallDisposition = ISNULL(CallDisposition,'')
			, @tblReason = ISNULL(APIDisposition,'')
			, @tblClaimNo = ISNULL(ClaimNo,'')
			, @tblDuration = Duration
			FROM C3_VoiceCallInfo(NOLOCK) WHERE Uniqueid = @Uniqueid and SourceAdded ='Ringcentral'
  
			/*Assign existing or new values to update*/  
			SET @PhoneNumber = CASE WHEN @tblPHNO IS NULL THEN @PhoneNumber ELSE @tblPHNO END  
			SET @CallInitiatedTime = CASE WHEN @tblSTime IS NULL THEN @CallInitiatedTime ELSE @tblSTime END  
			SET @CallEndTime = CASE WHEN @tblCallEndTime IS NULL THEN @CallEndTime ELSE @tblCallEndTime END  
			SET @CreatedBy = CASE WHEN @tblCreatedBy IS NULL THEN @CreatedBy ELSE @tblCreatedBy END  
			SET @CustomerID = CASE WHEN @tblCustomerID IS NULL THEN @CustomerID ELSE @tblCustomerID END  
			SET @Direction = CASE WHEN @tblCallDirection IS NULL THEN @Direction ELSE @tblCallDirection END
			SET @CallDisposition = CASE WHEN @tblCallDisposition = '' THEN @CallDisposition ELSE 
								CASE WHEN @tblCallDisposition != @CallDisposition THEN 
								CASE WHEN ISNULL(@CallDisposition,'')='' THEN @tblCallDisposition ELSE @CallDisposition END
								ELSE @tblCallDisposition END END
			SET @APIResult = CASE WHEN @tblReason = '' THEN @APIResult ELSE 
								CASE WHEN @tblReason != @APIResult THEN 
								CASE WHEN ISNULL(@APIResult,'')='' THEN @tblReason ELSE @APIResult END
								ELSE @tblReason END END			
			SET @ClaimNo = CASE WHEN @tblClaimNo = '' THEN @ClaimNo ELSE CASE WHEN @tblClaimNo != @ClaimNo THEN 
								CASE WHEN ISNULL(@ClaimNo,'')='' THEN @tblClaimNo ELSE @ClaimNo END
								ELSE @tblClaimNo END END
			
			/*change the disposion in progress to connected*/
			if @CallDisposition = 'In Progress' OR @CallDisposition IS NULL
			BEGIN 
				SET @CallDisposition = 'Connected' 
			END
			IF @APIResult IS NULL OR @APIResult = 'In Progress'
			BEGIN
				SET @APIResult = 'Connected'
			END

			 /**/
			if (@Duration > 0 AND @Duration < 6) OR (@tblDuration >= @Duration)
			BEGIN
				SET @Duration = @tblDuration
				--SET @CallDisposition = @tblCallDisposition
				--SET @ClaimNo = @tblClaimNo
			END 
			/*Assing the duration for endpart disconnect*/
			if @EndCallEventFlag = 2 AND @CallInitiatedTime IS NOT NULL AND @CallEndTime IS NULL
			BEGIN
				SET @Duration = DATEDIFF(SECOND,@CallInitiatedTime,@UserSystemDateTime)
			END

  			/*Assign the end call time*/
			IF @IsInsert = 1/*Direct Update detail as Insert*/  
			BEGIN     
				if @CallInitiatedTime IS NOT NULL  
				BEGIN    
					if @Duration = 0  
					BEGIN  
						SET @Duration = DATEDIFF(SECOND,@CallInitiatedTime,GETDATE())  
						SET @FileLoc = '2'         
					END    
				SET @CallEndTime = DATEADD(SECOND,@Duration,@CallInitiatedTime)  
				END  
			END  
			ELSE IF @IsInsert = 0/*Insert ID*/  
			BEGIN  
				SET @CallEndTime = NULL  
			END
				  
			--BEGIN TRANSACTION  
			UPDATE C3_VoiceCallInfo SET ClaimNo = @ClaimNo, CallEndTime = @CallEndTime, CallDisposition = @CallDisposition  
			,Duration = @Duration, RecordingID = @RecordingID, RecordingURL = @RecordingURL  
			,PhoneNumber = @PhoneNumber, CallInitiatedTime = @CallInitiatedTime, CreatedBy = @CreatedBy  
			,CustomerID = @CustomerID,CallDirection = @Direction ,FileLocation = @FileLoc  
			,APIDisposition = @APIResult,APIReason = @Reason,APIReasonDesc = @ReasonDescription
			WHERE Uniqueid = @Uniqueid  and SourceAdded ='Ringcentral'
  
			UPDATE ARC_AR_Callrecoding SET ClaimNo = @ClaimNo, CallEndTime = @CallEndTime, CallDisposition = @APIResult 
			,Duration = @Duration, RecordingID = @RecordingID, APIURL = @RecordingURL  
			,PhoneNumber = @PhoneNumber, CallInitiatedTime = @CallInitiatedTime, CreatedBy = @CreatedBy  
			,CustomerID = @CustomerID,CallDirections = @Direction, UserDisposition = @CallDisposition   
			WHERE Uniqueid = @Uniqueid and SourceAdded ='Ringcentral'
			--COMMIT TRANSACTION  
		END  
		ELSE  
		BEGIN  
			
			/*Assing the duration for endpart disconnect*/
			if @EndCallEventFlag = 2 AND @CallInitiatedTime IS NOT NULL AND @CallEndTime IS NULL
			BEGIN
				SET @Duration = DATEDIFF(SECOND,@CallInitiatedTime,@UserSystemDateTime)
			END

			/*change the disposion in progress to connected*/
			if @CallDisposition = 'In Progress' OR @CallDisposition IS NULL
			BEGIN 
				SET @CallDisposition = 'Connected' 
			END
			IF @APIResult IS NULL OR @APIResult = 'In Progress'
			BEGIN
				SET @APIResult = 'Connected'
			END

			/*Assign the end call time*/
			IF @IsInsert = 1/*Direct Update detail as Insert*/  
			BEGIN     
				if @CallInitiatedTime IS NOT NULL  
				BEGIN    
					if @Duration = 0  
					BEGIN  
						SET @Duration = DATEDIFF(SECOND,@CallInitiatedTime,GETDATE())  
						SET @FileLoc = '2'         
					END    
				SET @CallEndTime = DATEADD(SECOND,@Duration,@CallInitiatedTime)  
				END  
			END  
			ELSE IF @IsInsert = 0/*Insert ID*/  
			BEGIN  
				SET @CallEndTime = NULL  
			END  

			/*Assing the start time to get missing value*/		
			SET @cDate = CASE WHEN CONVERT(TIME,GETDATE()) BETWEEN '00:00:00:00' AND '08:00:00:00'                                         
			THEN DATEADD(DAY,-1,CONVERT(DATE,GETDATE())) ELSE CONVERT(DATE,GETDATE()) END                                               
			SET @sDateTime = DATEADD(DAY, DATEDIFF(DAY, 0, @cDate),'08:00:00') 
				
			 /*Get the old record to review the null value*/        
			SELECT  SNO,  CallEndTime INTO #TmbTblC3ECall       
			FROM C3_VoiceCallInfo(NOLOCK)         
			WHERE Uniqueid != @Uniqueid AND CallInitiatedTime >= @sDateTime  
			AND CreatedBy = @CreatedBy AND ISNULL(SchedulerStatus,'') <>'1'  
			AND CallEndTime IS NULL
	
			--BEGIN TRANSACTION  
			INSERT INTO C3_VoiceCallInfo(ClaimNo,InsuranceName,PhoneNumber,CallInitiatedTime,CallEndTime,RecordingURL  
			,CreatedBy,SourceAdded ,CustomerID,Uniqueid,CallDisposition,[Location],Duration,CallDirection  
			,RecordingID,FileLocation,C3Version,APIDisposition,APIReason,APIReasonDesc,FromExtn,ToName
			,SchedulerStatus)  
			VALUES(@ClaimNo,NULL,@PhoneNumber,@CallInitiatedTime,@CallEndTime,@RecordingURL,@CreatedBy  
			,@SourceAdded,@CustomerID,@Uniqueid,@CallDisposition,@ToLocation,@Duration,@Direction  
			,@RecordingID,@FileLoc,@PageURL,@APIResult, @Reason, @ReasonDescription,@FromExtn,@ToName
			,@SchedulerStatus)  
         
			INSERT INTO ARC_AR_Callrecoding(ClaimNo,PhoneNumber,CallInitiatedTime,CallEndTime,APIURL  
			,CreatedBy,SourceAdded ,CustomerID,Uniqueid,CallDisposition,[Location],Duration,RecordingID  
			,IsAPI,calldate,CallDirections,UserDisposition)  
			VALUES(@ClaimNo,@PhoneNumber,@CallInitiatedTime,@CallEndTime,@RecordingURL,@CreatedBy  
			,@SourceAdded,@CustomerID,@Uniqueid,@APIResult,@ToLocation,@Duration,@RecordingID,1  
			,CONVERT(DATE, DATEADD(n, -630, GETDATE())) ,@Direction, @CallDisposition)   
							 
		   /*Flag marked for null value data to run the scheduler*/        
		   if EXISTS(SELECT TOP 1 'x' FROM #TmbTblC3ECall)      
		   BEGIN        
			UPDATE a SET SchedulerStatus = '1' 
			FROM C3_VoiceCallInfo(NOLOCK) a  
			INNER JOIN #TmbTblC3ECall b 
			ON a.sno=b.SNO  
			WHERE ISNULL(SchedulerStatus,'') <>'1'   
		   END     
			--COMMIT TRANSACTION    
		END  
	END      
	SET @spResult = 'Success'  
	END TRY  
	BEGIN CATCH  
		BEGIN TRY ROLLBACK TRANSACTION END TRY BEGIN CATCH END CATCH  
		SET @spResult = ERROR_MESSAGE()  
		INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)  
		VALUES(@Uniqueid,@SourceAdded,@CreatedBy,'DB',GETDATE(),@spResult)   
	END CATCH  
IF OBJECT_ID('tempdb..#TmbTblC3CallInfo') IS NOT NULL DROP TABLE #TmbTblC3CallInfo
IF OBJECT_ID('tempdb..#TmbTblC3ECall') IS NOT NULL DROP TABLE #TmbTblC3ECall
SELECT @spResult AS Result, @Uniqueid Uniqueid ,@CallEndTime CallEndTime, @CreatedBy CreatedBy  
END

GO
/****** Object:  StoredProcedure [dbo].[Callrecording_apayaa_autoimport]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Callrecording_apayaa_autoimport](
@filepath varchar(1000)=null,
@Customerid int=0,
@Customername varchar(250)=null,
@Format varchar(20)=null,
@Table varchar(300)=null,
@result varchar(750)=null OUTPUT)
as
begin


if not exists(select FI.FilePath from ARC_AR_Fileformat FF left join ARC_Ar_fileimportstatus FI on FI.Customerid=FF.CustomerId
	where FI.importstatus=3 and FF.Status=1 and  FF.CustomerId=@Customerid 	and FI.FilePath=@filepath)
begin
		truncate table Callrecording_apayaa_importtable 
		select @result='File imported sucessfuly'
end
 else
begin
		truncate table Callrecording_apayaa_importtable
		select @result='File name already exist.if you want import same file please change file name from folder'
end
end


GO
/****** Object:  StoredProcedure [dbo].[Callrecording_apayaa_import]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Callrecording_apayaa_import]      
(        
 @Format varchar(5000)=null,        
 @locationid int =1 ,         
 @CustomerId  int=0,         
 @sessionid VARCHAR(50)=null,        
 @USERID INT=1,        
 @importstatus varchar(max)=null OUTPUT )        
AS        
        
BEGIN        
 declare @PurgeCount int=0,@Duplicate int = 0,@FileType int = 1,         
 @MultiPurgeCount int=0,@MultiDuplicate int = 0 ,         
 @NoramlImportCount int=0,@MultiTouchImportCount int=0,@Totalflatfilerows int=0,@Exstions varchar(max)=null,@Minutes int=0,@ApayaTime varchar(100)='';         
        
    set @Totalflatfilerows=(select COUNT ('a') from  Callrecording_apayaa_importtable)      
      
    update Callrecording_apayaa_importtable set USERNAME=trim(USERNAME)      
          
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData         
    create table #TempData(CallInitiatedTime datetime,CallEndTime datetime,      
 CreatedBy varchar(2500),SourceAdded varchar(2500),CustomerName varchar(2500),      
 CreatedDate datetime,Extension varchar(2000),CustomerID int,      
 SubProvisionId int,Location varchar(2500),Duration varchar(200),      
 PhoneNumber varchar(200),CallDisposition varchar(max),      
 UniqueID varchar(max))      
      
-- BEGIN TRY                  
--BEGIN TRANSACTION                      
    If OBJECT_ID('tempdb..#ExtensionmappedtData') is not null DROP TABLE #ExtensionmappedtData        
    create table #ExtensionmappedtData(Extension varchar(20))      
    delete from Callrecording_apayaa_importtable where TALKTIMESECONDS='null'       
    if exists (select top 1 * from Callrecording_apayaa_importtable)      
    begin      
      set @ApayaTime=(select top 1 CALLSTARTTIME  from Callrecording_apayaa_importtable)      
      set @Minutes=(select IST_Minutes from ARC_AR_TimeZoneConverter where TimeZone='EST' and Status=1 and convert(datetime, @ApayaTime) between StartDate and Enddate)      
      If OBJECT_ID('tempdb..#tempmaxusercustomer') is not null DROP TABLE #tempmaxusercustomer                     
      create table #tempmaxusercustomer(nt_username varchar(100), Userid int, CustomerId int, SubprovisionId int)                  
            
 insert into Callrecording_apayaa_ImportData(UNIQUEID,USERNAME,NOTES,      
 SOURCE,DESTINATION,CALLTYPE,SYSTEMDISPOSITION,USERDISPOSITION,      
 HANGUPCODE,HANGUPFIRST,CALLSTARTTIME,CALLANSWERTIME,CALLENDTIME,      
 TALKTIMESECONDS,RECORDINGURL,ISDELETED,CreatedDate)      
      
 select UNIQUEID,USERNAME,NOTES,      
 SOURCE,DESTINATION,CALLTYPE,SYSTEMDISPOSITION,USERDISPOSITION,      
 HANGUPCODE,HANGUPFIRST,CALLSTARTTIME,CALLANSWERTIME,CALLENDTIME,      
 TALKTIMESECONDS,RECORDINGURL,ISDELETED,getdate()       
 from Callrecording_apayaa_importtable      
          
      
 insert into #tempmaxusercustomer          
 select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                   
 FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                   
 inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_UserProfileMapping (nolock) UPM on UPM.UserID=UIF.USERID and UPM.Status=1                  
 inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ProfileMaster (nolock) PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                  
 inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ClientMaster_InternalExternal_View (nolock) CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                    
 inner join ARC_REC..ARC_REC_usercustomer (nolock) UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                  
 group by  UIF.nt_username,UIF.UserId,CV.CustomerID      
       
 insert into #tempmaxusercustomer                  
    select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                   
    FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                   
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_UserProfileMapping  UPM on UPM.UserID=UIF.USERID and UPM.Status=1                  
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                  
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ClientMaster_View  CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                    
    inner join ARC_REC..ARC_REC_usercustomer  UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                  
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID      
       
       
 insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,Extension,      
 CustomerID,SubProvisionId,Location,Duration,PhoneNumber,      
 CallDisposition,UniqueID)                  
    select distinct CI.CALLSTARTTIME CallInitiatedTime,coalesce(CALLENDTIME,CALLSTARTTIME),UIF.NT_USERNAME CreatedBy,                  
    'Apayaa' SourceAdded ,GETDATE()CreatedDate,[SOURCE] Extension,UIF.CustomerID,UIF.SubProvisionId,'USA',                    
    TALKTIMESECONDS Duration,DESTINATION as PhoneNumber,CALLTYPE+'@@'+SYSTEMDISPOSITION as CallDisposition, CI.UNIQUEID as  UniqueID                   
    FROM Callrecording_apayaa_importtable (nolock) CI                    
    inner join #tempmaxusercustomer UIF on CI.USERNAME=UIF.NT_USERNAME                  
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,coalesce(CALLENDTIME,CALLSTARTTIME))=D.Date                   
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance   A on UIF.USERID=A.UserId and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey                  
                 
/*Pending rows*/      
 insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,Extension,      
 CustomerID,SubProvisionId,Location,Duration,PhoneNumber,      
 CallDisposition,UniqueID)                  
    select CI.CALLSTARTTIME CallInitiatedTime,coalesce(CALLENDTIME,CALLSTARTTIME),      
 UIF.NT_USERNAME CreatedBy,'Apayaa' SourceAdded ,GETDATE()CreatedDate,      
 [SOURCE] Extension,A.PrimaryClientId,0,'USA',                    
    TALKTIMESECONDS Duration,DESTINATION as PhoneNumber,      
 CALLTYPE+'@@'+SYSTEMDISPOSITION as CallDisposition,       
 UNIQUEID as  UniqueID                   
    FROM Callrecording_apayaa_importtable  CI                    
    inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.USERNAME=UIF.NT_USERNAME                  
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,coalesce(CALLENDTIME,CALLSTARTTIME))=D.Date                   
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance   A on UIF.USERID=A.UserId and D.DateKey=A.DateKey                  
    where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp  WHERE  temp.CreatedBy = CI.USERNAME and temp.UniqueID = cI.UNIQUEID)      
       
 /*Missing users mapping with Rec db with current day*/                  
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,      
 SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,Location,      
 Duration,PhoneNumber,CallDisposition,UniqueID)                  
    select CI.CALLSTARTTIME CallInitiatedTime,coalesce(CALLENDTIME,CALLSTARTTIME),      
 UIF.NT_USERNAME CreatedBy,'Apayaa' SourceAdded ,GETDATE()CreatedDate,      
 [SOURCE] Extension,A.PrimaryClientId,0,'USA',                    
    TALKTIMESECONDS Duration,DESTINATION as PhoneNumber,      
 CALLTYPE+'@@'+SYSTEMDISPOSITION as CallDisposition, UNIQUEID as  UniqueID                   
    FROM Callrecording_apayaa_importtable (nolock) CI                    
    inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.USERNAME=UIF.NT_USERNAME                  
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,dateAdd(d, -1, coalesce(CALLENDTIME,CALLSTARTTIME)))=D.Date                   
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance   A on UIF.USERID=A.UserId and D.DateKey=A.DateKey                  
    where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp  WHERE  temp.CreatedBy = CI.USERNAME and temp.UniqueID = cI.UNIQUEID)                     
               
 /*Pending Records*/                  
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,      
 SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,Location,      
 Duration,PhoneNumber,CallDisposition, UniqueID)                  
    select  CallInitiatedTime,CallEndTime,CI.CreatedBy,SourceAdded ,GETDATE(),Extension,UIF.CustomerID,UIF.SubProvisionId,'USA',                    
    Duration,PhoneNumber,CallDisposition, UniqueID                     
    FROM ARC_AR_CallrecodingpendingData (nolock) CI                    
    inner join #tempmaxusercustomer UIF on CI.CreatedBy=UIF.NT_USERNAME                  
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CI.CallEndTime)=D.Date                   
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance   A on UIF.USERID=A.UserId and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey                  
             
 /* Import the data which are not matching */        
    /*insert into ARC_AR_CallrecodingpendingData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,Extension,CustomerID,Location,Createddate,Duration,PhoneNumber,CallDisposition, UniqueId)                  
    select CALLSTARTTIME,CallEndTime,USERNAME CreatedBy, 'Apayaa' SourceAdded,[SOURCE] Extension,0 CustomerID,'USA',GETDATE() as Createddate,                   
 TALKTIMESECONDS DURATION,DESTINATION as PhoneNumber,CALLTYPE+'@@'+SYSTEMDISPOSITION as CallDisposition, UNIQUEID                    
    from Callrecording_apayaa_importtable  CI       
 where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp  WHERE  temp.CreatedBy = CI.USERNAME)*/        
       
 delete ARC_AR_CallrecodingpendingData  where  CreatedBy in                  
    (SELECT CreatedBy  FROM   #TempData temp WHERE  temp.CreatedBy = CreatedBy and SourceAdded='Apayaa') and SourceAdded='Apayaa'                  
                  
 /* declare @Pendingrecords int=0                  
  set @Pendingrecords =(select count('a') from ARC_AR_CallrecodingpendingData (nolock))                  
  if(@Pendingrecords>0)                  
  begin                  
   select @Exstions= '<table cellpading="0" cellspacing="0" border ="1" style="font-family: verdana; font-size: 12px"><tr align="left"                   
   valign="top" style="font-weight:bold;color:#fff;background:#267cc7;                  
   font-style:italic;border: solid 1px #000;"><td>Ntusername</td><td>Client</td></tr>'+CAST((select distinct CPd.CreatedBy as 'td' ,'',                  
   isnull(b.Client_name,'Name not matching') as 'td',''    from ARC_AR_CallrecodingpendingData (nolock) CPd                   
   Left Join ARC_REC.dbo.ARC_REC_User_info_vy (nolock) b on CPd.CreatedBy=b.nt_username                     
   and CONVERT(date, CPd.Createddate)=CONVERT(date,getdate())   where Cpd.SourceAdded='Apayaa' order by 1                     
   FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX));                  
   INSERT INTO ARC_REC_MAIL_TRAN(FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,ISHTML,CC)--ar_managers@accesshealthcare.co             
   select 'mail.support@accesshealthcare.co' FROM_MAILID,'aneesh.t@accesshealthcare.com;Voice@accesshealth.onmicrosoft.com;niranjan.m@accesshealthcare.com;kailashvasan.vk@accesshealthcare.com' RECIPIENTS,      
   'User names not found in arc  - Apayaa' ,                  
   '<HTML><HEAD></HEAD><BODY style="font-family: verdana; font-size: 12px"><div >Hi ,<br /><p>The below given users are                  
   not found in arc records. Kindly provide AHS ntusername as username in the vendor applications/provide the logic                   
   to fetch AHS ntusernames. </p>                  
   '+@Exstions+'</table>                    
   <br />Thanks,<br />Arc.flow team.<br /><img src="http://www.accesshealthcare.co/appimages/arc_support.png" alt="" width="250px" height="65px" /></p>** This is an auto-generated email.                   
   Please do not reply to this email.**<br />                  
   Legal Disclaimer: The information contained in this message (including all attachments) may be privileged and confidential. It is intended to be read only by the individual                   
   or entity to whom it is addressed or by their designee. If the reader of this message is not the intended recipient, please destroy this message immediately and also      
   please note that you are on notice that any distribution of this message, in any form, is strictly prohibited. If you have received this message in error,                   
   please immediately notify the sender and delete or destroy any copy of this message. </BODY></HTML>'as Body,                    
   'Y' ISHTML,'sakkaravarth.k@accesshealthcare.co;arunkumar.p@accesshealthcare.co;karthiknainar.c@accesshealthcare.co;barathi.a@accesshealthcare.co;ramesh.v2@accesshealthcare.co' as CC;                  
   end   */               
                  
 end  /*Insert Callrecording matched Data*/                   
  INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,      
  CreatedBy,SourceAdded,Customername,Extension,CustomerID,Location,      
  Duration,Createddate,PhoneNumber,CallDisposition,Uniqueid,      
  RecordingURL, SubProvisionId,CallDate)                    
  SELECT A.CallInitiatedTime,A.CallEndTime,A.CreatedBy,A.SourceAdded,      
  A.Customername,A.Extension,A.CustomerID,A.Location,A.Duration,      
  A.CreatedDate,A.PhoneNumber,A.CallDisposition,a.UniqueID,      
  replace(convert(varchar(50),CONVERT(DATE,CallInitiatedTime), 101), '/', '') +'\'+a.UniqueID+'.wav' as RecordingURL, A.SubProvisionId ,convert(date,DATEADD(n,-630, A.CallInitiatedTime))                     
  FROM #TempData A WHERE                     
  NOT EXISTS (                    
  SELECT 'A' FROM ARC_AR_Callrecoding (nolock)B       
  WHERE A.CallInitiatedTime=B.CallInitiatedTime AND                     
  A.CallEndTime=B.CallEndTime       
  AND A.SourceAdded= B.SourceAdded       
  AND A.UniqueID=B.Uniqueid)                    
       
 /*Insert Callrecoding unmatched data*/      
  INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,      
  CreatedBy,SourceAdded,Extension,CustomerID,Location,Createddate,      
  Duration,PhoneNumber,CallDisposition,Uniqueid,      
  RecordingURL, SubProvisionId,CallDate)      
  select CALLSTARTTIME,coalesce(CALLENDTIME,CALLSTARTTIME),USERNAME CreatedBy,      
  'Apayaa' SourceAdded,[SOURCE] Extension,0 CustomerID,'USA',GETDATE() as Createddate,                   
  TALKTIMESECONDS DURATION,DESTINATION as PhoneNumber,      
  CALLTYPE+'@@'+SYSTEMDISPOSITION as CallDisposition, UNIQUEID,      
  replace(convert(varchar(50),CONVERT(DATE,CALLSTARTTIME), 101), '/', '') +'\'+UNIQUEID+'.wav' as RecordingURL,      
  0 as SubProvisionId,convert(date,DATEADD(n,-630, CALLSTARTTIME))                                   
     from Callrecording_apayaa_importtable  CI       
  where   NOT EXISTS (SELECT UniqueID  FROM   #TempData temp        
  WHERE  temp.UniqueID = CI.UNIQUEID)      
  and UNIQUEID not IN(select uniqueid from  ARC_AR_Callrecoding)      
      
 UPDATE CD set cd.CustomerID=td.CustomerID,      
 cd.SubProvisionId=td.SubProvisionId          
 from #TempData td       
 inner join ARC_AR_Callrecoding cd on cd.CreatedBy=td.CreatedBy          
    where cd.CustomerID=0   and cd.SourceAdded='Apayaa'            
       
  update cd set cd.active=0      
  from #TempData td       
 inner join ARC_AR_Callrecoding cd on cd.CreatedBy=td.CreatedBy and td.uniqueid=cd.uniqueid      
 where    td.CallDisposition in('EXTENSION-DOWN-DIAL-FAILED','Failed')      
  and cd.sourceadded='Apayaa'      
      
    update cd set cd.active=0      
  from #TempData td       
 inner join ARC_AR_Callrecoding cd on cd.CreatedBy=td.CreatedBy and td.uniqueid=cd.uniqueid      
 where    cd.sourceadded='Apayaa'      
  and  ((cd.PhoneNumber is null) or  (cd.PhoneNumber=''))      
      
      
 insert into ARC_AR_FloorProductionCalldata(Ntusername,Customerid,SubProvisionId,CallintialtedDate,Vendor,Createddate,CallDuration)                    
 SELECT A.CreatedBy,A.CustomerId,A.SubProvisionId,A.CallInitiatedTime,A.SourceAdded,A.CreatedDate,A.Duration FROM #TempData A WHERE NOT EXISTS (                    
 SELECT 'A' FROM ARC_AR_FloorProductionCalldata (nolock) B                     
 WHERE  A.CreatedBy=B.Ntusername AND A.Customerid=B.Customerid  AND A.SubProvisionId=B.SubProvisionId AND A.CallInitiatedTime=B.CallintialtedDate AND A.SourceAdded =B.Vendor )                    
            
 --COMMIT TRANSACTION                  
--END TRY                  
--BEGIN CATCH        
--IF(@@TRANCOUNT > 0)                
 --ROLLBACK TRANSACTION                  
--END CATCH                  
                                
 UPDATE ARC_Ar_fileimportstatus set importstatus = 3,ErrorDescription='imported'      
  Where customerid = @CustomerId and Identityno = @sessionid                    
                                     
   TRUNCATE TABLE Callrecording_apayaa_importtable;                  
  set @NoramlImportCount=(select COUNT ('a') from #TempData)                  
  If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData                       
                     
  select @importstatus=CONVERT(varchar(10), isnull(@Totalflatfilerows,0))+','+CONVERT(varchar(10),isnull(@NoramlImportCount,0))+                     
  ','+CONVERT(varchar(10),isnull(@MultiTouchImportCount,0))+','+CONVERT(varchar(10),isnull(@Duplicate,0))                     
  +','+CONVERT(varchar(10),isnull(@MultiDuplicate,0))+','+CONVERT(varchar(10),isnull(@PurgeCount,0))+                     
  +','+CONVERT(varchar(10),isnull(@MultiPurgeCount,0))                     
                      
END      
      
GO
/****** Object:  StoredProcedure [dbo].[Callrecording_autoimport]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Callrecording_autoimport](
@filepath varchar(1000)=null,
@Customerid int=0,
@Customername varchar(250)=null,
@Format varchar(20)=null,
@Table varchar(300)=null,
@result varchar(750)=null OUTPUT)
as
begin


if not exists(select FI.FilePath from ARC_AR_Fileformat FF left join ARC_Ar_fileimportstatus FI on FI.Customerid=FF.CustomerId
	where FI.importstatus=3 and FF.Status=1 and  FF.CustomerId=@Customerid 	and FI.FilePath=@filepath)
begin
		truncate table Callrecording_importtable 
		select @result='File imported sucessfuly'
end
 else
begin
		truncate table Callrecording_importtable
		select @result='File name already exist.if you want import same file please change file name from folder'
end
end




GO
/****** Object:  StoredProcedure [dbo].[Callrecording_FIVE9_autoimport]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Callrecording_FIVE9_autoimport](
@filepath varchar(1000)=null,
@Customerid int=0,
@Customername varchar(250)=null,
@Format varchar(20)=null,
@Table varchar(300)=null,
@result varchar(750)=null OUTPUT)
as
begin


if not exists(select FI.FilePath from ARC_AR_Fileformat FF left join ARC_Ar_fileimportstatus FI on FI.Customerid=FF.CustomerId
	where FI.importstatus=3 and FF.Status=1 and  FF.CustomerId=@Customerid 	and FI.FilePath=@filepath)
begin
		truncate table Callrecording_FIVE9_importtable 
		select @result='File imported sucessfuly'
end
 else
begin
		truncate table Callrecording_FIVE9_importtable
		select @result='File name already exist.if you want import same file please change file name from folder'
end
end

GO
/****** Object:  StoredProcedure [dbo].[Callrecording_FIVE9_import]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Callrecording_FIVE9_import]            
(             
 @Format varchar(5000)=null,              
 @locationid int =1 ,               
 @CustomerId  int=0,               
 @sessionid VARCHAR(50)=null,              
 @USERID INT=1,              
 @importstatus varchar(max)=null OUTPUT             
 )            
AS              
              
BEGIN              
 declare @PurgeCount int=0,@Duplicate int = 0,@FileType int = 1,            
 @MultiPurgeCount int=0,@MultiDuplicate int = 0 ,               
 @NoramlImportCount int=0,@MultiTouchImportCount int=0,            
 @Totalflatfilerows int=0,@Exstions varchar(max)=null,@Minutes int=0,            
 @FiveTime varchar(100)='';               
             
   update Callrecording_FIVE9_importtable set TIMESTAMP=reverse(substring(reverse(TIMESTAMP),0,CHARINDEX(',',reverse(TIMESTAMP))))            
   update Callrecording_FIVE9_importtable set AGENT =LEFT(AGENT, CHARINDEX('@',AGENT )-1) where AGENT like '%@%'            
   update Callrecording_FIVE9_importtable set AGENT=trim(AGENT)            
   update Callrecording_FIVE9_importtable set CLAIMID=isnull(CLAIMID,'')+','+isnull(CUSTOMACCOUNTNUMBER,'')+','+isnull(ADDITIONALCLAIMID,'')            
   update Callrecording_FIVE9_importtable set CLAIMID=dbo.Removeduplicatesfromstring(CLAIMID,',')            
   update Callrecording_FIVE9_importtable set CallEndTime=CAST([TIMESTAMP] AS datetime) + CAST(CONVERT(time,CALLTIME) AS datetime)            
         
    UPDATE CR set cr.TIMESTAMP=dateadd (minute,  TZ.IST_Minutes ,  CR.TIMESTAMP),cr.CALLENDTIME=dateadd (minute,  TZ.IST_Minutes ,  CR.CALLENDTIME)       
  FROM Callrecording_FIVE9_importtable CR      
  inner join EXTR_ARC_AR_V1.dbo.ARC_AR_TimeZoneConverter TZ on CR.TIMESTAMP between TZ.StartDate and TZ.EndDate       
         
               
--BEGIN TRY                        
 --BEGIN TRANSACTION            
   set @Totalflatfilerows=(select COUNT ('a') from  Callrecording_FIVE9_importtable)            
   delete Callrecording_FIVE9_importtable where isnull(AGENT,'')=''            
            
   if exists (select top 1 * from Callrecording_FIVE9_importtable)             
   begin            
     set @FiveTime=(select top 1 TIMESTAMP  from Callrecording_FIVE9_importtable)            
  set @Minutes=(select IST_Minutes from EXTR_ARC_AR_V1.dbo.ARC_AR_TimeZoneConverter where TimeZone='EST' and Status=1 and convert(datetime, @FiveTime) between StartDate and Enddate)            
             
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData               
 create table #TempData(CallInitiatedTime datetime,CallEndTime datetime,            
 CreatedBy varchar(2500),SourceAdded varchar(2500),CustomerName varchar(2500),            
 CreatedDate datetime,Extension varchar(2000),CustomerID int,            
 SubProvisionId int,Location varchar(250),Duration int,            
 PhoneNumber varchar(200),CallDisposition varchar(max),            
 CLAIMID varchar(500),UniqueID varchar(500),CallDirections varchar(500) )            
              
  insert into Callrecording_FIVE9_ImportData(CALLID,TIMESTAMP,CAMPAIGN,            
  CALLTYPE,AGENT,AGENTNAME,DISPOSITION,ANI,CUSTOMERNAME,DNIS,CALLTIME,            
  IVRTIME,QUEUEWAITTIME,RINGTIME,TALKTIME,PARKTIME,AFTERCALLWORKTIME,            
  TRANSFERS,ABANDONED,RECORDINGS,BILLINGADDDIGIT,BILLINGCLAIMID,            
  CUSTOMACCOUNTNUMBER,CLAIMID,ADDITIONALCLAIMID,CALLENDTIME,CreatedDate)            
            
 select CALLID,TIMESTAMP,CAMPAIGN,CALLTYPE,AGENT,AGENTNAME,DISPOSITION,            
 ANI,CUSTOMERNAME,DNIS,CALLTIME,IVRTIME,QUEUEWAITTIME,RINGTIME,TALKTIME,            
 PARKTIME,AFTERCALLWORKTIME,TRANSFERS,ABANDONED,RECORDINGS,BILLINGADDDIGIT,            
 BILLINGCLAIMID, CUSTOMACCOUNTNUMBER,CLAIMID,ADDITIONALCLAIMID,            
 CALLENDTIME,getdate()             
 from Callrecording_FIVE9_importtable            
                
 If OBJECT_ID('tempdb..#ExtensionmappedtData') is not null DROP TABLE #ExtensionmappedtData              
 create table #ExtensionmappedtData(Extension varchar(200))            
 If OBJECT_ID('tempdb..#tempmaxusercustomer') is not null DROP TABLE #tempmaxusercustomer                           
    create table #tempmaxusercustomer(nt_username varchar(100), Userid int, CustomerId int, SubprovisionId int)                        
               
 insert into #tempmaxusercustomer                
    select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                         
    FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                         
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_UserProfileMapping (nolock) UPM on UPM.UserID=UIF.USERID and UPM.Status=1                        
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ProfileMaster (nolock) PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                        
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ClientMaster_InternalExternal_View (nolock) CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                          
    inner join ARC_REC..ARC_REC_usercustomer (nolock) UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                        
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID             
            
 insert into #tempmaxusercustomer                        
    select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                         
    FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                         
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_UserProfileMapping  UPM on UPM.UserID=UIF.USERID and UPM.Status=1                        
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                        
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ClientMaster_View  CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                          
    inner join ARC_REC..ARC_REC_usercustomer  UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                        
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID                         
                        
            
 insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,            
 Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition,UniqueID,CLAIMID,CallDirections)                        
    select distinct CI.[TIMESTAMP] CallInitiatedTime,CallEndTime            
 ,UIF.NT_USERNAME CreatedBy,                        
    'FIVE9' SourceAdded ,GETDATE(),CI.AGENT Extension,UIF.CustomerID,UIF.SubProvisionId,'USA',                          
    datediff(second,0,(CONVERT(time,CI.CALLTIME))) Duration,DNIS as PhoneNumber,            
 DISPOSITION as CallDisposition, CALLID as  UniqueID,CLAIMID ,CALLTYPE                        
    FROM Callrecording_FIVE9_importtable (nolock) CI                          
    inner join #tempmaxusercustomer UIF on CI.AGENT=UIF.NT_USERNAME                        
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CallEndTime)=D.Date                         
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance  A on UIF.USERID=A.UserId and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey                        
                  
  /*Missing users mapping with Rec db*/                        
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition,UniqueID,ClaimID,CallDirections)                        
    select CI.[TIMESTAMP] CallInitiatedTime,CallEndTime,UIF.NT_USERNAME CreatedBy,                        
    'FIVE9' SourceAdded ,GETDATE()CreatedDate,AGENT Extension,A.PrimaryClientId,0,'USA',                          
    datediff(second,0,(CONVERT(time,CI.CALLTIME))) Duration,DNIS as PhoneNumber,            
 DISPOSITION as CallDisposition, CALLID as  UniqueID ,CLAIMID,CallType                 
    FROM Callrecording_FIVE9_importtable (nolock) CI                          
    inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.AGENT=UIF.NT_USERNAME                        
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on Convert(date,CallEndTime)=D.Date                         
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance   A on UIF.USERID=A.UserId and D.DateKey=A.DateKey                        
    where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp  WHERE  temp.CreatedBy = CI.AGENT and temp.UniqueID = cI.CALLID)            
             
 /*Missing users mapping with Rec db*/                     
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition,UniqueID,CLAIMID,CallDirections)                        
    select CI.[TIMESTAMP] CallInitiatedTime,            
 CallEndTime ,UIF.NT_USERNAME CreatedBy,                        
    'FIVE9' SourceAdded ,GETDATE()CreatedDate,AGENT Extension,A.PrimaryClientId,0,'USA',                          
    datediff(second,0,(CONVERT(time,CI.CALLTIME))) Duration,DNIS as PhoneNumber,            
 DISPOSITION as CallDisposition, CALLID as  UniqueID ,CLAIMID ,CALLTYPE                                
    FROM Callrecording_FIVE9_importtable (nolock) CI                          
    inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.AGENT=UIF.NT_USERNAME                        
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,dateAdd(d, -1, CallEndTime))=D.Date                         
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance   A on UIF.USERID=A.UserId and D.DateKey=A.DateKey                        
    where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp              
 WHERE  temp.CreatedBy = CI.AGENT and temp.UniqueID = cI.CALLID)                           
                
 /*Pending Records*/                        
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,Extension,            
 CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition, UniqueID)                        
    select  CallInitiatedTime,CallEndTime,CI.CreatedBy,SourceAdded ,GETDATE(),Extension,UIF.CustomerID,UIF.SubProvisionId,'USA',                          
    Duration,PhoneNumber,CallDisposition, UniqueID                  
    FROM ARC_AR_CallrecodingpendingData (nolock) CI                          
    inner join #tempmaxusercustomer UIF on CI.CreatedBy=UIF.NT_USERNAME                        
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CallEndTime)=D.Date                         
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance  A on UIF.USERID=A.UserId and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey                        
                  
 /* Import the data which are not matching */                        
   /* insert into ARC_AR_CallrecodingpendingData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,            
 Extension,CustomerID,Location,Createddate,Duration,PhoneNumber,CallDisposition, UniqueId)                        
    select CI.[TIMESTAMP] CallInitiatedTime,CallEndTime,            
 AGENT CreatedBy, 'FIVE9' SourceAdded,            
 AGENT ,0 CustomerID,'USA',GETDATE() as Createddate,                         
 datediff(second,0,(CONVERT(time,CI.CALLTIME))) Duration,ANI as PhoneNumber,            
 DISPOSITION as CallDisposition, CALLID as  UniqueID                          
    from Callrecording_FIVE9_importtable  CI             
 where   NOT EXISTS (SELECT CreatedBy  FROM               
 #TempData temp  WHERE  temp.CreatedBy = CI.AGENT) */            
             
 delete ARC_AR_CallrecodingpendingData  where  CreatedBy in                        
    (SELECT CreatedBy  FROM   #TempData temp WHERE  temp.CreatedBy = CreatedBy and SourceAdded='FIVE9') and SourceAdded='FIVE9'                        
       /*declare @Pendingrecords int=0                        
         set @Pendingrecords =(select count('a') from ARC_AR_CallrecodingpendingData (nolock))                        
     if(@Pendingrecords>0)                        
           begin                        
   select @Exstions= '<table cellpading="0" cellspacing="0" border ="1" style="font-family: verdana; font-size: 12px"><tr align="left"                         
   valign="top" style="font-weight:bold;color:#fff;background:#267cc7;                        
   font-style:italic;border: solidg 1px #000;"><td>Ntusername</td><td>Client</td></tr>'+CAST((select distinct CPd.CreatedBy as 'td' ,'',                        
   isnull(b.Client_name,'Name not matching') as 'td',''    from ARC_AR_CallrecodingpendingData (nolock) CPd                         
   Left Join ARC_REC.dbo.ARC_REC_User_info_vy (nolock) b on CPd.CreatedBy=b.nt_username                           
   and CONVERT(date, CPd.Createddate)=CONVERT(date,getdate())   where Cpd.SourceAdded='FIVE9' order by 1                           
   FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX));                        
   INSERT INTO ARC_REC_MAIL_TRAN(FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,ISHTML,CC)--ar_managers@accesshealthcare.co                   
   select 'mail.support@accesshealthcare.co' FROM_MAILID,'aneesh.t@accesshealthcare.com;Voice@accesshealth.onmicrosoft.com;niranjan.m@accesshealthcare.com;kailashvasan.vk@accesshealthcare.com' RECIPIENTS,            
   'User names not found in arc  - Five9' ,                        
   '<HTML><HEAD></HEAD><BODY style="font-family: verdana; font-size: 12px"><div >Hi ,<br /><p>The below given users are                        
   not found in arc records. Kindly provide AHS ntusername as username in the vendor applications/provide the logic                         
   to fetch AHS ntusernames. </p>                        
   '+@Exstions+'</table>                          
   <br />Thanks,<br />Arc.flow team.<br /><img src="http://www.accesshealthcare.co/appimages/arc_support.png" alt="" width="250px" height="65px" /></p>** This is an auto-generated email.                        
   Please do not reply to this email.**<br />             
   Legal Disclaimer: The information contained in this message (including all attachments) may be privileged and confidential. It is intended to be read only by the individual                         
   or entity to whom it is addressed or by their designee. If the reader of this message is not the intended recipient, please destroy this message immediately and also                         
   please note that you are on notice that any distribution of this message, in any form, is strictly prohibited. If you have received this message in error,                         
   please immediately notify the sender and delete or destroy any copy of this message. </BODY></HTML>'as Body,                          
   'Y' ISHTML,'sakkaravarth.k@accesshealthcare.co;arunkumar.p@accesshealthcare.co;karthiknainar.c@accesshealthcare.co;barathi.a@accesshealthcare.co;ramesh.v2@accesshealthcare.co' as CC;                        
  end  */                     
                        
 end                                    
        INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,            
  CreatedBy,SourceAdded,Customername,Extension,CustomerID,Location,            
  Duration,Createddate,PhoneNumber,CallDisposition,Uniqueid,CLAIMNO,RecordingURL,            
  SubProvisionId,CallDirections,CallDate)                          
        SELECT A.CallInitiatedTime,A.CallEndTime,A.CreatedBy,A.SourceAdded,            
  A.Customername,A.Extension,A.CustomerID,A.Location,A.Duration,            
  A.CreatedDate,A.PhoneNumber,A.CallDisposition,a.UniqueID,a.CLAIMID,            
  replace(convert(varchar(50),CONVERT(DATE,CallInitiatedTime), 101), '/', '') +'\'+a.UniqueID+'.wav' as RecordingURL,            
   A.SubProvisionId,CallDirections, Convert(date,DATEADD(n,-630,A.CallInitiatedTime))                               
  FROM #TempData A WHERE                           
  NOT EXISTS (                          
  SELECT 'A' FROM ARC_AR_Callrecoding (nolock)B             
  WHERE A.CallInitiatedTime=B.CallInitiatedTime AND                           
  A.CallEndTime=B.CallEndTime AND A.CreatedBy=B.CreatedBy            
  and A.SourceAdded=b.SourceAdded            
  And A.UniqueID=B.Uniqueid )             
              
            
  /*Callrecoding unmatched records*/            
  INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,            
  CreatedBy,SourceAdded,Extension,CustomerID,Location,Createddate,            
  Duration,PhoneNumber,CallDisposition,            
  Uniqueid,RecordingURL,SubProvisionId,CLAIMNO,CallDirections ,CallDate)            
              
 select CI.[TIMESTAMP] CallInitiatedTime,CallEndTime,            
 AGENT CreatedBy, 'FIVE9' SourceAdded,            
 AGENT ,0 CustomerID,'USA',GETDATE() as Createddate,                         
 datediff(second,0,(CONVERT(time,CI.CALLTIME))) Duration,            
 DNIS as PhoneNumber,DISPOSITION as CallDisposition,             
 CALLID as  UniqueID,             
 replace(convert(varchar(50),CONVERT(DATE,CI.[TIMESTAMP]), 101), '/', '') +'\'+CALLID+'.wav' as RecordingURL,                         
 0 as SubProvisionId,CI.CLAIMID ,CI.Calltype, Convert(date,DATEADD(n,-630, CI.[TIMESTAMP]))           
 from Callrecording_FIVE9_importtable  CI             
 where   NOT EXISTS (SELECT UniqueID  FROM               
 #TempData temp  WHERE  temp.UniqueID = CI.CALLID)            
 and CALLID not IN(select uniqueid from  ARC_AR_Callrecoding)                
            
 UPDATE CD set cd.CustomerID=td.CustomerID,            
 cd.SubProvisionId=td.SubProvisionId                
 from #TempData td             
 inner join ARC_AR_Callrecoding cd on cd.CreatedBy=td.CreatedBy                
 where cd.CustomerID=0   and cd.SourceAdded='FIVE9'                           
              
  update cd set cd.active=0            
  from #TempData td             
 inner join ARC_AR_Callrecoding cd on cd.CreatedBy=td.CreatedBy and td.uniqueid=cd.uniqueid            
 where    td.CallDisposition in('3rd party conference','3rd party conference','3rd party transfer','Internal','Test manual')            
  and cd.sourceadded='FIVE9'            
            
  set @NoramlImportCount=(select COUNT ('a') from #TempData)            
          
 insert into ARC_AR_FloorProductionCalldata(Ntusername,Customerid,SubProvisionId,CallintialtedDate,Vendor,Createddate,CallDuration)            
 SELECT A.CreatedBy,A.CustomerId,A.SubProvisionId,A.CallInitiatedTime,A.SourceAdded,A.CreatedDate,A.Duration FROM #TempData A WHERE NOT EXISTS (                          
 SELECT 'A' FROM ARC_AR_FloorProductionCalldata (nolock) B                           
 WHERE  A.CreatedBy=B.Ntusername AND A.Customerid=B.Customerid  AND A.SubProvisionId=B.SubProvisionId AND A.CallInitiatedTime=B.CallintialtedDate AND A.SourceAdded =B.Vendor )             
                         
--COMMIT TRANSACTION                        
--END TRY                        
-- BEGIN CATCH                       
-- IF(@@TRANCOUNT > 0)                      
--  ROLLBACK TRANSACTION                        
-- END CATCH               
             
                                       
 UPDATE ARC_Ar_fileimportstatus set importstatus = 3,ErrorDescription='imported' Where customerid = @CustomerId and Identityno = @sessionid                          
                                          
 TRUNCATE TABLE Callrecording_FIVE9_importtable;                        
                       
     update [LNKTPARFLOW].[ARC_FLOW].[dbo].ADM_MailDownload set Status=1 where '\\fs3\ARC_FLOW\New_Batches\WaterTown\ArcDumpAttachments\'+FolderPath+'\'+FileName=@Format              
  select @importstatus=CONVERT(varchar(10), isnull(@Totalflatfilerows,0))+','+CONVERT(varchar(10),isnull(@NoramlImportCount,0))+                           
  ','+CONVERT(varchar(10),isnull(@MultiTouchImportCount,0))+','+CONVERT(varchar(10),isnull(@Duplicate,0))                           
  +','+CONVERT(varchar(10),isnull(@MultiDuplicate,0))+','+CONVERT(varchar(10),isnull(@PurgeCount,0))+                           
  +','+CONVERT(varchar(10),isnull(@MultiPurgeCount,0))                           
                            
END                           
GO
/****** Object:  StoredProcedure [dbo].[Callrecording_import]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Callrecording_import]      
(        
 @Format varchar(5000)=null,        
 @locationid int =1 ,         
 @CustomerId  int=0,         
 @sessionid VARCHAR(50)=null,        
 @USERID INT=1777,        
 @importstatus varchar(max)=null OUTPUT )        
AS        
        
BEGIN        
       
    
 declare @PurgeCount int=0,@Duplicate int = 0,@FileType int = 1,         
 @MultiPurgeCount int=0,@MultiDuplicate int = 0 ,         
 @NoramlImportCount int=0,@MultiTouchImportCount int=0,@Totalflatfilerows int=0,@Exstions varchar(max)=null;         
        
   UPDATE Callrecording_importtable SET [DESCRIPTION]=REPLACE([DESCRIPTION],'"','')        
   UPDATE Callrecording_importtable SET [DATETIME]=REPLACE(isnull([DATETIME],''),'"','')        
                      
      
  UPDATE CR set cr.[DATETIME]=dateadd (minute,  TZ.IST_Minutes ,  CR.[DATETIME])      
  FROM Callrecording_importtable CR      
  inner join  EXTR_ARC_AR_V1.dbo.ARC_AR_TimeZoneConverter TZ on CR.[DATETIME] between TZ.StartDate and TZ.EndDate       
         
      
 set @Totalflatfilerows=(select COUNT ('a') from  Callrecording_importtable)      
      
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData                       
   create table #TempData(CallInitiatedTime datetime,CallEndTime datetime,CreatedBy varchar(2500),SourceAdded varchar(2500),CustomerName varchar(2500),      
   CreatedDate datetime,Extension varchar(2000),CustomerID int,SubProvisionId int,Location varchar(250),Duration int,PhoneNumber varchar(200),      
   CallDisposition varchar(max),CLAIMID varchar(500),UniqueID varchar(500),Result varchar(max),CALLDIRECTION varchar(max))         
 If OBJECT_ID('tempdb..#ExtensionmappedtData') is not null DROP TABLE #ExtensionmappedtData                      
 create table #ExtensionmappedtData(Extension varchar(200))                    
 If OBJECT_ID('tempdb..#tempmaxusercustomer') is not null DROP TABLE #tempmaxusercustomer                                   
    create table #tempmaxusercustomer(nt_username varchar(100), Userid int, CustomerId int, SubprovisionId int)       
          
--BEGIN TRY                                
-- BEGIN TRANSACTION        
      
 if  (@Totalflatfilerows>0)      
 begin      
  insert into #tempmaxusercustomer                        
  select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                                 
  FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                                 
  inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_UserProfileMapping (nolock) UPM on UPM.UserID=UIF.USERID and UPM.Status=1                                
  inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_ProfileMaster (nolock) PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                                
  inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_ClientMaster_InternalExternal_View (nolock) CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                  
  inner join ARC_REC..ARC_REC_usercustomer (nolock) UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                                
  group by  UIF.nt_username,UIF.UserId,CV.CustomerID                     
        
  insert into #tempmaxusercustomer                                
  select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                                 
  FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                                 
  inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_UserProfileMapping  UPM on UPM.UserID=UIF.USERID and UPM.Status=1                                
  inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                                
  inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ClientMaster_View  CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                  
  inner join ARC_REC..ARC_REC_usercustomer  UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                                
  group by  UIF.nt_username,UIF.UserId,CV.CustomerID       
      
      
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CustomerName,CreatedDate,      
   Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition)      
      
   select CONVERT(datetime, CI.[DATETIME]) CallInitiatedTime,CAST(CI.[DATETIME] AS datetime) + CAST(CONVERT(time,CI.CHARGEDTIMEHOURMINSEC) AS datetime)CallEndTime,UI.NT_USERNAME CreatedBy,      
   'Siplink' SourceAdded ,CV.CustomerName,GETDATE()CreatedDate,ACCOUNT as Extension,CV.CustomerID,CV.SubProvisionId,CI.[COUNTRY] Location,        
   DATEDIFF(SECOND, convert(datetime,CI.[DATETIME]), CAST(CI.[DATETIME] AS datetime) + CAST(CONVERT(time,CI.CHARGEDTIMEHOURMINSEC) AS datetime)) as Duration,      
   [TO] as PhoneNumber,[Description]as CallDisposition        
   FROM Callrecording_importtable  CI        
   inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_UserProfileMapping UPM on CI.ACCOUNT=UPM.VoiceMailId and UPM.Status=1        
   inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1      
   inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_ClientMaster_View CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId        
   inner join ARC_REC..ARC_REC_USER_INFO UI on UPM.UserID=UI.USERID        
   inner join ARC_REC..ARC_REC_usercustomer UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId      
        
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CustomerName,CreatedDate,      
   Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition)      
      
   select CONVERT(datetime, CI.[DATETIME]) CallInitiatedTime,CAST(CI.[DATETIME] AS datetime) + CAST(CONVERT(time,CI.CHARGEDTIMEHOURMINSEC) AS datetime)CallEndTime,UI.NT_USERNAME CreatedBy,      
   'Siplink' SourceAdded ,CV.CustomerName,GETDATE()CreatedDate,ACCOUNT as Extension,CV.CustomerID,CV.SubProvisionId,CI.[COUNTRY] Location,        
   DATEDIFF(SECOND, convert(datetime,CI.[DATETIME]), CAST(CI.[DATETIME] AS datetime) + CAST(CONVERT(time,CI.CHARGEDTIMEHOURMINSEC) AS datetime)) as Duration,      
   [TO] as PhoneNumber,[Description]as CallDisposition        
   FROM Callrecording_importtable  CI        
   inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_UserProfileMapping UPM on CI.ACCOUNT=UPM.VoiceMailId and UPM.Status=1        
   inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1      
   inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ClientMaster_View CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId        
   inner join ARC_REC..ARC_REC_USER_INFO UI on UPM.UserID=UI.USERID        
   inner join ARC_REC..ARC_REC_usercustomer UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId      
        
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,                  
  Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition)                                
  select CONVERT(datetime, CI.[DATETIME]) CallInitiatedTime, CAST(CI.[DATETIME] AS datetime) + CAST(CONVERT(time,CI.CHARGEDTIMEHOURMINSEC) AS datetime)CallEndTime      
  ,UIF.NT_USERNAME CreatedBy,'Siplink' SourceAdded ,GETDATE()CreatedDate,ACCOUNT as Extension,AE.CustomerId,AE.SubprovisionId,'USA',                                  
   DATEDIFF(SECOND, convert(datetime,CI.[DATETIME]), CAST(CI.[DATETIME] AS datetime) + CAST(CONVERT(time,CHARGEDTIMEHOURMINSEC) AS datetime)) as Duration,      
   [TO] as PhoneNumber,[Description]as CallDisposition                                           
   FROM Callrecording_importtable (nolock) CI             
   inner join EXTR_ARC_AR_V1.dbo.ARC_AR_AssociateExtnDetails  AE on AE.ExtNo=CI.ACCOUNT  and convert(date,CI.[DATETIME])=CONVERT(date,AE.CreatedDate)                         
   inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on AE.UserId=UIF.USERID                                
   where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp                      
   WHERE  temp.CreatedBy = UIF.NT_USERNAME)       
           
  insert into Callrecording_importdata(ACCOUNT,[FROM],[TO],COUNTRY,[DESCRIPTION],      
  [DATETIME],CHARGEDTIME)      
  SELECT ACCOUNT,[FROM],[TO],COUNTRY,[DESCRIPTION],[DATETIME],CHARGEDTIMEHOURMINSEC      
  FROM Callrecording_importtable A where not exists(SELECT 'A' FROM #TempData B WHERE A.ACCOUNT=B.Extension)      
        
  UPDATE CD set cd.CallInitiatedTime=td.CallInitiatedTime, cd.CallEndTime=TD.CallEndTime,      
   CD.Duration=TD.Duration ,cd.SubProvisionId=td.SubProvisionId                        
   from #TempData td                     
   inner join ARC_AR_Callrecoding cd on cd.CreatedBy=td.CreatedBy                        
   where   cd.SourceAdded='Splink'        
        
  INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,Customername,Extension,      
  CustomerID,Location,Duration,Createddate,PhoneNumber,CallDisposition,CallDate)        
        
   SELECT A.CallInitiatedTime,A.CallEndTime,A.CreatedBy,A.SourceAdded,A.Customername,A.Extension,      
   A.CustomerID,A.Location,A.Duration,A.CreatedDate,A.PhoneNumber,A.CallDisposition, Convert(date,DATEADD(n,-630,A.CallInitiatedTime))        
   FROM #TempData A WHERE NOT EXISTS (        
   SELECT 'A' FROM ARC_AR_Callrecoding B WHERE A.CallInitiatedTime=B.CallInitiatedTime AND         
   A.CallEndTime=B.CallEndTime AND A.CreatedBy=B.CreatedBy AND A.SourceAdded= B.SourceAdded       
   AND A.Customername= B.Customername AND A.Extension=B.Extension AND A.CustomerID=B.CustomerID       
   AND A.Location = B.Location AND A.Duration=B.Duration )        
        
  UPDATE ARC_Ar_fileimportstatus set importstatus = 3,ErrorDescription='imported' Where customerid = @CustomerId and Identityno = @sessionid        
        
  set @NoramlImportCount=(select COUNT ('a') from #TempData)      
        
         
        
  insert into ARC_AR_FloorProductionCalldata(Ntusername,Customerid,SubProvisionId,CallintialtedDate,Vendor,Createddate,CallDuration)                    
 SELECT A.CreatedBy,A.CustomerId,A.SubProvisionId,A.CallInitiatedTime,A.SourceAdded,A.CreatedDate,A.Duration FROM #TempData A WHERE NOT EXISTS (                                  
 SELECT 'A' FROM ARC_AR_FloorProductionCalldata (nolock) B                                   
 WHERE  A.CreatedBy=B.Ntusername AND A.Customerid=B.Customerid  AND A.SubProvisionId=B.SubProvisionId AND A.CallInitiatedTime=B.CallintialtedDate AND A.SourceAdded =B.Vendor )                     
     
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData     
 end                     
--COMMIT TRANSACTION                                
--END TRY                    
-- BEGIN CATCH                               
-- IF(@@TRANCOUNT > 0)                              
--  ROLLBACK TRANSACTION                                
-- END CATCH           
  -- TRUNCATE TABLE Callrecording_importtable;        
  select @importstatus=CONVERT(varchar(10), isnull(@Totalflatfilerows,0))+','+CONVERT(varchar(10),isnull(@NoramlImportCount,0))+       
  ','+CONVERT(varchar(10),isnull(@MultiTouchImportCount,0))+','+CONVERT(varchar(10),isnull(@Duplicate,0))         
  +','+CONVERT(varchar(10),isnull(@MultiDuplicate,0))+','+CONVERT(varchar(10),isnull(@PurgeCount,0))+         
  +','+CONVERT(varchar(10),isnull(@MultiPurgeCount,0))         
          
END       
      
    
  
GO
/****** Object:  StoredProcedure [dbo].[Callrecording_Kruptoconnect_autoimport]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Callrecording_Kruptoconnect_autoimport](
@filepath varchar(1000)=null,
@Customerid int=0,
@Customername varchar(250)=null,
@Format varchar(20)=null,
@Table varchar(300)=null,
@result varchar(750)=null OUTPUT)
as
begin


if not exists(select FI.FilePath from ARC_AR_Fileformat FF left join ARC_Ar_fileimportstatus FI on FI.Customerid=FF.CustomerId
	where FI.importstatus=3 and FF.Status=1 and  FF.CustomerId=@Customerid 	and FI.FilePath=@filepath)
begin
		truncate table Callrecording_Kruptoconnect_importtable 
		select @result='File imported sucessfuly'
end
 else
begin
		truncate table Callrecording_Kruptoconnect_importtable
		select @result='File name already exist.if you want import same file please change file name from folder'
end
end
GO
/****** Object:  StoredProcedure [dbo].[Callrecording_Kruptoconnect_import]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Callrecording_Kruptoconnect_import]            
(             
 @Format varchar(5000)=null,              
 @locationid int =1 ,               
 @CustomerId  int=0,               
 @sessionid VARCHAR(50)=null,              
 @USERID INT=1,              
 @importstatus varchar(max)=null OUTPUT             
 )            
AS            
            
            
            
BEGIN              
  declare @PurgeCount int=0,@Duplicate int = 0,@FileType int = 1,            
  @MultiPurgeCount int=0,@MultiDuplicate int = 0 ,               
  @NoramlImportCount int=0,@MultiTouchImportCount int=0,@Totalflatfilerows int=0,@Exstions varchar(max)=null;            
             
  delete Callrecording_Kruptoconnect_importtable where isnull(SOURCE,'')=''            
  set @Totalflatfilerows=(select COUNT ('a') from  Callrecording_Kruptoconnect_importtable)            
            
  update Callrecording_Kruptoconnect_importtable set SOURCE=trim(SOURCE)            
  update Callrecording_Kruptoconnect_importtable set TOTALTIME= DATEDIFF(second, cast(CALLSTARTTIME as datetime), cast(CALLENDTIME as datetime))            
  update Callrecording_Kruptoconnect_importtable set CALLSTARTTIME=convert(datetime,CALLSTARTTIME)            
  update Callrecording_Kruptoconnect_importtable set CALLENDTIME=convert(datetime,CALLENDTIME)            
        
        If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData               
        create table #TempData(CallInitiatedTime datetime,CallEndTime datetime,CreatedBy varchar(2500),SourceAdded varchar(2500),        
  CustomerName varchar(250),CreatedDate datetime,            
        Extension varchar(2500),CustomerID int,SubProvisionId int,        
  Location varchar(2000),Duration int,PhoneNumber varchar(2500),        
  CallDisposition varchar(max),UniqueiD varchar(max))            
--BEGIN TRY                    
--BEGIN TRANSACTION         
if exists (select top 1 * from Callrecording_Kruptoconnect_importtable)             
   begin             
           
   insert into Callrecording_Kruptoconnect_ImportData(UUID,CAMPAIGN,SOURCE,        
   DESTINATION,FINALDESTINATION,CALLTYPE,CALLSTATUS,CALLSTARTTIME,CALLRINGINGTIME,        
   CALLANSWEREDTIME,CALLENDTIME,TOTALTIME,RINGINGTIME,TALKTIME,TOTALHOLDTIME,        
   POSTDIALDELAY,HANGUPCAUSE,HANGUPCAUSECODE,HANGUPFIRST,QUEUEANSWEREDSTATUS,        
   QUEUESTARTTIME,QUEUEANSWERTIME,QUEUECANCELTIME,QUEUEENDTIME,DISPOSITION,        
   DISPOSITIONTIME,NOTES,CallInitiatedTime,CallEndTimes,CreatedDate)        
           
   select UUID,CAMPAIGN,SOURCE,        
   DESTINATION,FINALDESTINATION,CALLTYPE,CALLSTATUS,CALLSTARTTIME,CALLRINGINGTIME,        
   CALLANSWEREDTIME,CALLENDTIME,TOTALTIME,RINGINGTIME,TALKTIME,TOTALHOLDTIME,        
   POSTDIALDELAY,HANGUPCAUSE,HANGUPCAUSECODE,HANGUPFIRST,QUEUEANSWEREDSTATUS,        
   QUEUESTARTTIME,QUEUEANSWERTIME,QUEUECANCELTIME,QUEUEENDTIME,DISPOSITION,        
   DISPOSITIONTIME,NOTES,CallInitiatedTime,CallEndTimes,GETDATE()        
   from  Callrecording_Kruptoconnect_importtable        
  If OBJECT_ID('tempdb..#tempmaxusercustomer') is not null DROP TABLE #tempmaxusercustomer                       
  create table #tempmaxusercustomer(nt_username varchar(100), Userid int, CustomerId int, SubprovisionId int)                    
                   
  insert into #tempmaxusercustomer            
  select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                     
   FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                    
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_UserProfileMapping (nolock) UPM on UPM.UserID=UIF.USERID and UPM.Status=1                             
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ProfileMaster (nolock) PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                              
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ClientMaster_InternalExternal_View (nolock) CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                
    inner join ARC_REC..ARC_REC_usercustomer (nolock) UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                              
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID      
    
          
  insert into #tempmaxusercustomer                    
  select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId             
     
  FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                               
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_UserProfileMapping  UPM on UPM.UserID=UIF.USERID and UPM.Status=1                              
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                              
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ClientMaster_View  CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                
    inner join ARC_REC..ARC_REC_usercustomer  UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                              
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID      
  
        
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,Location,        
  Duration,PhoneNumber,CallDisposition,UniqueID)                    
  select distinct CI.CALLSTARTTIME CallInitiatedTime,CALLENDTIME,UIF.NT_USERNAME CreatedBy,              
  'Kruptoconnect' SourceAdded ,GETDATE()CreatedDate,[SOURCE] Extension,UIF.CustomerID,UIF.SubProvisionId,'USA',                      
  TOTALTIME,DESTINATION as PhoneNumber,CALLSTATUS as CallDisposition, UUID as  UniqueID                     
  FROM Callrecording_Kruptoconnect_importtable (nolock) CI                      
  inner join #tempmaxusercustomer UIF on CI.[SOURCE]=UIF.NT_USERNAME                    
  inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CI.CallEndTime)=D.Date                     
  inner join  [LNKTPARFLOW].ARC_Dashboard.dbo.FactAttendance A on UIF.USERID=A.UserId and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey                    
                
  /*Missing users mapping with Rec db*/                    
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,        
  SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,        
  Location,Duration,PhoneNumber,CallDisposition,UniqueID)                    
  select CI.CALLSTARTTIME CallInitiatedTime,CallEndTime,        
  UIF.NT_USERNAME CreatedBy,'Kruptoconnect' SourceAdded ,        
  GETDATE()CreatedDate,[SOURCE] Extension,A.PrimaryClientId,0,        
  'USA',TOTALTIME,DESTINATION as PhoneNumber,CALLSTATUS as CallDisposition, UUID as  UniqueID                     
  FROM Callrecording_Kruptoconnect_importtable (nolock) CI                      
  inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.[SOURCE]=UIF.NT_USERNAME                    
  inner join Echoc3Analytics.dbo.DimDate  (nolock) D on convert(date,CI.CallEndTime)=D.Date                     
  inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance  A on UIF.USERID=A.UserId and D.DateKey=A.DateKey                    
  where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp          
  WHERE  temp.CreatedBy = CI.[SOURCE] and temp.UniqueID = cI.UUID)       
    
     
    
        
  /*Missing users mapping with Rec db*/                    
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,        
  SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,        
  Location,Duration,PhoneNumber,CallDisposition,UniqueID)                    
  select CI.CALLSTARTTIME CallInitiatedTime,CallEndTime,        
  UIF.NT_USERNAME CreatedBy,'Kruptoconnect' SourceAdded ,        
  GETDATE()CreatedDate,[SOURCE] Extension,A.PrimaryClientId,0,'USA',                      
  TOTALTIME DURATION,DESTINATION as PhoneNumber,CALLSTATUS as CallDisposition, UUID as  UniqueID                     
  FROM Callrecording_Kruptoconnect_importtable (nolock) CI                    
  inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.[SOURCE]=UIF.NT_USERNAME                    
  inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,dateAdd(d, -1, CI.CallEndTime))=D.Date                     
  inner join  [LNKTPARFLOW].ARC_Dashboard.dbo.FactAttendance  A on UIF.USERID=A.UserId and D.DateKey=A.DateKey                    
  where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp  WHERE  temp.CreatedBy = CI.[SOURCE] and temp.UniqueID = cI.UUID)      
                   
                              
          
  /*Pending Records*/                    
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,        
  SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,        
  Location,Duration,PhoneNumber,CallDisposition, UniqueID)                    
  select  CallInitiatedTime,CallEndTime,CI.CreatedBy,SourceAdded,        
  GETDATE(),Extension,UIF.CustomerID,UIF.SubProvisionId,'USA',                      
  Duration,PhoneNumber,CallDisposition, UniqueID                       
  FROM ARC_AR_CallrecodingpendingData (nolock) CI                      
  inner join #tempmaxusercustomer UIF on CI.CreatedBy=UIF.NT_USERNAME                    
  inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CI.CallEndTime)=D.Date                     
  inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance  A on UIF.USERID=A.UserId and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey                    
               
       
  
     /* Import the data which are not matching */                    
 /* insert into ARC_AR_CallrecodingpendingData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,        
  Extension,CustomerID,Location,Createddate,Duration,PhoneNumber,CallDisposition, UniqueId)                    
  select CALLSTARTTIME,CallEndTime,[SOURCE] CreatedBy, 'Kruptoconnect' SourceAdded,        
  [SOURCE]  ,0 CustomerID,'USA',GETDATE() as Createddate,                     
  TOTALTIME DURATION,DESTINATION as PhoneNumber,CALLSTATUS as CallDisposition, UUID                      
  from Callrecording_Kruptoconnect_importtable  CI         
  where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp          
  WHERE  temp.CreatedBy = CI.[SOURCE]) */        
          
  delete ARC_AR_CallrecodingpendingData  where  CreatedBy in                    
  (SELECT CreatedBy  FROM   #TempData temp WHERE          
  temp.CreatedBy = CreatedBy and SourceAdded='Kruptoconnect')        
  and SourceAdded='Kruptoconnect'                    
                    
        /*declare @Pendingrecords int=0                    
        set @Pendingrecords =(select count('a') from ARC_AR_CallrecodingpendingData (nolock))                    
        if(@Pendingrecords>0)                    
        begin                    
   select @Exstions= '<table cellpading="0" cellspacing="0" border ="1" style="font-family: verdana; font-size: 12px"><tr align="left"                     
   valign="top" style="font-weight:bold;color:#fff;background:#267cc7;                    
   font-style:italic;border: solid 1px #000;"><td>Ntusername</td><td>Client</td></tr>'+CAST((select distinct CPd.CreatedBy as 'td' ,'',                    
   isnull(b.Client_name,'Name not matching') as 'td',''    from ARC_AR_CallrecodingpendingData (nolock) CPd                     
   Left Join ARC_REC.dbo.ARC_REC_User_info_vy (nolock) b on CPd.CreatedBy=b.nt_username                       
   and CONVERT(date, CPd.Createddate)=CONVERT(date,getdate())   where Cpd.SourceAdded='Kruptoconnect' order by 1                       
   FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX));                    
   INSERT INTO ARC_REC_MAIL_TRAN(FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,ISHTML,CC)--ar_managers@accesshealthcare.co               
   select 'mail.support@accesshealthcare.co' FROM_MAILID,'aneesh.t@accesshealthcare.com;Voice@accesshealth.onmicrosoft.com;niranjan.m@accesshealthcare.com;kailashvasan.vk@accesshealthcare.com' RECIPIENTS,'User names not found in arc  - Kruptoconnect' ,   
  
    
     
       
        
         
                  
   '<HTML><HEAD></HEAD><BODY style="font-family: verdana; font-size: 12px"><div >Hi ,<br /><p>The below given users are                    
   not found in arc records. Kindly provide AHS ntusername as username in the vendor applications/provide the logic                     
   to fetch AHS ntusernames. </p>                    
   '+@Exstions+'</table>              s        
   <br />Thanks,<br />Arc.flow team.<br /><img src="http://www.accesshealthcare.co/appimages/arc_support.png" alt="" width="250px" height="65px" /></p>** This is an auto-generated email.                     
   Please do not reply to this email.**<br />                    
   Legal Disclaimer: The information contained in this message (including all attachments) may be privileged and confidential. It is intended to be read only by the individual                     
   or entity to whom it is addressed or by their designee. If the reader of this message is not the intended recipient, please destroy this message immediately and also                     
   please note that you are on notice that any distribution of this message, in any form, is strictly prohibited. If you have received this message in error,                     
   please immediately notify the sender and delete or destroy any copy of this message. </BODY></HTML>'as Body,                      
   'Y' ISHTML,'sakkaravarth.k@accesshealthcare.co;arunkumar.p@accesshealthcare.co;karthiknainar.c@accesshealthcare.co;barathi.a@accesshealthcare.co;ramesh.v2@accesshealthcare.co' as CC;                    
   end */                   
                    
 end        
  /*Call recording matched records*/        
  INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,        
  CreatedBy,SourceAdded,Customername,Extension,CustomerID,Location,        
  Duration,Createddate,PhoneNumber,CallDisposition,        
  Uniqueid,RecordingURL,SubProvisionId,CallDate)                      
  SELECT A.CallInitiatedTime,A.CallEndTime,A.CreatedBy,A.SourceAdded,        
  A.Customername,A.Extension,A.CustomerID,A.Location,A.Duration,        
  A.CreatedDate,A.PhoneNumber,A.CallDisposition,a.UniqueID,        
  replace(convert(varchar(50),CONVERT(DATE,CallInitiatedTime), 101), '/', '') +'\'+a.UniqueID+'.wav' as RecordingURL, A.SubProvisionId   ,      
  convert(date,DATEADD(n,-630, A.CallInitiatedTime))    
            
  FROM #TempData A WHERE                       
  NOT EXISTS (                      
  SELECT 'A' FROM ARC_AR_Callrecoding (nolock)B         
  WHERE A.CallInitiatedTime=B.CallInitiatedTime AND                       
  A.CallEndTime=B.CallEndTime AND A.CreatedBy=B.CreatedBy         
  AND A.SourceAdded= B.SourceAdded         
  AND A.UniqueiD=B.Uniqueid)         
          
  /*Callrecoding unmatched records*/        
  INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,        
  CreatedBy,SourceAdded,Extension,CustomerID,Location,Createddate,        
  Duration,PhoneNumber,CallDisposition,        
  Uniqueid,RecordingURL,SubProvisionId,calldate)        
          
  select CALLSTARTTIME,CallEndTime,[SOURCE] CreatedBy,'Kruptoconnect' SourceAdded,        
  [SOURCE] ,0 CustomerID,'USA',GETDATE() as Createddate,                     
  TOTALTIME DURATION,DESTINATION as PhoneNumber,        
  CALLSTATUS as CallDisposition, UUID,        
  replace(convert(varchar(50),CONVERT(DATE,CALLSTARTTIME), 101), '/', '') +'\'+UUID+'.wav' as RecordingURL,         
  0 as SubProvisionId,  convert(date,DATEADD(n,-630, CALLSTARTTIME))                                
  from Callrecording_Kruptoconnect_importtable  CI         
  where   NOT EXISTS (SELECT UniqueID  FROM   #TempData temp          
  WHERE  temp.UniqueID = CI.UUID)        
  and UUID not IN(select uniqueid from  ARC_AR_Callrecoding)        
          
  UPDATE CD set cd.CustomerID=td.CustomerID,        
  cd.SubProvisionId=td.SubProvisionId            
  from #TempData td         
  inner join ARC_AR_Callrecoding cd on cd.CreatedBy=td.CreatedBy            
  where cd.CustomerID=0   and cd.SourceAdded='Kruptoconnect'                
          
    update cd set cd.active=0        
  from #TempData td         
 inner join ARC_AR_Callrecoding cd on cd.CreatedBy=td.CreatedBy and td.uniqueid=cd.uniqueid        
 where    td.CallDisposition in('Agent to agent call')        
  and cd.sourceadded='Kruptoconnect'        
                 
                
  insert into ARC_AR_FloorProductionCalldata(Ntusername,Customerid,SubProvisionId,CallintialtedDate,Vendor,Createddate,CallDuration)                      
  SELECT A.CreatedBy,A.CustomerId,A.SubProvisionId,A.CallInitiatedTime,A.SourceAdded,A.CreatedDate,A.Duration FROM #TempData A WHERE NOT EXISTS (                      
  SELECT 'A' FROM ARC_AR_FloorProductionCalldata (nolock) B                       
  WHERE  A.CreatedBy=B.Ntusername AND A.Customerid=B.Customerid  AND A.SubProvisionId=B.SubProvisionId AND A.CallInitiatedTime=B.CallintialtedDate AND A.SourceAdded =B.Vendor )                      
               
--COMMIT TRANSACTION                    
--END TRY                    
-- BEGIN CATCH                   
--  IF(@@TRANCOUNT > 0)                  
--   ROLLBACK TRANSACTION                    
-- END CATCH         
         
                                  
 UPDATE ARC_Ar_fileimportstatus set importstatus = 3,ErrorDescription='imported' Where customerid = @CustomerId and Identityno = @sessionid                      
                                       
 TRUNCATE TABLE Callrecording_Kruptoconnect_importtable;                    
 set @NoramlImportCount=(select COUNT ('a') from #TempData)                    
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData                         
                       
  select @importstatus=CONVERT(varchar(10), isnull(@Totalflatfilerows,0))+','+CONVERT(varchar(10),isnull(@NoramlImportCount,0))+                       
  ','+CONVERT(varchar(10),isnull(@MultiTouchImportCount,0))+','+CONVERT(varchar(10),isnull(@Duplicate,0))                       
  +','+CONVERT(varchar(10),isnull(@MultiDuplicate,0))+','+CONVERT(varchar(10),isnull(@PurgeCount,0))+                       
  +','+CONVERT(varchar(10),isnull(@MultiPurgeCount,0))                       
                        
END 
GO
/****** Object:  StoredProcedure [dbo].[Callrecording_RingCentral_autoimport]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Callrecording_RingCentral_autoimport](
@filepath varchar(1000)=null,
@Customerid int=0,
@Customername varchar(250)=null,
@Format varchar(20)=null,
@Table varchar(300)=null,
@result varchar(750)=null OUTPUT)
as
begin


if not exists(select FI.FilePath from ARC_AR_Fileformat FF left join ARC_Ar_fileimportstatus FI on FI.Customerid=FF.CustomerId
	where FI.importstatus=3 and FF.Status=1 and  FF.CustomerId=@Customerid 	and FI.FilePath=@filepath)
begin
		truncate table Callrecording_RingCentral_importtable 
		select @result='File imported sucessfuly'
end
 else
begin
		truncate table Callrecording_RingCentral_importtable
		select @result='File name already exist.if you want import same file please change file name from folder'
end
end

GO
/****** Object:  StoredProcedure [dbo].[Callrecording_RingCentral_import]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Callrecording_RingCentral_import]                          
(                           
 @Format varchar(5000)=null,                            
 @locationid int =1 ,                             
 @CustomerId  int=0,                             
 @sessionid VARCHAR(50)=null,                            
 @USERID INT=1,                            
 @importstatus varchar(max)=null OUTPUT                           
 )                          
AS                            
                            
BEGIN                            
 declare @PurgeCount int=0,@Duplicate int = 0,@FileType int = 1,                         
 @MultiPurgeCount int=0,@MultiDuplicate int = 0 ,                             
 @NoramlImportCount int=0,@MultiTouchImportCount int=0,                          
 @Totalflatfilerows int=0,@Exstions varchar(max)=null,@Minutes int=0,                          
 @FiveTime varchar(100)='';                             
                    
   update Callrecording_RingCentral_importtable set CallEndTime=convert(varchar, CAST(CALLSTARTTIME AS datetime) + CAST(CONVERT(time,CALLLENGTH) AS datetime), 121)                          
   update Callrecording_RingCentral_importtable set FROMNAME= REPLACE(FROMNAME, ' ', '.');              
   update Callrecording_RingCentral_importtable set FROMNUMBER=replace(replace(replace(REPLACE(FROMNUMBER,'(',''),')',''),'-',''),' ','')            
   update Callrecording_RingCentral_importtable set TONUMBER=replace(replace(replace(REPLACE(TONUMBER,'(',''),')',''),'-',''),' ','')            
           
   UPDATE CR set cr.CALLSTARTTIME=convert(varchar,dateadd (minute,TZ.IST_Minutes, CR.CALLSTARTTIME),121),  
   cr.callendtime=convert(varchar,dateadd (minute, TZ.IST_Minutes, CR.callendtime),121)           
   FROM Callrecording_RingCentral_importtable CR          
   inner join EXTR_ARC_AR_V1.dbo.ARC_AR_TimeZoneConverter TZ on CR.CALLSTARTTIME between TZ.StartDate and TZ.EndDate           
   and TZ.TimeZone='EST'                        
            
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData                             
  create table #TempData(CallInitiatedTime datetime,CallEndTime datetime,                          
  CreatedBy varchar(2500),SourceAdded varchar(2500),CustomerName varchar(2500),                          
  CreatedDate datetime,Extension varchar(2000),CustomerID int,                          
  SubProvisionId int,Location varchar(250),Duration int,                          
  PhoneNumber varchar(200),CallDisposition varchar(max),                          
  CLAIMID varchar(500),UniqueID varchar(500),Result varchar(max), CALLDIRECTION varchar(max))               
             
 insert into Callrecording_RingCentral_importdata(SESSIONID,FROMNAME,FROMNUMBER,TONAME,TONUMBER,RESULT,CALLLENGTH,HANDLETIME,                    
 CALLSTARTTIME,CALLDIRECTION,QUEUE,CALLENDTIME)                    
 SELECT SESSIONID,FROMNAME,FROMNUMBER,TONAME,TONUMBER,RESULT,CALLLENGTH,HANDLETIME,                    
 CALLSTARTTIME,CALLDIRECTION,QUEUE,CALLENDTIME FROM Callrecording_RingCentral_importtable             
                          
--BEGIN TRY                                      
-- BEGIN TRANSACTION                          
   set @Totalflatfilerows=(select COUNT ('a') from  Callrecording_RingCentral_importtable)                          
   delete Callrecording_RingCentral_importtable where isnull(FROMNAME,'')=''                          
                          
   if exists (select top 1 * from Callrecording_RingCentral_importtable)                           
   begin                          
     set @FiveTime=(select top 1 CALLSTARTTIME  from Callrecording_RingCentral_importtable)                          
  set @Minutes=(select IST_Minutes from EXTR_ARC_AR_V1.dbo.ARC_AR_TimeZoneConverter                        
   where TimeZone='EST' and Status=1 and convert(datetime, @FiveTime) between StartDate and Enddate)                          
                           
                        
                       
                              
 If OBJECT_ID('tempdb..#ExtensionmappedtData') is not null DROP TABLE #ExtensionmappedtData                            
 create table #ExtensionmappedtData(Extension varchar(200))                          
 If OBJECT_ID('tempdb..#tempmaxusercustomer') is not null DROP TABLE #tempmaxusercustomer                                         
    create table #tempmaxusercustomer(nt_username varchar(100), Userid int, CustomerId int, SubprovisionId int)                                      
                                   
 insert into #tempmaxusercustomer                              
    select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                    
FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                                       
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_UserProfileMapping (nolock) UPM on UPM.UserID=UIF.USERID and UPM.Status=1                                      
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ProfileMaster (nolock) PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                                      
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ClientMaster_InternalExternal_View (nolock) CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                        
    inner join ARC_REC..ARC_REC_usercustomer (nolock) UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                                      
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID                           
                          
 insert into #tempmaxusercustomer                                      
    select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                                       
    FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                                       
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_UserProfileMapping  UPM on UPM.UserID=UIF.USERID and UPM.Status=1                                      
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                                      
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ClientMaster_View  CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                        
    inner join ARC_REC..ARC_REC_usercustomer  UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                                      
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID                                       
                               
                                
                    
 insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,                          
 Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition,UniqueID,RESULT,CALLDIRECTION)                                      
            
 select convert(varchar,CI.CALLSTARTTIME,121) CallInitiatedTime,CALLENDTIME,UIF.NT_USERNAME CreatedBy,                                      
 'RingCentral' SourceAdded ,GETDATE(),CI.FROMNAME Extension,UIF.CustomerID,UIF.SubProvisionId,'USA',             
 DATEDIFF(SECOND, convert(datetime,CI.CALLSTARTTIME), CAST(CI.CALLSTARTTIME AS datetime) + CAST(CONVERT(time,CALLLENGTH) AS datetime)) as Duration,            
 TONUMBER as PhoneNumber,                          
 CALLDIRECTION as CallDisposition, SESSIONID as  UniqueID,RESULT,CALLDIRECTION                                       
 FROM Callrecording_RingCentral_importtable (nolock) CI                                        
 inner join #tempmaxusercustomer UIF on CI.FROMNAME=UIF.NT_USERNAME                                      
 inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CALLENDTIME)=D.Date                                       
 inner join [LNKTPARFLOW].[ARC_dashboard].[dbo].FactAttendance   A on UIF.USERID=A.UserId                         
 and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey                                      
                             
  /*Missing users mapping with Rec db*/                                      
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,Extension,                        
 CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition,UniqueID,RESULT,CALLDIRECTION)                                      
    select convert(varchar,CI.CALLSTARTTIME,121) CallInitiatedTime,CALLENDTIME,UIF.NT_USERNAME CreatedBy,                                      
 'RingCentral' SourceAdded ,GETDATE(),CI.FROMNAME Extension,A.PrimaryClientId,0,'USA',                                        
 DATEDIFF(SECOND, convert(datetime,CI.CALLSTARTTIME), CAST(CI.CALLSTARTTIME AS datetime) + CAST(CONVERT(time,CALLLENGTH) AS datetime)) as Duration,            
 TONUMBER as PhoneNumber,                          
 CALLDIRECTION as CallDisposition, SESSIONID as  UniqueID  ,RESULT,CALLDIRECTION                                   
    FROM Callrecording_RingCentral_importtable (nolock) CI                                        
    inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.FROMNAME=UIF.NT_USERNAME                                      
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on Convert(date,CALLENDTIME)=D.Date                                       
    inner join [LNKTPARFLOW].[ARC_dashboard].[dbo].FactAttendance  A on UIF.USERID=A.UserId and D.DateKey=A.DateKey                                      
    where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp                         
 WHERE  temp.CreatedBy = CI.FROMNAME and temp.UniqueID = cI.SESSIONID)                          
                           
 /*Missing users mapping with Rec db*/                                      
 insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,                        
 Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition,UniqueID,RESULT,CALLDIRECTION)                                      
 select convert(varchar,CI.CALLSTARTTIME,121) CallInitiatedTime, CallEndTime ,UIF.NT_USERNAME CreatedBy,                                      
 'RingCentral' SourceAdded ,GETDATE()CreatedDate,FROMNAME Extension,A.PrimaryClientId,0,'USA',                                        
  DATEDIFF(SECOND, convert(datetime,CI.CALLSTARTTIME), CAST(CI.CALLSTARTTIME AS datetime) + CAST(CONVERT(time,CALLLENGTH) AS datetime)) as Duration,            
  TONUMBER as PhoneNumber,                          
 CALLDIRECTION as CallDisposition, SESSIONID as  UniqueID,RESULT,CALLDIRECTION                                                
 FROM Callrecording_RingCentral_importtable (nolock) CI                                        
 inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.FROMNAME=UIF.NT_USERNAME                                      
 inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,dateAdd(d, -1, CallEndTime))=D.Date                                       
 inner join [LNKTPARFLOW].[ARC_dashboard].[dbo].FactAttendance  A on UIF.USERID=A.UserId and D.DateKey=A.DateKey                                      
 where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp                            
 WHERE  temp.CreatedBy = CI.FROMNAME and temp.UniqueID = cI.SESSIONID)                                         
                              
 /*Pending Records*/                                      
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,Extension,                          
 CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition, UniqueID)                                      
    select  CallInitiatedTime,CallEndTime,CI.CreatedBy,SourceAdded ,GETDATE(),                        
 Extension,UIF.CustomerID,UIF.SubProvisionId,'USA',                                        
    Duration,PhoneNumber,CallDisposition, UniqueID                         
    FROM ARC_AR_CallrecodingpendingData (nolock) CI                                        
    inner join #tempmaxusercustomer UIF on CI.CreatedBy=UIF.NT_USERNAME                                      
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CallEndTime)=D.Date                                       
    inner join [LNKTPARFLOW].[ARC_dashboard].[dbo].FactAttendance   A on UIF.USERID=A.UserId                         
 and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey                                      
                          
                           
 delete ARC_AR_CallrecodingpendingData  where  CreatedBy in           
    (SELECT CreatedBy  FROM   #TempData temp WHERE  temp.CreatedBy = CreatedBy                        
  and SourceAdded='RingCentral') and SourceAdded='RingCentral'                                      
                                 
                                      
 end                     
               
                       
 UPDATE CD set cd.CallInitiatedTime=td.CallInitiatedTime, cd.CallEndTime=TD.CallEndTime ,CD.Duration=TD.Duration ,cd.SubProvisionId=td.SubProvisionId                              
 from #TempData td                           
 inner join ARC_AR_Callrecoding cd on  cd.SourceAdded='RingCentral' AND TD.UniqueID=CD.Uniqueid             
               
                                            
 INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,Customername,                        
 Extension,CustomerID,Location,Duration,Createddate,PhoneNumber,CallDisposition,Uniqueid,                        
 CLAIMNO,RecordingURL,SubProvisionId,CallDirections,CallDate)                                          
 SELECT A.CallInitiatedTime,A.CallEndTime,A.CreatedBy,A.SourceAdded,                          
 A.Customername,A.Extension,A.CustomerID,A.Location,A.Duration,                          
 A.CreatedDate,A.PhoneNumber,A.Result,a.UniqueID,a.CLAIMID,                          
 --replace(convert(varchar(50),CONVERT(DATE,CallInitiatedTime), 101), '/', '') +'\'+a.UniqueID+'.wav' as RecordingURL,               
 null as RecordingURL,                       
 A.SubProvisionId   ,A.CALLDIRECTION, Convert(date,DATEADD(n,-630,A.CallInitiatedTime))                                      
 FROM #TempData A WHERE                                         
 NOT EXISTS (                                        
 SELECT 'A' FROM ARC_AR_Callrecoding (nolock)B                           
 WHERE                        
  A.SourceAdded=b.SourceAdded                          
 And A.UniqueID=B.Uniqueid and A.CreatedDate >='2020-06-01' )                           
                            
                          
  /*Callrecoding unmatched records*/                          
  INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,Extension,CustomerID,                        
  Location,Createddate,Duration,PhoneNumber,CallDisposition,Uniqueid,RecordingURL,SubProvisionId,CallDirections,CallDate)                            
                          
  select CI.CALLSTARTTIME CallInitiatedTime,CallEndTime,FROMNAME CreatedBy, 'RingCentral' SourceAdded,                          
 FROMNAME ,0 CustomerID,'USA',GETDATE() as Createddate,DATEDIFF(SECOND, convert(datetime,CI.CALLSTARTTIME), CAST(CI.CALLSTARTTIME AS datetime) + CAST(CONVERT(time,CALLLENGTH) AS datetime)) as Duration,                        
 TONUMBER as PhoneNumber,Result ,SESSIONID as  UniqueID,                           
 --replace(convert(varchar(50),CONVERT(DATE,CI.CALLSTARTTIME), 101), '/', '') +'\'+SESSIONID+'.wav' as RecordingURL,              
 null as RecordingURL,                                     
 0 as SubProvisionId,CALLDIRECTION, Convert(date,DATEADD(n,-630,CI.CALLSTARTTIME))                           
 from Callrecording_RingCentral_importtable  CI                           
 where   NOT EXISTS (SELECT UniqueID  FROM                             
 #TempData temp  WHERE  temp.UniqueID = CI.SESSIONID)                          
 and SESSIONID not IN(select uniqueid from  ARC_AR_Callrecoding where sourceadded='RingCentral')                              
                          
 UPDATE CD set cd.CustomerID=td.CustomerID,                          
 cd.SubProvisionId=td.SubProvisionId                              
 from #TempData td                           
 inner join ARC_AR_Callrecoding cd on cd.uniqueid=td.uniqueid                              
 where cd.CustomerID=0   and cd.SourceAdded='RingCentral'                                         
                            
  update cd set cd.active=0                          
  from #TempData td                           
 inner join ARC_AR_Callrecoding cd on   td.uniqueid=cd.uniqueid                  
 where td.CallDisposition in('3rd party conference','3rd party conference','3rd party transfer','Internal','Test manual')                          
  and cd.sourceadded='RingCentral'                  
                
                        
                          
  set @NoramlImportCount=(select COUNT ('a') from #TempData)                          
                        
 insert into ARC_AR_FloorProductionCalldata(Ntusername,Customerid,SubProvisionId,CallintialtedDate,Vendor,Createddate,CallDuration)                          
 SELECT A.CreatedBy,A.CustomerId,A.SubProvisionId,A.CallInitiatedTime,A.SourceAdded,A.CreatedDate,A.Duration FROM #TempData A WHERE NOT EXISTS (                                        
 SELECT 'A' FROM ARC_AR_FloorProductionCalldata (nolock) B                                         
 WHERE  A.CreatedBy=B.Ntusername AND A.Customerid=B.Customerid  AND A.SubProvisionId=B.SubProvisionId AND A.CallInitiatedTime=B.CallintialtedDate AND A.SourceAdded =B.Vendor )                           
                                       
--COMMIT TRANSACTION                                 
--END TRY                          
-- BEGIN CATCH                                     
-- IF(@@TRANCOUNT > 0)                                    
--  ROLLBACK TRANSACTION                                      
-- END CATCH                             
                           
                                                     
 UPDATE ARC_Ar_fileimportstatus set importstatus = 3,ErrorDescription='imported' Where customerid = @CustomerId and Identityno = @sessionid                                        
                            
 TRUNCATE TABLE Callrecording_RingCentral_importtable;                                      
                                     
     update [LNKTPARFLOW].[ARC_FLOW].[dbo].ADM_MailDownload set Status=1 where '\\fs3\ARC_FLOW\New_Batches\WaterTown\ArcDumpAttachments\'+FolderPath+'\'+FileName=@Format                            
  select @importstatus=CONVERT(varchar(10), isnull(@Totalflatfilerows,0))+','+CONVERT(varchar(10),isnull(@NoramlImportCount,0))+                                         
  ','+CONVERT(varchar(10),isnull(@MultiTouchImportCount,0))+','+CONVERT(varchar(10),isnull(@Duplicate,0))                                         
  +','+CONVERT(varchar(10),isnull(@MultiDuplicate,0))+','+CONVERT(varchar(10),isnull(@PurgeCount,0))+                                         
  +','+CONVERT(varchar(10),isnull(@MultiPurgeCount,0))                                         
                                          
END 
GO
/****** Object:  StoredProcedure [dbo].[Callrecording_TATA_autoimport]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Callrecording_TATA_autoimport](
@filepath varchar(1000)=null,
@Customerid int=0,
@Customername varchar(250)=null,
@Format varchar(20)=null,
@Table varchar(300)=null,
@result varchar(750)=null OUTPUT)
as
begin


if not exists(select FI.FilePath from ARC_AR_Fileformat FF left join ARC_Ar_fileimportstatus FI on FI.Customerid=FF.CustomerId
	where FI.importstatus=3 and FF.Status=1 and  FF.CustomerId=@Customerid 	and FI.FilePath=@filepath)
begin
		truncate table Callrecording_TATA_importtable 
		select @result='File imported sucessfuly'
end
 else
begin
		truncate table Callrecording_TATA_importtable
		select @result='File name already exist.if you want import same file please change file name from folder'
end
end




GO
/****** Object:  StoredProcedure [dbo].[Callrecording_TATA_import]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Callrecording_TATA_import]                  
(                                
 @Format varchar(5000)=null,                                
 @locationid int =1 ,                                 
 @CustomerId  int=0,                                 
 @sessionid VARCHAR(50)=null,                                
 @USERID INT=1,                                
 @importstatus varchar(max)=null OUTPUT )                                
AS                                
                                
BEGIN                                
                               
 declare @PurgeCount int=0,@Duplicate int = 0,@FileType int = 1,                                 
 @MultiPurgeCount int=0,@MultiDuplicate int = 0 ,                                 
 @NoramlImportCount int=0,@MultiTouchImportCount int=0,@Totalflatfilerows int=0,@Exstions varchar(max)=null,@Minutes int=0,@TTime varchar(100)='';                               
             
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData                                 
 create table #TempData(CallInitiatedTime datetime,CallEndTime datetime,            
 CreatedBy varchar(2500),SourceAdded varchar(2500),CustomerName varchar(2500),            
 CreatedDate datetime,Extension varchar(2500),CustomerID int,            
 SubProvisionId int,Location varchar(250),Duration int,            
 PhoneNumber varchar(520),CallDisposition varchar(max),            
 UniqueID varchar(500))                              
                         
--BEGIN TRY                              
-- BEGIN TRANSACTION                              
 UPDATE Callrecording_TATA_importtable set CallerID= lTRIM(CallerID)            
 UPDATE Callrecording_TATA_importtable set CALLERANI= lTRIM(CALLERANI)                               
 UPDATE Callrecording_TATA_importtable set GROUPBYPARAMETER= left(replace(GROUPBYPARAMETER, 'Agent: ', ''), charIndex(' ',replace(GROUPBYPARAMETER, 'Agent: ', '')))                               
 UPDATE Callrecording_TATA_importtable set GROUPBYPARAMETER= left(replace(GROUPBYPARAMETER, 'Agent: ', ''), charIndex(' ',replace(GROUPBYPARAMETER, 'Agent: ', '')))                               
 set @Totalflatfilerows=(select COUNT ('a') from  Callrecording_TATA_importtable)                              
                                              
 If OBJECT_ID('tempdb..#ExtensionmappedtData') is not null DROP TABLE #ExtensionmappedtData                                
 create table #ExtensionmappedtData(Extension varchar(20))                              
                                              
    if exists (select top 1 * from Callrecording_TATA_importtable)                              
    begin                              
          set @TTime=(select top 1 ARRIVALTIME  from Callrecording_TATA_importtable)                              
          set @Minutes=(select IST_Minutes from EXTR_ARC_AR_V1.dbo.ARC_AR_TimeZoneConverter where TimeZone='EST' and Status=1 and convert(datetime, @TTime) between StartDate and Enddate)                              
          update Callrecording_TATA_importtable set GROUPBYPARAMETER= TRIM(GROUPBYPARAMETER)                               
    update Callrecording_TATA_importtable set DURATION=datediff(second,0,(CONVERT(time,DURATION)))                       
       update Callrecording_TATA_importtable set CallEndTime=DATEADD(second,cast(DURATION as int),Convert(datetime,ARRIVALTIME))                             
            
 insert into Callrecording_TATA_ImportData(GROUPBYPARAMETER, CALLID, CALLERANI, CALLERID, ARRIVALTIME, DIRECTION, OUTCOME, DURATION            
 ,TALKTIME, TRANSFER, HOLDS, CallEndTime, CreatedDate)            
 select GROUPBYPARAMETER, CALLID, CALLERANI, CALLERID, ARRIVALTIME, DIRECTION, OUTCOME, DURATION,            
 TALKTIME, TRANSFER, HOLDS, CallEndTime, getdate() from Callrecording_TATA_importtable            
                                   
    If OBJECT_ID('tempdb..#tempmaxusercustomer') is not null DROP TABLE #tempmaxusercustomer                              
    create table #tempmaxusercustomer(nt_username varchar(100), Userid int, CustomerId int, SubprovisionId int)                              
                                  
    insert into #tempmaxusercustomer                      
 select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                               
    FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                    
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_UserProfileMapping (nolock) UPM on UPM.UserID=UIF.USERID and UPM.Status=1                             
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ProfileMaster (nolock) PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                              
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ClientMaster_InternalExternal_View (nolock) CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                
    inner join ARC_REC..ARC_REC_usercustomer (nolock) UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                              
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID                               
                              
    insert into #tempmaxusercustomer                              
    select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                               
    FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                               
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_UserProfileMapping  UPM on UPM.UserID=UIF.USERID and UPM.Status=1                              
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                              
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ClientMaster_View  CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                
    inner join ARC_REC..ARC_REC_usercustomer  UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                              
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID                               
                              
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,            
 SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,Location,            
 Duration,PhoneNumber,CallDisposition,UniqueID)                              
    select distinct CI.ARRIVALTIME CallInitiatedTime,CallEndTime,            
 UIF.NT_USERNAME CreatedBy,'TATA' SourceAdded ,GETDATE()CreatedDate,            
 GROUPBYPARAMETER as Extension,UIF.CustomerID,UIF.SubProvisionId,'USA',DURATION,            
 CALLERANI as PhoneNumber,DIRECTION as CallDisposition,             
 CALLID as  UniqueID                               
    FROM Callrecording_TATA_importtable (nolock) CI                                
    inner join #tempmaxusercustomer UIF on CI.GROUPBYPARAMETER=UIF.NT_USERNAME                              
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CI.CallEndTime)=D.Date                               
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance  A on UIF.USERID=A.UserId and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey                              
                              
                                  
    /*Missing users mapping with Rec db*/                              
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,            
 SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,Location,            
 Duration,PhoneNumber,CallDisposition,UniqueID)                              
    select CI.ARRIVALTIME CallInitiatedTime,CallEndTime,UIF.NT_USERNAME CreatedBy,                              
    'TATA' SourceAdded ,GETDATE()CreatedDate,GROUPBYPARAMETER Extension,A.PrimaryClientId,0,'USA',                                
    DURATION,CALLERANI as PhoneNumber,DIRECTION as CallDisposition, CALLID as  UniqueID             
    FROM Callrecording_TATA_importtable (nolock) CI                                
    inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.GROUPBYPARAMETER=UIF.NT_USERNAME                              
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CI.CallEndTime)=D.Date                               
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance   A on UIF.USERID=A.UserId and D.DateKey=A.DateKey           
    where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp  WHERE  temp.CreatedBy = CI.GROUPBYPARAMETER and temp.UniqueID = cI.CALLID)                  
                   
    /*Missing users mapping with Rec db*/                              
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition,UniqueID)                              
    select CI.ARRIVALTIME CallInitiatedTime,CallEndTime,UIF.NT_USERNAME CreatedBy,                            
    'TATA' SourceAdded ,GETDATE()CreatedDate,GROUPBYPARAMETER Extension,A.PrimaryClientId,0,'USA',                                
    DURATION,CALLERANI as PhoneNumber,DIRECTION as CallDisposition, CALLID as  UniqueID                               
    FROM Callrecording_TATA_importtable (nolock) CI                                
    inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.GROUPBYPARAMETER=UIF.NT_USERNAME                              
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,dateAdd(d, -1, CI.CallEndTime))=D.Date                               
    inner join[LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance    A on UIF.USERID=A.UserId and D.DateKey=A.DateKey                              
    where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp  WHERE  temp.CreatedBy = CI.GROUPBYPARAMETER and temp.UniqueID = cI.CALLID)                                 
                                              
    /*Pending Records*/                              
    insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition, UniqueID)                              
    select  CallInitiatedTime,CallEndTime,CI.CreatedBy,SourceAdded ,GETDATE(),Extension,UIF.CustomerID,UIF.SubProvisionId,'USA',                                
    Duration,PhoneNumber,CallDisposition, UniqueID                                 
    FROM ARC_AR_CallrecodingpendingData (nolock) CI                                
    inner join #tempmaxusercustomer UIF on CI.CreatedBy=UIF.NT_USERNAME                              
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CI.CallEndTime)=D.Date                               
    inner join [LNKTPARFLOW].[ARC_Dashboard].[dbo].FactAttendance   A on UIF.USERID=A.UserId and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey                              
                              
    /* Import the data which are not matching */                              
 --   insert into ARC_AR_CallrecodingpendingData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,Extension,CustomerID,Location,Createddate,Duration,PhoneNumber,CallDisposition, UniqueId)                              
 --   select ARRIVALTIME,CallEndTime,GROUPBYPARAMETER CreatedBy, 'TATA' SourceAdded,GROUPBYPARAMETER ,0 CustomerID,'USA',GETDATE() as Createddate,                               
 --DURATION,CALLERID as PhoneNumber,DIRECTION as CallDisposition, CALLID                                
 --   from Callrecording_TATA_importtable  CI                   
 --where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp  WHERE  temp.CreatedBy = CI.GROUPBYPARAMETER)                          
                   
                  
 delete ARC_AR_CallrecodingpendingData  where  CreatedBy in                              
    (SELECT CreatedBy  FROM   #TempData temp WHERE  temp.CreatedBy = CreatedBy and SourceAdded='TATA') and SourceAdded='TATA'                              
                              
 --               declare @Pendingrecords int=0                              
 --               set @Pendingrecords =(select count('a') from ARC_AR_CallrecodingpendingData (nolock))                              
 --               if(@Pendingrecords>0)                              
 --               begin                              
 --                               select @Exstions= '<table cellpading="0" cellspacing="0" border ="1" style="font-family: verdana; font-size: 12px"><tr align="left"                               
 --      valign="top" style="font-weight:bold;color:#fff;background:#267cc7;                              
 --     font-style:italic;border: solid 1px #000;"><td>Ntusername</td><td>Client</td></tr>'+CAST((select distinct CPd.CreatedBy as 'td' ,'',                         
 --                               isnull(b.Client_name,'Name not matching') as 'td',''    from ARC_AR_CallrecodingpendingData (nolock) CPd                               
 --                               Left Join ARC_REC.dbo.ARC_REC_User_info_vy (nolock) b on CPd.CreatedBy=b.nt_username                                 
 --                               and CONVERT(date, CPd.Createddate)=CONVERT(date,getdate())   where Cpd.SourceAdded='TATA' order by 1                                 
 --                               FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX));                              
 --                               INSERT INTO ARC_REC_MAIL_TRAN(FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,ISHTML,CC)--ar_managers@accesshealthcare.co                         
 --                    select 'mail.support@accesshealthcare.co' FROM_MAILID,'aneesh.t@accesshealthcare.com;Voice@accesshealth.onmicrosoft.com' RECIPIENTS,'User names not found in arc  - TATA' ,                              
 --                               '<HTML><HEAD></HEAD><BODY style="font-family: verdana; font-size: 12px"><div >Hi ,<br /><p>The below given users are                              
 --                               not found in arc records. Kindly provide AHS ntusername as username in the vendor applications/provide the logic                               
 --                                to fetch AHS ntusernames. </p>                              
 --                               '+@Exstions+'</table>                                
 --                               <br />Thanks,<br />Arc.flow team.<br /><img src="http://www.accesshealthcare.co/appimages/arc_support.png" alt="" width="250px" height="65px" /></p>** This is an auto-generated email.                               
 --                               Please do not reply to this email.**<br />                              
 --                   Legal Disclaimer: The information contained in this message (including all attachments) may be privileged and confidential. It is intended to be read only by the individual                               
 --                               or entity to whom it is addressed or by their designee. If the reader of this message is not the intended recipient, please destroy this message immediately and also                               
 --                               please note that you are on notice that any distribution of this message, in any form, is strictly prohibited. If you have received this message in error,                               
 --                               please immediately notify the sender and delete or destroy any copy of this message. </BODY></HTML>'as Body,                                
 --                               'Y' ISHTML,'sakkaravarth.k@accesshealthcare.co;arunkumar.p@accesshealthcare.co;karthiknainar.c@accesshealthcare.co;barathi.a@accesshealthcare.co;ramesh.v2@accesshealthcare.co' as CC;                              
 --               end                              
                              
 end                              
                           
 /*                              
  Modified on:03/10/2020        Modified by: Arunkumar.P                              
  Modified reason: Duplicate logic based on call start,endtime,provider and created By, Phone No                              
 */                           
                  
                  
                
 INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,CreatedBy,            
 SourceAdded,Customername,Extension,CustomerID,Location,Duration,            
 Createddate,PhoneNumber,CallDisposition,Uniqueid,RecordingURL,             
 SubProvisionId,CallDirections,CallDate )                                
 SELECT A.CallInitiatedTime,A.CallEndTime,A.CreatedBy,A.SourceAdded,            
 A.Customername,A.Extension,A.CustomerID,A.Location,A.Duration,            
 A.CreatedDate,A.PhoneNumber,A.CallDisposition,a.UniqueID,            
            
 '\\10.50.2.243\$tata-recrd$\'+ replace(convert(varchar(50),CONVERT(DATE,CallInitiatedTime), 101), '/', '') +'\'+a.UniqueID+'.wav' as RecordingURL,            
 A.SubProvisionId ,A.CallDisposition,  convert(date,DATEADD(n,-630, A.CallInitiatedTime))                                   
 FROM #TempData A WHERE                           
 NOT EXISTS (                                
 SELECT 'A' FROM ARC_AR_Callrecoding (nolock)B                   
 WHERE A.CallInitiatedTime=B.CallInitiatedTime AND                                 
 A.CallEndTime=B.CallEndTime AND A.CreatedBy=B.CreatedBy             
 AND A.SourceAdded= B.SourceAdded                   
 AND isnull(A.PhoneNumber,'')=isnull(B.PhoneNumber,'') )                           
              
   /*unmatched records*/               
 INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,CreatedBy,            
 SourceAdded,Customername,Extension,CustomerID,Location,Duration,              
 Createddate,PhoneNumber,CallDisposition,Uniqueid,RecordingURL, SubProvisionId,CallDirections ,CallDate )                              
 select    ARRIVALTIME,CallEndTime,GROUPBYPARAMETER CreatedBy, 'TATA' SourceAdded,'' CustomerName ,              
 GROUPBYPARAMETER,  0 CustomerID,'USA' as Location,DURATION,              
 GETDATE() as Createddate, CALLERANI as PhoneNumber,DIRECTION as CallDisposition, CALLID ,          
  '\\10.50.2.243\$tata-recrd$\'+ replace(convert(varchar(50),CONVERT(DATE,ArrivalTime), 101), '/', '') +'\'+callid+'.wav' as RecordingURL,0 as  SubProvisionId  ,DIRECTION,      
   convert(date,DATEADD(n,-630, ARRIVALTIME))            
              
from Callrecording_TATA_importtable  (nolock)CI                 
 where   NOT EXISTS (SELECT UniqueID  FROM   #TempData temp              
 WHERE  temp.UniqueID = CI.CALLID)                  
 and CALLID not IN(select uniqueid from  ARC_AR_Callrecoding)                
             
                
                
 UPDATE CD set cd.CustomerID=td.CustomerID,            
 cd.SubProvisionId=td.SubProvisionId                
 from #TempData td inner join ARC_AR_Callrecoding cd on             
 cd.CreatedBy=td.CreatedBy                
 where cd.CustomerID=0   and cd.SourceAdded='TATA'                  
                               
 insert into ARC_AR_FloorProductionCalldata(Ntusername,Customerid,SubProvisionId,CallintialtedDate,Vendor,Createddate,CallDuration)                                
 SELECT A.CreatedBy,A.CustomerId,A.SubProvisionId,A.CallInitiatedTime,A.SourceAdded,A.CreatedDate,A.Duration FROM #TempData A WHERE NOT EXISTS (                                
 SELECT 'A' FROM ARC_AR_FloorProductionCalldata (nolock) B                                 
 WHERE  A.CreatedBy=B.Ntusername AND A.Customerid=B.Customerid  AND A.SubProvisionId=B.SubProvisionId AND A.CallInitiatedTime=B.CallintialtedDate AND A.SourceAdded =B.Vendor )                                
             
                   
-- COMMIT TRANSACTION                              
--END TRY                              
--BEGIN CATCH                             
--IF(@@TRANCOUNT > 0)                            
-- ROLLBACK TRANSACTION                              
--END CATCH                              
                               
 --NOT EXISTS (                                
 --SELECT 'A' FROM ARC_AR_Callrecoding (nolock)B WHERE A.CallInitiatedTime=B.CallInitiatedTime AND                                 
 --A.CallEndTime=B.CallEndTime AND A.CreatedBy=B.CreatedBy AND A.SourceAdded= B.SourceAdded AND A.Customername= B.Customername                                  
 --AND A.Extension=B.Extension AND A.CustomerID=B.CustomerID AND A.Location = B.Location AND A.Duration=B.Duration )                                
                                                
                                                
 UPDATE ARC_Ar_fileimportstatus set importstatus = 3,ErrorDescription='imported' Where customerid = @CustomerId and Identityno = @sessionid                                
                                                 
  TRUNCATE TABLE Callrecording_TATA_importtable;                 
 set @NoramlImportCount=(select COUNT ('a') from #TempData)                              
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData                                   
                                 
 select @importstatus=CONVERT(varchar(10), isnull(@Totalflatfilerows,0))+','+CONVERT(varchar(10),isnull(@NoramlImportCount,0))+                                 
 ','+CONVERT(varchar(10),isnull(@MultiTouchImportCount,0))+','+CONVERT(varchar(10),isnull(@Duplicate,0))                                 
 +','+CONVERT(varchar(10),isnull(@MultiDuplicate,0))+','+CONVERT(varchar(10),isnull(@PurgeCount,0))+                                 
 +','+CONVERT(varchar(10),isnull(@MultiPurgeCount,0))                                 
                                  
END 
GO
/****** Object:  StoredProcedure [dbo].[Callrecording_TCN_autoimport]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Callrecording_TCN_autoimport](  
@filepath varchar(1000)=null,  
@Customerid int=0,  
@Customername varchar(250)=null,  
@Format varchar(20)=null,  
@Table varchar(300)=null,  
@result varchar(750)=null OUTPUT)  
as  
begin  
  
  
if not exists(select FI.FilePath from ARC_AR_Fileformat FF   
left join ARC_Ar_fileimportstatus FI on FI.Customerid=FF.CustomerId  
 where FI.importstatus=3 and FF.Status=1 and  FF.CustomerId=@Customerid  and FI.FilePath=@filepath)  
begin  
  --truncate table Callrecording_TCN_importtable   
  select @result='File imported sucessfuly'  
end  
 else  
begin  
  --truncate table Callrecording_TCN_importtable  
  select @result='File name already exist.if you want import same file please change file name from folder'  
end  
end  

GO
/****** Object:  StoredProcedure [dbo].[Callrecording_TCN_import]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Callrecording_TCN_import]              
(                            
 @Format varchar(5000)=null,                            
 @locationid int =1 ,                             
 @CustomerId  int=0,                             
 @sessionid VARCHAR(50)=null,                            
 @USERID INT=1,                            
 @importstatus varchar(max)=null OUTPUT )                            
AS                            
BEGIN                            
 declare @PurgeCount int=0,@Duplicate int = 0,@FileType int = 1,                             
 @MultiPurgeCount int=0,@MultiDuplicate int = 0 ,                             
 @NoramlImportCount int=0,@MultiTouchImportCount int=0,@Totalflatfilerows int=0,@Exstions varchar(max)=null,@Minutes int=0,@TTime varchar(100)='';                           
                          
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData                             
 create table #TempData(CallInitiatedTime datetime,CallEndTime datetime,CreatedBy varchar(250),SourceAdded varchar(250),CustomerName varchar(250),CreatedDate datetime,                          
 Extension varchar(250),CustomerID int,SubProvisionId int,            
 Location varchar(250),Duration int,PhoneNumber varchar(520),            
 CallDisposition varchar(max),UniqueID varchar(500),RecordingUrl varchar(2000),CallDirections varchar(500))                          
             
 delete Callrecording_TCN_importtable where isnull(CALLID,'')=''            
 UPDATE Callrecording_TCN_importtable set CALLENDTIME=CAST(CALLTIME AS datetime) + CAST(CONVERT(time,AGENTCALLTALKDURATION) AS datetime)            
            
          
  UPDATE CR set cr.CALLTIME=dateadd (minute,  TZ.IST_Minutes ,  CR.CALLTIME),cr.CALLENDTIME=dateadd (minute,  TZ.IST_Minutes ,  CR.CALLENDTIME)           
  FROM Callrecording_TCN_importtable CR          
  inner join EXTR_ARC_AR_V1.dbo.ARC_AR_TimeZoneConverter TZ on CR.CALLTIME between TZ.StartDate and TZ.EndDate           
    
      
              
          
 insert into CALLRECORDING_TCN_ImportData(CALLID,CALLTYPE,CALLTIME,            
 TASKGROUPNAME,CLIENTNAME,AGENTUSERNAME,AGENTCALLHUNTGROUPNAME,            
 RESULT,CUSTOMERPHONENUMBER,AGENTCALLRESPONSETEXTCLAIMID,            
 AGENTCALLTALKDURATION,CALLRECORDINGLINK,CreatedDate)            
            
 select  CALLID,CALLTYPE,CALLTIME,            
 TASKGROUPNAME,CLIENTNAME,AGENTUSERNAME,AGENTCALLHUNTGROUPNAME,            
 RESULT,CUSTOMERPHONENUMBER,AGENTCALLRESPONSETEXTCLAIMID,            
 AGENTCALLTALKDURATION,CALLRECORDINGLINK,getdate()             
 from   Callrecording_TCN_importtable            
            
--BEGIN TRY                          
-- BEGIN TRANSACTION              
 set @Totalflatfilerows=(select COUNT ('a') from  Callrecording_TCN_importtable)                          
             
 If OBJECT_ID('tempdb..#ExtensionmappedtData') is not null DROP TABLE #ExtensionmappedtData                            
 create table #ExtensionmappedtData(Extension varchar(20))                          
                                          
    if exists (select top 1 * from Callrecording_TCN_importtable)                          
    begin                          
  If OBJECT_ID('tempdb..#tempmaxusercustomer') is not null DROP TABLE #tempmaxusercustomer                             
  create table #tempmaxusercustomer(nt_username varchar(100), Userid int, CustomerId int, SubprovisionId int)                          
                              
         
                          
    insert into #tempmaxusercustomer                          
 select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                                   
    FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                        
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_UserProfileMapping (nolock) UPM on UPM.UserID=UIF.USERID and UPM.Status=1                                 
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ProfileMaster (nolock) PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                                  
    inner join EXTR_ARC_AR_V1.dbo.Arc_Ar_ClientMaster_InternalExternal_View (nolock) CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                    
    inner join ARC_REC..ARC_REC_usercustomer (nolock) UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                                  
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID           
                  
                          
  insert into #tempmaxusercustomer                          
         
  select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                                   
    FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                                   
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_UserProfileMapping  UPM on UPM.UserID=UIF.USERID and UPM.Status=1                                  
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                                  
    inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ClientMaster_View  CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                    
    inner join ARC_REC..ARC_REC_usercustomer  UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                                  
    group by  UIF.nt_username,UIF.UserId,CV.CustomerID                   
                          
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,            
  CreatedDate,Extension,CustomerID,SubProvisionId,Location,Duration,            
  PhoneNumber,CallDisposition,UniqueID,RecordingUrl,CallDirections)              
                          
  select  CI.CALLTIME CallInitiatedTime,CALLENDTIME,UIF.NT_USERNAME CreatedBy,                          
  'TCN' SourceAdded ,GETDATE()CreatedDate,AGENTUSERNAME Extension,UIF.CustomerID,            
  UIF.SubProvisionId,'USA',datediff(second,0,(CONVERT(time,CI.AGENTCALLTALKDURATION))) as duration,            
  CUSTOMERPHONENUMBER as PhoneNumber,RESULT as CallDisposition,            
  CALLID as  UniqueID,CALLRECORDINGLINK as RecordingUrl,CALLTYPE                           
  FROM Callrecording_TCN_importtable (nolock) CI                            
  inner join #tempmaxusercustomer UIF on CI.AGENTUSERNAME=UIF.NT_USERNAME                                  
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CI.CallEndTime)=D.Date                                   
    inner join Echoc3Analytics.[dbo].FactAttendance  A on UIF.USERID=A.UserId and A.PrimaryClientId=UIF.CustomerID and D.DateKey=A.DateKey            
        
           
                       
                              
  /*Missing users mapping with Rec db*/                          
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,            
  SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,            
  Location,Duration,PhoneNumber,CallDisposition,UniqueID,            
  RecordingUrl,CallDirections)                          
              
  select  CI.CALLTIME CallInitiatedTime,CALLENDTIME,UIF.NT_USERNAME CreatedBy,                          
  'TCN' SourceAdded ,GETDATE()CreatedDate,AGENTUSERNAME Extension,A.PrimaryClientId,            
  0 as SubProvisionId,'USA',datediff(second,0,(CONVERT(time,CI.AGENTCALLTALKDURATION))) as duration,            
  CUSTOMERPHONENUMBER as PhoneNumber,RESULT as CallDisposition,            
  CALLID as  UniqueID,CALLRECORDINGLINK as RecordingUrl,CALLTYPE                          
  FROM Callrecording_TCN_importtable (nolock) CI                            
  inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.AGENTUSERNAME=UIF.NT_USERNAME             
        
   inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,CI.CallEndTime)=D.Date                                   
    inner join Echoc3Analytics.[dbo].FactAttendance   A on UIF.USERID=A.UserId and D.DateKey=A.DateKey               
    where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp  WHERE temp.CreatedBy = CI.AGENTUSERNAME      and temp.UniqueID = cI.CALLID)             
              
               
  /*Missing users mapping with Rec db*/                          
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,            
  SourceAdded,CreatedDate,Extension,CustomerID,SubProvisionId,            
 Location,Duration,PhoneNumber,CallDisposition,UniqueID,RecordingUrl,CallDirections)                          
              
  select  CI.CALLTIME CallInitiatedTime,CALLENDTIME,UIF.NT_USERNAME CreatedBy,                          
  'TCN' SourceAdded ,GETDATE()CreatedDate,AGENTUSERNAME Extension,A.PrimaryClientId,            
  0 as SubProvisionId,'USA',datediff(second,0,(CONVERT(time,CI.AGENTCALLTALKDURATION))) as duration,            
  CUSTOMERPHONENUMBER as PhoneNumber,RESULT as CallDisposition,            
  CALLID as  UniqueID,CALLRECORDINGLINK as RecordingUrl,CALLTYPE                          
  FROM Callrecording_TCN_importtable (nolock) CI                             
     inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on CI.AGENTUSERNAME=UIF.NT_USERNAME                                  
    inner join Echoc3Analytics.dbo.DimDate (nolock) D on convert(date,dateAdd(d, -1, CI.CallEndTime))=D.Date                                   
    inner join Echoc3Analytics.[dbo].FactAttendance   A on UIF.USERID=A.UserId and D.DateKey=A.DateKey                             
  where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp  WHERE  temp.CreatedBy = CI.AGENTUSERNAME            
   and temp.UniqueID = cI.CALLID)                             
      
       
                          
 end             
 /*insert records*/                         
  INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,            
  CreatedBy,SourceAdded,Customername,Extension,CustomerID,Location,            
  Duration,Createddate,PhoneNumber,CallDisposition,Uniqueid,            
  RecordingURL,SubProvisionId,CallDirections,CallDate)                            
              
  SELECT A.CallInitiatedTime,A.CallEndTime,A.CreatedBy,A.SourceAdded,            
  A.Customername,A.Extension,A.CustomerID,A.Location,A.Duration,            
  A.CreatedDate,A.PhoneNumber,A.CallDisposition,a.UniqueID,            
  A.RecordingUrl,A.SubProvisionId,A.CallDirections, Convert(date,DATEADD(n,-630,A.CallInitiatedTime))                  
  FROM #TempData A WHERE                             
  NOT EXISTS (                            
  SELECT 'A' FROM ARC_AR_Callrecoding (nolock)B               
  WHERE A.CallInitiatedTime=B.CallInitiatedTime AND                             
  A.CallEndTime=B.CallEndTime AND A.CreatedBy=B.CreatedBy             
  AND A.SourceAdded= B.SourceAdded               
  and A.UniqueID=b.Uniqueid)                       
               
 /*Insert unmatched records*/            
  INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,            
  CreatedBy,SourceAdded,Extension,CustomerID,Location,            
  Duration,Createddate,PhoneNumber,CallDisposition,Uniqueid,            
  RecordingURL, SubProvisionId,CallDirections,CallDate)                             
              
 select  CI.CALLTIME,CALLENDTIME,AGENTUSERNAME CreatedBy,                          
 'TCN' SourceAdded,AGENTUSERNAME Extension,0 CustomerID,            
 'USA',datediff(second,0,(CONVERT(time,CI.AGENTCALLTALKDURATION))) as duration,            
 Getdate(),CUSTOMERPHONENUMBER as PhoneNumber,RESULT as CallDisposition,            
 CALLID as  UniqueID,CALLRECORDINGLINK as RecordingUrl,0 as SubProvisionId,CI.CALLTYPE ,        
  Convert(date,DATEADD(n,-630,CALLTIME))             
 from Callrecording_TCN_importtable  CI               
 where   NOT EXISTS (SELECT UniqueID  FROM   #TempData temp             
 WHERE  temp.UniqueID = CI.CALLID)                
 and CALLID not in(select uniqueid from  ARC_AR_Callrecoding)            
              
              
  UPDATE CD set cd.CustomerID=td.CustomerID,            
  cd.SubProvisionId=td.SubProvisionId              
  from #TempData td             
  inner join ARC_AR_Callrecoding             
  cd on cd.CreatedBy=td.CreatedBy              
  where cd.CustomerID=0 and Cd.SourceAdded='TCN'            
             
  insert into ARC_AR_FloorProductionCalldata(Ntusername,Customerid,SubProvisionId,CallintialtedDate,Vendor,Createddate,CallDuration)                            
  SELECT A.CreatedBy,A.CustomerId,A.SubProvisionId,A.CallInitiatedTime,A.SourceAdded,            
  A.CreatedDate,A.Duration FROM #TempData A WHERE NOT EXISTS (                            
  SELECT 'A' FROM ARC_AR_FloorProductionCalldata (nolock) B                             
  WHERE  A.CreatedBy=B.Ntusername AND A.Customerid=B.Customerid            
  AND A.SubProvisionId=B.SubProvisionId AND A.CallInitiatedTime=B.CallintialtedDate            
  AND A.SourceAdded =B.Vendor )                            
                           
       set @NoramlImportCount=(select COUNT ('a') from #TempData)                          
   If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData             
            
-- COMMIT TRANSACTION                          
--END TRY                          
--BEGIN CATCH                         
--IF(@@TRANCOUNT > 0)                        
-- ROLLBACK TRANSACTION                          
--END CATCH              
                           
 UPDATE ARC_Ar_fileimportstatus set importstatus = 3,ErrorDescription='imported' Where customerid = @CustomerId and Identityno = @sessionid                            
 TRUNCATE TABLE Callrecording_TCN_importtable;                          
 select @importstatus=CONVERT(varchar(10), isnull(@Totalflatfilerows,0))+','+CONVERT(varchar(10),isnull(@NoramlImportCount,0))+                             
 ','+CONVERT(varchar(10),isnull(@MultiTouchImportCount,0))+','+CONVERT(varchar(10),isnull(@Duplicate,0))                             
 +','+CONVERT(varchar(10),isnull(@MultiDuplicate,0))+','+CONVERT(varchar(10),isnull(@PurgeCount,0))+                             
 +','+CONVERT(varchar(10),isnull(@MultiPurgeCount,0))                             
                              
END               
              
              
  
GO
/****** Object:  StoredProcedure [dbo].[Callrecording_VIVA_autoimport]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Callrecording_VIVA_autoimport](
@filepath varchar(1000)=null,
@Customerid int=0,
@Customername varchar(250)=null,
@Format varchar(20)=null,
@Table varchar(300)=null,
@result varchar(750)=null OUTPUT)
as
begin


if not exists(select FI.FilePath from ARC_AR_Fileformat FF left join ARC_Ar_fileimportstatus FI on FI.Customerid=FF.CustomerId
	where FI.importstatus=3 and FF.Status=1 and  FF.CustomerId=@Customerid 	and FI.FilePath=@filepath)
begin
		truncate table Callrecording_VIVA_importtable 
		select @result='File imported sucessfuly'
end
 else
begin
		truncate table Callrecording_VIVA_importtable
		select @result='File name already exist.if you want import same file please change file name from folder'
end
end


GO
/****** Object:  StoredProcedure [dbo].[Callrecording_VIVA_import]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Callrecording_VIVA_import]      
(        
 @Format varchar(5000)=null,        
 @locationid int =1 ,         
 @CustomerId  int=1006,         
 @sessionid VARCHAR(50)=null,        
 @USERID INT=1777,        
 @importstatus varchar(max)=null OUTPUT )        
AS        
        
BEGIN        
       
    
 declare @PurgeCount int=0,@Duplicate int = 0,@FileType int = 1,         
 @MultiPurgeCount int=0,@MultiDuplicate int = 0 ,         
 @NoramlImportCount int=0,@MultiTouchImportCount int=0,@Totalflatfilerows int=0,@Exstions varchar(max)=null;         
        
   UPDATE Callrecording_VIVA_importtable SET [DESCRIPTION]=REPLACE([DESCRIPTION],'"','')        
   UPDATE Callrecording_VIVA_importtable SET [CONNECTTIME]=REPLACE(isnull([CONNECTTIME],''),'"','')   
   UPDATE Callrecording_VIVA_importtable SET [DISCONNECTTIME]=REPLACE(isnull([DISCONNECTTIME],''),'"','')        
                      
      
  UPDATE CR set cr.[CONNECTTIME]=dateadd (minute, TZ.IST_Minutes,CR.[CONNECTTIME]),  
  cr.[DISCONNECTTIME]=dateadd (minute, TZ.IST_Minutes,CR.[DISCONNECTTIME])  
  FROM Callrecording_VIVA_importtable CR      
  inner join  EXTR_ARC_AR_V1.dbo.ARC_AR_TimeZoneConverter TZ  
   on CR.[CONNECTTIME] between TZ.StartDate and TZ.EndDate       
         
      
 set @Totalflatfilerows=(select COUNT ('a') from  Callrecording_VIVA_importtable)      
      
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData                       
   create table #TempData(CallInitiatedTime datetime,CallEndTime datetime,CreatedBy varchar(2500),SourceAdded varchar(2500),CustomerName varchar(2500),      
   CreatedDate datetime,Extension varchar(2000),CustomerID int,SubProvisionId int,Location varchar(250),Duration int,PhoneNumber varchar(200),      
   CallDisposition varchar(max),CLAIMID varchar(500),UniqueID varchar(500),Result varchar(max),CALLDIRECTION varchar(max))         
 If OBJECT_ID('tempdb..#ExtensionmappedtData') is not null DROP TABLE #ExtensionmappedtData                      
 create table #ExtensionmappedtData(Extension varchar(200))                    
 If OBJECT_ID('tempdb..#tempmaxusercustomer') is not null DROP TABLE #tempmaxusercustomer                                   
    create table #tempmaxusercustomer(nt_username varchar(100), Userid int, CustomerId int, SubprovisionId int)       
          
--BEGIN TRY                                
-- BEGIN TRANSACTION        
      
 if  (@Totalflatfilerows>0)      
 begin      
  insert into #tempmaxusercustomer                        
  select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                                 
  FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                                 
  inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_UserProfileMapping (nolock) UPM on UPM.UserID=UIF.USERID and UPM.Status=1                                
  inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_ProfileMaster (nolock) PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                                
  inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_ClientMaster_InternalExternal_View (nolock) CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                  
  inner join ARC_REC..ARC_REC_usercustomer (nolock) UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                                
  group by  UIF.nt_username,UIF.UserId,CV.CustomerID                     
        
  insert into #tempmaxusercustomer                                
  select  UIF.nt_username,UIF.UserId,CV.CustomerID,max(CV.SubProvisionId)as SubProvisionId                                 
  FROM  ARC_REC..ARC_REC_USER_INFO (nolock) UIF                                 
  inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_UserProfileMapping  UPM on UPM.UserID=UIF.USERID and UPM.Status=1                                
  inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1                                
  inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ClientMaster_View  CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId                                  
  inner join ARC_REC..ARC_REC_usercustomer  UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId                                
  group by  UIF.nt_username,UIF.UserId,CV.CustomerID       
      
      
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CustomerName,CreatedDate,      
   Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition)      
      
   select CONVERT(datetime, CI.[CONNECTTIME]) CallInitiatedTime,CONVERT(datetime, CI.[DISCONNECTTIME])CallEndTime,UI.NT_USERNAME CreatedBy,      
   'VIVA' SourceAdded ,CV.CustomerName,GETDATE()CreatedDate,ACCOUNT as Extension,CV.CustomerID,CV.SubProvisionId,CI.[COUNTRY] Location,        
    DATEDIFF(SECOND, convert(datetime,CI.CONNECTTIME), CAST(CI.DISCONNECTTIME AS datetime)) as Duration,  
  [TO] as PhoneNumber,[DESCRIPTION]as CallDisposition        
   FROM Callrecording_VIVA_importtable  CI        
   inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_UserProfileMapping UPM on CI.ACCOUNT=UPM.VoiceMailId and UPM.Status=1        
   inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1      
   inner join  EXTR_ARC_AR_V1.dbo.Arc_Ar_ClientMaster_View CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId        
   inner join ARC_REC..ARC_REC_USER_INFO UI on UPM.UserID=UI.USERID        
   inner join ARC_REC..ARC_REC_usercustomer UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId      
        
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CustomerName,CreatedDate,      
   Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition)      
      
   select CONVERT(datetime, CI.[CONNECTTIME]) CallInitiatedTime,CONVERT(datetime,CI.[DISCONNECTTIME])CallEndTime,UI.NT_USERNAME CreatedBy,      
   'VIVA' SourceAdded ,CV.CustomerName,GETDATE()CreatedDate,ACCOUNT as Extension,CV.CustomerID,CV.SubProvisionId,CI.[COUNTRY] Location,        
   DATEDIFF(SECOND, convert(datetime,CI.CONNECTTIME), CAST(CI.DISCONNECTTIME AS datetime)) as Duration,      
   [TO] as PhoneNumber,[DESCRIPTION]as CallDisposition        
   FROM Callrecording_VIVA_importtable  CI        
   inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_UserProfileMapping UPM on CI.ACCOUNT=UPM.VoiceMailId and UPM.Status=1        
   inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ProfileMaster PM on PM.ProfileId=UPM.ProfileId  and PM.Status=1      
   inner join [LNKOFFLINE].[ARC_AR_ATHENA].dbo.Arc_Ar_ClientMaster_View CV on CV.CustomerID=PM.CustomerId and PM.SubProvisionId=CV.SubProvisionId        
   inner join ARC_REC..ARC_REC_USER_INFO UI on UPM.UserID=UI.USERID        
   inner join ARC_REC..ARC_REC_usercustomer UC on UC.UserId=UPM.UserID and UC.CustomerID=PM.CustomerId      
        
  insert into #TempData(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,CreatedDate,                  
  Extension,CustomerID,SubProvisionId,Location,Duration,PhoneNumber,CallDisposition)                                
  select CONVERT(datetime, CI.[CONNECTTIME]) CallInitiatedTime,CONVERT(datetime,CI.[DISCONNECTTIME])CallEndTime      
  ,UIF.NT_USERNAME CreatedBy,'VIVA' SourceAdded ,GETDATE()CreatedDate,ACCOUNT as Extension,AE.CustomerId,AE.SubprovisionId,'USA',                                  
   DATEDIFF(SECOND, convert(datetime,CI.CONNECTTIME), CAST(CI.DISCONNECTTIME AS datetime)) as Duration,  
   [TO] as PhoneNumber,[DESCRIPTION]as CallDisposition                                           
   FROM Callrecording_VIVA_importtable (nolock) CI             
   inner join EXTR_ARC_AR_V1.dbo.ARC_AR_AssociateExtnDetails  AE on AE.ExtNo=CI.ACCOUNT  and convert(date,CI.[CONNECTTIME])=CONVERT(date,AE.CreatedDate)                         
   inner join ARC_REC.dbo.ARC_REC_USER_INFO UIF on AE.UserId=UIF.USERID                                
   where   NOT EXISTS (SELECT CreatedBy  FROM   #TempData temp                      
   WHERE  temp.CreatedBy = UIF.NT_USERNAME)       
           
  insert into Callrecording_VIVA_importdata(ACCOUNT,[FROM],[TO],COUNTRY,[DESCRIPTION],      
  CONNECTTIME,DISCONNECTTIME,CHARGEDTIMEHOURMINSEC)      
  SELECT ACCOUNT,[FROM],[TO],COUNTRY,[DESCRIPTION],CONNECTTIME,DISCONNECTTIME,CHARGEDTIMEHOURMINSEC      
  FROM Callrecording_VIVA_importtable A where not exists(SELECT 'A' FROM #TempData B WHERE A.ACCOUNT=B.Extension)      
        
  UPDATE CD set cd.CallInitiatedTime=td.CallInitiatedTime, cd.CallEndTime=TD.CallEndTime,      
   CD.Duration=TD.Duration ,cd.SubProvisionId=td.SubProvisionId                        
   from #TempData td                     
   inner join ARC_AR_Callrecoding cd on cd.CreatedBy=td.CreatedBy                        
   where   cd.SourceAdded='VIVA'        
        
  INSERT INTO ARC_AR_Callrecoding(CallInitiatedTime,CallEndTime,CreatedBy,SourceAdded,Customername,Extension,      
  CustomerID,Location,Duration,Createddate,PhoneNumber,CallDisposition,CallDate)        
        
   SELECT A.CallInitiatedTime,A.CallEndTime,A.CreatedBy,A.SourceAdded,A.Customername,A.Extension,      
   A.CustomerID,A.Location,A.Duration,A.CreatedDate,A.PhoneNumber,A.CallDisposition, Convert(date,DATEADD(n,-630,A.CallInitiatedTime))        
   FROM #TempData A WHERE NOT EXISTS (        
   SELECT 'A' FROM ARC_AR_Callrecoding B WHERE A.CallInitiatedTime=B.CallInitiatedTime AND         
   A.CallEndTime=B.CallEndTime AND A.CreatedBy=B.CreatedBy AND A.SourceAdded= B.SourceAdded       
   AND A.Customername= B.Customername AND A.Extension=B.Extension AND A.CustomerID=B.CustomerID       
   AND A.Location = B.Location AND A.Duration=B.Duration )        
        
  UPDATE ARC_Ar_fileimportstatus set importstatus = 3,ErrorDescription='imported' Where customerid = @CustomerId and Identityno = @sessionid        
        
  set @NoramlImportCount=(select COUNT ('a') from #TempData)      
        
         
        
  insert into ARC_AR_FloorProductionCalldata(Ntusername,Customerid,SubProvisionId,CallintialtedDate,Vendor,Createddate,CallDuration)                    
 SELECT A.CreatedBy,A.CustomerId,A.SubProvisionId,A.CallInitiatedTime,A.SourceAdded,A.CreatedDate,A.Duration FROM #TempData A WHERE NOT EXISTS (                                  
 SELECT 'A' FROM ARC_AR_FloorProductionCalldata (nolock) B                                   
 WHERE  A.CreatedBy=B.Ntusername AND A.Customerid=B.Customerid  AND A.SubProvisionId=B.SubProvisionId AND A.CallInitiatedTime=B.CallintialtedDate AND A.SourceAdded =B.Vendor )                     
     
 If OBJECT_ID('tempdb..#TempData') is not null DROP TABLE #TempData     
 end                     
--COMMIT TRANSACTION                                
--END TRY                    
-- BEGIN CATCH                               
-- IF(@@TRANCOUNT > 0)                              
--  ROLLBACK TRANSACTION                                
-- END CATCH           
  -- TRUNCATE TABLE Callrecording_VIVA_importtable;        
  select @importstatus=CONVERT(varchar(10), isnull(@Totalflatfilerows,0))+','+CONVERT(varchar(10),isnull(@NoramlImportCount,0))+       
  ','+CONVERT(varchar(10),isnull(@MultiTouchImportCount,0))+','+CONVERT(varchar(10),isnull(@Duplicate,0))         
  +','+CONVERT(varchar(10),isnull(@MultiDuplicate,0))+','+CONVERT(varchar(10),isnull(@PurgeCount,0))+         
  +','+CONVERT(varchar(10),isnull(@MultiPurgeCount,0))         
          
END       
      
    
  
  
GO
/****** Object:  StoredProcedure [dbo].[CDR_RingCentral_CoverageSendMail]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[CDR_RingCentral_CoverageSendMail]    
As    
Begin    
Set nocount on;  
 Declare @PreviousDate date=convert(date, dateAdd(d, -1, getdate()))    
    
 IF OBJECT_ID('tempdb..#CDRDataUsers') is not null drop table #CDRDataUsers    
 IF OBJECT_ID('tempdb..#V1DataUsers') is not null drop table #V1DataUsers    
 IF OBJECT_ID('tempdb..#V2DataUsers') is not null drop table #V2DataUsers    
 IF OBJECT_ID('tempdb..#HeadCount') is not null drop table #HeadCount    
 IF OBJECT_ID('tempdb..#FinalReport') is not null drop table #FinalReport    
    
 select ClientInternalName, count(distinct CreatedBy) TotalUsers, count(1) TotalCalls into #CDRDataUsers    
 from ARC_AR_Callrecoding a inner join Echoc3Analytics..DimClient c on a.customerid=c.clientid     
 where calldate=@PreviousDate and SourceAdded='RingCentral' and a.createdby is not null and a.CallEndTime is not null     
 group by ClientInternalName     
    
 select ClientInternalName, count(distinct CreatedBy) V1Users, count(1) TotalCalls into #V1DataUsers    
 from ARC_AR_Callrecoding a inner join Echoc3Analytics..DimClient c on a.customerid=c.clientid     
 where calldate=@PreviousDate and SourceAdded='RingCentral' and isAPI=1 and a.createdby is not null and a.CallEndTime is not null         
 group by ClientInternalName    
    
 select ClientInternalName, count(distinct userid) V2Users, count(distinct CallerIdInfo) TotalCalls into #V2DataUsers      
 from EXTR_ARC_AR_V1.dbo.Arc_Ar_InboxClaimsCallerIdDetails a 
 inner join Echoc3Analytics..DimClient c on a.customerid=c.clientid 
 inner join EXTR_ARC_AR_V1.dbo.ARC_AR_ClientMaster CM on cm.CustomerID=a.customerid and cm.Status=1     
 where a.CreatedDate>=dateAdd(n, 720, convert(datetime,@PreviousDate)) and a.CreatedDate<dateAdd(d, 1,dateAdd(n, 720, convert(datetime,@PreviousDate)))      
 group by ClientInternalName   
 
 insert into #V2DataUsers
 select ClientInternalName, count(distinct userid) V2Users, count(distinct CallerIdInfo) TotalCalls       
 from [dotflowlistner].ARC_AR_V1.dbo.Arc_Ar_InboxClaimsCallerIdDetails a 
 inner join Echoc3Analytics..DimClient c on a.customerid=c.clientid 
 inner join [dotflowlistner].ARC_AR_V1.dbo.ARC_AR_ClientMaster CM on cm.CustomerID=a.customerid and cm.Status=1     
 where a.CreatedDate>=dateAdd(n, 720, convert(datetime,@PreviousDate)) and a.CreatedDate<dateAdd(d, 1,dateAdd(n, 720, convert(datetime,@PreviousDate)))      
 group by ClientInternalName    
     
    
 select client_name, count(1) as total into #HeadCount    
 from Echoc3Analytics.dbo.ARC_REC_User_info_vy where Lob='AR' and d_band=1    
 group by client_name    
    
 select a.ClientInternalName Customer, b.total HeadCount,     
 a.TotalUsers CDRUsers, a.TotalCalls CDRCalls,    
 cast(case when b.total=0 then 0 else a.TotalUsers/(b.total*1.0)*100 end as decimal(10,2)) as RCoverage,        
 isnull(c.V1Users,0) V1Users, isnull(c.totalCalls,0) V1Calls,     
 cast(case when isnull(a.TotalUsers,0)=0 then 0 else isnull(c.V1Users,0)/(a.TotalUsers*1.0)*100 end as decimal(10,2)) as V1Usage,    
 isnull(d.V2Users,0) V2Users, isnull(d.totalCalls,0) V2Calls,      
 cast(case when isnull(a.TotalUsers,0)=0 then 0 else isnull(d.V2Users,0)/(a.TotalUsers*1.0)*100 end as decimal(10,2)) as V2Usage into #FinalReport    
 from #CDRDataUsers a inner join #HeadCount b on a.ClientInternalName=b.client_name    
 Left Join #V1DataUsers c on c.ClientInternalName=a.ClientInternalName    
 Left Join #V2DataUsers d on d.ClientInternalName=a.ClientInternalName     
 union ALL    
 select 'Total' Customer, sum(b.total) HeadCount, sum(a.TotalUsers) CDRUsers, sum(a.TotalCalls) CDRCalls,    
 cast(case when sum(b.total)=0 then 0 else sum(a.TotalUsers)/(sum(b.total)*1.0)*100 end as decimal(10,2)) as RCoverage,        
 sum(isnull(c.V1Users,0)) V1Users, sum(isnull(c.totalCalls,0)) V1Calls,     
 cast(case when sum(a.TotalUsers)=0 then 0 else sum(c.V1Users)/(sum(a.TotalUsers)*1.0)*100 end as decimal(10,2)) as V1Usage,    
 sum(isnull(d.V2Users,0)) V2Users, sum(isnull(d.totalCalls,0)) V2Calls,    
 cast(case when sum(a.TotalUsers)=0 then 0 else sum(d.V2Users)/(sum(a.TotalUsers)*1.0)*100 end as decimal(10,2)) as V2Usage       
 from #CDRDataUsers a inner join #HeadCount b on a.ClientInternalName=b.client_name    
 Left Join #V1DataUsers c on c.ClientInternalName=a.ClientInternalName    
 Left Join #V2DataUsers d on d.ClientInternalName=a.ClientInternalName    
    
 if exists (select top 1 * from #FinalReport)    
 begin    
   Declare @Records varchar(max)=''    
   set @Records= '<table cellpading="0" cellspacing="0" border ="1" style="font-family: verdana; font-size: 12px">    
   <tr align="Center" bgcolor="#9A9DDE">    
   <td RowSpan="2"><B>Customer</B></td><td RowSpan="2"><B>Head Count</B></td>    
   <td colspan="3"><B>As per Ring Central CDR Data</B></td>    
   <td colspan="3"><B>V1</B></td>    
<td colspan="3"><B>V2</B></td>    
   </tr>    
   <tr align="Center" bgcolor="#9A9DDE">    
   <td><B>Total Users</B></td><td><B>Total Calls</B></td><td><B>Coverage %</B></td>     <td><B>Total Users</B></td><td><B>Total Calls</B></td><td><B>Usage %</B></td>    
   <td><B>Total Users</B></td><td><B>Total Calls</B></td><td><B>Usage %</B></td>    
   </tr>'    
    
       
   Select @Records=@Records+'<tr align="Center"><td>'+Customer+'</td><td>'+convert(varchar,HeadCount)+'</td><td>'+convert(varchar,CDRUsers)+'</td><td>'+convert(varchar,CDRCalls)+'</td><td align="right">'+convert(varchar,RCoverage)+'</td>    
   <td>'+convert(varchar,V1Users)+'</td><td>'+convert(varchar,V1Calls)+'</td><td align="right">'+convert(varchar,V1Usage)+'</td><td>'+convert(varchar,V2Users)+'</td><td>'+convert(varchar,V2Calls)+'</td><td align="right">'+convert(varchar,V2Usage)+'</td></
tr>' from #FinalReport where Customer<>'Total'    
       
   Select @Records=@Records+'<tr align="Center" bgcolor="#9A9DDE"><td><b>'+Customer+'</b></td><td><b>'+convert(varchar,HeadCount)+'</b></td><td><b>'+convert(varchar,CDRUsers)+'</b></td><td><b>'+convert(varchar,CDRCalls)+'</b></td><td align="right"><b>'+convert(varchar,RCoverage)+'</b></td>    
   <td><b>'+convert(varchar,V1Users)+'</b></td><td><b>'+convert(varchar,V1Calls)+'</b></td><td align="right"><b>'+convert(varchar,V1Usage)+'</b></td><td><b>'+convert(varchar,V2Users)+'</b></td><td><b>'+convert(varchar,V2Calls)+'</b></td><td align="right"><b>'+convert(varchar,V2Usage)+'</b></td></tr>' from #FinalReport where Customer='Total'     
    
   set @Records=@Records+'</table>'    
    
        
   INSERT INTO EXTR_ARC_AR_V1.dbo.ARC_REC_MAIL_TRAN(FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,ISHTML,CC,MAIL_STATUS,Active)    
   select 'mail.support@accesshealthcare.co' FROM_MAILID,'sanjeev.britto@accesshealthcare.com; john.anilraj@accesshealthcare.com; mario.joseph@accesshealthcare.com; 
   santhosh.jose@accesshealthcare.com; sushma.lawrence@accesshealthcare.com; vimaladhitha.na@accesshealthcare.com','RingCentral Coverage/Usage report',    
   '<HTML><HEAD></HEAD><BODY style="font-family: verdana; font-size: 12px"><div >Hi Team,<br /><p>Please find the RingCentral Coverage/Usage report for '+convert(varchar,@PreviousDate,101)+'</p> '+@Records+'    
   <br />Thanks,<br />arc.flow team.<br /><img src="https://www.accesshealthcare.co/appimages/arc_support.png" alt="" width="250px" height="65px" /></p>** This is an auto-generated email.     
   Please do not reply to this email.**<br />    
   Legal Disclaimer: The information contained in this message (including all attachments) may be privileged and confidential. It is intended to be read only by the individual     
   or entity to whom it is addressed or by their designee. If the reader of this message is not the intended recipient, please destroy this message immediately and also     
   please note that you are on notice that any distribution of this message, in any form, is strictly prohibited. If you have received this message in error,     
   please immediately notify the sender and delete or destroy any copy of this message. </BODY></HTML>'as Body,      
   'Y' ISHTML,'prabhakar.m@accesshealthcare.com; satheesh.seetha@accesshealthcare.com; madhavan.gg@accesshealthcare.com; 
   kailashvasan.vk@accesshealthcare.com; saravanakuma.r@accesshealthcare.com; balamudhan.r@accesshealthcare.com;jaffer.s@accesshealthcare.com;
   chandrasekar.g@accesshealthcare.com;sakkaravarth.k@accesshealthcare.com;arunkumar.p@accesshealthcare.com;udhayaganesh.p@accesshealthcare.com' as CC,0,1;    
 end    
  
   
 IF OBJECT_ID('tempdb..#CDRDataUsers') is not null drop table #CDRDataUsers    
 IF OBJECT_ID('tempdb..#V1DataUsers') is not null drop table #V1DataUsers    
 IF OBJECT_ID('tempdb..#V2DataUsers') is not null drop table #V2DataUsers    
 IF OBJECT_ID('tempdb..#HeadCount') is not null drop table #HeadCount    
 IF OBJECT_ID('tempdb..#FinalReport') is not null drop table #FinalReport    
    
end



GO
/****** Object:  StoredProcedure [dbo].[CDR_RingCentral_CoverageSendMail_1]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CDR_RingCentral_CoverageSendMail_1]
As
Begin
Set nocount on;
 Declare @PreviousDate date=convert(date, dateAdd(d, -1, getdate()))
              
 IF OBJECT_ID('tempdb..#CDRDataUsers') is not null drop table #CDRDataUsers              
 IF OBJECT_ID('tempdb..#V1DataUsers') is not null drop table #V1DataUsers              
 IF OBJECT_ID('tempdb..#V2DataUsers') is not null drop table #V2DataUsers              
 IF OBJECT_ID('tempdb..#V1V2DataUsers') is not null drop table #V1V2DataUsers              
 IF OBJECT_ID('tempdb..#HeadCount') is not null drop table #HeadCount              
 IF OBJECT_ID('tempdb..#FinalReport') is not null drop table #FinalReport              
              
 select ClientInternalName, count(distinct CreatedBy) TotalUsers, count(1) TotalCalls into #CDRDataUsers              
 from ARC_AR_Callrecoding a inner join Echoc3Analytics..DimClient c on a.customerid=c.clientid               
 where calldate=@PreviousDate and SourceAdded='RingCentral' and a.createdby is not null and a.CallEndTime is not null               
 and isnull(a.CallDirections,'') not in ('Inbound', 'Internal')    
 group by ClientInternalName               
              
 select ClientInternalName, count(distinct CreatedBy) V1Users, count(1) TotalCalls into #V1DataUsers              
 from ARC_AR_Callrecoding a inner join Echoc3Analytics..DimClient c on a.customerid=c.clientid               
 where calldate=@PreviousDate and SourceAdded='RingCentral' and isAPI=1 and a.createdby is not null and a.CallEndTime is not null                   
 and isnull(a.CallDirections,'') not in ('Inbound', 'Internal')    
 group by ClientInternalName              
              
 select ClientInternalName, count(distinct CreatedBy) V2Users, count(1) TotalCalls into #V2DataUsers              
 from ARC_AR_Callrecoding a inner join Echoc3Analytics..DimClient c on a.customerid=c.clientid               
 where calldate=@PreviousDate and SourceAdded='RingCentral' and isAPI=2 and a.createdby is not null and a.CallEndTime is not null                   
 and isnull(a.CallDirections,'') not in ('Inbound', 'Internal')    
 group by ClientInternalName             
    
 select ClientInternalName, count(distinct CreatedBy) V1V2Users, count(1) TotalCalls into #V1V2DataUsers              
 from ARC_AR_Callrecoding a inner join Echoc3Analytics..DimClient c on a.customerid=c.clientid               
 where calldate=@PreviousDate and SourceAdded='RingCentral' and isAPI>=1 and a.createdby is not null and a.CallEndTime is not null                   
 and isnull(a.CallDirections,'') not in ('Inbound', 'Internal')    
 group by ClientInternalName    
              
 select client_name, count(1) as total into #HeadCount              
 from Echoc3Analytics.dbo.ARC_REC_User_info_vy a inner join C3_UserMaster b on a.nt_username=b.ntusername           
 where d_band=1 and b.isActive=1              
 group by client_name              

 select a.ClientInternalName Customer, b.total HeadCount,               
 a.TotalUsers CDRUsers, a.TotalCalls CDRCalls,              
 cast(case when b.total=0 then 0 else a.TotalUsers/(b.total*1.0)*100 end as decimal(10,2)) as RCoverage,                  
 isnull(c.V1Users,0) V1Users, isnull(c.totalCalls,0) V1Calls,               
 cast(case when isnull(a.TotalUsers,0)=0 then 0 else isnull(c.V1Users,0)/(a.TotalUsers*1.0)*100 end as decimal(10,2)) as V1Usage,              
 isnull(d.V2Users,0) V2Users, isnull(d.totalCalls,0) V2Calls,                
 cast(case when isnull(a.TotalUsers,0)=0 then 0 else isnull(d.V2Users,0)/(a.TotalUsers*1.0)*100 end as decimal(10,2)) as V2Usage,    
 isnull(e.V1V2Users,0) V1V2Users, isnull(e.totalCalls,0) V1V2Calls,                
 cast(case when isnull(a.TotalUsers,0)=0 then 0 else isnull(e.V1V2Users,0)/(a.TotalUsers*1.0)*100 end as decimal(10,2)) as V1V2Usage  into #FinalReport              
 from #CDRDataUsers a inner join #HeadCount b on a.ClientInternalName=b.client_name              
 Left Join #V1DataUsers c on c.ClientInternalName=a.ClientInternalName              
 Left Join #V2DataUsers d on d.ClientInternalName=a.ClientInternalName    
 Left Join #V1V2DataUsers e on e.ClientInternalName=a.ClientInternalName               
 union ALL              
 select 'Total' Customer, sum(b.total) HeadCount, sum(a.TotalUsers) CDRUsers, sum(a.TotalCalls) CDRCalls,              
 cast(case when sum(b.total)=0 then 0 else sum(a.TotalUsers)/(sum(b.total)*1.0)*100 end as decimal(10,2)) as RCoverage,                  
 sum(isnull(c.V1Users,0)) V1Users, sum(isnull(c.totalCalls,0)) V1Calls,               
 cast(case when sum(a.TotalUsers)=0 then 0 else sum(c.V1Users)/(sum(a.TotalUsers)*1.0)*100 end as decimal(10,2)) as V1Usage,              
 sum(isnull(d.V2Users,0)) V2Users, sum(isnull(d.totalCalls,0)) V2Calls,              
 cast(case when sum(a.TotalUsers)=0 then 0 else sum(d.V2Users)/(sum(a.TotalUsers)*1.0)*100 end as decimal(10,2)) as V2Usage,    
 sum(isnull(e.V1V2Users,0)) V1V2Users, sum(isnull(e.totalCalls,0)) V1V2Calls,                
 cast(case when sum(isnull(a.TotalUsers,0))=0 then 0 else sum(isnull(e.V1V2Users,0))/sum(a.TotalUsers*1.0)*100 end as decimal(10,2)) as V1V2Usage      
 from #CDRDataUsers a inner join #HeadCount b on a.ClientInternalName=b.client_name              
 Left Join #V1DataUsers c on c.ClientInternalName=a.ClientInternalName     
 Left Join #V2DataUsers d on d.ClientInternalName=a.ClientInternalName    
 Left Join #V1V2DataUsers e on e.ClientInternalName=a.ClientInternalName              

 if exists (select top 1 * from #FinalReport where Headcount is not null)              
 begin              
   Declare @Records varchar(max)=''              
   set @Records= '<table cellpading="0" cellspacing="0" border ="1" style="font-family: verdana; font-size: 12px">           
   <tr align="Center" bgcolor="#9A9DDE">              
   <td RowSpan="2"><B>Customer</B></td><td RowSpan="2"><B>RC Users</B></td>              
   <td colspan="3"><B>As per Ring Central CDR Data</B></td>              
   <td colspan="3"><B>V1</B></td>              
   <td colspan="3"><B>V2</B></td>    
   <td colspan="3"><B>V1+V2</B></td>              
   </tr>              
   <tr align="Center" bgcolor="#9A9DDE">              
   <td><B>Total Users</B></td><td><B>Total Calls</B></td><td><B>Coverage %</B></td>         
   <td><B>Total Users</B></td><td><B>Total Calls</B></td><td><B>Usage %</B></td>              
   <td><B>Total Users</B></td><td><B>Total Calls</B></td><td><B>Usage %</B></td>    
   <td><B>Total Users</B></td><td><B>Total Calls</B></td><td><B>Usage %</B></td>              
   </tr>'              

   Select @Records=@Records+'<tr align="Center"><td>'+Customer+'</td><td>'+convert(varchar,HeadCount)+'</td>    
   <td>'+convert(varchar,CDRUsers)+'</td><td>'+convert(varchar,CDRCalls)+'</td><td align="right">'+convert(varchar,RCoverage)+'</td>              
   <td>'+convert(varchar,V1Users)+'</td><td>'+convert(varchar,V1Calls)+'</td><td align="right">'+convert(varchar,V1Usage)+'</td><td>'+convert(varchar,V2Users)+'</td><td>'+convert(varchar,V2Calls)+'</td><td align="right">'+convert(varchar,V2Usage)+'</td>
   <td>'+convert(varchar,V1V2Users)+'</td><td>'+convert(varchar,V1V2Calls)+'</td><td align="right">'+convert(varchar,V1V2Usage)+'</td></tr>' from #FinalReport where Customer<>'Total'

   Select @Records=@Records+'<tr align="Center" bgcolor="#9A9DDE"><td><b>'+Customer+'</b></td><td><b>'+convert(varchar,HeadCount)+'</b></td>    
   <td><b>'+convert(varchar,CDRUsers)+'</b></td><td><b>'+convert(varchar,CDRCalls)+'</b></td><td align="right"><b>'+convert(varchar,RCoverage)+'</b></td>          
   <td><b>'+convert(varchar,V1Users)+'</b></td><td><b>'+convert(varchar,V1Calls)+'</b></td><td align="right"><b>'+convert(varchar,V1Usage)+'</b></td>    
   <td><b>'+convert(varchar,V2Users)+'</b></td><td><b>'+convert(varchar,V2Calls)+'</b></td><td align="right"><b>'+convert(varchar,V2Usage)+'</b></td>    
   <td><b>'+convert(varchar,V1V2Users)+'</b></td><td><b>'+convert(varchar,V1V2Calls)+'</b></td><td align="right"><b>'+convert(varchar,V1V2Usage)+'</b></td></tr>' from #FinalReport where Customer='Total'

   set @Records=@Records+'</table>'              

--   INSERT INTO EXTR_ARC_AR_V1.dbo.ARC_REC_MAIL_TRAN(FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,ISHTML,CC,MAIL_STATUS,ACTIVE)          
   select
   'mail.support@accesshealthcare.co' as FROM_MAILID,
   'sanjeev.britto@accesshealthcare.com;john.anilraj@accesshealthcare.com;mario.joseph@accesshealthcare.com;
   santhosh.jose@accesshealthcare.com;sushma.lawrence@accesshealthcare.com;vimaladhitha.na@accesshealthcare.com;
   selvan.swamy@accesshealthcare.com;vikas.gupta2@accesshealthcare.com' as RECIPIENTS,
   'RingCentral Coverage/Usage report' as SUBJECT_TEXT,
   '<HTML><HEAD></HEAD><BODY style="font-family: verdana; font-size: 12px"><div >Hi Team,<br /><p>Please find the RingCentral Coverage/Usage report for '+convert(varchar,@PreviousDate,101)+'</p> '+@Records+'          
   <br />Thanks,<br />arc.flow team.<br /><img src="https://www.accesshealthcare.co/appimages/arc_support.png" alt="" width="250px" height="65px" /></p>** This is an auto-generated email.               
   Please do not reply to this email.**<br />
   Legal Disclaimer: The information contained in this message (including all attachments) may be privileged and confidential. It is intended to be read only by the individual               
   or entity to whom it is addressed or by their designee. If the reader of this message is not the intended recipient, please destroy this message immediately and also               
   please note that you are on notice that any distribution of this message, in any form, is strictly prohibited. If you have received this message in error,               
   please immediately notify the sender and delete or destroy any copy of this message. </BODY></HTML>'as BODY,
   'Y' as ISHTML,
   'prabhakar.m@accesshealthcare.com;satheesh.seetha@accesshealthcare.com;madhavan.gg@accesshealthcare.com;
   kailashvasan.vk@accesshealthcare.com;saravanakuma.r@accesshealthcare.com;balamudhan.r@accesshealthcare.com;
   jaffer.s@accesshealthcare.com;chandrasekar.g@accesshealthcare.com;sakkaravarth.k@accesshealthcare.com;
   arunkumar.p@accesshealthcare.com;udhayaganesh.p@accesshealthcare.com;aaron.gilgal@accesshealthcare.com;
   vijay.g@accesshealthcare.com;saravanan.shanm@accesshealthcare.com;shaju.subramani@accesshealthcare.com;
   dilip.sumra@accesshealthcare.com;pradeepkumar.ra1@accesshealthcare.com;harsan.sp@accesshealthcare.com' as CC,
   0 as MAIL_STATUS,
   1 as ACTIVE;
 end              
            
             
 IF OBJECT_ID('tempdb..#CDRDataUsers') is not null drop table #CDRDataUsers              
 IF OBJECT_ID('tempdb..#V1DataUsers') is not null drop table #V1DataUsers              
 IF OBJECT_ID('tempdb..#V2DataUsers') is not null drop table #V2DataUsers              
 IF OBJECT_ID('tempdb..#V1V2DataUsers') is not null drop table #V1V2DataUsers              
 IF OBJECT_ID('tempdb..#HeadCount') is not null drop table #HeadCount              
 IF OBJECT_ID('tempdb..#FinalReport') is not null drop table #FinalReport              
              
end 

GO
/****** Object:  StoredProcedure [dbo].[CDR_RingCentral_Status]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[CDR_RingCentral_Status]
As
Begin

Declare @PreviousDate date=convert(date, dateAdd(d, -1, getdate()))

select createdby, ISAPI, count(1) as total into #Calls
from ARC_AR_CallRecoding where CreatedBy is not null 
and  calldate=@PreviousDate and sourceAdded='RingCentral'  
group by createdby, ISAPI

select a.*, case when DirectRC=Total then 'Direct RC' 
when V1=Total then 'V1' 
when V2=Total then 'V2'
when V1+V2=Total then 'V1+V2'
when DirectRC+V1=Total then 'DirectRC+V1' 
when DirectRC+V2=Total then 'DirectRC+V2' 
when DirectRC+V1+V2=Total then 'DirectRC+V1+V2'
end Status, b.Client_Name     from (
select CreatedBy, isnull(sum(Case when ISAPI=0 then total end),0) DirectRC, isnull(sum(Case when ISAPI=1 then total end),0) V1,
isnull(sum(Case when ISAPI=2 then total end),0) V2, sum(total) Total  
from #Calls
group by Createdby ) a, echoc3Analytics..ARC_REC_User_info_vy b where a.createdby=b.nt_username 
order by b.Client_name, a.CreatedBY

End

GO
/****** Object:  StoredProcedure [dbo].[echoC3_CallsMissed_SendMail]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[echoC3_CallsMissed_SendMail]

as
Begin

	Declare @PreviousDate date=convert(date, dateAdd(d, -1, getdate()))

	IF OBJECT_ID('tempdb..#Calls') is not null drop table #Calls
	IF OBJECT_ID('tempdb..#DetailReport') is not null drop table #DetailReport

	select createdby, 
	count(case when isAPI>=1 then 1 end) API, count(case when isAPI=0 then 1 end) RC, count(1) as total,
	sum(case when isAPI>=1 then duration end) API_D, sum(case when isAPI=0 then Duration end) RC_d, SUM(Duration) as total_D  into #Calls
	from ARC_AR_CallRecoding a inner join Echoc3Analytics.dbo.ARC_REC_User_info b on a.CreatedBy=b.nt_username 
	where CallDate=@PreviousDate and SourceAdded='RingCentral' 
	and isnull(a.CallDirections,'') not in ('Inbound', 'Internal') and a.createdby is not null
	and a.CallEndTime is not null           
	GROUP BY CreatedBy

	select a.CallDisposition, count(1) as Total, 
	count(case when a.Duration<60 then 1 end) [<1 min short calls],
		count(case when a.Duration>=60 and a.Duration<=300 then 1 end) [1-5 mins],
		count(case when a.Duration>300 and a.Duration<=600 then 1 end) [5-10 mins],
		count(case when a.Duration>600 and a.Duration<=900 then 1 end) [10-15 mins],
		count(case when a.Duration>900 and a.Duration<=1800 then 1 end) [15-30 mins],
		count(case when a.Duration>1800 and a.Duration<=2700 then 1 end) [30-45 mins],
		count(case when a.Duration>2700 and a.Duration<=3600 then 1 end) [45 mins - 1 hr],
		count(case when a.Duration>3600 then 1 end) [1+ hrs] into #DetailReport
	from ARC_AR_CallRecoding a inner join Echoc3Analytics.dbo.ARC_REC_User_info b on a.CreatedBy=b.nt_username 
	inner join #Calls c on c.CreatedBy=a.CreatedBy and c.API>0
	where CallDate=@PreviousDate and SourceAdded='RingCentral' and IsAPI=0
	and isnull(a.CallDirections,'') not in ('Inbound', 'Internal') and a.createdby is not null
	and a.CallEndTime is not null           
	group by a.CallDisposition

	if exists (select top 1 * from #DetailReport)
	Begin

		Declare @Records varchar(max)=''          
		set @Records= '<table cellpading="0" cellspacing="0" border ="1" style="font-family: verdana; font-size: 12px">       
		<tr align="Center" bgcolor="#9A9DDE">          
		<td><B>Total Users</B></td><td><B>API Calls</B></td><td><B>Calls Missed</B></td>     
		<td><B>Total Calls</B></td><td><B>Avg Talk time per caller (API)</B></td><td><B>Avg Talk time per caller (Missed)</B></td>          
		<td><B>Avg Talk time per caller (Overall)</B></td>          
		</tr>'          
             
		Select @Records=@Records+'<tr align="Center"><td>'+convert(varchar,count(1))+'</td>
		<td>'+convert(varchar,sum(API))+'</td><td>'+convert(varchar,sum(RC))+'</td><td align="right">'+convert(varchar,sum(total))+'</td>          
		<td>'+convert(varchar,CONVERT(time(0), DATEADD(SECOND, sum(API_D*1.0)/count(1), 0)))+'</td><td>'+convert(varchar,CONVERT(time(0), DATEADD(SECOND, sum(RC_D*1.0)/count(1), 0)))+'</td>		<td align="right">'+convert(varchar,CONVERT(time(0), DATEADD(SECOND, sum(total_D*1.0)/count(1), 0)))+'</td>		</tr>' FROM #Calls a where a.API>0	          
		set @Records=@Records+'</table><BR>'  

		select @Records=@Records+'<table cellpading="0" cellspacing="0" border ="1" style="font-family: verdana; font-size: 12px">       
		<tr align="Center" bgcolor="#9A9DDE">          
		<td><B>Call Disposition</B></td><td><B><1 min short calls</B></td><td><B>1-5 mins</B></td>     
		<td><B>5-10 mins</B></td><td><B>10-15 mins</B></td><td><B>15-30 mins</B></td>          
		<td><B>30-45 mins</B></td><td><B>45 mins - 1 hr</B></td><td><B>1+ hrs</B></td><td><B>Total</B></td>          
		</tr>'          
             
		Select @Records=@Records+'<tr align="Center"><td>'+CallDisposition+'</td>
		<td>'+convert(varchar,[<1 min short calls])+'</td><td>'+convert(varchar,[1-5 mins])+'</td><td align="right">'+convert(varchar,[5-10 mins])+'</td>          
		<td>'+convert(varchar,[10-15 mins])+'</td><td>'+convert(varchar,[15-30 mins])+'</td>		<td align="right">'+convert(varchar,[30-45 mins])+'</td>		<td align="right">'+convert(varchar,[45 mins - 1 hr])+'</td>		<td align="right">'+convert(varchar,[1+ hrs])+'</td>		<td align="right">'+convert(varchar,[Total])+'</td>		</tr>' FROM #DetailReport  
		Select @Records=@Records+'<tr align="Center"><td><B>Total</B></td>
		<td><B>'+convert(varchar,sum([<1 min short calls]))+'</B></td><td><B>'+convert(varchar,sum([1-5 mins]))+'</B></td>
		<td align="right"><B>'+convert(varchar,sum([5-10 mins]))+'</B></td>          
		<td><B>'+convert(varchar,sum([10-15 mins]))+'</B></td><td><B>'+convert(varchar,sum([15-30 mins]))+'</B></td>		<td align="right"><B>'+convert(varchar,sum([30-45 mins]))+'</B></td>		<td align="right"><B>'+convert(varchar,sum([45 mins - 1 hr]))+'</B></td>		<td align="right"><B>'+convert(varchar,sum([1+ hrs]))+'</B></td>		<td align="right"><B>'+convert(varchar,sum([Total]))+'</B></td>		</tr>' FROM #DetailReport  
		set @Records=@Records+'</table><BR>'

		INSERT INTO EXTR_ARC_AR_V1.dbo.ARC_REC_MAIL_TRAN(FROM_MAILID,RECIPIENTS,SUBJECT_TEXT,BODY,ISHTML,CC,MAIL_STATUS,ACTIVE)      
		select      
		'mail.support@accesshealthcare.co' as FROM_MAILID,      
		'prabhakar.m@accesshealthcare.com; satheesh.seetha@accesshealthcare.com;' as RECIPIENTS,      
		'echoC3 - Calls Missed details' as SUBJECT_TEXT,          
		'<HTML><HEAD></HEAD><BODY style="font-family: verdana; font-size: 12px"><div >Hi Team,<br /><p>Please find the calls missed details report for '+convert(varchar,@PreviousDate,101)+'</p> '+@Records+'      
		<br />Thanks,<br />arc.flow team.<br /><img src="https://www.accesshealthcare.co/appimages/arc_support.png" alt="" width="250px" height="65px" /></p>** This is an auto-generated email.           
		Please do not reply to this email.**<br />          
		Legal Disclaimer: The information contained in this message (including all attachments) may be privileged and confidential. It is intended to be read only by the individual           
		or entity to whom it is addressed or by their designee. If the reader of this message is not the intended recipient, please destroy this message immediately and also           
		please note that you are on notice that any distribution of this message, in any form, is strictly prohibited. If you have received this message in error,           
		please immediately notify the sender and delete or destroy any copy of this message. </BODY></HTML>'as BODY,            
		'Y' as ISHTML,      
		'kailashvasan.vk@accesshealthcare.com; saravanakuma.r@accesshealthcare.com; sakkaravarth.k@accesshealthcare.com; arunkumar.p@accesshealthcare.com' as CC,      
		0 as MAIL_STATUS,      
		1 as ACTIVE;      
   
	End
END
GO
/****** Object:  StoredProcedure [dbo].[echoC3_UpdateClaimCountTimeBetweenCalls]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[echoC3_UpdateClaimCountTimeBetweenCalls]    
    
as    
Begin    
    
  if datepart(hour,getdate())  between 5 and 11    
begin    
 /* To update the time between calls */    
 IF OBJECT_ID('tempdb..#CallDates') is not null drop table #CallDates    
 Create table #CallDates(CallDate date)    
    
 Declare @Fromdate date=getdate()-5,@CallDate date    
    
     
 insert into #CallDates    
 select distinct calldate from echoC3.dbo.ARC_AR_Callrecoding (nolock) where calldate>=@Fromdate    
  and TimeBetweenCallsInSec is null    
    
    
 Select @CallDate=min(callDate) from #CallDates    
 while @CallDate is not null    
 begin    
    
  IF OBJECT_ID('tempdb..#TimeBetweenCalls') is not null drop table #TimeBetweenCalls     
    
  select SNO, calldate, createdby,CallInitiatedTime,CallEndTime,isnull(lag(callendtime,1) over( partition by createdby order by CreatedBy,callendtime), CallInitiatedTime) LastCallEndTime into #TimeBetweenCalls    
  from echoC3.dbo.ARC_AR_Callrecoding(nolock)  where calldate = @CallDate     
    
  /* Update more Records */    
  update a set a.TimeBetweenCallsInSec=case when datediff(s, b.LastCallEndTime, b.CallInitiatedTime)>0 then datediff(s, b.LastCallEndTime, b.CallInitiatedTime) else 0 end    
  from echoC3.dbo.ARC_AR_Callrecoding a inner join #TimeBetweenCalls b on a.SNO=b.SNO    
  where a.calldate = @CallDate and a.calldate=b.calldate    
    
  Select @CallDate=min(callDate) from #CallDates where CallDate>@CallDate    
 end    
    
End     
    
 /* To update the claim count*/    
     
 IF OBJECT_ID('tempdb..#ClaimCount') is not null drop table #ClaimCount    
    
 select customerID, calldate, createdby, claimNo, Count(1) as Total, max(UniqueID) uniqueID    
 ,0 Claimcount     
  into #ClaimCount    
 from echoC3.dbo.ARC_AR_Callrecoding (nolock)    
 where calldate=convert(date,dateAdd(n, -630, getdate())) and ClaimNo is not null    
 and sourceAdded='ringcentral' and CallEndTime is not null      
 group by customerID, createdby, claimNo, calldate    

 update #ClaimCount set Claimcount=(select count(distinct items)     
 from dbo.fnSplitString(replace(replace(replace(replace(rtrim(ltrim(ClaimNo)), ' ', ','), char(9), ','),    
  char(10), ','), char(13), ','), ',') where items<>'')    
    
     
    
 if exists(select top 1 * from #ClaimCount)    
 begin      
  update b set b.ClaimCount=a.Claimcount from #ClaimCount a     
  inner join echoC3.dbo.ARC_AR_Callrecoding b on a.customerid=b.customerid and a.createdby=b.createdby     
  and a.calldate=b.calldate and a.claimNo=b.ClaimNo  and a.Total>1    
  where isnull(b.Claimcount,0)<>isnull(a.Claimcount,0) and a.UniqueId=b.UniqueId    
      
  update b set b.ClaimCount=0 from #ClaimCount a     
  inner join echoC3.dbo.ARC_AR_Callrecoding b on a.customerid=b.customerid and a.createdby=b.createdby     
  and a.calldate=b.calldate and a.claimNo=b.ClaimNo  and a.Total>1    
  where isnull(b.Claimcount,0)>0 and a.UniqueId<>b.UniqueId    
    
  update b set b.ClaimCount=a.Claimcount    
  from #ClaimCount a     
  inner join echoC3.dbo.ARC_AR_Callrecoding b on a.customerid=b.customerid and a.createdby=b.createdby     
  and a.calldate=b.calldate and a.claimNo=b.ClaimNo     
  where  a.UniqueId=b.UniqueId and a.Total=1 and isnull(b.claimCount,0)=0 and a.Claimcount<>0    
     
 end    
    
    
 IF OBJECT_ID('tempdb..#ClaimsCount') is not null drop table #ClaimsCount    
 IF OBJECT_ID('tempdb..#CallDates') is not null drop table #CallDates    
 IF OBJECT_ID('tempdb..#TimeBetweenCalls') is not null drop table #TimeBetweenCalls    
End    
    
GO
/****** Object:  StoredProcedure [dbo].[GetAllTableSizes_Dialy]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE ProcEDURE [dbo].[GetAllTableSizes_Dialy]          
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
insert into [LNKENTERPRISE].DBAevents_11.dbo.DialyTableCountDetails    
select @@SERVERNAME, DB_NAME(),*,CONVERT(date, getdate()) from #TempTable     
    
DROP TABLE #TempTable     
    
end    
    
    
    
    
    
    
    
    
    
    
  
  
  
GO
/****** Object:  StoredProcedure [dbo].[MissingIndex]    Script Date: 8/30/2020 6:36:02 PM ******/
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
TableName varchar(max),            
IndexNameCreate varchar(max),            
IndexName varchar(max) default(Null),        
avg_user_impact int           
)            
            
            
insert into #tempU(ID,Imapact,Seek,TableName,IndexNameCreate,IndexName,avg_user_impact)              
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
 INDName,avg_user_impact                
FROM sys.dm_db_missing_index_groups dm_mig                    
INNER JOIN sys.dm_db_missing_index_group_stats dm_migs                    
ON dm_migs.group_handle = dm_mig.index_group_handle                    
INNER JOIN sys.dm_db_missing_index_details dm_mid                    
ON dm_mig.index_handle = dm_mid.index_handle                    
WHERE dm_mid.database_ID = DB_ID() and avg_user_impact>50            
ORDER BY avg_user_impact DESC               
            
select * from #tempU  order by Imapact desc          
            
delete from #tempU where Pid in (            
select Max(pid) from #tempU group by indexName having COUNT(*)>1 )            
            
select distinct IndexNameCreate,IndexName  from #tempU         
where IndexName not in (select isnull(name,'') from sys.indexes)            
            
End  
  
GO
/****** Object:  StoredProcedure [dbo].[TableViewFunctionPermission]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCedure [dbo].[TableViewFunctionPermission]
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
select  Name into #viewtemp from sys.views where create_date >=GETDATE()-7               
                
                
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
/****** Object:  StoredProcedure [dbo].[TableViewFunctionPermission_ReadOnly]    Script Date: 8/30/2020 6:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCedure [dbo].[TableViewFunctionPermission_ReadOnly]
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
and crdate >=GETDATE()-7              
                
                
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
