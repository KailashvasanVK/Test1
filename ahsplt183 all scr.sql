USE [AhsPlatform_183]
GO
/****** Object:  UserDefinedFunction [dbo].[fnSplitString]    Script Date: 9/10/2020 6:01:17 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[parseJSON]    Script Date: 9/10/2020 6:01:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[parseJSON]( @JSON NVARCHAR(MAX))
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
/****** Object:  UserDefinedFunction [dbo].[Split_PerDiem]    Script Date: 9/10/2020 6:01:17 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[Split_PerDim]    Script Date: 9/10/2020 6:01:17 PM ******/
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
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 9/10/2020 6:01:17 PM ******/
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
/****** Object:  Table [dbo].[aa11]    Script Date: 9/10/2020 6:01:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aa11](
	[id] [int] NULL,
	[name] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARC_REC_USER_INFO_Temp]    Script Date: 9/10/2020 6:01:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARC_REC_USER_INFO_Temp](
	[USERID] [int] NOT NULL,
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
	[rowguid] [uniqueidentifier] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DecisionResults]    Script Date: 9/10/2020 6:01:20 PM ******/
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
/****** Object:  Table [dbo].[DecisionStatus]    Script Date: 9/10/2020 6:01:21 PM ******/
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
/****** Object:  Table [dbo].[DecisionStickyNote]    Script Date: 9/10/2020 6:01:21 PM ******/
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
/****** Object:  Table [dbo].[DecisionTreee]    Script Date: 9/10/2020 6:01:22 PM ******/
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
 CONSTRAINT [PK_DecisionTreee] PRIMARY KEY CLUSTERED 
(
	[DecisionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DecisionTreeLog]    Script Date: 9/10/2020 6:01:22 PM ******/
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
 CONSTRAINT [PK_DecisionTreeLog] PRIMARY KEY CLUSTERED 
(
	[DecisionIdLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DecisionTreeResults]    Script Date: 9/10/2020 6:01:23 PM ******/
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
 CONSTRAINT [PK_DecisionTreeResults] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailStore]    Script Date: 9/10/2020 6:01:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailStore](
	[RequestID] [int] NOT NULL,
	[From] [varchar](50) NOT NULL,
	[To] [varchar](max) NULL,
	[Body] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CC] [varchar](max) NULL,
	[MailStatus] [bit] NULL,
	[IsHTML] [varchar](1) NULL,
	[Active] [int] NULL,
	[FilePath] [varchar](1000) NULL,
	[Subject] [varchar](100) NULL,
	[Exception] [varchar](max) NULL,
	[AppName] [nvarchar](max) NULL,
 CONSTRAINT [PK_RId] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_BatchID]    Script Date: 9/10/2020 6:01:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_BatchID](
	[ID] [int] NOT NULL,
	[EOB_BatchID] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex]    Script Date: 9/10/2020 6:01:25 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_06_10_2017]    Script Date: 9/10/2020 6:01:25 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_11thSep]    Script Date: 9/10/2020 6:01:26 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_BatchID]    Script Date: 9/10/2020 6:01:26 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_BatchID_1]    Script Date: 9/10/2020 6:01:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_BatchID_1](
	[Sno] [float] NULL,
	[BatchNo] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_BatchID_Output]    Script Date: 9/10/2020 6:01:28 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_BatchID_Output_15thsep]    Script Date: 9/10/2020 6:01:29 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_BatchID_Output1]    Script Date: 9/10/2020 6:01:29 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_BatchID1]    Script Date: 9/10/2020 6:01:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_BatchID1](
	[BatchNO] [nvarchar](255) NULL,
	[PayerName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_bk_05_09_17]    Script Date: 9/10/2020 6:01:30 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_Headers]    Script Date: 9/10/2020 6:01:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_Headers](
	[PayerName] [varchar](max) NULL,
	[matchedheader] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_Headers_Index]    Script Date: 9/10/2020 6:01:31 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_Input]    Script Date: 9/10/2020 6:01:32 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_Input1]    Script Date: 9/10/2020 6:01:33 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_Input2]    Script Date: 9/10/2020 6:01:33 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_Input3]    Script Date: 9/10/2020 6:01:34 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_Input4]    Script Date: 9/10/2020 6:01:35 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_Input5]    Script Date: 9/10/2020 6:01:35 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_Input6]    Script Date: 9/10/2020 6:01:36 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_Output]    Script Date: 9/10/2020 6:01:36 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_Pattern_Input]    Script Date: 9/10/2020 6:01:37 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_TesseractHeaders]    Script Date: 9/10/2020 6:01:37 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegex_TesseractHeaders1]    Script Date: 9/10/2020 6:01:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EOB_tRegex_TesseractHeaders1](
	[PayerName] [varchar](max) NULL,
	[matchedheader] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EOB_tRegex_test]    Script Date: 9/10/2020 6:01:38 PM ******/
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
/****** Object:  Table [dbo].[EOB_tRegexMachedValue]    Script Date: 9/10/2020 6:01:39 PM ******/
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
/****** Object:  Table [dbo].[FacilityMaster]    Script Date: 9/10/2020 6:01:40 PM ******/
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
/****** Object:  Table [dbo].[HR_Designation]    Script Date: 9/10/2020 6:01:40 PM ******/
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
	[DesigId] [int] IDENTITY(1,1) NOT NULL,
	[NoticePeriod] [int] NULL,
	[Supervisor] [char](1) NULL,
	[HeadCountName] [varchar](10) NULL,
	[CameraPhoneAllowed] [int] NULL,
	[OP_READ] [char](1) NULL,
	[OP_EDIT] [char](1) NULL,
	[IsDesignationAMandAbove] [int] NULL,
	[BenchTypeGroup] [varchar](50) NULL,
	[ExpectedDays] [int] NULL,
	[ShortDesignation] [varchar](10) NULL,
	[Band] [tinyint] NULL,
	[Grade] [varchar](4) NULL,
 CONSTRAINT [PK_HD_DesigId] PRIMARY KEY CLUSTERED 
