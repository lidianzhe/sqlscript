use azBase
/*下面主要用于创建基础表
*/
---------------------------------------------------------------
---------------------------------------------------------------
/*基础表*/
if object_id('FK_OrganizationsPersonnel','F') is not null
	alter table base_Personnel drop constraint FK_OrganizationsPersonnel;
if object_id('base_Organizations') is not null
	drop table base_Organizations
if object_id('base_Dutykind') is not null
	drop table base_Dutykind
if object_id('base_TypeOfWork') is not null
	drop table base_TypeOfWork
if object_id('base_Level') is not null
	drop table base_Level
if object_id('base_Regime') is not null
	drop table base_Regime
if object_id('base_Personnel') is not null
	drop table base_Personnel
---------------------------------------------------------------------------------------------------------
/*
创建组织机构表
*/
create table dbo.base_Organizations (
    OrgId int identity(1,1) not null primary key, --整形组织机构编码
    DomainId uniqueidentifier  not null,
    OrgName nvarchar(100)  not null,--单位或部门名称
    ParentOrgId int  ,
    OrgCode nvarchar(50)  , --二位长度的组织机构编码
    OrgSequal varchar(256) , --单位序列编码
    SpellCode nvarchar(100)  ,
    BriefCode nvarchar(500)  ,
    ComputedOrgName nvarchar(500)   ,--完整的单位名称
    LeafNode bit  ,
    Depth tinyint  ,
    IsDeleted bit default 0 ,
    --保留接口
    if_OrgId	varchar(255) 
);
go
create  index UX_Organizations_OrgCode on base_Organizations(OrgCode)
create  index UX_Organizations_if_OrgId on base_Organizations(if_OrgId)

go
--------------------------------------------------------------
/*
创建职务表
*/
create table base_Dutykind(
	Id int identity(1,1) not null primary key,
	DutykindId int not null unique,
	DutykindName varchar(20)
)
go

--------------------------------------------------------------
/*
创建工种表
*/
create table base_TypeOfWork(
	Id int identity(1,1) not null primary key,
	TypeOfWorkId smallint  not null unique,
	TypeOfWorkName varchar(30) ,
	LimitTimeId smallint 
)
go
--------------------------------------------------------------
/*几线人员表*/
create table base_Level(
	Id int identity(1,1) not null primary key,
	LevelId smallint not null unique  ,
	LevelName varchar(10)
)
go
---------------------------------------------------------------------------------------------------------
/*用工制度表*/
create table base_Regime(
	Id int identity(1,1) not null primary key,
	RegimeId smallint not null unique,
	RegimeName varchar(20)
)
go
---------------------------------------------------------------------------------------------------------
/*创建人员信息表*/
create table dbo.base_Personnel (
    	PersonId int identity(1,1) not null primary key,
    	OrgId int  not null,
    	Name nvarchar(50)  not null, --姓名
	Pinyin varchar(10) , --简拼
	FullPinyin nvarchar(50), --全拼
    	Sex nvarchar(3)  , --性别
    	Age int  , --年龄
		IdentityCard varchar(18),
	MobilePhone varchar(20), --手机
	Address nvarchar(50), --住址
	IsDeleted bit default 0 , --是否已减员(软删除)
----
	RegimeId smallint,
	TypeOfWorkId smallint,
	DutykindId smallint default 1,
	LevelId smallint, --几线人员
----
	Photo image, --相片
	IsKeepped bit, --保留人员,特殊用途
----保留接口
	if_PersonId	varchar(255)
);
go

create index IX_base_Personnel_Pinyin on base_Personnel(Pinyin)
create index IX_base_Personnel_OrgId on base_Personnel(OrgId)
create index IX_base_Personnel_PersonId on base_Personnel (PersonId)
--
create index IX_base_Personnel_if_PersonId on base_Personnel (if_PersonId)

go
alter table base_Personnel add constraint FK_OrganizationsPersonnel
	foreign key (OrgId) references base_Organizations(OrgId)
------------------------------------------------------------------------------------------------------
