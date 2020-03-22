
DROP TABLE todo;
DROP TABLE city_route;
DROP TABLE daily;
DROP TABLE stuff;
DROP TABLE memo;
DROP TABLE plan;

DROP SEQUENCE seq_plan_plan_id;
DROP SEQUENCE seq_todo_todo_id;
DROP SEQUENCE seq_city_route_city_id;
DROP SEQUENCE seq_daily_daily_id;
DROP SEQUENCE seq_stuff_stuff_id;
DROP SEQUENCE seq_memo_memo_id;

CREATE SEQUENCE seq_plan_plan_id		INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_todo_todo_id		INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_city_route_city_id	INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_daily_daily_id		INCREMENT BY 1 START WITH 10000;	
CREATE SEQUENCE seq_stuff_stuff_id		INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_memo_memo_id		INCREMENT BY 1 START WITH 10000;


CREATE TABLE plan (
	plan_id			VARCHAR2(10)	NOT NULL,
	plan_master_id	VARCHAR2(10)	NOT NULL,	
	plan_title		VARCHAR2(50)	NOT NULL,
	plan_img		VARCHAR2(100),
	plan_type		CHAR(1),
	plan_reg_date	TIMESTAMP,
	start_date		TIMESTAMP,
	plan_status		CHAR(1),
	deleted			CHAR(1),
	PRIMARY KEY(plan_id)
);

CREATE TABLE todo (
	plan_id			VARCHAR2(10)	NOT NULL	REFERENCES plan(plan_id),
	todo_id			VARCHAR2(10)	NOT NULL,
	todo_name		VARCHAR2(50)	NOT NULL,
	todo_check		CHAR(1),
	PRIMARY KEY(todo_id)
);

CREATE TABLE city_route (
	plan_id			VARCHAR2(10)	NOT NULL	REFERENCES plan(plan_id),
	city_id			VARCHAR2(10)	NOT NULL,
	city_name		VARCHAR2(20)	NOT NULL,
	visit_order		NUMBER,
	city_duration	NUMBER,
	tran_type		CHAR(1),
	PRIMARY KEY(city_id)
);

CREATE TABLE daily (
	plan_id			VARCHAR2(10)	NOT NULL	REFERENCES plan(plan_id),
	daily_id		VARCHAR2(10)	NOT NULL,
	daily_cate		CHAR(1),
	daily_detail	VARCHAR2(100),
	day_no			VARCHAR2(10),
	day_time		VARCHAR2(10),
	budget_amount	NUMBER,
	budget_currency	CHAR(1),
	PRIMARY KEY(daily_id)
);


CREATE TABLE stuff (
	plan_id			VARCHAR2(10)	NOT NULL	REFERENCES plan(plan_id),
	stuff_id		VARCHAR2(10)	NOT NULL,
	stuff_name		VARCHAR2(50),
	stuff_check		CHAR(1),
	PRIMARY KEY(stuff_id)
);


CREATE TABLE memo (
	plan_id			VARCHAR2(10)	NOT NULL	REFERENCES plan(plan_id),
	memo_id			VARCHAR2(10)	NOT NULL,
	memo_detail		VARCHAR2(1000),
	memo_reg_date	TIMESTAMP,
	memo_reg_user	VARCHAR2(10),
	PRIMARY KEY(memo_id)
);


//연습용 PARTY 테이블 생성
DROP TABLE party;
DROP SEQUENCE seq_party_party_id;
CREATE SEQUENCE seq_party_party_id	INCREMENT BY 1 START WITH 10000;

CREATE TABLE party (
	party_id		VARCHAR2(10)	NOT NULL,
	party_user_id	VARCHAR2(10)	NOT NULL,
	party_type		CHAR(1),
	ref_id			VARCHAR2(10),
	party_role		CHAR(1),
	PRIMARY KEY(party_id)
);





//연습용 쿼리

INSERT INTO plan ( plan_id, plan_master_id, plan_title, plan_img, plan_type, plan_reg_date, start_date, plan_status, deleted )
VALUES ( TO_CHAR(seq_plan_plan_id.nextval), 'admin', '첫번째 플랜', NULL, 'A', sysdate, '2020-03-05','R', 'F' );

INSERT INTO plan ( plan_id, plan_master_id, plan_title, plan_img, plan_type, plan_reg_date, start_date, plan_status, deleted )
VALUES ( TO_CHAR(seq_plan_plan_id.nextval), 'admin', '플랜제목없음', NULL, 'B', sysdate, '2020-02-02', 'R', 'F' );

INSERT INTO plan ( plan_id, plan_master_id, plan_title, plan_img, plan_type, plan_reg_date, start_date, plan_status, deleted )
VALUES ( TO_CHAR(seq_plan_plan_id.nextval), 'userrrr', '플랜333', NULL, 'B', sysdate, '2020-10-10', 'R', 'F' );

INSERT INTO plan ( plan_id, plan_master_id, plan_title, plan_img, plan_type, plan_reg_date, start_date, plan_status, deleted )
VALUES ( TO_CHAR(seq_plan_plan_id.nextval), 'sysy', '타임스탬프 플래너', 'no.jpg', 'C', sysdate, '2020-04-10', 'R', 'F' );

