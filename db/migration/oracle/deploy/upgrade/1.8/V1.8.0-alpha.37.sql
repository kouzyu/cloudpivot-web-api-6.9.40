
ALTER TABLE h_org_department MODIFY (queryCode varchar2 (765));

ALTER TABLE biz_workitem ADD (batchOperate number(1, 0) DEFAULT null);
ALTER TABLE biz_workitem_finished ADD (batchOperate number(1, 0) DEFAULT null);
comment on column biz_workitem.batchOperate is '是否允许批量处理，0：否；1：是';
comment on column biz_workitem_finished.batchOperate is '是否允许批量处理，0：否；1：是';

ALTER TABLE h_workflow_header ADD (VISIBLETYPE varchar2(40) DEFAULT 'PART_VISIABLE' NOT NULL);
comment on column h_workflow_header.VISIBLETYPE is '流程可见范围类型，ALL_VISIABLE: 全部人员可见， PART_VISIABLE：部分可见';

ALTER TABLE h_biz_database_pool ADD (driverClassName varchar2(150) DEFAULT null);