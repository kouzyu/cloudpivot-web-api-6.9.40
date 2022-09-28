
-- 字段调整为用户主键
update d_process_task,h_org_user set d_process_task.userId = h_org_user.id where h_org_user.userId = d_process_task.userId;

update d_process_instance,h_org_user set d_process_instance.originator = h_org_user.id where h_org_user.userId = d_process_instance.originator;
