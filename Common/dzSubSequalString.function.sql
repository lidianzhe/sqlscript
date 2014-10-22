use azdomain
if object_id('dzSubSequalString') is null
	exec('create function dzSubSequalString() returns int as begin return 0 end')
go
/*
function:获取指定级别以后字符串
print dbo.dzSubSequalString('123.21.23',2)
*/
alter function [dbo].[dzSubSequalString](
	@source varchar(256),
	@beginlevel int
)
returns varchar(500)
as 
begin
	if @beginlevel>dbo.dzGetSequalLevel(@source)
		return ''
	declare @pos int,@i int,@priorpos int
	select @i=1,@pos=0
	while @i<=@beginlevel
	begin
		set @priorpos = @pos
		set @pos=charindex('.',@source,@pos+1)
		set @i=@i+1
	end
	if @pos=0
		set @pos=len(@source)+1
	return substring(@source,@priorpos+1,len(@source))
end

go

