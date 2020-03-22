DROP table push;
DROP SEQUENCE seq_push_id;


CREATE SEQUENCE seq_push_id		INCREMENT BY 1 START WITH 10000 NOCACHE;
CREATE TABLE push (
push_id varchar2(20),
push_type char(10),
ref_id varchar2(20),
push_date timestamp,
read char(10),
receiver_id varchar2(20),
cmt_count NUMBER,
primary key(push_id),
constraint FK_push foreign key(receiver_id)
references users(user_id)
);