(
	[DesigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HR_Functionality]    Script Date: 9/10/2020 6:01:40 PM ******/
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
/****** Object:  Table [dbo].[Inventory]    Script Date: 9/10/2020 6:01:41 PM ******/
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
/****** Object:  Table [dbo].[JsonStructureMaster]    Script Date: 9/10/2020 6:01:42 PM ******/
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
/****** Object:  Table [dbo].[LMS_Designer]    Script Date: 9/10/2020 6:01:42 PM ******/
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
/****** Object:  Table [dbo].[LMS_Designer7]    Script Date: 9/10/2020 6:01:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Designer7](
	[Id] [int] NOT NULL,
	[ModuleId] [int] NULL,
	[ImgJson] [varchar](max) NULL,
	[TokenKey] [varchar](2050) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserName] [varchar](650) NULL,
	[FileName] [varchar](650) NULL,
	[Status] [varchar](150) NULL,
	[SubModuleId] [int] NULL,
	[AudioFiles] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Modules]    Script Date: 9/10/2020 6:01:43 PM ******/
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
 CONSTRAINT [PK_LMS_Modules] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_Modules7]    Script Date: 9/10/2020 6:01:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LMS_Modules7](
	[Id] [int] NOT NULL,
	[ModuleName] [varchar](250) NULL,
	[Description] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[UserName] [varchar](650) NULL,
	[Status] [varchar](50) NULL,
	[ModuleOverview] [varchar](max) NULL,
	[IsARCalling] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LMS_TestResults]    Script Date: 9/10/2020 6:01:44 PM ******/
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
 CONSTRAINT [PK_LMS_TestResults] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocationMaster]    Script Date: 9/10/2020 6:01:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocationMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NOT NULL,
	[Location] [varchar](60) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 9/10/2020 6:01:45 PM ******/
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
/****** Object:  Table [dbo].[Logs]    Script Date: 9/10/2020 6:01:46 PM ******/
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
/****** Object:  Table [dbo].[MANILA_REC_USER_INFO]    Script Date: 9/10/2020 6:01:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MANILA_REC_USER_INFO](
	[USERID] [float] NULL,
	[FIRSTNAME] [nvarchar](255) NULL,
	[LASTNAME] [nvarchar](255) NULL,
	[NT_USERNAME] [nvarchar](255) NULL,
	[DESIGNATION_ID] [float] NULL,
	[FUNCTIONALITY_ID] [float] NULL,
	[REC_ID] [float] NULL,
	[CREATED_BY] [float] NULL,
	[CREATED_DT] [datetime] NULL,
	[REPORTING_TO] [nvarchar](255) NULL,
	[EMPCODE] [nvarchar](255) NULL,
	[ACTIVE] [float] NULL,
	[CLIENT_ID] [float] NULL,
	[DOJ] [datetime] NULL,
	[AHS_PRL] [nvarchar](255) NULL,
	[PreDoj] [nvarchar](255) NULL,
	[LastCustomerId] [float] NULL,
	[Password] [nvarchar](255) NULL,
	[EmailId] [nvarchar](255) NULL,
	[AccountType] [nvarchar](255) NULL,
	[ExtUser] [nvarchar](255) NULL,
	[UserName] [nvarchar](255) NULL,
	[FirstTrnDt] [nvarchar](255) NULL,
	[MIDDLENAME] [nvarchar](255) NULL,
	[T_Empcode] [nvarchar](255) NULL,
	[LocationID] [float] NULL,
	[LOB] [float] NULL,
	[IsCritical] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterFields]    Script Date: 9/10/2020 6:01:47 PM ******/
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
/****** Object:  Table [dbo].[PBusinessProcess]    Script Date: 9/10/2020 6:01:48 PM ******/
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
/****** Object:  Table [dbo].[PBusinessProcessFields]    Script Date: 9/10/2020 6:01:48 PM ******/
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
/****** Object:  Table [dbo].[PBW_MailInformation]    Script Date: 9/10/2020 6:01:49 PM ******/
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
/****** Object:  Table [dbo].[PBWDocuments]    Script Date: 9/10/2020 6:01:49 PM ******/
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
 CONSTRAINT [PK_PBWDocuments] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWLanguageMaster]    Script Date: 9/10/2020 6:01:50 PM ******/
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
/****** Object:  Table [dbo].[PBWMasterData]    Script Date: 9/10/2020 6:01:51 PM ******/
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
/****** Object:  Table [dbo].[PBWMenuMaster]    Script Date: 9/10/2020 6:01:51 PM ******/
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
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWMenuRoleMapping]    Script Date: 9/10/2020 6:01:52 PM ******/
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
/****** Object:  Table [dbo].[PBWSubMenuMaster]    Script Date: 9/10/2020 6:01:53 PM ******/
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
/****** Object:  Table [dbo].[PBWSubmenuRoleMapping]    Script Date: 9/10/2020 6:01:54 PM ******/
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
/****** Object:  Table [dbo].[PBWUserDesignation]    Script Date: 9/10/2020 6:01:55 PM ******/
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
/****** Object:  Table [dbo].[PBWUserMaster]    Script Date: 9/10/2020 6:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PBWUserMaster](
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
	[LocationName] [varchar](256) NULL,
 CONSTRAINT [PK__PBWUserM__3214EC075CD6CB2B] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWUserRoleMapping]    Script Date: 9/10/2020 6:01:56 PM ******/
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
/****** Object:  Table [dbo].[PBWWorkFlowException]    Script Date: 9/10/2020 6:01:56 PM ******/
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
/****** Object:  Table [dbo].[PBWWorkFlowExceptionTransaction]    Script Date: 9/10/2020 6:01:57 PM ******/
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
 CONSTRAINT [PK_PBWWorkFlowExceptionTransaction] PRIMARY KEY CLUSTERED 