commit;

SELECT * FROM plan;


INSERT INTO memo ( plan_id, memo_id, memo_detail, memo_reg_date, memo_reg_user )
VALUES ('10000', TO_CHAR(seq_memo_memo_id.nextval), '첫번째 플랜의 첫번째 메모입니다 메모메모메모메모메모메모', sysdate, 'admin');

INSERT INTO memo ( plan_id, memo_id, memo_detail, memo_reg_date, memo_reg_user )
VALUES ('10001', TO_CHAR(seq_memo_memo_id.nextval), '두번째 플랜 첫번째 메모메메모', sysdate, 'admin');

INSERT INTO memo ( plan_id, memo_id, memo_detail, memo_reg_date, memo_reg_user )
VALUES ('10000', TO_CHAR(seq_memo_memo_id.nextval), '첫번째 플랜 두번째 메모~~~', sysdate, 'user01');

commit;

SELECT * FROM memo;



INSERT INTO city_route ( city_id, plan_id, city_name, visit_order, city_duration, tran_type )
VALUES ( TO_CHAR(seq_city_route_city_id.nextval), '10000', '런던', 1, 3, 'F' );
INSERT INTO city_route ( city_id, plan_id, city_name, visit_order, city_duration, tran_type )
VALUES ( TO_CHAR(seq_city_route_city_id.nextval), '10000', '파리', 2, 2, 'P' );
INSERT INTO city_route ( city_id, plan_id, city_name, visit_order, city_duration, tran_type )
VALUES ( TO_CHAR(seq_city_route_city_id.nextval), '10000', '피렌체', 3, 3, 'E' );

commit;

INSERT INTO city_route ( city_id, plan_id, city_name, visit_order, city_duration, tran_type )
VALUES ( TO_CHAR(seq_city_route_city_id.nextval), '10001', '인터라켄', 1, 3, 'E' );
INSERT INTO city_route ( city_id, plan_id, city_name, visit_order, city_duration, tran_type )
VALUES ( TO_CHAR(seq_city_route_city_id.nextval), '10001', '베니스', 2, 4, 'P' );

commit;


INSERT INTO city_route ( city_id, plan_id, city_name, visit_order, city_duration, tran_type )
VALUES ( TO_CHAR(seq_city_route_city_id.nextval), '10002', '밀라노', 1, 2, 'F' );
INSERT INTO city_route ( city_id, plan_id, city_name, visit_order, city_duration, tran_type )
VALUES ( TO_CHAR(seq_city_route_city_id.nextval), '10002', '취리히', 2, 4, 'F' );

commit;


INSERT INTO todo ( plan_id, todo_id, todo_name, todo_check )
VALUES ( '10000', TO_CHAR(seq_todo_todo_id.nextval), '항공권 예약하기', 'T');
INSERT INTO todo ( plan_id, todo_id, todo_name, todo_check )
VALUES ( '10000', TO_CHAR(seq_todo_todo_id.nextval), '숙소 예약하기', 'F');
INSERT INTO todo ( plan_id, todo_id, todo_name, todo_check )
VALUES ( '10000', TO_CHAR(seq_todo_todo_id.nextval), '맛집 검색해보기', 'F');

INSERT INTO todo ( plan_id, todo_id, todo_name, todo_check )
VALUES ( '10001', TO_CHAR(seq_todo_todo_id.nextval), '항공권 예약하기', 'F');
INSERT INTO todo ( plan_id, todo_id, todo_name, todo_check )
VALUES ( '10001', TO_CHAR(seq_todo_todo_id.nextval), '숙소 예약하기', 'F');
INSERT INTO todo ( plan_id, todo_id, todo_name, todo_check )
VALUES ( '10001', TO_CHAR(seq_todo_todo_id.nextval), '맛집 검색해보기', 'T');

INSERT INTO todo ( plan_id, todo_id, todo_name, todo_check )
VALUES ( '10002', TO_CHAR(seq_todo_todo_id.nextval), '항공권 예약하기', 'F');
INSERT INTO todo ( plan_id, todo_id, todo_name, todo_check )
VALUES ( '10002', TO_CHAR(seq_todo_todo_id.nextval), '숙소 예약하기', 'T');
INSERT INTO todo ( plan_id, todo_id, todo_name, todo_check )
VALUES ( '10002', TO_CHAR(seq_todo_todo_id.nextval), '맛집 검색해보기', 'T');

commit;


INSERT INTO stuff ( plan_id, stuff_id, stuff_name, stuff_check )
VALUES ( '10000', TO_CHAR(seq_stuff_stuff_id.nextval), '항공권 바우처', 'T' );
INSERT INTO stuff ( plan_id, stuff_id, stuff_name, stuff_check )
VALUES ( '10000', TO_CHAR(seq_stuff_stuff_id.nextval), '세면도구', 'F' );
INSERT INTO stuff ( plan_id, stuff_id, stuff_name, stuff_check )
VALUES ( '10000', TO_CHAR(seq_stuff_stuff_id.nextval), '잠옷', 'F' );

