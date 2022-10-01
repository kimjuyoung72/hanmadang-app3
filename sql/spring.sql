--테이블 삭제
drop table uploadfile;
drop table bbs;
drop table member;
drop table notice;
drop table code;
drop table p_event;
drop table p_facility;
--drop table promotion;
--drop table review;

--시퀀스삭제
drop sequence member_member_id_seq;
drop sequence notice_notice_id_seq;
drop sequence bbs_bbs_id_seq;
drop sequence uploadfile_uploadfile_id_seq;
drop sequence p_event_post_id_seq;
--drop sequence promotion_promotion_post_id_seq;
--drop sequence review_review_post_id_seq;
-------
--코드
-------
create table code(
    code_id     varchar2(11),       --코드
    decode      varchar2(30),       --코드명
    discript    clob,               --코드설명
    pcode_id    varchar2(11),       --상위코드
    useyn       char(1) default 'Y',            --사용여부 (사용:'Y',미사용:'N')
    cdate       timestamp default systimestamp,         --생성일시
    udate       timestamp default systimestamp          --수정일시
);
--기본키
alter table code add Constraint code_code_id_pk primary key (code_id);

--외래키
--alter table code drop constraint bbs_pcode_id_fk;
alter table code add constraint bbs_pcode_id_fk
    foreign key(pcode_id) references code(code_id);

--제약조건
alter table code modify decode constraint code_decode_nn not null;
alter table code modify useyn constraint code_useyn_nn not null;
alter table code add constraint code_useyn_ck check(useyn in ('Y','N'));