(
	[ExceptionTransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkFlowExceptionTransactionHistory]    Script Date: 9/10/2020 6:01:57 PM ******/
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
 CONSTRAINT [PK_PBWWorkFlowExceptionTransactionHistory] PRIMARY KEY CLUSTERED 
(
	[ExceptionTransactionHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkFlowMaster]    Script Date: 9/10/2020 6:01:58 PM ******/
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
 CONSTRAINT [PK_AhsPlatformWorkFlowMaster] PRIMARY KEY CLUSTERED 
(
	[WorkFlowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkFlowRoleMaster]    Script Date: 9/10/2020 6:01:59 PM ******/
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
/****** Object:  Table [dbo].[PBWWorkflowTransaction]    Script Date: 9/10/2020 6:01:59 PM ******/
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
 CONSTRAINT [PK_PBWWorkflowTransaction] PRIMARY KEY CLUSTERED 
(
	[Fin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkflowTransactionHistory]    Script Date: 9/10/2020 6:02:00 PM ******/
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
 CONSTRAINT [PK_AhsPlatformWorkflowHistory] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PBWWorkSpaceMaster]    Script Date: 9/10/2020 6:02:00 PM ******/
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
/****** Object:  Table [dbo].[PCityList]    Script Date: 9/10/2020 6:02:01 PM ******/
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
/****** Object:  Table [dbo].[PClient]    Script Date: 9/10/2020 6:02:02 PM ******/
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
/****** Object:  Table [dbo].[PDepartment]    Script Date: 9/10/2020 6:02:02 PM ******/
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
/****** Object:  Table [dbo].[PDWComponentInstance]    Script Date: 9/10/2020 6:02:03 PM ******/
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
/****** Object:  Table [dbo].[PDWComponentMaster]    Script Date: 9/10/2020 6:02:04 PM ******/
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
/****** Object:  Table [dbo].[PDWInventory]    Script Date: 9/10/2020 6:02:04 PM ******/
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
/****** Object:  Table [dbo].[PDWLog]    Script Date: 9/10/2020 6:02:05 PM ******/
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
/****** Object:  Table [dbo].[PDWProcessQueue]    Script Date: 9/10/2020 6:02:05 PM ******/
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
/****** Object:  Table [dbo].[PDWProcessScheduler]    Script Date: 9/10/2020 6:02:06 PM ******/
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
/****** Object:  Table [dbo].[PDWRunTimeEngine]    Script Date: 9/10/2020 6:02:06 PM ******/
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
/****** Object:  Table [dbo].[PIndustry]    Script Date: 9/10/2020 6:02:07 PM ******/
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
/****** Object:  Table [dbo].[ProcessQueue]    Script Date: 9/10/2020 6:02:07 PM ******/
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
/****** Object:  Table [dbo].[PRuleMaster]    Script Date: 9/10/2020 6:02:08 PM ******/
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
 CONSTRAINT [PK_PRuleMaster] PRIMARY KEY CLUSTERED 
(
	[RuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRuleSet]    Script Date: 9/10/2020 6:02:08 PM ******/
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
 CONSTRAINT [PK_PRuleSet] PRIMARY KEY CLUSTERED 
(
	[RuleSetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRuleSetMapping]    Script Date: 9/10/2020 6:02:09 PM ******/
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
 CONSTRAINT [PK_PRuleSetMapping] PRIMARY KEY CLUSTERED 
(
	[MappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PSubDepartment]    Script Date: 9/10/2020 6:02:10 PM ******/
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
/****** Object:  Table [dbo].[RBA_NodeHierachy]    Script Date: 9/10/2020 6:02:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RBA_NodeHierachy](
	[NodeId] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NULL,
	[MenuCaption] [nvarchar](200) NULL,
	[Wfid] [int] NULL,
	[Url] [nvarchar](200) NULL,
	[Image] [nvarchar](200) NULL,
	[Type] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[DisplayOrder] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[CustomField] [varchar](max) NULL,
	[RootId] [int] NULL,
	[StatusID] [bit] NULL,
 CONSTRAINT [PK_PBA_NodeHierachy] PRIMARY KEY CLUSTERED 
(
	[NodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RBA_Permissions]    Script Date: 9/10/2020 6:02:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RBA_Permissions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[NodeId] [int] NULL,
	[Read] [bit] NULL,
	[Write] [bit] NULL,
	[Delete] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[Active] [int] NULL,
	[StatusID] [bit] NULL,
 CONSTRAINT [PK_RBA_Permissions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RBA_Roles]    Script Date: 9/10/2020 6:02:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RBA_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](200) NULL,
	[WorkFlowId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[NodeAccess] [int] NULL,
 CONSTRAINT [PK_RBA_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RBA_UserPermission]    Script Date: 9/10/2020 6:02:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RBA_UserPermission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](50) NULL,
	[NodeId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_RBA_UserPermission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RBA_UserRole]    Script Date: 9/10/2020 6:02:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RBA_UserRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](50) NULL,
	[RoleId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedBy] [nvarchar](50) NULL,
	[LastModifiedDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_RBA_UserRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RBA_Users]    Script Date: 9/10/2020 6:02:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RBA_Users](
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
	[LocationName] [varchar](256) NULL,
 CONSTRAINT [PK_PBA_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegexPattern_temp]    Script Date: 9/10/2020 6:02:15 PM ******/
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
/****** Object:  Table [dbo].[StatusNotes]    Script Date: 9/10/2020 6:02:16 PM ******/
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
/****** Object:  Table [dbo].[tblLogin]    Script Date: 9/10/2020 6:02:17 PM ******/
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
/****** Object:  Table [dbo].[tblRuleSet]    Script Date: 9/10/2020 6:02:17 PM ******/
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
/****** Object:  Table [dbo].[TestUser]    Script Date: 9/10/2020 6:02:18 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 9/10/2020 6:02:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](100) NULL,
	[Password] [nvarchar](max) NULL,
	[Role] [varchar](20) NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Token] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Voice_Details]    Script Date: 9/10/2020 6:02:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voice_Details](
	[TaskName] [nvarchar](50) NOT NULL,
	[groupName] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DecisionResults] ADD  CONSTRAINT [DF_DecisionResults_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[DecisionResults] ADD  CONSTRAINT [DF_DecisionResults_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[DecisionTreeResults] ADD  CONSTRAINT [DF_DecisionTreeResults_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[DecisionTreeResults] ADD  CONSTRAINT [DF_DecisionTreeResults_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[LMS_Designer] ADD  CONSTRAINT [DF_LMS_Designer12_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[LMS_Designer] ADD  CONSTRAINT [DF_LMS_Designer12_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[Logs] ADD  CONSTRAINT [df_logs_loggedondate]  DEFAULT (getutcdate()) FOR [LoggedOnDate]
GO
ALTER TABLE [dbo].[PBW_MailInformation] ADD  CONSTRAINT [DF__PBW_MailD__Statu__36B2B8F1]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[PBW_MailInformation] ADD  DEFAULT (getdate()) FOR [CreatedDt]
GO
ALTER TABLE [dbo].[PBWMenuMaster] ADD  DEFAULT ((0)) FOR [ShowCountOnMenu]
GO
ALTER TABLE [dbo].[PBWWorkFlowMaster] ADD  DEFAULT ((0)) FOR [IsWorkFlowActive]
GO
ALTER TABLE [dbo].[PBWWorkFlowMaster] ADD  DEFAULT ((0)) FOR [IsDataActive]
GO
ALTER TABLE [dbo].[tblRuleSet] ADD  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[TestUser] ADD  CONSTRAINT [DF_TestUser_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
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
/****** Object:  StoredProcedure [dbo].[AhsDecisionRule]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AHSPlatform_InsertComponent]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AHSPlatform_SelectJsonLoad]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AHSPlatformBusinessInsert]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AHSPlatformBusinessSelect]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AHSPlatformBusinessUpdate]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AhsSelectDecisionRule]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AhsSelectRole]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AhsSelectWorkFlowMaster]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ARC_GET_DATA_JSON]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ARC_GET_WORKFLOW_ID]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AthenaDecisionTreeUtilization]    Script Date: 9/10/2020 6:02:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[AthenaDecisionTreeUtilization](@fromDate datetime = null,@toDate datetime=null)
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
  FROM [ARC_AhsPlatform].[dbo].[DecisionTreeResults] d 
  join [ARC_AhsPlatform].[dbo].DecisionTreee r
   on d.DecisionId = r.DecisionId 
   join [ARC_AhsPlatform].[dbo].PBWUserMaster u
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
/****** Object:  StoredProcedure [dbo].[ComponentInitiate_New1]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DecisionTreeDetailedReport]    Script Date: 9/10/2020 6:02:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Exec DecisionTreeDetailedReport 
--Exec DecisionTreeSummaryReport

 


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
then dateadd(dd,-1,dr.CreatedDate) else dr.CreatedDate end as Date
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
/****** Object:  StoredProcedure [dbo].[DecisionTreeSummaryReport]    Script Date: 9/10/2020 6:02:20 PM ******/
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
then dateadd(dd,-1,Convert(date,dr.CreatedDate)) else Convert(date,dr.CreatedDate) end as Date
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
/****** Object:  StoredProcedure [dbo].[InsertLog]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Inventory_Insert]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Inventory_Insert_N]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Inventory_Insert_New]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[P_GET_PROCESS_RUNTIME]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAHSPlatformGetJsonValue]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spSaveAhsPlatformWorkflowTransaction]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spViewAhsPlatformWorkflowTransaction]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Update_PQID]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[usp_GetFinId]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspAHSPlatformGetJsonValue]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspCheckPendingTravelDeskStatus]    Script Date: 9/10/2020 6:02:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCheckPendingTravelDeskStatus]        
	@RequestId		INT,
	@WfId			INT,
	@Result			INT	OUTPUT  
AS        
BEGIN   
	/*                    
	PURPOSE           : GETTING MAILS INFORMATION USING SERVICE INTO DB                
	CREATED BY        : PRABAAKARAN T                    
	CREATED DATE      :	22 SEP 2017  
	*/      
	
	SELECT 
		@Result = COUNT(RequestId) 
	FROM pbwworkflowtransaction 
	WHERE Status in ('AcknowledgedTD','PendingTDR','Approved') AND RequestId = @RequestId AND WorkflowId = @WfId 
	
END


GO
/****** Object:  StoredProcedure [dbo].[uspCheckTravelDeskMailExists]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetApprovalRoleId]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetDocument]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetDocumentAll]    Script Date: 9/10/2020 6:02:20 PM ******/
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
	@WfId INT
AS   
-- EXEC [uspGetDocumentAll] 1
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
	SELECT ROW_NUMBER() OVER(ORDER BY FileId) SNo,* FROM dbo.PBWDocuments WHERE WfId = @WfId
END 
 

 

GO
/****** Object:  StoredProcedure [dbo].[uspGetExceptionTransactionFin]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetExceptionTransactionWfID]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetFacilityMaster]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetFirstNameLastName]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetMailId]    Script Date: 9/10/2020 6:02:20 PM ******/
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
-- EXEC uspGetMailId  'JITHESH.SUNDARA','MD' 
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
 
 
	IF EXISTS(SELECT 1 FROM #RoleMail WHERE UPPER(RoleMailName) IN ('COO','MD','FINANCE','CEO','TRAVELDESK','FM','PE','PM','VC','PH','Legal'))
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
		AND URM.WorkflowId = @WfId	AND PWR.WfId = @WfId	
	END
	ELSE
	BEGIN
		INSERT INTO #Temp4(RoleName,UserId,EmailId)
		SELECT RoleName,UserId,EmailId FROM #Temp2		
	END
	
 
 
	SELECT DISTINCT T4.RoleName,UserId,EmailId FROM #Temp4 AS T4 
	INNER JOIN PBWWorkFlowRoleMaster AS W 
	ON T4.RoleName = W.RoleName WHERE W.HierarchyLevel >= (
	SELECT DISTINCT WFRM.HierarchyLevel FROM PBWUserRoleMapping AS RM
	INNER JOIN PBWWorkFlowRoleMaster AS WFRM ON RM.RoleId = WFRM.RoleId  WHERE WFRM.WfId = @WfId AND RM.WorkflowId = @WfId AND RM.UniqueId = @NT_UserName) 
	UNION
	SELECT DISTINCT RoleName,UserId,EmailId FROM #Temp3 AS T3 WHERE T3.EmailId NOT IN (SELECT T4.EmailId FROM #Temp4 AS T4)
END  




GO
/****** Object:  StoredProcedure [dbo].[uspGetMasterData]    Script Date: 9/10/2020 6:02:20 PM ******/
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
 @Field NVARCHAR(100)
AS   
-- EXEC uspGetRules 1,1
BEGIN 
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELPBWMasterDataECT statements.  
 SET NOCOUNT ON;  
 
	SELECT MasterDataId,Value FROM dbo.PBWMasterData WHERE WorkflowId = @WorkflowId AND Field = @Field ORDER BY Value
END  
 

GO
/****** Object:  StoredProcedure [dbo].[uspGetMenus]    Script Date: 9/10/2020 6:02:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  RAMESHKUMAR  
-- Create date: Jun/06/2017  
-- Description: GetJSON Value  
-- =============================================  
CREATE PROCEDURE  [dbo].[uspGetMenus]  
 -- Add the parameters for the stored procedure here 
 @WfId INT,  
 @NT_UserName VARCHAR(256)
AS   
-- EXEC [uspGetMenus]  'rameshkumar.r1'
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  SELECT distinct Name,ActionName,ControllerName,ShowCountOnMenu,OrderNo FROM PBWMenuMaster PM INNER JOIN PBWMenuRoleMapping AS PMM ON PM.Id=PMM.MenuId 
  INNER JOIN PBWUserRoleMapping AS PRM ON PMM.RoleId = PRM.RoleId
  WHERE PRM.UniqueId = @NT_UserName
  order by OrderNo
END




GO
/****** Object:  StoredProcedure [dbo].[uspGetPerDiem]    Script Date: 9/10/2020 6:02:20 PM ******/
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
 @TravelBy VARCHAR(256),
 @NT_UserName VARCHAR(256)
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
	,dbo.Split_PerDiem(ThenAction,'&','=','Accommodation') Accomodation
	,dbo.Split_PerDiem(ThenAction,'&','=','OtherExpenses') OtherExpenses
	 INTO #TempFindRules FROM FindRules 	
	 
 
	 SELECT T.*,CASE WHEN Designation = '1' OR Designation = '2' THEN 'Bus,Train' ELSE 'Bus,Train,Flight' END TravelByEligibilty  FROM dbo.PBWUserMaster AS U
	 INNER JOIN dbo.PBWUserDesignation AS UD ON UD.RoleId = U.RoleId
	 INNER JOIN #TempFindRules AS T ON UD.Band = T.Designation
	 WHERE T.TravelType = @TravelType AND T.TravelBy = @TravelBy AND U.UniqueId = @NT_UserName
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPerDiemAll]    Script Date: 9/10/2020 6:02:20 PM ******/
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
	SELECT ROW_NUMBER() OVER(ORDER BY RuleId) SNo,RuleName,Description
	,dbo.Split_PerDiem(Condition,'~','=','TravelType') TravelType
	,dbo.Split_PerDiem(Condition,'~','=','TravelBy') TravelBy
	,dbo.Split_PerDiem(Condition,'~','=','Band') Designation
	,dbo.Split_PerDiem(ThenAction,'&','=','PerDiem') PerDiem
	,dbo.Split_PerDiem(ThenAction,'&','=','Accommodation') Accommodation
	,dbo.Split_PerDiem(ThenAction,'&','=','OtherExpenses') OtherExpenses
	 FROM FindRules 	 
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetPerDiemDesignation]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetProcessedHistory]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetRole]    Script Date: 9/10/2020 6:02:20 PM ******/
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
-- EXEC uspGetRole  'prabaakaran.t',1 
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
	INNER JOIN PBWWorkFlowRoleMaster AS WFR ON URM.RoleId = WFR.RoleId 
	ORDER BY Position 
END  



GO
/****** Object:  StoredProcedure [dbo].[uspGetRoleId]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspGetRules]    Script Date: 9/10/2020 6:02:20 PM ******/
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
	WHERE RSM.RuleSetId = @RuleSetId
END  
 

GO
/****** Object:  StoredProcedure [dbo].[uspGetTravelDeskAttachment]    Script Date: 9/10/2020 6:02:20 PM ******/
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
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetUserDetails]    Script Date: 9/10/2020 6:02:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC uspGetUserDetails @USERID = 'prabaakaran.t'
	EXEC uspGetUserDetails @USERID = ''
*/
CREATE PROCEDURE [dbo].[uspGetUserDetails]
	@UserId	VARCHAR(100) 
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @ImageRootPath		VARCHAR(100) = 'https://arc.accesshealthcare.co/IISFS/'
	DECLARE @ImageFolderPath	VARCHAR(100) = 'arc_rec/images/candidate/ProfileImage/thumb_'
	
	IF ISNULL(@UserId,'') = ''
	BEGIN
		SELECT
			UserId,FirstName,LastName,DepartmentId,RoleId,ClientId,EmailId,SupervisorId,UserLob,UserClient,
			@ImageRootPath+@ImageFolderPath+ISNULL(UserImageName,'') [UserImage] 
			,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,Active,Grade,LocationName
		FROM PBWUserMaster 
	END
	ELSE
	BEGIN
		SELECT
			UserId,FirstName,LastName,DepartmentId,RoleId,ClientId,EmailId,SupervisorId,UserLob,UserClient,
			@ImageRootPath+@ImageFolderPath+ISNULL(UserImageName,'') [UserImage] 
			,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,Active,Grade,LocationName
		FROM PBWUserMaster 
		WHERE ISNULL(UserID,'') = @USERID
	END
		
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetUserInfo]    Script Date: 9/10/2020 6:02:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	EXEC uspGetUserInfo @ClientId = 1,@USERID = 'prabaakaran.t'
	EXEC uspGetUserInfo @ClientId = 1,@USERID = ''
*/
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

	SET NOCOUNT ON
	
	DECLARE @ImageRootPath		VARCHAR(100) = 'https://arc.accesshealthcare.co/IISFS/'
	DECLARE @ImageFolderPath	VARCHAR(100) = 'arc_rec/images/candidate/ProfileImage/thumb_'
	
	SELECT 
		UserId,FirstName,LastName,DepartmentId,
		RoleId,ClientId,EmailId,SupervisorId,
		CreatedBy,CreatedDate,LastModifiedBy,
		LastModifiedDate,UniqueId,Id,UserLob,
		UserClient, @ImageRootPath+@ImageFolderPath+ISNULL(UserImageName,'') [UserImage] 
	FROM PBWUserMaster 
	WHERE ( UserID = @USERID OR @USERID = '' ) AND ClientId = @ClientId
		
	SET NOCOUNT OFF
END




GO
/****** Object:  StoredProcedure [dbo].[uspGetWaitingForApproval]    Script Date: 9/10/2020 6:02:20 PM ******/
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
-- EXEC uspGetWaitingForApproval 3,'Surendher.s',''        
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
    
 SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U      
 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId       
 INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId      
 WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId AND UPPER(W.Status) = @Status        
 UNION      
 SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U      
 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) = @Status    
 AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE W.WorkflowId = @WorkflowId AND RoleName IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','Legal'))  
 AND W.WorkflowId = @WorkflowId  