INSERT INTO stuff ( plan_id, stuff_id, stuff_name, stuff_check )
VALUES ( '10001', TO_CHAR(seq_stuff_stuff_id.nextval), '항공권 바우처', 'F' );
INSERT INTO stuff ( plan_id, stuff_id, stuff_name, stuff_check )
VALUES ( '10001', TO_CHAR(seq_stuff_stuff_id.nextval), '세면도구', 'T' );
INSERT INTO stuff ( plan_id, stuff_id, stuff_name, stuff_check )
VALUES ( '10001', TO_CHAR(seq_stuff_stuff_id.nextval), '잠옷', 'T' );

INSERT INTO stuff ( plan_id, stuff_id, stuff_name, stuff_check )
VALUES ( '10002', TO_CHAR(seq_stuff_stuff_id.nextval), '항공권 바우처', 'F' );
INSERT INTO stuff ( plan_id, stuff_id, stuff_name, stuff_check )
VALUES ( '10002', TO_CHAR(seq_stuff_stuff_id.nextval), '세면도구', 'T' );
INSERT INTO stuff ( plan_id, stuff_id, stuff_name, stuff_check )
VALUES ( '10002', TO_CHAR(seq_stuff_stuff_id.nextval), '잠옷', 'F' );

commit;



INSERT INTO daily ( plan_id, daily_id, daily_cate, daily_detail, day_no, day_time, budget_amount, budget_currency )
VALUES ( '10000', TO_CHAR(seq_daily_daily_id.nextval), 'S', '쇼핑인가 뭔가 긴가민가', '1', '10', 100, 'G' );
INSERT INTO daily ( plan_id, daily_id, daily_cate, daily_detail, day_no, day_time, budget_amount, budget_currency )
VALUES ( '10000', TO_CHAR(seq_daily_daily_id.nextval), 'D', '트라팔가 광장~', '1', '14', 0, 'E' );

INSERT INTO daily ( plan_id, daily_id, daily_cate, daily_detail, day_no, day_time, budget_amount, budget_currency )
VALUES ( '10001', TO_CHAR(seq_daily_daily_id.nextval), 'F', '맛있는 버거', '1', '13', 50, 'E' );
INSERT INTO daily ( plan_id, daily_id, daily_cate, daily_detail, day_no, day_time, budget_amount, budget_currency )
VALUES ( '10001', TO_CHAR(seq_daily_daily_id.nextval), 'D', '아무것도 하고싶지 않다', '2', '10', 0, 'E' );
INSERT INTO daily ( plan_id, daily_id, daily_cate, daily_detail, day_no, day_time, budget_amount, budget_currency )
VALUES ( '10001', TO_CHAR(seq_daily_daily_id.nextval), 'V', '야경 투어', '2', '19', 10, 'E' );
INSERT INTO daily ( plan_id, daily_id, daily_cate, daily_detail, day_no, day_time, budget_amount, budget_currency )
VALUES ( '10001', TO_CHAR(seq_daily_daily_id.nextval), 'F', '예산등록 안함', '1', '11', NULL, NULL );
INSERT INTO daily ( plan_id, daily_id, daily_cate, daily_detail, day_no, day_time, budget_amount, budget_currency )
VALUES ( '10001', TO_CHAR(seq_daily_daily_id.nextval), 'E', '기타 일정', '3', '15', 350, 'K' );

commit;



INSERT INTO party ( party_id, party_user_id, party_type, ref_id, party_role )
VALUES ( TO_CHAR(seq_party_party_id.nextval), 'admin', 'P', '10000', 'K' );
INSERT INTO party ( party_id, party_user_id, party_type, ref_id, party_role )
VALUES ( TO_CHAR(seq_party_party_id.nextval), 'user01', 'P', '10000', 'M' );
INSERT INTO party ( party_id, party_user_id, party_type, ref_id, party_role )
VALUES ( TO_CHAR(seq_party_party_id.nextval), 'jisung', 'P', '10000', 'M' );

INSERT INTO party ( party_id, party_user_id, party_type, ref_id, party_role )
VALUES ( TO_CHAR(seq_party_party_id.nextval), 'admin', 'P', '10001', 'K' );

INSERT INTO party ( party_id, party_user_id, party_type, ref_id, party_role )
VALUES ( TO_CHAR(seq_party_party_id.nextval), 'userrrr', 'P', '10002', 'K' );

INSERT INTO party ( party_id, party_user_id, party_type, ref_id, party_role )
VALUES ( TO_CHAR(seq_party_party_id.nextval), 'admin', 'P', '10002', 'M' );

INSERT INTO party ( party_id, party_user_id, party_type, ref_id, party_role )
VALUES ( TO_CHAR(seq_party_party_id.nextval), 'sysy', 'P', '10020', 'K' );
commit;




//테스트용 users 테이블

DROP TABLE userss;

