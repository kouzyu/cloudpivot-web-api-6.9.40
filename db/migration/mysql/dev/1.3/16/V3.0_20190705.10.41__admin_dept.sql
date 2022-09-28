INSERT IGNORE INTO `h_org_department` (`id`, `createdTime`, `creater`, `deleted`, `extend1`, `extend2`, `extend3`, `extend4`, `extend5`, `modifiedTime`, `modifier`, `remarks`, `calendarId`, `employees`, `leaf`, `managerId`, `name`, `parentId`, `sortKey`, `sourceId`, `sourceParentId`, `queryCode`)
VALUES ('1803c80ed28a3e25871d58808019816e', '2019-03-22 11:25:05', NULL, b'0', '', '', NULL, NULL, NULL, '2019-05-14 13:44:21', NULL, NULL, NULL, NULL, b'0', '', '管理部门', 'fc57a56529ef4e089b5b23162f063ca9', '0', NULL, NULL, '');

UPDATE `h_org_user` SET `departmentId`='1803c80ed28a3e25871d58808019816e' WHERE `id`='2c9280a26706a73a016706a93ccf002b';

INSERT IGNORE INTO `h_org_dept_user` (`id`, `createdTime`, `creater`, `deleted`, `modifiedTime`, `modifier`, `remarks`, `deptId`, `main`, `userId`)
VALUES ('a92a7856f16132c6a1884b08c3233236', '2019-03-22 11:25:07', NULL, b'0','2019-03-22 11:25:07', NULL, NULL, '1803c80ed28a3e25871d58808019816e', NULL, '2c9280a26706a73a016706a93ccf002b');
