# 注意

## 部署迁移脚本

* {db}/deploy/install/all_init.sql 是汇总所有版本的SQL迁移脚本, 适用于全新安装云枢
* {db}/deploy/upgrade/**/*.sql 按版本提供的增量SQL迁移脚本, 适用于从低版本升级云枢. 请注意不要跳过版本执行迁移

## 开发迁移脚本

{db}/dev/**/*.sql 为云枢产品迭代开发中使用的SQL迁移脚本