CREATE TABLE userss(
	user_id				VARCHAR2(30)		NOT NULL,  
	pwd					VARCHAR2(20)		NOT NULL,
	email				VARCHAR2(50)		NOT NULL,
	role				CHAR(1)				DEFAULT 'G',
	nickname			VARCHAR2(20)		NOT NULL,
	user_name			VARCHAR2(20)		NOT NULL,
	birth				VARCHAR2(10),		
	phone				VARCHAR2(20),
	sex					CHAR(1),
	user_img			VARCHAR2(200),
	slot				NUMBER,
	reg_date			TIMESTAMP,
	unreg_date			TIMESTAMP,
	push_agree			CHAR(1),
	total_point			NUMBER,
	PRIMARY KEY(user_id)
);


INSERT INTO userss ( user_id, pwd, email, role, nickname, user_name, birth, phone, sex, user_img, slot, reg_date, unreg_date, push_agree, total_point )
VALUES ( 'admin', '1234', 'admin@a.a', 'A', '관리자', '김서영', '1995-02-10', '010-1111-2222','F', NULL, 3, sysdate, NULL, 'T', 0 );

INSERT INTO userss ( user_id, pwd, email, role, nickname, user_name, birth, phone, sex, user_img, slot, reg_date, unreg_date, push_agree, total_point )
VALUES ( 'user01', '1234', 'user01@a.a', 'G', '회원임', '박지성', '1996-02-10', '010-1111-0000','M', NULL, 3, sysdate, NULL, 'F', 0 );

INSERT INTO userss ( user_id, pwd, email, role, nickname, user_name, birth, phone, sex, user_img, slot, reg_date, unreg_date, push_agree, total_point )
VALUES ( 'jisung', '1234', 'jisung@a.a', 'G', '지성지성', '박지성', '1996-03-10', '010-1333-0000','M', NULL, 3, sysdate, NULL, 'F', 0 );

INSERT INTO userss ( user_id, pwd, email, role, nickname, user_name, birth, phone, sex, user_img, slot, reg_date, unreg_date, push_agree, total_point )
VALUES ( 'testMember', '1234', 'test@a.a', 'G', '테스트', '테스트멤', '1996-03-10', '010-1333-0000','M', NULL, 3, sysdate, NULL, 'F', 0 );

INSERT INTO userss ( user_id, pwd, email, role, nickname, user_name, birth, phone, sex, user_img, slot, reg_date, unreg_date, push_agree, total_point )
VALUES ( 'testUser', '1234', 'test@a.a', 'G', '테스트', '테스트멤', '1996-03-10', '010-1333-0000','M', NULL, 3, sysdate, NULL, 'F', 0 );

INSERT INTO userss ( user_id, pwd, email, role, nickname, user_name, birth, phone, sex, user_img, slot, reg_date, unreg_date, push_agree, total_point )
VALUES ( 'sysy', '1234', 'test@a.a', 'G', '김서영', '김김서영', '1996-03-10', '010-1333-0000','M', NULL, 3, sysdate, NULL, 'F', 0 );

INSERT INTO userss ( user_id, pwd, email, role, nickname, user_name, birth, phone, sex, user_img, slot, reg_date, unreg_date, push_agree, total_point )
VALUES ( 'userrrr', '1234', 'test@a.a', 'G', '김서영', '김김서영', '1996-03-10', '010-1333-0000','M', NULL, 3, sysdate, NULL, 'F', 0 );

INSERT INTO userss ( user_id, pwd, email, role, nickname, user_name, birth, phone, sex, user_img, slot, reg_date, unreg_date, push_agree, total_point )
VALUES ( 'test2222', '1234', 'test@a.a', 'G', '테스트', '테스트멤', '1996-03-10', '010-1333-0000','M', NULL, 3, sysdate, NULL, 'F', 0 );

commit;


//업데이트 실험용
//UPDATE plan SET plan_title = '타이틀바꾸기', plan_img = 'noImg.jpg', plan_type = 'A', start_date = '2020-04-11' WHERE plan_id = '10000';


//테스트용 Offer 테이블 생성
DROP TABLE offer;

DROP SEQUENCE seq_offer_offer_id;

CREATE SEQUENCE seq_offer_offer_id	INCREMENT BY 1 START WITH 10000;

CREATE TABLE offer(
	offer_id			VARCHAR2(10)		NOT NULL,
	offer_type			CHAR(1),
	ref_id				VARCHAR2(10),
	offer_msg			VARCHAR2(200),
	offer_status		CHAR(1),
	from_user_id		VARCHAR2(30),
	to_user_id			VARCHAR2(30),
	offer_date			TIMESTAMP,
	PRIMARY KEY(offer_id)
);

//실험용
//INSERT INTO offer ( offer_id, offer_type, ref_id, offer_msg, offer_status, from_user_id, to_user_id, offer_date )
//VALUES ( TO_CHAR(seq_offer_offer_id.nextval), 'P', '10001', '두번째 플래너의 킹이 보내는 초대메시지입니다', 'S', 'admin', 'jisung', sysdate );

commit;


//실험용
//INSERT INTO party ( party_id, party_user_id, party_type, ref_id, party_role )
//VALUES ( TO_CHAR(seq_party_party_id.nextval), 'testMember', 'P', '10000', 'M' );







