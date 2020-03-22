DROP TABLE orders;
DROP TABLE flight;
DROP TABLE room;

DROP SEQUENCE seq_orders_order_id;
DROP SEQUENCE seq_flight_flight_id;
DROP SEQUENCE seq_room_room_id;



CREATE SEQUENCE seq_orders_order_id	INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_flight_flight_id	INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_room_room_id	INCREMENT BY 1 START WITH 10000;

 CREATE TABLE orders
 (
    order_id   		 VARCHAR2(50 BYTE)    NOT NULL ENABLE,
    buyer_id   		 VARCHAR2(30 BYTE)    NOT NULL REFERENCES users(user_id),
    buyer_name		 VARCHAR2(20 BYTE),
    buyer_phone		 VARCHAR2(20 BYTE),
    buyer_email		 VARCHAR2(50 BYTE),
    order_date	 	TIMESTAMP (6),
    order_status	CHAR(1 BYTE),
    flight_id 		VARCHAR2(10 BYTE)     REFERENCES flight(flight_id),
    room_id 		VARCHAR2(10 BYTE)     REFERENCES room(room_id),
    pay_opt 		CHAR(1 BYTE),
    pay_instal    	 NUMBER(10,0),
    pay_point 		NUMBER(10,0),
    total_amount 	NUMBER(10,0),
    actual_amount 	NUMBER(10,0),
    refund_date 	TIMESTAMP ,

    PRIMARY KEY (order_id)
 );

CREATE TABLE flight
(  
   flight_id   	VARCHAR2(10 BYTE)   NOT NULL ENABLE,
   airline 		VARCHAR2(20 BYTE),
   price		NUMBER(10),
   trip_course 	CHAR(1 BYTE),
   dep_city 	VARCHAR2(20 BYTE),
   dep_date 	VARCHAR2(20 BYTE),
   dep_time 	VARCHAR2(20 BYTE), 
 	arr_city		VARCHAR2(20 BYTE),
   arr_date 	VARCHAR2(20 BYTE),
   arr_time 	VARCHAR2(20 BYTE),
   seat_grade 	CHAR(1 BYTE),
   adult_num 	NUMBER(10,0),
   child_num 	NUMBER(10,0),
   infant_num	NUMBER(10,0),
   lead_time    VARCHAR2(20 BYTE),
   stop_over 	VARCHAR2(20 BYTE),
   PRIMARY KEY (flight_id)
);


CREATE TABLE room
( 
   room_id		VARCHAR2(10 BYTE)       NOT NULL ENABLE,
   room_name	VARCHAR2(50 BYTE),
   price 		NUMBER(10),
   room_city	VARCHAR2(20 BYTE),
   check_in 	VARCHAR2(20 BYTE),
   check_out    VARCHAR2(20 BYTE),
   detail_link  VARCHAR2(4000 BYTE),
   adult_num	NUMBER(10,0),
   child_num 	NUMBER(10,0),
   room_num	 	NUMBER(10,0),
   room_img 	VARCHAR2(200 BYTE),
   main_service VARCHAR2(2000 BYTE),
   family_service	 VARCHAR2(2000 BYTE),
   sights		VARCHAR2(2000 BYTE),
   hotel_info   VARCHAR2(2000 BYTE),
   room_info 	VARCHAR2(2000 BYTE),

   PRIMARY KEY (room_id)
);
