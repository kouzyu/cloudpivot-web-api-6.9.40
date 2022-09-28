
CREATE INDEX idx_h_biz_attachment_refid ON h_biz_attachment ( refid );

CREATE INDEX idx_workflow_template_c_v ON h_workflow_template ( workflowCode, workflowVersion );

CREATE INDEX idx_biz_query_column_q_s ON h_biz_query_column ( queryId, sortKey );

CREATE INDEX idx_biz_query_condition_q_s ON h_biz_query_condition ( queryId, sortKey );

CREATE INDEX idx_org_user_username_corpid ON h_org_user ( username, corpId );