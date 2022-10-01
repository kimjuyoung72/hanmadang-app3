package com.kh.app3.domain.admin.svc;

import com.kh.app3.domain.PEvent;
import com.kh.app3.domain.PFacility;
import com.kh.app3.domain.admin.dao.AdminPostDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminPostSVCImpl implements AdminPostSVC{
  private final AdminPostDAO adminPostDAO;

  @Override
  public int add(PEvent pEvent) {
    return 0;
  }

  @Override
  public int update(String id, PEvent pEvent) {
    return 0;
  }

  @Override
  public PEvent findById(String pEventId) {
    return null;
  }

  @Override
  public int del(String pEventId) {
    return 0;
  }

  @Override
  public List<PEvent> pEventList() {
    return adminPostDAO.pEventList();
  }

  @Override
  public List<PFacility> pall() {
    return adminPostDAO.pall();
  }
}
