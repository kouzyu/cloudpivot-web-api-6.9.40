ALTER TABLE h_workflow_header ADD (VISIBLETYPE varchar2(40) DEFAULT 'PART_VISIABLE' NOT NULL);
comment on column h_workflow_header.VISIBLETYPE is '流程可见范围类型，ALL_VISIABLE: 全部人员可见， PART_VISIABLE：部分可见';