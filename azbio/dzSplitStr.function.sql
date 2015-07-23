use azdomain
if object_id('dzSplitStr') is not null
	exec('drop function dbo.dzSplitStr')
go
/*
select * from az_Roles where roleid in(
select value from dbo.dzSplitStr('1;2',';')
) 
*/
create function  dbo.dzSplitStr(
	@source	varchar(max),
	@separator	char(1) = ';'
)  
RETURNS @table TABLE( value varchar(255)  )
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
