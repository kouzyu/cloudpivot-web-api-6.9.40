alter table `h_biz_attachment` add index idx_h_biz_attachment_bizObjectId(`bizObjectId`);
alter table `h_biz_attachment` modify column parentBizObjectId varchar(36) default '';
alter table `h_biz_attachment` add index idx_h_biz_attachment_parentBizObjectId(`parentBizObjectId`);
