package sonframework.test.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;

@Controller
public class TestController {

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;	

	private static final Logger LOGGER = LoggerFactory.getLogger(TestController.class);
	
	@RequestMapping(value = "/test/testManage.do")
	public String testManage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		LOGGER.debug(">>> Called hello !!! <<<");
		 // 미인증 사용자에 대한 보안처리 
		 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
		 if(!isAuthenticated) {
			 model.addAttribute("message",
			 egovMessageSource.getMessage("fail.common.login")); 
			 return "uat/uia/EgovLoginUsr"; 
		 }		
		
		
		return "test/TestHello";
	}
	

	@RequestMapping(value = "/test/hello.do")
	public String hello(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		LOGGER.debug(">>> Called hello !!! <<<");
		 // 미인증 사용자에 대한 보안처리 
		 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
		 if(!isAuthenticated) {
			 model.addAttribute("message",
			 egovMessageSource.getMessage("fail.common.login")); 
			 return "uat/uia/EgovLoginUsr"; 
		 }		
		
		
		return "test/TestHello";
	}	
}