END  
ELSE  
BEGIN  
   
 SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U      
 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId       
 INNER JOIN #TempSubOrdinates AS T ON W.UserId = T.UserId      
 WHERE W.WorkflowId = @WorkflowId AND U.UniqueId = @UserId   AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','REVIEWED')   
 UNION      
 SELECT W.* FROM dbo.PBWWorkflowTransaction  AS W INNER JOIN PBWUserRoleMapping AS U      
 ON U.UniqueId =@UserId AND W.RoleId = U.RoleId AND UPPER(W.Status) IN ('PENDING','APPROVED','SUBMITTED','SUBMIT','SAVE','REVIEWED')  
 INNER JOIN PBWWorkFlowRoleMaster AS R ON U.RoleId = R.RoleId   
    AND W.RoleId IN (SELECT R.RoleId FROM PBWWorkFlowRoleMaster AS R WHERE  W.WorkflowId = @WorkflowId AND RoleName IN ('COO','MD','FINANCE','CEO','FM','PE','PM','VC','PH','Legal'))  
    AND W.WorkflowId = @WorkflowId  
 --WHERE UPPER(R.RoleName) NOT IN ('DEPARTMENTHEAD')  
 --AND W.RoleId NOT IN (SELECT R.RoleId FROM PBWUserRoleMapping AS R WHERE UniqueId = @UserId)  
