use azBase
if dbo.dzHasColumn('base_Personnel','RFCard')=0
	alter table base_Personnel add RFCard varchar(20)
if dbo.dzHasColumn('base_Personnel','LeftIrisTemplate')=0
	alter table base_Personnel add LeftIrisTemplate varbinary(1024)
if dbo.dzHasColumn('base_Personnel','RightIrisTemplate')=0
	alter table base_Personnel add RightIrisTemplate varbinary(1024)
