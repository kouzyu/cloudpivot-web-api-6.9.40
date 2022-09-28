create table h_open_api_event
(
	id varchar2(120) not null
		primary key,
	callback varchar2(400) null,
	clientId varchar2(30) null,
	eventTarget varchar2(300) null,
	eventTargetType varchar2(255) null,
	eventType varchar2(255) null
);