END  
   
       
 IF OBJECT_ID('TEMPDB..#TempSubOrdinates') IS NOT NULL      
  DROP TABLE #TempSubOrdinates      
END 
GO
/****** Object:  StoredProcedure [dbo].[uspGetWorkFlowRoleMaster]    Script Date: 9/10/2020 6:02:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetWorkFlowRoleMaster]
	@Fin AS INT = 0,
	@WfId	INT = 0
AS
BEGIN
	IF ISNULL(@Fin,0) != 0
	BEGIN
		SELECT DISTINCT RoleId,RoleName FROM PBWWorkFlowRoleMaster AS W WHERE W.HierarchyLevel > (
		SELECT WFRM.HierarchyLevel FROM PBWWorkflowTransaction AS T INNER JOIN 
		PBWUserRoleMapping AS RM ON T.UserId = RM.UniqueId 
		INNER JOIN PBWWorkFlowRoleMaster AS WFRM ON WFRM.RoleId = RM.RoleId 
		WHERE Fin = @Fin AND WFRM.WfId=@WfId) AND WfId = @WfId
	END
	ELSE
	BEGIN
		SELECT RoleId,RoleName FROM PBWWorkFlowRoleMaster WHERE WfId = @WfId
	END
End


GO
/****** Object:  StoredProcedure [dbo].[uspInsertMailInformation]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSaveAhsPlatformWorkflowTransaction]    Script Date: 9/10/2020 6:02:20 PM ******/
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
	
	SET @DataJson = REPLACE(@DataJson,'.00','')
	IF NOT EXISTS(SELECT 1 FROM PBWWorkflowTransaction WHERE Fin = @FinId)    
	BEGIN
		SELECT @RequestId = MAX(RequestId) + 1 FROM  dbo.PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId  
		SET @RequestId = ISNULL(@RequestId,1)
	    
		INSERT INTO   dbo.PBWWorkflowTransaction  
		(WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId)        
		SELECT @WorkflowId,@DataJson,0 WorkFlowStateId,0 RoleId,@Status Status,@UserId,@UserId CreatedBy,GETDATE() CreatedDate,@UserId LastModifiedBy, GETDATE() LastModifiedDate,@RequestId  
	END    
	ELSE    
	BEGIN      
		INSERT INTO dbo.PBWWorkflowTransactionHistory    
		(Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId)    
		SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId FROM dbo.PBWWorkflowTransaction WHERE Fin = @FinId      

		UPDATE dbo.PBWWorkflowTransaction SET WorkflowId = @WorkflowId,DataJson = @DataJson,Status = @Status ,UserId = @UserId,LastModifiedBy = @UserId,LastModifiedDate = GETDATE() WHERE Fin = @FinId        
	END    
	SET @OutFinId = @@IDENTITY     
