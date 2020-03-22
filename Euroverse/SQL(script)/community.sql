
DROP TABLE post;
DROP TABLE comments;
DROP TABLE likes;
DROP TABLE tag;

DROP SEQUENCE seq_post_post_id;
DROP SEQUENCE seq_comments_parent_cmt_id;
DROP SEQUENCE seq_comments_cmt_id;
DROP SEQUENCE seq_likes_like_id;
DROP SEQUENCE seq_tag_tag_id;

CREATE SEQUENCE seq_post_post_id	                 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_comments_parent_cmt_id  INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_comments_cmt_id	     INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_likes_like_id	                  INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_tag_tag_id	                  INCREMENT BY 1 START WITH 10000;

CREATE TABLE post (
	post_id VARCHAR2(10) NOT NULL,
	post_writer_id VARCHAR2(30) NOT NULL REFERENCES users(user_id),
	nickname VARCHAR2(20) NOT NULL,	
	board_name CHAR(1),
	post_grade CHAR(1),
	post_title VARCHAR2(200),
	post_content VARCHAR2(4000),
	post_date TIMESTAMP,
	acc_person NUMBER(10),
	acc_start_date TIMESTAMP,
	acc_end_date TIMESTAMP,
	plan_id VARCHAR2(10) REFERENCES plan(plan_id),
	qna_first_cate CHAR(1),
	qna_second_cate CHAR(1),
	views NUMBER(10),
	blocked CHAR(1),
	deleted CHAR(1),
	post_like_count NUMBER(10),
	day_best NUMBER(10),
	week_best NUMBER(10),
	month_best NUMBER(10),
	PRIMARY KEY(post_id)	
);

CREATE TABLE comments (
	cmt_id VARCHAR2(10) NOT NULL,
	post_id VARCHAR2(10) NOT NULL REFERENCES post(post_id),
	parent_cmt_id VARCHAR2(10) REFERENCES comments(cmt_id),
	writer_id VARCHAR2(30) NOT NULL REFERENCES users(user_id),
	nickname VARCHAR2(20) NOT NULL,
	cmt_content VARCHAR2(500),
	cmt_dateTIMESTAMP,
	secret CHAR(1),
	deleted CHAR(1),
	blocked CHAR(1),
	cmt_like_count NUMBER(10),
	PRIMARY KEY(cmt_id)	
);

CREATE TABLE likes (
	like_id VARCHAR2(10) NOT NULL,
	like_type CHAR(1),
	ref_id VARCHAR2(10) NOT NULL,
	like_user_id VARCHAR2(30) NOT NULL REFERENCES users(user_id),
	like_check CHAR(1),
	PRIMARY KEY(like_id)	
);

CREATE TABLE tag (
	tag_id VARCHAR2(10) NOT NULL,
	post_id VARCHAR2(10) NOT NULL REFERENCES post(post_id),
	tag_content VARCHAR2(50),
	PRIMARY KEY(tag_id)	
);

