use azdomain
if object_id('dzLeftSequalString') is null
	exec('create function dzLeftSequalString() returns int as begin return 0 end')
go
/*
function:获取指定级别的字符串(针对OrgSequal结构).
author:lihongjun 26/7/2011 22:11
print  dbo.dzLeftSequalString('1.23.323.23',3)
*/
alter function [dbo].dzLeftSequalString(
	@source varchar(256),
	@level int
)
returns varchar(500)
as 
begin
	if @level>=dbo.dzGetSequalLevel(@source)
		return @source
	declare @pos int,@i int,@priorpos int,@beginpos int ,@endpos int
	select @i=1,@pos=0
	while @i<=@level+1
	begin
		set @priorpos = @pos
		set @pos=charindex('.',@source,@pos+1)
		set @i=@i+1
	end
	return left(@source,@priorpos-1)
end

go

