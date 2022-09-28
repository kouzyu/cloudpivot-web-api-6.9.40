ALTER TABLE `h_workflow_header` ADD COLUMN `visibleType` varchar(40) NOT NULL DEFAULT 'PART_VISIABLE'
COMMENT '流程可见范围类型，ALL_VISIABLE: 全部人员可见， PART_VISIABLE：部分可见';