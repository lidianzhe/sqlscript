use azInterface
/*---------------------------------------------------------------
Author: lihongjun 2014-09-05 10:29
门禁接口说明：
	1、实时向if_InoutRecords表中插入刷卡记录。
	2、关键字以PersonId为准，冗余设计了CardId及MobilePhone，这两个字段可以为空。
	3、if_InoutRecords向历史表迁移的工作 ，不用负责处理。
*/---------------------------------------------------------------

/*清理表*/
if object_id('if_InoutRecords') is not null
	drop table if_InoutRecords
go
if object_id('if_InoutHistory') is not null
	drop table if_InoutHistory
go
---------------------------------------------------------------------------------------------------------
/*
门禁出入记录表(只保留50天的数据)
*/
create table if_InoutRecords (
    InoutId int   identity(1,1) not null primary key  , --主关键字，自动增量
    PersonId int not null, --人员Id
    CardId  int , --卡号,冗余
    MobilePhone  int ,--手机号码，冗余
    InoutTime datetime not null, --刷卡时间
    InoutFlag smallint not null -- 进出标识， 0＝进，1＝出
);
go
create index UX_InoutRecords_PersonId on if_InoutRecords(PersonId)
go
/*门禁出入记录历史数据，备用*/
create table if_InoutHistory (
    InoutId int   identity(1,1) not null primary key  , --主关键字，自动增量
    PersonId int not null, --人员Id
    CardId  int , --卡号,冗余
    MobilePhone  int ,--手机号码，冗余
    InoutTime datetime not null, --刷卡时间
    InoutFlag smallint not null -- 进出标识， 0＝进，1＝出
);
go

