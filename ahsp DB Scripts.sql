USE [AhsPlatform]
GO
/****** Object:  UserDefinedTableType [dbo].[Batchdetails]    Script Date: 8/30/2020 7:12:44 PM ******/
CREATE TYPE [dbo].[Batchdetails] AS TABLE(
	[Batchno] [varchar](300) NULL,
	[FiletakenPathSize] [bigint] NULL,
	[FilePlacedPath] [bigint] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[C3_ADMN_DeleteUser_Type]    Script Date: 8/30/2020 7:12:46 PM ******/
CREATE TYPE [dbo].[C3_ADMN_DeleteUser_Type] AS TABLE(
	[NTUserName] [varchar](150) NULL,
	[VendorID] [int] NULL,
	[Remarks] [varchar](500) NULL,
	[IsActive] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[C3_ADMN_EditUser_Type]    Script Date: 8/30/2020 7:12:46 PM ******/
CREATE TYPE [dbo].[C3_ADMN_EditUser_Type] AS TABLE(
	[NTUserName] [varchar](150) NULL,
	[VendorID] [int] NULL,
	[GroupID] [int] NULL,
	[RoleID] [int] NULL,
	[Department] [varchar](500) NULL,
	[DialerType] [int] NULL,
	[Remarks] [varchar](500) NULL,
	[IsActive] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[C3_CallInfo_Type]    Script Date: 8/30/2020 7:12:47 PM ******/
CREATE TYPE [dbo].[C3_CallInfo_Type] AS TABLE(
	[ClaimNo] [varchar](250) NULL,
	[ToPhoneNumber] [varchar](150) NULL,
	[CallInitiatedTime] [datetime] NULL,
	[CallEndTime] [datetime] NULL,
	[RecordingURL] [varchar](1000) NULL,
	[FromName] [varchar](150) NULL,
	[SourceAdded] [varchar](100) NULL,
	[Uniqueid] [varchar](500) NULL,
	[CallDisposition] [varchar](350) NULL,
	[ToLocation] [varchar](250) NULL,
	[ToName] [varchar](150) NULL,
	[Duration] [int] NULL,
	[Direction] [varchar](350) NULL,
	[RecordingID] [varchar](150) NULL,
	[FromExtn] [varchar](150) NULL,
	[PageURL] [varchar](250) NULL,
	[Reason] [varchar](350) NULL,
	[ReasonDescription] [varchar](500) NULL,
	[EndCallEventFlag] [int] NULL,
	[UserSystemDateTime] [datetime] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[C3_CallInfo_Type_New]    Script Date: 8/30/2020 7:12:48 PM ******/
CREATE TYPE [dbo].[C3_CallInfo_Type_New] AS TABLE(
	[ClaimNo] [varchar](250) NULL,
	[ToPhoneNumber] [varchar](150) NULL,
	[CallInitiatedTime] [datetime] NULL,
	[CallEndTime] [datetime] NULL,
	[RecordingURL] [varchar](1000) NULL,
	[FromName] [varchar](150) NULL,
	[SourceAdded] [varchar](100) NULL,
	[Uniqueid] [varchar](500) NULL,
	[CallDisposition] [varchar](350) NULL,
	[ToLocation] [varchar](250) NULL,
	[ToName] [varchar](150) NULL,
	[Duration] [int] NULL,
	[Direction] [varchar](350) NULL,
	[RecordingID] [varchar](150) NULL,
	[FromExtn] [varchar](150) NULL,
	[PageURL] [varchar](250) NULL,
	[Reason] [varchar](350) NULL,
	[ReasonDescription] [varchar](500) NULL,
	[EndCallEventFlag] [int] NULL,
	[UserSystemDateTime] [datetime] NULL,
	[AppHost] [varchar](500) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[C3_CallRecordingExtensions_Type]    Script Date: 8/30/2020 7:12:49 PM ******/
CREATE TYPE [dbo].[C3_CallRecordingExtensions_Type] AS TABLE(
	[ExternalId] [varchar](100) NOT NULL,
	[extensionNumber] [varchar](100) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[C3_FileWatcherType]    Script Date: 8/30/2020 7:12:50 PM ******/
CREATE TYPE [dbo].[C3_FileWatcherType] AS TABLE(
	[FullPath] [varchar](1000) NOT NULL,
	[FileName] [varchar](350) NULL,
	[FileSize] [bigint] NULL,
	[FileCreatedAt] [datetime] NULL,
	[OldName] [varchar](250) NULL,
	[ChangeType] [varchar](100) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[C3_RCDirectory_Type]    Script Date: 8/30/2020 7:12:52 PM ******/
CREATE TYPE [dbo].[C3_RCDirectory_Type] AS TABLE(
	[department] [varchar](700) NULL,
	[email] [varchar](250) NULL,
	[extensionNumber] [varchar](150) NULL,
	[firstName] [varchar](150) NULL,
	[lastName] [varchar](150) NULL,
	[name] [varchar](300) NULL,
	[id] [varchar](150) NULL,
	[jobTitle] [varchar](150) NULL,
	[phoneNumber] [varchar](150) NULL,
	[Phonetype] [varchar](250) NULL,
	[label] [varchar](250) NULL,
	[usageType] [varchar](150) NULL,
	[status] [varchar](150) NULL,
	[type] [varchar](150) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FileNameDetails]    Script Date: 8/30/2020 7:12:53 PM ******/
CREATE TYPE [dbo].[FileNameDetails] AS TABLE(
	[FileName] [varchar](300) NULL,
	[FileSizeinServer] [varchar](10) NULL,
	[FileSizeinClient] [varchar](10) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[PathNames]    Script Date: 8/30/2020 7:12:57 PM ******/
CREATE TYPE [dbo].[PathNames] AS TABLE(
	[Pathname] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[RptQryType]    Script Date: 8/30/2020 7:12:58 PM ******/
CREATE TYPE [dbo].[RptQryType] AS TABLE(
	[Qry] [varchar](max) NULL,
	[InsertionOrder] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[VDSNewUserlist]    Script Date: 8/30/2020 7:13:00 PM ******/
CREATE TYPE [dbo].[VDSNewUserlist] AS TABLE(
	[UserName] [varchar](75) NULL,
	[UserRole] [varchar](20) NULL,
	[PrimaryUserName] [varchar](150) NULL,
	[Primarypassword] [varchar](300) NULL,
	[SecondaryUserName] [varchar](150) NULL,
	[Secondarypassword] [varchar](300) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[C3_ADMN_SplitStringfn]    Script Date: 8/30/2020 7:13:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[C3_ADMN_SplitStringfn]    
(@String VARCHAR(MAX), @Delimiter CHAR(1))      
RETURNS @temptable TABLE (items VARCHAR(MAX))                       
AS               
BEGIN              
    DECLARE @idx INT               
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
/****** Object:  UserDefinedFunction [dbo].[C3_ADMN_UserExist]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[C3_ADMN_UserExist]
(
	@NtUsername VARCHAR(150) --= 'balakumar.m1'
	,@VendorID INT --= 2
)
RETURNS  INT
AS
BEGIN
	DECLARE @Result INT
	SELECT @Result= COUNT(NTUserName)
	FROM C3_UserMaster(NOLOCK)UM
	INNER JOIN C3_UserProfile(NOLOCK)UP
	ON UM.UserID = UP.UserID
	WHERE NTUserName = @NtUsername
	AND VendorID = @VendorID
	RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[C3_StringSplit]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnSplitString]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[GetCurrentDateTime]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[GetCurrentDateTime]( @Date Datetime,@LocationId int,@ToTS varchar(50)) 
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
from [ARC_AR_V2].dbo.ARC_AR_LocationMaster with (nolock)
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
/****** Object:  UserDefinedFunction [dbo].[parseJSON]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[parseJSON]( @JSON NVARCHAR(MAX))
RETURNS @hierarchy TABLE
  (
   element_id INT IDENTITY(1, 1) NOT NULL, /* internal surrogate primary key gives the order of parsing and the list order */
   sequenceNo [int] NULL, /* the place in the sequence for the element */
   parent_ID INT,/* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
   Object_ID INT,/* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
   NAME NVARCHAR(2000),/* the name of the object */
   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
  )
AS
BEGIN
  DECLARE
    @FirstObject INT, --the index of the first open bracket found in the JSON string
    @OpenDelimiter INT,--the index of the next open bracket found in the JSON string
    @NextOpenDelimiter INT,--the index of subsequent open bracket found in the JSON string
    @NextCloseDelimiter INT,--the index of subsequent close bracket found in the JSON string
    @Type NVARCHAR(10),--whether it denotes an object or an array
    @NextCloseDelimiterChar CHAR(1),--either a '}' or a ']'
    @Contents NVARCHAR(MAX), --the unparsed contents of the bracketed expression
    @Start INT, --index of the start of the token that you are parsing
    @end INT,--index of the end of the token that you are parsing
    @param INT,--the parameter at the end of the next Object/Array token
    @EndOfName INT,--the index of the start of the parameter at end of Object/Array token
    @token NVARCHAR(200),--either a string or object
    @value NVARCHAR(MAX), -- the value as a string
    @SequenceNo int, -- the sequence number within a list
    @name NVARCHAR(200), --the name as a string
    @parent_ID INT,--the next parent ID to allocate
    @lenJSON INT,--the current length of the JSON String
    @characters NCHAR(36),--used to convert hex to decimal
    @result BIGINT,--the value of the hex symbol being parsed
    @index SMALLINT,--used for parsing the hex value
    @Escape INT --the index of the next escape character


  DECLARE @Strings TABLE /* in this temporary table we keep all strings, even the names of the elements, since they are 'escaped' in a different way, and may contain, unescaped, brackets denoting objects or lists. These are replaced in the JSON string by tokens representing the string */
    (
     String_ID INT IDENTITY(1, 1),
     StringValue NVARCHAR(MAX)
    )
  SELECT--initialise the characters to convert hex to ascii
    @characters='0123456789abcdefghijklmnopqrstuvwxyz',
    @SequenceNo=0, --set the sequence no. to something sensible.
  /* firstly we process all strings. This is done because [{} and ] aren't escaped in strings, which complicates an iterative parse. */
    @parent_ID=0;
  WHILE 1=1 --forever until there is nothing more to do
    BEGIN
      SELECT
        @start=PATINDEX('%[^a-zA-Z]["]%', @json collate SQL_Latin1_General_CP850_Bin);--next delimited string
      IF @start=0 BREAK --no more so drop through the WHILE loop
      IF SUBSTRING(@json, @start+1, 1)='"'
        BEGIN --Delimited Name
          SET @start=@Start+1;
          SET @end=PATINDEX('%[^\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
        END
      IF @end=0 --no end delimiter to last string
        BREAK --no more
      SELECT @token=SUBSTRING(@json, @start+1, @end-1)
      --now put in the escaped control characters
      SELECT @token=REPLACE(@token, FROMString, TOString)
      FROM
        (SELECT
          '\"' AS FromString, '"' AS ToString
         UNION ALL SELECT '\\', '\'
         UNION ALL SELECT '\/', '/'
         UNION ALL SELECT '\b', CHAR(08)
         UNION ALL SELECT '\f', CHAR(12)
         UNION ALL SELECT '\n', CHAR(10)
         UNION ALL SELECT '\r', CHAR(13)
         UNION ALL SELECT '\t', CHAR(09)
        ) substitutions
      SELECT @result=0, @escape=1
  --Begin to take out any hex escape codes
      WHILE @escape>0
        BEGIN
          SELECT @index=0,
          --find the next hex escape sequence
          @escape=PATINDEX('%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%', @token collate SQL_Latin1_General_CP850_Bin)
          IF @escape>0 --if there is one
            BEGIN
              WHILE @index<4 --there are always four digits to a \x sequence  
                BEGIN
                  SELECT --determine its value
                    @result=@result+POWER(16, @index)
                    *(CHARINDEX(SUBSTRING(@token, @escape+2+3-@index, 1),
                                @characters)-1), @index=@index+1 ;

                END
                -- and replace the hex sequence by its unicode value
              SELECT @token=STUFF(@token, @escape, 6, NCHAR(@result))
            END
        END
      --now store the string away
      INSERT INTO @Strings (StringValue) SELECT @token
      -- and replace the string with a token
      SELECT @JSON=STUFF(@json, @start, @end+1,
                    '@string'+CONVERT(NVARCHAR(5), @@identity))
    END
  -- all strings are now removed. Now we find the first leaf. 
  WHILE 1=1  --forever until there is nothing more to do
  BEGIN

  SELECT @parent_ID=@parent_ID+1
  --find the first object or list by looking for the open bracket
  SELECT @FirstObject=PATINDEX('%[{[[]%', @json collate SQL_Latin1_General_CP850_Bin)--object or array
  IF @FirstObject = 0 BREAK
  IF (SUBSTRING(@json, @FirstObject, 1)='{')
    SELECT @NextCloseDelimiterChar='}', @type='object'
  ELSE
    SELECT @NextCloseDelimiterChar=']', @type='array'
  SELECT @OpenDelimiter=@firstObject

  WHILE 1=1 --find the innermost object or list...
    BEGIN
      SELECT
        @lenJSON=LEN(@JSON+'|')-1
  --find the matching close-delimiter proceeding after the open-delimiter
      SELECT
        @NextCloseDelimiter=CHARINDEX(@NextCloseDelimiterChar, @json,
                                      @OpenDelimiter+1)
  --is there an intervening open-delimiter of either type
      SELECT @NextOpenDelimiter=PATINDEX('%[{[[]%',
             RIGHT(@json, @lenJSON-@OpenDelimiter)collate SQL_Latin1_General_CP850_Bin)--object
      IF @NextOpenDelimiter=0
        BREAK
      SELECT @NextOpenDelimiter=@NextOpenDelimiter+@OpenDelimiter
      IF @NextCloseDelimiter<@NextOpenDelimiter
        BREAK
      IF SUBSTRING(@json, @NextOpenDelimiter, 1)='{'
        SELECT @NextCloseDelimiterChar='}', @type='object'
      ELSE
        SELECT @NextCloseDelimiterChar=']', @type='array'
      SELECT @OpenDelimiter=@NextOpenDelimiter
    END
  ---and parse out the list or name/value pairs
  SELECT
    @contents=SUBSTRING(@json, @OpenDelimiter+1,
                        @NextCloseDelimiter-@OpenDelimiter-1)
  SELECT
    @JSON=STUFF(@json, @OpenDelimiter,
                @NextCloseDelimiter-@OpenDelimiter+1,
                '@'+@type+CONVERT(NVARCHAR(5), @parent_ID))
  WHILE (PATINDEX('%[A-Za-z0-9@+.e]%', @contents collate SQL_Latin1_General_CP850_Bin))<>0
    BEGIN
      IF @Type='Object' --it will be a 0-n list containing a string followed by a string, number,boolean, or null
        BEGIN
          SELECT
            @SequenceNo=0,@end=CHARINDEX(':', ' '+@contents)--if there is anything, it will be a string-based name.
          SELECT  @start=PATINDEX('%[^A-Za-z@][@]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)--AAAAAAAA
          SELECT @token=SUBSTRING(' '+@contents, @start+1, @End-@Start-1),
            @endofname=PATINDEX('%[0-9]%', @token collate SQL_Latin1_General_CP850_Bin),
            @param=RIGHT(@token, LEN(@token)-@endofname+1)
          SELECT
            @token=LEFT(@token, @endofname-1),
            @Contents=RIGHT(' '+@contents, LEN(' '+@contents+'|')-@end-1)
          SELECT  @name=stringvalue FROM @strings
            WHERE string_id=@param --fetch the name
        END
      ELSE
        SELECT @Name=null,@SequenceNo=@SequenceNo+1
      SELECT
        @end=CHARINDEX(',', @contents)-- a string-token, object-token, list-token, number,boolean, or null
      IF @end=0
        SELECT  @end=PATINDEX('%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%', @Contents+' ' collate SQL_Latin1_General_CP850_Bin)
          +1
       SELECT
        @start=PATINDEX('%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)
      --select @start,@end, LEN(@contents+'|'), @contents 
      SELECT
        @Value=RTRIM(SUBSTRING(@contents, @start, @End-@Start)),
        @Contents=RIGHT(@contents+' ', LEN(@contents+'|')-@end)
      IF SUBSTRING(@value, 1, 7)='@object'
        INSERT INTO @hierarchy
          (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
          SELECT @name, @SequenceNo, @parent_ID, SUBSTRING(@value, 8, 5),
            SUBSTRING(@value, 8, 5), 'object'
      ELSE
        IF SUBSTRING(@value, 1, 6)='@array'
          INSERT INTO @hierarchy
            (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
            SELECT @name, @SequenceNo, @parent_ID, SUBSTRING(@value, 7, 5),
              SUBSTRING(@value, 7, 5), 'array'
        ELSE
          IF SUBSTRING(@value, 1, 7)='@string'
            INSERT INTO @hierarchy
              (NAME, SequenceNo, parent_ID, StringValue, ValueType)
              SELECT @name, @SequenceNo, @parent_ID, stringvalue, 'string'
              FROM @strings
              WHERE string_id=SUBSTRING(@value, 8, 5)
          ELSE
            IF @value IN ('true', 'false')
              INSERT INTO @hierarchy
                (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                SELECT @name, @SequenceNo, @parent_ID, @value, 'boolean'
            ELSE
              IF @value='null'
                INSERT INTO @hierarchy
                  (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                  SELECT @name, @SequenceNo, @parent_ID, @value, 'null'
              ELSE
                IF PATINDEX('%[^0-9]%', @value collate SQL_Latin1_General_CP850_Bin)>0
                  INSERT INTO @hierarchy
                    (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                    SELECT @name, @SequenceNo, @parent_ID, @value, 'real'
                ELSE
                  INSERT INTO @hierarchy
                    (NAME, SequenceNo, parent_ID, StringValue, ValueType)
                    SELECT @name, @SequenceNo, @parent_ID, @value, 'int'
      if @Contents=' ' Select @SequenceNo=0
    END
  END
INSERT INTO @hierarchy (NAME, SequenceNo, parent_ID, StringValue, Object_ID, ValueType)
  SELECT '-',1, NULL, '', @parent_id-1, @type
--
   RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[Split_PerDiem]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split_PerDiem]
(
	@Input VARCHAR(MAX),
	@Delimiter1 VARCHAR(3),
	@Delimiter2 VARCHAR(3)='',
	@FilterName VARCHAR(100)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	    DECLARE @StartIndex INT, @EndIndex INT
		DECLARE @OutputValue AS VARCHAR(MAX)
		SET @OutputValue = '' 
		DECLARE @OutputValue1 AS VARCHAR(MAX)
		SET @OutputValue1 = '' 
		SET @StartIndex = 1
		IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Delimiter1
		BEGIN
			SET @Input = @Input + @Delimiter1
		END

		WHILE CHARINDEX(@Delimiter1, @Input) > 0
		BEGIN
			SET @EndIndex = CHARINDEX(@Delimiter1, @Input)           
			SET @OutputValue = SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
			IF PATINDEX('%' + @FilterName +'%',@OutputValue) > 0
			BEGIN
				SELECT @OutputValue1 = SUBSTRING(@OutputValue,CHARINDEX(@Delimiter2,@OutputValue)+1,LEN(@OutputValue) - CHARINDEX(@Delimiter2,@OutputValue))
				--SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
				BREAK;
			END           
			SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
		END
		SET @OutputValue1 = REPLACE(@OutputValue1,'"','')
 
      RETURN @OutputValue1
END
GO
/****** Object:  UserDefinedFunction [dbo].[Split_PerDim]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split_PerDim]
(
	@Input VARCHAR(MAX),
	@Delimiter1 VARCHAR(3),
	@Delimiter2 VARCHAR(3)='',
	@FilterName VARCHAR(100)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	    DECLARE @StartIndex INT, @EndIndex INT
		DECLARE @OutputValue AS VARCHAR(MAX)
		SET @OutputValue = '' 
		SET @StartIndex = 1
		IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Delimiter1
		BEGIN
			SET @Input = @Input + @Delimiter1
		END

		WHILE CHARINDEX(@Delimiter1, @Input) > 0
		BEGIN
			SET @EndIndex = CHARINDEX(@Delimiter1, @Input)           
			SET @OutputValue = SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
			IF PATINDEX('%' + @FilterName +'%',@OutputValue) > 0
			BEGIN
				SELECT @OutputValue = SUBSTRING(@OutputValue,CHARINDEX(@Delimiter2,@OutputValue)+1,LEN(@OutputValue) - CHARINDEX(@Delimiter2,@OutputValue))
				--SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
				BREAK;
			END           
			SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
		END
		SET @OutputValue = REPLACE(@OutputValue,'"','')
 
      RETURN @OutputValue
END
GO
/****** Object:  UserDefinedFunction [dbo].[StringSplit]    Script Date: 8/30/2020 7:13:02 PM ******/
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
   set  @String = replace(@String,'.mp3','')
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
/****** Object:  View [dbo].[Arc_Ar_ClientMaster_View]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  View [dbo].[ARC_REC_USER_INFO_VY]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  View [dbo].[C3_ADMN_GroupMasterList_VY]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  View [dbo].[C3_ADMN_RolesMasterList_VY]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  View [dbo].[C3_ADMN_SchedulerUserStatus_VY]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  View [dbo].[C3_ADMN_UserMasterList_VY]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  View [dbo].[C3_ADMN_VendorMasterList_VY]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[C3_ADMN_VendorMasterList_VY] AS
SELECT VendorID,VendorName,[Description]
FROM C3_VendorMaster(NOLOCK)
WHERE IsActive = 1
GO
/****** Object:  StoredProcedure [dbo].[AhsDecisionRule]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[AhsDecisionRule]
as
begin
select RuleName,Description from PRuleMaster
End
GO
/****** Object:  StoredProcedure [dbo].[AHSPlatform_InsertComponent]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure  [dbo].[AHSPlatform_InsertComponent](
@Name nvarchar(max))
As
Begin
delete from AhsPlatformProcessScheduler
insert into AhsPlatformProcessScheduler(ProcessId,ProcessDescription,ProcessJson,StartupJson,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate) values(1,'Component',@Name,'','','','','')
End



GO
/****** Object:  StoredProcedure [dbo].[AHSPlatform_SelectJsonLoad]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure  [dbo].[AHSPlatform_SelectJsonLoad](
@ProcessID int)
As

Begin
select ProcessJson from AhsPlatformProcessScheduler where ProcessId=@ProcessID

End




GO
/****** Object:  StoredProcedure [dbo].[AHSPlatformBusinessInsert]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure  [dbo].[AHSPlatformBusinessInsert](
@Name nvarchar(max))
As
Begin

update AhsPlatformWorkFlowMaster set WorkFlowJson=@Name
End




GO
/****** Object:  StoredProcedure [dbo].[AHSPlatformBusinessSelect]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure  [dbo].[AHSPlatformBusinessSelect]
As
Begin

select * from  AhsPlatformWorkFlowMaster 
End
GO
/****** Object:  StoredProcedure [dbo].[AHSPlatformBusinessUpdate]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure  [dbo].[AHSPlatformBusinessUpdate](
@Name nvarchar(max))
As
Begin

update PBWWorkFlowMaster set WorkFlowJson=@Name where workflowid=2
End
GO
/****** Object:  StoredProcedure [dbo].[AhsSelectDecisionRule]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[AhsSelectDecisionRule]
as
begin
select RuleSetId,RuleSetName from PRuleSet
End

GO
/****** Object:  StoredProcedure [dbo].[AhsSelectRole]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[AhsSelectRole]
as
begin
select Queueid,QueueName from AhsPlatformRoleQueue
End
GO
/****** Object:  StoredProcedure [dbo].[AhsSelectWorkFlowMaster]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AhsSelectWorkFlowMaster]  
 @Mail BIT = 0  ,
  @workflowtype int 
AS   
BEGIN  
 --IF @Mail = 1  
 --BEGIN 
  SELECT RoleId,RoleName from PBWWorkFlowRoleMaster where WfId=@workflowtype 
  UNION  
  SELECT 101 RoleId,'Requester' RoleName FROM PBWWorkFlowRoleMaster  
 --END  
 --ELSE  
 --BEGIN  
  --SELECT RoleId,RoleName from PBWWorkFlowRoleMaster  
 --END  
END  

 
GO
/****** Object:  StoredProcedure [dbo].[ARC_AR_GetCurrentDateTimeGMT]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE ProcEDURE [dbo].[ARC_AR_GetCurrentDateTimeGMT]
(
	@CustomerId int = 0,
	@SubProvisionId int = 0
)
AS
BEGIN
	
	IF @CustomerId > 0
		BEGIN
			declare @ProcessDate date ,@FrmDate time,@ToTime time           

			select @FrmDate =convert(time,FromTime ) , @ToTime = CONVERT(time, ToTime) from Arc_Ar_ClientMaster_View           
			where CustomerID =@CustomerId  AND SubProvisionId=@SubProvisionId         
			
			SET @ProcessDate= dateadd (D,(case when CONVERT(time,GETDATE())< CONVERT(time,@FrmDate ) then -1 when CONVERT(time,GETDATE()) > CONVERT(time,@ToTime) then 0 else 0 end)           
			,CONVERT(date,GETDATE()))   

			SELECT dbo.GetCurrentDateTime(GETDATE(),1,'GMT') GMT,dbo.GetCurrentDateTime(GETDATE(),1,'GMT') GMT,GETDATE() IST, @ProcessDate ProductionDate
		END
	ELSE
		BEGIN
			SELECT dbo.GetCurrentDateTime(GETDATE(),1,'GMT') GMT,dbo.GetCurrentDateTime(GETDATE(),1,'GMT') GMT,GETDATE() IST, CONVERT(date,getdate()) ProductionDate
		END
END

GO
/****** Object:  StoredProcedure [dbo].[ARC_GET_DATA_JSON]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ARC_GET_DATA_JSON]
	@WORKFLOW_ID	INT
AS
BEGIN
	/*
	CREATED BY		: PRABAAKARAN T
	CREATED DT		: 
	PURPOSE			: GET JSON DATA
	TICKET/SCR NO	: SCR-897
	
	IMPLEMENTED BY	:
	IMPLEMENTED DT	:	
	*/
	
	SET NOCOUNT ON
	
	SELECT 
		 DataJson 
	FROM AhsPlatformWorkFlowMaster 
	WHERE WorkFlowId = @WORKFLOW_ID 
	
	SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[ARC_GET_WORKFLOW_ID]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	DECLARE @WORKFLOW_ID	INT	
	EXEC ARC_GET_WORKFLOW_ID @CLIENT_ID=1,@BP_ID=1, @WORKFLOW_ID = @WORKFLOW_ID OUTPUT
	SELECT @WORKFLOW_ID
*/

CREATE PROCEDURE [dbo].[ARC_GET_WORKFLOW_ID]
	@CLIENT_ID		INT,
	@BP_ID			INT,
	@WORKFLOW_ID	INT	OUTPUT
AS
BEGIN
	/*
	CREATED BY		: PRABAAKARAN T
	CREATED DT		: 
	PURPOSE			: GET WORKFLOW ID
	TICKET/SCR NO	: SCR-897
	
	IMPLEMENTED BY	:
	IMPLEMENTED DT	:	
	*/
	
	SET NOCOUNT ON
	
	SELECT 
		@WORKFLOW_ID = WorkFlowId 
	FROM AhsPlatformWorkFlowMaster 
	WHERE ClientId = @CLIENT_ID AND BpId = @BP_ID
	
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[ARC_REC_GETlob]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ARC_REC_GETlob]      
As          
Begin       
	--select  LOB,ID from ARC_REC_LOB_INFO where Active=1      
	SELECT 'AR' LOB,1 ID
	UNION
	SELECT 'Billing',2
	UNION
	SELECT 'Clustering',3
	UNION
	SELECT 'Coding',4
	UNION
	SELECT 'Other',5
	UNION
	SELECT 'Quality',6
End  
GO
/****** Object:  StoredProcedure [dbo].[ARC_SUP_PROCESS_FLOW]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ARC_SUP_PROCESS_FLOW]
AS
BEGIN
	SELECT
		RequestId,UserId,Status [Subject],CONVERT(VARCHAR(12),ISNULL(LastModifiedDate,CreatedDate),113) [Received],Status [Categories],
		--'<button type="button" class="btn btn-primary btn-md btnWidth120"  onclick="return fnOpenTicket('+CONVERT(VARCHAR(20),RequestId)+','''+UserId+''',''TmsAction'',''TmsAction'')" > Action </ button >' [Action]
		'<button type="button" class="btn btn-primary btn-md btnWidth120"  onclick="return fnOpenTicket('+CONVERT(VARCHAR(20),Fin)+','''+UserId+''',''TmsAction'',''TmsAction'')" > Action </ button >' [Action]		
	FROM PBWWorkflowTransaction
	WHERE WorkflowId = 2 AND Status IN ('Acknowledgement','SubmitExpenses','BillVerify')
END

GO
/****** Object:  StoredProcedure [dbo].[AthenaDecisionTreeUtilization]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[AthenaDecisionTreeUtilization](@fromDate datetime = null,@toDate datetime=null)
as begin
--declare @fromDate datetime='2018-03-12 16:22:33.927'
--declare @toDate datetime='2019-03-28 16:22:33.927'
if @fromDate is null Set @fromDate = Convert(Datetime,Convert(varchar,Convert(date,GETDATE()-1)) + ' 08:00')  
if @toDate is null Set @toDate = DateAdd(Day,1,@fromDate) 
SELECT   case when substring(Convert(varchar,cast(d.CreatedDate as time)),0,6)  between '00:01' and '07:59'   
then convert(date,dateadd(dd,-1,Convert(date,d.CreatedDate))) else Convert(date,d.CreatedDate) end as Date 
         ,r.Name as DT_Name
      ,d.[UserName]
     
      ,u.UserClient as Team
      ,u.LocationName as Location
         ,u.DepartmentName
		 ,u.SupervisorId
       ,COUNT(*) as [Count] 
  FROM [AhsPlatform].[dbo].[DecisionTreeResults] d 
  join [AhsPlatform].[dbo].DecisionTreee r
   on d.DecisionId = r.DecisionId 
   join [AhsPlatform].[dbo].PBWUserMaster u
   on d.UserName = u.UserId
   where d.CreatedDate between @fromDate and @toDate  
    and u.UserClient='Athena' and u.LocationName <> 'Manila'
   group by case when substring(Convert(varchar,cast(d.CreatedDate as time)),0,6)  between '00:01' and '07:59'   
then convert(date,dateadd(dd,-1,Convert(date,d.CreatedDate))) else Convert(date,d.CreatedDate) end ,r.Name
      ,d.[UserName]
   
      ,u.UserClient
      ,u.LocationName 
         ,u.DepartmentName
		 ,u.SupervisorId

		 end


		 
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_CreateGroup]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_ADMN_CreateGroup]
(
	@VendorID INT
	,@GroupName VARCHAR(500)
	,@Department VARCHAR(500)
	,@Description VARCHAR(600)
	,@CreatedBy VARCHAR(150)
)
AS
BEGIN
	INSERT INTO C3_GroupNameInfo(VendorID,GroupName,Department,[Description],CreatedBy)
	VALUES(@VendorID,@GroupName,@Department,@Description,@CreatedBy)
END
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_CreateNewUser]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_ADMN_CreateNewUser]
(
	 @NtUsername VARCHAR(150) --= 'balakumar.m1'
	,@Mode VARCHAR(100) --= 'Create User'
	,@CreatedBy VARCHAR(150) --= 'saravanakuma.r'
	,@Extension VARCHAR(100) --= '105'
	,@ExternalId VARCHAR(150) --= '281492004'
	,@VendorID	INT --= 1
	,@GroupID INT --= 17
	,@RoleID INT --= 3
	,@Department VARCHAR(250) --= 'Support_Application Development'
)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX), @UserExist BIT = 0
	BEGIN TRY
		if (SELECT dbo.C3_ADMN_UserExist(@NtUsername,@VendorID)) = 0
		BEGIN
			if EXISTS(SELECT NTUserName FROM C3_UserMaster(NOLOCK) WHERE NTUserName = @NtUsername)
			BEGIN
				SET @UserExist = 1
			END			
			BEGIN TRANSACTION  
				if @UserExist = 0
				BEGIN
					INSERT INTO C3_UserMaster(EmpCode,NTUserName,FirstName,LastName,Email,CreatedBy)
					SELECT Empcode,NT_UserName,FIRSTNAME,LASTNAME,Associate_Email,@CreatedBy
					FROM /*ARC_REC.dbo.ARC_REC_USER_INFO_VY*/ARC_REC_USER_INFOVY a
					WHERE a.NT_UserName = @NtUsername
				END

				INSERT INTO C3_UserProfile(UserID,VendorID,CustomerID,GroupID,Extension,RoleID,DirectNumber
				,Department,ExternalId,Remarks,CreatedBy,DialerType)
				SELECT UM.UserID,@VendorID,ar.Client_Id,@GroupID,@Extension,@RoleID,NULL,@Department
				,@ExternalId,@Mode,@CreatedBy,NULL
				FROM C3_UserMaster(NOLOCK)UM		
				INNER JOIN /*ARC_REC.dbo.ARC_REC_USER_INFO_VY*/ARC_REC_USER_INFOVY AR
				ON AR.NT_UserName = UM.NTUserName
				WHERE UM.NTUserName = @NtUsername
			COMMIT TRANSACTION
			SET @Result = 'Success'  
		END
		ELSE
		BEGIN
			SET @Result = @NtUsername + ' name already exist' 
		END
		
	END TRY  
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @Result = ERROR_MESSAGE()  
		INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)  
		VALUES('RCNewUser','RingCentral',@CreatedBy,'Newuser-DB',GETDATE(),@Result)   
	END CATCH  
SELECT @Result AS Result	
END 
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_CreateVendor]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_ADMN_CreateVendor]
(
	@VendorName		VARCHAR(600)
	,@Description	VARCHAR(600)
	,@CreatedBy		VARCHAR(150)
)
AS
BEGIN
	INSERT INTO C3_VendorMaster(VendorName,[Description],CreatedBy)
	VALUES(@VendorName,@Description,@CreatedBy)
END
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_DeleteGroup]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[C3_ADMN_DeleteGroup]
(
	@GroupID INT
	,@CreatedBy VARCHAR(150)
)
AS
BEGIN
	UPDATE C3_GroupNameInfo SET CreatedBy = @CreatedBy, ModifiedOn = GETDATE(), IsActive = 0
	WHERE GroupID = @GroupID
END
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_DeleteUser]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_ADMN_DeleteUser]
(
	@Data C3_ADMN_DeleteUser_Type READONLY, 
	@CreatedBy	VARCHAR(150)
)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX)	
	BEGIN TRY
		IF OBJECT_ID('tempdb..#TmbTblC3DeleteUser') IS NOT NULL DROP TABLE #TmbTblC3DeleteUser

		SELECT UM.UserID,a.VendorID,a.Remarks
		INTO #TmbTblC3DeleteUser 
		FROM @Data a
		INNER JOIN C3_UserMaster(NOLOCK)UM
		ON a.NTUserName = UM.NTUserName
		
		BEGIN TRANSACTION  

			INSERT INTO C3_UserProfileLog(UserID,VendorID,CustomerID,GroupID,Extension,RoleID,DirectNumber
					,Department,ExternalId,DialerType,Remarks,IsActive,ModifiedBy)
			SELECT UP.UserID,UP.VendorID,UP.CustomerID,UP.GroupID,UP.Extension,UP.RoleID,UP.DirectNumber
				,UP.Department,UP.ExternalId,UP.DialerType,UP.Remarks,UP.IsActive,@CreatedBy
			FROM C3_UserProfile(NOLOCK)UP
			INNER JOIN #TmbTblC3DeleteUser TMP
			ON UP.UserID = TMP.UserID AND UP.VendorID = TMP.VendorID

			DELETE UP 
			FROM C3_UserProfile UP
			INNER JOIN #TmbTblC3DeleteUser TMP
			ON UP.UserID = TMP.UserID AND UP.VendorID = TMP.VendorID

		COMMIT TRANSACTION
		SET @Result = 'Success' 
	END TRY  
	BEGIN CATCH
		BEGIN TRY ROLLBACK TRANSACTION END TRY BEGIN CATCH END CATCH  
		SET @Result = ERROR_MESSAGE()  
		INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)  
		VALUES('RCDeleteUser','RingCentral',@CreatedBy,'Deleteuser-DB',GETDATE(),@Result)   
	END CATCH  
IF OBJECT_ID('tempdb..#TmbTblC3DeleteUser') IS NOT NULL DROP TABLE #TmbTblC3DeleteUser
SELECT @Result AS Result
END
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_DeleteVendor]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[C3_ADMN_DeleteVendor]
(
	@VendorID		INT
	,@CreatedBy		VARCHAR(150)
)
AS
BEGIN
	UPDATE C3_VendorMaster SET CreatedBy = @CreatedBy, IsActive = 0
	WHERE VendorID = @VendorID
END
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_EditGroup]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_ADMN_EditGroup]
(
	@VendorID INT
	,@GroupID INT
	,@GroupName VARCHAR(500)
	,@Department VARCHAR(500)
	,@Description VARCHAR(600)
	,@CreatedBy VARCHAR(150)
)
AS
BEGIN
	UPDATE C3_GroupNameInfo SET VendorID = @VendorID,GroupName = @GroupName
		,Department = @Department,[Description] = @Description
		,CreatedBy = @CreatedBy, ModifiedOn = GETDATE()		
	WHERE GroupID = @GroupID
END
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_EditUser]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_ADMN_EditUser]
(
	@Data C3_ADMN_EditUser_Type READONLY, 
	@CreatedBy	VARCHAR(150)
)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX)	
	BEGIN TRY
		IF OBJECT_ID('tempdb..#TmbTblC3EditUser') IS NOT NULL DROP TABLE #TmbTblC3EditUser

		SELECT UM.UserID,AR.Client_Id,a.VendorID,a.GroupID,a.RoleID,a.Department,a.DialerType,a.Remarks,a.IsActive
		INTO #TmbTblC3EditUser 
		FROM @Data a
		INNER JOIN C3_UserMaster(NOLOCK)UM
		ON a.NTUserName = UM.NTUserName
		INNER JOIN /*ARC_REC.dbo.ARC_REC_USER_INFO_VY*/ARC_REC_USER_INFOVY AR
		ON UM.NTUserName = AR.NT_UserName
		BEGIN TRANSACTION  
			
			INSERT INTO C3_UserProfileLog(UserID,VendorID,CustomerID,GroupID,Extension,RoleID,DirectNumber
					,Department,ExternalId,DialerType,Remarks,IsActive,ModifiedBy)
			SELECT UP.UserID,UP.VendorID,UP.CustomerID,UP.GroupID,UP.Extension,UP.RoleID,UP.DirectNumber
				,UP.Department,UP.ExternalId,UP.DialerType,UP.Remarks,UP.IsActive,@CreatedBy
			FROM C3_UserProfile(NOLOCK)UP
			INNER JOIN #TmbTblC3EditUser TMP
			ON UP.UserID = TMP.UserID AND UP.VendorID = TMP.VendorID

			UPDATE UP SET UP.CustomerID = A.Client_Id, UP.GroupID = A.GroupID,UP.RoleID = A.RoleID
						,UP.Department = A.Department,UP.Remarks = A.Remarks,UP.IsActive = A.IsActive
						,UP.DialerType = A.DialerType       
			FROM(            
					SELECT * FROM #TmbTblC3EditUser
				)A            
			INNER JOIN C3_UserProfile(NOLOCK)UP 
			ON A.UserID = UP.UserID AND A.VendorID = UP.VendorID

		COMMIT TRANSACTION
		SET @Result = 'Success' 
	END TRY  
	BEGIN CATCH
		BEGIN TRY ROLLBACK TRANSACTION END TRY BEGIN CATCH END CATCH  
		SET @Result = ERROR_MESSAGE()  
		INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)  
		VALUES('RCEditUser','RingCentral',@CreatedBy,'Edituser-DB',GETDATE(),@Result)   
	END CATCH  
IF OBJECT_ID('tempdb..#TmbTblC3EditUser') IS NOT NULL DROP TABLE #TmbTblC3EditUser
SELECT @Result AS Result
END
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_FunctionalityList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_ADMN_FunctionalityList]
(
	@Client VARCHAR(MAX)
)
AS
BEGIN	
	IF OBJECT_ID('tempdb..#TmpTblC3Client') IS NOT NULL DROP TABLE #TmpTblC3Client     
	CREATE TABLE #TmpTblC3Client(Client VARCHAR(500))        
	INSERT INTO #TmpTblC3Client        
	SELECT items FROM C3_ADMN_SplitStringfn(@Client,',') 

	SELECT UI.FunctionName 
	FROM /*ARC_REC.dbo.ARC_REC_USER_INFO_VY*/ARC_REC_USER_INFOVY(NOLOCK)UI
	INNER JOIN #TmpTblC3Client C
	ON UI.client_name = C.Client
	GROUP BY UI.FunctionName
	IF OBJECT_ID('tempdb..#TmpTblC3Client') IS NOT NULL DROP TABLE #TmpTblC3Client     
END
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_GroupMasterList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_ADMN_GroupMasterList]
(
	@VendorID INT
)
AS
BEGIN
	SELECT GroupID,GroupName,Department,[Description]
	,VendorID 
	FROM C3_GroupNameInfo(NOLOCK)
	WHERE IsActive = 1 AND VendorID = @VendorID
END
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_RolesMasterList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_ADMN_RolesMasterList]
(
	@VendorID INT
)
AS
BEGIN
	SELECT RoleID,RoleName,ApiID,[Description]
	,VendorID 
	FROM C3_VendorRole(NOLOCK)
	WHERE IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[C3_ADMN_UserList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_ADMN_UserList]
(
	@VendorID INT,
	@Client VARCHAR(MAX),
	@Functionality VARCHAR(MAX) = NULL
)
AS
BEGIN	
	IF OBJECT_ID('tempdb..#TmpTblC3User') IS NOT NULL DROP TABLE #TmpTblC3User
	IF OBJECT_ID('tempdb..#TmpTblC3Team') IS NOT NULL DROP TABLE #TmpTblC3Team
	IF OBJECT_ID('tempdb..#TmpTblC3ExUser') IS NOT NULL DROP TABLE #TmpTblC3ExUser  
	DECLARE @SQLQuery VARCHAR(MAX)  
	CREATE TABLE #TmpTblC3User(Client VARCHAR(500)) 
	CREATE TABLE #TmpTblC3Team(Functionality VARCHAR(500))  
	SET @SQLQuery = ''	
	      
	INSERT INTO #TmpTblC3User        
	SELECT items FROM C3_ADMN_SplitStringfn(@Client,',')
	
	INSERT INTO #TmpTblC3Team        
	SELECT items FROM C3_ADMN_SplitStringfn(@Functionality,',')  

	SELECT NTUserName,'Mapped' AS MappedUser
	INTO #TmpTblC3ExUser
	FROM C3_UserMaster(NOLOCK)UM
	INNER JOIN C3_UserProfile(NOLOCK)UP
	ON UM.UserID = UP.UserID
	WHERE up.VendorID = @VendorID
	
	SET @SQLQuery +='
	SELECT EMPCODE,NTUSERNAME,CLILENT,FUNCTIONNAME,LOCATIONNAME,Associate_Email
	FROM(	
		SELECT EmpCode,UI.NT_UserName AS NtUserName,UI.client_name AS Clilent
		,UI.FunctionName, NULL LocationName,Associate_Email, MappedUser
		FROM /*ARC_REC.dbo.ARC_REC_USER_INFO_VY*/ARC_REC_USER_INFOVY(NOLOCK)UI
		INNER JOIN  #TmpTblC3User US
		ON UI.client_name = US.Client
		LEFT JOIN #TmpTblC3ExUser UP
		ON UI.NT_UserName = up.NTUserName'
	
	if @Functionality IS NOT NULL
	BEGIN
		SET @SQLQuery +='
		INNER JOIN #TmpTblC3Team TM
		on UI.FunctionName = TM.Functionality'
	END
	SET @SQLQuery +='
	)x
	WHERE x.MappedUser IS NULL'
	--PRINT @SQLQuery
	EXEC(@SQLQuery)
	IF OBJECT_ID('tempdb..#TmpTblC3User') IS NOT NULL DROP TABLE #TmpTblC3User
	IF OBJECT_ID('tempdb..#TmpTblC3Team') IS NOT NULL DROP TABLE #TmpTblC3Team
	IF OBJECT_ID('tempdb..#TmpTblC3ExUser') IS NOT NULL DROP TABLE #TmpTblC3ExUser
END
GO
/****** Object:  StoredProcedure [dbo].[C3_CallRecordingExtensionsList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_CallRecordingExtensionsList]
(
	@Data C3_CallRecordingExtensions_Type READONLY
)
AS
BEGIN
TRUNCATE TABLE C3_CallRecordingExtensions
INSERT INTO C3_CallRecordingExtensions(ExternalId,extensionNumber)
SELECT ExternalId,extensionNumber FROM @Data

--	IF OBJECT_ID('tempdb..#TmpC3_CallRecordingExtensions') IS NOT NULL DROP TABLE #TmpC3_CallRecordingExtensions
--	SELECT * INTO #TmpC3_CallRecordingExtensions FROM @Data

--	/*Remove missing data*/
--	UPDATE CRE SET CRE.IsActive = 0
--	FROM(
--		SELECT *
--		FROM(
--			SELECT a.ExternalId,a.extensionNumber,cr.ID 
--			FROM  C3_CallRecordingExtensions(NOLOCK)CR 
--			LEFT JOIN #TmpC3_CallRecordingExtensions A
--			ON A.ExternalId = CR.ID AND A.extensionNumber = CR.extensionNumber
--		)x
--		WHERE x.ExternalId is null
--	) UPD
--	INNER JOIN C3_CallRecordingExtensions(NOLOCK)CRE
--	ON UPD.ID = CRE.ID
	
--	/*Insert new data*/
--	INSERT INTO C3_CallRecordingExtensions(ExternalId,extensionNumber)
--	SELECT x.ExternalId,x.extensionNumber 
--	FROM (
--		SELECT a.ExternalId,a.extensionNumber,cr.ID 
--		FROM  #TmpC3_CallRecordingExtensions A
--		LEFT JOIN C3_CallRecordingExtensions(NOLOCK)CR 
--		ON A.ExternalId = CR.ID AND A.extensionNumber = CR.extensionNumber
--		)X
--	WHERE X.ID IS NULL
--IF OBJECT_ID('tempdb..#TmpC3_CallRecordingExtensions') IS NOT NULL DROP TABLE #TmpC3_CallRecordingExtensions
END
GO
/****** Object:  StoredProcedure [dbo].[C3_FileWatcherDetails]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  StoredProcedure [dbo].[C3_FileWatcherFileInput]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  StoredProcedure [dbo].[C3_FileWatcherPath]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  StoredProcedure [dbo].[C3_GetAppLoginInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  StoredProcedure [dbo].[C3_GetAutoCallRecordingExt]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_GetAutoCallRecordingExt]
@ExtNo varchar(20)
AS
BEGIN
Select * from AhsPlatform.dbo.C3_CallRecordingExtensions where extensionNumber = @ExtNo and IsActive = 1
END
GO
/****** Object:  StoredProcedure [dbo].[C3_GetSchedulerRCLoginInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_GetSchedulerRCLoginInfo]
(
	@VendorName VARCHAR(250)
	,@AppName	VARCHAR(200)
	,@AppType	VARCHAR(200)
	,@NtUser	VARCHAR(200)
	,@IsError	INT = 0
)
AS
BEGIN

	--DECLARE	@VendorName VARCHAR(250) = 'RingCentral'
	--,@AppName	VARCHAR(200) = 'UserProfileManagementApp'
	--,@AppType	VARCHAR(200) = 'Live'
	DECLARE @ID INT, @ExtnNo VARCHAR(50),@Pass NVARCHAR(MAX)

	if EXISTS(SELECT TOP 1 DID FROM C3_RCDirectory(NOLOCK) 
		WHERE [Status] = 'Enabled' AND [Type] = 'User'
		AND @NtUser = CONVERT(VARCHAR(250), FirstName + '.' + LastName)
		AND @IsError = 0
		)
	BEGIN
		SELECT TOP 1 @ExtnNo = ExtensionNumber,
		@Pass = 'oe-cC5A02AI3kpNvVkXotj4NT5shgaORmwtQmRyF9xA'
		FROM C3_RCDirectory(NOLOCK)
		WHERE [Status] = 'Enabled' AND [Type] = 'User'
		AND @NtUser = CONVERT(VARCHAR(350), FirstName + '.' + LastName)
		AND ExtensionNumber NOT IN 
		(SELECT ExtensionNumber FROM C3_SchedulerExtension(NOLOCK))
	END
	ELSE
	BEGIN
		SELECT TOP 1 @ID = ID, @ExtnNo = ExtensionNumber,@Pass = [Password]
		FROM C3_SchedulerExtension(NOLOCK)
		WHERE IsActive = 1 ORDER BY AccessAt,ID ASC
		UPDATE C3_SchedulerExtension SET AccessAt = GETDATE() WHERE ID = @ID
	END
	
	SELECT LI.ClientID,LI.SecretID,LI.UserID,@Pass [Password],@ExtnNo Extension,LI.URLLink 
	FROM C3_AppLoginInfo(NOLOCK)LI
	INNER JOIN C3_VendorMaster(NOLOCK)VM
	ON LI.VendorID = VM.VendorID
	WHERE LI.IsActive = 1 AND VM.IsActive = 1
	AND LI.AppName = @AppName AND LI.AppType = @AppType
	AND VM.VendorName = @VendorName
END
GO
/****** Object:  StoredProcedure [dbo].[C3_MapAudioFile]    Script Date: 8/30/2020 7:13:02 PM ******/
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
GO
/****** Object:  StoredProcedure [dbo].[C3_NewAppLoginInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
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
GO
/****** Object:  StoredProcedure [dbo].[C3_RCDirectoryInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  StoredProcedure [dbo].[C3_RCSchedulerUpdate]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  StoredProcedure [dbo].[C3_RecordingIDScheduler]    Script Date: 8/30/2020 7:13:02 PM ******/
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
	
	if 	@RunOption > 0
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
		)X WHERE X.RNO > 1'
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
/****** Object:  StoredProcedure [dbo].[C3_SchedulerInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
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
		SET @SQLQuery += Char(10) + ' AND APIDisposition = '+ 
		CHAR(39) + @Input + CHAR(39)
	END
	--PRINT @SQLQuery	
	EXEC(@SQLQuery)	
END
GO
/****** Object:  StoredProcedure [dbo].[C3_SchedulerUpdate]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_SchedulerUpdate]
(
	@PhoneNumber		VARCHAR(300) = NULL,
	@CallInitiatedTime	DATETIME = NULL,
	@CallEndTime		DATETIME = NULL,
	@RecordingURL		VARCHAR(1000) = NULL,
	@CreatedBy			VARCHAR(250) = NULL,	
	@Uniqueid			VARCHAR(1000) = NULL,
	@CallDisposition	VARCHAR(500) = NULL,
	@Location			VARCHAR(300) = NULL,
	@Duration			INT = 0,	
	@CallDirection		VARCHAR(500) = NULL,
	@RecordingID		VARCHAR(500) = NULL,
	@FileLocation		VARCHAR(1000) = NULL,
	@APIReason			VARCHAR(350) = NULL,
	@APIReasonDesc		VARCHAR(500) = NULL,
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
		[Location],Duration,CallDirections,RecordingID
	INTO #TmpTblExData
	FROM ARC_AR_Callrecoding(NOLOCK) WHERE Uniqueid = @Uniqueid AND SourceAdded = 'RingCentral'
	UNION ALL
	SELECT 'C3' TName, PhoneNumber,CallInitiatedTime,CallEndTime,RecordingURL,CreatedBy,CustomerID,Uniqueid,CallDisposition,
		[Location],Duration,CallDirection,RecordingID
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
		WHERE Uniqueid = @Uniqueid
		SET @Result = 'AR-Updated' 
		if EXISTS(SELECT Uniqueid FROM #TmpTblExData WHERE Uniqueid = @Uniqueid AND TName = 'C3')
		BEGIN
			UPDATE C3_VoiceCallInfo SET PhoneNumber = @PhoneNumber ,CallInitiatedTime = @CallInitiatedTime
			,CallEndTime = @CallEndTime ,RecordingURL = @RecordingURL ,CreatedBy = @CreatedBy,CustomerID = @CustomerID
			/*,CallDisposition = @CallDisposition*/,[Location] = @Location ,Duration = @Duration
			,CallDirection = @CallDirection ,RecordingID = @RecordingID, FileLocation = @FileLocation
			,APIDisposition = @CallDisposition, APIReason = @APIReason, APIReasonDesc = @APIReasonDesc
		WHERE Uniqueid = @Uniqueid
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
/****** Object:  StoredProcedure [dbo].[C3_URLRedirect]    Script Date: 8/30/2020 7:13:02 PM ******/
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
		ON UC.CustomerID = CL.ClientID AND CL.IsActive = 1
		WHERE UI.NT_USERNAME = @Ntuser
		ORDER BY UC.TriModifyon DESC
	END
END
GO
/****** Object:  StoredProcedure [dbo].[C3_UserAccess]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_UserAccess]
(@NTUserName VARCHAR(100) = null)
AS
BEGIN

	select Id, NTLoginName, PageAccess, ControlAccess
		from C3_AdminUsers
		(nolock)
		where 1 = case when @NTUserName is null  then 1 when NTLoginName = @NTUserName then 1 else 0 end
			and IsActive = 1

END
GO
/****** Object:  StoredProcedure [dbo].[C3_VoiceCallApiErrrorInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
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
/****** Object:  StoredProcedure [dbo].[C3_VoiceCallApiInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
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
			@PageURL = ISNULL(PageURL,'V2'),
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
			FROM C3_VoiceCallInfo(NOLOCK) WHERE Uniqueid = @Uniqueid
  
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
			WHERE Uniqueid = @Uniqueid     
  
			UPDATE ARC_AR_Callrecoding SET ClaimNo = @ClaimNo, CallEndTime = @CallEndTime, CallDisposition = @APIResult 
			,Duration = @Duration, RecordingID = @RecordingID, APIURL = @RecordingURL  
			,PhoneNumber = @PhoneNumber, CallInitiatedTime = @CallInitiatedTime, CreatedBy = @CreatedBy  
			,CustomerID = @CustomerID,CallDirections = @Direction, UserDisposition = @CallDisposition   
			WHERE Uniqueid = @Uniqueid
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
/****** Object:  StoredProcedure [dbo].[C3_VoiceCallApiInfo_BCK0723]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_VoiceCallApiInfo_BCK0723]  
(  
 @ClaimNo   VARCHAR(1000) = NULL,  
 @InsuranceName  VARCHAR(1000) = NULL,  
 @PhoneNumber  VARCHAR(300) = NULL,  
 @CallInitiatedTime DATETIME = NULL,  
 @CallEndTime  DATETIME = NULL,  
 @RecordingURL  VARCHAR(1000) = NULL,  
 @CreatedBy   VARCHAR(250) = NULL,  
 @SourceAdded  VARCHAR(250) = NULL,   
 @Uniqueid   VARCHAR(1000) = NULL,  
 @CallDisposition VARCHAR(500) = NULL,  
 @Location   VARCHAR(300) = NULL,  
 @Duration   INT = 0,   
 @CallDirection  VARCHAR(500) = NULL,  
 @RecordingID  VARCHAR(500) = NULL,  
 @FileLocation  VARCHAR(1000) = NULL,  
 @IsInsert   TINYINT  
)  
AS  
BEGIN  
 DECLARE @Result VARCHAR(MAX), @CustomerID INT, @sTime DATETIME--, @rwCount BIGINT = 0  
 DECLARE @tblPHNO VARCHAR(300),@tblSTime DATETIME, @tblCreatedBy VARCHAR(250), @tblCustomerID INT  
 ,@tblCallDirection VARCHAR(500),@FileLoc VARCHAR(5)  
 BEGIN TRY               
  IF @Uniqueid IS NOT NULL  
  BEGIN  
   --SET @rwCount = 0  
   SET @SourceAdded = 'RingCentral'  
   SET @CreatedBy = REPLACE(RTRIM(LTRIM(@CreatedBy)),' ','.');  
   SET @PhoneNumber = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@PhoneNumber,'+',''),'(',''),')',''),' ',''),'-','');  
   --SET @CustomerID = 1  
   SELECT @CustomerID = CLIENT_ID FROM ARC_REC.DBO.ARC_REC_USER_INFO(NOLOCK) WHERE NT_USERNAME = @CreatedBy  
   SET @CallInitiatedTime = CASE WHEN @CallInitiatedTime IS NOT NULL THEN DATEADD(MI,330,@CallInitiatedTime) ELSE @CallInitiatedTime END     
   SET @FileLoc = null  
  
   if EXISTS(SELECT Uniqueid FROM C3_VoiceCallInfo(NOLOCK) WHERE Uniqueid = @Uniqueid)  
   BEGIN      
    /*Get existing values to review null data*/  
    SELECT @tblPHNO = PhoneNumber, @tblSTime= CallInitiatedTime, @tblCreatedBy =CreatedBy  
    , @tblCustomerID = CustomerID, @tblCallDirection = CallDirection  
    FROM C3_VoiceCallInfo(NOLOCK) WHERE Uniqueid = @Uniqueid  
  
    /*Assign existing or new values to update*/  
    SET @PhoneNumber = CASE WHEN @tblPHNO IS NULL THEN @PhoneNumber ELSE @tblPHNO END  
    SET @CallInitiatedTime = CASE WHEN @tblSTime IS NULL THEN @CallInitiatedTime ELSE @tblSTime END  
    SET @CreatedBy = CASE WHEN @tblCreatedBy IS NULL THEN @CreatedBy ELSE @tblCreatedBy END  
    SET @CustomerID = CASE WHEN @tblCustomerID IS NULL THEN @CustomerID ELSE @tblCustomerID END  
    SET @CallDirection = CASE WHEN @tblCallDirection IS NULL THEN @CallDirection ELSE @tblCallDirection END      
  
    --if @CallEndTime IS NULL  
    --BEGIN       
     if @CallInitiatedTime IS NOT NULL   
     BEGIN  
      if @Duration = 0  
      BEGIN  
       SET @Duration = DATEDIFF(SECOND,@CallInitiatedTime,GETDATE())  
       SET @FileLoc = '2'         
      END        
      SET @CallEndTime = DATEADD(SECOND,@Duration,@CallInitiatedTime)  
     END  
    --END  
    --SET @rwCount = 0  
    BEGIN TRANSACTION  
    UPDATE C3_VoiceCallInfo SET ClaimNo = @ClaimNo, CallEndTime = @CallEndTime, CallDisposition = @CallDisposition  
     ,Duration = @Duration, RecordingID = @RecordingID, RecordingURL = @RecordingURL  
     ,PhoneNumber = @PhoneNumber, CallInitiatedTime = @CallInitiatedTime, CreatedBy = @CreatedBy  
     ,CustomerID = @CustomerID,CallDirection = @CallDirection  
     ,FileLocation = @FileLoc  
    WHERE Uniqueid = @Uniqueid  
      
    --SET @rwCount = @@ROWCOUNT  
  
    UPDATE ARC_AR_Callrecoding SET ClaimNo = @ClaimNo, CallEndTime = @CallEndTime, CallDisposition = @CallDisposition  
     ,Duration = @Duration, RecordingID = @RecordingID, APIURL = @RecordingURL  
     ,PhoneNumber = @PhoneNumber, CallInitiatedTime = @CallInitiatedTime, CreatedBy = @CreatedBy  
     ,CustomerID = @CustomerID,CallDirections = @CallDirection  
    WHERE Uniqueid = @Uniqueid  
      
    --SET @rwCount = @@ROWCOUNT + @rwCount  
    COMMIT TRANSACTION  
   END  
   ELSE  
   BEGIN  
      
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
  
    --SET @rwCount = 0  
    BEGIN TRANSACTION  
    INSERT INTO C3_VoiceCallInfo(ClaimNo,InsuranceName,PhoneNumber,CallInitiatedTime,CallEndTime,RecordingURL  
     ,CreatedBy,SourceAdded ,CustomerID,Uniqueid,CallDisposition,[Location],Duration,CallDirection  
     ,RecordingID,FileLocation)  
    VALUES(@ClaimNo,@InsuranceName,@PhoneNumber,@CallInitiatedTime,@CallEndTime,@RecordingURL,@CreatedBy  
     ,@SourceAdded,@CustomerID,@Uniqueid,@CallDisposition,@Location,@Duration,@CallDirection  
     ,@RecordingID,@FileLoc)  
      
    --SET @rwCount = @@ROWCOUNT;  
    INSERT INTO ARC_AR_Callrecoding(ClaimNo,PhoneNumber,CallInitiatedTime,CallEndTime,APIURL  
     ,CreatedBy,SourceAdded ,CustomerID,Uniqueid,CallDisposition,[Location],Duration,RecordingID  
     ,IsAPI,calldate,CallDirections)  
    VALUES(@ClaimNo,@PhoneNumber,@CallInitiatedTime,@CallEndTime,@RecordingURL,@CreatedBy  
     ,@SourceAdded,@CustomerID,@Uniqueid,@CallDisposition,@Location,@Duration,@RecordingID,1  
     ,CONVERT(DATE, DATEADD(n, -630, GETDATE()))  
     ,@CallDirection)   
    --SET @rwCount = @@ROWCOUNT + @rwCount   
    COMMIT TRANSACTION    
   END  
  END      
  SET @Result = 'Success' -- + CONVERT(VARCHAR(50),@rwCount) + ' | ' + CONVERT(VARCHAR(10),@IsInsert)  
 END TRY  
 BEGIN CATCH  
 BEGIN TRY ROLLBACK TRANSACTION END TRY BEGIN CATCH END CATCH  
  SET @Result = ERROR_MESSAGE()  
  INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)  
  VALUES(@Uniqueid,@SourceAdded,@CreatedBy,'DB',GETDATE(),@Result)   
 END CATCH  
SELECT @Result AS Result    
END
GO
/****** Object:  StoredProcedure [dbo].[C3_VoiceCallApiInfo_New]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[C3_VoiceCallApiInfo_New]
(
	@ClaimNo			VARCHAR(1000) = NULL,
	@InsuranceName		VARCHAR(1000) = NULL,
	@PhoneNumber		VARCHAR(300) = NULL,
	@CallInitiatedTime	DATETIME = NULL,
	@CallEndTime		DATETIME = NULL,
	@RecordingURL		VARCHAR(1000) = NULL,
	@CreatedBy			VARCHAR(250) = NULL,
	@SourceAdded		VARCHAR(250) = NULL,	
	@Uniqueid			VARCHAR(1000) = NULL,
	@CallDisposition	VARCHAR(500) = NULL,
	@Location			VARCHAR(300) = NULL,
	@Duration			INT = 0,	
	@CallDirection		VARCHAR(500) = NULL,
	@RecordingID		VARCHAR(500) = NULL,
	@FileLocation		VARCHAR(1000) = NULL
)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX), @CustomerID INT, @sTime DATETIME, @rwCount BIGINT = 0
	DECLARE @tblPHNO VARCHAR(300),@tblSTime DATETIME, @tblCreatedBy VARCHAR(250), @tblCustomerID INT
	BEGIN TRY           
		BEGIN TRANSACTION
		IF @Uniqueid IS NOT NULL
		BEGIN

			SET @SourceAdded = 'RingCentral'
			SET @CreatedBy = REPLACE(RTRIM(LTRIM(@CreatedBy)),' ','.');
			SET @PhoneNumber = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@PhoneNumber,'+',''),'(',''),')',''),' ',''),'-','');
			SET @CustomerID = 1
			--SELECT @CustomerID = CLIENT_ID FROM ARC_REC.DBO.ARC_REC_USER_INFO(NOLOCK) WHERE NT_USERNAME = @CreatedBy
			SET @CallInitiatedTime = CASE WHEN @CallInitiatedTime IS NOT NULL THEN DATEADD(MI,330,@CallInitiatedTime) ELSE @CallInitiatedTime END
			
			if EXISTS(SELECT Uniqueid FROM C3_VoiceCallInfo(NOLOCK) WHERE Uniqueid = @Uniqueid)
			BEGIN
				
				SELECT @tblPHNO = PhoneNumber, @tblSTime= CallInitiatedTime, @tblCreatedBy =CreatedBy, @tblCustomerID = CustomerID
				FROM C3_VoiceCallInfo(NOLOCK) WHERE Uniqueid = @Uniqueid

				SET @PhoneNumber = CASE WHEN @tblPHNO IS NULL THEN @PhoneNumber ELSE @tblPHNO END
				SET @CallInitiatedTime = CASE WHEN @tblSTime IS NULL THEN @CallInitiatedTime ELSE @tblSTime END
				SET @CreatedBy = CASE WHEN @tblCreatedBy IS NULL THEN @CreatedBy ELSE @tblCreatedBy END
				SET @CustomerID = CASE WHEN @tblCustomerID IS NULL THEN @CustomerID ELSE @tblCustomerID END

				--if @CallEndTime IS NULL
				--BEGIN					
					if @CallInitiatedTime IS NOT NULL	
					BEGIN
						SET @CallEndTime = DATEADD(SECOND,@Duration,@CallInitiatedTime)
					END
				--END
				SET @rwCount = 0
				UPDATE C3_VoiceCallInfo SET ClaimNo = @ClaimNo, CallEndTime = @CallEndTime, CallDisposition = @CallDisposition
					,Duration = @Duration, RecordingID = @RecordingID, RecordingURL = @RecordingURL
					,PhoneNumber = @PhoneNumber, CallInitiatedTime = @CallInitiatedTime, CreatedBy = @CreatedBy
					,CustomerID = @CustomerID
				WHERE Uniqueid = @Uniqueid
				
				SET @rwCount = @@ROWCOUNT

				UPDATE ARC_AR_Callrecoding SET ClaimNo = @ClaimNo, CallEndTime = @CallEndTime, CallDisposition = @CallDisposition
					,Duration = @Duration, RecordingID = @RecordingID, APIURL = @RecordingURL
					,PhoneNumber = @PhoneNumber, CallInitiatedTime = @CallInitiatedTime, CreatedBy = @CreatedBy
					,CustomerID = @CustomerID
				WHERE Uniqueid = @Uniqueid
				
				SET @rwCount = @@ROWCOUNT + @rwCount
			END
			ELSE
			BEGIN
				
				if @CallInitiatedTime IS NOT NULL AND @Duration > 0
				BEGIN		
					SET @CallEndTime = DATEADD(SECOND,@Duration,@CallInitiatedTime)
				END

				SET @rwCount = 0
				INSERT INTO C3_VoiceCallInfo(ClaimNo,InsuranceName,PhoneNumber,CallInitiatedTime,CallEndTime,RecordingURL
					,CreatedBy,SourceAdded ,CustomerID,Uniqueid,CallDisposition,[Location],Duration,CallDirection
					,RecordingID,FileLocation)
				VALUES(@ClaimNo,@InsuranceName,@PhoneNumber,@CallInitiatedTime,@CallEndTime,@RecordingURL,@CreatedBy
					,@SourceAdded,@CustomerID,@Uniqueid,@CallDisposition,@Location,@Duration,@CallDirection
					,@RecordingID,@FileLocation)
				
				SET @rwCount = @@ROWCOUNT;

				INSERT INTO ARC_AR_Callrecoding(ClaimNo,PhoneNumber,CallInitiatedTime,CallEndTime,APIURL
					,CreatedBy,SourceAdded ,CustomerID,Uniqueid,CallDisposition,[Location],Duration,RecordingID,IsAPI,calldate)
				VALUES(@ClaimNo,@PhoneNumber,@CallInitiatedTime,@CallEndTime,@RecordingURL,@CreatedBy
					,@SourceAdded,@CustomerID,@Uniqueid,@CallDisposition,@Location,@Duration,@RecordingID,1
					,CONVERT(DATE, DATEADD(n, -630, GETDATE())))	
				SET @rwCount = @@ROWCOUNT + @rwCount			
			END
		END		
		COMMIT TRANSACTION
		SET @Result = 'Success - ' + CONVERT(VARCHAR(50),@rwCount)
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @Result = ERROR_MESSAGE()
		INSERT INTO C3_VoiceCallErrorLog(Uniqueid,SourceAdded,NtUserName,ErrorAt,ErrorOn,ErrorMessage)
		VALUES(@Uniqueid,@SourceAdded,@CreatedBy,'DB',GETDATE(),@Result)	
	END CATCH
SELECT @Result AS Result		
END
GO
/****** Object:  StoredProcedure [dbo].[ComponentInitiate_New1]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[ComponentInitiate_New1]           
As            
BEGIN            
Select distinct PQID, c.ComponentAssembly, FileName, t.ProcessJson, t.ProcessId from ProcessQueue p      
inner join Inventory v on v.FIN = p.FIN       
inner join PDWProcessScheduler t on t.ProcessId = v.TaskID          
inner join PDWComponentMaster c on c.ComponentId = p.ComponentID             
Where p.Status = 0              
END 
GO
/****** Object:  StoredProcedure [dbo].[CRM_GetUsersForPasswordReset]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CRM_GetUsersForPasswordReset](@DialerName varchar(10))
AS
BEGIN
	DECLARE @ExpiringDate AS DATETIME
	SET @ExpiringDate = GETDATE() - 25
	
	IF(@DialerName='')
		BEGIN
			SELECT CRML.UserName, CRML.Password, CRMDT.DailerURL FROM dbo.CRM_tUserLogin CRML
			JOIN dbo.CRM_DailerType CRMDT 
			ON CRML.Dialerid = CRMDT.Dialerid 
			WHERE CRML.PWD_Modifieddt> @ExpiringDate AND CRMDT.isActive = 1
		END
	ELSE
		BEGIN
			SELECT CRML.UserName, CRML.Password, CRMDT.DailerURL FROM dbo.CRM_tUserLogin CRML
			JOIN dbo.CRM_DailerType CRMDT 
			ON CRML.Dialerid = CRMDT.Dialerid
			WHERE CRML.PWD_Modifieddt > @ExpiringDate AND CRMDT.DialerName = @DialerName AND CRMDT.isActive = 1
		END
END
GO
/****** Object:  StoredProcedure [dbo].[CT_EchoBotLogs]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CT_EchoBotLogs]
(@MachineIp VARCHAR(60),
@BotName VARCHAR(60),
@StartTime VARCHAR(60),
@EndTime VARCHAR(60),
@Status INT,
@UserName VARCHAR(80),
@Author VARCHAR(80),
@ProcessName VARCHAR(150),
@SubProcessName VARCHAR(150))
AS
BEGIN
BEGIN TRY 
DECLARE @ErrorMessage VARCHAR(MAX)
INSERT INTO AhsPlatform.dbo.CT_BotStatus(MachineIp,BotName,StartTime,EndTime,StatusId,CreatedDate,
ModifiedDate,UserName,Author,ProcessName,SubProcessName)
VALUES(@MachineIp,@BotName,@StartTime,@EndTime,@Status,GETDATE(),GETDATE(),@UserName,@Author,@ProcessName,@SubProcessName)
SET @ErrorMessage = 'LogCreated'      
END TRY 
BEGIN CATCH 
SET @ErrorMessage = ERROR_MESSAGE() 
END CATCH 
SELECT @ErrorMessage 
END
GO
/****** Object:  StoredProcedure [dbo].[DecisionTreeDetailedARCReport]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[DecisionTreeDetailedARCReport](@fromDate datetime = null,@toDate datetime=null)  
As  
Begin  
/**  
Created by : muthamizh  
Created on : 2017-10-03  
Modified by : muthamizh  
Modified on: 2017-10-10  
Purpose : Will return detailed production   
**/  
if @fromDate is null Set @fromDate = Convert(Datetime,Convert(varchar,Convert(date,GETDATE()-1)) + ' 08:00')  
if @toDate is null Set @toDate = DateAdd(Day,1,@fromDate)  
SELECT row_number() over (order by dr.id) as SlNo  
,case when substring(Convert(varchar,cast(dr.CreatedDate as time)),0,6)  between '00:01' and '07:59'   
then convert(date,dateadd(dd,-1,dr.CreatedDate)) else convert(date,dr.CreatedDate) end as Date  
,dr.DecisionId  
,dt.Name  
,dr.UserName  
,dr.Documentation as Notes
,dr.FieldSetValues  
--,case when dr.FieldSetValues is null then '' else  
--(Select StringValue from parseJSON(dr.FieldSetValues) where NAME='Value' and parent_ID in (select  parent_ID from parseJSON(dr.FieldSetValues)  
--where replace(lower(StringValue),' ','')='payername' )) end as PayerName  
--,case when dr.FieldSetValues is null then '' else  
--(Select StringValue from parseJSON(dr.FieldSetValues) where NAME='Value' and parent_ID in (select  parent_ID from parseJSON(dr.FieldSetValues)  
--where replace(lower(StringValue),' ','')='requisition#' )) end as Requisition  
FROM [DecisionTreeResults] dr  
join [DecisionTreee] dt on dr.DecisionId = dt.DecisionId  
where isnull(dr.UserName,'empty') != 'empty'  
and dr.CreatedDate between @fromDate and @toDate  
End  


--[dbo].[DecisionTreeDetailedARCReport] '2018-01-01 08:00:00','2018-02-01 07:59:00' 
--select GETDATE() 
GO
/****** Object:  StoredProcedure [dbo].[DecisionTreeDetailedReport]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[DecisionTreeDetailedReport](@fromDate datetime = null,@toDate datetime=null)  
As  
Begin  
/**  
Created by : muthamizh  
Created on : 2017-10-03  
Modified by : muthamizh  
Modified on: 2017-10-10  
Purpose : Will return detailed production   
**/  
if @fromDate is null Set @fromDate = Convert(Datetime,Convert(varchar,Convert(date,GETDATE()-1)) + ' 08:00')  
if @toDate is null Set @toDate = DateAdd(Day,1,@fromDate)  
SELECT row_number() over (order by dr.id) as SlNo  
,case when substring(Convert(varchar,cast(dr.CreatedDate as time)),0,6)  between '00:01' and '07:59'   
then convert(date,dateadd(dd,-1,dr.CreatedDate)) else convert(date,dr.CreatedDate) end as Date  
,dr.DecisionId  
,dt.Name  
,dr.UserName  
,dr.Documentation as Notes  
,case when dr.FieldSetValues is null then '' else  
(Select StringValue from parseJSON(dr.FieldSetValues) where NAME='Value' and parent_ID in (select  parent_ID from parseJSON(dr.FieldSetValues)  
where replace(lower(StringValue),' ','')='payername' )) end as PayerName  
,case when dr.FieldSetValues is null then '' else  
(Select StringValue from parseJSON(dr.FieldSetValues) where NAME='Value' and parent_ID in (select  parent_ID from parseJSON(dr.FieldSetValues)  
where replace(lower(StringValue),' ','')='requisition#' )) end as Requisition  
FROM [AhsPlatform].[dbo].[DecisionResults] dr  
join [AhsPlatform].[dbo].[DecisionTree] dt on dr.DecisionId = dt.Id  
where isnull(dr.UserName,'empty') != 'empty'  
and dr.CreatedDate between @fromDate and @toDate  
End  
GO
/****** Object:  StoredProcedure [dbo].[DecisionTreeSummaryArcReport]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[DecisionTreeSummaryArcReport](@fromDate datetime = null,@toDate datetime=null)  
As  
Begin  
/**  
Created by : muthamizh  
Created on : 2017-10-03  
Modified by : muthamizh  
Modified on: 2017-10-12  
Purpose : Will return detailed production   
**/  
  
if @fromDate is null Set @fromDate = Convert(Datetime,Convert(varchar,Convert(date,GETDATE()-1)) + ' 08:00')  
if @toDate is null Set @toDate = DateAdd(Day,1,@fromDate)  
select   
dr.DecisionId,dt.Name  
,case when substring(Convert(varchar,cast(dr.CreatedDate as time)),0,6)  between '00:01' and '08:00'   
then convert(date,dateadd(dd,-1,Convert(date,dr.CreatedDate))) else Convert(date,dr.CreatedDate) end as Date  
,dr.UserName,COUNT(*) as [Count]  
FROM [AhsPlatform].[dbo].[DecisionTreeResults] dr  
join [AhsPlatform].[dbo].[DecisionTreee] dt on dr.DecisionId = dt.DecisionId  
where isnull(dr.UserName,'empty') != 'empty'   
and dr.CreatedDate between @fromDate and @toDate  
group by dr.DecisionId,dt.Name,dr.UserName,case when substring(Convert(varchar,cast(dr.CreatedDate as time)),0,6)  between '00:01' and '08:00'   
then dateadd(dd,-1,Convert(date,dr.CreatedDate)) else Convert(date,dr.CreatedDate) end  
End      
  
/****** Script for SelectTopNRows command from SSMS  ******/  
  
  
  --[dbo].[DecisionTreeSummaryArcReport] '2018-01-01 08:00:00','2018-02-01 07:59:00' 
GO
/****** Object:  StoredProcedure [dbo].[DecisionTreeSummaryReport]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[DecisionTreeSummaryReport](@fromDate datetime = null,@toDate datetime=null)  
As  
Begin  
/**  
Created by : muthamizh  
Created on : 2017-10-03  
Modified by : muthamizh  
Modified on: 2017-10-12  
Purpose : Will return detailed production   
**/  
  
if @fromDate is null Set @fromDate = Convert(Datetime,Convert(varchar,Convert(date,GETDATE()-1)) + ' 08:00')  
if @toDate is null Set @toDate = DateAdd(Day,1,@fromDate)  
select   
dr.DecisionId,dt.Name  
,case when substring(Convert(varchar,cast(dr.CreatedDate as time)),0,6)  between '00:01' and '08:00'   
then convert(date,dateadd(dd,-1,Convert(date,dr.CreatedDate))) else Convert(date,dr.CreatedDate) end as Date  
,dr.UserName,COUNT(*) as [Count]  
FROM [AhsPlatform].[dbo].[DecisionResults] dr  
join [AhsPlatform].[dbo].[DecisionTree] dt on dr.DecisionId = dt.Id  
where isnull(dr.UserName,'empty') != 'empty'   
and dr.CreatedDate between @fromDate and @toDate  
group by dr.DecisionId,dt.Name,dr.UserName,case when substring(Convert(varchar,cast(dr.CreatedDate as time)),0,6)  between '00:01' and '08:00'   
then dateadd(dd,-1,Convert(date,dr.CreatedDate)) else Convert(date,dr.CreatedDate) end  
End      
  
/****** Script for SelectTopNRows command from SSMS  ******/  
  
GO
/****** Object:  StoredProcedure [dbo].[DT_DataMigration]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[DT_DataMigration] 
As  
Begin  
declare @fromDate datetime =getdate()-1
declare @toDate datetime =getdate() 
INSERT INTO [CT_ProjectUsage]
           ([Project]
           ,[Process]
           --,[SubProcess]
           ,[Team]
           --,[SubTeam]
           ,[Location]
           --,[Facility]
           ,[UserName]
           ,[Date]
           ,[UsageCount]
           ,[CustomField]
           ,[Status])
		SELECT  
		'Decision Tree' as Project
		,r.Name as Process
		 --,'' as SubProcess
		,u.UserClient as Team
		 --,'' as SubTeam
        ,u.LocationName as Location
        --,'' as Facility
        ,d.[UserName]
        ,case when substring(Convert(varchar,cast(d.CreatedDate as time)),0,6)  between '00:01' and '07:59'   
  then convert(date,dateadd(dd,-1,Convert(date,d.CreatedDate))) else Convert(date,d.CreatedDate) end as Date 
 ,COUNT(*) as UsageCount 
      ,d.[CustomField]
  ,'Active' as [Status]
  FROM [dbo].[DecisionTreeResults] d 
  join [dbo].DecisionTreee r
   on d.DecisionId = r.DecisionId 
   join [dbo].PBWUserMaster u
   on d.UserName = u.UserId
   where d.CreatedDate between @fromDate and @toDate  
   group by case when substring(Convert(varchar,cast(d.CreatedDate as time)),0,6)  between '00:01' and '07:59'   
   then convert(date,dateadd(dd,-1,Convert(date,d.CreatedDate))) else Convert(date,d.CreatedDate) end 
	  ,r.Name
      ,d.[UserName]
      ,d.[CustomField]
      ,u.UserClient
      ,u.LocationName
 End 
GO
/****** Object:  StoredProcedure [dbo].[DT_TeamWiseReport]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[DT_TeamWiseReport](@fromDate datetime = null,@toDate datetime=null)  
As  
Begin  
if @fromDate is null Set @fromDate = Convert(Datetime,Convert(varchar,Convert(date,GETDATE()-1)) + ' 08:00')  
if @toDate is null Set @toDate = DateAdd(Day,1,@fromDate) 
print @fromDate
print @toDate
SELECT  d.[DecisionId]
	  ,r.Name as DT_Name
      ,d.[UserName]
      ,d.[CustomField]
      ,u.UserClient as Team
      ,u.LocationName as Location
       ,case when substring(Convert(varchar,cast(d.CreatedDate as time)),0,6)  between '00:01' and '08:00'   
then convert(date,dateadd(dd,-1,Convert(date,d.CreatedDate))) else Convert(date,d.CreatedDate) end as CreatedDate  
  FROM AhsPlatform.[dbo].[DecisionTreeResults] d 
  join AhsPlatform.[dbo].DecisionTreee r
   on d.DecisionId = r.DecisionId 
   join AhsPlatform.[dbo].PBWUserMaster u
   on d.UserName = u.UserId
   where d.CreatedDate between @fromDate and @toDate  
   order by d.DecisionId
 End 
GO
/****** Object:  StoredProcedure [dbo].[FTP_MoveBatchlist]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[FTP_MoveBatchlist](@ClientName varchar(100),@ProcessName varchar(30),@FiletakenPath varchar(300),@FilePlacedPath varchar(500),@Batchinfo Batchdetails readonly)  
 as  
 begin  
  insert into FTPMovement_Track (ClientName,ProcessName,ProcessDate,BatchNo,FiletakenPath,FilePlacedPath,FileTakenPathSize,FileplacedpathSize,FilePlacedStatus,ProcessCheck) 
  select @ClientName,@ProcessName,Convert(Date,getdate()),a.batchno,@FiletakenPath,@FilePlacedPath,a.FileTakenPathSize,a.FilePlacedPath,1,getdate()   
  from @Batchinfo a left join FTPMovement_Track b on a.Batchno=b.batchno where b.batchno is null  
    
 End  
GO
/****** Object:  StoredProcedure [dbo].[FTP_pacific_pProcesslist]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[FTP_pacific_pProcesslist](@ClientName varchar(100),@SubCenter VARCHAR(50),@ApplicationName VARCHAR(15),@ProcessName varchar(30),@FileServerPath varchar(300),@FileClientPath varchar(500),@Batchinfo FileNameDetails readonly)  
 AS  
 BEGIN  
  INSERT INTO ftp_pacific_tProcess (ClientName,SubCenter,ApplicationName,ProcessName,ProcessDate,FileName,FileServerPath,FileClientPath,FileSizeinServer,FileSizeinClient,FileStatus,ProcessDateTime) 
  SELECT @ClientName,@SubCenter,@ApplicationName,@ProcessName,Convert(Date,getdate()),bat.FileName,@FileServerPath,@FileClientPath,bat.FileSizeinServer,bat.FileSizeinClient,1,getdate()   
  FROM  @Batchinfo bat  left join ftp_pacific_tProcess pr ON bat.FileName=pr.FileName where pr.FileName  is null      
 END 
GO
/****** Object:  StoredProcedure [dbo].[FTP_pGetHolidaylist]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROC [dbo].[FTP_pGetHolidaylist](@processName VARCHAR(100),@Holidaydate VARCHAR(10))
 AS
 BEGIN
 SELECT  CASE WHEN Holiday_Date=@Holidaydate THEN 1 ELSE 0 END Holiday FROM FTP_tHolidaylist WHERE ClientName=@processName
 END
GO
/****** Object:  StoredProcedure [dbo].[FTP_pGetMail]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 Create Proc [dbo].[FTP_pGetMail](@ProcessName Varchar(30))
 as
 begin
 Select From_Mailid,To_Mailid,Cc_Mailid from FTP_tMailDetails where ProcessName=@ProcessName and isactive=1

 End  
GO
/****** Object:  StoredProcedure [dbo].[GetAthenaDTUtilizationRpt]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetAthenaDTUtilizationRpt]
as begin
declare @fromDate datetime =getdate()-1
declare @toDate datetime =getdate()
--declare @fromDate datetime ='2017-10-03 21:18:40.990'
--declare @toDate datetime ='2018-08-29 13:12:26.443'
--if @fromDate is null Set @fromDate = Convert(Datetime,Convert(varchar,Convert(date,GETDATE()-1)) + ' 08:00')  
--if @toDate is null Set @toDate = DateAdd(Day,1,@fromDate) 
SELECT   case when substring(Convert(varchar,cast(d.CreatedDate as time)),0,6)  between '00:01' and '07:59'   
then convert(date,dateadd(dd,-1,Convert(date,d.CreatedDate))) else Convert(date,d.CreatedDate) end as Date 
	  ,r.Name as DT_Name
      ,d.[UserName]
      ,d.[CustomField]
      ,u.UserClient as Team
      ,u.LocationName as Location
      ,u.DepartmentName
       ,COUNT(*) as [Count] 
  FROM [ARC_AhsPlatform].[dbo].[DecisionTreeResults] d 
  join [ARC_AhsPlatform].[dbo].DecisionTreee r
   on d.DecisionId = r.DecisionId 
   join [ARC_AhsPlatform].[dbo].PBWUserMaster u
   on d.UserName = u.UserId
   where d.CreatedDate between @fromDate and @toDate   and u.UserClient='Athena' and r.Name in('IPN/NREVIEW','Unverified Workflow','IPN/NEREVIEW Workflow')
   group by case when substring(Convert(varchar,cast(d.CreatedDate as time)),0,6)  between '00:01' and '07:59'   
then convert(date,dateadd(dd,-1,Convert(date,d.CreatedDate))) else Convert(date,d.CreatedDate) end ,r.Name
      ,d.[UserName]
      ,d.[CustomField]
      ,u.UserClient
      ,u.LocationName
      ,u.DepartmentName 
      end
    
      --select MIN(CreatedDate) from [ARC_AhsPlatform].[dbo].DecisionTreeResults
GO
/****** Object:  StoredProcedure [dbo].[GetDesignation]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDesignation]
	(	@FETCHFOR VARCHAR(30)  = NULL,
		@REPORTING_TO VARCHAR(100) = NULL,
		@FUNCTIONNAME VARCHAR(150) = NULL
	)
	AS
	BEGIN
		
		SET NOCOUNT ON
		IF @FETCHFOR = 'FUNCTION'
				BEGIN		
					SELECT DISTINCT(FunctionName) FROM ARC_Enterprise_Dec.dbo.ARC_REC_USER_INFO_VY 					
				END
		ELSE IF @FETCHFOR = 'LEAD'
				BEGIN
					SELECT Associate, NT_UserName FROM ARC_Enterprise_Dec.dbo.ARC_REC_USER_INFO_VY WHERE REPORTING_TO= @REPORTING_TO AND D_Band = '2'
				END
		ELSE IF @FETCHFOR = 'SUPERVISOR'
				BEGIN
					SELECT Associate, NT_UserName, REPORTING_TO, D_Band FROM ARC_Enterprise_Dec.dbo.ARC_REC_USER_INFO_VY WHERE FunctionName= @FUNCTIONNAME AND D_Band not in (1,2)
				END
		ELSE IF @FETCHFOR = 'ASSOCIATE'
				BEGIN
					SELECT Associate FROM ARC_Enterprise_Dec.dbo.ARC_REC_USER_INFO_VY WHERE REPORTING_TO = @REPORTING_TO AND D_Band = '1'
				END
		SET NOCOUNT OFF
	END	




	-- exec GetDesignation @REPORTING_TO = 'Harapriya.N' , @FETCHFOR = 'LEAD'

	
GO
/****** Object:  StoredProcedure [dbo].[GetDTTemplateReport]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetDTTemplateReport]
as begin

SELECT  GETDATE() Date
      ,d.Name as Name
      --,d.DecisionId
      ,u.UserId
      ,u.UserClient
      , TemplateAdded  = (LEN(d.[Json]) - LEN(REPLACE(d.[Json], '"isDocNeeded":true', '')))/LEN('"isDocNeeded":true')
  FROM ARC_AhsPlatform.[dbo].[DecisionTreee] d 
 join ARC_AhsPlatform.[dbo].[PBWUserMaster] u on d.[UserName]=u.UserId where
  d.CustomField='ARC'
  --and u.UserClient !='Shared Services'
 and d.UserName not in ('jaiganesh.s','arunkumar.p','muthamizhsel.tm','karthiknainar.c') 
 --order by u.UserClient
 union
 SELECT  GETDATE() Date
      ,d.Name as Name
      --,d.DecisionId
      ,u.UserId
      ,u.UserClient
      , TemplateAdded  = (LEN(d.[Json]) - LEN(REPLACE(d.[Json], '"isDocNeeded":true', '')))/LEN('"isDocNeeded":true')
  FROM ARC_AhsPlatform.[dbo].[DecisionTreee] d 
 join ARC_AhsPlatform.[dbo].[PBWUserMaster] u on d.[UserName]=u.UserId where
  d.CustomField='NONARC'
  and u.UserClient   in ('PST','ABS')
 and d.UserName not in ('jaiganesh.s','arunkumar.p','muthamizhsel.tm','karthiknainar.c') 
 order by u.UserClient

  end
GO
/****** Object:  StoredProcedure [dbo].[GetIJPCandiateStatusCount]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetIJPCandiateStatusCount]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT,
	@UserId VARCHAR(256) =''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- EXEC GetIJPCandiateStatusCount 11
    -- Insert statements for procedure here
	IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL
       DROP TABLE #TempFindRules
    IF OBJECT_ID('TEMPDB..#TempFindRules1') IS NOT NULL
       DROP TABLE #TempFindRules1
	IF @UserId =''
	BEGIN
		SELECT LEFT(Status,CHARINDEX('"',Status)-1) Status INTO #TempFindRules FROM (
			SELECT RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"CurrentStatus","Value":"%',DATAJSON)-LEN('"Key":"CurrentStatus","Value":"')+1) Status FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId
		)X
		
		SELECT
			SUM(1) AppliedCnt,
			SUM(CASE WHEN Status = 'Scheduled' THEN 1 END) ScheduledCnt,
			SUM(CASE WHEN Status = 'Attended' THEN 1 END) AttendedCnt,
			SUM(CASE WHEN Status = 'AwaitingResult' THEN 1 END) AwaitingResultCnt,
			SUM(CASE WHEN Status = 'Selected' THEN 1 END) SelectedCnt,
			SUM(CASE WHEN Status = 'Rejected' THEN 1 END) RejectedCnt
		FROM #TempFindRules
	END
	ELSE
	BEGIN
		SELECT LEFT(Status,CHARINDEX('"',Status)-1) Status INTO #TempFindRules1 FROM (
			SELECT RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"CurrentStatus","Value":"%',DATAJSON)-LEN('"Key":"CurrentStatus","Value":"')+1) Status FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId
		)X
		
		SELECT
			SUM(1) AppliedCnt,
			SUM(CASE WHEN Status = 'Scheduled' THEN 1 END) ScheduledCnt,
			SUM(CASE WHEN Status = 'Attended' THEN 1 END) AttendedCnt,
			SUM(CASE WHEN Status = 'AwaitingResult' THEN 1 END) AwaitingResultCnt,
			SUM(CASE WHEN Status = 'Selected' THEN 1 END) SelectedCnt,
			SUM(CASE WHEN Status = 'Rejected' THEN 1 END) RejectedCnt
		FROM #TempFindRules1
	END
 
END
GO
/****** Object:  StoredProcedure [dbo].[GetIJPStatusCount]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetIJPStatusCount]
	-- Add the parameters for the stored procedure here
	@WorkflowIJPId INT,
	@WorkflowId INT,	
	@UserId VARCHAR(256) =''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- EXEC GetIJPStatusCount 502,11,'surendher.s'
    -- Insert statements for procedure here
    IF ISNULL(@UserId,'') = ''
    BEGIN
		SELECT 
			SUM(1) OverAllCnt,ISNULL(SUM(1),0) - ISNULL(SUM(CASE WHEN Status = 'Closed' THEN 1 END),0) OpenedCnt,SUM(CASE WHEN Status = 'Closed' THEN 1 END) ClosedCnt 
		FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowIJPId
	END
	ELSE
	BEGIN		
		SELECT 
			SUM(1) OverAllCnt,ISNULL(SUM(1),0)- ISNULL(SUM(CASE WHEN Status = 'Closed' THEN 1 END),0) OpenedCnt,SUM(CASE WHEN Status = 'Closed' THEN 1 END) ClosedCnt 
		FROM PBWWorkflowTransaction AS T INNER JOIN 
		(SELECT LEFT(IJPId,CHARINDEX('"',IJPId)-1) IJPId FROM(
			SELECT RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"IJPId","Value":"%',DATAJSON)-LEN('"Key":"IJPId","Value":"')+1) IJPId FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId
		)X)Y ON T.FIN = Y.IJPId 
		WHERE WorkflowId = @WorkflowIJPId
	END 
END
GO
/****** Object:  StoredProcedure [dbo].[GetItemBasedVendorList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetItemBasedVendorList]      
 -- Add the parameters for the stored procedure here      
 @WorkflowId INT,
 @ItemName Nvarchar(200)       
   
AS    
BEGIN  
--exec  GetItemBasedVendorList 3
select distinct V.VendorId,V.Name from PVendors v
inner join PItemVendorMapping VM
on v.VendorId=VM.VendorId
inner join PItems p
on p.ItemId=VM.ItemId where p.Name=@ItemName and p.Wfid=@WorkflowId  
END    
  
  
    
    
GO
/****** Object:  StoredProcedure [dbo].[GetItemDetails]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetItemDetails]                  
  @WorkflowId INT ,      
  @Item nvarchar(100)
AS                  
BEGIN                  
 SET NOCOUNT ON;                  

select VM.Description,VM.Price,V.Name,V.VendorEmail,V.Address  from PItems VM
Inner join PItemVendorMapping IVM ON VM.ItemId=IVM.ItemId
left Join PVendors V on V.VendorId=IVM.VendorId where VM.Name like '%'+@Item +'%'
 End
 
GO
/****** Object:  StoredProcedure [dbo].[GetIVRCallDuration]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIVRCallDuration]
	(	@FETCHFOR VARCHAR(30)  = NULL,
		@DEPARTMENT VARCHAR(100) = NULL,
		@SUPERVISOR VARCHAR(150) = NULL,
		@TEAMLEADER VARCHAR(150) = NULL,
		@ASSOCIATE VARCHAR(150) = NULL,
		@STARTDATE DATETIME = NULL,
		@ENDDATE DATETIME = NULL
	)
	AS
	BEGIN
		
		SET NOCOUNT ON

		IF @FETCHFOR = 'LIST'
			BEGIN
			IF @DEPARTMENT IS NOT NULL AND @SUPERVISOR IS NULL AND @TEAMLEADER IS NULL  AND @ASSOCIATE IS NULL
				BEGIN	
					IF @STARTDATE IS NULL AND @ENDDATE IS NULL 
						BEGIN
							SELECT DEPARTMENT, COUNT(*) AS CALLS,
							IVRhour = SUM(DATEDIFF(HOUR, '00:00:00',  IVR)),IVRmin = SUM(DATEDIFF(MINUTE, '00:00:00', IVR)),IVRsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', IVR)),2) as int),
							VOICEhour = SUM(DATEDIFF(HOUR, '00:00:00', VOICE)),VOICEmin = SUM(DATEDIFF(MINUTE, '00:00:00', VOICE)),VOICEsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', VOICE)), 2) AS INT), 
							HOLDhour = SUM(DATEDIFF(HOUR, '00:00:00', HOLD)),HOLDmin = SUM(DATEDIFF(MINUTE, '00:00:00', HOLD)),HOLDsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', HOLD)), 2) AS INT) ,
							TOTALhour = SUM(DATEDIFF(HOUR, '00:00:00', TOTAL)),TOTALmin = SUM(DATEDIFF(MINUTE, '00:00:00', TOTAL)),TOTALsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', TOTAL)), 2) AS INT) 
							FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT GROUP BY DEPARTMENT
						END
						
					ELSE
						BEGIN
							SELECT DEPARTMENT, COUNT(*) AS CALLS,
							IVRhour = SUM(DATEDIFF(HOUR, '00:00:00',  IVR)),IVRmin = SUM(DATEDIFF(MINUTE, '00:00:00', IVR)),IVRsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', IVR)),2) as int),
							VOICEhour = SUM(DATEDIFF(HOUR, '00:00:00', VOICE)),VOICEmin = SUM(DATEDIFF(MINUTE, '00:00:00', VOICE)),VOICEsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', VOICE)), 2) AS INT), 
							HOLDhour = SUM(DATEDIFF(HOUR, '00:00:00', HOLD)),HOLDmin = SUM(DATEDIFF(MINUTE, '00:00:00', HOLD)),HOLDsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', HOLD)), 2) AS INT) ,
							TOTALhour = SUM(DATEDIFF(HOUR, '00:00:00', TOTAL)),TOTALmin = SUM(DATEDIFF(MINUTE, '00:00:00', TOTAL)),TOTALsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', TOTAL)), 2) AS INT) 
							FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND WORKED_DATE >=@STARTDATE AND WORKED_DATE<=@ENDDATE  GROUP BY DEPARTMENT
						END	
					
				END
			ELSE IF @DEPARTMENT IS NOT NULL AND @SUPERVISOR IS NOT NULL  AND @TEAMLEADER IS NULL AND @ASSOCIATE IS NULL
				BEGIN 
				
					IF @STARTDATE IS NULL AND @ENDDATE IS NULL
						BEGIN
						SELECT  DEPARTMENT, COUNT(*) AS CALLS,
							IVRhour = SUM(DATEDIFF(HOUR, '00:00:00', IVR)),IVRmin = SUM(DATEDIFF(MINUTE, '00:00:00', IVR)),IVRsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', IVR)),2) as int),
							VOICEhour = SUM(DATEDIFF(HOUR, '00:00:00', VOICE)),VOICEmin = SUM(DATEDIFF(MINUTE, '00:00:00', VOICE)),VOICEsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', VOICE)), 2) AS INT) ,
							HOLDhour = SUM(DATEDIFF(HOUR, '00:00:00', HOLD)),HOLDmin = SUM(DATEDIFF(MINUTE, '00:00:00', HOLD)),HOLDsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', HOLD)), 2) AS INT) ,
							TOTALhour = SUM(DATEDIFF(HOUR, '00:00:00', TOTAL)),TOTALmin = SUM(DATEDIFF(MINUTE, '00:00:00', TOTAL)),TOTALsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', TOTAL)), 2) AS INT) 
							FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO IN (SELECT NT_UserName FROM ARC_Enterprise_Feb2019.dbo.ARC_REC_USER_INFO_VY WHERE REPORTING_TO = @SUPERVISOR AND FunctionName = @DEPARTMENT AND D_Band  in (2))
							GROUP BY DEPARTMENT 
						END
					ELSE
						BEGIN
							SELECT  DEPARTMENT, COUNT(*) AS CALLS,
							IVRhour = SUM(DATEDIFF(HOUR, '00:00:00', IVR)),IVRmin = SUM(DATEDIFF(MINUTE, '00:00:00', IVR)),IVRsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', IVR)),2) as int),
							VOICEhour = SUM(DATEDIFF(HOUR, '00:00:00', VOICE)),VOICEmin = SUM(DATEDIFF(MINUTE, '00:00:00', VOICE)),VOICEsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', VOICE)), 2) AS INT) ,
							HOLDhour = SUM(DATEDIFF(HOUR, '00:00:00', HOLD)),HOLDmin = SUM(DATEDIFF(MINUTE, '00:00:00', HOLD)),HOLDsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', HOLD)), 2) AS INT) ,
							TOTALhour = SUM(DATEDIFF(HOUR, '00:00:00', TOTAL)),TOTALmin = SUM(DATEDIFF(MINUTE, '00:00:00', TOTAL)),TOTALsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', TOTAL)), 2) AS INT) 
							FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO IN (SELECT NT_UserName FROM ARC_Enterprise_Feb2019.dbo.ARC_REC_USER_INFO_VY WHERE REPORTING_TO = @SUPERVISOR AND FunctionName = @DEPARTMENT AND D_Band  in (2)) 
							AND WORKED_DATE >=@STARTDATE AND WORKED_DATE<=@ENDDATE GROUP BY DEPARTMENT 
						END
					
				END
			ELSE IF @DEPARTMENT IS NOT NULL AND @SUPERVISOR IS NOT NULL AND @TEAMLEADER IS NOT NULL  AND  @ASSOCIATE IS NULL
				BEGIN
					IF @STARTDATE IS NULL AND @ENDDATE IS NULL
						BEGIN
						SELECT REPORTING_TO, DEPARTMENT,  COUNT(*) AS CALLS,
							IVRhour = SUM(DATEDIFF(HOUR, '00:00:00', IVR)),IVRmin = SUM(DATEDIFF(MINUTE, '00:00:00', IVR)),IVRsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', IVR)),2) as int),
							VOICEhour = SUM(DATEDIFF(HOUR, '00:00:00', VOICE)),VOICEmin = SUM(DATEDIFF(MINUTE, '00:00:00', VOICE)),VOICEsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', VOICE)), 2) AS INT) ,
							HOLDhour = SUM(DATEDIFF(HOUR, '00:00:00', HOLD)),HOLDmin = SUM(DATEDIFF(MINUTE, '00:00:00', HOLD)),HOLDsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', HOLD)), 2) AS INT) ,
							TOTALhour = SUM(DATEDIFF(HOUR, '00:00:00', TOTAL)),TOTALmin = SUM(DATEDIFF(MINUTE, '00:00:00', TOTAL)),TOTALsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', TOTAL)), 2) AS INT) 
							FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO = @TEAMLEADER   GROUP BY DEPARTMENT, REPORTING_TO
						END
					ELSE
						BEGIN
							SELECT REPORTING_TO, DEPARTMENT,  COUNT(*) AS CALLS,
							IVRhour = SUM(DATEDIFF(HOUR, '00:00:00', IVR)),IVRmin = SUM(DATEDIFF(MINUTE, '00:00:00', IVR)),IVRsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', IVR)),2) as int),
							VOICEhour = SUM(DATEDIFF(HOUR, '00:00:00', VOICE)),VOICEmin = SUM(DATEDIFF(MINUTE, '00:00:00', VOICE)),VOICEsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', VOICE)), 2) AS INT) ,
							HOLDhour = SUM(DATEDIFF(HOUR, '00:00:00', HOLD)),HOLDmin = SUM(DATEDIFF(MINUTE, '00:00:00', HOLD)),HOLDsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', HOLD)), 2) AS INT) ,
							TOTALhour = SUM(DATEDIFF(HOUR, '00:00:00', TOTAL)),TOTALmin = SUM(DATEDIFF(MINUTE, '00:00:00', TOTAL)),TOTALsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', TOTAL)), 2) AS INT) 
							FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO = @TEAMLEADER AND WORKED_DATE >=@STARTDATE AND WORKED_DATE<=@ENDDATE GROUP BY DEPARTMENT, REPORTING_TO
						END
					
				END
			ELSE IF @DEPARTMENT IS NOT NULL AND @SUPERVISOR IS NOT NULL AND @TEAMLEADER IS NOT NULL  AND  @ASSOCIATE IS NOT NULL
				BEGIN
					IF @STARTDATE IS NULL AND @ENDDATE IS NULL
						BEGIN
						SELECT USERNAME,REPORTING_TO, DEPARTMENT,  COUNT(*) AS CALLS,
							IVRhour = SUM(DATEDIFF(HOUR, '00:00:00', IVR)),IVRmin = SUM(DATEDIFF(MINUTE, '00:00:00', IVR)),IVRsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', IVR)),2) as int),
							VOICEhour = SUM(DATEDIFF(HOUR, '00:00:00', VOICE)),VOICEmin = SUM(DATEDIFF(MINUTE, '00:00:00', VOICE)),VOICEsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', VOICE)), 2) AS INT) ,
							HOLDhour = SUM(DATEDIFF(HOUR, '00:00:00', HOLD)),HOLDmin = SUM(DATEDIFF(MINUTE, '00:00:00', HOLD)),HOLDsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', HOLD)), 2) AS INT) ,
							TOTALhour = SUM(DATEDIFF(HOUR, '00:00:00', TOTAL)),TOTALmin = SUM(DATEDIFF(MINUTE, '00:00:00', TOTAL)),TOTALsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', TOTAL)), 2) AS INT) 
							FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO = @TEAMLEADER AND USERNAME = @ASSOCIATE  GROUP BY DEPARTMENT, REPORTING_TO, USERNAME
						END
					ELSE
						BEGIN
							SELECT USERNAME,REPORTING_TO, DEPARTMENT,  COUNT(*) AS CALLS,
							IVRhour = SUM(DATEDIFF(HOUR, '00:00:00', IVR)),IVRmin = SUM(DATEDIFF(MINUTE, '00:00:00', IVR)),IVRsec = CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', IVR)),2) as int),
							VOICEhour = SUM(DATEDIFF(HOUR, '00:00:00', VOICE)),VOICEmin = SUM(DATEDIFF(MINUTE, '00:00:00', VOICE)),VOICEsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', VOICE)), 2) AS INT) ,
							HOLDhour = SUM(DATEDIFF(HOUR, '00:00:00', HOLD)),HOLDmin = SUM(DATEDIFF(MINUTE, '00:00:00', HOLD)),HOLDsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', HOLD)), 2) AS INT) ,
							TOTALhour = SUM(DATEDIFF(HOUR, '00:00:00', TOTAL)),TOTALmin = SUM(DATEDIFF(MINUTE, '00:00:00', TOTAL)),TOTALsec =CAST(LEFT(SUM(DATEDIFF(SECOND, '00:00:00', TOTAL)), 2) AS INT) 
							FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO = @TEAMLEADER AND USERNAME = @ASSOCIATE AND WORKED_DATE >=@STARTDATE AND WORKED_DATE<=@ENDDATE GROUP BY DEPARTMENT, REPORTING_TO, USERNAME
						END
					
				END
			END
		ELSE IF @FETCHFOR = 'DEPARTMENTLIST'
			BEGIN 
				IF @DEPARTMENT IS NOT NULL AND @SUPERVISOR IS NULL AND @TEAMLEADER IS NULL  AND @ASSOCIATE IS NULL
				BEGIN	
					IF @STARTDATE IS NULL AND @ENDDATE IS NULL 
						BEGIN
							SELECT USERNAME,CALL_ID,IVR,VOICE,HOLD,TOTAL,CREATED_USER,convert(varchar(10),CREATED_DATE,101) as CREATED_DATE  FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT
							
						END
					ELSE
						BEGIN
							SELECT USERNAME,CALL_ID,IVR,VOICE,HOLD,TOTAL,CREATED_USER,convert(varchar(10),CREATED_DATE,101) as CREATED_DATE FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND WORKED_DATE >=@STARTDATE AND WORKED_DATE<=@ENDDATE 
							
						END
				END
				ELSE IF @DEPARTMENT IS NOT NULL AND @SUPERVISOR IS NOT NULL  AND @TEAMLEADER IS NULL AND @ASSOCIATE IS NULL
					BEGIN	
						IF @STARTDATE IS NULL AND @ENDDATE IS NULL 
							BEGIN
								SELECT  USERNAME,CALL_ID,IVR,VOICE,HOLD,TOTAL,CREATED_USER,convert(varchar(10),CREATED_DATE,101) as CREATED_DATE FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO IN (SELECT NT_UserName FROM ARC_Enterprise_Feb2019.dbo.ARC_REC_USER_INFO_VY WHERE REPORTING_TO = @SUPERVISOR AND FunctionName = @DEPARTMENT AND D_Band =2)
							END
						ELSE
							BEGIN
								SELECT  USERNAME,CALL_ID,IVR,VOICE,HOLD,TOTAL,CREATED_USER,convert(varchar(10),CREATED_DATE,101) as CREATED_DATE
								FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO IN (SELECT NT_UserName FROM ARC_Enterprise_Feb2019.dbo.ARC_REC_USER_INFO_VY WHERE REPORTING_TO = @SUPERVISOR AND FunctionName = @DEPARTMENT AND D_Band  in (2)) 
								AND WORKED_DATE >=@STARTDATE AND WORKED_DATE<=@ENDDATE 
							
							END
					END
				ELSE IF @DEPARTMENT IS NOT NULL AND @SUPERVISOR IS NOT NULL AND @TEAMLEADER IS NOT NULL  AND  @ASSOCIATE IS NULL
					BEGIN	
						IF @STARTDATE IS NULL AND @ENDDATE IS NULL 
							BEGIN
								SELECT USERNAME,CALL_ID,IVR,VOICE,HOLD,TOTAL,CREATED_USER,convert(varchar(10),CREATED_DATE,101) as CREATED_DATE FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO = @TEAMLEADER

							END
						ELSE
							BEGIN
								SELECT USERNAME,CALL_ID,IVR,VOICE,HOLD,TOTAL,CREATED_USER,convert(varchar(10),CREATED_DATE,101) as CREATED_DATE FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO = @TEAMLEADER AND WORKED_DATE >=@STARTDATE AND WORKED_DATE<=@ENDDATE 

							END
					END
				ELSE IF @DEPARTMENT IS NOT NULL AND @SUPERVISOR IS NOT NULL AND @TEAMLEADER IS NOT NULL  AND  @ASSOCIATE IS NOT NULL
					BEGIN	
						IF @STARTDATE IS NULL AND @ENDDATE IS NULL 
							BEGIN
								SELECT USERNAME,CALL_ID,IVR,VOICE,HOLD,TOTAL,CREATED_USER,convert(varchar(10),CREATED_DATE,101) as CREATED_DATE FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO = @TEAMLEADER AND USERNAME = @ASSOCIATE
							END
						ELSE
							BEGIN
								SELECT USERNAME,CALL_ID,IVR,VOICE,HOLD,TOTAL,CREATED_USER,convert(varchar(10),CREATED_DATE,101) as CREATED_DATE
								FROM ARC_ECHOREV WHERE DEPARTMENT = @DEPARTMENT AND REPORTING_TO = @TEAMLEADER AND USERNAME = @ASSOCIATE AND WORKED_DATE >=@STARTDATE AND WORKED_DATE<=@ENDDATE 

							END
					END
			END

		SET NOCOUNT OFF
	END	




	-- EXEC GetIVRCallDuration @FETCHFOR = 'DEPARTMENTLIST', @DEPARTMENT = 'Operations - Billing', @SUPERVISOR = 'manigandan.j',@TEAMLEADER = 'rajesh.ramadoss', @ASSOCIATE = 'Hemalatha Subash', @STARTDATE = '2019-07-22', @ENDDATE = '2019-07-22'
	
GO
/****** Object:  StoredProcedure [dbo].[GetLastOrderPrice]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                    
-- Author:  <Sivasankar.s1>                    
-- Create date: <21092018>                    
-- =============================================    
CREATE PROCEDURE [dbo].[GetLastOrderPrice]                    
  @WorkflowId INT ,        
  @VendorName nvarchar(100),        
  @ItemDesc nvarchar(100),      
   @Final  Nvarchar(100) output           
                   
AS                    
BEGIN                    
  -- exec GetLastOrderPrice 3 ,'Vendor','Testing' out            
 -- SET NOCOUNT ON added to prevent extra result sets from                    
 -- interfering with SELECT statements.                    
 SET NOCOUNT ON;                    
--exec uspTATMail 3                
   IF OBJECT_ID('TEMPDB..##TempPoPending1') IS NOT NULL            
  DROP TABLE ##TempPoPending1        
  IF OBJECT_ID('TEMPDB..##TempPoPending2') IS NOT NULL            
  DROP TABLE ##TempPoPending2        
  IF OBJECT_ID('TEMPDB..##TempPoPending3') IS NOT NULL          
  DROP TABLE ##TempPoPending3        
 --declare @Final as Nvarchar(100);         
          
   select CreatedDate,TranRefID into ##TempPoPending1 from rptTransaction where WorkflowId = 3 AND LogId = 0 and SourceColumn=''  and WorkFlowStateId=-29     
   select nvarchar1 djdf_VendorName,float2 djdf_Final,TranRefID into ##TempPoPending2 from rptTransaction where SourceColumn='djdf_Vendor'  and WorkFlowStateId=-29           
   select nvarchar2 djdf_PRItemDescription,TranRefID into ##TempPoPending3 from rptTransaction where WorkflowId = 3 AND LogId = 0 AND SourceColumn = 'djdf_Item'  and WorkFlowStateId=-29            
           
  set @Final= (select top 1 djdf_Final Final from ##TempPoPending1 t1         
   left outer join ##TempPoPending2 t2 on t1.tranrefid=t2.tranrefid        
   left outer join ##TempPoPending3 t3 on t2.tranrefid=t3.tranrefid  where djdf_VendorName=@VendorName and djdf_PRItemDescription=@ItemDesc)        
                  
return  @Final     
print  @Final    
 IF OBJECT_ID('TEMPDB..##TempPoPending1') IS NOT NULL            
  DROP TABLE ##TempPoPending1        
  IF OBJECT_ID('TEMPDB..##TempPoPending2') IS NOT NULL            
  DROP TABLE ##TempPoPending2        
  IF OBJECT_ID('TEMPDB..##TempPoPending3') IS NOT NULL          
  DROP TABLE ##TempPoPending3        
  End
  
  
GO
/****** Object:  StoredProcedure [dbo].[GetNetworkCategoryList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNetworkCategoryList]      
 -- Add the parameters for the stored procedure here      
 @WorkflowId INT       
   
AS    
BEGIN   
--exec GetNetworkCategoryList 3 
select Value from PBWMasterData where Field='NetworkCategory' and WorkflowId=@WorkflowId
--where workflowid=3    
END    
  
  
    
    
GO
/****** Object:  StoredProcedure [dbo].[GetNonFlowDTTemplateReport]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetNonFlowDTTemplateReport]
as begin
SELECT  GETDATE() Date
      ,d.Name as Name
      --,d.DecisionId
      ,u.UserId
      ,u.UserClient
      , TemplateAdded  = (LEN(d.[Json]) - LEN(REPLACE(d.[Json], '"isDocNeeded":true', '')))/LEN('"isDocNeeded":true')
  FROM [dbo].[DecisionTreee] d 
 join [dbo].[PBWUserMaster] u on d.[UserName]=u.UserId where
  d.CustomField='NONARC' and u.UserClient in ('PST','ABS')
  --and u.UserClient !='Shared Services'
 and d.UserName not in ('jaiganesh.s','arunkumar.p','muthamizhsel.tm','karthiknainar.c') 
 order by u.UserClient

  end
GO
/****** Object:  StoredProcedure [dbo].[GetProcItemDetails]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
          
CREATE PROCEDURE [dbo].[GetProcItemDetails]             
 -- Add the parameters for the stored procedure here            
 @WorkflowId INT,             
 @ID INT,          
 @ItemName NVARCHAR(100),          
 @NetworkCategory NVARCHAR(100)      
AS            
BEGIN          
--exec GetProcItemDetails 3,'','Symantec Endpoint renewal','Network Service'        
 -- SET NOCOUNT ON added to prevent extra result sets from            
 -- interfering with SELECT statements.            
 SET NOCOUNT ON;            
         
     IF(@NetworkCategory='Network Service')    
     BEGIN    
     Select Name,Description,1 as Quantity,Price,UOM,Mas.Value,SeatingCapacity,Kmslimit from PItems Ite        
     inner join pbwmasterdata Mas        
     On Ite.ParentCategory=Mas.MasterDataId        
     where  ite.Name=@ItemName  and wfid=@WorkflowId            
      END    
    ELSE    
    BEGIN    
        Select Name,Description,1 as Quantity,Price,UOM,'' Value, SeatingCapacity,Kmslimit from PItems        
     where  Name=@ItemName  and wfid=@WorkflowId            
    END    
        
         
END 
GO
/****** Object:  StoredProcedure [dbo].[GetProcItemDetailsbyID]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProcItemDetailsbyID]  
 -- Add the parameters for the stored procedure here  
 @WorkflowId INT,   
 @ReqID INT  
AS  
BEGIN  
--Exec GetProcItemDetailsbyID 3,1
 
 SET NOCOUNT ON;  
 select DataJson from PBWWorkflowTransaction where WorkflowId=@WorkflowId and RequestId=@ReqID
END  

GO
/****** Object:  StoredProcedure [dbo].[GetProcItemsList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[GetProcItemsList]    
 -- Add the parameters for the stored procedure here    
 @WorkflowId INT     
 
AS  
BEGIN  
select ItemId,Name from PItems where Active=1
--where workflowid=3  
END  


  
  
  
GO
/****** Object:  StoredProcedure [dbo].[GetProcOrderList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
        
CREATE PROCEDURE [dbo].[GetProcOrderList]        
            
 -- Add the parameters for the stored procedure here                  
 @WorkflowId INT,                   
 @Category NVARCHAR(50),                
 @Requestype NVARCHAR(50)                
   
AS                
BEGIN                
  
    --Exec GetProcOrderList '3','Transport Service','current order'                
      
    IF OBJECT_ID('TEMPDB..##TEMPPOPENDING0') IS NOT NULL                                
    DROP TABLE ##TempPoPending0                
    IF OBJECT_ID('TEMPDB..##TEMPPOPENDING01') IS NOT NULL                                
    DROP TABLE ##TempPoPending01                
    IF OBJECT_ID('TEMPDB..##TEMPPOPENDING02') IS NOT NULL                                
    DROP TABLE ##TempPoPending02                
    IF OBJECT_ID('TEMPDB..##TEMPPOPENDING03') IS NOT NULL                                
    DROP TABLE ##TempPoPending03         
     IF OBJECT_ID('TEMPDB..##TEMPPOPENDING04') IS NOT NULL                                
    DROP TABLE ##TempPoPending04     
     IF OBJECT_ID('TEMPDB..##TEMPPOPENDING05') IS NOT NULL                                
    DROP TABLE ##TempPoPending05          
      
    IF(LOWER(@Requestype)='renewal')        
      BEGIN                            
   SELECT DISTINCT Fin,RequestId,datetime1 djdf_ApprovedOn,TranRefID,ParentGroupNo,WorkflowId,CreatedDate,(case when nvarchar42='NA' then 0 else nvarchar42 END) OrderPeriod,        
   convert(int,( datediff(day,CreatedDate ,GETDATE())) / 365) Datedif,nvarchar43 RefID INTO  ##TEMPPOPENDING0                   
   FROM rptTransaction  WHERE WorkflowId = 3 AND LogId = 0                        
                          
   select nvarchar12 Itemcategory, nvarchar41 itemorderType, TranRefID,ParentGroupNo,WorkflowId into ##TEMPPOPENDING01               
   from rptTransaction where WorkflowId = 3 AND LogId = 0                 
   
   --'00'++'/'+CONVERT(nvarchar(5), DATEPART(YEAR,t1.createddate))
                            
    select distinct convert(varchar(5),t1.RequestId) as RequestId,  
    Itemcategory,itemorderType, t1.OrderPeriod,t1.Datedif,t1.RefID into ##TEMPPOPENDING04         
    from  ##TEMPPOPENDING0 t1         
    Inner join ##TEMPPOPENDING01 t2                
    on t1.tranrefid=t2.tranrefid  and t1.ParentGroupNo=LEFT(t2.ParentGroupNo,2)               
    where Itemcategory=@Category and t1.workflowid=3          
       
      
     select * from ##TEMPPOPENDING04 as t1 where not exists (select 1 from ##TEMPPOPENDING04 RR where RR.refid=t1.requestid)  
     and DATEDIF>OrderPeriod    
                
     END                  
   ELSE IF(LOWER(@Requestype)='current order')        
     BEGIN                            
    SELECT DISTINCT Fin,RequestId,datetime1 djdf_ApprovedOn,TranRefID,ParentGroupNo,WorkflowId,CreatedDate,(case when nvarchar42='NA' then 0 else nvarchar42 END) OrderPeriod,        
    convert(int,( datediff(day,CreatedDate ,GETDATE())) / 365) Datedif,nvarchar43 RefID INTO ##TEMPPOPENDING02                
    FROM rptTransaction  WHERE WorkflowId = 3 AND LogId = 0 and RoleId = -100                  
                          
    select nvarchar12 Itemcategory, nvarchar41 itemorderType, TranRefID,ParentGroupNo,WorkflowId into ##TEMPPOPENDING03               
    from rptTransaction where WorkflowId = 3 AND LogId = 0  and RoleId = -100                   
    
    --+'/'+CONVERT(nvarchar(5), DATEPART(YEAR,t1.createddate))
                            
    select distinct convert(varchar(5),t1.RequestId) as RequestId,  
    Itemcategory,itemorderType,OrderPeriod,t1.Datedif,t1.RefID  into ##TEMPPOPENDING05        
     from  ##TEMPPOPENDING02 t1         
    Inner join ##TEMPPOPENDING03 t2                
    on t1.tranrefid=t2.tranrefid    
    --and t1.ParentGroupNo=LEFT(t2.ParentGroupNo,2)               
    where Itemcategory=@Category and t1.workflowid=3         
     and DATEDIF<OrderPeriod    
       
      SELECT * FROM ##TEMPPOPENDING05 as t1 WHERE ISNULL(RefID,'') = ''  
      --not exists (select 1 from ##TEMPPOPENDING05 RR where RR.refid=t1.requestid)  
                     
     END                  
    IF OBJECT_ID('TEMPDB..##TEMPPOPENDING0') IS NOT NULL                                
    DROP TABLE ##TempPoPending0                
    IF OBJECT_ID('TEMPDB..##TEMPPOPENDING01') IS NOT NULL                                
    DROP TABLE ##TempPoPending01            
     IF OBJECT_ID('TEMPDB..##TEMPPOPENDING02') IS NOT NULL                                
    DROP TABLE ##TempPoPending02                
    IF OBJECT_ID('TEMPDB..##TEMPPOPENDING03') IS NOT NULL                                
    DROP TABLE ##TempPoPending03     
     IF OBJECT_ID('TEMPDB..##TEMPPOPENDING04') IS NOT NULL                                
    DROP TABLE ##TempPoPending04        
     IF OBJECT_ID('TEMPDB..##TEMPPOPENDING05') IS NOT NULL                                
    DROP TABLE ##TempPoPending05                 
                     
END         
    
GO
/****** Object:  StoredProcedure [dbo].[GetRptBudget]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
                  
-- =============================================                  
-- Author:  <Sivasankar.s1>                  
-- Create date: <31012018>                  
-- Description: <Procurment -Budget Report>                  
-- =============================================                  
CREATE PROCEDURE [dbo].[GetRptBudget]              
  @FromDate DATETIME              
 ,@ToDate DATETIME              
 ,@UserId Nvarchar(100)              
 ,@WorkflowId INT                  
                  
AS                  
BEGIN                  
--Exec GetRptBudget '09/04/2018','09/04/2018','rameshkumar.r1','3'    
                
SET NOCOUNT ON;           
                   
	IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                  
	DROP TABLE ##TEMPITEMS             
	IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                  
	DROP TABLE ##TEMPVENDORS                              
	IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                  
	DROP TABLE ##TEMPPOMAINROW             
         
			SELECT ParentGroupNo,nvarchar2 djdf_PRItemDescription,float2 djdf_PRQuantity,CreatedDate,TranRefID   
			INTO ##TEMPITEMS  
			FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_Item' and WorkflowId=3 ORDER BY ParentGroupNo  
		      
			SELECT ParentGroupNo ,nvarchar1 djdf_VendorName,nvarchar2 IsSelected,TranRefID   
			INTO ##TEMPVENDORS  
			FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_vendors'   
		      
			select ParentGroupNo,nvarchar20 facility,CreatedDate,TranRefID  
			INTO ##TEMPPOMAINROW  
			FROM  rptTransaction WHERE RequestId='1' and  logid = 0 and SourceColumn='' and WorkflowId=3  
		        
		    
			SELECT distinct facility Facility,CONVERT(nvarchar(10),TM.CreatedDate,120) order_Date,djdf_PRItemDescription [Description],djdf_VendorName Vendor_Name  
			,'' Indent_Cost          
			,'' PO_Cost,'' Amount_Paid,'' Taxes_Paid,'' Bal_Amount_to_be_Paid   
			FROM ##TEMPVENDORS TV            
			left outer join ##TEMPPOMAINROW TM ON TV.TranRefID=TM.tranrefid  
			left outer join ##TEMPITEMS TI ON TI.tranrefid=TM.tranrefid 
			-- AND TI.ParentGroupNo = LEFT(TV.ParentGroupNo,1)                         
			WHERE  CONVERT(DATE,TM.CreatedDate) between CONVERT(DATE,@FromDate)  and CONVERT(DATE,@ToDate)    
           
           
	 IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                  
	 DROP TABLE ##TEMPITEMS             
	 IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                  
	 DROP TABLE ##TEMPVENDORS                              
	 IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                  
	 DROP TABLE ##TEMPPOMAINROW                  
                  
END   

GO
/****** Object:  StoredProcedure [dbo].[GetRptCostsavings]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
                
-- =============================================                
-- Author:  <Sivasankar.s1>                
-- Create date: <31012018>                
-- Description: <Procurment -Due Date>                
-- =============================================                
CREATE PROCEDURE [dbo].[GetRptCostsavings]            
  @FromDate datetime            
 ,@ToDate datetime            
 ,@UserId  Nvarchar(100)              
 ,@WorkflowId INT                  


  --Exec GetRptCostsavings '09/04/2018','09/04/2018','rameshkumar.r1','3'    
                  
                
AS                
BEGIN                
              
  SET NOCOUNT ON;             
  
 IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                
 DROP TABLE ##TEMPITEMS           
 IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                
 DROP TABLE ##TEMPVENDORS                            
 IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                
 DROP TABLE ##TEMPPOMAINROW           
          
       
       
    SELECT ParentGroupNo,nvarchar2 djdf_PRItemDescription,float2 djdf_PRQuantity,CreatedDate,TranRefID 
    INTO ##TEMPITEMS
    FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_Items' and WorkflowId=3 ORDER BY ParentGroupNo
    
    SELECT ParentGroupNo ,nvarchar1 djdf_VendorName,nvarchar2 IsSelected,TranRefID 
    INTO ##TEMPVENDORS
    FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_vendors' 
    
    select ParentGroupNo,nvarchar20 facility,nvarchar27 djdf_PRDepartment,float3 Savings,nvarchar32 Basis_of_Savings,CreatedDate,TranRefID
    INTO ##TEMPPOMAINROW
    FROM  rptTransaction WHERE RequestId='1' and  logid = 0 and SourceColumn='' and WorkflowId=3
        
            
      
  
   SELECT distinct djdf_PRDepartment Department,facility Facility,CONVERT(Date,TM.CreatedDate,120) Order_Date,djdf_PRItemDescription [Description],djdf_VendorName VendorName
   ,'' Order_Value,TM.Savings ,TM.Basis_of_Savings 
    FROM ##TEMPVENDORS TV          
   left outer join ##TEMPPOMAINROW TM ON TV.TranRefID=TM.tranrefid
   left outer join ##TEMPITEMS TI ON TI.tranrefid=TM.tranrefid  AND TM.ParentGroupNo = LEFT(TI.ParentGroupNo,2)         
   WHERE  CONVERT(Date,TM.CreatedDate) between CONVERT(Date,@FromDate)  and CONVERT(Date,@ToDate)              
         
         
 IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                
 DROP TABLE ##TEMPITEMS           
 IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                
 DROP TABLE ##TEMPVENDORS                            
 IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                
 DROP TABLE ##TEMPPOMAINROW     
                
END 


  
GO
/****** Object:  StoredProcedure [dbo].[GetRptDueDate]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
        
-- =============================================        
-- Author:  <Sivasankar.s1>        
-- Create date: <31012018>        
-- Description: <Procurment -PO pending Report>        
-- =============================================        
CREATE PROCEDURE [dbo].[GetRptDueDate]        
 -- Add the parameters for the stored procedure here        
  @FromDate DATETIME        
 ,@ToDate DATETIME        
 ,@UserId nvarchar(100)        
 ,@WorkflowId INT          
        
AS        
BEGIN        
  IF OBJECT_ID('TEMPDB..##TempPoPending1') IS NOT NULL        
  DROP TABLE ##TempPoPending1    
  IF OBJECT_ID('TEMPDB..##TempPoPending2') IS NOT NULL        
  DROP TABLE ##TempPoPending2    
    IF OBJECT_ID('TEMPDB..##TempPoPending4') IS NOT NULL        
  DROP TABLE ##TempPoPending4    
        
         
        
  select nvarchar20 djdf_Facility,nvarchar27 djdf_PRDepartment,WorkFlowStateId,TranRefID,datetime1 djdf_ApprovedOn into ##TempPoPending1     
  from rptTransaction where WorkflowId = 3 AND LogId = 0 and SourceColumn=''      
      
  select nvarchar1 djdf_VendorName,TranRefID into ##TempPoPending2 from rptTransaction     
  where WorkflowId = 3 AND LogId = 0 AND SourceColumn = 'djdf_Vendor'     
  select nvarchar1 djdf_InvoiceNo,datetime1 djdf_InvReceivedDate,float1 djdf_Amount,TranRefID INTO ##TempPoPending4 from rptTransaction where workflowid = 3 and TranRefID =2530 and SourceColumn ='djdf_InvoiceItem' and  LogId = 0    
      
 select DISTINCT t1.djdf_Facility Facility ,t1.djdf_PRDepartment Department ,djdf_InvoiceNo Invoice_Number,CONVERT(varchar,djdf_InvReceivedDate) Invoice_Date
 ,djdf_Amount Invoice_Amount from ##TempPoPending1 t1       
  left outer join ##TempPoPending2 t2 ON t1.tranrefid=t2.tranrefid      
  left outer join ##TempPoPending4 t4 ON t2.tranrefid=t4.tranrefid     
  where CONVERT(varchar(10),t1.djdf_ApprovedOn,120) between @FromDate and @ToDate    
     
  IF OBJECT_ID('TEMPDB..##TempPoPending1') IS NOT NULL            
  DROP TABLE ##TempPoPending1          
  IF OBJECT_ID('TEMPDB..##TempPoPending2') IS NOT NULL            
  DROP TABLE ##TempPoPending2        
  IF OBJECT_ID('TEMPDB..##TempPoPending4') IS NOT NULL          
  DROP TABLE ##TempPoPending4       
          
END 
GO
/****** Object:  StoredProcedure [dbo].[GetRptGRNRecived]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
            
-- =============================================            
-- Author:  <Sivasankar.s1>            
-- Create date: <31012018>            
-- Description: <Procurment -PO pending Report>            
-- =============================================            
CREATE PROCEDURE [dbo].[GetRptGRNRecived]            
  -- Add the parameters for the stored procedure here        
  @FromDate datetime        
 ,@ToDate datetime        
 ,@UserId nvarchar(100)        
 ,@WorkflowId INT          
        
AS        
BEGIN        
 --Exec GetRptGRNRecived '09/04/2018','09/04/2018','rameshkumar.r1','3'   
         
  SET NOCOUNT ON;          
            
	IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                
	DROP TABLE ##TEMPITEMS           
	IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                
	DROP TABLE ##TEMPVENDORS                            
	IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                
	DROP TABLE ##TEMPPOMAINROW           
          
       
       
    SELECT ParentGroupNo,nvarchar2 djdf_PRItemDescription,float2 djdf_PRQuantity,CreatedDate,TranRefID 
    INTO ##TEMPITEMS
    FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_Items' and WorkflowId=3 ORDER BY ParentGroupNo
    
    SELECT ParentGroupNo ,nvarchar1 djdf_VendorName,nvarchar2 IsSelected,TranRefID 
    INTO ##TEMPVENDORS
    FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_vendors' 
    
    select ParentGroupNo,nvarchar20 facility,nvarchar27 djdf_PRDepartment,datetime1 djdf_ApprovedOn,nvarchar23 djdf_Remarks,CreatedDate,TranRefID
    INTO ##TEMPPOMAINROW
    FROM  rptTransaction WHERE RequestId='1' and  logid = 0 and SourceColumn='' and WorkflowId=3
        
            
      
  
		SELECT distinct djdf_PRDepartment Department,facility Facility,'' PO_No,CONVERT(Date,TM.djdf_ApprovedOn) PO_Date,djdf_PRItemDescription Item_Description,djdf_VendorName Vendor_Name
		,'' Ordered_Quantity,'' Unit_Rate,'' Amount,TM.djdf_Remarks
		FROM ##TEMPVENDORS TV          
		left outer join ##TEMPPOMAINROW TM ON TV.TranRefID=TM.tranrefid
		left outer join ##TEMPITEMS TI ON TI.tranrefid=TM.tranrefid  AND TM.ParentGroupNo = LEFT(TI.ParentGroupNo,2)         
		WHERE  CONVERT(Date,TM.CreatedDate) between CONVERT(Date,@FromDate)  and CONVERT(Date,@ToDate)              
         
         
 IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                
 DROP TABLE ##TEMPITEMS           
 IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                
 DROP TABLE ##TEMPVENDORS                            
 IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                
 DROP TABLE ##TEMPPOMAINROW         
 
 END
            
  
            
 
GO
/****** Object:  StoredProcedure [dbo].[GetRptInvoiceRejection]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
            
-- =============================================            
-- Author:  <Sivasankar.s1>            
-- Create date: <31012018>            
-- Description: <Procurment -InvoiceRejection>            
-- =============================================            
CREATE PROCEDURE [dbo].[GetRptInvoiceRejection]            
 -- Add the parameters for the stored procedure here        
  @FromDate datetime        
 ,@ToDate datetime        
 ,@UserId nvarchar(100)        
 ,@WorkflowId INT          
        
AS        
BEGIN        
---Exec GetRptInvoiceRejection '09/04/2018','09/04/2018','rameshkumar.r1','3'           
         
  SET NOCOUNT ON;          
            
 IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                
	DROP TABLE ##TEMPITEMS           
	IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                
	DROP TABLE ##TEMPVENDORS                            
	IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                
	DROP TABLE ##TEMPPOMAINROW           
          
       
       
    SELECT ParentGroupNo,nvarchar2 djdf_PRItemDescription,float2 djdf_PRQuantity,CreatedDate,TranRefID 
    INTO ##TEMPITEMS
    FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_Items' and WorkflowId=3 ORDER BY ParentGroupNo
    
    SELECT ParentGroupNo ,nvarchar1 djdf_VendorName,nvarchar2 IsSelected,TranRefID 
    INTO ##TEMPVENDORS
    FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_vendors' 
    
    select ParentGroupNo,nvarchar20 facility,nvarchar27 djdf_PRDepartment,datetime1 djdf_ApprovedOn,nvarchar23 djdf_Remarks,CreatedDate,TranRefID
    INTO ##TEMPPOMAINROW
    FROM  rptTransaction WHERE RequestId='1' and  logid = 0 and SourceColumn='' and WorkflowId=3
        
            
      
  
		SELECT distinct djdf_PRDepartment Department,facility Facility,'' PO_No,CONVERT(Date,TM.djdf_ApprovedOn) PO_Date,djdf_PRItemDescription Item_Description,djdf_VendorName Vendor_Name
		,'' Ordered_Quantity,'' Unit_Rate,'' Amount,TM.djdf_Remarks Remarks,'' Reason_For_Rejection
		FROM ##TEMPVENDORS TV          
		left outer join ##TEMPPOMAINROW TM ON TV.TranRefID=TM.tranrefid
		left outer join ##TEMPITEMS TI ON TI.tranrefid=TM.tranrefid  AND TM.ParentGroupNo = LEFT(TI.ParentGroupNo,2)         
		WHERE  CONVERT(Date,TM.CreatedDate) between CONVERT(Date,@FromDate)  and CONVERT(Date,@ToDate) 
		
IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                
 DROP TABLE ##TEMPITEMS           
 IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                
 DROP TABLE ##TEMPVENDORS                            
 IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                
 DROP TABLE ##TEMPPOMAINROW    
            
END 
GO
/****** Object:  StoredProcedure [dbo].[GetRptPaymentPending]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
        
-- =============================================        
-- Author:  <Sivasankar.s1>        
-- Create date: <31012018>        
-- Description: <Procurment -Payment Pending >        
-- =============================================        
CREATE PROCEDURE [dbo].[GetRptPaymentPending]      
 -- Add the parameters for the stored procedure here    
  @FromDate datetime    
 ,@ToDate datetime    
 ,@UserId datetime    
 ,@WorkflowId INT      
    
AS    
BEGIN    
---Exec GetRptPaymentPending '','','',3      
     
  SET NOCOUNT ON;      
        
  IF OBJECT_ID('TEMPDB..##TempPoPending1') IS NOT NULL        
  DROP TABLE ##TempPoPending1    
  IF OBJECT_ID('TEMPDB..##TempPoPending2') IS NOT NULL        
  DROP TABLE ##TempPoPending2    
  IF OBJECT_ID('TEMPDB..##TempPoPending3') IS NOT NULL        
  DROP TABLE ##TempPoPending3    
  IF OBJECT_ID('TEMPDB..##TempPoPending4') IS NOT NULL        
  DROP TABLE ##TempPoPending4    
        
  DECLARE @Prvendorname AS NVARCHAR(MAX)    
  SET @Prvendorname=(SELECT TOP 1 nvarchar29 djdf_PRVendorName FROM rptTransaction WHERE WorkflowId = 3 AND LogId = 0 and SourceColumn='')    
        
   select nvarchar20 djdf_Facility,nvarchar27 djdf_PRDepartment,datetime1 djdf_ApprovedOn,TranRefID,RequestId,WorkFlowStateId into ##TempPoPending1   
  from rptTransaction where WorkflowId = 3 AND LogId = 0 and SourceColumn=''    
  select nvarchar1 djdf_VendorName,TranRefID,float3 djdf_Total into ##TempPoPending2 from rptTransaction   
  where WorkflowId = 3 AND LogId = 0 AND SourceColumn = 'djdf_Vendor' and nvarchar1=@Prvendorname  
  select nvarchar2 djdf_PRItemDescription,float2 djdf_PRQuantity,TranRefID into ##TempPoPending3 from rptTransaction where WorkflowId = 3 AND LogId = 0 AND SourceColumn = 'djdf_Item'    
    
  select nvarchar1 djdf_InvoiceNo,float1 djdf_Amount,TranRefID INTO ##TempPoPending4 from rptTransaction where workflowid = 3 and TranRefID =2530 and SourceColumn ='djdf_InvoiceItem' and  LogId = 0  
  
 select DISTINCT t1.djdf_Facility Facility ,t1.djdf_PRDepartment Department ,t1.RequestId PO_No ,CONVERT(varchar(10),t1.djdf_ApprovedOn,120) PO_Date ,'' PO_Amount,djdf_InvoiceNo Invoice_Number,'' Invoice_Date
 ,djdf_Amount Invoice_Amount,'' Paid_Amount,'' Pending_Against_Invoice,'' Pending_Against_PO from ##TempPoPending1 t1     
  left outer join ##TempPoPending2 t2 ON t1.tranrefid=t2.tranrefid    
  left outer join ##TempPoPending3 t3 ON t2.tranrefid=t3.tranrefid    
  left outer join ##TempPoPending4 t4 ON t3.tranrefid=t4.tranrefid     
where CONVERT(varchar(10),t1.djdf_ApprovedOn,120) between @FromDate and @ToDate        
       
  IF OBJECT_ID('TEMPDB..##TempPoPending1') IS NOT NULL          
  DROP TABLE ##TempPoPending1        
  IF OBJECT_ID('TEMPDB..##TempPoPending2') IS NOT NULL          
  DROP TABLE ##TempPoPending2        
  IF OBJECT_ID('TEMPDB..##TempPoPending3') IS NOT NULL          
  DROP TABLE ##TempPoPending3     
  IF OBJECT_ID('TEMPDB..##TempPoPending4') IS NOT NULL        
  DROP TABLE ##TempPoPending4         
  
        
END 
GO
/****** Object:  StoredProcedure [dbo].[GetRptPaymentProcessed]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
          
-- =============================================          
-- Author:  <Sivasankar.s1>          
-- Create date: <31012018>          
-- Description: <Procurment -Payment Processed >          
-- =============================================          
CREATE PROCEDURE [dbo].[GetRptPaymentProcessed]          
  -- Add the parameters for the stored procedure here      
  @FromDate datetime      
 ,@ToDate datetime      
 ,@UserId datetime      
 ,@WorkflowId INT        
      
AS      
BEGIN      
---Exec GetRptPaymentProcessed '','','',3        
       
  SET NOCOUNT ON;        
          
  IF OBJECT_ID('TEMPDB..##TempPoPending1') IS NOT NULL          
  DROP TABLE ##TempPoPending1      
  IF OBJECT_ID('TEMPDB..##TempPoPending2') IS NOT NULL          
  DROP TABLE ##TempPoPending2      
  IF OBJECT_ID('TEMPDB..##TempPoPending3') IS NOT NULL          
  DROP TABLE ##TempPoPending3      
  IF OBJECT_ID('TEMPDB..##TempPoPending4') IS NOT NULL          
  DROP TABLE ##TempPoPending4      
          
  DECLARE @Prvendorname AS NVARCHAR(MAX)      
  SET @Prvendorname=(SELECT TOP 1 nvarchar29 djdf_PRVendorName FROM rptTransaction WHERE WorkflowId = 3 AND LogId = 0 and SourceColumn='')      
          
  SELECT nvarchar20 djdf_Facility,nvarchar27 djdf_PRDepartment,datetime1 djdf_ApprovedOn,'Req00' request,TranRefID,RequestId,nvarchar23 djdf_Remarks INTO ##TempPoPending1       
  FROM rptTransaction where WorkflowId = 3 AND LogId = 0 and SourceColumn=''        
  SELECT nvarchar1 djdf_VendorName,TranRefID,float3 djdf_Total INTO ##TempPoPending2 FROM rptTransaction       
  WHERE WorkflowId = 3 AND LogId = 0 AND SourceColumn = 'djdf_Vendor' and nvarchar1=@Prvendorname      
  SELECT nvarchar2 djdf_PRItemDescription,float2 djdf_PRQuantity,TranRefID INTO ##TempPoPending3 FROM rptTransaction WHERE WorkflowId = 3 AND LogId = 0 AND SourceColumn = 'djdf_Item'        
  select nvarchar1 djdf_InvoiceNo,float1 djdf_Amount,float2 djdf_TDSOtherDeduction,float3 djdf_NetAmount,datetime3 djdf_PaymentDate,nvarchar3 djdf_ChequeNo,nvarchar4 djdf_BankName,TranRefID INTO ##TempPoPending4 from rptTransaction where workflowid = 3 and TranRefID =2530 and SourceColumn ='djdf_InvoiceItem' and  LogId = 0    
      
         
 select DISTINCT t1.djdf_Facility Facility ,t1.djdf_PRDepartment Department ,t1.RequestId PO_No ,djdf_InvoiceNo Invoice_Number,djdf_Amount Invoice_Amount    
 ,djdf_TDSOtherDeduction TDSOther_deduction ,djdf_NetAmount Net_Amount,CONVERT(varchar(10),djdf_PaymentDate,120) Payment_Date ,djdf_ChequeNo Cheque_Number, djdf_BankName Bank_Name      
  from ##TempPoPending1 t1         
  left outer join ##TempPoPending2 t2 ON t1.tranrefid=t2.tranrefid        
  left outer join ##TempPoPending3 t3 ON t2.tranrefid=t3.tranrefid        
  left outer join ##TempPoPending4 t4 ON t3.tranrefid=t4.tranrefid        
  where CONVERT(varchar(10),t1.djdf_ApprovedOn,120) between @FromDate and @ToDate     
         
  IF OBJECT_ID('TEMPDB..##TempPoPending1') IS NOT NULL            
  DROP TABLE ##TempPoPending1          
  IF OBJECT_ID('TEMPDB..##TempPoPending2') IS NOT NULL            
  DROP TABLE ##TempPoPending2          
  IF OBJECT_ID('TEMPDB..##TempPoPending3') IS NOT NULL            
  DROP TABLE ##TempPoPending3       
  IF OBJECT_ID('TEMPDB..##TempPoPending4') IS NOT NULL          
  DROP TABLE ##TempPoPending4           
    
          
END 
GO
/****** Object:  StoredProcedure [dbo].[GetRptPOPending]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:  <Sivasankar.s1>            
-- Create date: <31012018>            
-- Description: <Procurment -PO pending Report>            
-- =============================================            
CREATE PROCEDURE [dbo].[GetRptPOPending]            
 -- Add the parameters for the stored procedure here            
  @FromDate DATETIME            
 ,@ToDate DATETIME            
 ,@UserId nvarchar(100)            
 ,@WorkflowId INT              
            
AS            
BEGIN            
---Exec GetRptPOPending '','','',3     
  SET NOCOUNT ON;            
    
	IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                  
	DROP TABLE ##TEMPITEMS             
	IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                  
	DROP TABLE ##TEMPVENDORS                              
	IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                  
	DROP TABLE ##TEMPPOMAINROW             
         
				SELECT ParentGroupNo,nvarchar2 djdf_PRItemDescription,float2 djdf_PRQuantity,CreatedDate,TranRefID   
				INTO ##TEMPITEMS  
				FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_Items' and WorkflowId=3 ORDER BY ParentGroupNo  

				SELECT ParentGroupNo ,nvarchar1 djdf_VendorName,nvarchar2 IsSelected,TranRefID   
				INTO ##TEMPVENDORS  
				FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_vendors'   

				select ParentGroupNo,nvarchar20 facility,nvarchar27 djdf_PRDepartment,datetime1 djdf_ApprovedOn,CreatedDate,TranRefID  
				INTO ##TEMPPOMAINROW  
				FROM  rptTransaction WHERE RequestId='1' and  logid = 0 and SourceColumn='' and WorkflowId=3  

				SELECT distinct djdf_PRDepartment Department,facility Facility,'' PO_No,CONVERT(Date,TM.djdf_ApprovedOn) PO_Date,djdf_PRItemDescription Item_Description,djdf_VendorName Vendor_Name  
				,'' Ordered_Quantity,'' Recieved_Quantity,'' Pending_Quantity,'' Unit_Rate,'' Amount   
				FROM ##TEMPVENDORS TV            
				left outer join ##TEMPPOMAINROW TM ON TV.TranRefID=TM.tranrefid  
				left outer join ##TEMPITEMS TI ON TI.tranrefid=TM.tranrefid  AND TM.ParentGroupNo = LEFT(TI.ParentGroupNo,2)           
				WHERE  CONVERT(Date,TM.CreatedDate) between CONVERT(Date,@FromDate)  and CONVERT(Date,@ToDate)                
				   

	IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                  
	DROP TABLE ##TEMPITEMS             
	IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                  
	DROP TABLE ##TEMPVENDORS                              
	IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                  
	DROP TABLE ##TEMPPOMAINROW         
     
END 
GO
/****** Object:  StoredProcedure [dbo].[GetRptServiceContract]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
                
-- =============================================                
-- Author:  <Sivasankar.s1>                
-- Create date: <31012018>                
-- Description: <Procurment -Due Date>                
-- =============================================                
CREATE PROCEDURE [dbo].[GetRptServiceContract]            
  @FromDate datetime            
 ,@ToDate datetime            
 ,@UserId Nvarchar(100)                
 ,@WorkflowId INT                  
                
AS                
BEGIN                

--Exec GetRptServiceContract '09/04/2018','09/04/2018','rameshkumar.r1','3'                  
  SET NOCOUNT ON; 
  
  IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                
 DROP TABLE ##TEMPITEMS           
 IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                
 DROP TABLE ##TEMPVENDORS                            
 IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                
 DROP TABLE ##TEMPPOMAINROW           
          
       
       
    SELECT ParentGroupNo,nvarchar2 djdf_PRItemDescription,float2 djdf_PRQuantity,CreatedDate,TranRefID 
    INTO ##TEMPITEMS
    FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_Items' and WorkflowId=3 ORDER BY ParentGroupNo
    
    SELECT ParentGroupNo ,nvarchar1 djdf_VendorName,nvarchar2 IsSelected,TranRefID 
    INTO ##TEMPVENDORS
    FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_vendors' 
    
    select ParentGroupNo,nvarchar20 facility,nvarchar27 djdf_PRDepartment,float3 Savings,nvarchar32 Basis_of_Savings,CreatedDate,TranRefID
    INTO ##TEMPPOMAINROW
    FROM  rptTransaction WHERE RequestId='1' and  logid = 0 and SourceColumn='' and WorkflowId=3
        
            
      
  
   SELECT distinct djdf_PRDepartment Department,facility Facility,'' PR_Ref_No,'' Oder_Ref_No,CONVERT(Date,TM.CreatedDate,120) Order_Date,djdf_PRItemDescription [Description],djdf_VendorName Vendor_Name
   ,'' Contract_Period,'' Contract_End_date
    FROM ##TEMPVENDORS TV          
   left outer join ##TEMPPOMAINROW TM ON TV.TranRefID=TM.tranrefid
   left outer join ##TEMPITEMS TI ON TI.tranrefid=TM.tranrefid  AND TM.ParentGroupNo = LEFT(TI.ParentGroupNo,2)         
   WHERE  CONVERT(Date,TM.CreatedDate) between CONVERT(Date,@FromDate)  and CONVERT(Date,@ToDate)              
         
         
 IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                
 DROP TABLE ##TEMPITEMS           
 IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                
 DROP TABLE ##TEMPVENDORS                            
 IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                
 DROP TABLE ##TEMPPOMAINROW    
                    
  
END 
GO
/****** Object:  StoredProcedure [dbo].[GetRptTat]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
-- =============================================    
-- Author:  <Sivasankar.s1>    
-- Create date: <31012018>    
-- Description: <Procurment -Due Date>    
-- =============================================    
Create PROCEDURE [dbo].[GetRptTat]
  @FromDate datetime
 ,@ToDate datetime
 ,@UserId datetime
 ,@WorkflowId INT      
    
AS    
BEGIN    
  
  SET NOCOUNT ON;    
 
    
  IF OBJECT_ID('TEMPDB..##TempPoPending1') IS NOT NULL    
  DROP TABLE ##TempPoPending1   
  
  IF OBJECT_ID('TEMPDB..##TempPoPending4') IS NOT NULL    
  DROP TABLE ##TempPoPending4
    
    select UserId from PBWUserMaster
   select nvarchar5 dj_UserId,TranRefID into ##TempPoPending1 from rptTransaction where WorkflowId = 3 AND LogId = 0 and SourceColumn=''
   select * from ##TempPoPending1
   
   select nvarchar1 djdf_InvoiceNo,datetime2 djdf_InvInvoiceReceivedDate,float1 djdf_Amount,TranRefID into ##TempPoPending4 from rptTransaction where WorkflowId = 3 AND LogId = 0 AND SourceColumn = 'djdf_InvoiceItem'
   
   select * from ##TempPoPending1 t1 
   inner join PBWUserMaster Pbw
   on t1.dj_UserId=Pbw.UserId
  left outer join ##TempPoPending4 t4 on t1.tranrefid=t4.tranrefid
  
   IF OBJECT_ID('TEMPDB..##TempPoPending1') IS NOT NULL    
  DROP TABLE ##TempPoPending1   
  
  IF OBJECT_ID('TEMPDB..##TempPoPending4') IS NOT NULL    
  DROP TABLE ##TempPoPending4
    
END 
GO
/****** Object:  StoredProcedure [dbo].[GetRptWarranty]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
                
-- =============================================                
-- Author:  <Sivasankar.s1>                
-- Create date: <31012018>                
-- Description: <Procurment -Due Date>                
-- =============================================                
CREATE PROCEDURE [dbo].[GetRptWarranty]            
  @FromDate datetime            
 ,@ToDate datetime            
 ,@UserId Nvarchar(100)                            
 ,@WorkflowId INT                  
                
AS                
BEGIN                
              
  SET NOCOUNT ON;
  --Exec GetRptWarranty '09/04/2018','09/04/2018','rameshkumar.r1','3'      
  
  IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                
 DROP TABLE ##TEMPITEMS           
 IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                
 DROP TABLE ##TEMPVENDORS                            
 IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                
 DROP TABLE ##TEMPPOMAINROW           
          
       
       
    SELECT ParentGroupNo,nvarchar2 djdf_PRItemDescription,float2 djdf_PRQuantity,CreatedDate,TranRefID 
    INTO ##TEMPITEMS
    FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_Items' and WorkflowId=3 ORDER BY ParentGroupNo
    
    SELECT ParentGroupNo ,nvarchar1 djdf_VendorName,nvarchar2 IsSelected,TranRefID 
    INTO ##TEMPVENDORS
    FROM rptTransaction WHERE RequestId='1' and logid = 0 and SourceColumn='djdf_vendors' 
    
    select ParentGroupNo,nvarchar20 facility,nvarchar27 djdf_PRDepartment,float3 Savings,nvarchar32 Basis_of_Savings,CreatedDate,TranRefID
    INTO ##TEMPPOMAINROW
    FROM  rptTransaction WHERE RequestId='1' and  logid = 0 and SourceColumn='' and WorkflowId=3
        
            
      
  
   SELECT distinct djdf_PRDepartment Department,facility Facility,'' PR_Ref_No,'' Order_Ref_No,CONVERT(Date,TM.CreatedDate,120) Order_Date,djdf_PRItemDescription [Description],djdf_VendorName Vendor_Name
   ,'' Warranty_Period,'' Warranty_End_date
    FROM ##TEMPVENDORS TV          
   left outer join ##TEMPPOMAINROW TM ON TV.TranRefID=TM.tranrefid
   left outer join ##TEMPITEMS TI ON TI.tranrefid=TM.tranrefid  AND TM.ParentGroupNo = LEFT(TI.ParentGroupNo,2)         
   WHERE  CONVERT(Date,TM.CreatedDate) between CONVERT(Date,@FromDate)  and CONVERT(Date,@ToDate)              
         
         
 IF OBJECT_ID('TEMPDB..##TEMPITEMS') IS NOT NULL                
 DROP TABLE ##TEMPITEMS           
 IF OBJECT_ID('TEMPDB..##TEMPVENDORS') IS NOT NULL                
 DROP TABLE ##TEMPVENDORS                            
 IF OBJECT_ID('TEMPDB..##TEMPPOMAINROW') IS NOT NULL                
 DROP TABLE ##TEMPPOMAINROW                   
                
END 
GO
/****** Object:  StoredProcedure [dbo].[GetUserDetailsMail_TMS]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserDetailsMail_TMS]
	-- Add the parameters for the stored procedure here
	@UniqueId VARCHAR(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--EXEC GetUserDetailsMail_TMS 'rameshkumar.r1'
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CI.InternalName Client,FunctionName Functionality FROM [ARC_Enterprise]..ARC_REC_USER_INFO_ALL AS UI
	INNER JOIN [ARC_Enterprise]..HR_Functionality HF ON HF.FunctionalityId=UI.FUNCTIONALITY_ID  
	INNER JOIN [ARC_Enterprise]..arc_contract_customer CI ON CI.customerid=UI.Client_Id  
	WHERE UI.NT_USERNAME = @UniqueId   
END
GO
/****** Object:  StoredProcedure [dbo].[GetVendorEmail]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
     
CREATE PROCEDURE [dbo].[GetVendorEmail]           
 
     
 @Itemname nvarchar(200)             
         
AS          
BEGIN         
--exec GetVendorEmail '156'       
    
select  VendorEmail  From PVendors where Name=@Itemname
-- LOWER(p.Name)=lower(@Itemname)  
      
END 
GO
/****** Object:  StoredProcedure [dbo].[GetVendorEmailID]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
CREATE PROCEDURE [dbo].[GetVendorEmailID]            
 -- Add the parameters for the stored procedure here            
      
 @Vendorname nvarchar(200)             
         
AS          
BEGIN         
--exec GetVendorEmailID 'Anbu Printers'       
    
select distinct Name as VendorName,VendorEmail from PVendors
where Name=(@Vendorname)        
END          
        
        
GO
/****** Object:  StoredProcedure [dbo].[GetVendorListitembased]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[GetVendorListitembased]          
 -- Add the parameters for the stored procedure here          
 @WorkflowId INT,    
 @Itemname nvarchar(200)           
       
AS        
BEGIN       
--exec GetVendorListitembased 3,'LAptopS'     
  
select distinct v.VendorId,v.Name as VendorName from PItems p     
inner join PItemVendorMapping vp     
inner join PVendors v   
on v.VendorId=vp.VendorId  
on p.ItemId=vp.ItemId    
where p.Wfid=@WorkflowId and (p.Name)=(@Itemname)
-- LOWER(p.Name)=lower(@Itemname)
    
END        
      
      
        
GO
/****** Object:  StoredProcedure [dbo].[InsertLog]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[InsertLog] 
(
	@level varchar(max),
	@callSite varchar(max),
	@type varchar(max),
	@message varchar(max),
	@stackTrace varchar(max),
	@innerException varchar(max),
	@additionalInfo varchar(max)
)
as

insert into dbo.Logs
(
	[Level],
	CallSite,
	[Type],
	[Message],
	StackTrace,
	InnerException,
	AdditionalInfo
)
values
(
	@level,
	@callSite,
	@type,
	@message,
	@stackTrace,
	@innerException,
	@additionalInfo
)


GO
/****** Object:  StoredProcedure [dbo].[Inventory_Insert]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Inventory_Insert]  
(  
@FileName varchar(max) = NULL,  
@TaskID int = NULL,  
@ComponentID int = NULL  
)  
As  
BEGIN  
INSERT INTO Inventory(TaskID) VALUES (@TaskID)  
Declare @Identity int   
  
SET @Identity =  @@IDENTITY  
  
INSERT INTO ProcessQueue(FIN, ComponentID, FileName, Status) VALUES (@Identity, @ComponentID, @FileName, 0)  
  
END  
GO
/****** Object:  StoredProcedure [dbo].[Inventory_Insert_N]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Inventory_Insert_N]  
(     
@PQID int = NULL      
)      
As      
BEGIN    
UPDATE ProcessQueue SET Status = 4 Where PQID = @PQID    
END  
  
GO
/****** Object:  StoredProcedure [dbo].[Inventory_Insert_New]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Inventory_Insert_New]    
(    
@FileName varchar(max) = NULL,    
@TaskID int = NULL,    
@ComponentID int = NULL,  
@PQID int = NULL    
)    
As    
BEGIN    
INSERT INTO Inventory(TaskID) VALUES (@TaskID)    
Declare @Identity int     
    
SET @Identity =  @@IDENTITY    
    
INSERT INTO ProcessQueue(FIN, ComponentID, FileName, Status) VALUES (@Identity, @ComponentID, @FileName, 0)    
  
UPDATE ProcessQueue SET Status = 4 Where PQID = @PQID  
END 
GO
/****** Object:  StoredProcedure [dbo].[Lms_DeleteUserRoleMapping]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Lms_DeleteUserRoleMapping]
(
	@ACTION VARCHAR(70)  = NULL,
	@ID INT = NULL,
	@USER VARCHAR(70) = NULL,
	@STATUS INT = NULL	
	
)
	AS
	DECLARE @COUNT INT;
	
	BEGIN
		SET NOCOUNT ON

			IF @ACTION = 'DELETE'
				BEGIN	
					SELECT @COUNT = COUNT(*) FROM LMS_UserRoleMapping WHERE userroleid = @ID;
						IF @COUNT >0 
							BEGIN 
							UPDATE LMS_UserRoleMapping SET 
								modified_user = @USER	,
								status = @STATUS,
								modified_date = GETDATE()
							WHERE userroleid = @ID
							--DELETE LMS_UserRoleMapping WHERE userroleid = @ID
							END
				SELECT STATUS = 1 , MESSAGE = 'Record Deleted Successfully..!'

				END
				
		SET NOCOUNT OFF
	END	
GO
/****** Object:  StoredProcedure [dbo].[Lms_GetEchoRecorderRights]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Lms_GetEchoRecorderRights]
(
	@UserName VARCHAR(70)  = NULL
)
	AS
	BEGIN
		SET NOCOUNT ON
			SELECT
				U.username,
					CASE WHEN
						SUM( CASE WHEN R.rolename = 'admin' THEN 1 ELSE 0 END) > 0 THEN 1 ELSE 0 END AS 'Admin',
					CASE WHEN
					SUM(CASE WHEN R.rolename = 'Create Module' THEN 1 ELSE 0 END) > 0 THEN 1 ELSE 0  END AS 'Create',
						CASE WHEN
					SUM(CASE WHEN R.rolename = 'Delete Module' THEN 1 ELSE 0 END) > 0 THEN 1 ELSE  0 END AS 'Delete',
						CASE WHEN
					SUM(CASE WHEN R.rolename = 'View Module' THEN 1 ELSE 0 END) > 0 THEN 1 ELSE 0 END AS 'View',
						CASE WHEN
					SUM(CASE WHEN R.rolename = 'Edit Module' THEN 1 ELSE 0 END) > 0 THEN 1 ELSE 0 END AS 'Edit'
		
				FROM LMS_UserRoleMapping RM
				 INNER JOIN LMS_Users U on U.userid = RM.userid
				 INNER JOIN LMS_Roles R on R.roleid = RM.roleid
	
				 WHERE U.username = @UserName and RM.status ='1'	  GROUP BY U.username

			SET NOCOUNT OFF
	End								


	--exec Lms_GetEchoRecorderRights @UserName='kailashvasan.vk'
GO
/****** Object:  StoredProcedure [dbo].[Lms_GetNTLoginUser]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Lms_GetNTLoginUser]

	AS
	BEGIN
		SET NOCOUNT ON
				BEGIN							
				SELECT NT_USERNAME,EmailId,FIRSTNAME,LASTNAME FROM ARC_Enterprise_Feb2019.dbo.ARC_REC_USER_INFO 
				END
				
		SET NOCOUNT OFF
	END	

GO
/****** Object:  StoredProcedure [dbo].[Lms_GetReports]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Lms_GetReports]

	AS
	BEGIN
		SET NOCOUNT ON
			
			SELECT * 
				INTO #TOTALUSER_ATTEMPT_COUNT
			FROM
				(
				SELECT  LM.ModuleName AS MODULENAME, LT.moduleid AS MODULEID,
						COUNT( DISTINCT LT.USERNAME) AS TOTALUSERCOUNT,COUNT(LT.USERNAME) AS TOTALATTEMPTCOUNT
						FROM LMS_TestResults LT INNER JOIN LMS_Modules LM
						on LT.ModuleId = LM.Id WHERE LM.ModuleName IS NOT NULL AND LT.USERNAME IS NOT NULL   GROUP BY LT.ModuleId,LM.ModuleName
				) AS L

			SELECT * 
				INTO #TEMPUSERWISE_ATTEMPT_COUNT
			FROM
				(
					SELECT lm.ModuleName AS MODULENAME ,lt.ModuleId AS MODULEID,lt.UserName AS USERNAME, count(LT.username) USERATTEMPT_COUNT
					from LMS_Modules Lm INNER JOIN LMS_TestResults lt   
					on lm.id = lt.ModuleId WHERE LM.ModuleName IS NOT NULL AND LT.USERNAME IS NOT NULL group by LT.UserName,lm.ModuleName, lt.ModuleId
				) AS LT
			
			

			SELECT * 
				INTO #TEMPUSERWISE_PASS_COUNT
			FROM
				(
					SELECT  lt.UserName AS USERNAME,lt.ModuleId AS MODULEID, count(result) AS PASSCOUNT
					FROM LMS_TestResults LT
					where lt.Result = 'P' and lt.Result is not null    group by LT.UserName,lt.ModuleId
				) AS UP
			
			

			SELECT * 
				INTO #TEMPUSERWISE_FAIL_COUNT
			FROM
				(
					SELECT lt.UserName AS USERNAME,lt.ModuleId AS MODULEID, count(result) AS FAILCOUNT  from LMS_TestResults LT
					where lt.Result = 'F' and lt.Result is not null    group by LT.UserName,lt.ModuleId
				) AS UF
			
			
			--SELECT * 
			--	INTO #TEMPUSERWISE_TOTAL_COUNT
			--FROM
			--	(
			--		SELECT lt.UserName AS USERNAME,lt.ModuleId AS MODULEID, count(result) AS TOTALCOUNT  from LMS_TestResults LT where lt.username is not null   group by LT.UserName,lt.ModuleId
			--	) AS UT
			
			
			SELECT * 
				INTO #TEMPUSERWISE_TOTAL_TIMEDURATION
			FROM
				(
					
					SELECT * FROM (
						SELECT lt.Result AS RESULT,lt.moduleid AS MODULEID,lt.username AS USERNAME,lt.totalsessiontime AS SESSIONTIME, row_number() over(partition by moduleid,username order by id desc) as rn 
						from LMS_TestResults lt where  lt.result  is not null and lt.username is not null
					) t
					where rn = 1 
				) AS UT

			

			SELECT DISTINCT A.MODULENAME,A.MODULEID,A.TOTALUSERCOUNT, B.USERNAME,B.USERATTEMPT_COUNT --,
				--,100*c.PASSCOUNT/B.USERATTEMPT_COUNT as PASS_PERCENT
				,case when cast((100.0*c.PASSCOUNT/B.USERATTEMPT_COUNT) as decimal(4,1)) is null then 0 else cast((100.0*c.PASSCOUNT/B.USERATTEMPT_COUNT) as decimal(4,1)) end as PASS_PERCENT
				-- ,case when Cast(Cast((c.PASSCOUNT/B.USERATTEMPT_COUNT)*100 as decimal(8,4)) as varchar(5)) is null then 0 else Cast(Cast((c.PASSCOUNT/B.USERATTEMPT_COUNT)*100 as decimal(18,2)) as varchar(5)) end as PASS_PERCENT
				--,100*D.FAILCOUNT/B.USERATTEMPT_COUNT as FAIL_PERCENT
				,case when  cast((100.0*D.FAILCOUNT/B.USERATTEMPT_COUNT) as decimal(4,1)) is null then 0 else cast((100.0*D.FAILCOUNT/B.USERATTEMPT_COUNT) as decimal(4,1)) end as FAIL_PERCENT
			--	,case when Cast(Cast((D.FAILCOUNT/B.USERATTEMPT_COUNT)*100 as decimal(8,4)) as varchar(5)) is null then 0 else Cast(Cast((D.FAILCOUNT/B.USERATTEMPT_COUNT)*100 as decimal(18,2)) as varchar(5)) end as PASS_PERCENT
				, E.RESULT
				, E.SESSIONTIME 
				FROM #TOTALUSER_ATTEMPT_COUNT A JOIN #TEMPUSERWISE_ATTEMPT_COUNT B ON A.MODULEID = B.MODULEID
				LEFT JOIN #TEMPUSERWISE_TOTAL_TIMEDURATION E ON A.MODULEID = E.MODULEID AND B.USERNAME = E.USERNAME
				LEFT JOIN #TEMPUSERWISE_PASS_COUNT C ON B.MODULEID = C.MODULEID AND B.USERNAME = C.USERNAME
				LEFT JOIN #TEMPUSERWISE_FAIL_COUNT D ON B.MODULEID = D.MODULEID AND B.USERNAME = D.USERNAME

					
			DROP TABLE	#TOTALUSER_ATTEMPT_COUNT
			DROP TABLE	#TEMPUSERWISE_ATTEMPT_COUNT
			DROP TABLE	#TEMPUSERWISE_TOTAL_TIMEDURATION
			DROP TABLE	#TEMPUSERWISE_PASS_COUNT
			DROP TABLE	#TEMPUSERWISE_FAIL_COUNT

		SET NOCOUNT OFF
	END	


--EXEC Lms_GetReports
GO
/****** Object:  StoredProcedure [dbo].[P_add_kafkalog]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_add_kafkalog](@server  nvarchar(max),  
                                @topicname nvarchar(max),  
                                @data nvarchar(max)        
                                   )          
AS    
  
        
       
BEGIN    
  
 insert into t_kafka_log(servername,topicname,data,createdon)  
values(@server,@topicname,@data,getdate());  
       
END
GO
/****** Object:  StoredProcedure [dbo].[P_add_PathDetails]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_add_PathDetails](@Scandate date,        
                                  @Path_Details[PathNames] readonly)          
AS    
  
declare @count  int;   
declare @rowcount  int;        
       
BEGIN    
  
select @count = Count(*) from PathDetails WHERE scandate = @scandate  
  
  
if @count <> 0    
begin  
  
INSERT INTO dbo.PathDetails(scandate,batchpaths)  
    
SELECT @Scandate,PD.PathName FROM @Path_Details PD left join PathDetails P ON PD.PathName = p.batchpaths   
WHERE batchpaths is null   
  
Select @rowcount=@@rowcount  
end  
else  
begin  
INSERT INTO dbo.PathDetails(scandate,batchpaths)    
      
SELECT @Scandate,PD.PathName FROM @Path_Details PD   
  
Select @rowcount=@@rowcount  
end  
  
Select Top (@rowcount) scandate,batchpaths from PathDetails Order By Id DESC   
       
END
GO
/****** Object:  StoredProcedure [dbo].[P_GET_ARC_COUNT]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_GET_ARC_COUNT](@fromDate DATETIME)
AS      
    
          
         
BEGIN      
    
select 
sum(case when isnull(CompletedMode,0)<>3 then 1 else 0 end) ArcCompleted from   WTFollowUp_AR_TicketMaster TM
inner join WTFollowUp_AR_ProcessMaster PM
on Tm.TicketId=PM.TicketId 
inner join WTFollowUp_AR_TicketAllocation TA on TA.TicketId=TM.TicketID and ta.AllocationStatus=1
inner join Arc_Ar_ServiceMaster sm on sm.ServiceId=ta.ServiceId 
inner join Arc_Ar_LoadBasicItems lb on lb.RowId=sm.ClientServiceId
where PM.ProcessDate=@fromDate
group by lb.ItemsText

 
         
END

GO
/****** Object:  StoredProcedure [dbo].[P_GET_JTBD_COUNT]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_GET_JTBD_COUNT](@fromDate DATETIME,@toDate DATETIME          
                                   )            
AS      
    
          
         
BEGIN      
    
SELECT  SUM([Count]) AS [Count] FROM (
SELECT
       R.[Name], COUNT(D.Id) AS [Count]
FROM [dbo].[DecisionTreeResults] D
       INNER JOIN [dbo].DecisionTreee R ON D.DecisionId = R.DecisionId
       INNER JOIN [dbo].PBWUserMaster U ON D.UserName = U.UserId
WHERE D.CreatedDate BETWEEN @fromDate AND @toDate AND DepartmentName != 'Shared Services – Application Development'
GROUP BY 
       CASE WHEN SUBSTRING(CONVERT(VARCHAR,CAST(D.CreatedDate AS TIME)),0,6) BETWEEN '00:01' AND '07:59'   
              THEN CONVERT(DATE,DATEADD(DD,-1,CONVERT(DATE,D.CreatedDate))) 
              ELSE CONVERT(DATE,D.CreatedDate) 
       END, R.[Name], D.[UserName], D.[CustomField], U.UserClient, U.LocationName, U.DepartmentName)A

 
         
END
GO
/****** Object:  StoredProcedure [dbo].[P_GET_PROCESS_RUNTIME]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_GET_PROCESS_RUNTIME]                      
  @ProcessName varchar(255)                      
AS                  
DECLARE @TimeinSecond INT                   
BEGIN                      
SET @TimeinSecond = ( SELECT  sum(( DATEPART(hh, TIME_TAKEN) * 3600 ) + ( DATEPART(mi, TIME_TAKEN) * 60 ) + DATEPART(ss, TIME_TAKEN)) AS total_time                  
FROM   PPm_USAGE  Where PROCESS_NAME =@ProcessName )                 
              
--SELECT RIGHT('0' + CAST(@TimeinSecond / 3600 AS VARCHAR),24) + ':' +              
--RIGHT('0' + CAST((@TimeinSecond / 60) % 60 AS VARCHAR),2) + ':' +              
--RIGHT('0' + CAST(@TimeinSecond % 60 AS VARCHAR),2)              
            
select '566:00:00'            
            
                
END 
GO
/****** Object:  StoredProcedure [dbo].[PBW_GET_CURRENT_STATUS]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PBW_GET_CURRENT_STATUS]
	@RequestId	INT,
	@WfId		INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		Status [Status]
	FROM PBWWorkflowTransaction
	WHERE RequestId = @RequestId AND WorkflowId = @WfId
	
	SET NOCOUNT OFF	
END
GO
/****** Object:  StoredProcedure [dbo].[PBW_RECENT_REQEUST_ACTION_STATUS]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PBW_RECENT_REQEUST_ACTION_STATUS]
	@FinId	INT,
	@WfId	INT
AS
BEGIN
	/*
		EXEC PBW_RECENT_REQEUST_ACTION_STATUS @FinId=809796,@WfId=2
		EXEC PBW_RECENT_REQEUST_ACTION_STATUS @FinId=809797,@WfId=2
	*/
	/*
	DECLARE @RoleId		INT
	DECLARE @Status		VARCHAR(100)
	DECLARE @RequestId	INT
	DECLARE @Action		VARCHAR(300)
	DECLARE @RoleName	VARCHAR(300)
	
	SELECT  
		@RoleId=RoleId,
		@Status=Status,
		@RequestId=RequestId
	FROM PBWWorkflowTransactionHistory T
	INNER JOIN ( SELECT MAX(LogId) [LogId], Fin FROM PBWWorkflowTransactionHistory  GROUP BY Fin ) TH ON TH.LogId = T.LogId AND TH.Fin = T.Fin 
	WHERE WorkflowId=@WfId AND T.Fin=@FinId
	
	IF @RoleId = 17 
		BEGIN
			SET @Action ='Travel ID <strong>'+CONVERT(VARCHAR(30),@RequestId)+'</strong> has been approved by <strong>dept head</strong>'
		END
	SELECT @Action [RecentAction]
	*/
	SELECT  
		'Travel ID <strong>'+CONVERT(VARCHAR(30),T.RequestId)+'</strong>'+
		CASE WHEN T.WorkFlowStateId = -2 AND T.Status ='Raised' THEN ' has been raised by <strong>you</strong>' 
		WHEN T.WorkFlowStateId = -2 AND T.Status ='Data Modified' THEN ' has been resubmitted by <strong>you</strong>'
		WHEN T.WorkFlowStateId = -4 AND T.Status ='Approved' THEN ' has been approved by <strong>dept head</strong>'
		WHEN T.WorkFlowStateId = -4 AND T.Status ='Rejected' THEN ' has been rejected by <strong>dept head</strong>'
		WHEN T.WorkFlowStateId = -33 AND T.Status ='Approved' THEN ' has been approved by <strong>Ticket cost updater</strong>'
		WHEN T.WorkFlowStateId = -33 AND T.Status ='Rejected' THEN ' has been Rejected by <strong>Ticket cost updater</strong>'
		WHEN T.WorkFlowStateId = -36 AND T.Status ='Approved' THEN ' has been approved by <strong>Final approver</strong>'
		WHEN T.WorkFlowStateId = -36 AND T.Status ='Rejected' THEN ' has been Rejected by <strong>Final approver</strong>'
		WHEN T.WorkFlowStateId = -8 AND T.Status ='Approved' THEN ' has been approved by <strong>MD</strong>'
		WHEN T.WorkFlowStateId = -8 AND T.Status ='Rejected' THEN ' has been Rejected by <strong>MD</strong>'
		WHEN T.WorkFlowStateId = -10 AND T.Status ='Acknowledged' THEN ' - Advance has been issued by <strong>Finance team</strong>'
		WHEN T.WorkFlowStateId = -12 AND T.Status ='ExpensesSubmitted' THEN ' - Bill has been submitted by <strong>you</strong>'
		WHEN T.WorkFlowStateId = -19 AND T.Status ='Approved' THEN ' - Expenses has been approved by <strong>dept head</strong>'
		WHEN T.WorkFlowStateId = -21 AND T.Status ='Approved' THEN ' has been closed <strong>Finance team</strong>'
		ELSE ' has been raised by <strong>you</strong>' END [RecentAction]
	FROM PBWWorkflowTransactionHistory T
	INNER JOIN ( SELECT MAX(LogId) [LogId], Fin FROM PBWWorkflowTransactionHistory  GROUP BY Fin ) TH ON TH.LogId = T.LogId AND TH.Fin = T.Fin 
	INNER JOIN PBWWorkFlowRoleMaster RM ON RM.RoleId = T.RoleId
	WHERE WorkflowId=@WfId AND T.Fin=@FinId
	
END
GO
/****** Object:  StoredProcedure [dbo].[RptGenerateTrvel]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[RptGenerateTrvel]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT nvarchar5 Name,nvarchar42 EmployeeCode,DepartmentName Department,RoleName Designation,0 AdvanceIssued,
float1 PerDiem,float3 Accommodation,float4 Others FROM rptTransaction AS r 
INNER JOIN PBWUserMaster AS U ON r.nvarchar5 = U.UniqueId 
INNER JOIN PBWUserDesignation AS D ON U.RoleId = D.RoleId WHERE SourceColumn = '' 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetBTQUsage]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetBTQUsage]
(
@TYPE VARCHAR(50) NULL
)
AS
	IF (@TYPE = '0')
		BEGIN
		
				SELECT* FROM BTQ_USAGE WHERE IS_TRANSFERED  = 0
		
		END
	 ELSE IF  (@TYPE = '1')
		 BEGIN
		
			UPDATE  BTQ_USAGE SET IS_TRANSFERED  = 1 WHERE IS_TRANSFERED = 0
		
		END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTimeToCall]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GetTimeToCall]
(@phoneNumber VARCHAR(100))
AS
BEGIN

SELECT * FROM Doc_Athena_ARCallTimeReport
WHERE 
	CONVERT(VARCHAR(5),ExecutionTime,108) 
		BETWEEN CONVERT(VARCHAR(5),DATEADD(MI,-30,DATEADD(MI, DATEDIFF(MI, 0, GETDATE())/10*10, 0)),108) AND
		CONVERT(VARCHAR(5),DATEADD(MI, DATEDIFF(MI, 0, GETDATE())/10*10, 0),108)
		AND		
	PhoneNumber = @phoneNumber
	ORDER BY ExecutionTime DESC

END

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_CT_Transactions]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_INSERT_CT_Transactions]
AS
BEGIN

BEGIN TRAN
BEGIN TRY

DECLARE @Date DATE = GETDATE()-1;

INSERT INTO Echo_ControlTower.cto.CT_Transactions
SELECT * FROM
(
SELECT 'Athena' AS [LOB], 'Unpostable Forwarded by Practice' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.AthUnPostableVoice_Live WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date) AND Scenario = 'Forwarded By Practice Found'
UNION ALL
SELECT 'Athena' AS [LOB], 'Unpostable Possible Match Scenario' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.AthUnPostableVoice_Live WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date) AND Scenario = 'Possible Match Found'
UNION ALL
SELECT 'Athena' AS [LOB], 'Denials Coding Clustering' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.AthDenialsCoding_ClusterDetails WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Overpayment Precall' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Overpayment_Precall_OutPut WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Overpayment Preliminary' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Preliminary_Precall_OutPut WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Unspecified Denials Night Precall' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_USPDN_Pre_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Expanded Client Specific Non Voice' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_ExpClSp_NV_InsElig_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'RNBF Precall' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_RNBF_Pre_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'CWR 351' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_351_Ins_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Expanded 7 Kicks' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Athena_BotSessionTable WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date) AND FlowId = 8
UNION ALL
SELECT 'Athena' AS [LOB], 'Remittance Tracking Pune Precall' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_Pune_Pre_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Clustering 2' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Clustering2_Dump WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Expanded Service Voice Precall' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Athena_BotSessionTable WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date) AND FlowId = 7
UNION ALL
SELECT 'Athena' AS [LOB], 'Manual Posting Tentative Discarded' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.ManualPosting_BotSessionTable WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date) AND ProcessName LIKE 'Tentative Discarded'
UNION ALL
SELECT 'Athena' AS [LOB], 'Remittance MasterCard' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Athena_RemittancesRecordPosting_BotSession WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'RAR DPCN Clustering' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.RAR_DPCNGathering WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'RAR Provider Takeback' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.RAR_ProviderTakeback WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Nereview' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_NeReview_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Denials Expansion' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_DenialsExpansion_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Specified Denials Clustering' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_SpecifiedDenialsClustering_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Expanded 7 Kicks BADPKG' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_7Kick_BadPkg_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Expanded 7 Kicks BAC' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_7Kick_Bac_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Prescribed Follow-up' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_PFUP_Prl_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Preliminary Analysis precall' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Athena_BotSessionTable WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date) AND FlowId = 11
UNION ALL
SELECT 'Athena' AS [LOB], 'Manila Clustering' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.manilaWorklistClaimReassignment WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'CWR Eligibility verification' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Athena_BotSessionTable WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date) AND FlowId = 9
UNION ALL
SELECT 'Athena' AS [LOB], 'Refund precall' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_REFD_Prl_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Enrollment Preliminary' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.EnrollmentDumpDownload WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'FUP WEBACCESSRVW' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_Fup_WEBACCESSRVW_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Enrollment Callable Task' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.Ath_enr_cal_task_Tr WHERE CONVERT(DATE,CreatedOn) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'ManualPosting_preliminary' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.TRN_ManualPostingERA_Preliminary_ProcessDetails WHERE CONVERT(DATE,CreateDate) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Athena' AS [LOB], 'Expanded7kicks_preliminary' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM IL_Athena.dbo.trn_7Kicks_preliminary_processdetails WHERE CONVERT(DATE,CreateDate) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Greenway ERA - Intergy' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.Greenways_LogInfo WHERE CONVERT(DATE,EndTime) = CONVERT(DATE,@Date) AND Process = 'ERA - Intergy'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Greenway - Primesuite' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.Greenways_LogInfo WHERE CONVERT(DATE,EndTime) = CONVERT(DATE,@Date) AND Process = 'Primesuite'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Greenway - Box' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.Greenway_Box_List WHERE CONVERT(DATE,Completed_on) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Greenway - Deposit Log' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.Greenway_DepositLog_LogInfo WHERE CONVERT(DATE,EndTime) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'TPX ERA Posting' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.TPX_ERA_POSTING WHERE CONVERT(DATE,[End time]) = CONVERT(DATE,@Date)
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'TPX ERA Exception Posting' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.TPX_ERA_POSTING WHERE CONVERT(DATE,[End time]) = CONVERT(DATE,@Date) AND ERA_PostingStatus IS NOT NULL
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'BT Pre Call Analysis' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'BT_Pre Call Analysis'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Cheque download' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'Cheque download'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Deposit log' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME IN ('Deposit log','DepositLog')
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'ERA EOB Download' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'ERA EOB Download'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'FaceBook Automation' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'FaceBook Automation'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Greenways - AR' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME IN('Greenways - AR','Greenways-AR')
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Greenways - AR - Flatfile Download' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'Greenways - AR - Flatfile Download'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Greenways - ERA' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'Greenways - ERA'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Hap_Era_Posting' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'Hap_Era_Posting'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Payment' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'Payment'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Payments' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'Payments'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Pre Call Analysis' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME IN ('Pre Call Analysis','PreCallAnalysis')
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'TATA_Report' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'TATA_Report'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'Web-Statusing' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.ECHOBOT_TRANSACTIONLOG_INFO WHERE CONVERT(DATE,[END_TIME]) = CONVERT(DATE,@Date) AND PROCESS_NAME = 'Web-Statusing'
UNION ALL
SELECT 'Non-Athena' AS [LOB], 'TPX_ERA_POSTING' AS [Process], COUNT(*) AS [Transactions] , @Date AS [Date] FROM Lab_183.dbo.TPX_ERA_POSTING WHERE CONVERT(DATE,[End time]) = CONVERT(DATE,@Date) AND [Processing status] = 'Processing completed successfully.'
)A

COMMIT TRAN

SELECT 'TRUE' AS [Status]

END TRY
BEGIN CATCH
	ROLLBACK TRAN
	SELECT 'FALSE' AS [Status]
END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_CT_Transactions_Testing]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_INSERT_CT_Transactions_Testing]
AS
BEGIN

BEGIN TRAN
BEGIN TRY

DECLARE @Date DATE = GETDATE();

INSERT INTO AhsPlatform.dbo.CT_Transactions_Testing
SELECT * FROM
(
SELECT 'Non-Athena' AS [LOB], 'BTQ Health First' AS [Process], COUNT(*) AS [Transactions] , CONVERT(DATE,Getdate()) AS [Date] FROM AhsPlatform.dbo.HealthFirst_Test WHERE CONVERT(DATE,CreatedDate) = CONVERT(DATE,@Date)
)A

COMMIT TRAN

SELECT 'TRUE' AS [Status]

END TRY
BEGIN CATCH
	ROLLBACK TRAN
	SELECT 'FALSE' AS [Status]
END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertUnAvailableRecords]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_InsertUnAvailableRecords]  
(  
@phoneNumber VARCHAR(100),  
@createdBy VARCHAR(500),  
@Team VARCHAR(500),
@TeamID INT
)  
AS
BEGIN  
  
INSERT INTO Doc_Athena_UnavaialableRecords (PhoneNumber,Created,CreatedBy,Team,ID_Team) VALUES (@phoneNumber,GETDATE(),@createdBy,@Team,@TeamID)  
  
END

GO
/****** Object:  StoredProcedure [dbo].[SP_LoadLocationData]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LoadLocationData]
AS 
BEGIN
select 'All'  as LocationName Union select distinct Location as LocationName from Doc_Athena_TeamMaster with(Nolock) where Status=1 and GroupName='Athena'
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LoadTeamData]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LoadTeamData]
@Location varchar(100)
AS 
BEGIN
IF(@Location = 'All')
	select TeamID,TeamName as TeamName from Doc_Athena_TeamMaster with(Nolock) where Status=1 and GroupName='Athena' order by TeamName
ELSE
	select TeamID,TeamName as TeamName from Doc_Athena_TeamMaster with(Nolock) where Status=1 and GroupName='Athena' and Location= @Location  order by TeamName
END
GO
/****** Object:  StoredProcedure [dbo].[spAHSPlatformGetJsonValue]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		RAMESHKUMAR
-- Create date: Jun/06/2017
-- Description:	GetJSON Value
-- =============================================
CREATE PROCEDURE  [dbo].[spAHSPlatformGetJsonValue]
	-- Add the parameters for the stored procedure here 
	@WorkflowId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT DataJson FROM AhsPlatformWorkFlowMaster WHERE WorkFlowId = @WorkflowId
END
GO
/****** Object:  StoredProcedure [dbo].[spSaveAhsPlatformWorkflowTransaction]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[spSaveAhsPlatformWorkflowTransaction]  
 -- Add the parameters for the stored procedure here   
 @WorkflowId INT,
 @UserId INT,
 @DataJson VARCHAR(MAX),  
 @FinId INT = 0,
 @IsSubmit BIT = 0,
 @Status VARCHAR(32) = 'Pending'
AS  
-- EXEC spAHSPlatformGetJsonValue 1  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  	
	IF NOT EXISTS(SELECT 1 FROM AhsPlatformWorkflowTransaction WHERE Fin = @FinId)
	BEGIN
		INSERT INTO AhsPlatformWorkflowTransaction
		(WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate)    
		SELECT @WorkflowId,@DataJson,0 WorkFlowStateId,1 RoleQueueId,@Status Status,@UserId,@UserId CreatedBy,GETDATE() CreatedDate,@UserId LastModifiedBy, GETDATE() LastModifiedDate
    END
    ELSE
    BEGIN
		
		INSERT INTO AhsPlatformWorkflowHistory
		(Fin,WorkflowId,DataJson,WorkFlowStateId,RoleQueueId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate)
		SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate FROM AhsPlatformWorkflowTransaction WHERE Fin = @FinId  
		
		IF @Status = 'Pending' OR @Status = ''
		BEGIN
			UPDATE AhsPlatformWorkflowTransaction SET WorkflowId = @WorkflowId,DataJson = @DataJson,Status = @Status ,UserId = @UserId,LastModifiedBy = @UserId,LastModifiedDate = GETDATE() WHERE Fin = @FinId 
		END
		ELSE 
		BEGIN
			UPDATE AhsPlatformWorkflowTransaction SET WorkflowId = @WorkflowId  ,Status = @Status  ,LastModifiedBy = @UserId,LastModifiedDate = GETDATE() WHERE Fin = @FinId 
		END
    END
END  
 
GO
/****** Object:  StoredProcedure [dbo].[spViewAhsPlatformWorkflowTransaction]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[spViewAhsPlatformWorkflowTransaction]  
 -- Add the parameters for the stored procedure here   
 @WorkflowId INT,
 @UserId INT 
AS  
-- EXEC spAHSPlatformGetJsonValue 1  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  	
	SELECT * FROM AhsPlatformWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId
END  
 
GO
/****** Object:  StoredProcedure [dbo].[SupportFlow_GetEchoFlowRecords]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                        
-- Author:  rameshkumar.r1                        
-- Create date: 07/May/2018                        
-- Description: For Single dot Flow                        
-- =============================================                        
CREATE PROCEDURE [dbo].[SupportFlow_GetEchoFlowRecords]                        
 -- Add the parameters for the stored procedure here                        
 @NT_UserName NVARCHAR(256)          
AS                        
BEGIN                    
/*                     
 -- SET NOCOUNT ON added to prevent extra result sets from                        
 -- interfering with SELECT statements.                        
 --          
 EXEC SupportFlow_GetEchoFlowRecords 'surendher.s'                   
 EXEC SupportFlow_GetEchoFlowRecords 'seenaa.nataraja'                
               
 http://localhost:59601/Approval/Approva1?finid=                
               
 --W.URL+''?finid=''+convert(varchar(20),X.FIN) URL,'              
                  
 */                       
 SET NOCOUNT ON;                        
                        
 --DECLARE @WorkflowId AS INT                      
 --SET @WorkflowId = 2                      
                       
 IF OBJECT_ID('TEMPDB..#TempWorkflowFin') IS NOT NULL                      
  DROP TABLE #TempWorkflowFin                      
 CREATE TABLE #TempWorkflowFin(WorkflowId int,                        
 DataJson nvarchar(MAX),WorkFlowStateId int,RoleId int,Status nvarchar(100),UserId nvarchar(100),CreatedBy nvarchar(100),CreatedDate datetime,                      
 LastModifiedBy nvarchar(100),LastModifiedDate datetime,Fin int,RequestId bigint,WorkflowVersion varchar(100),WorkflowSubVersion varchar(100),                         
 rptTblSyncDate datetime,IsTranLastEntry bit,rptTranRefId int,ParentWorkFlowStateId int,ParentFin int,BucketInDate DATETIME,BucketOutDate DATETIME)                      
                
   --print convert(varchar(50),getdate(),120)        
   INSERT INTO #TempWorkflowFin                      
   EXEC SupportFlow_uspGetWaitingForApproval @NT_UserName              
   ----print convert(varchar(50),getdate(),120)               
          
    --select * from #TempWorkflowFin      
   --INSERT INTO #TempWorkflowFin                      
   --EXEC uspGetWaitingForApproval @WorkflowId,@NT_UserName,'Acknowledgement'            
   ----print convert(varchar(50),getdate(),120)                
                       
   --INSERT INTO #TempWorkflowFin                      
   --EXEC uspGetWaitingForApproval @WorkflowId,@NT_UserName,'SubmitExpenses'                     
   ----print convert(varchar(50),getdate(),120)         
                        
 SELECT X.RequestId ID,WorkflowName [From],'Pending for Action' [Status],R.nvarchar24 [Description],X.CreatedDate DueOn,'http://localhost:59601/Approval/Approval?finid='+convert(varchar(20),X.FIN) RURL,              
 Replace(W.URL,'http://10.20.0.187/TMS/','http://10.20.0.187/supportflow_TMS/')+'?finid='+convert(varchar(20),X.FIN)   URL,X.FIN ,    
     
   (case when x.WorkflowId=36 then '<input type="button" value="Action" onclick="return OpenTaskactionpopup('''+convert(varchar(20),X.FIN)+' '');" />' else   
  '<input type="button" value="Action" onclick="return callfun('''+Replace(W.URL,'http://10.20.0.187/TMS/','http://10.20.0.187/supportflow_TMS/')+'?finid='+convert(varchar(20),X.FIN)+''');" />' end )as ActionButton    
     
     
 FROM (                        
 SELECT ROW_NUMBER() OVER (ORDER BY FIN) AS rownumber,RequestId,CreatedDate,DataJson,WorkflowId,WorkflowStateId,FIN FROM PBWWorkflowTransaction                         
 WHERE FIN IN (SELECT I.FIN FROM #TempWorkflowFin AS I) AND ISNULL(Status,'') NOT IN ('Closed','Completed') AND WorkflowId IN (2,3,36)) X                       
 INNER JOIN PBWWorkflowMaster AS P ON X.WorkflowId = P.WorkflowId                      
 INNER JOIN WorkFlowRedirectURL AS W ON X.WorkflowId = W.WorkflowId AND X.WorkflowStateId = W.WorkflowStateId                      
 LEFT OUTER JOIN rptTransaction AS R ON R.WorkflowId = X.WorkflowId and R.FIN = X.FIN AND R.LogId = 0 AND R.SourceColumn = ''   
 
 where W.URL not like '%http://localhost:59460/RaiseRequest/RaiseRequest%'            
       
END   



  
  
  
  
GO
/****** Object:  StoredProcedure [dbo].[SupportFlow_GetEchoFlowRecords_Bk20180518]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================              
-- Author:  rameshkumar.r1              
-- Create date: 07/May/2018              
-- Description: For Single dot Flow              
-- =============================================              
CREATE PROCEDURE [dbo].[SupportFlow_GetEchoFlowRecords_Bk20180518]              
 -- Add the parameters for the stored procedure here              
 @NT_UserName NVARCHAR(256),              
 @StartRecord INT,              
 @MaxRecords INT,              
 @SortColumn NVARCHAR(256)              
AS              
BEGIN          
/*           
 -- SET NOCOUNT ON added to prevent extra result sets from              
 -- interfering with SELECT statements.              
 -- EXEC SupportFlow_GetEchoFlowRecords 'rameshkumar.r1',1,30,'InboxId'           
 EXEC SupportFlow_GetEchoFlowRecords 'seenaa.nataraja',1,30,'InboxId'      
     
 http://localhost:59601/Approval/Approva1?finid=      
     
 --W.URL+''?finid=''+convert(varchar(20),X.FIN) URL,'    
        
 */             
 SET NOCOUNT ON;              
              
 DECLARE @WorkflowId AS INT            
 SET @WorkflowId = 2            
             
 IF OBJECT_ID('TEMPDB..#TempWorkflowFin') IS NOT NULL            
  DROP TABLE #TempWorkflowFin            
 CREATE TABLE #TempWorkflowFin(WorkflowId int,              
 DataJson nvarchar(MAX),WorkFlowStateId int,RoleId int,Status nvarchar(100),UserId nvarchar(100),CreatedBy nvarchar(100),CreatedDate datetime,            
 LastModifiedBy nvarchar(100),LastModifiedDate datetime,Fin int,RequestId bigint,WorkflowVersion varchar(100),WorkflowSubVersion varchar(100),               
 rptTblSyncDate datetime,IsTranLastEntry bit,rptTranRefId int,ParentWorkFlowStateId int,ParentFin int)            
             
 --DECLARE db_cursor CURSOR FOR             
 --SELECT WorkflowId FROM PBWWorkflowMaster             
 --OPEN db_cursor              
 --FETCH NEXT FROM db_cursor INTO @WorkflowId              
 --WHILE @@FETCH_STATUS = 0              
 --BEGIN              
   INSERT INTO #TempWorkflowFin            
   EXEC uspGetWaitingForApproval @WorkflowId,@NT_UserName,''            
             
   INSERT INTO #TempWorkflowFin            
   EXEC uspGetWaitingForApproval @WorkflowId,@NT_UserName,'Acknowledgement'           
             
   INSERT INTO #TempWorkflowFin            
   EXEC uspGetWaitingForApproval @WorkflowId,@NT_UserName,'SubmitExpenses'           
   --FETCH NEXT FROM db_cursor INTO @WorkflowId             
 --END             
 --CLOSE db_cursor              
 --DEALLOCATE db_cursor             
             
 IF @SortColumn = 'InboxId'            
 BEGIN            
  SET @SortColumn = 'X.RequestId'            
 END            
 ELSE IF @SortColumn = 'Category'            
 BEGIN            
  SET @SortColumn = 'WorkflowName'            
 END            
 ELSE IF @SortColumn = 'SubCategory'            
 BEGIN            
  SET @SortColumn = 'SubCategory'            
 END            
 ELSE IF @SortColumn = 'Description'            
 BEGIN            
  SET @SortColumn = 'R.nvarchar24'            
 END            
 ELSE IF @SortColumn = 'DueOn'            
 BEGIN            
  SET @SortColumn = 'X.CreatedDate'            
 END            
 ELSE IF @SortColumn = 'URL'            
 BEGIN            
  SET @SortColumn = 'URL'            
 END            
                 
 -- Insert statements for procedure here              
 DECLARE @strQry AS NVARCHAR(MAX)              
 SET @strQry = ''              
 SET @strQry += ' SELECT X.RequestId InboxId,WorkflowName Category,'''' SubCategory,R.nvarchar24 Description,X.CreatedDate DueOn,''http://localhost:59601/Approval/Approval?finid=''+convert(varchar(20),X.FIN) RURL,'    
 SET @strQry += ' Replace(W.URL,''http://10.20.0.187/TMS/'',''http://10.20.0.187/supportflow_TMS/'')+''?finid=''+convert(varchar(20),X.FIN) URL,X.FIN FROM ('              
 SET @strQry += ' SELECT ROW_NUMBER() OVER (ORDER BY FIN) AS rownumber,RequestId,CreatedDate,DataJson,WorkflowId,WorkflowStateId,FIN FROM PBWWorkflowTransaction'               
 SET @strQry += ' WHERE FIN IN (SELECT I.FIN FROM #TempWorkflowFin AS I) AND ISNULL(Status,'''') NOT IN (''Closed'',''Completed'') AND WorkflowId = 2) X'             
 SET @strQry += ' INNER JOIN PBWWorkflowMaster AS P ON X.WorkflowId = P.WorkflowId'            
 SET @strQry += ' INNER JOIN WorkFlowRedirectURL AS W ON X.WorkflowId = W.WorkflowId AND X.WorkflowStateId = W.WorkflowStateId'            
 SET @strQry += ' LEFT OUTER JOIN rptTransaction AS R ON R.WorkflowId = X.WorkflowId and R.FIN = X.FIN AND R.LogId = 0 AND R.SourceColumn = '''''            
 SET @strQry += ' WHERE ROWNUMBER >= '+convert(varchar(20),@StartRecord)+' AND ROWNUMBER <= '+convert(varchar(20),@MaxRecords)+''              
 SET @strQry += ' ORDER BY '+@SortColumn+''               
 PRINT @strQry              
 EXECUTE sp_executesql @strQry              
            
 SET @strQry = ''              
            
 SET @strQry += ' SELECT COUNT(1) TotalRecords FROM PBWWorkflowTransaction'               
 SET @strQry += ' WHERE FIN IN (SELECT I.FIN FROM #TempWorkflowFin AS I) AND ISNULL(Status,'''') NOT IN (''Closed'',''Completed'') AND WorkflowId = 2'              
 PRINT @strQry              
 EXECUTE sp_executesql @strQry              
END 
GO
/****** Object:  StoredProcedure [dbo].[SupportFlow_uspGetWaitingForApproval]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                    
-- Author:  RAMESHKUMAR                    
-- Create date: Jun/06/2017                    
-- Description: GetJSON Value                    
-- =============================================                    
CREATE PROCEDURE  [dbo].[SupportFlow_uspGetWaitingForApproval]                    
 -- Add the parameters for the stored procedure here    
 @UserId VARCHAR(100)              
AS                     
-- EXEC SupportFlow_uspGetWaitingForApproval 'babu.j'                    
BEGIN                    
 -- SET NOCOUNT ON added to prevent extra result sets from                    
 -- interfering with SELECT statements.                    
 SET NOCOUNT ON;    
                  
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL                  
  DROP TABLE #TempSubOrdinates         
 CREATE TABLE #TempSubOrdinates      
 (UserId VARCHAR(256),SuperVisorId VARCHAR(256))      
    
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates1') IS NOT NULL                  
  DROP TABLE #TempSubOrdinates1        
    
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates2') IS NOT NULL                  
  DROP TABLE #TempSubOrdinates2        
    
 SELECT       
  DISTINCT U.SupervisorId,U.Userid INTO #TempSubOrdinates1      
 FROM PBWUserMaster AS U LEFT OUTER JOIN PBWUserMaster AS V      
 ON U.UserId = V.SupervisorId      
 WHERE ISNULL(v.SupervisorId,'') != ''      
    
 ;WITH SubOrdinates                  
 AS                  
 (          
  SELECT DISTINCT UserId,SuperVisorId FROM #TempSubOrdinates1 AS U WHERE U.SuperVisorId = @UserId                
  UNION ALL                  
  SELECT U.UserId,U.SuperVisorId FROM #TempSubOrdinates1 AS U INNER JOIN SubOrdinates AS S                  
  ON U.SuperVisorId = S.UserId         
 )                  
 SELECT DISTINCT S.UserId,S.SuperVisorId       
 INTO #TempSubOrdinates2                
 FROM SubOrdinates AS S       
    
 INSERT INTO #TempSubOrdinates      
 (UserId,SuperVisorId)      
 SELECT DISTINCT UserId,SuperVisorId FROM #TempSubOrdinates1 AS U WHERE U.SuperVisorId = @UserId       
 UNION      
 SELECT DISTINCT U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN #TempSubOrdinates2 as v      
 ON U.SuperVisorId = V.UserId      
 ORDER BY U.SupervisorId,U.UserId             
    
  
    
 INSERT INTO #TempSubOrdinates      
 (UserId,SuperVisorId)      
 SELECT DISTINCT UserId,SuperVisorId FROM PBWUserMaster AS U WHERE U.SuperVisorId = @UserId AND U.UserId NOT IN (SELECT T.UserId FROM #TempSubOrdinates AS T)      
    
    
      
 IF OBJECT_ID('TEMPDB..#TempSingleFlowFin') IS NOT NULL    
  DROP TABLE #TempSingleFlowFin    
 CREATE TABLE #TempSingleFlowFin(Fin VARCHAR(50))    
    
    INSERT INTO #TempSingleFlowFin    
    (Fin)    
 SELECT W.FIN FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId                   
 INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId                  
 WHERE W.WorkflowId = 11 AND U.UniqueId = @UserId        
 AND W.UserId IN (CASE WHEN W.RoleId = 36 THEN (SELECT TOP 1 ISNULL(UI.UserId,'') FROM PBWUserMaster AS UI WHERE W.UserId = UI.UserId AND UI.SuperVisorId  = @UserId) ELSE W.UserId END)                 
 UNION                  
 SELECT W.FIN FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId         
 AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = 11 AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYST
  
EM','CUSTOMER','SPOC','SUPERVISOR'))              
 AND W.WorkflowId = 11       
 UNION    
 SELECT W.Fin FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId                   
 INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId     
 WHERE W.WorkflowId = U.WorkflowId AND U.UniqueId = @UserId  AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED','SELECT
E  
D')               
 AND W.WorkflowId IN (2,3)    
 UNION                  
 SELECT W.Fin FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED','SELECTED')          
 
 INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId               
 AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = U.WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPD
  
ATER','SYSTEM','CUSTOMER','SPOC'))              
 AND W.WorkflowId = U.WorkflowId      
 AND W.WorkflowId IN (2,3)   
 
  UNION      -- for single flow workflow             
 SELECT W.Fin FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED','SELECTED')          
 
 INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId               
 AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = U.WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPD
ATER','SYSTEM','CUSTOMER','SPOC','Asssociate'))       AND W.WorkflowId = U.WorkflowId      
 AND W.WorkflowId IN (36)          
inner JOIN rptTransaction AS RT ON RT.WorkflowId = W.WorkflowId and RT.FIN = W.FIN AND RT.LogId = 0 AND RT.SourceColumn = '' and RT.nvarchar6=@UserId  

     
 SELECT * FROM PBWWorkflowTransaction AS T WHERE EXISTS (SELECT 1 FROM #TempSingleFlowFin AS T1 WHERE T.Fin = T1.Fin)      
 ORDER BY LastModifiedDate DESC                        
               
                   
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL                  
  DROP TABLE #TempSubOrdinates           
    
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates1') IS NOT NULL                  
  DROP TABLE #TempSubOrdinates1        
    
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates2') IS NOT NULL                  
  DROP TABLE #TempSubOrdinates2             
END 
GO
/****** Object:  StoredProcedure [dbo].[Update_PQID]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Update_PQID]  
(  
@PQID int  
)  
As  
BEGIN  
UPDATE ProcessQueue Set Status = 1 Where PQID =  @PQID  
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BOTSLOG_INFORMATION]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_BOTSLOG_INFORMATION]
(
@MachineIp varchar(100),
@BotName VARCHAR(100),
@StartTime DATETIME,
@EndTime DATETIME,
@Status VARCHAR(100),
@CreatedDate DATETIME,
@ModifiedDate DATETIME,
@Username VARCHAR (100),
@ProcessName VARCHAR(100),
@Author VARCHAR(100),
@SubProcessName VARCHAR(100)
)
AS
BEGIN
/* INSER THE BOT STATUS IN DB */
INSERT INTO [dbo].[CT_BotStatus] ([MachineIp],[BotName],[StartTime],[EndTime],[Status],[CreatedDate],[ModifiedDate],[UserName],[Author],[ProcessName],[SubProcessName])
SELECT @MachineIp,@BotName,@StartTime,@EndTime,@Status,@CreatedDate,@ModifiedDate,@Username,@Author,@ProcessName,@SubProcessName

END
GO
/****** Object:  StoredProcedure [dbo].[usp_Get_rptMapping]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rameshkumar.r1
-- Create date: 2017-12-14
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_Get_rptMapping]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT
AS
BEGIN
	--EXEC usp_Get_rptMapping 2
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM rptMapping WHERE WorkflowId = @WorkflowId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetFinId]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetFinId]
(
	@WorkflowId INT,
	@RequestId INT
) AS
--EXEC usp_GetFinId 2,1
BEGIN
	SELECT Fin FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND RequestId = @RequestId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_SavingsLog]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Insert_SavingsLog]
(
	 @SolutionName VARCHAR(100)
	,@LogType VARCHAR(10)
	,@LogMessage VARCHAR(2000)
	,@LogStackTrace VARCHAR(8000) 
)
AS
BEGIN
	DECLARE @SolutionId AS UNIQUEIDENTIFIER

	IF ISNULL(@SolutionName,'') != ''
	BEGIN
		SELECT @SolutionId = SolutionId FROM SavingsRPASolutions WHERE SolutionName = @SolutionName
    END
    
	INSERT INTO SavingsLog(SolutionId,LogType,LogMessage,LogStackTrace,CreatedOn)
	VALUES(@SolutionId,@LogType,@LogMessage,@LogStackTrace,GETDATE())
END



GO
/****** Object:  StoredProcedure [dbo].[uspAHSPlatformGetJsonValue]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspAHSPlatformGetJsonValue]  
 -- Add the parameters for the stored procedure here   
 @WorkflowId INT,  
 @FinId INT  
AS  
BEGIN 
-- EXEC uspAHSPlatformGetJsonValue 1,4
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Insert statements for procedure here  
	IF @FinId = 0  
	BEGIN  
		SELECT * FROM dbo.PBWWorkFlowMaster WHERE WorkFlowId = @WorkflowId  
	END  
	ELSE    
	BEGIN  
		SELECT * FROM PBWWorkflowTransaction WHERE WorkFlowId = @WorkflowId AND Fin = @FinId 
	END  
END  
GO
/****** Object:  StoredProcedure [dbo].[uspCheckPendingTravelDeskStatus]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCheckPendingTravelDeskStatus]          
      @RequestId        INT,  
      @WfId             INT,  
      @Result                 INT   OUTPUT    
AS          
BEGIN     
      /*                      
      PURPOSE           : GETTING MAILS INFORMATION USING SERVICE INTO DB                  
      CREATED BY        : PRABAAKARAN T                      
      CREATED DATE      :     22 SEP 2017    
      */        
        
      SELECT   
            @Result = COUNT(RequestId)   
      FROM pbwworkflowtransaction   
      WHERE Status in ('AcknowledgedTD','PendingTDR','Approved') AND RequestId = @RequestId AND WorkflowId = @WfId  
      AND RoleId IN (24)  
      AND FIN NOT IN (SELECT X.FIN FROM (   
            SELECT FIN FROM PBWWorkflowTransaction AS T WHERE WorkflowId = @WfId AND Status IN ('Acknowledgement','SubmitExpenses')  
            UNION   
            SELECT FIN FROM PBWWorkflowTransactionHistory AS T WHERE WorkflowId = @WfId AND Status IN ('Acknowledged','ExpensesSubmitted')  
            )X)  
        
END 
GO
/****** Object:  StoredProcedure [dbo].[uspCheckTravelDeskMailExists]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[uspCheckTravelDeskMailExists]        
	@RequestId			INT,
	@ReceivedDt			DATETIME,  
	@ConversationId		VARCHAR(MAX) = NULL ,
	@MessageId			VARCHAR(MAX) = NULL ,
	@WfId				INT,
	@Result				INT	OUTPUT  
AS        
BEGIN   
	/*                    
	Purpose           : Getting mails information using service into DB                
	Created By        : Prabaakaran T                    
	Created Date      :	05 sep 2017  
	*/      
	
	SELECT 
		@Result = COUNT(RequestId) 
	FROM PBW_MailInformation 
	WHERE RequestId =@RequestId AND ReceivedDt = @ReceivedDt 
	AND ConversationId = @ConversationId AND MessageId = @MessageId AND WfId = @WfId
END
GO
/****** Object:  StoredProcedure [dbo].[uspEchoSavingsAllIndents]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspEchoSavingsAllIndents]
	-- Add the parameters for the stored procedure here 
	@Year VARCHAR(4),
	@QuarterVal VARCHAR(12)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--EXEC uspEchoSavingsAllIndents '2018','Q1,Q2,Q3,Q4'
	
	
	IF OBJECT_ID('TEMPDB..#TempEchoSavingSimpleView') IS NOT NULL
		DROP TABLE #TempEchoSavingSimpleView
		
	CREATE TABLE #TempEchoSavingSimpleView(QuarterVal VARCHAR(2))
	
	IF CHARINDEX('1',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q1'
	END
	
	IF CHARINDEX('2',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q2'
	END
	
	IF CHARINDEX('3',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q3'
	END
	
	IF CHARINDEX('4',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q4'
	END
 
	 IF OBJECT_ID('TEMPDB..#Temp1') IS NOT NULL
		DROP TABLE #Temp1
	 SELECT WorkflowId,FIN,nvarchar22 INTO #Temp1 FROM(
	 SELECT WorkflowId,FIN,LastModifiedDate,nvarchar22,RANK() OVER(PARTITION BY Fin ORDER BY LastModifiedDate DESC) RwNo
	 FROM rptTransaction as I WHERE WorkflowId = 28 AND I.RoleId NOT IN (66,69,-100)
	 )X WHERE RwNo = 1
	 
    -- Insert statements for procedure here
	SELECT RIGHT('000' + CONVERT(VARCHAR(3),Row_number() OVER(ORDER BY Createddate)),3) ProjectNo,nvarchar6 Vertical,nvarchar7 ScopeIdentification,nvarchar8 Client,nvarchar9 LOB,nvarchar10 ProjClient,nvarchar11 SubProcess
	,nvarchar12 NewOpportunity,CASE WHEN nvarchar21 = '' THEN 'Pending' ELSE CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),nvarchar21)) END ProjectedFTE
	--,CASE WHEN nvarchar22 = '' THEN ISNULL((SELECT TOP 1 CASE WHEN nvarchar22 = '' THEN 'Pending' ELSE CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),nvarchar22)) END FROM rptTransaction as I WHERE I.WorkflowId = O.WorkflowId AND I.Fin = O.Fin AND I.RoleId NOT IN (66,69,-100) ORDER BY LastModifiedDate Desc),'Pending') ELSE CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),nvarchar22)) END ConfirmedFTE
	,CASE WHEN ISNULL(nvarchar22,'') = '' THEN ISNULL((SELECT CASE WHEN ISNULL(nvarchar22,'') = '' THEN 'Pending' ELSE CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),nvarchar22)) END FROM #Temp1 as I WHERE I.WorkflowId = O.WorkflowId AND I.Fin = O.Fin),'Pending') ELSE CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),nvarchar22)) END ConfirmedFTE
	,CASE WHEN nvarchar23 = '' THEN 'Pending' ELSE CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),nvarchar23)) END ApprovedFTE
	,Fin,WorkFlowStateId,nvarchar26 [Year],nvarchar27 [Quarter]
	--,CASE WHEN ISDATE(nvarchar28) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar28),106) ELSE nvarchar28 END ProjectStartDate
	--,CASE WHEN ISDATE(nvarchar29) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar29),106) ELSE nvarchar29 END ProjectEndDate 
	,CASE WHEN ISDATE(nvarchar28) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar28),106) ELSE nvarchar28 END ProjectStartDate
		,CASE WHEN ISDATE(nvarchar29) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar29),106) ELSE nvarchar29 END ProjectEndDate 				
		,CASE WHEN ISDATE(nvarchar30) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar30),106) ELSE nvarchar30 END ReqGivenDate
		,CASE WHEN ISDATE(nvarchar31) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar31),106) ELSE nvarchar31 END ReqSignOffDate
		,CASE WHEN ISDATE(nvarchar32) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar32),106) ELSE nvarchar32 END DevStartDate
		,CASE WHEN ISDATE(nvarchar33) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar33),106) ELSE nvarchar33 END DevAgEndDate
		,CASE WHEN ISDATE(nvarchar34) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar34),106) ELSE nvarchar34 END DevAcEndDate
		,nvarchar35 DevDeadlinesMissed
		,CASE WHEN ISDATE(nvarchar36) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar36),106) ELSE nvarchar36 END UnitTestStartDate
		,CASE WHEN ISDATE(nvarchar37) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar37),106) ELSE nvarchar37 END UnitTestEndDate
		,CASE WHEN ISDATE(nvarchar38) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar38),106) ELSE nvarchar38 END UATStartDate
		,CASE WHEN ISDATE(nvarchar39) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar39),106) ELSE nvarchar39 END UATEndDate
		, nvarchar40 ReasonsForDevDeadlineMissed, nvarchar41 ReasonsForReqChangesOPS, nvarchar42 ReasonsForReqChangesBT
	FROM rptTransaction AS O WHERE WorkflowId = 28 AND LogId = 0 
	AND nvarchar26 = @Year AND ISNULL(nvarchar27,'') in (SELECT QuarterVal FROM #TempEchoSavingSimpleView)
	AND ISNULL(nvarchar6,'') != ''
END

 
GO
/****** Object:  StoredProcedure [dbo].[uspEchoSavingsAllIndents_Home]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspEchoSavingsAllIndents_Home]
	-- Add the parameters for the stored procedure here 
	@Year VARCHAR(4),
	@QuarterVal VARCHAR(12),
	@FTEClickBox VARCHAR(1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
	IF OBJECT_ID('TEMPDB..#TempEchoSavingSimpleView') IS NOT NULL
		DROP TABLE #TempEchoSavingSimpleView
		
	CREATE TABLE #TempEchoSavingSimpleView(QuarterVal VARCHAR(2))
	
	IF CHARINDEX('1',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q1'
	END
	
	IF CHARINDEX('2',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q2'
	END
	
	IF CHARINDEX('3',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q3'
	END
	
	IF CHARINDEX('4',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q4'
	END
 
	IF OBJECT_ID('TEMPDB..#TempAllContentsHome') IS NOT NULL
		DROP TABLE #TempAllContentsHome
    -- Insert statements for procedure here
	SELECT nvarchar14,Createddate,nvarchar6 Vertical,nvarchar7 ScopeIdentification,nvarchar8 Client,nvarchar9 LOB,nvarchar10 ProjClient,nvarchar11 SubProcess
	,nvarchar12 NewOpportunity,CASE WHEN nvarchar21 = '' THEN 'Pending' ELSE CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),nvarchar21)) END ProjectedFTE
	,CASE WHEN nvarchar22 = '' THEN ISNULL((SELECT TOP 1 CASE WHEN nvarchar22 = '' THEN 'Pending' ELSE CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),nvarchar22)) END FROM rptTransaction as I WHERE I.WorkflowId = O.WorkflowId AND I.Fin = O.Fin AND I.RoleId NOT IN (66,69,-100) ORDER BY LastModifiedDate Desc),'Pending') ELSE CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),nvarchar22)) END ConfirmedFTE,CASE WHEN nvarchar23 = '' THEN 'Pending' ELSE CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),nvarchar23)) END ApprovedFTE
	,Fin,WorkFlowStateId,nvarchar26 [Year],nvarchar27 [Quarter]
	--,CASE WHEN ISDATE(nvarchar28) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar28),106) ELSE nvarchar28 END ProjectStartDate
	--,CASE WHEN ISDATE(nvarchar29) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar29),106) ELSE nvarchar29 END ProjectEndDate 
	,CASE WHEN ISDATE(nvarchar28) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar28),106) ELSE nvarchar28 END ProjectStartDate
		,CASE WHEN ISDATE(nvarchar29) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar29),106) ELSE nvarchar29 END ProjectEndDate 				
		,CASE WHEN ISDATE(nvarchar30) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar30),106) ELSE nvarchar30 END ReqGivenDate
		,CASE WHEN ISDATE(nvarchar31) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar31),106) ELSE nvarchar31 END ReqSignOffDate
		,CASE WHEN ISDATE(nvarchar32) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar32),106) ELSE nvarchar32 END DevStartDate
		,CASE WHEN ISDATE(nvarchar33) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar33),106) ELSE nvarchar33 END DevAgEndDate
		,CASE WHEN ISDATE(nvarchar34) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar34),106) ELSE nvarchar34 END DevAcEndDate
		,nvarchar35 DevDeadlinesMissed
		,CASE WHEN ISDATE(nvarchar36) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar36),106) ELSE nvarchar36 END UnitTestStartDate
		,CASE WHEN ISDATE(nvarchar37) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar37),106) ELSE nvarchar37 END UnitTestEndDate
		,CASE WHEN ISDATE(nvarchar38) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar38),106) ELSE nvarchar38 END UATStartDate
		,CASE WHEN ISDATE(nvarchar39) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar39),106) ELSE nvarchar39 END UATEndDate
		, nvarchar40 ReasonsForDevDeadlineMissed, nvarchar41 ReasonsForReqChangesOPS, nvarchar42 ReasonsForReqChangesBT 
	INTO #TempAllContentsHome
	FROM rptTransaction AS O WHERE WorkflowId = 28 AND LogId = 0 
	AND nvarchar26 = @Year AND ISNULL(nvarchar27,'') in (SELECT QuarterVal FROM #TempEchoSavingSimpleView)
	AND ISNULL(nvarchar6,'') != ''
	
	IF @FTEClickBox = 4
	BEGIN
		SELECT RIGHT('000' + CONVERT(VARCHAR(3),Row_number() OVER(ORDER BY Createddate)),3) ProjectNo,* FROM #TempAllContentsHome WHERE ISNULL(ApprovedFTE,'') != 'Pending'
	END
	ELSE IF @FTEClickBox = 3
	BEGIN
		SELECT RIGHT('000' + CONVERT(VARCHAR(3),Row_number() OVER(ORDER BY Createddate)),3) ProjectNo,* FROM #TempAllContentsHome WHERE ISNULL(ConfirmedFTE,'') != 'Pending'
	END
	ELSE IF @FTEClickBox = 2
	BEGIN
		SELECT RIGHT('000' + CONVERT(VARCHAR(3),Row_number() OVER(ORDER BY Createddate)),3) ProjectNo,* FROM #TempAllContentsHome AS T WHERE ISNULL(ProjectedFTE,'') != 'Pending' AND EXISTS (SELECT 1 FROM rptTransaction AS R WHERE R.WorkflowId =28 AND R.Fin = T.Fin AND ISNULL(R.Status,'') = 'Submitted')
	END
	ELSE 
	BEGIN
		SELECT RIGHT('000' + CONVERT(VARCHAR(3),Row_number() OVER(ORDER BY Createddate)),3) ProjectNo,* FROM #TempAllContentsHome
	END
	
END

 
GO
/****** Object:  StoredProcedure [dbo].[uspEchoSavingsApprovalIndents]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspEchoSavingsApprovalIndents]
	-- Add the parameters for the stored procedure here 
	@UserId VARCHAR(MAX)
AS
BEGIN
 --exec uspEchoSavingsApprovalIndents 'mohammedsafiyu.a'
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
 
    -- Insert statements for procedure here
	SELECT RIGHT('000' + CONVERT(VARCHAR(3),Row_number() OVER(ORDER BY Createddate)),3) ProjectNo,nvarchar6 Vertical,nvarchar7 ScopeIdentification,nvarchar8 Client
	,nvarchar9 LOB,nvarchar10 ProjClient,nvarchar11 SubProcess
	,nvarchar12 NewOpportunity, nvarchar21  ProjectedFTE, nvarchar22 ConfirmedFTE,nvarchar23 ApprovedFTE,Fin,WorkFlowStateId,RoleId,UserId FROM rptTransaction R WHERE WorkflowId = 28 AND LogId = 0 
	AND ISNULL(nvarchar6,'') != '' and RoleId NOT IN (66,-100) AND R.RoleId IN (SELECT DISTINCT UR.RoleId FROM PBWUserRoleMapping AS UR WHERE WorkflowId = 28 AND UniqueId = @UserId)
END
GO
/****** Object:  StoredProcedure [dbo].[uspEchoSavingsAuditTrail]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspEchoSavingsAuditTrail]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT=28,
	@Fin INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    --exec uspEchoSavingsAuditTrail 28,820933
    -- Insert statements for procedure here
	SELECT ROW_NUMBER() OVER(ORDER BY LastModifiedDate,CASE WHEN LogId = 0 THEN 2 ELSE 1 END) SNo,Description ApprovalLevel,nvarchar19 ProcessedBy,CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),CASE WHEN M.RoleId = 66 THEN (CASE WHEN ISNUMERIC(nvarchar21) = 0 THEN '0' ELSE nvarchar21 END)  WHEN M.RoleId = 69 THEN (CASE WHEN ISNUMERIC(nvarchar23) = 0 THEN '0' ELSE nvarchar23 END) ELSE (CASE WHEN ISNUMERIC(nvarchar22) = 0 THEN '0' ELSE nvarchar22 END) END)) FTE
	,nvarchar25 Comments,CONVERT(VARCHAR(16),LastModifiedDate,106) + ' ' + CONVERT(VARCHAR(16),LastModifiedDate,108) ProcessedOn,Status,nvarchar24 FolderPath
	FROM rptTransaction AS r 
	INNER JOIN PBWWorkFlowRoleMaster AS M ON r.WorkflowId = M.WfId AND r.RoleId = M.RoleId WHERE M.WfId = 28 
	and Fin =@Fin
	ORDER BY LastModifiedDate,CASE WHEN LogId = 0 THEN 2 ELSE 1 END
	--SELECT ROW_NUMBER() OVER(ORDER BY LastModifiedDate,CASE WHEN LogId = 0 THEN 2 ELSE 1 END) SNo,Description ApprovalLevel,nvarchar19 ProcessedBy,CONVERT(VARCHAR(25),CONVERT(NUMERIC(15,2),CASE WHEN M.RoleId = 66 THEN (CASE WHEN ISNUMERIC(nvarchar21) = 0 THEN '0' ELSE nvarchar21 END)  WHEN M.RoleId = 69 THEN (CASE WHEN ISNUMERIC(nvarchar23) = 0 THEN '0' ELSE nvarchar23 END) END)) FTE
	--,nvarchar25 Comments,CONVERT(VARCHAR(16),LastModifiedDate,106) + ' ' + CONVERT(VARCHAR(16),LastModifiedDate,108) ProcessedOn,Status,nvarchar24 FolderPath
	--FROM rptTransaction AS r 
	--INNER JOIN PBWWorkFlowRoleMaster AS M ON r.WorkflowId = M.WfId AND r.RoleId = M.RoleId WHERE @WorkflowId = 28 and Fin =@Fin
	--ORDER BY LastModifiedDate,CASE WHEN LogId = 0 THEN 2 ELSE 1 END
END
GO
/****** Object:  StoredProcedure [dbo].[uspEchoSavingsDetailed]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspEchoSavingsDetailed]
	-- Add the parameters for the stored procedure here 
	@Year VARCHAR(4),
	@QuarterVal VARCHAR(12)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF OBJECT_ID('TEMPDB..#TempEchoSavingSimpleView') IS NOT NULL
		DROP TABLE #TempEchoSavingSimpleView
		
	CREATE TABLE #TempEchoSavingSimpleView(QuarterVal VARCHAR(2))
	
	IF CHARINDEX('1',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q1'
	END
	
	IF CHARINDEX('2',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q2'
	END
	
	IF CHARINDEX('3',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q3'
	END
	
	IF CHARINDEX('4',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q4'
	END
 
	IF OBJECT_ID('TempDB..#TempSavingsDetailed') IS NOT NULL
		DROP TABLE #TempSavingsDetailed
	SELECT nvarchar6 Vertical,CONVERT(NUMERIC(15,2),SUM(CONVERT(FLOAT,nvarchar21))) OverAllProjectedFTE
	,CONVERT(NUMERIC(15,2),SUM(CASE WHEN nvarchar16 ='Enterprise' THEN CONVERT(FLOAT,nvarchar21) END)) EnterpriseProjectedFTE
	,CONVERT(NUMERIC(15,2),SUM(CASE WHEN nvarchar16 ='Marquee' THEN CONVERT(FLOAT,nvarchar21) END)) MarqueeProjectedFTE
	,CONVERT(NUMERIC(15,2),SUM(CASE WHEN nvarchar16 ='Niche' THEN CONVERT(FLOAT,nvarchar21) END)) NicheProjectedFTE,Fin 
	INTO #TempSavingsDetailed
	FROM rptTransaction AS O WHERE WorkflowId = 28 AND Status ='Submitted'  AND LogId != 0
	AND nvarchar26 = @Year AND ISNULL(nvarchar27,'') in (SELECT QuarterVal FROM #TempEchoSavingSimpleView)
	GROUP BY nvarchar6,Fin
	
	IF OBJECT_ID('TempDB..#TempSavingsDetailed1') IS NOT NULL
		DROP TABLE #TempSavingsDetailed1	
	SELECT nvarchar6 Vertical,CONVERT(NUMERIC(15,2),SUM(CONVERT(FLOAT,nvarchar22))) OverAllConfirmedFTE
	,CONVERT(NUMERIC(15,2),SUM(CASE WHEN nvarchar16 ='Enterprise' THEN CONVERT(FLOAT,nvarchar22) END)) EnterpriseConfirmedFTE
	,CONVERT(NUMERIC(15,2),SUM(CASE WHEN nvarchar16 ='Marquee' THEN CONVERT(FLOAT,nvarchar22) END)) MarqueeConfirmedFTE
	,CONVERT(NUMERIC(15,2),SUM(CASE WHEN nvarchar16 ='Niche' THEN CONVERT(FLOAT,nvarchar22) END)) NicheConfirmedFTE,Fin 
	INTO #TempSavingsDetailed1
	FROM rptTransaction AS O WHERE WorkflowId = 28 AND LogId = 0
	AND nvarchar26 = @Year AND ISNULL(nvarchar27,'') in (SELECT QuarterVal FROM #TempEchoSavingSimpleView)
	GROUP BY nvarchar6,Fin
	
	SELECT T.Vertical,SUM(OverAllProjectedFTE) OverAllProjectedFTE,SUM(OverAllConfirmedFTE) OverAllConfirmedFTE
	,SUM(EnterpriseProjectedFTE) EnterpriseProjectedFTE,SUM(EnterpriseConfirmedFTE) EnterpriseConfirmedFTE
	,SUM(MarqueeProjectedFTE) MarqueeProjectedFTE,SUM(MarqueeConfirmedFTE) MarqueeConfirmedFTE
	,SUM(NicheProjectedFTE) NicheProjectedFTE,SUM(NicheConfirmedFTE) NicheConfirmedFTE,1 OrderBy
	FROM #TempSavingsDetailed AS T INNER JOIN #TempSavingsDetailed1 AS T1 ON T.Fin = T1.Fin
	GROUP BY T.Vertical
	UNION ALL
	SELECT 'OverAll' Vertical,SUM(OverAllProjectedFTE) OverAllProjectedFTE,SUM(OverAllConfirmedFTE) OverAllConfirmedFTE
	,SUM(EnterpriseProjectedFTE) EnterpriseProjectedFTE,SUM(EnterpriseConfirmedFTE) EnterpriseConfirmedFTE
	,SUM(MarqueeProjectedFTE) MarqueeProjectedFTE,SUM(MarqueeConfirmedFTE) MarqueeConfirmedFTE
	,SUM(NicheProjectedFTE) NicheProjectedFTE,SUM(NicheConfirmedFTE) NicheConfirmedFTE,2 Orderby
	FROM #TempSavingsDetailed AS T INNER JOIN #TempSavingsDetailed1 AS T1 ON T.Fin = T1.Fin	 
	ORDER BY OrderBy,Vertical
	
END
 

 
GO
/****** Object:  StoredProcedure [dbo].[uspEchoSavingsFinanceIndents]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspEchoSavingsFinanceIndents]
	-- Add the parameters for the stored procedure here 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- exec uspEchoSavingsFinanceIndents
    -- Insert statements for procedure here
	SELECT RIGHT('000' + CONVERT(VARCHAR(3),Row_number() OVER(ORDER BY Createddate)),3) ProjectNo,nvarchar6 Vertical,nvarchar7 ScopeIdentification,nvarchar8 Client
	,nvarchar9 LOB,nvarchar10 ProjClient,nvarchar11 SubProcess
	,nvarchar12 NewOpportunity,nvarchar21 ProjectedFTE,nvarchar22 ConfirmedFTE,nvarchar23 ApprovedFTE,Fin,WorkFlowStateId FROM rptTransaction WHERE WorkflowId = 28 AND LogId = 0 
	AND ISNULL(nvarchar6,'') != '' and RoleId = 69
END
GO
/****** Object:  StoredProcedure [dbo].[uspEchoSavingsMasterView]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspEchoSavingsMasterView]
	-- Add the parameters for the stored procedure here 
	@WorkflowId INT = 28,
	@Fin INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @Fin != 0
    BEGIN
		SELECT nvarchar6 Vertical,nvarchar7 ScopeIdentification,nvarchar8 Client,nvarchar9 LOB,nvarchar10 ProjClient,nvarchar11 SubProcess
		,nvarchar12 NewOpportunity,nvarchar13 Location,nvarchar14 FlatSavings,nvarchar15 SavingsType,nvarchar16 ClientType,nvarchar17 AutomationScope
		,nvarchar18 CurStatus,Fin,WorkFlowStateId,nvarchar26 [Year],nvarchar27 [Quarter]
		,CASE WHEN ISDATE(nvarchar28) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar28),106) ELSE nvarchar28 END ProjectStartDate
		,CASE WHEN ISDATE(nvarchar29) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar29),106) ELSE nvarchar29 END ProjectEndDate 				
		,CASE WHEN ISDATE(nvarchar30) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar30),106) ELSE nvarchar30 END ReqGivenDate
		,CASE WHEN ISDATE(nvarchar31) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar31),106) ELSE nvarchar31 END ReqSignOffDate
		,CASE WHEN ISDATE(nvarchar32) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar32),106) ELSE nvarchar32 END DevStartDate
		,CASE WHEN ISDATE(nvarchar33) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar33),106) ELSE nvarchar33 END DevAgEndDate
		,CASE WHEN ISDATE(nvarchar34) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar34),106) ELSE nvarchar34 END DevAcEndDate
		,nvarchar35 DevDeadlinesMissed
		,CASE WHEN ISDATE(nvarchar36) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar36),106) ELSE nvarchar36 END UnitTestStartDate
		,CASE WHEN ISDATE(nvarchar37) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar37),106) ELSE nvarchar37 END UnitTestEndDate
		,CASE WHEN ISDATE(nvarchar38) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar38),106) ELSE nvarchar38 END UATStartDate
		,CASE WHEN ISDATE(nvarchar39) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar39),106) ELSE nvarchar39 END UATEndDate
		, nvarchar40 ReasonsForDevDeadlineMissed, nvarchar41 ReasonsForReqChangesOPS, nvarchar42 ReasonsForReqChangesBT  
		FROM rptTransaction WHERE WorkflowId = @WorkflowId AND LogId = 0 AND Fin = @Fin 
		AND ISNULL(nvarchar6,'') != '' 
	END
	ELSE
	BEGIN
		SELECT nvarchar6 Vertical,nvarchar7 ScopeIdentification,nvarchar8 Client,nvarchar9 LOB,nvarchar10 ProjClient,nvarchar11 SubProcess
		,nvarchar12 NewOpportunity,nvarchar13 Location,nvarchar14 FlatSavings,nvarchar15 SavingsType,nvarchar16 ClientType,nvarchar17 AutomationScope
		,nvarchar18 CurStatus,Fin,WorkFlowStateId,nvarchar26 [Year],nvarchar27 [Quarter]
		,CASE WHEN ISDATE(nvarchar28) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar28),106) ELSE nvarchar28 END ProjectStartDate
		,CASE WHEN ISDATE(nvarchar29) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar29),106) ELSE nvarchar29 END ProjectEndDate		
		,CASE WHEN ISDATE(nvarchar30) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar30),106) ELSE nvarchar30 END ReqGivenDate
		,CASE WHEN ISDATE(nvarchar31) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar31),106) ELSE nvarchar31 END ReqSignOffDate
		,CASE WHEN ISDATE(nvarchar32) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar32),106) ELSE nvarchar32 END DevStartDate
		,CASE WHEN ISDATE(nvarchar33) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar33),106) ELSE nvarchar33 END DevAgEndDate
		,CASE WHEN ISDATE(nvarchar34) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar34),106) ELSE nvarchar34 END DevAcEndDate
		,nvarchar35 DevDeadlinesMissed
		,CASE WHEN ISDATE(nvarchar36) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar36),106) ELSE nvarchar36 END UnitTestStartDate
		,CASE WHEN ISDATE(nvarchar37) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar37),106) ELSE nvarchar37 END UnitTestEndDate
		,CASE WHEN ISDATE(nvarchar38) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar38),106) ELSE nvarchar38 END UATStartDate
		,CASE WHEN ISDATE(nvarchar39) = 1 THEN CONVERT(VARCHAR(16),CONVERT(DATE,nvarchar39),106) ELSE nvarchar39 END UATEndDate
		, nvarchar40 ReasonsForDevDeadlineMissed, nvarchar41 ReasonsForReqChangesOPS, nvarchar42 ReasonsForReqChangesBT 
		FROM rptTransaction WHERE WorkflowId = @WorkflowId and LogId = 0 
		AND ISNULL(nvarchar6,'') != ''
	END
END
GO
/****** Object:  StoredProcedure [dbo].[uspEchoSavingsSimple]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspEchoSavingsSimple]
	-- Add the parameters for the stored procedure here 
	@Year VARCHAR(4),
	@QuarterVal VARCHAR(12)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF OBJECT_ID('TEMPDB..#TempEchoSavingSimpleView') IS NOT NULL
		DROP TABLE #TempEchoSavingSimpleView
		
	CREATE TABLE #TempEchoSavingSimpleView(QuarterVal VARCHAR(2))
	
	IF CHARINDEX('1',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q1'
	END
	
	IF CHARINDEX('2',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q2'
	END
	
	IF CHARINDEX('3',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q3'
	END
	
	IF CHARINDEX('4',@QuarterVal) > 0
	BEGIN
		INSERT INTO #TempEchoSavingSimpleView(QuarterVal)
		SELECT 'Q4'
	END
	
 
	DECLARE @TargetFTE VARCHAR(10)
	DECLARE @ProjectedFTE VARCHAR(10)
	DECLARE @ConfirmedFTE VARCHAR(10)
	DECLARE @ApprovedFTE VARCHAR(10)
	SET @TargetFTE = 0
	SET @ProjectedFTE = 0
	SET @ConfirmedFTE = 0
	SET @ApprovedFTE = 0
    -- Insert statements for procedure here
	SELECT @TargetFTE= SUM(CONVERT(FLOAT,nvarchar14)) FROM rptTransaction AS O WHERE WorkflowId = 28 AND LogId = 0 AND nvarchar26 = @Year AND ISNULL(nvarchar27,'') in (SELECT QuarterVal FROM #TempEchoSavingSimpleView)
 
	SELECT @ProjectedFTE = SUM(CONVERT(FLOAT,nvarchar21))   FROM rptTransaction AS O WHERE WorkflowId = 28 AND Status ='Submitted'  AND LogId != 0  AND nvarchar26 = @Year AND ISNULL(nvarchar27,'') in (SELECT QuarterVal FROM #TempEchoSavingSimpleView)
	
	SELECT @ConfirmedFTE= SUM(CONVERT(FLOAT,nvarchar22)) FROM rptTransaction AS O WHERE WorkflowId = 28 AND LogId = 0 AND nvarchar26 = @Year AND ISNULL(nvarchar27,'') in (SELECT QuarterVal FROM #TempEchoSavingSimpleView)
 
	SELECT @ApprovedFTE = SUM(CONVERT(FLOAT,nvarchar23))   FROM rptTransaction AS O WHERE WorkflowId = 28 AND LogId = 0 AND nvarchar26 = @Year AND ISNULL(nvarchar27,'') in (SELECT QuarterVal FROM #TempEchoSavingSimpleView)
	
	SELECT CONVERT(NUMERIC(15,2),ISNULL(ROUND(@TargetFTE,2),0)) TargetFTE,CONVERT(NUMERIC(15,2),ISNULL(ROUND(@ProjectedFTE,2),0)) ProjectedFTE,CONVERT(NUMERIC(15,2),ISNULL(ROUND(@ConfirmedFTE,2),0)) ConfirmedFTE,CONVERT(NUMERIC(15,2),ISNULL(ROUND(@ApprovedFTE,2),0)) ApprovedFTE
	
END
 

 
GO
/****** Object:  StoredProcedure [dbo].[uspGetApprovalRoleId]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC uspGetApprovalRoleId @WorkflowId = 1,@UserId = 'prabaakaran.t'
	EXEC uspGetApprovalRoleId @WorkflowId = 1,@UserId = 'seenaa.nataraja'
*/
CREATE PROCEDURE [dbo].[uspGetApprovalRoleId]
	@WorkflowId		INT,
	@UserId			VARCHAR(100) = ''
AS
BEGIN
	/*
	CREATED BY  : PRABAAKARAN T
	CREATED DT	: 2017-07-24
	PURPOSE     : GET USER ROLL ID
	*/

	SET NOCOUNT ON
	
	SELECT 
		RoleId
	FROM PBWUserRoleMapping WHERE UniqueId = @UserId AND WorkflowId = @WorkflowId
	
	SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[uspGetCity]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetCity]
	@STATE_ID		INT = NULL,	
	@COUNTRY_ID		INT = NULL
AS
BEGIN
	/*
	CREATED BY		: PRABAAKARAN T
	CREATED DT		: 2017-11-01
	PURPOSE			: AR TEST PROCESS
	TICKET/SCR NO	: SCR - 1422
	*/
	
	/*
		EXEC uspGetCity @STATE_ID = 24,@COUNTRY_ID = 0
	*/
	
	SET NOCOUNT ON
	
	DECLARE @SQL	VARCHAR(MAX) =''
	SET @SQL = '	
	SELECT
		*
	FROM PBWCities C 
	INNER JOIN PBWStates S ON S.StateId = C.StateId AND S.Active=1
	INNER JOIN PBWCountries CO ON CO.CountryId = S.CountryId AND CO.Active=1
	WHERE C.Active=1 ' 
	
	IF ISNULL(@STATE_ID,0) > 0
		BEGIN
			SET @SQL = @SQL + ' AND S.StateId = '+CONVERT(VARCHAR(10),@STATE_ID)+' '  
		END
	IF ISNULL(@COUNTRY_ID,0) > 0
		BEGIN
			SET @SQL = @SQL + ' AND CO.CountryId = '+CONVERT(VARCHAR(10),@COUNTRY_ID)+' '
		END	
	EXEC(@SQL)
	SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetCityStateCountryDetails]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC uspGetCityStateCountryDetails @CityNames='Bombuflat,Garacharma,Port Blair,Rangat,Addanki',@CityId='',@StateId='',@CountryId=''
	EXEC uspGetCityStateCountryDetails @CityNames='',@CityId='',@StateId='22',@CountryId=''
	EXEC uspGetCityStateCountryDetails @CityNames='',@CityId='',@StateId='',@CountryId='101'
	EXEC uspGetCityStateCountryDetails @CityNames='',@CityId='0',@StateId='0',@CountryId='0'
	EXEC uspGetCityStateCountryDetails @CityNames='',@CityId=0,@StateId=0,@CountryId=0
*/
CREATE PROCEDURE [dbo].[uspGetCityStateCountryDetails]
	@CityNames		VARCHAR(MAX) = '',
	@CityId			INT = 0,
	@StateId		INT = 0,
	@CountryId		INT = 0
AS
BEGIN
	/*
	CREATED BY		: PRABAAKARAN T
	CREATED DATE	: 2017-11-06	
	*/
	SET NOCOUNT ON
	
	/*
	DECLARE
	@CityNames		VARCHAR(250) = '',
	@CityId			VARCHAR(10) = '0',
	@StateId		VARCHAR(10) = '0',
	@CountryId		VARCHAR(10) = '0'
	*/
	
	SET @CityNames = ISNULL(@CityNames,'')
	
	DECLARE @SQL	VARCHAR(MAX) =''
	
	SET @SQL = '			
	SELECT DISTINCT
		*
	FROM PBWCountries C
	INNER JOIN PBWStates S ON S.CountryId = C.CountryID AND S.Active = 1
	INNER JOIN PBWCities CI ON CI.StateId = S.StateId AND CI.Active = 1
	WHERE C.Active = 1'
	IF ISNULL(@CityNames,'') <> ''	
		BEGIN
			--SET @SQL = @SQL + ' AND CI.CityName = '''+@CityName+''' '
			SET @SQL = @SQL + ' AND CI.CityName IN ( SELECT items FROM [dbo].[fnSplitString]('''+@CityNames+''','','' ) )  '
		END	
	IF ISNULL(@CityId,0) > 0
		BEGIN
			SET @SQL = @SQL + ' AND CI.CityId = '+CONVERT(VARCHAR(10),@CityId)+' '
		END
	IF ISNULL(@StateId,0) > 0
		BEGIN
			SET @SQL = @SQL + ' AND S.StateId = '+CONVERT(VARCHAR(10),@StateId)+' '
		END	
	IF ISNULL(@CountryId,0) > 0
		BEGIN
			SET @SQL = @SQL + ' AND C.CountryId = '+CONVERT(VARCHAR(10),@CountryId)+' '
		END					
	
	EXEC(@SQL);
	
	SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetCityTier]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetCityTier]
	@STATE_ID		INT = NULL,	
	@COUNTRY_ID		INT = NULL
AS
BEGIN
	/*
	CREATED BY		: PRABAAKARAN T
	CREATED DT		: 2017-11-23
	PURPOSE			: AR TEST PROCESS
	TICKET/SCR NO	: SCR - 1422
	*/
	
	/*
		EXEC uspGetCityTier @STATE_ID = 24,@COUNTRY_ID = 0
	*/
	
	SET NOCOUNT ON
	
	DECLARE @SQL	VARCHAR(MAX) =''
	SET @SQL = '	
	SELECT
		*
	FROM PBWCities C 
	INNER JOIN PBWStates S ON S.StateId = C.StateId AND S.Active=1
	INNER JOIN PBWCountries CO ON CO.CountryId = S.CountryId AND CO.Active=1
	WHERE C.Active=1 AND ISNULL(C.Tier,0) <> 0 ' 
	
	IF ISNULL(@STATE_ID,0) > 0
		BEGIN
			SET @SQL = @SQL + ' AND S.StateId = '+CONVERT(VARCHAR(10),@STATE_ID)+' '  
		END
	IF ISNULL(@COUNTRY_ID,0) > 0
		BEGIN
			SET @SQL = @SQL + ' AND CO.CountryId = '+CONVERT(VARCHAR(10),@COUNTRY_ID)+' '
		END	
	EXEC(@SQL)
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetClient]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[uspGetClient]  
 -- Add the parameters for the stored procedure here  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Insert statements for procedure here  
 --SELECT * FROM ARC_FIN_CLIENT_INFO   
	SELECT 1 Client_Id,'Athena' Client_Name,'Athena' Short_Name,'Athena' FullName,'Athena' OldInternalname
	UNION
	SELECT 2 Client_Id,'Non athena' Client_Name,'Non athena' Short_Name,'Non athena' FullName,'Non athena' OldInternalname
END  
  
GO
/****** Object:  StoredProcedure [dbo].[uspGetClientInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 EXEC uspGetClientInfo @Client ='NMS'
 EXEC uspGetClientInfo @Client =''
*/
CREATE PROCEDURE [dbo].[uspGetClientInfo]
	@Client	VARCHAR(250) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT 
		* 
	FROM ARC_Contract_Customer
	WHERE ( InternalName = @Client OR @Client = '' )
	
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetClosedRequests]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                  
-- Author:  RAMESHKUMAR                  
-- Create date: Jun/06/2017                  
-- Description: GetJSON Value                  
-- =============================================                  
CREATE PROCEDURE  [dbo].[uspGetClosedRequests]                  
 -- Add the parameters for the stored procedure here                   
 @WorkflowId INT        
AS                   
-- EXEC [uspGetClosedRequests] 16              
BEGIN                  
 -- SET NOCOUNT ON added to prevent extra result sets from                  
 -- interfering with SELECT statements.                  
 SET NOCOUNT ON;      
     
 SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W                  
 WHERE W.WorkflowId = @WorkflowId AND UPPER(W.Status) in('Closed','Completed','Submitted','Verified','Acknowledged')     
     
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetCountry]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC uspGetCountry
*/
CREATE PROCEDURE [dbo].[uspGetCountry]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		*
	FROM PBWCountries C 
	WHERE C.Active=1	
	
	SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetCustomerInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 EXEC uspGetClientInfo @Client ='NMS'
 EXEC uspGetClientInfo @Client =''
*/
CREATE PROCEDURE [dbo].[uspGetCustomerInfo]
	@Client	VARCHAR(250) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT 
		CustomerId,FullName,InternalName,ExternalName
	FROM ARC_Contract_Customer
	WHERE ( InternalName = @Client OR @Client = '' )
	
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetDepHeadApprovedComments]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDepHeadApprovedComments]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT = 2,
	@Fin INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') ApprovedBy,nvarchar21 ApprovedComments FROM rptTransaction AS R INNER JOIN PBWUserMaster AS U
	ON R.nvarchar20 = U.UniqueId 
	WHERE WorkflowId = @WorkflowId AND Fin = @Fin AND R.RoleId  = 17 AND SourceColumn = ''
	ORDER BY R.LastModifiedDate DESC
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetDesignation]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rameshkumar
-- Create date: 2017/11/27
-- Description:	Get Facility Master
-- =============================================
CREATE PROCEDURE [dbo].[uspGetDesignation]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT RoleName FROM  dbo.PBWUserDesignation WHERE ISNULL(Grade,'') != '' ORDER BY RoleName
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetDocument]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetDocument]  
 -- Add the parameters for the stored procedure here  
	@WfId INT,
	@FileId INT
AS   
-- EXEC [uspGetPerDiem] 'Domestic','Flight','Prabaakaran.t'
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
	SELECT * FROM dbo.PBWDocuments WHERE WfId = @WfId AND FileId = @FileId 
END 
 

 

GO
/****** Object:  StoredProcedure [dbo].[uspGetDocumentAll]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetDocumentAll]  
 -- Add the parameters for the stored procedure here  
	@WfId			INT,
	@Country		VARCHAR(250) = '',
	@DocCategory	VARCHAR(250) = '',
	@UserId			VARCHAR(250) = ''	
AS   
-- EXEC [uspGetDocumentAll] 2
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
	SET NOCOUNT ON;  
  
	SELECT 
		ROW_NUMBER() OVER(ORDER BY FileId) SNo,* 
	FROM dbo.PBWDocuments 
	WHERE WfId = @WfId 
	/* Added by Prabaa */
	AND ( Country = @Country OR @Country = '' ) 
	AND ( CreatedBy = @UserId OR @UserId = '' )
	AND ( DocCategory = @DocCategory OR @DocCategory = '' )
	
	SET NOCOUNT OFF;  
END 
 

 


GO
/****** Object:  StoredProcedure [dbo].[uspGetExceptionTransactionFin]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetExceptionTransactionFin]  
 -- Add the parameters for the stored procedure here  
 @WfID INT,
 @Fin INT
AS   
-- EXEC [uspGetPerDiem] 'Domestic','Flight','Prabaakaran.t'
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
	 SELECT ExceptionTransactionId,1 ExceptionId,FIN,WfID,ExceptionJson,CreatedBy,CreatedDate FROM PBWWorkFlowExceptionTransaction  WHERE WfID = @WfID AND FIN = @Fin
END 
 

 

GO
/****** Object:  StoredProcedure [dbo].[uspGetExceptionTransactionWfID]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetExceptionTransactionWfID]  
 -- Add the parameters for the stored procedure here  
 @WfID INT
AS   
-- EXEC [uspGetPerDiem] 'Domestic','Flight','Prabaakaran.t'
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
	 SELECT ExceptionTransactionId,1 ExceptionId,FIN,WfID,ExceptionJson,CreatedBy,CreatedDate FROM PBWWorkFlowExceptionTransaction  WHERE WfID = @WfID
END 
 

 

GO
/****** Object:  StoredProcedure [dbo].[uspGetExpensesJsonDataForInsertRptTbl]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetExpensesJsonDataForInsertRptTbl]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT,
	@Fin INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
-- exec uspGetExpensesJsonDataForInsertRptTbl 2,0
    -- Insert statements for procedure here
    DECLARE @strQry AS VARCHAR(MAX)
    DECLARE @strFilter AS VARCHAR(MAX)
    SET @strQry = '' 
    SET @strFilter = '' 
    IF @WorkflowId != 0
    BEGIN
		SET @strFilter += ' AND WfID = '+ CONVERT(VARCHAR(16),@WorkflowId)
    END
    IF @Fin != 0
    BEGIN
		SET @strFilter += ' AND Fin = '+ CONVERT(VARCHAR(16),@Fin)
    END
    
    SET @strQry = '
	SELECT ExceptionTransactionId,ExceptionId,FIN,WfID WorkflowId,ExceptionJson,CreatedBy,REPLACE(CONVERT(VARCHAR(100),CreatedDate,126),''T'','' '') CreatedDate,rptTblSyncDate,rptTranRefId,0 LogId,0 WorkFlowStateId,0 RoleId,'''' Status,'''' UserId,REPLACE(CONVERT(VARCHAR(100),CreatedDate,126),''T'','' '') LastModifiedDate,CreatedBy LastModifiedBy,0 RequestId,'''' WorkflowVersion,'''' WorkflowSubVersion,0 IsTranLastEntry FROM PBWWorkFlowExceptionTransaction WHERE rptTblSyncDate IS NULL'
	SET @strQry +=  @strFilter
    SET @strQry += ' UNION ALL
	SELECT ExceptionTransactionId,ExceptionId,FIN,WfID WorkflowId,ExceptionJson,CreatedBy,REPLACE(CONVERT(VARCHAR(100),CreatedDate,126),''T'','' '') CreatedDate,rptTblSyncDate,rptTranRefId,ExceptionTransactionHistoryId LogId,0 WorkFlowStateId,0 RoleId,'''' Status,'''' UserId,REPLACE(CONVERT(VARCHAR(100),HCreatedDate,126),''T'','' '') LastModifiedDate,HCreatedBy LastModifiedBy,0 RequestId,'''' WorkflowVersion,'''' WorkflowSubVersion,0 IsTranLastEntry FROM PBWWorkFlowExceptionTransactionHistory WHERE rptTblSyncDate IS NULL'
	SET @strQry += @strFilter	  
	print @strQry
	EXEC(@strQry) 
END

 
GO
/****** Object:  StoredProcedure [dbo].[uspGetFacilityMaster]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rameshkumar
-- Create date: 2017/11/27
-- Description:	Get Facility Master
-- =============================================
CREATE PROCEDURE [dbo].[uspGetFacilityMaster]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM FacilityMaster
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetFirstNameLastName]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetFirstNameLastName]
(
	@UniqueId VARCHAR(250)
)
AS 
-- Execute uspGetFirstNameLastName 'jithesh.sundara'
BEGIN 
	SELECT ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') Name FROM PBWUserMaster WHERE UniqueId = @UniqueId
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetGrade]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Oct/19/2017    
-- Description: GetGrade for Setup  
-- =============================================    
CREATE PROCEDURE  [dbo].[uspGetGrade]    
 -- Add the parameters for the stored procedure here    
 @TravelType VARCHAR(256),   
 @Band VARCHAR(256),  
@RuleId INT = 0   
 --Travel Type, Band, Grade  
AS     
-- EXEC uspGetGrade   
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;   
   
      DECLARE @RuleSetId INT  
      SET @RuleSetId = 0  
      SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE RuleSetName = 'PerDiem'  
  
      IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL  
            DROP TABLE #TempFindRules  
              
      CREATE TABLE #TempFindRules  
      (RuleId INT,RuleName NVARCHAR(100),Description  NVARCHAR(100),Condition      NVARCHAR(MAX),ThenAction NVARCHAR(MAX),ElseAction     NVARCHAR(MAX),  
      Priorit INT,Message     NVARCHAR(MAX),TravelType NVARCHAR(MAX),Band NVARCHAR(MAX),Grade NVARCHAR(MAX),TravelBy NVARCHAR(MAX),  
      PerDiem NVARCHAR(MAX),AccommodationLessThan7Days NVARCHAR(MAX),AccommodationMoreThan7Days NVARCHAR(MAX),TransportCharges NVARCHAR(MAX)  
      )  
  
      IF @RuleId = 0  
      BEGIN  
            ;WITH FindRules  
            AS  
            (  
                  SELECT R.RuleId,R.RuleName,R.Description,R.Condition,R.ThenAction,R.ElseAction,R.Priority,R.Message FROM dbo.PRuleSetMapping AS RSM  
                  INNER JOIN dbo.PRuleMaster AS R    
                  ON RSM.RuleId = R.RuleId   
                  WHERE RSM.RuleSetId = @RuleSetId  
            )  
            INSERT INTO #TempFindRules  
            SELECT *  
            ,dbo.Split_PerDiem(Condition,'~','=','TravelType') TravelType       
            ,dbo.Split_PerDiem(Condition,'~','=','Band') Band  
            ,dbo.Split_PerDiem(Condition,'~','=','Grade') Grade  
            ,dbo.Split_PerDiem(ThenAction,'&','=','TravelBy') TravelBy  
            ,dbo.Split_PerDiem(ThenAction,'&','=','PerDiem') PerDiem  
            ,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationLessThan7Days') AccommodationLessThan7Days  
            ,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationMoreThan7Days') AccommodationMoreThan7Days  
            ,dbo.Split_PerDiem(ThenAction,'&','=','TransportCharges') TransportCharges  
            FROM FindRules     
      END  
      ELSE  
      BEGIN  
            ;WITH FindRules  
            AS  
            (  
                  SELECT R.RuleId,R.RuleName,R.Description,R.Condition,R.ThenAction,R.ElseAction,R.Priority,R.Message FROM dbo.PRuleSetMapping AS RSM  
                  INNER JOIN dbo.PRuleMaster AS R    
                  ON RSM.RuleId = R.RuleId   
                  WHERE RSM.RuleSetId = @RuleSetId AND R.RuleId != @RuleId   
            )  
            INSERT INTO #TempFindRules  
            SELECT *  
            ,dbo.Split_PerDiem(Condition,'~','=','TravelType') TravelType       
            ,dbo.Split_PerDiem(Condition,'~','=','Band') Band  
            ,dbo.Split_PerDiem(Condition,'~','=','Grade') Grade  
            ,dbo.Split_PerDiem(ThenAction,'&','=','TravelBy') TravelBy  
            ,dbo.Split_PerDiem(ThenAction,'&','=','PerDiem') PerDiem  
            ,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationLessThan7Days') AccommodationLessThan7Days  
            ,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationMoreThan7Days') AccommodationMoreThan7Days  
            ,dbo.Split_PerDiem(ThenAction,'&','=','TransportCharges') TransportCharges  
            FROM FindRules   
      END  
        
      IF OBJECT_ID('TEMPDB..#TempFindGrade') IS NOT NULL  
            DROP TABLE #TempFindGrade       
                          
      CREATE TABLE #TempFindGrade(RulesGrade VARCHAR(10))  
              
      DECLARE @GradeRule AS VARCHAR(256)  
  
      ;DECLARE CUR_Rules CURSOR FOR   
      SELECT Grade FROM #TempFindRules AS T WHERE T.TravelType = @TravelType AND T.Band = @Band   
      OPEN CUR_Rules  
            FETCH NEXT FROM CUR_Rules INTO @GradeRule  
      WHILE @@FETCH_STATUS = 0  
      BEGIN  
            PRINT @GradeRule  
            INSERT INTO #TempFindGrade  
            SELECT * FROM dbo.fnSplitString(@GradeRule,',')  
            FETCH NEXT FROM CUR_Rules INTO @GradeRule  
      END  
      CLOSE CUR_Rules  
      DEALLOCATE CUR_Rules  
  
      SELECT DISTINCT Grade FROM PBWUserDesignation WHERE Band = @Band and Grade!=''
      AND ISNULL(Grade,'') NOT IN (SELECT RTRIM(LTRIM(RulesGrade)) FROM #TempFindGrade)  
END  
  
GO
/****** Object:  StoredProcedure [dbo].[uspGetGradeOfUserDesignation]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetGradeOfUserDesignation]
	@Designation VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--EXEC uspGetGradeOfUserDesignation 'Lead Developer'
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT LEFT(GRADE,1) Grade FROM PBWUserDesignation WHERE RoleName = @Designation AND ISNULL(Grade,'') != ''
END
 
GO
/****** Object:  StoredProcedure [dbo].[uspGetHR_Functionality]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetHR_Functionality]
	-- Add the parameters for the stored procedure here	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [FunctionName],[JobTitle],[Type] FROM [HR_Functionality]
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetIJPAppliedList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetIJPAppliedList]
	-- Add the parameters for the stored procedure here
	@WorkflowIJPCandidateId INT,
	@IJPId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- EXEC uspGetIJPAppliedList 11,806507 
    -- Insert statements for procedure here
     
	SELECT LEFT(IJPId,CHARINDEX('"',IJPId)-1) IJPId,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,Fin,RequestId
				WorkflowVersion,WorkflowSubVersion,rptTblSyncDate,IsTranLastEntry,rptTranRefId FROM (
			SELECT RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"IJPId","Value":"%',DATAJSON)-LEN('"Key":"IJPId","Value":"')+1) IJPID,
				WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,Fin,RequestId,
				WorkflowVersion,WorkflowSubVersion,rptTblSyncDate,IsTranLastEntry,rptTranRefId
			FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowIJPCandidateId
		)X 
		WHERE LEFT(IJPId,CHARINDEX('"',IJPId)-1) = @IJPId 
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetIJPApprovedList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetIJPApprovedList]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT = 502
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM PBWWorkflowTransaction AS T WHERE WorkflowId = @WorkflowId AND WorkFlowStateId = -14
	--AND T.Fin IN (SELECT FIN FROM PBWWorkflowTransactionHistory AS H WHERE H.WorkflowStateId IN (-11,-9) AND Status = 'Approved')
	--AND Status = 'Closed'
	--AND NOT EXISTS (
	--SELECT 1 FROM PBWWorkflowTransactionHistory AS H 
	--WHERE H.WorkflowId = T.WorkflowId AND T.Fin = H.Fin AND H.Status IN ('Rejected'))
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetIJPCandiateStatusCount]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--=============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetIJPCandiateStatusCount]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT,
	@UserId VARCHAR(256) ='',
	@RawData BIT=0,
	@Status VARCHAR(256)=''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- EXEC uspGetIJPCandiateStatusCount 11,'sofia.a',1,'SPOC Released'
    -- Insert statements for procedure here
	IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL
       DROP TABLE #TempFindRules
    IF OBJECT_ID('TEMPDB..#TempFindRules1') IS NOT NULL
       DROP TABLE #TempFindRules1
	IF @UserId =''
	BEGIN
		SELECT WorkflowId,FIN,LEFT(IJPId,CHARINDEX('"',IJPId)-1) IJPId,LEFT(Status,CHARINDEX('"',Status)-1) Status INTO #TempFindRules FROM (
			SELECT WorkflowId,FIN,RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"IJPId","Value":"%',DATAJSON)-LEN('"Key":"IJPId","Value":"')+1)
			IJPId,RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"CurrentStatus","Value":"%',DATAJSON)-LEN('"Key":"CurrentStatus","Value":"')+1) Status FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId
		)X
		
		IF @RawData = 1
		BEGIN
			SELECT * FROM PBWWorkflowTransaction AS P INNER JOIN #TempFindRules AS T
			ON P.WorkflowId = T.WorkflowId AND P.Fin = T.Fin
			--WHERE T.Status in (@Status)
		END
		ELSE
		BEGIN
			SELECT
				SUM(CASE WHEN Status = 'Applied' THEN 1 END) AppliedCnt,
				SUM(CASE WHEN Status = 'Schedule' THEN 1 
						 when Status = 'ReSchedule' THEN 1 END) ScheduledCnt,
				SUM(CASE WHEN Status = 'Assessment' THEN 1
						 WHEN Status = 'AssessmentValidated' THEN 1 END) AttendedCnt,
				SUM(CASE WHEN Status = 'AwaitingResult' THEN 1 END) AwaitingResultCnt,
				SUM(CASE WHEN Status = 'Select' THEN 1
						 WHEN Status = 'SupervisorRelease' THEN 1
						 WHEN Status = 'SPOC Released' THEN 1 END) SelectedCnt,
				SUM(CASE WHEN Status = 'Reject' THEN 1 END) RejectedCnt
			FROM #TempFindRules
		END
	END
	ELSE
	BEGIN
		SELECT WorkflowId,FIN,LEFT(IJPId,CHARINDEX('"',IJPId)-1) IJPId,LEFT(Status,CHARINDEX('"',Status)-1) Status INTO #TempFindRules1 FROM (
			SELECT WorkflowId,FIN,RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"IJPId","Value":"%',DATAJSON)-LEN('"Key":"IJPId","Value":"')+1)
			 IJPId,RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"CurrentStatus","Value":"%',DATAJSON)-LEN('"Key":"CurrentStatus","Value":"')+1) Status FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId
		)X 
		IF @RawData = 1
		BEGIN
		print 'a'
		print @status
			SELECT * FROM PBWWorkflowTransaction AS P INNER JOIN #TempFindRules1 AS T
			ON P.WorkflowId = T.WorkflowId AND P.Fin = T.Fin
			--WHERE T.Status in (@Status)
		END
		ELSE
		BEGIN
			SELECT
				SUM(CASE WHEN Status = 'Applied' THEN 1 END) AppliedCnt,
				SUM(CASE WHEN Status = 'Schedule' THEN 1 
						 when Status = 'ReSchedule' THEN 1 END) ScheduledCnt,
				SUM(CASE WHEN Status = 'Assessment' THEN 1
						 WHEN Status = 'AssessmentValidated' THEN 1 END) AttendedCnt,
				SUM(CASE WHEN Status = 'AwaitingResult' THEN 1 END) AwaitingResultCnt,
				SUM(CASE WHEN Status = 'Select' THEN 1
						 WHEN Status = 'SupervisorRelease' THEN 1
						 WHEN Status = 'SPOC Released' THEN 1 END) SelectedCnt,
				SUM(CASE WHEN Status = 'Reject' THEN 1 END) RejectedCnt
			FROM #TempFindRules1
		END
	END
 
END








GO
/****** Object:  StoredProcedure [dbo].[uspGetIJPStatusCount]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetIJPStatusCount]
	-- Add the parameters for the stored procedure here
	@WorkflowIJPId INT,
	@WorkflowId INT,	
	@UserId VARCHAR(256) ='',
	@RawData BIT=0,
	@Status VARCHAR(256)=''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- EXEC uspGetIJPStatusCount 502,11,'',1,'OVERALL'
    -- Insert statements for procedure here
    
    
    IF ISNULL(@UserId,'') = ''
    BEGIN
	
		IF @RawData = 1
		BEGIN
			IF UPPER(@Status) = 'OVERALL'
			BEGIN
				SELECT * FROM PBWWorkflowTransaction AS T WHERE WorkflowId = @WorkflowIJPId AND (WorkFlowStateId = -14 OR (RoleId = -100 AND
				EXISTS (SELECT 1 FROM PBWWorkflowTransactionHistory AS H WHERE WorkflowId = @WorkflowIJPId AND WorkFlowStateId = -14 AND H.Fin = T.Fin)))
			END
			ELSE IF UPPER(@Status) = 'OPENED'
			BEGIN
				SELECT * FROM PBWWorkflowTransaction AS T WHERE WorkflowId = @WorkflowIJPId AND Status != 'Closed' AND (WorkFlowStateId = -14 OR (RoleId = -100 AND
				EXISTS (SELECT 1 FROM PBWWorkflowTransactionHistory AS H WHERE WorkflowId = @WorkflowIJPId AND WorkFlowStateId = -14 AND H.Fin = T.Fin)))
			END
			ELSE IF UPPER(@Status) = 'CLOSED'
			BEGIN
				SELECT * FROM PBWWorkflowTransaction AS T WHERE WorkflowId = @WorkflowIJPId AND Status = 'Closed' AND (RoleId = -100 AND
				EXISTS (SELECT 1 FROM PBWWorkflowTransactionHistory AS H WHERE WorkflowId = @WorkflowIJPId AND WorkFlowStateId = -14 AND H.Fin = T.Fin))
			END
		END
		ELSE
		BEGIN
			SELECT 
				SUM(1) OverAllCnt,ISNULL(SUM(1),0) - ISNULL(SUM(CASE WHEN Status = 'Closed' THEN 1 END),0) OpenedCnt,SUM(CASE WHEN Status = 'Closed' THEN 1 END) ClosedCnt 
			FROM PBWWorkflowTransaction AS T WHERE WorkflowId = @WorkflowIJPId
			AND (WorkFlowStateId = -14 OR (RoleId = -100 AND
			EXISTS (SELECT 1 FROM PBWWorkflowTransactionHistory AS H WHERE WorkflowId = @WorkflowIJPId AND WorkFlowStateId = -14 AND H.Fin = T.Fin)))
		END
	END
	ELSE
	BEGIN		
		IF @RawData = 1
		BEGIN
			IF UPPER(@Status) = 'OVERALL'
			BEGIN
				SELECT 
					*
				FROM PBWWorkflowTransaction AS T INNER JOIN 
				(SELECT LEFT(IJPId,CHARINDEX('"',IJPId)-1) IJPId FROM(
					SELECT RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"IJPId","Value":"%',DATAJSON)-LEN('"Key":"IJPId","Value":"')+1) IJPId FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId
				)X)Y ON T.FIN = Y.IJPId 
				WHERE WorkflowId = @WorkflowIJPId AND (WorkFlowStateId = -14 OR (RoleId = -100 AND
				EXISTS (SELECT 1 FROM PBWWorkflowTransactionHistory AS H WHERE WorkflowId = @WorkflowIJPId AND WorkFlowStateId = -14 AND H.Fin = T.Fin)))
			END
			ELSE IF UPPER(@Status) = 'OPENED'
			BEGIN
				SELECT 
					*
				FROM PBWWorkflowTransaction AS T INNER JOIN 
				(SELECT LEFT(IJPId,CHARINDEX('"',IJPId)-1) IJPId FROM(
					SELECT RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"IJPId","Value":"%',DATAJSON)-LEN('"Key":"IJPId","Value":"')+1) IJPId FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId
				)X)Y ON T.FIN = Y.IJPId 
				WHERE WorkflowId = @WorkflowIJPId AND Status != 'Closed' AND (WorkFlowStateId = -14 OR (RoleId = -100 AND
				EXISTS (SELECT 1 FROM PBWWorkflowTransactionHistory AS H WHERE WorkflowId = @WorkflowIJPId AND WorkFlowStateId = -14 AND H.Fin = T.Fin)))
			END
			ELSE IF UPPER(@Status) = 'CLOSED'
			BEGIN
				SELECT 
					*
				FROM PBWWorkflowTransaction AS T INNER JOIN 
				(SELECT LEFT(IJPId,CHARINDEX('"',IJPId)-1) IJPId FROM(
					SELECT RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"IJPId","Value":"%',DATAJSON)-LEN('"Key":"IJPId","Value":"')+1) IJPId FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId
				)X)Y ON T.FIN = Y.IJPId 
				WHERE WorkflowId = @WorkflowIJPId AND (WorkFlowStateId = -14 OR (RoleId = -100 AND
				EXISTS (SELECT 1 FROM PBWWorkflowTransactionHistory AS H WHERE WorkflowId = @WorkflowIJPId AND WorkFlowStateId = -14 AND H.Fin = T.Fin)))
			END
		END
		ELSE
		BEGIN
			print 'b'
			SELECT 
				SUM(1) OverAllCnt,ISNULL(SUM(1),0)- ISNULL(SUM(CASE WHEN Status = 'Closed' THEN 1 END),0) OpenedCnt,SUM(CASE WHEN Status = 'Closed' THEN 1 END) ClosedCnt 
			FROM PBWWorkflowTransaction AS T INNER JOIN 
			(SELECT LEFT(IJPId,CHARINDEX('"',IJPId)-1) IJPId FROM(
				SELECT RIGHT(DATAJSON,LEN(DATAJSON)-PATINDEX('%"Key":"IJPId","Value":"%',DATAJSON)-LEN('"Key":"IJPId","Value":"')+1) IJPId FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId
			)X)Y ON T.FIN = Y.IJPId 
			WHERE WorkflowId = @WorkflowIJPId AND (WorkFlowStateId = -14 OR (RoleId = -100 AND
			EXISTS (SELECT 1 FROM PBWWorkflowTransactionHistory AS H WHERE WorkflowId = @WorkflowIJPId AND WorkFlowStateId = -14 AND H.Fin = T.Fin)))
		END
		
		
	
	END 
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetJDComments]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jan/06/2018  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetJDComments]  
 -- Add the parameters for the stored procedure here  
	@Functionality VARCHAR(256),
	@Designation VARCHAR(256),
	@LOB VARCHAR(256)
AS   
-- EXEC [uspGetJDComments] 'Shared Services – Application Development','Senior Developer','Support'
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    DECLARE @RuleSetId INT
    SET @RuleSetId = 0
    SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE RuleSetName = 'IJPJDComments'

    IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL
       DROP TABLE #TempFindRules
    ;WITH FindRules
    AS
    (
        SELECT R.*,IsActive,RSM.CreatedDate CRD FROM dbo.PRuleSetMapping AS RSM
        INNER JOIN dbo.PRuleMaster AS R  
        ON RSM.RuleId = R.RuleId 
        WHERE RSM.RuleSetId = @RuleSetId
    )
    SELECT  dbo.Split_PerDiem(Condition,'~','=','Functionality') Functionality	
	,dbo.Split_PerDiem(Condition,'~','=','Designation') Designation
	,dbo.Split_PerDiem(Condition,'~','=','LOB') LOB
	,ThenAction JDComments,IsActive,CRD CreatedDate
	INTO #TempFindRules            
    FROM FindRules where IsActive=1 
    
    SELECT * FROM #TempFindRules                 
    WHERE Functionality = @Functionality AND Designation = @Designation AND LOB = @LOB 
   
END 

GO
/****** Object:  StoredProcedure [dbo].[uspGetJDCommentsAll]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jan/06/2018  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetJDCommentsAll]  
 -- Add the parameters for the stored procedure here  
AS   
-- EXEC [uspGetJDCommentsAll] 
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 -- exec uspGetJDCommentsAll
 SET NOCOUNT ON;  
  
	DECLARE @RuleSetId INT
	SET @RuleSetId = 0
	SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE RuleSetName = 'IJPJDComments'
  
	;WITH FindRules
	AS
	(
		SELECT R.*,RSM.CreatedDate CRD FROM dbo.PRuleSetMapping AS RSM
		INNER JOIN dbo.PRuleMaster AS R  
		ON RSM.RuleId = R.RuleId 
		WHERE RSM.RuleSetId = @RuleSetId
		AND RSM.IsActive = 1
	)
	SELECT ROW_NUMBER() OVER(ORDER BY RuleId) SNo 
	,dbo.Split_PerDiem(Condition,'~','=','Functionality') Functionality	
	,dbo.Split_PerDiem(Condition,'~','=','Designation') Designation
	,dbo.Split_PerDiem(Condition,'~','=','LOB') LOB
	,ThenAction JDComments,RuleId,CRD CreateDate
	 FROM FindRules 	 
END  

 



GO
/****** Object:  StoredProcedure [dbo].[uspGetJsonDataForInsertRptTbl]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetJsonDataForInsertRptTbl]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT,
	@Fin INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
-- exec uspGetJsonDataForInsertRptTbl 2,806295
    -- Insert statements for procedure here
    DECLARE @strQry AS VARCHAR(MAX)
    DECLARE @strFilter AS VARCHAR(MAX)
    SET @strQry = '' 
    SET @strFilter = '' 
    IF @WorkflowId != 0
    BEGIN
		SET @strFilter += ' AND WorkflowId = '+ CONVERT(VARCHAR(16),@WorkflowId)
    END
    IF @Fin != 0
    BEGIN
		SET @strFilter += ' AND Fin = '+ CONVERT(VARCHAR(16),@Fin)
    END
    
    SET @strQry = '
	SELECT WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,REPLACE(CONVERT(VARCHAR(100),CreatedDate,126),''T'','' '') CreatedDate,LastModifiedBy,REPLACE(CONVERT(VARCHAR(100),LastModifiedDate,126),''T'','' '') LastModifiedDate,
		   Fin,RequestId,WorkflowVersion,WorkflowSubVersion,rptTblSyncDate,IsTranLastEntry,rptTranRefId,0 LogId,BucketInDate,BucketOutDate FROM PBWWorkflowTransaction WHERE ISNULL(rptTranRefId,0) = 0'
	SET @strQry +=  @strFilter 
    SET @strQry += ' UNION ALL
	SELECT WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,REPLACE(CONVERT(VARCHAR(100),CreatedDate,126),''T'','' '') CreatedDate,LastModifiedBy,REPLACE(CONVERT(VARCHAR(100),LastModifiedDate,126),''T'','' '') LastModifiedDate,
		   Fin,RequestId,WorkflowVersion,WorkflowSubVersion,rptTblSyncDate,IsTranLastEntry,rptTranRefId,LogId,BucketInDate,BucketOutDate FROM PBWWorkflowTransactionHistory WHERE ISNULL(rptTranRefId,0) = 0'
	SET @strQry += @strFilter	  
	EXEC(@strQry) 
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetLOB]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetLOB]
	-- Add the parameters for the stored procedure here	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT UserLob FROM PBWUserMaster 
END
GO
/****** Object:  StoredProcedure [dbo].[uspGETlocation]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGETlocation]      
AS            
BEGIN          
 SELECT 1 Id,'Chennai' LocationName
 UNION 
 SELECT 2 Id,'Chennai/Coimbatore' LocationName
 UNION 
 SELECT 3 Id,'Chennai/Coimbatore/Pune' LocationName
 UNION 
 SELECT 4 Id,'Chennai/Pune' LocationName
 UNION 
 SELECT 5 Id,'Coimbatore' LocationName
 UNION 
 SELECT 6 Id,'Manila' LocationName
 UNION 
 SELECT 7 Id,'Pune' LocationName   
END   
GO
/****** Object:  StoredProcedure [dbo].[uspGetMailId]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Jun/06/2017    
-- Description: GetJSON Value    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspGetMailId]    
 -- Add the parameters for the stored procedure here     
 @NT_UserName VARCHAR(MAX),  
 @RoleName VARCHAR(MAX),  
 @WfId VARCHAR(MAX) = 2  
AS     
-- EXEC uspGetMailId  'rameshkumar.r1','TicketCostUpdater',2  
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;     
   
    IF OBJECT_ID('TempDB..#RoleMail') IS NOT NULL  
  DROP TABLE #RoleMail  
 CREATE TABLE #RoleMail (RoleMailName VARCHAR(100))  
 DECLARE @Input AS VARCHAR(MAX)  
 SET @Input = @RoleName   
 DECLARE @StartIndex INT, @EndIndex INT  
 DECLARE @Delimiter1 AS VARCHAR(1)  
 SET @Delimiter1 = ','  
 DECLARE @OutputValue AS VARCHAR(MAX)  
 SET @OutputValue = ''   
 SET @StartIndex = 1  
 IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Delimiter1  
 BEGIN  
  SET @Input = @Input + @Delimiter1  
 END  
 IF OBJECT_ID('TempDB..#Temp3') IS NOT NULL  
  DROP TABLE #Temp3   
 IF OBJECT_ID('TempDB..#Temp4') IS NOT NULL  
  DROP TABLE #Temp4  
 CREATE TABLE #Temp3(RoleName VARCHAR(MAX),UserId VARCHAR(MAX),EmailId VARCHAR(MAX))   
 CREATE TABLE #Temp4(RoleName VARCHAR(MAX),UserId VARCHAR(MAX),EmailId VARCHAR(MAX))   
 WHILE CHARINDEX(@Delimiter1, @Input) > 0  
 BEGIN  
  SET @EndIndex = CHARINDEX(@Delimiter1, @Input)             
  SET @OutputValue = SUBSTRING(@Input, @StartIndex, @EndIndex - 1)  
  SET @OutputValue = REPLACE(@OutputValue,'"','')  
    
  IF(CHARINDEX('@',@OutputValue) > 0)  
  BEGIN  
   INSERT INTO #Temp3(RoleName,UserId,EmailId) SELECT '','',@OutputValue  
  END  
  ELSE IF(UPPER(@OutputValue) = 'REQUESTER')  
  BEGIN  
   INSERT INTO #Temp3(RoleName,UserId,EmailId)   
   SELECT '','',EmailId FROM PBWUserMaster WHERE UserId = @NT_UserName  
  END  
  ELSE IF(UPPER(@OutputValue) = 'TRAVELDESK')  
  BEGIN  
   INSERT INTO #Temp3(RoleName,UserId,EmailId)   
   SELECT '','','traveldesk@leinfra.in'   
   --  
  END  
  ELSE  
  BEGIN  
   INSERT INTO #RoleMail VALUES(@OutputValue)  
  END  
  SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))  
 END  
   
 IF @WfId = 11 OR @WfId = 502  
 BEGIN  
  INSERT INTO #Temp3(RoleName,UserId,EmailId)   
  SELECT '','','rameshkumar.r1@accesshealthcare.co'   
    
  INSERT INTO #Temp3(RoleName,UserId,EmailId)   
  SELECT '','','shyamsundar.s1@accesshealthcare.co'   
    
  INSERT INTO #Temp3(RoleName,UserId,EmailId)   
  SELECT '','','nagarajan.s3@accesshealthcare.co'   
 END  
   
 IF @WfId = 2  
 BEGIN  
  INSERT INTO #Temp3(RoleName,UserId,EmailId)   
  SELECT '','','prabaakaran.t@accesshealthcare.co'   
  
  INSERT INTO #Temp3(RoleName,UserId,EmailId)   
  SELECT '','','jaiganesh.s@accesshealthcare.co'   
 END  
 
    
       if @WfId = 3
   begin
		INSERT INTO #Temp3(RoleName,UserId,EmailId)   
		SELECT '','','jaiganesh.s@accesshealthcare.co'  
		union
		SELECT '','','ramesh.raju@accesshealthcare.co'   
		union 
		SELECT '','','Shyamsundar.s1@accesshealthcare.co'    
   end
   
 IF OBJECT_ID('TempDB..#Temp1') IS NOT NULL  
  DROP TABLE #Temp1  
 IF OBJECT_ID('TempDB..#Temp2') IS NOT NULL  
  DROP TABLE #Temp2    
   
 DECLARE @i INT  
 SET @i = 0;  
 ;WITH SuperVisor  
 AS  
 (  
  SELECT @i Position,UserId,SuperVisorId,RoleId,EmailId FROM PBWUserMaster AS U WHERE U.UserId = @NT_UserName  
  UNION ALL  
  SELECT Position+1 Position,U.UserId,U.SuperVisorId,U.RoleId,U.EmailId FROM PBWUserMaster AS U INNER JOIN SuperVisor AS S  
  ON U.UserId = S.SuperVisorId  
 )  
 SELECT UserId,SuperVisorId,RoleName,WFR.RoleId,Position,EmailId INTO #Temp1 FROM SuperVisor AS S INNER JOIN PBWUserRoleMapping AS URM   
 ON S.UserId = URM.UniqueId   
 INNER JOIN PBWWorkFlowRoleMaster AS WFR ON URM.RoleId = WFR.RoleId   
 WHERE URM.WorkflowId = @WfId  
 ORDER BY Position    
  
  
 SELECT RoleName,UserId,EmailId INTO #Temp2 FROM #Temp1 WHERE UserId = @NT_UserName AND RoleName IN (SELECT RoleMailName FROM #RoleMail)  
 UNION  
 SELECT RoleName,UserId,EmailId FROM #Temp1 AS T WHERE   
 T.RoleName NOT IN (SELECT TI.RoleName FROM #Temp1 AS TI WHERE TI.UserId = @NT_UserName)   
 AND T.RoleName IN (SELECT RoleMailName FROM #RoleMail)  
   
   
 IF EXISTS(SELECT 1 FROM #RoleMail WHERE UPPER(RoleMailName) IN ('COO','MD','FINANCE','CEO','TRAVELDESK','FM','PE','PM','VC','PH','LEGAL','HRBP','TICKETCOSTUPDATER','ARAPPROVER','ARHEADAPPROVER','BILLINGATHENAAPPROVER','BILLINGNONATHENAAPPROVER','BTHEAD','CODINGAPPROVER'))  
 BEGIN  
  INSERT INTO #Temp4(RoleName,UserId,EmailId)  
  SELECT RoleName,UserId,EmailId FROM #Temp2  
  UNION  
  SELECT RoleName,UserId,EmailId FROM PBWUserMaster AS S  
  INNER JOIN PBWUserRoleMapping AS URM   
  ON S.UserId = URM.UniqueId   
  INNER JOIN PBWWorkFlowRoleMaster AS PWR  
  ON URM.RoleId = PWR.RoleId   
  WHERE PWR.RoleName NOT IN (SELECT T.RoleName FROM #Temp2 AS T)  
  AND PWR.RoleName IN (SELECT RoleMailName FROM #RoleMail)   
  AND URM.WorkflowId = @WfId AND PWR.WfId = @WfId   
 END  
 ELSE  
 BEGIN  
  INSERT INTO #Temp4(RoleName,UserId,EmailId)  
  SELECT RoleName,UserId,EmailId FROM #Temp2    
 END  
   
 print 'a'  
   
 SELECT DISTINCT T4.RoleName,UserId,EmailId FROM #Temp4 AS T4   
 INNER JOIN PBWWorkFlowRoleMaster AS W   
 ON T4.RoleName = W.RoleName WHERE W.HierarchyLevel >= (  
 SELECT TOP 1  WFRM.HierarchyLevel FROM PBWUserRoleMapping AS RM  
 INNER JOIN PBWWorkFlowRoleMaster AS WFRM ON RM.RoleId = WFRM.RoleId  WHERE WFRM.WfId = @WfId AND RM.WorkflowId = @WfId AND RM.UniqueId = @NT_UserName ORDER BY WFRM.HierarchyLevel)   
 UNION  
 SELECT DISTINCT RoleName,UserId,EmailId FROM #Temp3 AS T3 WHERE T3.EmailId NOT IN (SELECT T4.EmailId FROM #Temp4 AS T4)  
END    
  
  
  
  
GO
/****** Object:  StoredProcedure [dbo].[uspGetMasterData]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetMasterData]  
 -- Add the parameters for the stored procedure here   
 @WorkflowId INT,
 @Field NVARCHAR(100),
 @FromUserTable BIT = 0
 
AS   
-- EXEC uspGetMasterData 502,'LOB',1
BEGIN 
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELPBWMasterDataECT statements.  
 SET NOCOUNT ON;  
 
	IF @FromUserTable = 1
	BEGIN
	    DECLARE @strQry AS VARCHAR(MAX)
	    SET @strQry = ''
		SET @strQry = 'SELECT DISTINCT '+ @Field + ' FROM PBWUserProfile WHERE ISNULL('+ @Field +','''') != '''' ORDER BY '+ @Field
		PRINT @strQry
		EXEC(@strQry)
	END
	ELSE
	BEGIN
		SELECT MasterDataId,Value FROM dbo.PBWMasterData WHERE WorkflowId = @WorkflowId AND Field = @Field ORDER BY Value
	END
END  
 

GO
/****** Object:  StoredProcedure [dbo].[uspGetMenus]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[uspGetMenus]      
 -- Add the parameters for the stored procedure here     
 @WfId INT,      
 @NT_UserName VARCHAR(256)    
AS       
-- EXEC [uspGetMenus] 2, 'rameshkumar.r1'    
BEGIN      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 -- interfering with SELECT statements.      
 SET NOCOUNT ON;      
  SELECT distinct Name,ActionName,ControllerName,ShowCountOnMenu,OrderNo FROM PBWMenuMaster PM INNER JOIN PBWMenuRoleMapping AS PMM ON PM.Id=PMM.MenuId     
  INNER JOIN PBWUserRoleMapping AS PRM ON PM.WfId = PRM.WorkflowId AND PMM.RoleId = PRM.RoleId     
  WHERE PRM.UniqueId = @NT_UserName   
  AND PM.WfId = PRM.WorkflowId AND PM.WfId = @WfId    
  order by OrderNo    
END   
GO
/****** Object:  StoredProcedure [dbo].[uspGetMobileProcWaitingForApproval]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE  [dbo].[uspGetMobileProcWaitingForApproval]                 
	@WorkflowId INT ,                  
	@UserId VARCHAR(100),              
	@Status VARCHAR(MAX) = ''  
	with recompile            
AS    
/* =============================================                    
-- Author:  Leela Thangavel                    
-- Create date: July/07/2019                    
-- Description: GetJSON Value  for Mobile Application                  
                   
-- Author:  Leela                    
-- Create date:                     
-- Description:      [uspGetMobileProcWaitingForApproval] 3,'shaji.ravi'              
-- ============================================= */                         
BEGIN                    
	SET NOCOUNT ON;                     
	/*                     
	----------IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL                  
	----------DROP TABLE #TempSubOrdinates         
	----------CREATE TABLE #TempSubOrdinates      
	----------(UserId VARCHAR(256),SuperVisorId VARCHAR(256))      

	----------IF UPPER(@UserId) = 'SHAJI.RAVI'      
	----------BEGIN      
	----------INSERT INTO #TempSubOrdinates      
	----------SELECT UserId,SuperVisorId FROM PBWUserMaster      
	----------END      
	----------ELSE      
	----------BEGIN              
	---------- ;WITH SubOrdinates                  
	---------- AS                  
	---------- (                  
	----------   SELECT UserId,SuperVisorId FROM PBWUserMaster AS U WHERE U.SuperVisorId = @UserId                  
	----------   UNION ALL                  
	----------   SELECT U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN SubOrdinates AS S                  
	----------   ON U.SuperVisorId = S.UserId                  
	---------- )         
	---------- INSERT INTO #TempSubOrdinates               
	---------- SELECT UserId,SuperVisorId FROM SubOrdinates        
	----------END                

	*/  
	
	               
	IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates         
	CREATE TABLE #TempSubOrdinates      
	(UserId VARCHAR(256),SuperVisorId VARCHAR(256))      

	IF OBJECT_ID('TEMPDB..#TempSubOrdinates1') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates1        

	IF OBJECT_ID('TEMPDB..#TempSubOrdinates2') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates2   
		
	  IF OBJECT_ID('TEMPDB..#TempPendingApproval') IS NOT NULL                  
		DROP TABLE #TempPendingApproval  
        CREATE TABLE #TempPendingApproval
			(Fin INT,Requesttd INT, CreatedBy VARCHAR(75), CreatedDate DATETIME,DataJson NVARCHAR(MAX),Workflowstateid INT) 
			
			
	SELECT DISTINCT 
		U.SupervisorId,U.Userid INTO #TempSubOrdinates1      
	FROM PBWUserMaster AS U LEFT OUTER JOIN PBWUserMaster AS V      
	ON U.UserId = V.SupervisorId      
	WHERE ISNULL(v.SupervisorId,'') != '' 
	option(recompile)   

	Create index NCIDX on #TempSubOrdinates1(userid)    

	Create index NCIDX1 on #TempSubOrdinates1(SuperVisorId)  

	;WITH SubOrdinates                  
	AS                  
	(          
	SELECT DISTINCT UserId,SuperVisorId FROM #TempSubOrdinates1 AS U WHERE U.SuperVisorId = @UserId                
	UNION ALL                  
	SELECT U.UserId,U.SuperVisorId FROM #TempSubOrdinates1 AS U INNER JOIN SubOrdinates AS S                  
	ON U.SuperVisorId = S.UserId         
	)                  
	SELECT DISTINCT S.UserId,S.SuperVisorId       
	INTO #TempSubOrdinates2                
	FROM SubOrdinates AS S 
	option(recompile)      

	INSERT INTO #TempSubOrdinates      
	(UserId,SuperVisorId)      
	SELECT DISTINCT UserId,SuperVisorId FROM #TempSubOrdinates1 AS U WHERE U.SuperVisorId = @UserId       
	UNION      
	SELECT DISTINCT U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN #TempSubOrdinates2 as v      
	ON U.SuperVisorId = V.UserId      
	ORDER BY U.SupervisorId,U.UserId
	option(recompile)             

	INSERT INTO #TempSubOrdinates      
	(UserId,SuperVisorId)      
	SELECT DISTINCT UserId,SuperVisorId FROM PBWUserMaster AS U 
	WHERE U.SuperVisorId = @UserId AND U.UserId NOT IN (SELECT T.UserId FROM #TempSubOrdinates AS T) 
	option(recompile)     

	               
			IF @Status != ''               
				BEGIN              
					IF @UserId = 'jacob.jesuroon'        
						BEGIN 
						   INSERT INTO #TempPendingApproval               
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId                   
							INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId                  
							WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status                    
							UNION                  
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status                
							AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO',  
							'NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','SUPERVISOR'))              
							AND W.WorkflowId = @WorkflowId AND @UserId = 'jacob.jesuroon'      
							--ORDER BY W.LastModifiedDate DESC       
						END      
					ELSE      
						BEGIN  
						    INSERT INTO #TempPendingApproval          
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId   FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId                   
							INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId                  
							WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status                    
							UNION                  
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status                
							AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD',  
							'HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','SUPERVISOR','PACIFIC FINANCE'))              
							AND W.WorkflowId = @WorkflowId       
							--ORDER BY W.LastModifiedDate DESC       
						END           
				END              
			ELSE              
				BEGIN              
					IF @UserId = 'jacob.jesuroon'        
						BEGIN  
						   INSERT INTO #TempPendingApproval      
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId                   
							INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId                  
							WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId   AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED',
							'CREATED','SELECTED')               
							UNION                  
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson ,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','C
							REATED','SELECTED')             
							INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId               
							AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBER
							S','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','SUPERVISOR'))              
							AND W.WorkflowId = @WorkflowId AND @UserId = 'jacob.jesuroon'      
							--ORDER BY W.LastModifiedDate DESC        
						END      
					ELSE      
						BEGIN  
						    INSERT INTO #TempPendingApproval       
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId                   
							INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId                  
							WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId   AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED',
							'REOPENED','CREATED','SELECTED')               
							UNION                  
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','C
							REATED','SELECTED')             
							INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId               
							AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBER
							S','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','PACIFIC FINANCE'))              
							AND W.WorkflowId = @WorkflowId      
							--ORDER BY W.LastModifiedDate DESC      
						END           
	--WHERE UPPER(R.RoleName) NOT IN ('DEPARTMENTHEAD')              
	--AND W.RoleId NOT IN (SELECT R.RoleId FROM PBWUserRoleMapping AS R WHERE UniqueId = @UserId)              
				END        
		--END          
	
		SELECT  PA.Fin,PA.Requesttd,PA.createdby as Rasiedby, PA.CreatedDate as RaisedOn ,(SELECT JSON_VALUE(value,'$.Value') as Facility FROM  OPENJSON(JSON_QUERY(PA.datajson,'$.DataFields') ) 
		where JSON_VALUE(value,'$.Key')='Facility') Facility,
		(SELECT JSON_VALUE(value,'$.Value') as ItemCategory FROM  OPENJSON(JSON_QUERY(PA.datajson,'$.DataFields') ) 
		where JSON_VALUE(value,'$.Key')='ItemCategory') ItemCategory, case  when WorkFlowStateId in (-26,-27) then 1 else 0 End IsCostApproval,UM.FirstName+' '+UM.LastName reqBy
		FROM #TempPendingApproval PA
		inner join PBWUserMaster UM on Um.UniqueId=PA.createdby
		

	IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates           

	IF OBJECT_ID('TEMPDB..#TempSubOrdinates1') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates1        

	IF OBJECT_ID('TEMPDB..#TempSubOrdinates2') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates2 		
				
	IF OBJECT_ID('TEMPDB..#TempPendingApproval') IS NOT NULL                  
		DROP TABLE #TempPendingApproval  
		 
		
	SET NOCOUNT OFF;                         
END  



Select b.RoleName from PBWUserMaster a inner join PBWUserDesignation b on a.RoleId=b.RoleId where UniqueId='leela.thangavel'
GO
/****** Object:  StoredProcedure [dbo].[uspGetMobileTMSWaitingForApproval]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[uspGetMobileTMSWaitingForApproval]           
	@WorkflowId INT ,                  
	@UserId VARCHAR(100),              
	@Status VARCHAR(MAX) = 'pending'  
	with recompile            
AS    
/* =============================================                    
-- Author:  Leela Thangavel                    
-- Create date: July/07/2019                    
-- Description: GetJSON Value  for Mobile Application                  
                   
-- Author:  Leela                    
-- Create date:                     
-- Description:      [uspGetMobileProcWaitingForApproval] 3,'shaji.ravi'              
-- ============================================= */                         
BEGIN                    
	SET NOCOUNT ON;  
	
	set @Status=''                   
	/*                     
	----------IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL                  
	----------DROP TABLE #TempSubOrdinates         
	----------CREATE TABLE #TempSubOrdinates      
	----------(UserId VARCHAR(256),SuperVisorId VARCHAR(256))      

	----------IF UPPER(@UserId) = 'SHAJI.RAVI'      
	----------BEGIN      
	----------INSERT INTO #TempSubOrdinates      
	----------SELECT UserId,SuperVisorId FROM PBWUserMaster      
	----------END      
	----------ELSE      
	----------BEGIN              
	---------- ;WITH SubOrdinates                  
	---------- AS                  
	---------- (                  
	----------   SELECT UserId,SuperVisorId FROM PBWUserMaster AS U WHERE U.SuperVisorId = @UserId                  
	----------   UNION ALL                  
	----------   SELECT U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN SubOrdinates AS S                  
	----------   ON U.SuperVisorId = S.UserId                  
	---------- )         
	---------- INSERT INTO #TempSubOrdinates               
	---------- SELECT UserId,SuperVisorId FROM SubOrdinates        
	----------END                

	*/  
 
	               
	IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates         
	CREATE TABLE #TempSubOrdinates      
	(UserId VARCHAR(256),SuperVisorId VARCHAR(256))      

	IF OBJECT_ID('TEMPDB..#TempSubOrdinates1') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates1        

	IF OBJECT_ID('TEMPDB..#TempSubOrdinates2') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates2   
		
	  IF OBJECT_ID('TEMPDB..#TempPendingApproval') IS NOT NULL                  
		DROP TABLE #TempPendingApproval  
        CREATE TABLE #TempPendingApproval
			(Fin INT,Requesttd INT, CreatedBy VARCHAR(75), CreatedDate DATETIME,DataJson NVARCHAR(MAX),Workflowstateid INT) 
			
			
	SELECT DISTINCT 
		U.SupervisorId,U.Userid INTO #TempSubOrdinates1      
	FROM PBWUserMaster AS U LEFT OUTER JOIN PBWUserMaster AS V      
	ON U.UserId = V.SupervisorId      
	WHERE ISNULL(v.SupervisorId,'') != '' 
	option(recompile)   

	Create index NCIDX on #TempSubOrdinates1(userid)    

	Create index NCIDX1 on #TempSubOrdinates1(SuperVisorId)  

	;WITH SubOrdinates                  
	AS                  
	(          
	SELECT DISTINCT UserId,SuperVisorId FROM #TempSubOrdinates1 AS U WHERE U.SuperVisorId = @UserId                
	UNION ALL                  
	SELECT U.UserId,U.SuperVisorId FROM #TempSubOrdinates1 AS U INNER JOIN SubOrdinates AS S                  
	ON U.SuperVisorId = S.UserId         
	)                  
	SELECT DISTINCT S.UserId,S.SuperVisorId       
	INTO #TempSubOrdinates2                
	FROM SubOrdinates AS S 
	option(recompile)      

	INSERT INTO #TempSubOrdinates      
	(UserId,SuperVisorId)      
	SELECT DISTINCT UserId,SuperVisorId FROM #TempSubOrdinates1 AS U WHERE U.SuperVisorId = @UserId       
	UNION      
	SELECT DISTINCT U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN #TempSubOrdinates2 as v      
	ON U.SuperVisorId = V.UserId      
	ORDER BY U.SupervisorId,U.UserId
	option(recompile)             

	INSERT INTO #TempSubOrdinates      
	(UserId,SuperVisorId)      
	SELECT DISTINCT UserId,SuperVisorId FROM PBWUserMaster AS U 
	WHERE U.SuperVisorId = @UserId AND U.UserId NOT IN (SELECT T.UserId FROM #TempSubOrdinates AS T) 
	option(recompile)     

	               
			IF @Status != ''               
				BEGIN              
					IF @UserId = 'jacob.jesuroon'        
						BEGIN 
						   INSERT INTO #TempPendingApproval               
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId                   
							INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId                  
							WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status                    
							UNION                  
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status                
							AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO',  
							'NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','SUPERVISOR'))              
							AND W.WorkflowId = @WorkflowId AND @UserId = 'jacob.jesuroon'      
							--ORDER BY W.LastModifiedDate DESC       
						END      
					ELSE      
						BEGIN  
						    INSERT INTO #TempPendingApproval          
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId   FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId                   
							INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId                  
							WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status                    
							UNION                  
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status                
							AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD',  
							'HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','SUPERVISOR','PACIFIC FINANCE'))              
							AND W.WorkflowId = @WorkflowId       
							--ORDER BY W.LastModifiedDate DESC       
						END           
				END              
			ELSE              
				BEGIN              
					IF @UserId = 'jacob.jesuroon'        
						BEGIN  
						   INSERT INTO #TempPendingApproval      
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId                   
							INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId                  
							WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId   AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED',
							'CREATED','SELECTED')               
							UNION                  
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson ,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','C
							REATED','SELECTED')             
							INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId               
							AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBER
							S','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','SUPERVISOR'))              
							AND W.WorkflowId = @WorkflowId AND @UserId = 'jacob.jesuroon'      
							--ORDER BY W.LastModifiedDate DESC        
						END      
					ELSE      
						BEGIN  
						    INSERT INTO #TempPendingApproval       
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId                   
							INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId                  
							WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId   AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED',
							'REOPENED','CREATED','SELECTED')               
							UNION                  
							SELECT W.Fin,w.RequestId,w.CreatedBy,w.CreatedDate,w.DataJson,w.WorkFlowStateId  FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U                  
							ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','C
							REATED','SELECTED')             
							INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId               
							AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBER
							S','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','PACIFIC FINANCE'))              
							AND W.WorkflowId = @WorkflowId      
							--ORDER BY W.LastModifiedDate DESC      
						END           
	--WHERE UPPER(R.RoleName) NOT IN ('DEPARTMENTHEAD')              
	--AND W.RoleId NOT IN (SELECT R.RoleId FROM PBWUserRoleMapping AS R WHERE UniqueId = @UserId)              
				END        
		--END          
	
		SELECT  PA.Fin,PA.Requesttd,PA.createdby as Rasiedby, PA.CreatedDate as RaisedOn ,(SELECT JSON_VALUE(value,'$.Value')  FROM  OPENJSON(JSON_QUERY(PA.datajson,'$.DataFields') ) 
		where JSON_VALUE(value,'$.Key')='RequesterComments') RequesterComments, 3 pendingApprovalType,  (SELECT JSON_VALUE(value,'$.Value')  FROM  OPENJSON(JSON_QUERY(PA.datajson,'$.DataFields') ) 
		where JSON_VALUE(value,'$.Key')='TravelBy') TravelBy,(SELECT JSON_VALUE(value,'$.Value') FROM  OPENJSON(JSON_QUERY(PA.datajson,'$.DataFields') ) 
		where JSON_VALUE(value,'$.Key')='StartDate') StartDate,
		(SELECT JSON_VALUE(value,'$.Value')  FROM  OPENJSON(JSON_QUERY(PA.datajson,'$.DataFields') ) 
		where JSON_VALUE(value,'$.Key')='EndDate') EndDate, '' travelAdvanceAmount,	(SELECT JSON_VALUE(value,'$.Value')  FROM  OPENJSON(JSON_QUERY(PA.datajson,'$.DataFields') ) 
		where JSON_VALUE(value,'$.Key')='NumberOfDays') NumberOfDays ,
		UD.RoleName Designation
		FROM #TempPendingApproval PA
		left join PBWUserMaster UM on PA.createdby=UM.UniqueId
		left join PBWUserDesignation UD  on UM.RoleId=UD.RoleId
		order by PA.CreatedDate
		
	
		

	IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates           

	IF OBJECT_ID('TEMPDB..#TempSubOrdinates1') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates1        

	IF OBJECT_ID('TEMPDB..#TempSubOrdinates2') IS NOT NULL                  
		DROP TABLE #TempSubOrdinates2  

		
	IF OBJECT_ID('TEMPDB..#TempPendingApproval') IS NOT NULL                  
		DROP TABLE #TempPendingApproval  
		
	SET NOCOUNT OFF;                         
END  


GO
/****** Object:  StoredProcedure [dbo].[uspGetOfficeAddess]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetOfficeAddess]
AS
BEGIN
      SET NOCOUNT ON
      
      SELECT 'Chennai Office' [OfficeName],'A9, First Main Road,Ambattur Industrial Estate,Chennai - 600 058. Tamil Nadu, India.' [OfficeAddress]
      UNION
      SELECT 'Pune Office' [OfficeName],'Embassy Tec zone,4th Floor, Wing A,Mississippi Block,Rajiv Gandhi InfoTech Park - Phase II,Hinjewadi, Pune – 411057' [OfficeAddress]
      UNION
      SELECT 'Manila Office' [OfficeName],'Manila' [OfficeAddress]
      UNION
      SELECT 'US Office' [OfficeName],'US' [OfficeAddress]
      UNION
      SELECT 'Coimbatore Office' [OfficeName],'406 & 407, 4th Floor, Tidel Park Coimbatore ltd,ELCOT-SEZ, IT/ITES, Villankurichi Road, Aerodrome Post,Coimbatore-641004' [OfficeAddress]
      UNION
      SELECT 'Mumbai Office' [OfficeName],'Mumbai Office' [OfficeAddress]
      SET NOCOUNT ON
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetOverDueList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetOverDueList]
	-- Add the parameters for the stored procedure here
	 @WorkflowId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- EXEC uspGetOverDueList 2
    -- Insert statements for procedure here
	
	SELECT 
		DISTINCT P.UserId,U.EmailId ToId,SupervisorId,CASE WHEN UPPER(U.SupervisorId) != 'SHAJI.RAVI' THEN SupervisorId + '@accesshealthcare.co' END CC 
		,P.RequestId,P.Fin,U.FirstName  FROM PBWWorkflowTransaction AS P
	INNER JOIN PBWUserMaster AS U ON P.UserId = U.UniqueId
	INNER JOIN rptTransaction AS T ON P.WorkflowId = T.WorkflowId AND P.Fin = T.Fin AND T.RowOrdinal = 0 AND T.LogId =0
	WHERE P.WorkFlowId = @WorkflowId AND T.RowOrdinal = 0 AND T.LogId = 0
	AND P.Status = 'SubmitExpenses' 
	AND UPPER(P.UserId) != 'SHAJI.RAVI'
	AND DATEDIFF(DAY,CONVERT(DATE,T.datetime2),CONVERT(DATE,GETDATE())) > 7
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPanelMembers]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetPanelMembers]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT = 11
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT--ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') 
	um.UniqueId [Name] FROM PBWUserRoleMapping AS U INNER JOIN PBWWorkFlowRoleMaster AS R 
	ON U.WorkflowId = R.WfId AND U.RoleId = R.RoleId 
	INNER JOIN PBWUserMaster AS UM ON UM.UniqueId = U.UniqueId 
	WHERE R.RoleName = 'PanelMembers' 
	ORDER BY Name
	
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetPendingAndResolvedCount_TMS]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetPendingAndResolvedCount_TMS]
	-- Add the parameters for the stored procedure here 
	@WorkflowId INT,
	@UserId VARCHAR(100),
	@IsApprovalStatus BIT=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @IsApprovalStatus = 1
    BEGIN
		SELECT SUM(CASE WHEN Status != 'Closed' THEN 1 END) Pending,SUM(CASE WHEN Status = 'Closed' THEN 1 END) Resolved FROM rptTransaction WHERE WorkflowId = 2 and SourceColumn = '' and LogId =0
		AND nvarchar20 = @UserId 
	END
	ELSE
	BEGIN
		SELECT SUM(CASE WHEN Status != 'Closed' THEN 1 END) Pending,SUM(CASE WHEN Status = 'Closed' THEN 1 END) Resolved FROM rptTransaction WHERE WorkflowId = 2 and SourceColumn = '' and LogId =0
		AND UserId = @UserId 
	END
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPendingPlatformMailTran]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rameshkumar
-- Create date: January/08/2018
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetPendingPlatformMailTran]
	-- Add the parameters for the stored procedure here
	 @WorkflowId INT,
	 @Fin INT =0AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @Fin = 0
    BEGIN
		SELECT WorkflowId,Fin,UserId,FromMailId,ToMailIds Receipients,CC,SubjectText,Body,MailStatus,IsHTML
		,AttachmentPath,CreateDate,CreatedBy,ModifiedDate,ModifiedBy FROM PMailTran
		WHERE WorkflowId = @WorkflowId 
	END
	ELSE
    BEGIN
		SELECT WorkflowId,Fin,UserId,FromMailId,ToMailIds Receipients,CC,SubjectText,Body,MailStatus,IsHTML
		,AttachmentPath,CreateDate,CreatedBy,ModifiedDate,ModifiedBy FROM PMailTran
		WHERE WorkflowId = @WorkflowId AND Fin = @Fin 
	END	
END

 
 
GO
/****** Object:  StoredProcedure [dbo].[uspGetPendingUploadDocument]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC uspGetPendingUploadDocument 'prabaakaran.t','TravelDocument',2
*/
CREATE PROCEDURE [dbo].[uspGetPendingUploadDocument]
	@UserId			VARCHAR(250),
	@DocCategory	VARCHAR(250),
	@WfId			INT
AS
BEGIN
	SET NOCOUNT ON
	
	
	SELECT
		MD.*
	FROM PBWMasterData MD 
	WHERE MD.Field = @DocCategory AND WorkflowId = @WfId
	AND ( MD.Value <> 'Visa' AND NOT EXISTS ( SELECT 1 FROM PBWDocuments WHERE CreatedBy = @UserId  
	AND WfId = Md.WorkflowId AND DocName = MD.Value AND WfId  = @WfId AND DocCategory = @DocCategory ) 
	
	OR ( MD.Value = 'Visa' AND MD.Value NOT IN ( SELECT MD.Value FROM PBWMasterData MD 
	WHERE MD.Field = 'Country' AND WorkflowId = @WfId
	AND NOT EXISTS ( SELECT 1 FROM PBWDocuments D WHERE D.CreatedBy = @UserId  
	AND D.WfId = Md.WorkflowId AND D.WfId  = @WfId AND D.Country = MD.Value AND DocName='Visa') ) ) )
	
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPendingVisaCountry]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
      EXEC uspGetPendingVisaCountry 'prabaakaran.t',2
*/
CREATE PROCEDURE [dbo].[uspGetPendingVisaCountry]
      @UserId                 VARCHAR(250),
      @WfId             INT
AS
BEGIN
      SET NOCOUNT ON
      
      /*
      SELECT
            MD.*
      FROM PBWMasterData MD 
      WHERE MD.Field = 'Country' AND WorkflowId = @WfId
      AND NOT EXISTS ( SELECT 1 FROM PBWDocuments D WHERE D.CreatedBy = @UserId  
      AND D.WfId = Md.WorkflowId AND D.WfId  = @WfId AND D.Country = MD.Value AND DocName='Visa')   
      */
      
      SELECT
            MD.*
      FROM pbwCountries MD 
      WHERE NOT EXISTS ( SELECT 1 FROM PBWDocuments D WHERE D.CreatedBy = @UserId  
      AND D.WfId  = @WfId AND D.Country = MD.CountryName AND DocName='Visa')        
      
      SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPerDiem]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetPerDiem]  
 -- Add the parameters for the stored procedure here  
 @TravelType VARCHAR(256),
@NT_UserName VARCHAR(256)
AS   
-- EXEC [uspGetPerDiem] 'Domestic','Prabaakaran.t'
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
                DECLARE @RuleSetId INT
                SET @RuleSetId = 0
                SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE RuleSetName = 'PerDiem'

                IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL
                                DROP TABLE #TempFindRules
                ;WITH FindRules
                AS
                (
                                SELECT R.* FROM dbo.PRuleSetMapping AS RSM
                                INNER JOIN dbo.PRuleMaster AS R  
                                ON RSM.RuleId = R.RuleId 
                                WHERE RSM.RuleSetId = @RuleSetId
                )
                SELECT *
                ,dbo.Split_PerDiem(Condition,'~','=','TravelType') TravelType      
                ,dbo.Split_PerDiem(Condition,'~','=','Band') Band
                ,dbo.Split_PerDiem(Condition,'~','=','Grade') + ',' Grade
                ,dbo.Split_PerDiem(ThenAction,'&','=','TravelBy') TravelBy
                ,dbo.Split_PerDiem(ThenAction,'&','=','PerDiem') PerDiem
                ,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationLessThan7Days') AccommodationLessThan7Days
                ,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationMoreThan7Days') AccommodationMoreThan7Days
                ,dbo.Split_PerDiem(ThenAction,'&','=','TransportCharges') TransportCharges
				,dbo.Split_PerDiem(ThenAction,'&','=','CityTier') CityTier
				,dbo.Split_PerDiem(ThenAction,'&','=','MoreThan7DaysCityTier') MoreThan7DaysCityTier
				,dbo.Split_PerDiem(ThenAction,'&','=','LessThan7DaysCityTier') LessThan7DaysCityTier                
                INTO #TempFindRules FROM FindRules                
                 
 
                 SELECT T.*  FROM dbo.PBWUserMaster AS U
                INNER JOIN dbo.PBWUserDesignation AS UD ON UD.RoleId = U.RoleId
                INNER JOIN #TempFindRules AS T ON UD.Band = T.Band
                WHERE T.TravelType = @TravelType AND T.Grade LIKE  '%' + UD.Grade + ',%' AND U.UniqueId = @NT_UserName
END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetPerDiemAll]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetPerDiemAll]  
 -- Add the parameters for the stored procedure here  
AS   
-- EXEC [uspGetPerDiemAll] 
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
	DECLARE @RuleSetId INT
	SET @RuleSetId = 0
	SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE RuleSetName = 'PerDiem'
 
	IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL
		DROP TABLE #TempFindRules
	;WITH FindRules
	AS
	(
		SELECT R.* FROM dbo.PRuleSetMapping AS RSM
		INNER JOIN dbo.PRuleMaster AS R  
		ON RSM.RuleId = R.RuleId 
		WHERE RSM.RuleSetId = @RuleSetId
	)
	SELECT ROW_NUMBER() OVER(ORDER BY RuleId) SNo,RuleId,RuleName,Description
	,dbo.Split_PerDiem(Condition,'~','=','TravelType') TravelType	
	,dbo.Split_PerDiem(Condition,'~','=','Band') Band
	,dbo.Split_PerDiem(Condition,'~','=','Grade') Grade
	,dbo.Split_PerDiem(ThenAction,'&','=','TravelBy') TravelBy
	,dbo.Split_PerDiem(ThenAction,'&','=','PerDiem') PerDiem
	,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationLessThan7Days') AccommodationLessThan7Days
	,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationMoreThan7Days') AccommodationMoreThan7Days
	,dbo.Split_PerDiem(ThenAction,'&','=','TransportCharges') TransportCharges
	 FROM FindRules 	 
END  

 



GO
/****** Object:  StoredProcedure [dbo].[uspGetPerDiemDesignation]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetPerDiemDesignation]  
 -- Add the parameters for the stored procedure here  
 @TravelType VARCHAR(256),
 @TravelBy VARCHAR(256),
 @Designation VARCHAR(256)
AS   
-- EXEC [uspGetPerDiem] 'Domestic','Flight','Prabaakaran.t'
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
	DECLARE @RuleSetId INT
	SET @RuleSetId = 0
	SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE RuleSetName = 'PerDiem'
 
	IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL
		DROP TABLE #TempFindRules
	;WITH FindRules
	AS
	(
		SELECT R.* FROM dbo.PRuleSetMapping AS RSM
		INNER JOIN dbo.PRuleMaster AS R  
		ON RSM.RuleId = R.RuleId 
		WHERE RSM.RuleSetId = @RuleSetId
	)
	SELECT *
	,dbo.Split_PerDiem(Condition,'~','=','TravelType') TravelType
	,dbo.Split_PerDiem(Condition,'~','=','TravelBy') TravelBy
	,dbo.Split_PerDiem(Condition,'~','=','Band') Designation
	,dbo.Split_PerDiem(ThenAction,'&','=','PerDiem') PerDiem
	,dbo.Split_PerDiem(ThenAction,'&','=','Accommodation') Accommodation
	,dbo.Split_PerDiem(ThenAction,'&','=','OtherExpenses') OtherExpenses
	 INTO #TempFindRules FROM FindRules 		 
  
	 SELECT * FROM #TempFindRules AS T 
	 WHERE T.TravelType = @TravelType AND T.TravelBy = @TravelBy AND T.Designation = @Designation
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPerDiemGrade]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetPerDiemGrade]  
 -- Add the parameters for the stored procedure here  
 @TravelType VARCHAR(256),
 @Band VARCHAR(256),
 @Grade VARCHAR(256)
AS   
-- EXEC [uspGetPerDiemGrade] 'Domestic','2','2A2'
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
	DECLARE @RuleSetId INT
	SET @RuleSetId = 0
	SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE RuleSetName = 'PerDiem'
 
	IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL
		DROP TABLE #TempFindRules
	;WITH FindRules
	AS
	(
		SELECT R.* FROM dbo.PRuleSetMapping AS RSM
		INNER JOIN dbo.PRuleMaster AS R  
		ON RSM.RuleId = R.RuleId 
		WHERE RSM.RuleSetId = @RuleSetId
	)
	SELECT *
	,dbo.Split_PerDiem(Condition,'~','=','TravelType') TravelType	
	,dbo.Split_PerDiem(Condition,'~','=','Band') Band
	,dbo.Split_PerDiem(Condition,'~','=','Grade') Grade
	,dbo.Split_PerDiem(ThenAction,'&','=','TravelBy') TravelBy
	,dbo.Split_PerDiem(ThenAction,'&','=','PerDiem') PerDiem
	,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationLessThan7Days') AccommodationLessThan7Days
	,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationMoreThan7Days') AccommodationMoreThan7Days
	,dbo.Split_PerDiem(ThenAction,'&','=','TransportCharges') TransportCharges
	,dbo.Split_PerDiem(ThenAction,'&','=','CityTier') CityTier
	,dbo.Split_PerDiem(ThenAction,'&','=','MoreThan7DaysCityTier') MoreThan7DaysCityTier
	,dbo.Split_PerDiem(ThenAction,'&','=','LessThan7DaysCityTier') LessThan7DaysCityTier
	 INTO #TempFindRules FROM FindRules  
  
	 SELECT * FROM #TempFindRules AS T 
	 WHERE T.TravelType = @TravelType AND T.Band = @Band AND T.Grade = @Grade
END 

GO
/****** Object:  StoredProcedure [dbo].[uspGetProcessedHistory]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC uspGetProcessedHistory @WorkflowId=1,@UserId='rameshkumar.r1',@Status = ''
	EXEC uspGetProcessedHistory @WorkflowId=1,@UserId='rameshkumar.r1',@Status = 'Approved'
	EXEC uspGetProcessedHistory @WorkflowId=1,@UserId='rameshkumar.r1',@Status = 'Pending'
*/
CREATE PROCEDURE  [dbo].[uspGetProcessedHistory]      
	@WorkflowId		INT ,    
	@UserId			VARCHAR(100),
	@Status			VARCHAR(MAX) = ''
AS       
BEGIN      
	/*
	created by prabaakaran T
	
	*/
	SET NOCOUNT ON;   	
 
	;WITH History(WorkflowId,Fin,LastModifiedDate)
	AS
	(
		SELECT WorkflowId,Fin,LastModifiedDate FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND DataJson LIKE '%ApprovedBy","Value":"'+ @UserId +'"%'
		UNION
		SELECT TH.WorkflowId,TH.Fin,TH.LastModifiedDate FROM PBWWorkflowTransactionHistory TH
		INNER JOIN (select MAX(COALESCE(LastModifiedDate,CreatedDate)) [LastModifiedDate],WorkflowId, Fin from PBWWorkflowTransactionHistory   
		WHERE WorkflowId = @WorkflowId AND DataJson LIKE '%ApprovedBy","Value":"'+ @UserId +'"%' GROUP BY WorkflowId,Fin ) MaxTH ON MaxTH.WorkflowId = TH.WorkflowId 
		AND MaxTH.LastModifiedDate = TH.LastModifiedDate AND MaxTH.Fin = TH.Fin
		WHERE TH.WorkflowId = @WorkflowId AND TH.DataJson LIKE '%ApprovedBy","Value":"'+ @UserId +'"%'
	)
	SELECT I.WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,I.LastModifiedDate,I.Fin,RequestId FROM PBWWorkflowTransaction AS I INNER JOIN History AS H ON I.WorkflowId = H.WorkflowId AND I.Fin = H.Fin 
	AND I.LastModifiedDate = H.LastModifiedDate
	WHERE EXISTS(SELECT 1 FROM PBWUserRoleMapping RM WHERE UniqueId=@UserId AND RM.RoleId = I.RoleId)
	UNION ALL
	SELECT I.WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,I.LastModifiedDate,I.Fin,RequestId FROM PBWWorkflowTransactionHistory AS I INNER JOIN History AS H ON I.WorkflowId = H.WorkflowId AND I.Fin = H.Fin 
	AND I.LastModifiedDate = H.LastModifiedDate
	WHERE EXISTS(SELECT 1 FROM PBWUserRoleMapping RM WHERE UniqueId=@UserId AND RM.RoleId = I.RoleId)
	ORDER BY Fin 
     

	--IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL    
	--	DROP TABLE #TempSubOrdinates    
	--;WITH SubOrdinates    
	--AS    
	--(    
	--	SELECT UserId,SuperVisorId FROM PBWUserMaster AS U WHERE U.SuperVisorId = @UserId    
	--	UNION ALL    
	--	SELECT U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN SubOrdinates AS S    
	--	ON U.SuperVisorId = S.UserId    
	--)    
	--SELECT UserId,SuperVisorId    
	--INTO #TempSubOrdinates FROM SubOrdinates    

	--SELECT 
	--	w.WorkflowId,w.DataJson,w.WorkFlowStateId,w.RoleId,w.Status,w.UserId,w.CreatedBy,w.CreatedDate,w.LastModifiedBy,w.LastModifiedDate,w.Fin
	--FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U    
	--ON U.UniqueId =@UserId AND W.RoleId = U.RoleId     
	--INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId    
	--WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND ( UPPER(W.Status) = @Status OR @Status = '' )     
	--UNION    
	--SELECT
	--	w.WorkflowId,w.DataJson,w.WorkFlowStateId,w.RoleId,w.Status,w.UserId,w.CreatedBy,w.CreatedDate,w.LastModifiedBy,w.LastModifiedDate,w.Fin
	--FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U    
	--ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND ( UPPER(W.Status) = @Status OR @Status = '' ) 
	--UNION
	--SELECT 
	--	w.WorkflowId,w.DataJson,w.WorkFlowStateId,w.RoleId,w.Status,w.UserId,w.CreatedBy,w.CreatedDate,w.LastModifiedBy,w.LastModifiedDate,w.Fin
	--FROM dbo.PBWWorkflowTransactionHistory  AS W INNER JOIN PBWUserRoleMapping AS U    
	--ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND ( UPPER(W.Status) = @Status OR @Status = '' )
	--order by w.CreatedDate
	
	--IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL    
	--	DROP TABLE #TempSubOrdinates    
END 



GO
/****** Object:  StoredProcedure [dbo].[uspGetProcNetworkList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:  <sivasankar.s1>    
-- Create date: <27Mar2018>    
-- Description: <Master datas Mapping in same table >    
-- =============================================    
CREATE PROCEDURE [dbo].[uspGetProcNetworkList]     
 -- Add the parameters for the stored procedure here    
 @Category NVarchar(100),    
 @WorkflowId int    
     
AS    
BEGIN    
--exec uspGetProcNetworkList  'Network Service',3  
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
    
    If(@Category='Network Service')
    Begin
    declare @Field nvarchar(100)
    set @Field='NetworkCategory'
    End
       
    SELECT Value from PBWMasterData where WorkflowId=@WorkflowId and Field=@Field    
    
END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetProcRequstDetails]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:  <sivasankar.s1>  
-- Create date: <27Mar2018>  
-- Description: <Master datas Mapping in same table >  
-- =============================================  
CREATE PROCEDURE [dbo].[uspGetProcRequstDetails]   
 -- Add the parameters for the stored procedure here  
 @Category NVarchar(100),  
 @WorkflowId int  
   
AS  
BEGIN  
--exec uspGetProcRequstDetails  'General Purchase',3
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
     
 SELECT ms.Value from PBWMasterData  ms   
 inner join  PBWMasterdatamapping mp  
 on ms.MasterDataId=mp.SubMasterID  
 join PBWMasterData md  
 on md.MasterDataId=mp.MasterID  
 where ms.WorkflowId=@WorkflowId and md.Value=@Category  
  
END  
GO
/****** Object:  StoredProcedure [dbo].[uspGetProcurementFacilityMaster]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  surendher  
-- Create date: 2018/11/18  
-- Description: Get procurement Facility Master  
-- =============================================  
CREATE PROCEDURE [dbo].[uspGetProcurementFacilityMaster]   
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Insert statements for procedure here  
 SELECT * FROM ProcurementFacilityMaster  
END  
GO
/****** Object:  StoredProcedure [dbo].[uspGetRole]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Jun/06/2017    
-- Description: GetJSON Value    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspGetRole]    
 -- Add the parameters for the stored procedure here     
 @NT_UserName VARCHAR(MAX),  
 @WfId INT  
AS     
-- EXEC uspGetRole  'irene.sybunsuan',3   
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
   
 DECLARE @i INT  
 SET @i = 0;  
 ;WITH SuperVisor  
 AS  
 (  
  SELECT @i Position,UserId,SuperVisorId FROM PBWUserMaster AS U WHERE U.UserId = @NT_UserName  
  UNION ALL  
  SELECT Position+1 Position,U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN SuperVisor AS S  
  ON U.UserId = S.SuperVisorId  
 )  
 SELECT UserId,SuperVisorId,RoleName,WFR.RoleId,Position FROM SuperVisor AS S INNER JOIN PBWUserRoleMapping AS URM   
 ON S.UserId = URM.UniqueId   
 INNER JOIN PBWWorkFlowRoleMaster AS WFR ON URM.RoleId = WFR.RoleId and WFR.WfId=@WfId  
 ORDER BY Position   
END    
GO
/****** Object:  StoredProcedure [dbo].[uspGetRoleId]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetRoleId]  
 -- Add the parameters for the stored procedure here   
 @Role VARCHAR(MAX),
 @WfId INT
AS   
-- EXEC uspGetRoleId  'Finance',1
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
 
	 SELECT TOP 1 RoleId FROM PBWWorkFlowRoleMaster WHERE WfId = @WfId AND RoleName = @Role
END  



GO
/****** Object:  StoredProcedure [dbo].[uspGetRoleName]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetRoleName]  
 -- Add the parameters for the stored procedure here   
 @RoleId VARCHAR(MAX),
 @WorkflowId INT
AS   
-- EXEC uspGetRoleId  'Finance',1
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
 
	 SELECT TOP 1 RoleName FROM PBWWorkFlowRoleMaster WHERE RoleId = @RoleId
END  


 
GO
/****** Object:  StoredProcedure [dbo].[uspGetRptData]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetRptData]
	-- Add the parameters for the stored procedure here
	@RequestFields1 VARCHAR(MAX),
	@RequestFields2 VARCHAR(MAX),
	@RequestFields3 VARCHAR(MAX),
	@ParentFields RptQryType READONLY,
	@Filter VARCHAR(MAX),
	@WorkflowId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--RequestFields: UserId,EmployeeCode,RequesterRoleId,Designation,TravelLocDetails.TravelFrom,TravelLocDetails.TravelTo,AdvanceIssued,PerDiem,Accommodation,OtherExpenses
	--Filter:~CreatedDate~ BETWEEN '2017-01-01' AND '2017-12-31'
	--WorkflowId:2
    -- Insert statements for procedure here
    IF OBJECT_ID('TEMPDB..##RequestFields1') IS NOT NULL
		DROP TABLE ##RequestFields1
	IF OBJECT_ID('TEMPDB..##RequestFields2') IS NOT NULL
		DROP TABLE ##RequestFields2
	IF OBJECT_ID('TEMPDB..##RequestFields3') IS NOT NULL
		DROP TABLE ##RequestFields3
	IF OBJECT_ID('TEMPDB..##FinalTable') IS NOT NULL
		DROP TABLE ##FinalTable
	IF OBJECT_ID('TEMPDB..##LastFinalTable') IS NOT NULL
		DROP TABLE ##LastFinalTable
		
	 
	DECLARE @ReqFieldQry1 AS VARCHAR(MAX)
	SET @ReqFieldQry1 ='';
	DECLARE @ReqFieldQry2 AS VARCHAR(MAX)
	SET @ReqFieldQry2 ='';
	DECLARE @ReqFieldQry3 AS VARCHAR(MAX)
	SET @ReqFieldQry3 ='';
	DECLARE @FinalQuery AS VARCHAR(MAX)
	SET @FinalQuery ='';
	
	SET @ReqFieldQry1 += 'SELECT ' + @RequestFields1 + ',TranRefId TranRefId1 INTO ##RequestFields1 FROM rptTransaction WHERE WorkflowId = '''+ CONVERT(VARCHAR(16),@WorkflowId) +''' AND ISNULL(SourceColumn,'''') = '''''
	EXEC(@ReqFieldQry1)
	
	IF @RequestFields2 != '' 
	BEGIN
		SET @ReqFieldQry2 += 'SELECT ' + @RequestFields2 + ',TranRefId TranRefId2 INTO ##RequestFields2 FROM rptTransaction WHERE WorkflowId = '''+ CONVERT(VARCHAR(16),@WorkflowId) +''' AND ISNULL(SourceColumn,'''') = '''''
		EXEC(@ReqFieldQry2)
	END
	
	IF @RequestFields3 != '' 
	BEGIN
		SET @ReqFieldQry3 += 'SELECT ' + @RequestFields3 + ',TranRefId TranRefId3 INTO ##RequestFields3 FROM rptTransaction WHERE WorkflowId = '''+ CONVERT(VARCHAR(16),@WorkflowId) +''' AND ISNULL(SourceColumn,'''') = '''''
		EXEC(@ReqFieldQry3)
	END
	
	IF @RequestFields2 = '' 
	BEGIN
		SET @FinalQuery = ' SELECT * INTO ##FinalTable FROM ##RequestFields1 AS T1'
	END
	ELSE IF @RequestFields2 != '' AND @RequestFields3 = ''
	BEGIN
		SET @FinalQuery = ' SELECT * INTO ##FinalTable FROM ##RequestFields1 AS T1 LEFT OUTER JOIN ##RequestFields2 AS T2 ON T1.TranRefId1 = T2.TranRefId2'	 	
	END
	ELSE
	BEGIN
		SET @FinalQuery = ' SELECT * INTO ##FinalTable FROM ##RequestFields1 AS T1 LEFT OUTER JOIN ##RequestFields2 AS T2 ON T1.TranRefId1 = T2.TranRefId2'
		SET @FinalQuery += ' LEFT OUTER JOIN ##RequestFields3 AS T3 ON T1.TranRefId1 = T3.TranRefId3'
	END
	--SET @FinalQuery = REPLACE(@FinalQuery,',TranRefId','')	
	EXEC(@FinalQuery)
	
	SET @FinalQuery =''
	SET @FinalQuery = 'SELECT * INTO ##LastFinalTable FROM ##FinalTable WHERE ' + @Filter
	SET @FinalQuery = REPLACE(@FinalQuery,',TranRefId2','')
	SET @FinalQuery = REPLACE(@FinalQuery,',TranRefId3','')
	EXEC(@FinalQuery)
	
	SET @FinalQuery =''
	SET @FinalQuery = 'SELECT * FROM ##LastFinalTable '
	EXEC(@FinalQuery)
	
	DECLARE @strParentQry AS VARCHAR(MAX)
	SET @strParentQry =''
	/*LSFJSDLFFFFFFFFFFFFFFFFFF*/
	DECLARE @MaxInsertRw AS INT
	SELECT @MaxInsertRw = MAX(InsertionOrder) FROM @ParentFields
	DECLARE @InsertRw AS INT
	DECLARE @TranRefID AS INT
	DECLARE @IdentityID AS INT
	SET @InsertRw = 1
	WHILE @InsertRw <= @MaxInsertRw 
	BEGIN
		SELECT @strParentQry = Qry FROM @ParentFields WHERE InsertionOrder = @InsertRw
		IF PATINDEX('%AND ir.Fin IN (%',@strParentQry) > 0
		BEGIN
			SET @strParentQry = @strParentQry + ' SELECT DISTINCT Fin FROM ##LastFinalTable as T) '
		END
		ELSE
		BEGIN
			SET @strParentQry = @strParentQry + ' SELECT DISTINCT TranRefId1 FROM ##LastFinalTable as T) '
		END
		EXEC(@strParentQry)		
		SET @InsertRw = @InsertRw + 1
	END	
	 
	/*SDFSDLFSDFJLSDJFSLJFLSDJLSDFJ*/
	
	
 
		
	IF OBJECT_ID('TEMPDB..##RequestFields1') IS NOT NULL
		DROP TABLE ##RequestFields1
	IF OBJECT_ID('TEMPDB..##RequestFields2') IS NOT NULL
		DROP TABLE ##RequestFields2
	IF OBJECT_ID('TEMPDB..##RequestFields3') IS NOT NULL
		DROP TABLE ##RequestFields3
	IF OBJECT_ID('TEMPDB..##FinalTable') IS NOT NULL
		DROP TABLE ##FinalTable
	IF OBJECT_ID('TEMPDB..##LastFinalTable') IS NOT NULL
		DROP TABLE ##LastFinalTable
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetRptData_Test]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[uspGetRptData_Test]  
 -- Add the parameters for the stored procedure here  
 @RequestFields1 VARCHAR(MAX),  
 @RequestFields2 VARCHAR(MAX),  
 @RequestFields3 VARCHAR(MAX),  
 @ParentFields RptQryType READONLY,  
 @Filter VARCHAR(MAX),  
 @WorkflowId INT  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
 --RequestFields: UserId,EmployeeCode,RequesterRoleId,Designation,TravelLocDetails.TravelFrom,TravelLocDetails.TravelTo,AdvanceIssued,PerDiem,Accommodation,OtherExpenses  
 --Filter:~CreatedDate~ BETWEEN '2017-01-01' AND '2017-12-31'  
 --WorkflowId:2  
    -- Insert statements for procedure here  
    IF OBJECT_ID('TEMPDB..##RequestFields1') IS NOT NULL  
  DROP TABLE ##RequestFields1  
 IF OBJECT_ID('TEMPDB..##RequestFields2') IS NOT NULL  
  DROP TABLE ##RequestFields2  
 IF OBJECT_ID('TEMPDB..##RequestFields3') IS NOT NULL  
  DROP TABLE ##RequestFields3  
 IF OBJECT_ID('TEMPDB..##FinalTable') IS NOT NULL  
  DROP TABLE ##FinalTable  
 IF OBJECT_ID('TEMPDB..##LastFinalTable') IS NOT NULL  
  DROP TABLE ##LastFinalTable  
    
    
 DECLARE @ReqFieldQry1 AS VARCHAR(MAX)  
 SET @ReqFieldQry1 ='';  
 DECLARE @ReqFieldQry2 AS VARCHAR(MAX)  
 SET @ReqFieldQry2 ='';  
 DECLARE @ReqFieldQry3 AS VARCHAR(MAX)  
 SET @ReqFieldQry3 ='';  
 DECLARE @FinalQuery AS VARCHAR(MAX)  
 SET @FinalQuery ='';  
   
 SET @ReqFieldQry1 += 'SELECT ' + @RequestFields1 + ',TranRefId TranRefId1 INTO ##RequestFields1 FROM rptTransaction WHERE WorkflowId = '''+ CONVERT(VARCHAR(16),@WorkflowId) +''' AND ISNULL(SourceColumn,'''') = '''''  
 EXEC(@ReqFieldQry1)  
   
 IF @RequestFields2 != ''   
 BEGIN  
  SET @ReqFieldQry2 += 'SELECT ' + @RequestFields2 + ',TranRefId TranRefId2 INTO ##RequestFields2 FROM rptTransaction WHERE WorkflowId = '''+ CONVERT(VARCHAR(16),@WorkflowId) +''' AND ISNULL(SourceColumn,'''') = '''''  
  EXEC(@ReqFieldQry2)  
 END  
   
 IF @RequestFields3 != ''   
 BEGIN  
  SET @ReqFieldQry3 += 'SELECT ' + @RequestFields3 + ',TranRefId TranRefId3 INTO ##RequestFields3 FROM rptTransaction WHERE WorkflowId = '''+ CONVERT(VARCHAR(16),@WorkflowId) +''' AND ISNULL(SourceColumn,'''') = '''''  
  EXEC(@ReqFieldQry3)  
 END  
   
 IF @RequestFields2 = ''   
 BEGIN  
  SET @FinalQuery = ' SELECT * INTO ##FinalTable FROM ##RequestFields1 AS T1'  
 END  
 ELSE IF @RequestFields2 != '' AND @RequestFields3 = ''  
 BEGIN  
  SET @FinalQuery = ' SELECT * INTO ##FinalTable FROM ##RequestFields1 AS T1 LEFT OUTER JOIN ##RequestFields2 AS T2 ON T1.TranRefId1 = T2.TranRefId2'     
 END  
 ELSE  
 BEGIN  
  SET @FinalQuery = ' SELECT * INTO ##FinalTable FROM ##RequestFields1 AS T1 LEFT OUTER JOIN ##RequestFields2 AS T2 ON T1.TranRefId1 = T2.TranRefId2'  
  SET @FinalQuery += ' LEFT OUTER JOIN ##RequestFields3 AS T3 ON T1.TranRefId1 = T3.TranRefId3'  
 END  
 --SET @FinalQuery = REPLACE(@FinalQuery,',TranRefId','')   
 EXEC(@FinalQuery)  
   
 SET @FinalQuery =''  
 SET @FinalQuery = 'SELECT * INTO ##LastFinalTable FROM ##FinalTable WHERE ' + @Filter  
 SET @FinalQuery = REPLACE(@FinalQuery,',TranRefId2','')  
 SET @FinalQuery = REPLACE(@FinalQuery,',TranRefId3','')  
 EXEC(@FinalQuery)  
   
 SET @FinalQuery =''  
 SET @FinalQuery = 'SELECT * FROM ##LastFinalTable '  
 EXEC(@FinalQuery)  
   
 DECLARE @strParentQry AS VARCHAR(MAX)  
 SET @strParentQry =''  
 /*LSFJSDLFFFFFFFFFFFFFFFFFF*/  
 DECLARE @MaxInsertRw AS INT  
 SELECT @MaxInsertRw = MAX(InsertionOrder) FROM @ParentFields  
 DECLARE @InsertRw AS INT  
 DECLARE @TranRefID AS INT  
 DECLARE @IdentityID AS INT  
 SET @InsertRw = 1  
 WHILE @InsertRw <= @MaxInsertRw   
 BEGIN  
  SELECT @strParentQry = Qry FROM @ParentFields WHERE InsertionOrder = @InsertRw  
  IF PATINDEX('%AND ir.Fin IN (%',@strParentQry) > 0  
  BEGIN  
   SET @strParentQry = @strParentQry + ' SELECT DISTINCT Fin FROM ##LastFinalTable as T) '  
  END  
  ELSE  
  BEGIN  
   SET @strParentQry = @strParentQry + ' SELECT DISTINCT TranRefId1 FROM ##LastFinalTable as T) '  
  END  
  EXEC(@strParentQry)    
  SET @InsertRw = @InsertRw + 1  
 END   
    
 /*SDFSDLFSDFJLSDJFSLJFLSDJLSDFJ*/  
   
   
   
    
 IF OBJECT_ID('TEMPDB..##RequestFields1') IS NOT NULL  
  DROP TABLE ##RequestFields1  
 IF OBJECT_ID('TEMPDB..##RequestFields2') IS NOT NULL  
  DROP TABLE ##RequestFields2  
 IF OBJECT_ID('TEMPDB..##RequestFields3') IS NOT NULL  
  DROP TABLE ##RequestFields3  
 IF OBJECT_ID('TEMPDB..##FinalTable') IS NOT NULL  
  DROP TABLE ##FinalTable  
 IF OBJECT_ID('TEMPDB..##LastFinalTable') IS NOT NULL  
  DROP TABLE ##LastFinalTable  
END  
GO
/****** Object:  StoredProcedure [dbo].[uspGetRptMapping]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetRptMapping] 
	-- Add the parameters for the stored procedure here
	@WorkflowId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- exec uspGetRptMapping 3
    -- Insert statements for procedure here
	SELECT * FROM rptMapping WHERE WorkflowId = @WorkflowId 
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetRules]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetRules]  
 -- Add the parameters for the stored procedure here  
 @RuleSetId INT
AS   
-- EXEC uspGetRules 1,1
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
 
	SELECT RM.RuleName,RM.Condition,RM.ThenAction,RM.ElseAction FROM dbo.PRuleSetMapping AS RSM 
	INNER JOIN dbo.PRuleMaster AS RM ON RSM.RuleId = RM.RuleId 
	INNER JOIN dbo.PRuleSet AS RS ON RSM.RuleSetId = RS.RuleSetId 
	WHERE RSM.RuleSetId = @RuleSetId
	ORDER BY RS.Priority, RM.Priority
END  
 

GO
/****** Object:  StoredProcedure [dbo].[uspGetRuleSetRules]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rameshkumar
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetRuleSetRules]
	@WorkflowId INT
AS
--Execute uspGetWorkflowList
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT RS.*,RM.* FROM PRuleSet AS RS 
	INNER JOIN PRuleSetMapping AS RSM ON RS.RuleSetId = RSM.RuleSetId 
	INNER JOIN PRuleMaster AS RM ON RSM.RuleId = RM.RuleId 
	--WHERE RS.WorkflowId = @WorkflowId
	ORDER BY RuleSetId,RuleId 
END


GO
/****** Object:  StoredProcedure [dbo].[uspGetSavingsFlatSavings]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetSavingsFlatSavings]
	-- Add the parameters for the stored procedure here	
	@FTECostId UNIQUEIDENTIFIER 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @FTECostId != CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER)
	BEGIN
		SELECT M.FTECostId,R.SolutionName,MonthName MonthNo,YearNo,Status,LOB,Functionality,Customer,Description,Attachments,Type,SavingsMode,Title,SavingsILValue,SavingsOPSValue,SavingsFINValue FROM SavingsFlatSavings AS M
	    INNER JOIN SavingsRPASolutions AS R ON M.SolutionId = R.SolutionId 
		WHERE M.FTECostId = @FTECostId
	END
	ELSE
	BEGIN		
		-- Insert statements for procedure here
		SELECT M.FTECostId,R.SolutionName,MonthName MonthNo,YearNo,Status,LOB,Functionality,Customer,Description,Attachments,Type,SavingsMode,Title,SavingsILValue,SavingsOPSValue,SavingsFINValue FROM SavingsFlatSavings AS M
	    INNER JOIN SavingsRPASolutions AS R ON M.SolutionId = R.SolutionId 
	END
    -- Insert statements for procedure here
 
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetSavingsMicrosServiceRegistry]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetSavingsMicrosServiceRegistry] 
	-- Add the parameters for the stored procedure here	
	@RegisterId uniqueidentifier 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	IF @RegisterId != CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER)
	BEGIN
		SELECT M.RegisterId,R.SolutionName,TranROI,TranROIMode,Status,LOB,Functionality,Customer,Description,Attachments,MicroServiceEffort,Title FROM SavingsMicrosServiceRegistry AS M
		INNER JOIN SavingsRPASolutions AS R ON M.SolutionId = R.SolutionId 
		WHERE M.RegisterId = @RegisterId
	END
	ELSE
	BEGIN
		-- Insert statements for procedure here
		SELECT M.RegisterId,R.SolutionName,TranROI,TranROIMode,Status,LOB,Functionality,Customer,Description,Attachments,MicroServiceEffort,Title FROM SavingsMicrosServiceRegistry AS M
		INNER JOIN SavingsRPASolutions AS R ON M.SolutionId = R.SolutionId 
	END
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetSavingsSolutionGUID]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetSavingsSolutionGUID]
	-- Add the parameters for the stored procedure here
	@SolutionName VARCHAR(256) =''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- EXEC uspGetSavingsSolutionGUID 'iLock'
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF ISNULL(@SolutionName,'') =''
    BEGIN
		SELECT SolutionId,SolutionName,SolId FROM SavingsRPASolutions 
	END
	ELSE
	BEGIN
		SELECT SolutionId,SolutionName,SolId FROM SavingsRPASolutions WHERE SolutionName = @SolutionName 
	END
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetTatOverDue]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[uspGetTatOverDue]                
 -- Add the parameters for the stored procedure here                 
 @WorkflowId INT ,              
 @UserId VARCHAR(100),          
 @Status VARCHAR(MAX) = ''          
AS                 
-- EXEC [uspGetTatOverDue] 3,'rameshkumar.r1',''                
BEGIN                

  /*declare @WorkflowId INT =3,              
 @UserId VARCHAR(100)='rameshkumar.r1',          
 @Status VARCHAR(MAX) = '' 
 */

 -- SET NOCOUNT ON added to prevent extra result sets from                
 -- interfering with SELECT statements.                
 SET NOCOUNT ON;                 
 BEGIN                
 -- SET NOCOUNT ON added to prevent extra result sets from                
 -- interfering with SELECT statements.                
 SET NOCOUNT ON;                 
                 
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL              
 DROP TABLE #TempSubOrdinates              
 ;WITH SubOrdinates              
 AS              
 (              
   SELECT UserId,SuperVisorId FROM PBWUserMaster AS U WHERE U.SuperVisorId = @UserId              
   UNION ALL              
   SELECT U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN SubOrdinates AS S              
   ON U.SuperVisorId = S.UserId              
 )              
 SELECT UserId,SuperVisorId              
 INTO #TempSubOrdinates FROM SubOrdinates              
              
 --SELECT * FROM  #TempSubOrdinates              
IF @Status != ''           
BEGIN          
  IF OBJECT_ID('TEMPDB..#TempData') IS NOT NULL DROP TABLE #TempData                    
	
	SELECT * INTO #TempData FROM (SELECT W.WorkflowId,W.RoleId,W.Fin FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
	ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
	INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
	WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status                
	UNION              
	SELECT W.WorkflowId,W.RoleId,W.Fin FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
	ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status            
	AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND RoleName IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','Legal','CMO','NHOD','HR		Head','HRBP','PanelMembers'))          
	AND W.WorkflowId = @WorkflowId ) AS TX          
 
	SELECT A.WorkflowId,A.Fin,TD.FIN,CASE WHEN A.Fin=TD.FIN THEN 1 ELSE 0 END TATFlag
	FROM #TempData A LEFT JOIN PBWWorkflowTATDetails AS TD ON TD.RoleId=A.RoleId AND TD.WorkflowId=A.WorkflowId AND A.Fin=TD.FIN
 
END          
ELSE          
BEGIN

IF OBJECT_ID('TEMPDB..#TempDataStatus') IS NOT NULL DROP TABLE #TempDataStatus                    
	
	SELECT * INTO #TempDataStatus FROM (SELECT W.WorkflowId,W.RoleId,W.Fin FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
	ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
	INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
	WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND 
	UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED')           
	UNION              
	SELECT W.WorkflowId,W.RoleId,W.Fin FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
	ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND 
	UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED')          
	INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId           
	AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND RoleName IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','Legal','CMO','NHOD','HR	Head','HRBP','PanelMembers'))          
	AND W.WorkflowId = @WorkflowId) AS TX
	
	SELECT A.WorkflowId,A.Fin,TD.FIN,CASE WHEN A.Fin=TD.FIN THEN 1 ELSE 0 END TATFlag
	FROM #TempDataStatus A LEFT JOIN PBWWorkflowTATDetails AS TD ON TD.RoleId=A.RoleId AND TD.WorkflowId=A.WorkflowId  AND A.Fin=TD.FIN 
   
 
END          
 IF OBJECT_ID('TEMPDB..#TempData') IS NOT NULL DROP TABLE #TempData
  IF OBJECT_ID('TEMPDB..#TempDataStatus') IS NOT NULL DROP TABLE #TempDataStatus       
               
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL              
  DROP TABLE #TempSubOrdinates
      
END
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetTraveDocumentStatus]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC uspGetTraveDocumentStatus 2,'prabaakaran.t','India,Philippines','TravelDocument'
*/
CREATE PROCEDURE [dbo].[uspGetTraveDocumentStatus]
	@WfId			INT,
	@UserId			VARCHAR(250),
	@VisaCountrys	VARCHAR(MAX) = '',
	@DocCategory	VARCHAR(250)
AS
BEGIN
	SET NOCOUNT ON
	
	IF OBJECT_ID('U','tempdb..#TravelDocument') IS NOT NULL
		DROP TABLE #TravelDocument
	
	SELECT * INTO #TravelDocument FROM (
	SELECT 
		MD.Value [DocName],'' [VisaCountry],@UserId [CreatedBy]
	FROM PBWMasterData MD
	WHERE MD.Field = 'TravelDocument' AND MD.WorkflowId  = @WfId AND MD.value <> 'Visa'
	UNION ALL
	SELECT 
		MD.Value [DocName],#Temp.items [VisaCountry],@UserId [CreatedBy]
	FROM PBWMasterData MD
	CROSS JOIN ( SELECT items FROM [dbo].[fnSplitString](@VisaCountrys,',') ) #Temp 
	WHERE MD.Field = 'TravelDocument' AND MD.WorkflowId  = @WfId AND MD.value = 'Visa' ) #Temp
	
	ALTER TABLE #TravelDocument ADD FilePath VARCHAR(250),ValidFromDt VARCHAR(10),ValidToDt VARCHAR(10),FileId INT,[FileName] VARCHAR(250)
	
	UPDATE #TravelDocument SET FilePath= #Temp.FilePath,ValidFromDt=#Temp.ValidFromDt,ValidToDt=#Temp.ValidToDt,FileId=#Temp.FileId,CreatedBy=#Temp.CreatedBy,FileName=#Temp.FileName FROM (
		SELECT 
			MD.Value [DocName],ISNULL(D.Country,'') [VisaCountry],ISNULL(D.FilePath,'') [FilePath],
			ISNULL(CONVERT(VARCHAR(10),D.ValidFromDt),'') [ValidFromDt],ISNULL(CONVERT(VARCHAR(10),D.ValidToDt),'') [ValidToDt],ISNULL(D.FileId,0) [FileId],
			D.CreatedBy,D.FileName
		FROM PBWMasterData MD
		INNER JOIN PBWDocuments D ON D.DocName = MD.Value AND D.CreatedBy = @UserId AND D.WfId  = MD.WorkflowId AND DocCategory = @DocCategory
		WHERE MD.Field = 'TravelDocument' AND MD.WorkflowId  = @WfId ) #Temp
	WHERE #TravelDocument.DocName = #Temp.DocName AND #TravelDocument.VisaCountry = #Temp.VisaCountry AND #TravelDocument.CreatedBy = #Temp.CreatedBy
	
	SELECT 
		ROW_NUMBER() OVER(ORDER BY FileId) SNo,ISNULL(DocName,'') [DocName],ISNULL(VisaCountry,'') [Country],ISNULL(FilePath,'') [FilePath],
		ISNULL(CONVERT(VARCHAR(10),ValidFromDt),'') [ValidFromDt],ISNULL(CONVERT(VARCHAR(10),ValidToDt),'') [ValidToDt],ISNULL(FileId,0) [FileId],
		CreatedBy,ISNULL([FileName],'') [FileName]	
	FROM #TravelDocument
	
	IF OBJECT_ID('U','tempdb..#TravelDocument') IS NOT NULL
		DROP TABLE #TravelDocument	
	
	/*
	SELECT 
		ROW_NUMBER() OVER(ORDER BY D.FileId) SNo,MD.Value [DocName],ISNULL(D.Country,'') [VisaCountry],ISNULL(D.FilePath,'') [FilePath],
		ISNULL(CONVERT(VARCHAR(10),D.ValidFromDt),'') [ValidFromDt],ISNULL(CONVERT(VARCHAR(10),D.ValidToDt),'') [ValidToDt],ISNULL(D.FileId,0) [FileId],
		D.CreatedBy,D.FileName
	FROM PBWMasterData MD
	LEFT JOIN PBWDocuments D ON D.DocName = MD.Value AND ( D.CreatedBy = @UserId OR @UserId = '' ) AND D.WfId  = MD.WorkflowId 
	AND ( ( Country = @VisaCountry AND D.DocName = 'Visa') OR ( D.DocName = 'Passport'  ) ) 
	AND ( DocCategory = @DocCategory OR @DocCategory = '' )
	WHERE MD.Field = 'TravelDocument' AND MD.WorkflowId  = @WfId
	*/
	
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetTravelDeskAttachment]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC uspGetTravelDeskAttachment 5,2
*/
CREATE Procedure [dbo].[uspGetTravelDeskAttachment]        
	@RequestId			INT,
	@WfId				INT
AS        
BEGIN   
	/*                    
	Purpose           : Getting mails information using service into DB                
	Created By        : Prabaakaran T                    
	Created Date      :	05 sep 2017  
	*/      
	
	SELECT 
		FolderPath,
		LTRIM(RTRIM(m.n.value('.[1]','varchar(8000)'))) AS FileName,
		CASE WHEN LTRIM(RTRIM(m.n.value('.[1]','varchar(8000)'))) = '' THEN '' ELSE FolderPath+'/'+LTRIM(RTRIM(m.n.value('.[1]','varchar(8000)'))) END [Attachment]
	FROM (SELECT FolderPath,CAST('<XMLRoot><RowData>' + REPLACE(FileName,',','</RowData><RowData>') + '</RowData></XMLRoot>' AS XML) AS #tem
	FROM PBW_MailInformation WHERE WfId = @WfId AND RequestId = @RequestId ) #Temp
	CROSS APPLY #tem.nodes('/XMLRoot/RowData') m(n)
	/*
	select 'https://arc.accesshealthcare.co/IISFS/TMS/Attachments/105/2018_4_3-16hrs24min2sec' [FolderPath],	'1.pdf' [FileName],	'https://arc.accesshealthcare.co/IISFS/TMS/Attachments/105/2018_4_3-16hrs24min2sec/1.pdf' [Attachment]
	UNION ALL
	select 'https://arc.accesshealthcare.co/IISFS/TMS/Attachments/105/2018_4_3-16hrs24min2sec'[FolderPath],	'2.pdf' [FileName],	'https://arc.accesshealthcare.co/IISFS/TMS/Attachments/105/2018_4_3-16hrs24min2sec/2.pdf' [Attachment]	
	*/
END


GO
/****** Object:  StoredProcedure [dbo].[uspGetTravelToCity]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspGetTravelToCity]
	@FROM_CITY_ID		INT = NULL	
AS
BEGIN
	/*
	CREATED BY		: PRABAAKARAN T
	CREATED DT		: 2017-11-01
	PURPOSE			: AR TEST PROCESS
	TICKET/SCR NO	: SCR - 1422
	*/
	
	/*
		EXEC uspGetTravelToCity @FROM_CITY_ID = 0	
		EXEC uspGetTravelToCity @FROM_CITY_ID = 1
	*/
	SET NOCOUNT ON
	DECLARE @SQL	VARCHAR(MAX) =''
	SET @SQL = '	
	SELECT
		*
	FROM PBWCities C 
	INNER JOIN PBWStates S ON S.StateId = C.StateId AND S.Active=1
	INNER JOIN PBWCountries CO ON CO.CountryId = S.CountryId AND CO.Active=1
	WHERE C.Active=1 ' 
	
	IF ISNULL(@FROM_CITY_ID,0) > 0
		BEGIN
			SET @SQL = @SQL + ' AND CO.CountryId  NOT IN ( 	SELECT
				ISNULL(S.CountryId,0) 
			FROM PBWCities C 
			INNER JOIN PBWStates S ON S.StateId = C.StateId AND S.Active=1
			WHERE C.CityId = '+CONVERT(VARCHAR(10),@FROM_CITY_ID)+' ) '
		END	
	EXEC(@SQL)
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetUserDetails]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetUserDetails]  
 @UserId VARCHAR(100)   
AS  
BEGIN  
 SET NOCOUNT ON  
   
 DECLARE @ImageRootPath  VARCHAR(100) = 'https://arc.accesshealthcare.co/IISFS/'  
 DECLARE @ImageFolderPath VARCHAR(100) = 'arc_rec/images/candidate/ProfileImage/thumb_'  
   
 IF ISNULL(@UserId,'') = ''  
 BEGIN  
  SELECT  
   UserId,FirstName,LastName,P.DepartmentId,P.RoleId,ClientId,EmailId,SupervisorId,UserLob,UserClient,  
   @ImageRootPath+@ImageFolderPath+ISNULL(UserImageName,'') [UserImage]   
   ,P.CreatedBy,P.CreatedDate,P.LastModifiedBy,P.LastModifiedDate,Active,P.Grade, LocationName, DepartmentName  
   ,UD.RoleName Designation,DATEADD(YEAR,-1,GETDATE()) DOJ
  FROM PBWUserMaster AS P LEFT OUTER JOIN PBWUserDesignation AS UD ON P.RoleId = UD.RoleId   
 END  
 ELSE  
 BEGIN  
  SELECT  
   UserId,FirstName,LastName,P.DepartmentId,P.RoleId,ClientId,EmailId,SupervisorId,UserLob,UserClient,  
   @ImageRootPath+@ImageFolderPath+ISNULL(UserImageName,'') [UserImage]   
   ,P.CreatedBy,P.CreatedDate,P.LastModifiedBy,P.LastModifiedDate,Active,P.Grade, LocationName, DepartmentName  
   ,UD.RoleName Designation,DATEADD(YEAR,-1,GETDATE()) DOJ
  FROM PBWUserMaster AS P LEFT OUTER JOIN PBWUserDesignation AS UD ON P.RoleId = UD.RoleId  
  WHERE ISNULL(UserID,'') = @USERID  
 END  
    
 SET NOCOUNT OFF  
END  

GO
/****** Object:  StoredProcedure [dbo].[uspGetUserDetailsMail_TMS]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[uspGetUserDetailsMail_TMS]  
 -- Add the parameters for the stored procedure here  
 @UniqueId VARCHAR(256)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 --EXEC uspGetUserDetailsMail_TMS 'sofia.a'  
 SET NOCOUNT ON;  
  
    -- Insert statements for procedure here  
 SELECT CI.InternalName Client,JobTitle Functionality,UserLob  
 ,(SELECT ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') FROM PBWUserMaster AS I WHERE I.UniqueId = U.SupervisorId) Supervisor  
 ,LocationName BaseLocation FROM [ARC_Enterprise_domain]..ARC_REC_USER_INFO_ALL AS UI  
 INNER JOIN [ARC_Enterprise_domain]..HR_Functionality HF ON HF.FunctionalityId=UI.FUNCTIONALITY_ID    
 INNER JOIN [ARC_Enterprise_domain]..arc_contract_customer CI ON CI.customerid=UI.Client_Id    
 INNER JOIN PBWUSERMASTER AS U ON U.UniqueId = UI.NT_USERNAME  
 WHERE UI.NT_USERNAME = @UniqueId     
    
END  
  
GO
/****** Object:  StoredProcedure [dbo].[uspGetUserInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetUserInfo]
	@ClientId		INT,
	@UserId			VARCHAR(100) = ''
AS
BEGIN
	/*
	CREATED BY  : PRABAAKARAN T
	CREATED DT	: 2017-07-12
	PURPOSE     : GET USER INFO
	*/
	/*
		EXEC uspGetUserInfo @ClientId = 1,@USERID = 'prabaakaran.t'
		EXEC uspGetUserInfo @ClientId = 1,@USERID = ''
	*/
	SET NOCOUNT ON
	
	DECLARE @ImageRootPath		VARCHAR(100) = 'https://arc.accesshealthcare.co/IISFS/'
	DECLARE @ImageFolderPath	VARCHAR(100) = 'arc_rec/images/candidate/ProfileImage/thumb_'
	
	SELECT 
		UserId,FirstName,LastName,UM.DepartmentId,
		UM.RoleId,UM.ClientId,UM.EmailId,SupervisorId,
		UM.CreatedBy,UM.CreatedDate,UM.LastModifiedBy,
		UM.LastModifiedDate,UniqueId,UM.Id,UserLob,
		UserClient,ISNULL(ContactNo,'') [ContactNo], 
		@ImageRootPath+@ImageFolderPath+ISNULL(UserImageName,'') [UserImage],
		C.CountryName,C.CountryCode,D.RoleName,UM.EmpCode,
		CASE C.CountryCode WHEN 'IN' THEN 'https://arc.accesshealthcare.co/applogin/' WHEN 'PH' THEN 'https://manilaarc.accesshealthcare.co/applogin/' 
		ELSE 'https://arc.accesshealthcare.co/applogin/' END [ArcPageUrl],
		CASE C.CountryCode WHEN 'IN' THEN 'https://arc.accesshealthcare.co/arc_support/' WHEN 'PH' THEN 'https://manilaarc.accesshealthcare.co/arc_support/' 
		ELSE 'https://arc.accesshealthcare.co/arc_support/' END [HomePageUrl]
	FROM PBWUserMaster UM 
	INNER JOIN PBWUserDesignation D ON D.RoleId = UM.RoleId
	INNER JOIN PBWCountries C ON UM.CountryId = C.CountryID AND C.Active = 1
	WHERE ( UserID = @USERID OR @USERID = '' ) AND ClientId = @ClientId
		
	SET NOCOUNT OFF
END


GO
/****** Object:  StoredProcedure [dbo].[uspGetWaitingForApproval]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                
-- Author:  RAMESHKUMAR                
-- Create date: Jun/06/2017                
-- Description: GetJSON Value                
-- =============================================                
CREATE PROCEDURE  [dbo].[uspGetWaitingForApproval]                
 -- Add the parameters for the stored procedure here                 
 @WorkflowId INT ,              
 @UserId VARCHAR(100),          
 @Status VARCHAR(MAX) = ''          
AS                 
-- EXEC uspGetWaitingForApproval 11,'babu.j',''                
BEGIN                
 -- SET NOCOUNT ON added to prevent extra result sets from                
 -- interfering with SELECT statements.                
 SET NOCOUNT ON;                 
                 
 ----------IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL              
 ----------DROP TABLE #TempSubOrdinates     
 ----------CREATE TABLE #TempSubOrdinates  
----------(UserId VARCHAR(256),SuperVisorId VARCHAR(256))  
  
----------IF UPPER(@UserId) = 'SHAJI.RAVI'  
----------BEGIN  
      ----------INSERT INTO #TempSubOrdinates  
      ----------SELECT UserId,SuperVisorId FROM PBWUserMaster  
----------END  
----------ELSE  
----------BEGIN          
      ---------- ;WITH SubOrdinates              
      ---------- AS              
      ---------- (              
      ----------   SELECT UserId,SuperVisorId FROM PBWUserMaster AS U WHERE U.SuperVisorId = @UserId              
      ----------   UNION ALL              
      ----------   SELECT U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN SubOrdinates AS S              
      ----------   ON U.SuperVisorId = S.UserId              
      ---------- )     
      ---------- INSERT INTO #TempSubOrdinates           
      ---------- SELECT UserId,SuperVisorId FROM SubOrdinates    
 ----------END            
              
              
       IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL              
            DROP TABLE #TempSubOrdinates     
       CREATE TABLE #TempSubOrdinates  
      (UserId VARCHAR(256),SuperVisorId VARCHAR(256))  
  
      IF OBJECT_ID('TEMPDB..#TempSubOrdinates1') IS NOT NULL              
            DROP TABLE #TempSubOrdinates1    
  
      IF OBJECT_ID('TEMPDB..#TempSubOrdinates2') IS NOT NULL              
            DROP TABLE #TempSubOrdinates2    
         
      SELECT   
            DISTINCT U.SupervisorId,U.Userid INTO #TempSubOrdinates1  
      FROM PBWUserMaster AS U LEFT OUTER JOIN PBWUserMaster AS V  
      ON U.UserId = V.SupervisorId  
      WHERE ISNULL(v.SupervisorId,'') != ''  
        
       ;WITH SubOrdinates              
       AS              
       (      
         SELECT DISTINCT UserId,SuperVisorId FROM #TempSubOrdinates1 AS U WHERE U.SuperVisorId = @UserId            
         UNION ALL              
         SELECT U.UserId,U.SuperVisorId FROM #TempSubOrdinates1 AS U INNER JOIN SubOrdinates AS S              
         ON U.SuperVisorId = S.UserId     
       )              
       SELECT DISTINCT S.UserId,S.SuperVisorId   
       INTO #TempSubOrdinates2            
       FROM SubOrdinates AS S   
         
       INSERT INTO #TempSubOrdinates  
      (UserId,SuperVisorId)  
      SELECT DISTINCT UserId,SuperVisorId FROM #TempSubOrdinates1 AS U WHERE U.SuperVisorId = @UserId   
       UNION  
      SELECT DISTINCT U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN #TempSubOrdinates2 as v  
      ON U.SuperVisorId = V.UserId  
      ORDER BY U.SupervisorId,U.UserId         
        
      INSERT INTO #TempSubOrdinates  
      (UserId,SuperVisorId)  
      SELECT DISTINCT UserId,SuperVisorId FROM PBWUserMaster AS U WHERE U.SuperVisorId = @UserId AND U.UserId NOT IN (SELECT T.UserId FROM #TempSubOrdinates AS T)  
  
            IF @WorkflowId = 11
            BEGIN
                  IF @Status != ''           
                  BEGIN  
                        SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                        ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
                        INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
                        WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status   
                        AND W.UserId IN (CASE WHEN W.RoleId = 36 THEN (SELECT TOP 1 ISNULL(UI.UserId,'') FROM PBWUserMaster AS UI WHERE W.UserId = UI.UserId AND UI.SuperVisorId  = @UserId) ELSE W.UserId END)             
                        UNION              
                        SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                        ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status            
                        AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','SUPERVISOR'))          
                        AND W.WorkflowId = @WorkflowId   
                        ORDER BY W.LastModifiedDate DESC  
                  END
                  ELSE
                  BEGIN
                        SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                        ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
                        INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
                        WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED','SELECTED')  
                        AND W.UserId IN (CASE WHEN W.RoleId = 36 THEN (SELECT TOP 1 ISNULL(UI.UserId,'') FROM PBWUserMaster AS UI WHERE W.UserId = UI.UserId AND UI.SuperVisorId  = @UserId) ELSE W.UserId END)
                        UNION              
                        SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                        ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED','SELECTED')                            
                        INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId           
                        AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC'))          
                        AND W.WorkflowId = @WorkflowId  
                        ORDER BY W.LastModifiedDate DESC  
                  END
            END
            ELSE
            BEGIN           
                  IF @Status != ''           
                  BEGIN          
                        IF @UserId = 'rameshkumar.r1'    
                        BEGIN            
                              SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                              ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
                              INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
                              WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status                
                              UNION              
                              SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                              ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status            
                              AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','SUPERVISOR'))          
                              AND W.WorkflowId = @WorkflowId AND @UserId = 'rameshkumar.r1'  
                              ORDER BY W.LastModifiedDate DESC   
                        END  
                        ELSE  
                        BEGIN    
                              SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                              ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
                              INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
                              WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status                
                              UNION              
                              SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                              ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status            
                              AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','SUPERVISOR'))          
                              AND W.WorkflowId = @WorkflowId   
                              ORDER BY W.LastModifiedDate DESC   
                        END       
                  END          
                  ELSE          
                  BEGIN          
                        IF @UserId = 'rameshkumar.r1'    
                        BEGIN   
                              SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                              ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
                              INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
                              WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId   AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED','SELECTED')           
                              UNION              
                              SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                              ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED','SELECTED')         

                              INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId           
                              AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC','SUPERVISOR'))          
                              AND W.WorkflowId = @WorkflowId AND @UserId = 'rameshkumar.r1'  
                              ORDER BY W.LastModifiedDate DESC    
                        END  
                        ELSE  
                        BEGIN    
                              SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                              ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
                              INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
                              WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId   AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED','SELECTED')           
                              UNION              
                              SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
                              ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED','SELECTED')         

                              INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId           
                              AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND UPPER(RoleName) IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','LEGAL','CMO','NHOD','HR Head','HRBP','PANELMEMBERS','ACTIVEMD','TICKETCOSTUPDATER','SYSTEM','CUSTOMER','SPOC'))          
                              AND W.WorkflowId = @WorkflowId  
                              ORDER BY W.LastModifiedDate DESC  
                        END       
                  --WHERE UPPER(R.RoleName) NOT IN ('DEPARTMENTHEAD')          
                  --AND W.RoleId NOT IN (SELECT R.RoleId FROM PBWUserRoleMapping AS R WHERE UniqueId = @UserId)          
                  END    
            END      
           
               
       IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL              
        DROP TABLE #TempSubOrdinates       
          
      IF OBJECT_ID('TEMPDB..#TempSubOrdinates1') IS NOT NULL              
              DROP TABLE #TempSubOrdinates1    
        
      IF OBJECT_ID('TEMPDB..#TempSubOrdinates2') IS NOT NULL              
              DROP TABLE #TempSubOrdinates2          
END  
GO
/****** Object:  StoredProcedure [dbo].[uspGetWaitingForApproval_old]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================                
-- Author:  RAMESHKUMAR                
-- Create date: Jun/06/2017                
-- Description: GetJSON Value                
-- =============================================                
create PROCEDURE  [dbo].[uspGetWaitingForApproval_old]                
 -- Add the parameters for the stored procedure here                 
 @WorkflowId INT ,              
 @UserId VARCHAR(100),          
 @Status VARCHAR(MAX) = ''          
AS                 
-- EXEC uspGetWaitingForApproval 16,'spoc',''                
BEGIN                
 -- SET NOCOUNT ON added to prevent extra result sets from                
 -- interfering with SELECT statements.                
 SET NOCOUNT ON;                 
                 
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL              
 DROP TABLE #TempSubOrdinates              
 ;WITH SubOrdinates              
 AS              
 (              
   SELECT UserId,SuperVisorId FROM PBWUserMaster AS U WHERE U.SuperVisorId = @UserId              
   UNION ALL              
   SELECT U.UserId,U.SuperVisorId FROM PBWUserMaster AS U INNER JOIN SubOrdinates AS S              
   ON U.SuperVisorId = S.UserId              
 )              
 SELECT UserId,SuperVisorId              
 INTO #TempSubOrdinates FROM SubOrdinates              
              
 --SELECT * FROM  #TempSubOrdinates              
IF @Status != ''           
BEGIN          
   IF @UserId = 'rameshkumar.r1'  
	BEGIN           
		 SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
		 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
		 INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
		 WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status                
		 UNION              
		 SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
		 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status            
		 AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND RoleName IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','Legal','CMO','NHOD','HR Head','HRBP','PanelMembers','ActiveMD','TicketCostUpdater','

System','Customer','SPOC'))          
		 AND W.WorkflowId = @WorkflowId AND @UserId = 'rameshkumar.r1'  
		 ORDER BY LastModifiedDate DESC 
	END
	ELSE
	BEGIN
		 SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
		 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
		 INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
		 WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status                
		 UNION              
		 SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
		 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status            
		 AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND RoleName IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','Legal','CMO','NHOD','HR Head','HRBP','PanelMembers','TicketCostUpdater','System','Cu

stomer','SPOC'))          
		 AND W.WorkflowId = @WorkflowId   
		 ORDER BY LastModifiedDate  DESC   
	END   
END          
ELSE          
BEGIN 
	IF @UserId = 'rameshkumar.r1'  
	BEGIN   
		SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
		ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
		INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
		WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId   AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED')       

    
		UNION              
		SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
		ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED')          
		INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId           
		AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND RoleName IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','Legal','CMO','NHOD','HR Head','HRBP','PanelMembers','ActiveMD','TicketCostUpdater','

System','Customer','SPOC'))          
		AND W.WorkflowId = @WorkflowId AND @UserId = 'rameshkumar.r1'	 
		 ORDER BY LastModifiedDate  DESC  
	END  
	ELSE
	BEGIN
		SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
		ON U.UniqueId =@UserId AND W.RoleId = U.RoleId               
		INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId              
		WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId   AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED')       

    
		UNION              
		SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U              
		ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','SAVED','REVIEWED','REJECTED','REVIEW','SCHEDULED','HOLD','SELECTED','RELEASEDATE','RAISED','REOPENED','CREATED')          
		INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId           
		AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND RoleName IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','Legal','CMO','NHOD','HR Head','HRBP','PanelMembers','TicketCostUpdater','System','Cu

stomer','SPOC'))          
		AND W.WorkflowId = @WorkflowId 	
		 ORDER BY LastModifiedDate   DESC 
	END
 --WHERE UPPER(R.RoleName) NOT IN ('DEPARTMENTHEAD')          
 --AND W.RoleId NOT IN (SELECT R.RoleId FROM PBWUserRoleMapping AS R WHERE UniqueId = @UserId)          
END          
           
               
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL              
  DROP TABLE #TempSubOrdinates              
END 

GO
/****** Object:  StoredProcedure [dbo].[uspGetWaitingForApprovalIJPPanelMembers]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
      
-- =============================================              
-- Author:  RAMESHKUMAR              
-- Create date: JAN/06/2018             
-- Description: GetJSON Value              
-- =============================================              
CREATE PROCEDURE  [dbo].[uspGetWaitingForApprovalIJPPanelMembers]              
 -- Add the parameters for the stored procedure here               
 @WorkflowId INT =11,
 @WorkflowStateId INT = -17 
AS               
-- EXEC uspGetWaitingForApprovalIJPPanelMembers              
BEGIN              
 -- SET NOCOUNT ON added to prevent extra result sets from              
 -- interfering with SELECT statements.              
 SET NOCOUNT ON;  
  
 SELECT * FROM PBWWorkflowTransaction AS T 
 INNER JOIN PBWWorkFlowRoleMaster AS R ON T.WorkflowId = R.WfId AND T.RoleId = R.RoleId
 WHERE WorkflowId = @WorkflowId AND WorkFlowStateId = @WorkflowStateId 
 --AND RoleName ='PanelMembers'
  
END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetWorkflowList]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rameshkumar
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspGetWorkflowList]
AS
--Execute uspGetWorkflowList
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT distinct WorkFlowId,WorkFlowName FROM PBWWorkFlowMaster
	WHERE WorkFlowName IS NOT NULL
	 and WorkFlowId NOT IN (1,2) 
	 ORDER BY WorkFlowName
END
 
GO
/****** Object:  StoredProcedure [dbo].[uspGetWorkFlowRoleMaster]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetWorkFlowRoleMaster]
      @Fin AS INT = 0,
      @WfId INT = 0
AS
BEGIN
      IF ISNULL(@Fin,0) != 0
      BEGIN
            /*
            SELECT DISTINCT RoleId,RoleName FROM PBWWorkFlowRoleMaster AS W WHERE W.HierarchyLevel > (
            SELECT WFRM.HierarchyLevel FROM PBWWorkflowTransaction AS T INNER JOIN 
            PBWUserRoleMapping AS RM ON T.UserId = RM.UniqueId 
            INNER JOIN PBWWorkFlowRoleMaster AS WFRM ON WFRM.RoleId = RM.RoleId 
            WHERE Fin = @Fin AND WFRM.WfId=@WfId) AND WfId = @WfId
            */
            /* Comment and modified by Prabaakaran T */
            
            SELECT 
                  DISTINCT RoleId,RoleName 
            FROM PBWWorkFlowRoleMaster AS W WHERE W.HierarchyLevel > (
            SELECT 
                 TOP 1 WFRM.HierarchyLevel 
            FROM PBWWorkflowTransaction AS T 
            INNER JOIN PBWUserRoleMapping AS RM ON T.UserId = RM.UniqueId AND T.WorkflowId = RM.WorkflowId
            INNER JOIN PBWWorkFlowRoleMaster AS WFRM ON WFRM.RoleId = RM.RoleId AND RM.WorkflowId = WFRM.WfId
            WHERE Fin = @Fin AND WFRM.WfId=@WfId ORDER BY WFRM.HierarchyLevel) 
            AND WfId = @WfId        
      END
      ELSE
      BEGIN
            SELECT RoleId,RoleName FROM PBWWorkFlowRoleMaster WHERE WfId = @WfId
      END
End

GO
/****** Object:  StoredProcedure [dbo].[uspIJPFinalClosureMail]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspIJPFinalClosureMail]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT=11,
	@IJPWorkflowId INT=502,
	@Fin INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 SELECT EmpCode,EmpName,OldDesignation,OldLOB,OldClient,OldFunctionality,NewDesignation,NewLOB,NewClient,NewFunctionality,IJPReleaseDate FROM
	 (
		 SELECT * FROM ( 	 	 	 	 	 	 	 
				 SELECT 
					 EmpCode,ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') EmpName,nvarchar22 OldDesignation,UserLob OldLOB,UserClient OldClient,nvarchar21 OldFunctionality 
					,CASE WHEN datetime5 ='1900-01-01 00:00:00.000' THEN '' ELSE CONVERT(VARCHAR(50),datetime5,101) END IJPReleaseDate,nvarchar5 UniqueId,int3 IJPFin 
				 FROM rptTransaction AS R INNER JOIN PBWUserMaster AS U 
				 ON R.nvarchar5 = U.uniqueid
				 WHERE R.WorkflowId = @WorkflowId AND R.Fin = @Fin AND R.LogId = 0 AND R.SourceColumn = ''
		 )X INNER JOIN ( 
				SELECT 
					nvarchar11 NewDesignation,nvarchar10 NewLOB,nvarchar7 NewClient,nvarchar8 NewFunctionality,Fin 
				FROM rptTransaction AS R  
				WHERE R.WorkflowId = @IJPWorkflowId AND R.LogId = 0 AND R.SourceColumn = ''
		)Y 
		ON X.IJPFin = Y.Fin 
	)Z
END
GO
/****** Object:  StoredProcedure [dbo].[uspIJPOpeningMail]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspIJPOpeningMail]
	-- Add the parameters for the stored procedure here
	@ClosureDays INT = 7
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		IF OBJECT_ID('TEMPDB..#TempIJPOpeningMail') IS NOT NULL
		DROP TABLE #TempIJPOpeningMail

	SELECT ROW_NUMBER() OVER(ORDER BY nvarchar6,nvarchar11) RowNo,nvarchar11 Designation,int3 NoOfVacancies
	,DATENAME(dw,DATEADD(DAY,35,CONVERT(DATE,datetime2))) + ' ' + CONVERT(VARCHAR(2),DATEPART(DAY,DATEADD(DAY,35,CONVERT(DATE,datetime2)))) + ', ' + DATENAME(MM,DATEADD(DAY,35,CONVERT(DATE,datetime2))) + ' ' + CONVERT(VARCHAR(4),DATEPART(YEAR,DATEADD(DAY,35,CONVERT(DATE,datetime2)))) LastDateForApplication
	,nvarchar6 Location
	INTO #TempIJPOpeningMail
	FROM rptTransaction AS r WHERE WorkflowId = 502 
	AND DATEADD(DAY,@ClosureDays,CONVERT(DATE,datetime2)) > GETDATE() AND ISNULL(Status,'') != 'Closed'

	DECLARE @Cnt AS INT
	SET @Cnt = 1
	DECLARE @MaxCnt AS INT
	SELECT @MaxCnt = MAX(RowNo) FROM #TempIJPOpeningMail

	WHILE @Cnt <= @MaxCnt
	BEGIN
		SELECT * FROM #TempIJPOpeningMail WHERE RowNo = @Cnt 
		
		SET @Cnt += 1

	END
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertMailInformation]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertMailInformation]        
(  
	@RowId			INT =0,  
	@RequestId		INT =0,
	@FromMailId		VARCHAR(200)=NULL,  
	@Subject		VARCHAR(500)=NULL,  
	@ReceivedDt		datetime=NULL,  
	@FileName		VARCHAR(100)=NULL,  
	@FolderPath		VARCHAR(100)=NULL,  
	@status			TINYINT =0,  
	@MailBody		VARCHAR(MAX)=NULL ,
	@ConversationId VARCHAR(MAX)=NULL ,
	@MessageId		VARCHAR(MAX)=NULL ,
	@WfId			INT,
	@Action			VARCHAR(100),
	@Result			INT		OUTPUT  
)        
AS        
BEGIN   
	/*                    
	PURPOSE           : GETTING MAILS INFORMATION USING SERVICE INTO DB                
	CREATED BY        : PRABAAKARAN T                    
	CREATED DATE      :	05 SEP 2017  
	*/      
	IF(@Action='INSERT')  
		BEGIN  
			INSERT INTO PBW_MailInformation(RequestId,FromMailId,Subject,ReceivedDt,FileName,FolderPath,MailBody,ConversationId,MessageId,WfId)       
			VALUES(@RequestId,@FromMailId,@Subject,@ReceivedDt,@FileName,@FolderPath,@MailBody,@ConversationId,@MessageId,@WfId)   
			SET @Result=0  
		END  
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertPlatformLog]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rameshkumar
-- Create date: January/08/2018
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspInsertPlatformLog]
	-- Add the parameters for the stored procedure here@WorkflowId,
	 @WorkflowId INT,
	 @Fin INT,
	 @LogType VARCHAR(100),
	 @LogMessage VARCHAR(MAX),
	 @LogStackTrace VARCHAR(MAX),
	 @CreatedDate DATETIME,
	 @CreatedBy VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
   INSERT INTO PLog
   (WorkflowId,Fin,LogType,LogMessage,LogStackTrace,CreatedDate,CreatedBy)
   SELECT @WorkflowId,@Fin,@LogType,@LogMessage,@LogStackTrace,@CreatedDate,@CreatedBy
END
 
GO
/****** Object:  StoredProcedure [dbo].[uspInsertPlatformMailTran]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rameshkumar
-- Create date: January/08/2018
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspInsertPlatformMailTran]
	-- Add the parameters for the stored procedure here
	 @WorkflowId INT,
	 @Fin INT,
	 @UserId VARCHAR(100),
	 @FromMailId VARCHAR(256),
	 @ToMailId VARCHAR(MAX),
	 @CC VARCHAR(MAX),
	 @SubjectText VARCHAR(MAX),
     @Body NVARCHAR(max),
     @MailStatus INT,
     @IsHTML bit,
     @AttachmentPath VARCHAR(MAX),
     @CreatedDate DATETIME,
     @CreatedBy VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO PMailTran
	(WorkflowId,Fin,UserId,FromMailId,ToMailIds,CC,SubjectText,Body,MailStatus,IsHTML,AttachmentPath,CreateDate,CreatedBy)
	SELECT @WorkflowId,@Fin,@UserId,@FromMailId,@ToMailId,@CC,@SubjectText,@Body,@MailStatus,@IsHTML,@AttachmentPath,@CreatedDate,@CreatedBy
END

 
GO
/****** Object:  StoredProcedure [dbo].[uspInsertQryReport]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspInsertQryReport] 
	-- Add the parameters for the stored procedure here
	 @QryTable RptQryType READONLY,
	 @WorkflowId INT,
	 @Fin INT,
	 @LogId INT,
	 @IsExpenses INT =0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @strQry AS VARCHAR(MAX)
    -- Insert statements for procedure here
    DECLARE @MaxInsertRw AS INT
	SELECT @MaxInsertRw = MAX(InsertionOrder) FROM @QryTable
	BEGIN TRY
		DECLARE @InsertRw AS INT
		DECLARE @TranRefID AS INT
		DECLARE @IdentityID AS INT
		SET @InsertRw = 1
		IF @LogId =0
		BEGIN
			IF @IsExpenses != 0
			BEGIN
				DELETE FROM rptTransaction WHERE WorkflowId = @WorkflowId AND Fin = @Fin AND LogId = 0 AND SourceColumn = 'djdf_ExpensesDetails'
			END
			ELSE
			BEGIN
				DELETE FROM rptTransaction WHERE WorkflowId = @WorkflowId AND Fin = @Fin AND TranRefID IN (SELECT TranRefID FROM rptTransaction AS T1 WHERE WorkflowId = @WorkflowId AND Fin = @Fin AND LogId = 0 AND SourceColumn != 'djdf_ExpensesDetails')
			END
		END
		WHILE @InsertRw <= @MaxInsertRw 
		BEGIN		
			SELECT @strQry =  Qry  FROM @QryTable WHERE InsertionOrder = @InsertRw
			EXEC(@strQry)		
			SET @IdentityID = @@IDENTITY
			IF @InsertRw = 1
			BEGIN
				SET @TranRefID = @IdentityID
			END
			UPDATE rptTransaction SET TranRefID = @TranRefID,rpt_CreatedDate = GETDATE() WHERE TranID = @IdentityID
			IF @IsExpenses != 0
			BEGIN
				IF @LogId = 0
				BEGIN
					UPDATE PBWWorkFlowExceptionTransaction SET rptTblSyncDate = GETDATE(),rptTranRefId=@TranRefID WHERE WfID = @WorkflowId AND Fin = @Fin
				END
				ELSE
				BEGIN
					UPDATE PBWWorkFlowExceptionTransactionHistory SET rptTblSyncDate = GETDATE(),rptTranRefId=@TranRefID WHERE WfID = @WorkflowId AND Fin = @Fin AND ExceptionTransactionHistoryId = @LogId 
				END
			END
			ELSE
			BEGIN
				IF @LogId = 0
				BEGIN
					UPDATE PBWWorkflowTransaction SET rptTblSyncDate = GETDATE(),rptTranRefId=@TranRefID WHERE WorkflowId = @WorkflowId AND Fin = @Fin
				END
				ELSE
				BEGIN
					UPDATE PBWWorkflowTransactionHistory SET rptTblSyncDate = GETDATE(),rptTranRefId=@TranRefID WHERE WorkflowId = @WorkflowId AND Fin = @Fin AND LogId = @LogId 
				END
			END
			SET @InsertRw = @InsertRw + 1
		END	
	END TRY
	BEGIN CATCH
		PRINT 1
	END CATCH
	SELECT @MaxInsertRw
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertReport]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspInsertReport] 
	-- Add the parameters for the stored procedure here
	 @QryTable RptQryType READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  * FROM @QryTable
END
GO
/****** Object:  StoredProcedure [dbo].[uspiRuleInsertion]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspiRuleInsertion]
(
    @WorkflowId INT,
	@OldRuleSetName VARCHAR(MAX),
	@RuleSetName VARCHAR(MAX),
	@RuleSetPriority INT,
	@OldRuleName VARCHAR(MAX),
	@RuleName VARCHAR(MAX),	
	@RulePriority INT,	
	@Condition VARCHAR(MAX),
	@ThenAction VARCHAR(MAX),
	@ElseAction VARCHAR(MAX)
)
AS
BEGIN
		
	DECLARE @RuleSetId INT
	DECLARE @RuleId INT
	--DELETE FROM PRuleSet WHERE WorkflowId = @WorkflowId
	
	--DELETE FROM PRuleSetMapping WHERE RuleSetId IN (SELECT RuleSetId FROM PRuleSet WHERE WorkflowId = @WorkflowId)
	
	--SELECT * FROM PRuleSet AS RM INNER JOIN PRuleSetMapping AS RSM
	--ON RM.RuleSetId = RSM.RuleSetId 
	--INNER JOIN PRuleMaster AS PRM ON RSM.RuleId = PRM.RULE
	SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE WorkflowId = @WorkflowId AND RuleSetName = @OldRuleSetName
	IF @RuleSetId > 0
	BEGIN
		UPDATE PRuleSet SET RuleSetName = @RuleSetName,Description=@RuleSetName,Priority=@RuleSetPriority WHERE WorkflowId = @WorkflowId AND RuleSetName = @OldRuleSetName		
	END
	ELSE
	BEGIN
		INSERT INTO PRuleSet 
		(RuleSetName,Description,WorkflowId,Priority)
		SELECT @RuleSetName,@RuleSetName,@WorkflowId,@RuleSetPriority
		SET @RuleSetId = @@IDENTITY
	END
		
	SELECT @RuleId = RuleId FROM PRuleMaster WHERE WorkflowId = @WorkflowId AND RuleName = @OldRuleName
	IF @RuleId > 0
	BEGIN
		UPDATE PRuleMaster SET RuleName = @RuleName,Description=@RuleName,Priority = @RulePriority,
		Condition =@Condition,ThenAction=@ThenAction,ElseAction=@ElseAction WHERE WorkflowId = @WorkflowId AND RuleName = @OldRuleName		
	END
	ELSE
	BEGIN
		INSERT INTO PRuleMaster 
		(RuleName,Description,Priority,Condition,ThenAction,ElseAction,WorkflowId)
		SELECT @RuleName,@RuleName,@RulePriority,@Condition,@ThenAction,@ElseAction,@WorkflowId
		SET @RuleId = @@IDENTITY
	END
	
	IF NOT EXISTS(SELECT 1 FROM PRuleSetMapping WHERE RuleSetId = @RuleSetId AND RuleId = @RuleId)
	BEGIN
		INSERT INTO PRuleSetMapping 
		(RuleSetId,RuleId,Version,IsActive,WorkflowId)
		SELECT @RuleSetId,@RuleId,1,1,@WorkflowId
	END
	
	 
	--INSERT INTO iRuleTable
	--(RuleSetName,RuleName,Condition,ThenAction,ElseAction,RuleSetPriority,RulePriority,CreatedOn)
	--SELECT @RuleSetName,@RuleName,@Condition,@ThenAction,@ElseAction,@RuleSetPriority,@RulePriority,GETDATE()
END
GO
/****** Object:  StoredProcedure [dbo].[uspiRuleJSonUpdation]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspiRuleJSonUpdation]
(
    @WorkflowId INT,
	@RuleJSON VARCHAR(MAX)
)
AS
BEGIN
	UPDATE PBWWorkflowMaster SET RuleJSon = @RuleJSON WHERE WorkFlowId = @WorkflowId
	
	DELETE FROM PRuleSetMapping WHERE WorkflowId = @WorkflowId 
END
GO
/****** Object:  StoredProcedure [dbo].[uspRptGetSavingsSummaryDetail]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspRptGetSavingsSummaryDetail]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(MAX) = 'All',	
	@DefaultStatus VARCHAR(MAX) = 'All',	
	@Customer VARCHAR(MAX) = 'All',
	@Functionality VARCHAR(MAX) = 'All',
	@LOB VARCHAR(MAX) = 'All',
	@FromMonth VARCHAR(32),
	@FromYear VARCHAR(32),
	@ToMonth VARCHAR(32),
	@ToYear VARCHAR(32)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 --EXEC uspRptGetSavingsSummaryDetail 'All','All','All','All','All','SDF','SDF','SDF','SDF'
	SET NOCOUNT ON;
	DECLARE @IsSummary BIT= 0
	DECLARE @strSql AS VARCHAR(MAX)
	SET @strSql =''
	IF @IsSummary = 1
	BEGIN
		SET @strSql =' SELECT R.SolutionName
		,SUM(CASE WHEN SavingsMode = ''F'' THEN SavingsILValue END) FlatFTEIL
		,SUM(CASE WHEN SavingsMode = ''F'' THEN SavingsOPSValue END) FlatFTEOPS
		,SUM(CASE WHEN SavingsMode = ''F'' THEN SavingsFINValue END) FlatFTEFIN
		,SUM(CASE WHEN SavingsMode = ''D'' THEN SavingsILValue END) DollarValueIL
		,SUM(CASE WHEN SavingsMode = ''D'' THEN SavingsOPSValue END) DollarValueOPS
		,SUM(CASE WHEN SavingsMode = ''D'' THEN SavingsFINValue END) DollarValueFIN		  
		FROM SavingsFlatSavings AS S INNER JOIN SavingsRPASolutions AS R ON S.SolutionId = R.SolutionId '
	END
	ELSE
	BEGIN
		SET @strSql =' SELECT R.SolutionName,MonthName,YearNo,LOB,Functionality,Customer,Description,Attachments,Status,Type,Title
		,CASE WHEN SavingsMode = ''F'' THEN ''Flat FTE'' ELSE ''Dollar Value'' END SavingsMode
		,SavingsILValue,SavingsOPSValue,SavingsFINValue FROM SavingsFlatSavings AS S INNER JOIN SavingsRPASolutions AS R ON S.SolutionId = R.SolutionId '
	END
	SET @strSql +=' WHERE 1=1'--MonthName = '''+ DATENAME(MONTH,@FromDate) +''' AND 
	--SET @strSql +=' AND Type = '''+ REPLACE(@Type,',','') +''''
	--IF @SolutionName != 'All'
	--BEGIN
	--	SET @strSql +=' AND R.SolutionName = '''+ @SolutionName +'''' 
	--END
	IF @DefaultStatus != 'All'
	BEGIN
		SET @strSql +=' AND Status = '''+ @DefaultStatus +'''' 
	END
	IF @Type != 'All'
	BEGIN
		SET @strSql +=' AND Type = '''+ @Type +'''' 
	END
	IF @Customer != 'All'
	BEGIN
		SET @strSql +=' AND Customer = '''+ @Customer +'''' 
	END
	IF @Functionality != 'All'
	BEGIN
		SET @strSql +=' AND Functionality = '''+ @Functionality +'''' 
	END
	IF @LOB != 'All'
	BEGIN
		SET @strSql +=' AND LOB = '''+ @LOB +'''' 
	END
	IF @IsSummary = 1
	BEGIN
		SET @strSql +=' GROUP BY R.SolutionName'
		PRINT @strSql	
		IF OBJECT_ID('TEMPDB..#TempRptSolutions') IS NOT NULL
			DROP TABLE #TempRptSolutions
		CREATE TABLE #TempRptSolutions
        (SolutionName VARCHAR(200),FlatFTEIL FLOAT,FlatFTEOPS FLOAT,FlatFTEFIN FLOAT,DollarValueIL FLOAT,DollarValueOPS FLOAT,DollarValueFIN FLOAT)
        INSERT INTO #TempRptSolutions	
		EXEC(@strSql)
		
		SELECT SolutionName,' IL' SavingsClaim,FlatFTEIL FlatFTE,DollarValueIL DollarValue,1 SortOrder FROM #TempRptSolutions 
		UNION
		SELECT SolutionName,'OPS' SavingsClaim,FlatFTEOPS FlatFTE,DollarValueOPS DollarValue,2 SortOrder FROM #TempRptSolutions 
		UNION
		SELECT SolutionName,'FIN' SavingsClaim,FlatFTEFIN FlatFTE,FlatFTEFIN DollarValue,3 SortOrder FROM #TempRptSolutions 
		ORDER BY SortOrder,SolutionName
	END
	ELSE
	BEGIN
		PRINT @strSql
		IF OBJECT_ID('TEMPDB..#TempRptSolutions1') IS NOT NULL
			DROP TABLE #TempRptSolutions1
		CREATE TABLE #TempRptSolutions1
        (SolutionName VARCHAR(200),MonthName VARCHAR(200),YearNo VARCHAR(200),LOB VARCHAR(200),Functionality VARCHAR(200),Customer VARCHAR(200),Description VARCHAR(200),Attachments VARCHAR(200),Status VARCHAR(200)
        ,Type VARCHAR(200),Title VARCHAR(200),SavingsMode VARCHAR(200),SavingsILValue FLOAT,SavingsOPSValue FLOAT,SavingsFINValue FLOAT)
        
        INSERT INTO #TempRptSolutions1	
		EXEC(@strSql)
		
		SELECT SolutionName,MonthName,YearNo,LOB,Functionality,Customer,Description,Attachments,Status,Type,Title,' IL' SavingsClaim,SUM(CASE WHEN SavingsMode = 'Flat FTE' THEN SavingsILValue END) FlatFTE,SUM(CASE WHEN SavingsMode != 'Flat FTE' THEN SavingsILValue END) DollarValue,1 SortOrder FROM #TempRptSolutions1 GROUP BY SolutionName,MonthName,YearNo,LOB,Functionality,Customer,Description,Attachments,Status,Type,Title
		UNION
		SELECT SolutionName,MonthName,YearNo,LOB,Functionality,Customer,Description,Attachments,Status,Type,Title,'OPS' SavingsClaim,SUM(CASE WHEN SavingsMode = 'Flat FTE' THEN SavingsOPSValue END) FlatFTE,SUM(CASE WHEN SavingsMode != 'Flat FTE' THEN SavingsOPSValue END) DollarValue,2 SortOrder FROM #TempRptSolutions1 GROUP BY SolutionName,MonthName,YearNo,LOB,Functionality,Customer,Description,Attachments,Status,Type,Title
		UNION
		SELECT SolutionName,MonthName,YearNo,LOB,Functionality,Customer,Description,Attachments,Status,Type,Title,'FIN' SavingsClaim,SUM(CASE WHEN SavingsMode = 'Flat FTE' THEN SavingsFINValue END) FlatFTE,SUM(CASE WHEN SavingsMode != 'Flat FTE' THEN SavingsFINValue END) DollarValue,3 SortOrder FROM #TempRptSolutions1 GROUP BY SolutionName,MonthName,YearNo,LOB,Functionality,Customer,Description,Attachments,Status,Type,Title
		ORDER BY SortOrder,SolutionName
	END
    -- Insert statements for procedure here
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspRptIJPCandidateRequested]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspRptIJPCandidateRequested]
	-- Add the parameters for the stored procedure here
	@WorkflowIJPId INT,
	@WorkflowIJPCandidateId INT,
	@UserId VARCHAR(256)='',
	@FromDate DATETIME,
	@ToDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
    
	
    IF ISNULL(@UserId,'') = ''
    BEGIN
		IF OBJECT_ID('TEMPDB..#TempIJP') IS NOT NULL
			DROP TABLE #TempIJP
		IF OBJECT_ID('TEMPDB..#TempIJPCandidate') IS NOT NULL
			DROP TABLE #TempIJPCandidate
		SELECT RequestId IJPNo,Fin IJPID,EmpCode,ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') EmpName,
		int3 NoOfPositions,nvarchar11 ReqDesignation,D.Band,D.Grade,nvarchar10 LOB,nvarchar7 Client,nvarchar8 Functionality,
		nvarchar6 Location,convert(varchar(20),T.CreatedDate,120) ReqDate,CASE WHEN T.WorkFlowStateId = -14 THEN convert(varchar(20),nvarchar17,120) END ApprovedOn,
		CASE WHEN CONVERT(DATE, datetime3) = '1900-01-01'  THEN '' else convert(varchar(20),datetime3,120) END IJPCloseDate,
		CASE WHEN T.Status = 'Closed' THEN 'Closed' ELSE 'Opened' END IJPStatus,
		convert(varchar(10),datetime1,126) ExpClosureDate
		INTO #TempIJP 
		FROM rptTransaction AS T INNER JOIN PBWUserMaster AS U ON T.UserId = U.UniqueId
		INNER JOIN PBWUserDesignation AS D ON T.nvarchar11 = D.RoleName     
		WHERE T.WorkflowId =@WorkflowIJPId AND T.LogId = 0
		AND CONVERT(DATE,T.CreatedDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
		ORDER BY RequestId 

		SELECT Fin IJPCandidateFIN, int3 IJPID,nvarchar12 PanelMember,convert(varchar(10),datetime3,126) InterviewSchduledDate,EmpCode,ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') EmpName
		,nvarchar22 PrevDesignation,nvarchar23 PrevSupervisor
		,(SELECT ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') FROM PBWUserMaster AS I WHERE I.UniqueId = U.SupervisorId) NewSupervisor
		,CASE WHEN datetime4 != '1900-01-01 00:00:00.000' THEN convert(varchar(10),datetime4,126) END SupervisorReleaseDate,CASE WHEN datetime5 != '1900-01-01 00:00:00.000' THEN convert(varchar(10),datetime5,126) END HRBPReleaseDate,nvarchar15 OverallScore
		INTO #TempIJPCandidate
		FROM rptTransaction AS T INNER JOIN PBWUserMaster AS U ON T.UserId = U.UniqueId
		WHERE WorkflowId = @WorkflowIJPCandidateId AND T.LogId =0 

		SELECT * FROM #TempIJP AS X 
		LEFT OUTER JOIN #TempIJPCandidate AS Y ON X.IJPID = Y.IJPID
	END
	ELSE
	BEGIN
		IF OBJECT_ID('TEMPDB..#TempIJP1') IS NOT NULL
			DROP TABLE #TempIJP1
		IF OBJECT_ID('TEMPDB..#TempIJPCandidate1') IS NOT NULL
			DROP TABLE #TempIJPCandidate1
		SELECT RequestId IJPNo,Fin IJPID,EmpCode,ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') EmpName,
		int3 NoOfPositions,nvarchar11 ReqDesignation,D.Band,D.Grade,nvarchar10 LOB,nvarchar7 Client,nvarchar8 Functionality,
		nvarchar6 Location,convert(varchar(20),T.CreatedDate,120) ReqDate,CASE WHEN T.WorkFlowStateId = -14 THEN convert(varchar(20),nvarchar17,120) END ApprovedOn,
		CASE WHEN CONVERT(DATE, datetime3) = '1900-01-01'  THEN '' else convert(varchar(20),datetime3,120) END IJPCloseDate,CASE WHEN T.Status = 'Closed' THEN 'Closed' ELSE 'Opened' END IJPStatus,
		convert(varchar(10),datetime1,126) ExpClosureDate
		INTO #TempIJP1
		FROM rptTransaction AS T INNER JOIN PBWUserMaster AS U ON T.UserId = U.UniqueId
		INNER JOIN PBWUserDesignation AS D ON T.nvarchar11 = D.RoleName     
		WHERE T.WorkflowId =@WorkflowIJPId AND T.LogId = 0
		AND CONVERT(DATE,T.CreatedDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
		AND T.UserId = @UserId
		ORDER BY RequestId 

		SELECT Fin IJPCandidateFIN,int3 IJPID,nvarchar12 PanelMember,convert(varchar(10),datetime3,126) InterviewSchduledDate,EmpCode,ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') EmpName
		,nvarchar22 PrevDesignation,nvarchar23 PrevSupervisor
		,(SELECT ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') FROM PBWUserMaster AS I WHERE I.UniqueId = U.SupervisorId) NewSupervisor
		,CASE WHEN datetime4 != '1900-01-01 00:00:00.000' THEN convert(varchar(10),datetime4,126) END SupervisorReleaseDate,CASE WHEN datetime5 != '1900-01-01 00:00:00.000' THEN convert(varchar(10),datetime5,126) END HRBPReleaseDate,nvarchar15 OverallScore
		INTO #TempIJPCandidate1
		FROM rptTransaction AS T INNER JOIN PBWUserMaster AS U ON T.UserId = U.UniqueId
		WHERE WorkflowId = @WorkflowIJPCandidateId AND T.LogId =0 

		SELECT * FROM #TempIJP1 AS X 
		INNER JOIN #TempIJPCandidate1 AS Y ON X.IJPID = Y.IJPID
	END
 
END


GO
/****** Object:  StoredProcedure [dbo].[uspRptIJPFinance]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspRptIJPFinance]
	-- Add the parameters for the stored procedure here
	@WorkflowIJPId INT,
	@WorkflowIJPCandidateId INT,
	@FromDate DATETIME,
	@ToDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- EXEC uspRptIJPFinance 502,11 ,'2018-02-13','2018-02-13'
    -- Insert statements for procedure here
    
    IF OBJECT_ID('TEMPDB..#TempIJPFinance') IS NOT NULL
       DROP TABLE #TempFindRules
    IF OBJECT_ID('TEMPDB..#TempIJPFinance1') IS NOT NULL
       DROP TABLE #TempFindRules1 
		
	 SELECT 
		T.RequestId IJPNo,Fin IJPId,EmpCode ReqEmpCode,ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') ReqEmpName,
		int3 NoOfPositions,nvarchar11 ReqDesignation,D.Band,D.Grade,nvarchar10 LOB,nvarchar7 Client,nvarchar8 Functionality,
		nvarchar6 Location,FLApprovedBy,FLApprovedComments,convert(varchar(20),FLApprovedDate,120) [FLApprovedDate]
		,convert(varchar(20),T.CreatedDate,120) RaisedOn,CASE WHEN datetime3 != '1900-01-01 00:00:00.000' THEN convert(varchar(20),datetime3,120) END IJPClosedDate
	INTO #TempIJPFinance
	FROM rptTransaction AS T INNER JOIN PBWUserMaster AS U ON T.UserId = U.UniqueId
	INNER JOIN PBWUserDesignation AS D ON T.nvarchar11 = D.RoleName  
	LEFT OUTER JOIN (
	SELECT nvarchar15 FLApprovedBy,nvarchar16 FLApprovedComments,nvarchar17 FLApprovedDate,RequestId FROM rptTransaction
	WHERE WorkflowId =@WorkflowIJPId AND SourceColumn = '' AND RoleId = 30 AND WorkFlowStateId = -5 AND nvarchar16 = 'approved'
	)X  ON T.RequestId = X.RequestId 
	WHERE T.WorkflowId =@WorkflowIJPId AND T.LogId = 0

	SELECT 
		 DISTINCT Fin IJPCandidateFIN,int3 IJPID,EmpCode CandidateEmpCode,ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') CandidateEmpName
		,nvarchar22 PrevDesignation 
		,CASE WHEN datetime5 != '1900-01-01 00:00:00.000' THEN convert(varchar(10),datetime5,126) END HRBPReleaseDate
		,(SELECT TOP 1 nvarchar6 FROM rptTransaction AS I WHERE I.WorkflowId = T.WorkflowId AND I.FIN = T.FIN AND I.int3 = T.int3 AND I.WorkflowStateId = -21 AND SourceColumn = '' ORDER BY I.LogId DESC) HRBPSpoc 
	INTO #TempIJPFinance1
	FROM rptTransaction AS T INNER JOIN PBWUserMaster AS U ON T.UserId = U.UniqueId
	WHERE WorkflowId =@WorkflowIJPCandidateId AND SourceColumn = '' AND Fin IN (SELECT DISTINCT FIN FROM rptTransaction WHERE WorkflowId =@WorkflowIJPCandidateId AND SourceColumn = '' AND nvarchar18 = 'Select')
	
	SELECT T.IJPID,T1.IJPCandidateFIN,IJPNo,ReqEmpCode,ReqEmpName,NoOfPositions,ReqDesignation,Band,Grade,LOB,Client,Functionality,Location,FLApprovedBy,FLApprovedComments,FLApprovedDate,RaisedOn,IJPClosedDate
	,CandidateEmpCode,CandidateEmpName,PrevDesignation,HRBPReleaseDate,HRBPSpoc
	FROM #TempIJPFinance AS T LEFT OUTER JOIN #TempIJPFinance1 AS T1 ON T.IJPID = T1.IJPID
	WHERE CONVERT(DATE,FLApprovedDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[uspRptIJPRequested]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspRptIJPRequested]
	-- Add the parameters for the stored procedure here
	@WorkflowIJPId INT,
	@WorkflowIJPCandidateId INT,
	@UserId VARCHAR(256)='',
	@FromDate DATETIME,
	@ToDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF ISNULL(@UserId,'') = ''
    BEGIN
		IF OBJECT_ID('TEMPDB..#TempIJP') IS NOT NULL
			DROP TABLE #TempIJP
		IF OBJECT_ID('TEMPDB..#TempIJPCandidate') IS NOT NULL
			DROP TABLE #TempIJPCandidate
		SELECT RequestId IJPNo,Fin IJPID,EmpCode,ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') EmpName,
		int3 NoOfPositions,nvarchar11 ReqDesignation,D.Band,D.Grade,nvarchar10 LOB,nvarchar7 Client,nvarchar8 Functionality,
		nvarchar6 Location,convert(varchar(20),T.CreatedDate,120) ReqDate,CASE WHEN T.WorkFlowStateId = -14 THEN convert(varchar(20),nvarchar17,120) END ApprovedOn,
		CASE WHEN CONVERT(DATE, datetime3) = '1900-01-01'  THEN '' else convert(varchar(20),datetime3,120) END IJPCloseDate,
		CASE WHEN T.Status = 'Closed' THEN 'Closed' ELSE 'Opened' END IJPStatus,
		convert(varchar(10),datetime1,126) ExpClosureDate
		INTO #TempIJP 
		FROM rptTransaction AS T INNER JOIN PBWUserMaster AS U ON T.UserId = U.UniqueId
		INNER JOIN PBWUserDesignation AS D ON T.nvarchar11 = D.RoleName     
		WHERE T.WorkflowId =@WorkflowIJPId AND T.LogId = 0
		AND CONVERT(DATE,T.CreatedDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
		ORDER BY RequestId 
	  
		SELECT int3 IJPID,SUM(1) AppliedCnt,SUM(CASE WHEN UPPER(nvarchar18)='SELECTED' THEN 1 END) SelectedCnt 
		INTO #TempIJPCandidate
		FROM rptTransaction AS T WHERE WorkflowId = @WorkflowIJPCandidateId AND T.LogId =0
		GROUP BY int3

		SELECT X.*,Y.AppliedCnt,Y.SelectedCnt FROM #TempIJP AS X 
		LEFT OUTER JOIN #TempIJPCandidate AS Y ON X.IJPID = Y.IJPID
	END
	ELSE
	BEGIN
		IF OBJECT_ID('TEMPDB..#TempIJP1') IS NOT NULL
			DROP TABLE #TempIJP
		IF OBJECT_ID('TEMPDB..#TempIJPCandidate1') IS NOT NULL
			DROP TABLE #TempIJPCandidate
		SELECT RequestId IJPNo,Fin IJPID,EmpCode,ISNULL(FirstName,'') + ' ' + ISNULL(LastName,'') EmpName,
		int3 NoOfPositions,nvarchar11 ReqDesignation,D.Band,D.Grade,nvarchar10 LOB,nvarchar7 Client,nvarchar8 Functionality,
		nvarchar6 Location,convert(varchar(20),T.CreatedDate,120) ReqDate,CASE WHEN T.WorkFlowStateId = -14 THEN convert(varchar(20),nvarchar17,120) END ApprovedOn,
		CASE WHEN CONVERT(DATE, datetime3) = '1900-01-01'  THEN '' else convert(varchar(20),datetime3,120) END IJPCloseDate,
		CASE WHEN T.Status = 'Closed' THEN 'Closed' ELSE 'Opened' END IJPStatus,
		convert(varchar(10),datetime1,126) ExpClosureDate
		INTO #TempIJP1 
		FROM rptTransaction AS T INNER JOIN PBWUserMaster AS U ON T.UserId = U.UniqueId
		INNER JOIN PBWUserDesignation AS D ON T.nvarchar11 = D.RoleName     
		WHERE T.WorkflowId =@WorkflowIJPId AND T.LogId = 0
		AND CONVERT(DATE,T.CreatedDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
		AND T.UserId = @UserId
		ORDER BY RequestId 
	  
		SELECT int3 IJPID,SUM(1) AppliedCnt,SUM(CASE WHEN UPPER(nvarchar18)='SELECTED' THEN 1 END) SelectedCnt 
		INTO #TempIJPCandidate1
		FROM rptTransaction AS T WHERE WorkflowId = @WorkflowIJPCandidateId AND T.LogId =0
		GROUP BY int3

		SELECT X.*,Y.AppliedCnt,Y.SelectedCnt FROM #TempIJP1 AS X 
		LEFT OUTER JOIN #TempIJPCandidate1 AS Y ON X.IJPID = Y.IJPID
	END
 
END




GO
/****** Object:  StoredProcedure [dbo].[uspSaveAddInventory]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspSaveAddInventory]  
 -- Add the parameters for the stored procedure here   
 @SolutionName VARCHAR(100),
 @StartTime DATETIME,
 @EndTime DATETIME,
 @TicketNo VARCHAR(100),
 @CreatedDate DATETIME,
 @CreatedBy VARCHAR(100)  
AS   
-- EXEC uspGetMasterData 502,'LOB',1
BEGIN 
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELPBWMasterDataECT statements.  
 SET NOCOUNT ON; 
 
 DECLARE @InventoryId UNIQUEIDENTIFIER
 SET @InventoryId = NEWID()
 
 DECLARE @SolutionId AS UNIQUEIDENTIFIER
 SELECT @SolutionId = SolutionId FROM SavingsRPASolutions WHERE SolutionName = @SolutionName
 INSERT INTO SavingsAddInventory
 (InventoryId,SolutionId,StartTime,EndTime,TicketNo,CreatedDate,CreatedBy)
 SELECT @InventoryId,@SolutionId,@StartTime,@EndTime,@TicketNo,@CreatedDate,@CreatedBy
 
 SELECT @InventoryId
 
END  


 
  
  

GO
/****** Object:  StoredProcedure [dbo].[uspSaveAhsPlatformTATDetails]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  SIVASANKAR S      
-- Create date: JAN/04/2018      
-- Description: INSERT TATDETAILS Value      
-- =============================================      
CREATE PROCEDURE  [dbo].[uspSaveAhsPlatformTATDetails]      
 -- Add the parameters for the stored procedure here       
 @WorkflowId INT,    
 @RoleID VARCHAR(MAX),    
 @FinId INT = 0,    
 @EmailToUniqueId VARCHAR(MAX)
AS      
BEGIN      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 -- interfering with SELECT statements.      
 SET NOCOUNT ON;
 
 INSERT INTO dbo.PBWWorkflowTATDetails (WorkflowId,FIN,RoleId,EmailToUniqueId,CreatedBy,CreatedDate)  
 values (@WorkflowId,@FinId,@RoleID,'','',GETDATE())      
		
 End
 
 
GO
/****** Object:  StoredProcedure [dbo].[uspSaveAhsPlatformWorkflowTransaction]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  RAMESHKUMAR      
-- Create date: Jun/06/2017      
-- Description: GetJSON Value      
-- =============================================      
CREATE PROCEDURE  [dbo].[uspSaveAhsPlatformWorkflowTransaction]      
 -- Add the parameters for the stored procedure here       
 @WorkflowId INT,    
 @UserId VARCHAR(MAX),    
 @DataJson VARCHAR(MAX),      
 @FinId INT = 0,    
 @Status VARCHAR(32) = 'Pending', 
 @OutFinId INT OUTPUT    
AS      
-- EXEC uspSaveAhsPlatformWorkflowTransaction 1,'rameshkumar.r1','',0,'Pending'      
BEGIN      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 -- interfering with SELECT statements.      
 SET NOCOUNT ON;
	
	DECLARE @RequestId BIGINT
	SET @RequestId = 0
	--IF(ISNULL(@FinId, 0) <> 0 AND EXISTS(SELECT TOP 1 RequestId FROM  dbo.PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId ) )
	--BEGIN
	--	SELECT @RequestId = ISNULL(MAX(RequestId), 0) + 1 FROM  dbo.PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND Fin = @FinId
	--END     
	--ELSE IF NOT EXISTS(SELECT TOP 1 RequestId FROM  dbo.PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId )
	--BEGIN
	--	SET @RequestId = 1
	--END
	--ELSE IF EXISTS(SELECT TOP 1 RequestId FROM  dbo.PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId ) 
	--BEGIN 
	--	SELECT @RequestId = ISNULL(MAX(RequestId), 0) + 1 FROM  dbo.PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId
	--END 
	
	----SET @DataJson = REPLACE(@DataJson,'.00','')
	IF NOT EXISTS(SELECT 1 FROM PBWWorkflowTransaction WHERE Fin = @FinId)    
	BEGIN
		SELECT @RequestId = MAX(RequestId) + 1 FROM  dbo.PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId  
		SET @RequestId = ISNULL(@RequestId,1)
		
		DECLARE @WorkflowVersion AS VARCHAR(100)
		DECLARE @WorkflowSubVersion AS VARCHAR(100)
		SET @WorkflowVersion = '1'
		SET @WorkflowSubVersion = '0'
		SELECT @WorkflowVersion =  Version, @WorkflowSubVersion =  SubVersion  FROM PBWWorkFlowMaster WHERE WorkflowId = 2 AND Active = 1   
	    
		INSERT INTO   dbo.PBWWorkflowTransaction  
		(WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId,WorkflowVersion,WorkflowSubVersion,rptTranRefId)        
		SELECT @WorkflowId,@DataJson,0 WorkFlowStateId,0 RoleId,@Status Status,@UserId,@UserId CreatedBy,GETDATE() CreatedDate,@UserId LastModifiedBy, GETDATE() LastModifiedDate,@RequestId ,@WorkflowVersion,@WorkflowSubVersion,0
	END    
	ELSE    
	BEGIN      
		INSERT INTO dbo.PBWWorkflowTransactionHistory    
		(Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId,WorkflowVersion,WorkflowSubVersion,rptTranRefId)    
		SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId,WorkflowVersion,WorkflowSubVersion,0 FROM dbo.PBWWorkflowTransaction WHERE Fin = @FinId      

		UPDATE dbo.PBWWorkflowTransaction SET WorkflowId = @WorkflowId,DataJson = @DataJson,Status = @Status ,UserId = @UserId,LastModifiedBy = @UserId,LastModifiedDate = GETDATE(),rptTranRefId=0 WHERE Fin = @FinId        
	END    
	SET @OutFinId = @@IDENTITY     
END   

GO
/****** Object:  StoredProcedure [dbo].[uspSaveCityTier]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspSaveCityTier]
	@CityIds	VARCHAR(MAX),	
	@Tier		INT
AS
BEGIN
	/*
	CREATED BY		: PRABAAKARAN T
	CREATED DT		: 2017-11-23
	PURPOSE			: AR TEST PROCESS
	TICKET/SCR NO	: SCR - 1422
	*/
	
	/*
		EXEC uspSaveCityTier @CityIds = '1,2,3,4',@Tier = 1
	*/
	
	SET NOCOUNT ON
	
	UPDATE PBWCities SET Tier = @Tier WHERE CityId IN ( SELECT items FROM dbo.fnSplitString(@CityIds,','))
	
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[uspSaveDocument]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspSaveDocument]  
 -- Add the parameters for the stored procedure here  
 @FileId INT = 0,
 @WfId INT,
 @FileName VARCHAR(MAX),
 @Description VARCHAR(MAX),
 @FilePath VARCHAR(MAX),
 @UserId VARCHAR(MAX),
 @DocCategory		VARCHAR(50) = 'PolicyDocument',
 @SaveOrUpdate INT,
 @ResponseMessage VARCHAR(MAX) OUTPUT,
 @ResponseStatus INT OUTPUT
AS   
-- EXEC uspSavePerDim 
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  

 SET NOCOUNT ON;    

	IF @SaveOrUpdate = 1 
	BEGIN
		IF EXISTS(SELECT * FROM PBWDocuments WHERE [FileName] = @FileName AND [FilePath] = @FilePath)
		BEGIN
			SET @ResponseMessage = 'Condition Alreay Matched.'
			SET @ResponseStatus = 0
		END
		ELSE 
		BEGIN
			INSERT INTO PBWDocuments
			([FileName],Description,FilePath,WfId,CreatedBy,CreatedDate,DocCategory)
			SELECT @FileName,@Description,@FilePath,@WfId,@UserId,GETDATE(),@DocCategory
			
			SET @ResponseStatus = 1
		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM PBWDocuments WHERE FileId = @FileId AND WfId = @WfId)
		BEGIN
			UPDATE PBWDocuments SET [FileName] = @FileName,FilePath=@FilePath,Description=@Description WHERE FileId = @FileId AND WfId = @WfId
			SET @ResponseStatus = 1
		END
		ELSE 
		BEGIN			
			SET @ResponseMessage = 'Condition Not Matched.'
			SET @ResponseStatus = 0
		END
	END

END  

 


GO
/****** Object:  StoredProcedure [dbo].[uspSaveExceptionTransaction]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspSaveExceptionTransaction]  
 -- Add the parameters for the stored procedure here  
  @ExceptionId INT,
  @FIN INT,
  @WfID INT,
  @ExceptionJson VARCHAR(MAX),
  @UserId VARCHAR(MAX)
AS   
-- EXEC [uspGetPerDiem] 'Domestic','Flight','Prabaakaran.t'
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
	INSERT INTO PBWWorkFlowExceptionTransactionHistory
	(ExceptionTransactionId,ExceptionId,FIN,WfID,ExceptionJson,CreatedBy,CreatedDate,HCreatedBy,HCreatedDate)
	SELECT ExceptionTransactionId,ExceptionId,FIN,WfID,ExceptionJson,CreatedBy,CreatedDate,@UserId,GETDATE() FROM PBWWorkFlowExceptionTransaction WHERE WfID = @WfID AND FIN = @FIN
	
	DELETE FROM PBWWorkFlowExceptionTransaction WHERE WfID = @WfID AND FIN = @FIN
	
	INSERT INTO PBWWorkFlowExceptionTransaction
	(ExceptionId,FIN,WfID,ExceptionJson,CreatedBy,CreatedDate)	
	 VALUES(@ExceptionId,@FIN,@WfID,@ExceptionJson,@UserId,GETDATE())
END 

GO
/****** Object:  StoredProcedure [dbo].[uspSaveFlatSavings]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspSaveFlatSavings]  
 -- Add the parameters for the stored procedure here   
 @FTECostId UNIQUEIDENTIFIER,
 @SolutionName VARCHAR(100),
 @MonthName VARCHAR(100),
 @YearNo VARCHAR(32),
 @Status VARCHAR(100),
 @LOB VARCHAR(100),
 @Functionality VARCHAR(100),
 @Customer VARCHAR(100),
 @Description VARCHAR(MAX),
 @Attachments VARCHAR(1000),
 @CreatedDate DATETIME,
 @CreatedBy VARCHAR(100),
 @Type VARCHAR(100),
 @SavingsMode VARCHAR(1),
 @Title VARCHAR(MAX),
 @SavingsILValue FLOAT ,
 @SavingsOPSValue FLOAT ,
 @SavingsFINValue FLOAT ,
 @ErrorMessage VARCHAR(1000) OUTPUT,
 @ReturnFTECostId UNIQUEIDENTIFIER OUTPUT
AS   
-- EXEC uspGetMasterData 502,'LOB',1
BEGIN 
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELPBWMasterDataECT statements.  
 SET NOCOUNT ON;  
 	BEGIN TRY
		SET @ReturnFTECostId = @FTECostId
		SET @ErrorMessage = ''
		--DECLARE @SolutionId AS UNIQUEIDENTIFIER
		--SELECT @SolutionId = SolutionId FROM SavingsRPASolutions WHERE SolutionName = @SolutionName
		IF @FTECostId != CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER)
		BEGIN
			IF EXISTS(SELECT 1 FROM SavingsFlatSavings WHERE SolutionId = @SolutionName AND Type = @Type AND Customer = @Customer 
			AND Functionality = @Functionality AND LOB = @LOB AND MonthName=@MonthName AND YearNo=@YearNo AND FTECostId != @FTECostId)
			BEGIN
				SET @ErrorMessage = 'This Combination of Data already exists, So It will make Duplicate...'
			END
			ELSE
			BEGIN
				UPDATE SavingsFlatSavings SET MonthName=@MonthName,YearNo=@YearNo,LOB=@LOB,Functionality=@Functionality,
				Customer=@Customer,Description=@Description,Attachments=@Attachments + CONVERT(VARCHAR(100),@FTECostId),ModifiedDate=@CreatedDate,SavingsILValue=@SavingsILValue,SavingsOPSValue=@SavingsOPSValue,SavingsFINValue=@SavingsFINValue WHERE FTECostId = @FTECostId	
			END
		END
		ELSE
		BEGIN
			IF EXISTS(SELECT 1 FROM SavingsFlatSavings WHERE SolutionId = @SolutionName AND Type = @Type AND Customer = @Customer 
				AND Functionality = @Functionality AND LOB = @LOB AND MonthName=@MonthName AND YearNo=@YearNo)
			BEGIN
				SET @ErrorMessage = 'This Combination of Data already exists, So It will make Duplicate...'
			END
			ELSE
			BEGIN
				SET @ReturnFTECostId = NEWID()
				INSERT INTO SavingsFlatSavings
				(FTECostId,SolutionId,MonthName,YearNo,LOB,Functionality,Customer,Description,Attachments,CreatedDate,Status,Type,SavingsMode,Title,SavingsILValue,SavingsOPSValue,SavingsFINValue)
				SELECT @ReturnFTECostId,@SolutionName,@MonthName,@YearNo,@LOB,@Functionality,@Customer,@Description,@Attachments + CONVERT(VARCHAR(100),@ReturnFTECostId),@CreatedDate,@Status,@Type,@SavingsMode,@Title,@SavingsILValue,@SavingsOPSValue,@SavingsFINValue
			END
		END
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE();
	END CATCH
END  
 


 

 
  

GO
/****** Object:  StoredProcedure [dbo].[uspSaveJDComments]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---- =============================================  
---- Author:  RAMESHKUMAR  
---- Create date: Jan/06/2018 
---- Description: GetJSON Value  
---- =============================================  
CREATE PROCEDURE  [dbo].[uspSaveJDComments]  
 -- Add the parameters for the stored procedure here  
 @Functionality VARCHAR(256), 
 @Designation VARCHAR(256),
 @LOB VARCHAR(256),
 @JDComments VARCHAR(MAX),  
 @RuleId INT = 0, 
 @IsActive BIT =1,
 @SaveOrUpdate INT, -- 1 - SAVE, 2 - UPDATE, 3 -- ACTIVE OR INACTIVE 
 @ResponseMessage VARCHAR(2000) OUTPUT,
 @ResponseStatus BIT = 0 OUTPUT 
AS   
--DECLARE  @ResponseMessage VARCHAR(MAX), @ResponseStatus BIT = 0  
--EXEC uspSaveJDComments 'Operation - SharedTIN','Assistant Incident Manager','Coding','<p>hfgh</p>',0,1,1,@ResponseMessage OUTPUT,@ResponseStatus OUTPUT
--PRINT @ResponseMessage
--PRINT @ResponseStatus
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;   
 
 
 
--Declare 
-- @Functionality VARCHAR(256)='Operation - SharedTIN', 
-- @Designation VARCHAR(256)='Assistant Incident Manager',
-- @LOB VARCHAR(256)='Coding',
-- @JDComments VARCHAR(MAX)='<p>hdfth</p>',  
-- @RuleId INT = 1, 
-- @IsActive BIT =1,
-- @SaveOrUpdate INT=1 ,-- 1 - SAVE, 2 - UPDATE, 3 -- ACTIVE OR INACTIVE 
--  @ResponseMessage VARCHAR(MAX) ,
-- @ResponseStatus BIT = 0 
 
 
 DECLARE @RuleSetId INT
 SET @RuleSetId = 0
 SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE RuleSetName = 'IJPJDComments'
 IF @RuleSetId > 0
 BEGIN
	IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL
	DROP TABLE #TempFindRules
	;WITH FindRules
	AS
	(
		SELECT R.* FROM dbo.PRuleSetMapping AS RSM
		INNER JOIN dbo.PRuleMaster AS R  
		ON RSM.RuleId = R.RuleId 
		WHERE RSM.RuleSetId = @RuleSetId
		AND RSM.IsActive =1
	)
	SELECT *
	,dbo.Split_PerDiem(Condition,'~','=','Functionality') Functionality	
	,dbo.Split_PerDiem(Condition,'~','=','Designation') Designation
	,dbo.Split_PerDiem(Condition,'~','=','LOB') LOB
	,ThenAction JDComments
	INTO #TempFindRules FROM FindRules 

	IF @SaveOrUpdate = 1 
	BEGIN
		IF EXISTS(SELECT * FROM #TempFindRules WHERE Functionality = @Functionality AND Designation = @Designation AND LOB = @LOB)
		BEGIN
			--SET @ResponseMessage = 'Condition Alreay Matched.'
			SET @ResponseMessage = '1'
			SET @ResponseStatus = 0
		END
		ELSE 
		BEGIN
			INSERT INTO PRuleMaster
			(RuleName,Description,Condition,ThenAction)
			SELECT 'IJPJDComments Rule','IJPJDComments Rule1'
			,'Functionality="'+ @Functionality +'"~Designation="'+ @Designation +'"~LOB="'+ @LOB +'"'
			,@JDComments
			INSERT INTO PRuleSetMapping
			(RuleSetId,RuleId,Version,IsActive)
			SELECT @RuleSetId,@@IDENTITY,1,1
			SET @ResponseStatus = 1
		END
	END
	ELSE IF @SaveOrUpdate = 2
	BEGIN
		IF EXISTS(SELECT * FROM #TempFindRules WHERE RuleId = @RuleId)
		BEGIN			
			UPDATE P SET ThenAction = @JDComments
			FROM PRuleMaster AS P INNER JOIN #TempFindRules AS T ON P.RuleId = T.RuleId
			WHERE T.RuleId = @RuleId
			SET @ResponseStatus = 1
		END
		ELSE 
		BEGIN			
			--SET @ResponseMessage = 'Condition Not Matched.'
			SET @ResponseMessage = '2'
			SET @ResponseStatus = 0
		END
	END	
	ELSE IF @SaveOrUpdate = 3
	BEGIN
		IF EXISTS(SELECT * FROM #TempFindRules WHERE RuleId = @RuleId)
		BEGIN			
			UPDATE P SET IsActive = 0
			FROM PRuleSetMapping AS P INNER JOIN #TempFindRules AS T ON P.RuleId = T.RuleId
			WHERE T.RuleId = @RuleId
			SET @ResponseStatus = 1
		END
		ELSE 
		BEGIN			
			SET @ResponseMessage = '2'
			--SET @ResponseMessage = 'Condition Not Matched.'
			SET @ResponseStatus = 0
		END
	END	
 END
 ELSE
 BEGIN
	SET @ResponseMessage = '3'
	--SET @ResponseMessage = 'JD Comments Not Configured.'
	SET @ResponseStatus = 0
 END 
END  


 
GO
/****** Object:  StoredProcedure [dbo].[uspSaveMicroServiceRegistry]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspSaveMicroServiceRegistry]  
 -- Add the parameters for the stored procedure here   
 @RegisterId uniqueidentifier,
 @SolutionName VARCHAR(100),
 @TranROI INT,
 @TranROIMode VARCHAR(32),
 @Status VARCHAR(100),
 @LOB VARCHAR(100),
 @Functionality VARCHAR(100),
 @Customer VARCHAR(100),
 @Description VARCHAR(MAX),
 @Attachments VARCHAR(1000),
 @MicroServiceEffort VARCHAR(100),
 @Title VARCHAR(1000),
 @CreatedDate DATETIME,
 @CreatedBy VARCHAR(100),
 @ErrorMessage VARCHAR(1000) OUTPUT,
 @ReturnRegisterId UNIQUEIDENTIFIER OUTPUT
AS   
-- EXEC uspGetMasterData 502,'LOB',1
BEGIN 
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELPBWMasterDataECT statements.  
 SET NOCOUNT ON; 	
 BEGIN TRY
	SET @ReturnRegisterId = @RegisterId
    SET @ErrorMessage = ''
 --   DECLARE @SolutionId AS UNIQUEIDENTIFIER
	--SELECT @SolutionId = SolutionId FROM SavingsRPASolutions WHERE SolutionName = @SolutionName
	IF @RegisterId != CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER)
	BEGIN
		IF EXISTS(SELECT 1 FROM SavingsMicrosServiceRegistry WHERE SolutionId = @SolutionName AND MicroServiceEffort = @MicroServiceEffort AND Customer = @Customer 
			AND Functionality = @Functionality AND LOB = @LOB AND RegisterId != @RegisterId)
		BEGIN
			SET @ErrorMessage = 'This Combination of Data already exists, So It will make Duplicate...'
		END
		ELSE
		BEGIN
			UPDATE SavingsMicrosServiceRegistry SET SolutionId=@SolutionName,TranROI=@TranROI,TranROIMode=@TranROIMode,Status=@Status,LOB=@LOB,Functionality=@Functionality,
			Customer=@Customer,Description=@Description,Attachments=@Attachments+ CONVERT(VARCHAR(100),@RegisterId),MicroServiceEffort=@MicroServiceEffort,Title=@Title,ModifiedDate=@CreatedDate WHERE RegisterId = @RegisterId
		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT 1 FROM SavingsMicrosServiceRegistry WHERE SolutionId = @SolutionName AND MicroServiceEffort = @MicroServiceEffort AND Customer = @Customer 
			AND Functionality = @Functionality AND LOB = @LOB)
		BEGIN
			SET @ErrorMessage = 'This Combination of Data already exists, So It will make Duplicate...'
		END
		ELSE
		BEGIN
			SET @ReturnRegisterId = NEWID()
			INSERT INTO SavingsMicrosServiceRegistry
			(RegisterId,SolutionId,TranROI,TranROIMode,Status,LOB,Functionality,Customer,Description,Attachments,MicroServiceEffort,Title,CreatedDate)
			SELECT @ReturnRegisterId,@SolutionName,@TranROI,@TranROIMode,@Status,@LOB,@Functionality,@Customer,@Description,@Attachments + CONVERT(VARCHAR(100),@ReturnRegisterId),@MicroServiceEffort,@Title,@CreatedDate
		END
		
	END
 END TRY
 BEGIN CATCH
	SET @ErrorMessage = ERROR_MESSAGE();
 END CATCH
	--SELECT @ReturnRegisterId
END  


 
 
  

GO
/****** Object:  StoredProcedure [dbo].[uspSavePerDiem]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspSavePerDiem]  
 -- Add the parameters for the stored procedure here  
 @TravelType VARCHAR(256), 
 @Band VARCHAR(256),
 @Grade VARCHAR(256),
 @TravelBy VARCHAR(256),
 @PerDiem VARCHAR(100),
 @AccommodationLessThan7Days VARCHAR(100),
 @AccommodationMoreThan7Days VARCHAR(100),
 @TransportCharges VARCHAR(100),   
 @SaveOrUpdate INT, -- 1 - SAVE, 2 - UPDATE
 @RuleId INT = 0,
 @CityTier					VARCHAR(20) = '',
 @MoreThan7DaysCityTier		VARCHAR(MAX) = '',
 @LessThan7DaysCityTier		VARCHAR(MAX) = '',
 @ResponseMessage VARCHAR(MAX) OUTPUT,
 @ResponseStatus BIT = 0 OUTPUT 
 --Travel Type, Band, Grade
AS   
-- EXEC uspSavePerDim 'Domestic','1','1B2, 1C1, 1C2, 1D1,1D2,1D3','Bus, Train','1,000','1,100','1,200','1,300',2
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;   
 
 SET @PerDiem = REPLACE(@PerDiem,'.00','')
 SET @AccommodationLessThan7Days = REPLACE(@AccommodationLessThan7Days,'.00','')
 SET @AccommodationMoreThan7Days = REPLACE(@AccommodationMoreThan7Days,'.00','')
 SET @TransportCharges = REPLACE(@TransportCharges,'.00','')

 DECLARE @RuleSetId INT
 SET @RuleSetId = 0
 SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE RuleSetName = 'PerDiem'
 IF @RuleSetId > 0
 BEGIN
	IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL
	DROP TABLE #TempFindRules
	;WITH FindRules
	AS
	(
		SELECT R.* FROM dbo.PRuleSetMapping AS RSM
		INNER JOIN dbo.PRuleMaster AS R  
		ON RSM.RuleId = R.RuleId 
		WHERE RSM.RuleSetId = @RuleSetId
	)
	SELECT *
	,dbo.Split_PerDiem(Condition,'~','=','TravelType') TravelType	
	,CONVERT(VARCHAR(10),dbo.Split_PerDiem(Condition,'~','=','Band')) Band
	,dbo.Split_PerDiem(Condition,'~','=','Grade') Grade
	,dbo.Split_PerDiem(ThenAction,'&','=','TravelBy') TravelBy
	,dbo.Split_PerDiem(ThenAction,'&','=','PerDiem') PerDiem
	,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationLessThan7Days') AccommodationLessThan7Days
	,dbo.Split_PerDiem(ThenAction,'&','=','AccommodationMoreThan7Days') AccommodationMoreThan7Days
	,dbo.Split_PerDiem(ThenAction,'&','=','TransportCharges') TransportCharges
	,dbo.Split_PerDiem(ThenAction,'&','=','CityTier') CityTier
	,dbo.Split_PerDiem(ThenAction,'&','=','MoreThan7DaysCityTier') MoreThan7DaysCityTier
	,dbo.Split_PerDiem(ThenAction,'&','=','LessThan7DaysCityTier') LessThan7DaysCityTier
	INTO #TempFindRules FROM FindRules 

	IF @SaveOrUpdate = 1 
	BEGIN
		IF EXISTS(SELECT * FROM #TempFindRules WHERE TravelType = @TravelType AND Band = @Band AND Grade = @Grade)
		BEGIN
			SET @ResponseMessage = 'Condition Alreay Matched.'
			SET @ResponseStatus = 0
		END
		ELSE 
		BEGIN
			INSERT INTO PRuleMaster
			(RuleName,Description,Condition,ThenAction)
			SELECT 'PerDiem Rule','PerDiem Rule1'
			,'TravelType="'+ @TravelType +'"~Band="'+ @Band +'"~Grade="'+ @Grade +'"'
			,'TravelBy='+ CONVERT(VARCHAR(256),@TravelBy) +'&PerDiem='+ CONVERT(VARCHAR(15),@PerDiem) +'&AccommodationLessThan7Days='+ CONVERT(VARCHAR(15),@AccommodationLessThan7Days) +
			'&AccommodationMoreThan7Days='+ CONVERT(VARCHAR(15),@AccommodationMoreThan7Days) +'&TransportCharges='+ CONVERT(VARCHAR(15),@TransportCharges)+
			'&CityTier='+ @CityTier +'&MoreThan7DaysCityTier='+ @MoreThan7DaysCityTier +'&LessThan7DaysCityTier='+ @LessThan7DaysCityTier +'' 
			INSERT INTO PRuleSetMapping
			(RuleSetId,RuleId,Version,IsActive)
			SELECT @RuleSetId,@@IDENTITY,1,1
			SET @ResponseStatus = 1
		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM #TempFindRules WHERE RuleId = @RuleId)
		BEGIN			
			UPDATE P SET Condition = 'TravelType="'+ @TravelType +'"~Band="'+ @Band +'"~Grade="'+ @Grade +'"',
			ThenAction = 'TravelBy='+ CONVERT(VARCHAR(256),@TravelBy) +'&PerDiem='+ CONVERT(VARCHAR(15),@PerDiem) +'&AccommodationLessThan7Days='+ CONVERT(VARCHAR(15),@AccommodationLessThan7Days) +
			'&AccommodationMoreThan7Days='+ CONVERT(VARCHAR(15),@AccommodationMoreThan7Days) +'&TransportCharges='+ CONVERT(VARCHAR(15),@TransportCharges) +
			'&CityTier='+ @CityTier +'&MoreThan7DaysCityTier='+ @MoreThan7DaysCityTier +'&LessThan7DaysCityTier='+ @LessThan7DaysCityTier +'' 
			FROM PRuleMaster AS P INNER JOIN #TempFindRules AS T ON P.RuleId = T.RuleId
			WHERE T.RuleId = @RuleId
			SET @ResponseStatus = 1
		END
		ELSE 
		BEGIN			
			SET @ResponseMessage = 'Condition Not Matched.'
			SET @ResponseStatus = 0
		END
	END	
 END
 ELSE
 BEGIN
	SET @ResponseMessage = 'PerDiem Not Configured in Rule Set Table.'
	SET @ResponseStatus = 0
 END 
END  

GO
/****** Object:  StoredProcedure [dbo].[uspSavePerDim]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspSavePerDim]  
 -- Add the parameters for the stored procedure here  
 @TravelType VARCHAR(256),
 @TravelBy VARCHAR(256),
 @Designation VARCHAR(256),
 @PerDiem NUMERIC(15,2),
 @Accommodation NUMERIC(15,2),
 @OtherExpenses NUMERIC(15,2),
 @SaveOrUpdate INT, -- 1 - SAVE, 2 - UPDATE
 @ResponseMessage VARCHAR(MAX) OUTPUT,
 @ResponseStatus BIT = 0
AS   
-- EXEC uspSavePerDim 
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;   
 DECLARE @RuleSetId INT
 SET @RuleSetId = 0
 SELECT @RuleSetId = RuleSetId FROM PRuleSet WHERE RuleSetName = 'PerDiem'
 IF @RuleSetId > 0
 BEGIN
	IF OBJECT_ID('TEMPDB..#TempFindRules') IS NOT NULL
	DROP TABLE #TempFindRules
	;WITH FindRules
	AS
	(
		SELECT R.* FROM dbo.PRuleSetMapping AS RSM
		INNER JOIN dbo.PRuleMaster AS R  
		ON RSM.RuleId = R.RuleId 
		WHERE RSM.RuleSetId = 5
	)
	SELECT *
	,dbo.Split_PerDim(Condition,'~','=','TravelType') TravelType
	,dbo.Split_PerDim(Condition,'~','=','TravelBy') TravelBy
	,dbo.Split_PerDim(Condition,'~','=','Designation') Designation
	,dbo.Split_PerDim(ThenAction,'&','=','PerDiem') PerDiem
	,dbo.Split_PerDim(ThenAction,'&','=','Accommodation') Accommodation
	,dbo.Split_PerDim(ThenAction,'&','=','OtherExpenses') OtherExpenses
	INTO #TempFindRules FROM FindRules 

	IF @SaveOrUpdate = 1 
	BEGIN
		IF EXISTS(SELECT * FROM #TempFindRules WHERE TravelType = @TravelType AND TravelBy = @TravelBy AND Designation = @Designation)
		BEGIN
			SET @ResponseMessage = 'Condition Alreay Matched.'
			SET @ResponseStatus = 0
		END
		ELSE 
		BEGIN
			INSERT INTO PRuleMaster
			(RuleName,Description,Condition,ThenAction)
			SELECT 'PerDiem Rule','PerDiem Rule1'
			,'TravelType="'+ @TravelType +'~TravelBy="'+ @TravelBy +'"~Designation="'+ @Designation +'"'
			,'PerDiem='+ CONVERT(VARCHAR(15),@PerDiem) +'~Accommodation="'+ CONVERT(VARCHAR(15),@Accommodation) +'"~OtherExpenses="'+ CONVERT(VARCHAR(15),@OtherExpenses) +'"' 
			SET @ResponseStatus = 1
		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM #TempFindRules WHERE TravelType = @TravelType AND TravelBy = @TravelBy AND Designation = @Designation)
		BEGIN
			UPDATE P SET Condition = 'TravelType="'+ @TravelType +'~TravelBy="'+ @TravelBy +'"~Designation="'+ @Designation +'"',
			ThenAction = 'PerDiem='+ CONVERT(VARCHAR(15),@PerDiem) +'~Accommodation="'+ CONVERT(VARCHAR(15),@Accommodation) +'"~OtherExpenses="'+ CONVERT(VARCHAR(15),@OtherExpenses) +'"' 
			FROM PRuleMaster AS P INNER JOIN #TempFindRules AS T ON P.RuleId = T.RuleId
			SET @ResponseStatus = 1
		END
		ELSE 
		BEGIN			
			SET @ResponseMessage = 'Condition Not Matched.'
			SET @ResponseStatus = 0
		END
	END	
 END
 ELSE
 BEGIN
	SET @ResponseMessage = 'PerDiem Not Configured in Rule Set Table.'
	SET @ResponseStatus = 0
 END 
END  

 

GO
/****** Object:  StoredProcedure [dbo].[uspSaveProcItemDetails]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspSaveProcItemDetails]       
 -- Add the parameters for the stored procedure here      
 @WorkflowId INT,       
 @ItemName VARCHAR(100),    
 @Description VARCHAR(500),    
 @Price FLOAT,    
 @UOM NVARCHAR(100),    
 @ParentCategory NVARCHAR(100),   
 @OutStatus INT OUTPUT       
AS      
BEGIN      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 -- interfering with SELECT statements.      
 SET NOCOUNT ON;      
      
      DECLARE @Cnt int;
      set @Cnt=(select  COUNT (*) from  PItems where Name =@ItemName)
     
     IF(@Cnt>0)
     BEGIN
    -- Insert statements for procedure here     
    UPDATE PItems SET [Description]=@Description,Price=@Price,UOM=@UOM,ParentCategory=@ParentCategory
       Where Name=@ItemName 
    
      SET @OutStatus = 1      
     END
     ELSE
     BEGIN
         INSERT INTO PItems (Name,Description,Price,UOM,Wfid,Active,ParentCategory) VALUES  (@ItemName,@Description,@Price,@UOM,@WorkflowId,1,@ParentCategory)    
      SET @OutStatus = 1      
     END  
END 


GO
/****** Object:  StoredProcedure [dbo].[uspSaveSavingsAcknowledgement]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspSaveSavingsAcknowledgement]  
 -- Add the parameters for the stored procedure here   
 @SolutionName VARCHAR(100),
 @TicketNo VARCHAR(100),
 @CreatedDate DATETIME,
 @CreatedBy VARCHAR(100)  
AS   
-- EXEC uspGetMasterData 502,'LOB',1
BEGIN 
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELPBWMasterDataECT statements.  
 SET NOCOUNT ON;  
 
 DECLARE @SolutionId AS UNIQUEIDENTIFIER
 SELECT @SolutionId = SolutionId FROM SavingsRPASolutions WHERE SolutionName = @SolutionName
 INSERT INTO SavingsAcknowledgement
 (SolutionId,TicketNo,CreatedDate,CreatedBy)
 SELECT @SolutionId,@TicketNo,@CreatedDate,@CreatedBy
 
 SELECT 'Success'
END  

 


 
  
  

GO
/****** Object:  StoredProcedure [dbo].[uspSaveSolution]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspSaveSolution]
	-- Add the parameters for the stored procedure here
	@SolutionId uniqueidentifier,
	@SolutionName VARCHAR(256),
	@CreatedDate DATETIME,
    @CreatedBy VARCHAR(100),
	@ErrorMessage VARCHAR(1000) OUTPUT,
	@ReturnSolutionId VARCHAR(256) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--INSERT INTO SavingsRPASolutions
	--(SolutionName)
	--SELECT @SolutionName
	
	
	BEGIN TRY
	SET @ReturnSolutionId = @SolutionId
    SET @ErrorMessage = '' 
	IF @SolutionId != CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER)
	BEGIN
		IF EXISTS(SELECT 1 FROM SavingsRPASolutions WHERE SolutionName = @SolutionName AND SolutionId != @SolutionId)
		BEGIN
			SET @ErrorMessage = 'This Combination of Data already exists, So It will make Duplicate...'
		END
		ELSE
		BEGIN
			UPDATE SavingsRPASolutions SET SolutionName = @SolutionName, ModifiedDate=@CreatedDate WHERE SolutionId = @SolutionId
		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT 1 FROM SavingsRPASolutions WHERE SolutionName = @SolutionName)
		BEGIN
			SET @ErrorMessage = 'This Combination of Data already exists, So It will make Duplicate...'
		END
		ELSE
		BEGIN
			SET @ReturnSolutionId = NEWID()
			INSERT INTO SavingsRPASolutions
			(SolutionId,SolutionName,CreatedDate)
			SELECT @ReturnSolutionId,@SolutionName,@CreatedDate
		END		
	END
 END TRY
 BEGIN CATCH
	SET @ErrorMessage = ERROR_MESSAGE();
 END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspSaveTravelDocument]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  Prabaakaran T  
-- Create date: 2017-10-29  
-- Description:
-- =============================================  
CREATE PROCEDURE  [dbo].[uspSaveTravelDocument]  
	@FileId			INT = 0,
	@WfId			INT,
	@FileName		VARCHAR(MAX),
	@Description	VARCHAR(MAX),
	@FilePath		VARCHAR(MAX),
	@UserId			VARCHAR(MAX),
	@DocCategory	VARCHAR(50) = 'TravelDocument',
	@DocName		VARCHAR(250) = '',
	@Country		VARCHAR(250) = '',
	@ValidFromDt	DATETIME = NULL,
	@ValidToDt		DATETIME = NULL
AS   
BEGIN  

	SET NOCOUNT ON;
	/*
	IF @DocName= 'PASSPORT' AND EXISTS(SELECT TOP 1 FileId FROM PBWDocuments WHERE DocName = 'PASSPORT' AND CreatedBy = @UserId AND ISNULL(@DocCategory,'') = 'TravelDocument') 
		BEGIN
			DELETE FROM PBWDocuments WHERE DocName = 'PASSPORT' AND CreatedBy = @UserId AND ISNULL(@DocCategory,'') = 'TravelDocument'
		END
	ELSE IF @DocName= 'VISA' AND EXISTS(SELECT TOP 1 FileId FROM PBWDocuments WHERE DocName = 'VISA' AND CreatedBy = @UserId AND ISNULL(@DocCategory,'') = 'TravelDocument' AND Country = @Country) 
		BEGIN
			DELETE FROM PBWDocuments WHERE DocName = 'PASSPORT' AND CreatedBy = @UserId AND ISNULL(@DocCategory,'') = 'TravelDocument'
		END
	*/
	IF ISNULL(@FileId,0) > 0
		BEGIN
			UPDATE PBWDocuments SET 
			[FileName] =@FileName,[Description]=@Description,FilePath=@FilePath,
			DocCategory=@DocCategory,DocName=@DocName,Country=@Country,ValidFromDt=@ValidFromDt,
			ValidToDt=@ValidToDt,ModifiedBy = @UserId,ModifiedDate=GETDATE()
			WHERE WfId = @WfId AND FileId=@FileId
		END
	ELSE
		BEGIN
			INSERT INTO PBWDocuments([FileName],Description,FilePath,WfId,CreatedBy,CreatedDate,DocCategory,DocName,Country,ValidFromDt,ValidToDt)
				SELECT @FileName,@Description,@FilePath,@WfId,@UserId,GETDATE(),@DocCategory,@DocName,@Country,@ValidFromDt,@ValidToDt
		END
END  
GO
/****** Object:  StoredProcedure [dbo].[uspSaveWorkflowTransaction_IJP]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  RAMESHKUMAR      
-- Create date: Jun/06/2017      
-- Description: GetJSON Value      
-- =============================================      
CREATE PROCEDURE  [dbo].[uspSaveWorkflowTransaction_IJP]      
 -- Add the parameters for the stored procedure here       
 @WorkflowId INT,    
 @UserId VARCHAR(MAX),    
 @DataJson VARCHAR(MAX),      
 @FinId INT = 0,    
 @Status VARCHAR(32) = 'Pending', 
 @OutFinId INT OUTPUT    
AS      
-- EXEC uspSaveAhsPlatformWorkflowTransaction 1,'rameshkumar.r1','',0,'Pending'      
BEGIN      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 -- interfering with SELECT statements.      
 SET NOCOUNT ON;
	
	DECLARE @RequestId BIGINT
	SET @RequestId = 0 
	
	SET @DataJson = REPLACE(@DataJson,'.00','')
	 
	SELECT @RequestId = MAX(RequestId) + 1 FROM  dbo.PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId  
	SET @RequestId = ISNULL(@RequestId,1)
	
	DECLARE @WorkflowVersion AS VARCHAR(100)
	DECLARE @WorkflowSubVersion AS VARCHAR(100)
	SET @WorkflowVersion = '1'
	SET @WorkflowSubVersion = '0'
	SELECT @WorkflowVersion =  Version, @WorkflowSubVersion =  SubVersion  FROM PBWWorkFlowMaster WHERE WorkflowId = 2 AND Active = 1   
    
	INSERT INTO   dbo.PBWWorkflowTransaction  
	(WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId,WorkflowVersion,WorkflowSubVersion,rptTranRefId)        
	SELECT @WorkflowId,@DataJson,-14 WorkFlowStateId,37 RoleId,@Status Status,@UserId,@UserId CreatedBy,GETDATE() CreatedDate,@UserId LastModifiedBy, GETDATE() LastModifiedDate,@RequestId ,@WorkflowVersion,@WorkflowSubVersion,0
	    	    
	SET @OutFinId = @@IDENTITY     
END   

GO
/****** Object:  StoredProcedure [dbo].[uspSelectAhsPlatformWorkflowMaster]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Jun/06/2017    
-- Description: GetJSON Value    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspSelectAhsPlatformWorkflowMaster]    
 -- Add the parameters for the stored procedure here     
 @WorkflowId INT   
AS     
-- EXEC uspSelectAhsPlatformWorkflowMaster 1    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;     
  SELECT WorkFlowJson FROM dbo.PBWWorkFlowMaster WHERE WorkflowId = @WorkflowId   
END 

GO
/****** Object:  StoredProcedure [dbo].[uspSelectAhsPlatformWorkflowTransaction]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Jun/06/2017    
-- Description: GetJSON Value    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspSelectAhsPlatformWorkflowTransaction]    
 -- Add the parameters for the stored procedure here     
 @WorkflowId INT,      
 @FinId INT,
 @WithHistory BIT = 0
AS     
-- EXEC uspSelectAhsPlatformWorkflowTransaction 2 ,804840 ,1
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.
    
 SET NOCOUNT ON;     
  IF @WithHistory = 1
  BEGIN
	  SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId
	  ,CASE WHEN Status IN ('AcknowledgedTD','AcknowledgedTDR') THEN 'Acknowledged' WHEN Status = 'PendingTDR' THEN 'Pending' WHEN Status = 'TravelDeskClosed' THEN 'Closed' ELSE Status END Status ,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'H' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId FROM PBWWorkflowTransactionHistory
	  WHERE WorkflowId = @WorkflowId AND Fin = @FinId 
	  UNION ALL
	  SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,CASE WHEN ISNULL(Status,'') = 'Approved' THEN 'Pending' WHEN Status = 'PendingTDR' THEN 'Pending'  WHEN Status IN ('AcknowledgedTD','AcknowledgedTDR') THEN 'Acknowledged' WHEN Status = 'TravelDeskClosed' THEN 'Closed' ELSE Status END Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'T' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId FROM PBWWorkflowTransaction 
	  WHERE WorkflowId = @WorkflowId AND Fin = @FinId 
	  ORDER BY TableName,LastModifiedDate
  END  
  ELSE
  BEGIN
	  SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'T' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId FROM PBWWorkflowTransaction 
	  WHERE WorkflowId = @WorkflowId AND Fin = @FinId 
  END
END    
GO
/****** Object:  StoredProcedure [dbo].[uspSelectAhsPlatformWorkflowTransaction_ByParentFin]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Jun/06/2017    
-- Description: GetJSON Value    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspSelectAhsPlatformWorkflowTransaction_ByParentFin]    
 -- Add the parameters for the stored procedure here     
 @WorkflowId INT,      
 @FinId INT,
 @WithHistory BIT = 0
AS     
-- EXEC uspSelectAhsPlatformWorkflowTransaction 2 ,804840 ,1
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.
    
 SET NOCOUNT ON;     
  IF @WithHistory = 1
  BEGIN
	  SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId
	  ,CASE WHEN Status IN ('AcknowledgedTD','AcknowledgedTDR') THEN 'Acknowledged' WHEN Status = 'PendingTDR' THEN 'Pending' WHEN Status = 'TravelDeskClosed' THEN 'Closed' ELSE Status END Status ,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'H' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId,ParentFin FROM PBWWorkflowTransactionHistory
	  WHERE WorkflowId = @WorkflowId AND ParentFin = @FinId 
	  UNION ALL
	  SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,CASE WHEN ISNULL(Status,'') = 'Approved' THEN 'Pending' WHEN Status = 'PendingTDR' THEN 'Pending'  WHEN Status IN ('AcknowledgedTD','AcknowledgedTDR') THEN 'Acknowledged' WHEN Status = 'TravelDeskClosed' THEN 'Closed' ELSE Status END Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'T' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId,ParentFin FROM PBWWorkflowTransaction 
	  WHERE WorkflowId = @WorkflowId AND ParentFin = @FinId 
	  ORDER BY TableName,LastModifiedDate
  END  
  ELSE
  BEGIN
	  SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'T' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId,ParentFin FROM PBWWorkflowTransaction 
	  WHERE WorkflowId = @WorkflowId AND ParentFin = @FinId 
  END
END    
GO
/****** Object:  StoredProcedure [dbo].[uspSelectAhsPlatformWorkflowTransaction_ByUserId]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[uspSelectAhsPlatformWorkflowTransaction_ByUserId]  
 -- Add the parameters for the stored procedure here   
 @WorkflowId INT,
 @UserId VARCHAR(250),
 @WithHistory BIT =0
AS  
-- EXEC spAHSPlatformGetJsonValue 1  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  	
	SET NOCOUNT ON;     
  IF @WithHistory = 1
  BEGIN
	SELECT * FROM (
	  SELECT Fin,WorkflowId,WorkFlowStateId,DataJson,RoleId
	  ,CASE WHEN Status IN ('AcknowledgedTD','AcknowledgedTDR') THEN 'Acknowledged' WHEN Status = 'PendingTDR' THEN 'Pending' WHEN Status = 'TravelDeskClosed' THEN 'Closed' ELSE Status END Status ,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,
'H' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId FROM PBWWorkflowTransactionHistory AS H
	  WHERE WorkflowId = @WorkflowId AND UserId = @UserId 
	  UNION ALL
	  SELECT Fin,WorkflowId,WorkFlowStateId,DataJson,RoleId,CASE WHEN ISNULL(Status,'') = 'Approved' THEN 'Pending' WHEN Status = 'PendingTDR' THEN 'Pending'  WHEN Status IN ('AcknowledgedTD','AcknowledgedTDR') THEN 'Acknowledged' WHEN Status = 'TravelDeskCl
osed' THEN 'Closed' ELSE Status END Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'T' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId FROM PBWWorkflowTransaction AS T
	  WHERE WorkflowId = @WorkflowId AND UserId = @UserId
	  )X WHERE X.Fin NOT IN (SELECT H1.Fin FROM PBWWorkflowTransactionHistory AS H1 WHERE WorkflowId = @WorkflowId AND UserId = @UserId AND Status ='Cancelled')
	  ORDER BY TableName,LastModifiedDate
  END  
  ELSE
  BEGIN
	  SELECT Fin,WorkflowId,WorkFlowStateId,DataJson,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'T' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId FROM PBWWorkflowTransaction AS T
	  WHERE WorkflowId = @WorkflowId AND UserId = @UserId
	  AND T.Fin NOT IN (SELECT 1 FROM PBWWorkflowTransactionHistory AS H1 WHERE WorkflowId = @WorkflowId AND UserId = @UserId AND Status ='Cancelled')
  END
END  

GO
/****** Object:  StoredProcedure [dbo].[uspSelectPBWWorkFlowException]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Jun/06/2017    
-- Description: GetJSON Value    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspSelectPBWWorkFlowException]    
 -- Add the parameters for the stored procedure here     
 @WfId INT   
AS     
-- EXEC uspSelectAhsPlatformWorkflowMaster 1    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;     
  SELECT ExceptionJson FROM dbo.PBWWorkFlowException WHERE WfId = @WfId AND ExceptionName = 'ExceptionJson'
END 

GO
/****** Object:  StoredProcedure [dbo].[uspSelectWorkflowTransaction_ByWFId]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Jun/06/2017    
-- Description: GetJSON Value    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspSelectWorkflowTransaction_ByWFId]    
 -- Add the parameters for the stored procedure here     
 @WorkflowId INT,  
 @WithHistory BIT = 0
AS     
-- EXEC uspSelectAhsPlatformWorkflowTransaction 2 ,804840 ,1
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.
    
 SET NOCOUNT ON;     
  IF @WithHistory = 1
  BEGIN
	  SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId
	  ,CASE WHEN Status IN ('AcknowledgedTD','AcknowledgedTDR') THEN 'Acknowledged' WHEN Status = 'PendingTDR' THEN 'Pending' WHEN Status = 'TravelDeskClosed' THEN 'Closed' ELSE Status END Status ,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'H' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId FROM PBWWorkflowTransactionHistory
	  WHERE WorkflowId = @WorkflowId 
	  UNION ALL
	  SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,CASE WHEN ISNULL(Status,'') = 'Approved' THEN 'Pending' WHEN Status = 'PendingTDR' THEN 'Pending'  WHEN Status IN ('AcknowledgedTD','AcknowledgedTDR') THEN 'Acknowledged' WHEN Status = 'TravelDeskClosed' THEN 'Closed' ELSE Status END Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'T' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId FROM PBWWorkflowTransaction 
	  WHERE WorkflowId = @WorkflowId  
	  ORDER BY TableName,LastModifiedDate
  END  
  ELSE
  BEGIN
	  SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,'T' TableName, CONVERT(VARCHAR(150),'') StepName,RequestId FROM PBWWorkflowTransaction 
	  WHERE WorkflowId = @WorkflowId 
  END
END    
GO
/****** Object:  StoredProcedure [dbo].[uspStudioGetDashboard]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  Sivasankar S  
-- Create date: Aug/16/2017  
-- Description: GetJSON Value Dashboard 
-- =============================================  
CREATE PROCEDURE  [dbo].[uspStudioGetDashboard]  
 -- Add the parameters for the stored procedure here  
 
AS   
-- EXEC uspGetRules 1,1
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
 
	SELECT  wf.WorkFlowId,wf.WorkFlowName,cl.ClientName,bp.BpName,ind.Industry,wf.CreatedDate,wf.CreatedBy FROM PBWWorkFlowMaster wf 
	INNER JOIN PBusinessProcess bp ON wf.BpId=bp.BpId
	INNER JOIN PIndustry ind on ind.IndustryId=bp.IndustryId
	INNER JOIN PClient cl on cl.ClientId=wf.ClientId
	
END  
 

GO
/****** Object:  StoredProcedure [dbo].[uspStudioGetWorkFlow]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  Sivasankar S  
-- Create date: Aug/17/2017  
-- Description: GetJSON Value Dashboard 
-- =============================================  
CREATE PROCEDURE  [dbo].[uspStudioGetWorkFlow]  
 -- Add the parameters for the stored procedure here  
 @WorkFlowID int 
AS   
-- EXEC uspGetRules 1,1
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
	SELECT  *  FROM PBWWorkFlowMaster WHERE WorkFlowId=@WorkFlowID
END  
 
GO
/****** Object:  StoredProcedure [dbo].[uspSubmitAhsPlatformWorkflowTransaction]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  RAMESHKUMAR      
-- Create date: Jun/06/2017      
-- Description: GetJSON Value      
-- =============================================      
CREATE PROCEDURE  [dbo].[uspSubmitAhsPlatformWorkflowTransaction]      
 -- Add the parameters for the stored procedure here       
 @WorkflowId INT,    
 @UserId VARCHAR(MAX),    
 @DataJson VARCHAR(MAX),      
 @FinId INT = 0,    
 @Status VARCHAR(32) = 'Pending'    
AS      
-- EXEC spAHSPlatformGetJsonValue 1      
BEGIN      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 -- interfering with SELECT statements.   
	DECLARE @RequestId BIGINT
	SET @RequestId = 0   
	SET NOCOUNT ON;       
	IF NOT EXISTS(SELECT 1 FROM PBWWorkflowTransaction WHERE Fin = @FinId)    
	BEGIN    
		SELECT @RequestId = MAX(RequestId) + 1 FROM  dbo.PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId  
		SET @RequestId = ISNULL(@RequestId,1)
		
		INSERT INTO PBWWorkflowTransaction    
		(WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId)        
		SELECT @WorkflowId,@DataJson,0 WorkFlowStateId,0 RoleId,@Status Status,@UserId,@UserId CreatedBy,GETDATE() CreatedDate,@UserId LastModifiedBy, GETDATE() LastModifiedDate,@RequestId
  
  -- INSERT INTO PBWWorkflowTransactionHistory    
  --(Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate)    
  --SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate FROM PBWWorkflowTransaction WHERE Fin = @FinId      
        
    END    
    ELSE    
    BEGIN    
    --UPDATE PBWWorkflowTransaction SET Status= @Status WHERE Fin = @FinId AND @Status = 'Pending'
 
  UPDATE PBWWorkflowTransaction SET DataJson = @DataJson,Status = @Status ,UserId = @UserId,LastModifiedBy = @UserId,LastModifiedDate = GETDATE() WHERE Fin = @FinId       
  
  -- INSERT INTO PBWWorkflowTransactionHistory    
  --(Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate)    
  --SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate FROM PBWWorkflowTransaction WHERE Fin = @FinId      
        
    END    
END   
  
GO
/****** Object:  StoredProcedure [dbo].[uspSyncUserInfo]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =================================================================  
-- Author:  RAMESHKUMAR    
-- Create date: Aug/09/2017    
-- Description: User Data Sync from Enterprise DB to Platform DB    
-- =================================================================
CREATE PROCEDURE  [dbo].[uspSyncUserInfo]    
 -- Add the parameters for the stored procedure here    
AS     
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
	SET NOCOUNT ON;   
	BEGIN TRY 
		BEGIN TRAN USERINFOTRAN
		
		UPDATE PUM SET RoleId = UAV.DesigId,SuperVisorId = UAV.REPORTING_TO,UserLob = UAV.LOB,UserClient = UAV.client_name,Active = CASE WHEN UAV.EmpStatus = 'Active' THEN 1 ELSE 2 END 
		FROM PBWUserMaster AS PUM INNER JOIN [ARC_Enterprise]..ARC_REC_USER_INFO_ALL_VY AS UAV ON PUM.UniqueId = UAV.NT_UserName
		WHERE NOT EXISTS (SELECT  1 FROM PBWUserMaster AS PUMO WHERE PUMO.UniqueId = UAV.NT_UserName AND PUMO.RoleId = UAV.DesigId AND PUMO.SupervisorId = UAV.REPORTING_TO 
		AND PUMO.UserLob = UAV.LOB AND PUMO.UserClient = UAV.client_name AND PUMO.Active = CASE WHEN UAV.EmpStatus = 'Active' THEN 1 ELSE 2 END)
		
		/* UserMaster */
		INSERT INTO PBWUserMaster  
		(UserId,FirstName,LastName,DepartmentId,RoleId,ClientId,EmailId,SupervisorId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,UniqueId,UserLob,UserClient,UserImageName,Active)
		SELECT NT_UserName UserId,FIRSTNAME FirstName,LASTNAME LastName,1 DepartmentId,DesigId RoleId
		,1 ClientId,EMAIL_ID EmailId,REPORTING_TO SupervisorId
		,'ADMIN' CreatedBy,GETDATE() CreatedDate,NULL LastModifiedBy,NULL LastModifiedDate,NT_UserName UniqueId
		,LOB UserLob,client_name UserClient,PROFILE_IMAGE_NAME UserImageName,1 Active FROM [ARC_Enterprise]..ARC_REC_USER_INFO_VY AS UserView
		WHERE NOT EXISTS (SELECT 1 FROM PBWUserMaster AS PUM WHERE UserView.NT_UserName = PUM.UniqueId)		

		UPDATE PUD SET RoleLevel = HD.Band,Band = HD.Band,Grade=HD.Grade FROM PBWUserDesignation AS PUD INNER JOIN [ARC_Enterprise]..HR_Designation AS HD ON PUD.RoleId = HD.DesigId 
		AND PUD.RoleName = HD.Designation
		WHERE NOT EXISTS (SELECT 1 FROM PBWUserDesignation AS PUDO WHERE PUDO.RoleId = HD.DesigId 
		AND PUDO.RoleName = HD.Designation AND PUDO.RoleLevel = HD.Band AND PUDO.Band = HD.Band AND PUDO.Grade=HD.Grade) 
		
		/* UserDesignation		*/
		 INSERT INTO PBWUserDesignation 
		 (RoleId,RoleName,RoleLevel,DepartmentId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,Band,Grade) 
		 SELECT DesigId RoleId,Designation RoleName,Band RoleLevel,1 DepartmentId,CreatedBy,CreatedDate,null LastModifiedBy,null LastModifiedDate,Band,Grade
		 FROM  [ARC_Enterprise]..HR_Designation AS HD
		 WHERE NOT EXISTS (SELECT 1 FROM PBWUserDesignation AS PUD WHERE PUD.RoleId = HD.DesigId AND PUD.RoleName = HD.Designation)
		 
		
		/* UserRoleMapping */
		INSERT INTO PBWUserRoleMapping 
		(WorkflowId,UniqueId,RoleId)
		SELECT 1,UniqueId,5 FROM PBWUserMaster AS PUM WHERE NOT EXISTS (SELECT 1 FROM PBWUserRoleMapping AS PURM WHERE PURM.WorkflowId = 1 AND ISNULL(PURM.UniqueId,'') = ISNULL(PUM.UniqueId,''))
		
		COMMIT TRAN USERINFOTRAN
	END TRY
	BEGIN CATCH		
		ROLLBACK TRAN USERINFOTRAN
		SELECT ERROR_MESSAGE()
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspTATMail]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
      
          
-- =============================================            
-- Author:  <Sivasankar.s1>            
-- Create date: <02012018>            
-- Description: <PlatformTATEmail>            
-- =============================================            
CREATE PROCEDURE [dbo].[uspTATMail]            
  @WfId INT          
AS            
BEGIN            
  -- exec uspTATMail 3        
 -- SET NOCOUNT ON added to prevent extra result sets from            
 -- interfering with SELECT statements.            
 SET NOCOUNT ON;            
--exec uspTATMail 3        
           
SELECT DATEDIFF(HH, CreatedDate, getdate()) AS  Hrs,RM.RoleName,WT.DataJson,CreatedDate,WT.UserId,WT.Fin,WT.RoleId FROM PBWWorkflowTransaction WT        
INNER JOIN PBWWorkFlowRoleMaster RM        
ON RM.RoleId=WT.RoleId        
WHERE WT.[Status] in ('pending','Raised')        
and WT.WorkflowId=3 and RM.RoleId<>5    
AND NOT EXISTS (SELECT * FROM PBWWorkflowTATDetails AS OT WHERE WT.WorkflowId = OT.WorkflowId AND WT.Fin = OT.Fin AND WT.RoleId = OT.RoleId)      
--AND DATEDIFF(HH, CreatedDate, getdate()) >48            
            
END 
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateAhsPlatformWorkflowTransactionQueueRole]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Jun/06/2017    
-- Description: GetJSON Value    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspUpdateAhsPlatformWorkflowTransactionQueueRole]    
 -- Add the parameters for the stored procedure here     
 @WorkflowId INT,      
 @FinId INT,  
 @WorkflowStepId INT,  
 @WorkflowRoleId INT,
 @DataJSon VARCHAR(MAX) = '',
 @Status VARCHAR(100)='',
 @UpdateRoleAndStep BIT = 0
AS     
-- EXEC uspUpdateAhsPlatformWorkflowTransactionQueueRole 3 ,806382  ,-4,8,'','Saved',0
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements. 
	SET NOCOUNT ON;     
	
    --SET @DataJson = REPLACE(@DataJson,'.00','')
	
	IF @UpdateRoleAndStep = 1
	BEGIN
		UPDATE PBWWorkflowTransaction SET WorkFlowStateId = @WorkflowStepId, RoleId = @WorkflowRoleId WHERE WorkflowId = @WorkflowId AND Fin = @FinId 
	END
	ELSE
	BEGIN
		    DECLARE @_Status AS VARCHAR(100)
	SET  @_Status = ''
		
	DECLARE @LogId AS INT
	DECLARE @WorkFlowStateId AS INT
	DECLARE @RoleId AS INT
	DECLARE @_MaxStatus VARCHAR(MAX)
	SET @LogId =-1
	SET @WorkFlowStateId = -1
	SET @RoleId = -1
	SET @_MaxStatus = ''
	SELECT @LogId = LogId,@WorkFlowStateId = WorkFlowStateId,@RoleId = RoleId,@_MaxStatus = Status FROM PBWWorkflowTransactionHistory AS I WHERE I.LogId IN (
	SELECT MAX(O.LogId) FROM PBWWorkflowTransactionHistory AS O WHERE WorkflowId = @WorkflowId AND Fin = @FinId)
	
	IF EXISTS(SELECT 1 FROM PBWWorkflowTransaction AS I WHERE WorkflowId = @WorkflowId AND WorkFlowStateId = @WorkFlowStateId AND RoleId = @RoleId)
	BEGIN
		DELETE FROM PBWWorkflowTransactionHistory WHERE LogId = @LogId
		DELETE FROM rptTransaction WHERE WorkflowId = @WorkflowId AND FIN = @FinId AND TranRefID IN (SELECT TranRefID FROM rptTransaction AS T1 WHERE T1.WorkflowId = @WorkflowId AND T1.FIN = @FinId AND T1.LogId = @LogId)
	END	
	
	SELECT @_Status = Status  FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND Fin = @FinId     
	IF ISNULL(@_Status,'') = 'Approved' AND ISNULL(@Status,'') = 'Closed'
	BEGIN
		SET @_Status = 'Approved'	
	END
	
 
	 IF @WorkflowId =2
	 BEGIN
			IF ISNULL(@_Status,'') != 'Rejected' 
			BEGIN
				--IF @Status = 'Acknowledgement'
				--	SET @_Status = 'Approved'
				--ELSE IF @Status = 'SubmitExpenses'
				--	SET @_Status = 'Acknowledged'
				--ELSE IF @Status = 'BillVerify'
				--	SET @_Status = 'ExpensesSubmitted'
				--ELSE IF @Status	= 'Pending'
				--	SET @_Status = 'Raised'		
				IF @Status = 'Approved'
					SET @_Status = 'Approved'
				ELSE IF @_MaxStatus = 'BillVerify' 
					SET @_Status = 'BillVerified'
				ELSE IF @_MaxStatus = 'Acknowledgement'
					SET @_Status = 'Acknowledged'
				ELSE IF @_MaxStatus = 'AcknowledgedTD' AND @Status = 'Acknowledgement'
					SET @_Status = 'TravelDeskClosed'
				ELSE IF @_MaxStatus = 'SubmitExpenses'
					SET @_Status = 'ExpensesSubmitted'
				ELSE IF @_MaxStatus = 'AcknowledgedTD'
					SET @_Status = 'AcknowledgedTD'		
				ELSE IF @_MaxStatus = 'PendingTDR' AND @Status = 'AcknowledgedTD'
					SET @_Status = 'AcknowledgedTD'
				ELSE IF @_MaxStatus = 'AcknowledgedTDR'
					SET @_Status = 'AcknowledgedTDR'	
				ELSE IF @_MaxStatus	= 'Pending'
					SET @_Status = 'Raised'	
			 END
		END
		--ELSE
		--BEGIN
		--   IF @WorkflowId != 16
		--   BEGIN
		--	SET @_Status = @Status 
		--   END
		--END
		
		IF ISNULL(@DataJSon,'') != ''
		BEGIN
			UPDATE PBWWorkflowTransaction SET DataJson = @DataJSon,[Status] = @Status WHERE WorkflowId = @WorkflowId AND Fin = @FinId  
		END   
	
		--ELSE IF @_MaxStatus = 'BillVerified'
		--	SET @_Status = 'Approved' 
		print @_Status
		print @_MaxStatus
		INSERT INTO PBWWorkflowTransactionHistory    
		(Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId,rptTranRefId)    
		SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,CASE WHEN ISNULL(@_Status,'') != '' AND ISNULL(Status,'') != 'Rejected' THEN @_Status ELSE Status END,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId,0 FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND Fin = @FinId     
		-- --UPDATE PBWWorkflowTransaction SET WorkFlowStateId = @WorkflowStepId, RoleId = @WorkflowRoleId WHERE WorkflowId = @WorkflowId AND Fin = @FinId   
		-- --END
		-- --ELSE
		-- --BEGIN
		-- --UPDATE PBWWorkflowTransaction SET WorkFlowStateId = @WorkflowStepId, RoleId = @WorkflowRoleId WHERE WorkflowId = @WorkflowId AND Fin = @FinId   
		-- --END
		UPDATE PBWWorkflowTransaction SET WorkFlowStateId = @WorkflowStepId, RoleId = @WorkflowRoleId,rptTranRefId = 0 WHERE WorkflowId = @WorkflowId AND Fin = @FinId   
  END
 
END    
   

GO
/****** Object:  StoredProcedure [dbo].[uspUpdateBulkTaskStatus]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspUpdateBulkTaskStatus]
	-- Add the parameters for the stored procedure here
	@WorkflowId INT,
	@Fin INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @SiblingsCnt AS INT
	SELECT @SiblingsCnt = COUNT(*) FROM PBWWorkflowTransaction WHERE ParentFin = @Fin
	IF ISNULL(@SiblingsCnt,0) > 0
	BEGIN
		UPDATE PBWWorkflowTransaction SET Status = 'Open' WHERE ParentFin = @Fin
	END
	ELSE
	BEGIN
		UPDATE PBWWorkflowTransaction SET Status = 'Completed' WHERE  Fin = @Fin AND Fin != ParentFin
		DECLARE @ParentFin AS INT
		SELECT @ParentFin = ParentFin FROM PBWWorkflowTransaction WHERE Fin = @Fin
		DECLARE @ReturnParentFin1 AS INT
		SET @ReturnParentFin1 = 0
		IF ISNULL(@ParentFin,0) != 0
		BEGIN
			EXEC uspUpdateParentTaskStatus @WorkflowId,@ParentFin,@ReturnParentFin = @ReturnParentFin1 OUTPUT
			SELECT * FROM PBWWorkflowTransaction WHERE Fin = @ReturnParentFin1
		END
	END	
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateDataJSon]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Nov/22/2017    
-- Description: Update Date    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspUpdateDataJSon]    
 -- Add the parameters for the stored procedure here     
 @WorkflowId INT,      
 @FinId INT, 
 @DataJSon VARCHAR(MAX) 
AS     
-- EXEC uspUpdateAhsPlatformWorkflowTransactionQueueRole 1 ,249  ,-21,2 
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements. 
      SET NOCOUNT ON;     
     

      UPDATE PBWWorkflowTransaction SET DataJson = @DataJSon WHERE WorkflowId = @WorkflowId AND Fin = @FinId   

END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateDate]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Nov/22/2017    
-- Description: Update Date    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspUpdateDate]    
 -- Add the parameters for the stored procedure here     
 @WorkflowId INT,      
 @FinId INT,  
 @UserId VARCHAR(256), 
 @DataJSon VARCHAR(MAX),
 @OldDataJSon VARCHAR(MAX)
AS     
-- EXEC uspUpdateAhsPlatformWorkflowTransactionQueueRole 1 ,249  ,-21,2 
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements. 
      SET NOCOUNT ON;     
      
	INSERT INTO PBWWorkflowTransactionHistory    
	(Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId)    
	SELECT Fin,WorkflowId,@OldDataJSon,WorkFlowStateId,RoleId,'ReSubmitted' Status
	,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND Fin = @FinId     

	DECLARE @WorkflowRoleId AS INT      
	SELECT @WorkflowRoleId = RoleId FROM PBWUserRoleMapping WHERE UniqueId = @UserId

	UPDATE PBWWorkflowTransaction SET WorkFlowStateId = -2, RoleId = @WorkflowRoleId,Status = 'Data Modified', DataJson = @DataJSon, LastModifiedBy = @UserId, LastModifiedDate = GETDATE() WHERE WorkflowId = @WorkflowId AND Fin = @FinId   

END

GO
/****** Object:  StoredProcedure [dbo].[uspUpdateEntryCancel]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Jun/06/2017    
-- Description: GetJSON Value    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspUpdateEntryCancel]    
 -- Add the parameters for the stored procedure here     
 @WorkflowId INT,      
 @FinId INT,  
 @RequestUserId VARCHAR(MAX),
 @WorkflowEndStepId INT, 
 @DataJSon VARCHAR(MAX) = ''
AS     
-- EXEC uspUpdateAhsPlatformWorkflowTransactionQueueRole 1 ,249  ,-21,2 
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements. 
	SET NOCOUNT ON;     
	
    SET @DataJson = REPLACE(@DataJson,'.00','')
    
	INSERT INTO PBWWorkflowTransactionHistory    
	(Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId)    
	SELECT 
		Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,CASE WHEN ISNULL(Status,'') = 'Approved' THEN 'Pending' ELSE Status END Status 
		,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId 
	FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND Fin = @FinId 

	DECLARE @WorkflowRoleId AS VARCHAR(MAX)
	SELECT @WorkflowRoleId = RoleId FROM PBWUserRoleMapping WHERE WorkflowId = @WorkflowId AND UniqueId = @RequestUserId
	UPDATE PBWWorkflowTransaction SET DataJson = @DataJSon,[Status] = 'Cancelled',WorkFlowStateId = 200, RoleId = @WorkflowRoleId WHERE WorkflowId = @WorkflowId AND Fin = @FinId 

	INSERT INTO PBWWorkflowTransactionHistory    
	(Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId)    
	SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId
	,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId 
	FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND Fin = @FinId 

	UPDATE PBWWorkflowTransaction SET [Status] = 'Closed',WorkFlowStateId = @WorkflowEndStepId, RoleId = 100 WHERE WorkflowId = @WorkflowId AND Fin = @FinId 
END


   
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateIJPClosedCandidateRelease]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspUpdateIJPClosedCandidateRelease]
	-- Add the parameters for the stored procedure here
	@WorkflowIJPCandidateId INT,
	@FIN INT,	
	@DataJson VARCHAR(MAX),
	@Status VARCHAR(100)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    
	UPDATE PBWWorkflowTransaction SET DataJson = @DataJson,Status = @Status WHERE WorkflowId = @WorkflowIJPCandidateId AND FIN = @FIN
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateParentFin]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE PROCEDURE [dbo].[uspUpdateParentFin]
(
	-- Add the parameters for the Stored Procedures here
	@WorkflowId INT,
	@Fin INT,
	@ParentFin INT,
	@ParentWorkFlowStateId INT
)
AS
BEGIN
	UPDATE PBWWorkflowTransaction SET ParentFin = @ParentFin,ParentWorkFlowStateId =@ParentWorkFlowStateId  WHERE WorkflowId = @WorkflowId AND Fin = @Fin AND ParentFin IS NULL
	UPDATE PBWWorkflowTransactionHistory SET ParentFin = @ParentFin,ParentWorkFlowStateId =@ParentWorkFlowStateId WHERE WorkflowId = @WorkflowId AND Fin = @Fin AND ParentFin IS NULL
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateParentTaskStatus]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE PROCEDURE [dbo].[uspUpdateParentTaskStatus]
(
	-- Add the parameters for the Stored Procedures here
	@WorflowId INT,
	@Fin INT,
	@ReturnParentFin INT OUTPUT
)
AS
BEGIN
	SET @ReturnParentFin = 0
	DECLARE @NotCompletedCnt AS INT
	DECLARE @Output AS INT
	SELECT @NotCompletedCnt = COUNT(*) FROM PBWWorkflowTransaction WHERE ParentFin = @Fin AND Status != 'Completed'
	IF ISNULL(@NotCompletedCnt,0) = 0
	BEGIN
	   DECLARE @RootParentFin AS INT
	   SELECT @RootParentFin = Fin FROM PBWWorkflowTransaction WHERE Fin = @Fin AND Fin = ParentFin
	   IF ISNULL(@RootParentFin,0) = 0
	   BEGIN
		 
		   UPDATE PBWWorkflowTransaction SET Status = 'Completed' WHERE Fin = @Fin AND Fin != ParentFin
		   DECLARE @ParentFin1 AS INT
		     print 'a'
		   PRINT @ParentFin1
		   PRINT @Fin
		   print 'b'
		   
		   SELECT @ParentFin1 = ParentFin FROM PBWWorkflowTransaction WHERE Fin = @Fin
		   IF ISNULL(@ParentFin1,0) != 0
		   BEGIN
				EXEC uspUpdateParentTaskStatus @WorflowId,@ParentFin1,@ReturnParentFin = @ParentFin1 OUTPUT
		   END
	   END
	   ELSE
	   BEGIN
		   SET @ReturnParentFin = @Fin
	   END
	END
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdatePlatformMailTran]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rameshkumar
-- Create date: January/08/2018
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspUpdatePlatformMailTran]
	-- Add the parameters for the stored procedure here
	 @WorkflowId INT,
     @Fin INT,	 
	 @MailTranId INT,	 
     @MailStatus INT,
     @ModifiedDate DATETIME,
     @ModifiedBy VARCHAR(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    UPDATE PMailTran SET MailStatus = @MailStatus,ModifiedDate = @ModifiedDate,ModifiedBy= @ModifiedBy WHERE Id = @MailTranId AND WorkflowId = @WorkflowId AND Fin = @Fin
END

 
 
GO
/****** Object:  StoredProcedure [dbo].[uspValidateForApprovalUserAndGetUsersbyRuleId]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================    
-- Author:  surendher.s  
-- Create date: Feb/13/2019  
-- Description: Getusers list by role id    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspValidateForApprovalUserAndGetUsersbyRuleId]    
 -- Add the parameters for the stored procedure here    
 @RoleId INT  
 ,@Module varchar(100)  
 ,@Finid INT  
AS     
  
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
   
 --Approval Roles  
 DECLARE   
  @RoleNames VARCHAR(500)  
 ,@TMSRoleNames VARCHAR(500)  
 ,@DepartHeadName varchar(75)  
  
 SET @RoleNames='HOD,MD,COO,FM,PM,VC,PH,CMO,NHOD'  
 SET @TMSRoleNames='DepartmentHead,MD,COO,ActiveMD,Pacific MD'  
  
IF EXISTS (SELECT RoleName FROM PBWWorkFlowRoleMaster WHERE RoleId=@RoleId and (RoleName='HOD' or RoleName='DepartmentHead'))  
BEGIN  
   DECLARE @UserId   VARCHAR(200)   
   Select @UserId=UserId from PBWWorkflowTransaction where Fin=@Finid  
  
IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL                    
      DROP TABLE #TempSubOrdinates   
CREATE TABLE  #TempSubOrdinates  
(  
      SupervisorId            VARCHAR(200),  
      Userid                        VARCHAR(200),  
      SupervisorRoleName            Varchar(200),  
      OrderId                       Int  
)  
  
Insert Into #TempSubOrdinates   
      SELECT DISTINCT        
            U.SupervisorId,U.Userid,RM.RoleName,1 [OrderId]   
      FROM PBWUserMaster AS U   
      Inner Join PBWUserRoleMapping UR On UR.UniqueId = U.SupervisorId   
      Inner Join PBWWorkFlowRoleMaster RM On RM.RoleId = UR.RoleId and RM.WfId = UR.WorkflowId  
      Where UR.WorkflowId = 2 and U.Userid = @UserId   
  
Insert Into #TempSubOrdinates  
      SELECT DISTINCT        
            U.SupervisorId,U.Userid,RM.RoleName,2 [OrderId]   
      FROM PBWUserMaster AS U   
      Inner Join #TempSubOrdinates AS UI On UI.SupervisorId = U.Userid   
      Inner Join PBWUserRoleMapping UR On UR.UniqueId = U.SupervisorId   
      Inner Join PBWWorkFlowRoleMaster RM On RM.RoleId = UR.RoleId and RM.WfId = UR.WorkflowId  
      Where UR.WorkflowId = 2 and OrderId = 1  
        
Insert Into #TempSubOrdinates  
      SELECT DISTINCT        
            U.SupervisorId,U.Userid,RM.RoleName,3 [OrderId]   
      FROM PBWUserMaster AS U   
      Inner Join #TempSubOrdinates AS UI On UI.SupervisorId = U.Userid   
      Inner Join PBWUserRoleMapping UR On UR.UniqueId = U.SupervisorId   
      Inner Join PBWWorkFlowRoleMaster RM On RM.RoleId = UR.RoleId and RM.WfId = UR.WorkflowId  
      Where UR.WorkflowId = 2 and OrderId = 2  
  
Insert Into #TempSubOrdinates  
      SELECT DISTINCT        
            U.SupervisorId,U.Userid,RM.RoleName,4 [OrderId]   
      FROM PBWUserMaster AS U   
      Inner Join #TempSubOrdinates AS UI On UI.SupervisorId = U.Userid   
      Inner Join PBWUserRoleMapping UR On UR.UniqueId = U.SupervisorId   
      Inner Join PBWWorkFlowRoleMaster RM On RM.RoleId = UR.RoleId and RM.WfId = UR.WorkflowId  
      Where UR.WorkflowId = 2 and OrderId = 3  
        
Insert Into #TempSubOrdinates  
      SELECT DISTINCT        
            U.SupervisorId,U.Userid,RM.RoleName,5 [OrderId]   
      FROM PBWUserMaster AS U   
      Inner Join #TempSubOrdinates AS UI On UI.SupervisorId = U.Userid   
      Inner Join PBWUserRoleMapping UR On UR.UniqueId = U.SupervisorId   
      Inner Join PBWWorkFlowRoleMaster RM On RM.RoleId = UR.RoleId and RM.WfId = UR.WorkflowId  
      Where UR.WorkflowId = 2 and OrderId = 4  
        
Insert Into #TempSubOrdinates  
      SELECT DISTINCT        
            U.SupervisorId,U.Userid,RM.RoleName,6 [OrderId]   
      FROM PBWUserMaster AS U   
      Inner Join #TempSubOrdinates AS UI On UI.SupervisorId = U.Userid   
      Inner Join PBWUserRoleMapping UR On UR.UniqueId = U.SupervisorId   
      Inner Join PBWWorkFlowRoleMaster RM On RM.RoleId = UR.RoleId and RM.WfId = UR.WorkflowId  
      Where UR.WorkflowId = 2 and OrderId = 5  
  
Select @DepartHeadName=SupervisorId from #TempSubOrdinates Where SupervisorRoleName='DepartmentHead'  
Select @DepartHeadName as UniqueId  
  
  
IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL                    
      DROP TABLE #TempSubOrdinates   
  
End  
  
Else  
begin  
 if @Module = 'Procurement'  
  
   
 SELECT DISTINCT URM.WorkflowId,URM.UniqueId,URM.RoleId FROM PBWUserRoleMapping(NOLOCK) URM  
 INNER JOIN PBWWorkFlowRoleMaster(NOLOCK) WRM ON WRM.RoleId = URM.RoleId WHERE WRM.wfid=3 AND  URM.roleid=@RoleId and URM.workflowid=3 AND WRM.RoleName in (select items from dbo.fnSplitString(@RoleNames,','))  
 ELSE IF @Module = 'Travel'  
   SELECT DISTINCT URM.WorkflowId,URM.UniqueId,URM.RoleId FROM PBWUserRoleMapping(NOLOCK) URM  
   INNER JOIN PBWWorkFlowRoleMaster(NOLOCK) WRM ON WRM.RoleId = URM.RoleId WHERE WRM.wfid=3 AND  URM.roleid=@RoleId and URM.workflowid=3 AND WRM.RoleName in (select items from dbo.fnSplitString(@TMSRoleNames,','))  
   
 END  
END    
  
GO
/****** Object:  StoredProcedure [dbo].[uspValidateRequestStatus]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspValidateRequestStatus](@workflowid INT,@finid INT,@userId VARCHAR(75),@workFlowStateId INT)  
as  
BEGIN  
DECLARE @CURRROLEID INT  
  
IF EXISTS(SELECT 1 FROM PBWWorkflowTransaction WHERE Fin=@finid AND WorkFlowStateId=@workFlowStateId)  
BEGIN  
SELECT @CurrRoleid=Roleid FROM PBWWorkflowTransaction WHERE Fin=@finid AND WorkFlowStateId=-@workFlowStateId  
  
IF EXISTS(SELECT 1 FROM PBWUserRoleMapping WHERE UniqueId=@userid AND WorkflowId=@workflowid AND RoleId=@CurrRoleid)  
SELECT 1  
ELSE   
SELECT 0  
END  
ELSE  
SELECT 0  
END
GO
/****** Object:  StoredProcedure [dbo].[uspViewAhsPlatformWorkflowTransaction]    Script Date: 8/30/2020 7:13:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:  RAMESHKUMAR    
-- Create date: Jun/06/2017    
-- Description: GetJSON Value    
-- =============================================    
CREATE PROCEDURE  [dbo].[uspViewAhsPlatformWorkflowTransaction]    
 -- Add the parameters for the stored procedure here     
 @WorkflowId INT,  
 @UserId     VARCHAR(100),
 @Status VARCHAR(100) =''
AS    
-- EXEC uspViewAhsPlatformWorkflowTransaction 3 ,'prabaakaran.t' ,'Submit'
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;     
 IF ISNULL(@Status,'') != ''
 BEGIN
	IF @WorkflowId = 3
	BEGIN
		SELECT *, CONVERT(VARCHAR(150),'') StepName FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId AND UPPER(Status) =  UPPER(@Status)
		ORDER BY CreatedDate
	END
	ELSE
	BEGIN	
		SELECT *, CONVERT(VARCHAR(150),'') StepName FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId AND UPPER(Status) = 'SUBMITEXPENSES'
		ORDER BY CreatedDate
	END
 END
 ELSE
 BEGIN
	SELECT *, CONVERT(VARCHAR(150),'') StepName FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND UserId = @UserId 
	order by CreatedDate
 END
END    



GO
