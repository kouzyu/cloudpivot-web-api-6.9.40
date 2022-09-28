INSERT IGNORE INTO `h_org_department` (`id`, `createdTime`, `creater`, `deleted`, `extend1`, `extend2`, `extend3`, `extend4`, `extend5`, `modifiedTime`, `modifier`, `remarks`, `calendarId`, `employees`, `leaf`, `managerId`, `name`, `parentId`, `sortKey`, `sourceId`, `sourceParentId`, `queryCode`)
VALUES ('06ef8c9a3f3b6669a34036a3001e6340', '2019-03-22 11:25:05', NULL, b'0', '', '', NULL, NULL, NULL, '2019-05-14 13:44:21', NULL, NULL, NULL, NULL, b'0', '', '外部', NULL, '0', NULL, NULL, '');

UPDATE `h_org_user` SET `departmentId`='06ef8c9a3f3b6669a34036a3001e6340' WHERE `id`='2ccf3b346706a6d3016706dc51c0022b';

INSERT IGNORE INTO `h_org_dept_user` (`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `remarks`, `deptId`, `main`, `userId`)
VALUES ('07df8b34e4469a00169a36a336450cf3', '2019-03-22 11:25:07', NULL, b'0','2019-03-22 11:25:07', NULL, NULL, '06ef8c9a3f3b6669a34036a3001e6340', NULL, '2ccf3b346706a6d3016706dc51c0022b');

