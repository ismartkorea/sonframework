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
	
	@RequestMapping(value = "/test/blog/page.do")
	public String blogPage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		LOGGER.debug(">>> Called blog !!! <<<");
		 // 미인증 사용자에 대한 보안처리 
		 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
		 if(!isAuthenticated) {
			 model.addAttribute("message",
			 egovMessageSource.getMessage("fail.common.login")); 
			 return "uat/uia/EgovLoginUsr"; 
		 }
		 
		 	/**
		 	 * 페이징 관련.
		 	 *
			PaginationInfo paginationInfo = new PaginationInfo();

			paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
			paginationInfo.setPageSize(boardVO.getPageSize());
			
			boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
			boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
			int totCnt = Integer.parseInt((String) map.get("resultCnt"));

			paginationInfo.setTotalRecordCount(totCnt);
			
			model.addAttribute("resultList", map.get("resultList"));
			model.addAttribute("resultCnt", map.get("resultCnt"));
			//model.addAttribute("boardVO", boardVO);
			//model.addAttribute("brdMstrVO", master);
			model.addAttribute("paginationInfo", paginationInfo);			
			*/
		
		
		return "test/blog/page";
	}
	
	@RequestMapping(value = "/test/blog/post/page.do")
	public String blogPostPage(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		LOGGER.debug(">>> Called blog !!! <<<");
		 // 미인증 사용자에 대한 보안처리 
		 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
		 if(!isAuthenticated) {
			 model.addAttribute("message",
			 egovMessageSource.getMessage("fail.common.login")); 
			 return "uat/uia/EgovLoginUsr"; 
		 }
		 
		 	/**
		 	 * 페이징 관련.
		 	 *
			PaginationInfo paginationInfo = new PaginationInfo();

			paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
			paginationInfo.setPageSize(boardVO.getPageSize());
			
			boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
			boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
			int totCnt = Integer.parseInt((String) map.get("resultCnt"));

			paginationInfo.setTotalRecordCount(totCnt);
			
			model.addAttribute("resultList", map.get("resultList"));
			model.addAttribute("resultCnt", map.get("resultCnt"));
			//model.addAttribute("boardVO", boardVO);
			//model.addAttribute("brdMstrVO", master);
			model.addAttribute("paginationInfo", paginationInfo);			
			*/
		
		
		return "test/blog/postPage";
	}	
}
