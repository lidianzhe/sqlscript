use azbio;
drop procedure if exists base_Organizations_GenSequalData;
DELIMITER $$

/*
Function:生成结构化数据
Author:lihongjun 2011/05/12 22:38
call base_Organizations_GenSequalData
*/
create procedure base_Organizations_GenSequalData()
begin

declare i int default 1;
update base_Organizations set OrgSequal=abs(OrgId),ComputedOrgName = OrgName;


while (i=1) do
	update base_Organizations set OrgSequal=concat(b.OrgSequal,'.',a.OrgId),
		ComputedOrgName=concat(ifnull(b.ComputedOrgName,''),'.',a.OrgName)
	from base_Organizations a inner join (select * from base_Organizations) b
		on a.ParentOrgId=b.OrgId
	where   dbo.dzGetSequalString(a.OrgSequal,1) not in (
		select OrgId from base_Organizations where ParentOrgId is null
		);

	if row_count()=0 then
		set i=0;
	end if;
end while;

-- update base_Organizations set ComputedOrgName = dbo.dzSubSequalString(ComputedOrgName,3)
-- where dbo.dzGetSequalLevel(ComputedOrgName)>3
-- 
-- --update base_Personnel set FullOrgName = ComputedOrgName
-- --from base_Personnel p inner join base_Organizations o on
-- --	p.OrgId = o.OrgId
-- return 0
end$$