--샘플데이터 of code
insert into code (code_id,decode,pcode_id,useyn) values ('B01','게시판',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0101','공연전시','B01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0102','홍보','B01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0103','후기','B01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('B0104','문화지도','B01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M01','회원구분',null,'Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M0101','일반','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M0102','홍보','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M01A1','관리자1','M01','Y');
insert into code (code_id,decode,pcode_id,useyn) values ('M01A2','관리자2','M01','Y');

--select * from code;
--delete code;
--commit;

--공연전시 공공데이터

create table p_event(
    event_id        NUMBER(10),    --내부관리용 ID
    mt20id	        VARCHAR2(10), --pk, not null	12	공연ID +
    prfnm	        VARCHAR2(100), --	공연명 +
    prfpdfrom	    VARCHAR2(10), --	공연시작일 +
    prfpdto	        VARCHAR2(10), --	공연종료일 +
    fcltynm	        VARCHAR2(100), --	공연시설명(공연장명) +
    prfcast	        VARCHAR2(100), --	공연출연진 +
    prfcrew	        VARCHAR2(30), --	공연제작진 +
    prfruntime	    VARCHAR2(20), --	공연 런타임 +
    prfage	        VARCHAR2(20), --	공연 관람 연령 +
    entrpsnm	    VARCHAR2(50),	--제작사 +
    pcseguidance	VARCHAR2(80),	--티켓가격 +
    poster	        VARCHAR2(100), --	포스터이미지경로
    sty	            CLOB,		    -- 줄거리
    genrenm	        VARCHAR2(10), --	공연 장르명 +
    prfstate	    VARCHAR2(20), --	공연상태 +
    openrun	        VARCHAR2(1), --	오픈런
    styurl1	        VARCHAR2(100), --	소개이미지1
    styurl2	        VARCHAR2(100), --	소개이미지2
    styurl3	        VARCHAR2(100), --	소개이미지3
    styurl4	        VARCHAR2(100), --	소개이미지4
    mt10id	        VARCHAR2(10), --	공연시설ID
    dtguidance	    VARCHAR2(100) --	공연시간 +
);
alter table p_event add constraint p_event_mt20id_pk primary key(mt20id);
create sequence p_event_post_id_seq;

select t1.*
  from (select row_number() over (order by event_id desc) no, prfnm
          from p_event) t1
where t1.no between 3 and 8;
select count(*) from p_event;
--공연장 상세

create table p_facility(
    mt10id	    VARCHAR2(10), --	pk, fk, 공연시설ID
    fcltynm	    VARCHAR2(100), --	fk, 공연시설명
    mt13cnt	    VARCHAR2(5), --	공연장 수
    fcltychartr	VARCHAR2(30), --	시설특성
    seatscale	  VARCHAR2(10), --	5	객석 수
    telno	      VARCHAR2(15), --	전화번호
    relateurl	  VARCHAR2(100), --	홈페이지
    adres	      VARCHAR2(120), --	주소
    opende	    VARCHAR2(6), --	개관연도
    la	        VARCHAR2(20), --	위도
    lo	        VARCHAR2(25) --	경도

);
alter table p_facility add constraint p_facility_mt10id_pk primary key(mt10id);


-------
--회원
-------
create table member (
    member_id   number,         --내부 관리 아이디
    email       varchar2(50),   --로긴 아이디
    passwd      varchar2(12),   --로긴 비밀번호
    nickname    varchar2(30),   --별칭
--    gender      varchar2(6),    --성별
--    hobby       varchar2(300),  --취미
--    region      varchar2(30),   --지역
    phone 		  varchar2 (12), -- 유니크 nn
    birthday 		date, -- nn
    sms_service 	number(1),
    email_service number(1),
    gubun       varchar2(11)   default 'M0101', --회원구분 (일반,홍보,관리자..)
    cdate       timestamp default systimestamp,         --생성일시
    udate       timestamp default systimestamp          --수정일시
);

--기본키생성
alter table member add Constraint member_member_id_pk primary key (member_id);

--제약조건
alter table member add constraint member_gubun_fk
    foreign key(gubun) references code(code_id);
alter table member modify email constraint member_passwd_uk unique;
alter table member modify email constraint member_passwd_nn not null;
--alter table member add constraint member_gender_ck check (gender in ('남자','여자'));

--시퀀스
create sequence member_member_id_seq;
desc member;
--......별칭,폰,생일,sns svc, email svc
insert into member (member_id,email,passwd,nickname,phone,birthday,sms_service,email_service,gubun)
    values(member_member_id_seq.nextval, 'test1@kh.com', '1234', '테스터1','01011112222','1999-01-01',1,1,'M0101');
insert into member (member_id,email,passwd,nickname,phone,birthday,sms_service,email_service,gubun)
    values(member_member_id_seq.nextval, 'test2@kh.com', '1234', '테스터2','01011113333','2001-03-03',1,1,'M0102');
insert into member (member_id,email,passwd,nickname,phone,birthday,sms_service,email_service,gubun)
    values(member_member_id_seq.nextval, 'admin1@kh.com', '1234','관리자1', '01022223333','2009-04-04',1,1,'M01A1');
insert into member (member_id,email,passwd,nickname,phone,birthday,sms_service,email_service,gubun)
    values(member_member_id_seq.nextval, 'admin2@kh.com', '1234','관리자2', '01033334444','2010-05-05',1,1,'M01A2');


---------
--공지사항
---------
create table notice(
    notice_id    number(8),
    subject     varchar2(100),
    content     clob,
    author      varchar2(12),
    hit         number(5) default 0,
    cdate       timestamp default systimestamp,
    udate       timestamp default systimestamp
);
--기본키생성
alter table notice add Constraint notice_notice_id_pk primary key (notice_id);

--제약조건 not null
alter table notice modify subject constraint notice_subject_nn not null;
alter table notice modify content constraint notice_content_nn not null;
alter table notice modify author constraint notice_author_nn not null;

--시퀀스
create sequence notice_notice_id_seq
start with 1
increment by 1
minvalue 0
maxvalue 99999999
nocycle;

-------
--게시판
-------
create table bbs(
    bbs_id      number(10),         --게시글 번호
    bcategory   varchar2(11),       --분류카테고리
    title       varchar2(150),      --제목
    email       varchar2(50),       --email
    nickname    varchar2(30),       --별칭
    hit         number(5) default 0,          --조회수
    bcontent    clob,               --본문
    pbbs_id     number(10),         --부모 게시글번호
    bgroup      number(10),         --답글그룹
    step        number(3) default 0,          --답글단계
    bindent     number(3) default 0,          --답글들여쓰기
    status      char(1),               --답글상태  (삭제: 'D', 임시저장: 'I')
    cdate       timestamp default systimestamp,         --생성일시
    udate       timestamp default systimestamp          --수정일시
);

--기본키
alter table bbs add Constraint bbs_bbs_id_pk primary key (bbs_id);

--외래키
--alter table bbs drop constraint bbs_bcategory_fk;
alter table bbs add constraint bbs_bcategory_fk
    foreign key(bcategory) references code(code_id);
alter table bbs add constraint bbs_pbbs_id_fk
    foreign key(pbbs_id) references bbs(bbs_id);
alter table bbs add constraint bbs_email_fk
    foreign key(email) references member(email);

--제약조건
alter table bbs modify bcategory constraint bbs_bcategory_nn not null;
alter table bbs modify title constraint bbs_title_nn not null;
alter table bbs modify email constraint bbs_email_nn not null;
alter table bbs modify nickname constraint bbs_nickname_nn not null;
alter table bbs modify bcontent constraint bbs_bcontent_nn not null;

--시퀀스
create sequence bbs_bbs_id_seq;

insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기1','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기2','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기3','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기4','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기5','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기6','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기7','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기8','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기9','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기10','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기11','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기12','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기13','test1@kh.com','글쓴이1',3,'잼씀');
insert into bbs (bbs_id,bcategory,title,email,nickname,hit,bcontent) values (bbs_bbs_id_seq.nextval,'B0103','후기14','test1@kh.com','글쓴이1',3,'잼씀');
commit;
select * from bbs;
---------
--첨부파일
---------
create table uploadfile(
    uploadfile_id   number(10),     --파일아이디
    code            varchar2(11),   --분류코드
    rid             varchar2(10),     --참조번호(게시글번호등)
    store_filename  varchar2(100),   --서버보관파일명
    upload_filename varchar2(100),   --업로드파일명(유저가 업로드한파일명)
    fsize           varchar2(45),   --업로드파일크기(단위byte)
    ftype           varchar2(100),   --파일유형(mimetype)
    cdate           timestamp default systimestamp, --등록일시
    udate           timestamp default systimestamp  --수정일시
);
--기본키
alter table uploadfile add constraint uploadfile_uploadfile_id_pk primary key(uploadfile_id);

--외래키
alter table uploadfile add constraint uploadfile_uploadfile_id_fk
    foreign key(code) references code(code_id);

--제약조건
alter table uploadfile modify code constraint uploadfile_code_nn not null;
alter table uploadfile modify rid constraint uploadfile_rid_nn not null;
alter table uploadfile modify store_filename constraint uploadfile_store_filename_nn not null;
alter table uploadfile modify upload_filename constraint uploadfile_upload_filename_nn not null;
alter table uploadfile modify fsize constraint uploadfile_fsize_nn not null;
alter table uploadfile modify ftype constraint uploadfile_ftype_nn not null;

--시퀀스
create sequence uploadfile_uploadfile_id_seq;

select * from member;