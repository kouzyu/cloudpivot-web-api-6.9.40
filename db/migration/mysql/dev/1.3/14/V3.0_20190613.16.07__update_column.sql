ALTER TABLE `h_im_work_record` MODIFY `workitemId` varchar(100) DEFAULT NULL;
ALTER TABLE `h_im_work_record` MODIFY `recordId` varchar(100) DEFAULT NULL;
ALTER TABLE `h_im_work_record` MODIFY `requestId` varchar(100) DEFAULT NULL;

ALTER TABLE `h_im_work_record_history` MODIFY `workitemId` varchar(100) DEFAULT NULL;
ALTER TABLE `h_im_work_record_history` MODIFY `recordId` varchar(100) DEFAULT NULL;
ALTER TABLE `h_im_work_record_history` MODIFY `requestId` varchar(100) DEFAULT NULL;