use azdomain
if object_id('dzGetSequalString') is null
	exec('create function dzGetSequalString() returns int as begin return 0 end')
go
/*
print dbo.dzGetSequalString('12.22.33',2)
*/
alter function dzGetSequalString(
	@source varchar(256),
	@level int
)
returns nvarchar(50)
as 
begin
	if @Level>dbo.dzGetSequalLevel(@source)
		return 0
	declare @pos int,@i int,@priorpos int
	select @i=1,@pos=0
	while @i<=@level
	begin
		set @priorpos = @pos
		set @pos=charindex('.',@source,@pos+1)
		set @i=@i+1
	end
	if @pos=0
		set @pos=len(@source)+1
	return substring(@source,@priorpos+1,@pos-@priorpos-1)
end
go

