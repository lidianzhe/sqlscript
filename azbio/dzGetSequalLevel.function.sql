use azdomain
if object_id('dzGetSequalLevel') is null
	exec('create function dzGetSequalLevel() returns int as begin return 0 end')
go
/*
print dbo.dzGetSequalLevel('1.2989.34.23')

*/

alter function dzGetSequalLevel(@source varchar(256))
returns int 
as
begin
	declare @pos int,@i int,@priorpos int
	select @i=1,@pos=0
	set @pos=charindex('.',@source)
	while @pos>0
	begin
		set @pos=charindex('.',@source,@pos+1)
		set @i=@i+1
	end
	return @i
end
