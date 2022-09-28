DROP PROCEDURE IF EXISTS updateCorpIdIsNull;

CREATE PROCEDURE updateCorpIdIsNull()
BEGIN

DECLARE MY_CORPID VARCHAR(50);
DECLARE IS_CLOUD_PIVOT VARCHAR(50); 

SET MY_CORPID = (select hss.paramValue from h_system_setting hss where hss.paramCode = 'dingtalk.client.corpId');
if MY_CORPID is not null then
	update h_org_user set corpId = MY_CORPID where corpId is null;
	update h_org_department set corpId = MY_CORPID where corpId is null;
	update h_org_role set corpId = MY_CORPID where corpId is null;
	update h_org_role_group set corpId = MY_CORPID where corpId is null;
else
	SET IS_CLOUD_PIVOT = (select hss.paramValue from h_system_setting hss where hss.paramCode = 'cloudpivot.load.is_cloud_pivot');
	if IS_CLOUD_PIVOT = '1' then
		update h_org_user set corpId = 'main' where corpId is null;
		update h_org_department set corpId = 'main' where corpId is null;
		update h_org_role set corpId = 'main' where corpId is null;
		update h_org_role_group set corpId = 'main' where corpId is null;
	end if;
end if;

END;

CALL updateCorpIdIsNull();