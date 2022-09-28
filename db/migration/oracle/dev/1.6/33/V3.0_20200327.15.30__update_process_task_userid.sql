
update d_process_task hpt set hpt.userId = (select hou.id from h_org_user hou where hpt.userId = hou.userId)
where exists (select userId from h_org_user hou where hou.userId = hpt.userId);

update d_process_instance hpi set hpi.originator = (select hou.id from h_org_user hou where hpi.originator = hou.userId)
where exists (select hou.userId from h_org_user hou where hou.userId = hpi.originator);
