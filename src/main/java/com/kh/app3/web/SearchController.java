package com.kh.app3.web;

import com.kh.app3.domain.EventInfo;
import com.kh.app3.domain.bbs.dao.Bbs;
import com.kh.app3.domain.bbs.dao.BbsFilterCondition;
import com.kh.app3.domain.bbs.svc.BbsSVC;
import com.kh.app3.domain.common.code.CodeDAO;
import com.kh.app3.domain.common.file.svc.UploadFileSVC;
import com.kh.app3.domain.common.paging.FindCriteria;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Slf4j
@Controller
@RequestMapping("/lists/search")
@RequiredArgsConstructor
public class SearchController {

  private final BbsSVC bbsSvc;
  private final CodeDAO codeDAO;
  private final UploadFileSVC uploadFileSVC;

  @Autowired
  @Qualifier("fc10") //동일한 타입의 객체가 여러개있을때 빈이름을 명시적으로 지정해서 주입받을때
  private FindCriteria fc;

  //게시판 코드,디코드 가져오기
  @ModelAttribute("classifier")
  public List<Code> classifier() {
    return codeDAO.code("B01");
  }

  @GetMapping
  public String searchResultForm(
      @PathVariable(required = false) Optional<Integer> reqPage,
      @PathVariable(required = false) Optional<String> searchType,
      @PathVariable(required = false) Optional<String> keyword,
      @RequestParam(required = false) Optional<String> category,
      Model model
  ) {

    String cate = getCategory(category);

    List<EventInfo> eList = null;
    List<Bbs> list02 = null;
    List<Bbs> list03 = null;

    //FindCriteria 값 설정
    fc.getRc().setReqPage(reqPage.orElse(1)); //요청페이지, 요청없으면 1
    fc.setSearchType(searchType.orElse(""));  //검색유형
    fc.setKeyword(keyword.orElse(""));        //검색어

    //공연전시게시파검색
    BbsFilterCondition filterCondition = new BbsFilterCondition(
        "B0101", fc.getRc().getStartRec(), fc.getRc().getEndRec(),
        searchType.get(),
        keyword.get());
    fc.setTotalRec(bbsSvc.totalPEventCount());
    fc.setSearchType(searchType.get());
    fc.setKeyword(keyword.get());
    eList = bbsSvc.findAllEvents(filterCondition);

    //홍보게시판 검색
    filterCondition = new BbsFilterCondition(
        "B0102", fc.getRc().getStartRec(), fc.getRc().getEndRec(),
        searchType.get(),
        keyword.get());
    fc.setTotalRec(bbsSvc.totalCount(filterCondition));
    fc.setSearchType(searchType.get());
    fc.setKeyword(keyword.get());
    list02 = bbsSvc.findAll(filterCondition);

    //후기게시판 검색
    filterCondition = new BbsFilterCondition(
        "B0103", fc.getRc().getStartRec(), fc.getRc().getEndRec(),
        searchType.get(),
        keyword.get());
    fc.setTotalRec(bbsSvc.totalCount(filterCondition));
    fc.setSearchType(searchType.get());
    fc.setKeyword(keyword.get());
    list02 = bbsSvc.findAll(filterCondition);


    model.addAttribute("res1", eList);
    model.addAttribute("res2", list02);
    model.addAttribute("res3", list03);

    return null;
  }

  private String getCategory(Optional<String> category) {
    return null;
  }
}
