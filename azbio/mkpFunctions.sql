use azBase

if object_id('dzYYYYMM') is not null
	drop function dzYYYYMM

if object_id('dzHasColumn') is not null
	drop function dzHasColumn
go


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[dzFillLeader]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[dzFillLeader]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[dzFillZero]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[dzFillZero]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[dzFormat]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[dzFormat]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[dzFormatStr]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[dzFormatStr]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[dzFormatTemplate]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[dzFormatTemplate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[dzSplitInt]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[dzSplitInt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[dzSplitStr]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[dzSplitStr]
GO
if object_id('dzMax') is not null
	drop function dzMax
go
if object_id('dzMin') is not null
	drop function dzMin
go
------------------------------------------------------------------------------------------------------------

CREATE FUNCTION dbo.dzFillLeader (
	@sourcestr 	varchar(20),
	@len		smallint,
	@leader	char(1)
)
RETURNS varchar(20)  
with encryption
AS  
BEGIN 
	RETURN (REPLICATE(@leader, @len - LEN(RTRIM(@sourcestr))) + RTRIM(@sourcestr))
END

GO
---------------------------------------------------------------------------------------------------------
CREATE FUNCTION dbo.dzFillZero (
	@sourcestr 	varchar(20),
	@len		smallint)
RETURNS varchar(20)  
with encryption
AS  
BEGIN 
	RETURN (REPLICATE('0', @len - LEN(RTRIM(@sourcestr))) + RTRIM(@sourcestr))
END
------------------------------------------------------------------------------------------------------------------
GO

CREATE FUNCTION  dzFormat (
	@format	varchar(255),
	@para1	varchar(60),
	@para2	varchar(60) =''
)  
RETURNS varchar(255) 
with encryption
AS  
BEGIN 
	DECLARE @result varchar(255)
	EXECUTE master..xp_sprintf @result OUTPUT,@format, @para1, @para2
	RETURN @result
	
END

GO
---------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION  dzFormatStr (
	@source	varchar(8000),
	@beginflag	varchar(6),
	@endflag	varchar(6),
	@para1	varchar(20),
	@para2	varchar(20)=''
)  
RETURNS varchar(8000) 
with encryption
AS  
BEGIN 
--set @source = '/*< Sum(Wage.%s) As %s, />*/ select /*< %s />*/ from dept/*< haa%s />*/'
--DECLARE @endflag varchar(4)
DECLARE @template varchar(100)
DECLARE @bpos smallint
DECLARE @epos smallint
DECLARE @formatstr varchar(200)
--SET @endflag = '0/>*/'
SET @bpos = CHARINDEX(@beginflag, @source,  0 )
SET @epos = CHARINDEX( @endflag, @source, @bpos)
WHILE @bpos > 0 AND @epos >0
BEGIN
  	SET @template = SUBSTRING( @source,@bpos,@epos-@bpos+LEN(RTRIM(@endflag)))
	SET @formatstr = dbo.dzFormatTemplate( @template, @beginflag, @endflag, @para1, @para2)
	SET @source = STUFF( @source, @bpos,len(@template), @formatstr)
	IF @bpos>100
		SET @source = STUFF(@source,@bpos,0,CHAR(10));
	SET @bpos = @bpos + LEN(@formatstr)
	SET @bpos = CHARINDEX(@beginflag, @source,  @bpos )
	SET @epos = CHARINDEX( @endflag, @source, @bpos)
END
RETURN @source	
END

--------------------------------------------------------------------------------------------------------------------------------------
GO

CREATE FUNCTION  dzFormatTemplate(
	@template	varchar(255),
	@beginflag	varchar(6),
	@endflag	varchar(6),
	@para1	varchar(60),
	@para2	varchar(60) =''
)  
RETURNS varchar(255) 
with encryption
AS  
BEGIN 
	DECLARE @result varchar(255)
	DECLARE @content varchar(255)
	IF CHARINDEX(  @beginflag,@template ) =0 OR CHARINDEX( @endflag,@template ) =0
		RETURN NULL
	SET @content = REPLACE( @template, @beginflag, '')
	SET @content = REPLACE( @content, @endflag, '' )
	RETURN dbo.dzFormat( @content, @para1, @para2) + @template
END


GO
-------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
GO

CREATE FUNCTION  dzSplitInt ( 
	@source	int
)  
RETURNS @table TABLE( parseval int) 
with encryption
AS  
BEGIN 
	WHILE @source >0 BEGIN
		INSERT @table SELECT @source % 10
		SET @source = @source /10 
	END
	RETURN
END


GO


/* 功能: 分离字符串
 * 参数: @source 被分离的字符串列.
 *	@seperator 分离符
 * 返回: 表 -- 每条记录代表一个被分离的子字符串
 *
 * 作者: 李红军			日期: 2003-3-30 17:52:39
 */
CREATE FUNCTION  dzSplitStr(
	@source	varchar(8000),
	@separator	char(1) = ';'
)  
RETURNS @table TABLE( strvalue varchar(255)  )
with encryption
AS  
BEGIN 
	DECLARE @pos smallint, @begin smallint, @item varchar(255)
	SET @begin =1
	WHILE (CHARINDEX(@separator, @source, @begin))>0
	BEGIN
		SET @pos = CHARINDEX(@separator, @source, @begin)
		SET @item = SUBSTRING(@source, @begin, @pos- @begin)
		/*插入记录*/
		INSERT @table VALUES ( @item) 
		SET @begin = @pos+1
	END	
	--插入最后的字符串
	SET @item = SUBSTRING( @source , @begin, LEN(@source))
	INSERT @table VALUES ( @item )
	RETURN 
	
END

go
/*-------------------------------------------------------------------------------------------------------------------------------------------------
Author: lihongjun	2001
Revision: 支持二位年表示 lihongjun 2005-03-28
*/-------------------------------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION dbo.dzYYYYMM( 
	@yyyymm	varchar(6),
	@val		smallint)
RETURNS varchar(6)
with encryption
AS  
BEGIN 
	DECLARE @newmm  smallint
	DECLARE @result	varchar(6)
	DECLARE @yearlen	smallint
	SET @yearlen =  len(@yyyymm) -2
	
	SET @newmm =  right( @yyyymm, 2) + @val
	IF @val >0 
	BEGIN
		IF @newmm > 12
			SET @result =  dbo.dzFillZero( substring ( @yyyymm, 1 , @yearlen) + ceiling( (@newmm) / 12 ), @yearlen) + dbo.dzFillZero( (@newmm) % 12  , 2)
		ELSE
			SET @result =  substring ( @yyyymm, 1 , @yearlen ) +  dbo.dzFillZero( @newmm  , 2)
			
	END	
	ELSE
	BEGIN
		IF @newmm  <=  0
			SET @result =  dbo.dzFillZero( substring( @yyyymm, 1 , @yearlen) + ceiling( (@newmm-12) / 12 ), @yearlen) + dbo.dzFillZero( 12+@newmm% 12  , 2)
		ELSE
			SET @result =  substring(@yyyymm, 1, @yearlen) + dbo.dzFillZero( @newmm, 2)
	END
	RETURN @result
END
go
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
功能：判断表中是否有指定的列
用法：print dbo.dzHasColumn('KQ_Information','WorkMeal')
*/
create function dzHasColumn(
	@TableName	varchar(50),
	@ColumnName varchar(50)
)
returns bit 
with encryption
as 
begin
	declare @result bit
	set @result = 0
	select @result = 1 from syscolumns 
	where id=object_id(@TableName) and name=@ColumnName
	return @result
end
go
-----------------------------------------------------------------------------------------------------------------

go
-----------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
create function dzMax(
	@param1 numeric(12,2),
	@param2 numeric(12,2)
)
returns numeric(12,2) 
as
begin
	declare @max numeric(12,2)
	if @param1 > @param2
		set @max = @param1
	else
		set @max =  @param2
	
	return @max
end
go
-----------------------------------------------------------------------------------------


create function dzMin(
	@param1 numeric(12,2),
	@param2 numeric(12,2)
)
returns numeric(12,2) 
as
begin
	declare @min numeric(12,2)
	if @param1 < @param2
		set @min = @param1
	else
		set @min =  @param2
	
	return @min
end
