package sonframework.front.blog.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.trace.LeaveaTrace;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import sonframework.front.blog.service.BlogPostInfo;
import sonframework.front.blog.service.BlogPostInfoVO;
import sonframework.front.blog.service.BlogPostService;

@Service("blogPostService")
public class BlogPostServiceImpl extends EgovAbstractServiceImpl implements BlogPostService {

	
    @Resource(name = "BlogPostServiceDAO")
    private BlogPostServiceDAO blogPostServiceDAO;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name="leaveaTrace") LeaveaTrace leaveaTrace;
    
    public Long getBlogPostArticleMaxNo(BlogPostInfo post) throws Exception {
    	
    	return blogPostServiceDAO.getBlogPostArticleMaxNo(post);
    }

    /**
     * 게시물 한 건을 삭제 한다.
     *
     */
    public void deleteBlogPostArticle(BlogPostInfo post) throws Exception {
		FileVO fvo = new FileVO();
	
		fvo.setAtchFileId(post.getAtchFileId());
	
		post.setNttSj("이 글은 작성자에 의해서 삭제되었습니다.");
	
		blogPostServiceDAO.deleteBlogPostArticle(post);
	
		if (!"".equals(fvo.getAtchFileId()) || fvo.getAtchFileId() != null) {
		    fileService.deleteAllFileInf(fvo);
		}
    }

    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     *
     */
    public void insertBlogPostArticle(BlogPostInfo post) throws Exception {
		// SORT_ORDR는 부모글의 소트 오더와 같게, NTT_NO는 순서대로 부여
	
		if ("Y".equals(post.getReplyAt())) {
		    // 답글인 경우 1. Parnts를 세팅, 2.Parnts의 sortOrdr을 현재글의 sortOrdr로 가져오도록, 3.nttNo는 현재 게시판의 순서대로
		    // replyLc는 부모글의 ReplyLc + 1
	
		    @SuppressWarnings("unused")
		    long tmpNttId = 0L; // 답글 게시물 ID
	
		    tmpNttId = blogPostServiceDAO.replyBlogPostArticle(post);
	
		} else {
		    // 답글이 아닌경우 Parnts = 0, replyLc는 = 0, sortOrdr = nttNo(Query에서 처리)
		    post.setParnts("0");
		    post.setReplyLc("0");
		    post.setReplyAt("N");
	
		    blogPostServiceDAO.insertBlogPostArticle(post);
		}
    }

	/**
     * 게시물 대하여 상세 내용을 조회 한다.
     *
     */
    public BlogPostInfoVO selectBlogPostArticle(BlogPostInfoVO postVO) throws Exception {
		if (postVO.isPlusCount()) {
		    int iniqireCo = blogPostServiceDAO.selectMaxInqireCo(postVO);
	
		    postVO.setInqireCo(iniqireCo);
		    blogPostServiceDAO.updateInqireCo(postVO);
		}
	
		return blogPostServiceDAO.selectBlogPostArticle(postVO);
    }

	/**
     * 조건에 맞는 게시물 목록을 조회 한다.
     *
     */
    public Map<String, Object> selectBlogPostArticles(BlogPostInfoVO postVO) throws Exception {
		List<BlogPostInfoVO> list = blogPostServiceDAO.selectBlogPostArticleList(postVO);
		List<BlogPostInfoVO> result = new ArrayList<BlogPostInfoVO>();
	
		result = list;
	
		int cnt = blogPostServiceDAO.selectBlogPostArticleListCnt(postVO);
	
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }

    /**
     * 게시물 한 건의 내용을 수정 한다.
     *
     */
    public void updateBlogPostArticle(BlogPostInfo post) throws Exception {
    	blogPostServiceDAO.updateBlogPostArticle(post);
    }

    /**
     * 방명록 내용을 삭제 한다.
     *
     */
    public void deleteGuestList(BlogPostInfoVO postVO) throws Exception {
    	blogPostServiceDAO.deleteGuestList(postVO);
    }

    /**
     * 방명록에 대한 목록을 조회 한다.
     *
     */
    public Map<String, Object> selectGuestList(BlogPostInfoVO postVO) throws Exception {
		List<BlogPostInfoVO> result = blogPostServiceDAO.selectGuestList(postVO);
		int cnt = blogPostServiceDAO.selectGuestListCnt(postVO);
	
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }

    /**
     * 방명록에 대한 패스워드를 조회 한다.
     *
     * @param board
     * @return
     * @throws Exception
     */
    public String getPasswordInf(BlogPostInfo post) throws Exception {
    	return blogPostServiceDAO.getPasswordInf(post);
    }
    
}
