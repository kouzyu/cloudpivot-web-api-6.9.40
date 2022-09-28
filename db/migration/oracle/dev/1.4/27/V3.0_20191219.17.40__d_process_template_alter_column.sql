ALTER TABLE d_process_template RENAME COLUMN wfWorkItemId TO queryId;
ALTER TABLE d_process_template MODIFY (queryId VARCHAR(42));
comment on column d_process_template.queryId is '列表ID';