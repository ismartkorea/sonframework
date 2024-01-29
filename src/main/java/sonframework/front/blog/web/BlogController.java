package sonframework.front.blog.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sonframework.front.blog.service.BlogPostInfoVO;
import sonframework.front.blog.service.BlogPostService;
import sonframework.menu.service.MenuManageVO;

@Controller
public class BlogController {
	
	
	@Resource(name = "blogPostService")
	private BlogPostService blogPostService;	
	
	
	/**
	 * 블로그 메인 페이지 조회
	 * @return 메인페이지 정보 Map [key : 항목명]
	 *
	 * @param request
	 * @param model
	 * @exception Exception Exception
	 */
	@RequestMapping(value = "/blog/main/mainPage.do")
	public String getMgtMainPage(@ModelAttribute("searchVO") BlogPostInfoVO postVO, HttpServletRequest request, ModelMap model)
	  throws Exception{

		/*
		 * // 공지사항 메인 컨텐츠 조회 시작 --------------------------------- BoardVO boardVO = new
		 * BoardVO(); boardVO.setPageUnit(10); boardVO.setPageSize(10);
		 * boardVO.setBbsId("BBSMSTR_AAAAAAAAAAAA");
		 * 
		 * PaginationInfo paginationInfo = new PaginationInfo();
		 * 
		 * paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		 * paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		 * paginationInfo.setPageSize(boardVO.getPageSize());
		 * 
		 * boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		 * boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		 * boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		 * 
		 * Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO,
		 * "BBSA02"); model.addAttribute("notiList", map.get("resultList"));
		 * 
		 * 
		 * // 공지사항 메인컨텐츠 조회 끝 -----------------------------------
		 * 
		 * // 자료실 메인 컨텐츠 조회 시작 ------------------------------- boardVO.setPageUnit(5);
		 * boardVO.setPageSize(10); boardVO.setBbsId("BBSMSTR_CCCCCCCCCCCC");
		 * 
		 * paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		 * paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		 * paginationInfo.setPageSize(boardVO.getPageSize());
		 * 
		 * boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		 * boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		 * boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		 * 
		 * model.addAttribute("bbsList", bbsMngService.selectBoardArticles(boardVO,
		 * "BBSA02").get("resultList"));
		 */

		// 자료실 메인컨텐츠 조회 끝 -----------------------------------
		postVO.setPageUnit(10);
		postVO.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(postVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(postVO.getPageUnit());
		paginationInfo.setPageSize(postVO.getPageSize());

		postVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		postVO.setLastIndex(paginationInfo.getLastRecordIndex());
		postVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = blogPostService.selectBlogPostArticles(postVO);
		
		int totCnt = Integer.parseInt((String) map.get("resultCnt"));
		// page total count set
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("paginationInfo", paginationInfo);

		return "main/BlogMainView";
	}	

	
	/**
     * Header Page를 조회한다.
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "EgovIncHeader"
     * @exception Exception
     * 
     */
    @RequestMapping(value="/blog/main/blogHeader.do")
    public String selectHeader(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		@RequestParam(value="flag", required=false) String flag,
    		ModelMap model)
            throws Exception {

    	return "main/inc/BlogIncHeader"; // 업무화면의 상단메뉴 화면

    }
    
	/**
     * Footer Page를 조회한다.
     * @param 
     * @return 출력페이지정보 "BlogIncFooter"
     * @exception Exception
     */
    @RequestMapping(value="/blog/main/blogFooter.do")
    public String selectFooter(ModelMap model) throws Exception {
    	return "main/inc/BlogIncFooter";
    }
    
    /**
     * 오른쪽메뉴를 조회한다.
     * @param 
     * @return 출력페이지정보 "EgovIncLeftmenu"
     * @exception Exception
     */
    @RequestMapping(value="/blog/main/blogMenuRight.do")
    public String selectMenuLeft(ModelMap model) throws Exception {

      	return "main/inc/BlogIncRightMenu";
    }    
	
}
