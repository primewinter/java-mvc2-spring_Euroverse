package com.ksy.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ksy.service.domain.LoginUser;
import com.ksy.service.domain.User;
import com.ksy.service.myPage.MyPageService;

public class LogOnCheckInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	@Qualifier("myPageServiceImpl")
	private MyPageService myPageService;
	
		///Constructor
		public LogOnCheckInterceptor(){
			System.out.println("\nCommon :: "+this.getClass()+"\n");		
		}
		
		///Method
		public boolean preHandle(	HttpServletRequest request,HttpServletResponse response,Object handler) throws Exception {
			
			HttpSession session = request.getSession();
			User user = (User)session.getAttribute("user");
			if(user!=null) {
				LoginUser loginUser = new LoginUser();
				loginUser = (LoginUser)myPageService.getLoginUser(user.getUserId());
				
				if(!loginUser.getSessionId().equals(session.getId())) {
					session.removeAttribute("user");
					session.invalidate();
					response.sendRedirect("/user/autoLogout");
					return false;
				}
			}
			return true;
		}// controller의 handler가 끝나면 처리됨
		@Override
		public void postHandle(HttpServletRequest request, HttpServletResponse response,Object obj, ModelAndView mav)throws Exception {
			System.out.println("postHandle");
		}

		// view까지 처리가 끝난 후에 처리됨
		@Override
		public void afterCompletion(HttpServletRequest request, HttpServletResponse response,Object obj, Exception e)throws Exception {
			System.out.println("afterCompletion");
		
		}
		
}