//1
INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '프라하', '체코', '프라하는 체코의 수도이다. 인구는 약 128만 명이며, 광역도시권을 모두 포함하면 인구는 약 216만 명에 달한다.', 'prague.jpeg', 50.0598058,14.3255408, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '암스테르담', '네덜란드', '암스테르담은 네덜란드의 수도이자 최대 도시이다.', 'amsterdam.jpg', 52.3547031,4.8339208, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '브뤼셀', '벨기에', '벨기에 수도 브뤼셀 지구(地區)(Region de Bruxelles-Capitale / Brussels Hoofdstedelijk Gewest)는 19개의 시(市)가 합병하여 이루어진 곳으로 수도 브뤼셀은 일반적으로 지역 전체를 뜻한다.', 'bruxelles.jpg', 50.846624, 4.351143, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '아테네', '그리스', '아테네는 그리스의 수도이자 최대의 도시이며, 아티키 주의 중심 도시이다. 세계적으로 오래된 도시이며, 역사 시대가 개막한 지 3,400년에 이른다.', 'athens.jpg', 37.9908997, 23.7033199, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '스톡홀름', '스웨덴', '스톡홀름은 스웨덴의 수도이자 스칸디나비아 반도 최대 도시이다.', 'stockholm.jpg', 59.326242,17.8419708, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '오슬로', '노르웨이', '오슬로는 노르웨이의 남부 해안에 있는 도시이며, 이 나라의 수도이다.', 'oslo.jpg', 59.8939529,10.6450349, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '헬싱키', '핀란드', '헬싱키는 핀란드의 수도이다. 핀란드 남부 핀란드 만 연안에 위치해 있다.', 'helsinki.JPG', 60.11021,24.7385061, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '레이캬비크', '아이슬란드', '레이캬비크는 아이슬란드의 수도이자 회뷔드보르가르스바이디의 행정 중심지인 도시이다.', 'reykjavik.jpg', 64.1452236,-21.9390972, 1  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '피렌체', '이탈리아', '피렌체는 이탈리아 토스카나주의 주도이다. 피렌체현의 현청 소재지이며, 인구는 38만명이고 근교의 인구까지 합치면 총 약 150만명이다.', 'firenze.jpg', 43.7800607,11.170928, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '베니스', '이탈리아', '베네치아는 이탈리아 북부에 위치한 베네토주 베네치아 광역시에 속하는 도시로, 베네토 주의 주도이다. 과거 베네치아 공화국의 수도였다.', 'venezia.jpg', 45.4046987,12.2416589, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '로마', '이탈리아', '로마는 이탈리아의 수도이자 최대 도시로, 라치오주의 주도이며, 테베레 강 연안에 있다. 로마시의 행정구역 면적은 1,285km²로 서울의 2배정도이고, 2014년 인구는 290여만명이다.', 'rome.jpg', 41.9102415,12.3959137, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '체르마트', '스위스', '체르마트는 스위스 발레주에 위치한 도시로 면적은 242.69km², 높이는 1,608m, 인구는 5,720명, 인구 밀도는 24명/km²이다.', 'zermatt.jpg', 45.9906828,7.6719051, 1  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '인터라켄', '스위스', '인터라켄은 스위스 베른주에 위치한 도시로, 면적은 4.3km², 높이는 568m, 인구는 5,429명, 인구 밀도는 1,234명/km²이다. 도시 이름은 독일어로 "호수 사이"를 뜻한다.', 'interlaken.jpg', 46.6845281,7.8403204, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '취리히', '스위스', '취리히는 스위스에서 가장 큰 도시이자 취리히주의 주도이며, 스위스의 중간 지역에 취리히 호의 북쪽 끝에 위치해 있다.', 'zurich.jpg', 47.3775499,8.4666752, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '비엔나', '오스트리아', '빈은 오스트리아의 수도이다. 도나우강이 도시 내부를 흐르며 인구는 약 182만 명이다.', 'wien.png', 48.2208286,16.2399766, 1  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '파리', '프랑스', '프랑스의 정치·경제·교통·학술·문화의 중심지일 뿐만 아니라 세계의 문화 중심지로, ‘꽃의 도시’라고 불리며 프랑스 사람들은 스스로 ‘빛의 도시’라고 부른다.', 'paris.jpg', 48.856667, 2.350833, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '니스', '프랑스', '니스는 프랑스 남부의 항만 도시로 프랑스의 지중해 연안에 위치해 있다. 마르세유와 제노바 사이에 위치해 있으며, 도시권 인구는 대략 100만명이다.', 'nice.jpg', 43.7032932,7.1827771, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '바르셀로나', '스페인', '바르셀로나는 스페인에서 두 번째로 큰 도시로, 스페인 동부 지중해 연안 지역부터 프랑스 남쪽 피레네 산맥과 접경지역을 아우르는 카탈루냐 지방의 중심 도시이다.', 'barcelona.jpg', 41.3948976,2.0787279, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '마드리드', '스페인', '마드리드는 스페인의 수도로, 나라의 중앙부에 있다. 인구는 약 300만 명 이다.', 'madrid.jpg', 40.4381311,-3.819621, 1  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '런던', '영국', '영국의 정치·경제·문화 그리고 교통의 중심지일 뿐만 아니라, 영국연방의 사실상의 중심도시다.', 'london.jpg', 51.507351, -0.127758, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '맨체스터', '영국', '맨체스터는 영국의 도시이다. 리버풀 동북쪽 약 50 km, 머지 강의 지류인 어웰 강과 아크 강의 합류점에 위치해 있다.', 'manchester.jpg', 53.4723272,-2.2935024, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '케임브리지', '영국', '케임브리지는 영국 런던에서 북쪽에 있는 케임브리지셔주의 중심 도시이다.', 'cambridge.jpg', 52.1988895,0.0849678, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '옥스퍼드', '영국', '옥스퍼드는 잉글랜드 옥스퍼드셔 주의 중심 도시이다.', 'oxford.jpg', 51.7505018,-1.3176275, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '프랑크푸르트', '독일', '프랑크푸르트암마인은 독일 중서부 헤센주에 있는 도시로, 간단히 줄여서 프랑크푸르트라고 불리기도 한다.', 'frankfurt.jpg', 50.1213479,8.4964807, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '베를린', '독일', '베를린은 독일의 수도이다. 2014년 12월 현재 인구 3,562,166명으로, 독일 내 단일 규모로는 최대의 도시이고 유럽 연합의 최대 도시이기도 하다.', 'berlin.jpg', 52.5069312,13.1445526, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '리스본', '포르투갈', '리스본은 포르투갈의 수도이다. 리스보아 현의 중심도시이자, 포르투갈에서 가장 큰 도시다.', 'lisboa.jpg', 38.7437396,-9.2302433, 1  );




