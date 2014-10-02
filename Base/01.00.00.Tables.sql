use azBase
/*������Ҫ���ڴ���������
*/
---------------------------------------------------------------
---------------------------------------------------------------
/*������*/
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
������֯������
*/
create table dbo.base_Organizations (
    OrgId int  not null primary key, --������֯��������
    DomainId uniqueidentifier  not null,
    OrgName nvarchar(100)  not null,--��λ��������
    ParentOrgId int  ,
    OrgCode nvarchar(50)  , --��λ���ȵ���֯��������
    OrgSequal varchar(256) , --��λ���б���
    SpellCode nvarchar(100)  ,
    BriefCode nvarchar(500)  ,
    ComputedOrgName nvarchar(500)   ,--�����ĵ�λ����
    LeafNode bit  ,
    Depth tinyint  ,
    IsDeleted bit default 0 
);
go
create unique index UX_Organizations_DomainId on base_Organizations(DomainId)
go
--------------------------------------------------------------
/*
����ְ���
*/
create table base_Dutykind(
	Id int identity(1,1) not null primary key,
	DutykindId int not null unique,
	DutykindName varchar(20)
)
go

--------------------------------------------------------------
/*
�������ֱ�
*/
create table base_TypeOfWork(
	Id int identity(1,1) not null primary key,
	TypeOfWorkId smallint  not null unique,
	TypeOfWorkName varchar(30) ,
	LimitTimeId smallint 
)
go
--------------------------------------------------------------
/*������Ա��*/
create table base_Level(
	Id int identity(1,1) not null primary key,
	LevelId smallint not null unique  ,
	LevelName varchar(10)
)
go
---------------------------------------------------------------------------------------------------------
/*�ù��ƶȱ�*/
create table base_Regime(
	Id int identity(1,1) not null primary key,
	RegimeId smallint not null unique,
	RegimeName varchar(20)
)
go
---------------------------------------------------------------------------------------------------------
/*������Ա��Ϣ��*/
create table dbo.base_Personnel (
    	PersonId int  not null primary key,
    	OrgId int  not null,
    	Name nvarchar(50)  not null, --����
	Pinyin varchar(10) , --��ƴ
	FullPinyin nvarchar(50), --ȫƴ
    	Sex nvarchar(3)  , --�Ա�
    	Age int  , --����
	MobilePhone varchar(20), --�ֻ�
	Address nvarchar(50), --סַ
	IsDeleted bit default 0 , --�Ƿ��Ѽ�Ա(��ɾ��)
----
	RegimeId smallint,
	TypeOfWorkId smallint,
	DutykindId smallint default 1,
	LevelId smallint, --������Ա
----
	Photo image, --��Ƭ
	IsKeepped bit --������Ա,������;
);
go

create index IX_base_Personnel_Pinyin on base_Personnel(Pinyin)
create index IX_base_Personnel_OrgId on base_Personnel(OrgId)
create index IX_base_Personnel_PersonId on base_Personnel (PersonId)
go
alter table base_Personnel add constraint FK_OrganizationsPersonnel
	foreign key (OrgId) references base_Organizations(OrgId)
------------------------------------------------------------------------------------------------------
