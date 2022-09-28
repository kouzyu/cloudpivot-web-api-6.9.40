create table h_open_api_event
(
	id varchar(120) not null
		primary key,
	callback varchar(400) null comment '回调地址',
	clientId varchar(30) null comment '客户端编号',
	eventTarget varchar(300) null comment '事件对象',
	eventTargetType varchar(255) null comment '事件对象类型',
	eventType varchar(255) null comment '事件触发类型'
);