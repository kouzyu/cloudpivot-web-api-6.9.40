-- 补偿appcode
update biz_workflow_instance w SET w.appCode = (
SELECT c.appCode FROM (
SELECT a.appCode,b.workflowCode FROM h_app_function a,
(SELECT DISTINCT t.workflowCode,t.schemaCode FROM h_workflow_header t GROUP BY t.workflowCode,t.schemaCode) b
WHERE a.`code`=b.schemaCode) c WHERE c.workflowCode=w.workflowCode
);