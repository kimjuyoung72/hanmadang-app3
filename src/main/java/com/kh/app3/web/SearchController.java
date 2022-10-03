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
  @Qualifier("fc5") //동일한 타입의 객체가 여러개있을때 빈이름을 명시적으로 지정해서 주입받을때
  private FindCriteria fc;

  //게시판 코드,디코드 가져오기
  @ModelAttribute("classifier")
  public List<Code> classifier() {
    return codeDAO.code("B01");
  }

  @GetMapping
  public String searchResultForm(
      @PathVariable(required = false) Optional<Integer> reqPage,
      @PathVariable String keyword,Model model) {

    List<EventInfo> list01 = null;
    List<Bbs> list02 = null;
    List<Bbs> list03 = null;

    String[] eType = new String[]{"ETC","ET","EC","EG","ED","EA"};  //공연,전시 검색유형
    String[] bType = new String[]{"TC","T","C","E","N"};            //홍보,후기 검색유형

    //공연전시게시파검색
    for (String type : eType) {
      //FindCriteria 값 설정
      fc.getRc().setReqPage(reqPage.orElse(1)); //요청페이지, 요청없으면 1
//      fc.setSearchType(type);         //유형
//      fc.setKeyword(keyword);        //검색어
      list01.addAll(getSearchResult_01("B0101", type, keyword));
    }

    //홍보게시판 검색
    for(String type : bType) {
      fc.getRc().setReqPage(reqPage.orElse(1)); //요청페이지, 요청없으면 1
      list02.addAll(getSearchResult_0203("B0102", type, keyword));
    }
    //후기게시판 검색
    for(String type : bType) {
      fc.getRc().setReqPage(reqPage.orElse(1)); //요청페이지, 요청없으면 1
      list02.addAll(getSearchResult_0203("B0103", type, keyword));
    }
    model.addAttribute("res1", list01);
    model.addAttribute("res2", list02);
    model.addAttribute("res3", list03);

    return "searchResultForm";
  }

  private List<EventInfo> getSearchResult_01(String cate, String type, String keyword) {
    BbsFilterCondition filterCondition = new BbsFilterCondition(
        cate, fc.getRc().getStartRec(), fc.getRc().getEndRec(), type, keyword);
    //FindCriteria 값 설정
    fc.setTotalRec(bbsSvc.totalPEventCount());
    fc.setSearchType(type );
    fc.setKeyword(keyword);
    return bbsSvc.findAllEvents(filterCondition);
  }
  private List<Bbs> getSearchResult_0203(String cate,String type, String keyword) {
    BbsFilterCondition filterCondition = new BbsFilterCondition(
        "B0103", fc.getRc().getStartRec(), fc.getRc().getEndRec(),type, keyword);
    //FindCriteria 값 설정
    fc.setTotalRec(bbsSvc.totalCount(filterCondition));
    fc.setSearchType(type);
    fc.setKeyword(keyword);
    return bbsSvc.findAll(filterCondition);
  }

}