END   

GO
/****** Object:  StoredProcedure [dbo].[uspSaveDocument]    Script Date: 9/10/2020 6:02:20 PM ******/
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
			([FileName],Description,FilePath,WfId,CreatedBy,CreatedDate)
			SELECT @FileName,@Description,@FilePath,@WfId,@UserId,GETDATE()
			
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
/****** Object:  StoredProcedure [dbo].[uspSaveExceptionTransaction]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSavePerDiem]    Script Date: 9/10/2020 6:02:20 PM ******/
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
 @TravelBy VARCHAR(256),
 @Designation VARCHAR(256),
 @PerDiem VARCHAR(100),
 @Accommodation VARCHAR(100),
 @OtherExpenses VARCHAR(100),
 @SaveOrUpdate INT, -- 1 - SAVE, 2 - UPDATE
 @ResponseMessage VARCHAR(MAX) OUTPUT,
 @ResponseStatus BIT = 0 OUTPUT
AS   
-- EXEC uspSavePerDim 
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;   
 
 SET @PerDiem = REPLACE(@PerDiem,'.00','')
 SET @Accommodation = REPLACE(@Accommodation,'.00','')
 SET @OtherExpenses = REPLACE(@OtherExpenses,'.00','')

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
	,dbo.Split_PerDiem(Condition,'~','=','TravelType') TravelType
	,dbo.Split_PerDiem(Condition,'~','=','TravelBy') TravelBy
	,dbo.Split_PerDiem(Condition,'~','=','Band') Designation
	,dbo.Split_PerDiem(ThenAction,'&','=','PerDiem') PerDiem
	,dbo.Split_PerDiem(ThenAction,'&','=','Accommodation') Accommodation
	,dbo.Split_PerDiem(ThenAction,'&','=','OtherExpenses') OtherExpenses
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
			,'TravelType="'+ @TravelType +'~TravelBy="'+ @TravelBy +'"~Band="'+ @Designation +'"'
			,'PerDiem='+ CONVERT(VARCHAR(15),@PerDiem) +'&Accommodation='+ CONVERT(VARCHAR(15),@Accommodation) +'&OtherExpenses='+ CONVERT(VARCHAR(15),@OtherExpenses) +'' 
			INSERT INTO PRuleSetMapping
			(RuleSetId,RuleId,Version,IsActive)
			SELECT @RuleSetId,@@IDENTITY,1,1
			SET @ResponseStatus = 1
		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM #TempFindRules WHERE TravelType = @TravelType AND TravelBy = @TravelBy AND Designation = @Designation)
		BEGIN
			UPDATE P SET Condition = 'TravelType="'+ @TravelType +'~TravelBy="'+ @TravelBy +'"~Band="'+ @Designation +'"',
			ThenAction = 'PerDiem='+ CONVERT(VARCHAR(15),@PerDiem) +'&Accommodation='+ CONVERT(VARCHAR(15),@Accommodation) +'&OtherExpenses='+ CONVERT(VARCHAR(15),@OtherExpenses) +'' 
			FROM PRuleMaster AS P INNER JOIN #TempFindRules AS T ON P.RuleId = T.RuleId
			WHERE T.TravelType = @TravelType AND T.TravelBy = @TravelBy AND T.Designation = @Designation
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
/****** Object:  StoredProcedure [dbo].[uspSavePerDim]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSelectAhsPlatformWorkflowMaster]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSelectAhsPlatformWorkflowTransaction]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSelectPBWWorkFlowException]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspStudioGetDashboard]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspStudioGetWorkFlow]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSubmitAhsPlatformWorkflowTransaction]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSyncUserInfo]    Script Date: 9/10/2020 6:02:20 PM ******/
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
/****** Object:  StoredProcedure [dbo].[uspSyncUserRoleBasedAccess]    Script Date: 9/10/2020 6:02:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sivasankar.s1
-- Create date: 01Jan2017
-- Description:	Job to Create Role based access for Newly created Users
-- =============================================
CREATE PROCEDURE [dbo].[uspSyncUserRoleBasedAccess] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
INSERT RPA_UserRole
(UserId,RoleId)
SELECT DISTINCT NT_USERNAME,R.RoleId FROM (
SELECT NT_USERNAME
FROM arc_rec_user_info_temp Usr
INNER JOIN HR_Designation HR
on HR.DesigId=Usr.designation_ID 
INNER JOIN LocationMaster AS L ON Usr.LocationId = L.LocationID 
WHERE HR.Designation in (
'Trainee Client Partner',
'Assistant Client Partner',
'Client Partner',
'Senior Client Partner',
'Client Specialist',
'Executive Assistant',
'Senior Client Specialist')
AND L.Location = 'MANILA'
)X, RBA_Roles as R WHERE R.RoleName LIKE '%-LA-MA'


INSERT RPA_UserRole
(UserId,RoleId)
SELECT DISTINCT NT_USERNAME,R.RoleId FROM (
SELECT NT_USERNAME
FROM arc_rec_user_info_temp Usr
INNER JOIN HR_Designation HR
on HR.DesigId=Usr.designation_ID 
INNER JOIN LocationMaster AS L ON Usr.LocationId = L.LocationID 
WHERE HR.Designation NOT in (
'Trainee Client Partner',
'Assistant Client Partner',
'Client Partner',
'Senior Client Partner',
'Client Specialist',
'Executive Assistant',
'Senior Client Specialist')
AND L.Location = 'MANILA'
)X, RBA_Roles as R WHERE R.RoleName LIKE '%-MA'


INSERT RPA_UserRole
(UserId,RoleId)
SELECT DISTINCT NT_USERNAME,R.RoleId FROM (
SELECT NT_USERNAME
FROM arc_rec_user_info_temp Usr
INNER JOIN HR_Designation HR
on HR.DesigId=Usr.designation_ID 
INNER JOIN LocationMaster AS L ON Usr.LocationId = L.LocationID 
WHERE HR.Designation in (
'Trainee Client Partner',
'Assistant Client Partner',
'Client Partner',
'Senior Client Partner',
'Client Specialist',
'Executive Assistant',
'Senior Client Specialist')
AND L.Location != 'MANILA'
)X, RBA_Roles as R WHERE R.RoleName LIKE '%-LA-CH'


INSERT RPA_UserRole
(UserId,RoleId)
SELECT DISTINCT NT_USERNAME,R.RoleId FROM (
SELECT NT_USERNAME
FROM arc_rec_user_info_temp Usr
INNER JOIN HR_Designation HR
on HR.DesigId=Usr.designation_ID 
INNER JOIN LocationMaster AS L ON Usr.LocationId = L.LocationID 
WHERE HR.Designation NOT in (
'Trainee Client Partner',
'Assistant Client Partner',
'Client Partner',
'Senior Client Partner',
'Client Specialist',
'Executive Assistant',
'Senior Client Specialist')
AND L.Location != 'MANILA'
)X, RBA_Roles as R WHERE R.RoleName LIKE '%-CH'

END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateAhsPlatformWorkflowTransactionQueueRole]    Script Date: 9/10/2020 6:02:20 PM ******/
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
-- EXEC uspUpdateAhsPlatformWorkflowTransactionQueueRole 1 ,249  ,-21,2 
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements. 
	SET NOCOUNT ON;     
	
    SET @DataJson = REPLACE(@DataJson,'.00','')
	
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
	END	
	
	SELECT @_Status = Status  FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND Fin = @FinId     
	IF ISNULL(@_Status,'') = 'Approved' AND ISNULL(@Status,'') = 'Closed'
	BEGIN
		SET @_Status = 'Approved'	
	END
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
		
		IF ISNULL(@DataJSon,'') != ''
		BEGIN
			UPDATE PBWWorkflowTransaction SET DataJson = @DataJSon,[Status] = @Status WHERE WorkflowId = @WorkflowId AND Fin = @FinId  
		END   
	
		--ELSE IF @_MaxStatus = 'BillVerified'
		--	SET @_Status = 'Approved' 
		print @_Status
		print @_MaxStatus
		INSERT INTO PBWWorkflowTransactionHistory    
		(Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,Status,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId)    
		SELECT Fin,WorkflowId,DataJson,WorkFlowStateId,RoleId,CASE WHEN ISNULL(@_Status,'') != '' AND ISNULL(Status,'') != 'Rejected' THEN @_Status ELSE Status END,UserId,CreatedBy,CreatedDate,LastModifiedBy,LastModifiedDate,RequestId FROM PBWWorkflowTransaction WHERE WorkflowId = @WorkflowId AND Fin = @FinId     
		-- --UPDATE PBWWorkflowTransaction SET WorkFlowStateId = @WorkflowStepId, RoleId = @WorkflowRoleId WHERE WorkflowId = @WorkflowId AND Fin = @FinId   
		-- --END
		-- --ELSE
		-- --BEGIN
		-- --UPDATE PBWWorkflowTransaction SET WorkFlowStateId = @WorkflowStepId, RoleId = @WorkflowRoleId WHERE WorkflowId = @WorkflowId AND Fin = @FinId   
		-- --END
		UPDATE PBWWorkflowTransaction SET WorkFlowStateId = @WorkflowStepId, RoleId = @WorkflowRoleId WHERE WorkflowId = @WorkflowId AND Fin = @FinId   
  END
 
END    
   

GO
/****** Object:  StoredProcedure [dbo].[uspViewAhsPlatformWorkflowTransaction]    Script Date: 9/10/2020 6:02:20 PM ******/
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