//6

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '자그레브', '크로아티아', '자그레브은 크로아티아의 수도이다. 자그레브는 크로아티아의 북서쪽, 다뉴브 강의 지류인 사바 강 변에 위치해 있고, 메드베드니차 산의 남쪽에 위치해있다.', 'zagreb.jpg', 45.8403496,15.8242479, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '에이일스타디르', '아이슬란드', '에이일스스타디르는 아이슬란드 동부에 위치한 도시로, 인구는 2,257명이다.', 'egilsstadir.JPG', 65.2623726,-14.4148883, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '누크', '그린란드', '누크 또는 고트호프는 그린란드의 수도이자 최대도시이며, 1979년에 발족한 그린란드의 자치 정부가 위치해 있는 곳이다.', 'nuuk.jpg', 64.3517529,-45.5152857, 6  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '밀라노', '이탈리아', '밀라노는 이탈리아의 북부에 있는 도시로, 롬바르디아주의 주도이다. 밀라노는 이탈리아 북부의 최대 도시로, 롬바르디아 평원 에 위치하고 있으며, 포 강이 이 도시를 흐르고 있다.', 'milano.jpg', 45.4628329,9.1076924, 6  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '루체른', '스위스', '루체른은 스위스 중부 루체른주에 있는 도시이다. 루체른 주의 주도이다. 루체른 호의 서안에 면하며, 로이스 강이 시내를 흐른다.', 'luzern.jpg', 47.0548081,8.2472856, 6  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '잘츠부르크', '오스트리아', '잘츠부르크는 오스트리아 서부에 있는 도시로 잘츠부르크주의 주도이기도 하다.', 'salzburg.jpg', 47.802904,12.9863902, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '리옹', '프랑스', '리옹은 프랑스의 도시로 론주와 론알프 지방의 중심도시이며, 과거 앙시앵 레짐의 프로방스 리오네의 중심지였다.', 'lyon.jpg', 45.7580539,4.7650811, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '마르세유', '프랑스', '마르세유는 프랑스에서 두 번째로 큰 도시이다. 프로방스알프코트다쥐르 레지옹과 부슈뒤론주의 중심지이기도 하다.', 'marseille.jpg', 43.280555,5.2404125, 6  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '세비야', '스페인', '세비야는 스페인의 남서부에 있는 도시로, 안달루시아 지방의 예술, 문화, 금융의 중심 도시이며 세비야 주의 주도이다.', 'sevilla.jpg', 37.3754865,-6.0250983, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '그라나다', '스페인', '그라나다는 스페인 안달루시아 지방에 위치한 그라나다 주의 주도이다.', 'granada.jpg', 37.1810095,-3.6262912, 6  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '리버풀', '영국', '리버풀은 잉글랜드 북서부의 도시로 2015년 기준으로 인구는 478,580 명이다. 머지 강 어귀의 동쪽에 자리잡고 있다.', 'liverpool.jpg', 53.4123001,-3.0561414, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '브라이턴', '영국', '브라이턴은 영국 잉글랜드 남동부 이스트서식스주 서단에 위치한 마을로 브라이턴앤드호브의 일부이다.', 'brighton.jpg', 50.8374669,-0.1412091, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '카디프', '영국', '카디프는 웨일스의 수도이자 웨일스에서 가장 많은 인구가 사는 도시로, 영국에서 9번째로 인구가 많은 도시이다.', 'cardiff.jpg', 51.5023268,-3.2750897, 6 );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '에든버러', '영국', '에든버러는 스코틀랜드의 수도이며, 글래스고 다음으로 큰 도시다.', 'edinburgh.jpg', 55.9412846,-3.2753782, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '뮌헨', '독일', '뮌헨은 독일 바이에른주의 최대 도시이자 주도시이다. 이 도시는 알프스 북부의 이자르 강가에 위치한다.', 'munchen.jpg', 48.1550547,11.4017524, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '드레스덴', '독일', '드레스덴은 독일 동부에 위치한 작센주의 주도로 엘베 강변에 위치해 있다.', 'dresden.jpg', 51.0769658,13.6325027, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '포르토', '포르투갈', '포르투 는 포르투갈 북부의 항구 도시로 포르투갈 제2의 도시이다.', 'porto.jpg', 41.1622023,-8.6569731, 6  );



