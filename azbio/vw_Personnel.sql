use azBase
if object_id('vw_Personnel') is null
	exec ('create view vw_Personnel as select 1 as ''a'';')
go

alter view vw_Personnel
as
select 
    	p.PersonId,
    	p.OrgId,
	o.ParentOrgId,
	o.OrgSequal,
	o.OrgCode,
	o.OrgName,
    	p.Name, 
	p.Pinyin, 
	p.MobilePhone, 
	o.ComputedOrgName,
	p.IsDeleted, 
	IsKeepped
from base_Personnel p inner join base_Organizations o
	on p.OrgId = o.OrgId



