package com.kh.app3.web;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Controller
public class HomeController {

  @RequestMapping("/")
  public String home(HttpServletRequest request){

    String view = null;
    HttpSession session = request.getSession(false);
    view = (session == null) ? "beforeLogin" : "afterLogin" ;


    return view;
  }

}
