ALTER TABLE h_log_business_rule_header ADD (sourceFlowInstanceId varchar2(360) null);

ALTER TABLE h_log_business_rule_header ADD (repair number(1, 0) null);

ALTER TABLE h_log_business_rule_header ADD (extend varchar2(765) null);