//7

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '라우터브루넨', '스위스', '라우터브루넨는 스위스 베른주에 위치한 도시로, 면적은 164.56km², 높이는 795m, 인구는 2,558명, 인구 밀도는 16명/km²이다. 빙하의 침식으로 인해 형성된 빙하곡과 접해 있으며 70여 개가 넘는 골짜기와 폭포로 유명한 도시이다.', 'lauterbrunnen.png', 46.5533016,7.8367102, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '베른', '스위스', '베른은 스위스의 연방시이며 사실상 수도이다. 취리히, 제네바, 바젤에 이어 스위스에서 네 번째로 큰 도시이기도 하다.', 'bern.jpg', 46.9547658,7.3248302, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '쾰른', '독일', '쾰른은 독일 노르트라인베스트팔렌주의 도시다. 베를린, 함부르크, 뮌헨에 이어 독일에서 가장 큰 도시로 옛 프로이센에서는 베를린 다음으로 제2의 도시였다.', 'koln.jpg', 50.9578353,6.8272394, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '도르트문트', '독일', '도르트문트는 독일 노르트라인베스트팔렌 주의 도시이다.', 'dortmund.jpg', 51.5080148,7.3301796, 1  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '뉘른베르크', '독일', '뉘른베르크는 독일 바이에른주에 있는 도시이다. 인구는 약 50만 명 이상이며 바이에른 주에서는 뮌헨에 이어 2번째로 큰 도시이다.', 'nurnberg.jpg', 49.4362322,10.9929541, 7  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '도버', '영국', '도버는 영국 잉글랜드 켄트주의 항구 도시이다.', 'dover.jpg', 51.126333,1.2659699, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '바스', '영국', '바스 또는 배스는 영국 잉글랜드의 남서부 서머싯주에 위치한 도시로, 런던에서 서쪽으로 156 킬로미터와 브리스틀에서 남동쪽으로 21 킬로미터 떨어진 곳에 있다.', 'bath.jpg', 51.3801748,-2.3995494, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '발렌시아', '스페인', '발렌시아는 스페인 발렌시아 주의 주도이다.', 'valencia.jpg', 39.4079665,-0.5015958, 7  );




INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '보르도', '프랑스', '보르도는 프랑스 남서부에 있는 항구 도시이다. 보르도는 아키텐 레지옹의 주도이자, 지롱드주의 주도이다.', 'bordeaux.jpg', 44.8638282,-0.6561809, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '할슈타트', '오스트리아', '할슈타트는 오스트리아 오버외스터라이히주의 마을이다. 할슈타트 호에 가까이 있으며 알프스 기슭의 호수 지역 잘츠카머구트 지방의 가장 안쪽에 위치하는 경승지이다.', 'hallstatt.jpg', 47.5345646,13.5405902, 7  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '그린델발트', '스위스', '그린델발트는 스위스 베른주에 위치한 도시로 면적은 171.08km², 높이는 1,034m, 인구는 3,740명, 인구 밀도는 22명/km²이다.', 'grindelwald.jpg', 46.6197715,7.9707351, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '나폴리', '이탈리아', '나폴리는 이탈리아 남부에 있는 도시로, 캄파니아주의 주도이다. 이 도시는 이탈리아 통일 전까지는 양시칠리아 왕국의 수도였다. 나폴리 시는 고대 때 네아폴리스로 불렸으며 "신도시"라는 뜻을 지닌다.', 'napoli.jpg', 40.8540421,14.1765624, 7  );









INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '룩셈부르크', '룩셈부르크', '룩셈부르크는 룩셈부르크 대공국의 수도이다. 2007년 현재 인구는 86,329명이며 페트뤼스 강이 알제트 강에 합류하는 지점에 위치한다.', 'luxembourg.jpg', 49.6077433,5.9961298,  7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '낭시', '프랑스', '낭시는 프랑스 모젤 강의 지류를 따라 발달한 로렌 지방의 중심 도시이다. 알사스와 자르를 연결하는 교통의 요지로, 예부터 교통·상업의 중심지로 발전하여 왔다.', 'nancy.JPG', 48.6881732,6.1035688,  7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '스트라스부르', '프랑스', '스트라스부르는 프랑스 북동부에 있는 도시로서 라인 강의 서쪽 강변에 있는 도시이다. 알자스 레지옹 청사 소재지임과 동시에 바랭주 정부 청사 소재지이다.', 'strasbourg.jpg', 48.5692562,7.6223536,  7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '제네바', '스위스', '제네바는 스위스에서 두 번째로 인구가 많은 도시이다. 레만 호에서 론 강이 흘러나오는 곳에 자리하고 있다.', 'geneve.jpg', 46.205127,6.0742203,  7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '헨트', '벨기에', '헨트는 벨기에 오스트플란데런주의 주도이자 가장 큰 도시로 플랑드르에 있는 지방 자치체다.', 'gent.JPG', 51.0825382,3.4349902,  7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '슈투트가르트', '독일', '슈투트가르트는 독일 바덴뷔르템베르크주의 주도이다. 구 뷔르템베르크 왕국의 수도였으며, 2006년 FIFA 월드컵의 경기가 열린 도시 중 하나이기도 하다.', 'stuttgart.jpg', 48.7793237,8.897719,  7  );

