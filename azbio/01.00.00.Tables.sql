use azbio;
/*下面主要用于创建基础表
*/
-- -------------------------------------------------------------
-- -------------------------------------------------------------
DELIMITER ;	
drop index IX_base_Personnel_OrgId on base_Personnel(OrgId);
drop table if exists base_Personnel;
drop table if exists base_Organizations;
drop table if exists base_Dutykind;
drop table if exists base_TypeOfWork;
drop table if exists base_Level;
drop table if exists base_Regime;

-- -------------------------------------------------------------------------------------------------------
/*
创建组织机构表
*/
create table base_Organizations (
    OrgId int auto_increment not null primary key, /*整形组织机构编码*/
    DomainId varchar(36)  not null,
    OrgName nvarchar(100)  not null, 
    ParentOrgId int  ,
    OrgCode varchar(50)  , /*二位长度的组织机构编码*/
    OrgSequal varchar(256) , /*单位序列编码*/
    SpellCode varchar(100)  ,
    BriefCode varchar(500)  ,
    ComputedOrgName nvarchar(500)   ,/*完整的单位名称*/
    LeafNode bit  ,
    Depth tinyint  ,
    IsDeleted bit default 0 ,
    /*保留接口*/
    if_OrgId	varchar(50) ,
    index UX_baseOrganizations_OrgCode(OrgCode),
    index UX_baseOrganizations_if_OrgId(if_OrgId)
);

/*
创建职务表
*/
create table base_Dutykind(
	Id int auto_increment not null primary key,
	DutykindId int not null unique,
	DutykindName varchar(20)
);


-- ------------------------------------------------------------
/*
创建工种表
*/
create table base_TypeOfWork(
	Id int auto_increment not null primary key,
	TypeOfWorkId smallint  not null unique ,
	TypeOfWorkName varchar(30) ,
	LimitTimeId smallint 
);

-- ------------------------------------------------------------
/*几线人员表*/
create table base_Level(
	Id int  not null primary key,
	LevelId smallint not null unique  ,
	LevelName varchar(10)
);
-- -------------------------------------------------------------------------------------------------------
/*用工制度表*/
create table base_Regime(
	Id int auto_increment not null primary key,
	RegimeId smallint not null unique,
	RegimeName varchar(20)
);

-- -------------------------------------------------------------------------------------------------------
/*创建人员信息表*/
create table base_Personnel (
    	PersonId int auto_increment not null primary key,
    	OrgId int  not null,
    	Name nvarchar(50)  not null, -- 姓名
	Pinyin varchar(10) , -- 简拼
	FullPinyin nvarchar(50), -- 全拼
    	Sex nvarchar(3)  , -- 性别
    	Age int  , -- 年龄
		IdentityCard varchar(18),
	MobilePhone varchar(20), -- 手机
	Address nvarchar(100), -- 住址
	IsDeleted bit default 0 , -- 是否已减员(软删除)
	RegimeId smallint,
	TypeOfWorkId smallint,
	DutykindId smallint default 1,
	LevelId smallint, -- 几线人员
	Photo blob, -- 相片
	IsKeepped bit, -- 保留人员,特殊用途
-- 保留接口
	if_PersonId	varchar(255)
);


create index IX_base_Personnel_Pinyin on base_Personnel(Pinyin);
create index IX_base_Personnel_OrgId on base_Personnel(OrgId);
create index IX_base_Personnel_PersonId on base_Personnel (PersonId);
-- 
create index IX_base_Personnel_if_PersonId on base_Personnel (if_PersonId);

alter table base_Personnel add constraint FK_OrganizationsPersonnel
	foreign key (OrgId) references base_Organizations(OrgId);
-- ----------------------------------------------------------------------------------------------------
