package com.kh.app3.domain.bbs.dao;

import com.kh.app3.domain.EventInfo;
import com.kh.app3.domain.FacInfo;

import java.util.List;

public interface BbsDAO {

  /**
   * 원글작성
   * @param bbs
   * @return 게시글 번호
   */
  Long saveOrigin(Bbs bbs);

  /**
   * 목록
   * @return
   */
  List<Bbs>  findAll();
  List<Bbs>  findAll(String category);

  List<Bbs>  findAll(int startRec, int endRec);
  List<Bbs>  findAll(String category,int startRec, int endRec);
  List<EventInfo> findAllEvents(int startRec, int endRec);
  /**
   * 홍보,후기 검색
   * @param filterCondition 분류,시작레코드번호,종료레코드번호,검색유형,검색어
   * @return
   */
  List<Bbs>  findAll(BbsFilterCondition filterCondition);

  /**
   * 이벤트검색
   * @param filterCondition 분류,시작레코드번호,종료레코드번호,검색유형,검색어
   * @return
   */
  List<EventInfo> findAllEvents(BbsFilterCondition filterCondition);

  /**
   * 상세 조회
   * @param id 게시글번호
   * @return
   */
  Bbs findByBbsId(Long id);

  EventInfo findByEventId(Long id);

  FacInfo findByFacId(String id);
  /**
   * 삭제
   * @param id 게시글번호
   * @return 삭제건수
   */
  int deleteByBbsId(Long id);

  /**
   * 수정
   * @param id 게시글 번호
   * @param bbs 수정내용
   * @return 수정건수
   */
  int updateByBbsId(Long id,Bbs bbs);


  String facilityLink(String facid);
  /**
   * 답글작성
   * @param pbbsId 부모글번호
   * @param replyBbs 답글
   * @return 답글번호
   */
  Long saveReply(Long pbbsId,Bbs replyBbs);

  /**
   * 조회수증가
   * @param id 게시글번호
   * @return  수정건수
   */ 
  int increaseHitCount(Long id);

  /**
   * 좋아요증감
   * @param id 게시글번호
   * @return 수정건수
   */
  int increaseGoodCount(Long id);
  /**
   * 전체건수
   * @return 게시글 전체건수
   */
  int totalCount();
  int totalCount(String bcategory);
  int totalCount(BbsFilterCondition filterCondition);

  int totalEventCount(BbsFilterCondition filterCondition);

  /**
   * 전체건수
   * @return 등록 이벤트 건수
   */
  int totalPEventCount();
}
