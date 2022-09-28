ALTER TABLE h_timer_job ADD (taskId VARCHAR(120) DEFAULT null);
comment on column h_timer_job.taskId is '任务id';

ALTER TABLE h_job_result ADD (taskId VARCHAR(120) DEFAULT null);
comment on column h_job_result.taskId is '任务id';