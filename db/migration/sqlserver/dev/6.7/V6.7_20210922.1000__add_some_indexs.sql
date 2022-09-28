CREATE INDEX idx_h_biz_attachment_refid ON h_biz_attachment ( refid );
GO
CREATE INDEX idx_workflow_template_code_verison ON h_workflow_template ( workflowCode, workflowVersion );
GO
CREATE INDEX idx_biz_query_column_queryId_sortKey ON h_biz_query_column ( queryId, sortKey );
GO
CREATE INDEX idx_biz_query_condition_queryId_sortKey ON h_biz_query_condition ( queryId, sortKey );
GO
CREATE INDEX idx_org_user_username_corpid ON h_org_user ( username, corpId );
GO