//61개


10106
10088


//6
INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '낭트', '프랑스', '낭트는 프랑스 본토 브르타뉴 지방에 위치한 도시이다. 페이드라루아르 레지옹의 중심지이며, 루아르아틀랑티크주의 주도이기도 하다. 프랑스에서 6번째로 큰 도시이다.', 'nantes.jpg', 47.2382006,-1.6302677, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '르망', '프랑스', '르망은 프랑스의 도시이며 사르트 강이 도시를 지난다. 역사적으로 멘 프로뱅스의 중심지였으며 현재는 사르트주의 주도이다.', 'leMans.jpg', 47.9818761,0.1254809, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '툴루즈', '프랑스', '툴루즈는 프랑스의 남서쪽 가론강 연안, 지중해와 대서양으로부터 비슷한 거리만큼 떨어져있는 도시이다.', 'toulouse.jpg', 43.6006785,1.3626292, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '살라망카', '스페인', '살라망카는 스페인 북서부에 위치한 도시이다. 카스티야이레온 지방에 속하는 주인 살라망카 주의 주도이다.', 'salamanca.jpg', 40.9634332,-5.7043175, 6  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '로테르담', '네덜란드', '로테르담은 네덜란드 자위트홀란트주에 있는 유럽 최대의 무역항 로테르담 항이 있는 도시이다.', 'rotterdam.png', 51.9279514,4.4201949, 6  );





//7
INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '베로나', '이탈리아', '베로나는 이탈리아 북부 베네토주 아디제 강 유역에 있는 도시이다. 전통 미술품과 건축물, 공연예술 문화가 많이 남아있는 북이탈리아의 주요 관광지이다.', 'verona.jpg', 45.4569207,10.9763163, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '피사', '이탈리아', '피사는 이탈리아 토스카나주에 있는 도시이다. 피사도의 현청 소재지이며, 시의 인구는 약 9만명이다.', 'pisa.jpg', 43.7068074,10.3602728, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '부다페스트', '헝가리', '부다페스트는 헝가리의 수도이자 정치·산업·상업·교통·문화의 중심지다.', 'budapest.jpg', 47.4811277,18.9898755, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '본머스', '영국', '본머스는 쥐라기 해안의 동쪽에 위치한 잉글랜드 남부 도싯주의 해안 도시이다.', 'bournemouth.jpg', 50.753983,-1.9299503, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '스털링', '영국', '스털링은 스코틀랜드 스털링의 도시이다. 인구는 45,750명이다.', 'stirling.JPG', 56.1187003,-3.9748036, 7  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '애버딘', '영국', '애버딘은 영국 스코틀랜드의 해안 도시로, 스코틀랜드의 32개 지방 자치 의회 구역 중 하나이다. 어업과 상업이 발달해 있다.', 'aberdeen.jpg', 57.1498816,-2.1952389, 7  );




INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '폼페이', '이탈리아', '폼페이는 이탈리아 캄파니아주 나폴리현에 위치한 코무네다.', 'pompei.jpg', 40.7466143,14.4585768, 8  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '콜체스터', '영국', '콜체스터는 영국 잉글랜드 남동부 에식스주의 도시이다.', 'colchester.jpg', 51.8860941,0.8334358, 8  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '디종', '프랑스', '디종은 프랑스 중부의 도시로, 부르고뉴프랑슈콩테 지방 코트도르주의 주도이다.', 'dijon.jpg', 47.3318596,4.9620094, 8  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '덩케르크', '프랑스', '됭케르크는 프랑스 노르주의 도시다. 벨기에 국경과 가깝고 북해에 면한 항구도시다.', 'dunkerque.jpg', 51.0168751,2.2728731, 8  );


INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '리에주', '벨기에', '리에주는 벨기에 동부 왈롱 지방에 위치한 도시로 리에주주의 주도이며 면적은 69.39km², 인구는 197,355명, 인구 밀도는 2,800명/km²이다.', 'liege.jpg', 50.624619,5.5288835, 8  );

INSERT INTO city_info ( city_info_id, city_name, country, city_content, city_img, lat, lng, scroll_scale )
VALUES ( TO_CHAR(seq_city_info_city_info_id.nextval), '바르샤바', '폴란드', '바르샤바는 폴란드의 수도이자 폴란드 최대 도시이고, 마조프셰주의 대표 도시이다.', 'warszawa.JPG', 52.2326047,20.7803259, 8  );


총 78개


10130