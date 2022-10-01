package com.kh.app3.domain.admin.svc;

import com.kh.app3.domain.PEvent;
import com.kh.app3.domain.PFacility;

import java.util.List;

public interface AdminPostSVC {
  /**
   * 공연정보 등록
   * @param pEvent
   * @return
   */
  int add(PEvent pEvent);
  /**
   * 공연정보 수정
   * @param id  공연ID
   * @param pEvent 수정된 공연정보
   * @return 수정건수
   */
  int update(String id, PEvent pEvent);

  /**
   * 공연정보 조회
   * @param pEventId 공연ID
   * @return 공연정보
   */
  PEvent findById(String pEventId);

  /**
   * 공연정보 삭제
   * @param pEventId 공연ID
   * @return 삭제건수
   */
  int del(String pEventId);

  /**
   * 공연정보목록
   * @return 공연정보
   */
  List<PEvent> pEventList();


  /**
   * 공연시설목록
   * @return 공연시설정보
   */
  List<PFacility> pall();
}

