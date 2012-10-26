package com.wemb;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

@Controller
public class LoginController extends AbstractController{
	
	private String loginView = "login";
	
	@RequestMapping("/login.do")
	public String loginProc(){
		System.out.println("그냥 되는거");
		return loginView;
	}

	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest arg0,
			HttpServletResponse arg1) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("어렵");
		
		return null;
	}
	
	
	/*
	@RequestMapping("/login.do")
	public ModelAndView login(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login");
		System.out.println(">>>>>");
		return mv;
	}
	*/

}
