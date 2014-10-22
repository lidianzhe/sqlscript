select  * from bsv5.dbo.dt_dep order by dep_serial,dep_parent

select user_serial,user_lname,user_sex,user_id,o.OrgId
from bsv5.dbo.dt_user bu inner join base_Organizations o 
	on bu.user_dep = o.if_OrgId

-- '7F07D26F-C3B5-4197-B811-29457F9B5374'
select * from base_Organizations
select * from base_Personnel

declare @domainid varchar(50)
set @domainid='7F07D26F-C3B5-4197-B811-29457F9B5374'
insert into base_Organizations(DomainId, if_OrgId,OrgName)
select @domainid, dep_serial,dep_name from bsv5.dbo.dt_dep order by dep_serial
update base_Organizations set ParentOrgId=t.OrgId from base_Organizations bo inner join(
	select o.OrgId,dep.dep_serial from base_Organizations o inner join bsv5.dbo.dt_dep dep on
		o.if_OrgId=dep.dep_parent
) t on bo.if_OrgId=t.dep_serial

insert into base_Personnel(if_PersonId,Name,Sex,IdentityCard,OrgId)
select user_serial,user_lname,user_sex,user_id,o.OrgId
from bsv5.dbo.dt_user bu inner join base_Organizations o 
	on bu.user_dep = o.if_OrgId

exec base_Organizations_GenSequalData
  
update base_Personnel set pinyin=dbo.dzGetPinyin(Name)
