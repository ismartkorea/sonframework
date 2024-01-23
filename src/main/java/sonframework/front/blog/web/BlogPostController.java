package sonframework.front.blog.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import sonframework.com.bbs.service.BoardMaster;
import sonframework.front.blog.service.BlogPostInfo;
import sonframework.front.blog.service.BlogPostInfoVO;
import sonframework.front.blog.service.BlogPostService;

@Controller
public class BlogPostController {

	@Resource(name = "blogPostService")
	private BlogPostService blogPostService;


	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * XSS 방지 처리.
	 *
	 * @param data
	 * @return
	 */
	protected String unscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}

		String ret = data;

		ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
		ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");

		ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
		ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");

		ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
		ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");

		ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");

		ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
		ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

		return ret;
	}

	/**
	 * 블로그 포스트에 대한 목록을 조회한다.
	 *
	 * @param postVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/blog/post/selectPostList.do")
	public String selectBoardArticles(@ModelAttribute("searchVO") BlogPostInfoVO postVO, ModelMap model,
			HttpServletRequest request) throws Exception {
		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("baseMenuNo", "1000000");

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		postVO.setBbsId(postVO.getBbsId());
		postVO.setBbsNm(postVO.getBbsNm());

		postVO.setPageUnit(propertyService.getInt("pageUnit"));
		postVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(postVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(postVO.getPageUnit());
		paginationInfo.setPageSize(postVO.getPageSize());

		postVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		postVO.setLastIndex(paginationInfo.getLastRecordIndex());
		postVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = blogPostService.selectBlogPostArticles(postVO);
		int totCnt = Integer.parseInt((String) map.get("resultCnt"));

		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("postVO", postVO);
		model.addAttribute("paginationInfo", paginationInfo);

		return "blog/post/BlogPostList";
	}

	/**
	 * 블로그게시물에 대한 상세 정보를 조회한다.
	 *
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/blog/post/selectBlogPostArticle.do")
	public String selectBoardArticle(@ModelAttribute("searchVO") BlogPostInfoVO postVO, ModelMap model)
			throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		// 조회수 증가 여부 지정
		postVO.setPlusCount(true);

		if (!postVO.getSubPageIndex().equals("")) {
			postVO.setPlusCount(false);
		}
		//// -------------------------------

		postVO.setLastUpdusrId(user.getUniqId());
		BlogPostInfoVO vo = blogPostService.selectBlogPostArticle(postVO);

		model.addAttribute("result", vo);
		model.addAttribute("sessionUniqId", user.getUniqId());
		model.addAttribute("userId", user.getId());
		model.addAttribute("userNm", user.getName());

		return "blog/post/BlogPostView";
	}

	/**
	 * 블로그게시물 등록을 위한 등록페이지로 이동한다.
	 *
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/blog/post/addBlogPostArticle.do")
	public String addBoardArticle(@ModelAttribute("searchVO") BlogPostInfoVO blogPostInfoVO, ModelMap model) throws Exception {

		return "blog/post/BlogPostRegist";
	}

	/**
	 * 블로그게시물을 등록한다.
	 *
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/blog/post/insertBlogPostArticle.do")
	public String insertBoardArticle(final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("searchVO") BlogPostInfoVO postVO, @ModelAttribute("bdMstr") BoardMaster bdMstr,
			@ModelAttribute("blogPostInfo") BlogPostInfo blogPostInfo, BindingResult bindingResult,
			SessionStatus status, ModelMap model) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		// beanValidator.validate(blogPostInfo, bindingResult);
		if (bindingResult.hasErrors()) {

			//// -----------------------------

			return "blog/post/BlogPostRegist";
		}

		if (isAuthenticated) {
			List<FileVO> result = null;
			String atchFileId = "";

			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
			}
			blogPostInfo.setAtchFileId(atchFileId);
			blogPostInfo.setFrstRegisterId(user.getUniqId());
			blogPostInfo.setBbsId(blogPostInfo.getBbsId());

			blogPostInfo.setNtcrNm(""); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			blogPostInfo.setPassword(""); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)

			blogPostInfo.setNttCn(unscript(blogPostInfo.getNttCn())); // XSS 방지

			blogPostService.insertBlogPostArticle(blogPostInfo);
		}
	    // 생성된 게시물 번호 조회.
		//Long nttId = blogPostService.getBlogPostArticleMaxNo(blogPostInfo);
		//postVO.setNttId(nttId);

		// 조회 처리.
		postVO.setLastUpdusrId(user.getUniqId());
		BlogPostInfoVO vo = blogPostService.selectBlogPostArticleByMaxId();

		model.addAttribute("result", vo);
		model.addAttribute("sessionUniqId", user.getUniqId());
		model.addAttribute("userId", user.getId());
		model.addAttribute("userNm", user.getName());

		return "blog/post/BlogPostView";
	}

	/**
	 * 블로그게시물에 대한 답변 등록을 위한 등록페이지로 이동한다.
	 *
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/blog/post/addReplyBlogPostArticle.do")
	public String addReplyBoardArticle(@ModelAttribute("searchVO") BlogPostInfoVO postVO, ModelMap model)
			throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		//// -----------------------------

		return "blog/post/EgovNoticeReply";
	}

	/**
	 * 블로그게시물에 대한 답변을 등록한다.
	 *
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/blog/post/replyBlogPostArticle.do")
	public String replyBoardArticle(final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("searchVO") BlogPostInfoVO postVO, @ModelAttribute("bdMstr") BoardMaster bdMstr,
			@ModelAttribute("blogPostInfo") BlogPostInfo blogPostInfo, BindingResult bindingResult, ModelMap model,
			SessionStatus status) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		// beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors()) {
			//// -----------------------------

			return "blog/post/EgovNoticeReply";
		}

		if (isAuthenticated) {
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			String atchFileId = "";

			if (!files.isEmpty()) {
				List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
			}

			blogPostInfo.setAtchFileId(atchFileId);
			blogPostInfo.setReplyAt("Y");
			blogPostInfo.setFrstRegisterId(user.getUniqId());
			blogPostInfo.setBbsId(blogPostInfo.getBbsId());
			blogPostInfo.setParnts(Long.toString(postVO.getNttId()));
			blogPostInfo.setSortOrdr(postVO.getSortOrdr());
			blogPostInfo.setReplyLc(Integer.toString(Integer.parseInt(postVO.getReplyLc()) + 1));

			blogPostInfo.setNtcrNm(""); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			blogPostInfo.setPassword(""); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)

			blogPostInfo.setNttCn(unscript(blogPostInfo.getNttCn())); // XSS 방지

			blogPostService.insertBlogPostArticle(blogPostInfo);
		}

		return "forward:/blog/post/selectBoardList.do";
	}

	/**
	 * 블로그게시물 수정을 위한 수정페이지로 이동한다.
	 *
	 * @param boardVO
	 * @param vo
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/blog/post/forUpdateBoardArticle.do")
	public String selectBoardArticleForUpdt(@ModelAttribute("searchVO") BlogPostInfoVO postVO,
			@ModelAttribute("blogPostInfo") BlogPostInfoVO vo, ModelMap model) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		postVO.setFrstRegisterId(user.getUniqId());

		BlogPostInfoVO blogPostvo = new BlogPostInfoVO();

		vo.setBbsId(postVO.getBbsId());

		if (isAuthenticated) {
			blogPostvo = blogPostService.selectBlogPostArticle(postVO);
		}

		model.addAttribute("result", blogPostvo);

		return "blog/post/BlogPostUpdt";
	}

	/**
	 * 블로그게시물에 대한 내용을 수정한다.
	 *
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/blog/post/updateBoardArticle.do")
	public String updateBoardArticle(final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("searchVO") BlogPostInfoVO blogPostInfoVO, @ModelAttribute("bdMstr") BoardMaster bdMstr,
			@ModelAttribute("blogPostInfo") BlogPostInfo blogPostInfo, BindingResult bindingResult, ModelMap model,
			SessionStatus status) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		String atchFileId = blogPostInfoVO.getAtchFileId();

		// beanValidator.validate(blogPostInfo, bindingResult);
		if (bindingResult.hasErrors()) {

			blogPostInfoVO.setFrstRegisterId(user.getUniqId());

			BlogPostInfoVO blogPostvo = new BlogPostInfoVO();

			blogPostvo = blogPostService.selectBlogPostArticle(blogPostInfoVO);

			model.addAttribute("result", blogPostvo);

			return "blog/post/BlogPostUpdt";
		}

		if (isAuthenticated) {
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				if ("".equals(atchFileId)) {
					List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
					atchFileId = fileMngService.insertFileInfs(result);
					blogPostInfo.setAtchFileId(atchFileId);
				} else {
					FileVO fvo = new FileVO();
					fvo.setAtchFileId(atchFileId);
					int cnt = fileMngService.getMaxFileSN(fvo);
					List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
					fileMngService.updateFileInfs(_result);
				}
			}

			blogPostInfo.setLastUpdusrId(user.getUniqId());

			blogPostInfo.setNtcrNm(""); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			blogPostInfo.setPassword(""); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			blogPostInfo.setNttCn(unscript(blogPostInfo.getNttCn())); // XSS 방지

			blogPostService.updateBlogPostArticle(blogPostInfo);

		}

		// 조회 처리.
		BlogPostInfoVO vo = blogPostService.selectBlogPostArticle(blogPostInfoVO);

		model.addAttribute("result", vo);
		model.addAttribute("sessionUniqId", user.getUniqId());
		model.addAttribute("userId", user.getId());
		model.addAttribute("userNm", user.getName());

		return "blog/post/BlogPostView";
	}

	/**
	 * 블로그게시물에 대한 내용을 삭제한다.
	 *
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/blog/post/deleteBlogPostArticle.do")
	public String deleteBoardArticle(@ModelAttribute("searchVO") BlogPostInfoVO blogPostInfoVO,
			@ModelAttribute("blogPostInfo") BlogPostInfo blogPostInfo, @ModelAttribute("bdMstr") BoardMaster bdMstr,
			ModelMap model) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (isAuthenticated) {
			blogPostInfo.setLastUpdusrId(user.getUniqId());

			blogPostService.deleteBlogPostArticle(blogPostInfo);
		}

		return "forward:/blog/post/selectBoardList.do";
	}

}
